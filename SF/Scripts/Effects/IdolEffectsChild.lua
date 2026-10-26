function ParentVisFades(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local v = 0
	local __wf_atom_e55d02aa = object:__wf_atom_575542c8():__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local v2

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		v2 = 0
	else
		v2 = __wf_atom_e55d02aa:__wf_atom_437fa2aa()
	end

	while true do
		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			v2 = __wf_atom_e55d02aa:__wf_atom_437fa2aa()
		end

		local __wf_atom_572fc369 = __wf_atom_3d96ddcd:__wf_atom_572fc369()
		local upDurationOne2, downDurationOne2

		if v2 == 1 then
			upDurationOne2 = upDurationOne
			downDurationOne2 = downDurationOne
		elseif v2 == 2 then
			upDurationOne2 = upDurationTwo
			downDurationOne2 = downDurationTwo
		elseif v2 == 3 then
			upDurationOne2 = upDurationThree
			downDurationOne2 = downDurationThree
		else
			upDurationOne2 = 0.65
			downDurationOne2 = 0.65
		end

		if __wf_atom_572fc369 then
			v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / upDurationOne2, 0, 1)
		else
			v = __wf_atom_421b01aa(v - __wf_atom_084b3e93() / downDurationOne2, 0, 1)
		end

		object:__wf_atom_8f04e01e(v)
		Sleep(0)
	end
end