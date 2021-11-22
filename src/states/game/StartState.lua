StartState = Class {__includes = BaseState}

function StartState:init()

end

function StartState:enter()
  gStateStack:push(FadeOutState({1, 1, 1}, .5, function()
    gStateStack:push(DialogueState('Welcome, press space to confirm.\n w, a, s, d is to move.', true, function()
      gStateStack:push(MenuState({
        x = VIRTUAL_WIDTH / 2 - 50, y = VIRTUAL_HEIGHT - 70, width = 100, height = 60,
        visible = false, scrollBar = true, align = 'center', maxRows = 5, rows= 3, items = {
          {
            text = 'Play',
            onSelect = function()
              gStateStack:pop()
              gStateStack:push(FadeInState({0, 0, 0}, .63, function()
                gStateStack:push(PlayState())
                gStateStack:push(FadeOutState({1, 1, 1}, .63, function()


                end))
              end))
            end
          },
          {
            text = 'Settings',
            onSelect = function()

            end
          },
          {
            text = 'Test',
            onSelect = function()

            end
          }
        }
      }))
    end))
  end))
end

function StartState:handleInput()
end

function StartState:update(dt)
  return false
end

function StartState:render()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.setFont(gFonts['huge'])
  love.graphics.printf('Postymon', 0, 32, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(gFonts['small'])


  love.graphics.setColor(1, 1, 1, 1)
end
