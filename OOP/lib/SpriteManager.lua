


-- Class goals:
-- 1. Load the GameObject data
-- 2. Draw the sprite to the window
-- 3. Cycle through the animation
-- 4. Change the GameObject sprite to new state

-- 1. pull SpriteManager object to return Sprite information
-- 2. Draw the sprite to the window
    -- Entity X,Y and State
    -- Rotation, Scale, Offset
-- 3. Cycle through animation
    -- frames_per_seconds
    -- Call Animation function
    -- Return specific frames


SpriteManager = Class{}

function SpriteManager:init(def)
    -- Spritesheet parameters
    self.atlas = def.atlas
    self.x = def.x or 0
    self.y = def.y or 0
    self.r = 0 or r
    self.sx = 2 or sx
    self.sy = 2 or sy
    self.ox = 0 or ox
    self.oy = 0 or oy
    self.current_animation = ""
    self.animations = {}
    self.frames = 0
    self.interval = 0
end

function SpriteManager:createAnimation(animation_name,frames,interval)
    if self.animations[animation_name] == nil and self.current_animation ~= animation_name then
        -- print(#frames)
        self.animations[animation_name] = Animation{frames = frames,interval = interval}
        self.current_animation = animation_name
        self.frames = frames
        self.interval = interval
    end
    return self.current_animation
end

function SpriteManager:changeAnimation(new_animation,frames,interval)
    local current_animation = self.current_animation
    if new_animation ~= current_animation then
        self.animations[new_animation] = Animation{frames = frames,interval = interval}
        self.current_animation = new_animation
    end
    return self.current_animation
end

function SpriteManager:update(dt)
    -- print(self.current_animation)
    -- print(self.animations[self.current_animation].frames)
    -- print(self.animations[self.current_animation].interval)
    self.animations[self.current_animation]:update(dt)
end

function SpriteManager:render()
    love.graphics.draw(self.atlas,gFrames[self.current_animation][self.animations[self.current_animation]:getFrame()]
    ,self.x,self.y,self.r,self.sx,self.sy,self.ox,self.oy)
end