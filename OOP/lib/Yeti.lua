Yeti = Class{}

function Yeti:init(world)

    self.Xyeti = WINDOW_WIDTH/2
    self.Yyeti = WINDOW_HEIGHT/2
    -- self.treeAnim = idleTree 
    self.yetiState = 1
    self.yetiTimer = 0
    
    self.world = world
    
    self.body = love.physics.newBody(self.world,self.Xyeti,self.Yyeti,'dynamic')
    self.shape = love.physice.newRectangleShape(25,50) 
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData({'yeti'})

    self.yeti_entity = Entity{atlas = gAtlas['spriteSheet'], x = self.Xyeti, y = self.Yyeti}

end

function Tree:yetiAnimation()

    
end

function Tree:update()

    vecX = 0
    vecY = 0

    if self.yetiState == 1 then
        if love.keyboard.isDown('down') then
            vecY = PLAYER_MOV
            -- py = py + PLAYER_MOV
            -- yetiAnim = runningYeti
        end
        if love.keyboard.isDown('up') then
            vecY = -PLAYER_MOV
            -- py = py - PLAYER_MOV
            -- yetiAnim = runningYeti
        end
        if love.keyboard.isDown('left') then
            vecX = -PLAYER_MOV
            -- px = px - PLAYER_MOV
            -- yetiAnim = runningYeti
            -- left_direction  = true
        end
        if love.keyboard.isDown('right') then
            vecX = PLAYER_MOV
            -- px = px + PLAYER_MOV
            -- yetiAnim = runningYeti
            -- left_direction = false
        end

    else
        vecX = 0
        vecY = 0
        yeti:changeAnimation('eatingYeti',{1,2,3,4},0.2)
        
        self.yetiTimer = self.yetiTimer + dt
        if self.yetiTimer >= 1.15 then
            self.yetiState = 1
            self.yetiTimer = 0
        end        
    end

    yetiBody:setLinearVelocity(vecX,vecY)

end

function Tree:render()

    for i,tree in pairs(treeXY) do
        love.graphics.draw(spritesheet,gFrames['tree'][tree['treeAnim']:getFrame()],treeTable[i]['treeBody']:getX(),treeTable[i]['treeBody']:getY(),0,2,2,offsetx_tree,offsety_tree+5)
        love.graphics.setColor(0,0,0)
        love.graphics.printf('TREE ID: ' ..tostring(tree['id']),treeTable[i]['treeBody']:getX(),treeTable[i]['treeBody']:getY(),WINDOW_WIDTH)
        love.graphics.reset()
    end
end

