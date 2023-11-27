return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		view = {
			adaptive_size = true,
		}
	},
	config = function()
		require("nvim-tree").setup {}
	end,
	keys = {
		{'<leader>b', ':NvimTreeToggle<CR>', desc="Toggle nvim-tree", mode = 'n', noremap = true, silent = true }
	},
}

