

pressed_button = function(arg,arg2,arg3)
    -- print('a ui button is pressed')
    Chain(
    function (go)
        Timer.tween(0.2, {
        [arg] = { 
            x = arg.x - 5
            ,y = arg.y - 5
            -- ,sw = arg.sw+0.01

        }
    })
        Timer.after(0.2, go)
    end,
    function (go)
        Timer.tween(0.2, {
            [arg] = { 
                x = arg.x + 5
                ,y = arg.y + 5
                -- ,sw = arg.sw-0.01

            }
    })
        Timer.after(0.2, go)
    end,
    function (go)
        arg2:emit(64)
        Timer.after(1, go)
    end
    -- function (go)
    --     print 'playing demo'
    --     Timer.after(1, go)
    -- end
    )()
end

menu_clickthrough = function()
    menu1:navigation(-1)
end



menu1 = {
    ['metadata'] = {name = 'Main Menu', debug = false},
    ['position'] = {x = 50, y=50},
    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet},
    ['frame'] = {
        ['top'] = {dimensions = {width = nil, height =50},rgb = nil,image = gFrames['frame']['top']}
        ,['bottom'] = {dimensions = {width = nil, height =50},rgb = nil,image = gFrames['frame']['bottom']}
        ,['left'] = {dimensions = {width = 50, height =nil},rgb = nil,image = gFrames['frame']['left']}
        ,['right'] = {dimensions = {width = 50, height =nil},rgb = nil,image = gFrames['frame']['right']}
    },
    ['size'] = {width = 900, height = 900},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            debug = false,
            panel_order = 1,
            ['layout'] = {priority = 'cols', rows = {1,1}, cols = {4,4}},
            ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=1,b=1},atlas = spritesheet6},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =0},rgb = nil,image = gFrames['frame3']['top']}
                ,['bottom'] = {dimensions = {width = nil, height =0},rgb = nil,image = gFrames['frame3']['bottom']}
                ,['left'] = {dimensions = {width =0, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                ,['right'] = {dimensions = {width =0, height =nil},rgb = nil,image = gFrames['frame3']['right']}
            },
            ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
            ['buttons'] = {
                ['button1'] = {
                    debug = false,
                    button_number = 1,
                    button_val = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet10, image = gFrames['button'][3]}
                },
                ['button2'] = {
                    debug = false,
                    button_number = 2,
                    button_val = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet7, image = gFrames['button'][2]}
                },
                ['button3'] = {
                    debug = false,
                    button_number = 3,
                    button_val = 2,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet10, image = gFrames['button'][3]}
                },
                ['button4'] = {
                    debug = false,
                    button_number = 4,
                    button_val = 1,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet7, image = gFrames['button'][2]}
                },
                ['button5'] = {
                    debug = false,
                    button_number = 5,
                    button_val = 3,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet11, image = gFrames['button'][4]}
                },
                ['button6'] = {
                    debug = false,
                    button_number = 6,
                    button_val = 3,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet11, image = gFrames['button'][4]}
                },
                ['button7'] = {
                    debug = false,
                    button_number = 7,
                    button_val = 4,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet12, image = gFrames['button'][5]}
                },
                ['button8'] = {
                    debug = false,
                    button_number = 8,
                    button_val = 4,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet12, image = gFrames['button'][5]}
                },
                ['button9'] = {
                    debug = false,
                    button_number = 9,
                    button_val = 5,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet13, image = gFrames['button'][6]}
                },
                ['button10'] = {
                    debug = false,
                    button_number = 10,
                    button_val = 5,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet13, image = gFrames['button'][6]}
                },
                ['button11'] = {
                    debug = false,
                    button_number = 11,
                    button_val = 5,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet14, image = gFrames['button'][7]}
                },
                ['button12'] = {
                    debug = false,
                    button_number = 12,
                    button_val = 5,
                    ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['top']}
                        ,['bottom'] = {dimensions = {width = nil, height =20},rgb = nil,image = gFrames['frame3']['bottom']}
                        ,['left'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['left']}
                        ,['right'] = {dimensions = {width = 20, height =nil},rgb = nil,image = gFrames['frame3']['right']}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet14, image = gFrames['button'][7]}
                },
            }
        },
    }
}

button_list = {
    ['button1'] = {
        ['graphics'] = {shape = 'rectangle',render_type = 'rgb',rgb = {r=0,g=0,b=1},image = nil},
        ['frame'] = {dimensions = {width = 10,height = 10}, rgb = {r=1,g=1,b = 1}, image = nil},
        ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
        ['callback'] = pressed_button,
        ['display'] = 'test'
    },
}

