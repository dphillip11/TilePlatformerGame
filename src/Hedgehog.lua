
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




