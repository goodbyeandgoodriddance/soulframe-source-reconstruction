local v = { "PuzzleFire", "PuzzleFlood", "PuzzleHangingCage", "PuzzleLightMirror" }
local v2 = { "Fire", "Flood", "HangingCage", "LightMirror" }
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.StatsLib")

function LogStatsForProcPuzzle(object)
	local creator

	if __wf_atom_7e8ad928(puzzleStatsIdentifier) then
		creator = object:GetCreator()
	else
		creator = puzzleStatsIdentifier
	end

	local v3 = nil

	if __wf_atom_7e8ad928(creator) then
		print("Logging stats for proc puzzle failed: no identifier referenced")
		return
	end

	for k, v4 in pairs(v) do
		if not string.find(tostring(creator:GetName()), v4) then
			continue
		end

		v3 = v2[k]
	end

	if __wf_atom_7e8ad928(v3) then
		print("Logging stats for proc puzzle failed: no puzzle family referenced")
	elseif puzzleState then
		module2.LogProcPuzzleSolved(creator, v3)
	else
		module2.LogProcPuzzleStarted(creator, v3)
	end
end

function GenericTouchAction(_, object)
	module.UnequipWeapon(object, true)
	object:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
	Sleep(playerTouchDelay)
end

function TeleportToWaypoint(object, _)
	if __wf_atom_7e8ad928(teleportWaypoint) then
		return
	end

	object:Teleport(teleportWaypoint:GetPosition(), (teleportWaypoint:__wf_atom_dc309f8a()))
end

function SoulStillTriggerPort(_, _)
	portToTrigger:FirePort(portName)
end

function LookAway(p, object)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if not __wf_atom_7e8ad928(lookAtPortToTrigger) then
		lookAtPortToTrigger:FirePort(lookAtPortName)
	end

	local total = 0

	while not __wf_atom_7e8ad928(attachParent) and total < lookAwayCooldown and object:__wf_atom_1c85e812(p) do
		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(lookAwayPortToTrigger) then
		lookAwayPortToTrigger:FirePort(lookAwayPortName)
	end

	object:Enable()
end

function LookAtPointOfInterest(object, object2)
	local cameraControl = object:CameraControl()

	if isForceWalk then
		object:MotionControl():__wf_atom_99fc7a82(true)
	end

	if isForceCameraTarget then
		local v3

		if __wf_atom_7e8ad928(cameraTarget) then
			v3 = object2
		else
			v3 = cameraTarget
		end

		cameraControl:__wf_atom_ad071f5c(v3, fovInTime)
	end

	local v3 = 0

	while v3 < fovInTime do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93(), 0, fovInTime)
		local v4 = __wf_atom_104bfe98(1, fovAtten, __wf_atom_24a82b69(v3 / fovInTime))

		if __wf_atom_7e8ad928(cameraControl) then
			return
		end

		cameraControl:__wf_atom_25382a0d(v4)
		Sleep(0)
	end

	local v4 = 0

	while v4 < fovTime and object2:__wf_atom_1c85e812(object) and not isZoomOutOnLookAway do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93(), 0, fovTime)
		Sleep(0)
	end

	if isForceWalk then
		object:MotionControl():__wf_atom_99fc7a82(false)
	end

	if isForceCameraTarget then
		cameraControl:__wf_atom_ad071f5c(nil, fovOutTime)
	end

	local v5 = 0

	while v5 < fovOutTime do
		v5 = __wf_atom_421b01aa(v5 + __wf_atom_084b3e93(), 0, fovOutTime)
		local v6 = __wf_atom_104bfe98(fovAtten, 1, __wf_atom_24a82b69(v5 / fovOutTime))

		if __wf_atom_7e8ad928(cameraControl) then
			break
		end

		cameraControl:__wf_atom_25382a0d(v6)
		Sleep(0)
	end
end

function OverrideMoverTime()
	if __wf_atom_7e8ad928(mover) then
		return
	end

	mover:__wf_atom_f5bf9505(moverTime)
end

function DecoDeflectUpdate(object)
	Sleep(0)
	module.Deflect(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

function NoiseOnHit(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	object:__wf_atom_1f5b5444(
		noisePosition,
		noisePositionSpeed,
		noiseRotation,
		noiseRotationSpeed,
		noiseRampUpTime,
		noiseDecayTime
	)
	Sleep(noiseRampUpTime + noiseDecayTime)
	__wf_atom_e919fb8e.noise = false
end

function OnHitNoiseBoost(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("DecoDeflectUpdate"), false)
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_8a035cd5(Symbol("NoiseOnHit"), false)

	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(decoHitSound) then
			object:PlaySound(decoHitSound, false)
		end

		if not __wf_atom_7e8ad928(object) then
			object:SetHealth((object:__wf_atom_95174740()))
		end
	end
end

function DebugDestroyChildren(object)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)

	for _, v3 in pairs(__wf_atom_f582136d) do
		v3:FirePort("Destroy")
	end
end