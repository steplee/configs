
function toggle_lsp()
	-- if table.getn(vim.lsp.get_active_clients()) == 0 then
	if table.getn(vim.lsp.get_clients()) == 0 then
		-- vim.cmd('LspStart');
		vim.lsp.enable(require'mason-lspconfig'.get_installed_servers(), true)
		vim.cmd('edit')
		print('Turning LSP On')
	else
		-- vim.cmd('LspStop');
		-- vim.lsp.enable(require'mason-lspconfig'.get_installed_servers(), false)
		-- vim.cmd('edit')

		vim.lsp.stop_client(vim.lsp.get_clients())

		local clientNames = {};
		for ii,k in pairs(vim.lsp.get_clients()) do clientNames[#clientNames+1] = k.name end
		vim.lsp.enable(clientNames, false)
		-- for ii,k in pairs(clientNames) do print(ii,k) end

		print('Turning LSP Off', clientNames)
	end
end

function setup_maps()
	local keymap = vim.api.nvim_set_keymap
	local cmd = vim.cmd

	keymap('', '<C-h>', '<C-w>h', {noremap=true})
	keymap('', '<C-k>', '<C-w>k', {noremap=true})
	-- keymap('', '<C-j>', '<C-w>j', {noremap=true})
	keymap('', '<C-l>', '<C-w>l', {noremap=true})
	keymap('n', '<leader>w', [[:%s/\s\+$//e<CR>]], {noremap=true})

	-- Delete markers from asm
	cmd('command CleanAsm %s/^\\W*\\..*// | :g/^$/d')

	-- Allow 'jk' to exit insert mode
	keymap('i', 'jk', '<ESC>', {noremap=false})

	-- Allow C-c to exit a quickfix window.
	cmd([[ autocmd BufWinEnter quickfix map <buffer> <C-c> :q<CR> ]])

	-- Toggle LSP
	keymap('n', '<Space>l', [[<Cmd>lua toggle_lsp()<CR>]], {silent=true, desc="toggle lsp"})
	-- keymap('n', '<localleader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent=true}) -- code action

	-- to quit vim
	cmd([[ autocmd BufEnter * nmap silent <buffer> <Leader>q :bd<CR> ]])
	cmd([[  cnorea wd w\|:bd ]])

	-- to save file
	keymap('i', '<C-s>',    '<ESC>:w <CR>', { noremap=true, silent=true })
	keymap('n', '<C-s>',    '<ESC>:w <CR>', { noremap=true, silent=true })

	-- scroll window up/down
	-- keymap('i', '<C-e>', '<ESC><C-e>', { silent=true })
	-- keymap('i', '<C-y>', '<ESC><C-y>', { silent=true })
	-- keymap('i', '<C-e>', '<C-x><C-e>', { silent=true, noremap=true })
	-- keymap('i', '<C-y>', '<C-x><C-y>', { silent=true, noremap=true })
	keymap('n', '<C-h>', 'zh', { silent=true })     -- left
	keymap('n', '<C-l>', 'zl', { silent=true })     -- right

	-- clear Search Results
	-- keymap('n', '//', ':noh <CR>', { silent=true })

	-- Resize splits more quickly
	-- resize up and down
	keymap('n', ';k',   ':resize +3 <CR>',          { noremap=true, silent=true })
	keymap('n', ';j',   ':resize -3 <CR>',          { noremap=true, silent=true })
	-- resize right and left
	keymap('n', ';l',   ':vertical resize +3 <CR>', { noremap=true, silent=true })
	keymap('n', ';h',   ':vertical resize -3 <CR>', { noremap=true, silent=true })

	-- Visual indent
	keymap('v', '<',   '<gv', { noremap=true, silent=true })
	keymap('v', '>',   '>gv', { noremap=true, silent=true })

	-- going back to normal mode which works even in vim's terminal
	-- you will need this if you use floaterm to escape terminal
	cmd([[ tmap <Esc> <c-\><c-n> ]])

	-- move selected line(s) up or down
	keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap=true, silent=true})
	keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap=true, silent=true})

	-- Complete file name (default in i mode is <C-x><C-f>, let's map just <C-f>)
	keymap('i', '<C-f>', "<C-x><C-f>", {noremap=true, silent=true})

	-- Allow C-w C-w in terminal mode
	keymap('t', '<C-w>', '<C-\\><C-w>', {noremap=true})
	keymap('t', 'jk', '<Esc>', {noremap=true})

	-- A-m simply once prompts omnifunc popup.
	-- And A-m when in popupmenu does same as C-n (down one)
	-- cmd('inoremap <expr> <C-m> pumvisible() ? "<C-n>" : "<C-x><C-o>"')
	cmd('imap <expr> <A-n> pumvisible() ? "<C-n>" : "<C-x><C-o>"')
	-- make a-n and a-p act like c-n and c-p
	cmd('imap <expr> <A-p> pumvisible() ? "<C-p>" : "<A-p>"')
	-- cmd('imap <A-n> <C-n>')
	
	-- April 12: change directory of current buffer /to/ current buffer location (using grb), and allow going up (using gru)
	--           modified from https://www.reddit.com/r/neovim/comments/1e34ti5/how_to_set_working_directory_to_that_of_the/
	if 1 then
		vim.keymap.set('n', 'gru', function()
			vim.cmd 'cd ..'
		end, { desc = 'Navigate up one directory from current' })

		vim.keymap.set('n', 'grb', function()
			vim.cmd('cd ' .. vim.fn.expand '%:p:h')
		end, { desc = 'Set working directory to path of buffer.' })

		-- Try to go up until we see a .git dir
		vim.keymap.set('n', 'grg', function()
			original = vim.fn.getcwd()
			success = false
			for i=1,15 do
				vim.print('at ' .. vim.fn.expand('%:p:h'))
				if vim.uv.fs_stat('./.git') then
					vim.print('found .git/, done')
					success = true
					break
				end
				vim.cmd('cd ..')
			end
			if not success then
				vim.print('faield to find .git/, not doing anything')
				vim.cmd('cd ' .. original)
			end
		end, { desc = 'Walk working directory up until seeing a .git/' })

		-- Combines `grb` & `grg`
		vim.keymap.set('n', 'grr', 'grbgrg', {remap=true});
	end
end


setup_maps()
