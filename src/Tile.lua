Tile = Class{}

function Tile:init(indexX, indexY, type)
    self.xIndex = indexX
    self.yIndex = indexY
    self.x = (indexX - 1) * 40
    self.y = (indexY - 1) * 40 
    _,_,self.width, self.height = quads[type]:getViewport( )
    self.type = type
end

function Tile:collision(object)
    if object.x + object.width - 2 > self.x and object.x + 2< self.x + self.width and object.y + object.height - 2> self.y and object.y + 2< self.y + self.height then
        self:collisionResponse(object.directionY)
        return true
    end
end

function Tile:collisionResponse(direction)
    if self.type == '?' and direction == 'N' then 
        self.y = self.y - 10
    end
    if self.type == 'spikes' and direction == 'S' then 
        self.type = 'bloodySpikes'
    end
    if self.type == 'breakBlock3' and direction == 'N' then 
        level.grid[self.xIndex][self.yIndex] = '0'
    end
    if self.type == 'breakBlock2' and direction == 'N' then 
        self.type = 'breakBlock3'
    end
    if self.type == 'breakBlock1' and direction == 'N' then 
        self.type = 'breakBlock2'
    end
    
end

function Tile:render()
    love.graphics.draw(textures['tiles'], quads[self.type], self.x - hero.x + HERO_OFFSET, self.y - math.min(hero.y,0))
end

