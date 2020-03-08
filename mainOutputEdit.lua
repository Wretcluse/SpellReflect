function()
    if aura_env.flag then --prevent iterating everyframe (trigger update might not fire, not sure)
        aura_env.flag = false
        aura_env.output = ""
        for i = 1, #aura_env.reflect do
            --srcName, name, spellName, amount
            local target = aura_env.config.target and aura_env.reflect[i][1] or ""
            local spellName = GetSpellLink(spellId) and aura_env.reflect[i][2] or ""
            local amount = aura_env.ShortenNumber(aura_env.reflect[i][3]) or ""

            aura_env.output = aura_env.output..target..spellName..amount
        end
    end
    return aura_env.output
end
