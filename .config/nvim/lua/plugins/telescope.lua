return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {}, -- Automatically calls require("telescope").setup({})
    config = function(_, opts)
      require("telescope").setup(opts)

      local pickers = require("telescope.builtin")

      vim.keymap.set("n", "<leader>fp", pickers.builtin, { desc = "[F]ind Builtin [P]ickers" })
      vim.keymap.set("n", "<leader>fb", pickers.buffers, { desc = "[F]ind [B]uffers" })
      vim.keymap.set("n", "<leader>ff", pickers.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fw", pickers.grep_string, { desc = "[F]ind Current [W]ord" })
      vim.keymap.set("n", "<leader>fg", pickers.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fr", pickers.oldfiles, { desc = "[F]ind [R]ecent" })
      vim.keymap.set("n", "<leader>fk", require("telescope.builtin").pickers, { desc = "[F]ind [K]ached Pickers" })

      vim.keymap.set("n", "<leader>fds", function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = { "Function", "Method", "Class", "Interface", "Struct" },
          symbol_width = 40,
          symbol_type_width = 15,
          show_line = false,
          layout_strategy = "horizontal",
        })
      end, { desc = "[F]ind [D]ocument [S]ymbols" })

      vim.keymap.set("n", "<leader>fh", pickers.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fm", pickers.man_pages, { desc = "[F]ind [M]anuals" })
    end,
  },
}
