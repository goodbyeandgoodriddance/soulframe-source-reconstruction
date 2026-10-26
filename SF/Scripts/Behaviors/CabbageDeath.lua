function easeOutElastic(p)
	if p == 0 then
		return 0
	elseif p == 1 then
		return 1
	end

	return math.pow(2, -10 * p) * math.sin((p * 10 - 0.75) * 2.0943951023931953) + 1
end

function CabbageDeath(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not (__wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_6009c8ed:IsKilled()) then
		return
	end

	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local v = Vector(0, 0, 0)
	local v2 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_3ae8d73b
	}
	gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137 + Vector(0, 1, 0), __wf_atom_a2a18137 - Vector(0, 1, 0), v2, nil, v)
	gRegion:CreateEntity(cabbageType, v, __wf_atom_80368bb1)
	local v3 = 0

	while v3 < 1 and not __wf_atom_7e8ad928(object) do
		v3 = __wf_atom_421b01aa(v3 - __wf_atom_084b3e93() * -0.85, 0, 1)
		object:SetMeshScale((math.max(0.001, 1 - v3 * 2.5)))
		object:__wf_atom_a763aa1a(__wf_atom_24a82b69(v3))
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		gRegion:__wf_atom_dd1e4d10(object)
	end
end

function CabbageSpawner(object)
	local total = 0

	while total < finalScale and not __wf_atom_7e8ad928(object) do
		total += __wf_atom_084b3e93() * 0.8
		object:SetMeshScale(easeOutElastic(total) * finalScale, true)
		Sleep(0)
	end
end