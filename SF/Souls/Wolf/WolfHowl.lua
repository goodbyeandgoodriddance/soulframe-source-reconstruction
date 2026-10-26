local v = 0.7
local v2 = 7
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(p, instance)
	local magikForceCalc = module.magikForceCalc(instance, p, mOwner)
	module.magikEnergyCalc(instance, p, mOwner)

	if p <= 1 then
		v = 0.1
		v2 = 3
	elseif p == 2 then
		v = 0.2
		v2 = 4
	elseif p == 3 then
		v = 0.3
		v2 = 5
	else
		v = 0.4
		v2 = 6
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
end

function ActivateAbility(object, instance, _, p)
	fn(p, instance)
	local v3 = 30
	local v4 = Symbol("OnHowl")
	local v5 = Symbol("EnemyOnHowl")
	local v6 = Symbol("Howl")
	mOwner:__wf_atom_a7328d06(true)
	mOwner:__wf_atom_d14eed1a()
	module.AddCastImmunity(instance)
	module.Fear(instance, 10)
	instance:MotionControl():__wf_atom_3a1d0c16(instance:__wf_atom_4e50d390())
	Sleep(0)
	local v7 = nil

	if instance:IsA(wolfPlayerType) then
		instance:Attach(castFxWolfType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

		if not module.PlayAnimAndSuspendUntilEvent(object, wolfActivateAnim, "Cast", false, 4, 1, true, 1) then
			return
		end
	else
		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		if not __wf_atom_7e8ad928(pactFxType) then
			v7 = instance:Attach(pactFxType, EMPTY_SYMBOL)
		end

		instance:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

		if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
			return
		end
	end

	module.RemoveCastImmunity(instance)
	local v8 = instance:Attach(rangeDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(v8) then
		v8:SetMeshScale(20)
	end

	if gRegion:IsMaster() then
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, instance:GetPosition(), 0, 20)

		for i = 1, #all do
			if
				not __wf_atom_7e8ad928(all[i])
				and all[i]:__wf_atom_129d1aba(instance)
				and not (all[i]:__wf_atom_bedb4e3f() or all[i]:IsKilled() or all[i]:HasTag(v6))
			then
				all[i]:__wf_atom_8a035cd5(v4, false)
			end

			if __wf_atom_7e8ad928(all[i]) or not all[i]:IsA(EnemyDogType) then
				continue
			end

			if all[i]:__wf_atom_bedb4e3f() or all[i]:IsKilled() or all[i]:__wf_atom_e93896ba() == Symbol("Neutral") then
				continue
			end

			all[i]:__wf_atom_8a035cd5(v5, false)
		end
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	object:__wf_atom_6a4cf64f()

	while v3 > 0 do
		Sleep(0)
		v3 -= __wf_atom_084b3e93()
	end

	mOwner:__wf_atom_a7328d06(false)
end

function OnHowl(instance)
	local v3 = Symbol("Howl")
	instance:__wf_atom_78128d94(v3)
	local v4 = 30
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local v5

	if instance:IsA(wolftype) or instance:IsA(wolfPlayerType) then
		instance:__wf_atom_2f3f52aa(5)
		instance:Heal(instance, instance:GetMaxHealth(true) * 0.5, instance)
		v5 = instance:__wf_atom_bb3e7833(targetWolfFxType)

		if __wf_atom_7e8ad928(v5) then
			v5 = instance:Attach(targetWolfFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		if instance:IsA(wolftype) then
			instance:PlaySound(packWolfBuffGrowl, false, 1, false)
		end
	else
		v5 = instance:__wf_atom_bb3e7833(targetFxType)

		if __wf_atom_7e8ad928(v5) then
			v5 = instance:Attach(targetFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	__wf_atom_d2b2176d:AddUpgrade(283, 3, v)
	__wf_atom_d2b2176d:AddUpgrade(23, 0, v2)

	while not instance:IsKilled() and v4 > 0 do
		Sleep(0)
		v4 -= __wf_atom_084b3e93()
	end

	if instance:IsA(wolftype) then
		instance:__wf_atom_2f3f52aa(2)
	end

	__wf_atom_d2b2176d:RemoveUpgrade(283, 3, v)
	__wf_atom_d2b2176d:RemoveUpgrade(23, 0, v2)

	if not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end

	instance:RemoveTag(v3)
end

function EnemyOnHowl(instance)
	local v3 = Symbol("Howl")
	local v4 = Symbol("Grineer")
	local v5 = Symbol("TENNO")
	instance:__wf_atom_78128d94(v3)
	local v6 = 10
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local v7

	if instance:IsA(EnemyDogType) then
		instance:__wf_atom_2f3f52aa(5)
		v7 = instance:__wf_atom_bb3e7833(targetWolfFxType)

		if __wf_atom_7e8ad928(v7) then
			v7 = instance:Attach(targetWolfFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	instance:SetFaction(v5)
	__wf_atom_d2b2176d:AddUpgrade(283, 3, 1)
	__wf_atom_d2b2176d:AddUpgrade(21, 2, 2)

	while not instance:IsKilled() and v6 > 0 do
		Sleep(0)
		v6 -= __wf_atom_084b3e93()
	end

	if
		not instance:__wf_atom_bedb4e3f()
		and not instance:IsKilled()
		and instance:__wf_atom_e93896ba() ~= Symbol("Neutral")
	then
		instance:SetFaction(v4)
	end

	if instance:IsA(EnemyDogType) then
		instance:__wf_atom_2f3f52aa(0)
	end

	__wf_atom_d2b2176d:RemoveUpgrade(283, 3, 1)
	__wf_atom_d2b2176d:RemoveUpgrade(21, 2, 2)

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	instance:RemoveTag(v3)
end