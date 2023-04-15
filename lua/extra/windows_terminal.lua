local util = require("dusk.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local windows_terminal = util.template([[
# Add the following object to your Windows Terminal configuration
# https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes#creating-your-own-color-scheme
{
    "background": "${bg}",
    "black": "${black}",
    "blue": "${blue}",
    "brightBlack": "${window.bg}",
    "brightBlue": "${blue}",
    "brightCyan": "${cyan}",
    "brightGreen": "${green}",
    "brightPurple": "${purple}",
    "brightRed": "${red}",
    "brightWhite": "${white}",
    "brightYellow": "${yellow}",
    "cursorColor": "${white}",
    "cyan": "${cyan}",
    "foreground": "${white}",
    "green": "${green}",
    "name": "${_style_name}",
    "purple": "${magenta}",
    "red": "${red}",
    "selectionBackground": "${bg_visual}",
    "white": "${white}",
    "yellow": "${yellow}"
}
]],
    colors
  )
  return windows_terminal
end

return M
