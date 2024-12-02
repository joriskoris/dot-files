require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostic (Trouble)" })
map("n", "<leader>dX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics (Trouble)" })
map("n", "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list (Trouble)" })
map("n", "<leader>pc", function()
  if require("precognition").toggle() then
    vim.notify "precognition on"
  else
    vim.notify "precognition off"
  end
end, { desc = "Precognition toggle " })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
