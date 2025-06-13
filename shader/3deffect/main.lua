function love.load()
    -- Load shader and image
    shader = love.graphics.newShader("shader.glsl")
    image = love.graphics.newImage("sword_item.png")
    
    -- Initial shader parameters
    shader:send("fov", 90)
    shader:send("cull_back", false)
    shader:send("x_rot", 0)
    shader:send("y_rot", 0)
    shader:send("inset", 0.05) -- Small inset to prevent edge clipping
    
    -- Set texture size
    -- shader:send("texture_size", {image:getDimensions()})
    
    -- Store image dimensions and position
    imageWidth, imageHeight = image:getDimensions()
    imageX, imageY = 150, 150
    
    -- Max rotation in degrees (limit rotation to this range)
    maxRotation = 30 -- Adjust this value as desired
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
    shader:send("y_rot", y_rotation)
    shader:send("x_rot", x_rotation)
end

function love.draw()
    -- Apply shader and draw image
    love.graphics.setShader(shader)
    love.graphics.draw(image, imageX, imageY,0,15,15)
    love.graphics.setShader()
    
    -- Optional: Draw instructions
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Move mouse to rotate image", 10, 10)
    
    -- Reset color
    love.graphics.reset()
end