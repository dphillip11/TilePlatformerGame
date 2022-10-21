Entity = Class{}

function Entity:init(def)
    
    self.x = def.x or 0
    self.y = def.y or 0
    self.dx = 0
    self.dy = 0
    self.type = def.type
    self.texture = def.texture or textures['tiles']
    self.quads = def.quads or quads
    _,_,self.qWidth, self.qHeight = self.quads[1]:getViewport( )
    self.scaleX = def.scale or 1
    self.scaleY = def.scale or 1
    self.height = self.qHeight*self.scaleY 
    self.width = self.qWidth*self.scaleY 
    self.onScreen = 0
    self.state = def.state or 0 
    self.frame = 1

     -- physical properties
     self.body = love.physics.newBody( world, self.x - self.width/2, self.y- self.height/2, 'dynamic')
     self.shape = love.physics.newRectangleShape(self.width-4,self.height-1)
     self.fixture = love.physics.newFixture( self.body, self.shape)
     self.fixture:setFriction(1)
     self.fixture:setUserData(self)
end


function Entity:update(dt)
    if self.onScreen then
        self.state:update(dt)
        
        self.body:setAngle(0)

        self.dx, self.dy = self.body:getLinearVelocity()

        if self.dx < 0 then 
            self.scaleX = -self.scaleY
        end
        if self.dx > 0 then 
            self.scaleX = self.scaleY
        end     
    end
    if self.body:getX() > -100 + SCROLL_X and self.body:getX() < VIEWPORT_WIDTH + 100 + SCROLL_X and self.y > SCROLL_Y - 100 and self.body:getY() < SCROLL_Y + VIEWPORT_HEIGHT + 100 then
        self.onScreen = 1
    else
        self.onScreen = 0
    end
end


function Entity:render()
    if self.onScreen == 1 then
        self.state:render() 
        x1,y1 = self.body:getWorldPoints(self.shape:getPoints())
        love.graphics.draw(self.texture, self.quads[self.frame], x1 + (self.scaleX<0 and self.width or 0), y1, 0, self.scaleX, self.scaleY)
    end
    
end









