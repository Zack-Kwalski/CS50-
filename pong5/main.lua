push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 600
VIRTUAL_HEIGHT = 350
 
 function love.load()
   math.randomseed(os.time())
   ball = Ball(VIRTUAL_WIDTH/2 - 2,VIRTUAL_HEIGHT/2 - 2,4,4)
   Player1 = Paddle(10,20,5,30)
   Player2 = Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-50,5,30)
   P1Score = 0
   P2Score = 0
   paddle_speed = 200
   
  
  nFont =  love.graphics.newFont('ARDESTINE.ttf',20)
  n2Font = love.graphics.newFont('ARDESTINE.ttf',40)
  love.graphics.setFont(nFont)
  -- love.graphics.setColour('red')
  love.graphics.setDefaultFilter('nearest','nearest')
  
 push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
   fullscreen = false,
   resizable = false,
   vsync = true
  })
   gamestate = 'start'
  end

 function love.keypressed(key)
    if key == 'escape' then
           love.event.quit()
    elseif key == 'enter'   or key == 'return'  then
        if gamestate == 'start' then
        gamestate = 'play'
        else 
        gamestate = 'start'
        ball:reset()
     end
  end
end

function love.draw()
    push:apply('start')
    love.graphics.setFont(nFont)
    love.graphics.printf('PONG',0,VIRTUAL_HEIGHT/5-50,VIRTUAL_WIDTH,'center')
    Player1:render()
    Player2:render()
    ball:render()
    love.graphics.setFont(n2Font)
    love.graphics.print(P1Score,VIRTUAL_WIDTH/2-70,20)
    love.graphics.print(P2Score,VIRTUAL_WIDTH/2+50,20)
    push:apply('end')
    end

 
function love.update(dt)
   if  love.keyboard.isDown('w') then
       Player1.speed = - paddle_speed
  elseif love.keyboard.isDown('s') then
    Player1.speed =  paddle_speed
  else 
     Player1.speed = 0
   end
  if  love.keyboard.isDown('up') then
       Player2.speed = - paddle_speed
  elseif love.keyboard.isDown('down') then
     Player2.speed = paddle_speed
  else 
     Player2.speed = 0 
  end
   Player1:update(dt)
   Player2:update(dt)
   
   if gamestate == 'play' then
   ball:update(dt)
   end
 end
        
 
 
