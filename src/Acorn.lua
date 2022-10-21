Acorn = Class{}

function Acorn:init(x,y)
self.x = x
self.y = y
self.timer=0
self.pause= math.random(0,2)
self.dy= -math.abs(hero.body:getX()-self.x)
self.dx= (hero.body:getX()-self.x)/2
end

function Acorn:update(dt)
self.timer = self.timer + dt
if self.timer > self.pause then
    self.y = self.y + (self.dy*dt)
    self.dy = self.dy + (500*dt)
    self.x = self.x + (self.dx*dt)
end
end

function Acorn:render()
    love.graphics.draw(textures['squirrel'], quads['acorn'], self.x-16,self.y-21, 0, 0.3,0.3)
end