return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    },
  },

  -- Keybinding helper
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
      },
    },
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_close = true,
      auto_open = false,
      auto_preview = true,
      auto_jump = false,
      win = {
        type = "split",
        position = "bottom",
        size = 10,
      },
      preview = {
        type = "main",
        scratch = true,
      },
      filter = {},
    },
    config = function(_, opts)
      require("trouble").setup(opts)

      vim.keymap.set("n", "<leader>qq", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>qQ", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
        { desc = "Buffer Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>cs", "<CMD>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
      vim.keymap.set("n", "<leader>cl", "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
        { desc = "LSP Definitions / references / ... (Trouble)" })
      vim.keymap.set("n", "<leader>qL", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
      vim.keymap.set("n", "<leader>qX", "<CMD>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })
    end,
  },
}
