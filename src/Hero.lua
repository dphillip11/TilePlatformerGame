Hero = Class{}

function Hero:init()
    self.x=HERO_OFFSET_X
    self.y=HERO_OFFSET_Y
    _,_,self.qWidth, self.qHeight = heroQuads[1]:getViewport( )
    self.scale = 0.3
    self.height = self.qHeight * self.scale
    self.width = self.qWidth * self.scale
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

    self.dy = self.dy + (GRAVITY*dt)

    if self.y > 480 then 
        self.dy = 0
        self.y = 480
    end
    
    if love.keyboard.wasPressed('up')then
        self.dy = -1000
    end  
    
    self.y = self.y + (self.dy*dt)/2
    
    if love.keyboard.wasPressed('right') then
        self.direction = 'E'
        self.x = self.x + (self.dx * dt)
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 5) + 1
            self.timer=0
        end
    end
    if love.keyboard.wasPressed('left') then
        self.direction = 'W'
        self.x = math.max(0,self.x - (self.dx * dt))
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 5) + 1
            self.timer=0
        end
    end
end

function Hero:render()
    if self.direction == 'W' then
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x, self.y, 0, self.scale, self.scale)
    else
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x + self.width, self.y, 0, -self.scale, self.scale)
    end
    love.graphics.print(self.y)
end
