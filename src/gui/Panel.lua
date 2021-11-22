Panel = Class {}

function Panel:init(def)
  self.x = def.x
  self.y = def.y
  self.width = def.width
  self.height = def.height

  self.color = def.color or {1, 1, 1, 1}
  self.borderColor = def.borderColor or {0, 0, 0, 1}
  self.borderWidth = def.borderWidth or 3
  self.borderPadding = def.borderPadding or 3
  self.roundedBorder = def.roundedBorder or 5

  if def.visible == nil then self.visible = true else self.visible = def.visible end
end

function Panel:toggle()
  self.visible = not self.visible
end

function Panel:update(dt)

end

function Panel:render()
  if self.visible then
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.roundedBorder)

    love.graphics.setColor(self.borderColor)
    love.graphics.setLineWidth(self.borderWidth)
    love.graphics.rectangle('line', self.x + self.borderPadding / 2, self.y + self.borderPadding / 2, self.width - self.borderPadding, self.height - self.borderPadding, self.roundedBorder)
    love.graphics.setLineWidth(1)

    love.graphics.setColor(1, 1, 1, 1)
  end
end
