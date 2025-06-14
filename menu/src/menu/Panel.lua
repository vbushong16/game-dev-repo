Panel = Class{__includes = Graphics}

function Panel:init(def)

    Graphics.init(self,def)
    -- PANEL DEBUG

    -- if self.debug then self:panelDebug() end
    -- if self.debug then self:PositionDebug() end
    
    -- PANEL SET UP 
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
            -- print('PANEL LAYOUT: ',priority..' '..self.panel_layout[k].priority.dim,secondary..' '..self.panel_layout[k].non_priority.dim)
            k = k + 1
        end
    end
    
    self.panel_width = self.points[6].x - self.points[5].x
    self.panel_height = self.points[7].y-self.points[5].y
    self:layoutInit()
end

function Panel:buttonDim(length,offset,divider,layout)
    local spacing = ((length/layout)/divider) -- offset
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

        if priority == 'rows' then
            button_width = self:buttonDim(self.panel_width,off_x,layout.non_priority.p,layout.non_priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.priority.p,layout.priority.dim)
            x_list = self.panel_width / layout.non_priority.p
            y_list = self.panel_height / layout.priority.dim  
        else
            button_width = self:buttonDim(self.panel_width,off_x,layout.priority.p,layout.priority.dim)
            button_height = self:buttonDim(self.panel_height,off_y,layout.non_priority.p,layout.non_priority.dim)
            x_list = self.panel_width / layout.priority.dim
            y_list = self.panel_height / layout.non_priority.p
        end
        button_init.size = {width = button_width,height = button_height}

        layout.button = {}



        -- self.points[5].x,self.points[5].y
        -- self.points[5].x + x_list, self.points[5].y
        -- if too big then
        -- self.points[5].x, self.points[5].y + y_list         
        -- self.points[5].x + x_list, self.points[5].y + y_list
    

        if k>1 then
            if self.layout.priority == 'cols' then
                if (self.panel_layout[k-1].button[1].x + self.panel_layout[k-1].button[1].width) >= self.panel_width then
                    button_init.position.x = (self.points[5].x)
                    button_init.position.y = (self.points[5].y) - self.panel_layout[k-1].button[1].offset.top + y_list
                else
                    button_init.position.x = self.panel_layout[k-1].button[1].x - self.panel_layout[k-1].button[1].offset.left + x_list
                    button_init.position.y = self.panel_layout[k-1].button[1].y - self.panel_layout[k-1].button[1].offset.top
                end
            else 
                if (self.panel_layout[k-1].button[1].y + self.panel_layout[k-1].button[1].height) >= self.panel_height then
                    button_init.position.x = (self.points[5].x) - self.panel_layout[k-1].button[1].offset.left + x_list
                    button_init.position.y = (self.points[5].y)
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





        -- if self.debug then self:buttonPosition(k,layout,button_init) end
        
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
        -- love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
        -- love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
        -- love.graphics.reset()

        Graphics.renderFrame(self)
        
        for k,layout in pairs(self.panel_layout) do
            layout.button[1]:render()
        end   

        -- for i, point in ipairs(self.points) do
        --     love.graphics.setColor(0,1,1)
        --     love.graphics.circle('fill',point.x,point.y,10)
        --     love.graphics.reset()
        -- end

        love.graphics.setColor(0,0,0)
        love.graphics.printf('This is Panel:' .. tostring(self.panel_number)
        ,self.x + self.offset.left+ self.offset.right
        ,self.y + self.offset.top+ self.offset.bottom,WINDOW_WIDTH)
        love.graphics.reset()
    end
end