WalkingState = Class{__includes = BaseState}

function WalkingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    
end

function WalkingState:update(dt)
    self.object.dy = self.object.dy + GRAVITY
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.dy > 0 then
        self.object.state:change('falling')
    end
    if self.object.dy < 0 then
        self.object.state:change('jumping')
    end
    if self.object.dx == 0 then
        self.object.state:change('idle')
    end
end

function WalkingState:render()
    love.graphics.print('W')
end
