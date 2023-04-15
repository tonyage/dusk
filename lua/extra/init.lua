local M = {}

local function write(str, fileName)
  print("[write] extra/" .. fileName)
  vim.fn.mkdir(vim.fs.dirname("extras/" .. fileName), "p")
  local file = io.open("extras/" .. fileName, "w")
  file:write(str)
  file:close()
end

function M.setup()
  local config = require("dusk.config")
  vim.o.background = "dark"

  local extras = {
    lua = "lua",
    tmux = "tmux",
    delta = "gitconfig",
    windows_terminal = "json",
  }
  -- map of style to style name
  local styles = {
    normal = " matte",
    vivid = " vivid",
  }

  for extra, ext in pairs(extras) do
    package.loaded["dusk.extra." .. extra] = nil
    local plugin = require("dusk.extra." .. extra)
    for style, style_name in pairs(styles) do
      config.setup({ style = style })
      local colors = require("dusk.colors").setup({ transform = true })
      local fname = extra .. "/dusk_" .. style .. "." .. ext
      colors["_upstream_url"] = "https://github.com/tonyage/dusk.nvim/raw/main/extras/" .. fname
      colors["_style_name"] = "Dusk" .. style_name
      write(plugin.generate(colors), fname)
    end
  end
end

return M
