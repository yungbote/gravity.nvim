-- gravity.nvim/lua/gravity/init.lua
local M = {}

M.setup = function(opts)
	opts = opts or {}
	M.load(opts)
end

M.load = function(opts)
	opts = opts or {}

	-- Reset highlighting
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "gravity"
	vim.o.background = "light"

	-- Define colors
	local colors = {
		-- Base colors from gravity
		fg = "#404040",
		bg = "#f0f0f0",
		white = "#ffffff",
		black = "#000000",

		-- Grays
		gray1 = "#909090",
		gray2 = "#808080",
		gray3 = "#dcdcdc",
		gray4 = "#9c9c9c",
		gray5 = "#7c7c7c",
		gray6 = "#8f8f8f",

		-- Blues
		blue1 = "#c0d0e0",
		blue2 = "#4b5e81",
		blue3 = "#2a3a57",
		blue4 = "#001ac4",
		blue5 = "#000557",

		-- Colors
		red = "#c40020",
		darkred = "#7d0000",
		crimson = "#A00000",
		brightred = "#CB1014",
		verydarkred = "#a40004",

		green = "#2a9400",
		lightgreen = "#b4de85",

		purple = "#7800c4",
		magenta = "#d8008e",

		cyan = "#00A0A0",
		lightcyan = "#87c5dc",
		teal = "#007958",

		orange = "#ff8a00",
		orangered = "#ff4500",
	}

	-- Helper function
	local function hi(group, opts)
		local cmd = "hi " .. group
		if opts.fg then
			cmd = cmd .. " guifg=" .. opts.fg
		end
		if opts.bg then
			cmd = cmd .. " guibg=" .. opts.bg
		end
		if opts.gui then
			cmd = cmd .. " gui=" .. opts.gui
		end
		if opts.sp then
			cmd = cmd .. " guisp=" .. opts.sp
		end
		if opts.link then
			vim.cmd("hi! link " .. group .. " " .. opts.link)
			return
		end
		vim.cmd(cmd)
	end

	-- General colors
	hi("Normal", { fg = colors.fg, bg = colors.bg })
	hi("NonText", { fg = colors.bg, bg = colors.bg })
	hi("Cursor", { fg = colors.white, bg = colors.black })
	hi("LineNr", { fg = colors.white, bg = colors.blue1 })
	hi("CursorLineNr", { fg = colors.black, bg = colors.blue1, gui = "bold" })
	hi("VertSplit", { fg = colors.blue2, bg = colors.blue2 })
	hi("StatusLine", { fg = colors.white, bg = colors.blue3 })
	hi("StatusLineNC", { fg = colors.white, bg = colors.blue2 })
	hi("Folded", { fg = colors.fg, bg = colors.gray3 })
	hi("Title", { fg = "#101010", gui = "bold" })
	hi("Visual", { fg = colors.white, bg = colors.crimson })
	hi("SpecialKey", { fg = colors.gray2, bg = "#343434" })
	hi("WildMenu", { fg = "green", bg = "yellow" })
	hi("PmenuSbar", { fg = colors.black, bg = colors.white })
	hi("Error", { gui = "undercurl", sp = colors.red })
	hi("ErrorMsg", { fg = colors.white, bg = "#FF0000", gui = "bold" })
	hi("WarningMsg", { fg = colors.white, bg = "#FF0000", gui = "bold" })
	hi("ModeMsg", { fg = colors.orange, bg = colors.bg, gui = "bold" })
	hi("IncSearch", { fg = colors.orangered, bg = colors.white })
	hi("Search", { fg = colors.white, bg = colors.orangered })
	hi("Directory", { fg = colors.brightred })

	-- Cursor line
	hi("CursorLine", { bg = colors.blue1 })
	hi("CursorColumn", { bg = colors.blue1 })

	-- Match paren
	hi("MatchParen", { fg = "red", bg = colors.bg, gui = "bold" })

	-- Popup menu
	hi("Pmenu", { fg = "#f6f3e8", bg = "#444444" })
	hi("PmenuSel", { fg = colors.white, bg = colors.darkred })

	-- Diff
	hi("DiffAdd", { bg = colors.lightgreen })
	hi("DiffDelete", { fg = colors.gray4, bg = colors.gray5 })
	hi("DiffChange", { bg = colors.lightcyan })
	hi("DiffText", { fg = colors.white, bg = colors.verydarkred })

	-- Syntax highlighting
	hi("Comment", { fg = colors.gray1 })
	hi("String", { fg = colors.red })
	hi("Number", { fg = colors.red })
	hi("Keyword", { fg = colors.green })
	hi("PreProc", { fg = colors.green })
	hi("Conditional", { fg = colors.blue4 })
	hi("Todo", { fg = colors.orangered })
	hi("Constant", { fg = colors.red })
	hi("Identifier", { fg = colors.purple })
	hi("Function", { fg = colors.magenta })
	hi("Type", { fg = colors.cyan })
	hi("Statement", { fg = colors.blue4 })
	hi("Special", { fg = colors.teal })
	hi("Delimiter", { fg = colors.blue5 })
	hi("Operator", { fg = colors.teal })

	-- Links
	hi("Character", { link = "Constant" })
	hi("Boolean", { link = "Constant" })
	hi("Float", { link = "Number" })
	hi("Repeat", { link = "Statement" })
	hi("Label", { link = "Statement" })
	hi("Exception", { link = "Statement" })
	hi("Include", { link = "PreProc" })
	hi("Define", { link = "PreProc" })
	hi("Macro", { link = "PreProc" })
	hi("PreCondit", { link = "PreProc" })
	hi("StorageClass", { link = "Type" })
	hi("Structure", { link = "Type" })
	hi("Typedef", { link = "Type" })
	hi("Tag", { link = "Special" })
	hi("SpecialChar", { link = "Special" })
	hi("SpecialComment", { link = "Special" })
	hi("Debug", { link = "Special" })

	-- TreeSitter support
	hi("@variable", { fg = colors.fg })
	hi("@variable.builtin", { fg = colors.purple })
	hi("@variable.parameter", { fg = colors.fg })
	hi("@variable.member", { fg = colors.fg })
	hi("@constant", { link = "Constant" })
	hi("@constant.builtin", { link = "Constant" })
	hi("@constant.macro", { link = "Constant" })
	hi("@module", { fg = colors.cyan })
	hi("@label", { link = "Label" })
	hi("@string", { link = "String" })

	hi("@string.escape", { fg = colors.teal })
	hi("@string.special", { fg = colors.teal })
	hi("@character", { link = "Character" })
	hi("@boolean", { link = "Boolean" })
	hi("@number", { link = "Number" })
	hi("@float", { link = "Float" })
	hi("@function", { link = "Function" })
	hi("@function.builtin", { link = "Function" })
	hi("@function.call", { link = "Function" })
	hi("@function.macro", { link = "Function" })
	hi("@method", { link = "Function" })
	hi("@constructor", { fg = colors.cyan })
	hi("@parameter", { fg = colors.fg })
	hi("@keyword", { link = "Keyword" })
	hi("@keyword.function", { link = "Keyword" })
	hi("@keyword.return", { link = "Keyword" })
	hi("@conditional", { link = "Conditional" })
	hi("@repeat", { link = "Repeat" })
	hi("@exception", { link = "Exception" })
	hi("@type", { link = "Type" })
	hi("@type.builtin", { link = "Type" })
	hi("@attribute", { fg = colors.green })
	hi("@include", { link = "Include" })
	hi("@preproc", { link = "PreProc" })
	hi("@comment", { link = "Comment" })
	hi("@operator", { link = "Operator" })
	hi("@punctuation.delimiter", { link = "Delimiter" })
	hi("@punctuation.bracket", { fg = colors.fg })
	hi("@punctuation.special", { link = "Special" })
	hi("@tag", { link = "Tag" })
	hi("@tag.delimiter", { fg = colors.blue5 })
	hi("@text", { fg = colors.fg })
	hi("@text.emphasis", { gui = "italic" })
	hi("@text.strong", { gui = "bold" })
	hi("@text.uri", { fg = colors.blue4, gui = "underline" })
	hi("Operator", { fg = colors.teal }) -- Base operators: + - * / %
	-- TreeSitter specific operator highlights
	hi("@operator", { fg = colors.teal }) -- All operators
	hi("@keyword.operator", { fg = colors.blue4 }) -- and, or, not, in
	hi("@punctuation.delimiter", { fg = colors.blue5 }) -- , ; .
	hi("@punctuation.bracket", { fg = colors.fg }) -- () [] {}
	hi("@punctuation.special", { fg = colors.magenta }) -- Special punctuation
	-- Language-specific operator highlights (for better granularity)
	hi("@operator.assignment", { fg = colors.blue4 }) -- = += -= *= /= %=
	hi("@operator.comparison", { fg = colors.purple }) -- == != < > <= >=
	hi("@operator.arithmetic", { fg = colors.teal }) -- + - * / %
	hi("@operator.bitwise", { fg = colors.orange }) -- & | ^ ~ << >>
	hi("@operator.logical", { fg = colors.green }) -- && || !
	-- LSP support
	hi("DiagnosticError", { fg = colors.red })
	hi("DiagnosticWarn", { fg = colors.orange })
	hi("DiagnosticInfo", { fg = colors.blue4 })
	hi("DiagnosticHint", { fg = colors.green })
	hi("DiagnosticUnderlineError", { gui = "undercurl", sp = colors.red })
	hi("DiagnosticUnderlineWarn", { gui = "undercurl", sp = colors.orange })
	hi("DiagnosticUnderlineInfo", { gui = "undercurl", sp = colors.blue4 })
	hi("DiagnosticUnderlineHint", { gui = "undercurl", sp = colors.green })

	-- Git signs
	hi("GitSignsAdd", { fg = colors.green })
	hi("GitSignsChange", { fg = colors.blue4 })
	hi("GitSignsDelete", { fg = colors.red })

	-- Telescope
	hi("TelescopeNormal", { fg = colors.fg, bg = colors.bg })
	hi("TelescopeBorder", { fg = colors.blue2 })
	hi("TelescopeSelection", { bg = colors.blue1 })
	hi("TelescopeSelectionCaret", { fg = colors.red })
	hi("TelescopeMultiSelection", { fg = colors.purple })
	hi("TelescopeMatching", { fg = colors.orange, gui = "bold" })

	-- NvimTree
	hi("NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
	hi("NvimTreeFolderIcon", { fg = colors.blue4 })
	hi("NvimTreeFolderName", { fg = colors.blue4 })
	hi("NvimTreeOpenedFolderName", { fg = colors.blue4, gui = "bold" })
	hi("NvimTreeRootFolder", { fg = colors.purple, gui = "bold" })
	hi("NvimTreeSpecialFile", { fg = colors.magenta })
	hi("NvimTreeExecFile", { fg = colors.green })
	hi("NvimTreeGitDirty", { fg = colors.orange })
	hi("NvimTreeGitNew", { fg = colors.green })
	hi("NvimTreeGitDeleted", { fg = colors.red })

	-- Which Key
	hi("WhichKey", { fg = colors.purple })
	hi("WhichKeyGroup", { fg = colors.blue4 })
	hi("WhichKeyDesc", { fg = colors.fg })
	hi("WhichKeySeparator", { fg = colors.gray1 })
	hi("WhichKeyFloat", { bg = colors.bg })

	-- Indent Blankline

	-- Indent Blankline (add this section where the old one was)
	hi("IblIndent", { fg = colors.gray3 })
	hi("IblWhitespace", { fg = colors.gray3 })
	hi("IblScope", { fg = colors.blue2 })
	-- Add numbered variants that indent-blankline expects
	hi("IblIndent1", { fg = colors.gray3 })
	hi("IblIndent2", { fg = colors.gray3 })
	hi("IblIndent3", { fg = colors.gray3 })
	hi("IblIndent4", { fg = colors.gray3 })
	hi("IblIndent5", { fg = colors.gray3 })
	hi("IblIndent6", { fg = colors.gray3 })
	hi("IblIndent7", { fg = colors.gray3 })
	hi("IblIndent8", { fg = colors.gray3 })
	-- Old names for compatibility
	hi("IndentBlanklineChar", { fg = colors.gray3 })
	hi("IndentBlanklineContextChar", { fg = colors.blue2 }) -- Store colors for lualine
	M.colors = colors
end

-- Lualine theme
M.get_lualine_theme = function()
	local colors = M.colors
		or {
			fg = "#404040",
			bg = "#f0f0f0",
			blue1 = "#c0d0e0",
			blue2 = "#4b5e81",
			blue3 = "#2a3a57",
			green = "#2a9400",
			red = "#c40020",
			purple = "#7800c4",
			orange = "#ff8a00",
			gray1 = "#909090",
		}

	return {
		normal = {
			a = { fg = colors.white or "#ffffff", bg = colors.blue3, gui = "bold" },
			b = { fg = colors.fg, bg = colors.blue1 },
			c = { fg = colors.fg, bg = colors.bg },
		},
		insert = {
			a = { fg = colors.white or "#ffffff", bg = colors.green, gui = "bold" },
			b = { fg = colors.fg, bg = colors.blue1 },
			c = { fg = colors.fg, bg = colors.bg },
		},
		visual = {
			a = { fg = colors.white or "#ffffff", bg = colors.purple, gui = "bold" },
			b = { fg = colors.fg, bg = colors.blue1 },
			c = { fg = colors.fg, bg = colors.bg },
		},
		replace = {
			a = { fg = colors.white or "#ffffff", bg = colors.red, gui = "bold" },
			b = { fg = colors.fg, bg = colors.blue1 },
			c = { fg = colors.fg, bg = colors.bg },
		},
		command = {
			a = { fg = colors.white or "#ffffff", bg = colors.orange, gui = "bold" },
			b = { fg = colors.fg, bg = colors.blue1 },
			c = { fg = colors.fg, bg = colors.bg },
		},
		inactive = {
			a = { fg = colors.gray1, bg = colors.blue1 },
			b = { fg = colors.gray1, bg = colors.bg },
			c = { fg = colors.gray1, bg = colors.bg },
		},
	}
end

return M
