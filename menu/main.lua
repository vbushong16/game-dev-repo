

require 'src/Dependencies'

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    w,h = select(3,gFrames['menu'][1]:getViewport()),select(4,gFrames['menu'][1]:getViewport())


    input = {width = 10, height = 10, x = 50, y = 50,num_panels = 2,scale_x=200/w,scale_y=200/h}
    menu = Menu(menu3)
    -- print('number of panels:' .. menu.number_panels)
    -- for i,panels in pairs(menu.panels) do
    --     print('panel ID:' .. i)
    -- end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'p' then
        menu:openClose()
    end
    if menu.menu_state then

        printx = 0
        printy = 0

        if key == 'u' then
            menu:updateScroller()
        end
        if key == 'w' then
            print('changing')
            menu:navigation(1)
        end
        if key == 'q' then
            menu:navigation(-1)
        end
    
        if key == 'd' then
            -- print('number of panels: '.. #menu.panels)
            if #menu.panels>1 then
                menu:removePanel(menu.current_panel)
            end
        end
    
        if key == 'f' then
            new_panel = Panel({x = menu.x+5,y = menu.y+5,width = menu.width-10, height = menu.height-10, panel_id = #menu.panels+1, panel_number = #menu.panels+1,r=0,g= 1,b=0,panel_row_number = 3,panel_col_number=2})
            -- print('panel row layout: ' .. new_panel.panel_row_number)
            -- print('panel col layout: ' .. new_panel.panel_col_number)
            
            menu:addPanel(new_panel)
            print('number of panels: ' .. #menu.panels)
            print('current panel: ' .. menu.current_panel)
            print('new panel id : ' .. tostring(menu.panels[1]['panel'].panel_state))
        end
        


    end
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

function love.update(dt)
    menu:update(dt)


end

function love.draw()
    -- love.graphics.rectangle('fill',50,50,100,100)
    menu:render()
    -- love.graphics.rectangle(mode,x,y,width,height)
end




pressed_button = function()
    -- print('a ui button is pressed')
    love.graphics.setColor(1,1,1)
    love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,5)
    love.graphics.reset()
end