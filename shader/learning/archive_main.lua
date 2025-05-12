
shader = 'src/shader.glsl'

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    shaderCode = love.graphics.newShader(shader)
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

end

function love.draw()

	love.graphics.setShader(shaderCode)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
	love.graphics.setShader()

end