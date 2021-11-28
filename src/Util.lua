function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight
    local counter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[counter] = love.graphics.newQuad(
                x * tilewidth,
                y * tileheight,
                tilewidth,
                tileheight,
                atlas:getDimensions()
            )
            counter = counter + 1
        end
    end

    return quads
end

function table.copy(orignal)
  local copy = {}
  for k, v in pairs(orignal) do
    copy[k] = v
  end

  return copy
end

function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

function StretchTexture(texture, x, y, width, height)
    local textureWidth = texture:getWidth()
    local textureHeight = texture:getHeight()
    love.graphics.draw(texture, x, y ,0,
        width / (textureWidth - 1),
        height / (textureHeight - 1)
    )
end

function math.clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

function Ask(question, items, onDialogueClose, font)

    gStateStack:push(DialogueMenuState({
      dialogueText = question,
      x = 0,
      y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT / 4) - 16,
      width = 48,
      height = VIRTUAL_HEIGHT / 4,
      paddingTop = 7,
      items = items,
      font = font,
      onDialogueClose = onDialogueClose
    }))
end

function Heal(pokemon, amount)
  gWorld.player.party:HealPokemon(pokemon, amount)
end

function Wait(waitTime, onDoneWaiting)
  gStateStack:push(WaitState())
  Timer.after(waitTime, onDoneWaiting)
end



function Collides(entity, target)
  return not (entity.x + entity.width < target.x or entity.x > target.x + target.width or
            entity.y + entity.height < target.y or entity.y > target.y + target.height)
end

function BattleMessage(world, message, callback)
  gStateStack:push(BattleMessageState(world, message, callback))
end

function Pop()
  gStateStack:pop()
end

function DrawBlackBackground()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  love.graphics.setColor(1, 1, 1, 1)
end

function RemoveItemFromInventory(player, item, amount, callback)
  player.inventory:removeItem(item, amount)
  callback()
end

function ChangeLevel(level, nextLevel, params)
  level.world:changeLevel(nextLevel, params)
end

function GoInOppositeDirection(entity)
  entity:setToOppositeDirection()
  entity:changeState('walk')
end

function Teleport(entity, level)
  entity:setPosition(entity.mapX, entity.mapY)
end

function AddItem(item, amount)
  print(amount .. ' ' ..  item .. ' added to inventory.')
end

function CreateItem(level, name, x, y, visible, solid)
  return Gameobject(level, {
    name = name,
    type = 'item',
    mapX = x,
    mapY = y,
    visible = visible,
    solid = solid,
    onInteract = function()
      Gameobject.toggle(self)
    end

  })
end
