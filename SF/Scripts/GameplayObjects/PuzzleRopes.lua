local v = Vector(0, 0.2, 0)
local v2 = Vector(0, 0.6, 0)
local v3 = Symbol("PuzzleRopeRoll")
local EMPTY_SYMBOL2 = EMPTY_SYMBOL
local v4 = {
	IDLE = 0,
	STANDBY = 1,
	THROWN = 2,
	TIED = 3,
	PULL = 4,
	RETRACT = 5,
	STOPPED = 6
}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local postProcess = nil
local v9 = {}
local v10 = {}

local function fn(_, reticleAnchor)
	local entity = gRegion:CreateEntity(grappleHookType, __wf_atom_28d5d4aa, __wf_atom_80368bb1, v5, v5)

	while __wf_atom_7e8ad928(entity) do
		Sleep(0)
	end

	entity:__wf_atom_dc5956fc(v5, EMPTY_SYMBOL2)
	Sleep(0)
	entity:__wf_atom_e6ed03c8()
	entity:SetVisibility(true)
	local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = entity:Attach(cableType, EMPTY_SYMBOL, v, __wf_atom_80368bb1, entity)
	end

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		return entity
	end

	if __wf_atom_7e8ad928(reticleAnchor) then
		__wf_atom_bb3e7833:__wf_atom_b2394158(v5, EMPTY_SYMBOL2)
		return entity
	else
		__wf_atom_bb3e7833:__wf_atom_b2394158(reticleAnchor, EMPTY_SYMBOL)
	end

	return entity
end

function AddAnchor(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_7879bfc7)
	local creator = object:GetCreator()

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = object:Attach(cableType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object)
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:__wf_atom_b2394158(creator, EMPTY_SYMBOL2)
	end
end

local function fn2(reticleDeco, reticleAnchor)
	if __wf_atom_7e8ad928(reticleDeco) then
		return
	end

	reticleDeco:FirePort("Show")
	local __wf_atom_bb3e7833 = reticleDeco:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		if __wf_atom_7e8ad928(reticleAnchor) then
			__wf_atom_bb3e7833:__wf_atom_b2394158(v5, EMPTY_SYMBOL2)
		else
			__wf_atom_bb3e7833:__wf_atom_b2394158(reticleAnchor, EMPTY_SYMBOL)
		end
	end

	local __wf_atom_3d96ddcd = v5:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		local __wf_atom_c082fc3d = __wf_atom_3d96ddcd:__wf_atom_c082fc3d()
		reticleDeco:AttachToInPlace(__wf_atom_3d96ddcd, EMPTY_SYMBOL)

		if __wf_atom_c082fc3d ~= 1 then
			reticleDeco:__wf_atom_e310f01f(
				reticleDeco:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d,
				reticleDeco:__wf_atom_45c0553e()
			)
		end

		if not __wf_atom_7e8ad928(reticleAnchor) then
			reticleAnchor:AttachToInPlace(__wf_atom_3d96ddcd, EMPTY_SYMBOL)

			if __wf_atom_c082fc3d ~= 1 then
				reticleAnchor:__wf_atom_e310f01f(
					reticleAnchor:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d,
					reticleAnchor:__wf_atom_45c0553e()
				)
			end
		end
	end
end

local function fn3()
	if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v7)) then
		v6:__wf_atom_e6ed03c8()
		v6:__wf_atom_dc5956fc(v7, EMPTY_SYMBOL2)

		if not __wf_atom_7e8ad928(latchingEffectType) then
			v7:Attach(latchingEffectType, EMPTY_SYMBOL2, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		end

		if not __wf_atom_7e8ad928(hookAttachSound) then
			v7:PlaySound(hookAttachSound, false)
		end
	end
end

local function fn4(p)
	if __wf_atom_7e8ad928(v6) then
		return
	end

	local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(__wf_atom_7879bfc7)
	local __wf_atom_8cc00ef8 = __wf_atom_bb3e7833:__wf_atom_8cc00ef8()
	__wf_atom_bb3e7833:Destroy()
	Sleep(0)
	local v11 = v6:Attach(p, EMPTY_SYMBOL, v, __wf_atom_80368bb1, v6)

	if not __wf_atom_7e8ad928(v11) then
		if v5 == __wf_atom_8cc00ef8 then
			v11:__wf_atom_b2394158(__wf_atom_8cc00ef8, EMPTY_SYMBOL2)
		else
			v11:__wf_atom_b2394158(__wf_atom_8cc00ef8, EMPTY_SYMBOL)
		end
	end
end

local function fn5()
	if __wf_atom_7e8ad928(v6) then
		return
	end

	local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Attach(
			cableDustFxType,
			EMPTY_SYMBOL,
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1,
			__wf_atom_bb3e7833
		)
	end

	if not __wf_atom_7e8ad928(v5) then
		v5:Attach(rollDustFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Attach(rollDustFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end

local function fn6(p)
	v5:FirePort("EnableTestRotate")
	v5:__wf_atom_82dcfcd4(Rotation(0, p, 0))

	if p > 1 then
		module2.EnableSequencerAttachments(v5, true, Symbol("ropeWinchUnspoolSequencer"))
	end

	if p < -1 then
		module2.EnableSequencerAttachments(v5, true, Symbol("ropeWinchRetractSequencer"))
	end
end

local function fn7()
	v5:FirePort("DisableTestRotate")
	v5:__wf_atom_82dcfcd4(Rotation(0, 0, 0))
	module2.EnableSequencerAttachments(v5, false, Symbol("ropeWinchUnspoolSequencer"))
	module2.EnableSequencerAttachments(v5, false, Symbol("ropeWinchRetractSequencer"))
	module2.EnableSequencerAttachments(v5, false, Symbol("ropeWinchPullSequencer"))
end

local function fn8(lastHitAvatarFacing, lastHitPoint)
	local v11 = {}
	local v12 = Vector()

	if module.IsInOverworld() then
		v12 = lastHitPoint + lastHitAvatarFacing * 200
	else
		gRegion:__wf_atom_c20d246a(
			lastHitPoint + lastHitAvatarFacing * 3,
			lastHitPoint + lastHitAvatarFacing * 200,
			v11,
			nil,
			v12
		)
	end

	if __wf_atom_7e8ad928(v12) then
		return nil
	end

	local v13 = Distance(lastHitPoint, v12)

	if v13 > 35 then
		return (__wf_atom_f55d6358(lastHitPoint, v12, 35 / v13))
	end

	return v12
end

local function fn9(p, position)
	local copyTable = module.CopyTable(v10)
	local v11 = {}
	local v12 = nil

	for k, v13 in pairs(copyTable) do
		local v14 = __wf_atom_fa8d0177(p, position)
		local position2 = v13:GetPosition()
		table.insert(v11, k, (math.abs((__wf_atom_a6515464(p, v14, position2)))))
	end

	for i = #v11, 1, -1 do
		if not (v11[i] > 10) then
			continue
		end

		table.remove(v11, i)
		table.remove(copyTable, i)
	end

	for i = #copyTable, 1, -1 do
		local position2 = copyTable[i]:GetPosition()
		local v13 = Distance(p, position2)
		local v14 = Vector()
		local v15 = __wf_atom_f55d6358(p, position2, 1 / v13)
		gRegion:__wf_atom_c20d246a(v15, position2, {}, nil, v14)
		Sleep(0)

		if not (math.abs(v13 - Distance(p, v14)) > 5) then
			continue
		end

		table.remove(copyTable, i)
		table.remove(v11, i)
	end

	if #copyTable == 1 then
		return copyTable[1]
	end

	if not (#copyTable > 1) then
		return v12
	end

	local v13 = 360
	local v14 = nil

	for k, _ in pairs(copyTable) do
		if not (v11[k] < v13) then
			continue
		end

		v13 = v11[k]
		v14 = k
	end

	return copyTable[v14]
end

function RopeTargetOnDamaged(object)
	v5 = object
	object:__wf_atom_bb3e7833(__wf_atom_7b01f9ce):__wf_atom_946cad0d()
end

function RopeTargetOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_7b01f9ce)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
	end

	while not __wf_atom_7e8ad928(object) do
		if object:IsEnabled() then
			Sleep(1)
		else
			__wf_atom_7e8ad928(__wf_atom_bb3e7833)
			break
		end
	end
end

local function fn10()
	local exclusiveTargets2 = gRegion:__wf_atom_2226b35c(v3)

	if not module.IsInOverworld() then
		exclusiveTargets2 = module.FilterObjectsInLayerIndex(module.GetLayerIndex(v5), exclusiveTargets2)
	end

	for i = #exclusiveTargets2, 1, -1 do
		if #exclusiveTargets > 0 then
			exclusiveTargets2 = exclusiveTargets
		else
			for _, v11 in ipairs(ignoredTargets) do
				if exclusiveTargets2[i] == v11 then
					table.remove(exclusiveTargets2, i)
				end
			end
		end
	end

	v9 = exclusiveTargets2
end

local function fn11()
	local __wf_atom_e919fb8e = v5:__wf_atom_e919fb8e()
	local exclusiveTarget

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.exclusiveTarget) then
		exclusiveTarget = __wf_atom_e919fb8e.exclusiveTarget
	end

	if not __wf_atom_7e8ad928(exclusiveTarget) then
		local exclusiveTargets = {}
		table.insert(exclusiveTargets, exclusiveTarget)
		v9 = exclusiveTargets
		Sleep(0)
	end

	for i = #v9, 1, -1 do
		if __wf_atom_7e8ad928(v9[i]) then
			table.remove(v9, i)
		end
	end

	local copyTable = module.CopyTable(v9)

	for i = #copyTable, 1, -1 do
		if not (not copyTable[i]:IsEnabled() or copyTable[i] == v5 or not copyTable[i]:IsVisible()) then
			continue
		end

		table.remove(copyTable, i)
	end

	v10 = copyTable
end

function BounceRest(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	object:FirePort("EnableReplicaMoveNoise")
	object:__wf_atom_1f5b5444(Vector(5, 5, 5), 1, Vector(450, 20, 20), 0.3, 0.1, 2)
	Sleep(2.1)
	object:FirePort("DisableReplicaMoveNoise")
	__wf_atom_e919fb8e.noise = false
end

function BounceFar(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	object:FirePort("EnableReplicaMoveNoise")
	object:__wf_atom_1f5b5444(Vector(10, 5, 10), 1.5, Vector(450, 20, 20), 1, 0.1, 2)
	Sleep(2.1)
	object:FirePort("DisableReplicaMoveNoise")
	__wf_atom_e919fb8e.noise = false
end

local function fn12(p, p2, position)
	local v11 = (p2 + position) / 2 + v2
	local v12, v13, v14, v15

	if p < 0.5 then
		v12 = p / 0.5
		v13 = v12 * v12
		v14 = (v12 - 1) * v13
		v15 = v11
		v11 = p2
	else
		v12 = (p - 0.5) / 0.5
		v13 = v12 * v12
		v14 = ((v12 - 2) * v12 + 1) * v12
		v15 = position
	end

	local v16 = (2 * v12 - 3) * v13 + 1
	local v17 = (-2 * v12 + 3) * v13
	return v11 * v16 + v15 * v17 + (position - p2) * v14 * 0.5
end

local function fn13(p) -- 1 equivalent call inferred from this helper
	return p ^ 7
end

function RopeRollOnEnabled(object)
	v5 = object

	while __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_adfb052a() do
		Sleep(0)
	end

	while not object:IsVisible() do
		Sleep(0)
	end

	v8 = gRegion:__wf_atom_c4f78a8f()
	postProcess = gRegion:__wf_atom_8ad59546().postProcess
	fn10()
	object:GetPosition()
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_589cefdb)
	local customAreaTrigger2

	if __wf_atom_7e8ad928(customAreaTrigger) then
		customAreaTrigger2 = object:__wf_atom_bb3e7833(__wf_atom_8b8e8b22)
	else
		customAreaTrigger2 = customAreaTrigger
		__wf_atom_bb3e7833:SetPosition(customAreaTrigger:GetPosition())
		__wf_atom_bb3e7833:__wf_atom_f947c7cc(customAreaTrigger:__wf_atom_80cf57aa())
	end

	if not __wf_atom_7e8ad928(reticleDeco) then
		fn2(reticleDeco, reticleAnchor)
		local __wf_atom_e919fb8e = reticleDeco:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.hintTrigger = customAreaTrigger2
	end

	local v11 = nil
	local count = 0
	local v12 = nil
	local flag = false
	local total = 0
	local v13 = 0
	local v14 = nil
	local position = nil
	local total2 = 0
	local position2 = nil
	local v15 = nil

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_f2317dfd = object:__wf_atom_f2317dfd()
		local v16 = not __wf_atom_7e8ad928(v11) and v11 ~= __wf_atom_f2317dfd
		local reticleDeco2

		if __wf_atom_7e8ad928(reticleDeco) or not v5:IsEnabled() then
			reticleDeco2 = v5
		else
			reticleDeco:MakeVulnerable()
			reticleDeco2 = reticleDeco
			v12 = reticleDeco:__wf_atom_bb3e7833(__wf_atom_7b01f9ce)
		end

		if __wf_atom_f2317dfd == v4.IDLE then
			v5:FirePort("Deactivate")

			if not __wf_atom_7e8ad928(customAreaTrigger2) then
				customAreaTrigger2:Enable()
			end

			if count <= 30 and not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Enable()
				count += 1
			end

			fn7()

			if not __wf_atom_7e8ad928(v12) then
				v12:Enable()
			end

			if not __wf_atom_7e8ad928(reticleDeco) and v5:IsEnabled() then
				reticleDeco:FirePort("Show")

				if not __wf_atom_7e8ad928(reticleReturnSound) then
					v5:PlaySound(reticleReturnSound, false)
				end

				if reticleDeco:IsA(__wf_atom_6a50bd07) then
					local v17 = Vector(20, 5, 20)
					local v18 = Vector(10, 1, 1)
					reticleDeco:__wf_atom_1f5b5444(v17, 1, v18, 0.3, 0.1, 2)
				else
					reticleDeco:__wf_atom_8a035cd5(Symbol("BounceRest"), false)
				end
			end

			if not __wf_atom_7e8ad928(v7) then
				v7:FirePort("Deactivate")
				v7 = nil
			end

			if not __wf_atom_7e8ad928(v6) then
				v6 = nil
			end

			if not __wf_atom_7e8ad928(reticleDeco) then
				local __wf_atom_e919fb8e = reticleDeco:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.lastHitAvatarFacing = nil
				__wf_atom_e919fb8e.lastHitPoint = nil
			end

			v5:__wf_atom_0e990c03(v4.STANDBY)
		elseif __wf_atom_f2317dfd == v4.STANDBY then
			if v5:IsEnabled() then
				if not v5:__wf_atom_b81a6e66() then
					if __wf_atom_7e8ad928(v6) then
						if not __wf_atom_7e8ad928(reticleDeco) then
							local __wf_atom_e919fb8e = reticleDeco:__wf_atom_e919fb8e()
							local lastHitAvatarFacing = __wf_atom_e919fb8e.lastHitAvatarFacing
							local lastHitPoint = __wf_atom_e919fb8e.lastHitPoint

							if not (__wf_atom_7e8ad928(lastHitAvatarFacing) or __wf_atom_7e8ad928(lastHitPoint)) then
								__wf_atom_e919fb8e.lastHitAvatarFacing = nil
								__wf_atom_e919fb8e.lastHitPoint = nil

								if not __wf_atom_7e8ad928(reticleHitSound) then
									v5:PlaySound(reticleHitSound, false)
								end

								position = fn8(lastHitAvatarFacing, lastHitPoint)
								v6 = fn(nil, reticleAnchor)
								fn4(cableType)
								v14 = lastHitPoint
							end
						end
					else
						v5:__wf_atom_0e990c03(v4.THROWN)
					end
				end
			else
				if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
					__wf_atom_bb3e7833:Disable()
				end

				if not __wf_atom_7e8ad928(reticleDeco) then
					reticleDeco:FirePort("Hide")
				end

				return
			end
		elseif __wf_atom_f2317dfd == v4.THROWN then
			if v16 then
				fn11()
				__wf_atom_bb3e7833:Disable()
				fn6(500)

				if not __wf_atom_7e8ad928(reticleDeco) then
					reticleDeco:FirePort("Hide")
				end

				v15 = __wf_atom_fa8d0177(v14, position) + Rotation(0, -90, 0)
				v13 = Distance(v14, position) / 30
				v6:__wf_atom_9b788a35(v15)
				v6:FirePort("EnableTestRotate")
				flag = false

				if __wf_atom_7e8ad928(v7) then
					local v17

					if __wf_atom_7e8ad928(reticleDeco) then
						v17 = v14
					else
						v17 = reticleDeco:GetPosition()
					end

					v7 = fn9(v17, position)

					if not __wf_atom_7e8ad928(v7) then
						position = v7:GetPosition()
					end
				end
			end

			if flag then
				v6:FirePort("DisableTestRotate")

				if __wf_atom_7e8ad928(v7) then
					v5:__wf_atom_0e990c03(v4.RETRACT)
					v7 = nil
				else
					v5:__wf_atom_0e990c03(v4.TIED)
					total = 0
				end
			elseif not __wf_atom_7e8ad928(v6) then
				if total < v13 then
					local v17 = fn12(total / v13, v14, position)
					v6:SetPosition(v17)
					total += __wf_atom_084b3e93()
				else
					flag = true
					total = 0

					if not __wf_atom_7e8ad928(hookAttachMissedSound) then
						v6:PlaySound(hookAttachMissedSound, false)
					end
				end
			end
		elseif __wf_atom_f2317dfd == v4.TIED then
			if v16 then
				fn3()
				fn7()

				if not __wf_atom_7e8ad928(hookAttachSound) then
					v6:PlaySound(hookAttachSound, false)
				end

				v7:SetOwner(v5)
				v7:FirePort("Activate")

				if isAutoPull then
					v5:__wf_atom_0e990c03(v4.PULL)
				end

				Sleep(0.125)
				fn6(-200)
				fn4(cableSubtleWaveType)
				Sleep(0.125)
				postProcess:__wf_atom_54a04966(5)
				Sleep(0.25)
				fn7()
				fn5()
				Sleep(0.375)
				postProcess:__wf_atom_54a04966(0)
				Sleep(0.125)
			end
		elseif __wf_atom_f2317dfd == v4.PULL then
			if v16 then
				v5:Activate()
				fn6(-100)
				module2.EnableSequencerAttachments(v5, true, Symbol("ropeWinchPullSequencer"))
			end

			if v5:IsEnabled() or not isStopRetractingOnDisabled then
				if not (__wf_atom_7e8ad928(v7) or v7:__wf_atom_b81a6e66()) then
					v5:__wf_atom_0e990c03(v4.RETRACT)
				end

				if not v5:__wf_atom_b81a6e66() then
					v5:__wf_atom_0e990c03(v4.RETRACT)
				end
			else
				v5:__wf_atom_0e990c03(v4.STOPPED)
			end
		elseif __wf_atom_f2317dfd == v4.RETRACT then
			if not __wf_atom_7e8ad928(v6) and v16 then
				fn4(cableRetractType)
				position2 = v6:GetPosition()

				if not __wf_atom_7e8ad928(reticleDeco2) then
					v6:__wf_atom_9b788a35(reticleDeco2:__wf_atom_dc309f8a())
				end

				v6:__wf_atom_e6ed03c8()
				v6:FirePort("EnableReplicaMoveNoise")
				module2.EnableSequencerAttachments(v5, false, Symbol("ropeWinchPullSequencer"))

				if not __wf_atom_7e8ad928(retractRopeSound) then
					v6:PlaySound(retractRopeSound, false)
				end

				fn6(-500)
			end

			if __wf_atom_7e8ad928(v6) or not (total2 < 1) then
				if not __wf_atom_7e8ad928(v6) then
					local __wf_atom_bb3e7833_2 = v6:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
						__wf_atom_bb3e7833_2:Destroy()
					end

					if not __wf_atom_7e8ad928(v6) then
						v6:Destroy()
					end
				end

				v5:__wf_atom_0e990c03(v4.IDLE)
				total2 = 0
			else
				local position3 = reticleDeco2:GetPosition()
				local __wf_atom_dc309f8a = reticleDeco2:__wf_atom_dc309f8a()

				if __wf_atom_7e8ad928(position2) then
					position2 = v6:GetPosition()
				end

				local v17 = __wf_atom_f55d6358(position2, position3, (math.sqrt(1 - math.pow(total2 / 1 - 1, 2))))
				local v18 = __wf_atom_9d2f097a(v15, __wf_atom_dc309f8a, fn13(total2 / 1)) -- inferred equivalent call
				v6:SetPosition(v17)
				v6:__wf_atom_9b788a35(v18)
				total2 += __wf_atom_084b3e93()
			end
		elseif __wf_atom_f2317dfd == v4.STOPPED then
			if not __wf_atom_7e8ad928(reticleDeco) then
				local __wf_atom_e919fb8e = reticleDeco:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.lastHitAvatarFacing = nil
				__wf_atom_e919fb8e.lastHitPoint = nil
			end

			fn7()
			fn4(cableStaticType)
			return
		end

		Sleep(0)
		v11 = __wf_atom_f2317dfd
	end

	if __wf_atom_7e8ad928(v5) then
		if not __wf_atom_7e8ad928(reticleDeco) then
			reticleDeco:FirePort("Destroy")
		end

		if __wf_atom_7e8ad928(v6) then
			return
		end

		local __wf_atom_bb3e7833_2 = v6:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:Destroy()
		end

		if not __wf_atom_7e8ad928(v6) then
			v6:Destroy()
		end
	end
end

function ReticleDeflectUpdate(object)
	Sleep(0)
	module.Deflect(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

local function fn14(object)
	object:__wf_atom_8a035cd5(Symbol("BounceFar"), false)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.farHitCount) then
		__wf_atom_e919fb8e.farHitCount = 1
	else
		__wf_atom_e919fb8e.farHitCount += 1
	end

	if __wf_atom_e919fb8e.farHitCount > 2 then
		_T.HideImpactMessage()
		_T.ShowImpactMessage("/SF/Language/Tutorial/GrapplePuzzleDungeonTooFar", 5)
	end
end

function ResetHealth(object)
	Sleep(0)
	Sleep(0)

	if gRegion:IsMaster() then
		object:SetHealth((object:__wf_atom_95174740()))
	end
end

function ReticleOnHit(object, object2)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("ReticleDeflectUpdate"), false)
	end

	object:__wf_atom_8a035cd5(Symbol("ResetHealth"), false)

	if not __wf_atom_7e8ad928(reticleHitSound) then
		object:PlaySound(reticleHitSound, false)
	end

	if __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object2:__wf_atom_679ed446()) then
		return
	end

	local __wf_atom_3371f607 = object2:__wf_atom_3371f607()

	if __wf_atom_7e8ad928(__wf_atom_3371f607) or not __wf_atom_3371f607:IsA(__wf_atom_2dc5c74e) then
		return
	end

	local __wf_atom_dc52498d = object2:__wf_atom_dc52498d()
	print(__wf_atom_dc52498d)

	if __wf_atom_3371f607:__wf_atom_ca3e110b() <= __wf_atom_dc52498d then
		return
	end

	local __wf_atom_3d08948b = __wf_atom_3371f607:__wf_atom_3d08948b(__wf_atom_dc52498d)

	if __wf_atom_7e8ad928(__wf_atom_3d08948b) or not __wf_atom_3d08948b:IsA(__wf_atom_e41d4960) then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.hintTrigger) then
		print("ReticleOnHit Error. No HintTrigger found")
		return
	end

	local __wf_atom_679ed446 = object2:__wf_atom_679ed446()

	if not __wf_atom_e919fb8e.hintTrigger:__wf_atom_4b409d7b(__wf_atom_679ed446) then
		fn14(object)
		return
	end

	__wf_atom_e919fb8e.lastHitAvatarFacing = __wf_atom_e97f3142(__wf_atom_679ed446:__wf_atom_4e50d390())
	__wf_atom_e919fb8e.lastHitPoint = object2:__wf_atom_3e5615f2()

	if not __wf_atom_7e8ad928(__wf_atom_3371f607) and __wf_atom_dc52498d < __wf_atom_3371f607:__wf_atom_ca3e110b() then
		local __wf_atom_414f70dd = __wf_atom_3371f607:__wf_atom_414f70dd(__wf_atom_dc52498d)

		if not __wf_atom_7e8ad928(__wf_atom_414f70dd) then
			local __wf_atom_91859ed8 = __wf_atom_414f70dd:__wf_atom_91859ed8()

			for _, v11 in pairs(__wf_atom_91859ed8) do
				if __wf_atom_7e8ad928(v11) or not v11:IsA(__wf_atom_9c4e6f99) or v11:IsA(__wf_atom_a7ef6cab) then
					continue
				end

				v11:__wf_atom_696c19a3(__wf_atom_28d5d4aa)
				return
			end
		end
	end
end

function PortBrancher(object)
	Sleep(0)
	local state = object:GetState()

	if not (__wf_atom_7e8ad928(portToTrigger[state + 1]) or __wf_atom_7e8ad928(portName[state + 1])) then
		portToTrigger[state + 1]:FirePort(portName[state + 1])
	end
end

function PortBrancherSetState(_)
	portBrancher:SetState(portStateNumber)
end