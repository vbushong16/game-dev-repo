
Class = require 'class'

WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500
BOX_SIZE = 100

x =WINDOW_WIDTH-BOX_SIZE-10
y = 0
counter = 0

GRAVITY = 15
dy = 0
PLAYER_MOV = 500
SKIER_MOV = 5

projectiles = {}

projx =0
projy = 0
py = WINDOW_HEIGHT/2
px = WINDOW_WIDTH/2

skierx = 0
skiery = 100


function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    spritesheet = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png')
    gFrames = {
        ['yeti'] = {love.graphics.newQuad(10,52,33,41,spritesheet:getDimensions()),
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

    

    chasingYeti = Animation{
        frames = {3,4},
        interval = 0.2
    }
    eatingYeti = Animation{
        frames = {5,6,7,8,9,10},
        interval = 0.2
    }

    idleYeti = Animation{
        frames = {1,2},
        interval = 0.2
    }


    yetiAnim = idleYeti

    pscore = 0


    world = love.physics.newWorld(0,0)
    yetiBody = love.physics.newBody(world,px,py,'dynamic')
    yetiShape = love.physics.newRectangleShape(25,30)
    yetiFixture = love.physics.newFixture(yetiBody,yetiShape)


end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then
        --table.insert{projectiles,}
        proj = true
        projx = yetiBody:getX()
        projy = yetiBody:getY()
    end
end


function love.update(dt)

    yetiAnim:update(dt)
    world:update(dt)

    y=y+dy
    py = yetiBody:getY()
    px = yetiBody:getX()
 

    if y <= math.random(0,50) then
        dy = GRAVITY
    elseif y>= math.random(WINDOW_HEIGHT-BOX_SIZE-50, WINDOW_HEIGHT-BOX_SIZE) then
        dy = -GRAVITY
    end


    if love.keyboard.isDown('down') then
        -- py = math.min(WINDOW_HEIGHT,py + PLAYER_MOV)
        yetiBody:setLinearVelocity(0,PLAYER_MOV)
        yetiAnim = chasingYeti
    elseif love.keyboard.isDown('left') then
        yetiBody:setLinearVelocity(-PLAYER_MOV,0)
        yetiAnim = chasingYeti
        left_direction = true
    elseif love.keyboard.isDown('right') then
        yetiBody:setLinearVelocity(PLAYER_MOV,0)
        yetiAnim = chasingYeti
        left_direction = false
    elseif love.keyboard.isDown('up') then
        yetiBody:setLinearVelocity(0,-PLAYER_MOV)
        yetiAnim = chasingYeti
    else
        yetiBody:setLinearVelocity(0,0)
        yetiAnim = idleYeti
    end
    
    if py >= skiery and py <= skiery+BOX_SIZE then
        if px >= skierx and px <= skierx+BOX_SIZE then
            yetiAnim = eatingYeti
            skierx = skierx
        end
    else
        skierx = skierx + SKIER_MOV
    end




    if py >= y and py <= y+BOX_SIZE then
        if px >= x and px <= x+BOX_SIZE then
            py = 10
            px = 10
        end
    end


    if proj == true then
        projx = projx+GRAVITY
    else
        projx = px
        projy = py
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

    if projx >= WINDOW_WIDTH then
        print('SCORE')
        if px > WINDOW_WIDTH/2 then
            pscore = pscore + 1
        else
            pscore = pscore + 2
        end
        proj = false
    end

end


function love.draw()

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.reset()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill',x,y,BOX_SIZE,BOX_SIZE)
    love.graphics.rectangle('fill',projx,projy,5,10)
    love.graphics.line(WINDOW_WIDTH/2,0,WINDOW_WIDTH/2,WINDOW_HEIGHT)
    love.graphics.printf('Score: ' .. tostring(pscore), 0, 0, WINDOW_WIDTH)
    love.graphics.printf('2pt Area ' , WINDOW_WIDTH/4-20 , WINDOW_HEIGHT/2, WINDOW_WIDTH)
    love.graphics.printf('1pt Area ' , WINDOW_WIDTH*3/4-10, WINDOW_HEIGHT/2, WINDOW_WIDTH)
    -- love.graphics.circle('fill',px,py,10)
    love.graphics.rectangle('line',yetiBody:getX(),yetiBody:getY(),10,10)
    love.graphics.reset()


    offsetx_yeti = select(3,gFrames['yeti'][1]:getViewport())/2
    offsety_yeti = select(4,gFrames['yeti'][1]:getViewport())/2

    love.graphics.draw(spritesheet,gFrames['skier'][1],skierx,skiery,0,2,2)
    love.graphics.draw(spritesheet,gFrames['yeti'][yetiAnim:getFrame()],yetiBody:getX(),yetiBody:getY()-offsety_yeti*2,0,left_direction == true and -2 or 2, 2,offsetx_yeti)
 
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)

    love.graphics.setColor( 1, 0, 0, 1 )
    for _, body in pairs(world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
    
            if shape:typeOf("CircleShape") then
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("line", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
    love.graphics.reset( )

    -- love.graphics.printf(text,x,y,limit,align)
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
            self.currentFrame = math.max(1, (self.currentFrame+1)%(#self.frames+1))
        end
    end

end

function Animation:getFrame()
    return self.frames[self.currentFrame]
end