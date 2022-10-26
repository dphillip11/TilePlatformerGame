HeroInput = Class{}

function HeroInput:init(hero)
    self.object = hero
end

function HeroInput:update(dt)
    if love.keyboard.isDown("right") then
        self.object.dx = HERO_SPEED
        
    elseif love.keyboard.isDown("left") and self.object.x > 30 then
        self.object.dx = -HERO_SPEED
    else
        self.object.dx = 0
    end
    -- if math.abs(self.object.dy)<5 and 
    if (love.keyboard.keysPressed['up'] == true or love.keyboard.keysPressed['space'] == true) and (self.object.currentState == 'walking' or self.object.currentState == 'idle') then 
        self.object.dy = -750
    end
    
end

