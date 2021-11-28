Tile = Class{}

function Tile:init(def)
  self.x = def.x
  self.y = def.y
  self.id = def.id or 0
  self.texture = def.texture

  self.type = def.type or 'tile'
  self.trigger = def.trigger or nil
  self.action = def.action or 'empty'
  self.solid = def.solid or false
  self.visible = def.visible or true
  self.properties = def.properties or {}
  -- table.foreach(self.properties, print)

  self:makeActions()
end

function Tile:makeActions()
  self.onEnter = ACTIONS['empty']
  self.onExit = ACTIONS['empty']
  self.onInteract = ACTIONS['empty']

  if self.type == 'trigger' then
    -- print(self.trigger)

  if self.trigger == 'onExit' then
      print('trying to make an exit event')
      self.onExit = function(params)
        return ACTIONS[self.action](self.properties)
      end


    elseif self.trigger == 'onEnter' then
      print('trying to make an enter event')
      self.onEnter = function(params)

        return ACTIONS[self.action](self.properties)
      end

    elseif self.trigger == 'onInteract' then
      -- print('Trying to ' .. self.action .. ' ' .. self.trigger)

      self.onInteract = function(params)
        return ACTIONS[self.action](self.properties)
      end
    end

  end
end

function Tile:toggle()
  self.visible = not self.visible
end


function Tile:render()
  -- love.graphics.setColor(1, 1, 1, 1)
  if self.id ~= 0 and self.visible then
    -- print(self.texture, self.id)
    love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.texture][self.id],
    math.floor((self.x-1) * TILESIZE),
    math.floor((self.y-1) * TILESIZE))
  end
end
