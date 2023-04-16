local colors = require("dusk.colors").setup({ transform = true })
local config = require("dusk.config").options

local dusk = {}

dusk.normal = {
  a = { bg = colors.blue, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
  c = { bg = colors.window.bg, fg = colors.window.muted_fg },
}

dusk.insert = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
}

dusk.command = {
  a = { bg = colors.yellow, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
}

dusk.visual = {
  a = { bg = colors.magenta, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
}

dusk.replace = {
  a = { bg = colors.red, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
}

dusk.terminal = {
  a = { bg = colors.green, fg = colors.black },
  b = { bg = colors.window.bg1, fg = colors.white },
}

dusk.inactive = {
  a = { bg = colors.window.bg, fg = colors.window.muted_fg },
  b = { bg = colors.window.bg, fg = colors.window.bg1, gui = "bold" },
  c = { bg = colors.window.bg, fg = colors.window.bg1 },
}

if config.lualine_bold then
  for _, mode in pairs(dusk) do
    mode.a.gui = "bold"
  end
end

return dusk
