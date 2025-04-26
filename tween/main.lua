require 'src/Dependencies'
Timer = require 'knife.timer'

MOVE_SPEED = 200
WINDOW_WIDTH = 300
WINDOW_HEIGHT = 600
px = WINDOW_WIDTH/2
py = WINDOW_HEIGHT/2

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    bubbles = {}
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then

        table.insert(bubbles,{
            bubble = true,
            bubbley = py,
            bubblex = px,
            rate = 3,
            size = 25,
        }) 

        for k, bubble in pairs(bubbles) do
            Timer.tween(bubble.rate, {
                [bubble] = { size = 0}
            })
        end   
    end
end

function love.update(dt)

    if love.keyboard.isDown('up') then
        py = py - MOVE_SPEED*dt
    end
    if love.keyboard.isDown('down') then
        py = py + MOVE_SPEED*dt
    end
    if love.keyboard.isDown('left') then
        px = px - MOVE_SPEED*dt
    end
    if love.keyboard.isDown('right') then
        px = px + MOVE_SPEED*dt
    end
    Timer.update(dt)
end

function love.draw()



    love.graphics.stencil(function ()
        love.graphics.rectangle("fill", 10, 10, 20, 20)
        -- love.graphics.rectangle('fill',px,py,50,50)
        love.graphics.draw(spritesheet, gFrames['menu'][1], px, py,0,4,4)
        love.graphics.draw(spritesheet, gFrames['menu'][2], px, py,0,3,3)
        -- iterate over bird table for drawing
        for k, bubble in pairs(bubbles) do
            love.graphics.circle('fill', bubble.bubblex, bubble.bubbley,bubble.size)
        end
        
      end,
      "replace", 1, false)
    love.graphics.setStencilTest("greater", 0)
    love.graphics.circle("fill", 50,100,100)


end
