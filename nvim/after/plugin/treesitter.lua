local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"glsl",
		"lua",
		"rust",
		"vim",
		"vimdoc",
		"zig"
	},
    highlight = {
        enable = true
    }
}
