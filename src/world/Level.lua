Level = Class{}

function Level:init(world, def)
  self.world = world

  self.tileWidth = def.tileWidth
  self.tileHeight = def.tileHeight

  self.pixelWidth = self.tileWidth * TILESIZE
  self.pixelHeight = self.tileHeight * TILESIZE

  self.tilesets = def.tilesets
  self.grid = {}
  self:generateLayers(def.layers)
end

function Level:generateLayers(def)
  self.layers = {}

  if def == nil then
    return
  end

  for k, layer in ipairs(def) do

    if layer.type == 'tilelayer' then
      self.layers[layer.name] = TileMap(layer, self.tilesets)

    elseif layer.type == 'objectgroup' then
      self.objects = {}

      for k, object in pairs(layer.objects) do

        local onEnter = function() print('__empty__ from Level') return true end
        local onExit = function() print('__empty__ from Level') return true end
        local onInteract = function() print('__empty__ from Level') return true end


        if object.type == 'door' then
          print('making door')
          local nextLevel = object.properties.nextLevel
          local playerDirection = object.properties.playerDirection

          local playerPositionX = object.properties.x
          local playerPositionY = object.properties.y

          onEnter = function()
            return ACTIONS['changeLevel'](nextLevel, {
              x = playerPositionX,
              y = playerPositionY,
              direction = playerDirection})
            end

        elseif object.type == 'readable' then
          print('making readable')
          onInteract = function()
            return ACTIONS['say'](object.properties.text)
          end

        elseif object.type == 'trigger' then
          print('making trigger')
          local action = object.properties.action

          if action == 'onEnter' then
            onEnter = function()
              return ACTIONS[object.properties.func](object.properties.params, self.world.player)
            end

          elseif action == 'onExit' then
            onExit = function()
              return ACTIONS[object.properties.func](object.properties.params, self.world.player)
            end

          elseif action == 'onInteract' then
            onInteract = function()
              return ACTIONS[object.properties.func](object.properties.params, self.world.player)
            end

          end

        elseif object.type == 'item' then
          print('making item')
          onInteract = function() AddItem(object.properties.name, object.properties.amount)

        end


        local objectDef = {
          x = object.x,
          y = object.y,
          type = object.type,
          width = object.width or 16,
          height = object.height or 16,
          visible = object.visible,

          solid = object.solid,

          onEnter = onEnter,
          onExit = onExit,
          onInteract = onInteract
          }

        table.insert(self.objects, Gameobject(world, objectDef))
        -- end

      end

    end
  end

  return self.objects
end

function Level:handleInput()

end

function Level:getTile(x, y, layer)
  local tile = self.layers[layer]:getTile(x, y)
  return tile
end

function Level:getTilesByType(x, y, type)
  local listOfTiles = {}
  local counter = 1
  for k, layer in pairs(self.layers) do
    local cache = {}
    chache = layer:getTilesByType(x, y, type)
    for i, l in ipairs(chache) do
      table.inser(listOfTiles, l)
    end
  end

  return listOfTiles
end

function Level:update(dt)
  for i, object in ipairs(self.objects) do
    object:update(dt)
  end
  return false
end

function Level:render()
  local renderOrder = {
    'grid', 'ground', 'onGround', 'player', 'deco', 'fixDeco'
  }

  for i =1, #renderOrder do

    if renderOrder[i] == 'player' then
      self.world.player:render()
    else

      local layer = self.layers[renderOrder[i]]
      if layer then
        layer:render()

      else
        -- print('Warning Level.lua:render() 48: layer ' .. renderOrder[i] .. ' not found in self.layers.')
      end

    end

  end

  for i, object in ipairs(self.objects) do
    object:render()
  end

end
