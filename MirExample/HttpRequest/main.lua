package.path = package.path .. "request\\?.lua;"

local ffi = require "ffi"
local request = require "request"

botm.tick = function()
    request.run()
end

botm.unload = function()
    request.close()
end

return request