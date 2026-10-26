local v = {
	Symbol("SplinePoint00"),
	Symbol("SplinePoint01"),
	Symbol("SplinePoint02"),
	Symbol("SplinePoint03"),
	Symbol("SplinePoint04"),
	Symbol("SplinePoint05")
}

function JointPosToMaterialParam(object)
	local v2

	if UseThisEntity then
		v2 = object
	else
		v2 = object:__wf_atom_575542c8()

		if __wf_atom_7e8ad928(v2) then
			v2 = object:__wf_atom_3d96ddcd()
		end
	end

	if __wf_atom_7e8ad928(v2) or not v2:__wf_atom_71a94e55(BoneName) then
		return
	end

	while not __wf_atom_7e8ad928(v2) do
		local __wf_atom_1c374cc9 = v2:__wf_atom_1c374cc9(BoneName, false)
		local __wf_atom_8e4cf043 = v2:__wf_atom_8e4cf043(BoneName)
		local v3 = __wf_atom_1c374cc9 + __wf_atom_9341614d(LocalOffset, __wf_atom_8e4cf043)
		object:SetMaterialParam(MaterialParam, v3.x, v3.y, v3.z, 0, applyToChildren)
		Sleep(sleepTime)
	end
end

function ParentPosToMaterialParam(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	object:SetMaterialParam(MaterialParam, position.x, position.y, position.z, 0, applyToChildren)

	while not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or IsStatic) do
		local position2 = __wf_atom_3d96ddcd:GetPosition()
		object:SetMaterialParam(MaterialParam, position2.x, position2.y, position2.z, 0, applyToChildren)
		Sleep(sleepTime)
	end
end

function InstancePosToMaterialParam(object)
	while not (__wf_atom_7e8ad928(targetInstance) or __wf_atom_7e8ad928(object)) do
		local position = targetInstance:GetPosition()
		object:SetMaterialParam(MaterialParam, position.x, position.y, position.z, 0, applyToChildren)
		Sleep(sleepTime)
	end
end

function TaggedPosToMaterialParam(object)
	local nearestTagged = gRegion:FindNearestTagged(tag, object:__wf_atom_a2a18137())

	while __wf_atom_7e8ad928(nearestTagged) and PersistentChecking do
		nearestTagged = gRegion:FindNearestTagged(tag, object:__wf_atom_a2a18137())
		Sleep(sleepTime)
	end

	while not (__wf_atom_7e8ad928(nearestTagged) or __wf_atom_7e8ad928(object)) do
		local position = nearestTagged:GetPosition()
		object:SetMaterialParam(MaterialParam, position.x, position.y, position.z, 0, applyToChildren)
		Sleep(sleepTime)
	end
end

function AvatarPosToMaterialParam(object)
	local v2

	if usePlayerAvatar then
		v2 = gRegion:__wf_atom_c4f78a8f()
	else
		v2 = object:__wf_atom_575542c8()
	end

	if __wf_atom_7e8ad928(v2) or not v2:IsA(__wf_atom_4ebf67cb) then
		return
	end

	while not (__wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(object)) do
		local position

		if __wf_atom_7e8ad928(BoneName) or not v2:__wf_atom_71a94e55(BoneName) then
			position = v2:GetPosition()
		else
			position = v2:__wf_atom_1c374cc9(BoneName)
		end

		object:SetMaterialParam(MaterialParam, position.x, position.y, position.z, 0, applyToChildren)
		Sleep(sleepTime)
	end
end

function HitPosToMaterialParam(object)
	local __wf_atom_575542c8 = object:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) or not __wf_atom_575542c8:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local v2 = Vector(0, 0, 0)
	local v3 = Symbol("GAME_C1_SPINE3")

	if useEntityAttachBone then
		v3 = object:__wf_atom_f5bac0e4()
	else
		local __wf_atom_7470861b = __wf_atom_575542c8:__wf_atom_7470861b()
		local __wf_atom_2a79ba52 = __wf_atom_7470861b:__wf_atom_55597fe3():__wf_atom_2a79ba52()

		if not __wf_atom_7e8ad928(__wf_atom_2a79ba52) then
			v3 = __wf_atom_7470861b:__wf_atom_bf9d0dc4(__wf_atom_2a79ba52)
		end
	end

	local v4 = 0

	while not __wf_atom_7e8ad928(__wf_atom_575542c8) and not __wf_atom_7e8ad928(object) and v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() / burstDelay, 0, 1)

		if not __wf_atom_7e8ad928(v3) and __wf_atom_575542c8:__wf_atom_71a94e55(v3) then
			v2 = __wf_atom_575542c8:__wf_atom_1c374cc9(v3)
		end

		object:SetMaterialParam(MaterialParam, v2.x, v2.y, v2.z, 0, false)
		Sleep(0)
	end

	__wf_atom_575542c8:Attach(burstFxType, v3)
end

function MaterialFade(p)
	local targetInstance = targetInstance

	if __wf_atom_7e8ad928(targetInstance) then
		targetInstance = p
	end

	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / timer, 0, 1)
		local v3 = __wf_atom_104bfe98(startVal, endVal, v2)
		targetInstance:SetMaterialParam(MaterialParam, v3)
		Sleep(0)
	end
end

function SplineUpdate(object, points2, splineOffsetScale2, splineOffsetFreq2, splineEvolveSpeed2)
	Sleep(0)
	local total = 0
	local v2 = Vector()

	if __wf_atom_7e8ad928(splineOffsetScale2) then
		splineOffsetScale2 = splineOffsetScale
	end

	if __wf_atom_7e8ad928(splineOffsetFreq2) then
		splineOffsetFreq2 = splineOffsetFreq
	end

	if __wf_atom_7e8ad928(splineEvolveSpeed2) then
		splineEvolveSpeed2 = splineEvolveSpeed
	end

	if not __wf_atom_7e8ad928(points) then
		points2 = points
	end

	while not __wf_atom_7e8ad928(object) do
		for i = 1, #points2 do
			v2.x = points2[i].x + splineOffsetScale2 * math.sin(total + i * 13.123 * splineOffsetFreq2)
			v2.y = points2[i].y + splineOffsetScale2 * math.sin(total * (1 + (4 - i) * 0.783) + i * 23.123 * splineOffsetFreq2)
			v2.z = points2[i].z + splineOffsetScale2 * math.sin(total * (1 + i * 0.333) + i * 13.123 * splineOffsetFreq2)
			object:SetMaterialParam(v[i], v2.x, v2.y, v2.z, 1, true)
		end

		total += __wf_atom_084b3e93() * splineEvolveSpeed2
		Sleep(0)
	end
end

function CopyParentVertexSine(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local __wf_atom_3de89c8e = __wf_atom_3d96ddcd:__wf_atom_3de89c8e(0)
	local v2 = Vector(0, 0, 0)
	local v3 = Vector(0, 0, 0)
	local v4 = Vector(0, 0, 0)
	local v5 = Vector(0, 0, 0)
	local v6 = Vector(0, 0, 0)
	v2.x = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWaves"), 1)
	v2.y = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWaves"), 2)
	v2.z = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWaves"), 3)
	local __wf_atom_b90af225 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWaves"), 4)
	v3.x = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesScale"), 1)
	v3.y = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesScale"), 2)
	v3.z = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesScale"), 3)
	local __wf_atom_b90af225_2 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesScale"), 4)
	v4.x = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesSeedScale"), 1)
	v4.y = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesSeedScale"), 2)
	v4.z = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesSeedScale"), 3)
	local __wf_atom_b90af225_3 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("vWavesSeedScale"), 4)
	v5.x = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineGreenStrength"), 1)
	v5.y = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineWorldSeedScale"), 1)
	v6.x = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineOffsetDirection"), 1)
	v6.y = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineOffsetDirection"), 2)
	v6.z = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineOffsetDirection"), 3)
	local __wf_atom_b90af225_4 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineOffsetDirection"), 4)
	local __wf_atom_b90af225_5 = __wf_atom_3de89c8e:__wf_atom_b90af225(Symbol("VertexSineNormalStrength"), 1)
	object:SetMaterialParam(Symbol("vWaves"), v2.x, v2.y, v2.z, __wf_atom_b90af225, true)
	object:SetMaterialParam(Symbol("vWavesScale"), v3.x, v3.y, v3.z, __wf_atom_b90af225_2, true)
	object:SetMaterialParam(Symbol("vWavesSeedScale"), v4.x, v4.y, v4.z, __wf_atom_b90af225_3, true)
	object:SetMaterialParam(Symbol("VertexSineGreenStrength_VertexSineWorldSeedScale"), v5.x, v5.y, 0, 0, true)
	object:SetMaterialParam(Symbol("VertexSineOffsetDirection"), v6.x, v6.y, v6.z, __wf_atom_b90af225_4, true)
	object:SetMaterialParam(Symbol("VertexSineNormalStrength"), __wf_atom_b90af225_5, 0, 0, 0, true)
end

function AvatarHealthToMaterialFade(instance)
	local __wf_atom_575542c8 = instance:__wf_atom_575542c8()

	if __wf_atom_7e8ad928(__wf_atom_575542c8) or not __wf_atom_575542c8:IsA(__wf_atom_4ebf67cb) then
		return
	end

	local v2 = __wf_atom_421b01aa(1 - __wf_atom_575542c8:__wf_atom_bb81a9df(), 0, 1)
	local v3 = 0

	while v3 < 1 do
		local v4 = __wf_atom_421b01aa(1 - __wf_atom_575542c8:__wf_atom_bb81a9df(), 0, 1)

		if v4 == v2 then
			v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / (fadeTime + 0.001), 0, 1)
		else
			instance:Attach(resetFxType, EMPTY_SYMBOL)
			v2 = v4
			v3 = 0
		end

		local v5 = (1 - v3) * v4 * v4 * paramScale
		instance:SetMaterialParam(MaterialParam, v5)
		Sleep(0)
	end

	instance:Destroy()
end

function ExtrudePointUpdate(object)
	Sleep(0)
	local v2 = Vector()
	local total = 0

	while not __wf_atom_7e8ad928(object) do
		v2.x = extrudePosOffset.x + noiseScale.x * math.sin(total + 13.123 * noiseFreq)
		v2.y = extrudePosOffset.y + noiseScale.y * math.sin(total * 4.132 + 13.123 * noiseFreq)
		v2.z = extrudePosOffset.z + noiseScale.z * math.sin(total * 3 + 33.123 * noiseFreq)
		object:SetMaterialParam(Symbol("ExtrudePoint"), v2.x, v2.y, v2.z, 1, true)
		total += __wf_atom_084b3e93() * noiseSpeed
		Sleep(0)
	end
end