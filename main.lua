function love.load()
    sWidth,sHeight = love.graphics.getDimensions()
    kwadrat = {}
    kwadrat.img = love.graphics.newImage('graphics/kwadrat.png')
    kwadrat.w = kwadrat.img:getWidth()
    kwadrat.h = kwadrat.img:getHeight()
    kwadrat.x = sWidth/2-kwadrat.w/2
    kwadrat.y = sHeight/2-kwadrat.h/2
    kwadrat.fill = false
    kwadrat.color = {}
    kolory = {love.graphics.newImage('graphics/kolor_czerwony.png'),
    love.graphics.newImage('graphics/kolor_niebieski.png'),
    love.graphics.newImage('graphics/kolor_zielony.png'),
    love.graphics.newImage('graphics/kolor_zolty.png')}
    podniesiony = 0  
    color = 0   -- 1=blue 2=red 3=green 4=yellow
    opuszczony = false
end

function love.update(dt)
    sWidth,sHeight = love.graphics.getDimensions()
    mx,my = love.mouse.getPosition()
    if podniesiony>0 then
        opuszczony = true
    end
    check_mouse()
end

function love.draw()
    love.graphics.setBackgroundColor(1,1,1)
    print(mx > kwadrat.x and mx < kwadrat.x + kwadrat.w and my > kwadrat.y and my < kwadrat.y + kwadrat.h)
    love.graphics.setColor(1,1,1)
    for i=1,4 do
        if i < 3 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2-kolory[i]:getHeight()*i)
        end
        if i > 2 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2+kolory[i]:getHeight()*(i-3))
        end
    end
    if kwadrat.fill == true then
        love.graphics.setColor(kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a)
        love.graphics.rectangle('fill',kwadrat.x,kwadrat.y,kwadrat.w,kwadrat.h)
       
    end
    love.graphics.setColor(0,0,0)
    love.graphics.draw(kwadrat.img,kwadrat.x,kwadrat.y)
    set_color()
    if podniesiony > 0 then
        love.graphics.circle('fill',love.mouse.getX(),love.mouse.getY(),20)   
    end
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end
function set_color()
    if color == 1 then
        love.graphics.setColor(95/255,205/255,228/255)
    elseif color == 2 then
        love.graphics.setColor(220/255,54/255,69/255)
    elseif color == 3 then
        love.graphics.setColor(153/255,229/255,80/255)
    elseif color == 4 then
        love.graphics.setColor(251/255,242/255,54/255)
    end
end
function check_mouse()
    if love.mouse.isDown(1) then
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
            color = podniesiony
        end
    else
        if color > 0 then
            if opuszczony == true then
                if mx > kwadrat.x and mx < kwadrat.x + kwadrat.w and my > kwadrat.y and my < kwadrat.y + kwadrat.h then  
                    set_color()
                    kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a = love.graphics.getColor()  
                    kwadrat.fill = true
                end
                opuszczony = false
            end 
        end
        podniesiony = 0
    end
end