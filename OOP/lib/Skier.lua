

Skier = Class{__includes = Entity}

function Skier:init(def)

    self.world = input.world
    self.atlas = input.atlas
    self.x = input.x
    self.y = input.y
    self.w = 25
    self.h = 25
    self.body = love.physics.newBody(self.world,self.x,self.y,'dynamic')
    self.shape = love.physics.newRectangleShape(self.w,self.h)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData({'skier'})
    self.state = 1
    -- self.sensorShape = love.physics.newCircleShape(100)
    vertices = {0,0
    ,-80,100
    ,-50,110
    ,-20,120
    , 10,130
    ,30,120
    ,60,110
    ,90,100}
    self.sensorShape = love.physics.newPolygonShape(vertices)
    self.sensorFixture = love.physics.newFixture(self.body,self.sensorShape)
    self.sensorFixture:setSensor(true)
    self.sensorFixture:setUserData({'skier_sensor'})

    def = {atlas = self.atlas,texture = 'skier',x = self.x,y = self.y}
    Entity.init(self,def)

    self.detectedBodies = {}
    self.allBodies = {}

end


function Skier:senseBodies()

    local x = self.x
    local y = self.y
    local sensedBody = {}
    local allSensedBodies = {}
    local distance = 0

    if self.detectedBodies == nil then self.state = 1 return false end
    for i, bodies in pairs(self.detectedBodies) do
        distance = distanceBetweenBodies(x,y,bodies:getX(),bodies:getY())
        sensedBody = {body = bodies,
        x = bodies:getX(),
        y = bodies:getY(),
        distance = distance}
        table.insert(allSensedBodies,sensedBody)
    end
    -- print(allSensedBodies.distance)
    return allSensedBodies
end


function Skier:update(dt)    
    
    -- print(#self.detectedBodies)
    if self.state == 4 then
        self.allBodies = self:senseBodies()
    else
        self.allBodies = {}
    end
    if not self.body:isDestroyed() then
        self.body:setLinearVelocity(0,SKIER_MOV)
        Entity.changeAnimation(self,'skiingSkier')
        Entity.update(self,dt)
        self.x = self.body:getX()
        self.y = self.body:getY()
    end
end

function Skier:render()

    Entity.render(self)

    -- print('SKIER STATE IS:' .. self.state)
    if self.state == 4 then
        local val = self.allBodies
        love.graphics.setColor(1, 0, 0)

        -- print('NUMBER OF BODIES ' .. #val)
    -- if detectedBodies ~= false then
        for i,bodies in pairs(val) do
            -- print(bodies.distance)
            love.graphics.line(self.x, self.y, bodies.x, bodies.y)
        end
    -- end
        love.graphics.reset()
    end

end