Class = require 'lib/class'
require 'src/constants'

-- utilities
require 'src/util'

-- classes
require 'src/Acorn'
require 'src/Hero'
require 'src/Hedgehog'
require 'src/Squirrel'
require 'src/Background'
require 'src/LevelMaker'
require 'src/Level'
require 'src/Tile'
require 'lib/StateMachine'
require 'src/PlayerHealth'

-- components
require 'src/components/Glide'
require 'src/components/Entity'
require 'src/components/BaseState'
require 'src/components/Animation'
require 'src/components/HeroInput'
require 'src/components/ChasingAvoidingInput'

-- physics callbacks
require 'src/CollisionCallbacks'

-- states
require 'src/states/TitleState'
require 'src/states/PlayState'
require 'src/states/GameOverState'
require 'src/states/LevelCreatorState'

-- entityStates
require 'src/entityStates/FallingState'
require 'src/entityStates/JumpingState'
require 'src/entityStates/WalkingState'
require 'src/entityStates/IdleState'
require 'src/entityStates/squirrelStates/ThrowingState'
require 'src/entityStates/squirrelStates/EscapingState'
require 'src/entityStates/squirrelStates/SqFallingState'
require 'src/entityStates/squirrelStates/SqJumpingState'

-- properties
require 'src/properties/heroProperties'
require 'src/properties/hedgehogProperties'
require 'src/properties/squirrelProperties'

-- graphics
textures={
    ['background'] = {
        ['jungle'] = love.graphics.newImage('graphics/jungleworldrepeat.png'),
        ['mountains'] = love.graphics.newImage('graphics/background.png')
    },
    ['midground'] = {
        ['jungle']={
            [1]=love.graphics.newImage('graphics/junglebackground1.png'),
            [2]=love.graphics.newImage('graphics/junglebackground2.png'),
            [3]=love.graphics.newImage('graphics/junglebackground3.png')
        }
    },
    ['grass'] = love.graphics.newImage('graphics/jungleground.png'),
    ['hero'] = love.graphics.newImage('graphics/hero.png'),
    ['squirrel'] = love.graphics.newImage('graphics/squirrel.png'),
    ['hedgehog'] = love.graphics.newImage('graphics/hedgehog.png'),
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
    ['thin'] = love.graphics.newFont('fonts/thin.ttf', 100),
    ['small'] = love.graphics.newFont('fonts/arial.ttf', 30)
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
    ['goldRing']    = love.graphics.newQuad(400, 0, 40, 40, textures['tiles'] ),
    ['acorn'] = love.graphics.newQuad(2028, 432, 108, 139, textures['squirrel']) 
}

heroQuads={
    [1] = love.graphics.newQuad( 0, 0, 268, 257, textures['hero']),
    [2] = love.graphics.newQuad(268, 0, 268, 257, textures['hero']),
    [3] = love.graphics.newQuad(536, 0, 268, 257, textures['hero']),
    [4] = love.graphics.newQuad(804, 0, 268, 257, textures['hero']),
    [5] = love.graphics.newQuad(1072, 0, 260, 257, textures['hero']) 
}

hedgehogQuads={
    [1] = love.graphics.newQuad( 0, 0, 514, 500, textures['hedgehog']),
    [2] = love.graphics.newQuad(514, 0, 514, 500, textures['hedgehog']),
    [3] = love.graphics.newQuad(1028, 0, 514, 500, textures['hedgehog']),
    [4] = love.graphics.newQuad(1542, 0, 514, 500, textures['hedgehog'])
}

squirrelQuads={
    [1] = love.graphics.newQuad( 0, 0, 507, 571, textures['squirrel']),
    [2] = love.graphics.newQuad(507, 0, 507, 571, textures['squirrel']),
    [3] = love.graphics.newQuad(1014, 0, 507, 571, textures['squirrel']),
    [4] = love.graphics.newQuad(1521, 0, 507, 571, textures['squirrel']),
}
    