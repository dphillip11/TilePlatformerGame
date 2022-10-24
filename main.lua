require 'src/dependencies'

function love.load()
     
     
    
    math.randomseed(love.timer.getTime())

    -- screen setup
    love.window.setMode(1280, 720, {resizable=False})
    love.window.setTitle('The Adventures of Portos')

    -- keylogger
    love.keyboard.keysPressed = {}

    -- states
    gameState = StateMachine({
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end,
        ['levelMaker'] = function() return LevelCreatorState() end
    })
    gameState:change('title')

end


function love.update(dt)
    
    if love.keyboard.isDown('left') then
        love.keyboard.keysPressed['left'] = true
    end
    if love.keyboard.isDown('right') then
        love.keyboard.keysPressed['right'] = true
    end
    gameState:update(dt)
    love.keyboard.keysPressed = {}
    mouseLog = {}
end


function love.draw()
    gameState:render()
    if text then
        love.graphics.print(text,200,0)
    end
end


function love.keypressed(key)
    if key == 'escape'then 
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

function love.mousepressed(x,y)
    mouseLog['x']=x
    mouseLog['y']=y
end

function mouseClicked()
    if mouseLog['x'] and mouseLog['y'] then
        return mouseLog['x'],mouseLog['y']
    else
        return false
    end
end