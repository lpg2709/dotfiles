local telescope = require('telescope')
local buildin = require('telescope.builtin')
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
			},
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

vim.keymap.set('n', '<leader>ff', buildin.find_files, { desc = "Find files by name",  silent = true })
vim.keymap.set('n', '<leader>fb', buildin.buffers, { desc = "Find buffer",  silent = true })
vim.keymap.set('n', '<leader>fh', buildin.help_tags, { desc = "Find on vim buildin help",  silent = true })
vim.keymap.set('n', '<leader>fg', buildin.live_grep, { desc = "Live grep",  silent = true })
vim.keymap.set('n', '<leader>fj', buildin.jumplist, { desc = "Find in jumplist",  silent = true })
vim.keymap.set('n', '<leader>fw',
	function()
		buildin.grep_string({ search = vim.fn.expand("<cword>") })
	end, { desc = "Search current cursor word",  silent = true })
vim.keymap.set('n', '<leader>fW',
	function()
		buildin.grep_string({ search = vim.fn.expand("<cword>") })
	end, { desc = "Search current cursor word until space",  silent = true })
vim.keymap.set('n', '<leader>fs',
	function()
		buildin.grep_string({ search = vim.fn.input("Grep > ") })
	end, { desc = "Search by string",  silent = true })

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

