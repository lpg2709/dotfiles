local g = vim.g
local set = vim.opt

-- set to 0 if you want to enable it later via :RainbowToggle
g.rainbow_active=1
-- set gruvbox temcoloe (255 or 16)
g.gruvbox_termcolors='16'

-- setup gruvbox color scheme and set transparency to none
vim.cmd [[
	colorscheme gruvbox
	hi Normal guibg=NONE ctermbg=NONE
]]

-- use background to dark
set.background='dark'

