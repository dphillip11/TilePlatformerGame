-- StateMachine = Class{}

-- function StateMachine:init(states)
--     self.states = states
--     self.states['empty'] = BaseState()
--     self.currentState = 'empty'
-- end

-- function StateMachine:change(newState)
--     self.states[self.currentState]:exit()
--     self.states[newState]:enter()
--     self.currentState = newState
-- end

-- function StateMachine:update(dt)
--     self.states[self.currentState]:update(dt)
-- end

-- function StateMachine:render()
--     self.states[self.currentState]:render()
-- end

StateMachine = Class{}

function StateMachine:init(states)
	self.empty = {
		render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	self.current:exit()
	self.current = self.states[stateName]()
	self.current:enter(enterParams)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end

    