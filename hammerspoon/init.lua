-- name the common hotkey combinations
hyper =    {"cmd", "alt", "ctrl", "shift"}
mash =     {"cmd", "alt", "ctrl"}
minimash = {"cmd", "alt"}

require "applications"
require "location"
require "utilities"
require "window_management"

-- toggle the hammerspoon console
hs.hotkey.bind(hyper, "H", hs.toggleConsole)

-- manually reload the hammerspoon config
hs.hotkey.bind(hyper, "R", function() hs.reload() end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- auto-reload the hammerspoon config on changes
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon Config Loaded")
