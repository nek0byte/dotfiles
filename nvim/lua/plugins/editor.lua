return {
    {
        enabled = false,
        "folke/flash.nvim",
        ---@type Flash.Config
        opts = {
            search = {
                forward = true,
                multi_window = false,
                wrap = false,
                incremental = true,
            },
        },
    },

    {
        "brenoprata10/nvim-highlight-colors",
        event = "BufReadPre",
        opts = {
            render = "background",
            enable_hex = true,
            enable_short_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_hsl_without_function = true,
            enable_ansi = true,
            enable_var_usage = true,
            enable_tailwind = true,
        },
    },

    {
        "dinhhuy258/git.nvim",
        event = "BufReadPre",
        opts = {
            keymaps = {
                -- Open blame window
                blame = "<Leader>gb",
                -- Open file/folder in git repository
                browse = "<Leader>go",
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        keys = {
            {
                "<leader>fP",
                function()
                    require("telescope.builtin").find_files({
                        cwd = require("lazy.core.config").options.root,
                    })
                end,
                desc = "Find Plugin File",
            },
            {
                ";f",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.find_files({
                        no_ignore = false,
                        hidden = true,
                    })
                end,
                desc = "Lists files in your current working directory, respects .gitignore",
            },
            {
                ";r",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.live_grep({
                        additional_args = { "--hidden" },
                    })
                end,
                desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
            },
            {
                "\\\\",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.buffers()
                end,
                desc = "Lists open buffers",
            },
            {
                ";t",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.help_tags()
                end,
                desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
            },
            {
                ";;",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.resume()
                end,
                desc = "Resume the previous telescope picker",
            },
            {
                ";e",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.diagnostics()
                end,
                desc = "Lists Diagnostics for all open buffers or a specific buffer",
            },
            {
                ";s",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.treesitter()
                end,
                desc = "Lists Function names, variables, from Treesitter",
            },
            {
                ";c",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.lsp_incoming_calls()
                end,
                desc = "Lists LSP incoming calls for word under the cursor",
            },
            {
                "sf",
                function()
                    local telescope = require("telescope")

                    local function telescope_buffer_dir()
                        return vim.fn.expand("%:p:h")
                    end

                    telescope.extensions.file_browser.file_browser({
                        path = "%:p:h",
                        cwd = telescope_buffer_dir(),
                        respect_gitignore = false,
                        hidden = true,
                        grouped = true,
                        previewer = false,
                        initial_mode = "normal",
                        layout_config = { height = 40 },
                    })
                end,
                desc = "Open File Browser with the path of the current buffer",
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local fb_actions = require("telescope").extensions.file_browser.actions

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
                wrap_results = true,
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
                mappings = {
                    n = {},
                },
            })
            opts.pickers = {
                diagnostics = {
                    theme = "ivy",
                    initial_mode = "normal",
                    layout_config = {
                        preview_cutoff = 9999,
                    },
                },
            }
            opts.extensions = {
                file_browser = {
                    theme = "dropdown",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    hidden = true,
                    mappings = {
                        -- your custom insert mode mappings
                        ["n"] = {
                            -- your custom normal mode mappings
                            ["N"] = fb_actions.create,
                            ["h"] = fb_actions.goto_parent_dir,
                            ["/"] = function()
                                vim.cmd("startinsert")
                            end,
                            ["<C-u>"] = function(prompt_bufnr)
                                for i = 1, 10 do
                                    actions.move_selection_previous(prompt_bufnr)
                                end
                            end,
                            ["<C-d>"] = function(prompt_bufnr)
                                for i = 1, 10 do
                                    actions.move_selection_next(prompt_bufnr)
                                end
                            end,
                            ["<PageUp>"] = actions.preview_scrolling_up,
                            ["<PageDown>"] = actions.preview_scrolling_down,
                        },
                    },
                },
            }
            telescope.setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
        end,
    },

    {
        "kazhala/close-buffers.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>th",
                function()
                    require("close_buffers").delete({ type = "hidden" })
                end,
                desc = "Close Hidden Buffers",
            },
            {
                "<leader>tu",
                function()
                    require("close_buffers").delete({ type = "nameless" })
                end,
                desc = "Close Nameless Buffers",
            },
        },
    },

    {
        "saghen/blink.cmp",
        opts = {
            completion = {
                menu = {
                    winblend = vim.o.pumblend,
                },
            },
            signature = {
                window = {
                    winblend = vim.o.pumblend,
                },
            },
        },
    },

    {
        "karb94/neoscroll.nvim",
        opts = {
            mappings = {
                "<C-u>",
                "<C-d>",
                "<C-b>",
                "<C-f>",
                "<C-y>",
                "<C-e>",
                "zt",
                "zz",
                "zb",
            },
            hide_cursor = true,
            stop_eof = true,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            duration_multiplier = 1.0,
            easing = "linear",
            pre_hook = nil,
            post_hook = nil,
            performance_mode = false,
            ignore_events = {
                "WinScrolled",
                "CursorMoved",
            },
        },
    },

    {
        "nvim-mini/mini.animate",
        version = "*",
        opts = function()
            local animate = require("mini.animate")
            local mouse_scrolled = false
            for _, scroll in ipairs({ "Up", "Down" }) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({ "", "i" }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end
            return {
                cursor = {
                    enable = true,
                    timing = animate.gen_timing.quadratic({ easing = "in-out", duration = 200, unit = "total" }),
                    path = animate.gen_path.line({
                        predicate = function()
                            return true
                        end,
                    }),
                },
                scroll = {
                    enable = true,
                    timing = animate.gen_timing.quadratic({ easing = "in-out", duration = 150, unit = "total" }),
                    subscroll = animate.gen_subscroll.equal({
                        max_output_steps = 200,
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    }),
                },
                resize = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
                },
                open = {
                    enable = true,
                    timing = animate.gen_timing.quadratic({ easing = "in-out", duration = 200, unit = "total" }),
                    winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
                    winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
                },
                close = {
                    enable = true,
                    timing = animate.gen_timing.quadratic({ easing = "in-out", duration = 0, unit = "total" }),
                    winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
                    winblend = animate.gen_winblend.linear({ from = 100, to = 80 }),
                },
            }
        end,
    },
}
