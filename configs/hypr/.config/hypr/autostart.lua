-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

local utils = require("utils")

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- clipse -listen")
    hl.exec_cmd("uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- walker --gapplication-service")
    -- background
    hl.exec_cmd("uwsm app -s b -- alacritty --daemon")
    hl.exec_cmd("uwsm app -s b -- swayosd-server")
    hl.exec_cmd("uwsm app -s b -- udiskie")
end)

local SECOND = 1000
local MINUTE = 60 * SECOND

local fetch_mails = hl.timer(function()
    if not utils.is_running("thunderbird") then
        hl.exec_cmd("timeout 10 thunderbird --headless")
    end
end, { timeout = 15 * MINUTE, type = "repeat" })

--fetch_mails:set_enabled(false)
