Entity = Class{}

function Entity:init(def)
    -- define physical atributes
    self.responsive = false
    indexX = def.indexX or level.rows-2
    indexY = def.indexY or level.rows-2
    self.x = (indexX - 1) * 40
    self.y = (indexY - 1) * 40
    self.dx = def.dx or 0
    self.dy = def.dy or 0
    self.texture = def.texture or textures['hedgehog']
    self.quads = def.quads or hedgehogQuads
    _,_,self.qWidth, self.qHeight = self.quads[1]:getViewport( )
    self.scaleX = def.scale or 1
    self.scaleY = def.scale or 1
    self.height = self.qHeight*self.scaleY 
    -- or 40
    self.width = self.qWidth*self.scaleY 
    -- or 40
    self.frame = 1
    self.onScreen = 0
    self.state = def.state or StateMachine{
        ['idle'] = IdleState{object=self, frames=def.frames},
        ['walking'] = WalkingState{object=self, frames=def.frames},
        ['jumping'] = JumpingState{object=self, frames=def.frames},
        ['falling'] = FallingState{object=self, frames=def.frames}
    }
    self.state:change('walking')
    self.tileCollisions ={}
     -- physical properties
     self.body = love.physics.newBody( world, self.x - self.width/2, self.y- self.height/2, 'dynamic')
     self.shape = love.physics.newRectangleShape(self.width,self.height)
     self.fixture = love.physics.newFixture( self.body, self.shape)
     self.fixture:setFriction(1)
end


function Entity:update(dt)
    if self.onScreen then
        self.body:setAngle(0)

        -- create list of collisions
        self.tileCollisions = level:collision(self)

        -- update state collision choices
        self.state:update(dt)
        
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










