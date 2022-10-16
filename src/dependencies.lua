Class = require 'lib/class'
require 'src/constants'

-- classes
require 'src/Hero'
require 'src/Background'
require 'src/LevelCreator'

-- graphics
textures={
    ['background']=love.graphics.newImage('graphics/background.png'),
    ['hero']= {
        [1] = love.graphics.newImage('graphics/hero1.png'),
        [2] = love.graphics.newImage('graphics/hero2.png'),
        [3] = love.graphics.newImage('graphics/hero3.png'),
        [4] = love.graphics.newImage('graphics/hero4.png'),
        [5] = love.graphics.newImage('graphics/hero5.png')
    },
    ['tiles']=love.graphics.newImage('graphics/environment.png')
}

quads={
    ['tile']        = love.graphics.newQuad( 0, 0, 40, 40, textures['tiles'] ),
    ['topper']      = love.graphics.newQuad(40, 0, 40, 40, textures['tiles'] ),
    ['spikes']      = love.graphics.newQuad(80, 0, 40, 40, textures['tiles'] ),
    ['bloodySpikes']= love.graphics.newQuad(120, 0, 40, 40, textures['tiles'] ),
    ['?']           = love.graphics.newQuad(160, 0, 40, 40, textures['tiles'] ),
    ['breakBlock1'] = love.graphics.newQuad( 0, 200, 40, 40, textures['tiles'] ),
    ['breakBlock2'] = love.graphics.newQuad( 0, 240, 40, 40, textures['tiles'] ),
    ['breakBlock3'] = love.graphics.newQuad( 0, 280, 40, 40, textures['tiles'] ),
    ['heart']       = love.graphics.newQuad( 0, 320, 40, 40, textures['tiles'] ),
    ['halfHeart']   = love.graphics.newQuad( 0, 360, 40, 40, textures['tiles'] ),
    ['goldRing']    = love.graphics.newQuad( 0, 400, 40, 40, textures['tiles'] )
}