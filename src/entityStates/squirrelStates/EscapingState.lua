EscapingState = Class{__includes = BaseState}

function EscapingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames, interval=0.2}
end

function EscapingState:update(dt)
  
    if math.abs(hero.x - self.object.x)> 400 or math.abs(hero.y - self.object.y) > 200 then
        self.object.state:change('throwing')
    else
        if hero.x - self.object.x > 0 then
            self.object.dx =-400
        else
            self.object.dx = 400
        end
        xi,yi = pointToIndex(self.object.x + (self.object.dx/2), self.object.y+ self.object.height)
        yi = math.min(yi + 1,level.rows) 
        if level.tileMap[xi] and level.tileMap[xi][yi] == 0 then
            self.object.dx = - self.object.dx
        elseif not level.tileMap[xi] then
            self.object.dx = - self.object.dx
        end
    end
    if math.random(0,100)>90 and self.object.dy and math.abs(self.object.dy)< 5 then
        self.object.dy = -750 
        self.object.state:change('jumping')
    end

    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
end