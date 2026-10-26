local v = nil
local v2 = nil
local v3 = nil
local v4 = 0

local function fn()
	if __wf_atom_7e8ad928(v) or __wf_atom_7e8ad928(v2) then
		return false
	end

	if v4 > 0 then
		v4 -= __wf_atom_fa1258d0()
	end

	local __wf_atom_c6f1f83d = v:__wf_atom_c6f1f83d()

	if __wf_atom_c6f1f83d < v3 then
		v3 = __wf_atom_c6f1f83d
		v4 = 10
	end

	if v4 > 0 then
		if not v2:IsEnabled() then
			v2:Enable()
		end
	elseif v2:IsEnabled() then
		v2:Disable()
	end

	return true
end

function AwarenessMarker(object)
	v2 = object
	v = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(v) or v:__wf_atom_8efce136() then
		v2:Disable()
		return
	end

	v3 = v:__wf_atom_c6f1f83d()

	while fn() do
		__wf_atom_7e8ad928(v:__wf_atom_a96eb2aa())
		Sleep(0)
	end
end