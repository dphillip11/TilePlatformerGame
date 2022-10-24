ChasingAvoidingInput = Class{}

function ChasingAvoidingInput:init(obj)
    self.object = obj
    self.chasing = 0
end

function ChasingAvoidingInput:update(dt)
    if self.object.body then
        self.object.body:setAngle(0)
        Vx, Vy = self.object.body:getLinearVelocity()
        x, y = self.object.body:getPosition()
        heroX, heroY = hero.body:getPosition()
        if math.abs(heroX - x)< 200 and math.abs(heroY - y) < 200 then
            self.chasing = 1
        else
            self.chasing = 0
        end
        if self.chasing == 0 then
            xi,yi = pointToIndex(x + (Vx/5), y)
            yi = math.min(yi + 1,level.rows) 
            if level.tileMap[xi] and level.tileMap[xi][yi] == 0 then
                self.object.body:setLinearVelocity(-Vx,Vy)
            elseif Vx > 0 then
                self.object.body:setLinearVelocity(50,Vy)
            else
                self.object.body:setLinearVelocity(-50,Vy)
            end
        end
        if self.chasing == 1 then
            if heroX - x > 10 then
                self.object.body:setLinearVelocity(100,Vy)
            elseif heroX - x > -10  then 
                self.object.body:setLinearVelocity(0,Vy)
            else
                self.object.body:setLinearVelocity(-100,Vy)
            end
        end
    end
    
end