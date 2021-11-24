TileMap = Class{}

function TileMap:init(def, tilesets)
  self.name = def.name
  self.id = def.id
  self.width = def.width
  self.height = def.height
  self.visible = def.visible or true

  self.opacity = def.opacity

  self.tilesets = tilesets
  self.tiles = self:generateTiles(def.data)
end

function TileMap:getTile(x, y)
  return self.tiles[y][x]
end

function TileMap:getTilesByType(x, y, type)
  local listOfTiles = {}
  for i, tile in iparis(self.tiles) do
    if tile.type == type then
      table.insert(listOfTiles, tile)
    end
  end
  return listOfTiles
end

function TileMap:generateTiles(def)
  local listOfTiles = {}
  local onEnter = function() end
  local onExit = function() end
  local onInteract = function() end

  for y = 1, self.height do
    listOfTiles[y] = {}
      for x = 1, self.width do

          local id = def[1 + (x -1) + (y - 1) * self.width]
          if not id or id == 0 then
              listOfTiles[y][x] = Tile({
                x = x,
                y = y,
                id = 0,
                type =  nil,
                texture = 'tiles',
                animation = nil})
              goto continue
          end

          local tset_gid = -1
          local texture = nil
          local type = nil
          for t = #self.tilesets, 1, -1  do
              if self.tilesets[t]['firstgid'] <= id then
                  tset_gid = self.tilesets[t]['firstgid']
                  texture = self.tilesets[t]['name']
                  for i, tileData in pairs(self.tilesets[t]['tiles']) do
                      if tileData['id'] == id - tset_gid + 1 then
                          type = tileData['type']

                          if type == 'readable' then
                            -- onInteract = def[id].properties['text']
                          elseif type == 'door' then
                            -- onEnter = def[id].onEnter
                          end


                          break
                      end
                  end
                  break
              end
          end

          if tset_gid == -1 then
              goto continue
          end

          id = id - tset_gid  + 1

          listOfTiles[y][x] = Tile({
            x = x,
            y = y,
            id = id,
            type = type or nil,
            texture = texture,
            onEnter = onEnter,
            onExit = onExit,
            onInteract = onInteract,
            animation = nil})

          ::continue::
      end
  end
  return listOfTiles
end

function TileMap:getTile(x, y)
  return self.tiles[y][x]
end

function TileMap:render()
  if self.visible then
    for y = 1, self.height do
      for x = 1, self.width do
        local tile = self:getTile(x, y)
        if tile and tile.id ~= 0 then
        -- if tile.visible then
        tile:render()
        -- print('Tile exists and renders')
        -- table.foreach(tile, print)
        end
      end
    end
  end
end
