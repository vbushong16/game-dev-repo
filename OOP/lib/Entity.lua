
-- Class goals:
-- 1. Load the GameObject data
-- 2. Cycle through the animation
-- 3. Change the GameObject sprite to new state

-- 1. pull SpriteManager object to return Sprite information


Entity = Class{}

function Entity:init(atlas,x,y)

    self.atlas = atlas
    -- self.world = def.world
    self.x = x or 0
    self.y = y or 0
    -- self.r = def.r or 0
    -- self.sx = def.sx or 0
    -- self.sy = def.sy or 0
    -- self.ox = def.ox or 0
    -- self.oy = def.oy or 0
    self.entity_render = SpriteManager(self.atlas,self.x,self.y)
    self.current_animation = ""
    self.animations = {}

end

function Entity:createAnimation(animation_name,frames,interval)
    if self.animations[animation_name] == nil and self.current_animation ~= animation_name then
        -- print(#frames)
        self.animations[animation_name] = Animation{frames = frames,interval = interval}
        self.current_animation = animation_name
        self.frames = frames
        self.interval = interval
    end
    return self.current_animation
end

function Entity:changeAnimation(new_animation,frames,interval)
    local current_animation = self.current_animation
    if new_animation ~= current_animation then
        self.animations[new_animation] = Animation{frames = frames,interval = interval}
        self.current_animation = new_animation
    end
    return self.current_animation
end

function Entity:update(dt)
    self.animations[self.current_animation]:update(dt)
end

function Entity:render()
    self.entity_render:render(self.current_animation,self.animations)    
end
