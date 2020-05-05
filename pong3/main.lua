push = require 'push'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 600
VIRTUAL_HEIGHT = 350
 
 function love.load()
   paddle_speed = 200
   P1Score = 0
   P2Score = 0
   P1Y = 30
   P2Y = VIRTUAL_HEIGHT-50
  nFont =  love.graphics.newFont('ARDESTINE.ttf',20)
  love.graphics.setFont(nFont)
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
    love.graphics.rectangle('fill',10,P1Y,5,30)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,P2Y,5,30)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
    love.graphics.print(P1Score,VIRTUAL_WIDTH/2-50,20)
    love.graphics.print(P2Score,VIRTUAL_WIDTH/2+50,20)
    push:apply('end')
    end

 
function love.update(dt)
 if  love.keyboard.isDown('w') then
       P1Y = P1Y - paddle_speed*dt
 elseif love.keyboard.isDown('s') then
       P1Y = P1Y + paddle_speed*dt
   end

   if love.keyboard.isDown('up') then
      P2Y = P2Y -  paddle_speed*dt
   elseif love.keyboard.isDown('down') then
        P2Y = P2Y + paddle_speed*dt
     end
  end
        
 
 
