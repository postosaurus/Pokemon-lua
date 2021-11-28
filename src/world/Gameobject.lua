Gameobject = Class{}

function Gameobject:init(def)
  -- self.  -- self.level = etCurrentLevel()
  -- print(self.lev)
  self.x = def.x
  self.y = def.y
  self.mapX = def.mapX
  self.mapY = def.mapY
  -- print(self.mapX, self.mapY)
  -- self.level.layers['grid'][mapY][mapX] = self
  self.type = def.type
  self.width = def.width or 16
  self.height = def.height or 16
  self.visible = def.visible

  self.solid = def.solid

  self.params = def.params

  self.onEnter = def.onEnter or function() print('__empty__') end
  self.onExit = def.onExit or function() print('__empty__') end
  self.onInteract = def.onInteract or function() print('__empty__') end
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
    if self.type == 'item' then
      -- print('item')
      love.graphics.draw(gTextures['balls'], gFrames['balls'][1], (self.mapX - 1) * TILESIZE, (self.mapY -1 ) * TILESIZE)
    end


    love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.texture][self.id],
    math.floor((self.x-1) * TILESIZE),
    math.floor((self.y-1) * TILESIZE))
  


  end
  -- if self.visible then
  --   love.graphics.setColor(1, 0, 0, 1)
  --   love.graphics.setColor(1, 1, 1, 1)
  -- end
end
