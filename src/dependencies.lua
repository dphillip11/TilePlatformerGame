Class = require 'lib/class'
require 'src/constants'

-- classes
require 'src/Hero'
require 'src/Background'
require 'src/LevelCreator'
require 'src/Tile'
require 'lib/BaseState'
require 'lib/StateMachine'
require 'lib/Glide'
require 'lib/entity'

-- states
require 'src/states/TitleState'
require 'src/states/PlayState'

-- graphics
textures={
    ['background']=love.graphics.newImage('graphics/background.png'),
    ['hero'] = love.graphics.newImage('graphics/hero.png'),
    ['tiles']=love.graphics.newImage('graphics/environment.png'),
    ['jungle'] = love.graphics.newImage('graphics/jungle.png'),
    ['dogDig1'] = love.graphics.newImage('graphics/dogDig2.png'),
    ['field'] = love.graphics.newImage('graphics/titleImages/titleBackground.png'),
    ['flowers']= {
        [1] = love.graphics.newImage('graphics/titleImages/flowers1.png'),
        [2] = love.graphics.newImage('graphics/titleImages/flowers2.png'),
        [3] = love.graphics.newImage('graphics/titleImages/flowers3.png'),
        [4] = love.graphics.newImage('graphics/titleImages/flowers4.png'),
        [5] = love.graphics.newImage('graphics/titleImages/flowers5.png'),
        [6] = love.graphics.newImage('graphics/titleImages/flowers6.png'),
        [7] = love.graphics.newImage('graphics/titleImages/flowers7.png'),
        [8] = love.graphics.newImage('graphics/titleImages/flowers8.png')}
}

-- fonts
fonts = {
    ['thin'] = love.graphics.newFont('fonts/thin.ttf', 100)
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
    [3] = love.graphics.newQuad(1072, 0, 260, 257, textures['hero']),
    [4] = love.graphics.newQuad(536, 0, 268, 257, textures['hero']),
    [5] = love.graphics.newQuad(804, 0, 268, 257, textures['hero']),
    [6] = love.graphics.newQuad(1072, 0, 260, 257, textures['hero']),
    [7] = love.graphics.newQuad( 0, 0, 268, 257, textures['hero']),
    [8] = love.graphics.newQuad(268, 0, 268, 257, textures['hero'])   
}