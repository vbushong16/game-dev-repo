

WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500


spritesheet = love.graphics.newImage('img/Menu Border Circle.png')
spritesheet:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {
        love.graphics.newQuad(2,2,28,28,spritesheet:getDimensions()),
        love.graphics.newQuad(34,2,28,28,spritesheet:getDimensions()),
        love.graphics.newQuad(66,2,28,28,spritesheet:getDimensions()),
        love.graphics.newQuad(98,2,28,28,spritesheet:getDimensions()),
    },
}

-- Circle dim: x = 2, y =2, w= 27, h= 27, x2 = 34 ...
-- Fire dim: x = 6,y=1, w = 22, h = 26, x2 = 38
-- fire top: x = 38, y = 1 , w=22, h =4
-- fire bot: x = 38, y = 23 , w=22, h =4


pressed_button = function()
    -- print('a ui button is pressed')
    love.graphics.setColor(1,1,1)
    love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,5)
    love.graphics.reset()
end

menu4 = {
    ['position'] = {x = 220, y=220},
    ['graphics'] = {shape = 'circle',render_type = 'rgb', rgb = {r=0,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 10},rgb = {r=1,g=0,b=0},image = nil},
    ['size'] = {radius = 100},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {}
}


new_panel = {
    ['layout'] = {rows = 3, cols = 3},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=1,b=0},image = nil},
    ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
    ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
    }


-- new_button = {
--     ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=1,b=0},image = nil},
--     ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
--     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--     ['callback'] = pressed_button,
--     ['display'] = nil
--     }