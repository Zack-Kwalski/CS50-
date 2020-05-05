WINDOW__WIDTH = 1280
WINDOW__HEIGHT = 720
function love.load()
  love.window.setMode(WINDOW__WIDTH,WINDOW__HEIGHT,{
   fullscreen = false,
   resizable = false,
   vsync = true
  })
  end
function love.draw()
    love.graphics.printf('PONG',0,WINDOW__HEIGHT/5-50,WINDOW__WIDTH,'center')
    end