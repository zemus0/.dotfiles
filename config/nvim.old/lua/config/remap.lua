vim.keymap.set("n", "<leader>vd", vim.cmd.Ex)

-- remove keys
vim.keymap.set("n", "J", "<Nop>")
vim.keymap.set("n", "Q", "<Nop>")

-- movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("i", "<C-b>", "<C-o>0")
vim.keymap.set("i", "<C-e>", "<C-o>$")

-- vim.keymap.set("i", "<C-k>", "<Up>")
-- vim.keymap.set("i", "<C-j>", "<Down>")
-- vim.keymap.set("i", "<C-h>", "<Left>")
-- vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set("n", "<C-A-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-A-l>", "<cmd> TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-A-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-A-k>", "<cmd> TmuxNavigateUp<CR>")

vim.keymap.set("n", "<A-S-k>", "kzz")
vim.keymap.set("n", "<A-S-j>", "jzz")

vim.keymap.set({ "n" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l")

-- move lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "d")
vim.keymap.set({ "n", "v" }, "d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>s", [[<Esc>:'<,'>s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>chx", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("i", "<A-p>", "<C-o>p")

-- split buffers
vim.keymap.set("n", "<leader>bh", ':vsplit<CR>')
vim.keymap.set("n", "<leader>bv", ':split<CR>')

vim.keymap.set("n", "<leader>b=", '<C-w>=')
vim.keymap.set("n", "<leader>bz", ':tabedit %<CR>')
-- vim.keymap.set("n", "<C-A-h>", '<C-w><')
-- vim.keymap.set("n", "<C-A-j>", '<C-w>-')
-- vim.keymap.set("n", "<C-A-k>", '<C-w>+')
-- vim.keymap.set("n", "<C-A-l>", '<C-w>>')

-- multiline editing with visual line
vim.keymap.set("x", "I", function ()
    if vim.fn.mode() == 'V' then return "0<C-v>I" end
    return "I"
end, {expr = true})

vim.keymap.set("x", "A", function ()
    if vim.fn.mode() == 'V' then return "$<C-v>A" end
    return "A"
end, {expr = true})

-- terminal
-- vim.keymap.set("t", "<C-x>", '<C-\\><C-N>')
-- vim.keymap.set("n", "<leader>th", ':split<CR>:terminal<CR>')
-- vim.keymap.set("n", "<leader>tv", ':vsplit<CR>:terminal<CR>')

