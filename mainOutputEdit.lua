function()
        if aura_env.flag then --prevent iterating everyframe (trigger update might not fire, not sure)
            aura_env.flag = false
            aura_env.output = ""
            for i=1, #aura_env.reflect do
                --srcName, name, icon, amount, school, critical
                local target = aura_env.config.target and aura_env.reflect[i][1] or ""
                local spellName = aura_env.config.spellName and " |cFFbbbbbb["..aura_env.reflect[i][2].."]|r" or ""
                local icon = aura_env.config.icon and "|T"..aura_env.reflect[i][3]..":0|t" or ""
                local amount = aura_env.ShortenNumber(aura_env.reflect[i][4])


    if aura_env.output then
        return aura_env.output
    end
end
