
Hedgehog = Class{__includes = Entity}

function Hedgehog:init(x_, y_, scale_)
    Entity.init(hedgehogProperties(self, x_, y_, scale_))
    self.state:change('walking')
    self.input = ChasingAvoidingInput(self)
end

function Hedgehog:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
end

function Hedgehog:render()
    Entity.render(self)
end

function Hedgehog:collide()
end

function Hedgehog:addBody()  
    -- physical properties
    self.body = love.physics.newBody( world, self.x - self.width/2, self.y- self.height/2, 'dynamic')
    self.shape = love.physics.newRectangleShape(self.width-4,self.height-1)
    self.fixture = love.physics.newFixture( self.body, self.shape)
    self.fixture:setFriction(1)
    self.fixture:setUserData(self)
end




