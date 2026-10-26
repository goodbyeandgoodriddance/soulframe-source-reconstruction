local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local v = Resource("/SF/Sounds/Dialog/TransmissionSets/TuvalkaneFragementsFoundTransmissionSet")
local v2 = nil
local v3 = nil

function CheckFragments(_, object)
	local localPlayerAncestorOfType = module2.GetLocalPlayerAncestorOfType(targetAncestor)

	if __wf_atom_7e8ad928(localPlayerAncestorOfType) or localPlayerAncestorOfType.mRank < 0 then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(v2) then
		v2 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		v3 = v2:__wf_atom_259e7653(true)
	end

	local __wf_atom_1dd35883 = object:__wf_atom_1dd35883()
	local __wf_atom_49479502 = v3:__wf_atom_49479502()
	local mItemCount = 0

	for i = 1, #__wf_atom_49479502 do
		local v4 = __wf_atom_49479502[i]

		if v4.mItemType ~= WeakResource(object) then
			continue
		end

		mItemCount = v4.mItemCount
		break
	end

	if mItemCount == __wf_atom_1dd35883 and module.TransmissionPlaying() == false then
		module.PlayLocalTransmission(v, tranmissionTag, __wf_atom_c4f78a8f, false, true, nil)
	end
end