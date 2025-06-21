

require 'Dependencies'

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)

    SW = 28
    SH = 25


end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

end

function love.draw()

    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    love.graphics.draw(gTextures['frame6'],gFrames['frame6'][1],0,0,0,SW,SH) -- BOT
    love.graphics.draw(gTextures['frame6'],gFrames['frame6'][2],0,0,0,SH,SW) -- LEFT
    love.graphics.draw(gTextures['frame6'],gFrames['frame6'][3],0,0,0,SW,SH) -- TOP
    love.graphics.draw(gTextures['frame6'],gFrames['frame6'][4],0,0,0,SH,SW) -- RIGHT

end