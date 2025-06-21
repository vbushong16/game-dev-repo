WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 500

entities = {}
frames = {}

Push = require 'src/push'
Timer = require 'src/knife.timer'
Flux = require 'src/flux'
require 'src/utils'

shaders = {
    love.graphics.newShader('shaders/shader2.glsl')
    ,love.graphics.newShader('shaders/shader3.glsl')
    ,love.graphics.newShader('shaders/shader4.glsl')
    ,love.graphics.newShader('shaders/shader5.glsl')
    ,love.graphics.newShader('shaders/shader6.glsl')
    ,love.graphics.newShader('shaders/shader7.glsl')
    ,love.graphics.newShader('shaders/shader8.glsl')
    ,love.graphics.newShader('shaders/shader9.glsl')
    ,love.graphics.newShader('shaders/shader10.glsl')
}

canvases = {
    ['animal1'] = love.graphics.newCanvas(500,500)
    ,['animal2'] = love.graphics.newCanvas(500,500)
    ,['frame'] = love.graphics.newCanvas(500,500)    
}


gTextures = {
    ['animals'] = love.graphics.newImage('img/Sprite-0001.png')
    ,['frame'] = love.graphics.newImage('img/Menu Border8.png')
}
gTextures['animals']:setFilter('nearest','nearest')
gTextures['frame']:setFilter('nearest','nearest')

gFrames = {
    ['animals'] = generateQuads(gTextures['animals'],500,500)
    ,['frame'] = generateQuads(gTextures['frame'],32,32)
}

spriteBatch = love.graphics.newSpriteBatch(gTextures['animals'])
frameBatch = love.graphics.newSpriteBatch(gTextures['frame'])


