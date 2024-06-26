
return {
	 {
			'nvim-treesitter/nvim-treesitter',
			-- commit='4cccb6f494eb255b32a290d37c35ca12584c74d0',
			-- commit='239bb86b54d07a955caa0200053484298879ca59',
			-- commit='bd5517989398145c36d859927fb4e76a45c66cf6',
			commit='53b32a6aa3e1de224e82f88cbdc08584c753adb7',
			run = ':TSUpdate',
			config = function()
				require'nvim-treesitter.configs'.setup {
					highlight = {
						enable  = {"c", "cpp", "python", "javascript", "lua", "rust"}, -- enable = true (false will disable the whole extension)
						custom_captures = {
						-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
							-- ["foo.bar"] = "Identifier",
							["type.qualifier.cpp"] = "Keyword", -- THIS IS BROKEN v0.10
							["type.cpp"] = "TSType",
							["type.builtin.cpp"] = "TSType",
							["storageclass.cpp"] = "Keyword",
							["storageclass"] = "Keyword",
						},
						-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
						-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
						-- Using this option may slow down your editor, and you may see some duplicate highlights.
						-- Instead of true it can also be a list of languages
						additional_vim_regex_highlighting = false,
					},
				}
			end
	},
}
