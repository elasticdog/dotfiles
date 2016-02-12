-- defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
