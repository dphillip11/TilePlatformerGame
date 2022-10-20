IdleState = Class{__includes = BaseState}

function IdleState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
end

function IdleState:update(dt)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if math.abs(self.object.dx) > 2 and math.abs(self.object.dy) < 2 then
        self.object.state:change('walking')
    end
    if self.object.dy < -2 then
        self.object.state:change('jumping')
    end
    if self.object.dy > 2 then
        self.object.state:change('falling')
    end
end



