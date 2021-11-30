PartyMenuState = Class {__includes = BaseState}

function PartyMenuState:init(world)
  self.world = world
  self.panel = Panel{ x= 0, y = 0, width = VIRTUAL_WIDTH, height = VIRTUAL_HEIGHT, color = {1, 1, 1,1}}

  self.items = {}
  for i, pokemon in ipairs(self.world.player.pokemon) do
      local lisOfOptions = {}
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
      table.insert(self.items, {
        item = pokemon,
        onSelect = function()
          gStateStack:push(MenuState{x = 5, y = 5, width = 56, rows = #lisOfOptions, items = lisOfOptions})
      end
    })

    self.currentSelection = 1
  end

  self.currentSelection = 1
end

function PartyMenuState:handleInput()
  if love.keyboard.wasPressed('w') then
    self.currentSelection = self.currentSelection - 1
    if self.currentSelection <= 0 then
      self.currentSelection = 7
    end
    if not self.world.player.pokemon[self.currentSelection] then
      if self.currentSelection == 7 then
        return
      end
      self.currentSelection = self.world.player:getPokemonCount()
    end

  elseif love.keyboard.wasPressed('s') then
    self.currentSelection = self.currentSelection + 1
    if self.currentSelection > 7 then
      self.currentSelection = 1
    end
    if not self.world.player.pokemon[self.currentSelection] then
      self.currentSelection = 7
    end
  elseif love.keyboard.wasPressed('space') then
    if self.currentSelection == 7 then
      gStateStack:pop()
      return
    end
    local item = self.items[self.currentSelection]
    if item then
      item:onSelect()
    end
  end
end

function PartyMenuState:update(dt)
end

function PartyMenuState:render()
  self.panel:render()
  local x = 64
  local y = 10
  local width = VIRTUAL_WIDTH -78
  local height = 32

  for i = 1, 6 do
    local panelColor = {1, 1, 1, .5}
    if i == self.currentSelection then
      panelColor = {1, 0, 0, .5}
    end

    local panel = Panel{x = x, y = y , width = width, height = height, color = panelColor, borderWidth = 0}
    panel:render()

    local pokemon = self.world.player.pokemon[i]
    if pokemon then
      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(pokemon.name, x + 10, y + 10)
      love.graphics.print('Lv. ' .. tostring(pokemon.level), x + VIRTUAL_WIDTH- 126, y +10)

      love.graphics.setFont(gFonts['tiny'])
      love.graphics.print(pokemon.currentHP .. '/' .. pokemon.HP .. ' HP', x +55, y+20)
      love.graphics.setFont(gFonts['small'])
      local healtBar = ProgressBar{x = x + width / 2, y = y+20, width = 96, height = 4,
        value = pokemon.currentHP, maxValue = pokemon.HP}
      healtBar:render()
    end

    y = y + 36
  end

  local panelColor = {1, 1, 1, .5}
  if self.currentSelection == 7 then
    print(self.currentSelection)

    panelColor = {1, 0, 0, .5}
  end
  local panel = Textbox('Cancel', {x = 5, y =  5*36 + 12 , width = 56, height = 30, borderWidth = 0, color = panelColor})
  panel:render()
end
