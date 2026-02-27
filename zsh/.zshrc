# ============================================================
# ~/.zshrc
# ============================================================

# Powerlevel10k instant prompt — must be first
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# PATH
# ============================================================
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.nvim/bin"
export PATH="$PATH:$HOME/.foundry/bin"
export PATH="$HOME/vcpkg:$PATH"
export PATH=/home/justin/.opencode/bin:$PATH
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH="$PATH:$HOME/idea-IC-252.23892.409/bin"
export PATH="$PATH:$HOME/aseprite/build/bin"

VOLTA_FEATURE_PNPM=1
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

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

plugins=(
    command-not-found
    extract
    git
    fzf
    poetry
    volta
    vscode
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ============================================================
# ALIASES
# ============================================================
if command -v nvim > /dev/null 2>&1; then alias vim='nvim'; fi

alias conf="nvim ~/dotfiles/zsh/.zshrc"
alias nconf="nvim ~/dotfiles/nvim/.config/nvim/init.lua"
alias tconf="nvim ~/dotfiles/tmux/.tmux.conf"
alias notes="cd ~/Desktop/Notes && nvim"
alias nus="cd ~/Desktop/NUS/2526S1"

alias poet="source \$(poetry env info --path)/bin/activate"
alias upev="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y"

alias ls="eza -ah --color=auto --group-directories-first --icons"
alias lh="eza -ah --color=auto --group-directories-first --icons"
alias l="eza -ah --color=auto --group-directories-first --icons"
alias :q="exit"
alias lg="lazygit"
alias c="clear"

alias cdde="cd ~/Desktop/"
alias cddo="cd ~/Downloads/"
alias gitzip="git archive HEAD -o \${PWD##*/}.zip"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias inspect-evm-errors="$HOME/projects/sec/helpers/evm/get-error-selectors.sh"
alias inspect-evm="$HOME/projects/sec/helpers/evm/inspect-contract.sh"
alias inspect-sol="$HOME/projects/sec/helpers/sol/inspect-contract"

# ============================================================
# TOOLS
# ============================================================
eval "$(pyenv init -)"

. "$HOME/.cargo/env"

export CPLUS_INCLUDE_PATH="/usr/include/c++/13:/usr/include/x86_64-linux-gnu/c++/13"
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:$HOME/CP/ac-library"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================
# FUNCTIONS
# ============================================================

# Searches upward for a Python .venv, stopping at .git
function vup() {
  local current_dir="$PWD" found_venv=""
  while [[ "$current_dir" != "/" ]]; do
    [[ -f "$current_dir/.venv/bin/activate" ]] && { found_venv="$current_dir/.venv"; break; }
    if [[ -d "$current_dir/.git" ]]; then
      [[ -f "$current_dir/.venv/bin/activate" ]] && found_venv="$current_dir/.venv"
      break
    fi
    current_dir=$(dirname "$current_dir")
  done
  if [[ -n "$found_venv" ]]; then echo "vup: activated $found_venv"
  else echo "vup: no .venv found" >&2; return 1; fi
}

# Source .zshrc.d/ — modular functions (llm, llm_apply, etc.)
for _f in ~/.zshrc.d/*.zsh; do [[ -f "$_f" ]] && source "$_f"; done
unset _f

# ============================================================
# SECRETS — local only, never tracked by git
# ============================================================
[[ -f ~/.secrets ]] && source ~/.secrets

# ============================================================
# RUNTIME INIT — must stay at bottom (sdkman requirement)
# ============================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# conda (managed by `conda init` — do not edit manually)
__conda_setup="$('/home/justin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/justin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/justin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/justin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
