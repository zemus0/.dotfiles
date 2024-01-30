vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    desc = "netrw mapping",
    callback = function()
        vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = true })
        vim.keymap.set("n", "o", "<CR>", { remap = true, buffer = true })
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    desc = "readonly mapping",
    callback = function()
        local buf = vim.api.nvim_win_get_buf(0)

        if vim.bo[buf].readonly then
            vim.keymap.set("n", "o", "<CR>", { remap = true, buffer = true })
        end
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
    buffer = 0
})
