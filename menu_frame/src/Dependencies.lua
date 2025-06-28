

function generateQuads(atlas,tileheight,tilewidth)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end
    return spritesheet
end


Class = require 'src/class'
Push = require 'src/push'
require 'src/Animation'

require 'src/menu/menu_config'
require 'src/menu/menu_utils'
require 'src/menu/Graphics'
require 'src/menu/Menu'
require 'src/menu/Panel'
require 'src/menu/Button'


currentFont = love.graphics.newFont('fonts/font.ttf',24)


local vfx = 'VFX/shader.glsl'
shader = love.graphics.newShader(vfx)
local vfx_1 = 'VFX/3deffect.glsl'
effect3d = love.graphics.newShader(vfx_1)

WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000
VIRTUAL_HEIGHT = 1000 
VIRTUAL_WIDTH = 1000

-- spritesheet = love.graphics.newImage('img/Menu Border.png')
-- spritesheet:setFilter('nearest','nearest')
-- spritesheet2 = love.graphics.newImage('img/Menu Border Circle.png')
-- spritesheet2:setFilter('nearest','nearest')
-- spritesheet3 = love.graphics.newImage('img/Graphics Fire Menu Border.png')
-- spritesheet3:setFilter('nearest','nearest')
-- spritesheet4 = love.graphics.newImage('img/sword_item.png')
-- spritesheet4:setFilter('nearest','nearest')
-- spritesheet5 = love.graphics.newImage('img/Menu Border2.png')
-- spritesheet5:setFilter('nearest','nearest')
-- spritesheet6 = love.graphics.newImage('img/Menu Border3.png')
-- spritesheet6:setFilter('nearest','nearest')
-- spritesheet7 = love.graphics.newImage('img/Menu Border4.png')
-- spritesheet7:setFilter('nearest','nearest')
-- spritesheet8 = love.graphics.newImage('img/Menu Border5.png')
-- spritesheet8:setFilter('nearest','nearest')

gTextures = {
    ['frame'] = love.graphics.newImage('img/Menu Border.png')
    ,['cirlce_menu'] = love.graphics.newImage('img/Menu Border Circle.png')
    ,['fireframe'] = love.graphics.newImage('img/Graphics Fire Menu Border.png')
    ,['sword'] = love.graphics.newImage('img/sword_item.png')
    ,['frame2'] = love.graphics.newImage('img/Menu Border2.png')
    ,['frame3'] = love.graphics.newImage('img/Menu Border3.png')
    ,['frame4'] = love.graphics.newImage('img/Menu Border4.png')
    ,['frame5'] = love.graphics.newImage('img/Menu Border5.png')
    ,['frame6'] = love.graphics.newImage('img/Menu Border7.png')
    ,['frame8'] = love.graphics.newImage('img/Menu Border8.png')
    ,['frame9'] = love.graphics.newImage('img/Menu Border9.png')
    ,['animals'] = love.graphics.newImage('img/Sprite-0001.png')
}

gTextures['frame']:setFilter('nearest','nearest')
gTextures['cirlce_menu']:setFilter('nearest','nearest')
gTextures['fireframe']:setFilter('nearest','nearest')
gTextures['sword']:setFilter('nearest','nearest')
gTextures['frame2']:setFilter('nearest','nearest')
gTextures['frame3']:setFilter('nearest','nearest')
gTextures['frame4']:setFilter('nearest','nearest')
gTextures['frame5']:setFilter('nearest','nearest')
gTextures['frame6']:setFilter('nearest','nearest')
gTextures['frame8']:setFilter('nearest','nearest')
gTextures['frame9']:setFilter('nearest','nearest')
gTextures['animals']:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {
        love.graphics.newQuad(6,3,22,24,gTextures['frame']:getDimensions()),
    },
    ['menu2'] = {
        love.graphics.newQuad(4,3,25,26,gTextures['frame2']:getDimensions()),
    },
    ['menu3'] = {
        love.graphics.newQuad(68,36,362,389,gTextures['frame3']:getDimensions()),
    },
    ['fireframe'] = {
        love.graphics.newQuad(6,1,22,4,gTextures['fireframe']:getDimensions()),
        love.graphics.newQuad(38,1,22,4,gTextures['fireframe']:getDimensions()),
        love.graphics.newQuad(70,1,22,4,gTextures['fireframe']:getDimensions()),
    },
    ['sword'] = {
        love.graphics.newQuad(6,6,20,20,gTextures['sword']:getDimensions()),
    },
    ['frame'] = {
        ['left'] = love.graphics.newQuad(6,3,2,24,gTextures['frame']:getDimensions()),
        ['top'] = love.graphics.newQuad(6,3,22,2,gTextures['frame']:getDimensions()),
        ['right'] = love.graphics.newQuad(6,3,2,24,gTextures['frame']:getDimensions()),
        ['bottom'] = love.graphics.newQuad(6,3,22,2,gTextures['frame']:getDimensions()),
    },
    ['frame2'] = {
        ['left'] = love.graphics.newQuad(4,3,4,25,gTextures['frame2']:getDimensions()),
        ['top'] = love.graphics.newQuad(4,3,26,5,gTextures['frame2']:getDimensions()),
        ['right'] = love.graphics.newQuad(24,3,4,25,gTextures['frame2']:getDimensions()),
        ['bottom'] = love.graphics.newQuad(4,3,26,3,gTextures['frame2']:getDimensions()),
    },
    ['frame3'] = {
        ['top'] = love.graphics.newQuad(68,36,362,44,gTextures['frame3']:getDimensions()),
        ['bottom'] = love.graphics.newQuad(68,381,362,44,gTextures['frame3']:getDimensions()),
        ['left'] = love.graphics.newQuad(68,36,46,389,gTextures['frame3']:getDimensions()),
        ['right'] = love.graphics.newQuad(384,36,46,389,gTextures['frame3']:getDimensions()),
    },
    ['frame4'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,gTextures['frame4']:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,gTextures['frame4']:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,gTextures['frame4']:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,gTextures['frame4']:getDimensions()),
    },
    ['frame5'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,gTextures['frame5']:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,gTextures['frame5']:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,gTextures['frame5']:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,gTextures['frame5']:getDimensions()),
    },
    ['frame6'] = generateQuads(gTextures['frame6'],32,32)
    ,['frame8'] = generateQuads(gTextures['frame8'],32,32)
    ,['frame9'] = generateQuads(gTextures['frame9'],64,64)
    ,['animals'] = generateQuads(gTextures['animals'],500,500)
}


swordBatch = love.graphics.newSpriteBatch(gTextures['sword'])
spriteBatch = love.graphics.newSpriteBatch(gTextures['animals'])


graphics_value = {
    ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=1},image = gFrames['fireframe']},
    ['position'] = {dimensions = {width = 22,height = 4}},
    ['anchor'] = {anchor_x = nil, anchor_y = 4},
}

