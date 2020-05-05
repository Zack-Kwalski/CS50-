push = require 'push'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 600
VIRTUAL_HEIGHT = 350
 
 function love.load()
   math.randomseed(os.time())
   ball_x_speed = math.random(3)==1 and 100 or -100
   ball_y_speed = math.random(-50,50)
   paddle_speed = 200
   P1Score = 0
   P2Score = 0
   P1Y = 30
   P2Y = VIRTUAL_HEIGHT-50
   ball_x = VIRTUAL_WIDTH/2-2
   ball_y = VIRTUAL_HEIGHT/2-2
 
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
        ball_x = VIRTUAL_WIDTH/2-2
        ball_y = VIRTUAL_HEIGHT/2-2
        ball_x_speed = math.random(3)==1 and 100 or -100
        ball_y_speed = math.random(-50,50)
     end
  end
end

function love.draw()
    push:apply('start')
    love.graphics.setFont(nFont)
    love.graphics.printf('PONG',0,VIRTUAL_HEIGHT/5-50,VIRTUAL_WIDTH,'center')
    love.graphics.rectangle('fill',10,P1Y,5,30)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH-10,P2Y,5,30)
    love.graphics.rectangle('fill',ball_x,ball_y,4,4)
    love.graphics.setFont(n2Font)
    love.graphics.print(P1Score,VIRTUAL_WIDTH/2-70,20)
    love.graphics.print(P2Score,VIRTUAL_WIDTH/2+50,20)
    push:apply('end')
    end

 
function love.update(dt)
  if  love.keyboard.isDown('w') then
       P1Y = math.max(0,P1Y - paddle_speed*dt)
 elseif love.keyboard.isDown('s') then
       P1Y = math.min(VIRTUAL_HEIGHT - 30,P1Y + paddle_speed*dt)
   end

   if love.keyboard.isDown('up') then
      P2Y = math.max(0,P2Y -  paddle_speed*dt)
   elseif love.keyboard.isDown('down') then
        P2Y = math.min(VIRTUAL_HEIGHT - 30,P2Y + paddle_speed*dt)
     end
   
   if gamestate == 'play' then
   ball_x = ball_x + ball_x_speed*dt
   ball_y = ball_y + ball_y_speed*dt
   end
 end
        
 
 
