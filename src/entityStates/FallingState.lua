FallingState = Class{__includes = BaseState}

function FallingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    self.object.currentState ='falling'
end

function FallingState:update(dt) 
    self.animation:update(dt)

    if self.object.type == 'hero' and self.object.collisions['down'] then
        for _, tile in pairs(self.object.collisions['down']) do
            if tile.type == 'spikes' or tile.type == 'bloodySpikes' or tile.type == 'breakBlock1' or tile.type == 'breakBlock2'or tile.type == 'breakBlock3' then
                tile:collide()
                healthbar.hit = 1
            end
        end
    end
    
    self.object.frame = self.animation:getFrame()
    if self.object.dy < -2 then
        self.object.state:change('jumping')
    end
    if self.object.dy == 0 then
        if math.abs(self.object.dx) > 2 then
            self.object.state:change('walking')
        else
            self.object.state:change('idle')
        end
    end
end



