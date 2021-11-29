World = Class{}

function World:init()
  -- gWorld = self
  self.levels = {}
  for k, level in pairs(LEVELS) do

    self.levels[k] = Level(self, {
      tileWidth = level.width,
      tileHeight = level.height,
      tilesets = level.tilesets,
      layers = level.layers,
    })
  end
  self.currentLevel = self:changeLevel('start')

  self.player = Player(self, ENTITY_DEFS['player'])
  self.player.controller = StateMachine({
    ['idle'] = function() return PlayerIdleState(self, self.player) end,
    ['walk'] = function() return PlayerWalkState(self, self.player) end,
  })
  self.player:changeState('idle')

  local limitWidth = self:getCurrentLevel().pixelWidth
  local limitHeight = self:getCurrentLevel().pixelHeight

  self.camera = Camera(self.player, limitWidth, limitHeight)
end

function World:getCurrentLevel()
  return self.currentLevel
end



function World:changeLevel(name, def)
  assert(self.levels[name])
  self.currentLevel = self.levels[name]
  if def then
    self.player:setPosition(def.x, def.y)
    self.player.direction = def.direction or 'down'
    self.camera:reset(self.player, self.currentLevel.pixelWidth, self.currentLevel.pixelHeight)
  end

  return self.currentLevel
end

function World:handleInput()
  self.currentLevel:handleInput()
  self.player:handleInput()
end

function World:update(dt)
  self.camera:update(dt)
  self.currentLevel:update(dt)
  self.player:update(dt)


  return false
end

function World:render()
  love.graphics.push()
  love.graphics.translate(-self.camera.x, -self.camera.y)
  self.currentLevel:render()
  love.graphics.pop()
end
