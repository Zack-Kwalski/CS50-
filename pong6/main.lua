push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'
require 'conf'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

 nFont =  love.graphics.newFont('ARDESTINE.ttf',10)
 n2Font = love.graphics.newFont('ARDESTINE.ttf',20)
 
 function love.load()
   love.window.setTitle('GAME')
   math.randomseed(os.time())
   ball = Ball(VIRTUAL_WIDTH/2 - 2,VIRTUAL_HEIGHT/2 - 2,4,4)
   Player1 = Paddle(5,0,5,30)
   Player2 = Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-30,5,30)
   P1Score = 0
   P2Score = 0
   paddle_speed = 200
  
  love.graphics.setFont(nFont)
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
    love.graphics.printf('PONG',0,2,VIRTUAL_WIDTH,'center')
    Player1:render()
    Player2:render()
    ball:render()
    love.graphics.setFont(n2Font)
    love.graphics.print(P1Score,VIRTUAL_WIDTH/2-18,15)
    love.graphics.print(P2Score,VIRTUAL_WIDTH/2+3,15)
    push:apply('end')
    end

 
function love.update(dt)
  
   Player1:update(dt)
   Player2:update(dt)
   
   if gamestate == 'play' then
       ball:update(dt)
   end
 
  

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

 end


function displayFPS()
   love.graphics.setFont(n2Font)
    love.graphics.setColor(0, 255, 0, 255)
    fps = love.timer.getFPS()
    love.graphics.print('FPS: ' .. tostring(fps),10,10)
 end

 

        
 
 
