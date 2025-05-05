
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

    -- PANEL PRESETS
    self.scale = {}
    self.position={}
    -- PANEL DEBUG
    self.debug = def['components']['debug']
    self.menu_name = def['menu_name']

    -- PANEL POSITION INIT
    self.offset = def['components']['position']['offsets']
    self.x = def['position']['x'] + self.offset.offset_x
    self.y = def['position']['y'] + self.offset.offset_y
    self.rotation = def.rotation or 0
    self.width = def['size']['width'] - 2*self.offset.offset_x
    self.height = def['size']['height'] - 2*self.offset.offset_y
    self.layout = def['components']['layout']

    if self.debug then self:panelDebug() end

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
   
    -- PANEL POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)

    if self.debug then self:PositionDebug() end
    
    -- PANEL SET UP 
    self.panel_id = def.panel_id
    self.panel_number = def.panel_number
    self.panel_state = false

    self.button_interface = def['components']['buttons']
    self.panel_layout = {}

    if self.layout.priority == 'rows' then
        priority = 'rows'
        secondary = 'cols'
    else
        priority = 'cols'
        secondary = 'rows'
    end

    k = 1
    for i,tab in pairs(self.layout[priority]) do
        for j = 1,tab,1 do
            self.panel_layout[k] = {
                priority = { p = 1, dim = self.layout[priority][i]}
                ,non_priority = {p = #self.layout[priority], dim = self.layout[secondary][i]}
            }
            print('PANEL LAYOUT: ',priority..' '..self.panel_layout[k].priority.dim,secondary..' '..self.panel_layout[k].non_priority.dim)
            k = k + 1
        end
    end
    
    self.panel_width = self.points[6].x - self.points[5].x
    self.panel_height = self.points[7].y-self.points[5].y
    self:layoutInit()
end

function Panel:buttonDim(length,offset,divider,layout)
    local spacing = ((length/layout)/divider) - offset
    return (spacing)
end


function Panel:layoutInit()

    button_number = 1
    for k,layout in pairs(self.panel_layout) do

        local button_init = {
            position = {
                x = nil
                ,y = nil
            }
            ,size = {width = nil,height = nil}
            ,components = {}
            ,button_id = nil
            ,button_number = nil
            ,menu_name = self.menu_name
        }

        for i, button in pairs(self.button_interface) do
            if button.button_number == button_number then
                button_init.components = button
                break
            end
        end 

        local off_x = button_init.components.position.offsets.offset_x
        local off_y = button_init.components.position.offsets.offset_y
        local button_width = nil
        local button_height = nil

        if priority == 'rows' then
            button_width = self:buttonDim(self.panel_width,off_x,layout.non_priority.p,layout.non_priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.priority.p,layout.priority.dim)
        else
            button_width = self:buttonDim(self.panel_width,off_x,layout.priority.p,layout.priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.non_priority.p,layout.non_priority.dim)
        end
        button_init.size = {width = button_width,height = button_height}

        layout.button = {}

        x_list = self.panel_width / layout.priority.dim
        y_list = self.panel_height / layout.non_priority.p


        -- self.points[5].x,self.points[5].y
        -- self.points[5].x + x_list, self.points[5].y
        -- if too big then
        -- self.points[5].x, self.points[5].y + y_list         
        -- self.points[5].x + x_list, self.points[5].y + y_list
    

        if k>1 then
            if self.layout.priority == 'cols' then
                if (self.panel_layout[k-1].button[1].x + self.panel_layout[k-1].button[1].width) >= self.panel_width then
                    button_init.position.x = (self.points[5].x)
                    button_init.position.y = (self.points[5].y) - self.panel_layout[k-1].button[1].offset.offset_y + y_list
                else
                    button_init.position.x = self.panel_layout[k-1].button[1].x - self.panel_layout[k-1].button[1].offset.offset_x + x_list
                    button_init.position.y = self.panel_layout[k-1].button[1].y - self.panel_layout[k-1].button[1].offset.offset_y
                end
            else 
                if (self.panel_layout[k-1].button[1].y + self.panel_layout[k-1].button[1].height - self.offset.offset_y) >= self.panel_height then
                    button_init.position.x = (self.panel_layout[k-1].button[1].x )+(button_width) - self.panel_layout[k-1].button[1].offset.offset_x
                    button_init.position.y = (self.points[5].y)
                else
                    button_init.position.x = self.panel_layout[k-1].button[1].x - self.panel_layout[k-1].button[1].offset.offset_x
                    button_init.position.y = self.panel_layout[k-1].button[1].y + button_height - self.panel_layout[k-1].button[1].offset.offset_y
                end
            end
        else
            button_init.position.x = (self.points[5].x)
            button_init.position.y = (self.points[5].y)
        end

        button_init.button_number = button_number
        button_init.button_id = button_number

        button_number = button_number + 1  
        table.insert(layout.button ,Button(button_init))

        if self.debug then self:buttonPosition(k,layout,button_init) end
        
    end
end

function Panel:update(dt)
    if self.panel_state then
        for k,layout in pairs(self.panel_layout) do
            layout.button[1]:update(dt)
        end            
    end
end

function Panel:resetButton()
    for k,layout in pairs(self.panel_layout) do
        layout.button[1].button_selected = false
        layout.button[1].button_state = false
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
        
        for k,layout in pairs(self.panel_layout) do
            layout.button[1]:render()
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

function Panel:panelDebug()
    print('\n','PANEL DEBUG ----------------------------------------------------')
    print('MENU NAME: ',self.menu_name)
    print('LAYOUT ROWS: ',self.layout.rows)
    print('LAYOUT COLS: ',self.layout.cols)
    print('PANEL X: ', self.x)
    print('PANEL y: ', self.y)
    print('PANEL WIDTH: ', self.width)
    print('PANEL HEIGHT: ', self.height)
    print('PANEL OFFSET X: ', self.offset.offset_x)
    print('PANEL OFFSET Y: ', self.offset.offset_y)
end

function Panel:frameDebug(edge)
    print('\n','FRAME DEBUG: ',edge, ' -------------')
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

function Panel:PositionDebug()
    print('\n','PANEL POSITIONS:')
    print('OUTTER P1 - X,Y: ', self.points[1].x,' ',self.points[1].y)
    print('OUTTER P2 - X,Y: ', self.points[2].x,' ',self.points[2].y)
    print('OUTTER P3 - X,Y: ', self.points[3].x,' ',self.points[3].y)
    print('OUTTER P4 - X,Y: ', self.points[4].x,' ',self.points[4].y)
    print('INNER P5 - X,Y: ', self.points[5].x,' ',self.points[5].y)
    print('INNER P6 - X,Y: ', self.points[6].x,' ',self.points[6].y)
    print('INNER P7 - X,Y: ', self.points[7].x,' ',self.points[7].y)
    print('INNER P8 - X,Y: ', self.points[8].x,' ',self.points[8].y)
end

function Panel:buttonPosition(k,layout,button)
    print('NEW LOOP ',k,' --------------------------------------------')
    print('PANEL HEIGHT: '..self.panel_height)
    print('PANEL WIDTH: '..self.panel_width)
    print('LAYOUT NONPRIORITY: '..layout.non_priority.p)
    print('LAYOUT PRIORITY: '..layout.priority.p)
    print('LAYOUT NONPRIORITY DIM: '..layout.non_priority.dim)
    print('LAYOUT PRIORITY DIM: '..layout.priority.dim)
    print('BUTTON '..k..' OFFSET X: '..button.components.position.offsets.offset_x)
    print('BUTTON '..k..' OFFSET Y: '..button.components.position.offsets.offset_y)
    print('BUTTON: '..k,'X: '..button.position.x)
    print('BUTTON: '..k,'y: '..button.position.y)
    print('BUTTON: '..k,'W: '..button.size.width)
    print('BUTTON: '..k,'H: '..button.size.height)
end