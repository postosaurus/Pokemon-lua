BaseState = Class{}
  function BaseState:init() end
  function BaseState:enter() end
  function BaseState:update(dt) return false end
  function BaseState:render() end
  function BaseState:exit() end
  function BaseState:handleInput() end
