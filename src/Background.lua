Background = Class{}

function Background:init()
    self.x = 0
    self.y = 0
end

function Background:update(dt)
    if love.keyboard.isDown('right') then
        self.x = (self.x - (BACKGROUND_SCROLL_SPEED * dt)) % 1276
    end
    if love.keyboard.isDown('left') then
        self.x = (self.x + (BACKGROUND_SCROLL_SPEED * dt)) % 1276
    end
end

function Background:render()
    love.graphics.draw(textures['background'], self.x, self.y)
    love.graphics.draw(textures['background'], self.x - 1276, self.y)
    love.graphics.draw(textures['background'], self.x + 1276, self.y)
end
