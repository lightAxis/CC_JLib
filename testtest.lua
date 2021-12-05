local th1 = function()
    local x = 1
    for i = 1, 100000000, 1 do
        x = x + 1
        if (x == 50000000) then coroutine.yield(x) end
    end
end

c1 = coroutine.create(th1)

local y = 1

for i = 1, 100000000, 1 do
    y = y + 1
    if (y == 50000000) then print("sdfdf") end
end
local x, y = coroutine.resume(c1)
print(x, y)
