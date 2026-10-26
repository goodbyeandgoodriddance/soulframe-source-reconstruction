local module = require("Lotus.Interface.TransmissionUtilities")
local v = {
	[23] = Symbol("NearDeath"),
	[34] = Symbol("Revived"),
	[44] = Symbol("WaypointMarked"),
	[16] = Symbol("Idle"),
	[45] = EMPTY_SYMBOL
}
local v2 = Symbol("EnemyMarked")
local v3 = Symbol("ModMarked")
local v4 = Symbol("SubmersibleDeployed")

function PlayTransmission(object, instance, p, p2)
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameRules) or gGameRules:InDojo() then
		return
	end

	if
		_T.QueuedTransmissions and #_T.QueuedTransmissions > 0
		or not __wf_atom_7e8ad928(_T.curTransmission)
		or not __wf_atom_7e8ad928(gRegion) and gRegion:__wf_atom_c3b255b8()
	then
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_392793db) and __wf_atom_392793db:__wf_atom_c3b255b8() then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()

	if not __wf_atom_7e8ad928(playerAvatar) then
		local cameraControl = playerAvatar:CameraControl()

		if
			not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(cameraControl:__wf_atom_4cd347da()))
			or playerAvatar:__wf_atom_bedb4e3f()
		then
			return
		end

		local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and __wf_atom_e55d02aa:__wf_atom_82f0cac6() then
			return
		end
	end

	local v5 = v[p2]

	if v5 then
		if p2 == 44 and not __wf_atom_7e8ad928(instance) then
			if instance:IsA(__wf_atom_4ebf67cb) then
				v5 = v2
			elseif instance:IsA(modPickupType) then
				v5 = v3
			end
		end

		if p2 == 45 and object:__wf_atom_d2b2176d():__wf_atom_42c5d5fc() then
			v5 = v4
		end

		local transmissionResponse = module:GetTransmissionResponse(v5, p, object)

		if not __wf_atom_7e8ad928(transmissionResponse) then
			object:__wf_atom_1a73b1c2(transmissionResponse)
		end
	end
end

function PlayOperatorVoiceOver(object, p)
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameRules) or gGameRules:InDojo() then
		return
	end

	if
		_T.QueuedTransmissions and #_T.QueuedTransmissions > 0
		or not __wf_atom_7e8ad928(_T.curTransmission)
		or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))
	then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local transmissionResponse = module:GetTransmissionResponse(Symbol(p), __wf_atom_9be88b01, object, true)

	if not __wf_atom_7e8ad928(transmissionResponse) then
		object:__wf_atom_1a73b1c2(transmissionResponse)
	end
end