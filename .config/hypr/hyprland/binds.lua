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

local numpadkey = {
	"KP_End",
	"KP_Down",
	"KP_Next",
	"KP_Left",
	"KP_Begin",
	"KP_Right",
	"KP_Home",
	"KP_Up",
	"KP_Prior",
	"KP_Insert",
}
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	local npkey = numpadkey[i]
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + " .. npkey, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. npkey, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + TAB ", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + S + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }
