local function fn(state, p)
	local v = state.position - state.targetPosition
	state.force += Vector(v.x * state.stiffness.x, v.y * state.stiffness.y, v.z * state.stiffness.z) * p
	state.velocity -= state.force
	state.position += state.velocity * p
	state.velocity *= 1 - state.dampening * p
	state.force = Vector()
end

function OrbFloat(object)
	Sleep(initialDelay)
	local boneOverride2 = object:__wf_atom_f5bac0e4()

	if not __wf_atom_7e8ad928(boneOverride) then
		boneOverride2 = boneOverride
	end

	local __wf_atom_fa6a8faf = object:__wf_atom_fa6a8faf()
	local __wf_atom_45c0553e = object:__wf_atom_45c0553e()
	local position = object:GetPosition()
	local v = __wf_atom_10cd16b2(position.x, 0.1)
	local v2 = __wf_atom_10cd16b2(position.y, 0.2)
	local v3 = __wf_atom_10cd16b2(position.z, 0.1)
	local v4 = __wf_atom_10cd16b2(position.x, 1)
	local v5 = __wf_atom_10cd16b2(position.y, 1)
	local v6 = __wf_atom_10cd16b2(position.z, 1)
	local v7 = Vector(position.x, position.y, position.z)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()
	object:__wf_atom_dc5956fc(nil, Symbol())
	local v8 = {
		force = Vector(),
		velocity = Vector(),
		position = position,
		targetPosition = position,
		stiffness = Vector(90, 40, 90),
		dampening = 8
	}
	local total = 0

	while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_3d96ddcd)) do
		local v9 = __wf_atom_084b3e93()

		while v9 <= 0 do
			v9 = __wf_atom_084b3e93()
			Sleep(0)
		end

		total += v9
		local v10 = Noise(Time() * 0.2) * 0.3
		local v11 = Noise(33 + Time() * 0.2) * 0.3
		local v12 = Noise(33 + Time() * 0.2) * 0.3
		local v13

		if __wf_atom_3d96ddcd:IsA(__wf_atom_67c46eba) then
			v13 = __wf_atom_3d96ddcd
		else
			v13 = __wf_atom_3d96ddcd:__wf_atom_575542c8()
		end

		local v14 = Vector(0, 0, 0)

		if not __wf_atom_7e8ad928(v13) then
			v14 = __wf_atom_e97f3142(v13:__wf_atom_4e50d390())
		end

		local v15 = __wf_atom_edfe0d73(v14, Vector(0, 1, 0)) * camOffset
		local __wf_atom_1c374cc9 = __wf_atom_3d96ddcd:__wf_atom_1c374cc9(boneOverride2, false)
		local __wf_atom_0e1e5bc9 = __wf_atom_3d96ddcd:__wf_atom_0e1e5bc9()
		local __wf_atom_f46ecadd = __wf_atom_3d96ddcd:__wf_atom_f46ecadd(boneOverride2)
		local v16 = (__wf_atom_1c374cc9 + (__wf_atom_9341614d(__wf_atom_f46ecadd, __wf_atom_0e1e5bc9) + __wf_atom_3d96ddcd:GetPosition() - v14 * 0.2)) * 0.5
		local v17 = math.sin(total * sineFrequency) * sineAmplitude
		local v18 = v16 + v15 + offset + Vector(0, v17, 0)
		v8.targetPosition = Vector(v18.x, v18.y, v18.z)
		local __wf_atom_278a2d05 = __wf_atom_3d96ddcd:__wf_atom_278a2d05()
		local v19 = (position - v7) * (1 / v9)
		v4:__wf_atom_09294a87(v19.x)
		v5:__wf_atom_09294a87(v19.y)
		v6:__wf_atom_09294a87(v19.z)
		v4:Update(v9)
		v5:Update(v9)
		v6:Update(v9)
		v19.x = v4:__wf_atom_9e368823()
		v19.y = v5:__wf_atom_9e368823()
		v19.z = v6:__wf_atom_9e368823()
		local v20 = Length(__wf_atom_278a2d05 - v19)
		v.mSmoothTime = __wf_atom_104bfe98(0.03, 0.1, __wf_atom_421b01aa(v20 * 0.5, 0, 1))
		v2.mSmoothTime = __wf_atom_104bfe98(0.1, 0.2, __wf_atom_421b01aa(v20 * 0.5, 0, 1))
		v3.mSmoothTime = __wf_atom_104bfe98(0.03, 0.1, __wf_atom_421b01aa(v20 * 0.5, 0, 1))
		v:__wf_atom_09294a87(v18.x)
		v2:__wf_atom_09294a87(v18.y)
		v3:__wf_atom_09294a87(v18.z)
		v:Update(v9)
		v2:Update(v9)
		v3:Update(v9)
		v18.x = v:__wf_atom_9e368823() + v10
		v18.y = v2:__wf_atom_9e368823() + v12
		v18.z = v3:__wf_atom_9e368823() + v11
		object:__wf_atom_dc309f8a()
		fn(v8, v9)
		local v21 = Vector(v8.position.x, v8.position.y, v8.position.z)
		object:SetPosition(v21)
		v7 = Vector(position.x, position.y, position.z)
		local _ = __wf_atom_fa6a8faf + Vector(v10, v12, v11)
		__wf_atom_45c0553e = object:__wf_atom_45c0553e()
		Sleep(0)
		position = v21
	end
end