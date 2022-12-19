local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Packer plugin Bootstrapping
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- My plugins here
	use 'morhetz/gruvbox'                                       -- Grovbox colorscheme S2
	use 'luochen1990/rainbow'                                   -- showing diff level of
														        --   parentheses in diff
														        --   color
	use 'jiangmiao/auto-pairs'                                  -- Insert or delete brackets
														        --   parens, quotes in pair.
	use 'editorconfig/editorconfig-vim'                         -- Editorsconfig plugint
	use 'dhruvasagar/vim-table-mode'                            -- Create tables
	use 'xolox/vim-notes'
	use 'xolox/vim-misc'
	-- - Neovim
	use 'kyazdani42/nvim-tree.lua'                              -- File explorer
	use 'nvim-lualine/lualine.nvim'                             -- Better status line
	use 'kyazdani42/nvim-web-devicons'                          -- Pretty icons
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}  -- treesitter S2
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	-- -   LSP support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	-- -   Autocomplete
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-cmdline'
	-- -   Snippets
	use 'L3MON4D3/LuaSnip'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
