require('lspconfig').racket_langserver.setup {}

vim.keymap.set('n', '<leader>rr', function()
  vim.fn.system "\\tmux send-keys -t {last} ',exit' Enter"
  vim.fn.system '\\tmux send-keys -t {last} C-l'
  vim.fn.system("\\tmux send-keys -t {last} $'racket -i -e \\'(enter! (file \"" .. vim.fn.expand '%:p' .. "\"))\\'' Enter")
end, { desc = '[R]un [R]acket File' })

vim.keymap.set('n', '<leader>rt', function()
  vim.fn.system('\\tmux send-keys -t {last} \'raco test "' .. vim.fn.expand '%:p' .. '"\' Enter')
end, { desc = '[R]acket [T]est File' })
