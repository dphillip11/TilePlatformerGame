Level = Class{}


function Level:init(columns, rows)
    -- 40 x 40 tiles, screen space is 32 x 18 tiles
    self.rows = rows
    self.columns = columns
    self.tileMap, self.entities = LevelMaker(columns, rows)
end

function Level:update(dt)
    for _, ent in pairs(self.entities) do
        ent:update(dt)
    end
end

function Level:render()
    for j = 1, self.rows do
        for i = 1, self.columns do
            if self.tileMap[i][j] ~= 0 then
                self.tileMap[i][j]:render()
            end
        end
    end
    for _, ent in pairs(self.entities) do
        ent:render()
    end
end

function Level:collision(object)
    
    -- object falling
    collisions={}
    collisions['down'] = {}
    if object.dy > 0 then

        -- assign indices to lower corners
        local indices = TileIndex{object.y + object.height + 3, object.x + 2, object.x + object.width - 2}

        -- check y in range
        if indices[1] > 0 and indices[1] < level.rows + 1 then
            for x = indices[2], indices[3] do

                -- check x values in range
                if x > 0 and x < level.columns + 1 and level.tileMap[x][indices[1]] ~= 0 then
                    table.insert(collisions['down'], level.tileMap[x][indices[1]])
                end
            end
        end
    end
    collisions['up'] = {}
    
    -- jumping
    if object.dy < 0 then
        -- assign indices to upper corners

        local indices = TileIndex{object.y - 2, object.x + 2, object.x + object.width - 2}

        -- check y in range
        if indices[1] > 0 and indices[1] < level.rows + 1 then
            for x = indices[2], indices[3] do

                -- check x values in range
                if x > 0 and x < level.columns + 1 and level.tileMap[x][indices[1]] ~= 0 then
                    table.insert(collisions['up'], level.tileMap[x][indices[1]])
                end
            end
        end
    end
    collisions['left'] = {}
    
    -- left
    if object.dx < 0 then
        -- assign indices to left edge
        local indices = TileIndex{object.x - 2, object.y+3, object.y + object.height - 5}

        -- check x in range
        if indices[1] > 0 and indices[1] < level.columns + 1 then
            for y = indices[2], indices[3] do

                -- check y values in range
                if y > 0 and y < level.rows + 1 and level.tileMap[indices[1]][y] ~= 0 then
                    table.insert(collisions['left'], level.tileMap[indices[1]][y])
                end
            end
        end
    end
    collisions['right'] = {}
    
    -- right
    if object.dx > 0 then
        -- assign indices to right edge
        local indices = TileIndex{object.x + object.width, object.y+3, object.y + object.height - 5}

        -- check x in range
        if indices[1] > 0 and indices[1] < level.columns + 1 then
            for y = indices[2], indices[3] do

                -- check y values in range
                if y > 0 and y < level.rows + 1 and level.tileMap[indices[1]][y] ~= 0 then
                    table.insert(collisions['right'], level.tileMap[indices[1]][y])
                end
            end
        end
    end
    return collisions
end






