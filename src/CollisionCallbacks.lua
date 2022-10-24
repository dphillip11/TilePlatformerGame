function beginContact(a, b, coll)
    a = a:getUserData()
    b = b:getUserData()
    x, y = coll:getNormal()
    if a.type == 'hero' and b.type == '?' then
        if math.abs(x) < 1 and y < 0 then
             b:collide()
        end
    end

    if b.type == 'hero' and a.type == '?' then
        if math.abs(x) < 1 and y > 0 then
             a:collide()
        end
    end


    if (a.type == 'hero' or b.type == 'hero') and (a.type == 'hedgehog' or b.type == 'hedgehog') then
        healthbar.health = math.max(healthbar.health -1, 0)
        b.body:setLinearVelocity(b.dx,-100)
        a.body:setLinearVelocity(-a.dx,-100)
    end

    if (a.type == 'hero' or b.type == 'hero') then
        a:collide()
        b:collide()
    end

end

 



