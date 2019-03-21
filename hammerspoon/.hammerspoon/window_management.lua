require "hs.application"

-- disable animations
hs.window.animationDuration = 0

-- change focus
hs.hotkey.bind({"cmd", "ctrl"}, "Left", function() hs.window.frontmostWindow():focusWindowWest() end)
hs.hotkey.bind({"cmd", "ctrl"}, "Right", function() hs.window.frontmostWindow():focusWindowEast() end)
hs.hotkey.bind({"cmd", "ctrl"}, "Up", function() hs.window.frontmostWindow():focusWindowNorth() end)
hs.hotkey.bind({"cmd", "ctrl"}, "Down", function() hs.window.frontmostWindow():focusWindowSouth() end)

-- set up the default grid
hs.grid.setGrid("14x12")
hs.grid.setMargins("0,0")

-- adjust the grid size
hs.hotkey.bind(mash, "=", function() hs.grid.adjustWidth( 1) end)
hs.hotkey.bind(mash, "-", function() hs.grid.adjustWidth(-1) end)
hs.hotkey.bind(mash, "]", function() hs.grid.adjustHeight( 1) end)
hs.hotkey.bind(mash, "[", function() hs.grid.adjustHeight(-1) end)

-- snap window(s) to grid
hs.hotkey.bind(mash, ";", function() hs.grid.snap(hs.window.focusedWindow()) end)
hs.hotkey.bind(mash, "'", function() hs.fnutils.map(hs.window.visibleWindows(), hs.grid.snap) end)

-- move windows
hs.hotkey.bind(mash, "H", hs.grid.pushWindowLeft)
hs.hotkey.bind(mash, "J", hs.grid.pushWindowDown)
hs.hotkey.bind(mash, "K", hs.grid.pushWindowUp)
hs.hotkey.bind(mash, "L", hs.grid.pushWindowRight)

-- multi monitor move
hs.hotkey.bind(mash, "N", hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, "P", hs.grid.pushWindowPrevScreen)

-- center window
hs.hotkey.bind(mash, "C", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen():frame()

    f.center = screen.center
    win:setFrame(f)
end)

-- resize windows
hs.hotkey.bind(mash, "Y", hs.grid.resizeWindowThinner)
hs.hotkey.bind(mash, "U", hs.grid.resizeWindowTaller)
hs.hotkey.bind(mash, "I", hs.grid.resizeWindowShorter)
hs.hotkey.bind(mash, "O", hs.grid.resizeWindowWider)

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:fullFrame()
        local menubar = 22

        f.x = max.w * x
        f.y = max.h * y + (menubar / 2 + 1)
        f.w = max.w * w
        f.h = (max.h - menubar) * h
        win:setFrame(f)
    end
end

-- Y   K   U
-- H       L
-- B   J   N
hs.hotkey.bind(minimash, "Y", baseMove(0, 0, 0.5, 0.5))     -- top-left quarter of screen
hs.hotkey.bind(minimash, "K", baseMove(0, 0, 1, 0.5))       -- top half of screen
hs.hotkey.bind(minimash, "U", baseMove(0.5, 0, 0.5, 0.5))   -- top-right quarter of screen
hs.hotkey.bind(minimash, "H", baseMove(0, 0, 0.5, 1))       -- left half of screen
hs.hotkey.bind(minimash, "L", baseMove(0.5, 0, 0.5, 1))     -- right half of screen
hs.hotkey.bind(minimash, "B", baseMove(0, 0.5, 0.5, 0.5))   -- bottom-left quarter of screen
hs.hotkey.bind(minimash, "J", baseMove(0, 0.5, 1, 0.5))     -- bottom half of screen
hs.hotkey.bind(minimash, "N", baseMove(0.5, 0.5, 0.5, 0.5)) -- bottom-right quarter of screen

-- maximize window
hs.hotkey.bind(mash, "M", hs.grid.maximizeWindow)

-- zoom  window
hs.hotkey.bind(mash, "Z", function() hs.window.frontmostWindow():toggleZoom() end)

-- display window hints
hs.hotkey.bind(mash, ".", hs.hints.windowHints)
