local module = require("SF.Scripts.Libs.EncounterLib")

function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	if object:__wf_atom_e919fb8e().fleeAlongPatrolRoute then
		return true
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if
		__wf_atom_7e8ad928(__wf_atom_30e3d82b)
		or not __wf_atom_30e3d82b:__wf_atom_17838662()
		or __wf_atom_30e3d82b:__wf_atom_d1d5ef7e() == __wf_atom_28d5d4aa
	then
		return false
	end

	local __wf_atom_76724198 = __wf_atom_30e3d82b:__wf_atom_76724198()

	if
		__wf_atom_7e8ad928(__wf_atom_76724198)
		or not module.IsValidDestinationForEncounter(__wf_atom_30e3d82b:__wf_atom_d1d5ef7e(), __wf_atom_76724198)
	then
		return false
	end

	return true
end

function Activate(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fleeAlongPatrolRoute = true
end

function Update(object, _)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	if
		object:__wf_atom_30e3d82b():__wf_atom_04ea4887()
		or not __wf_atom_7e8ad928(gRegion:__wf_atom_06db1fb1(object:GetPosition(), safeDistance))
	then
		return
	else
		return true
	end
end

function Deactivate(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.fleeAlongPatrolRoute = false
end