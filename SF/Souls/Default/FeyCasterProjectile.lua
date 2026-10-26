local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.TransmissionSet")

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

function NpcEvaluateAbility(_, _)
	return 0
end

local v = {
	["/SF/Souls/Default/FeyWardStoneAbility"] = WeakResource("/SF/Souls/Default/FeyPause.lua"),
	["/SF/Souls/Default/FeyWardFlockAbility"] = WeakResource("/SF/Souls/Default/FeyFlock.lua")
}

function GetAbilityUpgradeLevelInfo()
	_T.AbilityUpgradeLevelInfo = nil

	if not __wf_atom_7e8ad928(_T.AbilityLevelQueryParms.Avatar) then
		local v2 = Symbol("GetAbilityUpgradeLevelInfo")
		local v3 = v[_T.AbilityLevelQueryParms.Ability:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()]

		if v3 then
			_T.AbilityLevelQueryParms.Avatar:__wf_atom_51009507(Resource(v3), v2, true)
		end
	end
end

function ActivateAbility(object, object2, _, p)
	module.magikEnergyCalc(object2, p, mOwner)
	mOwner:__wf_atom_a7328d06(true)

	if object2:__wf_atom_4417a5d4() then
		local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.WardSoulWaitingForNewProjectile = mOwner
	end

	if __wf_atom_7e8ad928(object2) or object2:IsKilled() then
		return
	end

	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	object:__wf_atom_e8008ec5(mOwner)

	if __wf_atom_d2b2176d:__wf_atom_8c72e763() == 2 then
		__wf_atom_d2b2176d:__wf_atom_76425737()
	end

	local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

	while __wf_atom_7e8ad928(__wf_atom_28224c27) or not __wf_atom_28224c27:__wf_atom_ed08f97f() do
		Sleep(0)
		__wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)
	end

	module.EnableWeaponSlot(object2, "Idol", true, 0)

	while __wf_atom_d2b2176d:__wf_atom_d93821d0(0) do
		Sleep(0)
	end

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Equip(0, 0, 2)
	end

	local v2 = false
	local v3 = 1

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) and not v2 and v3 > 0 do
		v2 = __wf_atom_d2b2176d:__wf_atom_a028fd97(0) == 0 or v2
		v3 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if not v2 then
		return
	end

	module.SetForceAim(object2, mOwner, true)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not __wf_atom_7e8ad928(castFxType) then
		object2:Attach(castFxType, EMPTY_SYMBOL)
	end

	module.RemoveCastImmunity(object2)

	if object2:__wf_atom_4417a5d4() and not __wf_atom_7e8ad928(__wf_atom_28224c27) then
		__wf_atom_28224c27:__wf_atom_01e1d257(abilityComboContext)
	end

	local v5 = 1
	local v6 = false

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) and v5 > 0 do
		v6 = not v6 and __wf_atom_28224c27:__wf_atom_9f71ab59() and true or v6
		Sleep(0)
		v5 -= __wf_atom_084b3e93()
	end

	while not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:__wf_atom_9f71ab59() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end
end

function OnNewProjectile(_, object, object2)
	local __wf_atom_6009c8ed = object2:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or not __wf_atom_6009c8ed:__wf_atom_4417a5d4() then
		return
	end

	local __wf_atom_e919fb8e = __wf_atom_6009c8ed:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.WardSoulWaitingForNewProjectile) then
		local wardSoulWaitingForNewProjectile = __wf_atom_e919fb8e.WardSoulWaitingForNewProjectile
		__wf_atom_e919fb8e.WardSoulWaitingForNewProjectile = nil

		while not (__wf_atom_7e8ad928(object) or object:__wf_atom_503c55a5()) do
			Sleep(0)
		end

		if __wf_atom_7e8ad928(object) or not object:__wf_atom_e919fb8e().DelayCooldown then
			wardSoulWaitingForNewProjectile:__wf_atom_a7328d06(false)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	if object:__wf_atom_4417a5d4() then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		local v2 = 0.2

		while v2 > 0 and __wf_atom_e919fb8e.WardSoulWaitingForNewProjectile do
			Sleep(0)
			v2 -= __wf_atom_084b3e93()
		end

		if __wf_atom_e919fb8e.WardSoulWaitingForNewProjectile then
			__wf_atom_e919fb8e.WardSoulWaitingForNewProjectile = nil

			if not __wf_atom_7e8ad928(mOwner) then
				mOwner:__wf_atom_a7328d06(false)
			end
		end
	end

	module.EnableWeaponSlot(object, "Idol", false, 0)

	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
	end

	module.SetForceAim(object, mOwner, false)
end