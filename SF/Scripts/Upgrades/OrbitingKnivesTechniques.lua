local function fn(items, p)
	for _, item in items do
		if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_a7ef6cab) then
			continue
		end

		item:__wf_atom_49c08f3b(p)
	end
end

function OnExtendOrbitOnEquipApplied(object, instance, _, _, _)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_77e05d3b) then
		return
	end

	local v = false
	local v2 = false

	while not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object)) do
		local __wf_atom_91859ed8 = instance:__wf_atom_414f70dd(1):__wf_atom_91859ed8()

		if v or not (#__wf_atom_91859ed8 > 0) then
			if v and #__wf_atom_91859ed8 == 0 then
				v = false
				v2 = false
			end
		else
			v = true
		end

		if v and not v2 then
			local __wf_atom_be152500 = object:__wf_atom_d2b2176d():__wf_atom_be152500(0)

			if not __wf_atom_7e8ad928(__wf_atom_be152500) and __wf_atom_be152500:__wf_atom_0395f752() == 5 then
				fn(__wf_atom_91859ed8, 4)
				v2 = true
			end
		end

		Sleep(0)
	end
end

function CheckExtensionOnKill(p, instance, _, _, _)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_77e05d3b) then
		return
	end

	local __wf_atom_91859ed8 = instance:__wf_atom_414f70dd(1):__wf_atom_91859ed8()

	if #__wf_atom_91859ed8 == 0 then
		return
	end

	fn(__wf_atom_91859ed8, 2)
end

function CheckExtensionOnPerfectDodge(p, instance, _, _, _)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_77e05d3b) then
		return
	end

	local __wf_atom_91859ed8 = instance:__wf_atom_414f70dd(1):__wf_atom_91859ed8()

	if #__wf_atom_91859ed8 == 0 then
		return
	end

	fn(__wf_atom_91859ed8, 3)
end