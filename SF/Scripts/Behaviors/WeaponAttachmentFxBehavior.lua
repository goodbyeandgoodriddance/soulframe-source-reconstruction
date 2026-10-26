function Evaluate(_, _)
	return true
end

function Activate(object, _)
	local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
	local v

	if not __wf_atom_7e8ad928(__wf_atom_35a10d3c) then
		v = __wf_atom_35a10d3c:__wf_atom_66088189(1, 0)
	end

	while waitForParryPosture and not __wf_atom_7e8ad928(__wf_atom_35a10d3c) do
		if not __wf_atom_35a10d3c:IsA(__wf_atom_77e05d3b) then
			return
		end

		if __wf_atom_35a10d3c:__wf_atom_aab55bea() then
			break
		else
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(v) then
		local __wf_atom_be0bea4a = v:__wf_atom_be0bea4a()

		for i = 1, #__wf_atom_be0bea4a do
			if __wf_atom_be0bea4a[i]:IsA(fxToApplyToWeapon) then
				return
			end
		end

		v:Attach(fxToApplyToWeapon, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object):__wf_atom_b811702e(tagToApplyToWeapon)
	end
end