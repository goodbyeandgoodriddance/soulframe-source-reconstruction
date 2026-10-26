local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")
local stabilityDamage = 150
local v = 1.5

local function fn(p, p2)
	local magikForceCalc = module.magikForceCalc(p2, p, mOwner)
	module.magikEnergyCalc(p2, p, mOwner)

	if p == 1 then
		v = 1.5
		stabilityDamage = 100
	elseif p == 2 then
		v = 1.75
		stabilityDamage = 125
	elseif p == 3 then
		v = 2
		stabilityDamage = 150
	else
		v = 3
		stabilityDamage = 175
	end

	v *= magikForceCalc
	stabilityDamage *= magikForceCalc
end

function EvaluateAbility(object, object2)
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
	local __wf_atom_74d951b0 = __wf_atom_d2b2176d:__wf_atom_74d951b0()
	local position = object2:GetPosition()

	if Distance(__wf_atom_74d951b0, position) > 20 or __wf_atom_7e8ad928(__wf_atom_d2b2176d:__wf_atom_f2e7f4a9()) then
		local __wf_atom_ad19244e = object2:CameraControl():__wf_atom_ad19244e()
		__wf_atom_74d951b0 = __wf_atom_ad19244e + __wf_atom_e97f3142(object2:__wf_atom_4e50d390()) * 10
		gRegion:Raycast(__wf_atom_ad19244e, __wf_atom_74d951b0, object2, nil, __wf_atom_74d951b0)
	end

	gRegion:Raycast(
		__wf_atom_74d951b0 + Vector(0, 0.1, 0),
		__wf_atom_74d951b0 - Vector(0, 10, 0),
		object2,
		nil,
		__wf_atom_74d951b0,
		true
	)
	object:__wf_atom_e638fc23(__wf_atom_74d951b0)
	return true
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, object2, _, p, p2)
	fn(p, object2)
	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	module.EnableWeaponFiring(object2, mOwner, false)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v2

	if not __wf_atom_7e8ad928(pactFxType) then
		v2 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	mOwner:__wf_atom_a7328d06(true)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	module2.OdeIdolDestroy(object2, odeIdolOrbType, false)
	module.RemoveCastImmunity(object2)

	if gRegion:IsMaster() then
		local entity = gRegion:CreateEntity(projectileType, p2, Rotation(0, -90, 0), object2)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object2)
			entity:__wf_atom_c6dbdab6(object)
		end
	end
end

function DeactivateAbility(_, object, _, _)
	repeat
		Sleep(0)
	until __wf_atom_7e8ad928(object) or not object:__wf_atom_c138b19b(activateAnim)

	module.EnableWeaponFiring(object, mOwner, true)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_7b82e9e1(0) then
		object:__wf_atom_9b5dcd3b(orbTossAnim, false, 2, 1, true)
	end
end

function ProjectileScript(object)
	Sleep(0)
	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()
	local __wf_atom_9f2332e5 = object:__wf_atom_9f2332e5()
	local __wf_atom_cc3c265a = __wf_atom_9f2332e5:__wf_atom_cc3c265a((__wf_atom_9f2332e5:__wf_atom_248bb7ae(WeakResource(abilityType))))
	mOwner = __wf_atom_9f2332e5:__wf_atom_e21e8409(WeakResource("/SF/Souls/Ode/OdeShockAbility"))
	fn(__wf_atom_cc3c265a, __wf_atom_7be51ede)
	local damageData = Engine.DamageData()
	damageData.baseAmount = 1
	damageData.stabilityDamage = stabilityDamage
	damageData:__wf_atom_7498285f(5, 1)
	damageData:__wf_atom_6b472125(__wf_atom_7be51ede)
	damageData:__wf_atom_34a8a27a(__wf_atom_9f2332e5)
	local v2 = {}
	local v3 = {}
	Symbol("STAGGER")
	local v4 = Symbol("OdeShock")
	local v5 = Symbol("OnShocked")
	local v6 = -object:__wf_atom_510474d7() / object:__wf_atom_63ba752f()
	object:__wf_atom_e61acfb1(12)
	local v7 = object:Attach(radiusFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(v7) then
		v7:SetMeshScale(12)
	end

	local function fn2()
		for k, v8 in pairs(v3) do
			if __wf_atom_7e8ad928(v8) or not _T.odeShock or not _T.odeShock[k] then
				continue
			end

			local index = table.find(_T.odeShock[k], object)

			if not index then
				continue
			end

			table.remove(_T.odeShock[k], index)

			if not next(_T.odeShock[k]) then
				_T.odeShock[k] = nil
			end
		end
	end

	local entity = gRegion:CreateEntity(
		groundFxType,
		object:GetPosition() + Vector(0, 0.2, 0),
		__wf_atom_80368bb1,
		__wf_atom_7be51ede
	)

	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_503c55a5()) do
		local position = object:GetPosition()

		if _T.odeShieldOrbs and not __wf_atom_7e8ad928(shieldOrbBeamType) then
			for _, odeShieldOrb in ipairs(_T.odeShieldOrbs) do
				local v8 = false

				if __wf_atom_7e8ad928(odeShieldOrb) then
					continue
				end

				local __wf_atom_be0bea4a = odeShieldOrb:__wf_atom_be0bea4a()

				for _, v9 in ipairs(__wf_atom_be0bea4a) do
					if v9:IsA(shieldOrbBeamType) and v9:__wf_atom_8cc00ef8() == object then
						v8 = true
					end
				end

				if v8 then
					continue
				end

				local v9 = odeShieldOrb:Attach(shieldOrbBeamType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

				if __wf_atom_7e8ad928(v9) then
					continue
				end

				v9:__wf_atom_b2394158(object, EMPTY_SYMBOL)
				v9:__wf_atom_8a035cd5(Symbol("BeamUpdate"), false)
			end
		end

		local all = gRegion:FindAll(__wf_atom_4ebf67cb, position, 0, 12)
		local v8 = {}

		for _, v9 in ipairs(all) do
			local __wf_atom_18aa6e58 = v9:__wf_atom_18aa6e58()

			if v9:__wf_atom_129d1aba(__wf_atom_7be51ede) then
				if not v3[__wf_atom_18aa6e58] then
					if not _T.odeShock then
						_T.odeShock = {}
					end

					if _T.odeShock[__wf_atom_18aa6e58] then
						table.insert(_T.odeShock[__wf_atom_18aa6e58], object)
					else
						_T.odeShock[__wf_atom_18aa6e58] = { object }
					end
				end

				v8[__wf_atom_18aa6e58] = v9
				v3[__wf_atom_18aa6e58] = nil
			elseif not v2[__wf_atom_18aa6e58] then
				v2[__wf_atom_18aa6e58] = true
				v9:__wf_atom_649bf33e(damageData)

				if not __wf_atom_7e8ad928(v9) then
					v9:__wf_atom_d2b2176d():__wf_atom_28cf035c()
					object:Attach(orbReactFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v9)

					if not v9:HasTag(v4) then
						v9:__wf_atom_8a035cd5(v5, false)
					end
				end
			end
		end

		fn2()
		v3 = v8

		if v6 > 0 then
			v6 -= __wf_atom_084b3e93()

			if v6 <= 0 then
				object:Stop()
			end
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	fn2()

	if not __wf_atom_7e8ad928(__wf_atom_9f2332e5) then
		__wf_atom_9f2332e5:__wf_atom_e6831c5c(mOwner, Symbol("DoCooldownUnpause"), SF.SecondaryScriptArgs(false))
	end
end

function DoCooldownUnpause(_, _, _, _, _, _, _)
	mOwner:__wf_atom_a7328d06(false)
end

function OnShocked(instance)
	local v2 = Symbol("OdeShock")
	instance:__wf_atom_78128d94(v2)
	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:AddUpgrade(169, 2, v)
	__wf_atom_d2b2176d:AddUpgrade(366, 2, 0.5)
	__wf_atom_d2b2176d:AddUpgrade(292, 2, 0.5)
	local v3 = instance:Attach(targetFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local v4 = 20

	while not instance:IsKilled() and v4 > 0 do
		Sleep(0)
		v4 -= __wf_atom_084b3e93()
	end

	__wf_atom_7470861b:__wf_atom_63396172(v2)
	__wf_atom_d2b2176d:RemoveUpgrade(366, 2, 0.5)
	__wf_atom_d2b2176d:RemoveUpgrade(292, 2, 0.5)
	__wf_atom_d2b2176d:RemoveUpgrade(169, 2, v)

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	instance:RemoveTag(v2)
end

function BeamUpdate(instance)
	local __wf_atom_fdf659dc = instance:__wf_atom_fdf659dc()
	local __wf_atom_8cc00ef8 = instance:__wf_atom_8cc00ef8()
	local __wf_atom_c215662d = instance:__wf_atom_c215662d(__wf_atom_fdf659dc)

	while __wf_atom_c215662d <= 144 and not __wf_atom_7e8ad928(__wf_atom_8cc00ef8) do
		__wf_atom_c215662d = instance:__wf_atom_c215662d((instance:__wf_atom_fdf659dc()))
		__wf_atom_8cc00ef8 = instance:__wf_atom_8cc00ef8()
		Sleep(0)
	end

	instance:Destroy()
end