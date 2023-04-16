local util = require("dusk.util")
local colors = require("dusk.colors")

local M = {}
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
  local config = require("dusk.config")
  local options = config.options
  ---@class Theme
  ---@field highlights Highlights
  local theme = {
    config = options,
    colors = colors.setup(),
  }

  local c = theme.colors

  theme.highlights = {
    Comment = { fg = c.window.muted_fg, style = options.styles.comments }, -- any comment
    ColorColumn = { bg = c.black }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.white }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.black, bg = c.white }, -- character under the cursor
    lCursor = { fg = c.black, bg = c.white }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { fg = c.black, bg = c.white }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.window.bg }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.window.bg }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = c.blue }, -- directory names (and other special names in listings)
    DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer = { fg = c.window.bg2 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    ErrorMsg = { fg = c.error }, -- error messages on the command line
    VertSplit = { fg = c.border }, -- the column separating vertically split windows
    WinSeparator = { fg = c.border, bold = true }, -- the column separating vertically split windows
    Folded = { fg = c.blue, bg = c.white }, -- line used for closed folds
    FoldColumn = { bg = options.transparent and c.none or c.black, fg = c.window.muted_fg }, -- 'foldcolumn'
    SignColumn = { bg = options.transparent and c.none or c.black, fg = c.white }, -- column where |signs| are displayed
    SignColumnSB = { bg = c.black, fg = c.white }, -- column where |signs| are displayed
    Substitute = { bg = c.red, fg = c.black }, -- |:substitute| replacement text highlighting
    LineNr = { fg = c.gutter.muted_fg }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = c.gutter.focus_fg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.orange, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.white, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.white, bg = c.black }, -- Area for messages and cmdline
    MoreMsg = { fg = c.blue }, -- |more-prompt|
    NonText = { fg = c.window.muted_fg }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.white, bg = options.transparent and c.none or c.black }, -- normal text
    NormalNC = { fg = c.white, bg = options.transparent and c.none or options.dim_inactive and c.black or c.black }, -- normal text in non-current windows
    NormalSB = { fg = c.white, bg = c.black }, -- normal text in sidebar
    NormalFloat = { fg = c.white, bg = c.window.bg }, -- Normal text in floating windows.
    FloatBorder = { fg = c.window.bg2, bg = c.window.bg },
    Pmenu = { bg = c.window.bg, fg = c.white }, -- Popup menu: normal item.
    PmenuSel = { bg = c.window.bg1 }, -- Popup menu: selected item.
    PmenuSbar = { bg = util.lighten(c.window.bg, 0.95) }, -- Popup menu: scrollbar.
    PmenuThumb = { bg = util.darken(c.white, 0.50) }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.window.bg, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { bg = c.yellow, fg = c.black }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { bg = c.orange, fg = c.black }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.window.muted_fg }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.white, bg = c.statusline }, -- status line of current window
    StatusLineNC = { fg = c.gutter.muted_fg, bg = c.window.bg }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine = { bg = c.window.bg, fg = c.white }, -- tab pages line, not active tab page label
    TabLineFill = { bg = c.window.bg, fg = c.window.bg }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.black, bg = c.blue }, -- tab pages line, active tab page label
    Title = { fg = c.cyan, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = c.window.bg }, -- Visual mode selection
    VisualNOS = { bg = c.window.bg }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.warning }, -- warning messages
    Whitespace = { fg = c.window.bg }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { bg = c.blue }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant = { fg = c.orange }, -- (preferred) any constant
    String = { fg = c.green, style = options.styles.string }, --   a string constant: "this is a string"
    Character = { fg = c.orange }, --  a character constant: 'c', '\n'
    -- Number        = { }, --   a number constant: 234, 0xff
    -- Boolean       = { }, --  a boolean constant: TRUE, false
    -- Float         = { }, --    a floating point constant: 2.3e10

    Identifier = { fg = c.red, style = options.styles.variables }, -- (preferred) any variable name
    Function = { fg = c.blue, style = options.styles.functions }, -- function name (also: methods for classes)

    Statement = { fg = c.magenta }, -- (preferred) any statement
    -- Conditional   = { }, --  if, then, else, endif, switch, etc.
    -- Repeat        = { }, --   for, do, while, etc.
    -- Label         = { }, --    case, default, etc.
    Operator = { fg = c.white }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.magenta, style = options.styles.keywords }, --  any other keyword
    -- Exception     = { }, --  try, catch, throw

    PreProc = { fg = c.magenta }, -- (preferred) generic Preprocessor
    -- Include       = { }, --  preprocessor #include
    -- Define        = { }, --   preprocessor #define
    -- Macro         = { }, --    same as Define
    -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = c.yellow }, -- (preferred) int, long, char, etc.
    -- StorageClass  = { }, -- static, register, volatile, etc.
    -- Structure     = { }, --  struct, union, enum, etc.
    -- Typedef       = { }, --  A typedef

    Special = { fg = c.red }, -- (preferred) any special symbol
    -- SpecialChar   = { }, --  special character in a constant
    -- Tag           = { }, --    you can use CTRL-] on this
    -- Delimiter     = { }, --  character that needs attention
    -- SpecialComment= { }, -- special things inside a comment
    -- Debug         = { }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },

    -- ("Ignore", below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.error }, -- (preferred) any erroneous construct
    Todo = { bg = c.yellow, fg = c.black }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    qfLineNr = { fg = c.gutter.focus_fg },
    qfFileName = { fg = c.blue },

    htmlH1 = { fg = c.magenta, bold = true },
    htmlH2 = { fg = c.blue, bold = true },

    -- mkdHeading = { fg = c.orange, bold = true },
    -- mkdCode = { bg = c.window.bg, fg = c.white },
    mkdCodeDelimiter = { bg = c.black, fg = c.white },
    mkdCodeStart = { fg = c.cyan, bold = true },
    mkdCodeEnd = { fg = c.cyan, bold = true },
    -- mkdLink = { fg = c.blue, underline = true },

    markdownHeadingDelimiter = { fg = c.orange, bold = true },
    markdownCode = { fg = c.cyan },
    markdownCodeBlock = { fg = c.cyan },
    markdownH1 = { fg = c.magenta, bold = true },
    markdownH2 = { fg = c.blue, bold = true },
    markdownLinkText = { fg = c.blue, underline = true },

    ["helpCommand"] = { bg = c.black, fg = c.blue },

    debugPC = { bg = c.black }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText = { bg = c.white }, -- used for highlighting "text" references
    LspReferenceRead = { bg = c.white }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = c.white }, -- used for highlighting "write" references

    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

    DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

    LspSignatureActiveParameter = { bg = util.darken(c.blue, 0.4), bold = true },
    LspCodeLens = { fg = c.window.muted_fg },
    LspInfoBorder = { fg = c.window.bg, bg = c.window.bg },

    -- TODO:
    -- [""] = { },
    ["@operator"] = { fg = c.white }, -- For any operator: `+`, but also `->` and `*` in C.
    ["@punctuation.delimiter"] = { fg = c.white }, -- For delimiters ie: `.`
    ["@punctuation.bracket"] = { fg = c.white }, -- For brackets and parens.
    ["@punctuation.special"] = { fg = c.red }, -- For special punctutation that does not fall in the catagories before.
    ["@punctuation.special.markdown"] = { fg = c.orange, bold = true },

    ["@string.documentation"] = { fg = c.yellow },
    ["@string.regex"] = { fg = c.cyan },
    ["@string.escape"] = { fg = c.red }, -- For escape characters within a string.

    ["@constructor"] = { fg = c.yellow, bold = true }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@parameter"] = { fg = c.orange }, -- For parameters of a function.
    ["@functions"] = { fg = c.blue },
    ["@functions.builtin"] = { fg = c.blue, italic = true },

    -- TODO:
    -- ["@keyword.coroutine"] = { }, -- For keywords related to coroutines.
    ["@keyword"] = { fg = c.magenta, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
    ["@keyword.function"] = { fg = c.magenta, style = options.styles.functions }, -- For keywords used to define a fuction.
    ["@keyword.operator"] = { fg = c.magenta, style = options.styles.keywords },

    ["@label"] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.

    ["@field"] = { fg = c.red }, -- For fields.
    ["@property"] = { fg = c.red },

    ["@variable"] = { fg = c.white, style = options.styles.variables }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.red, italic = true }, -- Variable names that are defined by the languages, like `this` or `self`.

    ["@text.literal.markdown"] = { link = "Normal" },
    ["@text.literal.markdown_inline"] = { bg = c.black, fg = c.blue },
    ["@text.reference"] = { fg = c.cyan },

    ["@text.todo.unchecked"] = { fg = c.blue }, -- For brackets and parens.
    ["@text.todo.checked"] = { fg = c.green }, -- For brackets and parens.
    ["@text.warning"] = { fg = c.black, bg = c.warning },
    ["@text.danger"] = { fg = c.black, bg = c.error },

    ["@text.diff.add"] = { link = "DiffAdd" },
    ["@text.diff.delete"] = { link = "DiffDelete" },

    ["@namespace"] = { link = "Include" },

    -- LSP Semantic Token Groups
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "Identifier" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.globalScope"] = { fg = c.red, bold = true },

    -- LspTrouble
    TroubleText = { fg = c.white },
    TroubleCount = { fg = c.magenta, bg = c.white },
    TroubleNormal = { fg = c.white, bg = c.black },

    -- Illuminate
    illuminatedWord = { bg = c.window.bg1 },
    illuminatedCurWord = { bg = c.window.bg1 },
    IlluminatedWordText = { bg = c.window.bg1 },
    IlluminatedWordRead = { bg = c.window.bg1 },
    IlluminatedWordWrite = { bg = c.window.bg1 },

    -- diff
    diffAdded = { fg = c.git.add },
    diffRemoved = { fg = c.git.delete },
    diffChanged = { fg = c.git.change },
    diffOldFile = { fg = c.yellow },
    diffNewFile = { fg = c.orange },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.window.muted_fg },
    diffIndexLine = { fg = c.magenta },

    -- Neogit
    -- NeogitBranch = { fg = c.magenta },
    -- NeogitRemote = { fg = c.magenta },
    -- NeogitHunkHeader = { bg = c.window.bg, fg = c.white },
    -- NeogitHunkHeaderHighlight = { bg = c.white, fg = c.blue },
    -- NeogitDiffContextHighlight = { bg = util.darken(c.white, 0.5), fg = c.white_dark },
    -- NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
    -- NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

    -- Neotest
    -- NeotestPassed = { fg = c.green },
    -- NeotestRunning = { fg = c.yellow },
    -- NeotestFailed = { fg = c.red },
    -- NeotestSkipped = { fg = c.blue },
    -- NeotestTest = { fg = c.white },
    -- NeotestNamespace = { fg = c.green },
    -- NeotestFocused = { fg = c.yellow },
    -- NeotestFile = { fg = c.cyan },
    -- NeotestDir = { fg = c.blue },
    -- NeotestBorder = { fg = c.blue },
    -- NeotestIndent = { fg = c.white },
    -- NeotestExpandMarker = { fg = c.white },
    -- NeotestAdapterName = { fg = c.magenta, bold = true },
    -- NeotestWinSelect = { fg = c.blue },
    -- NeotestMarked = { fg = c.blue },
    -- NeotestTarget = { fg = c.blue },
    --[[ NeotestUnknown = {}, ]]

    GitSignsAdd = { fg = c.git.add }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.git.change }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.git.delete }, -- diff mode: Deleted line |diff.txt|

    TelescopeBorder = { bg = c.window.bg, fg = c.gutter.muted_fg },
    TelescopeNormal = { bg = c.window.bg },
    TelescopeTitle = { bg = c.window.bg, bold = true },
    TelescopeSelection = { bg = c.window.bg1 },
    TelescopeSelectionCaret = { fg = c.yellow },

    NeoTreeNormal = { fg = c.white, bg = options.transparent and c.none or c.window.bg },
    NeoTreeNormalNC = { fg = c.white, bg = options.transparent and c.none or c.window.bg },
    NeoTreeFloatBorder = { fg = c.window.bg1, bg = c.window.bg1 },
    NeoTreeEndOfBuffer = { fg = c.window.bg, bg = options.transparent and c.none or c.window.bg },
    NeoTreeDimText = { fg = c.window.muted_fg },
    NeoTreeWinSeparator = { fg = c.gutter.muted_fg, bg = options.transparent and c.none or c.black },
    NeoTreeTabActive = { bg = c.window.bg },
    NeoTreeTabInactive = { bg = c.black },
    NeoTreeTabSeparatorActive = { bg = c.window.bg, fg = c.window.bg },
    NeoTreeTabSeparatorInactive = { bg = c.black, fg = c.black },
    NeoTreeSymbolicLinkTarget = { fg = colors.cyan },

    AlphaShortcut = { fg = c.orange },
    AlphaHeader = { fg = c.green },
    AlphaHeaderLabel = { fg = c.orange },
    AlphaFooter = { fg = c.blue, bold = true },
    AlphaButtons = { fg = c.cyan },

    WhichKey = { fg = c.red, bold = true },
    WhichKeyGroup = { fg = c.orange },
    WhichKeyDesc = { fg = c.blue },
    WhichKeySeperator = { fg = c.window.muted_fg },
    WhichKeyFloat = { bg = c.float_bg },

    healthError = { fg = c.error },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.warning },

    BufferLineIndicatorSelected = { fg = c.blue },
    BufferLineFill = { bg = c.window.bg },

    TSNodeKey = { fg = c.magenta, bold = true },
    TSNodeUnmatched = { fg = c.window.muted_fg },

    CmpDocumentation = { fg = c.white, bg = c.window.bg },
    CmpDocumentationBorder = { fg = c.window.bg, bg = c.window.bg },

    CmpItemAbbr = { fg = c.white, bg = c.none },
    CmpItemAbbrDeprecated = { fg = c.white, bg = c.none, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.blue, bg = c.none },
    CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = c.none },

    CmpItemMenu = { fg = c.window.muted_fg, bg = c.none },

    -- TODO: link these to treesitter settings
    CmpItemKindKeyword = { fg = c.magenta, bg = c.none },
    CmpItemKindVariable = { fg = c.magenta, bg = c.none },
    CmpItemKindConstant = { fg = c.magenta, bg = c.none },
    CmpItemKindReference = { fg = c.magenta, bg = c.none },
    CmpItemKindValue = { fg = c.magenta, bg = c.none },

    CmpItemKindCopilot = { fg = c.cyan, bg = c.none },

    CmpItemKindFunction = { fg = c.blue, bg = c.none },
    CmpItemKindMethod = { fg = c.blue, bg = c.none },
    CmpItemKindConstructor = { fg = c.blue, bg = c.none },

    CmpItemKindClass = { fg = c.yellow, bg = c.none },
    CmpItemKindInterface = { fg = c.yellow, bg = c.none },
    CmpItemKindStruct = { fg = c.yellow, bg = c.none },
    CmpItemKindEvent = { fg = c.yellow, bg = c.none },
    CmpItemKindEnum = { fg = c.yellow, bg = c.none },
    CmpItemKindModule = { fg = c.yellow, bg = c.none },

    CmpItemKindUnit = { fg = c.orange, bg = c.none },

    CmpItemKindProperty = { fg = c.red, bg = c.none },
    CmpItemKindField = { fg = c.red, bg = c.none },
    CmpItemKindSnippet = { fg = c.red, bg = c.none },

    CmpItemKindTypeParameter = { fg = c.orange, bg = c.none },
    CmpItemKindEnumMember = { fg = c.orange, bg = c.none },
    CmpItemKindOperator = { fg = c.white, bg = c.none },

    -- navic
    NavicIconsFile = { fg = c.white, bg = c.none },
    NavicIconsModule = { fg = c.yellow, bg = c.none },
    NavicIconsNamespace = { fg = c.white, bg = c.none },
    NavicIconsPackage = { fg = c.magenta, bg = c.none },
    NavicIconsClass = { fg = c.yellow, bg = c.none },
    NavicIconsMethod = { fg = c.blue, bg = c.none },
    NavicIconsProperty = { fg = c.red, bg = c.none },
    NavicIconsField = { fg = c.red, bg = c.none },
    NavicIconsConstructor = { fg = c.yellow, bg = c.none },
    NavicIconsEnum = { fg = c.yellow, bg = c.none },
    NavicIconsInterface = { fg = c.yellow, bg = c.none },
    NavicIconsFunction = { fg = c.blue, bg = c.none },
    NavicIconsVariable = { fg = c.white, bg = c.none },
    NavicIconsConstant = { fg = c.orange, bg = c.none },
    NavicIconsString = { fg = c.green, bg = c.none },
    NavicIconsNumber = { fg = c.orange, bg = c.none },
    NavicIconsBoolean = { fg = c.orange, bg = c.none },
    NavicIconsArray = { fg = c.yellow, bg = c.none },
    NavicIconsObject = { fg = c.yellow, bg = c.none },
    NavicIconsKey = { fg = c.magenta, bg = c.none },
    NavicIconsKeyword = { fg = c.magenta, bg = c.none },
    NavicIconsNull = { fg = c.orange, bg = c.none },
    NavicIconsEnumMember = { fg = c.orange, bg = c.none },
    NavicIconsStruct = { fg = c.yellow, bg = c.none },
    NavicIconsEvent = { fg = c.yellow, bg = c.none },
    NavicIconsOperator = { fg = c.white, bg = c.none },
    NavicIconsTypeParameter = { fg = c.orange, bg = c.none },
    NavicText = { fg = c.window.muted_fg, bg = c.none },
    NavicSeparator = { fg = c.window.muted_fg, bg = c.none },

    IndentBlanklineChar = { fg = c.window.bg, nocombine = true },
    IndentBlanklineSpaceChar = { fg = c.black, nocombine = true },
    IndentBlanklineContextChar = { fg = c.magenta, nocombine = true },

    LazyButtonActive = { bg = c.blue },
    LazyProgressDone = { bold = true, fg = c.magenta },
    LazyProgressTodo = { bold = true, fg = c.white },

    NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.black },
    NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.black },
    NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.black },
    NotifyDEBUGBorder = { fg = util.darken(c.window.muted_fg, 0.3), bg = options.transparent and c.none or c.black },
    NotifyTRACEBorder = { fg = util.darken(c.magenta, 0.3), bg = options.transparent and c.none or c.black },

    NotifyERRORIcon = { fg = c.error },
    NotifyWARNIcon = { fg = c.warning },
    NotifyINFOIcon = { fg = c.info },
    NotifyDEBUGIcon = { fg = c.window.muted_fg },
    NotifyTRACEIcon = { fg = c.magenta },

    NotifyERRORTitle = { fg = c.error },
    NotifyWARNTitle = { fg = c.warning },
    NotifyINFOTitle = { fg = c.info },
    NotifyDEBUGTitle = { fg = c.window.muted_fg },
    NotifyTRACETitle = { fg = c.magenta },

    NotifyERRORBody = { fg = c.white, bg = options.transparent and c.none or c.black },
    NotifyWARNBody = { fg = c.white, bg = options.transparent and c.none or c.black },
    NotifyINFOBody = { fg = c.white, bg = options.transparent and c.none or c.black },
    NotifyDEBUGBody = { fg = c.white, bg = options.transparent and c.none or c.black },
    NotifyTRACEBody = { fg = c.white, bg = options.transparent and c.none or c.black },

    MiniCompletionActiveParameter = { underline = true },
    MiniCursorword = { bg = c.window.bg1 },
    MiniCursorwordCurrent = { bg = c.window.bg1 },

    MiniIndentscopeSymbol = { fg = c.yellow },
    MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible

    MiniJump = { bg = c.magenta, fg = "#ffffff" },
    MiniJump2dSpot = { fg = c.magenta, bold = true, nocombine = true },

    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.yellow, italic = true },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.window.muted_fg, style = options.styles.comments },
    MiniStarterItem = { fg = c.white, bg = options.transparent and c.none or c.black },
    MiniStarterItemBullet = { fg = c.border_highlight },
    MiniStarterItemPrefix = { fg = c.warning },
    MiniStarterSection = { fg = c.blue },
    MiniStarterQuery = { fg = c.info },

    -- MiniStatuslineDevinfo = { fg = c.white, bg = c.window.bg },
    -- MiniStatuslineFileinfo = { fg = c.window.muted_fg, bg = c.window.bg1 },
    -- MiniStatuslineFilename = { fg = c.window.muted_fg, bg = c.window.bg1 },
    -- MiniStatuslineInactive = { fg = c.blue, bg = c.black_statusline },
    -- MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
    -- MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
    -- MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
    -- MiniStatuslineModeOther = { fg = c.black, bg = c.cyan, bold = true },
    -- MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
    -- MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },

    MiniSurround = { bg = c.orange, fg = c.black },

    -- MiniTablineCurrent = { fg = c.white, bg = c.white },
    -- MiniTablineFill = { bg = c.black },
    -- MiniTablineHidden = { fg = c.dark5, bg = c.black_statusline },
    -- MiniTablineModifiedCurrent = { fg = c.warning, bg = c.white },
    -- MiniTablineModifiedHidden = { bg = c.black_statusline, fg = util.darken(c.warning, 0.7) },
    -- MiniTablineModifiedVisible = { fg = c.warning, bg = c.black_statusline },
    -- MiniTablineTabpagesection = { bg = c.black_statusline, fg = c.none },
    -- MiniTablineVisible = { fg = c.white, bg = c.black_statusline },

    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.red, bold = true },
    MiniTestPass = { fg = c.green, bold = true },

    MiniTrailspace = { bg = c.red },

    NoiceCompletionItemKindDefault = { fg = c.white, bg = c.none },
    NoiceCompletionItemKindKeyword = { fg = c.magenta, bg = c.none, italic = true, bold = true },

    NoiceCompletionItemKindVariable = { fg = c.magenta, bg = c.none },
    NoiceCompletionItemKindReference = { fg = c.magenta, bg = c.none },
    NoiceCompletionItemKindValue = { fg = c.magenta, bg = c.none },

    NoiceCompletionItemKindFunction = { fg = c.blue, bg = c.none, bold = true },
    NoiceCompletionItemKindMethod = { fg = c.blue, bg = c.none, italic = true },
    NoiceCompletionItemKindConstructor = { fg = c.blue, bg = c.none },

    NoiceCompletionItemKindConstant = { fg = c.orange, bg = c.none },
    NoiceCompletionItemKindEvent = { fg = c.orange, bg = c.none },
    NoiceCompletionItemKindUnit = { fg = c.orange, bg = c.none },
    NoiceCompletionItemKindTypeParameter = { fg = c.orange, bg = c.none },
    NoiceCompletionItemKindEnumMember = { fg = c.orange, bg = c.none, bold = true },

    NoiceCompletionItemKindInterface = { fg = c.yellow, bg = c.none },
    NoiceCompletionItemKindEnum = { fg = c.yellow, bg = c.none },
    NoiceCompletionItemKindClass = { fg = c.yellow, bg = c.none },
    NoiceCompletionItemKindModule = { fg = c.yellow, bg = c.none },
    NoiceCompletionItemKindStruct = { fg = c.yellow, bg = c.none },

    NoiceCompletionItemKindSnippet = { fg = c.red, bg = c.none },
    NoiceCompletionItemKindProperty = { fg = c.red, bg = c.none },
    NoiceCompletionItemKindField = { fg = c.red, bg = c.none },
    NoiceCompletionItemKindOperator = { fg = c.white, bg = c.none },

    -- TreesitterContext = { bg = util.darken(c.white, 0.8) },
    -- TreesitterContext = { bg = util.darken(c.bg_visual, 0.4) },
  }

  if not vim.diagnostic then
    local severity_map = {
      Error = "Error",
      Warn = "Warning",
      Info = "Information",
      Hint = "Hint",
    }
    local types = { "Default", "VirtualText", "Underline" }
    for _, type in ipairs(types) do
      for snew, sold in pairs(severity_map) do
        theme.highlights["LspDiagnostics" .. type .. sold] = {
          link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
        }
      end
    end
  end

  ---@type table<string, table>
  theme.defer = {}

  if options.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.none, fg = c.window.bg, sp = c.border }

    -- StatusLineNC
    theme.highlights.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ "a", "b", "c" }) do
      theme.defer["lualine_" .. section .. "_inactive"] = inactive
    end

    -- mini.statusline
    theme.highlights.MiniStatuslineInactive = inactive
  end

  options.override.highlights(theme.highlights, theme.colors)

  if config.light_mode() then
    util.invert_colors(theme.colors)
    util.invert_highlights(theme.highlights)
  end

  return theme
end

return M
