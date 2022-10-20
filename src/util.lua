-- convert x, y values to tile indices
function TileIndex(vals)
    for i, val in pairs(vals) do
        vals[i] = math.floor(val/40) + 1
    end
    return vals
end



