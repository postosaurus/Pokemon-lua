Layout = Class{}

function Layout:init()
  self.panels = {}

  self.panels['screen'] = {x= 0, y = 0, width = VIRTUAL_WIDTH, height = VIRTUAL_HEIGHT}

end

function Layout:createPanel(name)
  local layout = self.panels[name]
  local panel = Panel{x = layout.x, y = layout.y, width = layout.width, height = layout.height}
  return panel
end

function Layout:debugRender()
  for i, panel in pairs(self.panels) do
    print(i, panel)
    local p = self:createPanel(i)
    p:render()
  end
end

function Layout:contract(name, horz, vert)
  local horz = horz or 0
  local vert = vert or 0

  local panel = self.panels[name]
  panel.width = panel.width - horz
  panel.height = panel.height - vert
end

function Layout:contractEven(name, horz, vert)
  local horz = horz or 0
  local vert = vert or 0

  local panel = self.panels[name]
  panel.width = panel.width - horz
  panel.height = panel.height - vert
  panel.x = panel.x + horz /2
  panel.y = panel.y + vert /2
end

function Layout:splitHorz(name, tname, bname, x, spliteSize)
  local parent = self.panels[name]
  self.panels[name] = nil

  local p1Height = parent.height * (x)
  local p2Height = parent.height * (1-x)
  self.panels[tname] = {
    x = parent.x,
    y = parent.y + spliteSize,
    width = parent.width,
    height = p1Height - spliteSize
  }

  self.panels[bname] = {
    x = parent.x,
    y = parent.y + parent.height - p2Height + spliteSize,
    width = parent.width,
    height = p2Height - spliteSize
  }
end

function Layout:splitVert(name, lname, rname, x, spliteSize)
  local parent = self.panels[name]
  self.panels[name] = nil

  local p1Width = parent.width * (x)
  local p2Width = parent.width * (1-x)
  self.panels[lname] = {
    x = parent.x + spliteSize,
    y = parent.y,
    width = p1Width - spliteSize,
    height = parent.height,
  }

  self.panels[rname] = {
    x = parent.x + parent.width - p2Width + spliteSize,
    y = parent.y,
    width = p2Width - spliteSize,
    height = parent.height,
  }
end
