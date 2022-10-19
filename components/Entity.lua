Entity = Class{}

function Entity:init(def)
    -- define physical atributes
    self.responsive = false
    self.x = 0 or (def.indexX - 1) * 40 
    self.y = 0 or (def.indexY - 1) * 40 
    self.dx = def.dx or 0
    self.dy = def.dy or 0
    self.height = def.height or 40
    self.width = def.width or 40
    self.scaleX = def.scaleX or 1
    self.scaleY = def.scaleY or 1
    self.texture = def.texture or textures['tile']
    self.quads = def.quads or quads
    self.frame = 1
    self.onScreen = 0
    self.state = def.state or StateMachine{
        ['idle'] = IdleState{object=self, frames={1}},
        ['walking'] = WalkingState{object=self, frames={1}},
        ['jumping'] = JumpingState{object=self, frames={1}},
        ['falling'] = FallingState{object=self, frames={1}}
    }
    self.state:change('idle')
end


function Entity:update(dt)
    if self.onScreen then
        level:collision(self, self.responsive)
        self.state:update(dt)
        
        if self.dx < 0 then 
            self.scaleX = -self.scaleY
        end
        if self.dx > 0 then 
            self.scaleX = self.scaleY
        end 
        self.x = self.x + (self.dx * dt)
        self.y = self.y + (self.dy * dt)
    end
    if self.x > -50 and self.x < VIEWPORT_WIDTH then
        self.onScreen = 1
    else
        self.onScreen = 0
    end
end


function Entity:render()
    if self.onScreen == 1 then
        self.state:render() 
        love.graphics.draw(self.texture, self.quads[self.frame], self.x + (self.scaleX<0 and self.width or 0), self.y, 0, self.scaleX, self.scaleY)
    end
end










