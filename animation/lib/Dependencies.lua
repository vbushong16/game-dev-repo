
Class = require 'lib/class'

require 'tree_defs'
require 'lib/Entity'
require 'lib/Animation'
require 'lib/Tree'



WINDOW_HEIGHT = 800
WINDOW_WIDTH = 800

PLAYER_MOV = 200
SKIER_MOV = 100

pscore = 0

skier_table = {}
skier_fixture = {}
contactBodies = {}

treeTable = {}
destroyedTrees = {}
contactBodiesT = {}
treeNumber = 6

yetiTimer = 0


spritesheet = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png')
gFrames = {
    ['yeti'] = {
        love.graphics.newQuad(10,52,33,41,spritesheet:getDimensions()),
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
    love.graphics.newQuad(58,7,17,32,spritesheet:getDimensions())},

    ['tree']={love.graphics.newQuad(296,188,29,33,spritesheet:getDimensions()),
    love.graphics.newQuad(328,188,29,33,spritesheet:getDimensions()),
    love.graphics.newQuad(358,188,27,33,spritesheet:getDimensions()),
    love.graphics.newQuad(365,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(341,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(317,227,23,28,spritesheet:getDimensions()),
    love.graphics.newQuad(294,227,22,28,spritesheet:getDimensions())}    
}
