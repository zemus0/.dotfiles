return {
  'stevearc/vim-arduino',
  dependencies = {
    'jpalardy/vim-slime',
  },
  config = function()
    vim.g.arduino_use_slime = 1
    vim.keymap.set('n', '<leader>au', '<cmd>ArduinoUpload<CR>', { desc = 'Upload to arduino board' })
  end,
}
