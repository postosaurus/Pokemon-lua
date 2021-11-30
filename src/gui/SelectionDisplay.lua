SelectionDisplay = Class{__includes = Selection}

function SelectionDisplay:init(def)
  Selection.init(self, def)
end

function SelectionDisplay:update(dt)

end

function SelectionDisplay:render()
  love.graphics.setColor(self.textColor)

    local displayStart = self.displayStart
    local displayEnd = displayStart + self.rows - 1


    local itemIndex = ((displayStart - 1) * self.columns) + 1
    local charHeight = self.font:getHeight(self.items[1])

    local x = self.x + self.paddingLeft
    local y = self.y + self.paddingTop
    local lineHeight = self.font:getHeight('A') + self.lineSpace

    for i = displayStart, displayEnd do
      for j = 1, self.columns do
        love.graphics.setColor(0, 0, 0, 1)
        local item = self.items[itemIndex]

        if i == self.focusY and j == self.focusX and self.cursor then
          local fontSize = self.font:getHeight()
          local font = love.graphics.newFont('fonts/font.ttf', fontSize)
          love.graphics.setColor(self.markerColor)
          love.graphics.setFont(font)
          if item then
            love.graphics.setColor(1, 0, 0, 1)
            item(self, true)
          end
          love.graphics.setFont(self.font)

        end

        love.graphics.setColor(self.textColor)
        if item then

          item(self)
        end

        x = x + self.columnWidth + self.paddingLeft
        itemIndex = itemIndex + 1
      end

      y = y + lineHeight
      x = self.x + self.paddingLeft
    end

    if self.scrollBar then
      self.scrollBar:render()
    end

end

function SelectionDisplay:renderItem(item, x, y)

  if self.align then
    love.graphics.printf(item.text, x, y, self.width - self.paddingLeft, self.align)
  else
    love.graphics.print(item.text, x, y)
  end
end
