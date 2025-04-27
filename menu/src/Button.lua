
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

    -- BUTTON PRESETS
    self.scale = {}
    self.position={}
    -- BUTTON DEBUG
    self.debug = def['components']['debug']
    self.menu_name = def['menu_name']

    -- BUTTON POSITION INIT
    self.offset = def['components']['position']['offsets']
    self.x = def['position']['x'] + 1*self.offset.offset_x
    self.y = def['position']['y'] + 1*self.offset.offset_y
    self.rotation = def.rotation or 0
    self.width = def['size']['width'] - 1*self.offset.offset_x
    self.height = def['size']['height'] - 1*self.offset.offset_y

    if self.debug then self:buttonDebug() end

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
    
        if self.debug then self:frameDebug(edge) end    
    end
 
    -- BUTTON POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)
    -- self.button_middle = middleXY(self.x,self.y,self.width,self.height)
    
    if self.debug then self:positionDebug() end
    
    -- BUTTON SET UP 
    self.button_id = def.button_id
    self.button_number = def.button_number
    -- self.panel_state = def.panel_state
    self.button_state = false
    self.button_selected = false
    self.callback = def['components']['callback']

    self.display = def['components']['display']
    self.display.image_dimensions = getImageDims(self.display.image)
    self.display.scale = scaleXY(self.points[6].x-self.points[5].x,self.points[7].y-self.points[5].y
        ,self.display.image_dimensions.width
        ,self.display.image_dimensions.height
    )

    if self.debug then self:displayDebug() end 

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

function Button:buttonDebug()
    print('\n','BUTTON DEBUG ----------------------------------------------------')
    print('MENU NAME: ',self.menu_name)
    print('BUTTON X: ', self.x)
    print('BUTTON y: ', self.y)
    print('BUTTON WIDTH: ', self.width)
    print('BUTTON HEIGHT: ', self.height)
    print('BUTTON OFFSET X: ', self.offset.offset_x)
    print('BUTTON OFFSET Y: ', self.offset.offset_y)
end

function Button:frameDebug(edge)
    print('\n','FRAME VALUE: ',edge, ' -------------')
    print('FRAME IMAGE x: ',self.frame[edge].image_dimensions.x)
    print('FRAME IMAGE y: ',self.frame[edge].image_dimensions.y)
    print('FRAME IMAGE width: ',self.frame[edge].image_dimensions.width)
    print('FRAME IMAGE height: ',self.frame[edge].image_dimensions.height)
    print('INPUT INTO SCALEXY')
    print('FOR FRAME: ',edge,' WIDTH IS: ',w)
    print('FOR FRAME: ',edge,' HEIGHT IS: ',h)
    print('FRAME IMAGE SW: ',self.scale[edge].sw)
    print('FRAME IMAGE SH: ',self.scale[edge].sh)
end

function Button:positionDebug()
    print('\n','BUTTON POSITIONS:')
    print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
    print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
    print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
    print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
    print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
    print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
    print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
    print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y)
end

function Button:displayDebug()
    print('\n','IMAGE DISPLAY DEBUG ----------')
    print('DISPLAY X: ',self.points[5].x)
    print('DISPLAY y: ',self.points[5].y)
    print('DISPLAY IMAGE WIDTH: ',self.display.image_dimensions.width)
    print('DISPLAY IMAGE HEIGHT: ',self.display.image_dimensions.height)
end