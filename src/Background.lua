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
    self.x = -SCROLL_X/6 % 1008
    self.jungleX = -SCROLL_X/3 % 2100

end

function Background:render()
    -- images joined end to end, piecewise using quads would be more efficient, minimally 3 but more for less rendered outside of screenspace
    love.graphics.draw(textures['background']['jungle'], self.x, self.y)
    love.graphics.draw(textures['background']['jungle'], self.x - 1008, self.y)
    love.graphics.draw(textures['background']['jungle'], self.x + 1008, self.y)


    love.graphics.draw(textures['grass'], self.jungleX, self.grassY - SCROLL_Y/10, 0, 1, 2)
    love.graphics.draw(textures['grass'], self.jungleX - 2100, self.grassY - SCROLL_Y/10, 0, 1, 2)
    love.graphics.draw(textures['grass'], self.jungleX + 2100, self.grassY - SCROLL_Y/10, 0, 1, 2)
    love.graphics.draw(textures['jungle'], self.jungleX, self.jungleY - SCROLL_Y/5)
    love.graphics.draw(textures['jungle'], self.jungleX - 2100, self.jungleY - SCROLL_Y/5)
    love.graphics.draw(textures['jungle'], self.jungleX + 2100, self.jungleY - SCROLL_Y/5)
    
end
