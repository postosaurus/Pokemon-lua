local ballsTexture = 'balls'
local ballOnInteract = function() Say('an item') end
ITEMS = {
  ['empty'] = {
    name = 'empty',
    width = TILESIZE,
    height = TILESIZE,
    text = 'Empty',
    description = 'empty',
    type = nil,
    solid = false,
    visible = true,
    texture = ballsTexture,
    animations = {
      ['idle'] = {
        frames = {1},
        texture = 'items',
        looping = false}
    },
    onUse = function() end,
    onBattleUse = function() end,
    addAction = {
      text = 'empty',
      onAction = function() end
    }
  },
  ['pokeball'] = {
    text = 'Pokeball',
    name = 'pokeball',
    description = 'A sofisticated ball to catch Pokemon.',
    type = 'ball',
    solid = true,
    visible = true,
    texture = ballsTexture,
    animations = {
        ['idle'] = {
          frames = {1},
          texture = ballsTexture,
        },
        ['throw'] = {
          frames = {1 , 26, 51, 76, 101, 126, 151, 176, 201, 226, 251},
          texture = ballsTexture,
          interval = .3,
        },
        ['catch'] = {
          frames = {1, 276, 301, 326, 351, 376, 401},
          texture = ballsTexture,
          interval = 1
        }
    },
    onUse = nil,
    onBattleUse = function() Pop() BattleMessage('A Pokeball!') end,
  },
  ['map'] = {
    text = 'Map',
    name = 'map',
    description = 'A map of the town.',
    type = 'keyItem',
    solid = true,
    visible = true,
    texture = ballsTexture,
    animations = {
        ['idle'] = {
          frames = {1},
          texture = ballsTexture,
        }
    },
    onUse = function() gStateStack:push(DialogueState('This is a map')) end,
    onBattleUse = function() BattleMessage('This has no use here') end,
  },
  ['potion'] = {
    name = 'potion',
    width = TILESIZE,
    height = TILESIZE,
    text = 'Potion',
    amount = 20,
    description = 'Restores 20HP of one Pokemon',
    type = 'consumable',
    solid = true,
    visible = true,
    texture = ballsTexture,
    animations = {
      ['idle'] = {
        frames = {1},
        texture = 'items',
        looping = false}
    },

    onUse = function(world, item)
      -- return function (pokemon)
        print('im am here item_defs onUSe')
        Heal(world, item, 20)
      -- end
        -- gStateStack:pop()
        -- gStateStack:push(PartyMenuState(world,
        --   function(pokemon)
        --
        --     gStateStack:push(DialogueState('Somehhing happedn',
        --     function()
        --       gStateStack:pop()
        --       Heal(20, pokemon)
        --       world.player:removeItem(item.name, 1)
        --       -- return true
        --       gStateStack:pop()
        --       gStateStack:push(InventoryMenuState(world))
        --     end))
        --
        --   end))


    end,
    onConsume = function(pokemon, amount) Heal(pokemon, amount) end,
    onBattleUse = function(world, battlestate) gStateStack:push(PartyMenuState(world, true, 'potion', battlestate,
      function()
      end)) end,

    addAction = {
      text = 'empty',
      onAction = function() end
    }
  }
}
