-- convert x, y values to tile index
function pointToIndex(x,y)
    xIndex = math.floor(x/40) + 1
    yIndex = math.floor(y/40) + 1
    return xIndex,yIndex
end

function TileIndex(vals)
    indices = {}
    for i,val in pairs(vals) do
        indices[i] = math.floor(val/40) + 1
    end
    return indices
end

function indexToPoint(indexX,indexY)
    x = (indexX + 1) * 40
    y = (indexY + 1) * 40
    return x,y
end

function loadLevel(filename)
    for line in love.filesystem.lines(filename) do
        values={}
        for val in line:gmatch("[^,]+") do
            table.insert(values, val)
        end
        if #values == 2 then
            load_level = Level(values[1],values[2])
        end
        if #values == 3 then
            values[1] = tonumber(values[1])
            values[2] = tonumber(values[2])
            load_level.tileMap[values[1]][values[2]] = Tile(values[1],values[2], values[3])
        end
        if #values == 4 then
            values[2] = tonumber(values[2])
            values[3] = tonumber(values[3])
            values[4] = tonumber(values[4])
            if values[1]=='hedgehog' then
                table.insert(load_level.entities, Hedgehog(values[2],values[3], values[4]))
            end
            if values[1]=='squirrel' then
                table.insert(load_level.entities, Squirrel(values[2],values[3], values[4]))
            end
            if values[1]=='bone' then
                table.insert(load_level.entities, Bone(values[2],values[3]))
            end
        end
        if #values == 5 then
            load_level.heroX = tonumber(values[3])
            load_level.heroY = tonumber(values[5])
        end
    end
    return load_level
end

function saveLevel(lvl, filename)
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
    for i,ent in pairs(lvl.entities) do
        file:write(ent.type..","..ent.x..","..ent.y..","..ent.scaleY.."\n")
    end
    file:write("heroPosition:, X:,"..lvl.heroX..", Y:,"..lvl.heroY.."\n")
    file:close()
end

function entityCollision(self, ent)
    if self ~= ent and self.x + self.width > ent.x and self.x < ent.x + ent.width and self.y + self.height > ent.y and self.y < ent.y + ent.height then
        return true
    else
        return false
    end
end

function getEntityCollisions(self, ents)
    -- return a list of collisions
    cols={}
    cols['left']={}
    cols['right']={}
    cols['up']={}
    cols['down']={}

    for i, ent in pairs(ents) do
        -- move left, check collision
  
            self.x = self.x - 2

            if self~=ent and entityCollision(self,ent) then
                table.insert(cols['left'], ent)
                if #self.collisions['right'] < 1 and self.dx < 0 and self.x > ent.x then
                    self.x = ent.x + ent.width
                else
                    self.x = self.x + 2
                end
            else
                self.x = self.x + 2
            end

       
            -- move right, check collision
            self.x = self.x + 2

            if self~=ent and entityCollision(self,ent) then
                table.insert(cols['right'], ent)
                if #self.collisions['left'] < 1 and self.dx > 0 and self.x  < ent.x then
                    self.x = ent.x - self.width
                else
                    self.x = self.x - 2
                end
            else
                self.x = self.x - 2
            end
        -- end

        -- move up, check collision

        if self.dy < 0 then
            self.y = self.y - 2

            if self~=ent and entityCollision(self,ent) then
                table.insert(cols['up'], ent)
                if #self.collisions['down'] < 1 and self.dy < 0 and self.y  > ent.y then
                    self.y = ent.y + ent.height
                else
                    self.y = self.y + 2
                end
            else
                self.y = self.y + 2
            end
        end

        -- move down, check collision
        if self.dy > 0 then
            self.y = self.y + 2

            if self~=ent and entityCollision(self,ent) then
                table.insert(cols['down'], ent)
                if #self.collisions['up'] < 1 and self.dy > 0 and self.y  < ent.y then
                    self.y = ent.y - self.height
                    self.dy = 0
                else            
                    self.y = self.y - 2   
                end
            else            
                self.y = self.y - 2   
            end
        end
    end
    return cols
end



















