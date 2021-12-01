TestState = Class{__includes = BaseState}

function TestState:init(world, itemEffect)
  self.world = world
  self.itemEffect = itemEffect
  -- self.panel = gPanels['middle']

  self.layout = Layout()
  self.layout:splitHorz('screen', 'top', 'bottom', .055, 0)
  self.layout:splitHorz('bottom', 'middle', 'bottom', .8, 0)

  self.panel = self.layout:createPanel('middle')

  self.layout:splitThirdVert('middle', 'a', 'b', 'c', 10)
  self.layout:splitHorz('a', 'a', 'd', .5, 5)
  self.layout:splitHorz('b', 'b', 'e', .5, 5)
  self.layout:splitHorz('c', 'c', 'f', .5, 5)

  self.layout:splitVert('bottom', 'l', 'g', .69, 0)
  self.layout:splitVert('l', 'r', 's', .69, 0)


  local labels = {'a', 'b', 'c', 'd', 'e', 'f', 'g'}
  self.panels = {}
  for i = 1, #labels do
    table.insert(self.panels, self.layout:createPanel(labels[i]))
  end


  -- for i = 1, 6 do
  -- end

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
        pokemon = pokemon,
        onSelect = function()
          local panel = gPanels['bottomRight']
          panel.maxRows = 3
          panel.rows = 2
          return gStateStack:push(DialogueMenuState('What do you want to do?', lisOfOptions, panel))
        end
      })

    end

    for i = 1, 6-#listOPokemon do
      table.insert(listOPokemon, {
        text= 'empty',
        onSelect = function()
          gStateStack:push(DialogueState('Nothing to do here.', function() end))--, gPanels['bottomLeft']))
        end
      })
    end
    table.insert(listOPokemon, {
      text = 'Cancel',
      onSelect = function()
        gStateStack:pop()
      end
    })
  end

  self.panel['rows'] = 3
  self.panel['maxRows'] = 3
  self.panel['columns'] = 3
  self.panel['visible'] = true
  self.panel['items'] = listOPokemon
  self.pokemonList = Menu(self.panel)
end

function TestState:update(dt)
  if love.keyboard.wasPressed('backspace') then
    gStateStack:pop()
  end

  self.pokemonList:update(dt)

  local itemIndex = self.pokemonList.selection.focusX + (self.pokemonList.selection.focusY - 1) * self.pokemonList.selection.columns
  if itemIndex >= 7 then
    self.pokemonList.selection.focusX = 1
    self.pokemonList.selection.focusY = 3

  end

  -- if love.keyboard.wasPressed('space') and itemIndex == 7 then
  --   gStateStack:pop()
  -- end

end

function TestState:render()
  self.panel:render()
  self.pokemonList.selection:renderOnPanels(self.panels)
  -- self.pokemonList:render()
end
