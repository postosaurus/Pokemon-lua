StateStack = Class{}

function StateStack:init(states)
  self.states = states or {}
end

function StateStack:push(state)
  table.insert(self.states, state)
  state:enter()
end

function StateStack:pop()
  print("Stack pops state")
  self.states[#self.states]:exit()
  table.remove(self.states)
end

function StateStack:update(dt)
  for k = #self.states, 1, -1 do
    local v = self.states[k]
    local continue = v:update(dt)
    if not continue then
      break
    end
  end

  local top = self.states[#self.states]
  if not top then
      return
  end

  top:handleInput()
end

function StateStack:render()
  for i in pairs(self.states) do
    self.states[i]:render()
  end
end

function StateStack:clear()
  self.states = {}
end
