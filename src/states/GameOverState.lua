GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:update(dt)
    if mouseClicked() then 
        x,y = mouseClicked()
        if x > 57.5 and x < 57.5 + 350 and y > 200 and y < 400 then
            gameState:change('play', self.level)
        end 
        if x > 465 and x < 465 + 350 and y > 200 and y < 400 then
            saveLevel(self.level, 'level.csv')
        end
        if x > 872.5 and x < 872.5 + 350 and y > 200 and y < 400 then
            gameState:change('levelMaker',self.level)
        end
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

    -- check boxes
    love.graphics.rectangle("fill", 57.5, 200, 350, 200)
    love.graphics.rectangle("fill", 465, 200, 350, 200)
    love.graphics.rectangle("fill", 872.5, 200, 350, 200)
    love.graphics.setColor(0,0,0)
    love.graphics.printf( 'Replay', 57.5,250, 350, 'center')
    love.graphics.printf( 'Save Level', 465,200, 350, 'center')
    love.graphics.printf( 'Level Maker', 872.5,200, 350, 'center')
end


