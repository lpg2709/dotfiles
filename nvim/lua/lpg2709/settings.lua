local g = vim.g
local o = vim.o      -- set global options
local wo = vim.wo
local set = vim.opt

-- Highlight on
-- No error informations
-- Set color of right column
vim.cmd [[
	syntax on
	set noerrorbells
	highlight ColorColumn ctermbg=0 guibg=lightgrey
]]

o.exrc=true                   -- Auto load project configs
o.tabstop=4                   -- 1 tab = 4 Spaces
o.shiftwidth=4                -- 1 tab = 4 Space for << >>
o.scrolloff=8                 -- Scroll ofset, 8 lines
o.cursorline=true             -- Heighlight the current line
o.number=true                 -- Show line numbers
o.hidden=true                 --
o.relativenumber=true         -- Show relative lines
o.smartindent=true            -- Enable auto indent
wo.wrap=false                 -- Line can go off screen
o.smartcase=true              -- Case sensitive for search
set.swapfile=false            -- No swap files
set.backup=false              -- No backup files
o.undodir=vim.fn.stdpath('config') .. '/undo'      -- Set undo files folder
o.undofile=true               -- Enable undo files
o.incsearch=true              -- Highlight search
o.cmdheight=2                 -- Command line height
o.updatetime=300              -- Change update time
set.hlsearch=false            --
set.pastetoggle='<F2>'        -- Paste mode toggle by F2 key
set.guicursor='i:block'       -- Block cursor always
set.completeopt={'menu','menuone','noselect'}
o.lazyredraw = true           -- do not redraw screen while running macros

g.mapleader = ' '               -- Remap leader to SPACEBAR

