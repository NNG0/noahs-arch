local U = {}

function U.is_running(process)
    local cmd = "pgrep -af " .. process
    local handle = io.popen(cmd)

    if not handle then
        return false
    end

    local result = handle:read("*a")
    handle:close()

    return result ~= nil and result ~= ""
end

return U
