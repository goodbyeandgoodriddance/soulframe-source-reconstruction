local v = 10
local v2 = 2.25
local v3 = 5
local total = 0
local v4 = 0
local v5 = Symbol("BestonePhysicalDmg")
local v6 = Symbol("BestoneElementalDmg")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	local level = _T.AbilityLevelQueryParms.Level
	local avatar = _T.AbilityLevelQueryParms.Avatar
	local magikForceCalc = module.magikForceCalc(avatar, level, mOwner)

	if level >= 1 then
		v = 10
		v2 = 1.2
	end

	if level >= 2 then
		v = 15
		v2 = 1.3
	end

	if level >= 3 then
		v = 20
		v2 = 1.4
	end

	if level >= 4 then
		v = 25
		v2 = 1.5
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "DAMAGE MULT",
		Value = v2,
		ValuePost = "/SF/Language/Menu/DT_SLASH"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/ABILITY_RADIUS",
		Value = 10,
		ValueUnit = "/Lotus/Language/Game/UNIT_METER"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	table.insert(abilityUpgradeLevelInfo, {
		Label = "MAX TARGETS",
		Value = v3,
		ValueUnit = "/Lotus/Language/Game/UNIT_MULTIPLIER"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

local function fn(p) -- 1 equivalent call inferred from this helper
	for _, v7 in ipairs(ignoredFactions) do
		if v7 == p then
			return true
		end
	end

	return false
end

local function fn2(__wf_atom_7be51ede, instance)
	local v7 = not (__wf_atom_7e8ad928(instance) or instance:IsKilled() or instance:__wf_atom_129d1aba(__wf_atom_7be51ede))

	if v7 then
		return not (fn(instance:__wf_atom_e93896ba()) or __wf_atom_7e8ad928(mOwner)) -- inferred equivalent call
			and not instance:HasTag(mOwner:__wf_atom_37768748())
			and instance:IsVisible()
	end

	return v7
end

local v7 = 0

function PauseImpact(object, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local position

	if __wf_atom_7e8ad928(object2) then
		if __wf_atom_7e8ad928(object) then
			object:Die()
			return
		else
			position = object:GetPosition()
		end
	else
		position = object2:__wf_atom_d0069154()
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		object:Die()
		return
	end

	local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		object:Die()
		return
	end

	mOwner = __wf_atom_e55d02aa:__wf_atom_e21e8409(abilityType)
	local __wf_atom_e8008ec5 = __wf_atom_e55d02aa:__wf_atom_e8008ec5(mOwner)
	local v8 = __wf_atom_e8008ec5 < __wf_atom_e55d02aa:__wf_atom_87a16e10()
		and __wf_atom_e55d02aa:__wf_atom_cc3c265a(__wf_atom_e8008ec5)
		or 1
	local magikForceCalc = module.magikForceCalc(__wf_atom_7be51ede, v8, mOwner)

	if v8 >= 1 then
		v = 10
		v2 = 1.2
	end

	if v8 >= 2 then
		v = 15
		v2 = 1.3
	end

	if v8 >= 3 then
		v = 20
		v2 = 1.4
	end

	if v8 >= 4 then
		v = 25
		v2 = 1.5
	end

	v *= magikForceCalc
	v2 *= magikForceCalc

	if not __wf_atom_7e8ad928(targetImpactSound) then
		gRegion:PlaySound(targetImpactSound, position, false, 0, __wf_atom_7be51ede, nil, nil, false)
	end

	local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, 10)
	table.sort(all, function(a, b)
		return __wf_atom_7be51ede:__wf_atom_9af7625d(a) < __wf_atom_7be51ede:__wf_atom_9af7625d(b)
	end)
	local v9 = Symbol("DoPause")

	for _, v10 in ipairs(all) do
		if not fn2(__wf_atom_7be51ede, v10) then
			continue
		end

		v10:__wf_atom_8a035cd5(v9, false)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.DelayCooldown = true

		if v10 == object2 then
			continue
		end

		if not __wf_atom_7e8ad928(targetImpactSound) then
			gRegion:PlaySound(targetImpactSound, v10:GetPosition(), false, 0, __wf_atom_7be51ede, nil, nil, false)
		end

		v3 -= 1

		if v3 <= 0 then
			break
		end
	end

	if v7 <= 0 and not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end
end

function DoPause(instance)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local v8 = v
	local v9 = v2

	if instance:__wf_atom_464a4772() and v8 > 5 then
		v9 = 1.2
		v8 = 5
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	instance:__wf_atom_78128d94(__wf_atom_37768748)

	if not module.ApplyBestoneFrozenSolid(instance, targetFx, stonePerceptionHint, v9) then
		return
	end

	v7 += 1
	local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
	local v10 = v9
	local v11 = false

	while v8 > 0 do
		local __wf_atom_c6f1f83d2 = instance:__wf_atom_c6f1f83d()

		if __wf_atom_c6f1f83d2 < __wf_atom_c6f1f83d then
			v11 = true
			v4 += v7
			total += 3
			v9 += 0.2
			break
		else
			if v10 < v9 then
				__wf_atom_7470861b:__wf_atom_63396172(v5)
				__wf_atom_7470861b:__wf_atom_63396172(v6)
				__wf_atom_7470861b:__wf_atom_9fba31e6(v5, 21, 6, v9)
				__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 25, 6, v9)
				v10 = v9
			end

			if not instance:IsFrozenSolid() then
				break
			end

			Sleep(0)
			v8 -= __wf_atom_084b3e93()

			if v4 > 0 then
				v8 -= total
				v4 -= 1
			end

			__wf_atom_c6f1f83d = __wf_atom_c6f1f83d2
		end
	end

	instance:RemoveTag(__wf_atom_37768748)
	module.RemoveBestoneFrozenSolid(instance, targetFx, stonePerceptionHint, v11)
	v7 -= 1

	if v7 <= 0 and not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end
end