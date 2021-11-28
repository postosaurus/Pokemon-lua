TileMap = Class{}

function TileMap:init(def, tilesets)
  self.name = def.name
  self.id = def.id
  self.width = def.width
  self.height = def.height

  self.visible = def.visible or true
  self.opacity = def.opacity

  self.tilesets = tilesets

  self.items = {}
  self.tiles = self:generateTiles(def.data)
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

function TileMap:getTile(x, y)
  return self.tiles[y][x]
end

function TileMap:setTile(x, y, v)
  self.tiles[y][x] = v
end

function TileMap:render()
  -- if self.visible then
    for y = 1, self.height do
      for x = 1, self.width do
        local tile = self:getTile(x, y)
        if tile and tile.id ~= 0 then

          tile:render()


        end
      end
    end
  -- end
end


function TileMap:generateTiles(tiles)
  local listOfTiles = {}



  for y = 1, self.height do
    listOfTiles[y] = {}

    for x = 1, self.width do
      local visible = true
      local type = 'tile'
      local properties = {}
      local trigger = nil
      local action = nil
      local solid = false
      local onEnter = ACTIONS['empty']
      local onExit = ACTIONS['empty']
      local onInteract= ACTIONS['empty']

      local id = tiles[x + (y - 1) * self.width]
      if not id or id == 0 then
        listOfTiles[y][x] = Tile{
          x = x,
          y = y,
          id = id,
          type = 'tile'
        }
        goto continue
      end

      local texture = nil
      local tset_gid = -1
      local type = nil

      for t = #self.tilesets, 1, -1 do
        if self.tilesets[t].firstgid <= id then
            tset_gid = self.tilesets[t].firstgid
            texture = self.tilesets[t].name
            for i, tileData in ipairs (self.tilesets[t]['tiles']) do
              if tileData['id'] == id - tset_gid  then
                type = tileData['type'] or 'tile'
                properties = tileData['properties'] or {}
                break
              end
            end
            break
          end
      end

      if tset_gid == -1 then
        goto continue
      end

      id = id -tset_gid + 1

      if type == 'solid' then
        visible = properties.visible
        solid = true
        action = properties.action
        trigger = properties.trigger

      elseif type == 'trigger' then
        visible = properties.visible
        solid = properties.solid
        trigger = properties.trigger
        action = properties.action

      elseif type == 'item' then
        print('item in the map')
        print(type)
        solid = properties.solid
        visible = properties.visible
        table.insert(self.items, CreateItem(self.level, properties.name, x, y, visible, solid))


      end

      listOfTiles[y][x] = Tile({
        x = x,
        y = y,
        id = id,
        type = type,
        texture = texture,
        visible = visible,
        properties = properties,
        trigger = trigger,
        action = action,
        solid = solid,
        onEnter = onEnter,
        onExit = onExit,
        onInteract, onInteract
      })
      ::continue::
    end
  end
  return listOfTiles
end
