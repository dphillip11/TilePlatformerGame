Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval or 1/ANIMATION_SPEED 
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.interval then
        self.timer = 0
        self.currentFrame = (self.currentFrame % #self.frames) + 1
    end
end

function Animation:getFrame()
    return self.frames[self.currentFrame]
end
