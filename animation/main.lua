
require 'lib/Dependencies'

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false
    })

    world = love.physics.newWorld(0,0)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

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
    yetiState = 1
    yetiBody = love.physics.newBody(world,WINDOW_WIDTH/2,WINDOW_HEIGHT/2,'dynamic')
    yetiShape = love.physics.newRectangleShape(60,60)
    yetiFixture = love.physics.newFixture(yetiBody,yetiShape)
    yetiFixture:setUserData({'Yeti'})

    input = {world = world, atlas = spritesheet}
    for i =1,treeNumber,1 do
        table.insert(treeTable,Tree(input))
        treeTable[i]:createAnimation('idleTree')
        treeTable[i]:createAnimation('burningTree')
        treeTable[i]:changeAnimation('idleTree')
    end

end


function love.keypressed(key)

    if key=='escape' then
        love.event.quit()
    end

    if key == 'space' then
        table.insert(skier_table,{
            ['skierBody'] = love.physics.newBody(world,0,math.random(50, WINDOW_HEIGHT - 50),'dynamic'),
            ['skierShape'] = love.physics.newRectangleShape(25,25),
            ['isNew'] = true
        })

        for i in pairs(skier_table) do
            if skier_table[i]['isNew'] == true then
                table.insert(skier_fixture,{
                    ['skierFixture'] = love.physics.newFixture(skier_table[i]['skierBody'],skier_table[i]['skierShape'])
                })
                skier_table[i]['skierBody']:setLinearVelocity(SKIER_MOV,0)
                skier_table[i]['isNew'] = false
                skier_fixture[i]['skierFixture']:setUserData({'skier'})
            end
        end
    end
end


function love.update(dt)

    yetiAnim:update(dt)
    world:update(dt)

    for i,tree in pairs(treeTable) do
        tree:update(dt)
    end


    vecX = 0
    vecY = 0
    yetiAnim = idleYeti

    if yetiState == 1 then
        if love.keyboard.isDown('down') then
            vecY = PLAYER_MOV
            yetiAnim = runningYeti
        end
        if love.keyboard.isDown('up') then
            vecY = -PLAYER_MOV
            yetiAnim = runningYeti
        end
        if love.keyboard.isDown('left') then
            vecX = -PLAYER_MOV
            yetiAnim = runningYeti
            left_direction  = true
        end
        if love.keyboard.isDown('right') then
            vecX = PLAYER_MOV
            yetiAnim = runningYeti
            left_direction = false
        end

    else
        vecX = 0
        vecY = 0
        yetiAnim = eatingYeti
        
        yetiTimer = yetiTimer + dt
        if yetiTimer >= 1.15 then
            yetiState = 1
            yetiTimer = 0
        end        
    end

    yetiBody:setLinearVelocity(vecX,vecY)

    

    destroyedSkiers = {}
    if #contactBodies > 0 then
        if love.keyboard.isDown('return') then
            table.insert(destroyedSkiers,contactBodies[1])
           
        end
    end

    for k, body in pairs(destroyedSkiers) do
        if not body:isDestroyed() then
            body:destroy()
        end
    end

    for i = #skier_table, 1,-1 do
        if skier_table[i].skierBody:isDestroyed() then
            table.remove(skier_table,i)
            table.remove(skier_fixture,i)
            yetiState = 2
            pscore = pscore + 1
        end
    end


    for i,tree in pairs(treeTable) do
        if tree.treeState~=1 then
            tree:changeAnimation('burningTree')
            tree.treeTimer = tree.treeTimer + dt
            if tree.treeTimer >= 1.15 then
                if not tree.body:isDestroyed() then
                 tree.body:destroy()
                end
                table.remove(treeTable,i)
            end
        end
    end       
    
    for i,tree in pairs(treeTable) do
        for j,conB in pairs(contactBodiesT) do
            if tree.body == conB then
                if love.keyboard.isDown('return') then
                    tree.treeState = 2
                end
            end
        end
    end

    love.keyboard.keysPressed = {}


end

function love.draw()

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.setColor(0,0,0)
    love.graphics.line(WINDOW_WIDTH/2,0,WINDOW_WIDTH/2,WINDOW_HEIGHT)
    love.graphics.printf('Score: ' ..tostring(pscore),0,0,WINDOW_WIDTH)

    love.graphics.printf('TREE ID: ' ..tostring(destroyedTrees[1]),30,30,WINDOW_WIDTH)

    love.graphics.printf('2pt Area',WINDOW_WIDTH/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)
    love.graphics.printf('1pt Area',WINDOW_WIDTH*3/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)
    love.graphics.reset()

    offsetx_yeti = select(3,gFrames['yeti'][1]:getViewport())/2
    offsety_yeti = select(4,gFrames['yeti'][1]:getViewport())/2

    for i in pairs(skier_table) do
        love.graphics.draw(spritesheet,gFrames['skier'][1],skier_table[i]['skierBody']:getX(),skier_table[i]['skierBody']:getY(),0,2,2)
    end

    for i,tree in pairs(treeTable) do
        tree:render()
    end

    love.graphics.draw(spritesheet,gFrames['yeti'][yetiAnim:getFrame()],yetiBody:getX(),yetiBody:getY(),0,left_direction == true and -2 or 2,2,offsetx_yeti,offsety_yeti)

    love.graphics.setColor(0,0,0)
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

end




function beginContact(a,b,coll)
    local x,y = coll:getNormal()
    local types = {}
    types[a:getUserData()[1]] = true
    types[b:getUserData()[1]] = true
    if types['Yeti'] and types['skier'] then
        local yetiFixture = a:getUserData()[1] == 'Yeti' and a or b
        local skierFixture = a:getUserData()[1] == 'skier' and a or b
        
        table.insert(contactBodies, skierFixture:getBody())
    end
    if types['tree'] and types['Yeti'] then
        local treeFixture = a:getUserData()[1] == 'tree' and a or b
        table.insert(contactBodiesT,treeFixture:getBody())
    end
end

function endContact(a, b, coll)
	
    local x,y = coll:getNormal()
    local types = {}
    types[a:getUserData()[1]] = true
    types[b:getUserData()[1]] = true
    
    if types['Yeti'] and types['skier'] then

        local yetiFixture = a:getUserData()[1] == 'Yeti' and a or b
        local skierFixture = a:getUserData()[1] == 'skier' and a or b
        
        if #contactBodies > 0 then
            table.remove(contactBodies, 1)
        end
    end
    
    if types['Yeti'] and types['tree'] then
        local treeFixture = a:getUserData()[1] == 'tree' and a or b
        if #contactBodiesT>0 then
            table.remove(contactBodiesT,1)
        end
    end


end