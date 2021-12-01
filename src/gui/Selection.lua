Selection = Class {}

function Selection:init(def)
  self.x = def.x
  self.y = def.y
  self.items = def.items

  self.font = def.font or gFonts['small']
  self.textColor = def.textColor or {0, 0, 0, 1}
  self.markerColor = def.markerColor or {.5, .5, .5, 1}
  self.markerWidth = def.markerWidth or 2

  self.paddingTop = def.paddingTop or 10
  self.paddingLeft = def.paddingLeft or 5
  self.lineSpace = def.lineSpace or 10

  if def.align == nil then self.align = false else self.align = def.align or 'left' end
  if def.cursor == nil then self.cursor = true else self.cursor = def.cursor end
  if def.scrollBar == nil then self.scrollBar = false else self.scrollBar = def.scrollBar end
  if def.closeOnSelect == nil then self.closeOnSelect = false else self.closeOnSelect = def.closeOnSelect end

  self.rows = def.rows or #self.items

  self.maxRows = def.maxRows or self.rows
  self.columns = def.columns or 1
  self.columnWidth = def.columnWidth or 50
  self.displayStart = 1
  self.focusX = 1
  self.focusY = 1

  self.width = def.width or self:calcWidth()
  self.height = def.height or self:calcHeight()

  if self.scrollBar then
    self.scrollBar = ScrollBar({
      x = self.x + self.width + 2,
      y = self.y + 2,
      width = 6,
      height = self.height- 4,
      value = self.focusY,
      maxValue = self.maxRows})
  end
end

function Selection:calcWidth()
  if self.columns == 1 then
    local maxItemWidth = 0
    for k, item in ipairs(self.items) do
      maxItemWidth =  math.max(self.font:getWidth(item.text), maxItemWidth)
    end

    return maxItemWidth + self.paddingLeft * 2
  else
    return self.columns * self.columnWidth + self.paddingLeft * 2
  end
end

function Selection:calcHeight()

  local lineHeight = self.font:getHeight(self.items[1].text) + self.lineSpace
  return self.rows * lineHeight + self.paddingTop
end

function Selection:handleInput()
    if love.keyboard.wasPressed('w') then
      self:moveUp()
    elseif love.keyboard.wasPressed('d') then
      self:moveRight()
    elseif love.keyboard.wasPressed('s') then
      self:moveDown()
    elseif love.keyboard.wasPressed('a') then
      self:moveLeft()
    elseif love.keyboard.wasPressed('space') then
      if self.items[self:getIndex()] then
        self.items[self:getIndex()]:onSelect()
      end
    end
end

function Selection:exit()
  if self.closeOnSelect then
    gStateStack:pop()
  end
end

function Selection:moveUp()
  self.focusY = math.max(self.focusY - 1, 1)
  if self.focusY < self.displayStart then
    self:moveDisplayUp()
  end
end

function Selection:moveDown()
  self.focusY = math.min(self.focusY + 1, self.maxRows)
  if self.focusY >= self.displayStart + self.rows then
    self:moveDisplayDown()
  end
end

function Selection:moveLeft()
  self.focusX = math.max(self.focusX - 1, 1)
end

function Selection:moveRight()
  self.focusX = math.clamp(self.focusX + 1, 1,  self.columns)
end

function Selection:moveDisplayUp()
  self.displayStart = self.displayStart - 1
end

function Selection:moveDisplayDown()
  self.displayStart = self.displayStart + 1
end

function Selection:getIndex()
  return self.focusX + ((self.focusY - 1) * self.columns)
end

function Selection:update(dt)
  if self.cursor then
    self:handleInput()

    if self.scrollBar then
      self.scrollBar:setValue(self.focusY)
    end
  end
end

function Selection:render()
  love.graphics.setColor(self.textColor)

    local displayStart = self.displayStart
    local displayEnd = displayStart + self.rows - 1


    local itemIndex = ((displayStart - 1) * self.columns) + 1
    local charHeight = self.font:getHeight(self.items[1])

    local x = self.x + self.paddingLeft
    local y = self.y + self.paddingTop
    local lineHeight = self.font:getHeight(self.items[1].text) + self.lineSpace

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
            self:renderItem(item, x+1, y+1)
          else
            self:renderItem({text = ' - '}, x+1, y+1)
          end
          love.graphics.setFont(self.font)

        end

        love.graphics.setColor(self.textColor)
        if item then
          self:renderItem(item, x, y)
        else
          self:renderItem({text = ' - '}, x, y)
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

function Selection:renderItem(item, x, y)

  if self.align then
    love.graphics.printf(item.text, x, y, self.width - self.paddingLeft, self.align)
  else
    love.graphics.print(item.text, x, y)
  end
end


function Selection:renderOnPanels(panels)
  if panels == nil then
    return
  end
  love.graphics.setColor(self.textColor)

  local displayStart = 1
  local itemIndex = ((displayStart - 1) * self.columns) + 1

  for i, panel in ipairs(panels) do
      local panel = panels[itemIndex]
      x = panel.x
      y = panel.y
      width = panel.width
      height = panel.height
      panel:setColor({1, 1, 1, 1})

      local item = self.items[itemIndex]
      print('x :' .. self.focusX .. ' y: ' .. self.focusY)
      if i == self.focusX + (self.focusY - 1) * self.columns then
        print(itemIndex)
        panel:setColor({1, 0, 0, .7})

      end

      panel:render()
      if item then
        if item.pokemon then

          love.graphics.setColor(0, 0, 0, 1)

          love.graphics.print(item.pokemon.name, panel.x +5, panel.y + 5)
          love.graphics.print('Lv. ' .. item.pokemon.level, panel.x +5, panel.y + 15)

          local healtBar = ProgressBar{x = x + 5 / 2, y = y+25, width = panel.width -20, height = 3,
            value = item.pokemon.currentHP, maxValue = item.pokemon.HP}
          love.graphics.print(item.pokemon.currentHP .. ' / ' .. item.pokemon.HP, x + 5, y + 36)
          love.graphics.setFont(gFonts['tiny'])
          love.graphics.print('Status: ok', x + 5, y + 56)
          love.graphics.setFont(gFonts['small'])
           healtBar:render()
        else
          love.graphics.setColor(0, 0, 0, 1)
          love.graphics.print(item.text, panel.x + 10, panel.y +15)
        end
      end


      itemIndex = itemIndex + 1
  end

  if self.scrollBar then
    self.scrollBar:render()
  end

end

function Selection:renderParty()
  love.graphics.setColor(self.textColor)

  local displayStart = self.displayStart
  local displayEnd = displayStart + self.rows - 1


  local itemIndex = ((displayStart - 1) * self.columns) + 1
  local charHeight = self.font:getHeight(self.items[1])

  local x = self.x + self.paddingLeft
  local y = self.y + self.paddingTop
  local lineHeight = self.font:getHeight(self.items[1].text) + self.lineSpace

  for i = displayStart, displayEnd do
    for j = 1, self.columns do

      local item = self.items[itemIndex]


      -- if i == #self.items then
      --   print('Cancel')
      --   local panel = Panel{x = 10, y = VIRTUAL_HEIGHT - 42, width = 64, height = 32}
      --
      --   panel:render()
      --   love.graphics.print('Cancel', x -64, VIRTUAL_HEIGHT - 42)
      --   return
      -- end
      if item then
        if item.pokemon then
          self:renderPartyItem(x, y, item.pokemon, false)
        elseif item.text then
          local panel = Panel{x = x, y = y , width = self.width - self.paddingLeft, height = 36, color = {1, 1, 1, 1}}
          panel:render()
          self:renderItem(item, x, y)
        end
      else
        local panel = Panel{x = x, y = y , width = self.width - self.paddingLeft, height = 36, color = {1, 1, 1, 1}}
        panel:render()
      end



      if i == self.focusY and j == self.focusX and self.cursor then
        if item then
          if item.pokemon then
            self:renderPartyItem(x, y, item.pokemon, true)
          elseif item.text then
            local panel = Panel{x = x, y = y , width = self.width - self.paddingLeft, height = 36, color = {1, 1, 1, 1}}
            panel:render()
            self:renderItem(item, x, y)
          end
        else
          local panel = Panel{x = x, y = y , width = self.width - self.paddingLeft, height = 36, color = {1, 0, 0, 1}}
          panel:render()
        end
      end



      x = x + self.columnWidth + self.paddingLeft
      itemIndex = itemIndex + 1
    end


    y = y + 36
    x = self.x + 2--self.paddingLeft
  end

  if self.scrollBar then
    self.scrollBar:render()
  end
end

function Selection:renderPartyItem(x, y, pokemon, isSelected)
  local color
  if isSelected then
    panelColor = {1, 0, 0, .7}
    textColor = {0, 0, 0, 1}
  else
    panelColor = {1, 1, 1, 1}
    textColor = {0, 0, 0, 1}
  end


  local panel = Panel{x = x, y = y , width = self.width - self.paddingLeft, height = 36, color = panelColor}

  panel:render()
  love.graphics.setColor(textColor)
  love.graphics.print(pokemon.name, x +5, y+10)
  love.graphics.print('Lv. ' .. tostring(pokemon.level), x + self.width - 54, y +10)
  -- love.graphics:setFont(gFonts['tiny'])
  love.graphics.print(pokemon.currentHP .. '/' .. pokemon.HP .. ' HP', x +5, y+20)

end
