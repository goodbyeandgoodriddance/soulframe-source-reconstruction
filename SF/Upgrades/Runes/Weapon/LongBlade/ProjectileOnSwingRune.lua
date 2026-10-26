local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = Symbol("ProjectileOnSwingRune")
local v2 = Symbol("RUNE_PROJECTILE")
local v3 = 1
local v4 = 1
local v5 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}
local v6 = Vector(0, 1, 0)

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(object)
	local __wf_atom_091354f5 = object:__wf_atom_091354f5(Symbol("StartMeleeSweep"))

	if __wf_atom_091354f5 <= 0 then
		__wf_atom_091354f5 = object:__wf_atom_091354f5(Symbol("StartMeleeSweepA"))
	end

	if __wf_atom_091354f5 <= 0 then
		__wf_atom_091354f5 = object:__wf_atom_091354f5(Symbol("StartMeleeSweepB"))
	end

	if __wf_atom_091354f5 <= 0 then
		__wf_atom_091354f5 = object:__wf_atom_091354f5(Symbol("StartMeleeSweepC"))
	end

	if __wf_atom_091354f5 > 0 then
		local __wf_atom_091354f5_2 = object:__wf_atom_091354f5(Symbol("EndMeleeSweep"))

		if __wf_atom_091354f5 < __wf_atom_091354f5_2 then
			return (__wf_atom_091354f5 + __wf_atom_091354f5_2) / 2
		end
	end

	local __wf_atom_091354f5_2 = object:__wf_atom_091354f5(Symbol("StartMeleeThrust"))

	if __wf_atom_091354f5_2 > 0 then
		local __wf_atom_091354f5_3 = object:__wf_atom_091354f5(Symbol("EndMeleeThrust"))

		if __wf_atom_091354f5_2 < __wf_atom_091354f5_3 then
			return (__wf_atom_091354f5_2 + __wf_atom_091354f5_3) / 2
		end
	end

	return 0
end

local function fn2(object, object2)
	local __wf_atom_6271f57d = object2:__wf_atom_6271f57d()

	if __wf_atom_6271f57d <= 0 then
		return
	end

	local __wf_atom_3d08948b = object2:__wf_atom_3d08948b(__wf_atom_6271f57d)

	if __wf_atom_7e8ad928(__wf_atom_3d08948b) then
		return
	end

	local v7 = Vector()
	Rotation()
	local __wf_atom_1c374cc9 = object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
	local v8

	if __wf_atom_7e8ad928((object2:__wf_atom_a7ab0ea2(v7))) then
		v8 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, __wf_atom_1c374cc9 + object:__wf_atom_a06d543c())
	else
		v8 = __wf_atom_fa8d0177(__wf_atom_1c374cc9, v7)
	end

	local __wf_atom_f7f6708f = object2:__wf_atom_f7f6708f()
	__wf_atom_3d08948b:__wf_atom_2f00a1b2(__wf_atom_1c374cc9, v8, projectileType, 0, 0, __wf_atom_f7f6708f)
end

function ActivateAbility(object, object2, _, level)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	if (__wf_atom_7e8ad928(weaponMote) and 0 or weaponMote:__wf_atom_a8dac107()) == 0 then
		if level == 1 then
			v3 = 1.25
			v4 = 1.5
		elseif level == 2 then
			v3 = 1.5
			v4 = 2
		elseif level == 3 then
			v3 = 1.75
			v4 = 2.5
		else
			v3 = 2
			v4 = 3
		end
	end

	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	local __wf_atom_75a0566d = __wf_atom_3371f607:__wf_atom_75a0566d()

	if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
		return
	end

	local __wf_atom_fe33ffd0 = __wf_atom_75a0566d:__wf_atom_fe33ffd0()

	if __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
		return
	end

	local __wf_atom_93e44bac = __wf_atom_fe33ffd0:__wf_atom_93e44bac()

	if __wf_atom_7e8ad928(__wf_atom_93e44bac) then
		return
	end

	local v7 = fn(__wf_atom_93e44bac)

	if v7 <= 0 then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].LongbladeProjRune) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].LongbladeProjRune = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].LongbladeProjRune.level = level
	local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
			__wf_atom_66088189,
			EMPTY_SYMBOL
		)
	end

	object2:PlaySound(buffAttackSFX, false)

	if gRegion:IsMaster() then
		object2:__wf_atom_d2b2176d():AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end

	local runeActivationCost = module3.GetRuneActivationCost()
	local v8 = __wf_atom_93e44bac:__wf_atom_8bb4ded3() / __wf_atom_3371f607:__wf_atom_bef8f035() * v7
	local v9 = true

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and v9 do
		Sleep(0)

		if __wf_atom_3371f607:__wf_atom_9f71ab59() and not __wf_atom_3371f607:__wf_atom_160ce839() then
			v9 = true

			if not __wf_atom_75a0566d:__wf_atom_dedeec57() then
				__wf_atom_3371f607:__wf_atom_c21d2c6f()
				v8 -= __wf_atom_084b3e93()

				if v8 < 0 then
					if object2:__wf_atom_631bafa1() then
						fn2(object2, __wf_atom_3371f607)
					end

					if gRegion:IsMaster() then
						local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
						object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
					end

					module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
					v9 = false
				end
			end
		else
			v9 = false
		end
	end
end

function DeactivateAbility(_, object, _, _)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():RemoveUpgrade(
			283,
			4,
			0,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607
		)
	end
end

function HugTheGround(object)
	local v7 = Vector(0, 1, 0)
	local v8 = Vector(0, -10, 0)
	local __wf_atom_dcc5c1a1 = object:__wf_atom_dcc5c1a1()
	__wf_atom_dcc5c1a1.y = 0
	Normalize(__wf_atom_dcc5c1a1)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v9 = __wf_atom_10cd16b2(__wf_atom_a2a18137.y, 0.025)
	local v10 = false

	while true do
		local __wf_atom_a2a18137_2 = object:__wf_atom_a2a18137()

		if not v10 then
			local __wf_atom_dcc5c1a1_2 = object:__wf_atom_dcc5c1a1()
			local v11 = Length(__wf_atom_dcc5c1a1_2)

			if v11 == 0 then
				v11 = object:__wf_atom_510474d7()
			end

			local v12 = __wf_atom_a2a18137_2 + __wf_atom_dcc5c1a1 * v11 * __wf_atom_084b3e93() * 2
			local v13 = Vector()
			local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(v12 + v7, v12 + v8, v5, nil, v13)

			if
				__wf_atom_c20d246a
				and (not __wf_atom_c20d246a:IsA(__wf_atom_8d0b7f88) or __wf_atom_c20d246a:__wf_atom_c6f1f83d() == 0)
			then
				local v14 = v13 + v6
				v9:__wf_atom_09294a87(v14.y)
				v9:Update(__wf_atom_084b3e93())
				v14.y = v9:__wf_atom_9e368823()
				local v15 = v14 - __wf_atom_a2a18137_2
				Normalize(v15)
				object:__wf_atom_53bcb18b(v15 * v11)
			else
				__wf_atom_dcc5c1a1_2.y = 0
				Normalize(__wf_atom_dcc5c1a1_2)
				object:__wf_atom_53bcb18b(__wf_atom_dcc5c1a1_2 * v11)
			end
		end

		if v10 then
			if __wf_atom_a2a18137_2 - __wf_atom_a2a18137 ~= __wf_atom_28d5d4aa then
				local v11 = Vector()
				local v12 = __wf_atom_9341614d(Vector(0, 0.5, 0), object:__wf_atom_2f2bada0())
				local __wf_atom_c20d246a = gRegion:__wf_atom_c20d246a(
					__wf_atom_a2a18137 + v12,
					__wf_atom_a2a18137_2 + v12,
					v5,
					nil,
					v11
				)

				if __wf_atom_c20d246a and not __wf_atom_c20d246a:HasTag(Symbol("TreeDeco")) then
					break
				end
			end

			__wf_atom_a2a18137 = object:__wf_atom_a2a18137()
			v9:Update(__wf_atom_084b3e93())
		end

		Sleep(0)
		v10 = not v10
	end

	gRegion:__wf_atom_dd1e4d10(object)
end

function OnNewProjectile(object, object2)
	local __wf_atom_7be51ede = object2:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) or object2:__wf_atom_197d43b1() ~= v2 then
		return
	end

	object2:__wf_atom_8a035cd5(Symbol("HugTheGround"), false)
	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_7be51ede:__wf_atom_e919fb8e()
	local v7 = (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].LongbladeProjRune))
		and 1
		or __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].LongbladeProjRune.level

	if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
		if v7 == 1 then
			v3 = 1.25
			v4 = 1.5
		elseif v7 == 2 then
			v3 = 1.5
			v4 = 2
		elseif v7 == 3 then
			v3 = 1.75
			v4 = 2.5
		else
			v3 = 2
			v4 = 3
		end
	end

	local runeDamageBuff = module3.GetRuneDamageBuff(__wf_atom_7be51ede, v3)
	local runeDamageBuff2 = module3.GetRuneDamageBuff(__wf_atom_7be51ede, v4)
	local __wf_atom_f792e63d = object:__wf_atom_010c2f81(0):__wf_atom_f792e63d()
	object2:__wf_atom_533c6916(__wf_atom_f792e63d.baseAmount * (runeDamageBuff + 1))
	object2:__wf_atom_350ac13e(__wf_atom_f792e63d.stabilityDamage * (runeDamageBuff2 + 1))
	object:__wf_atom_414f70dd(0)
	object:__wf_atom_7058a700(object2, 1)
	object2:__wf_atom_9866bacc(31, true)
	local upgradedValue = Engine.UpgradedValue(0)
	upgradedValue:__wf_atom_fae96c2e(4, 0)
	object2:__wf_atom_7c5964b8(upgradedValue)
end

function ApplyRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		if instance:__wf_atom_55da7898() ~= 5 and instance:__wf_atom_55da7898() ~= 1 then
			return
		end

		if not __wf_atom_7e8ad928(runeBehaviorUpgradeType) and runeBehaviorUpgradeType:IsA(__wf_atom_ac456965) then
			instance:__wf_atom_bc7d3d16(runeBehaviorUpgradeType)
			instance:__wf_atom_3bb2e7ee(true)
		end

		instance:__wf_atom_f354682d(v, "OnNewProjectile")
	end
end

function RemoveRuneUpgrade(_, instance, _, _, _)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_77e05d3b) then
		if instance:__wf_atom_55da7898() ~= 5 and instance:__wf_atom_55da7898() ~= 1 then
			return
		end

		instance:__wf_atom_c3534aa7()
		instance:__wf_atom_308a9a4d(v)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v3 = 1.25
			v4 = 1.5
		elseif p == 2 then
			v3 = 1.5
			v4 = 2
		elseif p == 3 then
			v3 = 1.75
			v4 = 2.5
		else
			v3 = 2
			v4 = 3
		end
	end

	local v7 = {
		DAMAGE = module2.FormatNumber(v3 * 100, 0),
		STAGGER = module2.FormatNumber(v4 * 100, 0)
	}
	return cjson.encode(v7)
end