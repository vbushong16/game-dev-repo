
Class = require 'class'

WINDOW_WIDTH = 300
WINDOW_HEIGHT = 300

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gTextures = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png')
    gFrames = {
        ['skier'] = {love.graphics.newQuad(11,12,21,26,gTextures:getDimensions()),
        love.graphics.newQuad(11,12,21,26,gTextures:getDimensions()),
        love.graphics.newQuad(34,10,23,29,gTextures:getDimensions()),
        love.graphics.newQuad(58,7,17,32,gTextures:getDimensions()),
        love.graphics.newQuad(76,6,16,33,gTextures:getDimensions())},

        ['snowman']= {love.graphics.newQuad(10,52,33,41,gTextures:getDimensions()),
        love.graphics.newQuad(44,50,29,43,gTextures:getDimensions()),
        love.graphics.newQuad(74,49,26,44,gTextures:getDimensions()),
        love.graphics.newQuad(101,54,31,39,gTextures:getDimensions()),

        }
    }

    movingAnimation = Animation {
        frames = {3, 4},
        interval = 0.2
    }

    idleAnimation = Animation {
        frames = {1, 2},
        interval = 0.2
    }

    currentAnimation = idleAnimation
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

    currentAnimation:update(dt)

    if love.keyboard.isDown('down') then
        currentAnimation = movingAnimation
    else
        currentAnimation = idleAnimation
    end
end

function love.draw()


    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    -- love.graphics.draw(gTextures,gFrames['skier'][1],0,0)
    -- love.graphics.draw(gTextures,gFrames['skier'][2],0,20)
    -- love.graphics.draw(gTextures,gFrames['skier'][3],0,40)
    -- love.graphics.draw(gTextures,gFrames['skier'][4],0,60)
    -- love.graphics.draw(gTextures,gFrames['skier'][5],0,80)
    -- love.graphics.draw(gTextures,gFrames['snowman'][1],40,0)
    -- love.graphics.draw(gTextures,gFrames['snowman'][2],40,30)
    -- love.graphics.draw(gTextures,gFrames['snowman'][3],40,60)
    -- love.graphics.draw(gTextures,gFrames['snowman'][4],40,90)
    love.graphics.draw(gTextures,gFrames['snowman'][currentAnimation:getCurrentFrame()],40,90)
    
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)

end



Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)

    if #self.frames > 1 then
        self.timer = self.timer + dt
        if self.timer > self.interval then
            self.timer = self.timer % self.interval
            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end