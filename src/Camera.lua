Camera = Class{}

function Camera:init(object, limitWidth, limitHeight)
  self:reset(object, limitWidth, limitHeight)
end

function Camera:reset(object, limitWidth, limitHeight)
  self.object = object
  self.limitWidth = limitWidth
  self.limitHeight = limitHeight
  self.x = math.floor(self.object.x - VIRTUAL_WIDTH / 2)
  self.y = math.floor(self.object.y - VIRTUAL_HEIGHT / 2)
  self.x = math.clamp(self.x, 0, self.limitWidth - VIRTUAL_WIDTH)
  self.y = math.clamp(self.y, 0, self.limitHeight - VIRTUAL_HEIGHT)
end

function Camera:update(dt)
  self.x = math.floor(self.object.x - VIRTUAL_WIDTH / 2)
  self.y = math.floor(self.object.y - VIRTUAL_HEIGHT / 2)
  self.x = math.clamp(self.x, 0, self.limitWidth - VIRTUAL_WIDTH)
  self.y = math.clamp(self.y, 0, self.limitHeight - VIRTUAL_HEIGHT)
end
