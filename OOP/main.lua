
require 'dependencies'


WINDOW_HEIGHT = 800
WINDOW_WIDTH = 800


function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false
    })
    yeti = Entity(gAtlas['spriteSheet'],WINDOW_WIDTH/2, WINDOW_HEIGHT/2)
    yeti:createAnimation('idleYeti',{1,2},0.2)
end

function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    end
    if key == 'return' then
        yeti:changeAnimation('eatingYeti',{1,2,3,4},0.2)
    end
end

function love.update(dt)

    yeti:update(dt)
end

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    yeti:render(10,20)
end