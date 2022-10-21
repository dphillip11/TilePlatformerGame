ThrowingState = Class{__includes = BaseState}

function ThrowingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames, interval=0.4}
    self.acorn = Acorn(self.object.body:getX(), self.object.body:getY())
    table.insert(self.object.acorns, self.acorn)
    self.throwing = 1
end

function ThrowingState:update(dt)
    self.object.body:setLinearVelocity(0,0)
    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
    if self.acorn.active==0 then
        self.throwing = 0
    end
    if self.throwing == 0 and math.random(0,100)>95 then
        self.throwing = 1
        self.acorn = Acorn(self.object.body:getX(), self.object.body:getY())
        table.insert(self.object.acorns, self.acorn)
    end
    x, y = self.object.body:getPosition()
    heroX, heroY = hero.body:getPosition()
    if self.throwing == 0 and  math.abs(heroX - x)< 400 and math.abs(heroY - y) < 200 then
        self.object.state:change('escaping')
    end
end






