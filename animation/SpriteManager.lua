
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


Tree = Class{}

function Tree:init(def)

    -- Spritesheet parameters
    self.atlas = atlas
    self.w = width
    self.h = height
    -- Drawing parameters
    self.x = x
    self.y = y
    self.rotation = r
    self.scalex = sx
    self.scaley = sy
    self.offsetx = ox
    self.offsety = oy
    -- Animate parameters
    self.animations = {}

end


function Tree:createAnimation(animation_name)
    self.animations[animation_name] = animation
end

function Tree:changeAnimation(animation_name)
    local currentAnimation = self.animations
    if animation_name != currentAnimation then
        self.animations[animation_name] = animation_name
    end
end

function Tree:update()

end

function Tree:render()
    love.graphics.draw(self.atlas,self.animations,self.x,self.y,self.angle,self.scalex,self.scaley,self.offsetx,self.offsety)
end

