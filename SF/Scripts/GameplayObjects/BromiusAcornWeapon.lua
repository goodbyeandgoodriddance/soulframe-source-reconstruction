local module = require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.NightFoldLib")
local v = nil
local v2 = nil

function findPlantingSpot(object)
	local nearestTagged = gRegion:FindNearestTagged(Symbol("AcornPlantingTrigger"), object:GetPosition())

	if __wf_atom_7e8ad928(nearestTagged) then
		return nil
	end

	if nearestTagged:IsEnabled() then
		return nearestTagged
	end

	return nil
end

function BromiusAcornGameplayModEnabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("BromiusAcornsPlanted"))
	object:__wf_atom_aeb02c14(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module2.RegisterPreventNighfoldUsage(true, "BromiusAcornWeapon")
		object:__wf_atom_51cd6126(Symbol("AcornHit"), "OnDamaged")
	end

	if not (__wf_atom_7e8ad928(__wf_atom_d163c8e5) or __wf_atom_7e8ad928(_T.acornsToPlant)) then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			Symbol("AcornPlantingTrigger"),
			object:GetPosition(),
			0,
			20
		)
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
			Symbol("FinalAcornPlantingTrigger"),
			object:GetPosition(),
			0,
			20
		)

		if not __wf_atom_7e8ad928(__wf_atom_439c0d29) then
			v = module.GetSparrowForPlayer(object)

			if __wf_atom_7e8ad928(v) then
				Sleep(0.5)
				_T.SparrowMode = "KeepActive"
				object:__wf_atom_4bf6f27a(true)
				v = module.GetSparrowForPlayer(object)
			end

			if __wf_atom_d163c8e5 == _T.acornsToPlant - 1 then
				v2 = __wf_atom_f738b4af
			end

			if __wf_atom_d163c8e5 < _T.acornsToPlant then
				while __wf_atom_7e8ad928(v2) do
					v2 = findPlantingSpot(object)
					Sleep(0.5)

					if __wf_atom_7e8ad928(object) then
						return
					end
				end
			end

			if not __wf_atom_7e8ad928(v2) and v2:IsEnabled() then
				module.AddSparrowDestination(v2, nil, "PlantPoint", module.PRIORITY.QUEST, nil)
			end
		end
	end

	_T.acornHeld = true
end

function BromiusAcornGameplayModDisabled(object)
	if __wf_atom_7e8ad928(inputFilter) or __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_cf966a74(inputFilter)
	object:MotionControl():__wf_atom_99fc7a82(forceWalk)

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_4417a5d4() then
		module2.RegisterPreventNighfoldUsage(false, "BromiusAcornWeapon")
		object:__wf_atom_3ede53b4(Symbol("AcornHit"))
	end

	module.RemoveSparrowDestination(nil, "PlantPoint")
	_T.acornHeld = false
end

function OnDamaged(object)
	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if
		(__wf_atom_9d766292:__wf_atom_78650070(16) or __wf_atom_9d766292:__wf_atom_78650070(17) or __wf_atom_9d766292:__wf_atom_78650070(19))
		and __wf_atom_9d766292:__wf_atom_78650070(19)
	then
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
		__wf_atom_6009c8ed:__wf_atom_3ede53b4(Symbol("AcornHit"))
	end
end

function DropWeaponFromStagger(object)
	object:__wf_atom_21ed1a39():__wf_atom_6009c8ed():__wf_atom_d2b2176d():__wf_atom_08ff49d5(0)
end

function PickupEvaluate(p, _)
	return not __wf_atom_7e8ad928(p)
end