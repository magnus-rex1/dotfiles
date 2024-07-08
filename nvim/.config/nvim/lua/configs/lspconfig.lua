-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    }
end

-- typescript
lspconfig.tsserver.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
}

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}

lspconfig.intelephense.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        filetypes = { "php", "blade" },
        files = {
            associations = { "*.php", "*.blade.php" },
        },
    },
}

lspconfig.stimulus_ls.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "stimulus-language-server", "--stdio" },
    filetypes = { "html", "ruby", "eruby", "blade", "php", ".blade.php" },
    root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
}

lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "clojure",
        "django-html",
        "htmldjango",
        "edge",
        "eelixir",
        "elixir",
        "ejs",
        "erb",
        "eruby",
        "gohtml",
        "gohtmltmpl",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "html-eex",
        "heex",
        "jade",
        "leaf",
        "liquid",
        "markdown",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "slim",
        "twig",
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        "sugarss",
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "templ",
    },
    init_options = {
        userLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            templ = "html",
        },
    },
    settings = {
        tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            validate = true,
        },
    },
    root_dir = lspconfig.util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "postcss.config.mjs",
        "postcss.config.ts",
        "package.json",
        "node_modules",
        ".git"
    ),
}
