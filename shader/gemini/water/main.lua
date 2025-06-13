-- Fragment Shader
local fragment_shader = [[
varying vec2 vTexCoord;
uniform sampler2D uTexture;
uniform float uTime;
//uniform vec2 uResolution;
uniform float uAmplitude;
uniform float uFrequency;
uniform float uSpeed;
uniform float uDistortion;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    // Time-dependent displacement for the water effect.
    float displacement = uAmplitude * sin(uFrequency * texture_coords.x + uTime * uSpeed);

    // Apply the displacement to the y-coordinate.  The distortion factor
    // controls how much the texture is shifted.
    texture_coords.y += displacement * uDistortion;

    // Fetch the color from the texture.
    vec4 waterColor = Texel(texture, texture_coords);

    // Add a subtle blue tint to the water.  This can be adjusted.
    waterColor.r *= 0.9;
    waterColor.g *= 0.95;
    waterColor.b *= 1.05;

    return waterColor;
}
]]

function love.load()
    -- Create a simple white image to use as the base texture.  Replace this
    -- with your actual water texture.
    local imageData = love.image.newImageData(256, 256)
    for x = 0, 255 do
        for y = 0, 255 do
            imageData:setPixel(x, y, 0, 0, 255, 255) -- White
        end
    end
    texture = love.graphics.newImage(imageData)
    spritesheet4 = love.graphics.newImage('sword_item.png')
    spritesheet4:setFilter('nearest','nearest')


    -- Create the shader
    shader = love.graphics.newShader(fragment_shader)
    if not shader then
        print("Error loading shader: " .. (shader:getErrorMessage() or "Unknown error"))
        error("Failed to load shader") -- Stop if the shader fails to load
    end

    -- Set initial shader parameters.  These can be adjusted to change the
    -- water effect.
    shader:send("uTime", 0)
    -- shader:send("uResolution", {love.graphics.getWidth(), love.graphics.getHeight()})
    shader:send("uAmplitude", 0.1) -- Height of the waves
    shader:send("uFrequency", 50.0) -- Number of waves
    shader:send("uSpeed", 2.0)    -- Speed of the waves
    shader:send("uDistortion", 0.5) -- How much the texture is distorted
    time = 0
end

function love.update(dt)
    time = time + dt
    shader:send("uTime", time)
end

function love.draw()
    -- Draw the textured quad.  The size and position can be adjusted.
    love.graphics.draw(texture, 0, 0, 0, love.graphics.getWidth()/texture:getWidth(), love.graphics.getHeight()/texture:getHeight())

    -- Set the shader
    love.graphics.setShader(shader)
    love.graphics.draw(spritesheet4,0,0,0,10,10)

    -- Unset the shader (good practice)
    love.graphics.setShader()


end
