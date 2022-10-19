LevelCreator = Class{}


function LevelCreator:init(columns, rows)
    -- 40 x 40 tiles, screen space is 32 x 18 tiles
    self.rows = rows
    self.columns = columns
    self.tileMap={}

    -- grid of zeroes mapping play space for locating fixed tiles

    for x = 1, self.columns do

        table.insert(self.tileMap, {})

        for y = 1, self.rows do
                    table.insert(self.tileMap[x], 0)          
            
        end
    end

    for i = 1, columns do
        for j = 12, rows do
            self.tileMap[i][j] = Tile(i,j,'tile')
        end
    end
    self.tileMap[8][8] = Tile(8,8,'?')

end


function LevelCreator:render()
    for j = 1, self.rows do
        for i = 1, self.columns do
            if self.tileMap[i][j] ~= 0 then
                self.tileMap[i][j]:render()
            end
        end
    end
end

function LevelCreator:collision(object)

    if object.dy > 0 then
        -- assign 3 point indexes along the lower edge if falling
    
        local indexY = math.floor((object.y + object.height + 2)/40) + 1
        local indexX1 = math.floor(object.x/40)+1
        local indexX2 = math.floor((object.x + (object.width/2))/40)+1
        local indexX3 = math.floor((object.x + object.width)/40)+1
        if level.tileMap[indexX1] and level.tileMap[indexX2] and level.tileMap[indexX3] and level.tileMap[indexX1][indexY] then         
            if level.tileMap[indexX1][indexY] ~= 0 
            or level.tileMap[indexX2][indexY] ~= 0 
            or level.tileMap[indexX3][indexY] ~= 0 then
                object.dy = 0
                object.y = ((indexY -1)* 40) - object.height
            end
                     
        end
    end
    
    -- define an index for the object and then check local tiles for collisions
    indexX1 = math.floor(object.x/40) + 1
    indexY1 = math.floor(object.y/40) + 1
    for x = math.max(1,indexX1-2), math.min(indexX1 + 2, self.columns) do
        -- for y = math.max(1,indexY1-2), math.min(indexY1 + 4, 18) do
        for y = 1,18 do
            if self.tileMap[x][y]~=0 and self.tileMap[x][y]:collision(object) then
                return true
            end
        end
    end
end




