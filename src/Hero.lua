Hero = Class{}

function Hero:init()
    self.x=0
    self.y=0
    self.dx=HERO_SPEED
    self.dy=0
    self.timer=0
    self.animationInterval = 1 / ANIMATION_SPEED
    self.skin=1
    -- compass direction, north oriented upwards
    self.direction='E'
end

function Hero:update(dt)
    self.timer = self.timer + dt
    if love.keyboard.isDown('right') then
        self.direction = 'E'
        self.x = self.x + (self.dx * dt)
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 5) + 1
            self.timer=0
        end
    end
    if love.keyboard.isDown('left') then
        self.direction = 'W'
        self.x = self.x - (self.dx * dt)
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 5) + 1
            self.timer=0
        end
    end
    if wasPressed['up'] == True then
        self.dy = - GRAVITY
    end
    if self.y > 0 then 
        self.dy = 0
        self.y = 0
    else
        self.dy = self.dy + GRAVITY
        self.y = self.y + (self.dy * dt )
    end
end

function Hero:render()
    if self.direction == 'W' then
        love.graphics.draw(textures['hero'][self.skin], VIEWPORT_WIDTH/2-180,VIEWPORT_HEIGHT/2 - 50,0,0.2,0.2)
    else
        love.graphics.draw(textures['hero'][self.skin], VIEWPORT_WIDTH/2+180,VIEWPORT_HEIGHT/2 -50, 0, -0.2,0.2)
    end
end
