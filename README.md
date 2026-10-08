# Dotfiles

A Git repository of configs, linked into your home directory by
[GNU Stow](https://www.gnu.org/software/stow/manual/). The installer targets
Linux, macOS and WSL with Bash and GNU Stow available. Native Windows needs a
Linux environment. Linux integration tests are included; macOS has not been
exercised here.

## Quick setup

Install system tools first. On Debian/Ubuntu:

```sh
sudo apt update
sudo apt install git stow zsh tmux fzf imagemagick
```

Also install **Neovim 0.11 or newer**; older distro packages may not meet this
requirement. Inline images need **tmux 3.3 or newer**, ImageMagick and a terminal
with Kitty graphics support, such as your existing Ghostty setup. On macOS,
install the same tools with your package manager. `eza` and `zoxide` are optional.
Use a Nerd Font for the configured icons, or set `have_nerd_font = false` in
`nvim/.config/nvim/lua/custom/core.lua`.

```sh
git clone https://github.com/FatKidddd/dotfiles.git ~/dotfiles
~/dotfiles/install.sh --doctor
~/dotfiles/install.sh --dry-run --bootstrap
~/dotfiles/install.sh --bootstrap
```

If the preview reports existing-file conflicts, inspect the paths, then use:

```sh
~/dotfiles/install.sh --backup --bootstrap
```

The script prints the dated backup directory and all Stow link operations.
Open a fresh Zsh (`zsh`), tmux and Neovim. Neovim's first launch downloads its
configured plugins; Mason installs the configured language tools. Copilot still
needs `:Copilot auth`. Runtime managers and compilers are intentionally not installed.
The script does not change your login shell; do that separately if desired.

`install.zsh` remains a compatibility wrapper and accepts the same arguments.
You can run either entry point from any working directory. No SSH key is needed
for the HTTPS clone of a public repository.

## Installer commands

```sh
./install.sh                         # link zsh, nvim, tmux
./install.sh --dry-run               # show the plan, change nothing
./install.sh --doctor                # check dependencies and link conflicts
./install.sh --bootstrap             # also clone missing shell/tmux plugins
./install.sh --backup                # back up conflicting config roots, then link
./install.sh zsh tmux                # select explicit packages
./install.sh --target /path/to/home  # use an existing alternate target directory
./install.sh --unstow                # remove this repo's default-package links
./install.sh --unstow zsh            # remove only this repo's Zsh links
./install.sh bash                    # opt-in legacy Bash config
```

Default packages are explicit, so a new `tests/` or documentation directory can
never accidentally become a Stow package. Bash is excluded by default: its older
configuration needs separate reconciliation with your live Bash files.

All selected packages undergo a Stow simulation before changes or downloads.
A conflict without `--backup` stops the entire link operation. Unknown options,
unknown packages, missing prerequisites and invalid target directories fail with
an explanation. User/repository `.stowrc` files are rejected so hidden options
(such as `--adopt`) cannot change the plan.

`--backup` moves the existing roots of conflicting packages (including entire
`.config/nvim` or `.zshrc.d` directories) into
`~/.dotfiles-backup-YYYYMMDD-HHMMSS.XXXXXX/`. It preserves existing Stow-owned
roots and never imports old config into this repository. If a second preflight
fails, moved originals are restored. After linking begins, backups remain for
manual recovery if Stow encounters an error; this is not a transactional
filesystem installer. Previewing `--backup --dry-run` never moves files.

`--bootstrap` clones missing Oh My Zsh, Powerlevel10k, shell suggestion/highlight
plugins, TPM, yank, resurrect and the existing tmux theme from their upstream
GitHub repositories. It skips existing complete installations, never pulls or
updates them, and stages each clone before moving it into place. Incomplete
existing dependency directories stop bootstrapping so you can inspect them.
An interrupted clone may leave a `.clone.*` directory; it is not used by startup.
Bootstrapping needs network access. `--dry-run --bootstrap` only prints clone plans.

No command invokes sudo, installs system packages, changes your login shell,
authenticates services, updates existing plugins, or deletes unrelated files.
A successful repeat install adds any missing links without deleting existing ones.
It uses additive Stow operations rather than unstowing/reinstalling everything.
Use `--unstow` before deliberately moving the repository or resetting a package.

## How the links work

Each package mirrors paths relative to your home:

| Source in this repo | Destination |
| --- | --- |
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zshrc.d/` | `~/.zshrc.d/` |
| `nvim/.config/nvim/` | `~/.config/nvim/` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `bash/.bashrc`, `bash/.profile` | `~/.bashrc`, `~/.profile` (opt-in) |

Stow uses relative symlinks, sometimes linking an entire directory when that
is safe ("directory folding"). Editing `~/.zshrc` edits the repo's source through
the link. Adding files under a folded directory becomes visible immediately;
re-run the installer to reconcile links if Stow has linked individual files.
Keep the repo in place: moving/deleting it can break links. Unstow before moving
it, then run the installer from its new location. Inspect a link with:

```sh
ls -ld ~/.zshrc ~/.zshrc.d ~/.config/nvim ~/.tmux.conf
readlink ~/.zshrc
```

To add another config, mirror its home path inside a package. To add a **new
package**, also update the installer's allowlist and backup-root mapping; do not
reintroduce a loop over every repo directory.

To restore a backed-up file, unstow the matching package, then move the original
from the printed backup directory back to its former home path. Inspect the
backup before moving it; the installer does not automatically restore backups
on `--unstow`.

## Machine-local settings and secrets

Use `~/.zshrc.local` for machine-specific paths or overrides. It is sourced before
runtime-manager initialization, and is never linked by the installer. For example:

```sh
export CONDA_ROOT="$HOME/miniconda3"
export CXX=clang++
```

Zsh tolerates missing Oh My Zsh, eza, pyenv, Cargo, NVM, SDKMAN and Conda.
Clipboard aliases use Wayland/X11 tools when available and retain macOS native
`pbcopy`/`pbpaste`. GCC 14 is preferred only when installed; CP otherwise uses
`g++` or your `$CXX`. Do not carry machine-specific standard-library include
paths between computers.

If needed, create `~/.secrets` yourself with mode 600 and put API keys there.
The installer neither reads nor creates it. Copilot authentication and app
credentials are not managed as dotfiles.

## Workflow

Use Neovim for fast navigation and edits, with Copilot completion. AI chat stays
in your external UI. See [the editor guide](nvim/.config/nvim/README.md) for CP,
Markdown image and note shortcuts.

- Capture personal notes in `~/Desktop/Notes/inbox.md`; search the directory with Telescope.
- Keep project decisions and working notes beside their code.
- Keep Ctrl+Space as tmux prefix; prefix+h/j/k/l navigate panes, prefix+R reloads.
- Bare Ctrl+h/j/k/l and Shift+arrows reach applications.

Next cleanup priorities: choose one Node manager (NVM or Volta), simplify the
Python manager policy, reconcile the legacy Bash package, and add portable
Ghostty/Git packages if needed. Retire `llm.zsh` if the clipboard AI workflow is
no longer used. These decisions are separate from safely installing symlinks.

## Tests

Requires Python 3 and GNU Stow. No network or real-home mutations:

```sh
python3 tests/test_install.py
```
