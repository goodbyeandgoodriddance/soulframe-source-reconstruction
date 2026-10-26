local function fn(object) -- 6 equivalent calls inferred from this helper
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return object
	end

	return __wf_atom_3d96ddcd
end

function InitializeSpeedRtpc(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object = fn(object) -- inferred equivalent call
	object:__wf_atom_c4e6c9aa(nil, { parameterName })
end

function InitializeInterpSpeedRtpc(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object = fn(object) -- inferred equivalent call
	object:__wf_atom_c4e6c9aa(nil, { parameterName }, true)
end

function InitializeProjectileRtpc(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	instance = fn(instance) -- inferred equivalent call

	if not instance:IsA(__wf_atom_baf9587d) then
		return
	end

	instance:__wf_atom_04759746()
end

function InitializeMovingSequencer(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not __wf_atom_7e8ad928(object) then
		fn(object):__wf_atom_c4e6c9aa(nil, { parameterName }) -- inferred equivalent call
	end

	local v = 0
	local retrigerDelay2 = 0

	while true do
		local v2 = fn(object) -- inferred equivalent call
		local v3 = Length(v2:__wf_atom_b4b1510d())

		if v <= speedThreshold and speedThreshold < v3 and retrigerDelay2 <= 0 then
			object:Enable()
			retrigerDelay2 = retrigerDelay
		end

		if speedThreshold < v and v3 <= speedThreshold then
			object:Disable()
		end

		Sleep(0.1)

		if retrigerDelay2 > 0 then
			retrigerDelay2 -= __wf_atom_084b3e93()
		end

		v = v3
	end
end

function InitializeNetVariableRtpc(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
		return
	end

	p = fn(p) -- inferred equivalent call
	gGameRules:__wf_atom_58c98191(p, netVariableNames)
end