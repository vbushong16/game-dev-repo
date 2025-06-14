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




Graphics = Class{}

function Graphics:init(def)
    -- OBJECT PRESETS
    self.scale = {}
    self.position={}
    -- OBJECT DEBUG
    self.debug = def['metadata']['debug']
    self.menu_name = def['metadata']['name']
    
    print('in Graphics ', self.menu_name)

    -- OBJECT POSITION INIT 
    self.offset = def['position']['offsets']
    self.x = def['position']['x'] + 1*self.offset.left
    self.y = def['position']['y'] + 1*self.offset.top
    self.rotation = def.rotation or 0
    self.width = def['size']['width'] - self.offset.left - self.offset.right
    self.height = def['size']['height'] - self.offset.top - self.offset.bottom    

    -- if self.debug then self:menuDebug() end
    
    -- OBJECT GRAPHICS INIT
    self.render_type = def['graphics']['render_type']
    self.rgb = def['graphics']['rgb']
    self.atlas = def['graphics']['atlas']

    self.shape = def['graphics']['shape']
    self.frame = def['frame']
    self.edge_names = {'top','bottom','left','right'}

    -- local w,h = nil, nil
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
        self.position[edge] = frameRender(edge,self.width,self.height,self.scale[edge].sw,self.scale[edge].sh,frame_adjustment)
        -- if self.debug then self:frameDebug(edge) end
    end

    -- OBJECT POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)
    
    -- if self.debug then self:MenuPositionDebug() end


    -- self.graphics = {}
    -- self.graphics.shape = def.graphics_value['graphics']['shape']
    -- self.graphics.render_type = def.graphics_value['graphics']['render_type']
    -- self.graphics.rgb = def.graphics_value['graphics']['rgb']
    -- self.graphics.image = def.graphics_value['graphics']['image']
    -- self.position = def.graphics_value['anchor']['dimensions']
    -- self.anchor = def.graphics_value['anchor']

    -- MENU RENDERING DIMS
    -- self.scale = self:scaleXY()

    -- self:position_calc()

    -- if self.menu.render_type == 'frame' then 
    --     self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.top.sh 
    -- elseif self.menu.render_type == 'image' then
    --     self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.sh
    -- else
    --     self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.top.sh
    -- end

    -- graphic_anim = Animation{frames = {1, 2, 3},interval = 0.4}

    print('WIDTH: ',self.width)
    print('HEIGHT: ',self.height)
    print('CALC WIDTH: ',self.points[2].x-self.points[1].x)
    print('CALC HEIGHT: ',self.points[3].y-self.points[1].y)

    self.frame_canvas = love.graphics.newCanvas(self.width,self.height)
    self.background_canvas = love.graphics.newCanvas(self.width,self.height)
    self.fore_canvas = love.graphics.newCanvas(self.width,self.height)
end


-- function Graphics:positionGraphics(dimensions)

--     x= dimensions.x + self.frame_render.top.sw - self.scale.top.sw * 22
--     y= dimensions.y + self.frame_render.top.sh - self.scale.top.sh * 4  

--     love.graphics.draw(spritesheet3,self.graphics.image,x,y,self.rotation,self.frame_render.top.sw,self.frame_render.top.sh)
    
-- end


-- function Graphics:position_calc()

--     points = self.menu.points

--     -- print(points[5].x)

-- end


-- function Graphics:update(dt)
--     graphic_anim:update(dt)
-- end

-- for i, point in ipairs(self.points) do
--     love.graphics.setColor(1,1,0)
--     love.graphics.circle('fill',point.x,point.y,10)
--     love.graphics.reset()
-- end

function Graphics:update(dt)
    self.frame_canvas:renderTo(function()
        love.graphics.clear()
        -- love.graphics.setShader(shader01)
        -- shader01:send('time',love.timer.getTime(dt))
        for i,edge in pairs(self.edge_names) do
            love.graphics.draw(self.atlas,self.frame[edge].image,self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
        end
        -- love.graphics.setShader()
    end
    )

    self.background_canvas:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader)
        love.graphics.rectangle('fill',5,5,self.width,self.height)
        love.graphics.setShader()
    end
    )


end

function Graphics:renderBackground()
    love.graphics.draw(self.background_canvas,self.x,self.y)
end


function Graphics:renderFrame()
    love.graphics.draw(self.frame_canvas,self.x,self.y)
end

-- function Graphics:render()

--     love.graphics.draw(
--         spritesheet3,self.graphics.image[graphic_anim:getFrame()]
--         ,self.menu.points[1].x
--         ,self.y
--         ,0
--         ,self.scale.top.sw
--         ,self.scale.top.sh
--     )
    
--     -- self.menu:render()

-- end


-- function Menu:menuDebug()
--     print('\n','MENU DEBUG ----------------------------------------------------')
--     print('MENU NAME: ',self.menu_name)
--     print('MENU X: ',self.x)
--     print('MENU Y: ',self.x)
--     print('MENU WIDTH: ', self.width)
--     print('MENU HEIGHT: ', self.height)
-- end

-- function Menu:frameDebug(edge)
--     print('\n','FRAME DEBUG: ',edge, ' -------------')
--     print('FRAME IMAGE x: ',self.frame[edge].image_dimensions.x)
--     print('FRAME IMAGE y: ',self.frame[edge].image_dimensions.y)
--     print('FRAME IMAGE width: ',self.frame[edge].image_dimensions.width)
--     print('FRAME IMAGE height: ',self.frame[edge].image_dimensions.height)
--     print('INPUT INTO SCALEXY')
--     print('FOR EDGE: ',edge,' WIDTH IS: ',w)
--     print('FOR EDGE: ',edge,' HEIGHT IS: ',h)
--     print('FRAME IMAGE SW: ',self.scale[edge].sw)
--     print('FRAME IMAGE SH: ',self.scale[edge].sh)
-- end

-- function Menu:MenuPositionDebug()
--     print('\n','MENU POSITIONS:')
--     print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
--     print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
--     print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
--     print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
--     print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
--     print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
--     print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
--     print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y) 
-- end

-- function Panel:panelDebug()
--     print('\n','PANEL DEBUG ----------------------------------------------------')
--     print('MENU NAME: ',self.menu_name)
--     print('LAYOUT ROWS: ',self.layout.rows)
--     print('LAYOUT COLS: ',self.layout.cols)
--     print('PANEL X: ', self.x)
--     print('PANEL y: ', self.y)
--     print('PANEL WIDTH: ', self.width)
--     print('PANEL HEIGHT: ', self.height)
--     print('PANEL OFFSET X: ', self.offset.offset_x)
--     print('PANEL OFFSET Y: ', self.offset.offset_y)
-- end

-- function Panel:frameDebug(edge)
--     print('\n','FRAME DEBUG: ',edge, ' -------------')
--     print('FRAME IMAGE x: ',self.frame[edge].image_dimensions.x)
--     print('FRAME IMAGE y: ',self.frame[edge].image_dimensions.y)
--     print('FRAME IMAGE width: ',self.frame[edge].image_dimensions.width)
--     print('FRAME IMAGE height: ',self.frame[edge].image_dimensions.height)
--     print('INPUT INTO SCALEXY')
--     print('FOR FRAME: ',edge,' WIDTH IS: ',w)
--     print('FOR FRAME: ',edge,' HEIGHT IS: ',h)
--     print('FRAME IMAGE SW: ',self.scale[edge].sw)
--     print('FRAME IMAGE SH: ',self.scale[edge].sh)
-- end

-- function Panel:PositionDebug()
--     print('\n','PANEL POSITIONS:')
--     print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
--     print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
--     print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
--     print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
--     print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
--     print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
--     print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
--     print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y)
-- end

-- function Panel:buttonPosition(k,layout,button)
--     print('NEW LOOP ',k,' --------------------------------------------')
--     print('PANEL HEIGHT: '..self.panel_height)
--     print('PANEL WIDTH: '..self.panel_width)
--     print('LAYOUT NONPRIORITY: '..layout.non_priority.p)
--     print('LAYOUT PRIORITY: '..layout.priority.p)
--     print('LAYOUT NONPRIORITY DIM: '..layout.non_priority.dim)
--     print('LAYOUT PRIORITY DIM: '..layout.priority.dim)
--     print('BUTTON '..k..' OFFSET X: '..button.components.position.offsets.left)
--     print('BUTTON '..k..' OFFSET Y: '..button.components.position.offsets.top)
--     print('BUTTON: '..k,'X: '..button.position.x)
--     print('BUTTON: '..k,'y: '..button.position.y)
--     print('BUTTON: '..k,'W: '..button.size.width)
--     print('BUTTON: '..k,'H: '..button.size.height)
-- end

-- function Button:buttonDebug()
--     print('\n','BUTTON DEBUG ----------------------------------------------------')
--     print('MENU NAME: ',self.menu_name)
--     print('BUTTON X: ', self.x)
--     print('BUTTON y: ', self.y)
--     print('BUTTON WIDTH: ', self.width)
--     print('BUTTON HEIGHT: ', self.height)
--     print('BUTTON OFFSET top: ', self.offset.top)
--     print('BUTTON OFFSET bottom: ', self.offset.bottom)
--     print('BUTTON OFFSET left: ', self.offset.left)
--     print('BUTTON OFFSET right: ', self.offset.right)
-- end

-- function Button:frameDebug(edge)
--     print('\n','FRAME VALUE: ',edge, ' -------------')
--     print('FRAME IMAGE x: ',self.frame[edge].image_dimensions.x)
--     print('FRAME IMAGE y: ',self.frame[edge].image_dimensions.y)
--     print('FRAME IMAGE width: ',self.frame[edge].image_dimensions.width)
--     print('FRAME IMAGE height: ',self.frame[edge].image_dimensions.height)
--     print('INPUT INTO SCALEXY')
--     print('FOR FRAME: ',edge,' WIDTH IS: ',w)
--     print('FOR FRAME: ',edge,' HEIGHT IS: ',h)
--     print('FRAME IMAGE SW: ',self.scale[edge].sw)
--     print('FRAME IMAGE SH: ',self.scale[edge].sh)
-- end

-- function Button:positionDebug()
--     print('\n','BUTTON POSITIONS:')
--     print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
--     print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
--     print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
--     print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
--     print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
--     print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
--     print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
--     print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y)
-- end

-- function Button:displayDebug()
--     print('\n','IMAGE DISPLAY DEBUG ----------')
--     print('DISPLAY X: ',self.points[5].x)
--     print('DISPLAY y: ',self.points[5].y)
--     print('DISPLAY IMAGE WIDTH: ',self.display.image_dimensions.width)
--     print('DISPLAY IMAGE HEIGHT: ',self.display.image_dimensions.height)
-- end