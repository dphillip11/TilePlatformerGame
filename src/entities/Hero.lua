
Hero = Class{__includes = Entity}

function Hero:init()
    Entity.init(heroProperties(self))
    self.state:change('walking')
    self.input = HeroInput(self)
end

function Hero:update(dt)
    self.input:update(dt)
    Entity.update(self, dt)
    for i,ent in pairs(self.entityCollisions['up']) do
        if ent.type == 'hedgehog' then
            ent:collide(1)  
        else
            ent:collide()
        end
    end
    for i,ent in pairs(self.entityCollisions['down']) do
        ent:collide()
    end
    for i,ent in pairs(self.entityCollisions['left']) do
        ent:collide()
    end
    for i,ent in pairs(self.entityCollisions['right']) do
        ent:collide()
    end
end

function Hero:render()
    Entity.render(self)
end

function Hero:collide()
end




