-- convert x, y values to tile indices
function TileIndex(vals)
    for i, val in pairs(vals) do
        vals[i] = math.floor(val/40) + 1
    end
    return vals
end


-- adjust object poistion given collision
function AdjustPosition(object, collisions, dt)
    if #object.tileCollisions['up'] > 0 then
        object.dy = 0
        object.y = (TileIndex{object.y}[1]) * 40 + 3
    end
    if #object.tileCollisions['down'] > 0  then
        object.dy = 0
        object.y = (TileIndex{object.y + object.height + 5}[1] - 1) * 40 - object.height
    end
    if #object.tileCollisions['left'] > 0 then
        object.x = (TileIndex{object.x - 5}[1]) * 40
        object.dx = 0
    end
    if #object.tileCollisions['right'] > 0 then
        object.x = (TileIndex{object.x + object.width + 5}[1] - 1) * 40 - object.width
        object.dx = 0
    end
end