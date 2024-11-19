return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "zbirenbaum/copilot-cmp",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local opts = {
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            max_width = 50,
            symbol_map = { Copilot = "" }
          })
        },
        sources = {
          { name = "lazydev", group_index = 0 },
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = {
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
        }
      }

      cmp.setup(opts)

      require("copilot_cmp").setup({});
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {}
  },
  {
    "L3MON4D3/LuaSnip"
  }
}
