
Squirrel = Class{__includes = Entity}

function Squirrel:init(x_, y_, scale_)
    Entity.init(squirrelProperties(self, x_, y_, scale_))
    self.acorns={}
    self.state:change('falling')
    self.active = 1
end

function Squirrel:update(dt)
    if self.active == 1 then
        Entity.update(self, dt)
        for _, acorn in pairs(self.acorns) do
            acorn:update(dt)
        end
        for i, acorn in pairs(self.acorns) do
            if acorn.active == 0 then
                table.remove(self.acorns,i)
            end
        end
    end
end

function  Squirrel:render()
    if self.active == 1 then
        Entity.render(self)
        for _, acorn in pairs(self.acorns) do
            acorn:render()
        end
    end
end

function Squirrel:collide()
    self.body:destroy()
    self.active = 0
end





