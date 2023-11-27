return {
	'dhruvasagar/vim-table-mode',
	lazy = true,
	opts = function()
		vim.g.table_mode_corner_corner='|'
		vim.g.table_mode_corner='+'
	end,
}
