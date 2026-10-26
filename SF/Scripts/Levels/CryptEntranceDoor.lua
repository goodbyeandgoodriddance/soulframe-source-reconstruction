function fadeDoorEmissives(object)
	if __wf_atom_7e8ad928(object) or #doors == 0 then
		return
	end

	local v = Vector()

	for _, v2 in ipairs(doors) do
		v += v2:GetPosition()
	end

	local v2 = v / #doors

	for _, v3 in ipairs(doors) do
		v3:SetMaterialParam(Symbol("EmissiveMapAtten"), fadeStartValue)
	end

	local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(v2)

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(__wf_atom_06db1fb1)
		and object:IsTouching(__wf_atom_06db1fb1)
	do
		__wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(v2)

		if __wf_atom_7e8ad928(__wf_atom_06db1fb1) then
			break
		end

		local position = __wf_atom_06db1fb1:GetPosition()
		local v3 = position.x - v2.x
		local v4 = position.y - v2.y
		local v5 = position.z - v2.z
		local v6 = 1 - (math.sqrt(v4 * v4 + v3 * v3 + v5 * v5) - fadeEndDist) / (fadeStartDist - fadeEndDist)
		local v7 = __wf_atom_104bfe98(fadeStartValue, fadeEndValue, v6)

		for _, v8 in ipairs(doors) do
			if __wf_atom_7e8ad928(v8) then
				return
			else
				v8:SetMaterialParam(Symbol("EmissiveMapAtten"), v7)
			end
		end

		Sleep(0.1)
	end

	for _, v3 in ipairs(doors) do
		if __wf_atom_7e8ad928(v3) then
			break
		else
			v3:SetMaterialParam(Symbol("EmissiveMapAtten"), fadeStartValue)
		end
	end
end