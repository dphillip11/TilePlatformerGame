JumpingState = Class{__includes = BaseState}

function JumpingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
   
end

function JumpingState:update(dt)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.dy > 0 then
        self.object.state:change('falling')
    end
end



