SqFallingState = Class{__includes = BaseState}

function SqFallingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    
end

function SqFallingState:update(dt) 
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.dy < 2 then
        self.object.state:change('escaping')
    end
end



