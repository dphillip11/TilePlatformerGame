Hero = Class{}
    -- __includes = Entity}

function Hero:init()
    self.x=0
    self.y=0

    _,_,self.qWidth, self.qHeight = heroQuads[1]:getViewport( )
    self.scaleX = HERO_SCALE
    self.scaleY = HERO_SCALE
    self.height = self.qHeight * self.scaleY
    self.width = self.qWidth * self.scaleX
    
    self.dx=0
    self.dy=0

    self.state = StateMachine{
        ['idle'] = IdleState{object=self, frames={1}},
        ['walking'] = WalkingState{object=self, frames={1,2,1,3,1,4,1,5}},
        ['jumping'] = JumpingState{object=self, frames={2,3,4,5}},
        ['falling'] = FallingState{object=self, frames={2,3,4,5}}
    }
    self.state:change('idle')

    self.input = HeroInput(self)
    self.frame = 1
end

function Hero:update(dt)
    self.input:update(dt)
    self.state:update(dt)
    level:collision(self)
    if self.dx < 0 then 
        self.scaleX = -self.scaleY
    end
    if self.dx > 0 then 
        self.scaleX = self.scaleY
    end
    self.x = self.x + (self.dx * dt)
    self.y = self.y + (self.dy * dt)
end

function Hero:render()
    self.state:render() 
    love.graphics.setFont(fonts['small'])
    love.graphics.draw(textures['hero'], heroQuads[self.frame], self.x + (self.scaleX<0 and self.width or 0), self.y, 0, self.scaleX, self.scaleY)
end
