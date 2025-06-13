



local vfx = 'VFX/shader.glsl'
shader = love.graphics.newShader(vfx)

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
spritesheet7 = love.graphics.newImage('img/Menu Border4.png')
spritesheet7:setFilter('nearest','nearest')
spritesheet8 = love.graphics.newImage('img/Menu Border5.png')
spritesheet8:setFilter('nearest','nearest')

gFrames = {
    ['menu'] = {
        love.graphics.newQuad(6,3,22,24,spritesheet:getDimensions()),
    },
    ['menu2'] = {
        love.graphics.newQuad(4,3,25,26,spritesheet5:getDimensions()),
    },
    ['menu3'] = {
        love.graphics.newQuad(68,36,362,389,spritesheet6:getDimensions()),
    },
    ['fireframe'] = {
        love.graphics.newQuad(6,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(38,1,22,4,spritesheet3:getDimensions()),
        love.graphics.newQuad(70,1,22,4,spritesheet3:getDimensions()),
    },
    ['button'] = {
        love.graphics.newQuad(6,6,20,20,spritesheet4:getDimensions()),
    },
    ['frame'] = {
        ['left'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['top'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
        ['right'] = love.graphics.newQuad(6,3,2,24,spritesheet:getDimensions()),
        ['bottom'] = love.graphics.newQuad(6,3,22,2,spritesheet:getDimensions()),
    },
    ['frame2'] = {
        ['left'] = love.graphics.newQuad(4,3,4,25,spritesheet5:getDimensions()),
        ['top'] = love.graphics.newQuad(4,3,26,5,spritesheet5:getDimensions()),
        ['right'] = love.graphics.newQuad(24,3,4,25,spritesheet5:getDimensions()),
        ['bottom'] = love.graphics.newQuad(4,3,26,3,spritesheet5:getDimensions()),
    },
    ['frame3'] = {
        ['top'] = love.graphics.newQuad(68,36,362,44,spritesheet6:getDimensions()),
        ['bottom'] = love.graphics.newQuad(68,381,362,44,spritesheet6:getDimensions()),
        ['left'] = love.graphics.newQuad(68,36,46,389,spritesheet6:getDimensions()),
        ['right'] = love.graphics.newQuad(384,36,46,389,spritesheet6:getDimensions()),
    },
    ['frame4'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,spritesheet7:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,spritesheet7:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,spritesheet7:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,spritesheet7:getDimensions()),
    },
    ['frame5'] = {
        ['top'] = love.graphics.newQuad(70,35,361,14,spritesheet8:getDimensions()),
        ['bottom'] = love.graphics.newQuad(70,412,361,14,spritesheet8:getDimensions()),
        ['left'] = love.graphics.newQuad(70,35,14,391,spritesheet8:getDimensions()),
        ['right'] = love.graphics.newQuad(417,35,14,391,spritesheet8:getDimensions()),
    },

}


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

menu_clickthrough = function()
    menu1:navigation(-1)
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
    ['metadata'] = {name = 'Main Menu', debug = false},
    ['position'] = {x = 50, y=50},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet},
    ['frame'] = {
        ['top'] = {dimensions = {width = nil, height =50},rgb = nil,image = gFrames['frame']['top']}
        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame']['bottom']}
        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame']['left']}
        ,['right'] = {dimensions = {width = 50, height =nil},rgb = nil,image = gFrames['frame']['right']}
    },
    ['size'] = {width = 900, height = 900},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            debug = true,
            panel_order = 1,
            ['layout'] = {priority = 'cols', rows = {1,1}, cols = {2,3}},
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['buttons'] = {
                ['button1'] = {
                    debug = false,
                    button_number = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet7},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame4']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame4']['bottom']}
                        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame4']['left']}
                        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame4']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 100}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                },
                ['button2'] = {
                    debug = false,
                    button_number = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = -90, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                },
                ['button3'] = {
                    debug = false,
                    button_number = 3,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                },
                ['button4'] = {
                    debug = false,
                    button_number = 4,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 0, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                },
                ['button5'] = {
                    debug = false,
                    button_number = 5,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 0, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                },
                -- ['button6'] = {
                --     debug = false,
                --     button_number = 6,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button7'] = {
                --     debug = false,
                --     button_number = 7,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button8'] = {
                --     debug = false,
                --     button_number = 8,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button9'] = {
                --     debug = false,
                --     button_number = 9,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button10'] = {
                --     debug = false,
                --     button_number = 10,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button11'] = {
                --     debug = false,
                --     button_number = 11,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button12'] = {
                --     debug = false,
                --     button_number = 12,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button13'] = {
                --     debug = false,
                --     button_number = 13,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button14'] = {
                --     debug = false,
                --     button_number = 14,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button15'] = {
                --     debug = false,
                --     button_number = 15,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },
                -- ['button16'] = {
                --     debug = false,
                --     button_number = 16,
                --     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                --     ['frame'] = {
                --         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                --         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                --         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                --         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                --     },
                --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
                --     ['callback'] = pressed_button,
                --     ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
                -- },

            }
        },
 
    }
}



test = {['panel2'] = {
    debug = false,
    panel_order = 2,
    ['layout'] = {priority = 'rows', rows = {2,1}, cols = {1,1}},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=0,b=0},atlas = spritesheet6},
    ['frame'] = {
        ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
        ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
        ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
        ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
    },
    ['position'] = { offsets = {offset_x = 0, offset_y = 0}},
    ['buttons'] = {
        ['button1'] = {
            debug = false,
            button_number = 1,
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['callback'] = menu_clickthrough,
            ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
        },
        ['button2'] = {
            debug = false,
            button_number = 2,
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['callback'] = pressed_button,
            ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
        },
        ['button3'] = {
            debug = false,
            button_number = 3,
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['callback'] = menu_clickthrough,
            ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
        },
        ['button4'] = {
            debug = false,
            button_number = 4,
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['callback'] = pressed_button,
            ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
        },
    }
}

}

-- menu1 = {
--     ['position'] = {x = 50, y=50},
--     ['graphics'] = {shape = 'rectangle',render_type = 'image', rgb = nil,image = gFrames['menu'][1]},
--     ['frame'] = {dimensions = {width = 2, height =2},rgb = nil,image = nil},
--     ['size'] = {width = 400, height = 400},
--     ['components'] = {number_of_panels = 1},
--     ['panels'] = {
--         -- ['panel1'] = {
--         --     panel_order = 1,
--         --     ['layout'] = {rows = 1, cols = 2},
--         --     ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
--         --     ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
--         --     ['position'] = { offsets = {offset_x = 10, offset_y = 10}}
--         --     },
--         ['panel2'] = {
--             panel_order = 2,
--             ['layout'] = {rows = 1, cols = 2},
--             ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = nil,image = gFrames['menu'][1]},
--             ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
--             ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
--             ['buttons'] = {
--                 ['button1'] = {
--                     button_number = 1,
--                     ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=0},image = gFrames['menu'][1]},
--                     ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
--                     ['position'] = { offsets = {offset_x = 10, offset_y = 5}},
--                     ['callback'] = pressed_button,
--                     ['display'] = gFrames['button'][1]
--                 },
--                 ['button2'] = {
--                     button_number = 2,
--                     ['graphics'] = {shape = 'rectangle',render_type = 'image',rgb = {r=0,g=0,b=0},image = gFrames['menu'][1]},
--                     ['frame'] = {dimensions = {width = 2,height = 2}, rgb = nil, image = nil},
--                     ['position'] = { offsets = {offset_x = 5, offset_y = 5}},
--                     ['callback'] = pressed_button,
--                     ['display'] = gFrames['button'][1]
--                 },
--             }
--             },

--     }
-- }


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