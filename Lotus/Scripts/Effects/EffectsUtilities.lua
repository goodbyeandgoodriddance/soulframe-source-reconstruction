module(..., package.seeall)

function Piecewise(p, list)
	local count = #list
	local v = 1 / (count - 1)
	local v2 = 1 / v
	local v3 = 1

	while v3 < count do
		if p < v * v3 then
			return (__wf_atom_104bfe98(list[v3], list[v3 + 1], (p - v * (v3 - 1)) * v2))
		else
			v3 += 1
		end
	end

	return list[count]
end

function UpdateWorldPos(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
		object:SetMaterialParam(p, __wf_atom_a2a18137.x, __wf_atom_a2a18137.y, __wf_atom_a2a18137.z)
		Sleep(0)
	end
end