
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			require('mason-lspconfig').setup_handlers {
			function (server_name)
				require('lspconfig')[server_name].setup {
					autostart=false,
					on_attach=function(client,buf)
						vim.cmd([[set signcolumn=yes]])
					end
				}
			end
			}


			vim.api.nvim_create_autocmd('LspAttach', {
				 desc = 'LSP actions',
				 callback = function(ev)
					-- local client = vim.lsp.get_client_by_id(args.data.client_id)
					vim.cmd([[set signcolumn=yes]])
				 end})


			end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		}
	},

	{
			'nvim-lua/lsp-status.nvim',
	},

	{
		'nvimdev/lspsaga.nvim',
		after = 'nvim-lspconfig',
		config = function()
			require('lspsaga').setup({
				-- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
				lightbulb = { virtual_text = false },
				outline = {
					keys = { toggle_or_jump = '<CR>' }
				}
			})
			vim.keymap.set("n", "<Space>f", "<cmd>Lspsaga finder<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>d", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>D", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>Q", "<cmd>Lspsaga show_buf_diagnostics<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>i", "<cmd>Lspsaga goto_definition<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space><Space>i", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>I", "<cmd>Lspsaga peek_definition<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>c", "<cmd>Lspsaga incoming_calls<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>C", "<cmd>Lspsaga outgoing_calls<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>O", "<cmd>Lspsaga outline<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>h", "<cmd>Lspsaga hover<cr>", {silent=true, noremap=true})
		end,
	},

}
