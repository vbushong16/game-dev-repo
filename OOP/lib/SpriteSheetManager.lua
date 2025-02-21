
-- Class goals:
-- 1. Find the sprites from a sprite sheet


-- 1. Sprite sheet metadata
    -- Global information about the sprite sheet
        -- Atlas name and file location
        -- Atlas size rows and columns
    -- individual sprite data
        -- Entity data file
        -- width, heights, frames


SpriteSheetManager = Class{}

local require 'Animation'

function SpriteSheetManager:init(def)
    -- Spritesheet parameters
    self.atlas = def.atlas
    self.w = def.width
    self.h = def.height
end

function SpriteSheetManager:createAtlasMap(atlas, w, h)
    local sprite_sheet_width = atlas:getWidth() / w
    local sprite_sheet_height = atlas:getHeight() / h
    local sprite_counter = 1
    local sprite_table = {}
    for i = 0,sprite_sheet_height,1 do
        for j = 0,sprite_sheet_width,1 do
            sprite_table[sprite_counter] = love.graphics.newQuad(j*w,i*h,w,h,atlas:getDimensions())
            sprite_counter = sprite_counter + 1
        end
    end
    return sprite_table
end

function SpriteSheetManager:queryAtlasMap(sprites_location)
    local atlas_map = SpriteSheetManager:createAtlasMap(self.atlas,self.w,self.h)
    local sprite_map = {}
    for i, sprite_loc in pairs(sprites_location) do
        table.insert(sprite_map,sprite_loc)
    end
    return sprite_map
end


function SpriteSheetManager:update()
end

function SpriteSheetManager:render()
end

