
WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    world = love.physics.newWorld(0,100)
    objects = {}
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world,0,WINDOW_HEIGHT-10,'static')
    objects.ground.shape = love.physics.newEdgeShape(0,0,WINDOW_WIDTH,0)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body,objects.ground.shape)

    objects.ball = {}
    objects.ball.body = love.physics.newBody(world,10,10,'dynamic')
    objects.ball.shape = love.physics.newCircleShape(3)
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape)
    objects.ball.fixture:setRestitution(0.9)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    world:update(dt)
end

function love.draw()

    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.setLineWidth(2)
    love.graphics.line(objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
    
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle('fill',WINDOW_HEIGHT/2,WINDOW_WIDTH/2,10,10)

    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.circle('fill',
            objects.ball.body:getX(),
            objects.ball.body:getY(),
            objects.ball.shape:getRadius()
        )


end