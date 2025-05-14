-- Fragment Shader
local fragment_shader = [[
varying vec2 vTexCoord;
uniform float uTime;

uniform float uIntensity;
uniform float uWindSpeed;
uniform float uGrainSize;

// Simplex noise function (simplified)
float simplex(vec2 coord)
{
    vec2 skew = vec2(0.366025403, 0.211324865); // Precalculated skew factors
    vec2 unskew = vec2(0.5 - 1.0/3.0, (1.0/3.0));

    // Skew the input to a hexagonal grid
    vec2 skewed_coord = (coord + dot(coord, skew));
    vec2 grid_cell = floor(skewed_coord);
    vec2 pos_in_cell = (skewed_coord - grid_cell);

    // Contribution from the origin
    float origin_contribution = 0.0;
    vec2 offset1 = vec2(1.0, 0.0);
    vec2 offset2 = vec2(0.0, 1.0);

    // Calculate the influence of each corner of the simplex.
    float c1 = max(0.0, 0.5 - dot(pos_in_cell, pos_in_cell));
    float c2 = max(0.0, 0.5 - dot(pos_in_cell - offset1, pos_in_cell - offset1));
    float c3 = max(0.0, 0.5 - dot(pos_in_cell - offset2, pos_in_cell - offset2));

    // Gradient vectors for the three corners
    vec2 grad1 = vec2(1.0, 0.0);
    vec2 grad2 = vec2(0.0, 1.0);
    vec2 grad3 = vec2(1.0, 1.0);


    origin_contribution = c1 * c1 * c1 * c1 * dot(pos_in_cell, grad1);
    float contrib1 = c2 * c2 * c2 * c2 * dot(pos_in_cell - offset1, grad2);
    float contrib2 = c3 * c3 * c3 * c3 * dot(pos_in_cell - offset2, grad3);
    return 70.0 * (origin_contribution + contrib1 + contrib2);
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 screen_uv = texture_coords;

    // Wind effect (scroll the noise field)
    float wind_offset_x = uTime * uWindSpeed;
    vec2 noise_uv = texture_coords * 10.0 + vec2(wind_offset_x, uTime * uWindSpeed * 0.5);

    // Generate noise
    float noise = simplex(noise_uv);

    // Distort UVs based on noise and intensity
    vec2 distorted_uv = texture_coords + vec2(
        (noise * uIntensity * 0.05),
        (noise * uIntensity * 0.08)
    );

    // Sample the texture with distorted UVs
    vec4 sandColor = Texel(texture, distorted_uv);

    // Color the sand.  Make it more brownish.
     sandColor = vec4(1.0, 0.9, 0.8, 1.0) * sandColor;


    // Add noise to the color to make it more grainy
    float grain = (simplex(texture_coords * uGrainSize + uTime * 2.0) * 0.5 + 0.5) * 0.2;
    sandColor += vec4(grain, grain, grain, 0.0);


    return sandColor;
}
]]

function love.load()
    -- Create a white texture.  Replace with a sand texture if you have one.
    local imageData = love.image.newImageData(256, 256)
    for x = 0, 255 do
        for y = 0, 255 do
            imageData:setPixel(x, y, 255, 255, 255, 255)
        end
    end
    texture = love.graphics.newImage(imageData)
    spritesheet4 = love.graphics.newImage('sword_item.png')
    spritesheet4:setFilter('nearest','nearest')


    -- Load the shader
    shader = love.graphics.newShader(fragment_shader)
    if not shader then
        print("Error loading shader: " .. (shader:getErrorMessage() or "Unknown error"))
        error("Failed to load shader")
    end

    -- Set shader parameters
    shader:send("uTime", 0)
    -- shader:send("uResolution", {love.graphics.getWidth(), love.graphics.getHeight()})
    shader:send("uIntensity", 1.0)    -- Intensity of the sandstorm
    shader:send("uWindSpeed", 5.0)   -- Speed of the wind
    shader:send("uGrainSize", 30.0);  -- Size of the sand grains
    time = 0
end

function love.update(dt)
    time = time + dt
    shader:send("uTime", time)
end

function love.draw()
    love.graphics.setShader(shader)
    love.graphics.draw(texture, 0, 0, 0, love.graphics.getWidth()/texture:getWidth(), love.graphics.getHeight()/texture:getHeight())
    love.graphics.draw(spritesheet4,0,0,0,10,10)
    love.graphics.setShader()
end
