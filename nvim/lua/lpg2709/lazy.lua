local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- - Vim
	"morhetz/gruvbox",                                       -- Grovbox colorscheme S2
	"jiangmiao/auto-pairs",                                  -- Insert or delete brackets
                                                             --   parens, quotes in pair.
	"editorconfig/editorconfig-vim",                         -- Editorsconfig plugint
	"dhruvasagar/vim-table-mode",                            -- Ident text table
	-- "posva/vim-vue",                                         -- Better vue heighlight
	"tpope/vim-fugitive"                                     -- A Git wrapper so awesome, it should be illegal

	-- - Neovim
	"kyazdani42/nvim-tree.lua",                              -- File explorer
	"nvim-lualine/lualine.nvim",                             -- Better status line
	"kyazdani42/nvim-web-devicons",                          -- Pretty icons
	{
		"nvim-treesitter/nvim-treesitter",                   -- Treesitter S2
		build = ":TSUpdate"
	},
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},

	-- -   LSP support
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- -   Autocomplete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-cmdline",

	-- -   Snippets
	"L3MON4D3/LuaSnip",
}

-- if on Windows; find telescope-fzf-native and change the build command
if vim.loop.os_uname().sysname == "Windows_NT" then
	for key, value in pairs(plugins) do
		if(type(value) == "table") then
			if value[1]:find("fzf") then
				value["build"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
			end
		end
	end
end

require("lazy").setup(plugins, {})
