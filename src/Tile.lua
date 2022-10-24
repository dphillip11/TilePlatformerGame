Tile = Class{}

function Tile:init(indexX, indexY, type)
    self.xIndex = indexX
    self.yIndex = indexY
    self.x = (indexX - 1) * 40
    self.y = (indexY - 1) * 40 
    self.type = type
    self.active = 1

    -- -- physical properties
    -- self.body = love.physics.newBody(world, self.x+20, self.y+20, 'static')
    -- self.shape = love.physics.newRectangleShape(40,40)
    -- self.fixture = love.physics.newFixture( self.body, self.shape)
    -- self.fixture:setFriction(0)
    -- self.fixture:setUserData(self)
end

function Tile:collide()
    if self.type == '?' and self.active == 1 then 
        -- table.insert(level.entities, Hedgehog(self.x, self.y-100) )
        self.active = 0  
    end
    if (self.type == 'spikes' or self.type == "bloodySpikes") then 
        self.type = 'bloodySpikes'
        healthbar.health = math.max(0, math.max(0,healthbar.health - 1))
    end
    if self.type == 'breakBlock3' then
        level.tileMap[self.xIndex][self.yIndex].body:destroy()
        level.tileMap[self.xIndex][self.yIndex] = 0
    end
    if self.type == 'breakBlock2' then 
        self.type = 'breakBlock3'
    end
    if self.type == 'breakBlock1' then 
        self.type = 'breakBlock2'
    end
    
end


function Tile:render()
    if self.x > -50 + SCROLL_X and self.x < VIEWPORT_WIDTH + SCROLL_X then
        if self.active == 0 then
            love.graphics.setColor(0.5,0.5,0.5)
        end
        love.graphics.draw(textures['tiles'], quads[self.type], self.x, self.y)
        love.graphics.setColor(1,1,1)
    end
end

function Tile:addBody()
    self.body = love.physics.newBody(world, self.x+20, self.y+20, 'static')
    self.shape = love.physics.newRectangleShape(40,40)
    self.fixture = love.physics.newFixture( self.body, self.shape)
    self.fixture:setFriction(0)
    self.fixture:setUserData(self)
end
