return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      sync_install = true,
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "lua",
        "c",
        "rust",
        "go",
        "html",
        "typescript",
        "svelte",
        "zig"
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").update("all")
      require("nvim-treesitter").setup(opts)
    end,
  },
  {
    "romus204/tree-sitter-manager.nvim",
    opts = {}, -- Automatically calls require("tree-sitter-manager").setup({})
  },
}
