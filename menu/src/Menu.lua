

Menu = Class{}

function Menu:init(def)

    self.theme = def.theme or 0
    self.shape = def.shape or 0
    self.width = def.width or 100
    self.height = def.height or 100
    self.radius = def.radius or 0
    self.x = def.x or 0
    self.y = def.y or 0
    self.rotation = def.rotation or 0
    self.scale_x = def.scale_x or 0
    self.scale_y = def.scale_y or 0
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
    self.current_panel = 1
    self.panels = {}


    for i = 1,self.number_panels,1 do
        -- table.insert(self.panels,{id = i, panel = 'Panel'})
        self.panels[i] = {id = i, panel = Panel({x = self.x+5,y = self.y+5,width = self.width-10, height = self.height-10, panel_id = i, panel_number = i,r=1,g= 1,b=0,panel_row_number = 4,panel_col_number=1})}
    end

    if #self.panels > 0 then 
        self.panels[self.current_panel]['panel'].panel_state = true
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
    if self.menu_state then
        love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    
        if self.scrollabe_status then
            if self.scrollabe_direction == 'horizontal' then
                love.graphics.circle('fill',self.scroller_direction,self.scroller_anchor,10)
                love.graphics.circle('fill',self.scroller_direction_2,self.scroller_anchor,10)
            else
                love.graphics.circle('fill',self.scroller_anchor,self.scroller_direction,10)
                love.graphics.circle('fill',self.scroller_anchor,self.scroller_direction_2,10)
            end
        end
        -- print(self.panels[self.current_panel]['panel'].panel_state)
        if #self.panels > 0 then 
            self.panels[self.current_panel]['panel']:render()
        end

    end
end
