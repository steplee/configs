local M = {}

-- local string = require'string'

M.v = 2;

local find_decl = function()
	local node = vim.treesitter.get_node();
	local type = node:type();
	local found = true;
	while type ~= "field_declaration" do
		node = node:parent();
		if node == nil then
			break;
		end
		type = node:type();
	end

	if node == nil then
		error("Could not find 'field_declaration' above cursor!")
	else
		-- vim.print("got type " .. type)
	end

	return node
end

local find_struct = function()
	local node = vim.treesitter.get_node();
	local type = node:type();
	local found = true;
	while (type ~= "class_specifier" and type ~= "struct_specifier")  do
		node = node:parent();
		if node == nil then
			found = false;
			break;
		end
		type = node:type();
	end

	if node == nil then
		error("Could not find struct above current func decl!")
	end

	return node
end

local find_struct_name = function(struct_decl_node)
	for child in struct_decl_node:iter_children() do
		if child:type() == "type_identifier" then
			local bufn = 0;
			return vim.treesitter.get_node_text(child, bufn);
		end
	end
	return nil
end

-- TODO: Handle depth upto 2 or 3
local find_decl_func_name = function(func_decl_node)

	local sub = nil;
	for child in func_decl_node:iter_children() do
		if child:type() == "function_declarator" then
			sub = child
		end
	end

	if sub == nil then
		error("could not find 'function_declarator' child of parent node type " .. func_decl_node:type())
	end

	for child in sub:iter_children() do
		if child:type() == "field_identifier" then
			local bufn = 0;
			return vim.treesitter.get_node_text(child, bufn);
		end
	end

	error("could not find 'field_identifier' child of parent node type " .. sub:type())

	return nil
end

M.decl2def = function()
	local bufn = 0; -- always the current one.
	local func_decl_node = find_decl()
	local func_decl_text = vim.treesitter.get_node_text(func_decl_node, bufn);
	local func_decl_name = find_decl_func_name(func_decl_node)

	local struct_node = find_struct()
	local struct_name = find_struct_name(struct_node)

	-- vim.print(" - Have func_decl_text   = ", func_decl_text);
	-- vim.print(" - Have struct_name = ", struct_name);
	-- vim.print(" - Have func_decl_name   = ", func_decl_name);

	local s = string.gsub(func_decl_text, func_decl_name, struct_name .. "::" .. func_decl_name, 1);
	s = string.gsub(s, "%svirtual%s", " ", 1);
	s = string.gsub(s, "%soverride%s", " ", 1);

	-- This should use the treesitter node "optional_parameter_declaration"
	-- This can probably break in some circumstances.
	s = string.gsub(s, "%=.-,", ",");
	s = string.gsub(s, "%=.-%)", ")");

	-- Finally: if we find a semi-colon near the end, truncate there and replace with an open-bracket.
	-- I prefer having the user close there own bracket.
	s, semicolon_count = string.gsub(s, ";", " {");
	if semicolon_count ~= 1 then
		error("should have had one semi-colon, had " .. tostring(semicolon_count))
	end

	-- vim.print(" - Final string = ", s);
	vim.fn.setreg("", s);
	vim.fn.setreg("+", s);
end

function M.setup(opts)
	if opts.key then
      vim.keymap.set("n", opts.key, M.decl2def)
	else
		error("must pass decl2def.setup({ key=<the-key> })")
	end
end

-- _G["p"] = M
return M
