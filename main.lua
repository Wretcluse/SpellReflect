function(event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, message, _, sourceGUID, srcName, _, _, _, destName, _, _, _, _, _, spellId, spellName, _, _, extraSpellId, extraSpellName = ...
        if message == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player") then
            aura_env.target = destName
            aura_env.spell = GetSpellLink(spellId)
            aura_env.output = "interrupted " .. aura_env.target .. "'s " .. aura_env.spell .. "!"
            return true
        end
    end
end