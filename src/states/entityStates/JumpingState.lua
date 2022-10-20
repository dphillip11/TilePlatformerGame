JumpingState = Class{__includes = BaseState}

function JumpingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
   
end

function JumpingState:update(dt)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.responsive and self.object.tileCollisions['up'] then
        for i, tile in pairs(self.object.tileCollisions['up']) do
            tile:collide()
        end
    end
    if self.object.dy > 2 then
        self.object.state:change('falling')
    end
end



