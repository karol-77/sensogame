function love.load()
    kwadrat = love.graphics.newImage('graphics/kwadrat.png')
    sWidth,sHeight = love.graphics.getDimensions()
    kolory = {love.graphics.newImage('graphics/kolor_czerwony.png'),
    love.graphics.newImage('graphics/kolor_niebieski.png'),
    love.graphics.newImage('graphics/kolor_zielony.png'),
    love.graphics.newImage('graphics/kolor_zolty.png')}
end

function love.update(dt)
    sWidth,sHeight = love.graphics.getDimensions()
end

function love.draw()
    love.graphics.draw(kwadrat,sWidth/2-kwadrat:getWidth()/2,sHeight/2-kwadrat:getWidth()/2)
    for i=1,4 do
        if i < 3 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2-kolory[i]:getHeight()*i)
        end
        if i > 2 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2+kolory[1]:getHeight()*(i-3))
        end
    end
    
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(b,x,y)

end