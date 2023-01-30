require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "ﯩ",
            package_uninstalled = "󰯇"
        }
    }
})

require("mason-lspconfig").setup()
