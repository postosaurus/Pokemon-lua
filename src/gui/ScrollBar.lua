ScrollBar = Class {}

function ScrollBar:init(def)
  self.x = def.x
  self.y = def.y
  self.width = def.width
  self.height = def.height

  self.value = def.value
  self.maxValue = def.maxValue

  self.tileHeight = self.height / self.maxValue

  self.color = def.color or {0, 0, 0, 1}
  self.borderColor = def.borderColor or {0, 0, 0, 1}
  self.roundedBorder = def.roundedBorder or 5

end

function ScrollBar:setValue(value)
    self.value = math.min(value, self.maxValue)
end

function ScrollBar:setMax()
  self.value = self.maxValue
end

function ScrollBar:render()
  local value = (self.value / self.maxValue) * self.height
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.roundedBorder)

  love.graphics.setColor(self.borderColor)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height, self.roundedBorder)

  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y + value - self.tileHeight, self.width, self.tileHeight, self.roundedBorder)


  love.graphics.setColor(1, 1, 1, 1)
end
