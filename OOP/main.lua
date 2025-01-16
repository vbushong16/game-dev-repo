
require 'lib/Dependencies'

function love.load()

    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false
    })

    world = love.physics.newWorld(0,0)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    input = {world = world, atlas = spritesheet}
    yeti_character = Yeti(input)
    yeti_character:createAnimation('idleYeti')
    yeti_character:createAnimation('runningYeti')
    yeti_character:createAnimation('eatingYeti')
    yeti_character:changeAnimation('idleYeti')

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
        skier_character = Skier(input)
        skier_character:createAnimation('skiingSkier')
        skier_character:createAnimation('turningSkier')
        skier_character:changeAnimation('skiingSkier')
        table.insert(skier_table,skier_character)
    end
end


function love.update(dt)

    Timer.update(dt)
    world:update(dt)

    yeti_character:update(dt)
    for i,tree in pairs(treeTable) do
        tree:update(dt)
    end

    for i,skier in pairs(skier_table) do
        skier:update(dt)
    end


    for i, skier in pairs(skier_table) do
        if skier.state == 4 then
            for i,bodies in pairs(skier.allBodies) do
                if 12.5+35 > math.abs(bodies.x - skier.x) then
                    if (bodies.x - skier.x) < 0 then
                        mov = SKIER_MOV
                        skier.scalex = ENTITY_DEFS['skier'].scalex
                    else
                        mov = -SKIER_MOV
                        skier.scalex = -ENTITY_DEFS['skier'].scalex
                    end
                    skier:changeAnimation('turningSkier')
                    skier.body:setLinearVelocity(mov,SKIER_MOV)
                end
            end
            for i,skierFlag in pairs(skierDestroy) do
                if love.keyboard.isDown('return') then
                    while yeti_character.state == 1 do
                        skierFlag.body:destroy()
                        if skier.body:isDestroyed() then
                            table.remove(skier_table,j)
                        end
                        yeti_character.state = 2
                        yeti_character:eatingFunction()
                        pscore = pscore + 1
                        skierDestroy = {}    
                    end    
                end
            end
        end
    end

    for i, tree in pairs(treeTable) do
        if tree.state == 2 then
            if love.keyboard.isDown('return') then    
                tree:removal()
            end
        elseif tree.state == 3 then
            table.remove(treeTable,i)
        end
    end

end

function love.draw()

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
    
    love.graphics.setColor(0,0,0)
    love.graphics.line(WINDOW_WIDTH/2,0,WINDOW_WIDTH/2,WINDOW_HEIGHT)
    love.graphics.printf('Score: ' ..tostring(pscore),0,0,WINDOW_WIDTH)
    love.graphics.printf('2pt Area',WINDOW_WIDTH/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)
    love.graphics.printf('1pt Area',WINDOW_WIDTH*3/4 -10,WINDOW_HEIGHT/2,WINDOW_WIDTH)
    love.graphics.reset()

    for i,skier in pairs(skier_table) do
        skier:render()
    end

    for i,tree in pairs(treeTable) do
        tree:render()
    end

    yeti_character:render()

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
    if types['yeti'] and types['skier'] then
        local skierFixture = a:getUserData()[1] == 'skier' and a or b
        for i, skier in pairs(skier_table) do
            if skier.body == skierFixture:getBody() then
                table.insert(skierDestroy,skier)
            end
        end
    end
    if types['tree'] and types['yeti'] then
        local treeFixture = a:getUserData()[1] == 'tree' and a or b
        for i,tree in pairs(treeTable)do
            if tree.body == treeFixture:getBody() then
                tree.state = 2
            end
        end
    end
    if types['skier_sensor'] and types['tree'] or types['yeti'] then
        local skier_sensorFixture = a:getUserData()[1] == 'skier_sensor' and a or b
        local otherBody = a:getUserData()[1] ~= 'skier_sensor' and a or b
        for i, skier in pairs(skier_table) do
            if skier.body == skier_sensorFixture:getBody() then
                skier.state = 4
                table.insert(skier.detectedBodies,otherBody:getBody())
            end
        end
    end
end

function endContact(a, b, coll)
	
    local x,y = coll:getNormal()
    local types = {}
    types[a:getUserData()[1]] = true
    types[b:getUserData()[1]] = true
    
    if types['yeti'] and types['skier'] then
        local skierFixture = a:getUserData()[1] == 'skier' and a or b
        for i, skier in pairs(skier_table) do
            if skier.body == skierFixture:getBody() then
                table.remove(skierDestroy,i)
            end
        end
    end
    
    if types['yeti'] and types['tree'] then
        local treeFixture = a:getUserData()[1] == 'tree' and a or b
        for i, tree in pairs(treeTable) do
            if tree.body == treeFixture:getBody() then
                tree.state = 1
            end
        end
    end
    if types['skier_sensor'] and types['tree'] or types['yeti'] then
        local skier_sensorFixture = a:getUserData()[1] == 'skier_sensor' and a or b
        local otherBody = a:getUserData()[1] ~= 'skier_sensor' and a or b
        for i, skier in pairs(skier_table) do
            if skier.body == skier_sensorFixture:getBody() then
                skier.state = 1
                for i,bodies in pairs(skier.detectedBodies) do
                    if bodies == otherBody:getBody() then
                        table.remove(skier.detectedBodies,i)
                    end
                end
            end
        end
    end
end


function distanceBetweenBodies(x1,y1,x2,y2)
    local distance = 0
    distance = math.sqrt((math.abs(x2-x1)^2)+(math.abs(y2-y1))^2)
    return distance
end