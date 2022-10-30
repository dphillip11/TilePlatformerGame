

LevelCreatorState = Class{__includes = BaseState}

function LevelCreatorState:init()
    -- tile types
    types = {'tile', 'topper', 'spikes', '?','breakBlock1'}
    -- entities
    -- entities = {Hedgehog(10,10,0.2), Squirrel(100,100,0.2)}
    background = Background{}
    new_level = Level(32, 18)
    SCROLL_X = 0
    SCROLL_Y = 0
    selector = 1
    entityClicked=0
    hero1=Hero(0,0)
    hero1.onScreen = 1
end


function LevelCreatorState:update(dt)
    -- update changes to hero starting position
    new_level.heroX = hero1.x+60
    new_level.heroY = hero1.y+40
    -- use a y offset to fix background position as level gets taller
    BACKGROUND_Y_OFFSET = (new_level.rows -18)*40
    if mouseClicked() then 
        x,y, button= mouseClicked()
        i,j=pointToIndex(x+SCROLL_X,y+SCROLL_Y)
        -- select and drag hero
        if hero1.x < x + SCROLL_X and hero1.x + hero1.width > x + SCROLL_X and hero1.y < y + SCROLL_Y and hero1.y + hero1.height > y + SCROLL_Y then
            hero1.x = x+SCROLL_X-40
            hero1.y = y+SCROLL_Y-40
        -- clear level
        elseif x > VIEWPORT_WIDTH-120 and x < VIEWPORT_WIDTH-10 and y< 80 then
            new_level = Level(32, 18)
            hero1.x = new_level.heroX
            hero1.y = new_level.heroY
            SCROLL_X = 0
            SCROLL_Y = 0
            text='newLevel'
        -- interacting with build space
        elseif y > 40 then
            if button == 1 then
                -- replace tile
                if selector < # types + 1 then
                    new_level.tileMap[i][j] = Tile(i,j, types[selector])
                end
                -- this results in dragging sprites or replacing them without spawning many at a time
                if selector == #types + 1 then
                    for index,ent in pairs(new_level.entities) do
                        if ent.x < x + SCROLL_X and ent.x + ent.width > x + SCROLL_X and ent.y < y + SCROLL_Y and ent.y + ent.height > y + SCROLL_Y then
                            if new_level.entities[index].type ~= 'hedgehog' then 
                                table.remove(new_level.entities,index)
                                table.insert(new_level.entities, Hedgehog(x+SCROLL_X-20,y+SCROLL_Y-40,0.1))
                            else
                                
                                new_level.entities[index].x = x+SCROLL_X-20
                                new_level.entities[index].y = y+SCROLL_Y-40
                            end
                            entityClicked=1
                        end
                    end
                    if entityClicked==0 then
                        table.insert(new_level.entities, Hedgehog(x+SCROLL_X-20,y+SCROLL_Y-40,0.1))
                    else
                        entityClicked=0
                    end
                end
                -- this results in dragging sprites or replacing them without spawning many at a time
                -- it is possible to alter mouse input logging to avoid this chunk
                -- at the moment it simulates many clicks when button is held
                if selector == #types + 2 then
                    for index,ent in pairs(new_level.entities) do
                        if (ent.x < x + SCROLL_X) and (ent.x + ent.width > x + SCROLL_X )and (ent.y < y + SCROLL_Y )and (ent.y + ent.height > y + SCROLL_Y ) then
                            if new_level.entities[index].type ~= 'squirrel' then 
                                table.remove(new_level.entities,index)
                                table.insert(new_level.entities, Squirrel(x+SCROLL_X-20,y+SCROLL_Y-40,0.125))
                            else
                                new_level.entities[index].x = x+SCROLL_X-20
                                new_level.entities[index].y = y+SCROLL_Y-40
                            end
                            entityClicked=1
                        end
                    end
                    -- if no entities are place then place one
                    if entityClicked==0 then
                        table.insert(new_level.entities, Squirrel(x+SCROLL_X-20,y+SCROLL_Y-40,0.125))
                    else
                        entityClicked=0
                    end
                end
                if selector == #types + 3 then
                    for index,ent in pairs(new_level.entities) do
                        if (ent.x < x + SCROLL_X) and (ent.x + ent.width > x + SCROLL_X )and (ent.y < y + SCROLL_Y )and (ent.y + ent.height > y + SCROLL_Y ) then
                            if new_level.entities[index].type ~= 'bone' then 
                                table.remove(new_level.entities,index)
                                table.insert(new_level.entities, Bone(x+SCROLL_X-20,y+SCROLL_Y-40,1,1))
                            else
                                new_level.entities[index].x = x+SCROLL_X-20
                                new_level.entities[index].y = y+SCROLL_Y-40
                            end
                            entityClicked=1
                        end
                    end
                    -- if no entities are place then place one
                    if entityClicked==0 then
                        table.insert(new_level.entities, Bone(x+SCROLL_X-20,y+SCROLL_Y-40,1,1))
                    else
                        entityClicked=0
                    end
                end
                -- empty space
                if selector > #types + 2 then
                    new_level.tileMap[i][j] = 0
                end
            else
                -- right click to remove
                new_level.tileMap[i][j] = 0
                for index,ent in pairs(new_level.entities) do
                    if ent.x < x + SCROLL_X and ent.x + ent.width > x + SCROLL_X and ent.y < y + SCROLL_Y and ent.y + ent.height > y + SCROLL_Y then
                        table.remove(new_level.entities, index)
                    end
                end
            end
        else
            -- icon selectors, seven so far
            if x < 320 then
            selector = math.floor(x/40) + 1
            end
            -- increase length
            if x > 460 and x < 650 then
                changeLevelDimensions(new_level, new_level.columns+1, new_level.rows)
            end
            -- increase height
            if x > 710 and x < 900 then
                changeLevelDimensions(new_level, new_level.columns, new_level.rows+1)
                SCROLL_Y = SCROLL_Y + 40
            end
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
        SCROLL_X = math.min(SCROLL_X + 100, (new_level.columns - 32)*40)
    end
    if love.keyboard.wasPressed('down') or mouseScrollLog<0 then
        SCROLL_Y = math.min(40 *(new_level.rows-18),SCROLL_Y + 100)
    end
    if love.keyboard.wasPressed('up') or  mouseScrollLog>0 then
        SCROLL_Y = math.max(-80,SCROLL_Y - 100)
    end
    
    if love.keyboard.wasPressed('return') then
        saveLevel(new_level, text)
        gameState:change('play', new_level)        
    end
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
    hero1.x = new_level.heroX - 60 
    hero1.y = new_level.heroY - 40

    if not text then 
        text = 'level.csv'
    end
    love.keyboard.setTextInput(true, 465, 450, 350, 50 )
    love.keyboard.setKeyRepeat(true)
end

function LevelCreatorState:render()
    
    background:render()
    love.graphics.setColor(1,1,1,1)
    love.graphics.translate(-math.floor(SCROLL_X), -math.floor(SCROLL_Y))
    new_level:render()
    hero1:render()
    love.graphics.printf("NAME: "..text.."\n(type to change)\n".."ARROWS to move camera\n".."ENTER to SAVE\nclick icons to SELECT\nright-click to REMOVE\nDIMENSIONS are in tiles",20,50,350, 'left')
    love.graphics.translate(math.floor(SCROLL_X), math.floor(SCROLL_Y))
    for i, t in pairs(types) do
        love.graphics.draw(textures['tiles'], quads[t], (i - 1)* 40)
    end
    love.graphics.draw(textures['bone'], 280,0,0,0.5,0.5)
    love.graphics.draw(textures['hedgehog'], hedgehogQuads[3], (#types)* 40, -10, 0.1,0.1)
    love.graphics.draw(textures['squirrel'], squirrelQuads[3], (#types+1)* 40, -10, 0.1,0.1)
    love.graphics.print("length:"..new_level.columns,500, 10)
    love.graphics.polygon( 'fill', 460, 35, 475, 10, 490, 35 )
    love.graphics.print("height:"..new_level.rows,750, 10)
    love.graphics.polygon( 'fill', 710, 35, 725, 10, 740, 35 )
    love.graphics.rectangle( 'fill', VIEWPORT_WIDTH-120, 10, 110, 70, 10,10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf("clear level", VIEWPORT_WIDTH-100, 10, 90)
    love.graphics.setColor(1,1,1,1)

   
end










