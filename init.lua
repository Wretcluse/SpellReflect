aura_env.data = {
    ["damage1st"] = {
    },
    ["missed1st"] = {
    },
}

aura_env.reflect = {}

aura_env.ShortenNumber = function(value)
    if not value then return end
    if(value > 999999999) then return string.format("%.2f", value/1000000000) .. "B" end           
    if(value > 999999) then return string.format("%.2f", value/1000000) .. "M" end      
    if(value > 99999) then return string.format("%.f", value/1000) .. "K" end 
    if(value > 999) then return string.format("%.1f", value/1000) .. "K" end         
    return value
end

local aura_env = aura_env
if not aura_env.region.hook then
    hooksecurefunc(WeakAuras, "OpenOptions", function()
            aura_env.data = {
                ["damage1st"] = {
                },
                ["missed1st"] = {
                },
            }
            
            aura_env.reflect = {}
    end)
end
aura_env.region.hook = true

