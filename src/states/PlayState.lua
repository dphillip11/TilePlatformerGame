PlayState = Class{__includes = BaseState}

function PlayState:init()
    hero = Hero()
    background = Background{}
    level=LevelCreator(300)
end


function PlayState:update(dt)
    hero:update(dt)
    background:update(dt)
    
end


function PlayState:render()
    background:render()
    level:render()
    hero:render()
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

