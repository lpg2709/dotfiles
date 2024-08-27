--/*****************************
-- * VIM BUILDIN CONDIGURATION *
-- *****************************/
vim.cmd('syntax on')              -- Highlight on
vim.o.exrc=true                   -- Auto load project configs
vim.o.tabstop=4                   -- 1 tab = 4 Spaces
vim.o.shiftwidth=4                -- 1 tab = 4 Space for << >>
vim.o.scrolloff=8                 -- Scroll ofset, 8 lines
vim.o.cursorline=true             -- Heighlight the current line
vim.o.number=true                 -- Show line numbers
vim.o.hidden=true                 --
vim.o.relativenumber=true         -- Show relative lines
vim.o.smartindent=true            -- Enable auto indent
vim.wo.wrap=false                 -- Line can go off screen
vim.o.smartcase=true              -- Case sensitive for search
vim.opt.swapfile=false            -- No swap files
vim.opt.backup=false              -- No backup files
vim.o.undodir=vim.fn.stdpath('config') .. '/undo'      -- Set undo files folder
vim.o.undofile=true               -- Enable undo files
vim.o.incsearch=true              -- Highlight search
vim.o.cmdheight=2                 -- Command line height
vim.o.updatetime=80               -- Change update time
vim.opt.hlsearch=false            --
vim.opt.completeopt={'menu','menuone','noselect'}
vim.o.lazyredraw = true           -- do not redraw screen while running macros
vim.g.noerrorbells = true         -- No error information
vim.api.nvim_set_hl(0, "ColorColumn", {  -- Set color of right column
	ctermbg = 0, bg = "lightgrey"
})
vim.g.mapleader = ' '             -- Remap leader to SPACEBAR

if vim.loop.os_uname().sysname == "Windows_NT" then -- only for windows gui
	vim.opt.guicursor='i:block'       -- Block cursor always
	vim.opt.guifont='Consolas:h14'
end

--/**********************
-- * MY CUSTOM FUNCTION *
-- **********************/
-- Enter to Config folder
vim.api.nvim_create_user_command("Config", function()
	local vimrc_path = vim.fn.stdpath("config")
	vim.cmd("cd " .. vimrc_path)
	vim.cmd("e " .. "./init.lua")
	vim.notify("Enter the '" .. vimrc_path .. "' folder!")
end, {})

local function jq_is_installed()
	vim.fn.system('jq --version')
	if vim.v.shell_error == 1 then
		vim.notify("ERROR: jq command not found!")
		return false
	end
	return true
end
-- Pretty JSON format
vim.api.nvim_create_user_command("PrettyJSON", function()
	if jq_is_installed() then
		vim.cmd("%!jq .")
		vim.bo.filetype="json"
		vim.notify("JSON formated")
	end
end, {})

-- Minify JSON format
vim.api.nvim_create_user_command("MinifyJSON", function()
	if jq_is_installed() then
		vim.cmd("%!jq -c .")
		vim.notify("JSON formated")
	end
end, {})

--/****************
-- * AUTO COMMAND *
-- ****************/
local augroup = vim.api.nvim_create_augroup
local lpg2709Group = augroup('lpg2709', {})

-- Remove spaces on the end of line
vim.api.nvim_create_autocmd({'BufWritePre'}, {
	group = lpg2709Group,
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

-- .inc file use nasm syntax
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.inc"},
  callback = function ()
	vim.opt_local.filetype="nasm"
  end
})

--/*********************************
-- * KEYBINDS REMAP FOR VIM NATIVE *
-- *********************************/
local function map(m, k, v, d)
	vim.keymap.set(m, k, v, { desc = d,  silent = true })
end

map('n', '<F2>', function()
	vim.o.paste = not vim.o.paste
	print("Paste mode: " .. (vim.o.paste and "ON" or "OFF") )
end, 'Toggle paste mode')

map('n', '<C-h>', '<cmd>:wincmd h<cr>', 'Move to left buffer')
map('n', '<C-l>', '<cmd>:wincmd l<cr>', 'Move to right buffer')
map('n', '<leader>n', '<cmd>:set invrelativenumber<cr>', 'Toggle relative lines')

map('n', '<leader>k', function()
	local value = vim.api.nvim_get_option_value("colorcolumn", {})
	vim.opt.colorcolumn = (value == "" and "80"  or "")
end, 'Toggle right column in 80 char')

map({ 'n', 's' }, '<leader>*', function ()
	local line = vim.api.nvim_get_current_line()
	local cline = vim.api.nvim_win_get_cursor(0)[1]
	local first_char = vim.api.nvim_get_current_line():match("^%s*"):len()
	local content = line:sub(first_char + 1, line:len() - 1)
	local tabs = line:sub(0, first_char)
	local comment_size = content:len() + 4
	local newline = '' .. tabs .. ' * ' .. string.upper(content) .. ' *'
	local stars =  string.rep("*", comment_size)
	local top_line = tabs .. '/' .. stars
	local bottom_line = tabs .. ' ' .. stars .. '/'
	-- Put tow lines for nor overwrite content
	vim.api.nvim_buf_set_lines(0, cline, cline, false, {'', ''})
	-- Replace with comment box format
	vim.api.nvim_buf_set_lines(0, cline-1, cline+2, true, {top_line, newline, bottom_line})
end, 'Comment box')

--/**********
-- * PLUGIN *
-- **********/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"morhetz/gruvbox", -- S2
		lazy = false,
		config = function()
			-- set gruvbox temcoloe (255 or 16)
			vim.g.gruvbox_termcolors='16'
			-- setup gruvbox color scheme and set transparency to none
			vim.cmd [[
				colorscheme gruvbox
				hi Normal guibg=NONE ctermbg=NONE
			]]
			-- use background to dark
			vim.opt.background='dark'
		end,
	},
	{
		"jiangmiao/auto-pairs",
		config = function()
			vim.g.AutoPairsShortcutToggle='' -- Disable auto-pairs toggle
		end,
	},
	{ "editorconfig/editorconfig-vim" },
	{
		"dhruvasagar/vim-table-mode",
		config = function()
			vim.g.table_mode_corner_corner='|'
			vim.g.table_mode_corner='+'
			vim.keymap.set("n", "<leader>tt", vim.cmd.TableModeToggle, { desc = "Toggle table mode" })
		end
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
		end
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open git with vim-fugitive" })
		end,
	},
	{
		'stevearc/oil.nvim',
		opts = {
			view_options = {show_hidden = true,},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({ view_options = {show_hidden = true} })
			vim.keymap.set("n", "<leader>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end
	},
	{
		"nvim-lualine/lualine.nvim", -- Better status line
		config = function()
			require('lualine').setup {
				options = {
					disabled_filetypes = {'NvimTree'},
					theme = 'gruvbox_dark'
				}
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter", -- S2
		build = ":TSUpdate",
		-- lazy = false,
		config = function()
			require('nvim-treesitter.configs').setup{
				ensure_installed = {
					"bash", "c", "cmake", "cpp", "glsl", "go",
					"lua", "rust", "vim", "vimdoc", "zig", "html", "css", "javascript", "markdown", "markdown_inline"
				},
				sync_install = false, -- Enable insall required parsers synchronously
				highlight = {
					enable = true
				}
			}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make"
			},
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
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
			vim.keymap.set('n', '<leader>fk', buildin.keymaps, { desc = "Find keymaps",  silent = true })
			vim.keymap.set('n', '<leader>fw',
			function()
				buildin.grep_string({ search = vim.fn.expand("<cword>") })
			end, { desc = "Search current cursor word",  silent = true })
			vim.keymap.set('n', '<leader>fW',
			function()
				buildin.grep_string({ search = vim.fn.expand("<cWORD>") })
			end, { desc = "Search current cursor word until space",  silent = true })
			vim.keymap.set('n', '<leader>fs',
			function()
				buildin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Search by string",  silent = true })

			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			telescope.load_extension('fzf')
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- -   LSP support
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- -   Autocomplete
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			-- -   Snippets
			{
				"L3MON4D3/LuaSnip",
				lazy = true,
				version = "v2.*",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,

			}
		},
		config = function()
			local cmp = require('cmp')
			local lspconfig = require("lspconfig")
			local ls = require("luasnip")
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local servers = {
--				"tsserver",
--				"pyright",
--				"clangd",
--				"rust_analyzer",
--				"gopls",
--				"neocmake",
--				"volar",
--				"zls",
--				"lua_ls"
			}

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = function(desc) return { noremap=true, silent=true, buffer=bufnr, desc=desc } end
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("Go to definition"))
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts("Go to references"))
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("Go to declaration"))
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts("Go to implementation"))
				vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, bufopts("Type definition"))
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts("Show informations under cursor"))
				vim.keymap.set('n', '<space>cr', vim.lsp.buf.rename, bufopts("Rename all ocorrences, under cursor"))
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts("Perform some code action"))
			end

			-- Mason config
			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = servers,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
							flags = {
								debounce_text_changes = 150,
							},
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup {
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim", "it", "describe", "before_each", "after_each" },
									}
								}
							}
						}
					end,
				}
			})

			cmp.setup({
				sources = cmp.config.sources(
				{
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'luasnip' },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ "i", "c" }
					),
					["<C-k>"] = cmp.mapping(function()
					  if ls.expand_or_jumpable() then
					    ls.expand_or_jump()
					  end
					end, { "i", "s" })
				}),
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
		end,
	},
}

-- if on Windows; find telescope-fzf-native and change the build command
if vim.loop.os_uname().sysname == "Windows_NT" then
	for key, value in pairs(plugins) do
		if(type(value) == "table") then
			if value[1]:find("fzf") then
				value["build"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
			end
		end
	end
end

require("lazy").setup(plugins, {})