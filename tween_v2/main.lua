
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
    end
end

function love.update(dt)

    if love.keyboard.isDown('up') then
        py = py - MOVE_SPEED*dt
        create_bubbles(bubbles,py,px)
    end
    if love.keyboard.isDown('down') then
        py = py + MOVE_SPEED*dt
        create_bubbles(bubbles,py,px)
    end
    if love.keyboard.isDown('left') then
        px = px - MOVE_SPEED*dt
        create_bubbles(bubbles,py,px)
    end
    if love.keyboard.isDown('right') then
        px = px + MOVE_SPEED*dt
        create_bubbles(bubbles,py,px)
    end


    for k, bubble in pairs(bubbles) do
        Timer.tween(bubble.rate, {
            [bubble] = { size = 5}
        })
        if bubble.size < 8 then
            table.remove(bubbles,k)
        end
    end

    Timer.update(dt)
end

function love.draw()

    love.graphics.rectangle('fill',px,py,50,50)
    -- iterate over bird table for drawing
    for k, bubble in pairs(bubbles) do
        love.graphics.circle('line', bubble.bubblex, bubble.bubbley,bubble.size)
    end

end


function create_bubbles(bubbles,py,px)
    table.insert(bubbles,{
        bubble = true,
        bubbley = py,
        bubblex = px,
        rate = 0.3,
        size = 25,
        }) 
end