
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

    print('BUTTON DEBUG ---------------')
    -- BUTTON PRESETS
    self.scale = {}
    self.position={}

    -- BUTTON POSITION INIT
    self.offset = def['components']['position']['offsets']
    self.x = def['position']['x'] + 1*self.offset.offset_x
    self.y = def['position']['y'] + 1*self.offset.offset_y
    self.rotation = def.rotation or 0

    -- BUTTON SIZE INIT
    self.width = def['size']['width'] - 1*self.offset.offset_x
    self.height = def['size']['height'] - 1*self.offset.offset_y

    -- print('BUTTON WIDTH: ', self.width)
    -- print('BUTTON HEIGHT: ', self.height)

    -- BUTTON GRAPHICS INIT
    self.render_type = def['components']['graphics']['render_type']
    self.rgb = def['components']['graphics']['rgb']
    self.atlas = def['components']['graphics']['atlas']

    self.shape = def['components']['graphics']['shape']
    self.frame = def['components']['frame']
    self.edge_names = {'top','bottom','left','right'}

    local w,h = nil, nil 
    for i,edge in pairs(self.edge_names) do
        self.frame[edge].image_dimensions = getImageDims(self.frame[edge].image)
        -- print('EDGE VALUE: ',edge, ' -------------')
        -- print('FRAME IMAGE x: ',self.frame[edge].image_dimensions.x)
        -- print('FRAME IMAGE y: ',self.frame[edge].image_dimensions.y)
        -- print('FRAME IMAGE width: ',self.frame[edge].image_dimensions.width)
        -- print('FRAME IMAGE height: ',self.frame[edge].image_dimensions.height)

        local w,h = nil,nil
        if edge == 'top' then
            w,h = self.width,self.frame[edge].dimensions.height
        elseif edge == 'bottom' then
            w,h = self.width,self.frame[edge].dimensions.height
        elseif edge == 'left' then
            w,h = self.frame[edge].dimensions.width,self.height
        elseif edge == 'right' then
            w,h = self.frame[edge].dimensions.width,self.height
        end
        -- print('INPUT INTO SCALEXY')
        -- print('FOR EDGE: ',edge,' WIDTH IS: ',w)
        -- print('FOR EDGE: ',edge,' HEIGHT IS: ',h)
        self.scale[edge] = scaleXY(
            w
            ,h
            ,self.frame[edge].image_dimensions.width
            ,self.frame[edge].image_dimensions.height
        )

        local frame_adjustment = nil
        if edge == 'bottom' then
            frame_adjustment = self.frame[edge].dimensions.height
        elseif edge == 'right' then
            frame_adjustment = self.frame[edge].dimensions.width
        else
            frame_adjustment = nil
        end
        self.position[edge] = frameRender(edge,self.x,self.y,self.width,self.height,self.scale[edge].sw,self.scale[edge].sh,frame_adjustment)
        -- print('BUTTON X: ', self.position[edge].x)
        -- print('BUTTON offset_X: ', self.offset.offset_x)

    end
 
    -- print('BUTTON X: ', self.position.top.x)
    -- print('BUTTON y: ', self.position.top.y)
    -- print('BUTTON scale X: ', self.position.top.sw)
    -- print('BUTTON scale y: ', self.position.top.sh)

    -- BUTTON POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)

    -- print('BUTTON LENGTH: ',self.points[6].x-self.points[5].x)
    -- self.button_middle = middleXY(self.x,self.y,self.width,self.height)
    -- print('BUTTON XY COORD: ',self.button_middle.x,' ',self.button_middle.y)

    -- BUTTON SET UP 
    self.button_id = def.button_id
    self.button_number = def.button_number
    self.button_state = false
    self.button_selected = false
    self.callback = def['components']['callback']

    self.display = def['components']['display']
    self.display.image_dimensions = getImageDims(self.display.image)

    -- print('DISPLAY IMAGE WIDTH: ',self.display.image_dimensions.width)
    -- print('DISPLAY IMAGE HEIGHT: ',self.display.image_dimensions.height)

    self.display.scale = scaleXY(self.points[6].x-self.points[5].x,self.points[7].y-self.points[5].y
        ,self.display.image_dimensions.width
        ,self.display.image_dimensions.height
    )

    -- print('DISPLAY X: ',self.points[5].x)
    -- print('DISPLAY y: ',self.points[5].y)

end

function getImageDims(value)
    local image_dimensions = {
        x = select(1,value:getViewport())
        ,y = select(2,value:getViewport())
        ,width = select(3,value:getViewport())
        ,height = select(4,value:getViewport())
    }
    return image_dimensions
end

function frameRender(edge,x,y,width,height,scale_width,scale_height,frame_adjustment)

    local frame_table = {}

    if edge == 'top' then
        frame_table = {
            x = x
            ,y = y
            ,sw = scale_width
            ,sh = scale_height
        }
    elseif edge == 'bottom' then
        frame_table = {
            x = x
            ,y =y+height-frame_adjustment
            ,sw = scale_width
            ,sh = scale_height
        }
    elseif edge == 'left' then
        frame_table = {
            x = x
            ,y = y
            ,sw = scale_width
            ,sh = scale_height
        }
    elseif edge == 'right' then
        frame_table = {
            x = x + width - frame_adjustment
            ,y = y
            ,sw = scale_width
            ,sh = scale_height
        }
    end
    return frame_table
end

function objectCoord(x,y,width,height,frame_offsets)

    points = {
            {x = x, y = y}
            ,{x = x + width, y = y}
            ,{x = x, y = y + height}
            ,{x = x + width, y = y + height}
            ,{x = x + frame_offsets.left, y = y+frame_offsets.top}
            ,{x = x + width - frame_offsets.right, y = y+frame_offsets.top}
            ,{x = x + frame_offsets.left, y = y+height - frame_offsets.bottom}
            ,{x = x + width - frame_offsets.right, y = y+height - frame_offsets.bottom}
        }

    -- for i, point in ipairs(points) do
    --     print('P',i,' COORDINATES: ', point.x,', ', point.y)
    -- end

    return points
end

function scaleXY(width,height,graphics_width,graphics_height)
    local scale_table = {sw = width/graphics_width, sh = height/graphics_height}
       -- print('THIS IS THE EDGE SCALE: ', scale_table.sw ,' & ', scale_table.sh)
   return scale_table
end

function middleXY(x,y,width,height)
    local middle_coord = {
        x = x+width/2
        ,y = y+height/2
    }
    return middle_coord
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
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        love.graphics.reset()  
    else
        love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        love.graphics.reset()    
    end
    
    for i,edge in pairs(self.edge_names) do
        love.graphics.draw(self.atlas,self.frame[edge].image,self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
    end
    

    
    love.graphics.draw(
        self.display.atlas,self.display.image
        -- ,self.button_middle.x
        -- ,self.button_middle.y
        ,self.points[5].x
        ,self.points[5].y
        ,0
        ,math.min(self.display.scale.sw,self.display.scale.sh)
        ,math.min(self.display.scale.sw,self.display.scale.sh)
    )

    for i, point in ipairs(self.points) do
        love.graphics.setColor(0.2,0.5,0.4)
        love.graphics.circle('fill',point.x,point.y,10)
        love.graphics.reset()
    end

    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(tostring(self.button_number)
    ,self.x + self.offset.offset_x
    ,self.y + self.offset.offset_y,WINDOW_WIDTH)
    love.graphics.reset()

end



    