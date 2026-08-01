-- ============================================================
-- Migrated from hyprland.conf (hyprlang) to hyprland.lua
-- Hyprland >= 0.55 Lua config
--
-- Lines marked [VERIFY] use a dispatcher/API name I could not
-- confirm with full certainty from the wiki search — check
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/ and
-- the Gestures / Binds pages before relying on them.
-- You can also cross-check this file with an automated
-- converter (e.g. hyprconf2lua or hyprlang2lua) if you want a
-- second opinion on any given line.
-- ============================================================

------------------------
---- PROGRAMS/VARS  ----
------------------------
local terminal = "kitty"
local fileManager = "nemo"
local menu = "rofi -show drun"
local browser = "firefox"
local ai = browser .. " --new-window https://chat.openai.com"
local reload_waybar = "pkill waybar; waybar &"
local mainMod = "SUPER"

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-3", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })

--------------------------------------
---- WORKSPACE -> MONITOR MAPPING ----
--------------------------------------
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-3", default = true })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-3" })

hl.workspace_rule({ workspace = "0", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })

------------------------------------------------
---- GENERAL / DECORATION / INPUT / ANIM/MISC ---
------------------------------------------------
hl.config({
	input = {
		kb_layout = "us,ara",
	},

	animations = {
		enabled = false,
	},

	decoration = {
		rounding = 10,
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,

		blur = {
			enabled = true,
			size = 4,
			passes = 4,
			new_optimizations = true,
			ignore_opacity = true,
			xray = true,
		},

		shadow = {
			enabled = true,
			range = 32,
			render_power = 2,
			color = "rgba(00000050)",
		},
	},

	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		["col.active_border"] = "rgba(00000050)",
		["col.inactive_border"] = "rgba(1a110fff)",
		layout = "dwindle",
		resize_on_border = true,
	},

	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
})

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

------------------
---- BINDS -------
------------------

-- Keyboard layout toggle
hl.bind("ALT + Shift_L", hl.dsp.exec_cmd("hyprctl switchxkblayout main next"), { locked = true })

-- [VERIFY] 3-finger horizontal swipe -> workspace switch.
-- Old: gesture = 3, horizontal, workspace
-- Check the Gestures section of the wiki for the current hl.config({ gestures = {...} })
-- or hl.bind() form — this one I couldn't confirm precisely.

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
-- [VERIFY] confirm hl.dsp.workspace.change() takes "e+1"/"e-1" the same way the old relative syntax did
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.change("e+1"))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.change("e-1"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ai))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(reload_waybar))

hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

-- [VERIFY] pseudo-tiling toggle (dwindle-specific dispatcher name unconfirmed)
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Cursor zoom in/out (mainMod + ALT + scroll)
hl.bind(mainMod .. " + ALT + mouse_down", function()
	local cur = hl.get_config("cursor.zoom_factor")
	hl.config({ cursor = { zoom_factor = cur + 0.5 } })
end)
hl.bind(mainMod .. " + ALT + mouse_up", function()
	local cur = hl.get_config("cursor.zoom_factor")
	hl.config({ cursor = { zoom_factor = cur - 0.5 } })
end)
hl.bind(mainMod .. " + ALT + Z", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)

-- [VERIFY] fullscreen dispatcher name/args unconfirmed — check Dispatchers page
-- hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 })) -- fullscreen
-- hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 })) -- maximize

-- Cycle windows + bring to top (ALT+Tab)
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end, { repeating = true })

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + M", hl.dsp.exec_cmd("hyprlock"))

-- [VERIFY] mouse drag-to-move / drag-to-resize dispatcher names unconfirmed
-- hl.bind(mainMod, "mouse:272", hl.dsp.window.move_mouse())
-- hl.bind(mainMod, "mouse:273", hl.dsp.window.resize_mouse())

-- hl.bind(mainMod .. " + Tab", hl.dsp.workspace.change("m+1"))
-- hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.workspace.change("m-1"))
-- hl.bind(mainMod .. " + CTRL + down", hl.dsp.workspace.change("empty"))

-------------------------------------------
---- WORKSPACE SWITCH/MOVE (1-0 + KP) -----
-------------------------------------------
local topRow = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local topRowWs = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

for i, key in ipairs(topRow) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = topRowWs[i] }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = topRowWs[i] }))
end

local keypadKeys = {
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
	"KP_Delete",
}
local keypadWs = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "0" }

for i, key in ipairs(keypadKeys) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = keypadWs[i] }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = keypadWs[i] }))
end

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
