-- Lua code (main.lua)

WINDOW_WIDTH = 500
WINDOW_HEIGHT = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    -- Load the shader.
    local shader_code = 'src/shader.glsl'
    spritesheet4 = love.graphics.newImage('src/sword_item.png')
    spritesheet4:setFilter('nearest','nearest')
  
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
  
    if not shader then
      print("Failed to load shader!")
      error("Shader loading failed")
    end
end

function love.keypressed(key)
  if key == 'escape' then
      love.event.quit()
  end
end

function love.update(dt)
  -- print(love.timer.getTime(dt))
 
end


function love.draw()
  -- Important: love.graphics.setShader(shader) should be called in love.draw
  love.graphics.setShader(shader)
  shader:send( "millis",love.timer.getTime(dt))

  -- Draw a fullscreen quad.
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
  love.graphics.setShader() --Unset the shader after drawing.
  love.graphics.draw(spritesheet4,0,0,0,10,10)
  -- love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,100)
  -- love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,100)

end
  