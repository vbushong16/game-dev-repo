Entity = Class{}

function Entity:init(def)

    self.world = def.world
    self.x = def.x
    self.y = def.y
    self.entity_state = SpriteManager(def.entity_state)

end

function Entity:update()

end

function Entity:render()

end
