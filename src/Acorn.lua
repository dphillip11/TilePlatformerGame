Acorn = Class{}

function Acorn:init(x,y)
self.x = x
self.y = y
self.timer=0
self.pause= math.random(0,1)
self.decay=2
self.dy= -math.abs(hero.x-self.x)
self.dx= (hero.x-self.x)/2
self.active=1
self.width=32
self.height = 32
end

function Acorn:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.pause then
        self.y = self.y + (self.dy*dt)
        self.dy = self.dy + (500*dt)
        self.x = self.x + (self.dx*dt)
    end
    if self.timer > self.decay then
        self.active = 0
    end
    if  self.active==1 then
        if hero.x + hero.width > self.x and hero.x < self.x + self.width and self.y < hero.y + hero.height and self.y + self.height > hero.y then
            healthbar.hit = 1
            self.active=0
        end
    end
    if  self.x < SCROLL_X - VIEWPORT_WIDTH/2 - 50 or self.x > SCROLL_X + VIEWPORT_WIDTH/2 or self.y > VIEWPORT_HEIGHT + SCROLL_Y or self.y < SCROLL_Y - VIEWPORT_HEIGHT/2 -50 then
            self.active=0
    end

end

function Acorn:render()
    love.graphics.draw(textures['squirrel'], quads['acorn'], self.x,self.y, 0, 0.3,0.3)
end