push = require 'push'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 600
VIRTUAL_HEIGHT = 350
function love.load()
  --nFont =  love.graphics.newFont(,20)
  --love.graphics.setFont(nFont)
  -- love.graphics.setColour('red')
  love.graphics.setDefaultFilter('nearest','nearest')
  push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
   fullscreen = false,
   resizable = false,
   vsync = true
  })
  end
 function love.keypressed(key)
    if key == 'escape' then
           love.event.quit()
    end
 end
 function love.draw()
    push:apply('start')
    love.graphics.printf('PONG',0,VIRTUAL_HEIGHT/5-50,VIRTUAL_WIDTH,'center')
    love.graphics.rectangle('fill',10,20,5,30)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-20,5,30)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
    push:apply('end')
    end
 