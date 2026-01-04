return {
	{
		enabled = false,
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			--
			-- TODO: Probably change these
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},

	{
		"gsuuon/model.nvim",

		-- Don't need these if lazy = false
		cmd = { "M", "Model", "Mchat" },
		init = function()
			vim.filetype.add({
				extension = {
					mchat = "mchat",
				},
			})
		end,
		ft = "mchat",

		keys = {
			{ "<C-m>d", ":Mdelete<cr>", mode = "n" },
			{ "<C-m>s", ":Mselect<cr>", mode = "n" },
			{ "<C-m><space>", ":Mchat<cr>", mode = "n" },
		},

		-- To override defaults add a config field and call setup()

		-- config = function()
		--   require('model').setup({
		--     prompts = {..},
		--     chats = {..},
		--     ..
		--   })
		--
		--   require('model.providers.llamacpp').setup({
		--     binary = '~/path/to/server/binary',
		--     models = '~/path/to/models/directory'
		--   })
		--end

		--[[
        config = function()
            require('model.providers.llamacpp').setup({
                binary = '~/path/to/server/binary',
                models = '~/path/to/models/directory'
            })
            local llamacpp = require('model.providers.llamacpp')
            require('model').setup({
                prompts = {
                    qwen = {
                        provider = llamacpp,
                        options = {
                            url = 'http://10.50.0.46:8081/v1'
                        },
                        builder = function(input, context)
                            return {
                                prompt =
                                '<|system|>'
                                .. (context.args or 'You are a helpful assistant')
                                .. '\n</s>\n<|user|>\n'
                                .. input
                                .. '</s>\n<|assistant|>',
                                stops = { '</s>' }
                            }
                        end
                    }
                }
            })

        end
        --]]

		config = function()
			local util = require("model.util")
            local qflist = require('model.util.qflist')

			local mistral = require("model.providers.openai")
            mistral.initialize({
						url = "http://10.50.0.46:8081/v1",
            })

            local myChat = require('model.prompts.chats').openai
            myChat.params = nil
            myChat.provider = mistral;
            myChat.options = {
                url = "http://10.50.0.46:8081/v1",
            }

			require("model").setup({
				hl_group = "Substitute",


                chats = {
                    spark2 = myChat
                },

				--prompts = util.module.autoload("prompt_library"),
				prompts = {
					["finishComment"] = {
						provider = mistral,
                        options = {
                            url = "http://10.50.0.46:8081/v1",
                        },
						mode = "replace",
						builder = function(input)
							return {
								messages = {
									{
										role = "system",
										content = "Complete the code based on the comment at the top. Output the code and nothing else. No markdown.",
									},
									{ role = "user", content = input },
								},
							}
						end,
					},

					["instReplace"] = {
						provider = mistral,
                        options = {
                            url = "http://10.50.0.46:8081/v1",
                        },
						mode = "replace",
                        builder = function(input)
                            return function(build)
                                vim.ui.input({ prompt = 'Instruction: ' }, function(user_input)
                                    build({
                                        messages = {
                                            {
                                                role = "system",
                                                content = "Complete the code with this instruction: " .. user_input .. ". Output only the code, no markdown",
                                            },
                                            { role = "user", content = input },
                                        },
                                    })
                                end)
                            end
                        end,
					},
					["instInsert"] = {
						provider = mistral,
                        options = {
                            url = "http://10.50.0.46:8081/v1",
                        },
						mode = "insert",
                        builder = function(input)
                            return function(build)
                                vim.ui.input({ prompt = 'Instruction: ' }, function(user_input)
                                    build({
                                        messages = {
                                            {
                                                role = "system",
                                                content = "Complete the code with this instruction: " .. user_input .. ". Output only the code, no markdown",
                                            },
                                            { role = "user", content = input },
                                        },
                                    })
                                end)
                            end
                        end,
					},
					["instAppend"] = {
						provider = mistral,
                        options = {
                            url = "http://10.50.0.46:8081/v1",
                        },
						mode = "append",
                        builder = function(input)
                            return function(build)
                                vim.ui.input({ prompt = 'Instruction: ' }, function(user_input)
                                    build({
                                        messages = {
                                            {
                                                role = "system",
                                                content = "Complete the code with this instruction: " .. user_input .. ". Output only the code, no markdown",
                                            },
                                            { role = "user", content = input },
                                        },
                                    })
                                end)
                            end
                        end,
					},
				},

				default_prompt = {
					provider = mistral,
					options = {
						--url = "https://api.mistral.ai/v1/",
						url = "http://10.50.0.46:8081/v1",
						authorization = "Bearer YOUR_MISTRAL_API_KEY",
					},
					builder = function(input)
						return {
							model = "mistral-medium",
							--temperature = 0.3,
							--max_tokens = 400,
							messages = {
								{
									role = "system",
									content = "You are helpful assistant.",
								},
								{ role = "user", content = input },
							},
						}
					end,
				},
			})
		end,
	},
}
