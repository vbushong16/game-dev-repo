

Class = require 'src/class'
require 'src/Animation'
require 'src/Menu'
require 'src/Panel'
require 'src/Button'
require 'src/Graphics'


WINDOW_HEIGHT = 1000
WINDOW_WIDTH = 1000

spritesheet = love.graphics.newImage('img/Menu Border.png')
spritesheet:setFilter('nearest','nearest')
spritesheet2 = love.graphics.newImage('img/Menu Border Circle.png')
spritesheet2:setFilter('nearest','nearest')
spritesheet3 = love.graphics.newImage('img/Graphics Fire Menu Border.png')
spritesheet3:setFilter('nearest','nearest')
spritesheet4 = love.graphics.newImage('img/sword_item.png')
spritesheet4:setFilter('nearest','nearest')
spritesheet5 = love.graphics.newImage('img/Menu Border2.png')
spritesheet5:setFilter('nearest','nearest')
spritesheet6 = love.graphics.newImage('img/Menu Border3.png')
spritesheet6:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {
        love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),
    },
    ['frame'] = {
        ['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['top'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
        ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
    },
    ['fireframe'] = {
        love.graphics.newQuad(6,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(38,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(70,1,22,4,spritesheet3:getDimensions()),
    },
    ['button'] = {
        love.graphics.newQuad(6,6,20,20,spritesheet4:getDimensions()),
    },
    ['menu2'] = {
        love.graphics.newQuad(4,3,25,26,spritesheet5:getDimensions()),
    },
    ['frame2'] = {
        ['left'] = love.graphics.newQuad(4,3,4,25,spritesheet5:getDimensions()),
        ['top'] = love.graphics.newQuad(4,3,26,5,spritesheet5:getDimensions()),
        ['right'] = love.graphics.newQuad(24,3,4,25,spritesheet5:getDimensions()),
        ['bottom'] = love.graphics.newQuad(4,3,26,3,spritesheet5:getDimensions()),
    },
    ['menu3'] = {
        love.graphics.newQuad(68,36,362,389,spritesheet5:getDimensions()),
    },
    ['frame3'] = {
        ['top'] = love.graphics.newQuad(68,36,362,44,spritesheet5:getDimensions()),
        ['bottom'] = love.graphics.newQuad(68,381,362,44,spritesheet5:getDimensions()),
        ['left'] = love.graphics.newQuad(68,36,46,389,spritesheet5:getDimensions()),
        ['right'] = love.graphics.newQuad(384,36,46,389,spritesheet5:getDimensions()),
    },

}

-- Circle dim: x = 2, y =2, w= 27, h= 27, x2 = 34 ...
-- Fire dim: x = 6,y=1, w = 22, h = 26, x2 = 38
-- fire top: x = 38, y = 1 , w=22, h =4
-- fire bot: x = 38, y = 23 , w=22, h =4

graphics_value = {
    ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=1},image = gFrames['fireframe']},
    ['position'] = {dimensions = {width = 22,height = 4}},
    ['anchor'] = {anchor_x = nil, anchor_y = 4},
}


pressed_button = function()
    -- print('a ui button is pressed')
    love.graphics.setColor(1,1,1)
    love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,5)
    love.graphics.reset()
end

button_list = {
    ['button1'] = {
        ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
        ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
        ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
        ['callback'] = pressed_button,
        ['display'] = 'test'
    },
    -- ['button2'] = {
    --     ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
    --     ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
    --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
    --     ['callback'] = pressed_button,
    --     ['display'] = nil
    -- }
}

menu1 = {
    ['position'] = {x = 50, y=50},
    ['graphics'] = {shape = 'rectangle',render_type = 'image', rgb = nil,image = gFrames['menu'][1]},
    ['frame'] = {dimensions = {width = 2, height =2},rgb = nil,image = nil},
    ['size'] = {width = 400, height = 400},
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
            ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
            ['buttons'] = {
                ['button1'] = {
                    button_number = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=0},image = gFrames['menu'][1]},
                    ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
                    ['position'] = { offsets = {offset_x = 10, offset_y = 5}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
                ['button2'] = {
                    button_number = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=0},image = gFrames['menu'][1]},
                    ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
                    ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
            }
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
    ['position'] = {x = 520, y=50},
    ['graphics'] = {shape = 'rectangle',render_type = 'rgb', rgb = {r=0,g=0,b=0},image = nil},
    ['frame'] = {dimensions = {width = 20, height = 20},rgb = {r=1,g=0,b=0},image = nil},
    ['size'] = {width = 400, height = 400},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            panel_order = 1,
            ['layout'] = {rows = 1, cols = 2},
            ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=1,g=1,b =1},image = nil},
            ['frame'] = {dimensions = {width = 20,height = 10}, rgb = {r=1,g=0,b =0}, image = nil},
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['buttons'] = {
                ['button1'] = {
                    button_number = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
                    ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
                ['button2'] = {
                    button_number = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 5,height = 5}, rgb = {r=0,g=1,b = 0}, image = nil},
                    ['position'] = { offsets = {offset_x = 2, offset_y = 2}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
            }
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
    ['position'] = {x = 50, y=520},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 20, height =20},rgb = nil,image = gFrames['frame']},
    ['size'] = {width = 400, height = 400},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            panel_order = 1,
            ['layout'] = {rows = 1, cols = 2},
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
            ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame']},
            ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
            ['buttons'] = {
                ['button1'] = {
                    button_number = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame']},
                    ['position'] = { offsets = {offset_x = 2, offset_y = 2}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
                ['button2'] = {
                    button_number = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame']},
                    ['position'] = { offsets = {offset_x = 2, offset_y = 2}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
            }
        }
    }
}

menu4 = {
    ['position'] = {x = 520, y=520},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
    ['frame'] = {dimensions = {width = 20, height =20},rgb = nil,image = gFrames['frame3']},
    ['size'] = {width = 400, height = 400},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            panel_order = 1,
            ['layout'] = {rows = 1, cols = 2},
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
            ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame3']},
            ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
            ['buttons'] = {
                ['button1'] = {
                    button_number = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame3']},
                    ['position'] = { offsets = {offset_x = 2, offset_y = 2}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
                ['button2'] = {
                    button_number = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},image = nil},
                    ['frame'] = {dimensions = {width = 10, height =20},rgb = nil,image = gFrames['frame3']},
                    ['position'] = { offsets = {offset_x = 2, offset_y = 2}},
                    ['callback'] = pressed_button,
                    ['display'] = gFrames['button'][1]
                },
            }
        }
    }
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