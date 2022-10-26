EscapingState = Class{__includes = BaseState}

function EscapingState:init(def)
    self.object = def.object
    self.animation = Animation{frames=def.frames, interval=0.2}
end

function EscapingState:update(dt)

    Vx = self.dx
    Vy = self.dy
    x, y = self.object.x, self.object.y
    heroX, heroY = hero.x, hero.y

    if math.abs(heroX - x)> 400 or math.abs(heroY - y) > 200 then
        self.object.state:change('throwing')
    else
        if heroX - x > 0 then
            self.object.dx =-400
        else
            self.object.dx = 400
        end
    end
    if math.random(0,100)>90 and Vy and math.abs(Vy)< 5 then
        self.object.dy = -750 
        self.object.state:change('jumping')
    end

    self.animation:update(dt)
    self.object.frame = self.animation:getFrame()
end