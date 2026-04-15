-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

return {
    {
        -- Local entry to trigger LSP setup after lazy.nvim loads
        "lsp-setup",
        dir = vim.fn.stdpath("config"),
        config = function()
            -- Lua with custom settings
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            -- YAML with OpenAPI schema support
            vim.lsp.config('yamlls', {
                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = {
                                "openapi.yaml",
                                "openapi.yml",
                                "**/openapi/**/*.yaml",
                                "**/openapi/**/*.yml",
                            },
                            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = {
                                "**/swagger/**/*.yaml",
                                "**/swagger/**/*.yml",
                            },
                        },
                        format = {
                            enable = true,
                        },
                        validate = true,
                        completion = true,
                    },
                },
            })

            -- Enable all LSP servers
            vim.lsp.enable({
                'lua_ls',
                'gopls',
                'ts_ls',
                'pyright',
                'clangd',
                'yamlls',
            })

            -- Enable built-in completion and document highlights on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- Enable built-in completion
                    vim.lsp.completion.enable(true, client.id, args.buf)

                    -- Enable document highlight (replaces vim-illuminate for LSP buffers)
                    if client:supports_method("textDocument/documentHighlight") then
                        local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. args.buf, { clear = true })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            group = group,
                            buffer = args.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            group = group,
                            buffer = args.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })
        end,
    },
}
