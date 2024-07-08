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
        -- opts = {
        --     ensure_installed = {
        --         "vim",
        --         "lua",
        --         "vimdoc",
        --         "html",
        --         "css",
        --         "blade",
        --     },
        --     highlight = {
        --         enable = true,
        --     }
        -- },
        init = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "vim",
                    "lua",
                    "vimdoc",
                    "html",
                    "css",
                },
                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = false,
                },
            }

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            }

            vim.filetype.add {
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            }
        end,
    },

    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("render-markdown").setup {}
        end,
        enabled = false,
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

    {
        "kristijanhusak/vim-dadbod-completion",
        -- opts = {},
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },

        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
        -- opts = {},
    },

    {
        "tpope/vim-dadbod",
        cmd = "DB",
        requires = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        -- opts = {},
        config = function()
            require("configs.dadbod").setup()
        end,
    },

    {
        "edluffy/hologram.nvim",
        config = function()
            require("hologram").setup() {
                auto_display = true,
            }
        end,
        -- opts = {}
    },
    -- install without yarn or npm
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = function()
    --         vim.fn["mkdp#util#install"]()
    --     end,
    --     config = function()
    --         -- vim.g.mkdp_browser = "/usr/bin/google-chrome"
    --         vim.g.mkgp_open_to_the_world =1
    --         vim.g.mkgp_open_ip = '127.0.0.1'
    --         vim.g.mkgp_port = 8080
    --         vim.g.mkdp_browser = "none"
    --         vim.g.mkgp_echo_preview_url = 1
    --     end,
    -- },

    -- install with yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkgp_open_to_the_world = 1
            vim.g.mkgp_open_ip = "127.0.0.1"
            vim.g.mkgp_port = 8080
            vim.g.mkdp_browser = "none"
            vim.g.mkgp_echo_preview_url = 1
        end,
        -- config = function()
        --     require("markdown-preview").setup() {
        --         mkdp_browder = "/usr/bin/google-chrome",
        --     }
        -- end,
        ft = { "markdown" },
    },

    -- Svelte plugins
    { "pangloss/vim-javascript" },
    { "othree/html5.vim" },

    {
        "evanleck/vim-svelte",
        dependencies = {
            "othree/html5.vim",
            "pangloss/vim-javascript",
            "evanleck/vim-svelte",
        },
    },

    {
        "jwalton512/vim-blade",
        opts = {},
    },

    {
        "ricardoramirezr/blade-nav.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp", -- if using nvim-cmp
            { "ms-jpq/coq_nvim", branch = "coq" }, -- if using coq
        },
        ft = { "blade", "php" }, -- optional, improves startup time
    },

    {
        "adalessa/laravel.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "tpope/vim-dotenv",
            "MunifTanjim/nui.nvim",
            "nvimtools/none-ls.nvim",
        },
        cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
        keys = {
            { "<leader>la", ":Laravel artisan<cr>" },
            { "<leader>lr", ":Laravel routes<cr>" },
            { "<leader>lm", ":Laravel related<cr>" },
        },
        event = { "VeryLazy" },
        config = true,
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require "notify"
            -- this for transparency
            notify.setup { background_colour = "#000000" }
            -- this overwrites the vim notify function
            vim.notify = notify.notify
        end,
    },
    -- {
    --     "haringsrob/laravel-dev-tools",
    --     opts = {},
    -- },
}
