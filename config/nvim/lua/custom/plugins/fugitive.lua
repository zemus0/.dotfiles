return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>Dh', ':diffget //2', { desc = 'Accept code from the left buffer' })
    vim.keymap.set('n', '<leader>Dl', ':diffget //3', { desc = 'Accept code from the right buffer' })
  end,
}
