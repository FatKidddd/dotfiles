-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false

-- -- Sync clipboard between OS and Neovim.
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)
--
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Your custom options
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.bo.softtabstop = 2
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.hlsearch = true

-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, { desc = 'Show diagnostic [X] (Error) messages' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Your custom keymaps
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', '<M-BS>', '<C-w>')
vim.keymap.set('i', '<C-Del>', '<C-o>dw')
vim.keymap.set('n', '<C-y>', '<C-i>', { noremap = true, desc = 'Jump forward in jumplist' })
vim.keymap.set('n', '<TAB>', '>>', { desc = 'Indent line' })
vim.keymap.set('n', '<S-TAB>', '<<', { desc = 'Unindent line' })
vim.keymap.set('v', '<TAB>', '>gv', { desc = 'Indent selection' })
vim.keymap.set('v', '<S-TAB>', '<gv', { desc = 'Unindent selection' })
vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>ww', ':set wrap!<CR>', { noremap = true, silent = true, desc = 'Toggle line wrap' })

-- asterisk for cgn for normal and visual
vim.keymap.set('n', '*', '*N', { noremap = true })
vim.api.nvim_exec2(
  [[
  function! g:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>N
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>N
]],
  {}
)

-- for CP - to add & edit testcase just use CompetiTest commands directly
vim.keymap.set('n', '<M-k>', '<cmd>!rm testcases/%<_input*.txt testcases/%<_output*.txt<CR>', { desc = 'CP: Remove testcases' })
vim.keymap.set('n', '<M-a>', '<cmd>CompetiTest receive testcases<CR>', { desc = 'CP: Receive testcases' })
vim.keymap.set('n', '<M-r>', '<cmd>CompetiTest run<CR>', { desc = 'CP: Run testcases' })
vim.keymap.set(
  'n',
  '<M-R>',
  '<cmd>silent !tmux send-keys -t bottom "g++ -std=c++20 -Wshadow -Wextra -Wall -fsanitize=address -fsanitize=undefined -D_GLIBCXX_ASSERTIONS -D_GLIBCXX_DEBUG -ggdb3 -o bin/%< % && bin/%<" C-m<CR>',
  { desc = 'CP: Compile and run in tmux (interactive)' }
)

-- Keybinds to make split navigation easier
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Your other custom keymaps
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking (visual)' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to black hole register' })
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux new tmux-sessionizer<CR>', { desc = 'Open tmux sessionizer' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer (LSP)' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next location list item' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Previous location list item' })
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute word under cursor' })
vim.keymap.set('n', '<leader>vpp', '<cmd>e ~/.config/nvim/init.lua<CR>', { desc = 'Edit nvim config' })

-- Profiling Functions & Keymaps
local PROFILE_LOG_FILE = vim.fn.stdpath 'data' .. '/profile.log'
function _G.start_nvim_profiling()
  print 'Starting Neovim profiling...'
  vim.cmd('profile start ' .. PROFILE_LOG_FILE)
  vim.cmd 'profile func *'
  vim.cmd 'profile file *'
  vim.notify('Neovim profiling started. Do your slow actions now.', vim.log.levels.INFO, { title = 'Profiling' })
end

function _G.pause_nvim_profiling_and_quit()
  print 'Pausing Neovim profiling and quitting all buffers...'
  vim.cmd 'profile pause'
  vim.notify('Neovim profiling paused. Closing Neovim to finalize log.', vim.log.levels.INFO, { title = 'Profiling' })
  vim.cmd 'noautocmd qall!'
end

vim.keymap.set('n', '<leader>ps', function()
  _G.start_nvim_profiling()
end, { desc = 'Start Neovim Profiling' })
vim.keymap.set('n', '<leader>pv', function()
  _G.pause_nvim_profiling_and_quit()
end, { desc = 'Pause Profiling and View Log (quits Neovim)' })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Your custom autocommand
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'txt', 'env', 'norg' },
  group = vim.api.nvim_create_augroup('kickstart-custom-filetype-cmp-spell', { clear = true }),
  callback = function(opts)
    if package.loaded.cmp then
      local cmp = require 'cmp'
      cmp.setup.buffer { enabled = false }
    end
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.spell = true
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>sF', function()
        builtin.find_files { cwd = vim.env.HOME }
      end, { desc = '[S]earch [F]iles Home Directory' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
      'nvim-java/nvim-java',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach-highlight', { clear = true }),
              callback = function(event2_detach)
                if event2_detach.buf == event.buf then
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2_detach.buf }
                end
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        clangd = {},
        ts_ls = {},
        lua_ls = {
          settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        },
        pyright = {},
        -- pyrefly = {},
      }

      local ensure_installed_tools = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed_tools, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed_tools }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            require('lspconfig')[server_name].setup(server_opts)
          end,
          jdtls = function()
            require('java').setup {}
            require('lspconfig').jdtls.setup {
              capabilities = capabilities,
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      { name = 'JavaSE-21', path = '/usr/lib/jvm/java-21-openjdk-amd64/bin', default = true },
                    },
                  },
                },
              },
            }
          end,
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true, solidity = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    'rebelot/kanagawa.nvim',
    -- 'EdenEast/nightfox.nvim',
    -- 'catppuccin/nvim',
    -- 'rose-pine/neovim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.colorscheme 'kanagawa'
      -- vim.cmd.colorscheme 'carbonfox'
      -- vim.cmd.colorscheme 'catppuccin-mocha'
      -- vim.cmd.colorscheme 'rose-pine-main'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'rust',
        'solidity',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- Your custom plugins
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: [A]dd file' })
      vim.keymap.set('n', '<leader>e', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: Toggle UI / [E]dit list' })
      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: Goto mark 1' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: Goto mark 2' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: Goto mark 3' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: Goto mark 4' })
      vim.keymap.set('n', '<M-S-P>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon: Previous mark' })
      vim.keymap.set('n', '<M-S-N>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon: Next mark' })
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },

  {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require('competitest').setup {
        testcases_directory = 'testcases',
        running_directory = 'bin',
        compile_command = {
          cpp = {
            exec = 'g++',
            args = {
              '-std=c++20',
              '-Wshadow',
              '-Wextra',
              '-Wall',
              '-D_GLIBCXX_ASSERTIONS',
              '-D_GLIBCXX_DEBUG',
              '-ggdb3',
              '-fsanitize=address',
              '-fsanitize=undefined',
              '$(FNAME)',
              '-o',
              './bin/$(FNOEXT)',
            },
          },
        },
      }
    end,
  },

  {
    'lervag/vimtex',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  {
    'kwkarlwang/bufresize.nvim',
    config = function()
      require('bufresize').setup()
    end,
  },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcasia/neotest-java',
    },
    opts = function()
      local neotest_java_config = {}
      if vim.g.have_nerd_font then
      end
      return {
        adapters = {
          ['neotest-java'] = neotest_java_config,
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
      }
    end,
    config = function(_, opts)
      require('neotest').setup(opts)
      vim.keymap.set('n', '<leader>Tt', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = 'Neotest: Run File' })
      vim.keymap.set('n', '<leader>TT', function()
        require('neotest').run.run(vim.loop.cwd())
      end, { desc = 'Neotest: Run All Test Files' })
      vim.keymap.set('n', '<leader>TR', function()
        require('neotest').run.run()
      end, { desc = 'Neotest: Run Nearest' })
      vim.keymap.set('n', '<leader>Ts', function()
        require('neotest').summary.toggle()
      end, { desc = 'Neotest: Toggle Summary' })
      vim.keymap.set('n', '<leader>To', function()
        require('neotest').output.open { enter = true, auto_close = true }
      end, { desc = 'Neotest: Show Output' })
      vim.keymap.set('n', '<leader>Ta', function()
        require('neotest').run.attach()
      end, { desc = 'Neotest: Attach to session' })
      vim.keymap.set('n', '<leader>Td', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = 'Neotest: Debug Nearest' })
    end,
  },

  { 'nvim-neorg/neorg', lazy = false, version = '*', config = true },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = '<Tab>',
        },
      },
    },
  },

  {
    'yetone/avante.nvim',
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has 'win32' == 1 then
        return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      else
        return 'make'
      end
    end,
    event = 'VeryLazy',
    lazy = false,
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      mappings = { suggestion = { accept = '<Tab>', next = '<M-]>', prev = '<M-[>', dismiss = '<C-]>' } },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        auto_approve_tool_permissions = true,
      },
      auto_suggestions_provider = 'deepinfra-chat',
      -- suggestion = {
      --   debounce = 300,
      --   throttle = 600,
      -- },
      -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
      -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
      -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
      provider = 'deepinfra', -- no idea why deepseek keeps thinking forever, and can't call shit
      providers = {
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-chat',
          extra_request_body = {
            temperature = 0,
          },
        },
        deepinfra = {
          __inherited_from = 'openai',
          api_key_name = 'DEEP_INFRA_API_KEY',
          endpoint = 'https://api.deepinfra.com/v1/openai',
          model = 'deepseek-ai/DeepSeek-R1-0528',
          extra_request_body = {
            temperature = 0.75,
          },
        },
        ['deepinfra-chat'] = {
          __inherited_from = 'openai',
          api_key_name = 'DEEP_INFRA_API_KEY',
          endpoint = 'https://api.deepinfra.com/v1/openai',
          model = 'deepseek-ai/DeepSeek-V3-0324',
          timeout = 30000, -- in ms
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        novita_ai = {
          __inherited_from = 'openai',
          api_key_name = 'NOVITA_AI_API_KEY',
          endpoint = 'https://api.novita.ai/v3/openai',
          model = 'deepseek/deepseek-r1-0528',
          extra_request_body = {
            temperature = 0.75,
          },
        },
        gemini = {
          model = 'gemini-2.5-flash-preview-05-20',
          extra_request_body = {
            temperature = 1,
            max_tokens = 1000000,
          },
        },
        ['gemini-pro'] = {
          __inherited_from = 'gemini',
          model = 'gemini-2.5-pro-preview-06-05',
          extra_request_body = {
            temperature = 1,
            max_tokens = 1000000,
          },
        },
        ['gemini-flash-2.0'] = {
          __inherited_from = 'gemini',
          model = 'gemini-2.0-flash',
          extra_request_body = {
            temperature = 1,
            max_tokens = 1500000,
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'stevearc/dressing.nvim', -- for input provider dressing
      'folke/snacks.nvim', -- for input provider snacks
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    opts = {
      enabled = false,
      message_template = ' <summary> • <date> • <author> • <<sha>>',
      date_format = '%m-%d-%Y %H:%M:%S',
      virtual_text_column = nil,
    },
  },

  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
