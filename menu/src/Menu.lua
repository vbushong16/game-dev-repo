

Menu = Class{}

function Menu:init(def)

    -- MENU PRESETS
    self.scale = {}
    self.position={}

    -- MENU POSITION INIT
    self.x = def['position']['x']
    self.y = def['position']['y']
    self.rotation = def.rotation or 0
    
    -- MENU SIZE INIT
    self.width = def['size']['width']
    self.height = def['size']['height']

    print('MENU WIDTH: ', self.width)
    print('MENU HEIGHT: ', self.height)

    -- MENU GRAPHICS INIT
    self.render_type = def['graphics']['render_type']
    self.rgb = def['graphics']['rgb']
    self.atlas = def['graphics']['atlas']

    self.shape = def['graphics']['shape']
    self.frame = def['frame']
    self.edge_names = {'top','bottom','left','right'}
    -- local w,h = nil, nil
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

        print('INPUT INTO SCALEXY')
        print('FOR EDGE: ',edge,' WIDTH IS: ',w)
        print('FOR EDGE: ',edge,' HEIGHT IS: ',h)
        self.scale[edge] = scaleXY(
            w
            ,h
            ,self.frame[edge].image_dimensions.width
            ,self.frame[edge].image_dimensions.height

        )
        print('FRAME IMAGE SW: ',self.scale[edge].sw)
        print('FRAME IMAGE SH: ',self.scale[edge].sh)

        local frame_adjustment = nil
        if edge == 'bottom' then
            frame_adjustment = self.frame[edge].dimensions.height
        elseif edge == 'right' then
            frame_adjustment = self.frame[edge].dimensions.width
        else
            frame_adjustment = nil
        end
        self.position[edge] = frameRender(edge,self.x,self.y,self.width,self.height,self.scale[edge].sw,self.scale[edge].sh,frame_adjustment)

    end

    -- MENU POSITIONS
    local frame_offsets = {
        ['top'] = self.frame.top.dimensions.height
        ,['bottom'] = self.frame.bottom.dimensions.height
        ,['left'] = self.frame.left.dimensions.width
        ,['right'] = self.frame.right.dimensions.width
    }
    self.points = objectCoord(self.x,self.y,self.width,self.height,frame_offsets)
    


    -- PANEL INIT
    self.panels = {}
    self.panels_to_build = def['components']['number_of_panels']
    self.panel_init = {
        position = {x = self.points[5].x, y = self.points[5].y},
        size = {width = self.points[6].x-self.points[5].x, height = self.points[7].y-self.points[5].y},
        components = {},
        panel_id = nil, 
        panel_number = nil,
    }

    if self.panels_to_build >= 1 then
        for i,interface in pairs(def['panels']) do 
            self.panel_init.components = interface
            self.panel_init.panel_id = i
            self.panel_init.panel_number = interface.panel_order
            table.insert(self.panels, {id = i,panel_number = interface.panel_order, panel = Panel(self.panel_init)
        })
        end
    end
    -- sort = function(a,b) return a.panel_number<b.panel_number end
    table.sort(self.panels,function(a,b) return a.panel_number<b.panel_number end)
        

    -- MENU LOGIC INIT0
    self.menu_state = false

    self.current_panel = 1
    if #self.panels > 0 then 
        self.panels[self.current_panel]['panel'].panel_state = true
    end

    -- print('THERE ARE X PANELS: ',#self.panels)
    -- print('THERE SHOULD BE X PANELS: ',self.panels_to_build)

    -- self.number_panels = def.num_panels or 0
    -- if self.number_panels > 1 then self.scrollabe_status = true else self.scrollabe_status = false end
    -- if self.scrollabe_status then 
    --     self.scrollabe_direction = 'horizontal'
    --     self.scroller_anchor = self.y + self.height/2
    --     self.scroller_direction, self.scroller_direction_2 = self.x, self.x + self.width
    -- else 
    --     self.scrollabe_direction = false 
    -- end



end


function scaleXY(width,height,graphics_width,graphics_height)
    local scale_table = {sw = width/graphics_width, sh = height/graphics_height}
       -- print('THIS IS THE EDGE SCALE: ', scale_table.sw ,' & ', scale_table.sh)
   return scale_table
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


function Menu:render()
    -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.circle(mode,x,y,radius)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    if self.menu_state then
        love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        love.graphics.reset()
        for i,edge in pairs(self.edge_names) do
            love.graphics.draw(self.atlas,self.frame[edge].image,self.position[edge].x,self.position[edge].y,self.rotation,self.position[edge].sw,self.position[edge].sh)
        end
        for i, point in ipairs(self.points) do
            love.graphics.setColor(1,1,0)
            love.graphics.circle('fill',point.x,point.y,10)
            love.graphics.reset()
        end


        if #self.panels > 0 then 
            -- print('CURRENT PANEL: ', self.current_panel)
            self.panels[self.current_panel]['panel']:render()
        end

    end
end

function Menu:update(dt)
    if #self.panels > 0 then 
        self.panels[self.current_panel]['panel']:update(dt)
    end
    if #self.panels >= 2 then
        self.scrollabe_status = true
        -- self.scrollabe_direction = 'horizontal'
        self:scroller()
    else
        self.scrollabe_status = false
    end
end


    
function Menu:addPanel(panel_input)
    --THIS WILL NEED TO BE UPDATED
    local panel_id = #self.panels+1
    self.panel_init.components = panel_input
    self.panel_init.panel_id = panel_id
    self.panel_init.panel_number = panel_id 
    table.insert(self.panels,{id = panel_id,panel_number = panel_id, panel = Panel(self.panel_init)})
    if #self.panels == 1 then
        self.panels[1].panel.panel_state = true
    end
end

function Menu:removePanel(current_panel_value)

    local panel_id = self.panels[current_panel_value]['id']

    for i,panel in pairs(self.panels) do
        if panel.id == panel_id then
            table.remove(self.panels,i)
            if self.current_panel > 1 then
                self.current_panel = self.current_panel-1
                self.panels[self.current_panel]['panel'].panel_state = true
            else
                self.current_panel = 1
                self.panels[self.current_panel]['panel'].panel_state = true
            end
        end
    end
end

function Menu:updatePanelsOrder(old_panel_position, new_panel_position)
    local panel_to_reorder = self.panels[new_panel_position]
    self.panels[new_panel_position] = self.panels[old_panel_position]
    self.panels[old_panel_position] = panel_to_reorder
end

function Menu:openClose()
    if self.menu_state then
        self.menu_state = false
    else
        self.menu_state = true
    end
end

function Menu:scroller()
    if self.scrollabe_status then
        if self.scrollabe_direction == 'horizontal' then
            self.scroller_anchor = self.y + self.height/2
            self.scroller_direction,self.scroller_direction_2 = self.x, self.x + self.width
        else 
            self.scroller_anchor = self.x + self.width/2
            self.scroller_direction,self.scroller_direction2 = self.y, self.y + self.height
        end
    end
end

function Menu:updateScroller()
    if self.scrollabe_status then
        if self.scrollabe_direction == 'horizontal' then
            self.scrollabe_direction = 'vertical'
        else 
            self.scrollabe_direction = 'horizontal'
        end
    end
end

function Menu:navigation(input)
    -- print('current panel: '.. self.current_panel)
    -- print('number of panels: ' .. #self.panels)
    if self.current_panel+input > 0 and self.current_panel+input <= #self.panels then
        self.panels[self.current_panel]['panel'].panel_state = false
        self.current_panel = self.current_panel + input
        self.panels[self.current_panel]['panel'].panel_state = true
        -- print('new panel: '.. self.current_panel)
    end
end
