PlayState = Class {__includes = BaseState}

function PlayState:init()

  self.list = MenuState({
    x = 20, y = 20,  scrollBar = true,
    columns = 2, maxRows = 10, rows = 3, items = {
      {text = 'one',
      onSelect = function()
        gStateStack:push(DialogueState('one'))

      end},
      {text = 'two',
      onSelect = function() gStateStack:push(DialogueState('two'))
      end},
      {text = 'three',
      onSelect = function() print('three') gStateStack:push(DialogueState('3', true, function()
        gStateStack:push(DialogueState('tree')) end )) end },
      {text = 'four',
      onSelect = function() print('four') gStateStack:pop() end},
      {text = 'five',
      onSelect = function() print('five') end},
      {text = 'six',
      onSelect = function() print('six') gStateStack:pop() gStateStack:push(StartState()) end},

    }
  }
)
end

function PlayState:enter()
  gStateStack:push(self.list)
  -- gStateStack:push(DialogueState('Hello', true, function()
    print('hello wolrd L27 PlayState')
    gStateStack:push(DialogueState('Lets work on the selection!', false, function()
        print('callback of an not input taker')

    end))
  -- end))
end

function PlayState:handleInput()

end

function PlayState:update(dt)
  -- self.list:update(dt)

  return false
end

function PlayState:render()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

  -- self.list:render()
end
