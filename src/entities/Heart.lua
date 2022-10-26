
Heart = Class{__includes = Entity}
function Heart:init(x_, y_)
    Entity.init(heartProperties(self, x_, y_))
    self.state:change('moving')
    self.active=1
    self.frame='heart'
    self.dx = math.random(-100,100)
    self.dy = math.random(0,-1000)
end

function Heart:update(dt)
    Entity.update(self, dt)
end

function Heart:render()
    if self.active==1 then
        Entity.render(self)
    end
end

function Heart:collide()
    self.active = 0 
    healthbar.health= math.min(6,healthbar.health+1)

end

