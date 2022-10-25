
Heart = Class{__includes = Entity}
function Heart:init(x_, y_)
    Entity.init(heartProperties(self, x_, y_))
    self.state:change('moving')
    self.active=1
end

function Heart:update(dt)
    if self.body and self.active==1 then
        Entity.update(self, dt)
    end
end

function Heart:render()
    if self.active==1 then
        Entity.render(self)
    end
end

function Heart:collide()
    self.active = 0 
    healthbar.health= math.min(6,healthbar.health+1)

end

function Heart:addBody()  
    -- physical properties
    self.body = love.physics.newBody( world, self.x - self.width/2, self.y- self.height/2, 'dynamic')
    self.shape = love.physics.newRectangleShape(self.width-4,self.height-1)
    self.fixture = love.physics.newFixture( self.body, self.shape)
    self.fixture:setFriction(1)
    self.fixture:setUserData(self)
    self.body:setLinearVelocity(math.random(-200,200),math.random(0,-300))
end
