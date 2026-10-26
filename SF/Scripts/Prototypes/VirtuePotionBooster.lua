function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if object:__wf_atom_58dabbc7() or object:__wf_atom_47fbd15c() then
		return false
	end

	return not object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
end

function GiveBooster(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(drinkAnim) then
		object:__wf_atom_921c1a5f(drinkAnim, false, 4, 1, false)
	end

	object:__wf_atom_d2b2176d():AddBoosterItem(boostersRes, duration)
end