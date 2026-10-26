function ShieldHit(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local __wf_atom_bb3e7833 = __wf_atom_575542c8:__wf_atom_bb3e7833(shieldType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	__wf_atom_bb3e7833:__wf_atom_8a035cd5(Symbol("ShieldFade"), false)
end

function ShieldFade(object)
	local v = 0

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / 0.6, 0, 1)
		local v2 = 1 - math.pow(1 - v, 3)
		object:SetMaterialParam(Symbol("UnlitAtten"), __wf_atom_104bfe98(50, 0.5, v2))
		object:SetMaterialParam(Symbol("uvOffsetFade"), __wf_atom_104bfe98(0, 1, v2))
		Sleep(0)
	end
end