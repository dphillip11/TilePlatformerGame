Hero = Class{}

function Hero:init()
    self.y=0
    _,_,self.qWidth, self.qHeight = heroQuads[1]:getViewport( )
    self.scale = 0.3
    self.height = self.qHeight * self.scale
    self.width = self.qWidth * self.scale
    self.x=(VIEWPORT_WIDTH / 2) - (self.width /2)
    self.dx=HERO_SPEED
    self.dy=0
    self.timer=0
    self.animationInterval = 1 / ANIMATION_SPEED
    self.skin=1
    -- compass direction, north oriented upwards
    self.direction='E'
    HERO_OFFSET = (VIEWPORT_WIDTH / 2) - (self.width /2)
      
end

function Hero:update(dt)
    
    self.timer = self.timer + dt

    self.dy = self.dy + (GRAVITY*dt)

    if self.dy > 0 and level:collision(self) then
        -- self.y = self.y - self.dy
        self.dy = 0
        self.direction = nil
    end
    
    if love.keyboard.wasPressed('up') and self.dy == 0 then
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
        self.x = self.x - (self.dx * dt)
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 5) + 1
            self.timer=0
        end
    end
    SCROLL_X = (VIEWPORT_WIDTH / 2) - (self.width /2) - self.x
end

function Hero:render()
    if self.direction == 'W' then
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x + SCROLL_X, self.y, 0, self.scale, self.scale)
    else 
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x + self.width + SCROLL_X, self.y, 0, -self.scale, self.scale)
    -- else
    --     love.graphics.draw(textures['dogDig1'], self.x + self.width + SCROLL_X, self.y, 0, -self.scale, self.scale)
    end
end
