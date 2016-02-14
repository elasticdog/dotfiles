-- defeat paste blocking
hs.hotkey.bind(minimash, "V", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
