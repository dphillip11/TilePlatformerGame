

LevelCreatorState = Class{__includes = BaseState}

function LevelCreatorState:init()
    -- tile types
    types = {'tile', 'topper', 'spikes', '?','breakBlock1'}
    -- entities
    entities = {Hedgehog(10,10,0.2), Squirrel(100,100,0.2)}
    SCROLL_X = 0
    SCROLL_Y = 0
    background = Background{}
    new_level = Level(300, 18)
    selector = 1
end


function LevelCreatorState:update(dt)
    if mouseClicked() then 
        x,y = mouseClicked()
        
        i,j=pointToIndex(x+SCROLL_X,y+SCROLL_Y)
        if y > 40 then
            if selector < # types + 1 then
                new_level.tileMap[i][j] = Tile(i,j, types[selector])
            end
            if selector == #types + 1 then
                table.insert(new_level.entities, Hedgehog(x+SCROLL_X-20,y+SCROLL_Y-20,0.125))
            end
            if selector == #types + 2 then
                table.insert(new_level.entities, Squirrel(x+SCROLL_X-20,y+SCROLL_Y-20,0.125))
            end
            if selector > #types + 2 then
                new_level.tileMap[i][j] = 0
            end
        else
            selector = math.floor(x/40) + 1
        end
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

    if love.keyboard.wasPressed('left') then
        SCROLL_X = math.max(0,SCROLL_X - 100)
    end
    if love.keyboard.wasPressed('right') then
        SCROLL_X = math.max(0,SCROLL_X + 100)
    end
    if love.keyboard.wasPressed('down') then
        SCROLL_Y = math.max(0,SCROLL_Y + 100)
    end
    if love.keyboard.wasPressed('up') then
        SCROLL_Y = math.max(0,SCROLL_Y - 100)
    end
    if love.keyboard.wasPressed('return') then
        saveLevel(new_level, text)
        gameState:change('play', new_level)        
    end
    new_level:update(dt)
    background:update(dt)
end


function LevelCreatorState:exit()
    love.graphics.setColor(1,1,1)
    love.keyboard.setTextInput(false)
end

function LevelCreatorState:enter(level)
    if level then
        new_level = level
    end
    if not text then 
        text = 'level.csv'
    end
    love.keyboard.setTextInput(true, 465, 450, 350, 50 )
    love.keyboard.setKeyRepeat(true)
end

function LevelCreatorState:render()
    background:render()
    for i, t in pairs(types) do
        love.graphics.draw(textures['tiles'], quads[t], (i - 1)* 40)
    end
    love.graphics.draw(textures['hedgehog'], hedgehogQuads[3], (#types)* 40, -10, 0.1,0.1)
    love.graphics.draw(textures['squirrel'], squirrelQuads[3], (#types+1)* 40, -10, 0.1,0.1)
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    new_level:render()
    love.graphics.printf("NAME: "..text.."\n(type to change)\n".."ARROWS to move camera\n".."ENTER to SAVE\nclick icons or empty space at top to SELECT",20,50,350, 'left')
end










