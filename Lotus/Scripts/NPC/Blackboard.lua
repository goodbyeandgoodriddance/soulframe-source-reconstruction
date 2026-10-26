local v = WeakResource("/EE/Types/Engine/EngineNpcAgent")

local function fn(object)
	return object:__wf_atom_50a7d83e()
end

function ClearAgentBlackboardEntry(result)
	if not (__wf_atom_7e8ad928(result) or result:IsA(v)) then
		if not (__wf_atom_7e8ad928(result) or result:IsA(__wf_atom_67c46eba)) then
			local success
			success, result = pcall(fn, result)

			if success == false or result == nil then
				result = nil
			end
		end

		if __wf_atom_7e8ad928(result) then
			result = nil
		else
			result = result:__wf_atom_30e3d82b()
		end
	end

	if __wf_atom_7e8ad928(result) then
		return
	end

	result:ClearAgentBlackboardEntry(name)
end

function SetAgentBlackboardFloat(result)
	if not (__wf_atom_7e8ad928(result) or result:IsA(v)) then
		if not (__wf_atom_7e8ad928(result) or result:IsA(__wf_atom_67c46eba)) then
			local success
			success, result = pcall(fn, result)

			if success == false or result == nil then
				result = nil
			end
		end

		if __wf_atom_7e8ad928(result) then
			result = nil
		else
			result = result:__wf_atom_30e3d82b()
		end
	end

	if __wf_atom_7e8ad928(result) then
		return
	end

	result:__wf_atom_5a0e15fd(name, valueFloat)
end

function SetAvatarBlackboardFloat(result)
	if not (__wf_atom_7e8ad928(result) or result:IsA(__wf_atom_67c46eba)) then
		local success
		success, result = pcall(fn, result)

		if success == false or result == nil then
			result = nil
		end
	end

	if __wf_atom_7e8ad928(result) then
		return
	end

	result:__wf_atom_cecb2d55(name, valueFloat)
end

function SetAvatarBlackboardBool(result)
	if not (__wf_atom_7e8ad928(result) or result:IsA(__wf_atom_67c46eba)) then
		local success
		success, result = pcall(fn, result)

		if success == false or result == nil then
			result = nil
		end
	end

	if __wf_atom_7e8ad928(result) then
		return
	end

	result:SetBlackboardBool(name, valueBool)
end