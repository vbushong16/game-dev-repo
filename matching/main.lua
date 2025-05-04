

require 'src/Dependencies'

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    menu1 = Menu(menu1)
    menu1:openClose()
    print(menu1.panels[1].panel.panel_layout[1].button[1].button_selected)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end



function love.update(dt)
    menu1:update(dt)
    Timer.update(dt)

    -- print(#matched_buttons)

    if #comparing_buttons == 2 then
        if  comparing_buttons[1].button_val == comparing_buttons[2].button_val then
            comparing_buttons[1].button_clickable = false
            comparing_buttons[2].button_clickable = false
            table.insert(matched_buttons,comparing_buttons[1])
            table.insert(matched_buttons,comparing_buttons[2])
            comparing_buttons = {}
        else
            comparing_buttons[1]:reset() 
            comparing_buttons[2]:reset() 
            comparing_buttons = {}
        end
    end

    if #menu1.panels[1].panel.panel_layout == #matched_buttons then
        print('YOU WON')
    end
    
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
