WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500
mouse ={}
images = {}
objectBodies = {}
objectFixures = {}
destroyedBodies = {}

dir ='characters'
files = love.filesystem.getDirectoryItems('characters')
image = love.graphics.newImage('characters/'..files[math.random(1,#files)])
objShape = love.physics.newRectangleShape(32,32)


function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true,
    })    

    world = love.physics.newWorld(0,100)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)


    bigCircleBody = love.physics.newBody(world,WINDOW_WIDTH/2,WINDOW_HEIGHT/2,'static')
    bigCircleShape = love.physics.newCircleShape(50)
    bigCircleFixture = love.physics.newFixture(bigCircleBody,bigCircleShape)
    bigCircleFixture:setUserData({"circle"})
    
    platformBody = love.physics.newBody(world,WINDOW_WIDTH/3,WINDOW_HEIGHT/2,'kinematic')
    platformShape = love.physics.newRectangleShape(50,10)
    platformFixture = love.physics.newFixture(platformBody,platformShape)
    platformFixture:setUserData({"platform"})
    platformBody:setLinearVelocity(100,0)

    Text = ""	  -- we'll use this to put info Text on the screen later
	Persisting = 0 -- we'll use this to store the state of repeated callback calls
	
	love.window.setTitle ("Persisting: "..Persisting)
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' then
    --     table.insert(images,{img = love.graphics.newImage('characters/'..files[math.random(1,#files)]),
    --     imgX = mouse.x,
    --     imgY = mouse.y,
    -- })
        file_name = files[math.random(1,#files)]
        table.insert(objectBodies,{love.physics.newBody(world, mouse.x, mouse.y,'dynamic'),
        img = love.graphics.newImage('characters/'..file_name),
        imgX = mouse.x,
        imgY = mouse.y,
        col_added = false,
        })
        
        for i, obj in pairs(objectBodies) do
            print(i)
            if obj.col_added == false then
                table.insert(objectFixures,{love.physics.newFixture(obj[1],objShape,2)})
                objectFixures[i][1]:setUserData({'image',i})
            end
            obj.col_added = true
        end

    end
end

function love.update(dt)
    mouse.x,mouse.y = love.mouse.getPosition()
    world:update(dt)

    for i,objectBody in pairs(objectBodies) do
        if objectBody[1]:getY() > WINDOW_WIDTH-200 then
            -- objectBody[1]:destroy()
            table.insert(destroyedBodies,objectBody[1])
            -- objectFixures[i][i]:destroy()
            -- table.remove(objectFixures,i)
            -- table.remove(objectBodies,i)
        end
    end

    if platformBody:getX() >= WINDOW_WIDTH then
        platformBody:setLinearVelocity(-100,0)
    elseif platformBody:getX() <= 0 then
        platformBody:setLinearVelocity(100,0)
    end

    for k, body in pairs(destroyedBodies) do
        if not body:isDestroyed() then 
            body:destroy()
        end
    end
    
    destroyedBodies = {}

    -- remove all destroyed obstacles from level
    for i = #objectBodies, 1, -1 do
        if objectBodies[i].body:isDestroyed() then
            table.remove(objectBodies, i)
        end
    end

end


function love.draw()
    love.graphics.circle('line',bigCircleBody:getX(),bigCircleBody:getY(),50)
    love.graphics.print('FPS: '.. tostring(love.timer.getFPS()),10,10)

    -- for i, image in pairs(images) do
    --     love.graphics.draw(image.img, image.imgX, image.imgY)
    -- end

    for i,objectBody in pairs(objectBodies) do
        love.graphics.draw(objectBody.img, 
        -- love.graphics.draw(images[i].img, 
        objectBody[1]:getX(),
        objectBody[1]:getY(),
        objectBody[1]:getAngle(),
        1,
        1,
        16,
        16)
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

    -- Draw the Text on the screen at position (10, 10)
	-- love.graphics.print(Text, 10, 10)
    -- for i = 1, #objectBodies do
    --     love.graphics.draw(images[i].img, 
    --         objectBodies[i][1]:getX(),
    --         objectBodies[i][1]:getY())
    -- end

    -- for i, image in pairs(images) do
    --     love.graphics.draw(image.img, image.imgX, image.imgY)
    -- end

end


-- function createBoxObject(obj,)

--     obj.body = love.physics.newBody(newWorld, x_input, y_input,'dynamic') 
--     obj.fixture = love.physics.newFixture(obj.body,obj.shape)
--     return obj
-- end


function beginContact(a, b, coll)
    Persisting = 1
	local x, y = coll:getNormal()
	local textA = a:getUserData()[1]
	local textB = b:getUserData()[1]
-- Get the normal vector of the collision and concatenate it with the collision information
	Text = Text.."\n 1.)" .. textA.." colliding with "..textB.." with a vector normal of: ("..x..", "..y..")"
	love.window.setTitle ("Persisting: "..Persisting)

    local types = {}
    types[a:getUserData()[1]] = true
    types[b:getUserData()[1]] = true

    -- if we collided between both the player and an obstacle...
    if types['platform'] and types['image'] then

        -- grab the body that belongs to the player
        local imageFixture = a:getUserData()[1] == 'image' and a or b
        local platformFixture = a:getUserData()[1] == 'platform' and a or b
        
        -- destroy the obstacle if player's combined X/Y velocity is high enough
        -- local velX, velY = imageFixture:getBody():getLinearVelocity()
        table.insert(destroyedBodies,imageFixture:getBody())
        -- imageFixture:getBody():setLinearVelocity(0,-200)
        -- imageFixture:getBody():destroy()
        -- objectFixures[i][i]:destroy()
        -- imageFixture:getBody():destroy()
        
    end

end

function endContact(a, b, coll)
	
end

function preSolve(a, b, coll)
	
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	
end