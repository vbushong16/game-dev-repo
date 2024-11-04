
WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500
PLAYER_SPEED = 400
DEGREES_TO_RADIANS = 0.0174532925199432957

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
 
    world = love.physics.newWorld(0,400)
    objects = {}
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world,0,WINDOW_HEIGHT-10,'static')
    objects.ground.shape = love.physics.newEdgeShape(0,0,WINDOW_WIDTH,0)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body,objects.ground.shape)

    objects.left_wall = {}
    objects.left_wall.body = love.physics.newBody(world,0+5,0,'static')
    objects.left_wall.shape = love.physics.newEdgeShape(0,0,0,WINDOW_HEIGHT)
    objects.left_wall.fixture = love.physics.newFixture(objects.left_wall.body,objects.left_wall.shape)

    objects.ball = {}
    objects.ball.body = love.physics.newBody(world,100,100,'dynamic')
    objects.ball.shape = love.physics.newCircleShape(60)
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape,10)
    objects.ball.fixture:setRestitution(0.8)

    playerBody = love.physics.newBody(world,WINDOW_WIDTH/2,WINDOW_HEIGHT/2,'dynamic')
    playerShape = love.physics.newRectangleShape(30, 30)
    platerFixture = love.physics.newFixture(playerBody, playerShape,20)
    playerBody:setFixedRotation(true)

    player2Body = love.physics.newBody(world,WINDOW_WIDTH/3,WINDOW_HEIGHT/3,'dynamic')
    player2Shape = love.physics.newRectangleShape(30, 30)
    plater2Fixture = love.physics.newFixture(player2Body, player2Shape,20)
    playerBody:setFixedRotation(true)

    spikeBody = love.physics.newBody(world,200,300,'kinematic')
    spikeShape = love.physics.newPolygonShape(0,0,25,0,12,25)
    spikeFixture = love.physics.newFixture(spikeBody,spikeShape)
    spikeBody:setAngularVelocity(360 * DEGREES_TO_RADIANS)

    bombsBodies = {}
    bombsFixtures = {}
    bombsShape = love.physics.newCircleShape(20)

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'space' then

        table.insert(bombsBodies,{
            love.physics.newBody(world,playerBody:getX(),playerBody:getY(),'dynamic'),
        })
        for i,bomb in pairs(bombsBodies) do
            table.insert(bombsFixtures,{
                love.physics.newFixture(bomb[1],bombsShape,10)
            })
        end
        
    end
   
end

function love.update(dt)
    
    local vx = 0
    local vy = 0

    local vx2 = 0
    local vy2 = 0
    if love.keyboard.isDown('down') then
        vy = PLAYER_SPEED
        vy2 = PLAYER_SPEED
    end
    if love.keyboard.isDown('up') then
        vy = -PLAYER_SPEED
        vy2 = -PLAYER_SPEED
    end
    if love.keyboard.isDown('left') then
        vx = -PLAYER_SPEED
        vx2 = -PLAYER_SPEED
    end
    if love.keyboard.isDown('right') then
        vx = PLAYER_SPEED
        vx2 = PLAYER_SPEED
    end
    playerBody:setLinearVelocity(vx,vy)
    player2Body:setLinearVelocity(vx2,vy2)
    
    world:update(dt)

end

function love.draw()

    -- love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.setLineWidth(2)
    -- love.graphics.line(objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
    
    -- love.graphics.setColor(0, 1, 0, 1)
    -- love.graphics.rectangle('fill',WINDOW_HEIGHT/2,WINDOW_WIDTH/2,10,10)

    -- love.graphics.setColor(0, 1, 0, 1)
    -- love.graphics.circle('fill',
    --         objects.ball.body:getX(),
    --         objects.ball.body:getY(),
    --         objects.ball.shape:getRadius()
    --     )
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

end

