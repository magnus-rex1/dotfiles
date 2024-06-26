return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- require("core.utils").load_mappings("dap")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },

    {
        "nvim-lua/plenary.nvim",
        -- event = "VeryLazy",
        opts = {},
        config = function()
            --
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require("null-ls").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        -- opts = function()
        --   return require "configs.null-ls"
        -- end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "html-lsp",
                "css-lsp",
                "prettier",
                "clangd",
                "clang-format",
                "codelldb",
                "black",
                "pyright",
            },
        },
    },

    { -- This plugin
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        opts = {},
    },
    { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
            },
        },
    },
    --
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
            },
        },
    },

    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup {}
        end,
    },

    {
        "echasnovski/mini.animate",
        recommended = true,
        event = "VeryLazy",
        opts = function()
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs { "Up", "Down" } do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({ "", "i" }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            local animate = require "mini.animate"
            return {
                resize = {
                    timing = animate.gen_timing.linear { duration = 50, unit = "total" },
                },
                scroll = {
                    timing = animate.gen_timing.linear { duration = 150, unit = "total" },
                    subscroll = animate.gen_subscroll.equal {
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    },
                },
            }
        end,
    },
    -- {
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     enabled = true,
    --     init = false,
    --     opts = function()
    --         local dashboard = require "alpha.themes.dashboard"
    --         local logo = [[
    --      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
    --      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
    --      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
    --      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
    --      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
    --      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    -- ]]
    --
    --         dashboard.section.header.val = vim.split(logo, "\n")
    -- -- stylua: ignore
    -- dashboard.section.buttons.val = {
    --   dashboard.button("f", " " .. " Find file",       LazyVim.pick()),
    --   dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
    --   dashboard.button("r", " " .. " Recent files",    LazyVim.pick("oldfiles")),
    --   dashboard.button("g", " " .. " Find text",       LazyVim.pick("live_grep")),
    --   dashboard.button("c", " " .. " Config",          LazyVim.pick.config_files()),
    --   dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
    --   dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
    --   dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
    --   dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
    -- }
    --         for _, button in ipairs(dashboard.section.buttons.val) do
    --             button.opts.hl = "AlphaButtons"
    --             button.opts.hl_shortcut = "AlphaShortcut"
    --         end
    --         dashboard.section.header.opts.hl = "AlphaHeader"
    --         dashboard.section.buttons.opts.hl = "AlphaButtons"
    --         dashboard.section.footer.opts.hl = "AlphaFooter"
    --         dashboard.opts.layout[1].val = 8
    --         return dashboard
    --     end,
    --     config = function(_, dashboard)
    --         -- close Lazy and re-open when the dashboard is ready
    --         if vim.o.filetype == "lazy" then
    --             vim.cmd.close()
    --             vim.api.nvim_create_autocmd("User", {
    --                 once = true,
    --                 pattern = "AlphaReady",
    --                 callback = function()
    --                     require("lazy").show()
    --                 end,
    --             })
    --         end
    --
    --         require("alpha").setup(dashboard.opts)
    --
    --         vim.api.nvim_create_autocmd("User", {
    --             once = true,
    --             pattern = "LazyVimStarted",
    --             callback = function()
    --                 local stats = require("lazy").stats()
    --                 local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    --                 dashboard.section.footer.val = "⚡ Neovim loaded "
    --                     .. stats.loaded
    --                     .. "/"
    --                     .. stats.count
    --                     .. " plugins in "
    --                     .. ms
    --                     .. "ms"
    --                 pcall(vim.cmd.AlphaRedraw)
    --             end,
    --         })
    --     end,
    -- },
}
