-- convert x, y values to tile index
function pointToIndex(x,y)
    xIndex = math.floor(x/40) + 1
    yIndex = math.floor(y/40) + 1
    return xIndex,yIndex
end

function indexToPoint(indexX,indexY)
    x = (indexX + 1) * 40
    y = (indexY + 1) * 40
    return x,y
end



