local v = nil
local v2 = nil
local module = require("SF.Scripts.Libs.EncounterLib")

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
		__wf_atom_e919fb8e.IsBossAvailable = IsBossAvailable
		v2 = object
		local v3 = Resource("/SF/Types/Game/Encounters/CombatEncounterHint")
		local position = object:GetPosition()
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v3, position, 30)
		v = module.GetSubBossTimerSymb(__wf_atom_e2db08ce, true)
	end
end

function IsBossAvailable()
	if v == nil then
		return false
	end

	return gGameData:__wf_atom_20bf298d(v)
end

function UpdateCompleteStatus()
	if v2 == nil then
		return
	end

	if not module.IsHardModeActive() then
		v2:Disable()
		return
	end

	v2:Enable()

	if gRegion:IsMaster() then
		local v3, v4

		if IsBossAvailable() then
			v3 = 57
			v4 = 2
		else
			v3 = 53
			v4 = 1.5
		end

		v2:__wf_atom_479a7ccf(v3)
		v2:__wf_atom_f6b21aac(v4)
	end
end