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
                        table.insert(self.grid[x], quads['?'])
                    else
                        table.insert(self.grid[x], '0')
                    end
                end
                if y < 14 and y ~= 7 then
                    table.insert(self.grid[x], '0')
                end
                if y == 14 then
                    table.insert(self.grid[x], quads['topper'])
                end
                if y > 14 then
                    table.insert(self.grid[x], quads['tile'])
                end
            else
                table.insert(self.grid[x], quads['tile'])
            end
            
        end
    end
    for n = 1, self.columns do
        if math.random(1,10) == 1 then
            self.grid[n][13] = quads['spikes']
        end
    end
end


function LevelCreator:render()
    for j = 1, 18 do
        for i = 1, self.columns do
            if self.grid[i][j] ~= '0' then
                love.graphics.draw(textures['tiles'], self.grid[i][j], (i-1) * 40 - hero.x, (j-1) * 40 - math.min(hero.y,0))
            end
        end
    end
end

function LevelCreator:collision(object)
    -- define a quad of tiles by the top left and bottom right corner
    indexX1 = (object.x/40) + 1
    indexY1 = (object.y/40) + 1
    indexX2 = ((object.x + object.width)/40) + 1
    indexY2 = ((object.y + object.height)/40) + 1
    if self.grid[math.floor(indexX1)][math.floor(indexY2)] ~= '0' or self.grid[math.floor(indexX2)][math.floor(indexY2)] ~= '0' or self.grid[math.floor(indexX1)][math.ceil(indexY1)] ~= '0' or self.grid[math.floor(indexX2)][math.ceil(indexY1)] ~= '0' then
        return 'up'
    end
end


