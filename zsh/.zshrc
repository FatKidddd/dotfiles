# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

export LS_COLORS="rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(
    command-not-found
    extract
    deno
    docker
    git
    github
    gitignore
    fzf
    node
    npm
    nvm
    poetry
    yarn
    volta
    vscode
    sudo
    web-search
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    ohmyzsh-full-autoupdate
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
else
  alias vim='vim'
fi

alias conf="nvim ~/dotfiles/zsh/.zshrc"
alias nvimrc="nvim ~/dotfiles/nvim/.config/nvim/init.lua"

alias poet="source \$(poetry env info --path)/bin/activate"

alias upev="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y"

alias ls="eza -ah --color=auto --group-directories-first --icons"
alias lh="eza -ah --color=auto --group-directories-first --icons"
alias l="eza -ah --color=auto --group-directories-first --icons"
alias :q="exit"

alias lg="lazygit"

alias cdde="cd /mnt/c/Users/justi/Desktop/";
alias cddo="cd /mnt/c/Users/justi/Downloads/";

# -----------------------------------------------------------------------------
# llm - Concatenate project files for Large Language Model context
#
# By default, treats all files as code (never truncated). Smartly truncates
# common data/log files if they exceed a line limit.
#
# Usage:
#   llm [-v] [-c] [-s] [path]
#
#   -v, --verbose        : Print files as they are being processed.
#   -c, --clipboard-only : Only copy content to clipboard, do not save to file.
#   -s, --save-only      : Only save content to file, do not copy to clipboard.
#   path                 : Directory or file to process (defaults to current dir).
# -----------------------------------------------------------------------------
function llm() {
  # --- Configuration ---
  # Line limit for DATA files. Code files will ignore this limit.
  local MAX_DATA_FILE_LINES=200
  # List of extensions to be treated as DATA (will be truncated if too long).
  # Any file NOT in this list is treated as code and will be included in full.
  local DATA_EXTENSIONS=(
    csv json jsonl log txt xml tsv
  )
  # Default ignored directories, files, and extensions (can be extended by .llmignore)
  local ignore_dirs_basenames=( .git .idea .vscode .next .svelte-kit .terragrunt-cache .terraform node_modules venv .venv __pycache__ dist build target public/build coverage cache .cache vendor obj bin )
  local ignore_files_basenames=( .DS_Store package-lock.json yarn.lock pnpm-lock.yaml composer.lock )
  local ignore_exts_basenames=( 7z a ar rar so tar tgz zip bmp gif jpeg jpg png svg webp heic avi flv mkv mov mp3 mp4 mpeg ogg wav pdf doc docx odt xls xlsx eot otf ttf woff woff2 bin class com dll dylib exe o pyc db db3-journal lock sqlite sqlite3 swp swo min.css min.js )

  # --- Nested Helper Function for Smart Truncation ---
  # This function is only called for DATA files that are too long.
  function _llm_smart_truncate() {
    local file_path="$1"
    local max_lines="$2"
    local truncate_notice="\n... (file content truncated for brevity) ...\n"

    local filename=$(basename -- "$file_path")
    local extension="${filename##*.}"

    case "$extension" in
      csv)
        head -n "$max_lines" "$file_path"; echo -e "$truncate_notice" ;;
      json)
        if command -v jq >/dev/null 2>&1; then
          jq "walk(
                if type == \"array\" and length > $max_lines then .[:$max_lines]
                elif type == \"object\" and (keys | length) > $max_lines then . as \$obj | keys[:$max_lines] | map({(.) : \$obj[.]}) | add
                else .
                end
              )" "$file_path" 2>/dev/null || \
              { echo "--- Note: JQ failed, using generic truncation ---" >&2; head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path"; }
        else
          head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path"
        fi
        ;;
      log)
        echo "[Log file truncated. Showing the most recent $max_lines lines.]"; echo -e "$truncate_notice"; tail -n "$max_lines" "$file_path" ;;
      *) # Generic fallback for other data types like .txt, .xml, etc.
        head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path" ;;
    esac
  }

  # --- Argument Parsing ---
  local target_path="."
  local verbose=0
  local output_to_clipboard=1; local save_to_file=1
  local parsed_args=()
  for arg in "$@"; do
    case "$arg" in
      -v | --verbose) verbose=1 ;;
      -c | --clipboard-only) output_to_clipboard=1; save_to_file=0 ;;
      -s | --save-only) output_to_clipboard=0; save_to_file=1 ;;
      -*) echo "Error: Unknown option '$arg'" >&2; return 1 ;;
      *) parsed_args+=("$arg") ;;
    esac
  done
  if [[ ${#parsed_args[@]} -gt 1 ]]; then echo "Error: Only one path argument allowed." >&2; return 1; elif [[ ${#parsed_args[@]} -eq 1 ]]; then target_path="${parsed_args[1]}"; fi

  # --- Initial Setup ---
  if [[ ! -e "$target_path" ]]; then echo "Error: Path '$target_path' does not exist." >&2; return 1; fi
  target_path=$(realpath "$target_path" 2>/dev/null || readlink -f "$target_path" 2>/dev/null || echo "$target_path")

  # --- CLIPBOARD COMMAND DETECTION ---
  local clip_cmd_arr=()
  if [[ "$output_to_clipboard" -eq 1 ]]; then
    if command -v pbcopy >/dev/null 2>&1; then clip_cmd_arr=(pbcopy);
    elif command -v wl-copy >/dev/null 2>&1; then clip_cmd_arr=(wl-copy);
    elif command -v xsel >/dev/null 2>&1; then clip_cmd_arr=(xsel --clipboard --input);
    else echo "Warning: No clipboard utility found. Cannot copy to clipboard." >&2; output_to_clipboard=0; fi
  fi
  if [[ "$output_to_clipboard" -eq 1 && ${#clip_cmd_arr[@]} -eq 0 ]]; then echo "Error: Clipboard output requested but no valid clipboard utility found." >&2; return 1; fi

  local output_dir="$HOME/.llm_contexts"
  if [[ "$save_to_file" -eq 1 ]]; then mkdir -p "$output_dir"; fi
  local base_name=${$(basename "$target_path"):-$(basename "$PWD")}; local timestamp=$(date +%Y%m%d-%H%M%S); local output_file="${base_name}-${timestamp}.txt"; local output_path="${output_dir}/${output_file}"

  # --- Main Processing Block ---
  # This block generates the content and then pipes it to the chosen destinations
  {
    if [[ -f "$target_path" ]]; then
      # Handle a single file
      echo "--- FILE: $(basename "$target_path") ---"
      local extension="${target_path##*.}"
      # Check if the file's extension IS a known data type
      if [[ " ${DATA_EXTENSIONS[@]} " =~ " ${extension} " ]]; then
        # It's a data file, so check its length for truncation
        local line_count=$(wc -l < "$target_path" | tr -d ' ')
        if (( line_count > MAX_DATA_FILE_LINES )); then
          if [[ "$verbose" -eq 1 ]]; then echo "     (truncating data file, ${line_count} lines > ${MAX_DATA_FILE_LINES})" >&2; fi
          _llm_smart_truncate "$target_path" "$MAX_DATA_FILE_LINES"
        else
          cat "$target_path"
        fi
      else
        # It's not a known data type, so treat it as code and include it all
        cat "$target_path"
      fi
      echo
    else
      # Handle a directory
      local project_root="$target_path"
      local effective_ignore_dirs_basenames=("${ignore_dirs_basenames[@]}")
      local effective_ignore_files_basenames=("${ignore_files_basenames[@]}")
      local effective_ignore_exts_basenames=("${ignore_exts_basenames[@]}")
      local effective_ignore_wholenames=()

      local llmignore_file="${project_root}/.llmignore"
      if [[ -f "$llmignore_file" ]]; then
        if [[ "$verbose" -eq 1 ]]; then echo ":information_source: Loading ignores from $llmignore_file" >&2; fi
        while IFS= read -r line || [[ -n "$line" ]]; do
          local pattern=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
          [[ -z "$pattern" ]] || [[ "$pattern" =~ ^# ]] && continue
          if [[ "$pattern" == *\/* ]]; then effective_ignore_wholenames+=("$pattern");
          elif [[ "$pattern" == *.* ]]; then [[ "$pattern" == .* ]] && effective_ignore_exts_basenames+=("${pattern#.}") || effective_ignore_files_basenames+=("$pattern");
          else effective_ignore_files_basenames+=("$pattern"); fi
        done < "$llmignore_file"
      fi

      local find_cmd=("find" ".")
      local find_conditions=()
      local default_dir_prune_conditions=(); for dir_name in "${effective_ignore_dirs_basenames[@]}"; do default_dir_prune_conditions+=(-o -name "$dir_name"); done
      if [[ ${#default_dir_prune_conditions[@]} -gt 0 ]]; then find_conditions+=(-type d \( "${default_dir_prune_conditions[@]:1}" \) -prune -o); fi
      local llmignore_wholename_conditions=(); for pat in "${effective_ignore_wholenames[@]}"; do llmignore_wholename_conditions+=(-o -wholename "$pat"); done
      if [[ ${#llmignore_wholename_conditions[@]} -gt 0 ]]; then find_conditions+=('!' \( "${llmignore_wholename_conditions[@]:1}" \) -o); fi
      local file_basename_conditions=(); for ext in "${effective_ignore_exts_basenames[@]}"; do file_basename_conditions+=(-o -name "*.$ext"); done
      for file_name in "${effective_ignore_files_basenames[@]}"; do file_basename_conditions+=(-o -name "$file_name"); done

      find_cmd+=("${find_conditions[@]}"); find_cmd+=(-type f)
      if [[ ${#file_basename_conditions[@]} -gt 0 ]]; then find_cmd+=('!' \( "${file_basename_conditions[@]:1}" \)); fi
      find_cmd+=(-print0)

      (
        cd "$project_root" || { echo "Error: Could not change to $project_root" >&2; return 1; }
        "${find_cmd[@]}"
      ) | while IFS= read -r -d '' file; do
        local abs_file="${project_root}/${file}"
        if [[ "$(file -b --mime-type "$abs_file" 2>/dev/null)" == text/* || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/json || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/xml ]]; then
          if [[ "$verbose" -eq 1 ]]; then echo "  -> Adding $file" >&2; fi
          echo "--- FILE: $file ---"

          local extension="${file##*.}"
          # Check if the file's extension IS a known data type
          if [[ " ${DATA_EXTENSIONS[@]} " =~ " ${extension} " ]]; then
            # It's a data file, so check its length for truncation
            local line_count=$(wc -l < "$abs_file" | tr -d ' ')
            if (( line_count > MAX_DATA_FILE_LINES )); then
              if [[ "$verbose" -eq 1 ]]; then echo "     (truncating data file, ${line_count} lines > ${MAX_DATA_FILE_LINES})" >&2; fi
              _llm_smart_truncate "$abs_file" "$MAX_DATA_FILE_LINES"
            else
              cat "$abs_file"
            fi
          else
            # It's not a known data type, so treat it as code and include it all
            cat "$abs_file"
          fi
          echo; echo
        fi
      done
    fi
  } | {
    # Dynamically handle output piping
    local temp_output
    if [[ "$save_to_file" -eq 1 ]]; then
      # If saving, `tee` to file and then pipe to clipboard if needed
      temp_output=$(tee "$output_path")
    else
      # If not saving, just pass content through with `cat`
      temp_output=$(cat)
    fi

    if [[ "$output_to_clipboard" -eq 1 ]]; then
      echo "$temp_output" | "${clip_cmd_arr[@]}"
    fi
  }

  # --- Final Report ---
  local char_count=0
  if [[ "$save_to_file" -eq 1 && -f "$output_path" ]]; then
    char_count=$(wc -c < "$output_path" | tr -d ' ')
  elif [[ "$output_to_clipboard" -eq 1 && ${#clip_cmd_arr[@]} -gt 0 ]]; then
    if command -v pbpaste >/dev/null 2>&1; then char_count=$(pbpaste | wc -c | tr -d ' ');
    elif command -v xsel >/dev/null 2>&1; then char_count=$(xsel -o -b | wc -c | tr -d ' ');
    elif command -v wl-paste >/dev/null 2>&1; then char_count=$(wl-paste | wc -c | tr -d ' ');
    fi
  fi
  local token_estimate=$((char_count / 4))

  if [[ "$output_to_clipboard" -eq 1 ]]; then echo ":white_check_mark: Content from '$(basename "$target_path")' copied to clipboard."; fi
  if [[ "$save_to_file" -eq 1 ]]; then echo "   ~${token_estimate} tokens saved to: $output_path";
  else echo "   (File not saved: use default behavior or --save-only to save)"; fi
}



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/.nvim/bin"

VOLTA_FEATURE_PNPM=1
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

alias npm=pnpm

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.local/bin" # for protoc rust

# for clangd lsp to know where header files are
export CPLUS_INCLUDE_PATH="/usr/include/c++/13:/usr/include/x86_64-linux-gnu/c++/13"
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:$HOME/CP/ac-library"

export PATH="$PATH:$HOME/.foundry/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
