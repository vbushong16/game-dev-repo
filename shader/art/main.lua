WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000

canvas_width = 200
canvas_height = 200

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{resizable = true})
    shader = love.graphics.newShader('shader.glsl')
    shader2 = love.graphics.newShader('shader2.glsl')
    shader3 = love.graphics.newShader('shader3.glsl')
    shader4 = love.graphics.newShader('shader4.glsl')
    shader5 = love.graphics.newShader('shader5.glsl')
    shader6 = love.graphics.newShader('shader6.glsl')
    shader7 = love.graphics.newShader('shader7.glsl')
    shader8 = love.graphics.newShader('shader8.glsl')
    shader9 = love.graphics.newShader('shader9.glsl')
    shader10 = love.graphics.newShader('shader10.glsl')
    shader01 = love.graphics.newShader('shader01.glsl')

    canvas1 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas2 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas3 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas4 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas5 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas6 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas7 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas8 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas9 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas10 = love.graphics.newCanvas(canvas_width,canvas_height)
    canvas01 = love.graphics.newCanvas(canvas_width,canvas_height)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

    canvas1:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader)
        shader:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end  
    )
    canvas2:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader2)
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end  
    )
    canvas3:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader3)
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end  
    )
    canvas4:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader4)
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas5:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader5)
        shader5:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas6:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader6)
        shader6:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas7:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader7)
        shader7:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas8:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader8)
        shader8:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas9:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader9)
        shader9:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas10:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader10)
        shader10:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )
    canvas01:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader01)
        shader01:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,canvas_width,canvas_height)
        love.graphics.setShader()
    end
    )

end

function love.draw()

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    love.graphics.reset()
    love.graphics.draw(canvas1,0,0)
    love.graphics.draw(canvas2,200,0)
    love.graphics.draw(canvas3,400,0)
    love.graphics.draw(canvas4,600,0)
    love.graphics.draw(canvas5,800,0)
    love.graphics.draw(canvas6,0,200)
    love.graphics.draw(canvas7,200,200)
    love.graphics.draw(canvas8,400,200)
    love.graphics.draw(canvas9,600,200)
    love.graphics.draw(canvas10,800,200)
    love.graphics.draw(canvas01,0,400)

    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)

end
