-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "HydraHint" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Initialize core runtime options, hotkeys, and autocommands
require("options")
require("keymaps")
require("autocmds") -- Fixed to match your filename 'autocmds.lua'

-- Initialize plugins via lazy.nvim
require("lazy").setup({
  spec = {
    -- Automatically import all plugin specifications from the lua/plugins/ directory
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false },
})

-- Load default colorscheme
vim.cmd.colorscheme("catppuccin")

-- UI2: no more press enter
require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = "cmd",
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.5,
			timeout = 4000,
		},
		pager = {
			height = 0.5,
		},
	},
})

-- Enable built-in tools
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")
