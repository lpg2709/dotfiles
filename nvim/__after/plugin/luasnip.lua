local config=vim.fn.stdpath('config')
require("luasnip.loaders.from_snipmate").lazy_load({
	paths = {config.."/snippets"}
})

vim.cmd [[
	imap <silent><expr> <C-n> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-n>'
	inoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>

	snoremap <silent> <C-n> <cmd>lua require('luasnip').jump(1)<Cr>
	snoremap <silent> <C-p> <cmd>lua require('luasnip').jump(-1)<Cr>

	imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
	smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]
