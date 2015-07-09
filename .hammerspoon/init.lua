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
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local isfull = win:isFullScreen()
    local screen_east = screen:toEast()
    if not screen_east then
        return
    end

    local movewindow = function()
        hs.window.animationDuration = 0
        win:moveToScreen(screen_east)
        if isfull then
            hs.timer.doAfter(.2, function()
                if not win:setFullScreen(true) then
                    win:maximize()
                end
            end)
        end
    end

    if isfull then
        win:setFullScreen(false)
        hs.timer.doAfter(1, movewindow)
    else
        movewindow()
    end
end)

-- Move to next screen on left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local isfull = win:isFullScreen()
    local screen_west = screen:toWest()
    if not screen_west then
        return
    end

    local movewindow = function()
        hs.window.animationDuration = 0
        win:moveToScreen(screen_west)
        if isfull then
            hs.timer.doAfter(.2, function()
                if not win:setFullScreen(true) then
                    win:maximize()
                end
            end)
        end
    end

    if isfull then
        win:setFullScreen(false)
        hs.timer.doAfter(1, movewindow)
    else
        movewindow()
    end
end)

-- Move to next screen on top/to the north
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local isfull = win:isFullScreen()
    local screen_north = screen:toNorth()
    if not screen_north then
        return
    end

    local movewindow = function()
        hs.window.animationDuration = 0
        win:moveToScreen(screen_north)
        if isfull then
            hs.timer.doAfter(.2, function()
                if not win:setFullScreen(true) then
                    win:maximize()
                end
            end)
        end
    end

    if isfull then
        win:setFullScreen(false)
        hs.timer.doAfter(1, movewindow)
    else
        movewindow()
    end
end)

-- Move to next screen on left
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local sf = screen:frame()

    local isfull = win:isFullScreen()
    local screen_south = screen:toSouth()
    if not screen_south then
        return
    end

    local movewindow = function()
        hs.window.animationDuration = 0
        win:moveToScreen(screen_south)
        if isfull then
            hs.timer.doAfter(.2, function()
                if not win:setFullScreen(true) then
                    win:maximize()
                end
            end)
        end
    end

    if isfull then
        win:setFullScreen(false)
        hs.timer.doAfter(1, movewindow)
    else
        movewindow()
    end
end)
