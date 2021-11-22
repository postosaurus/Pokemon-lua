ProgressBar = Class {}

function ProgressBar:init(def)
  self.x = def.x
  self.y = def.y
  self.width = def.width
  self.height = def.height

  self.value = def.value
  self.maxValue = def.maxValue
  self.color = def.color or {0, .7, .4, 1}
  self.borderColor = def.borderColor or {0, 0, 0, 1}
  self.roundedBorder = def.roundedBorder or 5

end

function ProgressBar:setValue(value)
    self.value = math.min(value, self.maxValue)
end

function ProgressBar:setMax()
  self.value = self.maxValue
end

function ProgressBar:render()
  local value = (self.value / self.maxValue) * self.width
  love.graphics.setColor(self.borderColor)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height, self.roundedBorder)

  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, value, self.height, self.roundedBorder)


  love.graphics.setColor(1, 1, 1, 1)
end
