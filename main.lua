
function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    sWidth,sHeight = love.graphics.getDimensions()
    tlo = love.graphics.newImage('graphics/tlo.png')
    kwadrat = {}
    kwadrat.imageData = love.image.newImageData('graphics/wzortest.png')
    kwadrat.img = love.graphics.newImage(kwadrat.imageData)
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

function isNodeInside(x,y, nR, nG, nB) 
    if x > kwadrat.imageData:getWidth() or x < 0 then
        return false
    end
    if y > kwadrat.imageData:getHeight() or y < 0 then
        return false
    end
    local r, g, b, a = kwadrat.imageData:getPixel(x, y)
    
    -- dotarlismy do granicy
    if r == 0 and g == 0 and b == 0 and a == 1 then
        return false
    end
    -- gdy dotarlismy do obszaru juz wypelnionego
    if math.abs(r -nR) < 0.001 and math.abs(g - nG) < 0.001 and math.abs(b - nB) < 0.001 then
        return false
    end 
    return true
end
function fill4PixelList(x,y, nR, nG, nB) 
    local nodes = {}
    local node = {x, y}
    table.insert(nodes, node)
    repeat 
        node = table.remove(nodes)
        x = node[1]
        y = node[2]
        --print(x, y)
        if isNodeInside(x, y, nR, nG, nB) then
            --print("isInside")
            kwadrat.imageData:setPixel(x, y, nR, nG, nB, 1)
            table.insert(nodes, {x+1,y})
            table.insert(nodes, {x-1,y})
            table.insert(nodes, {x,y+1})
            table.insert(nodes, {x,y-1})
            --print(table.getn)
        end
    until table.getn(nodes) == 0
end

function fill4Pixel(x,y, nR, nG, nB, kierunek)
    if x > kwadrat.imageData:getWidth() or x < 0 then
        return
    end
    if y > kwadrat.imageData:getHeight() or y < 0 then
        return
    end
    local r, g, b, a = kwadrat.imageData:getPixel(x, y)
    
    -- dotarlismy do granicy
    if r == 0 and g == 0 and b == 0 and a == 1 then
        return
    end
    -- gdy dotarlismy do obszaru juz wypelnionego
    if math.abs(r -nR) < 0.001 and math.abs(g - nG) < 0.001 and math.abs(b - nB) < 0.001 then
        return
    end 

    -- if a == 1 then
    --     return
    -- end
    
    kwadrat.imageData:setPixel(x, y, nR, nG, nB, 1)
    if kierunek ~= 1 then
        fill4Pixel(x+1, y, nR, nG, nB, 2) 
    end
        --else
    if kierunek ~= 2 then 
        fill4Pixel(x-1, y, nR, nG, nB, 1)
    end
    --end
    
    if kierunek ~= 4 then
        fill4Pixel(x, y+1, nR, nG, nB, 3)
    end

    if kierunek ~= 3 then
        fill4Pixel(x, y-1, nR, nG, nB, 4)
    end

end
function love.update(dt)
    sWidth,sHeight = love.graphics.getDimensions()
    mx,my = love.mouse.getPosition()
    if podniesiony>0 then
        opuszczony = true
    end
    check_mouse()
    if kwadrat.fill == true then
        love.graphics.setColor(1,1,1,1)
        set_color()
        kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a = love.graphics.getColor()
        --love.graphics.rectangle('fill',kwadrat.x,kwadrat.y,kwadrat.w,kwadrat.h)
        -- w prawo
        --for i=0,kwadrat.w-1 do
        --    local r, g, b, a = kwadrat.imageData:getPixel(i, my-kwadrat.y)
        --    if a == 1 then
        --        print(i,r,g,b,a)
        --    else
        --        kwadrat.imageData:setPixel(i, my-kwadrat.y,kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a)
        --    end
        
        --end
        -- w lewo
        local x = mx - kwadrat.x
        local y = my - kwadrat.y
        local stop_repeating = false
        fill4PixelList(x,y, kwadrat.color.r, kwadrat.color.g, kwadrat.color.b)
        --fill4Pixel(x-1,y,kwadrat.imageData, kwadrat.color.r, kwadrat.color.g, kwadrat.color.b, false)
        
        -- w lewo
        -- repeat
        --     local r, g, b, a = kwadrat.imageData:getPixel(x, my-kwadrat.y)
        --     if a == 1 then
        --         print(x,r,g,b,a)
        --         stop_repeating = true
        --     else
        --         kwadrat.imageData:setPixel(x, my-kwadrat.y,kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a)
        --     end
        --     x = x - 1
        --     if x < 0 or x > kwadrat.w - 1 then
        --         stop_repeating = true
        --     end
        -- until stop_repeating == true
        -- -- w prawo
        -- stop_repeating = false
        -- x = mx - kwadrat.x + 1
        -- y = my - kwadrat.y
        -- repeat
        --     local r, g, b, a = kwadrat.imageData:getPixel(x, my-kwadrat.y)
        --     if a == 1 then
        --         print(x,r,g,b,a)
        --         stop_repeating = true
        --     else
        --         kwadrat.imageData:setPixel(x, my-kwadrat.y,kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a)
        --     end
        --     x = x + 1
        --     if x < 0 or x > kwadrat.w - 1 then
        --         stop_repeating = true
        --     end
            
            
        -- until stop_repeating == true
        
        kwadrat.fill = false
    end
    kwadrat.img = love.graphics.newImage(kwadrat.imageData)
end

function love.draw()
    draw_background()
    for i=1,4 do
        if i < 3 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2-kolory[i]:getHeight()*i)
        end
        if i > 2 then
            love.graphics.draw(kolory[i],sWidth/20,sHeight/2+kolory[i]:getHeight()*(i-3))
        end
    end

    
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
    if k == 'delete' then
        kwadrat.color.r,kwadrat.color.g,kwadrat.color.b,kwadrat.color.a = 0,0,0,0 
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
function draw_background()
    love.graphics.setColor(1,1,1)
    local sx = sWidth/tlo:getWidth()
    local sy = sHeight/tlo:getHeight()
    love.graphics.draw(tlo,0,0,nil,sx,sy)
end