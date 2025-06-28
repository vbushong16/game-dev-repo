

function getFrameTranslation(image,border,images)

    return images[image][border].dimensions

end


function getImageDims(value)
    local image_dimensions = {
        x = select(1,value:getViewport())
        ,y = select(2,value:getViewport())
        ,width = select(3,value:getViewport())
        ,height = select(4,value:getViewport())
    }
    return image_dimensions
end

function scaleWH(width,height,graphics_width,graphics_height)
    local scale_table = {sw = width/graphics_width, sh = height/graphics_height}
   return scale_table
end

function middleXY(x,y,width,height)
    local middle_coord = {
        x = x+width/2
        ,y = y+height/2
    }
    return middle_coord
end

function objectCoord(x,y,width,height,frame_offsets)

    local points = {
            {x = x, y = y}
            ,{x = x + width, y = y}
            ,{x = x, y = y + height}
            ,{x = x + width, y = y + height}
            ,{x = x + frame_offsets.left, y = y+frame_offsets.top}
            ,{x = x + width - frame_offsets.right, y = y+frame_offsets.top}
            ,{x = x + frame_offsets.left, y = y+height - frame_offsets.bottom}
            ,{x = x + width - frame_offsets.right, y = y+height - frame_offsets.bottom}
        }
    return points
end

function frameRender(edge,x,y,scale_width,scale_height,frame_adj,coord_adj)
    local frame_table = {}
    if edge == 'top' then
        frame_table = {x = x,y =y+coord_adj,sw = scale_width,sh = scale_height}
    elseif edge == 'bottom' then
        frame_table = {x = x,y =y+coord_adj+frame_adj,sw = scale_width,sh = scale_height}
    elseif edge == 'left' then
        frame_table = {x = x+coord_adj,y = y,sw = scale_width,sh = scale_height}
    elseif edge == 'right' then
        frame_table = {x = x+coord_adj+frame_adj,y = y,sw = scale_width,sh = scale_height}
    end
    return frame_table
end

function imagePrep()

-- take an image or a table of images
-- return the dimensions
-- return the scale of each image

end

function imageSelection()

    -- take a spritesheet
    -- finds the sprite 
    -- find the images

    -- return a table of images

end

    
function renderImagePrep(sprite_batch,images,batch_start,batch_length)
    sprite_batch:clear()
    for i, image in ipairs(images) do
        -- if i <= batch_length and i >= batch_start then  
            sprite_batch:add(image.quad
            , math.floor(image.x)
            , math.floor(image.y)
            , (image.r)
            , (image.sx)
            , (image.sy)
            , math.floor(image.ox)
            , math.floor(image.oy) )
        -- end
    end
    -- Finally, draw the sprite batch to the screen.
    love.graphics.draw(sprite_batch)
    -- return(sprite_batch)
end

-- function updateFontSize(windowWidth, windowHeight)
--     -- Calculate scaling factor (example: based on height ratio)
--     local scaleFactor = windowHeight / VIRTUAL_HEIGHT
  
--     -- Determine dynamic font size
--     local baseFontSize = 24  -- starting font size
--     local dynamicFontSize = baseFontSize * scaleFactor
  
--     -- Create or select font (only if size changes)
--     if currentFont == nil or currentFont:getSize() ~= dynamicFontSize then
--       currentFont = love.graphics.newFont("'fonts/font.ttf'", dynamicFontSize) --
--     end
--   end


function middleX(x,x1)
    local x_val = (x+x1)/2
    return x_val
end

function middleX(y,y1)
    local y_val = (y+y1)/2
    return y_val
end


