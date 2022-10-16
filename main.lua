require 'src/dependencies'

function love.load()
    love.window.setMode(1280, 720, {resizable=False})
    hero = Hero()
    background = Background{}
    wasPressed={}
end


function love.update(dt)
    hero:update(dt)
    background:update(dt)
    wasPressed={}
    level=LevelCreator(10)
end


function love.draw()
    background:render()
    level:render()
    hero:render()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end


function love.keypressed(key)
    if key == 'return'then 
        love.event.quit()
    end
    -- keylogger
    wasPressed[key] = True
end