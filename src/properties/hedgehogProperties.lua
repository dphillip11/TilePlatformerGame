function hedgehogProperties(self, x_, y_, scale_)
    return self, {

    state = StateMachine{
        ['idle'] =  function() return IdleState{object=self, frames={1}}end,
        ['walking'] =  function() return WalkingState{object=self, frames={1,2,3,4}}end,
        ['jumping'] =  function() return JumpingState{object=self, frames={1,2,3,4}}end,
        ['falling'] =  function() return FallingState{object=self, frames={2}}end
    },
    scale = scale_ or 0.2,
    texture = textures['hedgehog'],
    quads = hedgehogQuads,
    x = x_,
    y = y_,
    type='hedgehog'
}
end