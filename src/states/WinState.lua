WinState = Class{__includes = BaseState}

function WinState:init()
    -- particle effects
explosion = love.graphics.newParticleSystem(textures['fluff'], 1000)
explosion:setParticleLifetime(5, 10) -- Particles live at least 2s and at most 5s.
explosion:setSizeVariation(1)
explosion:setEmissionRate(1000)
explosion:setLinearAcceleration(-100, -100, 100, 100) -- Random movement in all directions.
explosion:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.
explosion:setSizes(1,0.1,0.5,0.3)  
end

function WinState:update(dt)
    explosion:update(dt)
    if love.keyboard.wasPressed("return") then
        -- level = loadLevel('1')
        -- gameState:change('play', level)
        gameState:change('title', level)
    end   
end

function WinState:enter(squirrelCount)
    sq= "you killed all the squirrels. You barbarian!"
end

function WinState:exit()
    love.graphics.setFont(fonts['smallThin'])
end





function WinState:render()
    love.graphics.draw(explosion,math.sin(os.time()),2 * VIEWPORT_HEIGHT)
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fonts['thin'])
    love.graphics.printf(sq, 3,VIEWPORT_HEIGHT/2, VIEWPORT_WIDTH-6)
    love.graphics.printf(sq, 2,VIEWPORT_HEIGHT/2, VIEWPORT_WIDTH-6)
    love.graphics.printf(sq, 1,VIEWPORT_HEIGHT/2, VIEWPORT_WIDTH-6)
    love.graphics.setColor(0,1,1)
    love.graphics.printf(sq, 0,VIEWPORT_HEIGHT/2, VIEWPORT_WIDTH-6)
    love.graphics.setColor(1,1,1)
end


