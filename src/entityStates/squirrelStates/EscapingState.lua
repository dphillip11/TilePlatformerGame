EscapingState = Class{__includes = BaseState}

function EscapingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames, interval=0.2}
end

function EscapingState:update(dt)
    self.object.body:setAngle(0)

    Vx, Vy = self.object.body:getLinearVelocity()
    x, y = self.object.body:getPosition()
    heroX, heroY = hero.body:getPosition()

    

    if math.abs(heroX - x)> 400 or math.abs(heroY - y) > 200 then
        self.object.state:change('throwing')
    else
        if heroX - x > 0 then
            self.object.body:setLinearVelocity(-200,Vy)
        else
            self.object.body:setLinearVelocity(200,Vy)
        end
    end
    if math.random(0,100)>90 and math.abs(Vy)< 5 then
        self.object.body:applyLinearImpulse( 0, -750 )
        self.object.state:change('jumping')
    end

    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
end