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

local M = {}

M.search_dotfiles = function()
    require('telescope.builtin').find_files({
        prompt_title = "<.dotfiles>",
        cwd = '~/.dotfiles',
        hidden = true
    })
end

M.project_files = function()
    local opts = {}
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then require('telescope.builtin').find_files(opts) end
end

vim.api.nvim_set_keymap('n', '<Leader>p', ':lua require\'lpg2709.plugins.telescope\'.project_files()<Cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>df', ':lua require\'lpg2709.plugins.telescope\'.search_dotfiles()<Cr>', {noremap = true, silent = true})

return M


