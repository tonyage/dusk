local util = require("dusk.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
  local tmux = util.template(
    [[
#!/usr/bin/env bash

# dusk colors for Tmux

set -g mode-style "fg=${black},bg=${blue}"

set -g message-style "fg=${black},bg=${blue}"
set -g message-command-style "fg=${black},bg=${blue}"

set -g pane-border-style "fg=${window.bg}"
set -g pane-active-border-style "fg=${green}"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=${blue},bg=${window.bg}"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style ${none}
set -g status-right-style ${none}

set -g status-left "#[fg=${black},bg=${blue},bold] #S #[fg=${blue},bg=${window.bg},nobold,nounderscore,noitalics]"
set -g status-right "#[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]#[fg=${blue},bg=${window.bg}] #{prefix_highlight} #[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]#[fg=${blue},bg=${window.bg}] %Y-%m-%d  %I:%M %p #[fg=${blue},bg=${window.bg},nobold,nounderscore,noitalics]#[fg=${black},bg=${blue},bold] #h "

setw -g window-status-activity-style "underscore,fg=${white},bg=${window.bg}"
setw -g window-status-separator ""
setw -g window-status-style "${none},fg=${white},bg=${window.bg}"
setw -g window-status-format "#[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]#[fg=${blue},bg=${window.bg},bold] #I  #W #F #[fg=${window.bg},bg=${window.bg},nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=${yellow}]#[bg=${window.bg}]#[fg=${window.bg}]#[bg=${yellow}]"
set -g @prefix_highlight_output_suffix ""
]],
    colors
  )
  return tmux
end

return M
