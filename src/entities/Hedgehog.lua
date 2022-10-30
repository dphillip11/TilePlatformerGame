
Hedgehog = Class{__includes = Entity}

function Hedgehog:init(x_, y_, scale_)
    Entity.init(hedgehogProperties(self, x_, y_, scale_))
    self.state:change('walking')
    self.input = ChasingAvoidingInput(self)
    self.active = 1
end

function Hedgehog:update(dt)
    Entity.update(self, dt)
    self.input:update(dt)
end

function Hedgehog:render()
    Entity.render(self)
end

function Hedgehog:collide(jumpFlag)
    if jumpFlag == 1 then
        if self.active == 1 then
            self.active = 0
            particleX=self.x + 20
            particleY=self.y + 20
            psystem:emit(50)
        end
    else
    healthbar.hit = 1
    end
end






