
return {
	--[[
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		-- build = "make install_jsregexp"

		enabled = false,

		config = function(_, opts)
			local ls = require("luasnip")
			ls.setup(opts)

			vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
			vim.keymap.set({"i"}, "<C-J>", function() ls.expand() end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

			vim.keymap.set({"i", "s"}, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})




			-- Snippets.
			local ls = require("luasnip")
			local s = ls.snippet
			local sn = ls.snippet_node
			local isn = ls.indent_snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local r = ls.restore_node
			local events = require("luasnip.util.events")
			local ai = require("luasnip.nodes.absolute_indexer")
			local extras = require("luasnip.extras")
			local l = extras.lambda
			local rep = extras.rep
			local p = extras.partial
			local m = extras.match
			local n = extras.nonempty
			local dl = extras.dynamic_lambda
			local fmt = require("luasnip.extras.fmt").fmt
			local fmta = require("luasnip.extras.fmt").fmta
			local conds = require("luasnip.extras.expand_conditions")
			local postfix = require("luasnip.extras.postfix").postfix
			local types = require("luasnip.util.types")
			local parse = require("luasnip.util.parser").parse_snippet
			local ms = ls.multi_snippet
			local k = require("luasnip.nodes.key_indexer").new_key

			ls.add_snippets("all", {
				s("trigger", { t("Wow! Text!") })
			});

			local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
			local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
			local postfix_builtin = require("luasnip.extras.treesitter_postfix").builtin

			ls.add_snippets("cpp", {
				treesitter_postfix({
					matchTSNode = postfix_builtin.tsnode_matcher.find_topmost_types({
						"call_expression",
						"identifier",
						"template_function",
						"subscript_expression",
						"field_expression",
						"user_defined_literal"
					}),
					trig = ".mv",
					query_lang = "cpp",
				}, {
					f(function(_, parent)
						local c = parent.snippet.env.LS_TSMATCH[1];
						return { ("std::move(%s)"):format(c) }
					end)
				})
			}, {key = "move"})



		end
	}
	--]]
}
