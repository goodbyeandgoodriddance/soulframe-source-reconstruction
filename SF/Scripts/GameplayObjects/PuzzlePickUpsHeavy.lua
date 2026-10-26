require("SF.Scripts.Libs.SparrowLib")
local module = require("SF.Scripts.NightFoldLib")
local v = false

function HeavyPickupGameplayModEnabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_aeb02c14(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module.RegisterPreventNighfoldUsage(true)
		object:__wf_atom_51cd6126(Symbol("HelmitHit"), "OnDamaged")
	end

	if gRegion:IsMaster() then
		v = true
	end
end

function HeavyPickupGameplayModDisabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_cf966a74(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module.RegisterPreventNighfoldUsage(false)
		SoulVisionDisable(object)
		object:__wf_atom_3ede53b4(Symbol("HelmitHit"))
	end

	v = false
end

function SoulVisionDisable(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(soulVisionEnableFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

function HelmitStun(p, p2)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = damageRadius
	radialDamageData.baseAmount = 10
	radialDamageData:__wf_atom_6b472125(p)
	radialDamageData:__wf_atom_98d98d81(p2)
	radialDamageData:__wf_atom_d6f4d914(0, true)
	radialDamageData:__wf_atom_d6f4d914(18, true)
	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if not __wf_atom_7e8ad928(castFX) then
		gRegion:CreateEntity(castFX, p2, __wf_atom_80368bb1)
	end

	gRegion:__wf_atom_8d991675(radialDamageData:__wf_atom_e5d0bedf(), radialDamageData.radius, damageDebugAreaColour, 2)
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		__wf_atom_9d766292:__wf_atom_78650070(16)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(19)
	then
		HelmitStun(object, object:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")))
		object:__wf_atom_d2b2176d():__wf_atom_08ff49d5(0)
	end
end

function OnPrePickup(object, _, _)
	if gRegion:IsMaster() then
		object:__wf_atom_d2b2176d():Unequip(0, 2)
	end
end

function OnWeaponDropped(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		__wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_f2f1a00f(object)
		__wf_atom_6009c8ed:__wf_atom_3ede53b4(Symbol("HelmitHit"))
		SoulVisionDisable(__wf_atom_6009c8ed)
	end
end

function DropWeaponFromStagger(object)
	local __wf_atom_6009c8ed = object:__wf_atom_21ed1a39():__wf_atom_6009c8ed()
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()
	HelmitStun(__wf_atom_6009c8ed, __wf_atom_6009c8ed:__wf_atom_1c374cc9(Symbol("GAME_R1_WEAPON1")))
	__wf_atom_d2b2176d:__wf_atom_08ff49d5(0)
end

function PickupEvaluate(p, _)
	return not __wf_atom_7e8ad928(p)
end