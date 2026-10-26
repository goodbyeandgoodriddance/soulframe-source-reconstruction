local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local v = 1
local v2 = Symbol("TotemDamageIncrease")
local v3 = 5

local function fn(p, p2, object)
	local v4 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v5 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v4 == 0 then
		if p == 1 then
			v = 1.05
		elseif p == 2 then
			v = 1.15
		elseif p == 3 then
			v = 1.2
		else
			v = 1.25
		end
	elseif v4 == 1 then
		if p == 1 then
			v = 1.1
		elseif p == 2 then
			v = 1.2
		elseif p == 3 then
			v = 1.25
		else
			v = 1.35
		end
	elseif p == 1 then
		v = 1.1
	elseif p == 2 then
		v = 1.2
	elseif p == 3 then
		v = 1.3
	else
		v = 1.5
	end

	v *= v5
end

local function fn2(lastSoulRevealTargetAvatar, _)
	if lastSoulRevealTargetAvatar:__wf_atom_464a4772() then
		v -= 1
		v /= 2
		v += 1
	end

	local __wf_atom_7470861b = lastSoulRevealTargetAvatar:__wf_atom_7470861b()
	__wf_atom_7470861b:__wf_atom_9fba31e6(v2, v3, 6, v)

	if __wf_atom_7e8ad928((lastSoulRevealTargetAvatar:__wf_atom_bb3e7833(avatarAttachFxType))) then
		lastSoulRevealTargetAvatar:Attach(avatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local __wf_atom_bb3e7833 = lastSoulRevealTargetAvatar:__wf_atom_bb3e7833(SSEType)

	while not (__wf_atom_7e8ad928(__wf_atom_bb3e7833) or __wf_atom_7e8ad928(lastSoulRevealTargetAvatar)) do
		__wf_atom_bb3e7833 = lastSoulRevealTargetAvatar:__wf_atom_bb3e7833(SSEType)
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(lastSoulRevealTargetAvatar) or __wf_atom_7e8ad928(__wf_atom_7470861b)) then
		__wf_atom_7470861b:__wf_atom_63396172(v2)
		local __wf_atom_bb3e7833_2 = lastSoulRevealTargetAvatar:__wf_atom_bb3e7833(avatarAttachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:Destroy()
		end
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	Sleep(0)

	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local lastSoulRevealTargetAvatar = object:__wf_atom_e919fb8e().lastSoulRevealTargetAvatar

	if __wf_atom_7e8ad928(lastSoulRevealTargetAvatar) or lastSoulRevealTargetAvatar:__wf_atom_129d1aba(object) then
		return
	end

	fn(p2, object, object2)

	if useArcDmg then
		v3 = 13
	end

	fn2(lastSoulRevealTargetAvatar, object)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v4 = {
		BONUS = module2.FormatNumber((v - 1) * 100, 0)
	}
	return cjson.encode(v4)
end