return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}
