



-- Dimension of the quad WxH

-- frames = top, bottom, left, right

-- Menu menu_config
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
