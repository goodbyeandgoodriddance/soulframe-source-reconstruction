local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local v = Symbol("MockeryConjureElementAbility")
local v2 = false

local function fn(object, p)
	local __wf_atom_7470861b = object:__wf_atom_7470861b()

	if p then
		__wf_atom_7470861b:__wf_atom_e2ff9126(16, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(0, v)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, v)
	else
		__wf_atom_7470861b:__wf_atom_fbf4e632(16, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(0, v)
		__wf_atom_7470861b:__wf_atom_56b2394e(3, v)
	end
end

function NpcEvaluateAbility(object, object2)
	if __wf_atom_7e8ad928(thornsScriptTrigger) then
		return 0
	end

	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if
		__wf_atom_9a1e4ed3.visible
		and __wf_atom_9a1e4ed3:__wf_atom_a3309443()
		and npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget)
	then
		object:__wf_atom_f7170fc9(avatar)
		return 1
	else
		return 0
	end
end

function InitializeAbility(_, _) end

function ActivateAbility(p, object, entity)
	object:__wf_atom_51cd6126(Symbol("InteruptDamage"), "OnDamaged")

	if
		__wf_atom_7e8ad928(entity)
		and not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()))
	then
		entity = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().entity
	end

	if __wf_atom_7e8ad928(entity) then
		return
	end

	fn(object, true)
	local v3 = module.PlayAnim(p, introAnim, false, 4, 1, false)
	local v4 = introAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol)) * v3
	Sleep(v4)

	if v2 or __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(entity) then
		gRegion:CreateEntity(thornsScriptTrigger, entity:GetPosition(), entity:__wf_atom_dc309f8a(), object, object)
	end

	Sleep(v3 - v4)

	if v2 or __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return
	end

	local v5 = module.PlayAnim(p, endAnim, false, 4, 1, false)
	Sleep(v5)
end

function DeactivateAbility(_, p, _)
	fn(p, false)
end

function OnDamaged(object)
	if __wf_atom_7e8ad928(mOwner) then
		return
	end

	local __wf_atom_9d766292 = object:__wf_atom_9d766292()

	if __wf_atom_7e8ad928(__wf_atom_9d766292) then
		return
	end

	if
		__wf_atom_9d766292:__wf_atom_78650070(19)
		or __wf_atom_9d766292:__wf_atom_78650070(17)
		or __wf_atom_9d766292:__wf_atom_78650070(18)
	then
		v2 = true
	end
end