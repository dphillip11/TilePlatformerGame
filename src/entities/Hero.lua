
Hero = Class{__includes = Entity}

function Hero:init()
    Entity.init(heroProperties(self))
    self.state:change('walking')
    self.input = HeroInput(self)
end

function Hero:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
    
end

function Hero:render()
    Entity.render(self)
end

function Hero:collide()
end




