Tile = Class{}

function Tile:init(indexX, indexY, type)
    self.x = (indexX - 1) * 40
    self.y = (indexY - 1) * 40 
    _,_,self.width, self.height = quads[type]:getViewport( )
    self.type = type
    self.quad = quads[type]
end

function Tile:collision(object)
    if object.x + object.width > self.x and object.x < self.x + self.width and object.y + object.height > self.y and object.y < self.y + self.height then
        return true
    end
end

