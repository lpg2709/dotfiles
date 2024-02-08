-- File with functions usefull for me

-- Pretty JSON format
function PrettyJSON()
	vim.fn.system('jq --version')
	if vim.v.shell_error == 1 then
		vim.notify("ERROR: jq command not found!")
		return
	end
	vim.cmd("%!jq .")
	vim.bo.filetype="json"
	vim.notify("JSON formated")
end
vim.cmd([[command! PrettyJSON lua PrettyJSON()]])
