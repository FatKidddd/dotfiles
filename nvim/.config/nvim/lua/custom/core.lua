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
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Your custom options
vim.o.tabstop = 4
vim.o.shiftwidth = 4
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
-- vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to black hole register' }) -- removed for gdb / pdb plugin
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next location list item' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Previous location list item' })
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute word under cursor' })
vim.keymap.set('n', '<leader>vpp', '<cmd>e ~/.config/nvim/init.lua<CR>', { desc = 'Edit nvim config' })

-- Wrap selection in a fenced code block
local function wrap_in_code_block()
  -- Use getpos() to reliably get the line numbers of the visual selection.
  local _, start_line, _, _ = unpack(vim.fn.getpos "'<")
  local _, end_line, _, _ = unpack(vim.fn.getpos "'>")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local lang = vim.fn.input 'Language: '
  table.insert(selected_lines, 1, '```' .. lang)
  table.insert(selected_lines, '```')
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, selected_lines)
end

vim.api.nvim_create_user_command('WrapInCodeBlock', wrap_in_code_block, {})

-- Using ':<C-u>...' ensures that we exit visual mode, which correctly sets the '< and '> marks for the next operation.
vim.keymap.set('v', '`', ':<C-u>WrapInCodeBlock<CR>', {
  noremap = true,
  silent = true,
  desc = 'Wrap selection in a fenced code block',
})

vim.keymap.set('n', '<leader>td', ':Dooing<CR>', { noremap = true, silent = true, desc = 'Open Dooing todo list' })

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
  group = vim.api.nvim_create_augroup('kickstart-custom-filetype-completion-spell', { clear = true }),
  callback = function(opts)
    vim.b[opts.buf].completion = false
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.spell = true
  end,
})

-- Smart comment alignment for Solidity files so that i don't waste having to indent comments
local function handle_smart_comment(mode)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  -- Supported markers
  local patterns = { '//', '#', '/%*' }
  local first_pos, marker
  for _, p in ipairs(patterns) do
    local s, e = line:find(p)
    if s and (not first_pos or s < first_pos) then
      first_pos, marker = s, line:sub(s, e)
    end
  end

  -- Fallback if no comment found on line
  if not first_pos then
    local keys = { o = 'o', S = 'S', cr = '<CR>' }
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys[mode], true, false, true), 'n', false)
    return
  end

  vim.schedule(function()
    local padding = string.rep(' ', first_pos - 1)

    if mode == 'S' then
      local content = padding .. marker .. ' '
      vim.api.nvim_set_current_line(content)
      vim.api.nvim_win_set_cursor(0, { row, #content })
      vim.cmd 'startinsert!'
      return
    end

    if mode == 'o' then
      local content = padding .. marker .. ' '
      vim.api.nvim_buf_set_lines(0, row, row, false, { content })
      vim.api.nvim_win_set_cursor(0, { row + 1, #content })
      vim.cmd 'startinsert!'
      return
    end

    if mode == 'cr' then
      -- If cursor is to the left of the very first comment, do standard Enter
      if col < (first_pos - 1) then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
        return
      end

      local before = line:sub(1, col):gsub('%s*$', '')
      local after = line:sub(col + 1):gsub('^%s*', '')
      local new_line_content

      if after == '' then
        -- Cursor at end of line: just add new aligned comment
        new_line_content = padding .. marker .. ' '
      else
        -- Check if 'after' already starts with a comment marker
        local starts_with_marker = false
        for _, p in ipairs(patterns) do
          if after:find('^' .. p) then
            starts_with_marker = true
            break
          end
        end

        if starts_with_marker then
          new_line_content = padding .. after
        else
          new_line_content = padding .. marker .. ' ' .. after
        end
      end

      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { before, new_line_content })
      vim.api.nvim_win_set_cursor(0, { row + 1, #padding + #marker + 1 })
      vim.cmd 'startinsert!'
    end
  end)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'solidity',
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set('n', 'o', function()
      handle_smart_comment 'o'
    end, opts)
    vim.keymap.set('n', 'S', function()
      handle_smart_comment 'S'
    end, opts)
    vim.keymap.set('i', '<CR>', function()
      handle_smart_comment 'cr'
    end, opts)
  end,
})
