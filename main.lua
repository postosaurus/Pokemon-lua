require 'src/Dependencies'

math.randomseed(os.time())

function love.load()
    --setting graphics and window, initialzing push for having good arcade game resolutuon
    love.graphics.setDefaultFilter('nearest', 'linear')
    love.window.setTitle('Pokemon Simulation')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable =  true})

    gStateStack = StateStack()
    -- gStateStack:push(StartState())
    gStateStack:push(PlayState())

    GAMESTATES = {
      ['start'] = StartState,
      ['play'] = PlayState,
      ['test'] = TestState
    }
    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(key)
  return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
  return love.mouse.keysReleased[key]
end

function love.update(dt)
    if love.keyboard.isDown('escape') then
      love.event.quit()
    elseif love.keyboard.isDown('r') then
      love.event.quit('restart')
    end

    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
