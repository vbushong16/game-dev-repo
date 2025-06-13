--[[ License for original shader code that was ported to LÖVE
The MIT License

Copyright (c) 2013-2017 Mathew Groves, Chad Engler

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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
----LICENSE for original code that was ported over: https://github.com/pixijs/filters/tree/main/filters/shockwave/src MIT License
shaderShockwave = love.graphics.newShader[[
  extern number time;
  extern vec2 center;
  extern number wavelength;
  extern number radius;
  extern number speed;
  extern number amplitude;
  extern number brightness;
  
  vec4 effect( vec4 color, Image tex, vec2 uv, vec2 screen_coords ) {
  float halfWavelength = wavelength * 0.5 / love_ScreenSize.x;
  float maxRadius = radius / love_ScreenSize.x;
  float currentRadius = time * speed / love_ScreenSize.x;

  float fade = 0.5;

  if (maxRadius > 0.0) {
      if (currentRadius > maxRadius) {
          color = Texel(tex, uv);
          return color;
      }
      fade = 1.0 - pow(currentRadius / maxRadius, 2.0);
  }

  vec2 dir = vec2(uv - center / love_ScreenSize.xy);
  dir.y *= love_ScreenSize.y / love_ScreenSize.x;
  float dist = length(dir);

  if (dist <= 0.0 || dist < currentRadius - halfWavelength || dist > currentRadius + halfWavelength) {
      color = Texel(tex, uv);
      return color;
  }

  vec2 diffUV = normalize(dir);

  float diff = (dist - currentRadius) / halfWavelength;

  float p = 1.0 - pow(abs(diff), 2.0);

  //float powDiff = diff * pow(p, 2.0) * (amplitude * fade );
  float powDiff = 1.25 * sin(diff * 3.14159) * p * (amplitude * fade );

  vec2 offset = diffUV * powDiff / love_ScreenSize.xy;

  //Do clamp
  //vec2 coord = uv + offset;
  //vec2 clampedCoord = clamp(coord, love_ScreenSize.xy, love_ScreenSize.zw);
  //vec4 col = Texel(tex, clampedCoord);
  //if (coord != clampedCoord) {
      //col *= max(0.0, 1.0 - length(coord - clampedCoord));
  //}
  //No clamp
  color = Texel(tex, uv + offset);
  color.rgb *= 1.0 + (brightness - 1.0) * p * fade;
  return color;
  }
]]

-- variable to control the size of the shockwave
t = 0

-- here are various uniforms that you can change to fit your needs
shaderShockwave:send("wavelength", 160)
shaderShockwave:send("radius", -1)
shaderShockwave:send("speed", 500)
shaderShockwave:send("amplitude", 30)
shaderShockwave:send("brightness", 1)

canvas = love.graphics.newCanvas(640, 480)

sprites = {}
sprites.background = love.graphics.newImage("background.png")
end

function love.update(dt)
-- set the time uniform (the time it takes for the shockwave to grow to its current radius size)
shaderShockwave:send("time", t)
-- slowly increase the size of the shockwave
t = t + dt

-- if the shockwave time is greater than 5, set it to 0 and practically "hide" the shockwave 
if t > 5 then
   t = 0
end

-- set the position of the center of the shockwave to the x and y position of the mouse; position of the start point
x, y = love.mouse.getPosition()
shaderShockwave:send("center", {
      x,
      y
})
end

function love.draw()
love.graphics.setCanvas(canvas)
love.graphics.clear()
love.graphics.draw(sprites.background, 0, 0)
love.graphics.setShader(shaderShockwave)
love.graphics.setCanvas()
love.graphics.draw(canvas, 0, 0, 0, 1, 1)
love.graphics.setShader()

end

function love.keypressed(k)
  if k == "escape" then
    love.event.quit()
  end
end