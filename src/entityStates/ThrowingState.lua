ThrowingState = Class{__includes = BaseState}

function ThrowingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}

    -- describe acorn physics
    self.acorn = {}
    self.acorn.type = 'acorn'
    self.acorn.body = love.physics.newBody(world, self.object.body:getX(),self.object.body:getY(), 'dynamic')
    self.acorn.shape = love.physics.newCircleShape(25)
    self.acorn.fixture = love.physics.newFixture( self.acorn.body, self.acorn.shape)
    self.acorn.fixture:setUserData(self.acorn)
end

function ThrowingState:update(dt)
    if self.acorn then
        self.object.body:setLinearVelocity(0,0)
    else
        self.object.state:change('idle')
    end
end

function ThrowingState:render()
    x1,y1 = self.acorn.body:getPosition()
    love.graphics.draw(textures['squirrel'], quads['acorn'], x1-25,y1-25, 0, 0.4,0.4)
end
