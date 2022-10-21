Acorn = Class{}

function Acorn:init(x,y)
self.x = x
self.y = y
self.timer=0
self.pause= math.random(0,2)
self.dy= -math.abs(hero.body:getX()-self.x)
self.dx= (hero.body:getX()-self.x)/2
self.active=1
end

function Acorn:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.pause then
        self.y = self.y + (self.dy*dt)
        self.dy = self.dy + (500*dt)
        self.x = self.x + (self.dx*dt)
    end
    if  self.active==1 then
        if hero.fixture:testPoint(self.x, self.y) or hero.fixture:testPoint(self.x+32, self.y) or hero.fixture:testPoint(self.x, self.y+32) or hero.fixture:testPoint(self.x+32, self.y+32) then
            healthbar.health = healthbar.health - 1
            self.active=0
        end
    end
    -- if  self.x < SCROLL_X - VIEWPORT_WIDTH/2 - 50 or
        -- self.x > SCROLL_X + VIEWPORT_WIDTH/2 or
        if self.y > VIEWPORT_HEIGHT then
        -- if self.y < SCROLL_Y - VIEWPORT_HEIGHT/2 -50 then
            self.active=0
    end

end

function Acorn:render()
    love.graphics.draw(textures['squirrel'], quads['acorn'], self.x-16,self.y-21, 0, 0.3,0.3)
end