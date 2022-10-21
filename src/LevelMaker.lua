function LevelMaker(columns, rows)
    tileMap={}
    entities={}
    -- grid of zeroes for locating fixed tiles
    for x = 1, columns do
        table.insert(tileMap, {})
        for y = 1, rows do
            -- border
            if x == 1 or x==columns or y == 1 or y==rows then
                table.insert(tileMap[x], Tile(x,y,'tile'))
            else 
                table.insert(tileMap[x], 0) 
            end         
        end
    end
    
    
    tileMap[8][rows -3] = Tile(8,rows -3,'?')
    tileMap[5][rows -3] = Tile(5,rows -3,'?')
    tileMap[1][rows -3] = Tile(1,rows -3,'?')
    tileMap[15][rows].body:destroy()
    tileMap[16][rows].body:destroy()
    tileMap[15][rows]=0
    tileMap[16][rows]=0
    
    entities[1]= Hedgehog(100,100,0.125)
    -- entities['hedgehog1'] = Entity{indexX=3, indexY=1, dx=30,texture=textures['hero'], quads=heroQuads, frames={4,3,2,1}, scale = 0.2}
    -- entities['hedgehog2'] = Entity{indexX=20, indexY=9, dx=-30,texture=textures['hero'], quads=heroQuads, frames={4,3,2,1}, scale = 0.2}
    -- for i = 10, 18 do
    --     tileMap[12][i] = Tile(12,i,'?')
    -- end

    return tileMap, entities
end