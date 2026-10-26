local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.StatsLib")
local module5 = require("SF.Scripts.Libs.SparrowLib")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = nil
local v2 = { Symbol("EnterGarrenShrine") }

local function fn(ancestorTransmissionSet, ancestorTransmissionTag, object)
	for _, v3 in pairs(v2) do
		if v3 == ancestorTransmissionTag then
			module4.ReplicateLogEvent("STAG_QUEST", "StartStagPuzzle")
		end
	end

	if object:IsClientOnly() or object:__wf_atom_3eb2b0a9() then
		module.PlayLocalTransmission(
			ancestorTransmissionSet,
			ancestorTransmissionTag,
			gRegion:__wf_atom_c4f78a8f(),
			true
		)
	else
		module.PlayGlobalTransmission(ancestorTransmissionSet, ancestorTransmissionTag, true)
	end

	while _T.KeepDialogAncestorActive do
		Sleep(0)
	end
end

function ActivateRelativeToPlayer(object, p)
	if delay > 0 then
		Sleep(delay)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(p) then
		__wf_atom_c4f78a8f = p
	end

	local v3 = {
		distance = spawnDistance,
		minSpawnDist = 7,
		maxSpawnVerticalDist = 3,
		tryBehind = false
	}
	v = module2.TryAppearRelativeToPlayer(__wf_atom_c4f78a8f, ancestorDecoType, lookTarget, v3, true)

	if v then
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		end

		module2.DissolveIn(v, __wf_atom_c4f78a8f:__wf_atom_a2a18137(), dissolveInAudioTag)
		fn(ancestorTransmissionSet, ancestorTransmissionTag, v)
		local v4

		if not __wf_atom_7e8ad928(endPositionOverride) then
			v4 = endPositionOverride:GetPosition()
		end

		module2.DissolveOut(v, v4)
		Sleep(1)

		if not __wf_atom_7e8ad928(object) then
			object:Disable()
		end

		if not __wf_atom_7e8ad928(v) then
			Sleep(4)
			v:Destroy()
		end
	end
end

function Activate(_)
	if delay > 0 then
		Sleep(delay)
	end

	v = gRegion:__wf_atom_0a6a5887(ancestorTag)

	if not __wf_atom_7e8ad928(v) then
		v:__wf_atom_68f2c268(0)
		module2.DissolveIn(v, nil, dissolveInAudioTag)

		if not __wf_atom_7e8ad928(v) then
			fn(ancestorTransmissionSet, ancestorTransmissionTag, v)
			local v3

			if not __wf_atom_7e8ad928(endPositionOverride) then
				v3 = endPositionOverride:GetPosition()
			end

			module2.DissolveOut(v, v3)
		end
	end
end

function ActivateAtWaypoint(object, object2)
	module6.WaitForLevel()
	module6.WaitForLoginSequence()

	if delay > 0 then
		Sleep(delay)
	end

	if __wf_atom_7e8ad928(spawnWaypoint) then
		spawnWaypoint = object
	end

	if
		skipWaypointAtDistance > 0
		and not __wf_atom_7e8ad928(object2)
		and Distance(object2:GetPosition(), spawnWaypoint:GetPosition()) > skipWaypointAtDistance
	then
		ActivateRelativeToPlayer(object, object2)
		return
	end

	local groundPos = module3.GetGroundPos(spawnWaypoint:GetPosition())
	local v3

	if useWaypointRotation then
		v3 = module2.AppearAtPosition(
			object2,
			ancestorDecoType,
			groundPos,
			lookTarget,
			spawnWaypoint:__wf_atom_dc309f8a()
		)
	else
		v3 = module2.AppearAtPosition(object2, ancestorDecoType, groundPos, lookTarget)
	end

	if not __wf_atom_7e8ad928(v3) then
		local v4 = "AncestorTransmission-" .. object:GetName()

		if addAsSparrowDestination then
			module5.AddSparrowDestination(v3, nil, v4, module5.PRIORITY.QUEST)
		end

		v3:__wf_atom_68f2c268(0)
		module2.DissolveIn(v3)
		fn(ancestorTransmissionSet, ancestorTransmissionTag, v3)

		if addAsSparrowDestination then
			module5.RemoveSparrowDestination(v3, v4)

			if not __wf_atom_7e8ad928(object) then
				object:Disable()
			end
		end

		local v5

		if not __wf_atom_7e8ad928(endPositionOverride) then
			v5 = endPositionOverride:GetPosition()
		end

		module2.DissolveOut(v3, v5)

		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end
	end
end

function ActivateInTent(object)
	if delay > 0 then
		Sleep(delay)
	end

	local nearestTagged = gRegion:FindNearestTagged(ancestorTag, object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) then
		nearestTagged:SetVisibility(true, true)
		fn(ancestorTransmissionSet, ancestorTransmissionTag, nearestTagged)
	end
end

function ActivateAndEndPrevious(object)
	local nearestTagged = gRegion:FindNearestTagged(previousAncestorTag, object:GetPosition())

	if not __wf_atom_7e8ad928(nearestTagged) and nearestTagged:IsVisible() then
		module.CloseTransmissions()
		Sleep(3)
	end

	Activate(object)
end