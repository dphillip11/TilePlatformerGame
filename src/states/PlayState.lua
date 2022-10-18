PlayState = Class{__includes = BaseState}

function PlayState:init()
    hero = Hero()
    playerHealth = 6
    background = Background{}
    level=LevelCreator(300)
    -- level tweens
    level.glides={}
    level.entities={}
end


function PlayState:update(dt)
    hero:update(dt)
    background:update(dt)
    if love.keyboard.wasPressed('r') then
        playerHealth = 6
    end
    -- update level tween for aimation
    for i, glide in pairs(level.glides) do
        glide:update(dt)
        if glide.stopped == 1 then
            table.remove(level.glides,i)
        end
    end
    for i, entity in pairs(level.entities) do
        entity:update(dt)
        if entity.active == 0 then
            table.remove(level.entities,i)
        end
    end
end


function PlayState:render()
    background:render()
    for i, entity in pairs(level.entities) do
        entity:render()
    end
    level:render()
    hero:render()
    heartcount=0
    -- render health in hearts
    for i = 1, math.floor(playerHealth/2) do
        love.graphics.draw(textures['tiles'], quads['heart'], VIEWPORT_WIDTH - 125 +(40*(i-1)), 5)
        heartcount = heartcount + 1
    end
    -- render half hearts
    if playerHealth%2 == 1 then
        love.graphics.draw(textures['tiles'], quads['halfHeart'], VIEWPORT_WIDTH - 125 +(40*heartcount), 5)
    end
    -- renderFPS for debugging
    -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

