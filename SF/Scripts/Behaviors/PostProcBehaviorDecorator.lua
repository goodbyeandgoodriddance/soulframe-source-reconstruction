local v = Symbol("LastParried")

function Evaluate(object, _)
	local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(v)
	return __wf_atom_ccd337ec > 0 and Time() < __wf_atom_ccd337ec + timeToRemainActivePostProc
end

function Activate(object, _)
	while true do
		local __wf_atom_ccd337ec = object:__wf_atom_ccd337ec(v)

		if Time() >= __wf_atom_ccd337ec + timeToRemainActivePostProc then
			break
		end

		Sleep(0.1)
	end

	return true
end

function Update(_, _) end

function Deactivate(_, _) end

function OnDamage(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if object:__wf_atom_9d766292():__wf_atom_78650070(procToLookFor) then
		object:__wf_atom_cecb2d55(v, Time())
	end
end