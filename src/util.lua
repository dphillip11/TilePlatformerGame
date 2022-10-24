-- convert x, y values to tile index
function pointToIndex(x,y)
    xIndex = math.floor(x/40) + 1
    yIndex = math.floor(y/40) + 1
    return xIndex,yIndex
end

function indexToPoint(indexX,indexY)
    x = (indexX + 1) * 40
    y = (indexY + 1) * 40
    return x,y
end

function saveTileMap(lvl, filename)
    file = love.filesystem.newFile(filename)
    file:open("w")
    file:write(lvl.columns..","..lvl.rows.."\n")
    for i = 1, lvl.columns do
        for j = 1, lvl.rows do
            if lvl.tileMap[i][j] ~= 0 then
                file:write(i..","..j..","..lvl.tileMap[i][j].type.."\n")
            end
        end
    end
    file:close()
end

function loadTileMap(lvl, filename)
    for line in love.filesystem.lines(filename) do
        values={}
        for val in line:gmatch("[^,]+") do
            table.insert(values, val)
        end
        if values[3] then
            values[1] = tonumber(values[1])
            values[2] = tonumber(values[2])
            lvl.tileMap[values[1]][values[2]] = Tile(values[1],values[2], values[3])
        end
    end
end









