Hero = Class{__includes = Entity}

function Hero:init()

    _,_,self.qWidth, self.qHeight = heroQuads[1]:getViewport( )

    Entity.init(self, {
        state = StateMachine{
            ['idle'] = IdleState{object=self, frames={1}},
            ['walking'] = WalkingState{object=self, frames={1,2,1,3,1,4,1,5}},
            ['jumping'] = JumpingState{object=self, frames={2,3,4,5}},
            ['falling'] = FallingState{object=self, frames={2,3,4,5}}
        },
        scale = HERO_SCALE,
        texture = textures['hero'],
        quads = heroQuads,
    })
    -- reacts with tiles
    self.responsive = true
    self.input = HeroInput(self)

   
end

function Hero:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
    self.dx,self.dy = self.body:getLinearVelocity()
end

function Hero:render()
    Entity.render(self)
    love.graphics.setFont(fonts['small'])
    love.graphics.print(self.dx)
    love.graphics.print(math.floor(self.dy), 0, 20)
end


