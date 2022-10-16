Background = Class{}

function Background:init()
    self.x = 0
    self.y = 0
end

function Background:update(dt)
    self.x = -((hero.x/HERO_SPEED) * BACKGROUND_SCROLL_SPEED) % 1276
end

function Background:render()
    love.graphics.draw(textures['background'], self.x, self.y)
    love.graphics.draw(textures['background'], self.x - 1276, self.y)
    love.graphics.draw(textures['background'], self.x + 1276, self.y)
end
