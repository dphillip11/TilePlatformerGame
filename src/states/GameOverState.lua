GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.timer = 0
    self.period = 3
end

function GameOverState:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > self.period then
        saveTileMap(self.level, 'tilemap1.csv')
        world:destroy()
        gameState:change('play', self.level)
    end
    if  love.keyboard.wasPressed('m') then
        gameState:change('levelMaker',self.level)
    end
end

function GameOverState:enter(level)
    self.level = level
end


function GameOverState:render()
    -- draw background field
    love.graphics.setColor(1,1,1)
    love.graphics.draw(textures['field'])
    love.graphics.print('GAMEOVER')
end


