-- ============================================================================
-- UI ENHANCEMENTS
-- ============================================================================

return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons", "ahmedkhalf/project.nvim" },
        config = function()
            local alpha = require("alpha")

            -- Custom layout
            local header = {
                type = "text",
                val = {
                    "                                                     ",
                    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                    "                                                     ",
                },
                opts = {
                    position = "center",
                    hl = "Type",
                },
            }

            -- Function to get recent projects
            local function get_recent_projects()
                local history = require("project_nvim").get_recent_projects()
                local max_projects = 9
                local buttons = {}

                for i, project in ipairs(history) do
                    if i > max_projects then break end
                    if vim.fn.isdirectory(project) ~= 1 then goto continue end

                    -- Get just the folder name for display
                    local folder_name = vim.fn.fnamemodify(project, ":t")
                    local display = string.format("%d  %s", i, folder_name)

                    -- Create button
                    local button = {
                        type = "button",
                        val = display,
                        on_press = function()
                            vim.cmd("cd " .. project)
                            vim.cmd("Alpha")
                            vim.defer_fn(function()
                                require("neo-tree.command").execute({
                                    source = "filesystem",
                                    reveal = true,
                                })
                            end, 10)
                        end,
                        opts = {
                            position = "center",
                            shortcut = tostring(i),
                            cursor = 3,
                            width = 50,
                            align_shortcut = "right",
                            hl_shortcut = "Keyword",
                            hl = "String",
                        },
                    }

                    -- Set up keymap
                    vim.keymap.set("n", tostring(i), button.on_press, { buffer = true })

                    table.insert(buttons, button)

                    ::continue::
                end

                return buttons
            end

            local projects_section = {
                type = "group",
                val = function()
                    return get_recent_projects()
                end,
                opts = {
                    spacing = 1,
                },
            }

            -- Footer with "open project" option
            local footer = {
                type = "text",
                val = "Press 'o' to open project  •  'q' to quit",
                opts = {
                    position = "center",
                    hl = "Comment",
                },
            }

            local layout = {
                { type = "padding", val = 2 },
                header,
                { type = "padding", val = 2 },
                projects_section,
                { type = "padding", val = 2 },
                footer,
            }

            alpha.setup({
                layout = layout,
                opts = {
                    margin = 5,
                },
            })

            -- Disable folding on alpha buffer and add keymaps
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "alpha",
                callback = function()
                    vim.opt_local.foldenable = false

                    local buf = vim.api.nvim_get_current_buf()

                    -- Open project keymap
                    vim.keymap.set("n", "o", function()
                        require("telescope").extensions.file_browser.file_browser({
                            prompt_title = "Select Project Directory (Enter=Navigate, Ctrl-o=Open)",
                            cwd = vim.fn.expand("~"),
                            respect_gitignore = false,
                            hidden = true,
                            dir_icon = "",
                            display_stat = false,
                            attach_mappings = function(prompt_bufnr, map)
                                local actions = require("telescope.actions")
                                local action_state = require("telescope.actions.state")

                                -- Keep default Enter behavior (navigate into folders)
                                -- Add custom key to actually select the directory
                                local select_and_open = function()
                                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                                    local path = current_picker.finder.path

                                    actions.close(prompt_bufnr)

                                    -- Check if directory
                                    if vim.fn.isdirectory(path) == 1 then
                                        vim.cmd("cd " .. path)
                                        vim.cmd("Alpha")
                                        vim.defer_fn(function()
                                            require("neo-tree.command").execute({
                                                source = "filesystem",
                                                reveal = true,
                                            })
                                        end, 10)
                                    else
                                        vim.notify("Not a valid directory: " .. path, vim.log.levels.ERROR)
                                    end
                                end

                                map("i", "<C-o>", select_and_open)
                                map("n", "<C-o>", select_and_open)

                                return true
                            end,
                        })
                    end, { buffer = buf, desc = "Open project" })

                    -- Quit keymap
                    vim.keymap.set("n", "q", ":qa<CR>", { buffer = buf, desc = "Quit" })
                end,
            })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- 0: just filename, 1: relative path, 2: absolute path
                        },
                    },
                    lualine_x = { "filetype" },
                    lualine_y = { "diagnostics" },
                    lualine_z = {},
                },
            })
        end,
    },

    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("scrollbar").setup({
                show_in_active_only = false,
                hide_if_all_visible = true,
                throttle_ms = 100,
                handle = {
                    color = "#51576d",
                },
                marks = {
                    Search = { color = "#f9e2af" },
                    Error = { color = "#f38ba8" },
                    Warn = { color = "#fab387" },
                    Info = { color = "#89b4fa" },
                    Hint = { color = "#94e2d5" },
                    Misc = { color = "#cba6f7" },
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    search = false,
                },
                excluded_filetypes = {
                    "neo-tree",
                    "lazy",
                    "TelescopePrompt",
                },
            })
        end,
    },
}
