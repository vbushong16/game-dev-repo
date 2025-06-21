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


function renderImagePrep(sprite_batch,images,batch_start,batch_length)
    sprite_batch:clear()
    for i, image in ipairs(images) do
        if i <= batch_length and i >= batch_start then  
            sprite_batch:add(image.quad
            , math.floor(image.x)
            , math.floor(image.y)
            , (image.r)
            , (image.sx)
            , (image.sy)
            , math.floor(image.ox)
            , math.floor(image.oy) )
        end
    end

    print(sprite_batch:getPixel(0,0))

    -- Finally, draw the sprite batch to the screen.
    love.graphics.draw(sprite_batch)
end