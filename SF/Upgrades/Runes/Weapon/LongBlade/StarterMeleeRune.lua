local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local v = 1
Symbol("VictimIsVIP")

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module4.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, p)
	if __wf_atom_7e8ad928((module.GetWeaponMote(mOwner:__wf_atom_3371f607()))) then
		return
	end

	module.AddCastImmunity(object2)

	if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 1
		elseif p == 2 then
			v = 1.5
		elseif p == 3 then
			v = 2
		else
			v = 2.5
		end
	end

	local runeDamageBuff = module4.GetRuneDamageBuff(object2, v)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_3371f607)) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			local v2

			if string.find(__wf_atom_66088189:GetName(), "Dagger") then
				v2 = mOwner:__wf_atom_7ccf4243(activeFxSmallType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			else
				v2 = mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end

			v2:__wf_atom_dc5956fc(__wf_atom_66088189, EMPTY_SYMBOL)
			__wf_atom_66088189:__wf_atom_d87c0fc8(damageType)
		end

		local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

		if not (__wf_atom_7e8ad928(__wf_atom_66088189_2) or string.find(__wf_atom_66088189_2:GetName(), "Shield")) then
			mOwner:__wf_atom_7ccf4243(activeFxOffhandType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
				__wf_atom_66088189_2,
				EMPTY_SYMBOL
			)
			__wf_atom_66088189_2:__wf_atom_d87c0fc8(damageType)
		end
	end

	if gRegion:IsMaster() then
		__wf_atom_d2b2176d:AddUpgrade(
			401,
			0,
			runeDamageBuff,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607,
			damageType
		)
		__wf_atom_d2b2176d:AddUpgrade(
			319,
			4,
			1,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607,
			26,
			Symbol(),
			false,
			procType
		)
		__wf_atom_d2b2176d:AddUpgrade(
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
		__wf_atom_d2b2176d:AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end

	local runeActivationCost = module4.GetRuneActivationCost()
	Sleep(0)
	local __wf_atom_9f71ab59 = __wf_atom_3371f607:__wf_atom_9f71ab59()
	local v2 = false
	local v3 = false

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_9f71ab59 do
		Sleep(0)
		__wf_atom_9f71ab59 = __wf_atom_3371f607:__wf_atom_9f71ab59()
			and not __wf_atom_3371f607:__wf_atom_160ce839()
			and true
			or false

		if not (__wf_atom_7e8ad928(fullyChargedAttackFx) or v2) then
			local __wf_atom_75a0566d = __wf_atom_3371f607:__wf_atom_75a0566d()

			if not __wf_atom_7e8ad928(__wf_atom_75a0566d) and __wf_atom_75a0566d:__wf_atom_e34f584b() then
				v2 = true
				local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

				if not __wf_atom_7e8ad928(__wf_atom_66088189) then
					local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
						fullyChargedAttackFx,
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
						fullyChargedAttackFx,
						EMPTY_SYMBOL,
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)

					if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
						__wf_atom_7ccf4243:__wf_atom_dc5956fc(__wf_atom_66088189_2, EMPTY_SYMBOL)
					end
				end
			end
		end

		if v3 or not __wf_atom_3371f607:__wf_atom_745fda4a() then
			continue
		end

		object2:PlaySound(buffAttackSFX, false)
		v3 = true

		if gRegion:IsMaster() then
			local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
			object:__wf_atom_19516b62(-runeActivationCost, __wf_atom_2e4994f1)
		end

		module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	end

	Sleep(0)
end

function DeactivateAbility(_, object, _, p)
	module.RemoveCastImmunity(object)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_66088189) then
			__wf_atom_66088189:__wf_atom_d87c0fc8(Engine.__wf_atom_aee2d71e)
		end

		local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

		if not __wf_atom_7e8ad928(__wf_atom_66088189_2) then
			__wf_atom_66088189_2:__wf_atom_d87c0fc8(Engine.__wf_atom_aee2d71e)
		end
	end

	module2.EnableTaggedSequencers(Symbol("SFXFireSwordLoop"), false)

	if (__wf_atom_7e8ad928(nil) and 0 or (nil):__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 1
		elseif p == 2 then
			v = 1.5
		elseif p == 3 then
			v = 2
		else
			v = 2.5
		end
	end

	local runeDamageBuff = module4.GetRuneDamageBuff(object, v)

	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:RemoveUpgrade(
			401,
			0,
			runeDamageBuff,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607,
			damageType
		)
		__wf_atom_d2b2176d:RemoveUpgrade(
			319,
			4,
			1,
			__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
			__wf_atom_3371f607,
			26,
			Symbol(),
			false,
			procType
		)
		__wf_atom_d2b2176d:RemoveUpgrade(
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
		__wf_atom_d2b2176d:RemoveUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end
end

function GetAbilityStats(p, _, object, _, _, _)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			v = 1
		elseif p == 2 then
			v = 1.5
		elseif p == 3 then
			v = 2
		else
			v = 2.5
		end
	end

	local v2 = {
		DAMAGE = module3.FormatNumber(v * 100, 0)
	}
	return cjson.encode(v2)
end