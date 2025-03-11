

Panel = Class{}

function Panel:init(def)

    self.theme = def.theme or 0
    self.shape = def.theme or 0
    self.width = def.width or 90
    self.height = def.height or 90
    self.radius = def.theme or 0
    self.x = def.x or 5
    self.y = def.y or 5
    self.rotation = def.rotation or 0
    self.scale_x = def.scale_x or 0
    self.scale_y = def.scale_y or 0
    self.offset_x = def.offset_x or 0
    self.offset_y = def.offset_y or 0
    self.r,self.g,self.b = def.r,def.g,def.b

    self.panel_id = def.panel_id
    self.panel_number = def.panel_number

    self.number_buttons = 0
    
    self.panel_row_number = def.panel_row_number
    self.panel_col_number = def.panel_col_number

    print('Number of rows: '..def.panel_row_number)
    print('Number of cols: '..def.panel_col_number)

    self.panel_state = false
    self.panel_layout = self:layoutInit(def)

   print()


end

function Panel:layoutInit(def)

    x_usable_space = def.width - ((1+def.panel_col_number)*5)
    button_length = x_usable_space/def.panel_col_number
    y_usable_space = def.height - ((1+def.panel_row_number)*5)
    button_height = y_usable_space/def.panel_row_number

    print(def.width)
    print(def.height)
    print('base x:' .. self.x)
    print('usable x space:' .. x_usable_space)
    print('button_length:' .. button_length)
    print('usable y space:' .. y_usable_space)
    print('button_height:' .. button_height)

    panel_layout={}
    print(def.panel_row_number)
    button_number = 1
    for i = 1, def.panel_row_number, 1 do
        panel_layout[i] = {}
        -- print(i)
        for j = 1, def.panel_col_number,1 do
            -- print(j)
            panel_layout[i][j] = Button({x = (self.x+(5*j))+(button_length * (j-1)),
                                        y = (self.y+(5*i))+(button_height * (i-1)),
                                    width = button_length,
                                    height = button_height,
                                    scale_x = self.scale_x,
                                    scale_y = self.scale_y,
                                    button_number = button_number})
            button_number = button_number + 1

            print('Button '..i*j .. ' location - '..'x:' ..(self.x+(5*j))+(button_length*(j-1))..' y:' ..(self.y+(5*i))+(button_height*(i-1)))

            
        end
    end
    return(panel_layout)
end

function Panel:update()
    for i = 1, self.panel_row_number, 1 do
        for j = 1, self.panel_col_number,1 do
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
        love.graphics.setColor(self.r,self.g,self.b)
        love.graphics.rectangle('fill',self.x,self.y,self.width*self.scale_x,self.height*self.scale_y)
        love.graphics.reset()

        
        for i = 1, self.panel_row_number, 1 do
            -- print(self.panel_row_number)
            for j = 1, self.panel_col_number,1 do
                -- print(j)
                self.panel_layout[i][j]:render()
            end
        end
        love.graphics.setColor(0,0,0)
        love.graphics.printf('This is Panel:' .. tostring(self.panel_number),self.x,self.y,WINDOW_WIDTH)
        love.graphics.reset()
    end
end