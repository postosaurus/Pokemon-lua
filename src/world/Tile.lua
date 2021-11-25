Tile = Class{}

function Tile:init(def)
  self.x = def.x
  self.y = def.y
  self.type = def.type

  self.id = def.id
  self.texture = def.texture

  self.onEnter = def.onEnter or function() end
  self.onExit = def.OnExit or function() end
  self.onInteract = def.onInteract or function() end
  if self.type then
    
  end
end


function Tile:render()
  love.graphics.setColor(1, 1, 1, 1)
  if self.id ~= 0 then

    love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.texture][self.id],
    math.floor((self.x-1) * TILESIZE),
    math.floor((self.y-1) * TILESIZE))
  end
end
