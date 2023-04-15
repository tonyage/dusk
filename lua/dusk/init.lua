local util = require("dusk.util")
local theme = require("dusk.theme")
local config = require("dusk.config")

local M = {}

function M._load(style)
  if style and not M._style then
    M._style = require("dusk.config").options.style
  end
  if not style and M._style then
    require("dusk.config").options.style = M._style
    M._style = nil
  end
  M.load({ style = style, background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
  if opts then
    require("dusk.config").extend(opts)
  end
  util.load(theme.setup())
end

M.setup = config.setup
M.colorscheme = M.load

return M
