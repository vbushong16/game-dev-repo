
-- Entity = Class{}

-- function Entity:init(def)

--     self.atlas = def.atlas
--     self.texture = def.texture
--     self.x = def.x or 0
--     self.y = def.y or 0 
--     self.animations = {}
--     self.currentAnimation = "test"

-- end

-- function Entity:printingout()
--     print('this is a inherited method')
--     self.currentAnimation = "It Changed"
--     return 1
-- end


Tree = Class{}
-- Tree = Class{__includes = Entity}

function Tree:init(input)

    self.world = input.world
    self.atlas = input.atlas
    self.x = math.random(100,WINDOW_WIDTH-100)
    self.y = math.random(100,WINDOW_HEIGHT-100)
    self.body = love.physics.newBody(self.world,self.x,self.y,'static')
    self.shape = love.physics.newRectangleShape(25,50)
    self.fixture = love.physics.newFixture(self.body,self.shape)
    self.fixture:setUserData({'tree'})
    self.treeState = 1
    self.treeTimer = 0

    -- def = {atlas = self.atlas,texture = 'tree',x = self.x,y = self.y}
    -- Entity.init(self,def)

    self.texture = 'tree'

    self.animations = {}
    self.currentAnimation = ""
    self.entity_animations = TREE_DEFS[self.texture].anims
    self.angle = TREE_DEFS[self.texture].r
    self.scalex = TREE_DEFS[self.texture].scalex
    self.scaley = TREE_DEFS[self.texture].scaley
    self.offsetx = select(3,gFrames[self.texture][1]:getViewport())/2
    self.offsety = select(4,gFrames[self.texture][1]:getViewport())/2


end

function Tree:createAnimation(animation_name)
    self.animations[animation_name] = Animation{frames = self.entity_animations[animation_name].frames,
                                                interval = self.entity_animations[animation_name].interval
                                            }
end

function Tree:changeAnimation(animation_name)
    if animation_name ~= self.currentAnimation then
        self.currentAnimation = animation_name
    end
end


function Tree:update(dt)

    self.animations[self.currentAnimation]:update(dt)
    -- Entity.update(self,dt)
end

function Tree:render()

    love.graphics.draw(self.atlas,gFrames[self.texture][self.animations[self.currentAnimation]:getFrame()]
    ,self.x,self.y,
    self.angle,self.scalex,self.scaley,self.offsetx,self.offsety
    )
    -- Entity.render(self)

end

