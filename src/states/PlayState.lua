

PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0

    level=Level(100, 18)
    background = Background{}
    hero = Hero()
    healthbar=PlayerHealth(6)
    particleX=0
    particleY=0
end


function PlayState:update(dt)

     
        level:update(dt)
        hero:update(dt)
        background:update(dt)
        psystem:update(dt)
        healthbar:update(dt)

        SCROLL_X = math.max(0,hero.x - (VIEWPORT_WIDTH / 2) + (hero.width/2))
        SCROLL_Y = math.min(level.rows * 40 - VIEWPORT_HEIGHT, hero.y - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
        
        if healthbar.health == 0 or hero.y > level.rows * 40 then
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










