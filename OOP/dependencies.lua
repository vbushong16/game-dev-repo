
Class = require 'lib/class'
require 'lib/Animation'
require 'lib/SpriteManager'
require 'lib/Entity'

gAtlas = {
    ['spriteSheet'] = love.graphics.newImage('SkiFree_-_WIN3_-_Sprite_Sheet.png'),
}

gFrames = {
    ['idleYeti'] = {
        love.graphics.newQuad(10,52,33,41,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(44,50,29,43,gAtlas['spriteSheet']:getDimensions())},
    ['runningYeti'] ={    
        love.graphics.newQuad(74,49,26,44,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(101,54,31,39,gAtlas['spriteSheet']:getDimensions())},
    ['eatingYeti'] = {
        love.graphics.newQuad(133,51,33,42,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(167,51,30,42,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(198,51,30,42,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(229,51,24,42,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(254,55,27,38,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(282,55,27,38,gAtlas['spriteSheet']:getDimensions())},
    ['skier']={
        love.graphics.newQuad(10,12,23,27,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(34,10,23,29,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(58,7,17,32,gAtlas['spriteSheet']:getDimensions())},
    ['idleTree']={
        love.graphics.newQuad(296,188,29,33,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(328,188,29,33,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(358,188,27,33,gAtlas['spriteSheet']:getDimensions())},
    ['burningTree'] ={    
        love.graphics.newQuad(365,227,23,28,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(341,227,23,28,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(317,227,23,28,gAtlas['spriteSheet']:getDimensions()),
        love.graphics.newQuad(294,227,22,28,gAtlas['spriteSheet']:getDimensions())}    
}