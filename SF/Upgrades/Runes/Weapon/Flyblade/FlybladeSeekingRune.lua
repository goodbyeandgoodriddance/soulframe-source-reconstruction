local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 0.2
local v2 = Symbol("FlybladeSeekingRune")
local v3 = 3

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, p)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.6
		elseif p == 2 then
			v = 0.8
		elseif p == 3 then
			v = 1
		else
			v = 1.2
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_3371f607)) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
				activeFxType,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
			end
		end

		local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
				activeFxType,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189_2, EMPTY_SYMBOL)
			end
		end
	end

	local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(1)

	if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
		__wf_atom_3d08948b:__wf_atom_9a37af87(5, 0)
		__wf_atom_3d08948b:__wf_atom_9a37af87(6, 1)
		__wf_atom_3d08948b:__wf_atom_9a37af87(7, 0)
		__wf_atom_3d08948b:__wf_atom_9a37af87(8, 1)
		__wf_atom_3d08948b:__wf_atom_51d978c0(false)
		__wf_atom_3d08948b:__wf_atom_ff0c7f12(false, v3, 0.5)
		__wf_atom_3d08948b:__wf_atom_ff0c7f12(true, v3, 0.5)
	end

	__wf_atom_3371f607:__wf_atom_36d7c7d8()
	__wf_atom_3371f607:__wf_atom_3bb2e7ee(true)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneDamageMulti = runeDamageBuff
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneBuffAttackSFX = buffAttackSFX
	local runeActivationCost = module3.GetRuneActivationCost()
	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)
	Sleep(0)
	local v4 = false

	while
		not __wf_atom_7e8ad928(object2)
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and __wf_atom_3371f607:__wf_atom_9f71ab59()
		and not v4
	do
		if __wf_atom_3371f607:__wf_atom_160ce839() then
			v4 = true

			if gRegion:IsMaster() then
				local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
				object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
			end

			module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
		end

		Sleep(0)
	end

	Sleep(0.1)
end

local function fn(object)
	object:__wf_atom_3bb2e7ee(false)
	local __wf_atom_3d08948b = object:__wf_atom_3d08948b(1)

	if not __wf_atom_7e8ad928(__wf_atom_3d08948b) and __wf_atom_3d08948b:IsA(__wf_atom_4f8effca) then
		__wf_atom_3d08948b:__wf_atom_1f5f2e79()
		__wf_atom_3d08948b:__wf_atom_51d978c0(true)
		__wf_atom_3d08948b:__wf_atom_6d658747()
	end
end

function DeactivateAbility(_, object, _, _)
	mOwner:__wf_atom_34c9b8f6(0)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
		fn(__wf_atom_3371f607)

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
			local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

			if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneActive = nil
			end
		end
	end
end

function OnNewProjectile(object, object2)
	if object2:__wf_atom_1c9b5d2a() == object:__wf_atom_6271f57d() then
		local __wf_atom_7be51ede = object2:__wf_atom_7be51ede()

		if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
			object2:Die()
			return
		end

		local __wf_atom_b6645301 = object:__wf_atom_3d08948b(1):__wf_atom_b6645301()

		if __wf_atom_7e8ad928(__wf_atom_b6645301) then
			object2:Die()
			return
		end

		object2:__wf_atom_3b3c58ec(__wf_atom_b6645301)
		local __wf_atom_0395f752 = object:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = __wf_atom_7be51ede:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneDamageMulti) then
				object2:__wf_atom_9fba31e6(2, __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneDamageMulti)
			end

			local flybladeSeekRuneLastHitCharge = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneLastHitCharge

			if not __wf_atom_7e8ad928(flybladeSeekRuneLastHitCharge) and flybladeSeekRuneLastHitCharge >= 1 then
				object2:__wf_atom_9fba31e6(v3, 0.5)
				object2:__wf_atom_746d4173(v3, 0.5)
			end
		end

		local upgradedValue = Engine.UpgradedValue(0)
		upgradedValue:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue)
	else
		local __wf_atom_7be51ede = object2:__wf_atom_7be51ede()

		if not __wf_atom_7e8ad928(__wf_atom_7be51ede) then
			local __wf_atom_e919fb8e = __wf_atom_7be51ede:__wf_atom_e919fb8e()
			local __wf_atom_0395f752 = object:__wf_atom_0395f752()

			if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].FlybladeSeekRuneActive)) then
				local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.FlybladeSeekingRuneBuffed = true
				local upgradedValue = Engine.UpgradedValue(0)
				upgradedValue:__wf_atom_fae96c2e(4, 0)
				object2:__wf_atom_7c5964b8(upgradedValue)
			end
		end
	end
end

local function fn2(instances)
	local result = {}

	for i = 1, #instances do
		table.insert(result, instances[i])
	end

	for i = 1, #instances do
		table.insert(result, instances[i])
	end

	return result
end

local function fn3(heading, p) -- 1 equivalent call inferred from this helper
	local v4 = heading + p

	if v4 > 360 then
		return v4 - 360
	end

	if v4 < -360 then
		return v4 + 360
	end

	return v4
end

function OnProjectileHit(object, _, object2, instance)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or object2:__wf_atom_9f2332e5() ~= __wf_atom_3371f607 then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.FlybladeSeekingRuneBuffed)
		or not __wf_atom_e919fb8e.FlybladeSeekingRuneBuffed
	then
		return
	end

	local __wf_atom_6271f57d = __wf_atom_3371f607:__wf_atom_6271f57d()

	if __wf_atom_6271f57d < 0 then
		return
	end

	local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(__wf_atom_6271f57d)

	if __wf_atom_7e8ad928(__wf_atom_3d08948b) then
		return
	end

	local __wf_atom_e919fb8e2 = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752])) then
		__wf_atom_e919fb8e2.Runes[__wf_atom_0395f752].FlybladeSeekRuneLastHitCharge = object2:__wf_atom_826db97d()
	end

	local position = object2:GetPosition()

	if not __wf_atom_7e8ad928(seekProjSpawnSound) then
		gRegion:PlaySound(seekProjSpawnSound, position, false, 0, __wf_atom_6009c8ed)
	end

	if not __wf_atom_6009c8ed:__wf_atom_4417a5d4() then
		return
	end

	local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, 10)

	for i = #all, 1, -1 do
		if not (__wf_atom_7e8ad928(all[i]) or all[i]:__wf_atom_129d1aba(__wf_atom_6009c8ed) or all[i] == instance or all[i]:__wf_atom_bedb4e3f() or all[i]:IsKilled() or not all[i]:__wf_atom_6cd0da48(false, true, false)) then
			continue
		end

		table.remove(all, i)
	end

	module2.ShuffleTable(all)
	local instances = __wf_atom_7e8ad928(all) and {} or all

	if
		not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_129d1aba(__wf_atom_6009c8ed)
		and not instance:__wf_atom_bedb4e3f()
		and not instance:IsKilled()
		and instance:__wf_atom_6cd0da48(false, true, false)
	then
		table.insert(instances, instance)
	end

	local v4 = fn2(instances)
	__wf_atom_3371f607:__wf_atom_f4afee75()
	local __wf_atom_f7f6708f = __wf_atom_3371f607:__wf_atom_f7f6708f()

	for i = 1, 4 do
		local v5

		if #v4 > 0 then
			v5 = table.remove(v4, 1)
		end

		local v6

		if v5 and v5 ~= instance then
			v6 = __wf_atom_fa8d0177(position, v5:__wf_atom_d0069154())
		else
			v6 = Rotation(__wf_atom_5784a397(0, 360), __wf_atom_5784a397(-60, 60), 0)
		end

		v6.heading = fn3(v6.heading, __wf_atom_5784a397(-60, 60)) -- inferred equivalent call
		v6.pitch = -__wf_atom_5784a397(45, 65)
		__wf_atom_3d08948b:__wf_atom_2f00a1b2(position, v6, projectileType, 0, i - 1, __wf_atom_f7f6708f, v5)
	end
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		if not __wf_atom_7e8ad928(runeBehaviorUpgradeType) and runeBehaviorUpgradeType:IsA(__wf_atom_ac456965) then
			instance:__wf_atom_bc7d3d16(runeBehaviorUpgradeType)
		end

		instance:__wf_atom_f354682d(v2, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		fn(instance)
		instance:__wf_atom_c3534aa7()
		instance:__wf_atom_308a9a4d(v2)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 0.6
		elseif p == 2 then
			v = 0.8
		elseif p == 3 then
			v = 1
		else
			v = 1.2
		end
	end

	local v4 = {
		COUNT = 4,
		MULT = module2.FormatNumber(v * 100, 0)
	}
	return cjson.encode(v4)
end