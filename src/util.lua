-- convert x, y values to tile indices
function TileIndex(vals)
    for i, val in pairs(vals) do
        vals[i] = math.floor(val/40) + 1
    end
    return vals
end


-- adjust object poistion given collision
function AdjustPosition(object, collisions, dt)
    if #object.tileCollisions['down'] > 0 then
        object.dy = 0
        object.y = (TileIndex{object.y + object.height}[1] - 1) * 40 - object.height
    end
    if #object.tileCollisions['up'] > 0 then
        object.dy = 0
        object.y = (TileIndex{object.y}[1] - 1) * 40
    end
    if #object.tileCollisions['left'] > 0 then
        object.dx = 0
        object.x = (TileIndex{object.x}[1]) * 40
    end
    if #object.tileCollisions['right'] > 0 then
        object.x = object.x - (dx * dt)
        object.dx = 0
           end
end