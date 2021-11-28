Tile = Class{}

function Tile:init(def)
  self.x = def.x
  self.y = def.y
  self.id = def.id
  self.type = def.type

  self.texture = def.texture
  self.visible = def.visible or true
  self.solid = def.solid or false

  self.trigger = def.trigger or nil
  self.action = def.action or 'empty'
  self.properties = def.properties or {}

  self:makeActions()
end

function Tile:makeActions()
  self.onEnter = ACTIONS['empty']
  self.onExit = ACTIONS['empty']
  self.onInteract = ACTIONS['empty']

  if self.type == 'trigger' then


    if self.trigger == 'onExit' then
        self.onExit = function(params)
          return ACTIONS[self.action](self.properties)
        end


      elseif self.trigger == 'onEnter' then
        self.onEnter = function(params)
          return ACTIONS[self.action](self.properties)
        end

      elseif self.trigger == 'onInteract' then
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
  if self.id ~= 0 and self.visible then
    love.graphics.draw(
    gTextures[self.texture],
    gFrames[self.texture][self.id],
    math.floor((self.x-1) * TILESIZE),
    math.floor((self.y-1) * TILESIZE))
  end
end
