StartState = Class {__includes = BaseState}

function StartState:init()
  self.timer = 0
  self.justArrived = true

  -- local texture = POKEMON_IDS[math.random(#POKEMON_IDS)]
  self.sprite = tostring(POKEMON_IDS[math.random(#POKEMON_IDS)] ..'-front')
  self.spriteX  = (VIRTUAL_WIDTH / 2) - gTextures[self.sprite]:getWidth() / 2
  self.tween = Timer.every(5, function()
    Timer.tween(0.25, {
      [self] = {spriteX = -64}
    }):finish(
    function()


        self.spriteX = VIRTUAL_WIDTH + 64
        self.sprite = tostring(POKEMON_IDS[math.random(#POKEMON_IDS)] ..'-front')
        Timer.tween(0.25, {
          [self] = {spriteX = (VIRTUAL_WIDTH / 2) - gTextures[self.sprite]:getWidth() / 2}
        })

      end)

  end)

end

function StartState:triggerMenu()
  local menu = MenuState({
  x = VIRTUAL_WIDTH / 2 - 50, y = VIRTUAL_HEIGHT - 70, width = 100, height = 60,
  visible = false, update = true, scrollBar = true, align = 'center', maxRows = 5, rows= 3, items = {
    {
      text = 'Play',
      onSelect = function()
        gStateStack:pop()
        -- gStateStack:pop()
        -- gStateStack:push(FadeInState({0, 0, 0}, .63, function()

          gStateStack:push(PlayState())
          -- gStateStack:push(FadeOutState({1, 1, 1}, .63, function()


        --   end))
        -- end))
      end
    },
    {
      text = 'Settings',
      onSelect = function()

      end
    },
    {
      text = 'Test',
      onSelect = function()
        gStateStack:push(TestState())
      end
    }
  }
  })

  gStateStack:push(menu)
end

function StartState:enter()
  self.justArrived = true
  gStateStack:push(FadeOutState({0, 0, 0}, 1.25), function() end, false)
end

function StartState:exit()
  gStateStack:pop() -- Pop the Menu from the Stack
end

function StartState:handleInput()
end

function StartState:update(dt)
  self.timer = self.timer + dt


  if self.justArrived then
    self:triggerMenu()
    self.justArrived = false
    return
  end
  self.tween:update(dt)

  return false
end

function StartState:render()

  local shader = SHADER_DEFS['beautiful-colors']
  love.graphics.setShader(shader)
    shader:send('time', self.timer)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  love.graphics.setShader()
  if not self.justArrived then
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(gFonts['huge'])
    love.graphics.printf('Postymon', 0, 32, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
  end

  love.graphics.setColor(.61, .99, 0, 1)
  love.graphics.ellipse('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT -80 , 60, 16)

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(gTextures[self.sprite], self.spriteX, VIRTUAL_HEIGHT - gTextures[self.sprite]:getHeight() - 75)


end
