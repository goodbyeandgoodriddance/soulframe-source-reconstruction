local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = 25

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_9a1e4ed3.visible
		and not __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		and not __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		and __wf_atom_9a1e4ed3.distanceToTarget >= npcMinRange
		and __wf_atom_9a1e4ed3.distanceToTarget <= npcMaxRange
	then
		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	else
		return 0
	end
end

function EvaluateAbility(p, p2)
	return module.EvaluateUltAbility(p, p2)
end

local function fn(object, object2) -- 1 equivalent call inferred from this helper
	local selected

	if __wf_atom_7e8ad928(object2) then
		selected = object:__wf_atom_0e1e5bc9()
	else
		selected = __wf_atom_fa8d0177(object:__wf_atom_a2a18137(), object2:__wf_atom_a2a18137())
	end

	selected.pitch = 0
	selected.bank = 0
	return selected
end

function ActivateAbility(object, object2, _, _)
	print("ActivateAbility: CrossBolt")
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
		object2:__wf_atom_d2b2176d():Unequip(0)
	end

	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	__wf_atom_d2b2176d:__wf_atom_ec33d862(0)

	while not object2:IsKilled() and __wf_atom_7e8ad928((__wf_atom_d2b2176d:__wf_atom_28224c27(0))) do
		Sleep(0)
	end

	if object2:__wf_atom_4417a5d4() then
		__wf_atom_d2b2176d:Equip(0, 0, 2)
	end

	if object2:__wf_atom_8efce136() then
		_T.ForceReticle = true
	end

	__wf_atom_d2b2176d:__wf_atom_b9375444(false)
	Symbol("GAME_R1_ARM3")
	module.SetForceAim(object2, mOwner, true)
	object2:__wf_atom_8a035cd5(Symbol("AdjustTorso"), false)
	module.RemoveCastImmunity(object2)
	local __wf_atom_535d5cbb = object2:__wf_atom_535d5cbb()

	if __wf_atom_535d5cbb then
		object2:MotionControl():__wf_atom_3959d938(true)
		object2:__wf_atom_84d66e8e(object2:__wf_atom_0e1e5bc9())
		Sleep(0)

		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		if not __wf_atom_7e8ad928(pactFxType) then
			object2:Attach(pactFxType, EMPTY_SYMBOL)
		end

		module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 3, false)
	elseif not __wf_atom_7e8ad928(activateAnim) then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
		local v2 = object2:__wf_atom_9b5dcd3b(activateAnim, false, 2, 1, true) * activateAnim:__wf_atom_091354f5(Symbol("Cast"))

		while v2 > 0 do
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local v3 = fn(object2, __wf_atom_216d6edd) -- inferred equivalent call
					object2:__wf_atom_cc999c7b(__wf_atom_216d6edd:__wf_atom_a2a18137())
					object2:__wf_atom_51075230(v3)
				end
			end

			Sleep(0)
			v2 -= __wf_atom_084b3e93()
		end
	end

	module.PlayAnim(object, holdAnim, false, 2, 2, true, 0.5, object2)
	module.EnableWeaponSlot(object2, "Idol", true, 0)

	if __wf_atom_535d5cbb then
		local __wf_atom_e8008ec5 = object:__wf_atom_e8008ec5(mOwner)
		object:__wf_atom_3fe03b9d()
		object:__wf_atom_ac42b904(__wf_atom_e8008ec5, 148)

		while
			not __wf_atom_7e8ad928(object2)
			and (object2:__wf_atom_c138b19b(holdAnim, true) or object2:__wf_atom_3c281634(holdAnim))
		do
			Sleep(0)
		end
	end
end

function DeactivateAbility(object, object2, object3, p)
	object:__wf_atom_ac42b904(object:__wf_atom_e8008ec5(mOwner))
	local magikForceCalc = module.magikForceCalc(object2, p, mOwner)
	module.magikEnergyCalc(object2, p, mOwner)

	if p == 1 then
		v = 100
	end

	if p == 2 then
		v = 200
	end

	if p == 3 then
		v = 250
	end

	if p >= 4 then
		v = 300
	end

	v *= magikForceCalc

	if object2:__wf_atom_c138b19b(holdAnim, true) or object2:__wf_atom_3c281634(holdAnim) then
		local __wf_atom_535d5cbb = object2:__wf_atom_535d5cbb()
		local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
		local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()

		if not (__wf_atom_535d5cbb or __wf_atom_7e8ad928(object3)) then
			__wf_atom_4e50d390 = __wf_atom_fa8d0177(
				__wf_atom_1c374cc9,
				object3:__wf_atom_7470861b():__wf_atom_96c119f5(npcAimAtBodyPart)
			)
		end

		local __wf_atom_74d951b0 = object2:__wf_atom_d2b2176d():__wf_atom_74d951b0()

		if not (object2:__wf_atom_535d5cbb() or __wf_atom_7e8ad928(object3)) then
			__wf_atom_74d951b0 = object3:EyePosition()
		end

		local __wf_atom_4227f14a = object:__wf_atom_4227f14a()
		local entity = gRegion:CreateEntity(projectileType, __wf_atom_4227f14a, __wf_atom_4e50d390, object)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_8fcdea81(object2)
			entity:__wf_atom_c6dbdab6(object)
			entity:__wf_atom_533c6916(v)
			entity:__wf_atom_ac3c846c(v / 3)
			entity:__wf_atom_350ac13e(v)
			entity:__wf_atom_9866bacc(31, true)
			entity:__wf_atom_facb3053(4)
			entity:__wf_atom_129183dd(__wf_atom_1c374cc9, __wf_atom_74d951b0)
		end
	end

	if object2:__wf_atom_8efce136() then
		_T.ForceReticle = false
	end

	if not __wf_atom_7e8ad928(object2) then
		module.PlayAnimAndSuspendUntilEvent(object, fireAnim, "Cast", false, 4, 1, false)

		if __wf_atom_7e8ad928(object2) then
			print("DeactivateAbility: CrossBolt: InstigatorAvatar is Null!")
			return
		end

		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		object2:__wf_atom_92aa9d91():SetForceAim(false)
		object2:MotionControl():__wf_atom_3959d938(false)
		__wf_atom_d2b2176d:__wf_atom_d5651846()
		__wf_atom_d2b2176d:__wf_atom_b9375444(true)
		object:__wf_atom_6a4cf64f()
		module.EnableWeaponFiring(object2, mOwner, true)
	end

	module.EnableWeaponFiring(object2, mOwner, true)
	module.EnableWeaponSlot(object2, "", true, 0)
	module.SetForceAim(object2, mOwner, false)
	module.EnableWeaponSlot(object2, "Idol", false, 0)

	if gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
		object2:__wf_atom_d2b2176d():Unequip(0)
		object2:__wf_atom_d2b2176d():Equip(5, 0, 2)
	end

	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(pactFxType)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	print("DeactivateAbility: CrossBolt")
end

function AdjustTorso(object)
	object:__wf_atom_e919fb8e()
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v2 = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v2:__wf_atom_09294a87(0)

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and not mOwner:__wf_atom_9e62504e() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v2:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v2:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		object:__wf_atom_187571ae(0, -object:__wf_atom_ed1dbb61())
		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end

	object:__wf_atom_ae3321f6()
end