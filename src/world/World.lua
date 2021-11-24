World = Class{}

function World:init()
  self.levels = {}
  for k, level in pairs(LEVELS) do
    -- print('Levels: ' .. k)
    -- table.foreach(level, print)
    self.levels[k] = Level({
      tileWidth = level.width,
      tileHeight = level.height,
      tilesets = level.tilesets,
      layers = level.layers,
    })
  end
  self.currentLevel = self.levels['start']
  self.player = Entity(self, ENTITY_DEFS['player'])
  self.player.controller = StateMachine({
    ['idle'] = function() return PlayerIdleState(self, self.player) end,
    ['walk'] = function() return PlayerWalkState(self, self.player) end,
  })
  table.foreach(self.player.controller.states, print)
  self.player:changeState('idle')
end

function World:getCurrentLevel()
  return self.currentLevel
end

function World:handleInput()
  self.currentLevel:handleInput()
  self.player:handleInput()
end

function World:update(dt)
  self.currentLevel:update(dt)
  self.player:update(dt)

  return false
end

function World:render()
  self.currentLevel:render()
  self.player:render()
end
