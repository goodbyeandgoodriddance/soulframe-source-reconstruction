local v = Symbol("RandomTeam")
local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v2 = 2
local v3 = 0.5

local function fn(p, playerAvatar)
	local magikForceCalc = module.magikForceCalc(playerAvatar, p, mOwner)
	module.magikEnergyCalc(playerAvatar, p, mOwner)

	if p == 1 then
		v3 = 0.1
		v2 = 1
	elseif p == 2 then
		v3 = 0.25
		v2 = 1
	else
		if p == 3 then
			v3 = 0.5
		else
			v3 = 0.75
		end

		v2 = 2
	end

	v3 *= magikForceCalc
	v2 = math.round(v2 * magikForceCalc)
end

local function fn2(instance, p, p2)
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local __wf_atom_7d789620 = __wf_atom_2202ffb6:__wf_atom_7d789620()
	local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)
	local __wf_atom_e919fb8e = playerAvatar:__wf_atom_e919fb8e()

	if not __wf_atom_2202ffb6:ReadyToCreateAgents() then
		return
	end

	while p2 > 0 do
		if __wf_atom_7e8ad928(wolftype) then
			continue
		end

		local v4 = Symbol("OnSpawn")
		local __wf_atom_a06d543c = instance:__wf_atom_a06d543c()
		local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
		__wf_atom_a2a18137.y = instance:EyePosition().y
		local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_a2a18137 + __wf_atom_a06d543c * 5)
		local __wf_atom_2f2bada0 = instance:__wf_atom_2f2bada0()
		local __wf_atom_402b3832 = __wf_atom_7d789620:__wf_atom_402b3832(
			wolftype,
			__wf_atom_0e0a6fee,
			__wf_atom_2f2bada0,
			v,
			p
		)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			continue
		end

		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		__wf_atom_50a7d83e:SetMeshScale(0.55)
		__wf_atom_50a7d83e:__wf_atom_65fd9d84(instance)
		__wf_atom_50a7d83e:__wf_atom_6a95c7b8(playerAvatar)
		__wf_atom_50a7d83e:Attach(
			wolfSummonAttachFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_50a7d83e,
			1
		)
		__wf_atom_50a7d83e:__wf_atom_921c1a5f(summonJumpInAnim, false, 4, 1)
		__wf_atom_50a7d83e:__wf_atom_2f3f52aa(-1)
		local __wf_atom_18aa6e58 = playerAvatar:__wf_atom_18aa6e58()
		table.insert(_T.Wolves[__wf_atom_18aa6e58], __wf_atom_50a7d83e)
		__wf_atom_e919fb8e.numWolves += 1
		p2 -= 1
		__wf_atom_50a7d83e:__wf_atom_8a035cd5(v4, false)

		if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
			__wf_atom_402b3832:__wf_atom_30b587a4()
		end
	end
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, instance, _, p)
	local __wf_atom_a96eb2aa = instance:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local playerAvatar = __wf_atom_a96eb2aa:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	fn(p, playerAvatar)
	local __wf_atom_e919fb8e = playerAvatar:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.numWolves) then
		__wf_atom_e919fb8e.numWolves = 0
	end

	local __wf_atom_18aa6e58 = playerAvatar:__wf_atom_18aa6e58()

	if __wf_atom_7e8ad928(_T.Wolves) then
		_T.Wolves = {}
	end

	if __wf_atom_7e8ad928(_T.Wolves[__wf_atom_18aa6e58]) then
		_T.Wolves[__wf_atom_18aa6e58] = {}
	end

	module.AddCastImmunity(instance)
	module.Fear(instance, 10)
	instance:MotionControl():__wf_atom_3a1d0c16(instance:__wf_atom_4e50d390())
	Sleep(0)
	local v4 = nil

	if instance:IsA(playerWolfType) then
		if not module.PlayAnimAndSuspendUntilEvent(object, wolfActivateAnim, "Cast", false, 4, 1, true, 1) then
			return
		end
	else
		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		if not __wf_atom_7e8ad928(pactFxType) then
			v4 = instance:Attach(pactFxType, EMPTY_SYMBOL)
		end

		if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
			return
		end

		instance:Attach(castFxEnvoyType, EMPTY_SYMBOL)
	end

	module.RemoveCastImmunity(instance)

	if not gRegion:IsMaster() then
		return
	end

	for i = #_T.Wolves[__wf_atom_18aa6e58], 1, -1 do
		local v5 = _T.Wolves[__wf_atom_18aa6e58][i]

		if not (__wf_atom_7e8ad928(v5) or v5:__wf_atom_c6f1f83d() <= 0) then
			continue
		end

		table.remove(_T.Wolves[__wf_atom_18aa6e58], i)
		__wf_atom_e919fb8e.numWolves = math.max(0, __wf_atom_e919fb8e.numWolves - 1)
	end

	while true do
		local v5 = #_T.Wolves[__wf_atom_18aa6e58]

		if not (v2 <= v5) then
			break
		end

		local v6 = _T.Wolves[__wf_atom_18aa6e58][1]
		local __wf_atom_30e3d82b = _T.Wolves[__wf_atom_18aa6e58][1]:__wf_atom_30e3d82b()

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			v6:Destroy()
		else
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Despawn"), v6)
		end

		table.remove(_T.Wolves[__wf_atom_18aa6e58], 1)
		__wf_atom_e919fb8e.numWolves = math.max(0, __wf_atom_e919fb8e.numWolves - 1)
	end

	local __wf_atom_22941262 = object:__wf_atom_22941262()
	fn2(instance, __wf_atom_22941262 < 5 and 5 or __wf_atom_22941262, 1)
	Sleep(1)

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end
end

function OnSpawn(instance)
	local playerAvatar = instance:__wf_atom_6115a2e2():__wf_atom_a96eb2aa():GetPlayerAvatar(0)
	local __wf_atom_e919fb8e = playerAvatar:__wf_atom_e919fb8e()
	local numWolves, v4

	if __wf_atom_e919fb8e.numWolves > 0 then
		numWolves = __wf_atom_e919fb8e.numWolves
		v4 = numWolves * 25
	else
		v4 = 25
		numWolves = 1
	end

	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:AddUpgrade(366, 0, v4, __wf_atom_77e05d3b, nil)
	__wf_atom_d2b2176d:AddUpgrade(84, 3, v3)
	instance:SetHealth(instance:GetMaxHealth(), false)
	local v5 = 260

	while not instance:IsKilled() and v5 > 0 do
		if __wf_atom_e919fb8e.numWolves ~= numWolves then
			numWolves = __wf_atom_e919fb8e.numWolves
			__wf_atom_d2b2176d:RemoveUpgrade(366, 0, v4, __wf_atom_77e05d3b, nil)
			v4 = numWolves * 25
			__wf_atom_d2b2176d:AddUpgrade(366, 0, v4, __wf_atom_77e05d3b, nil)
		end

		Sleep(0)
		v5 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(playerAvatar) then
		local __wf_atom_e919fb8e2 = playerAvatar:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e2.numWolves = math.max(0, __wf_atom_e919fb8e2.numWolves - 1)
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		instance:Destroy()
	else
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Despawn"), instance)
	end
end

function DeactivateAbility(_, _, _, _, _) end

function Evaluate()
	return not (__wf_atom_7e8ad928(despawnAnim) or __wf_atom_7e8ad928(despawnFxType))
end

function Despawn(instance)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(instance) then
		return
	end

	instance:__wf_atom_921c1a5f(nil, false, 3, 2)
	Sleep(0)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	if not __wf_atom_7e8ad928(despawnFxType) then
		instance:Attach(despawnFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance, 1)
	end

	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(despawnAnim, false, 3, 3, true, 1)
	local total = 0

	while total < __wf_atom_921c1a5f do
		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	instance:Destroy()
end