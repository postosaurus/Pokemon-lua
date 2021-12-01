InventoryMenuState = Class{__includes = BaseState}

function InventoryMenuState:init(world)
  self.world = world

  self.panel = gPanels['middle']
  self.panel.visible = true
  self.panel.maxRows = 20
  self.panel.rows = 9
  self.descriptionPanel = gPanels['bottomLeft']

-- description
  local items = {}

  for i, item in ipairs(self.world.player.inventory) do
    local subMenuState = {}
    table.insert(subMenuState,{
        text = 'Use',
        onSelect = function()
          if not ITEMS[item.name].onUse then
            gStateStack:push(DialogueState('You can\'t use this here.', function()
              gStateStack:pop()
            end), gPanels['d'])
            return
          end

          ITEMS[item.name].onUse(self.world, item)


        end})

        local panel = gPanels['bottomRight']
        panel.rows = 2
        panel.maxRows = item.amout
        panel.offsetX = 0
        panel.offsetY = 0

    if ITEMS[item.name].type ~= 'keyItem' then
      table.insert(subMenuState,{
        text = 'Throw',
        onSelect = function()

          local counterMenu = {}
          for i = 1, item.amount do
          table.insert(counterMenu, {text = i,
            onSelect = function()
              self.world.player:removeItem(item.name, i)
              gStateStack:pop()
              gStateStack:pop()
              gStateStack:push(DialogueState(ITEMS[item.name].text ..' removed from your inventory.', function()
                gStateStack:pop()
                gStateStack:push(InventoryMenuState(self.world))
              end))
            end
            })
          end
          table.insert(counterMenu, {
            text = 'Cancel',
            onSelect = function() gStateStack:pop() end
          })

          -- panel .wid
          gStateStack:push(DialogueMenuState('', counterMenu, panel))
        end})
    end

    table.insert(subMenuState,{
      text = 'Cancel',
      onSelect = function() gStateStack:pop() end
    })

    items[i] = {
      text = ITEMS[item.name].text .. ' '.. tostring(item.amount),
      onSelect = function()
        gStateStack:push(DialogueMenuState(ITEMS[item.name].description, subMenuState, panel))
      end
    }
  end

  table.insert(items, {text = 'Cancel', onSelect = function() gStateStack:pop() end })
  self.panel.items = items

  self.items = Menu(self.panel)
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
 self.descriptionPanel:render()
 self.items:render()


  local text
  if self.world.player.inventory[self.items:getIndex()] then
    text = ITEMS[self.world.player.inventory[self.items:getIndex()].name].description
  else
    text = ''

  end
 love.graphics.printf(text, self.descriptionPanel.x + 5, self.descriptionPanel.y + 5, self.descriptionPanel.width, 'left')
end
