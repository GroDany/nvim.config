-- The Native Plugin Manifest
-- Neovim will clone these if they are missing.

vim.pack.add({
    -- Libraries
    "https://github.com/nvim-lua/plenary.nvim",

    -- Theme
    "https://github.com/thimc/gruber-darker.nvim",

    -- Treesitter & Syntax
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/tpope/vim-sleuth",
    "https://github.com/folke/todo-comments.nvim",

    -- LSP & Autoformat
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/saghen/blink.cmp", 

    -- Utilities
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/echasnovski/mini.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
})

-- Load Configurations
-- We wrap these in pcall to prevent errors during the very first install
-- (before the plugins are actually on disk).
pcall(require, "plugins.theme")
pcall(require, "plugins.treesitter")
pcall(require, "plugins.lsp")
pcall(require, "plugins.utils")

-- Update command shortcut
vim.keymap.set("n", "<leader>pu", function() 
    vim.pack.update() 
    print("Plugins updated! Restart Neovim.")
end, { desc = "Update Plugins" })
