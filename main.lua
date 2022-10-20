require 'src/dependencies'

function love.load()
    -- physics world
    world = love.physics.newWorld(0, 900, true)
    love.physics.setMeter(64)
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    
    math.randomseed(love.timer.getTime())

    -- screen setup
    love.window.setMode(1280, 720, {resizable=False})
    love.window.setTitle('The Adventures of Portos')

    -- keylogger
    love.keyboard.keysPressed = {}

    -- states
    gameState = StateMachine({
        ['title'] = TitleState(),
        ['play'] = PlayState()
    })
    gameState:change('title')

    
    
end

function beginContact(a, b, coll)
    a:getBody():setLinearVelocity(-1000,-1000)
end

function endContact(a, b, coll)
    text = 2
end

function love.update(dt)
    world:update(dt)
    if love.keyboard.isDown('left') then
        love.keyboard.keysPressed['left'] = true
    end
    if love.keyboard.isDown('right') then
        love.keyboard.keysPressed['right'] = true
    end
    gameState:update(dt)
    love.keyboard.keysPressed = {}
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