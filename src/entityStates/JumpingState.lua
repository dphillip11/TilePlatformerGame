JumpingState = Class{__includes = BaseState}

function JumpingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames}
    self.object.currentState ='jumping'
end

function JumpingState:update(dt)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()

    if self.object.type == 'hero' and self.object.collisions['up'] then
        for _, tile in pairs(self.object.collisions['up']) do
            if tile.type == '?' or tile.type == 'breakBlock1' or tile.type == 'breakBlock2'or tile.type == 'breakBlock3' then
                tile:collide()
            end
        end
    end
    if self.object.dy > 0 then
        self.object.state:change('falling')
    end
    
end



