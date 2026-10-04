------------------------
---- VARIABLES ---------
------------------------
local terminal = "kitty"
local fileManager = "nemo"
local menu = "rofi -show drun"
local browser = "firefox"
local ai = browser .. " --new-window https://chat.openai.com"
local reload_waybar = "pkill waybar; waybar &"
local mainMod = "SUPER"

------------------------
---- MONITORS ----------
------------------------
hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1920x0", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })
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

------------------------
---- CONFIG ------------
------------------------
hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
	general = {
		-- Gaps and border
		gaps_in = 4,
		gaps_out = 5,
		gaps_workspaces = 50,

		border_size = 1,

		col = {
			active_border = "rgba(0DB7D455)",
			inactive_border = "rgba(31313600)",
		},
		resize_on_border = true,

		no_focus_fallback = true,
		allow_tearing = true, -- This just allows the `immediate` window rule to work
		snap = {
			enabled = true,
			window_gap = 4,
			monitor_gap = 5,
			respect_gaps = true,
		},
	},
	decoration = {
		-- 2 = circle, higher = squircle, 4 = very obvious squircle
		-- Fuck clearly visible squircles. 100% Apple brainrot.
		rounding_power = 2.5,
		rounding = 18,

		blur = {
			enabled = true,
			xray = true,
			special = false,
			new_optimizations = true,
			size = 10,
			passes = 3,
			brightness = 1,
			noise = 0.05,
			contrast = 0.89,
			vibrancy = 0.5,
			vibrancy_darkness = 0.5,
			popups = false,
			popups_ignorealpha = 0.6,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
		shadow = {
			enabled = false,
			range = 20,
			offset = { 0, 2 },
			render_power = 10,
			color = "rgba(00000020)",
		},
		-- Dim
		dim_inactive = true,
		dim_strength = 0.05,
		dim_special = 0.2,
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = false,
		-- precise_mouse_move = true,
	},
	input = {
		kb_layout = "us,cz,eg",
		kb_variant = ",qwerty",
		kb_options = "grp:alt_shift_toggle",

		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,

		follow_mouse = 1,
		off_window_axis_events = 2,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 0,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(foot|kitty|alacritty|Alacritty)",
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		session_lock_xray = false,
		initial_workspace_tracking = false,
		focus_on_activate = true,
	},

	binds = {
		scroll_event_delay = 0,
		hide_special_on_workspace_change = true,
	},

	cursor = {
		zoom_factor = 1,
		zoom_rigid = false,
		zoom_disable_aa = true,
		hotspot_padding = 1,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

------------------------
---- AUTOSTART ---------
------------------------
-- exec-once has no direct keyword anymore; hook the session-start event instead
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd(terminal)
end)

------------------------
---- KEYBINDS ----------
------------------------
hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + A", hl.dsp.exec_cmd(ai))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", hl.dsp.exec_cmd(reload_waybar))

hl.bind("SUPER + space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = 0 })) -- fullscreen

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

-- Zoom with keypad
hl.bind("SUPER + code:82", function()
	zoomfunction(-0.3)
end, { repeating = true })
hl.bind("SUPER + code:86", function()
	zoomfunction(0.3)
end, { repeating = true })
-- Cursor zoom in/out (SUPER + scroll)
hl.bind("SUPER + mouse_down", function()
	zoomfunction(0.3)
end)
hl.bind("SUPER + mouse_up", function()
	zoomfunction(-0.3)
end)

hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Window: Move" })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Window: Resize" })

-- Focus with arrow keys
local arrows = { "Left", "Right", "Up", "Down" }
local dirs = { "l", "r", "u", "d" }
for i = 1, 4 do
	hl.bind(
		"SUPER + " .. arrows[i],
		hl.dsp.focus({ direction = dirs[i] }),
		{ description = "Window: Focus " .. arrows[i] }
	)
end

-- Focus left/right with brackets
local brackets = { "BracketLeft", "BracketRight" }
for i = 1, 2 do
	hl.bind("SUPER + " .. brackets[i], hl.dsp.focus({ direction = dirs[i] }))
end

-- Move windows with arrow keys
for i = 1, 4 do
	hl.bind(
		"SUPER + SHIFT + " .. arrows[i],
		hl.dsp.window.move({ direction = dirs[i] }),
		{ description = "Window: Move " .. arrows[i] }
	)
end

hl.bind("ALT + F4", function()
	hl.exec_cmd('notify-send "Wrong close keybind" "Super+Q to close. Use Alt+F4 for Windows VMs" -a Hyprland')
end, { non_consuming = true })
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Window: Close" })
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Window: Forcefully zap a window" })

-- Workspaces 1-10 (key 0 = workspace 10), plus numpad
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
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))

--------------------------------------
---- WORKSPACE -> MONITOR MAPPING ----
--------------------------------------
for i = 1, 5 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "DP-2",
		default = i == 1,
	})
end

for i = 6, 10 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "DP-1",
		default = i == 6,
	})
end

-------------------------
---- WINDOW RULES  ------
-------------------------
-- Verify class names with `hyprctl clients`
hl.window_rule({ match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { class = "(?i)^(qalculate-gtk)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "ModernGL" }, workspace = "9" })
hl.window_rule({ match = { class = "mpv" }, workspace = "9" })
