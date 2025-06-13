

require 'src/Dependencies'

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    local spritesheet = love.graphics.newImage('img/Sprite-0001.png')
    spriteBatch = love.graphics.newSpriteBatch(spritesheet)

    gFrames = {
        ['animals'] = generateQuads(spritesheet,500,500)
    }

    for i = 1,5,1 do
        table.insert(entities,{
            quad = gFrames['animals'][i]
            ,x = 250
            ,y = 250
            ,r = 0 * 3.14/180
            ,sx = 1
            ,sy = 1
            ,ox = 250
            ,oy = 250
        })
    end

-- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)

    for i = 6,10,1 do
        table.insert(entities,{
            quad = gFrames['animals'][i]
            ,x = 750
            ,y = 250
            ,r = 0* 3.14/180
            ,sx = 1
            ,sy = 1
            ,ox = 250
            ,oy = 250
        })
    end


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
    -- Timer.every(1, function () print 'Tick!' end)

end

function love.draw()

    love.graphics.rectangle('fill',0,0,500,500)
    spriteBatch:clear()
	for _, entity in ipairs(entities) do
		spriteBatch:add(entity.quad
        , math.floor(entity.x)
        , math.floor(entity.y)
        , (entity.r)
        , (entity.sx)
        , (entity.sy)
        , math.floor(entity.ox)
        , math.floor(entity.oy) )
	end

	-- Finally, draw the sprite batch to the screen.
	love.graphics.draw(spriteBatch)

end
