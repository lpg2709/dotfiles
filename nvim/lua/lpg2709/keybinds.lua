local function map(m, k, v, d)
	vim.keymap.set(m, k, v, { desc = d,  silent = true })
end

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', 'Find files by name')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', 'See all open buffers')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', 'Show tags')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', 'Live grap inside files')
map('n', '<leader>n', '<cmd>:RecentNotes<cr>', 'Show Recent notes in new buffer')

map('n', '<C-h>', '<cmd>:wincmd h<cr>', 'Move to left buffer')
map('n', '<C-l>', '<cmd>:wincmd l<cr>', 'Move to right buffer')
map('n', '<C-k>', '<cmd>:wincmd k<cr>', 'Move to top buffer')
map('n', '<C-j>', '<cmd>:wincmd j<cr>', 'Move to bottom buffer')
map('n', '<leader>k', '<cmd>:set invrelativenumber<cr>', 'Toggle relative lines')

map('n', '<leader>k', function()
	local value = vim.api.nvim_get_option_value("colorcolumn", {})
	vim.api.nvim_set_option_value("colorcolumn", (value == "" and "80" or ""), {})
end, 'Toggle right column in 80 char')
