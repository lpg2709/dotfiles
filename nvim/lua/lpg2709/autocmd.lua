-- Remove spaces on the end of line
vim.api.nvim_create_autocmd({'BufWritePre'}, {
	pattern = { '*' },
	command = [[%s/\s\+$//e]],
})

-- Set tab to 2 on vue files
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.vue"},
  callback = function ()
	vim.opt_local.tabstop=2
	vim.opt_local.shiftwidth=2
	vim.opt_local.expandtab=true
  end
})

