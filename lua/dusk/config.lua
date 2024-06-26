local M = {}

---@class Config
---@field colors fun(colors: ColorScheme)
---@field highlights fun(highlights: Highlights, colors: ColorScheme)
local defaults = {
  style = "vivid", -- The theme comes in three styles, `normal`, a darker variant `night` and `light`
  light_style = "light", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    bold = { bold = true },
    bold_italic = { bold = true, italic = true },
    conditionals = {},
    comments = { italic = true },
    functions = { bold = true },
    italic = { italic = true },
    keywords = { italic = true, bold = true },
    links = { underline = true, italic = true },
    loops = {},
    macros = { bold = true, italic = true },
    numbers = {},
    operators = {},
    properties = {},
    strings = {},
    types = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help", "terminal" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  brightness = 0.3, -- Adjusts the brightness of the colors of the **light** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  override = {
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    highlights = function(highlights, colors) end,
  },
  use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
}

---@type Config
M.options = {}

---@param options Config|nil
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

---@param options Config|nil
function M.extend(options)
  M.options = vim.tbl_deep_extend("force", {}, M.options or defaults, options or {})
end

function M.light_mode()
  return M.options.style == "light" or M.options.use_background and vim.o.background == "light"
end

M.setup()

return M
