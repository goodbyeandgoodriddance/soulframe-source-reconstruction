local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("EE.Interface.Utilities")
local module3 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local duration = 30
local v = 0.5
local v2 = 0.5
local v3 = 5
local v4 = Symbol("CC_GROUND_PERFECT_HEAVY")
local v5 = Symbol("CC_GROUND_BRANCH_HEAVY")
local v6 = Symbol("CC_RUN_PERFECT_HEAVY")
local v7 = Symbol("CC_RUN_BRANCH_HEAVY")
local v8 = nil

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module3.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

local function fn(p, p2, object)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			duration = 5
			v = 2
			v2 = 0.4
			v3 = 10
		elseif p == 2 then
			duration = 6
			v = 2
			v2 = 0.6
			v3 = 30
		elseif p == 3 then
			duration = 7
			v = 2
			v2 = 0.8
			v3 = 50
		else
			duration = 8
			v = 2
			v2 = 1
			v3 = 70
		end
	end

	if not __wf_atom_7e8ad928(p2) then
		duration = duration * 2 - module3.GetRuneDrainSpeed(p2, duration)
	end
end

local function fn2(object, object2, p)
	if p then
		object:AddUpgrade(368, 3, v2, object2:__wf_atom_1bb5b1ff(), object2)
		object:AddUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v5)
		object:AddUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:AddUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v5)
		object:AddUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:AddUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v7)
		object:AddUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
		object:AddUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v7)
		object:AddUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
		object:AddUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
	else
		object:RemoveUpgrade(368, 3, v2, object2:__wf_atom_1bb5b1ff(), object2)
		object:RemoveUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v5)
		object:RemoveUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:RemoveUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v5)
		object:RemoveUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v4)
		object:RemoveUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v7)
		object:RemoveUpgrade(431, 3, v, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
		object:RemoveUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v7)
		object:RemoveUpgrade(257, 0, v3, object2:__wf_atom_1bb5b1ff(), object2, 26, v6)
		object:RemoveUpgrade(283, 4, 0, object2:__wf_atom_1bb5b1ff(), object2)
	end
end

function OnMeleeHit(_, _, object, object2, _, p, _, _, _, _, _, object3)
	if __wf_atom_7e8ad928(object) or object ~= mOwner:__wf_atom_3371f607() or __wf_atom_7e8ad928(object3) then
		return
	end

	if p <= 0 or __wf_atom_7e8ad928(object2) or not object2:IsKilled() then
		return
	end

	if not (object3:__wf_atom_2319699d(v5) or object3:__wf_atom_2319699d(v4) or object3:__wf_atom_2319699d(v7) or object3:__wf_atom_2319699d(v6)) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local __wf_atom_0395f752 = object:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].refreshDuration = true
	end
end

function ActivateAbility(object, object2, _, p)
	__wf_atom_f2daf912("Range")
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	fn(p, object2, weaponMote)
	local runeActivationCost = module3.GetRuneActivationCost()
	mOwner:__wf_atom_34c9b8f6(runeActivationCost / duration)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
		return
	end

	module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	local v9 = nil
	local __wf_atom_9112f323 = __wf_atom_3371f607:__wf_atom_9112f323(false)
	local __wf_atom_c232e8c9 = __wf_atom_3371f607:__wf_atom_c232e8c9()
	local __wf_atom_973269a5 = __wf_atom_3371f607:__wf_atom_973269a5()
	local v10

	if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_3371f607)) then
		v10 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

		if not __wf_atom_7e8ad928(v10) then
			local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
				activeFxType,
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1
			)

			if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
				__wf_atom_7ccf4243:__wf_atom_dc5956fc(v10, EMPTY_SYMBOL)
			end

			v9 = mOwner:__wf_atom_7ccf4243(trailType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

			if not __wf_atom_7e8ad928(v9) then
				v9:__wf_atom_dc5956fc(v10, EMPTY_SYMBOL)
			end
		end

		if gRegion:IsMaster() then
			fn2(object2:__wf_atom_d2b2176d(), __wf_atom_3371f607, true)
		end
	end

	local energySoundInstance = nil
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) then
		__wf_atom_e919fb8e.Runes = {}
	end

	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752] = {}
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance) then
		energySoundInstance = object2:PlaySound(energyLoopingSound, false, 1, false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = energySoundInstance
	end

	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackAssistDistance = __wf_atom_9112f323
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackStopDistance = __wf_atom_c232e8c9
	__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackSnapDistance = __wf_atom_973269a5
	local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	local v11 = duration
	mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), true)
	local v12 = true
	local v13 = nil
	local v14 = false
	local v15 = false

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and duration > 0 do
		local v16 = false
		local v17 = false
		local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if
			__wf_atom_35a10d3c == __wf_atom_3371f607
			or __wf_atom_7e8ad928(__wf_atom_35a10d3c)
			or __wf_atom_35a10d3c:__wf_atom_ed08f97f()
		then
			if
				__wf_atom_3371f607:__wf_atom_9f71ab59()
				and not (__wf_atom_3371f607:__wf_atom_160ce839() or __wf_atom_7e8ad928(__wf_atom_3371f607:__wf_atom_75a0566d()))
			then
				local __wf_atom_75a0566d = __wf_atom_3371f607:__wf_atom_75a0566d()
				v16 = __wf_atom_75a0566d:__wf_atom_f824cfe6() == 4 or __wf_atom_75a0566d:__wf_atom_f824cfe6() == 16

				if v16 and __wf_atom_75a0566d:__wf_atom_dedeec57() then
					v17 = true
				end
			end

			if v12 or not v16 then
				if v12 and not v16 then
					if not __wf_atom_7e8ad928(v9) then
						v9:Disable()
					end

					local __wf_atom_bb3e7833 = v10:__wf_atom_bb3e7833(rangeFxType)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						__wf_atom_bb3e7833:PlayTriggeredFade()
						v13 = nil
					end

					__wf_atom_3371f607:__wf_atom_68a890f0(__wf_atom_9112f323, __wf_atom_c232e8c9, __wf_atom_973269a5)
				end
			else
				local __wf_atom_bb3e7833 = v10:__wf_atom_bb3e7833(rangeFxType)

				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:PlayTriggeredFade()
				end

				local __wf_atom_7ccf4243 = mOwner:__wf_atom_7ccf4243(
					rangeFxType,
					EMPTY_SYMBOL,
					__wf_atom_28d5d4aa,
					__wf_atom_80368bb1
				)

				if not __wf_atom_7e8ad928(__wf_atom_7ccf4243) then
					__wf_atom_7ccf4243:__wf_atom_dc5956fc(v10, EMPTY_SYMBOL)
					v13 = __wf_atom_7ccf4243
				end

				if not __wf_atom_7e8ad928(v9) then
					v9:Enable()
				end

				__wf_atom_3371f607:__wf_atom_68a890f0(5, 3, 2)
			end

			local __wf_atom_f582136d = v10:__wf_atom_f582136d(rangeFxType)

			if not __wf_atom_7e8ad928(v13) then
				table.remove(__wf_atom_f582136d, table.find(__wf_atom_f582136d, v13))
			end

			for _, v18 in ipairs(__wf_atom_f582136d) do
				v18:PlayTriggeredFade()
			end

			if
				v16
				and __wf_atom_3371f607:__wf_atom_745fda4a()
				and not (__wf_atom_3371f607:__wf_atom_160ce839() or v14)
			then
				object2:PlaySound(buffAttackSFX, false)
				v14 = true
			end

			if v14 and (not __wf_atom_3371f607:__wf_atom_9f71ab59() or __wf_atom_3371f607:__wf_atom_160ce839()) then
				v14 = false
			end

			if not __wf_atom_7e8ad928(buffChargeSFX) then
				if v17 and not v15 then
					if not __wf_atom_7e8ad928(v8) then
						v8:Stop(true)
					end

					v8 = object2:PlaySound(buffChargeSFX, false)
				elseif not (v17 or v15 or __wf_atom_7e8ad928(v8)) then
					v8:Stop(false)
				end
			end

			if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].refreshDuration)) then
				local v18 = v11 - duration
				duration = v11

				if gRegion:IsMaster() then
					object:__wf_atom_19516b62(runeActivationCost * v18 / v11, __wf_atom_2e4994f1)
				end

				__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].refreshDuration = nil
			end

			v15 = v17
			v12 = v16
		else
			duration = 0
		end

		duration -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		__wf_atom_3371f607:__wf_atom_68a890f0(__wf_atom_9112f323, __wf_atom_c232e8c9, __wf_atom_973269a5)
	end

	if not __wf_atom_7e8ad928(energySoundInstance) then
		energySoundInstance:Stop(false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
	end
end

function DeactivateAbility(_, object, _, p)
	mOwner:__wf_atom_34c9b8f6(0)

	if not __wf_atom_7e8ad928(v8) then
		v8:Stop(false)
		v8 = nil
	end

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		local defaultAttackAssistDistance = 3.2
		local defaultAttackStopDistance = 1.35
		local defaultAttackSnapDistance = -1
		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752])) then
			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackAssistDistance) then
				defaultAttackAssistDistance = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackAssistDistance
			end

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackStopDistance) then
				defaultAttackStopDistance = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackStopDistance
			end

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackSnapDistance) then
				defaultAttackSnapDistance = __wf_atom_e919fb8e.Runes[__wf_atom_0395f752].defaultAttackSnapDistance
			end
		end

		__wf_atom_3371f607:__wf_atom_68a890f0(
			defaultAttackAssistDistance,
			defaultAttackStopDistance,
			defaultAttackSnapDistance
		)
	end

	mOwner:__wf_atom_74f6ca7b(Symbol("OnMeleeHit"), false)
	local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance)) then
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance:Stop(false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
	end

	if gRegion:IsMaster() then
		fn(p, object)
		fn2(object:__wf_atom_d2b2176d(), __wf_atom_3371f607, false)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, nil, p2)
	local v9 = {
		DURATION = duration,
		BONUS = module2.FormatNumber(v2 * 100, 0),
		BONUS2 = module2.FormatNumber(v3, 0)
	}
	return cjson.encode(v9)
end