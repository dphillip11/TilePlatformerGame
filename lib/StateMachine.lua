StateMachine = Class{}

function StateMachine:init(states)
    self.states = states
    self.states['empty'] = BaseState()
    self.currentState = 'empty'
end

function StateMachine:change(newState)
    self.states[self.currentState]:exit()
    self.states[newState]:enter()
    self.currentState = newState
end

function StateMachine:update(dt)
    self.states[self.currentState]:update(dt)
end

function StateMachine:render()
    self.states[self.currentState]:render()
end
    
    