-- Better status line
return {
		'nvim-lualine/lualine.nvim',
		lazy = true,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			lazy = true,
		},
		opts = {
			disabled_filetypes = {'NvimTree'},
			theme = 'gruvbox_dark'
		}
}
