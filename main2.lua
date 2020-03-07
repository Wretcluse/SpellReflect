function()
    if aura_env.flag then --prevent iterating everyframe (trigger update might not fire, not sure)
        aura_env.flag = false
        aura_env.output = ""
        for i=1, #aura_env.reflect do
            --srcName, name, icon, amount, school, critical
            local target = aura_env.destName and aura_env.reflect[i][1] or ""
            local spell = GetSpellLink(spellId)
            local amount = aura_env.ShortenNumber(aura_env.reflect[i][4])
           
           
           
            aura_env.output = "reflected "..target.."'s "..spell.. "for "..amount.." damage!"
        end
    end
    return aura_env.output
end
