Hero = Class{}

function Hero:init()
    self.y=0
    _,_,self.qWidth, self.qHeight = heroQuads[1]:getViewport( )
    self.scale = HERO_SCALE
    self.height = self.qHeight * self.scale
    self.width = self.qWidth * self.scale
    self.x=(VIEWPORT_WIDTH / 2) - (self.width /2)
    self.dx=0
    self.dy=0
    self.timer=0
    self.animationInterval = 1 / ANIMATION_SPEED
    self.skin=1
    -- compass direction, north oriented upwards
    self.directionY = 'S'
    self.directionX = 'E'
    HERO_OFFSET = (VIEWPORT_WIDTH / 2) - (self.width /2)
    SCROLL_X = (VIEWPORT_WIDTH / 2) - (self.width /2)
      
end

function Hero:update(dt)
    --update animation timer
    self.timer = self.timer + dt

    self.dx = 0

    -- collect keyboard input
    if love.keyboard.wasPressed('up') then
        self.dy = -HERO_JUMP
    end
    if love.keyboard.wasPressed('left') then
        self.dx = -HERO_SPEED
        self.directionX = 'W'
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 6) + 1
            self.timer=0
        end
    end
    if love.keyboard.wasPressed('right') then
        self.dx = HERO_SPEED
        self.directionX = 'E'
        if self.timer > self.animationInterval then
            self.skin = (self.skin % 6) + 1
            self.timer=0
        end
    end
    -- try move y
    self.y = self.y + (self.dy * dt)
    -- if collide then unmove, cancel speed
    -- set direction to determine collision response
    if self.dy > 0 then
        self.directionY = 'S'
    else
        self.directionY = 'N'
    end
    if level:collision(self) then
        self.y = self.y - (self.dy * dt)
        self.dy = 0
    end
    --try x move
    self.x = self.x + (self.dx * dt)
    --if collide, unmove, reset speed
    if level:collision(self) then
        self.x = self.x - (self.dx * dt)
        self.dx = 0
    end
     --check for ground
     self.y = self.y + (GRAVITY * dt)
     -- if collide then unmove, cancel speed
     self.directionY = 'S'
     if level:collision(self) then
         self.y = self.y - (GRAVITY * dt)
         self.dy = 0
     else
        self.dy = self.dy + GRAVITY
     end

    SCROLL_X = (VIEWPORT_WIDTH / 2) - (self.width /2) - self.x
end

function Hero:render()
    if self.directionX == 'W' then
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x + SCROLL_X, self.y, 0, self.scale, self.scale)
    else 
        love.graphics.draw(textures['hero'], heroQuads[self.skin], self.x + self.width + SCROLL_X, self.y, 0, -self.scale, self.scale)
    end
end
