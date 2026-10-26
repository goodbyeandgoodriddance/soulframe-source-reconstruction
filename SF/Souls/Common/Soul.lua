require("SF.Souls.Powers.EntitySoulModeScans")

function SetSoulVisibility(object)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local creator = object:GetCreator()

	if not __wf_atom_7e8ad928(creator) then
		local _ = creator == __wf_atom_eab484a7
	end
end

function GetSoulLifespan()
	local v = 10
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

		if not __wf_atom_7e8ad928(playerAvatar) then
			return (playerAvatar:__wf_atom_d2b2176d():__wf_atom_2a745663(v, 41))
		end
	end

	return v
end

function SoulSpawned(instance)
	Sleep(0)
	SetSoulVisibility(instance)
	local v = GetSoulLifespan()
	Sleep(v - 3)
	local v2 = 3

	while not __wf_atom_7e8ad928(instance) and v2 > 0 do
		v2 = __wf_atom_421b01aa(v2 - __wf_atom_084b3e93(), 0, 3)
		instance:__wf_atom_68f2c268(1 - v2 / 3)
		Sleep(0)
	end

	instance:Destroy()
end