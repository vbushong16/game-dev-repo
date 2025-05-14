local perspectiveShader

-- function love.load()
--     -- Error handling is good practice
--     local success, err = pcall(function()
--         perspectiveShader = love.graphics.newShader("perspective.glsl")
--     end)
--     if not success then
--         print("Shader Error: " .. tostring(err))
--         -- Fallback or error state
--     end
-- end

local image = love.graphics.newImage('sword_item.png')-- Your image object (e.g., image = love.graphics.newImage("my_image.png"))
local fov = 90.0
local y_rotation = 0.0 -- in degrees
local x_rotation = 0.0 -- in degrees
local inset_amount = 0.0 -- 0.0 to 1.0
local enable_cull_back = true

function love.update(dt)
    -- Example: Animate rotation
    -- y_rotation = y_rotation + 30 * dt
    -- x_rotation = x_rotation + 20 * dt
end

function love.draw()
    if perspectiveShader and image then
        love.graphics.setShader(perspectiveShader)

        -- Send uniforms to the shader
        perspectiveShader:send("fov", fov)
        perspectiveShader:send("cull_back", enable_cull_back)
        perspectiveShader:send("y_rot", y_rotation)
        perspectiveShader:send("x_rot", x_rotation)
        perspectiveShader:send("inset", inset_amount) -- Note: The `inset` logic from Godot's VERTEX manipulation
                                                    -- is more about scaling the object itself.
                                                    -- In LÖVE, you might do this with love.graphics.draw scale arguments.
                                                    -- The current shader uses `inset` in the vertex shader to scale
                                                    -- the centered_uv, which will affect the perspective.
                                                    -- If you want actual image border inset, that's different.

        perspectiveShader:send("texture_size", {image:getWidth(), image:getHeight()}) -- Though not directly used in this version, good to have

        -- Draw your image. The shader will apply to this draw call.
        -- Ensure your image is drawn in a way that its texture coordinates
        -- range from (0,0) to (1,1) across its surface.
        -- Drawing at origin (0,0) with no rotation/scaling here,
        -- so shader handles all transformations.
        -- The image will be drawn centered at its own center for the rotation effect.
        local img_w, img_h = image:getDimensions()
        love.graphics.draw(image, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, img_w/2, img_h/2)

        love.graphics.setShader() -- Unset the shader
    else
        -- Draw normally if shader or image failed to load
        if image then
            local img_w, img_h = image:getDimensions()
            love.graphics.draw(image, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, img_w/2, img_h/2)
        end
    end

    love.graphics.print("FOV: " .. fov, 10, 10)
    love.graphics.print("Y Rot: " .. y_rotation, 10, 30)
    love.graphics.print("X Rot: " .. x_rotation, 10, 50)
end

function love.keypressed(key)
    if key == "up" then
        x_rotation = x_rotation - 5
    elseif key == "down" then
        x_rotation = x_rotation + 5
    elseif key == "left" then
        y_rotation = y_rotation - 5
    elseif key == "right" then
        y_rotation = y_rotation + 5
    elseif key == "z" then
        fov = math.max(1, fov - 5)
    elseif key == "x" then
        fov = math.min(179, fov + 5)
    elseif key == "c" then
        enable_cull_back = not enable_cull_back
    elseif key == "i" then
        inset_amount = math.min(1, inset_amount + 0.1)
    elseif key == "o" then
        inset_amount = math.max(0, inset_amount - 0.1)
    end
end

-- Make sure you have an image file named "my_image.png" or change the path
-- For example, create a dummy one if needed for testing:
function love.filesystem.isFused() return false end -- Allow writing to game directory for this example
function love.load()
    -- local success, err = pcall(function()
    print("LÖVE Version:", love.getVersion())
    perspectiveShader = love.graphics.newShader("perspective.glsl")
    -- end)
    -- if not success then
        -- print("Shader Error: " .. tostring(err))
    -- end

    -- Create a test image if it doesn't exist
    -- local W, H = 200, 200
    -- local imageData = love.image.newImageData(W, H)
    -- imageData:mapPixel(function(x, y, r, g, b, a)
    --     local isBorder = x < 5 or x > W-6 or y < 5 or y > H-6
    --     local isChecker = (math.floor(x/20) + math.floor(y/20)) % 2 == 0
    --     if isBorder then
    --         return 255,0,0,255 -- Red border
    --     elseif isChecker then
    --         return 200,200,200,255 -- Light gray
    --     else
    --         return 150,150,150,255 -- Dark gray
    --     end
    -- end)
    -- image = love.graphics.newImage('sword_item.png')
end