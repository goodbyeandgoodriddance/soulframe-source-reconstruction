local v = Symbol("LastBurrowed")

function Evaluate(object, _)
	if onlyEvaluation then
		if burrowingBehavior then
			return not object:__wf_atom_7bcdbf55(burrowAnimActionCheck)
		end

		return object:__wf_atom_7bcdbf55(burrowAnimActionCheck)
	elseif burrowingBehavior then
		return true
	else
		return Time() >= object:__wf_atom_ccd337ec(v)
	end
end

function Activate(object, _)
	if not onlyEvaluation then
		if burrowingBehavior then
			if not object:__wf_atom_7bcdbf55(burrowAnimActionCheck) then
				object:Burrow()
				object:__wf_atom_8d98f2fc(false, false, false)
			end
		elseif object:__wf_atom_7bcdbf55(burrowAnimActionCheck) and Time() >= object:__wf_atom_ccd337ec(v) then
			object:Unburrow(notifyNeighboursOnUnburrow)
			object:__wf_atom_8d98f2fc(true, true, true)
		end
	end
end

function Update(object, _)
	if burrowingBehavior then
		if not object:__wf_atom_7bcdbf55(burrowAnimActionCheck) then
			object:Burrow()
			object:__wf_atom_8d98f2fc(false, false, false)
		end
	elseif object:__wf_atom_7bcdbf55(burrowAnimActionCheck) and Time() >= object:__wf_atom_ccd337ec(v) then
		object:Unburrow(notifyNeighboursOnUnburrow)
		object:__wf_atom_8d98f2fc(true, true, true)
	end
end

function Deactivate(_, _) end