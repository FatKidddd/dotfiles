"""Offline integration tests using real GNU Stow and disposable directories."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles test ")
        self.root = Path(self.temp.name)
        self.repo = self.root / "repository with spaces"
        shutil.copytree(Path(__file__).resolve().parents[1], self.repo,
                        ignore=shutil.ignore_patterns(".git", "__pycache__"))
        self.target = self.root / "target with spaces"
        self.target.mkdir()

    def tearDown(self):
        self.temp.cleanup()

    def run_install(self, *args, ok=True, entry="install.sh", env=None):
        result = subprocess.run(
            [str(self.repo / entry), "--target", str(self.target), *args],
            cwd=self.root, text=True, capture_output=True, env=env,
        )
        if ok:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        return result

    def test_dry_run_then_install_repeat_and_unstow(self):
        self.run_install("--dry-run")
        self.assertEqual(list(self.target.iterdir()), [])
        foreign = self.target / "foreign-link"
        foreign.symlink_to(self.root / "unrelated-absolute-destination")
        result = self.run_install()
        self.assertNotIn("BUG in", result.stderr)
        zsh = self.target / ".zshrc"
        self.assertTrue(zsh.is_symlink())
        self.assertEqual(zsh.resolve(), self.repo / "zsh/.zshrc")
        self.assertEqual((self.target / ".config/nvim/init.lua").resolve(),
                         self.repo / "nvim/.config/nvim/init.lua")
        for relative, source in {
            ".gitconfig": "git/.gitconfig",
            ".gitignore_global": "git/.gitignore_global",
            ".config/ghostty/config": "ghostty/.config/ghostty/config",
        }.items():
            self.assertEqual((self.target / relative).resolve(), self.repo / source)
        local_git = self.target / ".gitconfig.local"
        local_git.write_text("[user]\n    name = Local override\n")
        self.assertFalse((self.target / ".bashrc").exists())
        self.run_install(entry="install.zsh")
        unrelated = self.target / "keep.txt"
        unrelated.write_text("keep")
        self.run_install("--unstow")
        self.assertFalse(zsh.exists())
        self.assertEqual(unrelated.read_text(), "keep")
        self.assertTrue(local_git.exists())
        self.assertFalse((self.target / ".gitconfig").exists())
        self.assertFalse((self.target / ".config/ghostty/config").exists())

    def test_conflict_stops_all_packages_before_linking(self):
        existing = self.target / ".tmux.conf"
        existing.write_text("old tmux")
        self.run_install(ok=False)
        self.assertEqual(existing.read_text(), "old tmux")
        self.assertFalse((self.target / ".zshrc").exists())
        self.assertFalse((self.target / ".config").exists())

    def test_backup_preview_and_apply_preserve_originals(self):
        old = self.target / ".zshrc"
        old.write_text("original config")
        self.run_install("--backup", "--dry-run", "zsh")
        self.assertEqual(old.read_text(), "original config")
        self.assertEqual(list(self.target.glob(".dotfiles-backup-*")), [])
        original_repo = (self.repo / "zsh/.zshrc").read_bytes()
        self.run_install("--backup", "zsh")
        self.assertTrue(old.is_symlink())
        backups = list(self.target.glob(".dotfiles-backup-*"))
        self.assertEqual(len(backups), 1)
        self.assertEqual((backups[0] / ".zshrc").read_text(), "original config")
        self.assertEqual((self.repo / "zsh/.zshrc").read_bytes(), original_repo)

    def test_git_ghostty_backup_preserves_existing_configs(self):
        originals = {
            ".gitconfig": "[user]\n    name = Previous user\n",
            ".gitignore_global": "old-ignore\n",
            ".config/ghostty/config": "font-size = 14\n",
            ".config/ghostty/extra": "keep extra file\n",
        }
        for relative, content in originals.items():
            path = self.target / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content)
        self.run_install("--backup", "git", "ghostty")
        backup, = self.target.glob(".dotfiles-backup-*")
        for relative, content in originals.items():
            self.assertEqual((backup / relative).read_text(), content)
        config = (self.target / ".gitconfig").read_text()
        self.assertIn("excludesfile = ~/.gitignore_global", config)
        self.assertIn("path = ~/.gitconfig.local", config)

    def test_failed_backup_preflight_restores_moved_files(self):
        (self.target / ".zshrc").write_text("original")
        (self.target / ".config").write_text("parent is a file")
        self.run_install("--backup", "zsh", "nvim", ok=False)
        self.assertEqual((self.target / ".zshrc").read_text(), "original")
        self.assertEqual((self.target / ".config").read_text(), "parent is a file")

    def test_invalid_input_and_bash_opt_in(self):
        self.run_install("unknown", ok=False)
        self.run_install("--typo", ok=False)
        self.run_install("--unstow", "--backup", ok=False)
        self.assertEqual(list(self.target.iterdir()), [])
        self.run_install("bash")
        self.assertTrue((self.target / ".bashrc").is_symlink())
        self.assertFalse((self.target / ".zshrc").exists())

    def test_bootstrap_preview_does_not_clone(self):
        result = self.run_install("--bootstrap", "--dry-run")
        self.assertIn("https://github.com/ohmyzsh/ohmyzsh.git", result.stdout)
        self.assertEqual(list(self.target.iterdir()), [])

    def test_offline_bootstrap_and_repeat_skip_existing_clones(self):
        tools = self.root / "fake tools"
        tools.mkdir()
        git = tools / "git"
        git.write_text("""#!/usr/bin/env bash
set -e
[[ $1 == clone ]] || exit 9
case $3 in
  */ohmyzsh.git) file=oh-my-zsh.sh ;;
  */powerlevel10k.git) file=powerlevel10k.zsh-theme ;;
  */zsh-autosuggestions.git) file=zsh-autosuggestions.plugin.zsh ;;
  */zsh-syntax-highlighting.git) file=zsh-syntax-highlighting.plugin.zsh ;;
  */tpm.git) file=tpm ;;
  */tmux-yank.git) file=yank.tmux ;;
  */tmux-resurrect.git) file=resurrect.tmux ;;
  */tmux-gruvbox.git) file=gruvbox-tpm.tmux ;;
  *) exit 10 ;;
esac
printf '# dependency stub\\n' > "$4/$file"
""")
        git.chmod(0o755)
        env = dict(os.environ, PATH=str(tools) + os.pathsep + os.environ["PATH"])
        first = self.run_install("--bootstrap", env=env)
        self.assertEqual(first.stdout.count("Clone   "), 8)
        second = self.run_install("--bootstrap", env=env)
        self.assertNotIn("Clone   ", second.stdout)
        self.assertEqual(list(self.target.rglob("*.clone.*")), [])

    def test_custom_stowrc_is_rejected(self):
        (self.repo / ".stowrc").write_text("--adopt\n")
        self.run_install(ok=False)
        self.assertEqual(list(self.target.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
