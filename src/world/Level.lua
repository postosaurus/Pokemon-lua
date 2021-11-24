Level = Class{}

function Level:init(def)
  self.tileWidth = def.tileWidth
  self.tileHeight = def.tileHeight

  self.tilesets = def.tilesets
  self:generateLayers(def.layers)
  -- print('tileset in Level:' .. #self.tilesets)
end

function Level:generateLayers(def)
  self.layers = {}

  if def == nil then
    return
  end

  for k, layer in ipairs(def) do
    if layer.type == 'tilelayer' then
      self.layers[layer.name] = TileMap(layer, self.tilesets)
      -- print('Layer created in level: ' .. layer.name)
    end
  end
  -- print('generateLayers in Level: ' ..tostring(#self.layers))
  return self.layers
end

function Level:handleInput()

end

function Level:getTile(x, y, layer)
  self.layers[layer]:getTile(x, y)
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


  return false
end

function Level:render()
  local renderOrder = {
    'grid', 'ground', 'deco', 'fixDeco'
  }
  for i =1, #renderOrder do
    local layer = self.layers[renderOrder[i]]
    if layer then
      layer:render()
    else
      -- print('Warning Level.lua:render() 48: layer ' .. renderOrder[i] .. ' not found in self.layers.')
    end
  end
end
