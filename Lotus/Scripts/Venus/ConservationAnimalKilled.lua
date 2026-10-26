local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Scripts.Libs.TransmissionSet")

local function fn(instance)
	if instance:IsA(__wf_atom_43e0c427) then
		instance = instance:__wf_atom_6009c8ed()
	end

	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_679ed446 = __wf_atom_7470861b:__wf_atom_5b93b030():__wf_atom_679ed446()

	while __wf_atom_7e8ad928(__wf_atom_679ed446) and not __wf_atom_7e8ad928(instance) do
		__wf_atom_679ed446 = __wf_atom_7470861b:__wf_atom_5b93b030():__wf_atom_679ed446()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(__wf_atom_679ed446) then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_679ed446) and __wf_atom_679ed446:IsA(__wf_atom_7e6ed5fa) then
		local gHuntingTransmissionSet = _T.gHuntingTransmissionSet

		if not __wf_atom_7e8ad928(gHuntingTransmissionSet) then
			local gHuntingInterruptibleTransmissionType = _T.gHuntingInterruptibleTransmissionType

			if not __wf_atom_7e8ad928(gHuntingInterruptibleTransmissionType) then
				module.InterruptTransmission(gHuntingInterruptibleTransmissionType, true)
			end

			module2.PlayLocalTransmission(gHuntingTransmissionSet, Symbol("PlayerKilled"), gRegion:__wf_atom_c4f78a8f())
		end
	end
end

function OnKilled(p)
	fn(p)
end

function OnAnimalVehicleKilled(object)
	if MatchPositionOnDeath then
		gRegion:CreateEntity(explosionFx, object:__wf_atom_a2a18137(), object:__wf_atom_2f2bada0())
	else
		gRegion:CreateEntity(explosionFx, object:__wf_atom_d0069154(), __wf_atom_80368bb1)
	end

	object:SetVisibility(false, true)
	fn(object)
end