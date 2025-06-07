


WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    -- Load shader and image
    effect3d = love.graphics.newShader("src/3deffect.glsl")
    local shader_code = 'src/shader.glsl'
    image = love.graphics.newImage("src/sword_item.png")
    image:setFilter('nearest','nearest')
    
    -- Create the shader object.
    shader = love.graphics.newShader(shader_code)
    -- shader:send( "background",spritesheet4)
    numCircles = 100
    circles = {}
    for i = 1, numCircles,1 do
      circle = {math.random(0,500),math.random(0,500),math.random(5,10)}
      -- circle.x = math.random(0,500)
      -- circle.y = math.random(0,500)
      -- circle.z = math.random(5,10)
      table.insert(circles,circle)
    end

    shader:send( "circles",unpack(circles))


    -- Initial shader parameters
    effect3d:send("fov", 90)
    effect3d:send("cull_back", false)
    effect3d:send("x_rot", 0)
    effect3d:send("y_rot", 0)
    effect3d:send("inset", 0.05) -- Small inset to prevent edge clipping
    
    -- Set texture size
    -- shader:send("texture_size", {image:getDimensions()})
    
    -- Store image dimensions and position
    imageWidth, imageHeight = image:getDimensions()
    imageX, imageY = 150, 150
    
    -- Max rotation in degrees (limit rotation to this range)
    maxRotation = 45 -- Adjust this value as desired
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
  end

function love.update(dt)
    -- Get window dimensions
    local windowWidth, windowHeight = love.graphics.getDimensions()
    
    -- Get mouse position
    local mouseX, mouseY = love.mouse.getPosition()
    
    -- Calculate center of the image
    local centerX = imageX + imageWidth / 2
    local centerY = imageY + imageHeight / 2
    
    -- Calculate mouse position relative to image center (-1 to 1 range)
    local relativeX = (mouseX - centerX) / (windowWidth / 2)
    local relativeY = (mouseY - centerY) / (windowHeight / 2)
    
    -- Limit the relative values to a range of -1 to 1
    relativeX = math.max(-1, math.min(1, relativeX))
    relativeY = math.max(-1, math.min(1, relativeY))
    
    -- Convert to rotation angles with limited range
    -- Invert Y rotation for more intuitive control (mouse right = image rotates right)
    local y_rotation = -relativeX * maxRotation
    -- Invert X rotation to make it feel more natural
    local x_rotation = relativeY * maxRotation
    
    -- Update shader parameters
    effect3d:send("y_rot", y_rotation)
    effect3d:send("x_rot", x_rotation)
end

function love.draw()

    
    love.graphics.setShader(shader)
    shader:send( "millis",love.timer.getTime(dt))
    -- Draw a fullscreen quad.
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    love.graphics.setShader() --Unset the shader after drawing.

    -- Optional: Draw instructions
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Move mouse to rotate image", 10, 10)
    -- Reset color
    love.graphics.reset()

    -- Apply shader and draw image
    love.graphics.setShader(effect3d)
    love.graphics.draw(image, imageX, imageY,0,15,15)
    love.graphics.setShader()
end