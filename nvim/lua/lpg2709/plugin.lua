-- File with functions usefull for me

-- Enter to Config folder
function config()
	local vimrc_path = vim.fn.stdpath("config")
	vim.cmd("cd " .. vimrc_path)
	vim.notify("Enter the '" .. vimrc_path .. "' folder!")
end
vim.cmd([[command! Config lua config()]])

-- Enter in Documents folder
function doc()
	local doc_path = vim.fn.expand("~/Documents")
	vim.cmd("cd " .. doc_path)
	vim.notify("Enter the '" .. doc_path .. "' folder!")
end
vim.cmd([[command! Doc lua doc()]])


function find_jq()
	vim.fn.system('jq --version')
	if vim.v.shell_error == 1 then
		vim.notify("ERROR: jq command not found!")
		return false
	end

	return true
end

-- Pretty JSON format
function PrettyJSON()
	if find_jq() then
		vim.cmd("%!jq .")
		vim.bo.filetype="json"
		vim.notify("JSON formated")
	end
end
vim.cmd([[command! PrettyJSON lua PrettyJSON()]])

-- Minify JSON format
function MinifyJSON()
	if find_jq() then
		vim.cmd("%!jq -c .")
		vim.notify("JSON formated")
	end
end
vim.cmd([[command! MinifyJSON lua MinifyJSON()]])
