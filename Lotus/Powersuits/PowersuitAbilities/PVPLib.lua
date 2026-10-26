module(..., package.seeall)
local v = WeakResource("/Lotus/Types/PickUps/CaptureFlagPvpItem")
local v2 = WeakResource("/Lotus/Types/PickUps/CaptureFlagPvpItemB")

local function fn(object, instance)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(instance)
		or not (gGameRules:IsPvpEnabled() or gGameRules:IsA(__wf_atom_3066d015))
	then
		return false
	end

	instance:IsA(__wf_atom_7e6ed5fa)

	if not instance:IsA(__wf_atom_4ebf67cb) then
		return false
	end

	local v3 = Symbol("TENNO")
	local v4 = not object:__wf_atom_129d1aba(instance)

	if v4 then
		if instance:__wf_atom_e93896ba() == v3 then
			v4 = false
		else
			v4 = object:__wf_atom_e93896ba() ~= v3
		end
	end

	if v4 then
		return true
	end

	return false
end

local PVPLib = {}

function PVPLib.IsValidPvpTarget(p, p2)
	return (fn(p, p2))
end

function PVPLib.IsValidNpcTarget(object, instance)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) then
		return false
	end

	return not not instance:IsA(__wf_atom_9e85eea2) and not object:__wf_atom_129d1aba(instance)
end

function PVPLib.ApplySlow(object, p, p2, p3)
	object:__wf_atom_986f733d(p, p2)
	Sleep(p3)
	object:__wf_atom_558ce619(p)
end

function PVPLib.ApplyDisarm(object, p)
	if not object:__wf_atom_8efce136() then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		__wf_atom_d2b2176d:EnableWeaponFiring(false)
		Sleep(p)
		__wf_atom_d2b2176d:EnableWeaponFiring(true)
	end
end

function PVPLib.ApplySilence(_, _)
	return true
end

function PVPLib.ApplyFear(_, _)
	return true
end

function PVPLib.ApplyFrozen(object, p)
	object:__wf_atom_d70bf41b(0)
	Sleep(p)
	object:__wf_atom_d70bf41b(4)
end

function PVPLib.ApplyPvPSlow(object, p, p2)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			local v3 = Symbol("PVP_SLOW_MOVE")
			local v4 = Symbol("PVP_SLOW_PARKOUR")
			local v5 = Symbol("PVP_SLOW_MELEE")

			if p2 then
				__wf_atom_d2b2176d:__wf_atom_56004282(v3, 101, 2, p)
				__wf_atom_d2b2176d:__wf_atom_56004282(v4, 187, 2, p)
				__wf_atom_d2b2176d:__wf_atom_56004282(v5, 315, 2, p, __wf_atom_77e05d3b)
			else
				__wf_atom_d2b2176d:__wf_atom_066a9716(v3, 101, 2, p)
				__wf_atom_d2b2176d:__wf_atom_066a9716(v4, 187, 2, p)
				__wf_atom_d2b2176d:__wf_atom_066a9716(v5, 315, 2, p, __wf_atom_77e05d3b)
			end
		end
	end
end

function PVPLib.DamageOnce(p, p2, p3, list, list2)
	for i = 1, #list do
		for j = 1, #list2 do
			if list[i] == list2[j] then
				return
			end
		end

		if __wf_atom_7e8ad928(list[i]) or not (fn(p, list[i]) or list[i]:IsA(__wf_atom_9e85eea2)) then
			continue
		end

		list[i]:__wf_atom_30d17f39(p3, 2, 0, 0, p, p2)
		table.insert(list2, list[i])
	end
end

function PVPLib.IsPvpEnabled()
	return not __wf_atom_7e8ad928(gGameRules)
		and (gGameRules:IsPvpEnabled() or _T.ArsenalState == 2 or gGameRules:IsA(__wf_atom_3066d015))
end

function PVPLib.IsFightingGame()
	return not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_3066d015)
end

function PVPLib.DisablePassives()
	return not __wf_atom_7e8ad928(gGameRules)
		and gGameRules:IsPvpEnabled()
		and gGameRules:IsA(__wf_atom_88d33e05)
		and gGameRules:DisablePassives()
end

function PVPLib.DropCephalonIfCarrying(object)
	if not __wf_atom_7e8ad928(object) and object:__wf_atom_d2b2176d():__wf_atom_30b6f67d() > 0 then
		local __wf_atom_bd95c25a = object:__wf_atom_d2b2176d():__wf_atom_bd95c25a()

		if __wf_atom_bd95c25a:IsA(v) or __wf_atom_bd95c25a:IsA(v2) then
			object:__wf_atom_d2b2176d():__wf_atom_8f02de07()
		end
	end
end

function PVPLib.ApplyPvPDot(p, instigator, object, baseAmount, p2, p3, value, abilityType)
	local v3 = p2 - 1

	if gRegion:IsMaster() then
		local damageData = Engine.DamageData()
		damageData.baseAmount = baseAmount
		damageData:__wf_atom_7498285f(value or 17, 1)
		damageData:__wf_atom_6b472125(instigator)
		damageData:__wf_atom_34a8a27a(p)
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			__wf_atom_7470861b:DOT(damageData, v3, p3)
		end
	end

	if not __wf_atom_7e8ad928(abilityType) then
		local buffNotification = SF.BuffNotification()
		buffNotification.instigator = instigator
		buffNotification.affected = { object }
		buffNotification.buffType = 1
		buffNotification.isDebuff = true
		buffNotification.abilityType = abilityType
		buffNotification.buffData = v3 * p3
		object:__wf_atom_abdab2f9(buffNotification, true, false)
	end
end

function PVPLib.GetModifiedSoftTargetRadius(p, object, object2)
	return object:__wf_atom_d2b2176d():__wf_atom_2a745663(p, 164, object2:__wf_atom_1bb5b1ff(), object2)
end

return PVPLib