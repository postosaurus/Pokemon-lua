Gameobject = Class{}

function Gameobject:init(level, def)
  self.mapX = def.mapX
  self.mapY = def.mapY

  self.x = math.floor(self.mapX * TILESIZE)
  self.y = math.floor(self.mapY * TILESIZE)

  self.type = def.type
  self.width = def.width or TILESIZE
  self.height = def.height or TILESIZE
  self.visible = def.visible

  self.solid = def.solid

  self.name = def.name or nil
  self.amount = def.amount or 1

  self.onEnter = def.onEnter or function() return ACTIONS['empty'] end
  self.onExit = def.onExit or function() return ACTIONS['empty'] end
  self.onInteract = def.onInteract or function() return ACTIONS['empty'] end
  -- print(self.type)
  if self.type == 'item' then
    print('creating the onInteract')
    self.onInteract = function(item)

      return  function(level, entity)

        gStateStack:push(DialogueState(item.name .. ' found.', function()
            ACTIONS['addItem'](item.name, item.amount)
            
            self:toggle()
            level:setTile(self.mapX, self.mapY, 'grid', Tile{
              x = x,
              y = y,
              id = id,
              type = 'tile'
            })

        end))
      end

    end
  end
end

function Gameobject:update(dt)

end

function Gameobject:toggle()
  self.visible = not self.visible
end

function Gameobject:render()
  -- love.graphics.setColor(1, 1, 1, .5)
  -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  -- love.graphics.setColor(1, 0, 0, .5)
  -- love.graphics.rectangle('fill', (self.mapX - 1) * TILESIZE, (self.mapY -1 ) * TILESIZE, self.width, self.height)
  if self.visible then
    -- if self.type == 'item' then
      -- print('item')
      love.graphics.draw(gTextures['balls'], gFrames['balls'][1], (self.mapX - 1) * TILESIZE, (self.mapY -1 ) * TILESIZE)
    -- end

    --
    -- love.graphics.draw(
    -- gTextures[self.texture],
    -- gFrames[self.texture][self.id],
    -- math.floor((self.x-1) * TILESIZE),
    -- math.floor((self.y-1) * TILESIZE))



  end
  -- if self.visible then
  --   love.graphics.setColor(1, 0, 0, 1)
  --   love.graphics.setColor(1, 1, 1, 1)
  -- end
end
