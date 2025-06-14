

function getImageDims(value)
    local image_dimensions = {
        x = select(1,value:getViewport())
        ,y = select(2,value:getViewport())
        ,width = select(3,value:getViewport())
        ,height = select(4,value:getViewport())
    }
    return image_dimensions
end

function scaleXY(width,height,graphics_width,graphics_height)
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

function frameRender(edge,width,height,scale_width,scale_height,frame_adjustment)
    local frame_table = {}
    if edge == 'top' then
        -- frame_table = {x = x,y = y,sw = scale_width,sh = scale_height}
        frame_table = {x = 0,y = 0,sw = scale_width,sh = scale_height}
    elseif edge == 'bottom' then
        -- frame_table = {x = x,y =y+height-frame_adjustment,sw = scale_width,sh = scale_height}
        frame_table = {x = 0,y =height-frame_adjustment,sw = scale_width,sh = scale_height}
    elseif edge == 'left' then
        -- frame_table = {x = x,y = y,sw = scale_width,sh = scale_height}
        frame_table = {x = 0,y = 0,sw = scale_width,sh = scale_height}
    elseif edge == 'right' then
        -- frame_table = {x = x + width - frame_adjustment,y = y,sw = scale_width,sh = scale_height}
        frame_table = {x = width - frame_adjustment,y = 0,sw = scale_width,sh = scale_height}
    end
    return frame_table
end




    







