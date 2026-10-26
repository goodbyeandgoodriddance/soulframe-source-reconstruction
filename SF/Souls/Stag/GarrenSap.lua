local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")
local baseAmount = 20
local v = 0.5
local v2 = 0.2
local v3 = 100

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 0.25
		v3 = 50
	elseif p == 2 then
		v = 0.3
		v3 = 50
	else
		if p == 3 then
			v = 0.4
		else
			v = 0.45
		end

		v3 = 75
	end

	v = math.min(1, v * magikForceCalc)
	v3 *= magikForceCalc
	v2 = math.min(0.3, v2 * magikForceCalc)
end

local function fn2(object, instance)
	return not __wf_atom_7e8ad928(instance)
		and not (instance:IsKilled() or instance:__wf_atom_129d1aba(object))
		and not instance:HasTag(mOwner:__wf_atom_37768748())
		and instance:IsVisible()
end

function EvaluateAbility(object, object2, p)
	fn(p, object2)
	local aimPosition = object2:GetAimPosition()
	local v4 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
	local v5 = object2:__wf_atom_0251b5eb(2, 20, 2, true, true, false, false) or {}
	local v6 = {}

	for _, v7 in ipairs(v5) do
		if not (fn2(object2, v7) and Dot(v7:__wf_atom_a2a18137() - aimPosition, v4) > 0) then
			continue
		end

		table.insert(v6, v7)
	end

	if #v6 > 0 then
		object:__wf_atom_f7170fc9(v6[1])
	end

	return true
end

function NpcEvaluateAbility(_, _)
	return 0
end

function FeyBowUpdate(p)
	module2.VirtueSwap(p)
end

function ActivateAbility(object, object2, object3, p)
	fn(p, object2)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v4

	if not __wf_atom_7e8ad928(pactFxType) then
		v4 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)
	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	Sleep(0)

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Destroy()
	end

	object2:Attach(castBurstFxType, EMPTY_SYMBOL)
	module.RemoveCastImmunity(object2)
	local v5 = Symbol("DoSap")
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	local position

	if not __wf_atom_7e8ad928(object3) then
		position = object3:GetPosition()
	end

	local v6 = Rotation(__wf_atom_4e50d390.heading, 0, 0)
	local v7 = object2:GetPosition() + __wf_atom_9341614d(Vector(0.5, 1.6, -1), v6) + __wf_atom_9341614d(Vector(0, 0, 20), __wf_atom_4e50d390)

	if __wf_atom_7e8ad928(position) then
		gRegion:CreateEntity(failFxType, v7, v6, object2)
	else
		gRegion:CreateEntity(successFxType, position + Vector(0, 1, 0), v6, object2)
	end

	if __wf_atom_7e8ad928(position) then
		return
	end

	if not __wf_atom_7e8ad928(targetImpactSound) then
		gRegion:PlaySound(targetImpactSound, object3:GetPosition(), false, 0, object2, nil, nil, false)
	end

	object3:__wf_atom_8a035cd5(v5, false)
end

function DeactivateAbility(_, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

function DoSap(instance)
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()
	local __wf_atom_6009c8ed = __wf_atom_c78fa517:__wf_atom_6009c8ed()
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	instance:__wf_atom_78128d94(__wf_atom_37768748)
	baseAmount = instance:__wf_atom_c6f1f83d() * v

	if instance:__wf_atom_464a4772() then
		baseAmount = instance:__wf_atom_c6f1f83d() * v2
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()
	local damageFxType = damageFxType

	if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_11cb6d4a() then
		if instance:__wf_atom_464a4772() then
			baseAmount *= 1.1
		else
			baseAmount *= 2
		end

		damageFxType = damageComboFxType
	end

	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount
	damageData:__wf_atom_7498285f(19, 1)
	damageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	damageData:__wf_atom_34a8a27a(__wf_atom_c78fa517)
	damageData.criticalChance = 0.25
	damageData.stabilityDamage = damageData.baseAmount * 2
	damageData.blockableProjType = 4
	local isMaster = gRegion:IsMaster()
	instance:__wf_atom_c6f1f83d()
	local v4

	if isMaster then
		local __wf_atom_bb81a9df = instance:__wf_atom_bb81a9df()
		instance:__wf_atom_649bf33e(damageData)
		v4 = __wf_atom_bb81a9df - instance:__wf_atom_bb81a9df()
		instance:Attach(damageFxType, EMPTY_SYMBOL)
	else
		v4 = 1
	end

	local __wf_atom_a2a18137 = instance:__wf_atom_a2a18137()
	local __wf_atom_89c94ab8 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_89c94ab8(false)
	local all = gRegion:FindAll(__wf_atom_4ebf67cb, __wf_atom_a2a18137, 0, __wf_atom_89c94ab8)
	local v5 = {}

	for _, v6 in ipairs(all) do
		if v6:__wf_atom_4402f880(__wf_atom_6009c8ed) then
			v5[1] = v6
		end
	end

	local v6 = Symbol(__wf_atom_37768748:c_str() .. "_ATTKSpeed")

	for _, v7 in ipairs(v5) do
		if v7:__wf_atom_bb81a9df() > 0.99 then
			v7:__wf_atom_d2b2176d():__wf_atom_0f765e85(v6, 5, 401, 3, 0.1)
			local __wf_atom_bb3e7833 = v7:__wf_atom_bb3e7833(damageFxType)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			v7:Attach(buffFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		else
			local v8 = v7:GetMaxHealth(true) * v4
			v7:Heal(
				v7,
				__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
					v8,
					473,
					nil,
					nil,
					26,
					Symbol("HEAL_FROM_CAST")
				),
				__wf_atom_6009c8ed
			)
			v7:Attach(healFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end
	end

	instance:RemoveTag(__wf_atom_37768748)
end