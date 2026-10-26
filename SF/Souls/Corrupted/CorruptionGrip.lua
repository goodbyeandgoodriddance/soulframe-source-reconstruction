local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local selectedTargets = {}
local affectedTargets = {}
local v = 0.25
local v2 = 50
local v3 = 0.2
Symbol("GAME_R1_WEAPON1")
local v4 = 5
local v5 = Symbol("POST_DEATH_ABILITY_ACTIVE")
local v6 = Symbol("BlockingBehavior")

local function fn(object, object2)
	return not __wf_atom_7e8ad928(object2)
		and not (object2:IsKilled() or object2:__wf_atom_129d1aba(object))
		and not gGameRules:__wf_atom_8c3af1a5(object:__wf_atom_e93896ba(), object2:__wf_atom_e93896ba())
		and object2:IsVisible()
end

local function fn2(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 0.25
		v2 = 50
	elseif p == 2 then
		v = 0.3
		v2 = 50
	else
		if p == 3 then
			v = 0.4
		else
			v = 0.45
		end

		v2 = 75
	end

	v = math.min(1, v * magikForceCalc)
	v2 *= magikForceCalc
	v3 = math.min(0.3, v3 * magikForceCalc)
end

local function fn3(attacker)
	local __wf_atom_d2b2176d = attacker:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Unequip(0, 2)

	while
		not __wf_atom_7e8ad928(attacker)
		and not attacker:IsKilled()
		and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14
	do
		__wf_atom_d2b2176d:Unequip(0, 2)
		Sleep(0)
	end
end

function EvaluateAbility(object, object2, p)
	fn2(p, object2)
	local aimPosition = object2:GetAimPosition()
	local v7 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
	local v8 = object2:__wf_atom_0251b5eb(2, 40, 3, true, true, true, true) or {}
	local v9 = {}

	for _, v10 in ipairs(v8) do
		if not (fn(object2, v10) and Dot(v10:__wf_atom_a2a18137() - aimPosition, v7) > 0) then
			continue
		end

		table.insert(v9, v10)
	end

	if #v9 > 0 then
		object:__wf_atom_f7170fc9(v9[1])
	end

	return true
end

function TargetGrip(instance)
	local isMaster = gRegion:IsMaster()
	local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
	local attacker = __wf_atom_e919fb8e.attacker

	if __wf_atom_7e8ad928(instance) and __wf_atom_7e8ad928(attacker) then
		return
	end

	local v7 = Symbol("Vadagar_Hold_Start")
	local v8 = Symbol("Vadagar_Hold_Loop")
	local v9 = Symbol("Vadagar_Hold_End")
	Symbol("AvatarPause")
	__wf_atom_e919fb8e.CorruptionGrip = true
	local v10 = nil
	local v11 = nil
	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_4e4078ea(true)
		__wf_atom_30e3d82b:__wf_atom_b414eabf()
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(v6, attacker, 1)
	end

	if instance:IsA(riderType) then
		return
	end

	local v12 = instance:__wf_atom_ee03557f() - instance:GetPosition()
	local v13 = v12.x > 1.5 or v12.z > 1.5
	local position = instance:GetPosition()
	gRegion:Raycast(position + Vector(0, 2, 0), position - Vector(0, 2, 0), nil, nil, position, true)
	local v14

	if v13 then
		v14 = gRegion:CreateEntity(liftPoolFxTypeLarge, position, __wf_atom_80368bb1, __wf_atom_e919fb8e.attacker)
	else
		v14 = gRegion:CreateEntity(liftPoolFxType, position, __wf_atom_80368bb1, __wf_atom_e919fb8e.attacker)
	end

	local v15 = instance:Attach(liftAttachFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if instance:__wf_atom_464a4772() then
		if v13 then
			v4 /= 1.25
		else
			v4 /= 2
		end

		instance:__wf_atom_d2b2176d():__wf_atom_3c88d02d(v4, 101, 2, 0)
		instance:__wf_atom_58c8ffec(v7, false, 4, 1, true, __wf_atom_5784a397(0, instance:__wf_atom_1ba2008d(v7)))

		while not __wf_atom_7e8ad928(instance) do
			if not (instance:__wf_atom_fc8d8e90(v7, false) or instance:__wf_atom_fc8d8e90(v8, false)) then
				instance:__wf_atom_58c8ffec(
					v8,
					false,
					4,
					2,
					true,
					__wf_atom_5784a397(0, instance:__wf_atom_1ba2008d(v8))
				)
			end

			Sleep(0)

			if instance:__wf_atom_fc8d8e90(v8, false) then
				break
			end
		end
	elseif instance:__wf_atom_7470861b():__wf_atom_3c3be7d2(instance, Engine.DamageData()) then
		instance:__wf_atom_d2b2176d():__wf_atom_3c88d02d(v4, 101, 2, 0)
		instance:__wf_atom_8914dfde("Ragdoll", instance:__wf_atom_921c1a5f(startAnim, false, 3, 1, true))
		v10 = instance:__wf_atom_7470861b():__wf_atom_07e250ed(instance, true)
		instance:__wf_atom_7470861b():__wf_atom_f756036f(false)
		instance:__wf_atom_80db4712(11, 0)
		instance:__wf_atom_5047e0ed(false)
		instance:SetDisableMovement(true)

		if instance:IsA(__wf_atom_7e6ed5fa) and instance:__wf_atom_52077f7a(v5) then
			instance:SetBlackboardBool(v5, false)
			instance:__wf_atom_ec1735df()
		end

		if isMaster then
			local __wf_atom_fec6bb4d = v10:__wf_atom_fec6bb4d(1)

			if not __wf_atom_7e8ad928(__wf_atom_fec6bb4d) then
				v11 = gRegion:__wf_atom_7ab56047(jointType)
				v11:SetAnchor(0, instance:__wf_atom_1c374cc9(Symbol("GAME_C1_HIP1")))
				v11:__wf_atom_7d7cae54(1, __wf_atom_fec6bb4d)
			end
		end

		if not __wf_atom_7e8ad928(instance) then
			v10:SetDisableGravity(true)
		end
	end

	local __wf_atom_c6f1f83d = instance:__wf_atom_c6f1f83d()
	local total = 0
	local flag = false

	while total < v4 and not __wf_atom_7e8ad928(instance) do
		local __wf_atom_c6f1f83d2 = instance:__wf_atom_c6f1f83d()
		local _ = __wf_atom_c6f1f83d2 < __wf_atom_c6f1f83d

		if instance:IsKilled() then
			break
		end

		local __wf_atom_e919fb8e2 = instance:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e2.Exploded) or not __wf_atom_e919fb8e2.Exploded then
			total += __wf_atom_084b3e93()
			Sleep(0)
			__wf_atom_c6f1f83d = __wf_atom_c6f1f83d2
		else
			flag = true
			break
		end
	end

	if not __wf_atom_7e8ad928(v14) then
		if flag then
			v14:SetVisibility(false, true)
		end

		v14:Destroy()
	end

	if not __wf_atom_7e8ad928(v15) then
		if flag then
			v15:SetVisibility(false, true)
		end

		v15:Destroy()
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		__wf_atom_30e3d82b:__wf_atom_4e4078ea(false)
		__wf_atom_30e3d82b:__wf_atom_42b767a2(v6)
	end

	__wf_atom_e919fb8e.CorruptionGrip = false

	if instance:__wf_atom_464a4772() and instance:__wf_atom_fc8d8e90(v8, false) then
		instance:__wf_atom_58c8ffec(v9, false, 4, 1, true, __wf_atom_5784a397(0, instance:__wf_atom_1ba2008d(v9)))
	else
		if not __wf_atom_7e8ad928(v11) then
			gRegion:__wf_atom_dd1e4d10(v11)
		end

		if not (__wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(instance)) then
			v10:SetDisableGravity(false)
			instance:__wf_atom_7470861b():__wf_atom_f756036f(true)
			instance:__wf_atom_5047e0ed(true)
			instance:SetDisableMovement(false)
		end
	end

	if not __wf_atom_7e8ad928(v14) then
		v14:Destroy()
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:Destroy()
	end
end

function ActivateAbility(object, attacker, object2)
	mOwner:__wf_atom_a7328d06(true)
	fn3(attacker)
	module.SetAbilityStats(object, mOwner, {
		affectedTargets = affectedTargets,
		selectedTargets = selectedTargets
	})
	module.EnableWeaponFiring(attacker, mOwner, false)
	module.Fear(attacker, 10)
	module.AddCastImmunity(attacker)
	attacker:MotionControl():__wf_atom_3a1d0c16(attacker:__wf_atom_4e50d390())
	Sleep(0)
	attacker:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v7

	if not __wf_atom_7e8ad928(pactFxType) then
		v7 = attacker:Attach(pactFxType, EMPTY_SYMBOL)
	end

	mOwner:__wf_atom_7ccf4243(chargeFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not module.PlayAnimAndSuspendUntilEvent(object, castStart, "Cast", false, 4, 1, true, 1) then
		return
	end

	module.RemoveCastImmunity(attacker)
	local aimPosition

	if __wf_atom_7e8ad928(object2) then
		aimPosition = attacker:GetAimPosition()
	else
		aimPosition = object2:__wf_atom_a2a18137()
		mOwner:__wf_atom_7ccf4243(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	local all = gRegion:FindAll(__wf_atom_4ebf67cb, aimPosition, 0, 10)

	for _, v8 in ipairs(all) do
		if fn(attacker, v8) then
			object2 = v8
		end
	end

	if __wf_atom_7e8ad928(object2) then
		module.RemoveCastImmunity(attacker)
		module.EnableWeaponFiring(attacker, mOwner, true)
		object:__wf_atom_6a4cf64f()

		while not __wf_atom_7e8ad928(attacker) and attacker:__wf_atom_c138b19b(castStart) do
			Sleep(0)
		end

		mOwner:__wf_atom_a7328d06(false)

		if attacker:__wf_atom_4417a5d4() then
			attacker:__wf_atom_d2b2176d():__wf_atom_1870de39(false)
		end

		Sleep(0.6)

		if not __wf_atom_7e8ad928(v7) then
			v7:Destroy()
		end
	else
		local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.CorruptionGrip = true

		if not module.PlayAnimAndSuspendUntilEvent(object, castEnd, "Cast", false, 4, 1, true, 1) then
			return
		end

		module.RemoveCastImmunity(attacker)
		module.EnableWeaponFiring(attacker, mOwner, true)
		object:__wf_atom_6a4cf64f()
		local v8 = Symbol("TargetGrip")

		if __wf_atom_7e8ad928(all) or not (#all > 1) then
			local __wf_atom_e919fb8e_2 = object2:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e_2.attacker = attacker
			object2:__wf_atom_8a035cd5(v8, false)
		else
			for _, v9 in ipairs(all) do
				if not fn(attacker, v9) then
					continue
				end

				local __wf_atom_e919fb8e_2 = v9:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e_2.attacker = attacker
				v9:__wf_atom_8a035cd5(v8, false)
			end
		end

		Sleep(0.6)

		if not __wf_atom_7e8ad928(v7) then
			v7:Destroy()
		end

		mOwner:__wf_atom_d14eed1a()
		mOwner:__wf_atom_a7328d06(false)
	end
end

function DeactivateAbility(_, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(castStart) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
	end
end