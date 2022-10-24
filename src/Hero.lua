
Hero = Class{__includes = Entity}

function Hero:init()
    Entity.init(heroProperties(self))
    self.state:change('walking')
    self.input = HeroInput(self)
end

function Hero:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
end

function Hero:render()
    Entity.render(self)
end

function Hero:collide()
end

function Hero:addBody()  
    -- physical properties
    self.body = love.physics.newBody( world, self.x - self.width/2, self.y- self.height/2, 'dynamic')
    self.shape = love.physics.newRectangleShape(self.width-4,self.height-1)
    self.fixture = love.physics.newFixture( self.body, self.shape)
    self.fixture:setFriction(1)
    self.fixture:setUserData(self)
end


