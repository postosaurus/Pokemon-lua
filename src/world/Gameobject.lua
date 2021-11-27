Gameobject = Class{}

function Gameobject:init(world, def)
  self.world = world
  self.x = def.x
  self.y = def.y
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

function Gameobject:render()
  if self.visible then
    love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
  end
end
