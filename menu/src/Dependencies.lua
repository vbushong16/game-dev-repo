

Class = require 'src/class'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'


WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500

spritesheet = love.graphics.newImage('img/Menu Border.png')

gFrames = {
    ['menu'] = {love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),},
    ['edges'] = {['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['top'] = love.graphics.newQuad(6,3,20,2,spritesheet:getDimensions()),
    ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),}
}

menu1 = {
    ['position'] = {x = 150, y=150},
    ['graphics'] = {shape = 'rectangle',render_type = 'image', rgb = nil,image = gFrames['menu'][1],edges = {image = nil,dimensions = nil}},
    ['size'] = {width = 200, height = 200},
}

menu2 = {
    ['position'] = {x = 150, y=150},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb', rgb = {r=1,g=1,b=1},image = nil,edges = {image = nil,dimensions = nil}},
    ['size'] = {width = 200, height = 200},
}

menu3 = {
    ['position'] = {x = 150, y=150},
    ['graphics'] = {shape = 'rectangle',render_type = 'edges', rgb = {r=1,g=1,b=1},image = nil,edges = {image = gFrames['edges'],dimensions = {width = 10, height =10}}},
    ['size'] = {width = 200, height = 200},
}

