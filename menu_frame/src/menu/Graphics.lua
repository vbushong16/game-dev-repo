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
    self.edge_names = {'bottom','left','top','right'}
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
    -- OBJECT GRAPHICS INIT
    self.canvas_frame = def['graphics']['frame']
    self.canvas_frame_quad = images_catalog[self.canvas_frame].image_quad
    self.background = def['graphics']['background']
    self.foreground = def['graphics']['foreground']
    self.graphics_type = def['graphics']['type']
    self.stickers = def['graphics']['stickers']
    -- FRAME RENDERING INIT
    self.frame = def['frame']

    self.graphics_defs = {
        -- OBJECT POSITION INIT 
        offsets = self.offset
        ,x = self.x
        ,y = self.y
        ,rotation = self.rotation
        ,width = self.width
        ,height = self.height  
        -- OBJECT GRAPHICS INIT
        ,canvas_frame = self.canvas_frame
        ,canvas_frame_quad = self.canvas_frame_quad
        ,background = self.background
        ,foreground = self.foreground
        ,graphics_type = self.graphics_type
        ,stickers = self.stickers
        -- FRAME RENDERING
        ,frame = self.frame
    }


    self:frameUnpacking()
    self:framePositionCalc()

    
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



    Push:setupCanvas({
        {name = 'foreground_canvas'}
        ,{name = 'frame_canvas'}
        ,{name = 'background_canvas'}

    })

    self.image = {}
    self.text = nil
end

function Graphics:setGraphics(graphics_defs)
    self.scale = {}
    self.position={}
    self.offset = graphics_defs.offsets
    self.x = graphics_defs.x
    self.y = graphics_defs.y
    self.rotation = graphics_defs.rotation
    self.width = graphics_defs.width
    self.height = graphics_defs.height
    -- OBJECT GRAPHICS
    -- self.canvas_frame = graphics_defs.canvas_frame
    -- self.canvas_frame_quad = graphics_defs.canvas_frame_quad
    self.background = graphics_defs.background
    self.foreground = graphics_defs.foreground
    self.graphics_type = graphics_defs.graphics_type
    self.stickers = graphics_defs.stickers
    -- FRAME RENDERING
    -- self.frame = graphics_defs.frame
end

function Graphics:setImage(display,sw,sh,first_sprite,last_sprit)
    self.text = nil
    for i = first_sprite,last_sprit,1 do
        table.insert(self.image,{
            quad = gFrames[display][i]
            ,x = self.points[1].x
            ,y = self.points[1].y
            ,r = 0 * 3.14/180
            ,sx = sw
            ,sy = sh
            ,ox = 0
            ,oy = 0
        })
    end
end

function Graphics:setText(display)
    self.text = display
end

function Graphics:framePositionCalc()
    self.x_point = self.x + self.frame['left'].image_dimensions.x * self.width/self.canvas_frame_quad
    self.y_point = self.y
    self.width_point = (self.frame['right'].image_dimensions.x  - self.frame['left'].image_dimensions.x + self.frame['right'].image_dimensions.width) * self.width/self.canvas_frame_quad
    self.height_point = (self.frame['bottom'].image_dimensions.y  - self.frame['top'].image_dimensions.y + self.frame['bottom'].image_dimensions.height) * self.height/self.canvas_frame_quad
    -- -- OBJECT POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x_point,self.y_point,self.width_point,self.height_point,frame_offsets)
end

function Graphics:frameUnpacking()

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
        
            self.scale[edge] = scaleWH(w,h,self.frame[edge].image_dimensions.width,self.frame[edge].image_dimensions.height)
        
            local frame_adjustment = nil
            local coord_adjustment = nil
            if edge == 'bottom' or edge == 'top' then
                frame_adjustment = (self.frame[edge].image_dimensions.height *self.height/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.height *self.scale[edge].sh) 
                coord_adjustment = (self.frame[edge].image_dimensions.y *self.height/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.y *self.scale[edge].sh)
            elseif edge == 'left' or edge == 'right' then
                frame_adjustment = (self.frame[edge].image_dimensions.width *self.width/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.width *self.scale[edge].sw)
                coord_adjustment = (self.frame[edge].image_dimensions.x *self.width/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.x *self.scale[edge].sw)
            else
                frame_adjustment = nil
            end
        
            self.position[edge] = frameRender(edge,self.x,self.y,self.scale[edge].sw,self.scale[edge].sh,frame_adjustment,coord_adjustment)
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

end

function Graphics:renderPoints()
    for i, point in ipairs(self.points) do
        love.graphics.setColor(1,0,0)
        love.graphics.circle('fill',point.x,point.y,10)
        love.graphics.setColor(0,0,0)
        love.graphics.printf(tostring(i)
        ,point.x
        ,point.y
        ,VIRTUAL_WIDTH)
    end
    love.graphics.reset()
end
 
function Graphics:renderBackground()
    Push:setCanvas('background_canvas')
    if self.text ~= nil then
        love.graphics.setFont(currentFont) 
        local x_pos = middleX(self.points[1].x,self.points[2].x)
        local y_pos = middleX(self.points[1].y,self.points[3].y)-currentFont:getHeight()/2
        love.graphics.printf(self.text,self.points[1].x,y_pos,self.width,'center')
    else
        renderImagePrep(spriteBatch,self.image,1,5)
    end
    love.graphics.reset()
end

function Graphics:renderForeground()
    Push:setCanvas('foreground_canvas')
    love.graphics.setColor(0.37,0.61,0.54,1.0)
    love.graphics.rectangle('fill',self.points[1].x,self.points[1].y,self.width,self.height)
    love.graphics.reset()
end

function Graphics:renderFrame()
    Push:setCanvas('frame_canvas')
    for i,edge in pairs(self.edge_names) do
        love.graphics.draw(gTextures[self.canvas_frame],gFrames[self.canvas_frame][i],self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
    end
    love.graphics.reset()
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


function Graphics:metadataDebug(component)
    local component = component
    print('\n',component..' METADATA DEBUG ----------------------------------------------------')
    print(component..' NAME: ',self.menu_name)
    print(component..' X: ',self.x)
    print(component..' Y: ',self.x)
    print(component..' WIDTH: ', self.width)
    print(component..' HEIGHT: ', self.height)
    print(component..' OFFSET BOTTOM: ', self.offset.bottom)
    print(component..' OFFSET TOP: ', self.offset.top)
    print(component..' OFFSET LEFT: ', self.offset.left)
    print(component..' OFFSET RIGHT: ', self.offset.right)
end

function Graphics:positionDebug(component)
    print('\n',component..' POSITION DEBUG ------------------------------------------')
    print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
    print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
    print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
    print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
    print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
    print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
    print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
    print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y) 
end

function Graphics:frameDebug(component)

    print('\n',component..' FRAME DEBUG ------------------------------------------')
    for i, edge in pairs(self.edge_names) do
        print('ACTUAL VALUES ========================================')
        print('FOR EDGE '..edge,'POSITION image width: '..self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION image height: '..self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION drawing width: '..self.frame[edge].image_dimensions.width)
        print('FOR EDGE '..edge,'POSITION drawing height: '..self.frame[edge].image_dimensions.height)
        print('FOR EDGE '..edge,'POSITION image X: '..self.frame[edge].image_dimensions.x)
        print('FOR EDGE '..edge,'POSITION image Y: '..self.frame[edge].image_dimensions.y)
        print('FOR EDGE '..edge,'POSITION canvas WIDTH: '..self.width)
        print('FOR EDGE '..edge,'POSITION canvas HEIGHT: '..self.height)
        print('FOR EDGE '..edge,'POSITION SCALE R WIDTH: '..self.width/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION SCALE R HEIGHT: '..self.height/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION SCALE D WIDTH: '..self.scale[edge].sw)
        print('FOR EDGE '..edge,'POSITION SCALE D HEIGHT: '..self.scale[edge].sh)
        print('FOR EDGE '..edge,'POSITION X R: '..self.frame[edge].image_dimensions.x * self.width/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION Y R: '..self.frame[edge].image_dimensions.y * self.height/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'POSITION X D: '..self.frame[edge].image_dimensions.x * self.scale[edge].sw)
        print('FOR EDGE '..edge,'POSITION Y D: '..self.frame[edge].image_dimensions.y * self.scale[edge].sh)
        print('FOR EDGE '..edge,'FRAME ADJ W R: '..self.frame[edge].image_dimensions.width * self.width/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'FRAME ADJ H R: '..self.frame[edge].image_dimensions.height * self.height/self.canvas_frame_quad)
        print('FOR EDGE '..edge,'FRAME ADJ W D: '..self.frame[edge].image_dimensions.width * self.scale[edge].sw)
        print('FOR EDGE '..edge,'FRAME ADJ H D: '..self.frame[edge].image_dimensions.height * self.scale[edge].sh)
        x_adj = (self.frame[edge].image_dimensions.x * self.width/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.x * self.scale[edge].sw)
        y_adj = (self.frame[edge].image_dimensions.y * self.height/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.y * self.scale[edge].sh)
        frame_w_adj = (self.frame[edge].image_dimensions.width * self.width/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.width * self.scale[edge].sw)
        frame_h_adj = (self.frame[edge].image_dimensions.height * self.height/self.canvas_frame_quad) - (self.frame[edge].image_dimensions.height * self.scale[edge].sh)
        print('APPLIED ADJUSTMENTS ================================')
        print('FOR EDGE '..edge,'POSITION X ADJ: '..x_adj + frame_w_adj)
        print('FOR EDGE '..edge,'POSITION Y ADJ: '..y_adj + frame_h_adj)
        print('FRAME RENDER VALUES ========================================')
        print('X RENDER VALUE: '..self.position[edge].x)
        print('Y RENDER VALUE: '..self.position[edge].y)
        print('SW RENDER VALUE: '..self.position[edge].sw)
        print('SH RENDER VALUE: '..self.position[edge].sh)
    end
end






     