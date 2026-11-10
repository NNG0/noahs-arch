---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us, de",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "grp:win_space_toggle",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad     = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

local osdclient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.dsp.exec_cmd(osdclient .. " --output-volume raise")
    end
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.dsp.exec_cmd(osdclient .. " --output-volume lower")
    end
})

hl.gesture({
    fingers = 4,
    direction = "right",
    action = function()
        hl.dsp.exec_cmd(osdclient .. " --playerctl next")
    end
})

hl.gesture({
    fingers = 4,
    direction = "left",
    action = function()
        hl.dsp.exec_cmd(osdclient .. " --playerctl next")
    end
})
-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
