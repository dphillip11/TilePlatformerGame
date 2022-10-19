PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0

    background = Background{}
    level=LevelCreator(300, 18)
    hero = Hero(level)
    healthbar=PlayerHealth(6)
end


function PlayState:update(dt)
    level:update(dt)
    hero:update(dt)
    background:update(dt)
    -- level:update(dt)
    SCROLL_X = math.max(0,hero.x - (VIEWPORT_WIDTH / 2) + (hero.width/2))
    SCROLL_Y = math.min(0,hero.y - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
end


function PlayState:render()
    background:render()
    healthbar:render()
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    level:render()
    hero:render()
    
end

