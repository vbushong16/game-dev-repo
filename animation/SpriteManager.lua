
-- Class goals:
-- 1. Find the sprites from a sprite sheet
-- 2. Draw to the window the sprites
-- 3. Cycle through the animation

-- 1. Sprite sheet metadata
    -- Global information about the sprite sheet
        -- Atlas name and file location
        -- Atlas size rows and columns
    -- individual sprite data
        -- Entity data file
        -- width, heights, frames, frames_per_seconds
-- 2. Draw the sprite to the window
    -- Entity X,Y and State
    -- Rotation, Scale, Offset
-- 3. Cycle through animation
    -- Call Animation function
    -- Return specific frames


SpriteManager = Class{}

function SpriteManager:init(def)

    -- Spritesheet parameters
    self.atlas = def.atlas
    self.w = def.width
    self.h = def.height
    -- Drawing parameters
    self.x = def.x
    self.y = def.y
    self.rotation = def.r
    self.scalex = def.sx
    self.scaley = def.sy
    self.offsetx = def.ox
    self.offsety = def.ox
    -- Animate parameters
    self.animations = {}

end

function SpriteManager:createAtlasMap(self.atlas, self.h, self.w)
    



end

function SpriteManager:createAnimation(animation_name)
    self.animations[animation_name] = animation
end

function SpriteManager:changeAnimation(animation_name)
    local currentAnimation = self.animations
    if animation_name != currentAnimation then
        self.animations[animation_name] = animation_name
    end
end

function SpriteManager:update()

end

function SpriteManager:render()
    love.graphics.draw(self.atlas,self.animations,self.x,self.y,self.angle,self.scalex,self.scaley,self.offsetx,self.offsety)
end

