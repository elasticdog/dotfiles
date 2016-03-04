-- launch applications
hs.hotkey.bind(hyper, "F", function () hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind(hyper, "N", function () hs.application.launchOrFocus("nvALT") end)
hs.hotkey.bind(hyper, "S", function () hs.application.launchOrFocus("Slack") end)

-- control music
hs.hotkey.bind(hyper, "P", function () hs.spotify.playpause() end)
hs.hotkey.bind(hyper, "[", function () hs.spotify.previous() end)
hs.hotkey.bind(hyper, "]", function () hs.spotify.next() end)
