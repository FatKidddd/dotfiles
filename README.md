# Dotfiles

Uses [GNU Stow](https://www.gnu.org/software/stow/) to symlink configs into `~`.

## Setup

```bash
git clone git@github.com:FatKidddd/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.zsh
```

Then create `~/.secrets` (never committed — add your API keys here):

```bash
touch ~/.secrets && chmod 600 ~/.secrets
$EDITOR ~/.secrets
```

### ~/.secrets format

```bash
export ANTHROPIC_API_KEY="..."
export DEEPSEEK_API_KEY="..."
export GEMINI_API_KEY="..."
export TAVILY_API_KEY="..."
export DEEP_INFRA_API_KEY="..."
export NOVITA_AI_API_KEY="..."

export OPENAI_API_BASE_DEEPINFRA="https://api.deepinfra.com/v1/openai"
export OPENAI_API_BASE=$OPENAI_API_BASE_DEEPINFRA
export OPENAI_API_KEY=$DEEP_INFRA_API_KEY
```

## How stow works

Each directory is a **stow package**. `install.zsh` runs `stow` on all of them.
The path inside the package becomes the path relative to `$HOME`:

```
zsh/.zshrc              → ~/.zshrc
zsh/.zshrc.d/llm.zsh    → ~/.zshrc.d/llm.zsh
nvim/.config/nvim/      → ~/.config/nvim/
tmux/.tmux.conf         → ~/.tmux.conf
```

To add a new config to an existing package, mirror its `$HOME` path:

```bash
mkdir -p ~/dotfiles/zsh/.config/foo/
mv ~/.config/foo/config.toml ~/dotfiles/zsh/.config/foo/
cd ~/dotfiles && stow zsh   # re-stow to pick up new files
```

## What's included

| Package | Config |
|---------|--------|
| `zsh/` | `~/.zshrc`, `~/.zshrc.d/` |
| `nvim/` | `~/.config/nvim/` |
| `tmux/` | `~/.tmux.conf` |
| `bash/` | `~/.bashrc`, `~/.profile` |

```bash
cd ~/path/to/repo && takopi init myproject
```

Telegram commands: `/topic myproject @branch`, `/ctx`, `/new`
