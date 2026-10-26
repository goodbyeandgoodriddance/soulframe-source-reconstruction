local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("Lotus.Scripts.Libs.AudioLib")

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		return 0
	end

	local __wf_atom_9fb9a1d6 = object:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()
	local __wf_atom_be152500 = object:__wf_atom_d2b2176d():__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_9fb9a1d6)
		or __wf_atom_be152500 ~= __wf_atom_9fb9a1d6
		or __wf_atom_9fb9a1d6:__wf_atom_ed08f97f()
		or __wf_atom_9fb9a1d6:GetState() ~= 0
	then
		return 0
	end

	return 1
end

function InitializeAbility(_, object)
	if gRegion:IsMaster() and object:__wf_atom_535d5cbb() then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_a06626cb(5, 7)
		local v = object:GiveItem(playerWeaponType, false)

		if not __wf_atom_7e8ad928(v) then
			local __wf_atom_a1680b24 = __wf_atom_c67f9605:__wf_atom_a1680b24(playerWeaponType)
			v:__wf_atom_67dd6811((__wf_atom_c67f9605:__wf_atom_6480316c(__wf_atom_a1680b24, playerWeaponType)))
			v:__wf_atom_cfecab5d(true)
		end

		__wf_atom_d2b2176d:__wf_atom_a06626cb(5, 7)
	end

	if _T.TotemPickedUp then
		mOwner:__wf_atom_34c9b8f6(0)
	end
end

function OnSteal(object, _, p)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	local __wf_atom_92aa9d91 = __wf_atom_6009c8ed:__wf_atom_92aa9d91()
	local __wf_atom_4417a5d4 = __wf_atom_6009c8ed:__wf_atom_4417a5d4()

	if p == 0 then
		if __wf_atom_4417a5d4 then
			if not _T.TotemPickedUp then
				module2.PlayLocalTransmission(transmissionSet, activateTransmissionSymb, __wf_atom_6009c8ed)
			end

			__wf_atom_d2b2176d:Unequip(0, 2)
		end

		__wf_atom_6009c8ed:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		module.PlayAnimAndSuspendUntilEvent(object, activateStealAnim, "FireSwordWait", false, 3, 1, true)

		if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
			return
		end

		__wf_atom_92aa9d91:__wf_atom_8595f516()
		__wf_atom_92aa9d91:__wf_atom_8d150708(false)
		__wf_atom_6009c8ed:__wf_atom_8914dfde("FireSwordGrab", 2)
	end

	if __wf_atom_4417a5d4 and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(mOwner)) then
		local __wf_atom_3a7106a8 = __wf_atom_6009c8ed:__wf_atom_3a7106a8()
		__wf_atom_6009c8ed:__wf_atom_bb45a13e(true)
		object:TryToActivateAbility(object:__wf_atom_e8008ec5(mOwner))
		__wf_atom_6009c8ed:__wf_atom_bb45a13e(__wf_atom_3a7106a8)
	end

	if p == 0 then
		while not __wf_atom_7e8ad928(__wf_atom_6009c8ed) and __wf_atom_6009c8ed:__wf_atom_c138b19b(activateStealAnim) do
			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_92aa9d91) then
			__wf_atom_92aa9d91:__wf_atom_8d150708(true)
		end
	end
end

local function fn(object) -- 2 equivalent calls inferred from this helper
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(7)

	if __wf_atom_7e8ad928(__wf_atom_28224c27) or not __wf_atom_28224c27:IsA(playerWeaponType) then
		return __wf_atom_d2b2176d:__wf_atom_28224c27(5)
	end

	return __wf_atom_28224c27
end

function ActivateAbility(object, object2)
	if not __wf_atom_7e8ad928(object2:__wf_atom_30e3d82b()) then
		object2:__wf_atom_30e3d82b():__wf_atom_b414eabf()
	end

	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if object2:__wf_atom_535d5cbb() then
		if gRegion:IsMaster() then
			__wf_atom_d2b2176d:__wf_atom_a06626cb(5, 7)
			__wf_atom_d2b2176d:Equip(5, 0, 2)
		end

		if not object2:__wf_atom_c138b19b(activateStealAnim) then
			object2:Attach(castFxShortType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			module.PlayUpperBodyAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 2, 1, false)
		end
	elseif module.PlayAnimAndSuspendUntilEvent(object, activateAnimNpc, animEventNpc, false, 2, 1, false) then
		object2:Attach(fxOnNpcActivate, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	else
		return
	end

	object:__wf_atom_6a4cf64f()
	local v = fn(object2) -- inferred equivalent call

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_18007d51 = v:__wf_atom_18007d51()

		if not __wf_atom_7e8ad928(__wf_atom_18007d51) then
			__wf_atom_18007d51:__wf_atom_9866bacc(damageType, true, false)
		end
	end

	if gRegion:IsMaster() then
		local playerWeaponType = object2:__wf_atom_535d5cbb() and playerWeaponType or __wf_atom_77e05d3b
		__wf_atom_d2b2176d:AddUpgrade(401, 0, damagePct, playerWeaponType, nil, damageType)
		__wf_atom_d2b2176d:AddUpgrade(312, 0, explosiveRadius, playerWeaponType)
		__wf_atom_d2b2176d:AddUpgrade(
			420,
			4,
			projectileEmbedTimeRange.minValue,
			playerWeaponType,
			nil,
			26,
			Symbol("MinEmbedTime")
		)
		__wf_atom_d2b2176d:AddUpgrade(
			420,
			4,
			projectileEmbedTimeRange.maxValue,
			playerWeaponType,
			nil,
			26,
			Symbol("MaxEmbedTime")
		)
	end

	while not object2:IsKilled() and (object:__wf_atom_f3044fe0() > 0 or module.InfiniteEnergy()) do
		Sleep(0)
	end
end

function DeactivateAbility(object, object2)
	local v = fn(object2) -- inferred equivalent call
	module3.EnableTaggedSequencers(Symbol("SFXFireSwordLoop"), false)

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_18007d51 = v:__wf_atom_18007d51()

		if not __wf_atom_7e8ad928(__wf_atom_18007d51) then
			__wf_atom_18007d51:__wf_atom_9866bacc(damageType, false, false)
		end

		v:__wf_atom_36d7c7d8()
	end

	if gRegion:IsMaster() then
		local playerWeaponType = object2:__wf_atom_535d5cbb() and playerWeaponType or __wf_atom_77e05d3b
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:RemoveUpgrade(401, 0, damagePct, playerWeaponType, nil, damageType)
		__wf_atom_d2b2176d:RemoveUpgrade(312, 0, explosiveRadius, playerWeaponType)
		__wf_atom_d2b2176d:RemoveUpgrade(
			420,
			4,
			projectileEmbedTimeRange.minValue,
			playerWeaponType,
			nil,
			26,
			Symbol("MinEmbedTime")
		)
		__wf_atom_d2b2176d:RemoveUpgrade(
			420,
			4,
			projectileEmbedTimeRange.maxValue,
			playerWeaponType,
			nil,
			26,
			Symbol("MaxEmbedTime")
		)

		if object2:__wf_atom_535d5cbb() then
			__wf_atom_d2b2176d:__wf_atom_a06626cb(5, 7)
		end
	end

	if not __wf_atom_7e8ad928(deactivateAbilitySound) then
		object2:PlaySound(deactivateAbilitySound, false)
	end

	object:__wf_atom_b26056dd((Resource(mOwner:__wf_atom_1bb5b1ff()):__wf_atom_89d06f0f(false)))
end