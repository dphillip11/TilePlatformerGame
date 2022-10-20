Entity = Class{}

function Entity:init(def)
    -- define physical atributes
    self.responsive = false
    self.x = 0 or (def.indexX - 1) * 40 
    self.y = 0 or (def.indexY - 1) * 40 
    self.dx = def.dx or 0
    self.dy = def.dy or 0
    self.texture = def.texture or textures['hedgehog']
    self.quads = def.quads or hedgehogQuads
    _,_,self.qWidth, self.qHeight = self.quads[1]:getViewport( )
    self.scaleX = def.scale or 1
    self.scaleY = def.scale or 1
    self.height = self.qHeight*self.scaleY or 40
    self.width = self.qWidth*self.scaleY or 40
    self.frame = 1
    self.onScreen = 0
    self.state = def.state or StateMachine{
        ['idle'] = IdleState{object=self, frames=def.frames},
        ['walking'] = WalkingState{object=self, frames=def.frames},
        ['jumping'] = JumpingState{object=self, frames=def.frames},
        ['falling'] = FallingState{object=self, frames=def.frames}
    }
    self.state:change('idle')
    self.tileCollisions ={}
end


function Entity:update(dt)
    if self.onScreen then
        self.dy = self.dy + GRAVITY

        -- create list of collisions
        self.tileCollisions = level:collision(self)

        -- adjust position
        AdjustPosition(self, self.tileCollisions, dt)

        -- update state collision choices
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
    if self.x > -100 + SCROLL_X and self.x < VIEWPORT_WIDTH + 100 + SCROLL_X and self.y > SCROLL_Y - 100 and self.y < SCROLL_Y + VIEWPORT_HEIGHT + 100 then
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










