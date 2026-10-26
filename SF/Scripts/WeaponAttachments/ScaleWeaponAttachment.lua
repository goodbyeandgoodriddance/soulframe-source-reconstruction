function ScaleAttachment(object)
	if object:__wf_atom_21ed1a39():GetState() == 17 or scaleTime <= __wf_atom_084b3e93() then
		object:SetMeshScale(toScale, true)
		return
	end

	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local v = 0

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / scaleTime, 0, 1)
		object:SetMeshScale(__wf_atom_104bfe98(__wf_atom_c082fc3d, toScale, v), true)
		Sleep(0)
	end

	object:SetMeshScale(toScale, true)
end