function EMO_START(object)
	object:__wf_atom_8914dfde("Toggle", 1)

	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local __wf_atom_eb82ab1f = __wf_atom_e55d02aa:__wf_atom_eb82ab1f()
	local __wf_atom_a6a0e624 = __wf_atom_eb82ab1f:__wf_atom_a6a0e624(0)

	if __wf_atom_7e8ad928(__wf_atom_a6a0e624) then
		__wf_atom_a6a0e624 = __wf_atom_eb82ab1f:__wf_atom_035fdfa8(0)
	end

	if not __wf_atom_7e8ad928(__wf_atom_a6a0e624) and Type(__wf_atom_a6a0e624):__wf_atom_ee0f346d() then
		local __wf_atom_f9098661 = __wf_atom_eb82ab1f:__wf_atom_f9098661(4, 0)
		local color = __wf_atom_eb82ab1f:GetColor(4, 0)
		local v = __wf_atom_f9098661 and bit32.extract(color.red, 0) == 1
		color.red = bit32.replace(color.red, v and 0 or 1, 0)
		__wf_atom_eb82ab1f:SetColor(4, 0, color)
		__wf_atom_eb82ab1f:__wf_atom_59cc106e(4, 0, true)
		__wf_atom_e55d02aa:SetCustomization(__wf_atom_eb82ab1f, false)
		__wf_atom_d2b2176d:__wf_atom_da1b89a8()
		__wf_atom_d2b2176d:Update(0)
	end
end