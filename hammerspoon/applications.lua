-- launch applications
hs.hotkey.bind(hyper, "F", function () hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind(hyper, "N", function () hs.application.launchOrFocus("nvALT") end)
hs.hotkey.bind(hyper, "S", function () hs.application.launchOrFocus("Slack") end)

-- manually reload the hammerspoon config
hs.hotkey.bind(hyper, "R", function() hs.reload() end)
