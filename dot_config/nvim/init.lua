local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- sidebar
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",

  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },

  -- plugins by folke
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  "folke/neodev.nvim",
  "folke/neoconf.nvim",
  "folke/trouble.nvim",

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- all the cool shiet
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  -- AI
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
}

require("lazy").setup(plugins)

vim.g.mapleader = ";"

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.smarttab = true

-- theme
vim.cmd.colorscheme "catppuccin-frappe"

-- sidebar
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({})
--
-- folke
require("neodev").setup({})
require("neoconf").setup({})
require("trouble").setup({})

-- treesitter
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

-- lsp
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "copilot" },
    { name = "luasnip" },
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  }),
})


-- mason
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup({})
require("mason-lspconfig").setup({})
require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities
    })
  end,
})

-- telescope
require("telescope").setup({})

-- keybindings
local telescope = require("telescope.builtin")
local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    q = { "<cmd>cclose<cr>", "quickfix close" },
  },
  ["<leader>t"] = {
    name = "+NvimTree",
    t = { "<cmd>NvimTreeToggle<cr>", "NvimTreeToggle" },
    f = { "<cmd>NvimTreeFocus<cr>", "NvimTreeFocus" },
    r = { "<cmd>NvimTreeRefresh<cr>", "NvimTreeRefresh" }
  },
  ["<leader>x"] = {
    name = "+Trouble",
    x = { "<cmd>TroubleToggle<cr>", "TroubleToggle" },
    c = { "<cmd>TroubleClose<cr>", "TroubleClose" },
    r = { "<cmd>TroubleRefresh<cr>", "TroubleRefresh" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "TroubleToggle workspace_diagnostics" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "TroubleToggle document_diagnostics" },
  },
  ["<leader>f"] = {
    name = "+Telescope",
    f = { telescope.find_files, "Find Files" },
    g = { telescope.live_grep, "Grep" },
    b = { telescope.buffers, "Buffers" },
    h = { telescope.help_tags, "Help Tags" },
    d = { telescope.diagnostics, "Diagnostics" },
    t = { telescope.treesitter, "Treesitter" },
  },
  ["<leader>c"] = {
    name = "+Copilot",
    t = { function()
      vim.cmd("Copilot toggle")
      vim.cmd("Copilot status")
    end, "toggle" },
    p = { "<cmd>Copilot panel<cr>", "panel" },
    s = { function()
      require("copilot.suggestion").toggle_auto_trigger()
    end, "toggle_auto_trigger" }
  },
  ["<space>"] = {
    name = "+Lspsaga",
    d = { "<cmd>Lspsaga peek_definition<cr>", "Lspsaga peek_definition" },
    t = { "<cmd>Lspsaga peek_type_definition<cr>", "Lspsaga peek_type_definition" },
    gd = { "<cmd>Lspsaga goto_definition<cr>", "Lspsaga goto_definition" },
    gt = { "<cmd>Lspsaga goto_type_definition<cr>", "Lspsaga goto_type_definition" },
    a = { "<cmd>Lspsaga code_action<cr>", "Lspsaga code_action" },
    k = { "<cmd>Lspsaga hover_doc<cr>", "Lspsaga hover_doc" },
    f = { function()
      vim.lsp.buf.format({ async = true })
    end, "format" },
  }
})
