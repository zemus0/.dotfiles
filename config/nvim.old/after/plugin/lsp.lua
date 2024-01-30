local lsp = require('lsp-zero')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',

        -- python
        'pyright',
        -- 'black',

        --Cpp
        'clangd',
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        -- gdscript = function()
        -- require('lspconfig').gdscript.setup {
        --     root_dir = require('lspconfig').util.root_pattern(".godot", "project.godot", ".git"),
        --     on_attach = function(client, bufnr)
        --         local opts = { buffer = bufnr, remap = false }
        --         vim.bo.expandtab = false
        --         -- vim.bo.foldmethod = expr
        --         vim.keymap.set({ "n", "i" }, "<F4>", "<Cmd>GodotRunLast<CR>", opts)
        --         vim.keymap.set({ "n", "i" }, "<F5>", "<Cmd>GodotRun<CR>", opts)
        --         vim.keymap.set({ "n", "i" }, "<F6>", "<Cmd>GodotRunCurrent<CR>", opts)
        --         vim.keymap.set({ "n", "i" }, "<F7>", "<Cmd>GodotRunFZF<CR>", opts)
        --     end
        -- }
        -- end
    }
})

lsp.preset({
    manage_nvim_cmp = {
        set_sources = 'recommended'
    }
})

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

vim.keymap.set("n", "<leader>dv", function() vim.diagnostic.open_float() end);
vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end);
vim.keymap.set("n", "<leader>dN", function() vim.diagnostic.goto_prev() end);
vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end);
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end);
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end);
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format() end);
vim.keymap.set({ "n", "i" }, "<A-i>", function() vim.lsp.buf.hover() end);
vim.keymap.set({ "n", "i" }, "<A-o>", function() vim.lsp.buf.references() end);
-- vim.keymap.set("i", "<A-p>", function() vim.lsp.buf.signature_help() end);

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['null-ls'] = { 'python' },
    }
})


lsp.on_attach(function(client, bufnr)
    -- lsp.default_keymaps({ buffer = bufnr })
    -- local opts = { buffer = bufnr, remap = false }
    lsp.buffer_autoformat()
end)

lsp.setup({
    mappings = {},
})

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
    }
})

local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()
local cmp_buffer = require("cmp_buffer")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.confirm()
            else
                cmp.complete()
            end
        end),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    -- sorting = {
    --     comparators = {
    --         function(...) return cmp_buffer:compare_locality(...) end,
    --     }
    -- }
})
