PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.world = World()
end

function PlayState:enter()
  local answers = {
    {text = 'Yes',
    onSelect = function()
      gStateStack:pop()
      gStateStack:push(DialogueState('Thats cool!'))
    end},
    {text = 'No',
    onSelect = function()
      gStateStack:clear()
      gStateStack:push(StartState())
    end}
  }
  gStateStack:push(DialogueMenuState('Do you want to play?', answers))
end

function PlayState:handleInput()
  self.world:handleInput()
end

function PlayState:update(dt)
  self.world:update(dt)

  return false
end

function PlayState:render()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

  self.world:render()
end
