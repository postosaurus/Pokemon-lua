TestState = Class {__includes = BaseState}

function TestState:init(world)
  self.world = world
  self.layout = Layout()
  self.layout:contractEven('screen', 3, 3)
  -- self.layout:splitVert('screen', 'left', 'right', .3, 3)
  -- self.layout:splitHorz('screen', 'top', 'bottom', .65, 3)
  self.layout:splitHorz('screen', 'top', 'bottom', .15, 3)
  self.layout:splitVert('bottom', 'left', 'right', .65, 3)
  self.layout:splitHorz('right', 'right', 'bottomRight', .8, 3)
  -- self.layout:splitHorz('left', 'lefttop', 'left', .15, 3)

  -- self.layout:splitHorz('right', 'top', 'middle', .2, 3)
  --
  -- self.layout:splitHorz('right', 'tright', 'bright', .7, 3)
  -- self.layout:splitHorz('tright', 'top', 'bottom', .15, 3)

end

function TestState:handleInput()
  if love.keyboard.wasPressed('q') then
    gStateStack:pop()
  end
end

function TestState:update(dt)
end

function TestState:render()
  self.layout:debugRender()

  love.graphics.setColor(0, 0, 0, 1)

  local x = self.layout.panels['right'].x
  local y = self.layout.panels['right'].y
  local width = self.layout.panels['right'].width
  local height = self.layout.panels['right'].height
  for i = 1, 6 do
      love.graphics.print('Item nr. '.. i, x + 5, y + 10)
    y = y + 16
  end


  local x = self.layout.panels['top'].x
  local y = self.layout.panels['top'].y
  local width = self.layout.panels['top'].width
  local height = self.layout.panels['top'].height
  love.graphics.printf('TITLE OF THE MENU', x +5, y + 10, width, 'center')
  -- love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)

  local x = self.layout.panels['left'].x
  local y = self.layout.panels['left'].y
  local width = self.layout.panels['left'].width
  local height = self.layout.panels['left'].height
  for i = 0, 4 do
    local panel = Panel{x = x + 5, y = y +10, width = width -10, height = 32}
    panel:render()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print('Item nr. '.. i, x + 10, y +20)
    love.graphics.printf('6', x + 10, y +20, width-30, 'right')
    y = y + 35
  end


end
