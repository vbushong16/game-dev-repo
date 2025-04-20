

Class = require 'src/class'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'


WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500

spritesheet = love.graphics.newImage('img/Menu Border.png')
spritesheet:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),},
    ['frame'] = {['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['top'] = love.graphics.newQuad(6,3,20,2,spritesheet:getDimensions()),
    ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),}
}

menu1 = {
    ['position'] = {x = 220, y=10},
    ['graphics'] = {shape = 'rectangle',render_type = 'image', rgb = nil,image = gFrames['menu'][1]},
    ['frame'] = {dimensions = {width = 2, height =2},rgb = nil,image = nil},
    ['size'] = {width = 200, height = 200},
}

menu2 = {
    ['position'] = {x = 10, y=10},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb', rgb = {r=0,g=0,b=0},image = nil},
    ['frame'] = {dimensions = {width = 10, height =10},rgb = {r=1,g=0,b=0},image = nil},
    ['size'] = {width = 200, height = 200},
}

menu3 = {
    ['position'] = {x = 10, y=220},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 10, height =10},rgb = nil,image = gFrames['frame']},
    ['size'] = {width = 200, height = 200},
}

menu4 = {
    ['position'] = {x = 150, y=150},
    ['graphics'] = {shape = 'circle',render_type = 'rgb', rgb = {r=1,g=1,b=1},image = nil,frame = {image = nil,dimensions = nil}},
    ['size'] = {radius = 100},
}

panel = {
    ['layout'] = {rows = 1, cols = 2},
    ['position'] = {x,y},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=1,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil}
    ['size'] = {width = 200, height = 200},
}