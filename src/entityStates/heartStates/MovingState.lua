MovingState = Class{__includes = BaseState}

function MovingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames, interval=0.2}
    self.time= math.random(1,4)
    self.timer = 0

end

function MovingState:update(dt)
    self.timer = self.timer + dt
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()

    if self.object.active == 1 and self.timer > self.time then
        self.object.active = 0
    end
end