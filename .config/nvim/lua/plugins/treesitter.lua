-- ============================================================================
-- SYNTAX HIGHLIGHTING & PARSING
-- ============================================================================
--
-- Uses the `main` branch of nvim-treesitter, which is a rewrite required for
-- Neovim 0.11+/0.12. The legacy `master` branch is incompatible with 0.12's
-- treesitter API and crashes inside query_predicates.lua.
--
-- The `main` branch only installs parsers; highlighting/indent are enabled
-- manually via the FileType autocmd below.

local parsers = {
    "bash",
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "tsx",
    "typescript",
    "yaml",
    "vim",
    "vimdoc",
    "query",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
                callback = function(args)
                    local buf = args.buf
                    local ft = vim.bo[buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft) or ft
                    if not lang or lang == "" then
                        return
                    end
                    -- Only start if a parser is available for this language.
                    local ok = pcall(vim.treesitter.start, buf, lang)
                    if ok then
                        -- Treesitter-based folding and indenting.
                        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
