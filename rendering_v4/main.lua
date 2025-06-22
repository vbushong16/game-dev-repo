

require 'src/Dependencies'

function love.load()
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setDefaultFilter('linear', 'linear')

    Push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        highdpi = true,
        canvas = true
      })
    Push:setupCanvas({
        {name = 'base'}--, shader = shader2}
        ,{name = 'frame',shader = shaders[9]}
        ,{name = 'animal'}
        ,{name = 'animal2'}
    })

    -- VERSION WITHOUT USING PUSH LIBRARY
    -- love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)


    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)

    for i = 1,10,1 do
        table.insert(entities,{
            quad = gFrames['animals'][i]
            ,x = 250
            ,y = 250
            ,r = 0 * 3.14/180
            ,sx = 0.8
            ,sy = 0.8
            ,ox = 250
            ,oy = 250
        })
    end

    for i = 1,4,1 do
        table.insert(frames,{
            quad = gFrames['frame'][i]
            ,x = 0
            ,y = 0
            ,r = 0* 3.14/180
            ,sx = 500/32
            ,sy = 500/32
            ,ox = 0
            ,oy = 0
        })
    end

end

function love.resize(w, h)
    return Push:resize(w, h)
  end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'p' then
        -- Timer.tween(5, {
        --     [entities[1]] = { r = 100*3.14/180 },
        --     [entities[2]] = { r = 100*3.14/180 },
        --     [entities[3]] = { r = 100*3.14/180 },
        --     [entities[4]] = { r = 100*3.14/180 },
        --     [entities[5]] = { r = 100*3.14/180 },
        -- })

        for i = 1,#entities,1 do
            forward_tween(entities[i],0.5,5)
        end

    end
end

function forward_tween(object,rate,final_angle)
    Flux.to(object,rate,{r = final_angle*3.14/180}):ease("linear"):oncomplete(function() backward_tween(object,math.random(0.3,0.5),0) end)
end

function backward_tween(object,rate,final_angle)
    Flux.to(object,rate,{r = final_angle*3.14/180}):ease("linear"):oncomplete(function() forward_tween(object,math.random(0.3,0.5),math.random(final_angle-2,final_angle+2)) end)
end


function love.update(dt)
    Timer.update(dt)
    Flux.update(dt)
    shaders[9]:send("time", love.timer.getTime())
    
    -- VERSION WITHOUT USING PUSH LIBRARY
    -- canvases['frame']:renderTo(function()
    --     love.graphics.setShader(shaders[9])
    --     shaders[9]:send('time',love.timer.getTime(dt))
    --     renderImagePrep(frameBatch,frames,1,4)
    --     love.graphics.setShader()
    -- end
    -- )
    -- canvases['animal1']:renderTo(function()
    --     love.graphics.rectangle('fill',0,0,500,500)
    --     -- love.graphics.setShader(shaders[9])
    --     -- shaders[9]:send('time',love.timer.getTime(dt))
    --     renderImagePrep(spriteBatch,entities,1,5)
    --     -- love.graphics.setShader()    
    -- end
    -- )
    -- canvases['animal2']:renderTo(function()
    --     love.graphics.rectangle('fill',0,0,500,500)
    --     -- love.graphics.setShader(shaders[9])
    --     -- shaders[9]:send('time',love.timer.getTime(dt))
    --     renderImagePrep(spriteBatch,entities,6,10)
    --     -- love.graphics.setShader()    
    -- end
    -- )

end

function love.draw()

   
    Push:apply("start")
    Push:setCanvas('base')
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill',0,0,1000,500)
    
    Push:setCanvas('animal')
    animal1 = renderImagePrep(spriteBatch,entities,1,5)
    love.graphics.draw(animal1,0,0)
    
    Push:setCanvas('frame')
    -- Push:setShader('frame',shaders[9])
    frame = renderImagePrep(frameBatch,frames,1,4)
    love.graphics.draw(frame,0,0)
    -- Push:setShader()

    Push:setCanvas('animal2')
    animal2 = renderImagePrep(spriteBatch,entities,6,10)
    love.graphics.draw(animal2,500,0)

    Push:setCanvas('frame')
    -- Push:setShader('frame',shaders[9])
    frame = renderImagePrep(frameBatch,frames,1,4)
    love.graphics.draw(frame,500,0)
    -- Push:setShader()
    Push:apply("end")

    
    -- VERSION WITHOUT USING PUSH LIBRARY
    -- love.graphics.rectangle('fill',0,0,1000,1000)
    -- love.graphics.draw(canvases['animal1'],0,0)
    -- love.graphics.draw(canvases['frame'],0,0)

    -- love.graphics.draw(canvases['animal2'],500,0)
    -- love.graphics.draw(canvases['frame'],500,0)

end
