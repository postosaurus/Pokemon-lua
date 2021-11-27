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

  self.triggers = {}
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

        local onEnter = function() return function() return true end end
        local onExit = function() return function() return true end end
        local onInteract = function()  return function() return true end end


        if object.type == 'door' then
          print('making door')

          onEnter = function(params)
            return ACTIONS['changeLevel'](object.properties)
            end

        elseif object.type == 'readable' then
          print('making readable')
          onInteract = function(params)

            return ACTIONS['say'](object.properties)
          end

        elseif object.type == 'trigger' then
          print('making trigger')
          local action = object.properties.action

          if action == 'onEnter' then

            local enterParams = object.properties

            onEnter = function(params)
              return ACTIONS[object.properties.func](enterParams)
            end

          elseif action == 'onExit' then

            local enterParams = object.properties

            onExit = function(params)
              return ACTIONS[object.properties.func](enterParams)
            end

          elseif action == 'onInteract' then

            local enterParams = object.properties
            onInteract = function(params)
              return ACTIONS[object.properties.func](enterParams)
            end

          end

        elseif object.type == 'item' then
          local enterParams = object.properties

          onInteract = function(params)
            return ACTIONS['addItem'](enterParams)
          end

        end


        local objectDef = {
          x = object.x,
          y = object.y,
          type = object.type,
          width = object.width or 16,
          height = object.height or 16,
          visible = object.visible,
          params = object.properties,

          solid = object.properties.solid,

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
