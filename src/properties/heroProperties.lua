function heroProperties(self, x_,  y_)
    return self, {

    state = StateMachine{
        ['idle'] = function() return IdleState{object=self, frames={1}} end,
        ['walking'] = function() return WalkingState{object=self, frames={1,2,1,3,1,4,1,5}} end,
        ['jumping'] = function() return JumpingState{object=self, frames={2,3,4,5}} end,
        ['falling'] = function() return FallingState{object=self, frames={2,3,4,5}} end
    },
    scale = HERO_SCALE,
    texture = textures['hero'],
    quads = heroQuads,
    x = 200,
    y = 500,
    type='hero'
}
end


