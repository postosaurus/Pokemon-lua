

local time = 0
function love.load()

  myShader = love.graphics.newShader(
  [[

  varying vec4 vpos;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    vpos = vertex_position;
    return transform_projection * vertex_position;
}
#endif

#ifdef PIXEL
vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{
    texture_coords += vec2(cos(vpos.x), sin(vpos.y));
    vec4 texcolor = Texel(tex, texture_coords);
    return texcolor * color;
}
#endif
  ]])
  sprite = love.graphics.newImage('graphics/pokemon/aardart-front.png')
  width, height = love.window:getMode()
  print(love.window:getMode())


  x = (width / 2) - (sprite:getWidth() * 5) / 2
  y =  height / 2 - (sprite:getHeight() * 5) / 2
end

function love.update(dt)
  time = time + dt
  if love.keyboard.isDown('r') then
    love.event.quit('restart')
  end
  if love.keyboard.isDown('a') then
    x = x - 40
  elseif love.keyboard.isDown('d') then
    x = x + 40
  elseif love.keyboard.isDown('w') then
    y = y - 40
  elseif love.keyboard.isDown('s') then
    y = y + 40
  end

  -- myShader:send('time', time)
end

function love.draw()
  love.graphics.setBackgroundColor(1, 1, 1, 1)
  -- if love.keyboard.isDown('space') then
     love.graphics.setShader(myShader) --draw something here
  -- end

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(sprite, x, y,  0, 5, 5)

  -- love.graphics.setShader(sunShader)
  love.graphics.setLineWidth(4)

  love.graphics.setColor(1, 1, 0, 1)
  love.graphics.circle('fill', -16, height / 2, 64)
  love.graphics.setShader()
end
