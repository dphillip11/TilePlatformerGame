-- Entity = Class{}

-- function Entity:init(indexX,indexY, dx, dy)
-- self.x = (indexX - 1) * 40
-- self.dx = dx or 0
-- self.dy = dy or 0
-- self.onScreen = 0

-- -- type
-- self.type = 'hedgehog'

-- self.directionX='E'
-- self.directionY='S'
-- self.scale = 0.2
-- self.width = 514 * self.scale
-- self.height = 500 * self.scale
-- self.y = (indexY - 1) * 40  - self.height
-- end

-- function Entity:update(dt)
--     if self.dx > 0 then 
--         self.directionX = 'E'
--     else
--         self.directionX = 'W'
--     end
--     if self.x - hero.x + HERO_OFFSET > -50 and self.x - hero.x + HERO_OFFSET < VIEWPORT_WIDTH then
--         self.onScreen = 1
--     else
--         self.onScreen = 0
--     end
--     if self.onScreen == 1 and self.active == 1 then
--         self.animationTimer = self.animationTimer + dt
--         if self.animationTimer > self.animationInterval then
--             self.animationTimer = 0
--             self.frame = (self.frame % self.frames) + 1
--         end
--         -- try move y
--         self.y = self.y + (self.dy * dt)
--         -- if collide then unmove, cancel speed
--         -- set direction to determine collision response
--         if self.dy > 0 then
--             self.directionY = 'S'
--         else
--             self.directionY = 'N'
--         end
--         if level:collision(self) then
--             self.y = self.y - (self.dy * dt)
--             self.dy = 0
--         end
--         --try x move
--         self.x = self.x + (self.dx * dt)
--         --if collide, unmove, reset speed
--         if level:collision(self) then
--             self.x = self.x - (self.dx * dt)
--             self.dx = 0
--         end
--         --check for ground
--         self.y = self.y + (GRAVITY * dt)
--         -- if collide then unmove, cancel speed
--         self.directionY = 'S'
--         if level:collision(self) then
--             self.y = self.y - (GRAVITY * dt)
--             self.dy = 0
--         else
--             self.dy = self.dy + GRAVITY
--         end

--     end   
-- end



-- function Entity:render()
--     if self.onScreen == 1 and self.active == 1 then
--         if self.directionX == 'W' then
--             love.graphics.draw(textures[self.type], hedgehogQuads[self.frame], self.x - hero.x + HERO_OFFSET + self.width, self.y + SCROLL_Y, 0, self.scale, self.scale)
--         else 
--             love.graphics.draw(textures[self.type], hedgehogQuads[self.frame], self.x - hero.x + HERO_OFFSET + self.width, self.y + SCROLL_Y, 0, -self.scale, self.scale)
--         end
--     end
-- end










