
Class = require 'class'

WINDOW_HEIGHT = 800
WINDOW_WIDTH = 800

BOX_SIZE = 100
x = WINDOW_WIDTH-BOX_SIZE
y = 0
dy = 0
GRAVITY = 15
PLAYER_MOV = 200
SKIER_MOV = 100

py = WINDOW_HEIGHT/2
px = WINDOW_WIDTH/2

pscore = 0

skierx = 0
skiery = 200


function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false
    })


    spritesheet = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png')
    gFrames = {
        ['yeti'] = {
            love.graphics.newQuad(10,52,33,41,spritesheet:getDimensions()),
        love.graphics.newQuad(44,50,29,43,spritesheet:getDimensions()),
        love.graphics.newQuad(74,49,26,44,spritesheet:getDimensions()),
        love.graphics.newQuad(101,54,31,39,spritesheet:getDimensions()),
        love.graphics.newQuad(133,51,33,42,spritesheet:getDimensions()),
        love.graphics.newQuad(167,51,30,42,spritesheet:getDimensions()),
        love.graphics.newQuad(198,51,30,42,spritesheet:getDimensions()),
        love.graphics.newQuad(229,51,24,42,spritesheet:getDimensions()),
        love.graphics.newQuad(254,55,27,38,spritesheet:getDimensions()),
        love.graphics.newQuad(282,55,27,38,spritesheet:getDimensions())},

        ['skier']={love.graphics.newQuad(10,12,23,27,spritesheet:getDimensions()),
        love.graphics.newQuad(34,10,23,29,spritesheet:getDimensions()),
        love.graphics.newQuad(58,7,17,32,spritesheet:getDimensions())}
        
    }

    eatingYeti = Animation{
        frames = {5,6,7,8,9,10},
        interval =0.2
    }

    idleYeti = Animation{
        frames = {1,2},
        interval = 0.2
    }
    runningYeti = Animation{
        frames = {3,4},
        interval = 0.2
    }

    yetiAnim = idleYeti



end

function love.keypressed(key)

    if key=='escape' then
        love.event.quit()
    end

    if key == 'space' then
        proj = true
        projx = px
        projy = py

    end
    

end

function love.update(dt)

    yetiAnim:update(dt)

    py = py
    px = px


    if y<= 0 then
        dy = GRAVITY
    elseif y>= WINDOW_HEIGHT-BOX_SIZE then
        dy = -GRAVITY
    end

    y = y+dy

    if love.keyboard.isDown('down') then
        py = py + PLAYER_MOV
        yetiAnim = runningYeti
    elseif love.keyboard.isDown('up') then
        py = py - PLAYER_MOV
        yetiAnim = runningYeti
    elseif love.keyboard.isDown('left') then
        px = px - PLAYER_MOV
        yetiAnim = runningYeti
        left_direction  = true
    elseif love.keyboard.isDown('right') then
        px = px + PLAYER_MOV
        yetiAnim = runningYeti
        left_direction = false
    else    
        yetiAnim = idleYeti
    end

    if py >= y and py <= y+BOX_SIZE then
        if px >= x and px <= x+BOX_SIZE then
            px = 10
            py = 10
        end
    end

    if proj == true then
        projx = projx +GRAVITY
    else
        projx = px
        projy = py
    end

    if projx >= WINDOW_WIDTH then
        if px > WINDOW_WIDTH/2 then
            pscore = pscore + 1
        else
            pscore = pscore + 2
        end
        projx = px
        projy = py
        proj = false
    end

    if projy >= y and projy <= y+BOX_SIZE then
        if projx >= x and projx <= x+BOX_SIZE then
            if px > WINDOW_WIDTH/2 then
                pscore = pscore - 2
            else
                pscore = pscore - 1
            end
            proj = false
        end
    end

    if skiery+50 >= py and skiery <= py+50 then
        if skierx+50 >= px and skierx <= px+50 then
            skierx = skierx
            yetiAnim = eatingYeti
        end
    else
        skierx = skierx + PLAYER_MOV
    end



end

function love.draw()

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill',x,y,BOX_SIZE,BOX_SIZE)
    love.graphics.rectangle('fill',projx,projy,5,10)
    love.graphics.line(WINDOW_WIDTH/2,0,WINDOW_WIDTH/2,WINDOW_HEIGHT)
    love.graphics.printf('Score: ' ..tostring(pscore),0,0,WINDOW_WIDTH)
    love.graphics.printf('2pt Area',WINDOW_WIDTH/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)
    love.graphics.printf('1pt Area',WINDOW_WIDTH*3/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)

    -- love.graphics.rectangle('line',px,py,50,50)
    -- love.graphics.rectangle('line',skierx,skiery,50,50)
    love.graphics.reset()

    love.graphics.draw(spritesheet,gFrames['skier'][1],skierx,skiery,0,2,2)


    -- for i in pairs(skier_table) do
    --     love.graphics.draw(spritesheet,gFrames['skier'][1],skierx,skiery,0,2,2)
    -- end

    love.graphics.draw(spritesheet,gFrames['yeti'][yetiAnim:getFrame()],px,py,0,left_direction == true and -2 or 2,2)
    -- love.graphics.draw()


Animation = Class{}

function Animation:init(def)

    self.frames = def.frames
    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1

end

function Animation:update(dt)

    if #self.frames > 1 then
        self.timer = self.timer +dt
        if self.timer > self.interval then
            self.timer = self.timer % self.interval
            self.currentFrame = math.max(1, (self.currentFrame+1) % (#self.frames+1))
        end
    end
end

function Animation:getFrame()
    return self.frames[self.currentFrame]
end
