ACTIONS = {
    ['say'] = function(text, onDialogueClose, font, canInput)
      gStateStack:push(DialogueState(text, onDialogueClose, def))
      return true
    end,

    ['changeLevel'] = function(levelName, enterParams)
      gStateStack:push(FadeInState({ 0, 0, 0}, .4,
      function()
        gWorld:changeLevel(levelName, enterParams)

        gStateStack:push(FadeOutState({ 0, 0, 0}, .4, function() end ))
      end))
      return true
    end,

    ['changeState'] = function(state)
      print('changeStateActions')
      gStateStack:pop()
      print(state)
      gStateStack:push(GAMESTATES[state]())
      return true
    end,

    ['push-back'] = function(text, entity)
      gStateStack:push(DialogueState(text, function()
        entity:setToOppositeDirection()
        entity:changeState('walk')
        entity.bumbed = false
      end))
      return false
    end,

    ['turn-around'] = function(text, entity)
      gStateStack:push(DialogueState(text, nil, false))
      Timer.after(.12, function()
        entity:setToOppositeDirection()
        entity:changeState('walk')
        Timer.after(.7, function()
          gStateStack:pop()
        end)
      end)

      return false
    end,

    ['changeDirection'] = function(direction, entity)
      -- entity:changeState('idle')
      --
      -- entity.direction = direction
    end,

    ['move'] = function(direction, entity)
      entity.canInput = false

      Timer.every(.18, function()
        entity.direction = direction
        -- entity:changeAnimation('walk-' .. direction)
        entity:changeState('walk')
      end):limit(3)
      Timer.after(3*.18, function()
        love.keyboard.keysPressed = {}
        entity.canInput = true
      end)

    end


}
