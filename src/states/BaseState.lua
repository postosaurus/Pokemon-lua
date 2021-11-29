BaseState = Class{}

  function BaseState:init() end
  function BaseState:enter()
    love.keyboard.keysPressed = {}
  end

  function BaseState:handleInput() end

  function BaseState:update(dt) return false end

  function BaseState:render() end

  function BaseState:exit()
    love.keyboard.keysPressed = {}
  end
