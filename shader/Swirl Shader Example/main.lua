--[[ License for original shader code that was ported to LÖVE
MIT License

Copyright (c) 2018 Rex

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

--[[ License for the current code
MIT License

Copyright (c) 2023 Cip

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

function love.load()
  
love.window.setMode(640, 480)
--LICENSE for original code that was ported over: https://github.com/rexrainbow/phaser3-rex-notes/blob/master/plugins/shaders/swirl/swirl-postfxfrag.js


swirlShader = love.graphics.newShader [[

extern float radius;
extern float angle;
extern vec2 center;

    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
    {
    vec2 texSize = love_ScreenSize.xy; //here is was love_ScreenSize.xy
    vec2 tc = texture_coords * texSize;
    tc -= center;
    float dist = length(tc);

    if (dist < radius) {
      float percent = (radius - dist) / radius;
      float theta = percent * percent * angle * 8.0;
      float s = sin(theta);
      float c = cos(theta);
      tc = vec2(dot(tc, vec2(c, -s)), dot(tc, vec2(s, c)));
    }
    tc += center;
    color = Texel(texture, tc / texSize);
    return color;
    }
]]

-- variable to control the speed at which the swirling occurs
t = 0

-- send the angle of the spiral
swirlShader:send("angle", 3)
canvas = love.graphics.newCanvas(640, 480)

-- variable to control when the spiral grows and decreases in size
canDecrease = false

sprites = {}
sprites.background = love.graphics.newImage("background.png")
end

function love.update(dt)
 
-- spiral increases in size 
if canDecrease == false then
  t = t + dt * 40
end

-- spiral decreases in size
if canDecrease == true then
  t = t - dt * 40
end

-- if statement to determine when the spiral grows or shrinks in size
if t < 0 then
   canDecrease = false
elseif t > 160 then
   canDecrease = true
end


-- send size of the spiral. it is set up in update function so that it can dynamically grow and shrink in size
swirlShader:send("radius", t)

-- send x and y position to shader (where the spiralling begins). it is set up in update function, to always update to current mouse position
x, y = love.mouse.getPosition()
swirlShader:send("center", {
      x,
      y
})
end

function love.draw()
love.graphics.setCanvas(canvas)
love.graphics.clear()
love.graphics.draw(sprites.background, 0, 0)
love.graphics.setShader(swirlShader)
love.graphics.setCanvas()
love.graphics.draw(canvas, 0, 0, 0, 1, 1)
love.graphics.setShader()
end

function love.keypressed(k)
  if k == "escape" then
    love.event.quit()
  end
end