vim.o.number = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.relativenumber = true
vim.o.path = "**"
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- keymaps
--- insert date in the previous line
vim.keymap.set('n', '<leader>d', ':-1r!date<CR>')
--- update current file with new init.lua settings.
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
-- to create a terminal inside neovim
vim.keymap.set('n', '<leader>vt', ':vsplit term://bash<CR>')
vim.keymap.set('n', '<leader>ht', ':split term://bash<CR>')
--- fzf history
vim.keymap.set('n', '<leader>hh', ':History<CR>')
vim.keymap.set('n', '<leader>ff', ':Files<CR>')
vim.keymap.set('n', '<leader>bb', ':Buffer<CR>')
--- another way to pick files. Slower than fzf
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
--- a better way to discover help
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
--- formatting
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- packages
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" }, -- theme
	{ src = "https://github.com/stevearc/oil.nvim" }, -- file chooser
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" }, -- package manager
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- neovims default lsp
	{ src = "https://github.com/MeanderingProgrammer/markdown.nvim" }, -- markdown renderer
	{ src = "https://github.com/junegunn/fzf.vim" }, -- for fzf functionality
	{ src = "https://github.com/junegunn/fzf" }, -- for fzf functionality
	--{ src = "https://github.com/ibhagwan/fzf-lua" }, -- want to investigate, but need to uncomment when machine is fixed.
})

-- LSP section
-- ctrl-s: signature help
-- normal mode - K: lsp-hover info
-- for more, type "h lsp-defaults
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd[[set completeopt+=menuone,noselect,popup]]

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.lsp.enable({ "lua_ls", "eslint", "javascript", "blink", "bashls" })

-- /LSP SECTION

require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "typescript", "javascript", "bash" },
	highlight = { enable = true }
})
require "oil".setup()
require "mason".setup()

require('render-markdown').setup({
	completions = { lsp = { enabled = true } },
})

vim.cmd("colorscheme catppuccin")
