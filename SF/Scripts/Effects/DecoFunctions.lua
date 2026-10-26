local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function DriveCustomFadeTime(instance)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_3ae8d73b) then
		return
	end

	local v = 0
	instance:SetVisibility(visibilityBeforeFade)
	Sleep(delayBeforeFade)

	if not __wf_atom_7e8ad928(fadeSound) then
		instance:PlaySound(fadeSound, false)
	end

	while v < 1 and not __wf_atom_7e8ad928(instance) do
		v = __wf_atom_421b01aa(v + __wf_atom_084b3e93() / (timer + 0.001), 0, 1)
		local v2

		if reverse then
			v2 = 1 - v
		else
			v2 = v
		end

		instance:__wf_atom_8f04e01e(v2)
		Sleep(0)
	end

	if __wf_atom_7e8ad928(instance) then
		return
	end

	if reverse then
		instance:__wf_atom_8f04e01e(0)
	else
		instance:__wf_atom_8f04e01e(1)
	end

	instance:SetVisibility(visibilityOnCompletion)
end

function FirePort()
	module.TaggedFirePorts(tagToFind, port)
end

function SpawnRangeGroundMarkers(object)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local position = object:GetPosition()
	Vector(0, 0, 0)
	local v = Vector(0, 0, 0)
	Vector(0, 0, 0)
	Rotation(0, 0, 0)
	local v2 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }

	for i = 1, MarkerCount do
		local v3 = Rotation(360 / MarkerCount * i, 0, 0)
		local v4 = __wf_atom_9341614d(Vector(0, 0, __wf_atom_c082fc3d), v3)
		local v5 = position + v4
		gRegion:__wf_atom_c20d246a(v5 + Vector(0, traceDistance / 2, 0), v5 - Vector(0, traceDistance, 0), v2, nil, v)
		local v6 = v4 + (v - v5) + Vector(0, GroundOffset, 0)

		if AttachAsChild then
			local v7 = v6 / __wf_atom_c082fc3d
			object:Attach(MarkerType, EMPTY_SYMBOL, v7, v3)
		else
			gRegion:CreateEntity(MarkerType, position + v6, v3)
		end

		local v7 = intervalMin + math.random(0, 100) / 100 * (math.max(intervalMax, intervalMin) - intervalMin)
		Sleep(v7)
	end
end

function AlignToTagged(object)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(tagToFind)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) do
		local position = object:GetPosition()
		local v

		if __wf_atom_7e8ad928(boneName) then
			v = __wf_atom_0a6a5887:GetPosition() + targetOffset
		else
			v = __wf_atom_0a6a5887:__wf_atom_1c374cc9(boneName) + targetOffset
		end

		object:__wf_atom_9b788a35((__wf_atom_fa8d0177(position, v)))
		Sleep(0.05)
	end
end

function PushToGround(instance)
	local position = instance:GetPosition()
	local v = Vector(0, 0, 0)
	local v2 = Rotation(0, 0, 0)
	local v3 = {
		__wf_atom_4ebf67cb,
		__wf_atom_3feeb44a,
		__wf_atom_43e0c427,
		__wf_atom_7b01f9ce,
		__wf_atom_3ae8d73b
	}
	gRegion:__wf_atom_267afa54(
		position + Vector(0, traceStartOffset, 0),
		position - Vector(0, traceDistance, 0),
		nil,
		v3,
		nil,
		v,
		v2,
		true
	)

	if drawDebug then
		gRegion:__wf_atom_8d991675(position + Vector(0, traceStartOffset, 0), 0.25, Color(255, 255, 255), 2)
	end

	if Length(v) == 0 then
		if drawDebug then
			gRegion:__wf_atom_8d991675(position + posOffset, 0.25, Color(255, 0, 0), 2)
		end

		if destroyOnFailedTrace then
			instance:Destroy()
		else
			instance:SetPosition(position + posOffset)
		end
	else
		if drawDebug then
			gRegion:__wf_atom_8d991675(v + posOffset, 0.25, Color(0, 255, 0), 2)
		end

		instance:SetPosition(v + posOffset)

		if useGroundAngle then
			instance:__wf_atom_9b788a35(v2 + rotOffset)
		end
	end

	if playInitAnim then
		instance:__wf_atom_921c1a5f(decoAnim, false, false)
	end
end

function DestroyChildren(object)
	local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

	for _, v in ipairs(__wf_atom_be0bea4a) do
		v:Destroy()
	end
end

function AimAlignment(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) then
		return
	end

	local posOffset2 = posOffset

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) do
		if trackBonePos then
			posOffset2 = (__wf_atom_575542c8:__wf_atom_1c374cc9(boneName) - __wf_atom_575542c8:GetPosition()) * bonePosScale + __wf_atom_9341614d(
				posOffset,
				__wf_atom_575542c8:__wf_atom_2f2bada0()
			)
		end

		object:__wf_atom_e310f01f(
			posOffset2,
			(__wf_atom_fa8d0177(Vector(0, 0, 0), __wf_atom_575542c8:__wf_atom_ab18bf26()))
		)
		Sleep(0)
	end
end

function TimedUnattach(object)
	Sleep(timer)
	object:__wf_atom_e6ed03c8()
end

function BeamDeco(object)
	local v = Length(object:GetPosition() - object:__wf_atom_fdf659dc())

	while v == 0 do
		v = Length(object:GetPosition() - object:__wf_atom_fdf659dc())
		Sleep(0)
	end

	local v2 = __wf_atom_fa8d0177(object:GetPosition(), object:__wf_atom_fdf659dc())
	local bank = math.random(-180, 180)
	v2.bank = bank
	local v3 = v2 + rotOffset

	if attachDeco then
		local v4 = object:Attach(beamDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, v3)

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(v4)) do
			local v5 = __wf_atom_fa8d0177(object:GetPosition(), object:__wf_atom_fdf659dc())
			v5.bank = bank
			local v6 = v5 + rotOffset
			local v7 = Length(object:GetPosition() - object:__wf_atom_fdf659dc())
			v4:__wf_atom_e310f01f(__wf_atom_28d5d4aa, v6)
			v4:SetMeshScale(v7 * scaleCoeff)
			Sleep(0)
		end
	else
		local v4

		if useEndPos then
			v4 = object:__wf_atom_fdf659dc()
		else
			v4 = object:GetPosition()
		end

		local entity = gRegion:CreateEntity(beamDecoType, v4, v3)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetMeshScale(v * scaleCoeff)
		end
	end
end