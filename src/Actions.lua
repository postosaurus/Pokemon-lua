ACTIONS = {

    ['empty'] = function(params)
      return function(level, entity)
        print('empty callback function')
        return true
      end
    end,

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

    ['addItem'] = function(name, amount)
      local item = name
      local amount = amount

      return function(level, entity)
        AddItem(item, amount)
      return true
      end
    end,

    ['say'] = function(params)
      -- local text = params.text
      -- print(params.text)

      -- table.foreach(params, print)
      return function(level, entity)
        -- entity.canInput = false
        gStateStack:push(DialogueState(params.text), function()
          -- entity.canInput = true
        end)
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

    ['changeState'] = function(params)
      return function(level, entity)
        gStateStack:pop()
        gStateStack:push(GAMESTATES[params.text]())
        return true
      end
    end,

    ['push-back'] = function(params)
      local text = params.text
      return function(level, entity)
        if text then
          gStateStack:push(DialogueState(text, function()
            entity:setToOppositeDirection()
            entity:changeState('walk')
            entity.bumbed = false
          end))
        else
            entity:setToOppositeDirection()
            entity:changeState('walk')
            entity.bumbed = false
          return false
        end
      end
    end,

    ['turn-around'] = function(params)
      local text = params.text

      return function(level, entity)
        if text then
          gStateStack:push(DialogueState(text, nil, false))
        end
        Timer.after(.12, function()
          entity:setToOppositeDirection()
          entity:changeState('walk')
          Timer.after(.7, function()
            if text then
              gStateStack:pop()
            end
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
        -- entity.canInput = false
        return false
      end
    end,

    ['move'] = function(params)
      local direction = params.direction
      local steps = params.steps or 1
      return function(level, entity)
        entity.canInput = false

        Timer.every(.18, function()
          entity.direction = direction
          entity:changeState('walk')
        end):limit(steps)

        Timer.after(steps*.2, function()

          entity.canInput = true
        end)
        love.keyboard.keysPressed = {}

      end

    end


}
