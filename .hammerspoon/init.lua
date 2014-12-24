-- Reload the HammerSpoon config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)


-- WINDOWS --------------------------------------------------------------------

-- GO TO FULLSCREEN
hs.hotkey.bind({"cmd", "alt"}, "f", function()
    local win = hs.window.focusedWindow()

    -- error
    if not win then
        return
    end

    -- if the app is full screen, just de-fullscreen it
    if win:isFullScreen() then
        win:setFullScreen(false)
        return
    end

    -- try to full screen the app, and if that fails, just size it to the
    -- screen it's on
    if not win:setFullScreen(true) then
        win:maximize()
    end
end)

-- RIGHT, HALF-SCREEN
hs.hotkey.bind({"cmd", "alt"}, "Right", function()
    local win = hs.window.focusedWindow()
    -- full screen apps should not behave like floating apps
    if win:isFullScreen() then
        return
    end

    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    f.x = sf.x + (sf.w / 2)
    f.y = sf.y
    f.w = sf.w / 2
    f.h = sf.h

    win:setFrame(f, 0)
end)

-- LEFT, HALF-SCREEN
hs.hotkey.bind({"cmd", "alt"}, "Left", function()
    local win = hs.window.focusedWindow()
    -- full screen apps should not behave like floating apps
    if win:isFullScreen() then
        return
    end

    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    f.x = sf.x
    f.y = sf.y
    f.w = sf.w / 2
    f.h = sf.h

    win:setFrame(f, 0)
end)

-- CENTER, HALF-SCREEN
hs.hotkey.bind({"cmd", "alt"}, "Down", function()
    local win = hs.window.focusedWindow()
    -- full screen apps should not behave like floating apps
    if win:isFullScreen() then
        return
    end

    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    f.x = sf.x + ((sf.w / 2) / 2)
    f.y = sf.y
    f.w = sf.w / 2
    f.h = sf.h

    win:setFrame(f, 0)
end)

-- Move to next screen on right/to the east
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    -- no point in moving a window if there are no screens to move it too
    local allscreens = hs.screen.allScreens()
    local cnt = 0
    -- don't know why, but table.getn is a "nil value"
    for k, v in pairs(allscreens) do
        cnt = cnt + 1
    end
    if cnt < 1 then
        return
    end

    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local east_screen = screen:toEast()
    -- no point in moving the window if there is no easterly screen
    if east_screen == nil then
        return
    end
    local esf = east_screen:frame()

    f.x = esf.x

    win:setFrame(f, 0)
end)

-- Move to next screen on left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    -- no point in moving a window if there are no screens to move it too
    local allscreens = hs.screen.allScreens()
    local cnt = 0
    -- don't know why, but table.getn is a "nil value"
    for k, v in pairs(allscreens) do
        cnt = cnt + 1
    end
    if cnt < 1 then
        return
    end

    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local west_screen = screen:toWest()
    -- no point in moving the window if there is no easterly screen
    if west_screen == nil then
        return
    end
    local wsf = west_screen:frame()

    f.x = wsf.x

    win:setFrame(f, 0)

end)
