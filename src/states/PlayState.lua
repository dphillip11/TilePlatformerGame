

PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0
     -- -- physics world
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 1000, true)
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    level=Level(100, 18)
    background = Background{}
    hero = Hero()
    healthbar=PlayerHealth(6)
    particleX=0
    particleY=0
end


function PlayState:update(dt)

        world:update(dt)
        level:update(dt)
        hero:update(dt)
        background:update(dt)
        psystem:update(dt)

        SCROLL_X = math.max(0,hero.body:getX() - (VIEWPORT_WIDTH / 2) + (hero.width/2))
        SCROLL_Y = math.min(level.rows * 40 - VIEWPORT_HEIGHT, hero.body:getY() - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
        
        if healthbar.health == 0 or hero.body:getY() > level.rows * 40 then
            inPlay = 0
            saveLevel(level,'temp')
            level = loadLevel('temp')
            gameState:change('gameover', level)
        end

end

function PlayState:enter(new_level)
    inPlay = 1
    if new_level then 
        level = new_level
    end

    hero.x = level.heroX
    hero.y = level.heroY
    

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
    BACKGROUND_Y_OFFSET = (level.rows -18)*40
end


function PlayState:render()
    background:render()
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    level:render()
    love.graphics.draw(psystem,particleX,particleY) 
    hero:render()    
    love.graphics.translate(math.floor(SCROLL_X), math.floor(SCROLL_Y))
    healthbar:render()
end










