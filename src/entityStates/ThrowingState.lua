ThrowingState = Class{__includes = BaseState}

function ThrowingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    self.acorn = Acorn(self.object.body:getX(), self.object.body:getY())
end

function ThrowingState:update(dt)
    self.object.setLinearVelocity = 0
    self.acorn:update(dt)
    self.animation:update(dt)
end

function ThrowingState:render()
    self.acorn:render()
end
