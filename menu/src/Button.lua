
-- button_init = {
--     position = {
--         x = nil
--         ,y = nil
--     }
--     ,size = {width = button_width,height = button_height}
--     ,components = {
--         ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
--         ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
--         ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--         ['callback'] = pressed_button,
--         ['display'] = 'test'
--     }
--     ,button_id = nil
--     ,button_number = nil
-- }

Button = Class{}

function Button:init(def)

    -- BUTTON GRAPHICS INIT
    self.render_type = def['components']['graphics']['render_type']
    self.rgb = def['components']['graphics']['rgb']
    self.image = def['components']['graphics']['image']
    self.shape = def['components']['graphics']['shape']
    self.frame = {}
    self.frame.images = def['components']['frame']['image']
    self.frame.dimensions = def['components']['frame']['dimensions']
    self.frame.rgb = def['components']['frame']['rgb']

    -- BUTTON POSITION INIT
    self.x = def['position']['x']
    self.y = def['position']['y']
    self.rotation = def.rotation or 0
    self.offset = def['components']['position']['offsets']

   -- BUTTON SIZE INIT
    if self.shape == 'rectangle' then
        self.width = def['size']['width']
        self.height = def['size']['height']
    elseif self.shape == 'circle' then
        self.radius = def['size']['radius']
    end 

    -- BUTTON RENDERING DIMS
    -- self.scale = def['scale']
    self.scale = self:scaleXY()
    self.frame_render = self:frameRender()
    self.frame_width = self.frame.dimensions.width * self.scale.sw
    self.frame_height = self.frame.dimensions.height * self.scale.sh

    -- BUTTON SET UP
    self.button_id = def.button_id 
    self.button_number = def.button_number 

    self.button_state = false
    self.button_selected = false
    self.callback = def['components']['callback']
    self.display = def['components']['display']

    print(self.callback)
end

function Button:frameRender()

    local frame_table = {}
    frame_table.top = {
        x = self.x + self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.top.sw
        ,sh = self.scale.top.sh
    }
    frame_table.bottom = {
        x = self.x + self.offset.offset_x
        ,y =self.y+self.height-self.frame.dimensions.height - self.offset.offset_y
        ,sw = self.scale.bottom.sw
        ,sh = self.scale.bottom.sh
    }
    frame_table.left = {
        x = self.x + self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.left.sw
        ,sh = self.scale.left.sh
    }
    frame_table.right = {
        x = self.x + self.width - self.frame.dimensions.width - self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.right.sw
        ,sh = self.scale.right.sh
    }
    return frame_table
end

function Button:scaleXY()
    local scale_table = {}
    if self.render_type == 'image' then
        local sw,sh = select(3,self.image:getViewport()),select(4,self.image:getViewport())
        scale_table.sw,scale_table.sh = (self.width-2*self.offset.offset_x)/sw,(self.height-2*self.offset.offset_y)/sh
        scale_table.top = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.bottom = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.left = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.right = {sw = scale_table.sw,sh = scale_table.sh}
    elseif self.render_type == 'frame' then
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = (self.width-2*self.offset.offset_x)/select(3,self.frame.images['top']:getViewport()), sh = self.frame.dimensions.height/select(4,self.frame.images['top']:getViewport())}
        scale_table.bottom = {sw = (self.width-2*self.offset.offset_x)/select(3,self.frame.images['bottom']:getViewport()),sh = self.frame.dimensions.height/select(4,self.frame.images['bottom']:getViewport())}
        scale_table.left = {sw = self.frame.dimensions.width/select(3,self.frame.images['left']:getViewport()),sh = (self.height-2*self.offset.offset_y)/select(4,self.frame.images['left']:getViewport())}
        scale_table.right = {sw = self.frame.dimensions.width/select(3,self.frame.images['right']:getViewport()),sh = (self.height-2*self.offset.offset_y)/select(4,self.frame.images['right']:getViewport())} 
        -- print('THIS IS THE EDGE SCALE TOP: ', scale_table.top.sw ,' & ', scale_table.top.sh)
        -- print('THIS IS THE EDGE SCALE BOT: ', scale_table.bottom.sw ,' & ', scale_table.bottom.sh)
        -- print('THIS IS THE EDGE SCALE LEFT: ', scale_table.left.sw ,' & ', scale_table.left.sh)
        -- print('THIS IS THE EDGE SCALE RIGHT: ', scale_table.right.sw ,' & ', scale_table.right.sh)
    else
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.width-2*self.offset.offset_x, sh = self.frame.dimensions.height}
        scale_table.bottom = {sw = self.width-2*self.offset.offset_x, sh = self.frame.dimensions.height}
        scale_table.left = {sw = self.frame.dimensions.width, sh = self.height-2*self.offset.offset_y}
        scale_table.right = {sw = self.frame.dimensions.width, sh = self.height-2*self.offset.offset_y}

    end
    return scale_table
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
                -- print('BUTTON: ',self.button_number,' IS PRESSED')
                -- print(self.button_state)
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
    
    if self.render_type == 'image' then
        love.graphics.draw(spritesheet,self.image,self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.rotation,self.scale.sw,self.scale.sh)
        -- love.graphics.setFilter("nearest", "nearest")
    elseif self.render_type == 'frame' then
        love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        love.graphics.rectangle('fill',self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.width-2*self.offset.offset_x,self.height-2*self.offset.offset_y)
        love.graphics.reset()
        -- print('PANEL TOP FRAME: ',self.frame_render.top.sw)
        love.graphics.draw(spritesheet,self.frame.images['top'],self.frame_render.top.x,self.frame_render.top.y,self.rotation,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
        love.graphics.draw(spritesheet,self.frame.images['bottom'],self.frame_render.bottom.x,self.frame_render.bottom.y,self.rotation,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
        love.graphics.draw(spritesheet,self.frame.images['left'],self.frame_render.left.x,self.frame_render.left.y,self.rotation,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
        love.graphics.draw(spritesheet,self.frame.images['right'],self.frame_render.right.x,self.frame_render.right.y,self.rotation,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
    elseif self.render_type == 'rgb' then
        love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        love.graphics.rectangle('fill',self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.width-2*self.offset.offset_x,self.height-2*self.offset.offset_y)
        love.graphics.reset()
        love.graphics.setColor(self.frame.rgb.r,self.frame.rgb.g,self.frame.rgb.b)
        love.graphics.rectangle('fill',self.frame_render.top.x,self.frame_render.top.y,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
        love.graphics.rectangle('fill',self.frame_render.bottom.x,self.frame_render.bottom.y,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
        love.graphics.rectangle('fill',self.frame_render.left.x,self.frame_render.left.y,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
        love.graphics.rectangle('fill',self.frame_render.right.x,self.frame_render.right.y,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
        love.graphics.reset()
    end
    
    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(tostring(self.button_number)
    ,self.x + self.offset.offset_x
    ,self.y + self.offset.offset_y,WINDOW_WIDTH)
    love.graphics.reset()

end



    