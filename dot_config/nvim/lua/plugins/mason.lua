return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "ruff" },
      automatic_installation = true,
    },
    config = function(LazyPlugin, opts)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers{
        function (server_name)
          require("lspconfig")[server_name].setup{
            capabilities = capabilities,
          }
        end
      }
    end,
  },
}
