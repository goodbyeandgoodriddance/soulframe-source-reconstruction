function Evaluate(_, _)
	return true
end

function Activate(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

		if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
			return
		else
			gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
				perceptionType,
				interestSubType,
				object:GetPosition(),
				__wf_atom_9a1e4ed3.avatar,
				perceptionRange.minValue,
				perceptionRange.maxValue
			)
		end
	end
end

function Update(_, _)
	return true
end

function Deactivate(_, _) end