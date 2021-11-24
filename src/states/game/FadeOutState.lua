FadeOutState = Class {__includes = BaseState}

function FadeOutState:init(color, time, onFadeComplete, contine)
  self.r = color[1]
  self.b = color[2]
  self.g = color[3]

  self.onFadeComplete = onFadeComplete or function() end
  self.alpha = 1

  self.time = time
  if contine == nil then self.continue = false else self.contine = contine end

  Timer.tween(self.time, {
    [self] = {alpha = 0}
  }):finish(
  function()
    gStateStack:pop()
    self.onFadeComplete()
  end)
end


function FadeOutState:update(dt)
  return self.contine
end

function FadeOutState:render()
  love.graphics.setColor(self.r, self.b, self.g, self.alpha)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  love.graphics.setColor(1, 1, 1, 1)
end
