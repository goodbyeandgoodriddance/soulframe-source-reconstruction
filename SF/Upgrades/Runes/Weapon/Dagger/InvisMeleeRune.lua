local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Upgrades.Runes.Weapon.RuneCommon")
local duration = 30
local bonus = 2

local function fn(p, p2, object)
	if (__wf_atom_7e8ad928(object) and 0 or object:__wf_atom_a8dac107()) == 0 then
		if p == 1 then
			duration = 3
		elseif p == 2 then
			duration = 4
		elseif p == 3 then
			duration = 5
		else
			duration = 6
		end

		bonus = 3
	end

	if not __wf_atom_7e8ad928(p2) then
		duration = duration * 2 - module2.GetRuneDrainSpeed(p2, duration)
	end
end

function EvaluateAbility(object, _)
	return object:__wf_atom_f3044fe0((object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner)))) >= module2.GetRuneActivationCost()
		or module.InfiniteEnergy()
end

function ActivateAbility(object, object2, _, p)
	local weaponMote = module.GetWeaponMote(mOwner:__wf_atom_3371f607())

	if __wf_atom_7e8ad928(weaponMote) then
		return
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) then
		return
	end

	fn(p, object2, weaponMote)
	module.AddCastImmunity(object2)
	mOwner:__wf_atom_34c9b8f6(0)
	object:__wf_atom_6a4cf64f()
	object:__wf_atom_7ee0a78b(true)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:__wf_atom_d5651846()

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_3371f607:__wf_atom_66088189(1, 0)

	if not __wf_atom_7e8ad928(__wf_atom_66088189) then
		mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
			__wf_atom_66088189,
			EMPTY_SYMBOL
		)
	end

	local __wf_atom_66088189_2 = __wf_atom_3371f607:__wf_atom_66088189(1, 1)

	if not (__wf_atom_7e8ad928(__wf_atom_66088189_2) or string.match(__wf_atom_66088189_2:GetName(), "Shield")) then
		mOwner:__wf_atom_7ccf4243(activeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_dc5956fc(
			__wf_atom_66088189_2,
			EMPTY_SYMBOL
		)
	end

	module.RemoveCastImmunity(object2)
	__wf_atom_d2b2176d:AddUpgrade(103, 2, noiseMultiplier)
	object2:__wf_atom_9373d0eb(7, true)
	object2:__wf_atom_92aa9d91():__wf_atom_152abd5a()
	mOwner:__wf_atom_7ccf4243(avatarFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object2:Attach(burstFxType, EMPTY_SYMBOL)
	local v = 0

	while v < 0.8 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 0.2, 0, 0.8)
		object2:__wf_atom_68f2c268(v)
		Sleep(0)
	end

	if gRegion:IsMaster() then
		object2:Attach(cloakStartPerception, Symbol("GAME_C1_HEAD1"))
		gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_b7b3b56a(object2)
	end

	module.NotifyRuneSuccess(object2, __wf_atom_3371f607)
	local runeActivationCost = module2.GetRuneActivationCost()
	local v2 = runeActivationCost / duration
	mOwner:__wf_atom_34c9b8f6(v2)
	local __wf_atom_2e4994f1 = object:__wf_atom_2e4994f1(object:__wf_atom_e8008ec5(mOwner))
	local v3 = duration
	local v4 = nil
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

	if gRegion:IsMaster() then
		object2:__wf_atom_d2b2176d():AddUpgrade(283, 4, 0, __wf_atom_3371f607:__wf_atom_1bb5b1ff(), __wf_atom_3371f607)
	end

	while not __wf_atom_7e8ad928(object2) and not __wf_atom_7e8ad928(__wf_atom_3371f607) and duration > 0 do
		Sleep(0)
		local __wf_atom_35a10d3c = object2:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)

		if
			__wf_atom_35a10d3c == __wf_atom_3371f607
			or __wf_atom_7e8ad928(__wf_atom_35a10d3c)
			or __wf_atom_35a10d3c:__wf_atom_ed08f97f()
		then
			if object2:__wf_atom_611b620c() then
				local __wf_atom_76a59b23 = object2:__wf_atom_76a59b23()

				if
					(__wf_atom_7e8ad928(v4) or v4 ~= __wf_atom_76a59b23)
					and (__wf_atom_7e8ad928(__wf_atom_76a59b23) or __wf_atom_76a59b23:IsKilled())
				then
					local v5 = __wf_atom_421b01aa(duration + bonus, 0, v3)
					local v6 = v5 - duration

					if gRegion:IsMaster() then
						object:__wf_atom_19516b62(runeActivationCost * v6 / v3, __wf_atom_2e4994f1)
					end

					duration = v5
					v4 = __wf_atom_76a59b23
				end
			end
		else
			duration = 0
		end

		object2:__wf_atom_cecb2d55(Symbol("sRtpcMoteMeter"), __wf_atom_421b01aa(duration / v3, 0, 1))
		duration -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(energySoundInstance) then
		energySoundInstance:Stop(false)
		__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
	end
end

function DeactivateAbility(_, object, _, _)
	object:__wf_atom_68f2c268(0.8)
	object:SetVisibility(true)
	object:__wf_atom_9373d0eb(7, false)
	object:Attach(burstFxType, EMPTY_SYMBOL)

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object:PlaySound(deactivateAbilitySound, false)
	end

	local __wf_atom_3371f607 = mOwner:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) then
		if gRegion:IsMaster() then
			object:__wf_atom_d2b2176d():RemoveUpgrade(
				283,
				4,
				0,
				__wf_atom_3371f607:__wf_atom_1bb5b1ff(),
				__wf_atom_3371f607
			)
		end

		local __wf_atom_0395f752 = __wf_atom_3371f607:__wf_atom_0395f752()
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

		if not (__wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752]) or __wf_atom_7e8ad928(__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance)) then
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance:Stop(false)
			__wf_atom_e919fb8e.Runes[__wf_atom_0395f752].energySoundInstance = nil
		end
	end

	local v = 0

	while v < 0.8 and not __wf_atom_7e8ad928(object) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 0.1, 0, 0.8)
		object:__wf_atom_68f2c268(0.8 - v)
		Sleep(0)
	end
end

function GetAbilityStats(p, _, p2, _, _, _)
	fn(p, nil, p2)
	local v = { DURATION = duration, BONUS = bonus }
	return cjson.encode(v)
end