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
    selector = 0
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
        self.direction = 1
    else
        self.direction = -1
    end
    -- update animation timer for foreground flowers
    self.timer = self.timer + dt
    if self.timer > self.period then
        self.timer = 0
        self.frame = self.frame % 8 + 1
    end
    -- allow 'return' or 'space' to start
    if love.keyboard.wasPressed('return') then
        if love.filesystem.getInfo(text) then
            load_level = loadLevel(text)
            gameState:change('play', load_level)
        else
            text = 'file not found'
        end
    end

    x, y = love.mouse.getPosition()
    
    if x > 57.5 and x < 57.5 + 350 and y > 200 and y < 400 then
        selector = 1
        if mouseClicked() then
            if load_level then
                gameState:change('play', load_level)
            else
                level = loadLevel('sl')
                gameState:change('play', level)
            end
        end
    elseif x > 465 and x < 465 + 350 and y > 200 and y < 400 then
        selector = 2
        if mouseClicked() then
            if text and love.filesystem.getInfo(text) then
                load_level = loadLevel(text)
                gameState:change('play', load_level)
            else
                text = 'file not found'
            end
        end
    elseif x > 872.5 and x < 872.5 + 350 and y > 200 and y < 400 then
        selector = 3
        if mouseClicked() then
            if load_level then
                gameState:change('levelMaker', load_level)
            else
                gameState:change('levelMaker')
            end
        end
    else
        selector = 0
    end

    if love.keyboard.wasPressed("backspace") then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            text = string.sub(text, 1, byteoffset - 1)
        end
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
    
    -- click boxes
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 1 and 1 or 0.5)
    love.graphics.rectangle("fill", 57.5, 200, 350, 200, 30)
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 2 and 1 or 0.5)
    love.graphics.rectangle("fill", 465, 200, 350, 200, 30)
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 3 and 1 or 0.5)
    love.graphics.rectangle("fill", 872.5, 200, 350, 200, 30)
    
    -- text
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Load Level", VIEWPORT_WIDTH/3, VIEWPORT_HEIGHT/2 - 150, VIEWPORT_WIDTH/3, 'center')
    love.graphics.printf("Level Maker",(2 * VIEWPORT_WIDTH)/3 ,VIEWPORT_HEIGHT/2 - 150,VIEWPORT_WIDTH/3, 'center')
    love.graphics.printf("Play",0,VIEWPORT_HEIGHT/2 - 100,VIEWPORT_WIDTH/3, 'center')
    -- input text
    love.graphics.setFont(fonts['smallThin'])
    love.graphics.setColor(0,0,0)
    love.graphics.printf('level name', 465, 410,350, 'center')
    love.graphics.setFont(fonts['small'])
    love.graphics.printf(text, 465, 450,350, 'center')
end


function TitleState:enter()
    if not text then 
        text = 'level.csv'
    end
    love.keyboard.setTextInput(true, 465, 450, 350, 50 )
    love.keyboard.setKeyRepeat(true)
end

function TitleState:exit()
    love.graphics.setColor(1,1,1)
    love.keyboard.setTextInput(false)
end
