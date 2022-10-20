PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0

    background = Background{}
    level=Level(300, 18)
    hero = Hero(level)
    healthbar=PlayerHealth(6)
end


function PlayState:update(dt)
    level:update(dt)
    hero:update(dt)
    background:update(dt)
    -- level:update(dt)
    SCROLL_X = math.max(0,hero.body:getX() - (VIEWPORT_WIDTH / 2) + (hero.width/2))
    SCROLL_Y = math.min(level.rows * 40 - VIEWPORT_HEIGHT, hero.body:getY() - (VIEWPORT_HEIGHT / 2) + (hero.height/2))
end


function PlayState:render()
    background:render()
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    level:render()
    hero:render()
    love.graphics.translate(math.floor(SCROLL_X), math.floor(SCROLL_Y))
    healthbar:render()
    
end

