TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.timer = 0
    self.period = 1/ANIMATION_SPEED
    self.frame = 1

    -- set color offset for title colors
    color = {
        [1] = 0,
        [2] = 30,
        [3] = 60
    }
    self.colorTimer = 0

    -- initialise tweens for glide motion
    self.glides={
        ['x'] = Glide({0, VIEWPORT_WIDTH - 300}, 2, 'false','random'),
        ['y'] = Glide({100, VIEWPORT_HEIGHT - 300}, 2, 'false','random')}
    
    -- initialise coordinates for gliding animation
    self.x = 0
    self.y = 0
end

function TitleState:update(dt)
    -- gradually move though color range\
    for i, value in pairs(color) do
        color[i] = math.abs(math.sin(((i - 1) * 120) + self.colorTimer))
    end
    self.colorTimer = (self.colorTimer + (dt/3)) % 360
    tempX = self.x
    -- update animation coordinates
    self.x = self.glides['x']:update(dt)
    self.y = self.glides['y']:update(dt)
    -- update animation direction
    if self.x > tempX then
        self.direction = -1
    else
        self.direction = 1
    end
    -- update animation timer for foreground flowers
    self.timer = self.timer + dt
    if self.timer > self.period then
        self.timer = 0
        self.frame = self.frame % 8 + 1
    end
    -- allow 'return' or 'space' to start
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('space') then
        gameState:change('play')
    end
end

function TitleState:render()
    -- draw background field
    love.graphics.setColor(1,1,1)
    love.graphics.draw(textures['field'])
    
    -- render title text
    love.graphics.setFont(fonts['thin'])
    for i = 1, 5 do
        love.graphics.setColor(color[1], color[2], color[3])
        love.graphics.print("The Adventures of Portos", i, i)
        love.graphics.setColor(color[3], color[1], color[2])
        love.graphics.print("The Adventures of Portos",5 + i, 5 + i)
        love.graphics.setColor(color[2], color[3], color[1])
        love.graphics.print("The Adventures of Portos", 10 + i, 10 + i)
    end
    -- draw animation
    love.graphics.setColor(1,1,1)
    love.graphics.draw(textures['hero'], heroQuads[(self.frame % 5)+1], self.x + (self.direction==-1 and 250 or 0), self.y,0,self.direction,1)

    -- draw flowers
    love.graphics.draw(textures['flowers'][self.frame], 0, 0, 0, 1280/textures['flowers'][self.frame]:getWidth(), 720/textures['flowers'][self.frame]:getHeight())
    
    -- draw click box
    love.graphics.setColor(color[1], color[2], color[3])
    love.graphics.rectangle("fill", VIEWPORT_WIDTH/2 - 150, VIEWPORT_HEIGHT/2 - 60, 300,120,10,10)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", VIEWPORT_WIDTH/2 - 140, VIEWPORT_HEIGHT/2 - 50, 280,100,10,10)
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Start",0,VIEWPORT_HEIGHT/2 - 50,VIEWPORT_WIDTH, 'center')

end

-- allow click to start
function love.mousepressed( x, y)
    if x > VIEWPORT_WIDTH/2 - 140 and x < VIEWPORT_WIDTH/2 + 140 and y > VIEWPORT_HEIGHT/2 - 50 and y < VIEWPORT_HEIGHT/2 + 50 then
        gameState:change('play')
    end
end
