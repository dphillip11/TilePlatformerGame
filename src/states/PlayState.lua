

PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0
     -- -- physics world
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 1000, true)
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    level=Level(300, 18)
    background = Background{}
    hero = Hero(level)
    healthbar=PlayerHealth(6) 
end


function PlayState:update(dt)

    if  love.keyboard.wasPressed('m') then
        gameState:change('levelMaker',level)
    end
    world:update(dt)
    level:update(dt)
    hero:update(dt)
    background:update(dt)

    SCROLL_X = math.max(0,hero.body:getX() - (VIEWPORT_WIDTH / 2) + (hero.width/2))
    SCROLL_Y = math.min(level.rows * 40 - VIEWPORT_HEIGHT, hero.body:getY() - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
    
    if healthbar.health == 0 or hero.body:getY() > level.rows * 40 then
        gameState:change('gameover', level)
    end

end

function PlayState:enter(new_level)
    if new_level then 
        level = new_level
    end

    for i = 1, level.columns do
        for j = 1,level.rows do
            if level.tileMap[i][j] ~= 0 then
                level.tileMap[i][j]:addBody()
            end
        end
    end

    hero:addBody()
    for _, entity in pairs(level.entities) do
        entity:addBody()
    end
end


function PlayState:render()
    background:render()
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    level:render()
    hero:render()
    love.graphics.printf("'m' to enter Level Maker",20,0,350, 'left')
    love.graphics.translate(math.floor(SCROLL_X), math.floor(SCROLL_Y))
    healthbar:render()
    
    
end










