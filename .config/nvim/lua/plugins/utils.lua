return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    opts = {}, -- Automatically calls require("nvim-autopairs").setup({})
  },

  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}, -- Automatically calls require("todo-comments").setup({})
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>lg", "<CMD>LazyGit<CR>", { desc = "Open LazyGit" })
    end,
  },
}
