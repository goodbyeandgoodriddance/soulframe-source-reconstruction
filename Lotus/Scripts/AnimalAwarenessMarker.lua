local v = nil
local v2 = nil
local v3 = nil

local function fn(_)
	if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v) then
		return
	end

	local __wf_atom_1793a706 = v2:__wf_atom_1793a706()
	local __wf_atom_2d9e235e = v:__wf_atom_2d9e235e()

	if
		canHide
		and (__wf_atom_1793a706 >= 2 or __wf_atom_2d9e235e <= 0 or v:__wf_atom_160c488b(sleepProcSymbol) and v2:__wf_atom_7470861b():__wf_atom_b76d107d(27))
	then
		if not __wf_atom_7e8ad928(v3) then
			v3:Disable()
		end
	else
		if canEnableMarker and not v3:IsEnabled() then
			v3:Enable()
		end

		local __wf_atom_93531a72 = v:__wf_atom_93531a72()
		local __wf_atom_d3542e6d = v:__wf_atom_d3542e6d()
		local combatColor2

		if __wf_atom_1793a706 == 3 then
			combatColor2 = combatColor
		elseif __wf_atom_1793a706 == 2 then
			combatColor2 = investigatingColor
		else
			combatColor2 = idleIconColor
		end

		if modifyContextColor and combatColor2 ~= nil and combatColor2 ~= v3:__wf_atom_5028a4cd() then
			v3:__wf_atom_4a41cc60(combatColor2)
		end

		local v4 = math.min(
			math.max(__wf_atom_2d9e235e - __wf_atom_d3542e6d, 0) / math.max(__wf_atom_93531a72 - __wf_atom_d3542e6d, 0.01),
			1
		)
		v3:__wf_atom_ea548960(v4)
	end
end

function AwarenessMarker(object)
	v3 = object
	v2 = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(v2) or not v2:IsA(__wf_atom_4ebf67cb) then
		return
	end

	v = v2:__wf_atom_30e3d82b()

	while not (__wf_atom_7e8ad928(v2) or v2:IsKilled()) do
		if __wf_atom_7e8ad928(v) then
			v = v2:__wf_atom_30e3d82b()

			if not __wf_atom_7e8ad928(v) then
				break
			end
		end

		Sleep(1)
	end

	__wf_atom_084b3e93()

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(object)) do
		local v4 = __wf_atom_084b3e93()
		fn(v4)
		Sleep(v4)
	end
end