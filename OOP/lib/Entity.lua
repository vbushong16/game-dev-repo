
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


Entity = Class{}

function Entity:init(def)

    self.atlas = def.atlas
    self.texture = def.texture
    self.x = def.x or 0
    self.y = def.y or 0 
    self.animations = {}
    self.currentAnimation = ""
    self.entity_animations = ENTITY_DEFS[self.texture].anims
    self.angle = ENTITY_DEFS[self.texture].r
    self.scalex = ENTITY_DEFS[self.texture].scalex
    self.scaley = ENTITY_DEFS[self.texture].scaley
    self.offsetx = select(3,gFrames[self.texture][1]:getViewport())/2
    self.offsety = select(4,gFrames[self.texture][1]:getViewport())/2
 
end

function Entity:createAnimation(animation_name)
    self.animations[animation_name] = Animation{frames = self.entity_animations[animation_name].frames,
                                                interval = self.entity_animations[animation_name].interval
                                            }
end

function Entity:changeAnimation(animation_name)
    if animation_name ~= self.currentAnimation then
        self.currentAnimation = animation_name
    end
end

function Entity:update(dt)
    self.animations[self.currentAnimation]:update(dt)
end

function Entity:render()
    love.graphics.draw(self.atlas,gFrames[self.texture][self.animations[self.currentAnimation]:getFrame()]
    ,self.x,self.y,
    self.angle,self.scalex,self.scaley,self.offsetx,self.offsety
    )
end

