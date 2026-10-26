function StringPullback(object)
	local __wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()

	while __wf_atom_7e8ad928(__wf_atom_21ed1a39) do
		Sleep(1)
		__wf_atom_21ed1a39 = object:__wf_atom_21ed1a39()
	end

	local __wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()

	while not __wf_atom_7e8ad928(__wf_atom_21ed1a39) and __wf_atom_7e8ad928(__wf_atom_6009c8ed) do
		Sleep(1)
		__wf_atom_6009c8ed = __wf_atom_21ed1a39:__wf_atom_6009c8ed()
	end

	if #onlyApplyOnTheseSkins > 0 then
		local v = false
		local __wf_atom_035fdfa8 = __wf_atom_21ed1a39:__wf_atom_eb82ab1f():__wf_atom_035fdfa8(0)

		if not __wf_atom_7e8ad928(__wf_atom_035fdfa8) then
			for _, v2 in ipairs(onlyApplyOnTheseSkins) do
				if v2:IsA(__wf_atom_035fdfa8) then
					v = true
				end
			end
		end

		if not v then
			return
		end
	end

	local v = "BowEffectFireGlow" .. tonumber(__wf_atom_6009c8ed:__wf_atom_18aa6e58())

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_e714d8ac) then
		object:__wf_atom_fd3ec680(Param, paramSlot, baseValue, 0, 0, 0)
		return
	end

	local v2 = 2

	while not __wf_atom_7e8ad928(__wf_atom_21ed1a39) do
		local v3 = __wf_atom_21ed1a39:__wf_atom_f9b5aca2() * scale
		local v4 = not __wf_atom_21ed1a39:__wf_atom_dedeec57() and 0 or v3
		local v5 = _T[v]

		if v5 ~= nil and v5 > 0 then
			v4 = math.max(v4, v5)
			_T[v] = v5 - __wf_atom_084b3e93() * falloffRate
		end

		local baseValue = baseValue
		local v6 = not __wf_atom_21ed1a39:__wf_atom_815bfe69() and 0 or baseValue
		local __wf_atom_6009c8ed2 = __wf_atom_21ed1a39:__wf_atom_6009c8ed()
		local v7 = not __wf_atom_7e8ad928(__wf_atom_6009c8ed2)
			and __wf_atom_6009c8ed2:__wf_atom_08998754() == v2
			and 0
			or v4
		object:__wf_atom_fd3ec680(Param, paramSlot, v6 + v7, 0, 0, 0)
		Sleep(0)
	end
end

function ShotFired(object)
	local __wf_atom_6009c8ed = object:__wf_atom_21ed1a39():__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	local v = "BowEffectFireGlow" .. tonumber(__wf_atom_6009c8ed:__wf_atom_18aa6e58())
	local fireIncrement = fireIncrement

	if _T[v] ~= nil then
		fireIncrement += _T[v]
	end

	_T[v] = fireIncrement
end