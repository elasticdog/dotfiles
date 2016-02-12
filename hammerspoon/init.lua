require "location"
require "utilities"
require "window_management"

-- manually reload this config
hs.hotkey.bind({"cmd", "alt"}, "R", function()
  hs.reload()
end)

-- auto-reload this config on changes
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

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon Config Loaded")
