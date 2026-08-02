------------------
---- BINDS -------
------------------
require("hyprland.variables")
require("hyprland.lib")
-- Keyboard layout toggle
hl.bind("ALT + Shift_L", hl.dsp.exec_cmd("hyprctl switchxkblayout main next"), { locked = true })

-- [VERIFY] 3-finger horizontal swipe -> workspace switch.
-- Old: gesture = 3, horizontal, workspace
-- Check the Gestures section of the wiki for the current hl.config({ gestures = {...} })
-- or hl.bind() form — this one I couldn't confirm precisely.

--hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
-- [VERIFY] confirm hl.dsp.workspace.change() takes "e+1"/"e-1" the same way the old relative syntax did
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.change("e+1"))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.change("e-1"))

hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + A", hl.dsp.exec_cmd(ai))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", hl.dsp.exec_cmd(reload_waybar))

hl.bind("SUPER + space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = 0 })) -- fullscreen
--##! Screen
--# Zoom
local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end

hl.bind("SUPER + Minus", function()
	zoomfunction(-0.3)
end, { repeating = true, description = "Screen: Zoom out" })
hl.bind("SUPER + Equal", function()
	zoomfunction(0.3)
end, { repeating = true, description = "Screen: Zoom in" })

--# Zoom with keypad
hl.bind("SUPER + code:82", function()
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind("SUPER + code:86", function()
	zoomfunction(0.3)
end, { repeating = true })
-- Cursor zoom in/out (mainMod + ALT + scroll)
hl.bind("SUPER +  mouse_down", function()
	zoomfunction(0.3)
end)
hl.bind("SUPER +   mouse_up", function()
	zoomfunction(-0.3)
end)

hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

--##! Window
--# Focusing
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Move" })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })
for i = 1, 4 do
	local arrowkey = { "Left", "Right", "Up", "Down" }
	local focusdir = { "l", "r", "u", "d" }
	hl.bind(
		"SUPER + " .. arrowkey[i],
		hl.dsp.focus({ direction = focusdir[i] }),
		{ description = "Window: Focus " .. arrowkey[i] }
	)
end
for i = 1, 2 do
	local arrowkey = { "BracketLeft", "BracketRight" }
	local focusdir = { "l", "r" }
	hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end
for i = 1, 4 do
	local arrowkey = { "Left", "Right", "Up", "Down" }
	local focusdir = { "l", "r", "u", "d" }
	hl.bind(
		"SUPER + SHIFT + " .. arrowkey[i],
		hl.dsp.window.move({ direction = focusdir[i] }),
		{ description = "Window: Move " .. arrowkey[i] }
	)
end

hl.bind("ALT + F4", function()
	hl.exec_cmd('notify-send "Wrong close keybind" "Super+Q to close. Use Alt+F4 for Windows VMs" -a Hyprland')
end, { non_consuming = true })
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Window: Close" })
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Forcefully zap a window" })

--#/# bind = SUPER+ALT, Hash,, -- Send to workspace -- (1, 2, 3,...)
for i = 1, 10 do
	hl.bind("SUPER + ALT + " .. (i % 10), function()
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = false }))
	end, { description = "Window: Send to workspace " .. i })
end
--# keypad numbers
for i = 1, 10 do
	local numpadkey = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + ALT + code:" .. numpadkey[i], function()
		hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = false }))
	end)
end
for i = 1, 4 do
	local key = { "SUPER + SHIFT + mouse_", "SUPER + ALT + mouse_" }
	local keycombos = { key[1] .. "down", key[1] .. "up", key[2] .. "down", key[2] .. "up" }
	local prefix = { "r-", "r+", "r-", "r+" }
	hl.bind(keycombos[i], hl.dsp.window.move({ workspace = prefix[i] .. "1" }))
end
--#/# bind = SUPER+SHIFT, Page_↑/↓,, -- Send to workspace left/right
-- for i = 1, 2 do
-- 	local keydirs = { "Up", "Down" }
-- 	local prefix = { "r-", "r+" }
-- 	local descdir = { "left", "right" }
-- 	hl.bind(
-- 		"SUPER + SHIFT + Page_" .. keydirs[i],
-- 		hl.dsp.window.move({ workspace = prefix[i] .. "1" }),
-- 		{ description = "Window: Send to workspace " .. descdir[i] }
-- 	)
-- end
for i = 1, 4 do
	local key = { "SUPER + ALT + Page_", "CTRL + SUPER + SHIFT + " }
	local keycombos = { key[1] .. "down", key[1] .. "up", key[2] .. "Right", key[2] .. "Left" }
	local prefix = { "r+", "r-", "r+", "r-" }
	hl.bind(keycombos[i], hl.dsp.window.move({ workspace = prefix[i] .. "1" })) -- # [hidden]
end

-- hl.bind(
-- 	"SUPER + ALT + S",
-- 	hl.dsp.window.move({ workspace = "special:special", follow = false }),
-- 	{ description = "Window: Send to scratchpad" }
-- )
-- hl.bind("CTRL + SUPER + S", hl.dsp.workspace.toggle_special("special"))
--
--##! Workspace
--# Switching
--#/# bind = SUPER, Hash,, -- Focus workspace -- (1, 2, 3,...)
for i = 1, 10 do
	hl.bind("SUPER + " .. (i % 10), function()
		hl.dispatch(hl.dsp.focus({ workspace = workspace_in_group(i) }))
	end, { description = "Workspace: Focus " .. i })
end
--# We also use raw keycodes because some keyboard layouts register number keys as different chars. The codes can be verified with `wev`
for i = 1, 10 do
	local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + code:" .. numberkey[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = workspace_in_group(i) }))
	end)
end
--# keypad numbers
for i = 1, 10 do
	local numpadkey = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + code:" .. numpadkey[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = workspace_in_group(i) }))
	end)
end

--#/# bind = CTRL+SUPER, ←/→,, -- Focus left/right
--#/# bind = CTRL+SUPER+ALT, ←/→,, -- # [hidden] Focus busy left/right
-- for i = 1, 2 do
-- 	local keys = { "Left", "Right" }
-- 	local prefix = { "r-", "r+" }
-- 	local descdir = { "left", "right" }
-- 	hl.bind(
-- 		"CTRL + SUPER + " .. keys[i],
-- 		hl.dsp.focus({ workspace = prefix[i] .. "1" }),
-- 		{ description = "Workspace: Focus " .. descdir[i] }
-- 	)
-- end
-- for i = 1, 2 do
-- 	local keys = { "Left", "Right" }
-- 	local prefix = { "m-", "m+" }
-- 	hl.bind("CTRL + SUPER + ALT + " .. keys[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
-- end
-- --#/# bind = SUPER, Page_↑/↓,, -- Focus left/right
-- for i = 1, 4 do
-- 	local key = { "SUPER + Page_Down", "SUPER + Page_Up" }
-- 	local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
-- 	local prefix = { "r+", "r-", "r+", "r-" }
-- 	hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
-- end
-- --#/# bind = SUPER, Scroll ↑/↓,, -- Focus left/right
-- for i = 1, 4 do
-- 	local key = { "SUPER + mouse_up", "SUPER + mouse_down" }
-- 	local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
-- 	local prefix = { "+", "-", "r+", "r-" }
-- 	hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
-- end
-- --## Special
-- hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("special"), { description = "Workspace: Toggle scratchpad" })
-- hl.bind("SUPER + mouse:275", hl.dsp.workspace.toggle_special("special"))
-- for i = 1, 4 do
-- 	local key = { "BracketLeft", "BracketRight", "Up", "Down" }
-- 	local prefix = { "-1", "+1", "r-5", "r+5" }
-- 	hl.bind("CTRL + SUPER + " .. key[i], hl.dsp.focus({ workspace = prefix[i] }))
-- end
--
--
-- local topRow = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
-- local topRowWs = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
--
-- for i, key in ipairs(topRow) do
-- 	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = topRowWs[i] }))
-- 	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = topRowWs[i] }))
-- end
--
-- local keypadKeys = {
-- 	"KP_End",
-- 	"KP_Down",
-- 	"KP_Next",
-- 	"KP_Left",
-- 	"KP_Begin",
-- 	"KP_Right",
-- 	"KP_Home",
-- 	"KP_Up",
-- 	"KP_Prior",
-- 	"KP_Insert",
-- 	"KP_Delete",
-- }
-- local keypadWs = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "0" }
--
-- for i, key in ipairs(keypadKeys) do
-- 	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = keypadWs[i] }))
-- 	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = keypadWs[i] }))
-- end
