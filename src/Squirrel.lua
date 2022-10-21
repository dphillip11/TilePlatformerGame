
Squirrel = Class{__includes = Entity}

function Squirrel:init(x_, y_, scale_)
    Entity.init(squirrelProperties(self, x_, y_, scale_))
    self.state:change('idle')
    self.input = ChasingAvoidingInput(self)
end

function Squirrel:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
    if love.keyboard.isDown('space') then
        self.state:change('throwing')
    end
end

function  Squirrel:render()
    Entity.render(self)
end




