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

    -- self.frame_canvas = love.graphics.newCanvas(self.width,self.height)
    -- self.background_canvas = love.graphics.newCanvas(self.width,self.height)
    -- self.foreground_canvas = love.graphics.newCanvas(self.width,self.height)

    
    -- OBJECT PRESETS
    self.scale = {}
    self.position={}
    -- OBJECT DEBUG
    self.debug = def['metadata']['debug']
    self.menu_name = def['metadata']['name']
    -- OBJECT POSITION INIT 
    self.offset = def['position']['offsets']
    self.x = def['position']['x'] + 1*self.offset.left
    self.y = def['position']['y'] + 1*self.offset.top
    self.rotation = def.rotation or 0
    self.width = def['size']['width'] - self.offset.left - self.offset.right
    self.height = def['size']['height'] - self.offset.top - self.offset.bottom    

    -- if self.debug then self:menuDebug() end
    
    -- OBJECT GRAPHICS INIT
    self.canvas_frame = def['graphics']['frame']
    self.background = def['graphics']['background']
    self.foreground = def['graphics']['foreground']
    self.display = def['graphics']['display']
    self.stickers = def['graphics']['stickers']

    -- FRAME RENDERING INIT
    self.frame = def['frame']
    self.edge_names = {'bottom','left','top','right'}
    -- local w,h = nil, nil
    for i,edge in pairs(self.edge_names) do
        -- self.frame[edge].image_dimensions = getImageDims(gFrames[self.canvas_frame][edge])
        self.frame[edge].image_dimensions = getFrameTranslation(self.canvas_frame,edge,images_catalog)

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

        self.scale[edge] = scaleWH(
            w
            ,h
            ,self.frame[edge].image_dimensions.width
            ,self.frame[edge].image_dimensions.height
        )

        local frame_adjustment = nil
        if edge == 'bottom' then
            frame_adjustment = (self.frame[edge].image_dimensions.height *self.height/32) - (self.frame[edge].image_dimensions.height *self.scale[edge].sh) 
        elseif edge == 'top' then
            frame_adjustment = (self.frame[edge].image_dimensions.height *self.height/32) - (self.frame[edge].image_dimensions.height *self.scale[edge].sh)
        elseif edge == 'left' then
            frame_adjustment = (self.frame[edge].image_dimensions.width *self.width/32) - (self.frame[edge].image_dimensions.width *self.scale[edge].sw)
        elseif edge == 'right' then
            frame_adjustment = (self.frame[edge].image_dimensions.width *self.width/32) - (self.frame[edge].image_dimensions.width *self.scale[edge].sw)
        else
            frame_adjustment = nil
        end

        local coord_adjustment = nil
        if edge == 'bottom' then
            coord_adjustment = (self.frame[edge].image_dimensions.y *self.height/32) - (self.frame[edge].image_dimensions.y *self.scale[edge].sh)
        elseif edge == 'top' then
            coord_adjustment = (self.frame[edge].image_dimensions.y *self.height/32) - (self.frame[edge].image_dimensions.y *self.scale[edge].sh)
        elseif edge == 'left' then
            coord_adjustment = (self.frame[edge].image_dimensions.x *self.width/32) - (self.frame[edge].image_dimensions.x *self.scale[edge].sw)
        elseif edge == 'right' then
            coord_adjustment = (self.frame[edge].image_dimensions.x *self.width/32) - (self.frame[edge].image_dimensions.x *self.scale[edge].sw)
        end


        self.position[edge] = frameRender(edge,self.scale[edge].sw,self.scale[edge].sh,frame_adjustment,coord_adjustment)
        -- if self.debug then self:frameDebug(edge) end

        -- if self.frame[edge].dimensions.width == nil then
        --     frame_width = self.width
        -- else
        --     frame_width = self.frame[edge].dimensions.width
        -- end
        -- if self.frame[edge].dimensions.height == nil then
        --     frame_height = self.height
        -- else 
        --     frame_height = self.frame[edge].dimensions.height
        -- end

        -- print('APPLIED ADJUSTMENTS ================================')
        -- print('FOR EDGE '..edge,'FRAME ADJUSTMENT: '..frame_adjustment)
        -- print('FOR EDGE '..edge,'COORD ADJUSTMENT: '..coord_adjustment)
        -- print('ACTUAL VALUES ========================================')

        -- print('FOR EDGE '..edge,'POSITION image width: '..image_quad)
        -- print('FOR EDGE '..edge,'POSITION image height: '..image_quad)
        -- print('FOR EDGE '..edge,'POSITION drawing width: '..self.frame[edge].image_dimensions.width)
        -- print('FOR EDGE '..edge,'POSITION drawing height: '..self.frame[edge].image_dimensions.height)
        -- print('FOR EDGE '..edge,'POSITION image X: '..self.frame[edge].image_dimensions.x)
        -- print('FOR EDGE '..edge,'POSITION image Y: '..self.frame[edge].image_dimensions.y)
        -- print('FOR EDGE '..edge,'POSITION canvas WIDTH: '..self.width)
        -- print('FOR EDGE '..edge,'POSITION canvas HEIGHT: '..self.height)

        -- print('FOR EDGE '..edge,'POSITION frame width: '..frame_width)
        -- print('FOR EDGE '..edge,'POSITION frame height: '..frame_height)
        -- print('FOR EDGE '..edge,'POSITION SCALE R WIDTH: '..self.width/image_quad)
        -- print('FOR EDGE '..edge,'POSITION SCALE R HEIGHT: '..self.height/image_quad)
        -- print('FOR EDGE '..edge,'POSITION SCALE D WIDTH: '..self.scale[edge].sw)
        -- print('FOR EDGE '..edge,'POSITION SCALE D HEIGHT: '..self.scale[edge].sh)
        -- print('FOR EDGE '..edge,'POSITION X R: '..self.frame[edge].image_dimensions.x * self.width/image_quad)
        -- print('FOR EDGE '..edge,'POSITION Y R: '..self.frame[edge].image_dimensions.y * self.height/image_quad)
        -- print('FOR EDGE '..edge,'POSITION X D: '..self.frame[edge].image_dimensions.x * self.scale[edge].sw)
        -- print('FOR EDGE '..edge,'POSITION Y D: '..self.frame[edge].image_dimensions.y * self.scale[edge].sh)
        -- print('FOR EDGE '..edge,'FRAME ADJ W R: '..self.frame[edge].image_dimensions.width * self.width/image_quad)
        -- print('FOR EDGE '..edge,'FRAME ADJ H R: '..self.frame[edge].image_dimensions.height * self.height/image_quad)
        -- print('FOR EDGE '..edge,'FRAME ADJ W D: '..self.frame[edge].image_dimensions.width * self.scale[edge].sw)
        -- print('FOR EDGE '..edge,'FRAME ADJ H D: '..self.frame[edge].image_dimensions.height * self.scale[edge].sh)


        -- x_adj = (self.frame[edge].image_dimensions.x * self.width/image_quad) - (self.frame[edge].image_dimensions.x * self.scale[edge].sw)
        -- y_adj = (self.frame[edge].image_dimensions.y * self.height/image_quad) - (self.frame[edge].image_dimensions.y * self.scale[edge].sh)
        -- frame_w_adj = (self.frame[edge].image_dimensions.width * self.width/image_quad) - (self.frame[edge].image_dimensions.width * self.scale[edge].sw)
        -- frame_h_adj = (self.frame[edge].image_dimensions.height * self.height/image_quad) - (self.frame[edge].image_dimensions.height * self.scale[edge].sh)

        -- print('FOR EDGE '..edge,'POSITION X ADJ: '..x_adj + frame_w_adj)
        -- print('FOR EDGE '..edge,'POSITION Y ADJ: '..y_adj + frame_h_adj)

        -- print('FRAME RENDER VALUES ========================================')

        -- print('X RENDER VALUE: '..self.position[edge].x)
        -- print('Y RENDER VALUE: '..self.position[edge].y)
        -- print('SW RENDER VALUE: '..self.position[edge].sw)
        -- print('SH RENDER VALUE: '..self.position[edge].sh)

    -- end
    end

    self.x_point = self.x + self.frame['left'].image_dimensions.x * self.width/32
    self.y_point = self.y
    self.width_point = (self.frame['right'].image_dimensions.x  - self.frame['left'].image_dimensions.x + 2) * self.width/32
    self.height_point = (self.frame['bottom'].image_dimensions.y  - self.frame['top'].image_dimensions.y + 2) * self.height/32


    -- -- OBJECT POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
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
    self.points = objectCoord(self.x_point,self.y_point,self.width_point,self.height_point,frame_offsets)

    self.frame_canvas = love.graphics.newCanvas(self.width,self.height)
    self.background_canvas = love.graphics.newCanvas(self.width,self.height)
    self.foreground_canvas = love.graphics.newCanvas(self.width,self.height)

    self.image = {}
end


function Graphics:setImage(display,sw,sh,first_sprite,last_sprit)
    for i = first_sprite,last_sprit,1 do
        table.insert(self.image,{
            quad = gFrames[display][i]
            ,x = 0
            ,y = 0
            ,r = 0 * 3.14/180
            ,sx = sw
            ,sy = sh
            ,ox = 0
            ,oy = 0
        })
    end
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
            love.graphics.draw(gTextures[self.canvas_frame],gFrames[self.canvas_frame][i],self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
        end
        -- love.graphics.setShader()
    end
    )

    self.background_canvas:renderTo(function()
        love.graphics.clear()
        love.graphics.setShader(shader)
        shader:send('time',love.timer.getTime(dt))
        love.graphics.rectangle('fill',0,0,self.width,self.height)
        love.graphics.setShader()
    end
    )

    self.foreground_canvas:renderTo(function()
        renderImagePrep(spriteBatch,self.image,1,5)
        -- love.graphics.clear()
        -- swordBatch:clear()
        -- for _, image_object in ipairs(self.image) do
        --     swordBatch:add(image_object.quad
        --     , math.floor(image_object.x)
        --     , math.floor(image_object.y)
        --     , (image_object.r)
        --     , (image_object.sx)
        --     , (image_object.sy)
        --     , math.floor(image_object.ox)
        --     , math.floor(image_object.oy) )
        -- end
        -- love.graphics.draw(swordBatch)
        -- love.graphics.rectangle('fill',0,0,self.width,self.height)
        -- love.graphics.draw(
        --     self.display.atlas,self.display.image
        --     ,self.points[5].x
        --     ,self.points[5].y
        --     ,0
        --     ,self.display.scale.sw
        --     ,self.display.scale.sh
        -- )
    end
    )
end

function Graphics:renderPoints()
    for i, point in ipairs(self.points) do
        love.graphics.setColor(1,0,0)
        love.graphics.circle('fill',point.x,point.y,10)
        love.graphics.reset()
        love.graphics.setColor(0,0,0)
        love.graphics.printf(tostring(i)
        ,point.x
        ,point.y
        ,WINDOW_WIDTH)
        love.graphics.reset()
    end
end
 
function Graphics:renderBackground()
    love.graphics.draw(self.background_canvas,self.x,self.y)
end

function Graphics:renderForeground()
    love.graphics.draw(self.foreground_canvas,self.x,self.y)
end

function Graphics:renderFrame()
    -- for i,edge in pairs(self.edge_names) do
    --     love.graphics.draw(gTextures[self.canvas_frame],gFrames[self.canvas_frame][i],self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
    -- end
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