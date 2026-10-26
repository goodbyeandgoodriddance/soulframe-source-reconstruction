function Evaluate(object, _)
	if __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f() then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or object:__wf_atom_d2b2176d():__wf_atom_9f71ab59(true)
	then
		return false
	end

	if object:__wf_atom_296472bc().mIsFishing then
		return true
	end

	return false
end

function ActivateAbility(object, object2)
	if object:__wf_atom_4417a5d4() then
		local __wf_atom_296472bc = object:__wf_atom_296472bc()
		__wf_atom_296472bc.mLureItem = object2:__wf_atom_e14d8a8c()
		object:__wf_atom_aabc9a96(__wf_atom_296472bc)
	end

	object:PlaySound(fishingLureSelectSound, false)
	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		if __wf_atom_a96eb2aa:IsLocal() then
			gGameData:__wf_atom_a6b3ae2b(object2:__wf_atom_1bb5b1ff())
		end

		__wf_atom_a96eb2aa:__wf_atom_99136c7a(object2:__wf_atom_1bb5b1ff())
	end
end