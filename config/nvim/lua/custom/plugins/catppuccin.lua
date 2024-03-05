return {
  'catppuccin/nvim',
  priority = 1000,
  name = 'catppuccin',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.cmd [[colorscheme catppuccin-macchiato]]
  end,
}
