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
 
    self.onScreen = 1
    self.state = def.state or 0 
    self.frame = 1
    self.entityCollisions = {}
end

function Entity:update(dt)

    self.collisions = {}

    self.collisions['down'] = level:checkCollision(self, 'down')
    if #self.collisions['down'] > 0 and self.dy >= 0 then
        self.dy = 0
        adjustPosition(self,'up')
    else 
        self.dy = self.dy + (GRAVITY*dt)        
    end 

    self.collisions['up'] = level:checkCollision(self, 'up')
    if #self.collisions['up'] > 0 and self.dy <= 0 then
        self.dy = 0
        adjustPosition(self,'down')
    end 
    
    self.collisions['left'] = level:checkCollision(self, 'left')
    if #self.collisions['left'] > 0 and self.dx <= 0 then
        if self.type == 'hero' or self.type == 'squirrel' then
            self.dx = 0
        else
            self.dx = -self.dx
        end
        adjustPosition(self,'right')
    end  

    self.collisions['right'] = level:checkCollision(self, 'right')
    if #self.collisions['right'] > 0 and self.dx >= 0 then
        if self.type == 'hero' or self.type == 'squirrel' then
            self.dx = 0
        else
            self.dx = -self.dx
        end
        adjustPosition(self,'left')
    end 

    self.entityCollisions = getEntityCollisions(self, level.entities)

    self.x = math.min(level.columns*40, math.max(0,self.x + (self.dx * dt)))
    self.y = self.y + (self.dy * dt)

    self.state:update(dt)

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

    if self.x < 0 - self.width or self.x > level.columns * 40 or self.y > level.rows * 40 then
        self.active = 0
    end
end


function Entity:render()
    if self.onScreen == 1 then 
        love.graphics.draw(self.texture, self.quads[self.frame], self.x + (self.scaleX<0 and self.width or 0), self.y, 0, self.scaleX, self.scaleY)
        self.state:render()
    end
end









