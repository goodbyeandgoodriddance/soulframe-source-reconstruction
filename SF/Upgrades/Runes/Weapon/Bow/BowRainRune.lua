local v = Symbol("Neutral")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v2 = Symbol("BowRainRuneCB")
local v3 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v4 = 1

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, bowRainRuneLevel)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	module.AddCastImmunity(object2)

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if bowRainRuneLevel == 1 then
			v4 = 0.5
		elseif bowRainRuneLevel == 2 then
			v4 = 0.6
		elseif bowRainRuneLevel == 3 then
			v4 = 0.7
		else
			v4 = 0.8
		end
	end

	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	mOwner:__wf_atom_74f6ca7b(Symbol("OnProjectileHit"), true)
	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v4)
	local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e_2.BowRainRuneDmgPct = runeDamageBuff

	if __wf_atom_7e8ad928(nil) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
				activeArrowFxType,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
			end
		end
	end

	if __wf_atom_7e8ad928(nil) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

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
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneActive = true
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneEnergyType = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneFireSFX = buffAttackSFX
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLevel = bowRainRuneLevel
	local v5 = true

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v5 do
		Sleep(0)
		v5 = __wf_atom_3371f607:GetState() == 13
			or __wf_atom_3371f607:GetState() == 14
			or __wf_atom_3371f607:GetState() == 3
	end

	Sleep(0)
end

function DeactivateAbility(_, object, _, _)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneActive)) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneActive = nil
		end
	end
end

function avatarRain(object, _, instance, _)
	if __wf_atom_7e8ad928(instance) or instance:IsA(ProjectileType) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if
		not __wf_atom_6009c8ed:__wf_atom_631bafa1()
		or __wf_atom_7e8ad928(instance:__wf_atom_e919fb8e().BowRainRuneBuffed)
	then
		return
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or instance:__wf_atom_9f2332e5() ~= __wf_atom_3371f607 then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.BowChargedRainPositionRune = instance:__wf_atom_a2a18137()
	__wf_atom_e919fb8e.BowChargedRainWeaponRune = __wf_atom_3371f607
	instance:Attach(arrowImpactFxType, EMPTY_SYMBOL)
	__wf_atom_6009c8ed:__wf_atom_8a035cd5(Symbol("SpawnRain"), false)
end

function OnNewProjectile(object, object2)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()
	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local runeActivationCost = module3.GetRuneActivationCost()
	local __wf_atom_6271f57d = object:__wf_atom_6271f57d()

	if object2:__wf_atom_1c9b5d2a() == __wf_atom_6271f57d then
		local bowRainRuneLevel

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLevel)) then
			bowRainRuneLevel = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLevel
		end

		local v5 = __wf_atom_7e8ad928(bowRainRuneLevel) and 1 or bowRainRuneLevel

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLastProjType)) then
			object2:__wf_atom_3b3c58ec(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLastProjType)
		end

		if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
			if v5 == 1 then
				v4 = 0.5
			elseif v5 == 2 then
				v4 = 0.6
			elseif v5 == 3 then
				v4 = 0.7
			else
				v4 = 0.8
			end
		end

		local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.numberOfProjectiles = 25
		local __wf_atom_d293da5d = object2:__wf_atom_d293da5d()
		local upgradedValue = Engine.UpgradedValue(0)

		for i = 0, 4 do
			local __wf_atom_4d8ee71d, v6 = __wf_atom_d293da5d:__wf_atom_4d8ee71d(i)

			if not __wf_atom_4d8ee71d then
				continue
			end

			if i == 2 then
				v6 = 1 + (v6 - 1) / 25
			elseif i < 4 then
				v6 /= 25
			end

			upgradedValue:__wf_atom_fae96c2e(i, v6)
		end

		local runeDamageBuff = module3.GetRuneDamageBuff(__wf_atom_6009c8ed, v4)
		upgradedValue:__wf_atom_fae96c2e(2, 0.3)
		upgradedValue:__wf_atom_fae96c2e(2, runeDamageBuff)
		object2:__wf_atom_df6a4117(upgradedValue)
		object2:__wf_atom_746d4173(2, runeDamageBuff)
		local upgradedValue2 = Engine.UpgradedValue(0)
		upgradedValue2:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue2)
	elseif
		object2:__wf_atom_1c9b5d2a() == 1
		and not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneActive))
	then
		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneEnergyType) then
			local __wf_atom_e55d02aa = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			if gRegion:IsMaster() and not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
				__wf_atom_e55d02aa:__wf_atom_19516b62(
					-runeActivationCost,
					__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneEnergyType
				)
			end

			module.NotifyRuneSuccess(__wf_atom_6009c8ed, object)
		end

		if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneFireSFX) then
			__wf_atom_6009c8ed:PlaySound(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneFireSFX, false)
		end

		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].BowRainRuneLastProjType = object2:__wf_atom_e14d8a8c()
		local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e_2.BowRainRuneBuffed = true
		object2:__wf_atom_facb3053(4)
		local upgradedValue = Engine.UpgradedValue(0)
		upgradedValue:__wf_atom_fae96c2e(4, 0)
		object2:__wf_atom_7c5964b8(upgradedValue)
	end
end

function SpawnRain(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local bowChargedRainPositionRune = __wf_atom_e919fb8e.BowChargedRainPositionRune
	local bowChargedRainWeaponRune = __wf_atom_e919fb8e.BowChargedRainWeaponRune
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	local __wf_atom_e93896ba = object:__wf_atom_e93896ba()
	local __wf_atom_f7f6708f = bowChargedRainWeaponRune:__wf_atom_f7f6708f()
	Sleep(0.25)
	local v5 = Range(0.05, 0.1)
	local v6 = Vector(0, 0, 0)
	local _ = math.sqrt((__wf_atom_7abf2d2f())) * 8
	local _ = math.random() * 2 * 3.141592653589793
	local v7 = 0

	while v7 < 25 do
		v6.x = bowChargedRainPositionRune.x
		v6.z = bowChargedRainPositionRune.z
		v6.y = bowChargedRainPositionRune.y
		local v8 = math.sqrt((math.random())) * 8
		local v9 = math.random() * 2 * 3.141592653589793
		v6.x += math.cos(v9) * v8
		v6.z += math.sin(v9) * v8
		v6.y += 5 * Random(1, 4)
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa, bowChargedRainPositionRune, 0, 8)
		local v10 = {}

		for i = 1, #all do
			if all[i]:__wf_atom_8c3af1a5(__wf_atom_e93896ba) or all[i]:__wf_atom_e93896ba() == v then
				continue
			end

			table.insert(v10, all[i])
		end

		local v11 = __wf_atom_2f2bada0 + Rotation(Random(-10, 10), Random(50, 80), 0)

		if #v10 > 0 and math.random() < math.min(1, #v10 / 4) then
			local v12 = v10[math.random(1, #v10)]
			local __wf_atom_96c119f5 = v12:__wf_atom_7470861b():__wf_atom_96c119f5(0)
			v6.x = __wf_atom_96c119f5.x + Random(-1, 1)
			v6.z = __wf_atom_96c119f5.z + Random(-1, 1)
			local v13 = __wf_atom_96c119f5 + Vector(0, 1, 0) + v12:MotionControl():__wf_atom_0cf4ee4b() * 0.25
			v11 = __wf_atom_fa8d0177(v6, v13)
		end

		local v12 = Vector()
		local v13 = (v6.y - bowChargedRainPositionRune.y) / math.sin((math.rad(v11.pitch)))
		local v14 = v6 + __wf_atom_9341614d(Vector(0, 0, v13), v11)
		local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v14, v6, v3, nil, v12)

		if
			__wf_atom_c20d246a
			and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			and v12.y - v14.y >= 1
		then
			v6 = v12
		end

		local flag = false
		local __wf_atom_6271f57d = bowChargedRainWeaponRune:__wf_atom_6271f57d()

		if __wf_atom_6271f57d > 1 then
			local __wf_atom_3d08948b = bowChargedRainWeaponRune:__wf_atom_3d08948b(__wf_atom_6271f57d)

			if not __wf_atom_7e8ad928(__wf_atom_3d08948b) then
				__wf_atom_3d08948b:__wf_atom_2f00a1b2(v6, v11, ProjectileType, 0, v7, __wf_atom_f7f6708f)
				flag = true
			end
		end

		if flag then
			local __wf_atom_ff1686f2 = v5:__wf_atom_ff1686f2()
			Sleep(__wf_atom_ff1686f2)
			v7 += 1
		else
			v7 = 25
		end
	end
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if
		not __wf_atom_7e8ad928(instance)
		and instance:IsA(__wf_atom_77e05d3b)
		and not __wf_atom_7e8ad928(runeBehaviorUpgradeType)
		and runeBehaviorUpgradeType:IsA(__wf_atom_ac456965)
	then
		instance:__wf_atom_bc7d3d16(runeBehaviorUpgradeType)
		instance:__wf_atom_3bb2e7ee(true)
		instance:__wf_atom_f354682d(v2, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		instance:__wf_atom_c3534aa7()
		instance:__wf_atom_308a9a4d(v2)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v4 = 0.5
		elseif p == 2 then
			v4 = 0.6
		elseif p == 3 then
			v4 = 0.7
		else
			v4 = 0.8
		end
	end

	local v5 = {
		BONUS = module2.FormatNumber(v4 * 100, 0)
	}
	return cjson.encode(v5)
end