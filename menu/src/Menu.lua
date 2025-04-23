

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

    -- MENU POSITION INIT
    self.x = def['position']['x']
    self.y = def['position']['y']
    self.rotation = def.rotation or 0
    
    -- MENU SIZE INIT
    if self.shape == 'rectangle' then
        self.width = def['size']['width']
        self.height = def['size']['height']
    elseif self.shape == 'circle' then
        self.radius = def['size']['radius']
    end 

    -- MENU RENDERING DIMS
    self.scale = self:scaleXY()
    self.frame_render = self:frameRender()
    self.frame_width = self.frame.dimensions.width * self.scale.sw
    self.frame_height = self.frame.dimensions.height * self.scale.sh

    -- MENU LOGIC INIT0
    self.menu_state = false

    self.panels = {}
    self.panels_to_build = def['components']['number_of_panels']
    self.panel_init = {
        position = {x = self.x+self.frame_width, y = self.y+self.frame_height},
        size = { width = self.width-self.frame_width*2, height = self.height-self.frame_height*2},
        -- scale = self.scale,
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



function Menu:frameRender()

    local frame_table = {}
    frame_table.top = {
        x = self.x
        ,y = self.y
        ,sw = self.scale.top.sw
        ,sh = self.scale.top.sh
    }
    frame_table.bottom = {
        x = self.x
        ,y =self.y+self.height-self.frame.dimensions.height
        ,sw = self.scale.bottom.sw
        ,sh = self.scale.bottom.sh
    }
    frame_table.left = {
        x = self.x
        ,y = self.y
        ,sw = self.scale.left.sw
        ,sh = self.scale.left.sh
    }
    frame_table.right = {
        x = self.x + self.width - self.frame.dimensions.width
        ,y = self.y
        ,sw = self.scale.right.sw
        ,sh = self.scale.right.sh
    }
    return frame_table
end

function Menu:scaleXY()
    local scale_table = {}
    if self.render_type == 'image' then
        local sw,sh = select(3,self.image:getViewport()),select(4,self.image:getViewport())
        scale_table.sw,scale_table.sh = self.width/sw,self.height/sh
        scale_table.top = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.bottom = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.left = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.right = {sw = scale_table.sw,sh = scale_table.sh}
    elseif self.render_type == 'frame' then
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.width/select(3,self.frame.images['top']:getViewport()), sh = self.frame.dimensions.height/select(4,self.frame.images['top']:getViewport())}
        scale_table.bottom = {sw = self.width/select(3,self.frame.images['bottom']:getViewport()),sh = self.frame.dimensions.height/select(4,self.frame.images['bottom']:getViewport())}
        scale_table.left = {sw = self.frame.dimensions.width/select(3,self.frame.images['left']:getViewport()),sh = self.height/select(4,self.frame.images['left']:getViewport())}
        scale_table.right = {sw = self.frame.dimensions.width/select(3,self.frame.images['right']:getViewport()),sh = self.height/select(4,self.frame.images['right']:getViewport())} 
        -- print('THIS IS THE EDGE SCALE TOP: ', scale_table.top.sw ,' & ', scale_table.top.sh)
        -- print('THIS IS THE EDGE SCALE BOT: ', scale_table.bottom.sw ,' & ', scale_table.bottom.sh)
        -- print('THIS IS THE EDGE SCALE LEFT: ', scale_table.left.sw ,' & ', scale_table.left.sh)
        -- print('THIS IS THE EDGE SCALE RIGHT: ', scale_table.right.sw ,' & ', scale_table.right.sh)
    else
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.width, sh = self.frame.dimensions.height}
        scale_table.bottom = {sw = self.width, sh = self.frame.dimensions.height}
        scale_table.left = {sw = self.frame.dimensions.width, sh = self.height}
        scale_table.right = {sw = self.frame.dimensions.width, sh = self.height}

    end
    return scale_table
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
            love.graphics.draw(spritesheet,self.frame.images['top'],self.frame_render.top.x,self.frame_render.top.y,self.rotation,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
            love.graphics.draw(spritesheet,self.frame.images['bottom'],self.frame_render.bottom.x,self.frame_render.bottom.y,self.rotation,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
            love.graphics.draw(spritesheet,self.frame.images['left'],self.frame_render.left.x,self.frame_render.left.y,self.rotation,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
            love.graphics.draw(spritesheet,self.frame.images['right'],self.frame_render.right.x,self.frame_render.right.y,self.rotation,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
        elseif self.render_type == 'rgb' then
            love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
            love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
            love.graphics.reset()
            love.graphics.setColor(self.frame.rgb.r,self.frame.rgb.g,self.frame.rgb.b)
            love.graphics.rectangle('fill',self.frame_render.top.x,self.frame_render.top.y,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
            love.graphics.rectangle('fill',self.frame_render.bottom.x,self.frame_render.bottom.y,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
            love.graphics.rectangle('fill',self.frame_render.left.x,self.frame_render.left.y,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
            love.graphics.rectangle('fill',self.frame_render.right.x,self.frame_render.right.y,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
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
