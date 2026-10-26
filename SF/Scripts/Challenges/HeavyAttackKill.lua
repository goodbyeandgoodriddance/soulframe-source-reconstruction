local v = 6
local v2 = 4
local v3 = 16
local v4 = 15
local v5 = 11

function IsHeavyAttack(p)
	return p == v or p == v2 or p == v3 or p == v4 or p == v5
end

function MatchAttackEvent(object, _)
	if not object:__wf_atom_d0af6a2c() then
		return false
	end

	local __wf_atom_3371f607 = object:__wf_atom_3371f607()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_3371f607:IsA(__wf_atom_77e05d3b) then
		local __wf_atom_75a0566d = __wf_atom_3371f607:__wf_atom_75a0566d()
		return not __wf_atom_7e8ad928(__wf_atom_75a0566d) and IsHeavyAttack(__wf_atom_75a0566d:__wf_atom_f824cfe6())
	end

	return false
end