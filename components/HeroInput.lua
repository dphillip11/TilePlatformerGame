HeroInput = Class{}

function HeroInput:init(hero)
    self.object = hero
end

function HeroInput:update(dt)
    if love.keyboard.isDown('left') then
        self.object.dx = - HERO_SPEED
    elseif love.keyboard.isDown('right') then
        self.object.dx = HERO_SPEED
    else
        self.object.dx = 0
    end
    
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('space') then
        self.object.dy = -HERO_JUMP
    end
end