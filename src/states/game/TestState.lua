TestState = Class {__includes = BaseState}

function TestState:init()
  self.timer = 0
  self.r = math.random(1, 255)/255
  self.g = math.random(1, 255)/255
  self.b = math.random(1, 255)/255
  self.power = math.random(20)
  self.tween = Timer.every(16, function()
    Timer.tween(8, {
      [self] = {r = 1, g = 1, b = 1, power = math.random(20)}
    }):finish(function()

      -- self.r = 0
      -- self.g = 0
      -- self.b = 0
      -- self.power = 0
      Timer.tween(8, {
        [self] = {r = math.random(1, 255)/255, g = math.random(1, 255)/255, b = math.random(1, 255)/255, power = 0}
      })
    end)
  end)
end

function TestState:enter()

end

function TestState:handleInput()
  if love.keyboard.wasPressed('q') then
    gStateStack:pop() -- pop this
  end
end

function TestState:update(dt)
  self.timer = self.timer + dt
  self.tween:update(dt)
  return false
end

function TestState:render()

  local shader = SHADER_DEFS['lights']
  love.graphics.setShader(shader)

  shader:send("num_lights", 2)
  shader:send("screen", {VIRTUAL_WIDTH, VIRTUAL_HEIGHT})


    lights = {

      -- {position =  {VIRTUAL_WIDTH, VIRTUAL_HEIGHT},
      -- diffuse = {1.0, 1.0, 0.0},
      -- power = 15},
      --
      -- {position =  {0, 0},
      -- diffuse = {1.0, 0.0, 0.0},
      -- power = 10},

      {position =  {VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT /2},
      diffuse = {self.r, self.g, self.b},
      power = self.power},
    }

    shader:send("num_lights", #lights)
      for i, light in ipairs(lights)do
         local name = "lights[" .. i-1 .."]"
         print(name)
         shader:send(name .. ".position", light.position)
         shader:send(name .. ".diffuse", light.diffuse)
         shader:send(name .. ".power", light.power)
      end
      love.graphics.setColor(1, 1, 1, 1)

  love.graphics.setFont(gFonts['small'])
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  love.graphics.setShader()

  -- shader = SHADER_DEFS['beautiful-colors']
  -- love.graphics.setShader(shader)
  -- shader:send('time', self.timer)
  -- love.graphics.printf('Postymon', 0, 32, VIRTUAL_WIDTH, 'center')
  love.graphics.setShader() 


  love.graphics.setColor(1, 1, 1, 1)
end
