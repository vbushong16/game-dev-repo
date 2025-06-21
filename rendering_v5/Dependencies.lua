

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


WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000


gTextures = {

    ['frame6'] = love.graphics.newImage('img/Menu Border7.png')
    ,['frame8'] = love.graphics.newImage('img/Menu Border8.png')
}


gTextures['frame6']:setFilter('nearest','nearest')
gTextures['frame8']:setFilter('nearest','nearest')

gFrames = {
    ['frame6'] = generateQuads(gTextures['frame6'],32,32)
    ,['frame8'] = generateQuads(gTextures['frame8'],32,32)
}

