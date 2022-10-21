function LevelMaker(columns, rows)
    tileMap={}
    entities={}
    -- grid of zeroes for locating fixed tiles
    for x = 1, columns do
        table.insert(tileMap, {})
        for y = 1, rows do
            -- border
            if x == 1 or x==columns or y == 1 or y==rows then
                table.insert(tileMap[x], Tile(x,y,'tile'))
            else 
                table.insert(tileMap[x], 0) 
            end         
        end
    end
    
    gapFlag=0
    qFlag=0
    for x = 2, columns - 1 do
        for y = 1, rows - 1 do
            if tileMap[x][y] == 0 and tileMap[x][y+1] ~= 0 and tileMap[x][y+1].type == 'tile' then
                tileMap[x][y+1] = Tile(x,y+1,'topper')
                if math.random(0,15)>14 then 
                    tileMap[x][y+1] = Tile(x,y+1,'spikes')
                    tileMap[x-1][y+1] = Tile(x-1,y+1,'spikes')
                end
            end
            if tileMap[x][y] == 0 then 
                if math.random(1,40) == 10 then
                    tileMap[x][y] = Tile(x,y,'?')
                end
            end
        end
    end
    tileMap[8][rows -3] = Tile(8,rows -3,'?')
    tileMap[5][rows -3] = Tile(5,rows -3,'?')
    tileMap[1][rows -3] = Tile(1,rows -3,'?')
    tileMap[15][rows].body:destroy()
    tileMap[16][rows].body:destroy()
    tileMap[15][rows]=0
    tileMap[16][rows]=0
    for x = 2, columns - 1 do
        for y = 1, rows - 1 do
            if tileMap[x][y] == 0 and tileMap[x][y+1] ~= 0 and tileMap[x][y+1].type == '?' then
                if math.random(1,100)>80 then
                    table.insert(entities, Squirrel((x-1)* 40,y * 40,0.125))
                end
            end
        end
    end
    table.insert(entities, Hedgehog(100,100,0.125))
    table.insert(entities, Squirrel(1000,100,0.125))
  

    return tileMap, entities
end