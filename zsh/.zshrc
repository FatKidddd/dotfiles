# ============================================================
# ~/.zshrc
# ============================================================

# Powerlevel10k instant prompt — must be first
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# PATH — retain precedence without accumulating duplicates on reload
# ============================================================
typeset -U path PATH
path=(
  "$HOME/.local/share/solana/install/active_release/bin"
  "$HOME/.opencode/bin"
  "$HOME/vcpkg"
  "$HOME/bin" "$HOME/.local/bin" /usr/local/bin
  $path
  "$HOME/.nvim/bin" "$HOME/.foundry/bin" "$HOME/go/bin"
  "$HOME/idea-IC-252.23892.409/bin" "$HOME/aseprite/build/bin"
)
export PATH

# ============================================================
# OH MY ZSH
# ============================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

export LS_COLORS="rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:"

zstyle ':omz:update' mode auto

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

# Optional integrations should not break the shell on a fresh machine.
[[ -r "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" ]] || ZSH_THEME=""
plugins=(git extract command-not-found)
for _tool in fzf zoxide; do
  command -v "$_tool" >/dev/null 2>&1 && plugins+=("$_tool")
done
for _plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  [[ -r "$ZSH/custom/plugins/$_plugin/$_plugin.plugin.zsh" ]] && plugins+=("$_plugin")
done
unset _tool _plugin
if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  autoload -Uz compinit
  compinit
  PROMPT='%n@%m %~ %# '
fi

# ============================================================
# ALIASES
# ============================================================
if command -v nvim > /dev/null 2>&1; then alias vim='nvim'; fi

alias conf="nvim ~/.zshrc"
alias nconf="nvim ~/.config/nvim/init.lua"
alias tconf="nvim ~/.tmux.conf"

alias upev="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza -ah --color=auto --group-directories-first --icons"
  alias lh=ls l=ls
fi
alias :q="exit"
alias lg="lazygit"
alias c="clear"

alias gitzip="git archive HEAD -o \${PWD##*/}.zip"

if command -v wl-copy >/dev/null 2>&1; then
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'
elif command -v xsel >/dev/null 2>&1; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

# ============================================================
# TOOLS
# ============================================================

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Build tools use GCC 14 by default. Projects still own their language standard.
if command -v gcc-14 >/dev/null 2>&1; then export CC="${CC:-gcc-14}"; fi
if command -v g++-14 >/dev/null 2>&1; then export CXX="${CXX:-g++-14}"; fi

# Never force one compiler's standard-library headers onto another compiler.
unset CPLUS_INCLUDE_PATH C_INCLUDE_PATH CPATH

[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ============================================================
# FUNCTIONS
# ============================================================

# Searches upward for a Python .venv, stopping at .git
function vup() {
  local current_dir="$PWD"
  while true; do
    if [[ -r "$current_dir/.venv/bin/activate" ]]; then
      source "$current_dir/.venv/bin/activate" || return
      print -r -- "vup: activated $current_dir/.venv"
      return 0
    fi
    # Git worktrees have a .git file rather than a directory.
    [[ -e "$current_dir/.git" || "$current_dir" == / ]] && break
    current_dir=${current_dir:h}
  done
  print -u2 -- 'vup: no .venv found'
  return 1
}

# ============================================================
# SECRETS — local only, never tracked by git
# ============================================================
[[ -f ~/.secrets ]] && source ~/.secrets
# Machine-specific paths and overrides live outside Git.
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# ============================================================
# RUNTIME INTEGRATIONS
# ============================================================
# Official Linux/macOS installer locations; package-manager installs use PATH.
for _fnm_bin in "${XDG_DATA_HOME:-$HOME/.local/share}/fnm" "$HOME/Library/Application Support/fnm"; do
  if [[ -x "$_fnm_bin/fnm" ]]; then
    path=("$_fnm_bin" $path)
    break
  fi
done
unset _fnm_bin
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --version-file-strategy recursive --shell zsh)"
fi

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Conda is reserved for school; initialize it on first explicit invocation.
function conda() {
  local conda_root=${CONDA_ROOT:-$HOME/anaconda3}
  if [[ ! -x "$conda_root/bin/conda" ]]; then
    print -u2 -- "Conda is not installed at $conda_root; set CONDA_ROOT in ~/.zshrc.local"
    return 127
  fi
  local conda_hook
  conda_hook=$(CONDA_AUTO_ACTIVATE_BASE=false "$conda_root/bin/conda" shell.zsh hook) || return
  unfunction conda
  eval "$conda_hook" || return
  conda "$@"
}
