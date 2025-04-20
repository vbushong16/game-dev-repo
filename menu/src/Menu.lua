

Menu = Class{}

function Menu:init(def)

    -- MENU GRAPHICS INIT
    self.render_type = def['graphics']['render_type']
    self.rgb = def['graphics']['rgb']
    self.image = def['graphics']['image']
    self.shape = def['graphics']['shape']
    self.frame = {}
    self.frame.images = def['frame']['image']
    self.frame.dimensions = def['frame']['dimensions']
    self.frame.rgb = def['frame']['rgb']
    

    -- MENU SIZE INIT
    if self.shape == 'rectangle' then
        self.width = def['size']['width']
        self.height = def['size']['height']
    elseif self.shape == 'circle' then
        self.radius = def['size']['radius']
    end

    -- MENU POSITION INIT
    self.x = def['position']['x']
    self.y = def['position']['y']
    
    self.scale = self:scaleXY()
    -- print(self.scale.top.sw)
    
    self.rotation = def.rotation or 0
    self.offset_x = def.offset_x or 0
    self.offset_y = def.offset_y or 0

    self.number_panels = def.num_panels or 0
    if self.number_panels > 1 then self.scrollabe_status = true else self.scrollabe_status = false end
    if self.scrollabe_status then 
        self.scrollabe_direction = 'horizontal'
        self.scroller_anchor = self.y + self.height/2
        self.scroller_direction, self.scroller_direction_2 = self.x, self.x + self.width
    else 
        self.scrollabe_direction = false 
    end

    self.menu_state = false
    -- self.current_panel = 1
    self.panels = {}


    for i = 1,self.number_panels,1 do
        -- table.insert(self.panels,{id = i, panel = 'Panel'})
        self.panels[i] = {id = i, panel = Panel({x = self.x+5,y = self.y+5,
        width = self.width-10, height = self.height-10, 
        panel_id = i, panel_number = i,r=1,g= 1,b=0,panel_row_number = 4,panel_col_number=1,scale_x = self.scale_x,scale_y = self.scale_y})}
    end

    if #self.panels > 0 then 
        self.panels[self.current_panel]['panel'].panel_state = true
    end


end



function Menu:scaleXY()
    local scale_table = {}
    if self.render_type == 'image' then
        sw,sh = select(3,self.image:getViewport()),select(4,self.image:getViewport())
        scale_table.sw,scale_table.sh = self.width/sw,self.height/sh
    elseif self.render_type == 'frame' then
        scale_table.top = {sw = self.width/select(3,self.frame.images['top']:getViewport()), sh = self.frame.dimensions.height/select(4,self.frame.images['top']:getViewport())}
        scale_table.bottom = {sw = self.width/select(3,self.frame.images['bottom']:getViewport()),sh = self.frame.dimensions.height/select(4,self.frame.images['bottom']:getViewport())}
        scale_table.left = {sw = self.frame.dimensions.width/select(3,self.frame.images['left']:getViewport()),sh = self.height/select(4,self.frame.images['left']:getViewport())}
        scale_table.right = {sw = self.frame.dimensions.width/select(3,self.frame.images['right']:getViewport()),sh = self.height/select(4,self.frame.images['right']:getViewport())} 
    else
        scale_table.sw,scale_table.sh = 0,0
    end
    return scale_table
end



-- function Menu:findCorners()
--     local corners_table = {}
--     if self.render_type == image then
--         x1 = self.x - self.width/2
--         x2 = self.x + self.width/2
--         y1 = self.y - self.height/2
--         y2 = self.y + self.height/2
--     else
--         x1 = self.x
--         x2 = self.x + self.width
--         y1 = self.y
--         y2 = self.y + self.height
--     end
--     corners_table{x1=x1,x2=x2,y1=y1,y2=y2}
--     return corners_table
-- end

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
    panel_id = #self.panels+1
    table.insert(self.panels,{id = panel_id, panel = panel_input})
end

function Menu:removePanel(current_panel_value)

    panel_id = self.panels[current_panel_value]['id']

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
    panel_to_reorder = self.panels[new_panel_position]
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
    print('current panel: '.. self.current_panel)
    print('number of panels: ' .. #self.panels)
    if self.current_panel+input > 0 and self.current_panel+input <= #self.panels then
        self.panels[self.current_panel]['panel'].panel_state = false
        self.current_panel = self.current_panel + input
        self.panels[self.current_panel]['panel'].panel_state = true
        print('new panel: '.. self.current_panel)
    end
end


function Menu:render()
    -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.circle(mode,x,y,radius)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    if self.menu_state then

        if self.render_type == 'image' then
            love.graphics.draw(spritesheet,self.image,self.x,self.y,self.rotation,self.scale.sw,self.scale.sh)
            -- love.graphics.setFilter("nearest", "nearest")
        elseif self.render_type == 'frame' then
            love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
            love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
            love.graphics.reset()
            love.graphics.draw(spritesheet,self.frame.images['top'],self.x,self.y,self.rotation,self.scale.top.sw,self.scale.top.sh)
            love.graphics.draw(spritesheet,self.frame.images['bottom'],self.x,self.y+self.height-self.frame.dimensions.height,self.rotation,self.scale.bottom.sw,self.scale.bottom.sh)
            love.graphics.draw(spritesheet,self.frame.images['left'],self.x,self.y,self.rotation,self.scale.left.sw,self.scale.left.sh)
            love.graphics.draw(spritesheet,self.frame.images['right'],self.x+self.width-self.frame.dimensions.width,self.y,self.rotation,self.scale.right.sw,self.scale.right.sh)
        elseif self.render_type == 'rgb' then
            love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
            love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
            love.graphics.reset()
            love.graphics.setColor(self.frame.rgb.r,self.frame.rgb.g,self.frame.rgb.b)
            love.graphics.rectangle('fill',self.x,self.y,self.frame.dimensions.width,self.height)
            love.graphics.rectangle('fill',self.x,self.y,self.width,self.frame.dimensions.height)
            love.graphics.rectangle('fill',self.width,self.y,self.frame.dimensions.width,self.height)
            love.graphics.rectangle('fill',self.x,self.height,self.width,self.frame.dimensions.height)
            love.graphics.reset()
        end

        -- love.graphics.setColor(0,0,0)
        -- love.graphics.line(self.x,self.y+20,self.x+self.scale.sw*2,self.y+20)
        -- love.graphics.reset()
        -- if self.scrollabe_status then
        --     if self.scrollabe_direction == 'horizontal' then
        --         love.graphics.circle('fill',self.scroller_direction,self.scroller_anchor,10)
        --         love.graphics.circle('fill',self.scroller_direction_2,self.scroller_anchor,10)
        --     else
        --         love.graphics.circle('fill',self.scroller_anchor,self.scroller_direction,10)
        --         love.graphics.circle('fill',self.scroller_anchor,self.scroller_direction_2,10)
        --     end
        -- end
        -- -- print(self.panels[self.current_panel]['panel'].panel_state)
        -- if #self.panels > 0 then 
        --     self.panels[self.current_panel]['panel']:render()
        -- end

    end
end
