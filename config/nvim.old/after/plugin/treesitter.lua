require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        -- web dev
        "javascript",
        "typescript",
        "html",
        "css",

        -- game dev
        "gdscript",

        -- general
        "latex",
        "rust",
        "python",

        -- requires
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query"
    },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
