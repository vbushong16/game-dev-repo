WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{resizable = true})
    shader = love.graphics.newShader('shader.glsl')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

end

function love.draw()

    love.graphics.setShader(shader)
    shader:send('time',love.timer.getTime(dt))
    -- love.graphics.rectangle(mode,x,y,width,height)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    love.graphics.setShader()


end
