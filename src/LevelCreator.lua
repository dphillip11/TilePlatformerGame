LevelCreator = Class{}


function LevelCreator:init(columns)
    -- 18 tiles up and down
    self.columns = columns

    self.grid={}

    for x = 1, self.columns do

        table.insert(self.grid, {})

        for y = 1, 18 do
            if y < 13 then
                table.insert(self.grid[x], '0')
            end
            if y == 13 then
                table.insert(self.grid[x], quads['topper'])
            end
            if y > 14 then
                table.insert(self.grid[x], quads['tile'])
            end
            
        end
    end
end

function LevelCreator:render()
    for j = 1, 17 do
        for i = 1, self.columns do
            if self.grid[i][j] ~= '0' then
                love.graphics.draw(textures['tiles'], self.grid[i][j], (i-1) * 40 - hero.x, j * 40 - hero.y)
            end
        end
    end
end


