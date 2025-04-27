
-- def = 

-- position = {x = self.x+self.frame_width, y = self.y+self.frame_height},
-- size = { width = self.width-self.frame_width*2, height = self.height-self.frame_height*2},
-- scale = {self.scale.sw, self.scale.sh}
-- components =  {
-- ['layout'] = {rows = 1, cols = 2},
-- ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
-- ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil}
-- }
-- panel_id = i, 
-- panel_number = i


Panel = Class{}

function Panel:init(def)

    print('PANEL DEBUG ---------------')
    -- PANEL PRESETS
    self.scale = {}
    self.position={}

    -- PANEL POSITION INIT
    self.offset = def['components']['position']['offsets']
    self.x = def['position']['x'] + self.offset.offset_x
    self.y = def['position']['y'] + self.offset.offset_y
    self.rotation = def.rotation or 0

    -- PANEL SIZE INIT
    self.width = def['size']['width'] - 2*self.offset.offset_x
    self.height = def['size']['height'] - 2*self.offset.offset_y

    -- print('PANEL WIDTH: ', self.width)
    -- print('PANEL HEIGHT: ', self.height)

    -- PANEL GRAPHICS INIT
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
        -- print('PANEL X: ', self.position[edge].x)
        -- print('PANEL offset_X: ', self.offset.offset_x)

    end
 
    -- print('PANEL X: ', self.position.top.x)
    -- print('PANEL y: ', self.position.top.y)
    -- print('PANEL scale X: ', self.position.top.sw)
    -- print('PANEL scale y: ', self.position.top.sh)

    self.layout = def['components']['layout']
    -- print('LAYOUT ROWS: ',self.layout.rows)
    -- print('LAYOUT COLS: ',self.layout.cols)
   
    -- PANEL POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)


    -- PANEL SET UP 
    self.panel_id = def.panel_id
    self.panel_number = def.panel_number
    self.panel_state = false

    self.button_interface = def['components']['buttons']
    -- for i,button in pairs(self.button_interface) do
    --     print('BUTTON NUMBER: ', button.button_number)
    -- end
    self.panel_layout = self:layoutInit()



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

function Panel:buttonDim(point1,point2,offset,layout)
    -- spacing = length-(offset*2)-(2*frame_dim)
    local spacing = point2-point1 - offset
    return (spacing/layout)
end


function Panel:layoutInit()

    local button_width = self:buttonDim(self.points[5].x,self.points[6].x,self.offset.offset_x,self.layout.cols)
    local button_height = self:buttonDim(self.points[5].y,self.points[7].y,self.offset.offset_y,self.layout.rows)
    
    button_init = {
        position = {
            x = nil
            ,y = nil
        }
        ,size = {width = button_width,height = button_height}
        ,components = {}
        ,button_id = nil
        ,button_number = nil
    }

    -- print(self.width)
    -- print(self.height)
    -- print('base x:' .. self.x)
    -- print('usable x space:' .. x_usable_space)
    -- print('button_width:' .. button_width)
    -- print('usable y space:' .. y_usable_space)
    -- print('button_height:' .. button_height)

    panel_layout={}
    -- print(self.layout.rows)
    button_number = 1
    for i = 1, self.layout.rows, 1 do
        panel_layout[i] = {}
        -- print(i)
        for j = 1, self.layout.cols,1 do

            -- button_init.position.x = (self.x+self.offset.offset_x +(self.frame_width*j))+(button_width * (j-1))
            -- button_init.position.y = (self.y+self.offset.offset_y +(self.frame_height*i))+(button_height * (i-1))
            button_init.position.x = (self.points[5].x)+(button_width * (j-1))
            button_init.position.y = (self.points[5].y)+(button_height * (i-1))
            button_init.button_number = button_number
            button_init.button_id = button_number
            for k, button in pairs(self.button_interface) do
                if button.button_number == button_number then
                    button_init.components = button
                    break
                end
            end 

            panel_layout[i][j] = Button(button_init)
            -- panel_layout[i][j] = {x = (self.points[5].x)+(self.offset.offset_x *j)+(button_width * (j-1)),
            --                     y = (self.points[5].y)+(self.offset.offset_y *i)+(button_height * (i-1)),
            --                     width = button_width,
            --                     height = button_height,
            --                     button_number = button_number}

            button_number = button_number + 1

            -- print('Button '..i*j .. ' location - '..'x:' ..(self.x+(5*j))+(button_width*(j-1))..' y:' ..(self.y+(5*i))+(button_height*(i-1)))

            
        end
    end
    return panel_layout
end

function Panel:update()
    for i = 1, self.layout.rows, 1 do
        for j = 1, self.layout.cols,1 do
            self.panel_layout[i][j]:update(dt)
        end
    end
end

function Panel:addButton()

end

function Panel:organizeButtons()

end

function Panel:render()
    -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.printf(text,x,y,limit,align)
    if self.panel_state then
        love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        love.graphics.reset()
        for i,edge in pairs(self.edge_names) do
            love.graphics.draw(self.atlas,self.frame[edge].image,self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
        end
        
        for i = 1, self.layout.rows, 1 do
            -- print(self.panel_row_number)
            for j = 1, self.layout.cols,1 do
                -- print(j)
                self.panel_layout[i][j]:render()
                -- love.graphics.setColor(0,0,0)
                -- love.graphics.rectangle(mode,x,y,width,height)
                -- love.graphics.rectangle('fill'
                -- ,self.panel_layout[i][j].x
                -- ,self.panel_layout[i][j].y
                -- ,self.panel_layout[i][j].width
                -- ,self.panel_layout[i][j].height)
                -- love.graphics.reset()

            end
        end

        for i, point in ipairs(self.points) do
            love.graphics.setColor(0,1,1)
            love.graphics.circle('fill',point.x,point.y,10)
            love.graphics.reset()
        end

        love.graphics.setColor(0,0,0)
        love.graphics.printf('This is Panel:' .. tostring(self.panel_number)
        ,self.x + self.offset.offset_x
        ,self.y + self.offset.offset_y,WINDOW_WIDTH)
        love.graphics.reset()
    end
end