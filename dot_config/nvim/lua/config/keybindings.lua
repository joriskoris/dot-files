local wk = require("which-key")
local telescope = require("telescope.builtin")


wk.register({
  ["<leader>p"] = {
    function()
      require("precognition").toggle()
    end,
    "precognition toggle"
  },
  ["<space>"] = {
    name = "+telescope",
    f = { telescope.find_files, "find files" },
    g = { telescope.live_grep, "live grep" },
    b = { function()
      require("telescope").extensions.file_browser.file_browser()
    end, "file browser" },
  },
  ["<leader>"] = {
    t = { "<cmd>Lspsaga peek_type_definition<cr>", "peek type definition "},
    T = { "<cmd>Lspsaga goto_type_definition<cr>", "goto type definition "},
    d = { "<cmd>Lspsaga peek_definition<cr>", "peek definition "},
    D = { "<cmd>Lspsaga goto_definition<cr>", "goto definition "},
  }
})

