

Menu = Class{}




function Menu:init()
    self.x = 10
    self.y = 10
    self.width = 600
    self.height = 50
end

function Menu:render()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    love.graphics.reset()
    for i = 0,self.width/50,1 do        
        x = self.x + i * self.width/10
        if printx >= x + 5 and printx <= x + 55 then
            if printy >= self.y + 5 and printy <= 40 then
                love.graphics.setColor(0,1,1,0.5)
                love.graphics.rectangle('fill',x+5,self.y+5,50,self.height-10)
                love.graphics.reset()
            end
        else   
            love.graphics.setColor(1,1,1) 
            love.graphics.rectangle('fill',x+5,self.y+5,50,self.height-10)
            love.graphics.reset()
        end
    end

    for i,panel in pairs(panel_items) do
        love.graphics.draw(spritesheet,gFrames[panel['image']][1],panel['x'],panel['y'])
    end
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
end


