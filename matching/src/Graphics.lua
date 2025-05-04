

Graphics = Class{}


function Graphics:init(def)
    self.menu = Menu(def.menu)

    self.graphics = {}
    self.graphics.shape = def.graphics_value['graphics']['shape']
    self.graphics.render_type = def.graphics_value['graphics']['render_type']
    self.graphics.rgb = def.graphics_value['graphics']['rgb']
    self.graphics.image = def.graphics_value['graphics']['image']
    self.position = def.graphics_value['anchor']['dimensions']
    self.anchor = def.graphics_value['anchor']

    -- MENU RENDERING DIMS
    self.scale = self:scaleXY()

    self:position_calc()

    if self.menu.render_type == 'frame' then 
        self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.top.sh 
    elseif self.menu.render_type == 'image' then
        self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.sh
    else
        self.y = self.menu.points[5].y - self.anchor.anchor_y * self.scale.top.sh
    end

    graphic_anim = Animation{frames = {1, 2, 3},interval = 0.4}


end

function Graphics:positionGraphics(dimensions)

    x= dimensions.x + self.frame_render.top.sw - self.scale.top.sw * 22
    y= dimensions.y + self.frame_render.top.sh - self.scale.top.sh * 4  

    love.graphics.draw(spritesheet3,self.graphics.image,x,y,self.rotation,self.frame_render.top.sw,self.frame_render.top.sh)
    
end

function Graphics:scaleXY()
    local scale_table = {}
    if self.menu.render_type == 'image' then
        local sw,sh = select(3,self.graphics.image[1]:getViewport()),select(4,self.graphics.image[1]:getViewport())
        scale_table.sw,scale_table.sh = (self.menu.width/sw)*22/22,(self.menu.height/sh)*(4/24)
        scale_table.top = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.bottom = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.left = {sw = scale_table.sw,sh = scale_table.sh}
        scale_table.right = {sw = scale_table.sw,sh = scale_table.sh}
    elseif self.menu.render_type == 'frame' then
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.menu.width/select(3,self.menu.frame.images['top']:getViewport()), sh = self.menu.frame.dimensions.height/select(4,self.menu.frame.images['top']:getViewport())}
        scale_table.bottom = {sw = self.menu.width/select(3,self.menu.frame.images['bottom']:getViewport()),sh = self.menu.frame.dimensions.height/select(4,self.menu.frame.images['bottom']:getViewport())}
        scale_table.left = {sw = self.menu.frame.dimensions.width/select(3,self.menu.frame.images['left']:getViewport()),sh = self.menu.height/select(4,self.menu.frame.images['left']:getViewport())}
        scale_table.right = {sw = self.menu.frame.dimensions.width/select(3,self.menu.frame.images['right']:getViewport()),sh = self.menu.height/select(4,self.menu.frame.images['right']:getViewport())} 
    else
        local sw,sh = select(3,self.graphics.image[1]:getViewport()),select(4,self.graphics.image[1]:getViewport())
        scale_table.sw,scale_table.sh = 1,1
        scale_table.top = {sw = self.menu.width/sw, sh = self.menu.frame.dimensions.height/(sh-2)}
        scale_table.bottom = {sw = self.menu.width, sh = self.menu.frame.dimensions.height}
        scale_table.left = {sw = self.menu.frame.dimensions.width, sh = self.height}
        scale_table.right = {sw = self.menu.frame.dimensions.width, sh = self.height}

    end
    return scale_table
end


function Graphics:position_calc()

    points = self.menu.points

    -- print(points[5].x)

end


function Graphics:update(dt)
    graphic_anim:update(dt)
end


function Graphics:render()

    self.menu:render()



    love.graphics.draw(
        spritesheet3,self.graphics.image[graphic_anim:getFrame()]
        ,self.menu.points[1].x
        ,self.y
        ,0
        ,self.scale.top.sw
        ,self.scale.top.sh
    )
    
    -- self.menu:render()

end