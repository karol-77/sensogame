function love.load()
    kwadrat = love.graphics.newImage('graphics/kwadrat.png')
    sWidth,sHeight = love.graphics.getDimensions()
end

function love.update(dt)
    sWidth,sHeight = love.graphics.getDimensions()
end

function love.draw()
    love.graphics.draw(kwadrat,sWidth/2-kwadrat:getWidth()/2,sHeight/2-kwadrat:getWidth()/2)
    
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end