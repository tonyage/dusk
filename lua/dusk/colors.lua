local util = require("dusk.util")

local M = {}

-- local gradients = {}
--
-- gradients.dark = {
--   black   = "#000000",
--   black00 = "#161616",
--   black05 = "#222222",
--   black10 = "#2d2d2d",
--   black15 = "#393939",
--   black20 = "#454545",
--   black25 = "#505050",
--   black90 = "#707070",
-- }
--
-- gradients.light = {
--   white   = "#ffffff",
--   white00 = "#abb2bf",
--   white05 = "#b5bcc9",
--   white10 = "#b9bfcc",
--   white15 = "#bcc3ce",
--   white20 = "#c4c9d4",
--   white25 = "#c7cdd6",
--   white90 = "#f8f8fa",
-- }

local palette = {
  none    = "NONE",
  black   = "#161616",
  red     = "#e54f65",
  green   = "#89ca78",
  yellow  = "#e5c07b",
  blue    = "#61afef",
  magenta = "#c678dd",
  cyan    = "#60c0cc",
  white   = "#abb2bf",
  orange  = "#ea9560",
  pink    = "#de8c92",
  error   = "#f44747",
}

---@class Palette
M.default = {
  none    = palette.none,
  black   = palette.black,
  red     = palette.red,
  green   = palette.green,
  yellow  = palette.yellow,
  blue    = palette.blue,
  magenta = palette.magenta,
  cyan    = palette.cyan,
  white   = palette.white,
  orange  = palette.orange,
  pink    = palette.pink,
  error   = palette.error,

  window = {
    muted_fg = "#505050",
    bg = "#222222",
    bg1 = "#2d2d2d",
    bg2 = "#393939",
  },
  gutter = {
    muted_fg = "#393939",
    focus_fg = palette.white,
  },
  git = {
    add = palette.green,
    change = palette.yellow,
    delete = palette.red
  },
}

---@class Palette
M.vivid = function()
  local theme = {
    none = "NONE",
    black   = "#161616",
    red     = "#ef596f",
    green   = "#93d482",
    yellow  = "#efca85",
    blue    = "#6bb9f9",
    magenta = "#d55fde",
    cyan    = "#6fcfdb",
    white   = "#b5bcc9",
    orange  = "#f49f6a",
    pink    = "#e8969c",
    error   = "#f44747",
  }
  theme.git = {
    add = util.blend(theme.green, theme.black, "ee"),
    change = util.blend(theme.yellow, theme.black, "ee"),
    delete = util.blend(theme.red, theme.black, "dd")
  }
  return theme
end

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("dusk.config")

  local style = config.light_mode() and config.options.light_style or config.options.style
  local colorscheme = M[style] or {}
  if type(colorscheme) == "function" then
    colorscheme = colorscheme()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", M.default, colorscheme)

  util.bg = colors.black
  util.brightness = config.options.brightness

  colors.diff = {
    add = util.darken(colors.green, 0.15),
    delete = util.darken(colors.red, 0.15),
    change = util.darken(colors.blue, 0.15),
    text = colors.black,
  }

  colors.git.ignore = util.lighten(colors.black, 0.25)
  colors.border_highlight = util.darken(colors.blue, 0.8)
  colors.border = util.darken(colors.black, 0.8, "#000000")

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.window.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.window.bg

  colors.bg_visual = util.darken(colors.blue, 0.4)
  colors.bg_search = colors.yellow
  colors.fg_sidebar = colors.white
  colors.fg_float = colors.white

  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.cyan
  colors.hint = colors.magenta

  config.options.override.colors(colors)
  if opts.transform and config.light_mode() then
    util.invert_colors(colors)
  end
  return colors
end

return M
