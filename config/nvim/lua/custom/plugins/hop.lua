return {
  'smoka7/hop.nvim',
  version = '2.6.x',
  config = function()
    local hop = require 'hop'
    hop.setup { keys = 'etovxqpdygfblzhckisuran' }
    local directions = require('hop.hint').HintDirection
    vim.keymap.set({ 'n', 'x' }, 'f', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR }
    end, { remap = true })
    vim.keymap.set({ 'n', 'x' }, 'F', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR }
    end, { remap = true })
    vim.keymap.set({ 'n', 'x' }, 't', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, hint_offset = -1 }
    end, { remap = true })
    vim.keymap.set({ 'n', 'x' }, 'T', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, hint_offset = 1 }
    end, { remap = true })
  end,
}
