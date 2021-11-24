Panel = Class {}

function Panel:init(def)

  self.x = def.x or 0
  self.y = def.y or 0
  self.width = def.width or VIRTUAL_WIDTH
  self.height = def.height or 64

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
    love.graphics.setColor(0, 0, 0, 1)
    -- love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    shader = SHADER_DEFS['gradient']
    love.graphics.setShader(shader)
    -- shader:send()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.roundedBorder)

    love.graphics.setShader()
    love.graphics.setColor(self.borderColor)
    love.graphics.setLineWidth(self.borderWidth)
    love.graphics.rectangle('line', self.x + self.borderPadding / 2, self.y + self.borderPadding / 2, self.width - self.borderPadding, self.height - self.borderPadding, self.roundedBorder)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)

  end
end
