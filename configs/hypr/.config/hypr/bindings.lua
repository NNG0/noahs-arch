------------------
---- PROGRAMS ----
------------------
local function set_class(args)
    return string.format(
        "--class %s -e %s",
        args,
        args
    )
end

local function alacritty(args)
    args = args or ""
    local class_string = args ~= "" and set_class(args) or ""
    return string.format(
        "alacritty msg create-window %s",
        class_string
    )
end

local function wrap_uwsm(args)
    return string.format("uwsm app -- %s", args)
end

-- local function is_running(class)
--     return hl.exec_cmd(
--         "hyprctl clients -j | jq -e '.[] | select(.class==\"" .. class .. "\")'"
--     ) ~= ""
-- end
--
-- local function focus_or_launch(class)
--     if not is_running(class) then
--         return alacritty(class)
--     else
--         local format_string = string.format(
--             "class:%s",
--             class
--         )
--         hl.dsp.focus({ window = class })
--         return ""
--     end
-- end

-- Set programs that you use
local terminal       = alacritty()
local fileManager    = alacritty("yazi")
local launcher       = wrap_uwsm('walker -p "Search…"')
local browser        = wrap_uwsm("zen-browser")
local lock           = wrap_uwsm("hyprlock")
local nm             = wrap_uwsm("swaync-client -t")
local clipboard      = alacritty("clipse")
local audio          = alacritty("wiremix")
local bluetooth      = alacritty("bluetui")
local wlan           = alacritty("impala")
local pw_manager     = wrap_uwsm("keepassxc")

---------------------
---- KEYBINDINGS ----
---------------------
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod        = "SUPER" -- Sets "Windows" key as main modifier
local applicationMod = "SUPER + SPACE"

--------------
---- APPS ----
--------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(nm))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(bluetooth))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(audio))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(wlan))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(pw_manager))

------------------------
---- Window actions ----
------------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

------------------------
---- Focus movement ----
------------------------

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

----------------------
---- Move windows ----
----------------------

hl.bind(mainMod .. " + CTRL + h",
    hl.dsp.window.move({ direction = "left" })
)

hl.bind(mainMod .. " + CTRL + j",
    hl.dsp.window.move({ direction = "down" })
)

hl.bind(mainMod .. " + CTRL + k",
    hl.dsp.window.move({ direction = "up" })
)

hl.bind(mainMod .. " + CTRL + l",
    hl.dsp.window.move({ direction = "right" })
)

--hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit")) -- dwindle only

------------------------
---- Resize windows ----
------------------------

hl.bind(mainMod .. " + SHIFT + h",
    hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true }
)

hl.bind(mainMod .. " + SHIFT + l",
    hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true }
)

hl.bind(mainMod .. " + SHIFT + j",
    hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true }
)

hl.bind(mainMod .. " + SHIFT + k",
    hl.dsp.window.resize({ x = 0, y = -30, relative = true, }), { repeating = true }
)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------
---- Misc ----
--------------

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + F1", function()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        general = {
            gaps_in = 0,
            gaps_out = 0, -- Disable gaps
            border_size = 0,
        },

        animations = {
            enabled = false, -- Disable animations
        },

        -- Disable blur, shadow and window rounding
        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    })
end)

-- screenshot
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(" + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-------------------
---- Workspace ----
-------------------

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

---------------
---- Media ----
---------------

-- Laptop multimedia keys for volume and LCD brightness
local osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume raise"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(osdclient .. " --output-volume lower"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --brightness lower"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --ddcutil setvcp 10 + 5"),
--     { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --ddcutil setvcp 10 + 5"),
--     { locked = true, repeating = true })



-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. " --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. " --playerctl previous"), { locked = true })
