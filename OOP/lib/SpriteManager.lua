


-- Class goals:
-- 1. Draw the sprite to the window

-- 1. pull SpriteManager object to return Sprite information
-- 2. Draw the sprite to the window
    -- Entity X,Y and State
    -- Rotation, Scale, Offset
-- 3. Cycle through animation
    -- frames_per_seconds
    -- Call Animation function
    -- Return specific frames


SpriteManager = Class{}

function SpriteManager:init(atlas,x,y,r,sx,sy,ox,oy)
    -- Spritesheet parameters
    self.atlas = atlas
    self.x = x or 0
    self.y = y or 0
    self.r = r or 0
    self.sx = sx or 1
    self.sy = sy or 1
    self.ox = ox or 0
    self.oy = oy or 0
    self.current_animation = ""
    self.animations = {}
end

function SpriteManager:render(c_anim,anim,x,y,r,sx,sy,ox,oy)

    if x ~= nil then
        self.x = x
    end
    if y ~= nil then
        self.y = y
    end
    if r ~= nil then
        self.r = r
        end
    if sx ~= nil then
        self.sx = sx
    end
    if sy ~= nil then
        self.sy = sy
    end
    if ox ~= nil then
        self.ox = ox
    end
    if oy ~= nil then
        self.oy = oy
    end

    love.graphics.draw(self.atlas,gFrames[c_anim][anim[c_anim]:getFrame()]
    ,self.x,self.y,self.r,self.sx,self.sy,self.ox,self.oy)

end