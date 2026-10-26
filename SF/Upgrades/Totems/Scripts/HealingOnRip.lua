local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local v = 50

local function fn(p, p2, object)
	local v2 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v3 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v2 == 0 then
		if p == 1 then
			v = 50
		elseif p == 2 then
			v = 125
		elseif p == 3 then
			v = 175
		else
			v = 200
		end
	elseif v2 == 1 then
		if p == 1 then
			v = 75
		elseif p == 2 then
			v = 100
		elseif p == 3 then
			v = 175
		else
			v = 250
		end
	elseif p == 1 then
		v = 50
	elseif p == 2 then
		v = 150
	elseif p == 3 then
		v = 250
	else
		v = 300
	end

	v *= v3
end

local function fn2(object, object2, p)
	local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

	if __wf_atom_c6f1f83d < object:GetMaxHealth() then
		object:Heal(object, p, object2)
		object:NotifyHeal(object2:__wf_atom_a96eb2aa(), p, 0, 1)

		if not __wf_atom_7e8ad928(healSound) then
			object:PlaySound(healSound, false, 1, false)
		end

		module.NotifyHeal(object2, object:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)

		if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(avatarAttachFxType))) then
			object:Attach(avatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(avatarAttachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function OnUpgradeApplied(p, p2, p3, _, object)
	if __wf_atom_7e8ad928((object:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p2) then
		return
	end

	fn(p3, p, object)
	fn2(p, p, v)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v2 = { BONUS = module2.FormatNumber(v, 0) }
	return cjson.encode(v2)
end