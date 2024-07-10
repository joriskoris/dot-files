return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "python" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function (LazyPlugin, opts)
      local configs = require("nvim-treesitter.configs")

      configs.setup(opts)
    end
  }
}
