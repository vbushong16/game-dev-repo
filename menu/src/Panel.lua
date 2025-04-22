
-- def = 

-- position = {x = self.x+self.frame_width, y = self.y+self.frame_height},
-- size = { width = self.width-self.frame_width, height = self.height-self.frame_height},
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


    -- PANEL GRAPHICS INIT
    self.render_type = def['components']['graphics']['render_type']
    self.rgb = def['components']['graphics']['rgb']
    self.image = def['components']['graphics']['image']
    self.shape = def['components']['graphics']['shape']
    self.frame = {}
    self.frame.images = def['components']['frame']['image']
    self.frame.dimensions = def['components']['frame']['dimensions']
    self.frame.rgb = def['components']['frame']['rgb']
    self.layout = def['components']['layout']

    -- PANEL POSITION INIT
    self.x = def['position']['x']
    self.y = def['position']['y']
    self.rotation = def.rotation or 0
    self.offset = def['components']['position']['offsets']
    
    -- PANEL SIZE INIT
    if self.shape == 'rectangle' then
        self.width = def['size']['width']
        self.height = def['size']['height']
    elseif self.shape == 'circle' then
        self.radius = def['size']['radius']
    end 

    -- PANEL RENDERING DIMS
    -- self.scale = def['scale']
    self.scale = self:scaleXY()
    self.frame_render = self:frameRender()
    self.frame_width = self.frame.dimensions.width * self.scale.sw
    self.frame_height = self.frame.dimensions.height * self.scale.sh

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

-- ,self.x + self.offset.offset_x
-- ,self.y + self.offset.offset_y
-- ,self.width - 2*self.offset.offset_x
-- ,self.height - 2*self.offset.offset_y)


function Panel:frameRender()

    local frame_table = {}
    frame_table.top = {
        x = self.x + self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.top.sw
        ,sh = self.scale.top.sh
    }
    frame_table.bottom = {
        x = self.x + self.offset.offset_x
        ,y =self.y+self.height-self.frame.dimensions.height - self.offset.offset_y
        ,sw = self.scale.bottom.sw
        ,sh = self.scale.bottom.sh
    }
    frame_table.left = {
        x = self.x + self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.left.sw
        ,sh = self.scale.left.sh
    }
    frame_table.right = {
        x = self.x + self.width - self.frame.dimensions.width - self.offset.offset_x
        ,y = self.y + self.offset.offset_y
        ,sw = self.scale.right.sw
        ,sh = self.scale.right.sh
    }
    return frame_table
end

function Panel:scaleXY()
    local scale_table = {}
    if self.render_type == 'image' then
        local sw,sh = select(3,self.image:getViewport()),select(4,self.image:getViewport())
        scale_table.sw,scale_table.sh = (self.width-2*self.offset.offset_x)/sw,(self.height-2*self.offset.offset_y)/sh
        scale_table.top = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.bottom = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.left = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.right = {sw = scale_table.sw,sh = scale_table.sh}
    elseif self.render_type == 'frame' then
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = (self.width-2*self.offset.offset_x)/select(3,self.frame.images['top']:getViewport()), sh = self.frame.dimensions.height/select(4,self.frame.images['top']:getViewport())}
        scale_table.bottom = {sw = (self.width-2*self.offset.offset_x)/select(3,self.frame.images['bottom']:getViewport()),sh = self.frame.dimensions.height/select(4,self.frame.images['bottom']:getViewport())}
        scale_table.left = {sw = self.frame.dimensions.width/select(3,self.frame.images['left']:getViewport()),sh = (self.height-2*self.offset.offset_y)/select(4,self.frame.images['left']:getViewport())}
        scale_table.right = {sw = self.frame.dimensions.width/select(3,self.frame.images['right']:getViewport()),sh = (self.height-2*self.offset.offset_y)/select(4,self.frame.images['right']:getViewport())} 
        -- print('THIS IS THE EDGE SCALE TOP: ', scale_table.top.sw ,' & ', scale_table.top.sh)
        -- print('THIS IS THE EDGE SCALE BOT: ', scale_table.bottom.sw ,' & ', scale_table.bottom.sh)
        -- print('THIS IS THE EDGE SCALE LEFT: ', scale_table.left.sw ,' & ', scale_table.left.sh)
        -- print('THIS IS THE EDGE SCALE RIGHT: ', scale_table.right.sw ,' & ', scale_table.right.sh)
    else
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.width-2*self.offset.offset_x, sh = self.frame.dimensions.height}
        scale_table.bottom = {sw = self.width-2*self.offset.offset_x, sh = self.frame.dimensions.height}
        scale_table.left = {sw = self.frame.dimensions.width, sh = self.height-2*self.offset.offset_y}
        scale_table.right = {sw = self.frame.dimensions.width, sh = self.height-2*self.offset.offset_y}

    end
    return scale_table
end

function Panel:buttonDim(length,frame_dim,offset,layout)
    spacing = length-(offset*2)-((1+layout)*frame_dim)
    return spacing/layout
end


function Panel:layoutInit()

    -- local x_usable_space = self.width-2*self.offset.offset_x - ((1+self.layout.cols)*self.frame.dimensions.width)
    -- local y_usable_space = self.height-2*self.offset.offset_y - ((1+self.layout.rows)*self.frame.dimensions.height)

    local button_width = self:buttonDim(self.width,self.frame_width,self.offset.offset_x,self.layout.cols)
    local button_height = self:buttonDim(self.height,self.frame_height,self.offset.offset_y,self.layout.rows)

    
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

            button_init.position.x = (self.x+self.offset.offset_x +(self.frame_width*j))+(button_width * (j-1))
            button_init.position.y = (self.y+self.offset.offset_y +(self.frame_height*i))+(button_height * (i-1))
            button_init.button_number = button_number
            button_init.button_id = button_number
            for k, button in pairs(self.button_interface) do
                if button.button_number == button_number then
                    button_init.components = button
                    break
                end
            end 

            panel_layout[i][j] = Button(button_init)
            -- panel_layout[i][j] = {x = (self.x+self.offset.offset_x +(self.frame_width*j))+(button_width * (j-1)),
            --                     y = (self.y+self.offset.offset_y +(self.frame_height*i))+(button_height * (i-1)),
            --                     width = button_width,
            --                     height = button_height,
            --                     button_number = button_number}

            -- button_number = button_number + 1

            -- print('Button '..i*j .. ' location - '..'x:' ..(self.x+(5*j))+(button_width*(j-1))..' y:' ..(self.y+(5*i))+(button_height*(i-1)))

            
        end
    end
    return panel_layout
end

function Panel:update()
    for i = 1, self.layout.rows, 1 do
        for j = 1, self.layout.cols,1 do
            -- self.panel_layout[i][j]:update(dt)
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
        if self.render_type == 'image' then
            love.graphics.draw(spritesheet,self.image,self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.rotation,self.scale.sw,self.scale.sh)
            -- love.graphics.setFilter("nearest", "nearest")
        elseif self.render_type == 'frame' then
            love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
            love.graphics.rectangle('fill',self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.width-2*self.offset.offset_x,self.height-2*self.offset.offset_y)
            love.graphics.reset()
            -- print('PANEL TOP FRAME: ',self.frame_render.top.sw)
            love.graphics.draw(spritesheet,self.frame.images['top'],self.frame_render.top.x,self.frame_render.top.y,self.rotation,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
            love.graphics.draw(spritesheet,self.frame.images['bottom'],self.frame_render.bottom.x,self.frame_render.bottom.y,self.rotation,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
            love.graphics.draw(spritesheet,self.frame.images['left'],self.frame_render.left.x,self.frame_render.left.y,self.rotation,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
            love.graphics.draw(spritesheet,self.frame.images['right'],self.frame_render.right.x,self.frame_render.right.y,self.rotation,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
        elseif self.render_type == 'rgb' then
            love.graphics.setColor(self.rgb.r,self.rgb.g,self.rgb.b)
            love.graphics.rectangle('fill',self.x+self.offset.offset_x,self.y+self.offset.offset_y,self.width-2*self.offset.offset_x,self.height-2*self.offset.offset_y)
            love.graphics.reset()
            love.graphics.setColor(self.frame.rgb.r,self.frame.rgb.g,self.frame.rgb.b)
            love.graphics.rectangle('fill',self.frame_render.top.x,self.frame_render.top.y,self.frame_render.top.sw,self.frame_render.top.sh) --TOP
            love.graphics.rectangle('fill',self.frame_render.bottom.x,self.frame_render.bottom.y,self.frame_render.bottom.sw,self.frame_render.bottom.sh) --BOTTOM
            love.graphics.rectangle('fill',self.frame_render.left.x,self.frame_render.left.y,self.frame_render.left.sw,self.frame_render.left.sh) --LEFT
            love.graphics.rectangle('fill',self.frame_render.right.x,self.frame_render.right.y,self.frame_render.right.sw,self.frame_render.right.sh) --RIGHT
            love.graphics.reset()
        end

        
        for i = 1, self.layout.rows, 1 do
            -- print(self.panel_row_number)
            for j = 1, self.layout.cols,1 do
                -- print(j)
                self.panel_layout[i][j]:render()
                -- love.graphics.setColor(1,1,1)
                -- love.graphics.rectangle(mode,x,y,width,height)
                -- love.graphics.rectangle('fill'
                -- ,self.panel_layout[i][j].x
                -- ,self.panel_layout[i][j].y
                -- ,self.panel_layout[i][j].width
                -- ,self.panel_layout[i][j].height)
                -- love.graphics.reset()

            end
        end
        love.graphics.setColor(0,0,0)
        love.graphics.printf('This is Panel:' .. tostring(self.panel_number)
        ,self.x + self.offset.offset_x
        ,self.y + self.offset.offset_y,WINDOW_WIDTH)
        love.graphics.reset()
    end
end