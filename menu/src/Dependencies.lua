

Class = require 'src/class'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'


WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500

spritesheet = love.graphics.newImage('img/Menu Border.png')

gFrames = {
    ['menu'] = {love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),}
}