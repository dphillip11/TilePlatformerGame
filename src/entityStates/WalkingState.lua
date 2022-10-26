WalkingState = Class{__includes = BaseState}

function WalkingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    self.object.currentState ='walking'
end

function WalkingState:update(dt)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()

    if self.object.type == 'hero' and self.object.collisions['down'] then
        for _, tile in pairs(self.object.collisions['down']) do
            if tile.type == 'spikes' or tile.type == 'bloodySpikes' or tile.type == 'breakBlock1' or tile.type == 'breakBlock2'or tile.type == 'breakBlock3' then
                tile:collide()
                healthbar.hit = 1
            end
        end
    end
        
    if self.object.dy > 2 then
        self.object.state:change('falling')
    end
    if self.object.dy < -2 then
        self.object.state:change('jumping')
    end
    if math.abs(self.object.dx) < 2 then
        self.object.state:change('idle')
    end

end
