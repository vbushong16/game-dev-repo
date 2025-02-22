

Tree = Class{__includes = Entity}

function Tree:init(input)

    self.world = input.world
    self.atlas = input.atlas
    self.x = input.x
    self.y = input.y
    self.w = 25
    self.h = 50
    self.body = love.physics.newBody(self.world,self.x,self.y,'static')
    self.shape = love.physics.newRectangleShape(self.w,self.h)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData({'tree'})
    self.state = 1

    def = {atlas = self.atlas,texture = 'tree',x = self.x,y = self.y}
    Entity.init(self,def)

end

function Tree:removal()
        Entity.changeAnimation(self,'burningTree')
        Timer.every(1.15, function () if not self.body:isDestroyed() then self.body:destroy() end end)
        :finish(function () self.state = 3 end)
        :limit(1)
end

function Tree:update(dt)
    Entity.update(self,dt)
end

function Tree:render()
    Entity.render(self)
end

