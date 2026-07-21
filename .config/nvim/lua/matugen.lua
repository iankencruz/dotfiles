 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#f9f9ff',
    base01 = '#ecedf7',
    base02 = '#e6e8f1',
    base03 = '#717784',
    base04 = '#414753',
    base05 = '#181c22',
    base06 = '#181c22',
    base07 = '#181c22',
    base08 = '#ba1a1a',
    base09 = '#8534a1',
    base0A = '#475f88',
    base0B = '#0058af',
    base0C = '#eeb0ff',
    base0D = '#aac7ff',
    base0E = '#afc7f7',
    base0F = '#ffdad6',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#181c22',          bg = '#f9f9ff' })
  hi('TelescopeBorder',         { fg = '#717784',             bg = '#f9f9ff' })
  hi('TelescopePromptNormal',   { fg = '#181c22',          bg = '#f9f9ff' })
  hi('TelescopePromptBorder',   { fg = '#717784',             bg = '#f9f9ff' })
  hi('TelescopePromptPrefix',   { fg = '#0058af',             bg = '#f9f9ff' })
  hi('TelescopePromptCounter',  { fg = '#414753',  bg = '#f9f9ff' })
  hi('TelescopePromptTitle',    { fg = '#f9f9ff',             bg = '#0058af' })
  hi('TelescopePreviewTitle',   { fg = '#f9f9ff',             bg = '#475f88' })
  hi('TelescopeResultsTitle',   { fg = '#f9f9ff',             bg = '#8534a1' })
  hi('TelescopeSelection',      { fg = '#181c22',          bg = '#e6e8f1' })
  hi('TelescopeSelectionCaret', { fg = '#0058af',             bg = '#e6e8f1' })
  hi('TelescopeMatching',       { fg = '#0058af',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
