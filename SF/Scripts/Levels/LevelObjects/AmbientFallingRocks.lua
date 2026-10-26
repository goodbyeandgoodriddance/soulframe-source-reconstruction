local v = Symbol("CurrentExplosionTrigger")
local v2 = WeakResource("/SF/Types/Player/EnvoyAvatar")
local postProcess = nil
local explosionTypes2 = nil
local explosionGroundTypes2 = nil
local v3 = nil
local v4 = nil

function rotationLerping(object)
	if Delay > 0 then
		Sleep(Delay)
	end

	object:__wf_atom_e792b90b(false)
	object:__wf_atom_ff224fc2(true)
	local total = 0

	while total < Timelength do
		object:__wf_atom_82dcfcd4(__wf_atom_9d2f097a(StartRotation, EndRotation, total / Timelength))
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function ShakeAvatar(object)
	postProcess = gRegion:__wf_atom_8ad59546().postProcess

	if not object:__wf_atom_a586ea4c(ExplosionSpawner) then
		print("AttachToLocalAvatar begin")
		local v5 = object:Attach(ExplosionSpawner, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v3)
		postProcess:__wf_atom_54a04966(shakeAmbVal)
		local v6 = Vector()
		local v7 = Vector(0, 0, 8)
		Vector()
		local v8 = Vector()
		local v9 = {
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce,
			__wf_atom_6a50bd07
		}
		local v10 = Vector()
		v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local total = 0

		while
			not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(v5)
			and total <= failsafeTime
			and __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
		do
			if v3:IsEnabled() then
				postProcess:__wf_atom_54a04966(shakeAmbVal * (1 - total / failsafeTime))
				local v11 = __wf_atom_9341614d(v7, Rotation(math.random(-180, 180), math.random(-30, 30), 0))
				VectorAdd(v6, object:__wf_atom_d0069154(), v11)
				v11.x *= 12
				v11.y *= 12
				v11.z *= 12
				VectorAdd(v8, v6, v11)

				if gRegion:__wf_atom_c20d246a(v6, v8, v9, nil, v10) and not __wf_atom_7e8ad928(v10) then
					local v12 = Distance(v6, v10)
					local v13 = __wf_atom_f55d6358(v6, v10, (v12 - 0.5) / v12)

					if v4:__wf_atom_0e0a6fee(v10, 5, 1) == v10 then
						if not __wf_atom_7e8ad928(v13) then
							gRegion:CreateEntity(
								explosionTypes2[math.random(1, #explosionTypes2)],
								v13,
								__wf_atom_80368bb1
							)
						end
					elseif #explosionGroundTypes2 > 0 then
						gRegion:CreateEntity(
							explosionGroundTypes2[math.random(1, #explosionTypes2)],
							v10,
							__wf_atom_80368bb1
						)
					end
				end

				local v12 = Random(1, 2) * 0.1
				Sleep(v12)
				total += v12
			else
				if not __wf_atom_7e8ad928(v5) then
					v5:Destroy()
				end

				postProcess:__wf_atom_54a04966(0)
				print("AttachToLocalAvatar return")
				return
			end
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:Destroy()
		end

		print("AttachToLocalAvatar return")
	end

	postProcess:__wf_atom_54a04966(0)
end

function AttachToLocalAvatar(p)
	Sleep(Delay)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not __wf_atom_c4f78a8f:IsA(v2) then
		return
	end

	explosionTypes2 = explosionTypes
	explosionGroundTypes2 = explosionGroundTypes
	v3 = p
	__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("ShakeAvatar"), false)
end

function RemoveAttachToLocalAvatar()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v)

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:__wf_atom_b811702e(EMPTY_SYMBOL)
		__wf_atom_0a6a5887:Disable()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not __wf_atom_c4f78a8f:IsA(v2) then
		return
	end

	postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess:__wf_atom_54a04966(0)
	local __wf_atom_f582136d = __wf_atom_c4f78a8f:__wf_atom_f582136d(ExplosionSpawner)

	for i = 1, #__wf_atom_f582136d do
		local v5 = __wf_atom_f582136d[i]

		if __wf_atom_7e8ad928(v5) then
			continue
		end

		v5:Disable()
		v5:Destroy()
	end
end

function TagTrainExplosionScriptTrigger(_)
	if not __wf_atom_7e8ad928(ExplosionTrigger) then
		ExplosionTrigger:__wf_atom_b811702e(v)
	end
end

function AmbientExplosions(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or not __wf_atom_3d96ddcd:IsA(v2)
		or __wf_atom_3d96ddcd:__wf_atom_a586ea4c(ExplosionSpawner)
	then
		return
	end

	postProcess = gRegion:__wf_atom_8ad59546().postProcess
	postProcess:__wf_atom_54a04966(8)
	local v5 = Vector()
	local v6 = Vector(0, 0, 8)
	Vector()
	local v7 = Vector()
	local v8 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v9 = Vector()

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) do
		local v10 = __wf_atom_9341614d(v6, Rotation(math.random(-180, 180), math.random(-30, 30), 0))
		VectorAdd(v5, __wf_atom_3d96ddcd:__wf_atom_d0069154(), v10)
		v10.x *= 12
		v10.y *= 12
		v10.z *= 12
		VectorAdd(v7, v5, v10)

		if gRegion:__wf_atom_c20d246a(v5, v7, v8, nil, v9) then
			gRegion:CreateEntity(explosionTypes[math.random(1, #explosionTypes)], v9, __wf_atom_80368bb1)
		end

		local v11 = Random(1, 2) * 0.1
		Sleep(v11)
	end

	instance:Destroy()
	postProcess:__wf_atom_54a04966(0)
end

function RandomExplosionPoints(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if AttachToSelf then
		__wf_atom_3d96ddcd = object
	end

	local total = 0
	local v5 = false

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and total <= Timelength do
		local v6 = total / Timelength
		local v7 = __wf_atom_5784a397(1, #ExplosionPoints)
		local v8 = ExplosionPoints[v7] * ScaleMult + ExplosionPointsOffset
		__wf_atom_3d96ddcd:Attach(explosionTypes[math.random(1, #explosionTypes)], EMPTY_SYMBOL, v8, __wf_atom_80368bb1)
		local v9 = __wf_atom_f55d6358(StartHiLo, EndHiLo, v6)
		local v10 = Random(v9.x, v9.y) * 0.1
		Sleep(v10)
		total += v10

		if v5 or not DoNoise then
			continue
		end

		__wf_atom_3d96ddcd:__wf_atom_e792b90b(true)
		v5 = true
	end

	for i = 1, 12 do
		if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			break
		end

		Sleep(0.1)

		if i == 6 and DoNoise then
			__wf_atom_3d96ddcd:__wf_atom_e792b90b(false)
		end
	end
end

function RandomMeshAndRot(object)
	if not __wf_atom_7e8ad928(DebriMeshes) then
		object:__wf_atom_45cf0e1a(DebriMeshes[__wf_atom_5784a397(1, #DebriMeshes)], false, false)
	end
end

function SimpleShakePlayerAvatar()
	postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		postProcess:__wf_atom_54a04966(shakeAmbVal)
	end

	Sleep(Timelength)

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		postProcess:__wf_atom_54a04966(0)
	end
end