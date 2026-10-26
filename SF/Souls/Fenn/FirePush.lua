local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 100
local v2 = 8

function EvaluateAbility(object, object2, _)
	local __wf_atom_5d790fbf = object2:__wf_atom_92aa9d91():__wf_atom_5d790fbf()

	if
		__wf_atom_7e8ad928(__wf_atom_5d790fbf)
		or not __wf_atom_5d790fbf:IsA(__wf_atom_4ebf67cb)
		or __wf_atom_5d790fbf:IsKilled()
		or __wf_atom_5d790fbf:__wf_atom_129d1aba(object2)
	then
		return true
	end

	object:__wf_atom_f7170fc9(__wf_atom_5d790fbf)
	return true
end

function NpcEvaluateAbility(_, _)
	return 0
end

local function fn(object, p)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 100
		v2 = 4
	elseif p == 2 then
		v = 200
		v2 = 5
	elseif p == 3 then
		v = 250
		v2 = 6
	else
		v = 300
		v2 = 7
	end

	v *= magikForceCalc
	v2 *= magikForceCalc
end

function ActivateAbility(object, object2, _, p)
	fn(object2, p)
	object2:__wf_atom_d2b2176d()
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if object2:__wf_atom_4417a5d4() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	module.AddCastImmunity(object2)
	module.Fear(object2, 10)
	object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	module.EnableWeaponFiring(object2, mOwner, false)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v3

	if not __wf_atom_7e8ad928(pactFxType) then
		v3 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	module.RemoveCastImmunity(object2)
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Hand)
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
	__wf_atom_4e50d390.bank = 210
	local entity = gRegion:CreateEntity(projectileType, __wf_atom_1c374cc9, __wf_atom_4e50d390, object2)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object2)
		entity:__wf_atom_c6dbdab6(object)
		entity:__wf_atom_533c6916(v)
		entity:__wf_atom_ac3c846c(150)
		entity:__wf_atom_e61acfb1(v2)
		entity:__wf_atom_350ac13e(100)

		if not object2:__wf_atom_8efce136() then
			entity:__wf_atom_c2d9fb01(0)
		end
	end
end

function DeactivateAbility(_, object, _, _, _)
	if object:__wf_atom_4417a5d4() then
		object:__wf_atom_92aa9d91():__wf_atom_e7914caa(false)
	end

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		module.EnableWeaponSlot(object, "Idol", false, 0)

		if object:__wf_atom_4417a5d4() then
			object:__wf_atom_d2b2176d():__wf_atom_1870de39(true)
		end
	end

	module.EnableWeaponFiring(object, mOwner, true)
end

function OnHit(object, instance)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_67c46eba) then
		return
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if not __wf_atom_7e8ad928(__wf_atom_7be51ede) and __wf_atom_7be51ede:__wf_atom_631bafa1() then
		local __wf_atom_e55d02aa = __wf_atom_7be51ede:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if instance:__wf_atom_7470861b():__wf_atom_b76d107d(3) then
			local radialDamageData = Engine.RadialDamageData()
			radialDamageData.baseAmount = 20
			radialDamageData.radius = 10
			radialDamageData:__wf_atom_7498285f(3, 1)
			radialDamageData:__wf_atom_d6f4d914(3, true)
			radialDamageData:__wf_atom_6b472125(__wf_atom_7be51ede)
			radialDamageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
			radialDamageData:__wf_atom_12cf5317(100)
			radialDamageData.fallOff = 0
			radialDamageData.checkForCover = true
			radialDamageData.staticCoverOnly = true
			radialDamageData:__wf_atom_98d98d81(instance:__wf_atom_a2a18137())
			gRegion:__wf_atom_f6ec80de(radialDamageData)
		end
	end

	object:Die()
end