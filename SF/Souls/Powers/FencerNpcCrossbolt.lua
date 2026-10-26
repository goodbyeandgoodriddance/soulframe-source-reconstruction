local module = require("Lotus.Scripts.Libs.AbilitiesLib")

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

function ActivateAbility(object, object2, object3, _)
	print("ActivateAbility: CrossBolt")
	local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()

	if gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
		object2:__wf_atom_d2b2176d():Unequip(0)
	end

	module.EnableWeaponFiring(object2, mOwner, false)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	__wf_atom_d2b2176d:__wf_atom_ec33d862(0)
	module.SetForceAim(object2, mOwner, true)
	local v = false
	local v2 = 2

	while not object2:IsKilled() do
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(0)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			break
		end

		Sleep(0)

		if __wf_atom_7e8ad928(__wf_atom_28224c27) and not v then
			object2:GiveItem(weaponToUse, false)
			v = true
		end

		v2 -= __wf_atom_084b3e93()

		if v2 <= 0 then
			return
		end
	end

	if gRegion:IsMaster() and not object2:__wf_atom_535d5cbb() then
		object2:__wf_atom_d2b2176d():Equip(0, 0, 2)
	end

	Symbol("GAME_R1_ARM3")
	object2:__wf_atom_d2b2176d():__wf_atom_ec33d862(0)
	module.SetForceAim(object2, mOwner, true)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	object2:__wf_atom_8a035cd5(Symbol("AdjustTorso"), false)
	local __wf_atom_8e96c598 = object:__wf_atom_8e96c598(4)
	local v3

	if not __wf_atom_7e8ad928(__wf_atom_8e96c598) then
		v3 = object2:Attach(__wf_atom_8e96c598, EMPTY_SYMBOL)
	end

	module.RemoveCastImmunity(object2)

	if not __wf_atom_7e8ad928(v3) then
		v3:Destroy()
	end

	local __wf_atom_535d5cbb = object2:__wf_atom_535d5cbb()

	if __wf_atom_535d5cbb then
		local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
		object2:MotionControl():__wf_atom_3a1d0c16(__wf_atom_4e50d390)
		object2:__wf_atom_84d66e8e(object2:__wf_atom_0e1e5bc9())
		Sleep(0)
		module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, false)
	elseif not __wf_atom_7e8ad928(activateAnim) then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
		local v4 = object2:__wf_atom_9b5dcd3b(activateAnim, false, 2, 1, true) * activateAnim:__wf_atom_091354f5(Symbol("Cast"))

		while v4 > 0 do
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local v5 = fn(object2, __wf_atom_216d6edd) -- inferred equivalent call
					object2:__wf_atom_cc999c7b(__wf_atom_216d6edd:__wf_atom_a2a18137())
					object2:__wf_atom_51075230(v5)
				end
			end

			Sleep(0)
			v4 -= __wf_atom_084b3e93()
		end
	end

	module.EnableWeaponSlot(object2, "Idol", true, 0)
	local __wf_atom_1c374cc9 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1"))
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()

	if not (__wf_atom_535d5cbb or __wf_atom_7e8ad928(object3)) then
		__wf_atom_4e50d390 = __wf_atom_fa8d0177(
			__wf_atom_1c374cc9,
			object3:__wf_atom_7470861b():__wf_atom_96c119f5(npcAimAtBodyPart)
		)
	end

	local entity = gRegion:CreateEntity(projectileType, __wf_atom_1c374cc9, __wf_atom_4e50d390, object)

	if not __wf_atom_7e8ad928(_T.WaitForShoot) then
		_T.WaitForShoot = 1
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_8fcdea81(object2)
		entity:__wf_atom_c6dbdab6(object)
	end
end

function DeactivateAbility(object, object2, _, _)
	while
		not __wf_atom_7e8ad928(object2)
		and (object2:__wf_atom_c138b19b(activateAnim) or object2:__wf_atom_3c281634(activateAnim))
	do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object2) then
		local __wf_atom_d2b2176d = object2:__wf_atom_d2b2176d()
		object2:__wf_atom_92aa9d91():SetForceAim(false)
		__wf_atom_d2b2176d:__wf_atom_d5651846()
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

	print("DeactivateAbility: CrossBolt")
end

function AdjustTorso(object)
	object:__wf_atom_e919fb8e()
	local __wf_atom_59cb39a4 = object:__wf_atom_59cb39a4()

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, true)
	end

	local v = __wf_atom_10cd16b2(object:__wf_atom_9f57166e(), 0.5)
	v:__wf_atom_09294a87(0)

	while not __wf_atom_7e8ad928(mOwner) and mOwner:IsActive() and not mOwner:__wf_atom_9e62504e() do
		if __wf_atom_59cb39a4 then
			if object:__wf_atom_59cb39a4() then
				v:Update(__wf_atom_084b3e93())
				object:__wf_atom_4c3f8902(v:__wf_atom_9e368823())
			else
				module.EnableAimGlide(object, mOwner, false)
				__wf_atom_59cb39a4 = false
			end
		end

		object:__wf_atom_187571ae(0, -object:__wf_atom_ed1dbb61() * 2)
		Sleep(0)
	end

	if __wf_atom_59cb39a4 then
		module.EnableAimGlide(object, mOwner, false)
	end

	object:__wf_atom_ae3321f6()
end