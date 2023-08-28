local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
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

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

