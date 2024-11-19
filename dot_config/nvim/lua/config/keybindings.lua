local wk = require("which-key")
local telescope = require("telescope.builtin")

wk.add({
  -- formatting
  { "<leader>F",  "<cmd>Format<cr>",                                                          desc = "format via formatters" },
  -- lsp
  { "<space>f",   telescope.find_files,                                                       desc = "find files" },
  { "<space>g",   telescope.live_grep,                                                        desc = "live grep" },
  { "<space>b",   telescope.buffers,                                                          desc = "buffers" },
  { "<space>B",   function() require("telescope").extensions.file_browser.file_browser() end, desc = "file browser" },
  { "<leader>p",  function() require("precognition").toggle() end,                            desc = "precognition toggle" },
  { "<leader>t",  "<cmd>Lspsaga peek_type_definition<cr>",                                    desc = "peek type definition" },
  { "<leader>T",  "<cmd>Lspsaga goto_type_definition<cr>",                                    desc = "goto type definition" },
  { "<leader>d",  "<cmd>Lspsaga peek_definition<cr>",                                         desc = "peek definition" },
  { "<leader>D",  "<cmd>Lspsaga goto_definition<cr>",                                         desc = "goto definition" },
  { "<leader>f",  vim.lsp.buf.format,                                                         desc = "format via lsp" },
  -- trouble
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                                      desc = "Diagnostics (Trouble)" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                         desc = "Buffer Diagnostics (Trouble)" },
  { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                              desc = "Symbols (Trouble)" },
  { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",               desc = "LSP Definitions / references / ... (Trouble)" },
  { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                                          desc = "Location List (Trouble)" },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                                           desc = "Quickfix List (Trouble)" },
  -- codecompanion keybindings
  -- codecompanion keybindings
  { "<leader>ca", "<cmd>CodeCompanionActions<cr>",                                            mode = { "n", "v" },                                  noremap = true, silent = true },
  { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>",                                        mode = { "n", "v" },                                  noremap = true, silent = true },
})


vim.cmd([[cab cc CodeCompanion]])
