
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

    objects.right_wall = {}
    objects.right_wall.body = love.physics.newBody(world,0-5,0,'static')
    objects.right_wall.shape = love.physics.newEdgeShape(WINDOW_WIDTH,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    objects.right_wall.fixture = love.physics.newFixture(objects.right_wall.body,objects.right_wall.shape)

    objects.ball = {}
    objects.ball.body = love.physics.newBody(world,100,100,'dynamic')
    objects.ball.shape = love.physics.newCircleShape(60)
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape,10)
    objects.ball.fixture:setRestitution(1)



-- local body = love.physics.newBody(world, 100, 100)

-- local halfCircleShape = createHalfCircleShape(20, 20) -- Adjust radius and segments as needed

-- body:createFixture(halfCircleShape)

    -- objects.other_ball = {}
    -- objects.other_ball.body = love.physics.newBody(world, 100, 100)
    -- objects.other_ball.shape = createHalfCircleShape(20, 18) -- Adjust radius and segments as needed
    -- objects.other_ball.fixture = love.physics.newFixture(objects.other_ball.body, objects.other_ball.shape,10)

    playerBody = love.physics.newBody(world,WINDOW_WIDTH/2,WINDOW_HEIGHT/2,'dynamic')
    -- playerShape = love.physics.newRectangleShape(30, 30)

    -- triangleShape = {-20,10,  20,10,  0,-10}
    -- triangleShape = {10,10,  20,10,  10,20,20,20}
    local vertices = {}
    segments = 6
    radius = 20
    x_val = true
    for i = 1, segments do

        local angle = math.pi * 2 * i / segments
        print(math.cos(angle)*radius)
        
        if x_val then
            local point = math.cos(angle) * radius
            x_val = false
        else
            local point = math.sin(angle) * radius
            x_val = true
        end
        table.insert(vertices, point)
        point = nil 
    end

    print(unpack(vertices))

    

    playerShape = love.physics.newPolygonShape(unpack(vertices))
    playerFixture = love.physics.newFixture(playerBody, playerShape,20)
    playerFixture:setRestitution(1)
    playerBody:setFixedRotation(true)

    -- player2Body = love.physics.newBody(world,WINDOW_WIDTH/3,WINDOW_HEIGHT/3,'dynamic')
    -- player2Shape = love.physics.newRectangleShape(30, 30)
    -- plater2Fixture = love.physics.newFixture(player2Body, player2Shape,20)
    -- playerBody:setFixedRotation(true)

    -- spikeBody = love.physics.newBody(world,200,300,'kinematic')
    -- spikeShape = love.physics.newPolygonShape(0,0,25,0,12,25)
    -- spikeFixture = love.physics.newFixture(spikeBody,spikeShape)
    -- spikeBody:setAngularVelocity(360 * DEGREES_TO_RADIANS)

    -- bombsBodies = {}
    -- bombsFixtures = {}
    -- bombsShape = love.physics.newCircleShape(20)






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
    
    ray = nil
    -- r1nx, r1ny, r1f = 0,0,0
    if love.keyboard.isDown('return') then
        ray = lineRay(playerFixture)
        r1nx, r1ny, r1f = objects.ball.fixture:rayCast(ray.point1.x, ray.point1.y, ray.point2.x, ray.point2.y, ray.scale)
    end

    -- if love.keyboard.isDown('a') then
    --     ray = squareRay(playerFixture)
    --     r1nx, r1ny, r1f = objects.ball.fixture:rayCast(ray.point1_left.x, ray.point1_left.y, ray.point2_left.x, ray.point2_left.y, ray.scale)
    --     r2nx, r2ny, r2f = objects.ball.fixture:rayCast(ray.point1_right.x, ray.point1_right.y, ray.point2_right.x, ray.point2_right.y, ray.scale)
    -- end


    local vx = 0
    local vy = 0

    -- local vx2 = 0
    -- local vy2 = 0
    if love.keyboard.isDown('down') then
        vy = PLAYER_SPEED
        -- vy2 = PLAYER_SPEED
    end
    if love.keyboard.isDown('up') then
        vy = -PLAYER_SPEED
        -- vy2 = -PLAYER_SPEED
    end
    if love.keyboard.isDown('left') then
        vx = -PLAYER_SPEED
        -- vx2 = -PLAYER_SPEED
    end
    if love.keyboard.isDown('right') then
        vx = PLAYER_SPEED
        -- vx2 = PLAYER_SPEED
    end
    playerBody:setLinearVelocity(vx,vy)
    -- player2Body:setLinearVelocity(vx2,vy2)
    
    world:update(dt)

end

function love.draw()

    love.graphics.setColor(1, 1, 1, 1)
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

    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.line(Ray1.point1.x, Ray1.point1.y, Ray1.point2.x, Ray1.point2.y)

    if ray then
        love.graphics.setColor(1, 0, 0)
        love.graphics.line(ray.point1.x, ray.point1.y, ray.point2.x, ray.point2.y)
        if r1f then
	    -- 	-- Calculating the world position where the ray hit.
	    	local r1HitX = ray.point1.x + (ray.point2.x - ray.point1.x) * r1f
	    	local r1HitY = ray.point1.y + (ray.point2.y - ray.point1.y) * r1f

	    -- 	-- Drawing the ray from the starting point to the position on the shape.
	    	love.graphics.setColor(1, 0, 0)
	    	love.graphics.line(ray.point1.x, ray.point1.y, r1HitX, r1HitY)

	    -- 	-- We also get the surface normal of the edge the ray hit. Here drawn in green
	    	love.graphics.setColor(0, 1, 0)
	    	love.graphics.line(r1HitX, r1HitY, r1HitX + r1nx * 25, r1HitY + r1ny * 25)
	    end
    end
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

function lineRay(fixture)

	Ray1 = {
		point1 = {},
		point2 = {},
	}
	Ray1.point1.x, Ray1.point1.y = fixture:getBody():getX(),fixture:getBody():getY()
	Ray1.point2.x, Ray1.point2.y = fixture:getBody():getX(), fixture:getBody():getY() + 50
	Ray1.scale = 1

    return Ray1 
end



-- Function to create a half circle shape

function createHalfCircleShape(radius, segments)

    local vertices = {}

    for i = 1, segments do

        local angle = math.pi * 2 * i / segments

        local x = math.cos(angle) * radius

        local y = math.sin(angle) * radius

        table.insert(vertices, {x, y})

    end

    

    -- Remove the bottom points to form a half circle

    table.remove(vertices, #vertices)

    table.remove(vertices, 1)

    

    return love.physics.newPolygonShape(vertices)

end



-- In your main loop:

-- local body = love.physics.newBody(world, 100, 100)

-- local halfCircleShape = createHalfCircleShape(20, 20) -- Adjust radius and segments as needed

-- body:createFixture(halfCircleShape)