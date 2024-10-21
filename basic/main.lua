

WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500
BOX_SIZE = 100

x =WINDOW_WIDTH/2
y = 0
counter = 0

GRAVITY = 10
dy = 0

projectiles = {}

projx =0
projy = 0
py = 10
px = 10
pscore = 0

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then
        --table.insert{projectiles,}
        proj = true
        projx = px
        projy = py
    end
end


function love.update()

    y=y+dy

    if y <= 0 then
        dy = GRAVITY
    elseif y>= WINDOW_HEIGHT-BOX_SIZE then
        dy = -GRAVITY
    end

    

    if love.keyboard.isDown('space') then
        table.insert(projectiles,px)
    end

    if love.keyboard.isDown('down') then
        py = math.min(WINDOW_HEIGHT,py + GRAVITY)
    end
    if love.keyboard.isDown('left') then
        px = math.max(0,px - GRAVITY)
    end
    if love.keyboard.isDown('right') then
        px = math.min(WINDOW_WIDTH,px + GRAVITY)
    end
    if love.keyboard.isDown('up') then
        py = math.max(0,py - GRAVITY)
    end
    
    if py >= y and py <= y+BOX_SIZE then
        if px >= x and px <= x+BOX_SIZE then
            py = 0
            px = 0
        end
    end


    if proj == true then
        projx = projx+GRAVITY
    else
        projx = px
        projy = py
    end 

    if projy >= y and projy <= y+BOX_SIZE then
        if projx >= x and projx <= x+BOX_SIZE then
            pscore = pscore - 1
            proj = false
        end
    end

    if projx == WINDOW_WIDTH then
        pscore = pscore + 1
        projx = px
        projy = py
        proj = false
    end

end


function love.draw()
    -- love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    love.graphics.rectangle('fill',x,y,BOX_SIZE,BOX_SIZE)
    love.graphics.rectangle('fill',projx,projy,5,10)
    love.graphics.circle('fill',px,py,10,10)
    love.graphics.printf('Score: ' .. tostring(pscore), 0, 0, WINDOW_WIDTH)
end
