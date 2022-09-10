function love.load()
    kwadrat = love.graphics.newImage('graphics/kwadrat.png')
    sWidth,sHeight = love.graphics.getDimensions()
    kolory = {love.graphics.newImage('graphics/kolor_czerwony.png'),
    love.graphics.newImage('graphics/kolor_niebieski.png'),
    love.graphics.newImage('graphics/kolor_zielony.png'),
    love.graphics.newImage('graphics/kolor_zolty.png')}
    podniesiony = 0  -- 1=blue 2=red 3=green 4=yellow
end

function love.update(dt)
    sWidth,sHeight = love.graphics.getDimensions()
    if love.mouse.isDown(1) then
        local mx,my = love.mouse.getPosition()
        if mx < sWidth/20 + kolory[1]:getWidth() and mx > sWidth/20 then
            if my > sHeight/2-kolory[1]:getHeight()*2 and my < sHeight/2-kolory[1]:getHeight()*1 then
                podniesiony = 1
            elseif my > sHeight/2-kolory[1]:getHeight()*1 and my < sHeight/2 then
                podniesiony = 2
            elseif my > sHeight/2 and my < sHeight/2+kolory[1]:getHeight()*1 then
                podniesiony = 3
            elseif my > sHeight/2+kolory[1]:getHeight()*1 and my < sHeight/2+kolory[1]:getHeight()*2 then
                podniesiony = 4
            end
        end
    else
        podniesiony = 0
    end
end

function love.draw()
    for i=1,4 do
        if i < 3 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2-kolory[i]:getHeight()*i)
        end
        if i > 2 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2+kolory[i]:getHeight()*(i-3))
        end
    end
    love.graphics.draw(kwadrat,sWidth/2-kwadrat:getWidth()/2,sHeight/2-kwadrat:getWidth()/2)
    if podniesiony == 1 then
        love.graphics.setColor(95/255,205/255,228/255)
    elseif podniesiony == 2 then
        love.graphics.setColor(271/255,87/255,99/255)
    elseif podniesiony == 3 then
        love.graphics.setColor(153/255,229/255,80/255)
    elseif podniesiony == 4 then
        love.graphics.setColor(251/255,242/255,54/255)
    end
    if podniesiony > 0 then
        love.graphics.circle('fill',love.mouse.getX(),love.mouse.getY(),20)   
    end
    love.graphics.setColor(1,1,1)
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end