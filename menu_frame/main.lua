

require 'src/Dependencies'

function love.load()

    -- love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    love.graphics.setDefaultFilter('nearest', 'nearest')
    Push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        highdpi = true,
        -- canvas = true
      })


    menu1 = Menu(menu1)

end

function love.resize(w, h)
    Push:resize(w, h)
    -- updateFontSize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'p' then
        menu1:openClose()
    end
    if key == 'q' then
        print('MENU: HAS A NEW IMAGE')
        menu1:changeImage(image_list['platypus'])
    end
    if key == 'w' then
        print('MENU: HAS A RGBA')
        menu1:changeRGBA({r = 0.37,g = 0.61,b = 0.54,a = 1.0})
    end
    if key == 'd' then
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' HAS A NEW IMAGE')
        menu1.panels[1]['panel'].panel_layout[1].button[1]:changeImage(image_list['platypus'])
    end
    if key == 'a' then
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' HAS A NEW TEXT')
        menu1.panels[1]['panel'].panel_layout[1].button[1]:changeText('NEWMESSAGE')
    end
    if key == 's' then
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' HAS A NEW RGBA')
        menu1.panels[1]['panel'].panel_layout[1].button[1]:changeRGBA({r = 1,g = 0,b = 0,a = 1.0})
    end
    if key == 'f' then
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' HAS SWITCHED')
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[4].button.button_id..' HAS SWITCHED')
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' OLD X POS '..menu1.panels[1]['panel'].panel_layout[1].button.x)
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' OLD TOP FRAME X POS '..menu1.panels[1]['panel'].panel_layout[1].button.position['top'].x)
        old_loc_button = menu1.panels[1]['panel'].panel_layout[1].button
        new_loc_button = menu1.panels[1]['panel'].panel_layout[4].button
        menu1.panels[1]['panel']:organizeButtons_Panel(old_loc_button,new_loc_button)
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' NEW X POS '..menu1.panels[1]['panel'].panel_layout[1].button.x)
        print('BUTTON NUMBER: '..menu1.panels[1]['panel'].panel_layout[1].button.button_id..' NEW TOP FRAME X POS '..menu1.panels[1]['panel'].panel_layout[1].button.position['top'].x)
    end
    if key == 'g' then
        print('ADDING 2 NEW BUTTON')
        menu1.panels[1]['panel']:addButton(2)    
    end
    if key == 'h' then
        print('remove NEW BUTTON')
        menu1.panels[1]['panel']:removeButton()    
    end
    if key == 'j' then
        print('remove BUTTON 2')
        menu1.panels[1]['panel']:removeSepecifcButton(4)
    end
    

    
    -- if key == 'w' then
    --     print('changing')
    --     menu1:navigation(1)
    -- end
    -- if key == 'q' then
    --     menu1:navigation(-1)
    -- end

end



function love.update(dt)
    menu1:update(dt)


end

function love.draw()
    
    Push:apply("start")
    -- love.graphics.rectangle(mode,x,y,width,height)

    -- love.graphics.setColor(1,1,1)
    -- love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    -- love.graphics.reset()
    menu1:render()

    Push:apply("end")

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