-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- alacritty --daemon")
    hl.exec_cmd("uwsm app -- clipse -listen")
    hl.exec_cmd("uwsm app -- elephant")
    hl.exec_cmd("uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- swayosd-server")
    hl.exec_cmd("uwsm app -- walker --gapplication-service")
    hl.exec_cmd("uwsm app -- syncthing --no-browser")
end)

local SECOND = 1000
local MINUTE = 60 * SECOND

local fetch_mails = hl.timer(function()
    hl.exec_cmd("timeout 10 thunderbird --headless")
end, { timeout = 15 * MINUTE, type = "repeat" })

--fetch_mails:set_enabled(false)
