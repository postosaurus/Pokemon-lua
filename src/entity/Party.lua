Party = Class{}

function Party:init(pokemon)
  self.pokemon = pokemon or {
     Pokemon(Pokemon:randomDef(self), math.random(1, 5)),
     Pokemon(Pokemon:randomDef(self), math.random(1, 5)),
     Pokemon(Pokemon:randomDef(self), math.random(1, 5)),
     Pokemon(Pokemon:randomDef(self), math.random(1, 5)),
     Pokemon(Pokemon:randomDef(self), math.random(1, 5)),
  }
end

function Party:heal(pokemonID, amount)
  self.pokemon[pokemonID]:heal(amount)
end
