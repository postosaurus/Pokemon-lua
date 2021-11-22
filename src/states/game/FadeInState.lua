FadeInState = Class {__includes = BaseState}

function FadeInState:init(color, time, onFadeComplete)
  self.r = color[1]
  self.b = color[2]
  self.g = color[3]

  self.alpha = 0

  self.time = time
  self.onFadeComplete = onFadeComplete or function() end
end

function FadeInState:enter()
  Timer.tween(self.time, {
    [self] = {alpha = 1}
  }):finish(
  function()
    gStateStack:pop()
    self.onFadeComplete()
  end)
end

function FadeInState:update(dt)

end

function FadeInState:render()
  love.graphics.setColor(self.r, self.b, self.g, self.alpha)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  love.graphics.setColor(1, 1, 1, 1)
end
