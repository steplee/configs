
local set_lsp_maps = function()
	vim.keymap.set("n", "<Space><Space>", "<cmd>lua vim.lsp.buf.format()<cr>", {silent=true, noremap=true})
	vim.keymap.set("i", "<C-c>", "<cmd>lua vim.lsp.buf.completion()<cr>", {silent=false, noremap=true})
	vim.keymap.set("i", "<A-t>", "<cmd>lua vim.lsp.buf.completion()<cr>", {silent=false, noremap=true})
	vim.keymap.set("i", "<C-t>", "<cmd>lua vim.lsp.buf.completion()<cr>", {silent=false, noremap=true})
	vim.keymap.set("i", "<c-t>", "<cmd>lua vim.lsp.buf.completion()<cr>", {silent=false, noremap=true})

	-- Toggle inlay hint.
	vim.keymap.set("n", "<Space>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", {silent=true, noremap=true})
end

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
						-- vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"
						vim.bo[buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
					end
				}
			end
			}


			vim.api.nvim_create_autocmd('LspAttach', {
				 desc = 'LSP actions',
				 callback = function(ev)

					-- local client = vim.lsp.get_client_by_id(args.data.client_id)
					vim.cmd([[set signcolumn=yes]])

					set_lsp_maps()

				 end})


			end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"SmiteshP/nvim-navic",
				opts = { lsp = { auto_attach = true } }
			}
		}
	},

	{
			'nvim-lua/lsp-status.nvim',
	},

	-- NOTE: I've disabled this!
	{
		'nvimdev/lspsaga.nvim',
		enabled = false,
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
			vim.keymap.set("n", "<Space>I", "<cmd>Lspsaga peek_definition<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>c", "<cmd>Lspsaga incoming_calls<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>C", "<cmd>Lspsaga outgoing_calls<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>O", "<cmd>Lspsaga outline<cr>", {silent=true, noremap=true})
			vim.keymap.set("n", "<Space>k", "<cmd>Lspsaga hover_doc<cr>", {silent=true, noremap=true})
			-- vim.keymap.set("n", "<Space><Space>i", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent=true, noremap=true})

		end,
	},

	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{ "<Space>a", function() require("actions-preview").code_actions() end, mode = {"v","n"}, desc="LSP Code Actions Preview", noremap=true,silent=true }
		},
	},

	{
		'kosayoda/nvim-lightbulb',
		opts = {
			autocmd = { enabled = true },
			priority = 1000,
			sign = {
				enabled = true,
			},
			number = {
				text = "💡",
				enabled = false,
			},
		},
	},

}
