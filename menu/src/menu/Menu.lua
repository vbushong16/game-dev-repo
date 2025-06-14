Menu = Class{__includes = Graphics}

function Menu:init(def)
    Graphics.init(self,def)

    local menu_name = self.menu_name
    local points = self.points

    -- PANEL INIT
    self.panels = {}
    self.panels_to_build = def['components']['number_of_panels']
    self.panel_init = {}

    if self.panels_to_build >= 1 then
        for i,interface in pairs(def['panels']) do 
            self.panel_init = interface
            self.panel_init.metadata.name = menu_name
            self.panel_init.position.x = points[5].x
            self.panel_init.position.y = points[5].y
            self.panel_init.size = {width = points[6].x-points[5].x, height = points[7].y-points[5].y}
            self.panel_id = i
            self.panel_init.panel_number = interface.panel_order
            table.insert(self.panels, {id = i,panel_number = interface.panel_order, panel = Panel(self.panel_init)
        })
        end
    end
    -- sort = function(a,b) return a.panel_number<b.panel_number end
    table.sort(self.panels,function(a,b) return a.panel_number<b.panel_number end)
        
    -- MENU LOGIC INIT0
    self.menu_state = false

    -- for i,panel in pairs(self.panels) do
    --     print('PANEL: ',panel.id,' STATE',panel.panel.panel_state)
    -- end
    
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

function Menu:render()
    -- love.graphics.rectangle(mode,x,y,width,height)
    -- love.graphics.circle(mode,x,y,radius)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
    if self.menu_state then
        -- love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        -- love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        -- love.graphics.reset()
        Graphics.renderFrame(self)
        if #self.panels > 0 then 
            self.panels[self.current_panel]['panel']:render()
        end
    end
end

function Menu:update(dt)
    Graphics.update(self,dt)

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

-- NEED TO REFACTOR
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
        self.panels[self.current_panel]['panel']:resetButton()
        -- print('OLD PANEL:' .. self.current_panel,'IS:'.. tostring(self.panels[self.current_panel]['panel'].panel_state))
        self.current_panel = self.current_panel + input
        self.panels[self.current_panel]['panel'].panel_state = true
        -- print('NEW PANEL:' .. self.current_panel,'IS:'..tostring(self.panels[self.current_panel]['panel'].panel_state))
    end
end