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
 playername = ''
 
 function love.load()
   love.graphics.setDefaultFilter('nearest','nearest')
   love.window.setTitle('Zack Kwalski (Shikhar)')
   math.randomseed(os.time())
   ball = Ball(VIRTUAL_WIDTH/2 - 2,VIRTUAL_HEIGHT/2 - 2,4,4)
   AI = Paddle(5,0,5,27)
   Player = Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT-30,5,27)
   AIScore = 0
   PlayerScore = 0
   winningPlayer =''
   servingPlayer=playername
  
  love.graphics.setFont(nFont)

  sounds = {
             ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'), 
             ['score'] = love.audio.newSource('sounds/_score.wav', 'static'),
             ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
             ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static') 
  }

  
 push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
   fullscreen = false,
   resizable = true,
   vsync = true
  })
   gamestate = 'input'
  end

  function love.resize(w,h)
    push:resize(w,h)
  end

  function love.update(dt)
   
    if gamestate == 'input' then
       servingPlayer = playername
    end
    if gamestate == 'serve' then
       ball:reset()
      ball.dy = math.random(-50, 50)
        if servingPlayer == playername then
            ball.xspeed = math.random(140, 200)
        else
            ball.xspeed = -math.random(140, 200)
        end
    end
  
   if gamestate == 'play' then 
      if math.random(1,30) ~=6 and math.random(1,30) ~= 17 then
        --if math.random(1,3) == 2 then
           -- AI.y = ball.y - AI.height/2 -6
           --else
        AI.y = ball.y - AI.height/2
         -- end
      end

     if ball:collision(AI) then
        sounds['paddle_hit']:play()
        ball.x = AI.x + 5
        ball.xspeed = - ball.xspeed*1.1
        if ball.yspeed < 0 then
                 ball.yspeed = - math.random(10,150)
        else
                 ball.yspeed = math.random(10,150)
        end
     end

     if ball:collision(Player) then
          sounds['paddle_hit']:play()
          ball.x = Player.x - 4
          ball.xspeed = -ball.xspeed*1.1
          if ball.yspeed < 0 then
                 ball.yspeed = - math.random(10,150)
        else
                 ball.yspeed = math.random(10,150)
        end
     end

     if ball.y<=0 then
         sounds['wall_hit']:play()
         ball.y = 0 
         ball.yspeed = - ball.yspeed
     end

     if ball.y >= VIRTUAL_HEIGHT-4 then
         sounds['wall_hit']:play()
         ball.y = VIRTUAL_HEIGHT - 4
         ball.yspeed = - ball.yspeed
     end
   
     if ball.x < 0 then
        sounds['score']:play()
        PlayerScore = PlayerScore + 1
        servingPlayer = playername
        if PlayerScore == 10 then
           sounds['victory']:play()
           winningPlayer = playername 
           gamestate = 'done'  
        else 
           gamestate = 'serve'
        end
      end

     if ball.x > VIRTUAL_WIDTH then
        sounds['score']:play()
        servingPlayer = 'AI'
        AIScore = AIScore + 1
        if AIScore == 10 then
          sounds['victory']:play()
          winningPlayer = 'AI'
          gamestate = 'done'
        else
          gamestate = 'serve'
        end
      end
    end
   --if  love.keyboard.isDown('w') then 
     --  Player1.speed = - paddle_speed
  --elseif love.keyboard.isDown('s') then
    --   Player1.speed =  paddle_speed
  --else 
    --   Player1.speed = 0
   --end

  if  love.keyboard.isDown('up') then
       Player.speed = - paddle_speed
  elseif love.keyboard.isDown('down') then
       Player.speed = paddle_speed
  else 
       Player.speed = 0 
  end

   if gamestate == 'play' then
       ball:update(dt)
   end

   AI:update(dt)
   Player:update(dt)
   
 end


 function love.keypressed(key)
    if key == 'escape' then
           love.event.quit()
    elseif key == 'enter'   or key == 'return'  then
        if gamestate == 'input' then
           gamestate = 'start'
        elseif gamestate == 'start' then
               gamestate = 'serve'
        elseif  gamestate == 'serve' then
                gamestate = 'play'  
        elseif gamestate == 'done' then
               ball:reset()
               gamestate = 'serve'   
               AIScore = 0
               PlayerScore = 0
               if winningPlayer == playername then
                 servingPlayer = 'AI'
               else 
                 servingPlayer = playername
               end
        end
      else
        if gamestate == 'input' then
          if ((key) >= 'A' and (key)<='Z' ) or ((key)>='a' and (key)<='z') then
            playername = playername ..  key
          end
       end
     end
  end

function love.draw()
   
    push:apply('start')
    love.graphics.clear(255/255, 165/255, 0/255, 255/255)
    love.graphics.setFont(nFont)
    if gamestate == 'start' then
      love.graphics.printf('Welcome ' .. playername,0,0,VIRTUAL_WIDTH,'center')
      love.graphics.printf('Press Enter to Begin',0,10,VIRTUAL_WIDTH,'center') 
    elseif gamestate == 'serve' then
      love.graphics.printf(playername .. "'s Score ",50,10,VIRTUAL_WIDTH,'center')
      love.graphics.printf( "AI's Score ",-50,10,VIRTUAL_WIDTH,'center')
      love.graphics.printf(servingPlayer.. "'s Serve",0,0,VIRTUAL_WIDTH,'center')
    elseif gamestate == 'input' then
      love.graphics.setFont(nFont)
      love.graphics.printf("Enter your name to start",0,0,VIRTUAL_WIDTH,'center')
      love.graphics.setFont(n2Font)
      love.graphics.printf(playername,0,50,VIRTUAL_WIDTH,'center')
    elseif gamestate == 'play' then
      love.graphics.printf(playername .. "'s Score ",50,0,VIRTUAL_WIDTH,'center')
      love.graphics.printf( "AI's Score ",-50,0,VIRTUAL_WIDTH,'center')
    elseif gamestate == 'done' then
      love.graphics.setFont(n2Font)
      love.graphics.printf('Press Enter to restart',0,50,VIRTUAL_WIDTH,'center')
      love.graphics.printf(winningPlayer .. ' Wins',0,0,VIRTUAL_WIDTH,'center')      
    end
    AI:render()
    Player:render()
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
    love.graphics.printf(AIScore .. '     ' .. PlayerScore,0,20,VIRTUAL_WIDTH,'center')
end
 

        
 
 
