local v = 0.2
local v2 = 8
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, p2, object)
	local v3 = __wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107(object:__wf_atom_f298d802())
	local v4 = not module2.UpgradeMatchesSlotPolarity(object) and 1 or module2.totemForceCalc(p2, p, object)

	if v3 == 0 then
		if p == 1 then
			v = 0.1
			v2 = 5
		elseif p == 2 then
			v = 0.12
			v2 = 5.5
		elseif p == 3 then
			v = 0.17
			v2 = 6
		else
			v = 0.2
			v2 = 6.5
		end
	elseif v3 == 1 then
		if p == 1 then
			v = 0.125
			v2 = 5
		elseif p == 2 then
			v = 0.15
			v2 = 6
		elseif p == 3 then
			v = 0.2
			v2 = 7
		else
			v = 0.225
			v2 = 8
		end
	elseif p == 1 then
		v = 0.15
		v2 = 6
	elseif p == 2 then
		v = 0.17
		v2 = 8
	elseif p == 3 then
		v = 0.2
		v2 = 10
	else
		v = 0.25
		v2 = 12
	end

	v *= v4
	v2 *= v4
end

local function fn2(object, object2, object3)
	if __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(object3) then
		return
	end

	local __wf_atom_ae118ae6 = object3:__wf_atom_010c2f81(0):__wf_atom_ae118ae6()
	local damageData = Engine.DamageData()
	damageData.baseAmount = 1
	damageData.criticalChance = __wf_atom_ae118ae6
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_6b472125(object2)
	damageData:__wf_atom_34a8a27a(object2)
	object:__wf_atom_649bf33e(damageData)
end

function OnUpgradeApplied(object, object2, p, _, object3)
	if __wf_atom_7e8ad928((object3:__wf_atom_60ba1637())) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	fn(p, object, object3)
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_C1_SPINE5"))
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_1c374cc9, 0, v2)
	local __wf_atom_ae118ae6 = object2:__wf_atom_010c2f81(0):__wf_atom_ae118ae6()
	v *= __wf_atom_ae118ae6
	local v3 = {}

	for _, v4 in pairs(all) do
		if
			__wf_atom_7e8ad928(v4)
			or v4:IsKilled()
			or gGameRules:__wf_atom_8c3af1a5(__wf_atom_e93896ba, v4:__wf_atom_e93896ba())
		then
			continue
		end

		table.insert(v3, v4)
	end

	if #v3 > 0 and math.random() < v then
		fn2(v3[math.random(1, #v3)], object, object2)
	end

	if not __wf_atom_7e8ad928(burstFxType) then
		gRegion:CreateEntity(burstFxType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object)
	end

	if not __wf_atom_7e8ad928(burstSound) then
		object:PlaySound(burstSound, false, 1, false)
	end

	local entity = gRegion:CreateEntity(burstDecoType, object:__wf_atom_d0069154(), __wf_atom_80368bb1, object)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(v2)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, gRegion:__wf_atom_c4f78a8f(), p2)
	local v3 = {
		["1_IN_X"] = module.FormatNumber(1 / v, 0),
		BONUS = module.FormatNumber(v2, 0),
		RANGE = module.FormatNumber(v2, 0)
	}
	return cjson.encode(v3)
end