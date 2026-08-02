------------------------
---- AUTOSTART -------
------------------------
-- exec-once has no direct keyword anymore; hook the session-start event instead
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd(terminal)
end)
