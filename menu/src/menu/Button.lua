Button = Class{__includes = Graphics}

function Button:init(def)

    Graphics.init(self,def)
    -- BUTTON POSITIONS
   
    -- self.button_middle = middleXY(self.x,self.y,self.width,self.height)
    
    -- if self.debug then self:positionDebug() end
    
    -- BUTTON SET UP 
    self.button_id = def.button_id
    self.button_number = def.button_number
    -- self.panel_state = def.panel_state
    self.button_state = false
    self.button_selected = false
    self.callback = def['callback']

    self.display = def['display']
    self.display.image_dimensions = getImageDims(self.display.image)
    self.display.scale = scaleXY(self.points[6].x-self.points[5].x,self.points[7].y-self.points[5].y
        ,self.display.image_dimensions.width
        ,self.display.image_dimensions.height
    )

    -- if self.debug then self:displayDebug() end 

end


function Button:buttonCallback(callback)
    if self.button_state then
        if mouse_pressed then
            self.button_selected = true
            callback()
            mouse_pressed = nil
        end
    end
end

function Button:reset(dt)
    print('PANEL RESET')
    self.button_state = false
    self.button_selected = false
end

function Button:update(dt,panel_status)
    Graphics.update(self,dt)
    local mx, my = love.mouse.getPosition()
    if mouse_pressed then
        if mx > self.x and mx < self.x + self.width then
            if my > self.y and my < self.y + self.height then
                self.button_state = true
            else
                self.button_state = false
                self.button_selected = false
            end
        else
            self.button_state = false
            self.button_selected = false
        end
    end

end

-- function Button:changeImage()

-- end

-- function Button:setImage()

-- end

-- function Button:changeText()

-- end

-- function Button:setText()

-- end

-- function Button:changeShape()

-- end

-- function Button:setShape()

-- end

-- function Button:selection()

-- end

function Button:render()

    self:buttonCallback(self.callback)

    Graphics.renderBackground(self)

    -- if self.button_selected then
    --     love.graphics.setColor(1,0,0)
    --     love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    --     love.graphics.reset()  
    -- else
    --     love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
    --     love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    --     love.graphics.reset()    
    -- end
    
    Graphics.renderFrame(self)


    
    love.graphics.draw(
        self.display.atlas,self.display.image
        ,self.points[5].x
        ,self.points[5].y
        ,0
        ,self.display.scale.sw
        ,self.display.scale.sh
    )

    -- for i, point in ipairs(self.points) do
    --     love.graphics.setColor(0.2,0.5,0.4)
    --     love.graphics.circle('fill',point.x,point.y,10)
    --     love.graphics.reset()
    -- end

    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(tostring(self.button_number)
    ,self.x + self.offset.left
    ,self.y + self.offset.top,WINDOW_WIDTH)
    love.graphics.reset()

end