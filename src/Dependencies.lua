os = require 'os'
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife/timer'
-- Serialize = require 'lib/knife.serialize'

-- Constants
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
VIRTUAL_WIDTH = 324
VIRTUAL_HEIGHT = 234

BATTLE_MENU_WIDTH = 124
BATTLE_MENU_HEIGHT = 64
BATTLE_MENU_X = VIRTUAL_WIDTH - BATTLE_MENU_WIDTH
BATTLE_MENU_Y = VIRTUAL_HEIGHT - BATTLE_MENU_HEIGHT

DIALOGUE_BOX_WIDTH = VIRTUAL_WIDTH
DIALOGUE_BOX_HEIGHT = 64
DIALOGUE_BOX_X = (VIRTUAL_WIDTH - DIALOGUE_BOX_WIDTH) / 2
DIALOGUE_BOX_Y = VIRTUAL_HEIGHT - 64

SELECTION_PADDING_LEFT = 10
SELECTION_PADDING_TOP = 7

TILESIZE = 16

LAYER_NUMBERS = {
  -- [5] = 'debugLayer',   -- debug
  -- [4] = 'grid',         --debug
  [1] = 'groundLayer',
  [2] = 'decoLayer',
  [3] = 'topLayer'
}

-- Preferences and variables
math.randomseed(os.time())


-- Loading Assets
require 'src/Util'
gTextures = {
  ['aardart-front'] = love.graphics.newImage('graphics/pokemon/aardart-front.png'),
  ['aardart-back'] = love.graphics.newImage('graphics/pokemon/aardart-back.png'),
  ['agnite-front'] = love.graphics.newImage('graphics/pokemon/agnite-front.png'),
  ['agnite-back'] = love.graphics.newImage('graphics/pokemon/agnite-back.png'),
  ['anoleaf-front'] = love.graphics.newImage('graphics/pokemon/anoleaf-front.png'),
  ['anoleaf-back'] = love.graphics.newImage('graphics/pokemon/anoleaf-back.png'),
  ['bamboon-front'] = love.graphics.newImage('graphics/pokemon/bamboon-front.png'),
  ['bamboon-back'] = love.graphics.newImage('graphics/pokemon/bamboon-back.png'),
  ['cardiwing-front'] = love.graphics.newImage('graphics/pokemon/cardiwing-front.png'),
  ['cardiwing-back'] = love.graphics.newImage('graphics/pokemon/cardiwing-back.png'),

  ['panelBackground'] = love.graphics.newImage('graphics/list.png'),
  ['continue'] = love.graphics.newImage('graphics/continue.png'),
  ['cursor'] = love.graphics.newImage('graphics/cursor.png'),


  --Entity
  ['entities'] = love.graphics.newImage('graphics/entities.png'),

  --Item
  ['balls'] = love.graphics.newImage('graphics/balls.png'),


  --TileMap
  ['sheet'] = love.graphics.newImage('graphics/sheet.png'),
  ['tilemap'] = love.graphics.newImage('graphics/tilemap.png'),
  ['collision'] = love.graphics.newImage('graphics/collision.png'),
  ['interior'] = love.graphics.newImage('graphics/interior.png'),
  ['living-room'] = love.graphics.newImage('graphics/living-room.png'),

}

gFrames = {
  ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
  ['sheet'] = GenerateQuads(gTextures['sheet'], 16, 16),
  ['tilemap'] = GenerateQuads(gTextures['tilemap'], 16, 16),
  ['collision'] = GenerateQuads(gTextures['collision'], 16, 16),
  ['interior'] = GenerateQuads(gTextures['interior'], 16, 16),
  ['living-room'] = GenerateQuads(gTextures['living-room'], 16, 16),
  ['balls'] = GenerateQuads(gTextures['balls'], 16, 16),
}

gFonts = {
  ['super-tiny'] = love.graphics.newFont('fonts/font.ttf', 3),
  ['tiny'] = love.graphics.newFont('fonts/font.ttf', 8), -- a bug here
  ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
  ['big'] = love.graphics.newFont('fonts/font.ttf', 10),
  ['huge'] = love.graphics.newFont('fonts/font.ttf', 18),
}

--  Includes
  require 'src/shader_defs'
  require 'src/pokemon_defs'
  require 'src/StateStack'
  require 'src/StateMachine'
  require 'src/states/BaseState'
  require 'src/Animation'
  require 'src/Camera'
  require 'src/Actions'

  require 'src/states/game/StartState'
  require 'src/states/game/PlayState'
  require 'src/states/game/FadeInState'
  require 'src/states/game/FadeOutState'
  require 'src/states/game/TestState'

  require 'src/states/gui/MenuState'
  require 'src/states/gui/DialogueState'
  require 'src/states/gui/DialogueMenuState'
  require 'src/states/gui/FieldMenuState' --The menu on the field(Press enter)
  require 'src/states/gui/InventoryMenuState' -- The Inventory menu on fieldmenu
  --
  require 'src/states/entity/EntityBaseState'
  require 'src/states/entity/EntityIdleState'
  require 'src/states/entity/PlayerIdleState'
  require 'src/states/entity/EntityWalkState'
  require 'src/states/entity/PlayerWalkState'

  require 'src/gui/Panel'
  require 'src/gui/Textbox'
  require 'src/gui/ProgressBar'
  require 'src/gui/ScrollBar'
  require 'src/gui/Selection'
  require 'src/gui/Menu'

  require 'src/entity/Entity'
  require 'src/entity/Player'
  require 'src/entity/Inventory'
  require 'src/entity/entity_defs'

  require 'src/world/level_defs'
  require 'src/world/World'
  require 'src/world/Level'
  require 'src/world/TileMap'
  require 'src/world/Tile'
  require 'src/world/Gameobject'
-- require 'src/Pokemon'
-- require 'src/Party'
-- require 'src/Item'
-- require 'src/Door'
-- require 'src/StoryboardState'
--

--
-- require 'src/states/menus/MenuState'  --Base Menu state
-- require 'src/states/menus/DialogueMenuState' -- A Menu with a textbox
-- require 'src/states/menus/PartyMenu'  -- The menu to view the Party on fieldmenu

-- require 'src/states/menus/ItemMenuState'
--
-- require 'src/states/battle/BattleState'
-- require 'src/states/battle/BattleMessageState'
-- require 'src/states/battle/BattleMenuState'
-- require 'src/states/battle/BattleStatsState'
-- require 'src/states/battle/TakeTurnState'
--
require 'src/item_defs'
require 'src/pokemon_defs'
require 'src/character_defs'
-- require 'src/defs/ai_defs'
-- require 'src/defs/tile_ids'
-- require 'src/defs/gameobject_defs'
--

-- require 'src/entity/NPC'


-- require 'src/battle/Opponent'
-- require 'src/battle/BattleSprite'
-- require 'src/battle/BattleDisplay'
