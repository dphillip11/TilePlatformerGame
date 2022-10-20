FallingState = Class{__includes = BaseState}

function FallingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    
end

function FallingState:update(dt) 
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.object.dy < 0 then
        self.object.state:change('jumping')
    end
    if self.object.dy == 0 and #self.object.tileCollisions['down'] > 0 then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.object.state:change('walking')
        else
            self.object.state:change('idle')
        end
    end
end



