return {
  -- precognition
  {
    "tris203/precognition.nvim",
    lazy = true,
    opts = {
      startVisible = false,
      showBalnkVirtLine = false,
    },
  },
  -- theme
  {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      vim.opt.background = "light"
    end,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- motion
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    config = function()
      require("leap").create_default_mappings()
    end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
  },
  -- telescope file navigation
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    }
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  -- icons
  { "nvim-tree/nvim-web-devicons" },
  -- formmatting
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          typescript = {
            require("formatter.filetypes.typescript").prettierd,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettierd,
          }
        }
      })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    opts = {
      mkdp_auto_start = 1,
    },
    build = function()
      vim.cmd [[Lazy load markdown-preview.nvim]]
      vim.fn['mkdp#util#install']()
    end,
  },

}
