Bone = Class{}

function Bone:init(x,y)
    self.x = x
    self.y = y
    self.height = 80
    self.width = 60
    self.active = 1
    self.type = 'bone'
    self.scaleY = 1
end

function Bone:collide()
    self.found = 0
end

function Bone:update(dt)
end

function Bone:render()
    love.graphics.draw(textures['bone'], self.x, self.y)
    if self.found == 0 then
        -- level = loadLevel(3)
        -- gameState:change('play', level)
        gameState:change('title', level)
    end
end