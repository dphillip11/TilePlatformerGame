Level = Class{}


function Level:init(columns, rows)
    -- 40 x 40 tiles, screen space is 32 x 18 tiles
    self.rows = rows
    self.columns = columns
    self.tileMap= EmptyLevel(columns, rows)
    self.entities={}
    self.heroX=100
    self.heroY=500
    self.squirrelCount = 0
end

function Level:update(dt)
    if inPlay == 1 then
        for i, ent in pairs(self.entities) do
            if ent.active == 0 then
                table.remove(self.entities, i)
            else
            ent:update(dt)
            end
        end
    else
        for i, ent in pairs(self.entities) do
            ent:update(dt)
        end
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
    self.squirrelCount = 0
    for _, ent in pairs(self.entities) do
        ent:render()
        if ent.type == 'squirrel' then
            self.squirrelCount = self.squirrelCount + 1
        end
    end
end

function Level:checkCollision(object, direction)
    
    -- object falling
    collisions={}
    if direction == 'down' then

        -- assign indices to lower corners
        local indices = TileIndex{object.y + object.height + 1, object.x + 3, object.x + object.width - 3}

        -- check y in range
        if indices[1] > 0 and indices[1] < level.rows + 1 then
            for x = indices[2], indices[3] do

                -- check x values in range
                if x > 0 and x < level.columns + 1 and level.tileMap[x][indices[1]] ~= 0 then
                    table.insert(collisions, level.tileMap[x][indices[1]])
                end
            end
        end
    
    elseif direction == 'up' then
    
        -- jumping
        
        -- assign indices to upper corners

        local indices = TileIndex{object.y - 1, object.x + 3, object.x + object.width - 3}

        -- check y in range
        if indices[1] > 0 and indices[1] < level.rows + 1 then
            for x = indices[2], indices[3] do

                -- check x values in range
                if x > 0 and x < level.columns + 1 and level.tileMap[x][indices[1]] ~= 0 then
                    table.insert(collisions, level.tileMap[x][indices[1]])
                end
            end
        end
    
    elseif direction == 'left' then
    
        -- left
        
        -- assign indices to left edge
        local indices = TileIndex{object.x - 1, object.y+3, object.y + object.height - 3}

        -- check x in range
        if indices[1] > 0 and indices[1] < level.columns + 1 then
            for y = indices[2], indices[3] do

                -- check y values in range
                if y > 0 and y < level.rows + 1 and level.tileMap[indices[1]][y] ~= 0 then
                    table.insert(collisions, level.tileMap[indices[1]][y])
                end
            end
        end
    elseif direction == 'right' then
    
        -- right
        
        -- assign indices to right edge
        local indices = TileIndex{object.x + object.width + 1, object.y+3, object.y + object.height - 3}

        -- check x in range
        if indices[1] > 0 and indices[1] < level.columns + 1 then
            for y = indices[2], indices[3] do

                -- check y values in range
                if y > 0 and y < level.rows + 1 and level.tileMap[indices[1]][y] ~= 0 then
                    table.insert(collisions, level.tileMap[indices[1]][y])
                end
            end
        end
    end
    return collisions
end

-- adjust position in the direction opposite collision
function adjustPosition(object, direction)
    if direction == 'up' then
        object.y = (40 * math.floor((object.y + object.height + 1)/40)) - object.height 
    end
    if direction == 'right' then
        object.x = 40 * (math.floor((object.x - 1)/40) + 1)
    end
    if direction == 'left' then
        object.x = 40 * (math.floor((object.x + object.width + 1)/40)) - object.width
    end
    if direction == 'down' then
        object.y = 40 * (math.floor((object.y - 1)/40) + 1) 
    end
end






