require 'src/dependencies'

function love.load()
     
     
    inPlay = 0
    math.randomseed(love.timer.getTime())

    -- screen setup
    love.window.setMode(1280, 720, {resizable=False})
    love.window.setTitle('The Adventures of Portos')

    -- keylogger
    love.keyboard.keysPressed = {}
    mouseLog = {}
    mouseScrollLog=0

    -- states
    gameState = StateMachine({
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end,
        ['levelMaker'] = function() return LevelCreatorState() end,
        ['win'] = function() return WinState() end
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
    mouseScrollLog=0
end


function love.draw()
    gameState:render()
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

function love.mousepressed(x,y, button)
    mouseLog['x']=x
    mouseLog['y']=y
    mouseLog['button']=button
end

function mouseClicked()
    if love.mouse.isDown(1) then
        x,y = love.mouse.getPosition()
        return x, y ,1
    end
    if love.mouse.isDown(2) then
        x,y = love.mouse.getPosition()
        return x, y, 2
    end
    if mouseLog['x'] and mouseLog['y'] then
        return mouseLog['x'],mouseLog['y'],mouseLog['button']
    else
        return false
    end
end

function love.wheelmoved(x, y)
    mouseScrollLog=y
end