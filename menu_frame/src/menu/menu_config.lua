
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
    ['position'] = {x = 50, y=50, offsets = {top = 0, bottom = 0, left = 0, right = 0}},
    ['graphics'] = {frame = 'frame',background = nil, foreground = nil, display = nil, stickers = nil},
    ['frame'] = {
        ['top'] = {dimensions = {width = nil, height =50}}
        ,['bottom'] = {dimensions = {width = nil, height =10}}
        ,['left'] = {dimensions = {width = 10, height =nil}}
        ,['right'] = {dimensions = {width = 50, height =nil}}
    },
    ['size'] = {width = 900, height = 900},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            ['metadata'] = {debug = true},
            panel_order = 1,
            ['layout'] = {priority = 'cols', rows = {1,1}, cols = {2,3}},
            ['graphics'] = {frame = 'frame3',background = nil, foreground = nil, display = nil, stickers = nil},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =10}}
                ,['bottom'] = {dimensions = {width = nil, height =10}}
                ,['left'] = {dimensions = {width = 10, height =nil}}
                ,['right'] = {dimensions = {width = 10, height =nil}}
            },        
            ['position'] = { offsets = {top = 5, bottom = 50, left = 5, right = 5}},
            ['buttons'] = {
                ['button1'] = {
                    ['metadata'] = {debug = true},
                    button_number = 1,
                    ['graphics'] = {frame = 'frame4',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },
                    ['position'] = { offsets = {top = 0, bottom = 0, left = 0, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['sword']}
                },
                ['button2'] = {
                    ['metadata'] = {debug = true},
                    button_number = 2,
                    ['graphics'] = {frame = 'frame3',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },                
                    ['position'] = { offsets = {top = 10, bottom = 0, left = 0, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['sword']}
                },
                ['button3'] = {
                    ['metadata'] = {debug = true},
                    button_number = 3,
                    ['graphics'] = {frame = 'frame3',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },                
                    ['position'] = { offsets = {top = 10, bottom = 0, left = 0, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['sword']}
                },
                ['button4'] = {
                    ['metadata'] = {debug = true},
                    button_number = 4,
                    ['graphics'] = {frame = 'frame3',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },                
                    ['position'] = { offsets = {top = 0, bottom = 0, left = 20, right = 20}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['sword']}
                },
                ['button5'] = {
                    ['metadata'] = {debug = true},
                    button_number = 5,
                    ['graphics'] = {frame = 'frame3',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },                
                    ['position'] = { offsets = {top = 50, bottom = 50, left = 0, right = 0}},
                    ['callback'] = pressed_button,
                    ['display'] = {atlas= spritesheet4, image = gFrames['sword']}
                },
                -- ['button6'] = {
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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
                --     ['metadata'] = {debug = true},
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



-- test = {['panel2'] = {
--     debug = false,
--     panel_order = 2,
--     ['layout'] = {priority = 'rows', rows = {2,1}, cols = {1,1}},
--     ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=1,g=0,b=0},atlas = spritesheet6},
--     ['frame'] = {
--         ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
--         ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
--         ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
--         ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
--     },
--     ['position'] = { offsets = {offset_x = 0, offset_y = 0}},
--     ['buttons'] = {
--         ['button1'] = {
--             debug = false,
--             button_number = 1,
--             ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
--             ['frame'] = {
--                 ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
--                 ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
--                 ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
--                 ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
--             },
--             ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--             ['callback'] = menu_clickthrough,
--             ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
--         },
--         ['button2'] = {
--             debug = false,
--             button_number = 2,
--             ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
--             ['frame'] = {
--                 ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
--                 ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
--                 ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
--                 ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
--             },
--             ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--             ['callback'] = pressed_button,
--             ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
--         },
--         ['button3'] = {
--             debug = false,
--             button_number = 3,
--             ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
--             ['frame'] = {
--                 ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
--                 ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
--                 ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
--                 ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
--             },
--             ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--             ['callback'] = menu_clickthrough,
--             ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
--         },
--         ['button4'] = {
--             debug = false,
--             button_number = 4,
--             ['graphics'] = {shape = 'rectangle',render_type = 'frame', rgb = {r=0,g=0,b=1},atlas = spritesheet6},
--             ['frame'] = {
--                 ['top'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['top']}
--                 ,['bottom'] = {dimensions = {width = nil, height =10},rgb = nil,image = gFrames['frame3']['bottom']}
--                 ,['left'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['left']}
--                 ,['right'] = {dimensions = {width = 10, height =nil},rgb = nil,image = gFrames['frame3']['right']}
--             },
--             ['position'] = { offsets = {offset_x = 10, offset_y = 10}},
--             ['callback'] = pressed_button,
--             ['display'] = {atlas= spritesheet4, image = gFrames['button'][1]}
--         },
--     }
-- }

-- }

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