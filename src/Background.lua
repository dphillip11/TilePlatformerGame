Background = Class{}

function Background:init()
    self.x = 0
    self.y = 0
    self.jungleX = 0
    self.jungleY = 0
    self.grassY = VIEWPORT_HEIGHT- 400
    self.midgroundX = 0
end

function Background:update(dt)
    -- self.x = -((hero.x/HERO_SPEED) * BACKGROUND_SCROLL_SPEED) % 1276
    self.jungleX = -((hero.x/HERO_SPEED) * FOREGROUND_SCROLL_SPEED) % 2100
    self.midgroundX = -((hero.x/HERO_SPEED) * MIDGROUND_SCROLL_SPEED) % 2100
end

function Background:render()
    -- images joined end to end, piecewise using quads would be more efficient, minimally 3 but more for less rendered outside of screenspace
    love.graphics.draw(textures['background']['jungle'], self.x, self.y)
    -- love.graphics.draw(textures['background']['jungle'], self.x - 1276, self.y)
    -- love.graphics.draw(textures['background']['jungle'], self.x + 1276, self.y)

    -- love.graphics.draw(textures['midground']['jungle'][2], self.midgroundX, 0)
    -- love.graphics.draw(textures['midground']['jungle'][1], self.midgroundX - 1610, 0)
    -- love.graphics.draw(textures['midground']['jungle'][3], self.midgroundX + 1350, 0)

    love.graphics.draw(textures['grass'], self.jungleX, self.grassY, 0, 1, 2)
    love.graphics.draw(textures['grass'], self.jungleX - 2100, self.grassY, 0, 1, 2)
    love.graphics.draw(textures['grass'], self.jungleX + 2100, self.grassY, 0, 1, 2)
    love.graphics.draw(textures['jungle'], self.jungleX, self.jungleY + SCROLL_Y/3)
    love.graphics.draw(textures['jungle'], self.jungleX - 2100, self.jungleY + SCROLL_Y/3)
    love.graphics.draw(textures['jungle'], self.jungleX + 2100, self.jungleY + SCROLL_Y/3)
    
end
