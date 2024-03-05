-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to clipboard' })

-- Ctrl + s = save
vim.keymap.set({ 'i', 'v', 'n' }, '<C-s>', '<cmd>:w %<CR>')

-- Don't replace buffer when delete
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])
vim.keymap.set({ 'n', 'v' }, 'x', [["_x]])

-- Do replace buffer
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd')
vim.keymap.set({ 'n', 'v' }, '<leader>x', 'x')

-- Full screen a buffer
vim.keymap.set('n', '<C-W>z', ':tabedit %<CR>', { desc = 'Expand the current buffer to be fullscreen' })
--
-- Move to end or start in insert mode
vim.keymap.set('i', '<C-b>', '<C-o>0')
vim.keymap.set('i', '<C-e>', '<C-o>$')

-- Make current script executable
vim.keymap.set('n', '<leader>chx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make the current script executable' })

-- Tab indent
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace word under cursor' })
vim.keymap.set('x', '<leader>sr', [[<Esc>:'<,'>s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace in selected range' })
vim.keymap.set('x', '<leader>sw', [["ay:%s/\<<C-r>a\>/<C-r>a/gI<Left><Left><Left>]], { desc = 'Search and replace selected word' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
