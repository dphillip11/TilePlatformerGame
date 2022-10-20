HeroInput = Class{}

function HeroInput:init(hero)
    self.object = hero
end

function HeroInput:update(dt)
    self.object.body:setAngle(0)
    _, Vy = self.object.body:getLinearVelocity()
    if love.keyboard.isDown("right") then
        self.object.body:setLinearVelocity(HERO_SPEED,Vy)
        
    elseif love.keyboard.isDown("left") then
        self.object.body:setLinearVelocity(-HERO_SPEED,Vy)
    else
        self.object.body:setLinearVelocity(0,Vy)
    end
    if love.keyboard.keysPressed['up'] == true and math.abs(Vy)<1 then 
        self.object.body:applyLinearImpulse( 0, -1000 )
    end
    
end

