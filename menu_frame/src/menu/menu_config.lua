
pressed_button = function()
    -- print('a ui button is pressed')
    love.graphics.setColor(1,0,0)
    love.graphics.circle('fill',WINDOW_WIDTH/2,WINDOW_HEIGHT/2,20)
    love.graphics.reset()
end

menu_clickthrough = function()
    menu1:navigation(-1)
end
image_quad = 32

images_catalog = {

    ['frame8'] = {
        ['top'] = {dimensions = {x = 0, y = 0, width = 32, height =5}}
        ,['bottom'] = {dimensions = {x = 5, y = 30, width = 32, height =2}}
        ,['left'] = {dimensions = {x = 5, y = 0, width = 2, height =32}}
        ,['right'] = {dimensions = {x = 25, y = 0, width = 2, height =32}}
    }
    ,['frame6'] = {
        ['top'] = {dimensions = {x = 0, y = 0, width = 32, height =2}}
        ,['bottom'] = {dimensions = {x = 0, y = 30, width = 32, height =2}}
        ,['left'] = {dimensions = {x = 0, y = 0, width = 2, height =32}}
        ,['right'] = {dimensions = {x = 30, y = 0, width = 2, height =32}}
    }
    ,['animals'] = {
        ['platypus'] = {row = 1}
        ,['elephant'] = {row = 2}
    }
}

image_list = {
    ['elephant']={display = 'animals',image = 'elephant'}
    ,['platypus']={display = 'animals',image = 'platypus'}
}



-- menu1 = {
--     ['metadata'] = {name = 'Main Menu', debug = false},
--     ['position'] = {x = 50, y=50, offsets = {top = 0, bottom = 0, left = 0, right = 0}},
--     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = nil, stickers = nil},
--     ['frame'] = {
--         ['top'] = {dimensions = {width = nil, height =50}}
--         ,['bottom'] = {dimensions = {width = nil, height =10}}
--         ,['left'] = {dimensions = {width = 50, height =nil}}
--         ,['right'] = {dimensions = {width = 50, height =nil}}
--     },
--     ['size'] = {width = 800, height = 800},
--     ['components'] = {number_of_panels = 1},
--     ['panels'] = {
--         ['panel1'] = {
--             ['metadata'] = {debug = false},
--             panel_order = 1,
--             ['layout'] = {priority = 'cols', rows = {1,1}, cols = {2,3}},
--             ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = nil, stickers = nil},
--             ['frame'] = {
--                 ['top'] = {dimensions = {width = nil, height =0}}
--                 ,['bottom'] = {dimensions = {width = nil, height =0}}
--                 ,['left'] = {dimensions = {width = 0, height =nil}}
--                 ,['right'] = {dimensions = {width = 0, height =nil}}
--             },        
--             ['position'] = { offsets = {top = 5, bottom = 5, left = 5, right = 5}},
--             ['buttons'] = {
--                 ['button1'] = {
--                     ['metadata'] = {debug = false},
--                     button_number = 1,
--                     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
--                     ['frame'] = {
--                         ['top'] = {dimensions = {width = nil, height =10}}
--                         ,['bottom'] = {dimensions = {width = nil, height =10}}
--                         ,['left'] = {dimensions = {width = 10, height =nil}}
--                         ,['right'] = {dimensions = {width = 10, height =nil}}
--                     },
--                     ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 50}},
--                     ['callback'] = pressed_button,
--                     ['display'] = {display = 'animals',image = 'elephant'}
--                 },
--                 ['button2'] = {
--                     ['metadata'] = {debug = false},
--                     button_number = 2,
--                     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
--                     ['frame'] = {
--                         ['top'] = {dimensions = {width = nil, height =10}}
--                         ,['bottom'] = {dimensions = {width = nil, height =10}}
--                         ,['left'] = {dimensions = {width = 10, height =nil}}
--                         ,['right'] = {dimensions = {width = 10, height =nil}}
--                     },                
--                     ['position'] = { offsets = {top = 10, bottom = 40, left = -40, right = 10}},
--                     ['callback'] = pressed_button,
--                     ['display'] = {display = 'animals',image = 'platypus'}
--                 },
--                 ['button3'] = {
--                     ['metadata'] = {debug = false},
--                     button_number = 3,
--                     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
--                     ['frame'] = {
--                         ['top'] = {dimensions = {width = nil, height =10}}
--                         ,['bottom'] = {dimensions = {width = nil, height =10}}
--                         ,['left'] = {dimensions = {width = 10, height =nil}}
--                         ,['right'] = {dimensions = {width = 10, height =nil}}
--                     },                
--                     ['position'] = { offsets = {top = 10, bottom = 10, left = 10, right = 10}},
--                     ['callback'] = pressed_button,
--                     ['display'] = {display = 'animals',image = 'elephant'}
--                 },
--                 ['button4'] = {
--                     ['metadata'] = {debug = false},
--                     button_number = 4,
--                     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
--                     ['frame'] = {
--                         ['top'] = {dimensions = {width = nil, height =10}}
--                         ,['bottom'] = {dimensions = {width = nil, height =10}}
--                         ,['left'] = {dimensions = {width = 10, height =nil}}
--                         ,['right'] = {dimensions = {width = 10, height =nil}}
--                     },                
--                     ['position'] = { offsets = {top = 50, bottom = 10, left = 20, right = 20}},
--                     ['callback'] = pressed_button,
--                     ['display'] = {display = 'animals',image = 'platypus'}
--                 },
--                 ['button5'] = {
--                     ['metadata'] = {debug = false},
--                     button_number = 5,
--                     ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
--                     ['frame'] = {
--                         ['top'] = {dimensions = {width = nil, height =10}}
--                         ,['bottom'] = {dimensions = {width = nil, height =10}}
--                         ,['left'] = {dimensions = {width = 10, height =nil}}
--                         ,['right'] = {dimensions = {width = 10, height =nil}}
--                     },                
--                     ['position'] = { offsets = {top = -30, bottom = 10, left = 10, right = 10}},
--                     ['callback'] = pressed_button,
--                     ['display'] = {display = 'animals',image = 'elephant'}
--                 },
--             }
--         }
--     }
-- }


menu1 = {
    ['metadata'] = {name = 'Main Menu', debug = false},
    ['position'] = {x = 50, y=50, offsets = {top = 0, bottom = 0, left = 0, right = 0}},
    ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = nil, stickers = nil},
    ['frame'] = {
        ['top'] = {dimensions = {width = nil, height =10}}
        ,['bottom'] = {dimensions = {width = nil, height =10}}
        ,['left'] = {dimensions = {width = 10, height =nil}}
        ,['right'] = {dimensions = {width = 10, height =nil}}
    },
    ['size'] = {width = 800, height = 600},
    ['components'] = {number_of_panels = 1},
    ['panels'] = {
        ['panel1'] = {
            ['metadata'] = {debug = true},
            panel_order = 1,
            ['layout'] = {priority = 'cols', rows = {1,1,1,1}, cols = {1,1,1,1}},
            ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = nil, stickers = nil},
            ['frame'] = {
                ['top'] = {dimensions = {width = nil, height =0}}
                ,['bottom'] = {dimensions = {width = nil, height =0}}
                ,['left'] = {dimensions = {width = 0, height =nil}}
                ,['right'] = {dimensions = {width = 0, height =nil}}
            },        
            ['position'] = { offsets = {top = 5, bottom = 5, left = 5, right = 5}},
            ['buttons'] = {
                ['button1'] = {
                    ['metadata'] = {debug = false},
                    button_number = 1,
                    ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 50, right = 50}},
                    ['callback'] = pressed_button,
                    ['display'] = {display = 'animals',image = 'elephant'}
                },
                ['button2'] = {
                    ['metadata'] = {debug = false},
                    button_number = 2,
                    ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 50, right = 50}},
                    ['callback'] = pressed_button,
                    ['display'] = {display = 'animals',image = 'elephant'}
                },
                ['button3'] = {
                    ['metadata'] = {debug = false},
                    button_number = 3,
                    ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 50, right = 50}},
                    ['callback'] = pressed_button,
                    ['display'] = {display = 'animals',image = 'elephant'}
                },
                ['button4'] = {
                    ['metadata'] = {debug = false},
                    button_number = 4,
                    ['graphics'] = {frame = 'frame6',background = nil, foreground = nil, display = 'sword', stickers = nil},
                    ['frame'] = {
                        ['top'] = {dimensions = {width = nil, height =10}}
                        ,['bottom'] = {dimensions = {width = nil, height =10}}
                        ,['left'] = {dimensions = {width = 10, height =nil}}
                        ,['right'] = {dimensions = {width = 10, height =nil}}
                    },
                    ['position'] = { offsets = {top = 10, bottom = 10, left = 50, right = 50}},
                    ['callback'] = pressed_button,
                    ['display'] = {display = 'animals',image = 'elephant'}
                },
            }
        }
    }
}
