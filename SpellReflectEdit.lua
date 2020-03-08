function(event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local tstamp, message, hideCaster, sourceGUID, srcName, srcFlags, srcRFlags, destGUID, destName, destFlags, destRFlags, _, _, _, spellId, spellName, _, _, extraSpellId, extraSpellName = ...
        --tstamp, message, hideCaster, srcGUID, srcName, srcFlags, srcRFlags, destGUID, destName, destFlags, destRFlags, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10
        --if message == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player") then

        if message == "SPELL_DAMAGE" and sourceGUID == destGUID then --CHECK IF SOMETHING IS SELF OWNED
            if next(aura_env.data["missed1st"]) then
                for k, v in pairs(aura_env.data["missed1st"]) do
                    if srcGUID == v[2]
                    and GetTime()-v[1] < 1.5
                    and (not aura_env.lastMissed or aura_env.lastMissed ~= v[1]) --for double reflects like shaman overload procs (sometimes happens)
                    then --check if missed event was before damage
                        aura_env.lastMissed = v[1]
                        local icon, name = GetSpellTexture(arg1), GetSpellInfo(arg1)-- CAN I USE GetSpellLink(spellId) ????
                        table.insert(aura_env.reflect, {srcName, name, icon, arg4, arg6}) --arg4 is amount and arg6 is school
                        --srcName, name, icon, amount, school
                    end
                end
                aura_env.flag = true
                return true
            else --damage event before missed
                local count = 1
                for unit in pairs(aura_env.data["damage1st"]) do
                    count = count + 1
                end
                aura_env.data["damage1st"][count] = aura_env.data["damage1st"][count] or {}
                aura_env.data["damage1st"][count][1] = GetTime()
                aura_env.data["damage1st"][count][2] = srcGUID
                local icon, name = GetSpellTexture(arg1), GetSpellInfo(arg1)-- CAN I USE GetSpellLink(spellId) ????
                aura_env.data["damage1st"][count][3] = {srcName, name, icon, arg4, arg6} --arg4 is amount and arg6 is school
                --srcName, name, icon, amount, school
            end

--CHECK IF YOU REFLECTED SOMETHING--
        elseif message == "SPELL_MISSED" and arg4 == "REFLECT" and (true or destGUID == WeakAuras.myGUID) then
            if next(aura_env.data["damage1st"]) then
                for k, v in pairs(aura_env.data["damage1st"]) do
                    if srcGUID == v[2]
                    and GetTime()-v[1] < 1.5
                    and (not aura_env.lastDamage or aura_env.lastDamage ~= v[1]) --for double reflects like shaman overload procs (sometimes happens)
                    then --check if damage event was before missed
                        aura_env.lastDamage = v[1]
                        table.insert(aura_env.reflect, v[3])
                    end
                end
                aura_env.flag = true
                return true
            else --missed event before damage
                local count = 1
                for unit in pairs(aura_env.data["missed1st"]) do
                    count = count + 1
                end
                aura_env.data["missed1st"][count] = aura_env.data["missed1st"][count] or {}
                aura_env.data["missed1st"][count][1] = GetTime()
                aura_env.data["missed1st"][count][2] = srcGUID
            end
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
