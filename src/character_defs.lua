CHARACTER_STATES = {
  ['idle'] = function(world, entity) return EntityIdleState(world, entity) end,
  ['walk'] = function(world, entity) return EntityWalkState(world, entity) end,
}

CHARACTER_DEFS = {
  ['empty'] = {
    name = 'empty',
    animations = ENTITY_DEFS['npc'].animations,
    width = 16,
    height = 16,
    AI = 'stand-still',
    states = {'idle'},
    state = 'idle',
    onInteract =
      function(npc)
        return function(level, entity)
          gStateStack:push(DialogueState('I am Empty'))
        end
      end
    },
    ['healer'] = {
      name = 'healer',
      animations = ENTITY_DEFS['npc'].animations,
      width = 16,
      height = 16,
      states = {'idle', 'walk'},
      state = 'idle',
      AI = 'walk-around',
      canInput = true,
      onInteract =
      function(npc)
        return function(level, entity)
          npc.direction = npc:oppositeDirection(entity.direction)
          npc:changeAnimation('idle-' .. npc.direction)
          gStateStack:push(DialogueState('I am Empty'))
          AddItem('potion', 1, entity)
        end
      end
      },
    ['susi'] = {
      name = 'susi',
      animations = ENTITY_DEFS['npc'].animations,
      width = 16,
      height = 16,
      states = {'idle', 'walk'},
      state = 'idle',
      AI = 'walk-around',
      canInput = true,
      onInteract = function()
        gStateStack:push(DialogueState('Hello my name is Susi.'))
      end
    }


}
