push = require 'push'
WINDOW__WIDTH = 1280
WINDOW__HEIGHT = 720
VIRTUAL_WIDTH = 600
VIRTUAL_HEIGHT = 350
function love.load()
  love.graphics.setDefaultFilter('nearest','nearest')
  push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW__WIDTH,WINDOW__HEIGHT,{
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
    push:apply('end')
    end
 