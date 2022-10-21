require 'src/CollisionCallbacks'

PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0

    -- physics world
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 900, true)
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )
   
    background = Background{}
    hero = Hero(level)
    level=Level(300, 18)
    
    healthbar=PlayerHealth(6) 
end


function PlayState:update(dt)
    world:update(dt)
    level:update(dt)
    hero:update(dt)
    background:update(dt)

    SCROLL_X = math.max(0,hero.body:getX() - (VIEWPORT_WIDTH / 2) + (hero.width/2))
    SCROLL_Y = math.min(level.rows * 40 - VIEWPORT_HEIGHT, hero.body:getY() - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
    
    if healthbar.health == 0 or hero.body:getY() > level.rows * 40 then
        gameState:change('gameover')
    end

end


function PlayState:render()
    background:render()
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    level:render()
    hero:render()
    love.graphics.translate(math.floor(SCROLL_X), math.floor(SCROLL_Y))
    healthbar:render()
    
end










