Button = Class{__includes = Graphics}

function Button:init(def)

    Graphics.init(self,def)
    -- GRAPHICS DEBUG
    if self.debug then 
        Graphics.metadataDebug(self,'BUTTON')
        Graphics.frameDebug(self,'BUTTON')
        Graphics.positionDebug(self,'BUTTON')
    end  
    -- BUTTON POSITIONS
    -- self.button_middle = middleXY(self.x,self.y,self.width,self.height)
    -- BUTTON SET UP 
    self.button_id = def.button_id
    self.button_number = def.button_number
    self.button_state = false
    self.button_selected = false
    self.callback = def['callback']

    if self.graphics_type == 'image' then
        self.display = def['display']
        self.image_unit = images_catalog[self.display.display][self.display.image].row*5
        self.display.image_dimensions = getImageDims(gFrames[self.display.display][self.image_unit])
        self.display.scale = scaleWH(self.points[6].x-self.points[5].x,self.points[7].y-self.points[5].y
            ,self.display.image_dimensions.width
            ,self.display.image_dimensions.height
        )
        Graphics.setImage(self,self.display.display,self.display.scale.sw,self.display.scale.sh,self.image_unit-4,self.image_unit)
    elseif self.graphics_type == 'text' then
        self.display = def['display']
        self.text_to_render = self.display.text
        Graphics.setText(self,self.text_to_render)
    end
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

function Button:changeImage(new_image)
    self.image = {}
    self.display = new_image
    self.image_unit = images_catalog[self.display.display][self.display.image].row*5
    self.display.image_dimensions = getImageDims(gFrames[self.display.display][self.image_unit])
    self.display.scale = scaleWH(self.points[6].x-self.points[5].x,self.points[7].y-self.points[5].y
        ,self.display.image_dimensions.width
        ,self.display.image_dimensions.height
    )
    Graphics.setImage(self,self.display.display,self.display.scale.sw,self.display.scale.sh,self.image_unit-4,self.image_unit)
end


-- function Button:changeText()

-- end


-- function Button:changeShape()

-- end



function Button:render()

    self:buttonCallback(self.callback)

    Graphics.renderBackground(self)    
    Graphics.renderForeground(self)
    Graphics.renderFrame(self)
    Graphics.renderPoints(self)

    -- love.graphics.reset()
    -- love.graphics.setColor(0,0,0)
    -- love.graphics.printf(tostring(self.button_number)
    -- ,self.x + self.offset.left
    -- ,self.y + self.offset.top,WINDOW_WIDTH)
    -- love.graphics.reset()

end

-- function Button:displayDebug()
--     print('\n','IMAGE DISPLAY DEBUG ----------')
--     print('DISPLAY X: ',self.points[5].x)
--     print('DISPLAY y: ',self.points[5].y)
--     print('DISPLAY IMAGE WIDTH: ',self.display.image_dimensions.width)
--     print('DISPLAY IMAGE HEIGHT: ',self.display.image_dimensions.height)
-- end


        -- print('DISPLAY: '..self.display.display)
    -- print('animal: '..self.display.image)
        -- print('ROW * 5: '..self.image_unit)
    -- print('VIEWPORT QUERY: '..select(1,gFrames[self.display.display][self.image_unit]:getViewport()))
        -- print('IMAGE SCALE: '..self.display.scale.sw)