
-- WINDOW MOVEMENT ------------------------------------------------------------

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

-- GO TO FULLSCREEN
hs.hotkey.bind({"cmd", "alt"}, "f", function()
    local win = hs.window.focusedWindow()

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