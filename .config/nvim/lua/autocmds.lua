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
