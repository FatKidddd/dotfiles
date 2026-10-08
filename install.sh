#!/usr/bin/env bash
set -eo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
target_dir=${HOME:?HOME must be set}
dry_run=0
backup=0
bootstrap=0
action=stow
doctor=0
packages=()

usage() {
  cat <<'EOF'
Usage: ./install.sh [options] [zsh nvim tmux git ghostty bash]
Default packages: zsh nvim tmux git ghostty (Bash is opt-in).

  -n, --dry-run     Show changes; do not link, back up or clone anything
  --target DIR     Existing destination directory (default: your home)
  --backup         Move conflicting package roots into a dated backup
  --bootstrap      Clone missing shell and tmux plugins (requires network)
  --unstow         Remove this repo's links; keep unrelated files
  --doctor         Check tools, plugin dependencies and link conflicts
  -h, --help       Show this help

Existing files are never adopted into the repo or overwritten.
No sudo, system package installation, login-shell changes or plugin updates.
EOF
}
fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
while (($#)); do
  case $1 in
    -n|--dry-run) dry_run=1 ;;
    --backup) backup=1 ;;
    --bootstrap) bootstrap=1 ;;
    --unstow) action=delete ;;
    --doctor) doctor=1 ;;
    --target) (($# >= 2)) || fail '--target requires a directory'; target_dir=$2; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; packages+=("$@"); break ;;
    -*) fail "Unknown option: $1" ;;
    *) packages+=("$1") ;;
  esac
  shift
done
((${#packages[@]})) || packages=(zsh nvim tmux git ghostty)
for package in "${packages[@]}"; do
  case $package in zsh|nvim|tmux|git|ghostty|bash) ;; *) fail "Unknown package: $package" ;; esac
  [[ -d "$repo_dir/$package" ]] || fail "Missing package directory: $package"
done
[[ -d $target_dir ]] || fail "Target must exist: $target_dir (create it first)"
target_dir=$(CDPATH= cd -- "$target_dir" && pwd -P)
[[ $target_dir != "$repo_dir" && $target_dir != "$repo_dir/"* ]] || fail 'Target cannot be inside the dotfiles repo'
if [[ $action == delete && ( $backup == 1 || $bootstrap == 1 ) ]]; then
  fail '--unstow cannot be combined with --backup or --bootstrap'
fi
if [[ $doctor == 1 && ( $backup == 1 || $bootstrap == 1 || $action == delete ) ]]; then
  fail '--doctor is read-only; use it separately from backup/bootstrap/unstow'
fi
[[ ! -f $repo_dir/.stowrc && ! -f $HOME/.stowrc ]] || fail 'Custom .stowrc found; move it aside or use Stow directly so hidden options cannot alter this plan'
printf 'Repository: %s\nTarget:     %s\nPackages:   %s\n' "$repo_dir" "$target_dir" "${packages[*]}"

has_package() {
  local p
  for p in "${packages[@]}"; do [[ $p != "$1" ]] || return 0; done
  return 1
}
stow_run() {
  (cd "$repo_dir" && command stow --dir="$repo_dir" --target="$target_dir" "$@")
}
check_tools() {
  local missing=0 tool
  for tool in git stow; do
    if command -v "$tool" >/dev/null 2>&1; then printf 'OK      %s\n' "$tool"
    else printf 'MISSING %s\n' "$tool"; missing=1; fi
  done
  for tool in zsh nvim tmux; do
    if has_package "$tool"; then
      if command -v "$tool" >/dev/null 2>&1; then printf 'OK      %s\n' "$tool"
      else printf 'MISSING %s (config can be linked before installing it)\n' "$tool"; missing=1; fi
    fi
  done
  for tool in uv fnm fzf zoxide eza convert identify; do
    command -v "$tool" >/dev/null 2>&1 || printf 'OPTIONAL %s\n' "$tool"
  done
  if has_package nvim && command -v nvim >/dev/null 2>&1; then
    version=$(nvim --version | head -n 1)
    printf '%s\n' "$version"
    if [[ $version =~ v([0-9]+)\.([0-9]+) ]]; then
      if (( BASH_REMATCH[1] == 0 && BASH_REMATCH[2] < 11 )); then
        printf 'MISSING Neovim >=0.11\n'; missing=1
      fi
    fi
  fi
  if has_package tmux && command -v tmux >/dev/null 2>&1; then
    version=$(tmux -V)
    printf '%s\n' "$version"
    if [[ $version =~ ([0-9]+)\.([0-9]+) ]]; then
      if (( BASH_REMATCH[1] < 3 || (BASH_REMATCH[1] == 3 && BASH_REMATCH[2] < 3) )); then
        printf 'MISSING tmux >=3.3 for inline images\n'; missing=1
      fi
    fi
  fi
  return "$missing"
}
# URL, destination relative to target, expected entry point.
dependency() {
  local url=$1 relative=$2 entry=$3 destination="$target_dir/$2"
  if [[ -r "$destination/$entry" ]]; then
    printf 'OK      %s\n' "$relative"
  elif [[ -e $destination || -L $destination ]]; then
    if [[ $bootstrap == 1 ]]; then fail "Incomplete dependency at $destination; inspect it before retrying"; fi
    printf 'MISSING %s/%s (existing directory left untouched)\n' "$relative" "$entry"
  elif [[ $bootstrap == 1 ]]; then
    printf 'Clone   %s -> %s\n' "$url" "$destination"
    if [[ $dry_run == 0 ]]; then
      mkdir -p -- "$(dirname -- "$destination")"
      # Clone into a temporary sibling so a failed download leaves no broken install.
      local temporary
      temporary=$(mktemp -d "$destination.clone.XXXXXX")
      if ! git clone --depth=1 "$url" "$temporary"; then
        rm -rf -- "$temporary"
        fail "Clone failed: $url; rerun --bootstrap to retry"
      fi
      if [[ ! -r "$temporary/$entry" ]]; then
        rm -rf -- "$temporary"
        fail "Dependency lacks expected file: $entry"
      fi
      mv -- "$temporary" "$destination"
    fi
  else
    printf 'MISSING %s (use --bootstrap to install)\n' "$relative"
  fi
}
dependencies() {
  if has_package zsh; then
    dependency https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh oh-my-zsh.sh
    dependency https://github.com/romkatv/powerlevel10k.git .oh-my-zsh/custom/themes/powerlevel10k powerlevel10k.zsh-theme
    dependency https://github.com/zsh-users/zsh-autosuggestions.git .oh-my-zsh/custom/plugins/zsh-autosuggestions zsh-autosuggestions.plugin.zsh
    dependency https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting zsh-syntax-highlighting.plugin.zsh
  fi
  if has_package tmux; then
    dependency https://github.com/tmux-plugins/tpm.git .tmux/plugins/tpm tpm
    dependency https://github.com/tmux-plugins/tmux-yank.git .tmux/plugins/tmux-yank yank.tmux
    dependency https://github.com/tmux-plugins/tmux-resurrect.git .tmux/plugins/tmux-resurrect resurrect.tmux
    dependency https://github.com/egel/tmux-gruvbox.git .tmux/plugins/tmux-gruvbox gruvbox-tpm.tmux
  fi
}
if [[ $doctor == 1 ]]; then
  status=0
  check_tools || status=1
  dependencies
  if command -v stow >/dev/null 2>&1; then
    stow_run --simulate --verbose --stow "${packages[@]}" || status=1
  fi
  exit "$status"
fi
command -v stow >/dev/null 2>&1 || fail 'GNU Stow is required. See README.md for installation commands.'
if [[ $bootstrap == 1 ]]; then command -v git >/dev/null 2>&1 || fail '--bootstrap requires Git'; fi

# Preflight the complete operation before creating links or downloading dependencies.
if [[ $action == delete ]]; then
  stow_run --simulate --verbose --delete "${packages[@]}"
  if [[ $dry_run == 0 ]]; then stow_run --verbose --delete "${packages[@]}"; fi
  exit 0
fi
backup_dir=
moved=()
restore_backups() {
  local rel
  for rel in "${moved[@]}"; do
    if [[ ! -e "$target_dir/$rel" && ! -L "$target_dir/$rel" ]]; then
      mkdir -p -- "$(dirname -- "$target_dir/$rel")"
      mv -- "$backup_dir/$rel" "$target_dir/$rel"
    fi
  done
}
roots() {
  case $1 in
    zsh) printf '%s\n' .zshrc ;;
    nvim) printf '%s\n' .config/nvim ;;
    tmux) printf '%s\n' .tmux.conf ;;
    git) printf '%s\n' .gitconfig .gitignore_global ;;
    ghostty) printf '%s\n' .config/ghostty ;;
    bash) printf '%s\n' .bashrc .profile ;;
  esac
}
if ! stow_run --simulate --verbose --stow "${packages[@]}"; then
  [[ $backup == 1 ]] || fail 'Link conflicts found; nothing changed. Inspect them or retry with --backup.'
  printf 'Backup moves whole conflicting package roots, preserving their contents.\n'
  for package in "${packages[@]}"; do
    if stow_run --simulate --verbose --stow "$package" >/dev/null 2>&1; then continue; fi
    while IFS= read -r rel; do
      destination="$target_dir/$rel"
      [[ -e $destination || -L $destination ]] || continue
      # Stow-owned directory links must not be moved with conflicting siblings.
      resolved=$(perl -MCwd=abs_path -e 'print abs_path(shift) // ""' "$destination")
      source=$(perl -MCwd=abs_path -e 'print abs_path(shift) // ""' "$repo_dir/$package/$rel")
      [[ -z $resolved || $resolved != "$source" ]] || continue
      if [[ $dry_run == 1 ]]; then printf 'Would back up: %s\n' "$destination"; continue; fi
      if [[ -z $backup_dir ]]; then
        backup_dir=$(mktemp -d "$target_dir/.dotfiles-backup-$(date +%Y%m%d-%H%M%S).XXXXXX")
        printf 'Backup: %s\n' "$backup_dir"
        trap restore_backups EXIT
      fi
      mkdir -p -- "$(dirname -- "$backup_dir/$rel")"
      mv -- "$destination" "$backup_dir/$rel"
      moved+=("$rel")
    done < <(roots "$package")
  done
  [[ $dry_run == 0 ]] || { printf 'Dry run: resolve the conflicts above; no changes made.\n'; exit 0; }
  stow_run --simulate --verbose --stow "${packages[@]}" || fail 'Conflicts remain; backups will be restored. Inspect parent directories.'
fi
# Linking preflight succeeded. Bootstrap is optional and never updates existing clones.
if [[ $bootstrap == 1 ]]; then dependencies; fi
if [[ $dry_run == 1 ]]; then printf 'Dry run complete: no changes made.\n'; exit 0; fi
# After Stow starts, preserve backups for manual recovery rather than overwrite links.
trap - EXIT
stow_run --verbose --stow "${packages[@]}"
printf 'Done. Open a new shell/editor. Re-run safely to pick up new config files.\n'
[[ -z $backup_dir ]] || printf 'Original files: %s\n' "$backup_dir"
