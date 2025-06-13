




WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000

spritesheet = love.graphics.newImage('img/Menu Border.png')
spritesheet:setFilter('nearest','nearest')
spritesheet2 = love.graphics.newImage('img/Menu Border Circle.png')
spritesheet2:setFilter('nearest','nearest')
spritesheet3 = love.graphics.newImage('img/Graphics Fire Menu Border.png')
spritesheet3:setFilter('nearest','nearest')
spritesheet4 = love.graphics.newImage('img/sword_item.png')
spritesheet4:setFilter('nearest','nearest')
spritesheet5 = love.graphics.newImage('img/Menu Border2.png')
spritesheet5:setFilter('nearest','nearest')
spritesheet6 = love.graphics.newImage('img/Menu Border3.png')
spritesheet6:setFilter('nearest','nearest')
spritesheet7 = love.graphics.newImage('img/Menu Border4.png')
spritesheet7:setFilter('nearest','nearest')
spritesheet8 = love.graphics.newImage('img/Menu Border5.png')
spritesheet8:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {
        love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),
    },
    ['menu2'] = {
        love.graphics.newQuad(4,3,25,26,spritesheet5:getDimensions()),
    },
    ['menu3'] = {
        love.graphics.newQuad(68,36,362,389,spritesheet6:getDimensions()),
    },
    ['fireframe'] = {
        love.graphics.newQuad(6,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(38,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(70,1,22,4,spritesheet3:getDimensions()),
    },
    ['button'] = {
        love.graphics.newQuad(6,6,20,20,spritesheet4:getDimensions()),
    },
    ['frame'] = {
        ['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['top'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
        ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
    },
    ['frame2'] = {
        ['left'] = love.graphics.newQuad(4,3,4,25,spritesheet5:getDimensions()),
        ['top'] = love.graphics.newQuad(4,3,26,5,spritesheet5:getDimensions()),
        ['right'] = love.graphics.newQuad(24,3,4,25,spritesheet5:getDimensions()),
        ['bottom'] = love.graphics.newQuad(4,3,26,3,spritesheet5:getDimensions()),
    },
    ['frame3'] = {
        ['top'] = love.graphics.newQuad(68,36,362,44,spritesheet6:getDimensions()),
        ['bottom'] = love.graphics.newQuad(68,381,362,44,spritesheet6:getDimensions()),
        ['left'] = love.graphics.newQuad(68,36,46,389,spritesheet6:getDimensions()),
        ['right'] = love.graphics.newQuad(384,36,46,389,spritesheet6:getDimensions()),
    },
    ['frame4'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,spritesheet7:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,spritesheet7:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,spritesheet7:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,spritesheet7:getDimensions()),
    },
    ['frame5'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,spritesheet8:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,spritesheet8:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,spritesheet8:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,spritesheet8:getDimensions()),
    },

}


graphics_value = {
    ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=1},image = gFrames['fireframe']},
    ['position'] = {dimensions = {width = 22,height = 4}},
    ['anchor'] = {anchor_x = nil, anchor_y = 4},
}

Class = require 'src/class'
require 'src/Animation'
require 'src/menu_config'
require 'src/menu_utils'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'
require 'src/Graphics'