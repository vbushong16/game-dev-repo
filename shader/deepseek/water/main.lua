function love.load()
    love.window.setTitle("Water Shader Demo")
    love.window.setMode(800, 600, {resizable = true, vsync = true})

    -- Load shader with error handling
    local shader_success, shader_error = pcall(function()
        water_shader = love.graphics.newShader("water.glsl")
    end)
    
    if not shader_success then
        print("Shader error:", shader_error)
        love.event.quit()
    end

    image = love.graphics.newImage('sword_item.png')

    -- Load noise texture
    local function createNoiseTexture(size)
        local img_data = love.image.newImageData(size, size)
        for y = 0, size-1 do
            for x = 0, size-1 do
                local value = love.math.noise(x/10, y/10, love.timer.getTime())
                img_data:setPixel(x, y, value, value, value, 1)
            end
        end
        return love.graphics.newImage(img_data)
    end
    noise_image = createNoiseTexture(256)
    noise_image:setWrap("repeat", "repeat")
    noise_image:setFilter("linear", "linear")

    -- Set shader parameters
    water_shader:send("noise_tex", noise_image)
    water_shader:send("noise_tex_size", {noise_image:getWidth(), noise_image:getHeight()})
    water_shader:send("texture_size", {love.graphics.getWidth(), love.graphics.getHeight()})

    -- Create background pattern
    bg_pattern = love.graphics.newCanvas(20, 20)
    love.graphics.setCanvas(bg_pattern)
        love.graphics.clear(0.2, 0.3, 0.1, 1)
        love.graphics.setColor(0.3, 0.4, 0.2)
        love.graphics.rectangle("fill", 0, 0, 10, 10)
        love.graphics.rectangle("fill", 10, 10, 10, 10)
    love.graphics.setCanvas()
end

function love.update(dt)
    water_shader:send("time", love.timer.getTime())
    water_shader:send("texture_size", {love.graphics.getWidth(), love.graphics.getHeight()})
end

function love.draw()
    -- Draw background
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bg_pattern, 0,0, 0, 0, 0, 
        love.graphics.getWidth()/20,
        love.graphics.getHeight()/20
    )

    -- Draw water
    love.graphics.setShader(water_shader)
    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.rectangle("fill", 100, 300, 600, 200)
    love.graphics.draw(image,100,300,0,5,5)
    love.graphics.setShader()
    
    -- Draw UI
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Water Shader Demo", 10, 10)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 30)
end

function love.resize(w, h)
    water_shader:send("texture_size", {w, h})
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end