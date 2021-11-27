ACTIONS = {

    ['teleport'] = function(params)
      local x = params.x
      local y = params.y
      return function(level, entity)
        -- print(x, y)
        entity.mapX = x
        entity.mapY = y
        Teleport(entity, level)

        entity:changeAnimation('idle-' .. entity.direction)
        entity:changeState('idle')

      end
    end,

    ['addItem'] = function(params)
      local item = params.name
      local amount = params.amount

      return function(level, entity)
        AddItem(item, amount)
      return false
      end
    end,

    ['say'] = function(params)
      local text = params.text
      return function(level, entity)
        gStateStack:push(DialogueState(text))
        return true
      end
    end,

    ['changeLevel'] = function(params)

      local nextLevel = params.nextLevel
      local enterParams = {
        nextLevel = params.nextLevel,
        x = params.x,
        y = params.y,
        direction = params.direction,
      }

      return function(level, entity)
      gStateStack:push(FadeInState({ 0, 0, 0}, .4,
        function()

          level.world:changeLevel(nextLevel, enterParams)

          gStateStack:push(FadeOutState({ 0, 0, 0}, .4, function() end ))
        end))

        return true
      end
    end,

    ['changeState'] = function(world, entity, params)
      -- print('changeStateActions')
      gStateStack:pop()
      -- print(params.state)
      gStateStack:push(GAMESTATES[params.state]())
      return true
    end,

    ['push-back'] = function(params)
      local text = params.text
      return function(level, entity)
        gStateStack:push(DialogueState(text, function()
          entity:setToOppositeDirection()
          entity:changeState('walk')
          entity.bumbed = false
        end))
        return false
      end
    end,

    ['turn-around'] = function(params)
      local text = params.text

      return function(level, entity)
        gStateStack:push(DialogueState(text, nil, false))
        Timer.after(.12, function()
          entity:setToOppositeDirection()
          entity:changeState('walk')
          Timer.after(.7, function()
            gStateStack:pop()
          end)
        end)

      return false
      end
    end,

    ['changeDirection'] = function(params)
      local direction = params.direction
      return function(level, entity)
        entity.direction = direction
        entity:changeState('idle')
        entity:changeAnimation('idle-' .. entity.direction)
        entity.canInput = false
        return false
      end
    end,

    ['move'] = function(params)
      local direction = params.direction
      return function(level, entity)
        entity.canInput = false

        Timer.every(.18, function()
          entity.direction = direction
          entity:changeState('walk')
        end):limit(3)

        Timer.after(3*.18, function()
          love.keyboard.keysPressed = {}
          entity.canInput = true
        end)

      end

    end


}
