fill = {}
function fill.isInside(x,y, nR, nG, nB)
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
function fill.fill4PixelList(x,y, nR, nG, nB) 
    local nodes = {}
    local node = {x, y}
    table.insert(nodes, node)
    repeat 
        node = table.remove(nodes)
        x = node[1]
        y = node[2]
        --print(x, y)
        if fill.isInside(x, y, nR, nG, nB) then
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
function fill.scanFill(x,y,nR,nG,nB)
    if not fill.isInside(x,y,nR,nG,nR)then
    end
end
return fill