
-- Table of the entity data

ENTITY_DEFS = {
    ['tree'] = {
        anims = {
            ['idleTree'] = {
                frames = {1, 2, 3},
                interval = 0.4
            },
            ['burningTree'] = {
                frames = {4, 5, 6, 7},
                interval = 0.2
            },
        },
        scalex = 2,
        scaley = 2,
        r = 0,

    },
    ['yeti'] = {
        anims = {
            ['idleYeti'] = {
                frames = {1, 2},
                interval = 0.2
            },
            ['runningYeti'] = {
                frames = {3, 4},
                interval = 0.2
            },
            ['eatingYeti'] = {
                frames = {5, 6, 7, 8,9,10},
                interval = 0.2
            },

        },
        scalex = 2,
        scaley = 2,
        r = 0,

    },
    ['skier'] = {
        anims = {
            ['skiingSkier'] = {
                frames = {4},
                interval = 0.2
            },
            ['turningSkier'] = {
                frames = {3},
                interval = 0.2
            },
        },
        scalex = 2,
        scaley = 2,
        r = 0,

    },
}