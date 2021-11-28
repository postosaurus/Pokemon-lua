Level = Class{}

function Level:init(world, def)
  self.world = world

  self.tileWidth = def.tileWidth
  self.tileHeight = def.tileHeight

  self.pixelWidth = self.tileWidth * TILESIZE
  self.pixelHeight = self.tileHeight * TILESIZE

  self.tilesets = def.tilesets
  -- self.grid = {}
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
    end
  end

  self.items = self.layers['grid'].items

  return self.objects
end

function Level:getTile(x, y, layer)
  local tile = self.layers[layer]:getTile(x, y)
  return tile
end

function Level:setTile(x, y, layer, value)
  self.layers[layer]:setTile(x, y, value)

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

function Level:freeSpaceOnGrid(x, y)
  self.layers['grid'][y][x] = {}
end

function Level:update(dt)
  return false
end

function Level:render()
  local renderOrder = {
    'ground', 'onGround',  'player', 'deco', 'fixDeco',
  }

  for i =1, #renderOrder do

    if renderOrder[i] == 'player' then
      for i, item in ipairs(self.items) do
        item:render()
      end
      self.world.player:render()

    else

      local layer = self.layers[renderOrder[i]]
      if layer then
        layer:render()

      else
        print('Warning Level.lua:render() 48: layer ' .. renderOrder[i] .. ' not found in self.layers.')
      end

    end

  end

end

function Level:handleInput()
-- this is needed by world and game logic
end
