PlayerHealth = Class()

function PlayerHealth:init(health)
    self.health = health
end

function PlayerHealth:render()
    heartcount = 0
    for i = 1, math.floor(self.health/2) do
        love.graphics.draw(textures['tiles'], quads['heart'], VIEWPORT_WIDTH - 125 +(40*(i-1)), 5)
        heartcount = heartcount + 1
    end
    -- render half hearts
    if self.health % 2 == 1 then
        love.graphics.draw(textures['tiles'], quads['halfHeart'], VIEWPORT_WIDTH - 125 +(40*heartcount), 5)
    end

end