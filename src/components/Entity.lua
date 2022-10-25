Entity = Class{}

function Entity:init(def)
    
    self.x = def.x or 0
    self.y = def.y or 0
    self.dx = 0
    self.dy = 0
    self.type = def.type
    self.texture = def.texture or textures['tiles']
    self.quads = def.quads or quads
    self.scaleX = def.scale or 1
    self.scaleY = def.scale or 1
    if self.quads[1] then
        _,_,self.qWidth, self.qHeight = self.quads[1]:getViewport( )
        self.height = self.qHeight*self.scaleY
        self.width = self.qWidth*self.scaleY
    else
        self.height = 40
        self.width = 40
    end
 
    
    self.onScreen = 0
    self.state = def.state or 0 
    self.frame = 1
end

function Entity:update(dt)
    if self.body then
        self.state:update(dt)        
        self.body:setAngle(0)
        self.dx, self.dy = self.body:getLinearVelocity()
        self.x, self.y = self.body:getWorldPoints(self.shape:getPoints())
    end

    if self.onScreen then
        if self.dx < 0 then 
            self.scaleX = -self.scaleY
        end
        if self.dx > 0 then 
            self.scaleX = self.scaleY
        end     
    end

    if self.x > -100 + SCROLL_X and self.x < VIEWPORT_WIDTH + 100 + SCROLL_X and self.y > SCROLL_Y - 100 and self.y < SCROLL_Y + VIEWPORT_HEIGHT + 100 then
        self.onScreen = 1
    else
        self.onScreen = 0
    end
end


function Entity:render()
    if self.onScreen == 1 then 
        love.graphics.draw(self.texture, self.quads[self.frame], self.x + (self.scaleX<0 and self.width or 0), self.y, 0, self.scaleX, self.scaleY)
        self.state:render()
    end
end










