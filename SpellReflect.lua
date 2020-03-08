function(event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local tstamp, message, hideCaster, sourceGUID, srcName, srcFlags, srcRFlags, destGUID, destName, destFlags, destRFlags, _, _, _, spellId, spellName, _, _, extraSpellId, extraSpellName = ...
        --tstamp, message, hideCaster, srcGUID, srcName, srcFlags, srcRFlags, destGUID, destName, destFlags, destRFlags, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10
        --if message == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player") then

        if message == "SPELL_DAMAGE" and sourceGUID == destGUID then --CHECK IF SOMETHING IS SELF OWNED

--CHECK IF YOU REFLECTED SOMETHING--
        elseif message == "SPELL_MISSED" and arg4 == "REFLECT" and (aura_env.config.showAll and true or destGUID == WeakAuras.myGUID) then

            aura_env.target = destName
            aura_env.spell = GetSpellLink(spellId)
            aura_env.output = "reflected " .. aura_env.target .. "'s " .. aura_env.spell .. "for " .. aura_env.count .. "damage!"
            return true
        end
    end
end


--[[ 
REFLECT event Arguments:
spellid = arg1
spellName = arg2
spellSchool = arg3
amount = arg4
overkill = arg5
school = arg6
resisted = arg7
blocked = arg8
absorbed = arg9
critical = arg10
]]--
