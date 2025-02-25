


Button = Class{}

function Button:init(def)

    self.theme = 0
    self.shape = 0
    self.width = def.width
    self.height = def.height
    self.radius = 0
    self.x = def.x
    self.y = def.y
    self.rotation = 0 
    self.scale_x = 0
    self.scale_y = 0
    self.offset_x = 5
    self.offset_y = 5

    self.button_id = 0
    self.button_number = def.button_number 

    self.button_state = false
    self.callback = pressed_button

end

function Button:buttonCallback(callback)
    if self.button_state then
        if mouse_pressed then
            callback()
        end
    end
end


function Button:update(dt)
    local mx, my = love.mouse.getPosition()
    if mx > self.x and mx < self.x + self.width then
        if my > self.y and my < self.y + self.height then
            if mouse_pressed then
                self.button_state = true
            -- currentlyFocused = self
            -- print("a ui button is hot")
            end
        else
            self.button_state = false
        end
    else
        self.button_state = false
    end
end

function Button:changeImage()

end

function Button:changeText()

end

function Button:changeShape()

end

function Button:selection()

end

function Button:render()

    self:buttonCallback(self.callback)

    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(tostring(self.button_number),self.x,self.y,self.width)
    love.graphics.reset()

end