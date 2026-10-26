local v = nil

function Initialize(object)
	while not __wf_atom_a0f6588f:__wf_atom_f89aa44a() do
		Sleep(1)
	end

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(1)
	end

	if object ~= nil then
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.UpdateStatus = UpdateCompleteStatus
		__wf_atom_e919fb8e.IsSiegeAvailable = IsSiegeAvailable
		v = object
	end

	UpdateCompleteStatus()
end

function IsSiegeAvailable()
	return gGameData:__wf_atom_20bf298d(siegeTimer)
end

function UpdateCompleteStatus()
	if v == nil then
		return
	end

	if IsSiegeAvailable() then
		v:SetIcon(incompleteSiegeMarkerIcon)
	else
		v:SetIcon(completeSiegeMarkerIcon)
	end
end