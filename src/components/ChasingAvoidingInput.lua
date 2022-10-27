ChasingAvoidingInput = Class{}

function ChasingAvoidingInput:init(obj)
    self.object = obj
    self.chasing = 0
    self.object.dx = 50
end

function ChasingAvoidingInput:update(dt)
    
        if math.abs(hero.x - self.object.x)< 200 and math.abs(hero.y - self.object.y) < 200 then
            self.chasing = 1
        else
            self.chasing = 0
        end
        if self.chasing == 0 then
            -- avoid holes
            -- self.object.dx = self.object.dx > 0 and 50 or -50
            xi,yi = pointToIndex(self.object.x + (self.object.dx/2), self.object.y + 40)
            yi = math.min(yi + 1,level.rows) 
            if level.tileMap[xi] and level.tileMap[xi][yi] == 0 then
                self.object.dx = - self.object.dx
            elseif not level.tileMap[xi] then
                self.object.dx = - self.object.dx
            end
            if self.object.dx >= 0 and self.object.entityCollisions['right'] and #self.object.entityCollisions['right'] > 0 then
                self.object.dx = -50
            end
            if self.object.dx <= 0 and self.object.entityCollisions['left'] and #self.object.entityCollisions['left'] > 0 then
                self.object.dx = 50
            end
        end
        if self.chasing == 1 then
            if hero.x - self.object.x > 10 then
                self.object.dx = 100
      
            elseif hero.x - self.object.x > -10  then 
                self.object.dx = 0

            else
                self.object.dx = -100 
            end
        end
        

    
end