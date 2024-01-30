vim.keymap.set("n", "<leader>qs", function() vim.api.nvim_feedkeys("ysiw", "t", false) end)
vim.keymap.set("v", "<leader>qs", function() vim.api.nvim_feedkeys("S", "t", false) end)
vim.keymap.set("n", "<leader>qd", function() vim.api.nvim_feedkeys("ds", "t", false) end)
vim.keymap.set("n", "<leader>qr", function() vim.api.nvim_feedkeys("cs", "t", false) end)
