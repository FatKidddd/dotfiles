local cxx = vim.env.CXX
if not cxx or cxx == '' then
  cxx = 'g++-14'
end

-- Competitive programming loads only for C++ buffers or CompetiTest commands.
return {
  'xeluxee/competitest.nvim',
  ft = 'cpp',
  cmd = 'CompetiTest',
  dependencies = 'MunifTanjim/nui.nvim',
  keys = {
    { '<M-k>', '<cmd>!rm testcases/%<_input*.txt testcases/%<_output*.txt<CR>', ft = 'cpp', desc = 'CP: Remove testcases' },
    { '<M-a>', '<cmd>CompetiTest receive testcases<CR>', ft = 'cpp', desc = 'CP: Receive testcases' },
    { '<M-r>', '<cmd>CompetiTest run<CR>', ft = 'cpp', desc = 'CP: Run testcases' },
    {
      '<M-R>',
      string.format(
        '<cmd>silent !tmux send-keys -t bottom "%s -std=c++23 -Wshadow -Wextra -Wall -fsanitize=address -fsanitize=undefined -D_GLIBCXX_ASSERTIONS -D_GLIBCXX_DEBUG -ggdb3 -o bin/%%< %% && bin/%%<" C-m<CR>',
        cxx
      ),
      ft = 'cpp',
      desc = 'CP: Compile and run in tmux (interactive)',
    },
  },
  config = function()
    require('competitest').setup {
      testcases_directory = 'testcases',
      running_directory = 'bin',
      compile_command = {
        cpp = {
          exec = cxx,
          args = {
            '-std=c++23',
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
}
