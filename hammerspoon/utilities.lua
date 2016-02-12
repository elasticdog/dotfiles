-- name the common hotkey combinations
local hyper =    {"cmd", "alt", "ctrl", "shift"}
local mash =     {"cmd", "alt", "ctrl"}
local minimash = {"cmd", "alt"}

-- defeat paste blocking
hs.hotkey.bind(minimash, "V", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
