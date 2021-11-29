InventoryMenuState = Class{__includes = BaseState}

function InventoryMenuState:init(world)
  self.world = world

  self.panel = Panel{x = 10, y = 10, width=VIRTUAL_WIDTH / 2 +  50, height=VIRTUAL_HEIGHT -20}

  local items = {}

  for i, item in ipairs(self.world.player.inventory) do
    local subMenuState = {}
    table.insert(subMenuState,{
        text = 'Use',
        onSelect = function()
          return ITEMS[item.name]:onUse()
        end})

      if ITEMS[item.name].type ~= 'keyItem' then
        table.insert(subMenuState,{
          text = 'Throw',
          onSelect = function()
            self.world.player:removeItem(item.name, 1)
            gStateStack:push(DialogueState(ITEMS[item.name].text ..' removed from your inventory.', function()
              gStateStack:pop()
              gStateStack:push(InventoryMenuState(self.world))
            end))
          end
        })
      end

      table.insert(subMenuState,{
        text = 'Cancel',
        onSelect = function() gStateStack:pop() end
      })

    items[i] = {
      text = ITEMS[item.name].text .. ' '.. tostring(item.amount),
      onSelect = function()
        gStateStack:push(DialogueMenuState(ITEMS[item.name].description, subMenuState, {
          offsetX = 0, offsetY = - 32
        }))
      end
    }
  end

  table.insert(items, {text = 'Cancel', onSelect = function() gStateStack:pop() end })

  self.items = Menu{
    x = 15, y = 15, visible = false, maxRows = 20, rows = 10, items = items
    }

end

function InventoryMenuState:handleInput()
  if love.keyboard.wasPressed('backspace') or love.keyboard.wasPressed('q') then
    gStateStack:pop()
  end
end

function InventoryMenuState:enter()
 love.keyboard.keysPressed = {}
end

function InventoryMenuState:exit()
 if not self.canInput then

 end
end

function InventoryMenuState:update(dt)
 self.items:update(dt)
 return false
end

function InventoryMenuState:render()
 self.panel:render()
 self.items:render()
end
