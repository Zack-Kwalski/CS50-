push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
paddle_speed = 200


 nFont =  love.graphics.newFont('font.ttf',10)
 n2Font = love.graphics.newFont('font.ttf',20)
 largeFont = love.graphics.newFont('font.ttf',35)
 playername = ''
 servingPlayer = 1
 
 function love.load()
   love.graphics.setDefaultFilter('nearest','nearest')
   love.window.setTitle('Zack Kwalski (Shikhar)')
   math.randomseed(os.time())
   ball = Ball(VIRTUAL_WIDTH/2 - 2,VIRTUAL_HEIGHT/2 - 2,4,4)
   Player1 = Paddle(5,0,5,30)
   Player2 = Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-30,5,30)
   P1Score = 0
   P2Score = 0
  
   
  love.graphics.setFont(nFont)

  
 push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
   fullscreen = false,
   resizable = false,
   vsync = true
  })
   gamestate = 'start'
  end

  function love.update(dt)

    if gamestate == 'serve' then
      ball.yspeed = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.xspeed = math.random(140, 200)
        else
            ball.xspeed = -math.random(140, 200)
        end
  
   elseif gamestate == 'play' then 

     if ball:collision(Player1) then
        ball.x = Player1.x + 5
        ball.xspeed = - ball.xspeed*1.1
        if ball.yspeed < 0 then
                 ball.yspeed = - math.random(10,150)
        else
                 ball.yspeed = math.random(10,150)
        end
     end

     if ball:collision(Player2) then
          ball.x = Player2.x - 4
          ball.xspeed = -ball.xspeed*1.1
          if ball.yspeed < 0 then
                 ball.yspeed = - math.random(10,150)
        else
                 ball.yspeed = math.random(10,150)
        end
     end

     if ball.y<=0 then
         ball.y = 0 
         ball.yspeed = - ball.yspeed
     end

     if ball.y >= VIRTUAL_HEIGHT-4 then
         ball.y = VIRTUAL_HEIGHT - 4
         ball.yspeed = - ball.yspeed
     end
   if ball.x < 0 then
        P2Score = P2Score + 1
         
        if P2Score >= 2 then
           winningplayer = 2
           gamestate = 'done'
        else
           ball:reset()
           gamestate = 'serve'
           servingPlayer = 1
        end
    end

    if ball.x > VIRTUAL_WIDTH then
      P1Score = P1Score + 1
      
      if P1Score >= 2 then 
         winningplayer = 1
         gamestate = 'done'
      else
        ball:reset()
        gamestate = 'serve'
        servingPlayer = 2
      end
    end
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

   if gamestate == 'play' then
       ball:update(dt)
   end

   Player1:update(dt)
   Player2:update(dt)
   
 end


 function love.keypressed(key)
    if key == 'escape' then
           love.event.quit()
    elseif key == 'enter'   or key == 'return'  then
        if gamestate == 'start' then
             gamestate = 'serve'
        elseif  gamestate == 'serve' then
             gamestate = 'play'  
        elseif gamestate == 'done' then
              ball:reset()
              gamestate = 'serve'
              P1Score = 0
              P2Score = 0 
              if winningplayer == 1 then
                 servingPlayer = 2
              else
                servingPlayer = 1
              end
        end
     --else
        --if count == 0 and string.byte(key)==65 then--and string.byte(key)<=90) or (string.byte(key)>=97 and string.byte(key)<=122)) then
        --playername = playername ..  tostring(key)
        --end
     end
  end

function love.draw()
   
    push:apply('start')
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    love.graphics.setFont(nFont)
    if gamestate == 'serve' then
        love.graphics.printf("Player" .. tostring(servingPlayer) .. "'s serve",0,0,VIRTUAL_WIDTH,'center')
      love.graphics.printf("Press Enter to start",0,VIRTUAL_HEIGHT/24.3,VIRTUAL_WIDTH,'center')
      
    elseif gamestate == 'start' then
      love.graphics.setFont(nFont)
      love.graphics.printf("Welcome to Pong",0,0,VIRTUAL_WIDTH,'center')
      love.graphics.printf("Press Enter to begin",0,VIRTUAL_HEIGHT/24.3,VIRTUAL_WIDTH,'center')
    elseif gamestate == 'done' then
      love.graphics.setFont(largeFont)
      love.graphics.printf("Player ".. winningplayer .. "  wins",0,0,VIRTUAL_WIDTH,'center')
      love.graphics.printf('Press enter to restart',0,70,VIRTUAL_WIDTH,'center')
    end
    Player1:render()
    Player2:render()
    ball:render()
    displayScore()
    displayFPS()
    push:apply('end')
  end

 

function displayFPS()
    love.graphics.setFont(nFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()),10,10)
end

function displayScore()
    love.graphics.setFont(n2Font)
    love.graphics.print(P1Score,VIRTUAL_WIDTH/2-18,50)
    love.graphics.print(P2Score,VIRTUAL_WIDTH/2+3,50)
end
 

        
 
 
