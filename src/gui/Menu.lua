Menu = Class {}

function Menu:init(def)

  self.selection = Selection(def)
  self.panel = Panel(def)
  self.panel.width = self.selection.width
  self.panel.height = self.selection.height

end

function Menu:enter()
end

function Menu:update(dt)
  self.selection:update(dt)
end

function Menu:render()
  self.panel:render()
  self.selection:render()
end
