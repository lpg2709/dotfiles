return {
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = function()
				if vim.loop.os_uname().sysname == "Windows_NT" then         -- If is on windows, compile with CMAKE; Else with make
					return 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
				else
					return 'make'
				end
			end,
			enabled = vim.fn.executable("make") == 1,
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	opts = function()
		local actions = require('telescope.actions')
		return {
			defaults = {
				color_devicons = false,
				prompt_prefix = "$ ",
				file_ignore_patterns = { "^.git/" },
				mappings = {
					i = {
						['<esc>'] = actions.close,
						['<C-j>'] = actions.move_selection_next,
						['<C-k>'] = actions.move_selection_previous
					}
				}
			},
			pickers = {
				find_files = {
					file_ignore_patterns = { "^node_modules/", "^undo/" },
					hidden = true,
				}
			},
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				}
			}
		}
	end,

}
