-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- alacritty")
    hl.exec_cmd("uwsm app -- clipse -listen")
    hl.exec_cmd("uwsm app -- elephant")
    hl.exec_cmd("uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- swaync")
    hl.exec_cmd("uwsm app -- swayosd-server")
    hl.exec_cmd("uwsm app -- walker --gapplication-service")
end)
