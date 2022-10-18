Background = Class{}

function Background:init()
    self.x = 0
    self.y = 0
    self.jungleX = 0
    self.jungleY = 0
end

function Background:update(dt)
    self.x = -((hero.x/HERO_SPEED) * BACKGROUND_SCROLL_SPEED) % 1276
    self.jungleX = -((hero.x/HERO_SPEED) * MIDGROUND_SCROLL_SPEED) % 2100
end

function Background:render()
    -- images joined end to end, piecewise using quads would be more efficient, minimally 3 but more for less rendered outside of screenspace
    love.graphics.draw(textures['background'], self.x, self.y)
    love.graphics.draw(textures['background'], self.x - 1276, self.y)
    love.graphics.draw(textures['background'], self.x + 1276, self.y)
    love.graphics.draw(textures['jungle'], self.jungleX, self.jungleY + SCROLL_Y/3)
    love.graphics.draw(textures['jungle'], self.jungleX - 2100, self.jungleY + SCROLL_Y/3)
    love.graphics.draw(textures['jungle'], self.jungleX + 2100, self.jungleY + SCROLL_Y/3)
end
