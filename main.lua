require 'src/dependencies'

function love.load()
    love.window.setMode(1280, 720, {resizable=False})
    hero = Hero()
    background = Background{}
    love.keyboard.keysPressed = {}
    level=LevelCreator(300)
end


function love.update(dt)
    hero:update(dt)
    background:update(dt)
    love.keyboard.keysPressed = {}
    -- update kyspressed, some bug meant asynchronous button presses were failing, logging down buttons seemed to fix it
    if love.keyboard.isDown('left') then
        love.keyboard.keysPressed['left'] = true
    end
    if love.keyboard.isDown('right') then
        love.keyboard.keysPressed['right'] = true
    end
    
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
    love.keyboard.keysPressed[key] = true

end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end