local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local v = 50
local v2 = 8

local function fn(p, p2, object)
	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v4 = not module.UpgradeMatchesSlotPolarity(object) and 1 or module.totemForceCalc(p2, p, object)

	if v3 == 0 then
		if p == 1 then
			v = 50
			v2 = 8
		elseif p == 2 then
			v = 75
			v2 = 10
		elseif p == 3 then
			v = 100
			v2 = 12
		else
			v = 125
			v2 = 15
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 50
			v2 = 8
		elseif p == 2 then
			v = 100
			v2 = 10
		elseif p == 3 then
			v = 125
			v2 = 12
		else
			v = 150
			v2 = 15
		end
	elseif p == 1 then
		v = 50
		v2 = 8
	elseif p == 2 then
		v = 125
		v2 = 10
	elseif p == 3 then
		v = 175
		v2 = 12
	else
		v = 250
		v2 = 15
	end

	v *= v4
	v2 *= v4
end

local function fn2(object, object2, p)
	if not __wf_atom_7e8ad928(avatarAttachFxType) then
		object2:Attach(avatarAttachFxType, Symbol("GAME_C1_SPINE5"), Vector(0, 1, 0), __wf_atom_80368bb1)
	end

	local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

	if __wf_atom_c6f1f83d < object:GetMaxHealth() then
		object:Heal(object, p, object2)
		object:NotifyHeal(object2:__wf_atom_a96eb2aa(), p, 0, 1)
		module.NotifyHeal(object2, object:__wf_atom_c6f1f83d() - __wf_atom_c6f1f83d)

		if __wf_atom_7e8ad928((object:__wf_atom_bb3e7833(targetAvatarAttachFxType))) then
			object:Attach(targetAvatarAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(targetAvatarAttachFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function OnUpgradeApplied(object, p, p2, _, object2)
	if __wf_atom_7e8ad928((object2:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p2, object, object2)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, v2)
	local count = 0

	for _, v3 in ipairs(all) do
		if gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v3:__wf_atom_e93896ba()) then
			count += 1
		end
	end

	local v3 = v / count

	for _, v4 in ipairs(all) do
		if __wf_atom_7e8ad928(v4) or not gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v4:__wf_atom_e93896ba()) then
			continue
		end

		fn2(v4, object, v3)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v3 = { BONUS = module2.FormatNumber(v, 0), RANGE = module2.FormatNumber(v2, 0) }
	return cjson.encode(v3)
end