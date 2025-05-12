local floor = math.floor
local rect = love.graphics.rectangle

local fluid_shader_code = [[
    const float size = 1.0/512.0;
    const vec4 blue = vec4(0.2,0.2,0.8,1.0);

    vec4 effect(vec4 global_color, Image texture, vec2 texture_coords, vec2 pixel_coords)
    {
        vec4 pixel = Texel(texture, texture_coords);
        vec4 upper = Texel(texture, vec2(texture_coords.x, texture_coords.y+size));
        vec4 lower = Texel(texture, vec2(texture_coords.x, texture_coords.y-size));
        vec4 ll = Texel(texture, vec2(texture_coords.x-size, texture_coords.y-size));
        vec4 lr = Texel(texture, vec2(texture_coords.x+size, texture_coords.y-size));
        vec4 ul = Texel(texture, vec2(texture_coords.x-size, texture_coords.y+size));
        vec4 ur = Texel(texture, vec2(texture_coords.x+size, texture_coords.y+size));
        vec4 l = Texel(texture, vec2(texture_coords.x-size, texture_coords.y));
        vec4 r = Texel(texture, vec2(texture_coords.x+size, texture_coords.y));

        if (pixel.b == 1.0) { //its solid, skip it
            return pixel;
        }

        if (lower.b == 1.0){
            if (pixel.r == 1.0) {
                return pixel;
            }
            else if (upper.r == 1.0) {
                pixel.g = min (1.0-pixel.g, upper.g);
                return upper;
            }
        }

        if (pixel.r != 1.0 && upper.r == 1.0) {
            return upper; //needs changing
        }

        if (lower.r != 1.0 && pixel.r == 1.0 ) {
            return vec4(0.0);
        }
        else
            return pixel;
    }
]]

local drawer_shader_code = [[
    const vec4 blue = vec4(0.2,0.2,0.8,1.0);

    vec4 effect(vec4 global_color, Image texture, vec2 texture_coords, vec2 pixel_coords)
    {
        vec4 pixel = Texel(texture, texture_coords);

        if (pixel.r == 1.0) {
            return blue;//needs changing
        }
        else if (pixel.b == 1.0) {
            return vec4(1.0);
        }
        return pixel;
    }
]]

fluid = love.graphics.newShader(fluid_shader_code)
drawer = love.graphics.newShader(drawer_shader_code)

local screensize = love.graphics.getWidth()
local fb1 = love.graphics.newCanvas(screensize, screensize)
local fb2 = love.graphics.newCanvas(screensize, screensize)
local drawing = love.graphics.newCanvas(screensize, screensize)

local tilesize = 8
local tilenumber = screensize / tilesize
local t = {}

for i = 0, tilenumber - 1 do
    if not t[i] then
        t[i] = {}
    end
    for j = 0, tilenumber - 1 do
        t[i][j] = { f = 0 }
    end
end

local mouse_x, mouse_y

function love.mousepressed(x, y, button)
    local grid_x = floor((x) / tilesize)
    local grid_y = floor((y) / tilesize)

    if button == "r" then
        if t[grid_x] and t[grid_x][grid_y] then
            if t[grid_x][grid_y].solid then
                t[grid_x][grid_y].f = 0
                t[grid_x][grid_y].solid = nil
            else
                t[grid_x][grid_y].solid = true
            end
        end
    end
    mouse_x, mouse_y = x, y
end

function love.draw()
    -- Draw to the 'drawing' canvas
    love.graphics.setCanvas(drawing)
    love.graphics.clear(0, 0, 0, 0) -- Clear the drawing canvas

    if love.mouse.isDown(1) then
        love.graphics.setColor(255, 100, 0, 255)
        love.graphics.rectangle("fill", mouse_x - 2, mouse_y - 2, 5, 5) -- Adjust position for center
    end

    love.graphics.setColor(0, 0, 255, 255)
    for i = 0, tilenumber - 1 do
        for j = 0, tilenumber - 1 do
            if t[i] and t[i][j] and t[i][j].solid then
                rect("fill", i * tilesize, j * tilesize, tilesize, tilesize)
            end
        end
    end
    love.graphics.setCanvas() -- Stop drawing to 'drawing' canvas

    -- Draw 'drawing' canvas to the screen (for debugging)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(drawing, 0, 0)

    -- Apply fluid effect
    love.graphics.setCanvas(fb1)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setShader(fluid)
    love.graphics.draw(fb2)
    love.graphics.draw(drawing)
    love.graphics.setShader()
    love.graphics.setCanvas()

    -- Copy fb1 to fb2
    love.graphics.setCanvas(fb2)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.draw(fb1)
    love.graphics.setCanvas()

    -- Apply drawer effect and draw to screen
    love.graphics.setShader(drawer)
    love.graphics.draw(fb2)
    love.graphics.setShader()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(love.timer.getFPS(), 20, 20)
end