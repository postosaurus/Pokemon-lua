 FieldMenuState = Class{__includes = BaseState}

function FieldMenuState:init(world)
  self.world = world



  self.panel = gPanels['fieldMenu']--Panel{ x= 0, y = 0, width = VIRTUAL_WIDTH, height = VIRTUAL_HEIGHT, color = {1, 1, 1,1}}
  self.panel['items'] = {
    {
      text = 'Pokemon',
      onSelect = function()
        gStateStack:push(PartyMenuState(self.world))
      end
    },
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
        gStateStack:push(TestState(self.world))
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
  self.panel['rows'] = 10
  self.panel['maxRows'] = 7

  self.menu = Menu(self.panel)
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
  
  -- gLayout:debugRender()
end
