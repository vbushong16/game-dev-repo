Panel = Class{__includes = Graphics}

function Panel:init(def)

    Graphics.init(self,def)
    -- GRAPHICS DEBUG
    if self.debug then 
        Graphics.metadataDebug(self,'PANEL')
        Graphics.frameDebug(self,'PANEL')
        Graphics.positionDebug(self,'PANEL')
    end    
    -- -- PANEL SET UP 
    self.layout = def['layout']
    self.panel_id = def.panel_id
    self.panel_number = def.panel_number
    self.panel_state = false

    self.button_interface = def['buttons']
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
            k = k + 1
        end
    end
    
    self.panel_width = self.points[6].x - self.points[5].x
    self.panel_height = self.points[7].y - self.points[5].y

    -- PANEL LAYOUT DEBUG
    if self.debug then self:panelLayout() end

    self:layoutInit()
end

function Panel:buttonDim(length,offset,divider,layout)
    local spacing = ((length/layout)/divider)
    return (spacing)
end


function Panel:layoutInit()

    button_number = 1
    for k,layout in pairs(self.panel_layout) do
        local button_init = {}
        for i, button in pairs(self.button_interface) do
            if button.button_number == button_number then
                button_init = button
                break
            end
        end 
        local off_x = button_init.position.offsets.left + button_init.position.offsets.right
        local off_y = button_init.position.offsets.top + button_init.position.offsets.bottom
        local button_width = nil
        local button_height = nil
        local x_list = nil
        local y_list = nil

        if self.layout.priority == 'cols' then
            button_width = self:buttonDim(self.panel_width,off_x,layout.priority.p,layout.priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.non_priority.p,layout.non_priority.dim)
            x_list = self.panel_width / layout.priority.dim
            y_list = self.panel_height / layout.non_priority.p
        else
            button_width = self:buttonDim(self.panel_width,off_x,layout.non_priority.p,layout.non_priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.priority.p,layout.priority.dim)
            x_list = self.panel_width / layout.non_priority.p
            y_list = self.panel_height / layout.priority.dim  
        end

        button_init.size = {width = button_width,height = button_height}
        layout.button = {}

        if k>1 then
            if self.layout.priority == 'cols' then
                if (self.panel_layout[k-1].button[1].x + self.panel_layout[k-1].button[1].width + math.abs(self.panel_layout[k-1].button[1].offset.left)+math.abs(self.panel_layout[k-1].button[1].offset.right)) >= self.points[5].x+self.panel_width then       
                    button_init.position.x = (self.panel_layout[k-2].button[1].x) - self.panel_layout[k-2].button[1].offset.left
                    button_init.position.y = (self.panel_layout[k-2].button[1].y) + y_list - self.panel_layout[k-2].button[1].offset.top
                else
                    button_init.position.x = self.panel_layout[k-1].button[1].x - self.panel_layout[k-1].button[1].offset.left + x_list
                    button_init.position.y = self.panel_layout[k-1].button[1].y - self.panel_layout[k-1].button[1].offset.top
                end
            else 
                if (self.panel_layout[k-1].button[1].y + self.panel_layout[k-1].button[1].height+ self.panel_layout[k-1].button[1].offset.top+self.panel_layout[k-1].button[1].offset.bottom) >= self.points[5].y+self.panel_height then
                    button_init.position.x = (self.panel_layout[k-2].button[1].x) + x_list - self.panel_layout[k-2].button[1].offset.left
                    button_init.position.y = (self.panel_layout[k-2].button[1].y) - self.panel_layout[k-2].button[1].offset.top
                else
                    button_init.position.x = self.panel_layout[k-1].button[1].x - self.panel_layout[k-1].button[1].offset.left
                    button_init.position.y = self.panel_layout[k-1].button[1].y - self.panel_layout[k-1].button[1].offset.top + y_list
                end
            end
        else
            button_init.position.x = (self.points[5].x)
            button_init.position.y = (self.points[5].y)
        end

        button_init.button_number = button_number
        button_init.button_id = button_number
        button_init.metadata.name = self.menu_name

        button_number = button_number + 1  
        table.insert(layout.button ,Button(button_init))
        if self.debug then self:buttonPosition(k,button_init) end       
    end
end

function Panel:update(dt)
    Graphics.update(self,dt)

    if self.panel_state then
        for k,layout in pairs(self.panel_layout) do
            layout.button[1]:update(dt)
        end            
    end
end

function Panel:resetButton()
    -- for k,layout in pairs(self.panel_layout) do
    --     layout.button[1].button_selected = false
    --     layout.button[1].button_state = false
    -- end
end

function Panel:addButton()

end


function Panel:organizeButtons_Panel(button1, button2)
    local new_button = button1.graphics_defs
    button1.graphics_defs = button2.graphics_defs
    button2.graphics_defs = new_button
    button1:organizeButtons_Button(button1.graphics_defs)
    button2:organizeButtons_Button(button2.graphics_defs)
end

function Panel:render()
    if self.panel_state then
        Graphics.renderFrame(self)
        -- Graphics.renderPoints(self)
        for k,layout in pairs(self.panel_layout) do
            layout.button[1]:render()
        end   
    end
end

function Panel:panelLayout()
    print('\n','PANEL DEBUG ----------------------------------------------------')
    -- print('PANEL ORDER: ',self.panel_order)
    print('LAYOUT PRIORITY: ',self.layout.priority)
    -- print('LAYOUT NUMBER OF ROWS: ',#self.layout.rows)
    -- print('LAYOUT NUMBER OF COLS: ',#self.layout.cols)
end

function Panel:buttonPosition(k,button)
    print('\n','BUTTON POSITION DEBUG ----------------------------------------------------')
    print('NEW LOOP ',k,' --------------------------------------------')
    print('PANEL HEIGHT: '..self.panel_height)
    print('PANEL WIDTH: '..self.panel_width)
    print('BUTTON '..k..' OFFSET X: '..button.position.offsets.left)
    print('BUTTON '..k..' OFFSET Y: '..button.position.offsets.top)
    print('BUTTON: '..k,'X: '..button.position.x)
    print('BUTTON: '..k,'y: '..button.position.y)
    print('BUTTON: '..k,'WIDTH: '..button.size.width)
    print('BUTTON: '..k,'HEIGHT: '..button.size.height)
end