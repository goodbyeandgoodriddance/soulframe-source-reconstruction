local v = {
	Symbol("GAME_L1_LEG2"),
	Symbol("GAME_R1_LEG2"),
	Symbol("GAME_L1_ARM2"),
	Symbol("GAME_R1_ARM2"),
	Symbol("GAME_C1_SPINE1"),
	Symbol("GAME_C1_SPINE2"),
	Symbol("GAME_C1_HEAD1")
}
local v2 = Symbol("ExtrudeVector")
local v3 = Symbol("ExtrudePoint")
local v4 = Symbol("OffsetTime")
local v5 = WeakResource("/Lotus/Powersuits/Loki/LokiBaseSuit")

function WallLatchFX(instance)
	Sleep(0.1)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		return
	end

	local isA = __wf_atom_3d96ddcd:IsA(__wf_atom_7e6ed5fa)
	local __wf_atom_e55d02aa = __wf_atom_3d96ddcd:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return
	end

	local isA2 = __wf_atom_e55d02aa:IsA(v5)
	__wf_atom_3d96ddcd:PlaySound(wallLatchStartSound, false, 1, false)
	local v6

	if isA2 then
		v6 = __wf_atom_3d96ddcd:PlaySound(lokiWallLatchLoopSound, false, 1, false)
	else
		v6 = __wf_atom_3d96ddcd:PlaySound(wallLatchLoopSound, false, 1, false)
	end

	local __wf_atom_fa6a8faf = instance:__wf_atom_fa6a8faf()
	local v7 = __wf_atom_9341614d(
		Vector(-__wf_atom_fa6a8faf.x, __wf_atom_fa6a8faf.y, __wf_atom_fa6a8faf.z),
		__wf_atom_3d96ddcd:__wf_atom_2f2bada0()
	)
	local __wf_atom_bb3e7833 = __wf_atom_3d96ddcd:__wf_atom_bb3e7833(projType)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = __wf_atom_3d96ddcd:Attach(
			projType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_3d96ddcd
		)
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:SetMaterialParam(v2, v7.x, 0, v7.z)
		__wf_atom_bb3e7833:SetMaterialParam(v3, v7.x, 1, v7.z)
	end

	local v8 = __wf_atom_3d96ddcd:__wf_atom_a2a18137() + Vector(0, 0.8, 0) - v7
	local entity = gRegion:CreateEntity(windType, v8, __wf_atom_80368bb1)
	local __wf_atom_f582136d = __wf_atom_3d96ddcd:__wf_atom_f582136d(latchBeamType)

	for i = 1, #__wf_atom_f582136d do
		__wf_atom_f582136d[i]:Destroy()
	end

	local __wf_atom_c2c1e7e7 = __wf_atom_3d96ddcd:__wf_atom_c2c1e7e7()
	local v9 = {}

	for i = 1, math.ceil(#v * __wf_atom_c2c1e7e7) do
		local v10 = __wf_atom_3d96ddcd:Attach(
			latchBeamType,
			v[i],
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_3d96ddcd
		)

		if __wf_atom_7e8ad928(v10) then
			continue
		end

		local __wf_atom_2f2bada0 = __wf_atom_3d96ddcd:__wf_atom_2f2bada0()
		v10:__wf_atom_a64eca67(v8 + __wf_atom_9341614d(
			Vector(Random(-0.15, 0.15), Random(-0.15, 0.15), 0),
			__wf_atom_2f2bada0
		))
		v10:SetMaterialParam(v4, Random(0, 10))
		table.insert(v9, v10)
	end

	local v10 = 1
	local postProcess

	if __wf_atom_3d96ddcd:__wf_atom_8efce136() then
		postProcess = gRegion:__wf_atom_8ad59546().postProcess
	end

	while
		not __wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		and not __wf_atom_3d96ddcd:IsKilled()
		and (__wf_atom_3d96ddcd:__wf_atom_08998754() == 20 or __wf_atom_3d96ddcd:__wf_atom_08998754() == 21 or __wf_atom_3d96ddcd:__wf_atom_08998754() == 22)
		and __wf_atom_c2c1e7e7 > 0
		and (not isA or __wf_atom_3d96ddcd:__wf_atom_535d5cbb())
	do
		local __wf_atom_a2a18137 = __wf_atom_3d96ddcd:__wf_atom_a2a18137()
		__wf_atom_c2c1e7e7 = __wf_atom_3d96ddcd:__wf_atom_c2c1e7e7()

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:SetMaterialParam(SF.__wf_atom_473a1df0, __wf_atom_c2c1e7e7)
			local v11 = __wf_atom_9341614d(
				Vector(-__wf_atom_fa6a8faf.x, __wf_atom_fa6a8faf.y, __wf_atom_fa6a8faf.z),
				__wf_atom_3d96ddcd:__wf_atom_2f2bada0()
			)
			__wf_atom_bb3e7833:SetMaterialParam(v3, v11.x, 1, v11.z)
		end

		for i = 1, #v9 do
			if __wf_atom_7e8ad928(v9[i]) then
				continue
			end

			if #v * __wf_atom_c2c1e7e7 < i then
				local v11 = v9[i]
				table.remove(v9, i)
				v11:Destroy()
			else
				local v11 = Time() * 0.2
				local v12 = __wf_atom_482dad48(3, 0.8, i + v11, i + 0.3 + v11)
				local v13 = __wf_atom_482dad48(3, 0.8, 0.7 + i + v11, 0.7 + i + 0.3 + v11)
				v9[i]:__wf_atom_a64eca67(__wf_atom_a2a18137 + Vector(v12 * 0.05, 1 + v13 * 0.2, -v12 * 0.05) - __wf_atom_fa6a8faf)
			end
		end

		if not __wf_atom_7e8ad928(entity) then
			entity:SetPosition(__wf_atom_a2a18137 + Vector(0, 0.8, 0) - __wf_atom_fa6a8faf)
			entity:__wf_atom_6f7fb720((Range(-2 - 10 * __wf_atom_c2c1e7e7, 0)))
		end

		if not isA2 then
			local v11 = math.pow(__wf_atom_c2c1e7e7, 0.5)
			v6:__wf_atom_53043d81(__wf_atom_104bfe98(0.5, 1.75, v11))
		end

		if not __wf_atom_7e8ad928(postProcess) then
			postProcess:__wf_atom_54a04966((math.max(0, v10 * 5)))
		end

		v10 -= __wf_atom_084b3e93() * 0.5
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess:__wf_atom_54a04966(0)
	end

	for i = 1, #v9 do
		local v11 = v9[i]

		if not __wf_atom_7e8ad928(v11) then
			v11:Destroy()
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		__wf_atom_3d96ddcd:PlaySound(wallLatchEndSound, false, 1, false)
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Destroy()
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Stop(true)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function AimGlideEffects(instance)
	Sleep(0)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:__wf_atom_8efce136() then
		return
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_c2c1e7e7 = __wf_atom_3d96ddcd:__wf_atom_c2c1e7e7()
	local v6 = 1

	while not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_c2c1e7e7 > 0 and v6 > 0 do
		__wf_atom_c2c1e7e7 = __wf_atom_3d96ddcd:__wf_atom_c2c1e7e7()

		if not __wf_atom_7e8ad928(postProcess) then
			postProcess:__wf_atom_54a04966(v6 * 10)
		end

		v6 -= __wf_atom_084b3e93() * 0.6
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(postProcess) then
		postProcess:__wf_atom_54a04966(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end