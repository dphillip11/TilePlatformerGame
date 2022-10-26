GameOverState = Class{__includes = BaseState}

function GameOverState:init()   
end

function GameOverState:update(dt)
    x, y = love.mouse.getPosition()   
    
    if x > 57.5 and x < 57.5 + 350 and y > 200 and y < 400 then
        selector = 1
        if mouseClicked() then
            gameState:change('play', self.level)
        end
    elseif x > 465 and x < 465 + 350 and y > 200 and y < 400 then
        selector = 2
        if mouseClicked() then
            saveLevel(self.level, text)
        end
    elseif x > 872.5 and x < 872.5 + 350 and y > 200 and y < 400 then
        selector = 3
        if mouseClicked() then
            gameState:change('levelMaker',self.level)
        end
    elseif x > 465 and x < 465 + 350 and y > 500 and y < 700 then
        selector = 4
        if mouseClicked() then
            if text and love.filesystem.getInfo(text) then
                load_level = loadLevel(text)
                gameState:change('play', load_level)
            else
                text = 'file not found'
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

function GameOverState:enter(level)
    if not text then 
        text = 'level.csv'
    end
    love.keyboard.setTextInput(true, 465, 450, 350, 50 )
    love.keyboard.setKeyRepeat(true)
    self.level = level
    selector = 0
end

function love.textinput(t)
    text = text .. t
end

function GameOverState:exit()
    love.graphics.setColor(1,1,1)
    love.keyboard.setTextInput(false)

end


function GameOverState:render()
    love.graphics.setFont(fonts['thin'])
    -- draw background field
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(textures['field'])
    love.graphics.setColor(0,0,0)
    love.graphics.print('GAMEOVER')

    -- click boxes
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 1 and 1 or 0.5)
    love.graphics.rectangle("fill", 57.5, 200, 350, 200, 30)
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 2 and 1 or 0.5)
    love.graphics.rectangle("fill", 465, 200, 350, 200, 30)
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 3 and 1 or 0.5)
    love.graphics.rectangle("fill", 872.5, 200, 350, 200, 30)
    love.graphics.setColor(58/255, 102/255, 58/255, selector == 4 and 1 or 0.5)
    love.graphics.rectangle("fill", 465, 500, 350, 200, 30)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf( 'Replay', 57.5,250, 350, 'center')
    love.graphics.printf( 'Save Level', 465,200, 350, 'center')
    love.graphics.printf( 'Load Level', 465,500, 350, 'center')
    love.graphics.printf( 'Level Maker', 872.5,200, 350, 'center')
    love.graphics.setFont(fonts['smallThin'])
    love.graphics.setColor(0,0,0)
    love.graphics.printf('level name', 465, 410,350, 'center')
    love.graphics.setFont(fonts['small'])
    love.graphics.printf(text, 465, 450,350, 'center')
end


