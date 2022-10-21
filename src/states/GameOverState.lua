GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.timer = 0
    self.period = 3
end

function GameOverState:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > self.period then
        world:destroy()
        love.physics.setMeter(64)
        world = love.physics.newWorld(0, 1000, true)
        world:setCallbacks( beginContact, endContact, preSolve, postSolve )
        gameState:change('play')
    end
end
    

function GameOverState:render()
    -- draw background field
    love.graphics.setColor(1,1,1)
    love.graphics.draw(textures['field'])
    love.graphics.print('GAMEOVER')
end


