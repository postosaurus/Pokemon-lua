PartyMenuState = Class{__includes = BaseState}

function PartyMenuState:init(world, itemEffect)
  self.world = world
  self.itemEffect = itemEffect
  self.panel = gPanels['middle']

  print('here--------------------------' .. type(self.world))

  local listOPokemon = {}
  if self.itemEffect then
    for i, pokemon in ipairs(self.world.player.pokemon) do
      local lisOfOptions = {}
      table.insert(lisOfOptions, {
        text = 'Ok',
        onSelect =  function()
          gStateStack:pop()
            self.itemEffect(pokemon)

            -- gStateStack:pop()


        end
      })

      table.insert(lisOfOptions, {
        text = 'Cancel',
        onSelect =  function()
          gStateStack:pop()
        end
      })

      table.insert(listOPokemon, {
        text = pokemon.name,
        onSelect = function()
          local panel = gPanels['bottomRight']
          panel.maxRows = 2
          panel.rows = 2
          return gStateStack:push(DialogueMenuState(pokemon.name, lisOfOptions, panel))
        end
      })
    end
  else
    for i, pokemon in ipairs(self.world.player.pokemon) do
      local lisOfOptions = {}
      print(pokemon.name)

      table.insert(lisOfOptions, {
        text = 'Info',
        onSelect = function()
          gStateStack:push(PokemonInfoState(i))
        end})

      table.insert(lisOfOptions, {
        text = 'Switch',
        onSelect = function()
          gStateStack:pop()
          gStateStack:push(DialogueState('function is about to come'))
        end})

      table.insert(lisOfOptions, {
        text = 'Cancel',
        onSelect = function()
          gStateStack:pop()
        end})

      table.insert(listOPokemon, {
        text = pokemon.name,
        onSelect = function()
          local panel = gPanels['bottomRight']
          panel.maxRows = 3
          panel.rows = 2
          return gStateStack:push(DialogueMenuState('What do you want to do?', lisOfOptions, panel))
        end
      })
    end
  end


  self.pokemonList = Menu{
    x = 15, y = 15, width = VIRTUAL_WIDTH / 2 + 40, height = VIRTUAL_HEIGHT - 30,
    rows = 6, maxRows = 6, visible = false,
    items = listOPokemon
  }
end

function PartyMenuState:update(dt)
  if love.keyboard.wasPressed('backspace') then
    gStateStack:pop()
  end

  self.pokemonList:update(dt)
end

function PartyMenuState:render()
  self.panel:render()
  self.pokemonList:render()
end
