Tile = Class{}

function Tile:init(indexX, indexY, type)
    self.xIndex = indexX
    self.yIndex = indexY
    self.x = (indexX - 1) * 40
    self.y = (indexY - 1) * 40 
    _,_,self.width, self.height = quads[type]:getViewport( )
    self.type = type
    self.active = 1
end

function Tile:collision(object)
    if object.x + object.width - 2 > self.x and object.x + 2< self.x + self.width and object.y + object.height - 2> self.y and object.y + 2< self.y + self.height then
        self:collisionResponse(object)
        return true
    end
end

function Tile:collisionResponse(object)
    if self.type == '?' and object.directionY == 'N' and self.active == 1 and not self.glideY then 
        table.insert(level.entities, Entity(self.xIndex,self.yIndex - 1, math.random(-200,200), math.random(-100,-1000)))
        self.glideY = Glide({self.y, self.y - 10, self.y}, 0.3)
        table.insert(level.glides, self.glideY)     
        self.active = 0   
    end
    if (self.type == 'spikes' or self.type == "bloodySpikes") and object.directionY == 'S' then 
        self.type = 'bloodySpikes'
        playerHealth = math.max(0, playerHealth -1)
        object.y = object.y - 20
    end
    if self.type == 'breakBlock3' and object.directionY == 'N' then 
        level.grid[self.xIndex][self.yIndex] = '0'
    end
    if self.type == 'breakBlock2' and object.directionY == 'N' then 
        self.type = 'breakBlock3'
    end
    if self.type == 'breakBlock1' and object.directionY == 'N' then 
        self.type = 'breakBlock2'
    end
    
end


function Tile:render()
    if self.glideY then
        self.y = self.glideY.x1
        -- remove dead tweens
        if self.glideY.stopped == 1 then
            self.glideY = nil
        end
    end

    if self.x > -50 and self.x < VIEWPORT_WIDTH then
        if self.active == 0 then
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.draw(textures['tiles'], quads[self.type], self.x, self.y)
        love.graphics.setColor(1,1,1)
    end
end

