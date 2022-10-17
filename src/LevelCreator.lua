LevelCreator = Class{}


function LevelCreator:init(columns)
    -- 18 tiles up and down
    self.columns = columns

    self.grid={}

    for x = 1, self.columns do

        table.insert(self.grid, {})

        for y = 1, 18 do

            if x > 14 then
                if y == 7 then
                    if math.random(0,5) > 1 then
                        table.insert(self.grid[x], '0')
                    else
                        if math.random(0,1)==0 then
                            table.insert(self.grid[x], Tile(x,y,'?'))
                        else
                            table.insert(self.grid[x], Tile(x,y,'breakBlock1'))
                        end
                    end
                end
                if y < 14 and y ~= 7 then
                    table.insert(self.grid[x], '0')
                end
                if y == 14 then
                    table.insert(self.grid[x], Tile(x,y,'topper'))
                end
                if y > 14 then
                    table.insert(self.grid[x], Tile(x,y,'tile'))
                end
            else
                table.insert(self.grid[x], Tile(x,y,'tile'))
            end
            
        end
    end
    for n = 1, self.columns do
        if math.random(1,10) == 1 then
            self.grid[n][13] = Tile(n,13,'spikes')
        end
    end
end


function LevelCreator:render()
    for j = 1, 18 do
        for i = 1, self.columns do
            if self.grid[i][j] ~= '0' then
                self.grid[i][j]:render()
            end
        end
    end
end

function LevelCreator:collision(object)
    -- define an index for the object and then check local tiles for collisions
    indexX1 = math.floor(object.x/40) + 1
    indexY1 = math.floor(object.y/40) + 1
    for x = math.max(1,indexX1-2), math.min(indexX1 + 2, self.columns) do
        for y = math.max(1,indexY1-2), math.min(indexY1 + 2, 18) do
            if self.grid[x][y]~='0' and self.grid[x][y]:collision(object) then
                return true
            end
        end
    end
end


