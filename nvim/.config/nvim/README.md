# Neovim

A small editor for quick edits, navigation, comments, and plain Markdown notes.
Copilot supplies inline suggestions; LSP completion uses Blink. AI chat stays in the external UI.

## Files

- `init.lua`: plugin manager bootstrap.
- `lua/custom/core.lua`: editor options, keymaps, and autocommands.
- `lua/custom/plugins/init.lua`: everyday plugins.
- `lua/custom/plugins/markdown.lua`: inline images and clipboard image pasting.
- `lua/custom/plugins/competitive.lua`: C++ competitive programming, loaded for C++ files or `:CompetiTest`.
- `lua/kickstart/plugins/`: Git signs, linting, autopairs, and the file tree.

## Navigation and editing

Space is the leader.

| Keys | Action |
| --- | --- |
| `<leader>sf` | Find project files |
| `<leader>sg` | Search project text |
| `<leader>sb` | Find open buffers |
| `<leader><leader>` | Previous buffer |
| `<leader>1` … `<leader>4` | Harpoon files |
| `<leader>f` | Format through Conform |
| `<leader>y` | Copy to the system clipboard |
| `Ctrl+f` | Scroll forward |

## Notes

Keep new personal notes in the existing `~/Desktop/Notes` directory.

| Keys | Action |
| --- | --- |
| `<leader>ni` | Open `inbox.md` for quick capture |
| `<leader>nf` | Find a note with Telescope |
| `<leader>ng` | Search note text with Telescope |

No Obsidian plugin, frontmatter generator, or review popup is required.
Existing notes remain untouched. The inbox file is created only when you save it.
Markdown images render inline through ImageMagick CLI and tmux passthrough.
`<leader>p` pastes an image in Markdown buffers. Use `gx` to open image links externally.

## Competitive programming

The GCC 14/C++23 configuration and sanitizer flags are preserved.
`$CXX` overrides the default compiler.

| Keys, in a C++ buffer | Action |
| --- | --- |
| `Alt+a` | Receive test cases |
| `Alt+r` | Run test cases |
| `Alt+Shift+r` | Compile and run in the bottom tmux pane |
| `Alt+k` | Remove the current file's test cases |

Use `:CompetiTest` for additional commands. The interactive run expects the usual
`bin/` directory and a bottom tmux pane, as before.

## Maintenance

The lockfile preserves installed versions of active plugins.
Unused Avante, Obsidian, Java/testing, and completion dependencies were removed
from the configuration and lockfile. Installed plugin directories have not been deleted.
Use `:Lazy` to inspect the active plugin list before choosing to clean obsolete downloads.
