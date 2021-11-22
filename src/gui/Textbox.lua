Textbox = Class {}

function Textbox:init(def)
  self.panel = Panel(def)
  self.x = def.x
  self.y = def.y
  self.width = def.width
  self.height = def.height

  self.text = tostring(def.text) or '__empty___'
  self.font = def.font or gFonts['small']

  _, self.textChunks = self.font:getWrap(self.text, self.width)

  self.textColor = def.textColor or {0, 0, 0, 1}
  self.paddingTop = def.paddingTop or 10
  self.paddingLeft = def.paddingLeft or 5

  self.chunkCounter = 1
  self.endOfText = false
  self.closed = false

  self:next()
end

function Textbox:isClosed()
  return self.closed
end

function Textbox:toggle()
  self.panel:toggle()
end

function Textbox:next()
  if self.endOfText then
      self.lastChunks = self.displayChunks -- this is needed by DialogueMenuState to display the last chunk
      self.displayChunks = {}
      self.panel:toggle()
      self.closed = true
  else
    self.displayChunks = self:nextChunks()
  end
end

function Textbox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 2 do
      table.insert(chunks, self.textChunks[i])

      if i == # self.textChunks then
        self.endOfText = true
        return chunks
      end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function Textbox:handleInput()
  if love.keyboard.wasPressed('space') then
    self:next()
  end
end

function Textbox:update(dt)
  if not self:isClosed() then
    self:handleInput()
  end
end

function Textbox:render()
  self.panel:render()
  love.graphics.setColor(self.textColor)
  for i = 1, #self.displayChunks do
    love.graphics.printf(self.displayChunks[i],
        self.x + self.paddingLeft,
        (self.y + (i - 1) * 16) + self.paddingTop,
        self.x + self.width,
        'left'
    )
  end

  if not self.endOfText then
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.polygon('fill',
      self.x + self.width - 5 , self.y + self.height - 0,
      self.x + self.width - 0, self.y + self.height - 5,
      self.x + self.width - 10, self.y + self.height - 5
    )

    love.graphics.setColor(1, 1, 1, 1)
  end
end
