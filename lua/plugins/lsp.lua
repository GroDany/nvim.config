-- 1. Setup Blink Completion
require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

-- 2. Native LSP Setup (0.12)
-- Note: We use lspconfig for the configurations, but native calls to enable them.

-- C# (Omnisharp)
vim.lsp.config("omnisharp", {
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
})
vim.lsp.enable("omnisharp")

-- C / C++ (Clangd)
vim.lsp.config("clangd", { cmd = { "clangd" } })
vim.lsp.enable("clangd")

-- Godot (GDScript)
vim.lsp.config("gdscript", {
    cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
})
vim.lsp.enable("gdscript")

-- Lua
vim.lsp.config("lua_ls", {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.enable("lua_ls")

-- 3. Autoformatting
require("conform").setup({
    notify_on_error = false,
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    formatters_by_ft = {
        lua = { 'stylua' },
        c_sharp = { 'csharpier' },
    },
})

-- 4. Keymaps (LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", vim.lsp.buf.references, "Goto References")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
    end,
})
