 FieldMenuState = Class{__includes = BaseState}

function FieldMenuState:init(world)
  self.world = world
  self.menu = Menu({
    x = VIRTUAL_WIDTH - 100, y = 10, rows = 10, maxRows = 7, items = {
      {
        text = 'Inventory',
        onSelect = function()
          gStateStack:push(InventoryMenuState(self.world))
        end
      },{
        text = 'Cancel',
        onSelect = function()
          gStateStack:pop()
        end
      },{
        text = 'TestState',
        onSelect = function()
          gStateStack:pop()
          gStateStack:push(TestState())
        end
      },{
        text = 'Go back to \ntitle \nscreen',
        onSelect = function()
          gStateStack:pop()
          -- gStateStack:pop()
          gStateStack:push(StartState())
        end
      },
    }
  })
end

function FieldMenuState:handleInput()
  if love.keyboard.wasPressed('backspace') or love.keyboard.wasPressed('q')
  or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter')then
    gStateStack:pop()
  end
end

function FieldMenuState:enter()
  love.keyboard.keysPressed = {}
end

function FieldMenuState:exit()
  love.keyboard.keysPressed = {}
  if not self.canInput then

  end
end

function FieldMenuState:update(dt)
  self.menu:update(dt)
  return not self.canInput
end

function FieldMenuState:render()
  self.menu:render()
end
