Pokemon = Class{}

function Pokemon:init(def, level)
  self.name = def.name
  self.battleSpriteFront = def.battleSpriteFront
  self.battleSpriteBack = def.battleSpriteBack

  self.baseHP = def.baseHP
  self.baseAttack = def.baseAttack
  self.baseDefense = def.baseDefense
  self.baseSpeed = def.baseSpeed

  self.HPIV = def.HPIV
  self.attackIV = def.attackIV
  self.defenseIV = def.defenseIV
  self.speedIV = def.speedIV

  self.level = level
  self.HP = self.baseHP
  self.attack = self.baseAttack
  self.defense = self.baseDefense
  self.speed = self.baseSpeed

  self:calculeStats()

  self.currentEXP = 0
  self.expToLevel = self.level * self.level * 5

end

function Pokemon:calculeStats()
  for i = 1, self.level do
    self:statsLevelUp()
    self.currentEXP = (self.level - 1) * (self.level - 1) * 5
  end
end

function Pokemon:statsLevelUp()
  local increaseHP = 0
  for j = 1, 3 do
    if math.random(6) <= self.HPIV then
      increaseHP = increaseHP + 1
      self.HP = self.HP + 1
    end
  end

  local increaseAttack = 0
  for j = 1, 3 do
    if math.random(6) <= self.attackIV then
      increaseAttack = increaseAttack + 1
      self.attack = self.attack + 1
    end
  end

  local inscreaseDefense = 0
  for j = 1, 3 do
    if math.random(6) <= self.defenseIV then
      inscreaseDefense = inscreaseDefense + 1
      self.defense = self.defense + 1
    end
  end

  local increaseSpeed = 0
  for j = 1, 3 do
    if math.random(6) <= self.speedIV then
      increaseSpeed = increaseSpeed + 1
      self.speed = self.speed + 1
    end
  end

  return increaseHP, increaseAttack, inscreaseDefense, increaseSpeed
end

function Pokemon:isDeath()
  if self.currentHP <= 0 then
    return true
  end

  return false
end

function Pokemon:randomDef()
  return POKEMON_DEFS[POKEMON_IDS[math.random(#POKEMON_IDS)]]
end

function Pokemon:heal(amount)
  if type(amount) == string then
    if amount == 'full' then
      self.currentHP = self.HP
    elseif amount == 'half' then
      self.currentHP = self.HP / 2
    elseif amount == 'min' then
      self.currentHP = 1
    end
  elseif type(amount) == number then
    self.currentHP = self.currentHP + amount
    if self.currentHP > self.HP then
      sel.currentHP = self.HP
    end
  end
end
