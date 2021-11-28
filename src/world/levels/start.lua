return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 25,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 41,
  nextobjectid = 30,
  properties = {},
  tilesets = {
    {
      name = "tilemap",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 13,
      image = "../../../../tiledMaps/tilemap.png",
      imagewidth = 208,
      imageheight = 144,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 117,
      tiles = {}
    },
    {
      name = "collision",
      firstgid = 118,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 15,
      image = "../../../tiledMaps/collision.png",
      imagewidth = 240,
      imageheight = 225,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 210,
      tiles = {
        {
          id = 0,
          type = "solid",
          properties = {
            ["solid"] = true,
            ["visible"] = false
          }
        },
        {
          id = 1,
          type = "trigger",
          properties = {
            ["action"] = "changeLevel",
            ["nextLevel"] = "house",
            ["playerDirection"] = "down",
            ["trigger"] = "onEnter",
            ["x"] = 11,
            ["y"] = 15
          }
        },
        {
          id = 2,
          type = "trigger",
          properties = {
            ["action"] = "push-back",
            ["text"] = "Don't go into the forest. It is dangerous there.",
            ["trigger"] = "onEnter"
          }
        },
        {
          id = 3,
          type = "trigger",
          properties = {
            ["action"] = "say",
            ["solid"] = true,
            ["text"] = "Jessy's house",
            ["trigger"] = "onInteract"
          }
        },
        {
          id = 4,
          type = "trigger",
          properties = {
            ["action"] = "say",
            ["solid"] = false,
            ["text"] = "Hmm...?",
            ["trigger"] = "onExit",
            ["visible"] = true
          }
        },
        {
          id = 5,
          type = "item",
          properties = {
            ["amount"] = 1,
            ["name"] = "pokeball",
            ["solid"] = true,
            ["visible"] = true
          }
        },
        {
          id = 6,
          type = "npc"
        },
        {
          id = 7,
          type = "trigger",
          properties = {
            ["action"] = "changeState",
            ["solid"] = true,
            ["text"] = "start",
            ["trigger"] = "onInteract"
          }
        },
        {
          id = 15,
          type = "trigger",
          properties = {
            ["action"] = "say",
            ["text"] = "Goodbye",
            ["trigger"] = "onExit"
          }
        },
        {
          id = 183,
          type = "solid",
          properties = {
            ["solid"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 37,
      name = "grid",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 0, 0, 0,
        118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        118, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 122, 0, 0, 0, 124, 0, 0, 118, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 118, 118, 118, 118, 118, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 118, 118, 118, 118, 118, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 118, 118, 118, 119, 118, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 118, 123, 0, 123, 118, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 125, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 0, 0, 120, 118, 118, 118, 118, 118,
        118, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 118, 118, 118, 118, 118,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 0, 0, 0, 0, 0,
        0, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 1,
      name = "ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        72, 72, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 72, 72, 72, 72, 72, 72,
        72, 72, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 72, 72, 72, 72, 72, 72,
        72, 72, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 59, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 59, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 59, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 59, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 72, 72, 72, 72, 72, 72,
        72, 72, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 72, 72, 72, 72, 72, 72,
        72, 72, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72,
        72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 40,
      name = "onGround",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 0, 0, 0, 0, 0, 0,
        0, 0, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 72, 73, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 40, 41, 42, 43, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 53, 54, 55, 56, 57, 61, 0, 0, 0, 0, 0, 71, 72, 73, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 66, 67, 68, 69, 70, 74, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 71, 72, 73, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 72, 73, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 71, 72, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 60, 0, 0, 0, 0, 0, 0, 71, 72, 73, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 34,
      name = "deco",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 59, 59, 59, 59, 59, 59,
        59, 59, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 14, 15, 16, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 27, 28, 29, 30, 31, 0, 0, 0, 32, 98, 32, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 98, 32, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 32, 98, 32, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 98, 32, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 32, 98, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 60, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 58, 59, 59, 59, 59, 59, 59,
        59, 59, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59,
        59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 25,
      height = 25,
      id = 35,
      name = "fixDeco",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 59, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 47, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 60, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 47, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 60, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 47, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 60, 0, 45, 46, 47, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 45, 46, 47, 0, 0, 0, 0, 0, 0, 0, 58, 59, 60, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 58, 59, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 45, 46, 47, 0, 0, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 0, 0, 0, 0, 0, 0, 58, 59, 60, 0, 0, 0, 0, 0, 0, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 47, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 45, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46
      }
    }
  }
}
