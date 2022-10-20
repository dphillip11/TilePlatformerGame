function LevelMaker(columns, rows)
    tileMap={}
    entities={}
    -- grid of zeroes for locating fixed tiles
    for x = 1, columns do
        table.insert(tileMap, {})
        for y = 1, rows do
                    table.insert(tileMap[x], 0)            
        end
    end
    -- ground to walk on
    for i = 1, columns do
        for j = 12, rows do
            tileMap[i][j] = Tile(i,j,'tile')
        end
    end
    tileMap[8][8] = Tile(8,8,'?')
    tileMap[5][5] = Tile(5,5,'?')
    tileMap[1][5] = Tile(1,5,'?')
    
    entities['hedgehog'] = Entity{indexX=3, indexY=3, dx=10, frames={4,3,2,1}, scale = 0.3}

    return tileMap, entities
end