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
      function()
        Say('I am Empty')
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
      canMove = true,
      onInteract =
        function()
          Say('Your Pokemon looks tired. You should let it rest from time to time.',
          function()
            Ask(
              'Do you want to heal your Pokemon?',
              {
                 {text = 'Yes',
                  onSelect = function()
                    gStateStack:pop()
                    Heal()
                    -- self.player.party.pokemon[1].currentHP = self.player.party.pokemon[1].HP
                    gStateStack:push(FadeOutState({r=1,b=1,g=1},.3,
                    function()

                      gStateStack:push(FadeInState({r=1,b=1,g=1},.3,
                      function()
                        Say('Much better')
                      end))
                    end))
                  end},
                 {text = 'No',
                  onSelect =
                    function()
                      gStateStack:pop()
                      Say('So there you go...')
                    end
                  }
              }
            )
          end)
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
      canMove = true,
      onInteract = function()
        Say('Hello my name is Susi.')
      end
    }


}
