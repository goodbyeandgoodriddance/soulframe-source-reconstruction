local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = Symbol("SBLaserRuneDmg")
local v2 = Symbol("SBLaserRuneBuffSym")
local v3 = Symbol("SBLaserRuneWeaponCB")
local v4 = 20
local v5 = 50

local function fn(p, p2, object)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v5 = 150
		elseif p == 2 then
			v5 = 200
		else
			v5 = 250
		end

		v4 = 8
	end

	if not __wf_atom_7e8ad928(p2) then
		v4 = v4 * 2 - module3.GetRuneDrainSpeed(p2, v4)
	end
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn2(sbLaserRune, object, object2)
	if not __wf_atom_7e8ad928(sbLaserRune.swordFXType) then
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(sbLaserRune.swordFXType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end

	if not __wf_atom_7e8ad928(sbLaserRune.shieldFXType) then
		local __wf_atom_66088189 = object2:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local __wf_atom_bb3e7833 = __wf_atom_66088189:__wf_atom_bb3e7833(sbLaserRune.shieldFXType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end
		end
	end

	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():__wf_atom_e3f17301(v2)
		object:__wf_atom_d2b2176d():RemoveUpgrade(
			319,
			4,
			1,
			object2:__wf_atom_1bb5b1ff(),
			object2,
			26,
			Symbol(),
			false,
			31
		)
		object:__wf_atom_d2b2176d():RemoveUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
	end
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn3(object) -- 1 equivalent call inferred from this helper
	local __wf_atom_74d951b0 = object:__wf_atom_d2b2176d():__wf_atom_74d951b0()
	local aimPosition = object:GetAimPosition()
	local v6 = __wf_atom_74d951b0 - aimPosition

	if Length(v6) > 25 then
		Normalize(v6)
		__wf_atom_74d951b0 = aimPosition + v6 * 25
	end

	return __wf_atom_74d951b0
end

function ActivateAbility(object, object2, _, level)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	module.AddCastImmunity(object2)
	fn(level, object2, weaponMote)
	local runeDamageBuff = module3.GetRuneDamageBuff(object2, v5)
	mOwner:__wf_atom_34c9b8f6(0)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	module.EnableWeaponFiring(object2, mOwner, false)
	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	local v6 = false
	local v7 = nil
	local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

	if __wf_atom_7e8ad928(nil) and not __wf_atom_7e8ad928(__wf_atom_66088189) then
		local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
			activeFxShieldType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)

		if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
			__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
		end
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune = {}
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.weapon = __wf_atom_3371f607
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.level = level

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage = 0
	end

	object2:__wf_atom_d2b2176d():__wf_atom_d5651846()

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true) then
		return
	end

	module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	local v8 = module3.GetRuneActivationCost() / v4
	mOwner:__wf_atom_34c9b8f6(v8)
	module.RemoveCastImmunity(object2)
	local energySoundInstance

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance) then
		energySoundInstance = object2:PlaySound(energyLoopingSound, false, 1, false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = energySoundInstance
	end

	object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))))
	__wf_atom_3371f607:__wf_atom_886269c8(true)
	__wf_atom_3371f607:__wf_atom_5884d237(false)

	if gRegion:IsMaster() then
		object2:__wf_atom_d2b2176d():AddUpgrade(392, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
		object2:__wf_atom_d2b2176d():AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end

	while
		not __wf_atom_7e8ad928(object2)
		and not object2:IsKilled()
		and not __wf_atom_7e8ad928(__wf_atom_3371f607)
		and v4 > 0
	do
		local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
		local v9 = __wf_atom_35a10d3c == __wf_atom_3371f607

		if not (v9 or __wf_atom_7e8ad928(__wf_atom_35a10d3c) or __wf_atom_35a10d3c:__wf_atom_ed08f97f()) then
			v4 = 0
		end

		local v10 = object2:__wf_atom_c138b19b(activateAnim) or object2:__wf_atom_7b82e9e1(26)
		local v11 = v9 and v10 and not __wf_atom_3371f607:__wf_atom_c5d04cb3()

		if v9 or not (v4 > 0) then
			if v9 then
				module.EnableWeaponFiring(object2, mOwner, false)

				if __wf_atom_4417a5d4 then
					__wf_atom_3371f607:__wf_atom_886269c8(true)
				else
					__wf_atom_3371f607:__wf_atom_886269c8(v11)
				end
			end
		else
			module.EnableWeaponFiring(object2, mOwner, true)
			__wf_atom_3371f607:__wf_atom_886269c8(false)
		end

		if v6 ~= v11 then
			if v11 then
				v7 = object2:Attach(
					laserType,
					__wf_atom_66088189:__wf_atom_f5bac0e4(),
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)

				if not __wf_atom_7e8ad928(v7) then
					v7:__wf_atom_7ebba814(object2)
					v7:__wf_atom_34a8a27a(__wf_atom_3371f607)
					v7:__wf_atom_99fe2087(runeDamageBuff)
					v7:__wf_atom_ffca77e5(0.5)
					v7:__wf_atom_be55614b(v)
				end
			elseif not __wf_atom_7e8ad928(v7) then
				v7:Destroy()
			end

			v6 = v11
		end

		if not __wf_atom_7e8ad928(v7) then
			local __wf_atom_f5bac0e4 = __wf_atom_66088189:__wf_atom_f5bac0e4()

			if v7:__wf_atom_f5bac0e4() ~= __wf_atom_f5bac0e4 then
				v7:__wf_atom_dc5956fc(object2, __wf_atom_f5bac0e4)
			end

			v7:__wf_atom_a64eca67(fn3(object2)) -- inferred equivalent call

			if __wf_atom_4417a5d4 then
				local __wf_atom_92aa9d91 = object2:__wf_atom_92aa9d91()

				if not __wf_atom_7e8ad928(__wf_atom_92aa9d91:__wf_atom_5d790fbf()) then
					__wf_atom_92aa9d91:__wf_atom_70c1e444()
				end
			end
		end

		v4 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(energySoundInstance) then
		energySoundInstance:Stop(false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
	end
end

function DeactivateAbility(_, object, _, p)
	object:__wf_atom_0650fed7(laserType)
	mOwner:__wf_atom_34c9b8f6(0)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		if gRegion:IsMaster() then
			object:__wf_atom_d2b2176d():RemoveUpgrade(
				392,
				4,
				0,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607
			)
			object:__wf_atom_d2b2176d():RemoveUpgrade(
				283,
				4,
				0,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607
			)
		end

		__wf_atom_3371f607:__wf_atom_886269c8(false)
		__wf_atom_3371f607:__wf_atom_5884d237(true)
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune)) then
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance) then
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance:Stop(false)
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
			end

			if
				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.weapon == __wf_atom_3371f607
				and __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage > 0
			then
				fn(p, object)

				if not __wf_atom_7e8ad928(buffedFxSwordType) then
					local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

					if not __wf_atom_7e8ad928(__wf_atom_66088189) then
						if __wf_atom_7e8ad928((__wf_atom_66088189:__wf_atom_bb3e7833(buffedFxSwordType))) then
							__wf_atom_66088189:Attach(buffedFxSwordType, EMPTY_SYMBOL)
						end

						__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.swordFXType = buffedFxSwordType
					end
				end

				if not __wf_atom_7e8ad928(buffedFxShieldType) then
					local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

					if not __wf_atom_7e8ad928(__wf_atom_66088189) then
						if __wf_atom_7e8ad928((__wf_atom_66088189:__wf_atom_bb3e7833(buffedFxShieldType))) then
							__wf_atom_66088189:Attach(buffedFxShieldType, EMPTY_SYMBOL)
						end

						__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.shieldFXType = buffedFxShieldType
					end
				end

				if gRegion:IsMaster() then
					local buffDamage = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage
					local runeDamageBuff = module3.GetRuneDamageBuff(object, buffDamage)
					object:__wf_atom_d2b2176d():__wf_atom_56004282(
						v2,
						366,
						3,
						runeDamageBuff,
						__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
						__wf_atom_3371f607
					)
					object:__wf_atom_d2b2176d():AddUpgrade(
						319,
						4,
						1,
						__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
						__wf_atom_3371f607,
						26,
						Symbol(),
						false,
						31
					)
					object:__wf_atom_d2b2176d():AddUpgrade(
						283,
						4,
						0,
						__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
						__wf_atom_3371f607
					)
				end
			end
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

function OnMeleeHit(object)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292())
		or __wf_atom_7e8ad928(object:__wf_atom_9d766292():__wf_atom_483e7ddc())
	then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	local __wf_atom_483e7ddc = object:__wf_atom_9d766292():__wf_atom_483e7ddc()

	if __wf_atom_483e7ddc.healthDamage == 0 then
		return
	end

	local __wf_atom_3371f607 = __wf_atom_483e7ddc:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_2dc5c74e) then
		return
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
	then
		return
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune)
		or __wf_atom_3371f607 ~= __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.weapon
	then
		return
	end

	fn(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.level, object)

	if __wf_atom_483e7ddc.upgradeSymbol == v then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage = __wf_atom_421b01aa(
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage + 0.15,
			0,
			3
		)
	elseif __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage > 0 then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:Attach(hitBurstFxType, EMPTY_SYMBOL)
		end

		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage = 0
		fn2(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune, object, __wf_atom_3371f607)
	end
end

function ApplyRuneUpgrade(object, object2, _, _, _)
	if
		__wf_atom_7e8ad928(object2)
		or __wf_atom_7e8ad928(object)
		or object2:__wf_atom_55da7898() ~= 5 and object2:__wf_atom_55da7898() ~= 1
	then
		return
	end

	object:__wf_atom_b4529799(v3, "OnMeleeHit")
end

function RemoveRuneUpgrade(object, object2, _, _, _)
	if
		__wf_atom_7e8ad928(object2)
		or __wf_atom_7e8ad928(object)
		or object2:__wf_atom_55da7898() ~= 5 and object2:__wf_atom_55da7898() ~= 1
	then
		return
	end

	local __wf_atom_0395f752 = object2:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes)
		and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])
		and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune)
		and __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.weapon == object2
		and __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage > 0
	then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune.buffDamage = 0
		fn2(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].SBLaserRune, object, object2)
	end

	object:__wf_atom_af2dc07b(v3)
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, nil, p2)
	local v6 = {
		BONUS = module2.FormatNumber(v5 * 0.5, 0),
		DURATION = module2.FormatNumber(v4)
	}
	return cjson.encode(v6)
end