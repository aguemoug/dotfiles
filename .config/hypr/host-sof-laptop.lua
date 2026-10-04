---
---- MONITORS ----------
local INTERNAL = "eDP-1"
local EXTERNAL = "" -- check with: hyprctl monitors

-- hl.bind(mainMod .. " + F8", toggleMirror)
--
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })
------------------------
---- GESTURES ----------
------------------------
hl.gesture({
	fingers = 3,
	direction = "swipe",
	action = "move",
})
hl.gesture({
	fingers = 3,
	direction = "pinch",
	action = "fullscreen",
})
hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})
-- NOTE: these need quickshell running (it is not started in AUTOSTART below)
hl.gesture({
	fingers = 4,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
	end,
})
hl.gesture({
	fingers = 4,
	direction = "down",
	action = function()
		hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
	end,
})

return {
	INTERNAL = "eDP-1",
	EXTERNAL = "", -- empty = any monitor without its own rule
}
