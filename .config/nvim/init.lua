--h vim.pack- INFO: introduction
-- this is a minimal neovim configuration written in lua. this is not meant to
-- be a distribution, but rather a template for you to build upon and/or a
-- reference for how to configure neovim using lua in the latest version.
--
-- TUTOR:
-- if you're completely new to neovim and/or vim, consider going through
-- `:Tutor` inside neovim to get a basic idea of how it works.
--     if you don't know what this means, type the following:
--       - <escape key> - :
--       - Tutor
--       - <enter key>
--
-- LUA:
-- some level of familiarity with lua/programming languages are also expected.
-- if you're new to lua, consider going through the official reference:
--    https://www.lua.org/manual
-- or a more friendly tutorial like:
--    https://learnxinyminutes.com/docs/lua/
-- you can also check out `:h lua-guide` inside neovim for a neovim-specific
-- lua guide.
--
-- DEPENDENCIES:
-- this configuration assumes you have the following tools installed on your
-- system:
--    `git` - for vim builtin package manager. (see `:h vim.pack`)
--    `ripgrep` - for fuzzy finding
--    clipboard tool: xclip/xsel/win32yank - for clipboard sharing between OS and neovim (see `h: clipboard-tool`)
--    a nerdfont (ensure the terminal running neovim is using it)
-- run `:checkhealth` inside neovim to see if your system is missing anything.
--
-- MINIMAL:
-- to say that something is 'minimal' you have to define what variable you're
-- minimizing. this configuration minimizes for lines of code and concepts.
-- to some, this configuration may have too many plugins. for example, using
-- mason.nvim to manage lsp servers will be an unnecessary dependency if the
-- user is already familiar with lsps and is comfortable managing them through
-- their OS package manager. but to someone that isn't familiar with lsp servers
-- this approach wouldn't cover everything needed to have the 'minimum' necessary
-- for lsp + completion + fuzzy finding. to some, fuzzy finding is also a bloated
-- dependency.
-- this configuration is only a starting point/reference. it is expected that
-- the user will change the configuration to suit their needs.

-- INFO: options
-- these change the default neovim behaviours using the 'vim.opt' API.
-- see `:h vim.opt` for more details.
-- run `:h '{option_name}'` to see what they do and what values they can take.
-- for example, `:h 'number'` for `vim.opt.number`.

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable true color support
vim.opt.termguicolors = true

-- make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- sync clipboard between OS and Neovim.
--  remove this option if you want your OS clipboard to remain independent.
--  see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- enable break indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- enable line wrapping
vim.opt.wrap = true

-- scroll off
vim.opt.scrolloff = 15

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.o.confirm = true

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	virtual_text = true, -- show inline diagnostics
})

-- Center the screen vertically when jumping to the end of the file
-- vim.keymap.set('n', 'G', 'Gzz', { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Easy Helpers for Window & Splits
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Window: Split Horizontal (s)" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window: Split Vertical (v)" })

-- 3. Revim.keymap.set window closing and other actions
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Window: Close Current (q)" })
vim.keymap.set("n", "<leader>wc", "<C-w>w", { desc = "Window: Cycle (w)" })

-- Indenting
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"

vim.opt.foldlevel = 99 -- open all folds by default
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"

vim.opt.fillchars = {
	fold = " ", -- Removes the trailing legacy dashes on folded lines
	foldopen = "", -- Sleek down chevron (material/lucide style)
	foldclose = "", -- Sleek right chevron
	foldinner = " ", -- Keeps nested levels completely clean
}

-- INFO: autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

-- add templ as filetype
vim.filetype.add({ extension = { templ = "templ" } })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.templ",
	callback = function()
		vim.bo.filetype = "templ"
		vim.treesitter.start()
	end,
})

-- INFO: plugins
-- we install plugins with neovim's builtin package manager: vim.pack
-- and then enable/configure them by calling their setup functions.
--
-- (see `:h vim.pack` for more details on how it works)
-- you can press `gx` on any of the plugin urls below to open them in your
-- browser and check out their documentation and functionality.
-- alternatively, you can run `:h {plugin-name}` to read their documentation.
--
-- plugins are then loaded and configured with a call to `setup` functions
-- provided by each plugin. this is not a rule of neovim but rather a convention
-- followed by the community.
-- these setup calls take a table as an agument and their expected contents can
-- vary wildly. refer to each plugin's documentation for details.

-- INFO: colorscheme
vim.cmd.colorscheme("catppuccin")

-- INFO: formatting and syntax highlighting
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")

require("nvim-treesitter").setup({
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
	},

	auto_install = true, -- autoinstall languages that are not installed yet

	highlight = {
		enable = true,
	},
})

vim.pack.add({ "https://github.com/romus204/tree-sitter-manager.nvim" })

require("tree-sitter-manager").setup()

-- INFO: completion engine
vim.pack.add({
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/github/copilot.vim",
})

-- Prevent Copilot from overriding the <Tab> key so it doesn't conflict with blink
vim.g.copilot_no_tab_map = true

-- Map a distinct key combination (like Alt + l or Control + y) to accept ghost text
vim.keymap.set("i", "<M-l>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})

local cmp = require("blink.cmp")

cmp.setup({

	snippets = { preset = "default" }, -- Neovim 0.10+ native snippet engine
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	keymap = {
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback_to_mappings" },
		["<C-j>"] = { "select_next", "fallback_to_mappings" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
	},

	fuzzy = {
		implementation = "lua",
	},
	completion = {
		documentation = {
			auto_show = true,
		},
	},
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
	lua_ls = {
		-- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
		Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } },
	},
	gopls = {
		filetypes = { "go", "gomod", "templ" },
	},
	templ = {
		filetypes = { "templ" },
	},
	html = {
		filetypes = { "templ", "html", "svelte" },
	},
	ts_ls = {
		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
		},
	},
	svelte = {
		filetypes = {
			"typescript",
			"svelte",
		},
	},
}

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig", -- default configs for lsps

	-- NOTE: if you'd rather install the lsps through your OS package manager you
	-- can delete the next three mason-related lines and their setup calls below.
	-- see `:h lsp-quickstart` for more details.
	"https://github.com/mason-org/mason.nvim", -- package manager
	"https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
	vim.lsp.config(server, {
		settings = config,

		-- only create the keymaps if the server attaches successfully
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "vim.lsp.buf.definition()" })

			vim.keymap.set("n", "grf", vim.lsp.buf.format, { buffer = bufnr, desc = "vim.lsp.buf.format()" })
		end,
	})
end

--: conform
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		sleek = {
			command = "sleek",
			args = { "-U", "true", "-l", "1" },
			stdin = true,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "jq" },
		sql = { "sleek" },
		pgsql = { "sleek" },
		rust = { "rustfmt" },
		python = { "black" },
		htmldjango = { "djlint" },
		html = { "oxfmt" },
		javascript = { "oxfmt", "prettierd" },
		typescript = { "oxfmt", "prettierd" },
		go = { "goimports", "gofumpt" },
		svelte = { "oxfmt", "prettierd", "prettier" },
	},
})

-- NOTE: if all you want is lsp + completion + highlighting, you're done.
-- the rest of the lines are just quality-of-life/appearance plugins and
-- can be removed.

-- INFO: fuzzy finder
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim", -- library dependency
	"https://github.com/nvim-tree/nvim-web-devicons", -- icons (nerd font)
	"https://github.com/nvim-telescope/telescope.nvim", -- the fuzzy finder
}, { confirm = false })

require("telescope").setup({})

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
		symbols = { "Function", "Method", "Class", "Interface", "Struct" }, -- Filter for specific symbol types
		symbol_width = 40, -- Give the symbol name more horizontal space
		symbol_type_width = 15, -- Width for the type column (e.g., [Function])
		show_line = false, -- Show the line number where the symbol is found
		layout_strategy = "horizontal", -- Choose layout (horizontal, vertical, center)
	})
end, { desc = "[F]ind [D]ocument [S]ymbols" })

vim.keymap.set("n", "<leader>fh", pickers.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fm", pickers.man_pages, { desc = "[F]ind [M]anuals" })

-- INFO: better statusline
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })

require("lualine").setup({
	options = {
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
})

-- INFO: keybinding helper
vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

require("which-key").setup({
	spec = {
		{ "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
	},
})

-- NOTE: there are many more quality-of-life plugins available and others that
-- achieve what these do. these are just our recommendations to start.

-- INFO: utility plugins
vim.pack.add({
	"https://github.com/windwp/nvim-autopairs", -- auto pairs
	"https://github.com/folke/todo-comments.nvim", -- highlight TODO/INFO/WARN comments
}, { confirm = false })

require("nvim-autopairs").setup()
require("todo-comments").setup()

-- INFO: Oil nvim
vim.pack.add({
	"https://github.com/stevearc/oil.nvim", -- Oil.nvim repository URL
	"https://github.com/nvim-lua/plenary.nvim", -- A dependency for oil.nvim
})
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- LazyGit
vim.pack.add({
	"https://github.com/kdheepak/lazygit.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
})

vim.keymap.set("n", "<leader>lg", "<CMD>LazyGit<CR>", { desc = "Open parent directory" })

-- Trouble
vim.pack.add({
	"https://github.com/folke/trouble.nvim",
})

require("trouble").setup({
	-- Position of the list: "bottom", "top", "left", "right"
	auto_close = true, -- Automatically close the list when you have no diagnostics left
	auto_open = false, -- Automatically open the list when you have diagnostics (usually annoying, keep false)
	auto_preview = true, -- Automatically open the preview window when hovering an item
	auto_jump = false, -- Auto jump to the code location when there's only one result

	-- Configuration for window appearance and behavior
	win = {
		type = "split", -- Use a standard layout split
		position = "bottom", -- Open at the bottom of the editor
		size = 10, -- Height or width of the split window
	},

	-- Preview window configuration
	preview = {
		type = "main", -- Opens the preview right inside your main coding buffer
		scratch = true, -- Use a scratch buffer if the file isn't loaded yet
	},

	-- Filter settings (e.g., severe errors vs minor hints)
	filter = {
		-- You can filter by severity if you only want to focus on Errors/Warnings:
		-- severity = vim.diagnostic.severity.ERROR
	},
})

vim.keymap.set("n", "<leader>qq", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>qQ",
	"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<CMD>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>qL", "<CMD>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>qX", "<CMD>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

-- UI2: no more press enter
require("vim._core.ui2").enable({
	enable = true,
	msg = { -- Options related to the message module.
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "cmd",
		cmd = { -- Options related to messages in the cmdline window.
			height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
		},
		dialog = { -- Options related to dialog window.
			height = 0.5, -- Maximum height.
		},
		msg = { -- Options related to msg window.
			height = 0.5, -- Maximum height.
			timeout = 4000, -- Time a message is visible in the message window.
		},
		pager = { -- Options related to message window.
			height = 0.5, -- Maximum height.
		},
	},
})

-- Enable built in Undotree
vim.cmd("packadd nvim.undotree")

-- Enable built in difftool
vim.cmd("packadd nvim.difftool")

-- ==========================================================================
-- 1. Package Installation (vim.pack)
-- ==========================================================================

vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
})

vim.pack.add({
	"https://github.com/leoluz/nvim-dap-go",
})

vim.pack.add({
	{ src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*") },
})

-- ==========================================================================
-- 2. Configuration & Signs
-- ==========================================================================

local dap = require("dap")
local dap_go = require("dap-go")
local dap_view = require("dap-view")

-- Visual Signs (Left gutter signs)
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define(
	"DapStopped",
	{ text = "▶️", texthl = "DiagnosticHint", linehl = "Visual", numhl = "DiagnosticHint" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "DiagnosticError", linehl = "", numhl = "" })

-- 1. Run the base setup first (this generates the internal defaults)
dap_go.setup()

-- 2. Forcefully wipe out the defaults and assign ONLY your absolute target
dap.configurations.go = {
	{
		type = "go",
		name = "Debug App (cmd/app)",
		request = "launch",
		program = function()
			local workspace = vim.fn.getcwd()
			local cmd_path = workspace .. "/cmd"

			-- Check if /cmd folder exists in this project workspace root
			if vim.fn.isdirectory(cmd_path) == 1 then
				-- Scan the /cmd folder for subdirectories
				local handle = vim.loop.fs_scandir(cmd_path)
				if handle then
					while true do
						local name, type = vim.loop.fs_scandir_next(handle)
						if not name then
							break
						end

						-- If it finds a directory inside /cmd/ (like 'app', 'api', 'server')
						-- it returns that full path to Delve instantly.
						if type == "directory" then
							return cmd_path .. "/" .. name
						end
					end
				end

				-- Fallback if cmd/ is empty but exists
				return cmd_path
			end

			-- Ultimate project fallback: just use the active workspace root directory
			return workspace
		end,
	},
}

dap_view.setup({
	winbar = {

		show = true,
		-- You can add a "console" section to merge the terminal with the other views
		sections = { "scopes", "breakpoints", "threads", "watches", "exceptions" },
		-- Must be one of the sections declared above
		default_section = "scopes",
		-- Append hints with keymaps within the labels
		show_keymap_hints = true,
		-- List of up to 2 strings, defining left and right separators
		separators = nil,
		-- Configure each section individually
		base_sections = {
			-- Labels can be set dynamically with functions
			-- Each function receives the window's width and the current section as arguments
			breakpoints = { label = "Breakpoints", keymap = "B" },
			scopes = { label = "Scopes", keymap = "S" },
			exceptions = { label = "Exceptions", keymap = "E" },
			watches = { label = "Watches", keymap = "W" },
			threads = { label = "Threads", keymap = "T" },
			sessions = { label = "Sessions", keymap = "K" },
			console = { label = "Console", keymap = "C" },
		},
		-- Add your own sections
		custom_sections = {},
		controls = {
			enabled = true,
			buttons = { "play", "step_into", "step_over", "step_out", "term_restart", "fun" },
			custom_buttons = {
				fun = {
					render = function()
						return "🎉"
					end,
					action = function()
						vim.print("🎊")
					end,
				},
				-- Stop | Restart
				-- Double click, middle click or click with a modifier disconnect instead of stopping
				term_restart = {
					render = function(session)
						local group = session and "ControlTerminate" or "ControlRunLast"
						local icon = session and "" or ""
						return "%#NvimDapView" .. group .. "#" .. icon .. "%*"
					end,
					action = function(clicks, button, modifiers)
						local dap = require("dap")
						local alt = clicks > 1 or button ~= "l" or modifiers:gsub(" ", "") ~= ""
						if not dap.session() then
							dap.run_last()
						elseif alt then
							dap.disconnect()
						else
							dap.terminate()
						end
					end,
				},
			},
		},
	},
	windows = {
		size = 0.25,
		position = "below",
		terminal = {
			size = 0.5,
			position = "left",
			-- List of debug adapters for which the terminal should be ALWAYS hidden
			-- Can also be set to "true" to never show the terminal
			hide = {},
		},
	},
	-- Bindings can be disabled by assigning to an empty table
	keymaps = {
		scopes = {
			toggle = { "<CR>", "<2-LeftMouse>" },
			jump_to_parent = "[[",
			set_value = "s",
		},
		watches = {
			toggle = { "<CR>", "<2-LeftMouse>" },
			jump_to_parent = "[[",
			set_value = "s",
			copy_value = "c",
			delete_expression = "d",
			append_expression = "a",
			insert_expression = "i",
			edit_expression = "e",
		},
		hover = {
			quit = "q",
			toggle = { "<CR>", "<2-LeftMouse>" },
			jump_to_parent = "[[",
			set_value = "s",
		},
		help = {
			quit = "q",
		},
		console = {
			next_session = "]s",
			prev_session = "[s",
		},
		threads = {
			toggle_subtle_frames = "t",
			filter = "f",
			invert_filter = "o",
			jump_to_frame = { "<CR>", "<2-LeftMouse>" },
			force_jump = "<C-w><CR>",
		},
		exceptions = {
			toggle_filter = { "<CR>", "<2-LeftMouse>" },
		},
		sessions = {
			switch_session = { "<CR>", "<2-LeftMouse>" },
		},
		breakpoints = {
			delete_breakpoint = "d",
			jump_to_breakpoint = { "<CR>", "<2-LeftMouse>" },
			force_jump = "<C-w><CR>",
		},
		base = {
			next_view = "]v",
			prev_view = "[v",
			jump_to_first = "[V",
			jump_to_last = "]V",
			help = "g?",
		},
	},
	icons = {
		collapsed = "󰅂 ",
		disabled = "",
		disconnect = "",
		enabled = "",
		expanded = "󰅀 ",
		filter = "󰈲",
		negate = " ",
		pause = "",
		play = "",
		run_last = "",
		step_back = "",
		step_into = "",
		step_out = "",
		step_over = "",
		terminate = "",
	},
	help = {
		border = nil,
	},
	hover = {
		border = nil,
	},
	render = {
		-- Optionally a function that takes two `dap.Variable`'s as arguments
		-- and is forwarded to a `table.sort` when rendering variables in the scopes view
		sort_variables = nil,
		-- Full control of how frames are rendered, see the "Custom Formatting" page
		threads = {
			-- Choose which items to display and how
			format = function(name, lnum, path)
				return {
					{ part = name, separator = " " },
					{ part = path, hl = "FileName", separator = ":" },
					{ part = lnum, hl = "LineNumber" },
				}
			end,
			-- Align columns
			align = false,
		},
		-- Full control of how breakpoints are rendered, see the "Custom Formatting" page
		breakpoints = {
			-- Choose which items to display and how
			format = function(line, lnum, path)
				return {
					{ part = path, hl = "FileName" },
					{ part = lnum, hl = "LineNumber" },
					{ part = line, hl = true },
				}
			end,
			-- Align columns
			align = false,
		},
	},
	-- Requires neovim 0.12+
	virtual_text = {
		-- Control with `DapViewVirtualTextToggle`
		enabled = false,
		-- Supported options include "inline", "eol", and "eol_right_align"
		position = "inline",
		format = function(variable, _, _)
			return " " .. variable.value
		end,
		-- Prepend the variable name (when using eol positioning)
		prefix = function(position, node, bufnr)
			if position == "eol" or position == "eol_right_align" then
				local name = vim.treesitter.get_node_text(node, bufnr)

				return name .. " ="
			end
		end,
		-- Add commas between variables (when using eol positioning)
		suffix = function(position, _, _, var_index, num_var_line)
			if position == "eol" or position == "eol_right_align" then
				return var_index == num_var_line and "" or ","
			end
		end,
	},
	-- Controls how to jump when selecting a breakpoint or navigating the stack
	-- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
	-- Only a subset of the options is available: newtab, useopen, usetab and uselast
	-- Can also be a function that takes the current winnr and the destination bufnr
	-- If a function, should return the winnr of the destination window
	switchbuf = "usetab,uselast",
	-- Auto open when a session is started and auto close when all sessions finish
	-- Alternatively, can be a string:
	-- - "keep_terminal": as above, but keeps the terminal when the session finishes
	-- - "open_term": open the terminal when starting a new session, nothing else
	auto_toggle = false,
	-- Reopen dapview when switching to a different tab
	-- Can also be a function to dynamically choose when to follow, by returning a boolean
	-- If a function, receives the name of the adapter for the current session as an argument
	follow_tab = false,
})

-- ==========================================================================
-- 3. Automation (Fixing the 'dap-view' listener collision)
-- ==========================================================================

-- Changing the listener key to "my_go_debug" ensures nvim-dap doesn't confuse
-- the UI commands with a language profile config.
dap.listeners.before.attach.my_go_debug = function()
	dap_view.open()
	print("🐞 Debugger: Connected/Attached")
end

dap.listeners.before.launch.my_go_debug = function()
	dap_view.open()
	print("🚀 Debugger: Process Launched & Running...")
end

dap.listeners.before.event_terminated.my_go_debug = function()
	dap_view.close()
	print("⏹️ Debugger: Session Terminated")
end

dap.listeners.before.event_exited.my_go_debug = function()
	dap_view.close()
	print("🏁 Debugger: Process Exited")
end

-- ==========================================================================
-- 4. Keymaps
-- ==========================================================================

vim.keymap.set("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Debug: Start / Continue" })
vim.keymap.set("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<leader>do", function()
	dap.step_over()
end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<leader>dt", function()
	dap.terminate()
end, { desc = "Debug: Terminate Session" })
vim.keymap.set("n", "<leader>dgt", function()
	dap_go.debug_test()
end, { desc = "Debug: Go Nearest Test" })
vim.keymap.set("n", "<leader>dv", function()
	dap_view.toggle()
end, { desc = "Debug: Toggle UI View" })

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
