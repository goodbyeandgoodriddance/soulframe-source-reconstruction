local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")
local v = 20

function NpcEvaluateAbility(_, _)
	return 0
end

function GetAbilityUpgradeLevelInfo()
	mOwner = _T.AbilityLevelQueryParms.Ability
	local level = _T.AbilityLevelQueryParms.Level
	local avatar = _T.AbilityLevelQueryParms.Avatar
	local magikForceCalc = module.magikForceCalc(avatar, level, mOwner)

	if level == 1 then
		v = 4
	elseif level == 2 then
		v = 5
	elseif level == 3 then
		v = 6
	else
		v = 7
	end

	v *= magikForceCalc
	local abilityUpgradeLevelInfo = {}
	table.insert(abilityUpgradeLevelInfo, {
		Label = "/Lotus/Language/Game/POWER_DURATION",
		Value = v,
		ValueUnit = "/Lotus/Language/Game/UNIT_SECOND"
	})
	_T.AbilityUpgradeLevelInfo = abilityUpgradeLevelInfo
end

function ActivateAbility(object, object2, _, p)
	local magikForceCalc = module.magikForceCalc(object2, p, mOwner)

	if p == 1 then
		v = 4
	elseif p == 2 then
		v = 5
	elseif p == 3 then
		v = 6
	else
		v = 7
	end

	v *= magikForceCalc
	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:__wf_atom_8a035cd5(Symbol("VirtueSwap"), false)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	module.SetForceAim(object2, mOwner, true)
	local __wf_atom_28224c27 = object2:__wf_atom_d2b2176d():__wf_atom_28224c27(1)

	if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		__wf_atom_28224c27:__wf_atom_36d7c7d8()
	end

	local __wf_atom_9fb9a1d6 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()

	if not __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		__wf_atom_9fb9a1d6:__wf_atom_36d7c7d8()
	end

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	if not __wf_atom_7e8ad928(pactFxType) then
		object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(cloakCastFxType) then
		object2:Attach(cloakCastFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		object2:Attach(critCastFx, EMPTY_SYMBOL)
	end

	Sleep(0)

	if object2:__wf_atom_59cb39a4() then
		object2:__wf_atom_8a035cd5(Symbol("AirStall"), false)

		if not module.PlayAnimAndSuspendUntilEvent(object, airAnim, "Cast", false, 2, 1, false) then
			return
		end
	elseif not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false) then
		return
	end

	mOwner:__wf_atom_d14eed1a()
	module.RemoveCastImmunity(object2)
	__wf_atom_d2b2176d:AddUpgrade(103, 2, noiseMultiplier)
	object2:__wf_atom_9373d0eb(7, true)
	object2:__wf_atom_92aa9d91():__wf_atom_152abd5a()
	object2:Attach(cloakAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 0.2, 0, 1)
		object2:__wf_atom_68f2c268(v2)
		Sleep(0)
	end

	object2:SetVisibility(false)

	if gRegion:IsMaster() then
		object2:Attach(cloakStartPerception, Symbol("GAME_C1_HEAD1"))
		gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_b7b3b56a(object2)
	end

	local __wf_atom_0c0ed46d = object2:__wf_atom_0c0ed46d()
	local __wf_atom_c6f1f83d = object2:__wf_atom_c6f1f83d()
	local v3 = true

	while v > 0 do
		if v3 and not object2:__wf_atom_c138b19b(activateAnim) then
			module.EnableWeaponSlot(object2, "Idol", false, 0)

			if object2:__wf_atom_4417a5d4() then
				object2:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
			end

			module.SetForceAim(object2, mOwner, false)
			module.EnableWeaponFiring(object2, mOwner, true)
			object:__wf_atom_6a4cf64f()
			v3 = false
		end

		if object2:__wf_atom_611b620c() then
			break
		end

		local __wf_atom_0c0ed46d2 = object2:__wf_atom_0c0ed46d()

		if __wf_atom_0c0ed46d2 < __wf_atom_0c0ed46d and not object2:__wf_atom_59cb39a4() then
			break
		end

		local __wf_atom_c6f1f83d2 = object2:__wf_atom_c6f1f83d()

		if
			__wf_atom_c6f1f83d2 < __wf_atom_c6f1f83d
			or object2:__wf_atom_08998754() == 2 and object2:__wf_atom_ee4f0cba() > 1
		then
			break
		end

		local __wf_atom_35a10d3c = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)

		if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
			local state = __wf_atom_35a10d3c:GetState()

			if state == 1 or state == 7 or state == 3 or state == 19 then
				break
			end
		end

		if not v3 and object:__wf_atom_47fbd15c() then
			break
		end

		Sleep(0)
		v -= __wf_atom_084b3e93()
		__wf_atom_c6f1f83d = __wf_atom_c6f1f83d2
		__wf_atom_0c0ed46d = __wf_atom_0c0ed46d2
	end
end

function DeactivateAbility(_, object, _, _)
	object:__wf_atom_9373d0eb(7, false)
	object:Attach(cloakEndPerception, Symbol("GAME_C1_HEAD1"))
	local __wf_atom_f582136d = object:__wf_atom_f582136d(cloakAttachType)

	for i = 1, #__wf_atom_f582136d do
		if not __wf_atom_7e8ad928(__wf_atom_f582136d[i]) then
			__wf_atom_f582136d[i]:Destroy()
		end
	end

	object:Attach(revealAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	object:__wf_atom_68f2c268(1)
	object:SetVisibility(true)
	Sleep(0.4)
	local v2 = 0

	while v2 < 1 and not __wf_atom_7e8ad928(object) do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / 0.2, 0, 1)
		object:__wf_atom_68f2c268(1 - v2)
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(pactFxType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end

		object:__wf_atom_d2b2176d():RemoveUpgrade(103, 2, noiseMultiplier)
	end

	while
		not __wf_atom_7e8ad928(object)
		and (object:__wf_atom_c138b19b(activateAnim) or object:__wf_atom_c138b19b(airAnim))
	do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	module.EnableWeaponSlot(object, "Idol", false, 0)

	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
	end

	module.SetForceAim(object, mOwner, false)
	module.EnableWeaponFiring(object, mOwner, true)
end

function AirStall(object)
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v2 = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v2:__wf_atom_09294a87(0)

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and __wf_atom_c78fa517:__wf_atom_47fbd15c() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v2:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v2:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end
end

function VirtueSwap(p)
	module2.FeyVirtueSwap(p, 0.1, 3)
end