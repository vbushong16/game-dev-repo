Tree = Class{}

function Tree:init(def)

    self.Xtree = math.random(100,WINDOW_WIDTH-200)
    self.Ytree = math.random(100,WINDOW_HEIGHT - 100)
    -- self.treeAnim = idleTree 
    self.treeState = 1
    self.treeTimer = 0
    
    self.world = def.world
    
    self.body = love.physics.newBody(self.world,self.Xtree,self.Ytree,'static')
    self.shape = love.physice.newRectangleShape(25,50) 
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData({'tree'})

end

function Tree:treeAnimation()

    
end

function Tree:update()


    for i,tree in pairs(treeXY) do
        if tree['treeState'] == 1 then
            tree['treeAnim'] = idleTree
        else
            tree['treeAnim'] = burningTree
            treeTimer = treeTimer + dt
            if treeTimer >= 1.15 then
    
    
                for k, body in pairs(destroyedTrees) do
                    if not body:isDestroyed() then
                        body:destroy()
                    end
                end
                print('number of trees '.. tostring(#treeTable))
                for i = #treeTable, 1,-1 do
                    print('Trees left '.. tostring(treeTable[i].id))
                end
                
                for i = #treeTable, 1,-1 do
                    -- if treeTable[i].treeBody:isDestroyed() then
                    if treeTable[i].treeBody:isDestroyed() then
                            print('removing tree #' .. tostring(i))
                        print('removing tree id ' .. tostring(treeXY[i]['id']))
                        print('removing treeFixture id ' .. tostring(treeFixture[i]['id']))
                        print('removing treeBody id ' .. tostring(treeTable[i]['id']))
                        table.remove(treeTable,i)
                        table.remove(treeFixture,i)
                        table.remove(treeXY,i)
                        destroyedTrees = {}
                        -- treeXY[i]['treeState'] = 1
                        -- pscore = pscore + 1
                    end
                end
                treeTimer = 0
            end
            
        end        
    end
    

    if #contactBodiesT > 0 then        
        if love.keyboard.isDown('return') then
            for i,CBTree in pairs(treeFixture) do
                if CBTree['id'] == contactBodiesT[1] then
                table.insert(destroyedTrees,CBTree['treeFixture']:getBody())
                    for i,CBTreeXY in pairs(treeXY) do
                        if CBTreeXY['id'] == contactBodiesT[1] then
                            CBTreeXY['treeState'] = 2
                        end
                    end            
                end 
            end 
        end
    end

end

function Tree:render()

    for i,tree in pairs(treeXY) do
        love.graphics.draw(spritesheet,gFrames['tree'][tree['treeAnim']:getFrame()],treeTable[i]['treeBody']:getX(),treeTable[i]['treeBody']:getY(),0,2,2,offsetx_tree,offsety_tree+5)
        love.graphics.setColor(0,0,0)
        love.graphics.printf('TREE ID: ' ..tostring(tree['id']),treeTable[i]['treeBody']:getX(),treeTable[i]['treeBody']:getY(),WINDOW_WIDTH)
        love.graphics.reset()
    end
end

