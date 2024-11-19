return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "python", "typescript", "javascript" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      syntax = { enable = true },
    },
    config = function(LazyPlugin, opts)
      local configs = require("nvim-treesitter.configs")

      configs.setup(opts)

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end
  }
}
