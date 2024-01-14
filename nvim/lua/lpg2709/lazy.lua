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
		-- For windows
		-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
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

require("lazy").setup(plugins, {})
