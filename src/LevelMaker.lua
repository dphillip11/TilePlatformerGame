function LevelMaker(columns, rows)
    tileMap={}
    entities={}
    -- grid of zeroes for locating fixed tiles
    for x = 1, columns do
        table.insert(tileMap, {})
        for y = 1, rows do
                    table.insert(tileMap[x], 0)            
        end
    end
    -- ground to walk on
    for i = 1, columns do
        for j = 12, rows do
            tileMap[i][j] = Tile(i,j,'tile')
        end
    end
    tileMap[8][8] = Tile(8,8,'?')
    tileMap[5][5] = Tile(5,5,'?')
    tileMap[1][5] = Tile(1,5,'?')
    
    entities['hedgehog3'] = Entity{indexX=40, indexY=9, dx=-HERO_SPEED,texture=textures['hero'], quads=heroQuads, frames={4,3,2,1}, scale = 0.4}
    entities['hedgehog1'] = Entity{indexX=3, indexY=1, dx=30,texture=textures['hero'], quads=heroQuads, frames={4,3,2,1}, scale = 0.2}
    entities['hedgehog2'] = Entity{indexX=20, indexY=9, dx=-30,texture=textures['hero'], quads=heroQuads, frames={4,3,2,1}, scale = 0.2}
    for i = 10, 18 do
        tileMap[12][i] = Tile(12,i,'?')
    end

    return tileMap, entities
end