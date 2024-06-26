local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

return {
    print "got here",
    sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.black,
    },
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds {
                group = augroup,
                buffer = bufnr,
            }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { bufnr = bufnr }
                end,
            })
        else
            print "client doesn't support formatting"
        end
    end,
}
