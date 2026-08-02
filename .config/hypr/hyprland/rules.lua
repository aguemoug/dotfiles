--------------------------------------
---- WORKSPACE -> MONITOR MAPPING ----
--------------------------------------
-- hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-3", default = true })
-- hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-3" })
-- hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-3" })
--
-- hl.workspace_rule({ workspace = "0", monitor = "DP-1", default = true })
-- hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
--
-------------------------
---- WINDOW RULES  -----
-------------------------
hl.window_rule({ match = { title = "^(pavucontrol)$" }, float = true })
hl.window_rule({ match = { title = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { title = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { title = "^(qalculate-gtk)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "ModernGL" }, workspace = "9", border_size = 10 })
hl.window_rule({ match = { class = "mpv" }, workspace = "9", border_size = 10 })
