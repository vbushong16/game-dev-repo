Timer = require 'knife.timer'

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 800
files_char = 'characters/2024-07-25 09-11-08 hecarim.png'
files_aval = 'characters/Snow sprite.png'
file_particle = 'characters/particle.png'

SPEED = 100
py = 0
px = 0
bubbles = {}
bubbleFixtures = {}
sizeAvalanch = 5

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 255,
        ['g'] = 0,
        ['b'] = 0
    },
}

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        vsync = false,
        resizable = false,
    })

    char = love.graphics.newImage(files_char)

    images ={
        ['char'] = love.graphics.newImage(files_char),
        ['aval'] = love.graphics.newImage(files_aval),
        ['particle'] = love.graphics.newImage(file_particle)
    }

    image_quads = {
        ['char'] = select(1,generateQuads(images['char'],32,32)),
        ['aval'] = select(1,generateQuads(images['aval'],16,16))
    }
    image_quad_size ={
        ['char'] = {image_quads['char'][1]:getViewport()},
        ['aval'] = {image_quads['aval'][1]:getViewport()}
    }
    -- print(image_quad_size['aval'][4])
    -- print(select(4,image_quads['char'][1]:getViewport()))
    world = love.physics.newWorld(0,0)

    playerBody = love.physics.newBody(world,px,py,'dynamic')
    playerShape = love.physics.newRectangleShape(image_quad_size['char'][3],image_quad_size['char'][4])   
    playerFixture = love.physics.newFixture(playerBody,playerShape,10)
    
    -- various behavior-determining functions for the particle system
    -- https://love2d.org/wiki/ParticleSystem
    avalanche_particles = love.graphics.newParticleSystem(images['particle'], 300)
    avalanche_particles:setParticleLifetime(0.5, 1)
    avalanche_particles:setLinearAcceleration(0, 0, 0, 80)
    avalanche_particles:setEmissionArea('uniform', 10, sizeAvalanch/2)
    avalanche_particles:setColors(
     paletteColors[1].r / 255,
     paletteColors[1].g / 255,
     paletteColors[1].b / 255,
     55 * (0 + 1) / 255,
     paletteColors[1].r / 255,
     paletteColors[1].g / 255,
     paletteColors[1].b / 255,
     0
    )

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then

        avalX = math.random(0,WINDOW_WIDTH)
        avalY = 0

        table.insert(bubbles,{
            bubble = true,
            bubbley = avalY,
            bubblex = avalX,
            rate = 3,
            size = 1,
            col_added = false,
            bubbleBody = love.physics.newBody(world,(avalX +(image_quad_size['aval'][3]/2)*sizeAvalanch) ,(avalY+ image_quad_size['aval'][4]/2),'kinematic'),
            bubbleShape = love.physics.newRectangleShape(image_quad_size['aval'][3]*sizeAvalanch,image_quad_size['aval'][4]),            
            -- bubbleShape = love.physics.newCircleShape(10),            
        }) 

        for i, bubble in pairs(bubbles) do
            if bubble.col_added == false then
                table.insert(bubbleFixtures,{
                    love.physics.newFixture(bubble.bubbleBody,bubble.bubbleShape,10)
                })
            end
            bubble.col_added = true
        end

        

        
        for k, bubble in pairs(bubbles) do
            Timer.tween(bubble.rate, {
                [bubble] = {size = WINDOW_HEIGHT/16/2},
            })
        end
        bubbles[1]['bubbleBody']:setAngularVelocity(0) 
    end
    -- Timer.every(1/60, function () avalanche_particles:emit(64) end)
    -- :limit(62*3)
    

    

end

function love.update(dt)

    local pvx = 0
    local pvy = 0
    if love.keyboard.isDown('down') then
        -- py = py + SPEED*dt
        pvy = SPEED
    end
    if love.keyboard.isDown('up') then
        -- py = py - SPEED*dt
        pvy = -SPEED
    end
    if love.keyboard.isDown('right') then
        -- px = px + SPEED*dt
        is_right = false
        pvx = SPEED
    end
    if love.keyboard.isDown('left') then
        -- px = px - SPEED*dt
        is_right = true
        pvx = -SPEED
    end

    playerBody:setLinearVelocity(pvx,pvy)
            
    for k, bubble in pairs(bubbles) do
        if bubble.bubbleBody:getY() < (WINDOW_HEIGHT-16)/2 then
            bubble['bubbleBody']:setLinearVelocity(0,(400-16)/3)
            avalanche_particles:emit(300)
        else
            bubbleFixtures[k][k]:destroy()
            table.remove(bubbleFixtures,k)
            table.remove(bubbles,k)

        end

    end
    

    Timer.update(dt)
    world:update(dt)
    avalanche_particles:update(dt)
end

function love.draw()

    love.graphics.rectangle('line',px-image_quad_size['char'][3]/2,py,image_quad_size['char'][3],image_quad_size['char'][4])
    for k, bubble in pairs(bubbles) do
        love.graphics.draw(images['aval'],image_quads['aval'][1], bubble.bubblex, bubble.bubbley,0,sizeAvalanch,bubble.size)
        love.graphics.draw(avalanche_particles, bubble.bubblex+(5*16)/2, 16 * bubble.size,0,5)
    end

    love.graphics.setColor( 1, 0, 0, 1 )
    for _, body in pairs(world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
    
            if shape:typeOf("CircleShape") then
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("line", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
    love.graphics.reset( )


    love.graphics.draw(images['char'],image_quads['char'][1],playerBody:getX(),playerBody:getY()-16,0, is_right == true and 1 or -1, 1,image_quad_size['char'][3]/2)
    --love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)


end



function generateQuads(atlas,spriteWidth,spriteHeight)
    local spritesHeight = atlas:getHeight()/spriteHeight
    local spritesWidth = atlas:getWidth()/spriteWidth

    local spriteCounter = 1
    local spriteTable = {}

    for y = 0, spritesHeight-1 do
        for x = 0, spritesWidth-1 do
            spriteTable[spriteCounter] = love.graphics.newQuad(x * spriteWidth,y * spriteHeight,spriteWidth
            ,spriteHeight,atlas:getDimensions())
            spriteCounter = spriteCounter + 1
        end
    end

    return spriteTable
end


