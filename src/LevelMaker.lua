function EmptyLevel(columns, rows)
    tileMap={}
    -- grid of zeroes for locating fixed tiles
    for x = 1, columns do
        table.insert(tileMap, {})
        for y = 1, rows do
            -- border
            if x == 1 or x==columns or y == 1 or y==rows then
                -- table.insert(tileMap[x], Tile(x,y,'tile'))
                table.insert(tileMap[x], 0) 
            else 
                table.insert(tileMap[x], 0) 
            end         
        end
    end

    return tileMap
end

function changeLevelDimensions(level, columns, rows)
    emptyLevel = Level(columns, rows)
    height_difference = rows - level.rows
    for i = 1, level.columns do
        for j = 1, level.rows do
            if level.tileMap[i][j] ~= 0 then
                emptyLevel.tileMap[i][j+height_difference] = Tile(i, j + height_difference, level.tileMap[i][j].type)
            end
        end
    end
    for _,ent in pairs(level.entities) do
        ent.y = ent.y + (height_difference * 40)
    end
    level.rows = rows
    level.columns = columns
    level.tileMap= emptyLevel.tileMap
end