

require 'src/Dependencies'

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    menu1 = Menu(menu1)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'p' then
        menu1:openClose()
    end
        if key == 'w' then
        print('changing')
        menu1:navigation(1)
    end
    if key == 'q' then
        menu1:navigation(-1)
    end

end



function love.update(dt)
    menu1:update(dt)
    Timer.update(dt)

end

function love.draw()
    -- love.graphics.rectangle(mode,x,y,width,height)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    menu1:render()
    love.graphics.reset()
end


function love.mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
        mouse_pressed = true
    end
end

function love.mousereleased(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
        mouse_pressed = false
    end
end

--     -- if menu.menu_state then

--     printx = 0
--     printy = 0

--     if key == 'u' then
--         -- menu:updateScroller()
--     end
--     if key == 'w' then
--         -- print('changing')
--         -- menu1:navigation(1)
--         -- menu2:navigation(1)
--         -- menu3:navigation(1)
--     end
--     if key == 'q' then
--         -- menu1:navigation(-1)
--         -- menu2:navigation(-1)
--         -- menu3:navigation(-1)
--     end

--     if key == 'd' then
--         -- print('number of panels: '.. #menu.panels)
--         -- if #menu1.panels>1 then
--         --     menu1:removePanel(menu1.current_panel)
--         -- end

--         -- if #menu2.panels>1 then
--         --     menu2:removePanel(menu2.current_panel)
--         -- end

--         -- if #menu3.panels>1 then
--         --     menu3:removePanel(menu3.current_panel)
--         -- end
--     end

--     if key == 'f' then
--         -- print('panel row layout: ' .. new_panel.panel_row_number)
--         -- print('panel col layout: ' .. new_panel.panel_col_number)
        
--         -- menu1:addPanel(new_panel)
--         -- menu2:addPanel(new_panel)
--         -- menu3:addPanel(new_panel)
--         -- print('Menu3 panel count: ', #menu3.panels)
--         -- print('Menu3 current panel: ', menu3.current_panel)
--         -- print('number of panels: ' .. #menu.panels)
--         -- print('current panel: ' .. menu.current_panel)
--         -- print('new panel id : ' .. tostring(menu.panels[1]['panel'].panel_state))
--     end
    


-- -- end