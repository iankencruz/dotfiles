vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Easy Helpers for Window & Splits
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Window: Split Horizontal (s)" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window: Split Vertical (v)" })

-- Revim.keymap.set window closing and other actions
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Window: Close Current (q)" })
vim.keymap.set("n", "<leader>wc", "<C-w>w", { desc = "Window: Cycle (w)" })

-- Indenting
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
