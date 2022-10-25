function heartProperties(self, x_, y_)
    return self, {

    state = StateMachine{
        ['rising'] =  function() return RisingState{object=self, frames={'heart'}}end,
        ['moving'] =  function() return MovingState{object=self, frames={'heart'}}end
    },
    texture = textures['tiles'],
    quads = quads,
    x = x_,
    y = y_,
    type='heart'
}
end