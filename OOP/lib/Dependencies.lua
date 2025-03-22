
Class = require 'lib/class'
Timer = require 'lib/knife.timer'

require 'entity_defs'
require 'lib/Entity'
require 'lib/Animation'
require 'lib/Tree'
require 'lib/Yeti'
require 'lib/Skier'
require 'lib/Menu'



WINDOW_HEIGHT = 800
WINDOW_WIDTH = 800

PLAYER_MOV = 200
SKIER_MOV = 50

pscore = 0

printx = 0
printy = 0
mouse ={}

skier_table = {}
skierDestroy = {}

treeTable = {}
treeNumber = 6
pause_status = false



panel_items = {
    ['panel_1'] = {
        x = 15,
        y = 15,
        image = 'tree'
    },
    ['panel_2'] = {
        x = 75,
        y = 15,
        image = 'sign'
    },
}



spritesheet = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png')
gFrames = {
    ['yeti'] = {love.graphics.newQuad(10,52,33,41,spritesheet:getDimensions()),
    love.graphics.newQuad(44,50,29,43,spritesheet:getDimensions()),
    love.graphics.newQuad(74,49,26,44,spritesheet:getDimensions()),
    love.graphics.newQuad(101,54,31,39,spritesheet:getDimensions()),
    love.graphics.newQuad(133,51,33,42,spritesheet:getDimensions()),
    love.graphics.newQuad(167,51,30,42,spritesheet:getDimensions()),
    love.graphics.newQuad(198,51,30,42,spritesheet:getDimensions()),
    love.graphics.newQuad(229,51,24,42,spritesheet:getDimensions()),
    love.graphics.newQuad(254,55,27,38,spritesheet:getDimensions()),
    love.graphics.newQuad(282,55,27,38,spritesheet:getDimensions())},

    ['skier']={love.graphics.newQuad(10,12,23,27,spritesheet:getDimensions()),
    love.graphics.newQuad(34,10,23,29,spritesheet:getDimensions()),
    love.graphics.newQuad(58,7,17,32,spritesheet:getDimensions()),
    love.graphics.newQuad(76,6,16,33,spritesheet:getDimensions()),
    love.graphics.newQuad(93,6,33,33,spritesheet:getDimensions()),
    love.graphics.newQuad(127,6,30,33,spritesheet:getDimensions()),
    love.graphics.newQuad(128,6,32,33,spritesheet:getDimensions())},

    ['tree']={love.graphics.newQuad(296,188,29,33,spritesheet:getDimensions()),
    love.graphics.newQuad(328,188,29,33,spritesheet:getDimensions()),
    love.graphics.newQuad(358,188,27,33,spritesheet:getDimensions()),
    love.graphics.newQuad(365,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(341,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(317,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(294,227,22,28,spritesheet:getDimensions())},

    ['sign']={love.graphics.newQuad(129,102,13,25,spritesheet:getDimensions()),
    love.graphics.newQuad(143,102,13,25,spritesheet:getDimensions())}

}
