PlayState = Class{__includes = BaseState}

function PlayState:init()
    SCROLL_X = 0
    SCROLL_Y = 0
    HERO_OFFSET = 0

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
    SCROLL_X = (VIEWPORT_WIDTH / 2) - (hero.width /2) - hero.x
    SCROLL_Y = math.max(0,(VIEWPORT_HEIGHT / 2) - (hero.height /2) - hero.y)
end


function PlayState:render()
    background:render()
    level:render()
    hero:render()
    healthbar:render()
end

