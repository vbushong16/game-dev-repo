
Class = require 'class'


Feline = Class{}

function Feline:init(def)
    self.size = def.size
    self.weight = def.weight
    self.output = self:stats()
end

function Feline:stats()
    text = string.format("size: %.02f, weight: %.02f", self.size, self.weight)
    print(text)
    self.size = self.size + 3
end

Cat = Class{__includes = Feline}

function Cat:init(def)
    Feline.init(self,def)
    -- self.entity = Feline(self.sizeCat,self.weightCat)
end

function Cat:status()
    Feline.stats(self)
end



-- garfield = Feline(.7, 45)
-- print(garfield:stats())

garfield = Cat{size = .7, weight =  45}
garfield:status()
garfield:stats()
-- print(out)
-- print(garfield.entity.size)
-- print(garfield.entity.weight)