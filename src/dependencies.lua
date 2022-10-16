Class = require 'lib/class'
require 'src/constants'

-- classes
require 'src/Hero'
require 'src/Background'
require 'src/LevelCreator'

-- graphics
textures={
    ['background']=love.graphics.newImage('graphics/background.png'),
    ['hero'] = love.graphics.newImage('graphics/hero.png'),
    ['tiles']=love.graphics.newImage('graphics/environment.png')
}

quads={
    ['tile']        = love.graphics.newQuad( 0, 0, 40, 40, textures['tiles'] ),
    ['topper']      = love.graphics.newQuad(40, 0, 40, 40, textures['tiles'] ),
    ['spikes']      = love.graphics.newQuad(80, 0, 40, 40, textures['tiles'] ),
    ['bloodySpikes']= love.graphics.newQuad(120, 0, 40, 40, textures['tiles'] ),
    ['?']           = love.graphics.newQuad(160, 0, 40, 40, textures['tiles'] ),
    ['breakBlock1'] = love.graphics.newQuad(200, 0, 40, 40, textures['tiles'] ),
    ['breakBlock2'] = love.graphics.newQuad(240, 0, 40, 40, textures['tiles'] ),
    ['breakBlock3'] = love.graphics.newQuad(280, 0, 40, 40, textures['tiles'] ),
    ['heart']       = love.graphics.newQuad(320, 0, 40, 40, textures['tiles'] ),
    ['halfHeart']   = love.graphics.newQuad(360, 0, 40, 40, textures['tiles'] ),
    ['goldRing']    = love.graphics.newQuad(400, 0, 40, 40, textures['tiles'] )
}

heroQuads={
    [1] = love.graphics.newQuad( 0, 0, 268, 257, textures['hero']),
    [2] = love.graphics.newQuad(268, 0, 268, 257, textures['hero']),
    [3] = love.graphics.newQuad(536, 0, 268, 257, textures['hero']),
    [4] = love.graphics.newQuad(804, 0, 268, 257, textures['hero']),
    [5] = love.graphics.newQuad(1072, 0, 260, 257, textures['hero'])
}