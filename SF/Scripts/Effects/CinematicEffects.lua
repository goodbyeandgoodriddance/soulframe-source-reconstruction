function ArmDecoSwap(_, object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for _, v in ipairs(__wf_atom_be0bea4a) do
		print(v:GetName())
	end

	local v

	if animEntityIsArm then
		v = object
	else
		v = object:__wf_atom_bb3e7833(currentArmType)
	end

	if __wf_atom_7e8ad928(v) then
		return
	end

	local v2 = object:Attach(newArmType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(transitionInFxType) then
		object:Attach(transitionInFxType, EMPTY_SYMBOL)
	end

	if __wf_atom_7e8ad928(v2) then
		return
	end

	v2:SetVisibility(true)
	print("newArm IS " .. v2:GetName())
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / transitionTimeIn, 0, 1)
		v:__wf_atom_68f2c268(v3)
		v2:__wf_atom_68f2c268(1 - v3)
		Sleep(0)
	end

	if not isTemporary then
		v:Destroy()
		return
	end

	Sleep(holdTime)
	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() / transitionTimeOut, 0, 1)
		v:__wf_atom_68f2c268(1 - v4)
		v2:__wf_atom_68f2c268(v4)
		Sleep(0)
	end

	v2:Destroy()
end

function ArmEmissivePulse(_, object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(currentArmType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return
	end

	local v = 0

	while v < 1 do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / timeUp, 0, 1)
		local v2 = __wf_atom_24a82b69(v)
		__wf_atom_bb3e7833:SetMaterialParam(matParam, v2 * emissiveAtten)
		Sleep(0)
	end

	Sleep(holdTime)
	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / timeDown, 0, 1)
		local v3 = __wf_atom_24a82b69(1 - v2)
		__wf_atom_bb3e7833:SetMaterialParam(matParam, v3 * emissiveAtten)
		Sleep(0)
	end
end