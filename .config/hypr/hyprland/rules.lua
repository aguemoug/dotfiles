--------------------------------------
---- WORKSPACE -> MONITOR MAPPING ----
--------------------------------------
for i = 0, 5 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "DP-2",
		default = i == 0,
	})
end

for i = 6, 9 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "DO- 1",
	})
end

hl.workspace_rule({
	workspace = "scratch",
	monitor = "DO- 1",
})
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
