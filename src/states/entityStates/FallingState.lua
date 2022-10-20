FallingState = Class{__includes = BaseState}

function FallingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    
end

function FallingState:update(dt) 
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.dy < 2 then
        self.object.state:change('jumping')
    end
    if math.abs(self.object.dy)<2 then
        if math.abs(self.object.dx) > 2 then
            self.object.state:change('walking')
        else
            self.object.state:change('idle')
        end
    end
end



