function GetNameSafe(object)
	if __wf_atom_7e8ad928(object) then
		return "NULL"
	end

	return object:__wf_atom_5b41f63b()
end

function SafeTestRuneFiring(instance)
	if __wf_atom_7e8ad928(instance) then
		return "weapon is NULL"
	end

	if instance:IsA(__wf_atom_77e05d3b) then
		return instance:__wf_atom_a9c74637()
	end

	return "weapon isn't a SFMeleeWeapon"
end

function MatchAttackEvent(object, object2)
	if not object:__wf_atom_d0af6a2c() or __wf_atom_7e8ad928(object2:__wf_atom_50a7d83e()) then
		return false
	end

	if object:__wf_atom_2319699d(Symbol("RUNE_PROJECTILE")) then
		return true
	end

	local __wf_atom_e55d02aa = object2:__wf_atom_50a7d83e():__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return false
	end

	local __wf_atom_36b4a6e5 = __wf_atom_e55d02aa:__wf_atom_36b4a6e5()

	for _, v in __wf_atom_36b4a6e5 do
		if v:IsActive() and v:IsA(WeakResource("/SF/Upgrades/Motes/BaseRuneAbility")) then
			return true
		end
	end

	return false
end