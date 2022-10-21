function squirrelProperties(self, x_, y_, scale_)
    return self, {

    state = StateMachine{
        ['escaping'] =  function() return EscapingState{object=self, frames={1}}end,
        ['throwing'] = function() return ThrowingState{object=self, frames={1,2,3,1,2}}end,
        ['jumping'] =  function() return SqJumpingState{object=self, frames={1}}end,
        ['falling'] = function() return SqFallingState{object=self, frames={1}}end
    },
    scale = scale_ or 0.2,
    texture = textures['squirrel'],
    quads = squirrelQuads,
    x = x_,
    y = y_,
    type='squirrel'
}
end