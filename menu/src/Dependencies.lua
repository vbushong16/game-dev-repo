

Class = require 'src/class'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'


WINDOW_HEIGHT = 500
WINDOW_WIDTH = 500

spritesheet = love.graphics.newImage('img/Menu Border.png')
spritesheet:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),},
    ['frame'] = {['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['top'] = love.graphics.newQuad(6,3,20,2,spritesheet:getDimensions()),
    ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
    ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),}
}

button_list = {
    ['button1'] = {
        ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
        ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
        ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
        ['callback'] = pressed_button,
        ['display'] = nil
    },
    ['button2'] = {
        ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
        ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
        ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
        ['callback'] = pressed_button,
        ['display'] = nil
    }
}

menu1 = {
    ['position'] = {x = 220, y=10},
    ['graphics'] = {shape = 'rectangle',render_type = 'image', rgb = nil,image = gFrames['menu'][1]},
    ['frame'] = {dimensions = {width = 2, height =2},rgb = nil,image = nil},
    ['size'] = {width = 125, height = 205},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        -- ['panel1'] = {
        --     panel_order = 1,
        --     ['layout'] = {rows = 1, cols = 2},
        --     ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
        --     ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
        --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
        --     },
        ['panel2'] = {
            panel_order = 2,
            ['layout'] = {rows = 1, cols = 2},
            ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = nil,image = gFrames['menu'][1]},
            ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
            ['position'] = { offsets = {offset_x = 5, offset_y = 5}}
            },
        -- ['panel3'] = {
        --     panel_order = 3,
        --     ['layout'] = {rows = 3, cols = 1},
        --     ['graphics'] = {shape = 'rectangle',render_type = 'frame',rgb = {r=0,g=0,b=0},image = nil},
        --     ['frame'] = {dimensions = {width = 5,height = 5}, rgb = nil, image = gFrames['frame']},
        --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
        --     },
    }
}

menu2 = {
    ['position'] = {x = 10, y=10},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb', rgb = {r=0,g=0,b=0},image = nil},
    ['frame'] = {dimensions = {width = 20, height =1},rgb = {r=1,g=0,b=0},image = nil},
    ['size'] = {width = 200, height = 200},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            panel_order = 1,
            ['layout'] = {rows = 1, cols = 2},
            ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = nil,image = gFrames['menu'][1]},
            ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
            ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
            ['buttons'] = button_list
            },
        -- ['panel2'] = {
        --     panel_order = 2,
        --     ['layout'] = {rows = 3, cols = 1},
        --     ['graphics'] = {shape = 'rectangle',render_type = 'frame',rgb = {r=0,g=1,b=0},image = nil},
        --     ['frame'] = {dimensions = {width = 5,height = 5}, rgb = nil, image = gFrames['frame']},
        --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
        --     ['buttons'] = nil
        --     },
        -- ['new_panel'] = {
        --     panel_order = 3,
        --     ['layout'] = {rows = 3, cols = 3},
        --     ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=1,b=0},image = nil},
        --     ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=0,b = 0}, image = nil},
        --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
        --     ['buttons'] = nil
        --     }
            
    }
}

menu3 = {
    ['position'] = {x = 10, y=220},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame']},
    ['size'] = {width = 200, height = 200},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {}
}

menu4 = {
    ['position'] = {x = 150, y=150},
    ['graphics'] = {shape = 'circle',render_type = 'rgb', rgb = {r=1,g=1,b=1},image = nil,frame = {image = nil,dimensions = nil}},
    ['size'] = {radius = 100},
    ['panels'] = nil
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