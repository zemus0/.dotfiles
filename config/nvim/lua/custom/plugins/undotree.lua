return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undo tree' })
    vim.keymap.set('n', '<leader>U', '1<C-w>w<CR>', { desc = 'Jump to undo tree' })
  end,
}
