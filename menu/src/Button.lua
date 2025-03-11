


Button = Class{}

function Button:init(def)

    self.theme = def.theme or 0
    self.shape = def.theme or 0
    self.width = def.width or 90
    self.height = def.height or 90
    self.radius = def.theme or 0
    self.x = def.x or 5
    self.y = def.y or 5
    self.rotation = def.rotation or 0
    self.scale_x = def.scale_x or 0
    self.scale_y = def.scale_y or 0
    self.offset_x = def.offset_x or 0
    self.offset_y = def.offset_y or 0

    self.button_id = 0
    self.button_number = def.button_number 

    self.button_state = false
    self.callback = pressed_button
    self.button_selected = false

end

function Button:buttonCallback(callback)
    if self.button_state then
        if mouse_pressed then
            callback()
            self.button_selected = true
        end
    end
end

function Button:update(dt)
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

    if self.button_selected then
        love.graphics.setColor(1,0,0)
    else
        love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle('fill',self.x,self.y,self.width*self.scale_x,self.height*self.scale_y)
    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(tostring(self.button_number),self.x,self.y,self.width*self.scale_x)
    love.graphics.reset()

end