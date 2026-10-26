local v = nil
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("EE.Interface.Utilities")

function PelengatorProximitySensor(object)
	local v2 = nil

	while __wf_atom_7e8ad928(v2) do
		Sleep(0)
		v2 = object:__wf_atom_3d96ddcd()
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local v3 = Vector(0, 0.5, 0)
	local v4 = Vector(15, 15, 15)
	local v5, v6

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_bb3e7833(__wf_atom_fac7b40a)
		v5 = object:__wf_atom_bb3e7833(__wf_atom_9578cbaa)
		v6 = object:__wf_atom_bb3e7833(__wf_atom_d00f34c2)
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(treasureTag)
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(falsePositiveTag)
	local mergeTables = module.MergeTables(__wf_atom_2226b35c, __wf_atom_2226b35c2, false)
	local flag = true
	local flag2 = false
	local v7 = nil
	local v8 = false
	local v9 = false
	local total = 0
	local v10 = nil
	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	while not __wf_atom_7e8ad928(object) do
		local v11 = 120
		local v12 = 120
		local v13 = nil
		local v14 = 2

		for i = #mergeTables, 1, -1 do
			local mergeTable = mergeTables[i]

			if __wf_atom_7e8ad928(mergeTable) or not mergeTable:IsEnabled() then
				table.remove(mergeTables, i)
			else
				local __wf_atom_8a6b8fc3 = mergeTable:__wf_atom_8a6b8fc3(object)
				local __wf_atom_57856d42 = v:__wf_atom_57856d42(object:GetPosition(), mergeTable:GetPosition())
				local layerIndex = module.GetLayerIndex(mergeTable)
				local layerIndex2 = module.GetLayerIndex(object)

				if
					layerIndex == layerIndex2
					and layerIndex ~= 0
					and layerIndex2 ~= 0
					and (__wf_atom_8a6b8fc3 < 30 or __wf_atom_57856d42 == 0)
				then
					v11 = math.min(v11, __wf_atom_8a6b8fc3)
				else
					v11 = math.min(v11, __wf_atom_57856d42)
				end

				__wf_atom_421b01aa(v11, 2.5, 120)

				if v11 < v12 then
					v13 = mergeTable
					v12 = v11
				else
					v11 = v12
				end
			end
		end

		if #mergeTables == 0 then
			v11 = __wf_atom_7e8ad928(v13) and -1 or not v13:IsEnabled() and -1 or v11
		end

		if not (__wf_atom_7e8ad928(v2) or v2:IsKilled() or v2:IsA(__wf_atom_43e0c427)) then
			if v2:__wf_atom_8efce136() then
				if v13 == nil or v11 == -1 or v11 == 0 then
					v2:__wf_atom_cecb2d55(sRtpcDistance, 121)
				else
					v2:__wf_atom_cecb2d55(sRtpcDistance, v11)
				end

				if v11 < 120 and v11 > 0 then
					if flag then
						v2:PlaySound(beepSound, false)
					end

					if not flag2 then
						v7 = v2:PlaySound(loopSound, false, 0, false)
						flag2 = true
					end
				elseif flag2 then
					if not __wf_atom_7e8ad928(v7) then
						v7:Stop(false)
					end

					flag2 = false
				end

				if flag2 then
					if v:__wf_atom_37241977(__wf_atom_eab484a7) and not v8 then
						v2:SetBlackboardBool(sRtpcIsInFight, true)
						v8 = true
					else
						v2:SetBlackboardBool(sRtpcIsInFight, false)
						v8 = false
					end
				end
			end

			if v13 == nil or v11 >= 120 or v11 == -1 or v11 == 0 then
				if not __wf_atom_7e8ad928(v5) then
					v5:Disable()
				end

				if not __wf_atom_7e8ad928(v6) then
					v6:TurnOff()
				end
			else
				v14 = __wf_atom_104bfe98(0.025, 2, v11 / 120)
				local v15 = 1 - v11 / 120

				if not __wf_atom_7e8ad928(v5) then
					v5:SetMaterialParam(Symbol("SineControlA"), 0, 0.1, 1, v15 * 0.2)
					v5:SetMaterialParam(Symbol("UnlitAtten"), v15 * v15, 0, 0, 0)
				end

				if not __wf_atom_7e8ad928(v6) then
					v6:__wf_atom_f5c11ad2(v15 * v15 * 200)
				end

				local v16 = __wf_atom_104bfe98(0, 0.3, v11 / 120)
				local v17 = __wf_atom_f55d6358(__wf_atom_28d5d4aa, v4, v11 / 120)

				if flag then
					flag = false

					if not __wf_atom_7e8ad928(v6) then
						v6:TurnOn()

						if v11 < scanDigRange then
							v6:__wf_atom_edd3fec6(1)
						else
							v6:__wf_atom_8a035cd5(Symbol("PulseLight"), false, v14)
						end
					end

					if not __wf_atom_7e8ad928(v5) then
						v5:Enable()

						if v11 < scanDigRange then
							v5:__wf_atom_8f04e01e(0.5)
							v5:SetMaterialParam(Symbol("UnlitAtten"), 4, 0, 0, 0)
						else
							v5:__wf_atom_8a035cd5(Symbol("PulseProj"), false, v14)
						end
					end

					object:__wf_atom_e792b90b(true)
					object:__wf_atom_1f5b5444(v3, 0.5, v17, v16, 0, 0)
				else
					__wf_atom_7e8ad928(v5)
					__wf_atom_7e8ad928(v6)
					object:__wf_atom_e792b90b(false)
					flag = true
				end
			end

			if v2:__wf_atom_8efce136() then
				if v13 == nil or not (v11 <= scanDigRange and internalSafetyRange < v11) then
					_T.HideImpactMessage()
					v2:CameraControl():__wf_atom_ad071f5c(nil, 0)
					v2:MotionControl():__wf_atom_99fc7a82(false)

					if not __wf_atom_7e8ad928(v10) then
						v10:Destroy()
					end

					v9 = false
					total = 0
				elseif v9 or not (hintDelay <= total) then
					total += v14
				else
					_T.ShowImpactMessage("/SF/Language/Objectives/DungeonDeedsUnearthTreasureHint", -1)
					v2:CameraControl():__wf_atom_ad071f5c(
						v13:__wf_atom_bb3e7833(__wf_atom_3a0953be),
						cameraAdjustmentTime
					)
					v2:MotionControl():__wf_atom_99fc7a82(true)
					v10 = object:Attach(hintBeamType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

					if not __wf_atom_7e8ad928(v10) then
						v10:__wf_atom_b2394158(v13, EMPTY_SYMBOL)
					end

					v9 = true
					total = 0
				end
			end
		end

		Sleep(v14)
	end

	print("Detector script ended")
end

local function fn(object, _)
	if __wf_atom_7e8ad928(dropTable) then
		return false
	end

	if gRegion:IsMaster() then
		local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
		local __wf_atom_e93896ba = __wf_atom_7d789620:__wf_atom_e93896ba(0)
		local __wf_atom_dcf48c53 = __wf_atom_7d789620:__wf_atom_dcf48c53()
		local __wf_atom_57203011 = __wf_atom_7d789620:__wf_atom_57203011()
		local v2 = __wf_atom_5784a397(__wf_atom_dcf48c53, __wf_atom_57203011)
		dropTable:__wf_atom_6ba3aebe(object, __wf_atom_e93896ba, v2, dropSpawnOffset)
		_T.idleTimoutReset = true
	end
end

function UnearthTrigger(object, object2)
	local position = object:GetPosition()
	object2:PlaySound(whistleSound, false)
	local total = 0

	while object:__wf_atom_acccc08b() do
		local position2 = object2:GetPosition()
		local v2 = Distance(position2, position)
		total += __wf_atom_084b3e93()
		Sleep(0)

		if not (unearthDelay < total and v2 > 1) then
			continue
		end

		local position3 = object:GetPosition()
		local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
		local v3 = Rotation(__wf_atom_fa8d0177(position3, position2).heading, 0, 0)
		local v4 = __wf_atom_d919c2d7(__wf_atom_dc309f8a, v3)
		object:FirePort("Disable")
		gRegion:CreateEntity(unearthEffect, position3, v4)
		gRegion:CreateEntity(creatureEffect, position3, v4)
		break
	end
end

function UnearthAction(object, object2)
	object:FirePort("Disable")

	if not gRegion:IsMaster() then
		return
	end

	local position = object2:GetPosition()
	object2:PlaySound(whistleSound, false)
	Sleep(unearthDelay)
	local position2 = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local v2 = Rotation(__wf_atom_fa8d0177(position2, position).heading, 0, 0)
	local v3 = __wf_atom_d919c2d7(__wf_atom_dc309f8a, v2)
	gRegion:CreateEntity(unearthEffect, position2, v3)
	gRegion:CreateEntity(creatureEffect, position2, v3)
	fn(object, object2)
end

function EvaluateUnearthAction(object, object2)
	local position = object:GetPosition()
	local position2 = object2:GetPosition()
	return Distance(position2, position) > internalSafetyRange
end

function DebugGivePelengator(_, object)
	object:Attach(pelengatorAttachDeco, sPelengatorAttachBone, pelengatorAttachPosition, pelengatorAttachRotation)
	object:__wf_atom_1bb5b1ff()
end

function AnimalEscape(instance)
	Sleep(1)
	local position = instance:GetPosition()
	local __wf_atom_dc309f8a = instance:__wf_atom_dc309f8a()
	local __wf_atom_402b3832 = gRegion:__wf_atom_2202ffb6():__wf_atom_402b3832(
		agentType,
		position,
		__wf_atom_dc309f8a,
		EMPTY_SYMBOL,
		0,
		true,
		0,
		0
	)
	instance:Destroy()

	if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("DissolveAvatarNoAnim"), false)

			if not __wf_atom_7e8ad928(animalSound) then
				__wf_atom_50a7d83e:PlaySound(animalSound, false)
			end
		end
	end
end

local function fn2(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	Sleep(dissolveTime)
	local total = 0

	while total <= dissolveTime do
		local v2 = __wf_atom_104bfe98(0, 1, (math.min(total / dissolveTime, 1)))

		if not __wf_atom_7e8ad928(instance) then
			instance:__wf_atom_68f2c268(v2)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:SetVisibility(false)
		instance:Destroy()
	end
end

function DissolveAvatarNoAnim(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v2 = math.random(1, 5)
	Sleep(v2)
	fn2(p)
end

function PulseProj(object, p)
	local v2 = 0

	while v2 < 1 do
		v2 = __wf_atom_421b01aa(v2 + __wf_atom_084b3e93() / p, 0, 1)
		object:__wf_atom_8f04e01e(v2)
		Sleep(0)
	end
end

function PulseLight(object, p)
	local v2 = p * 1
	local v3 = 0

	while v3 < 1 do
		v3 = __wf_atom_421b01aa(v3 + __wf_atom_084b3e93() / (v2 * 0.3), 0, 1)
		object:__wf_atom_edd3fec6(v3 * v3 * 0.05)
		Sleep(0)
	end

	local v4 = 0

	while v4 < 1 do
		v4 = __wf_atom_421b01aa(v4 + __wf_atom_084b3e93() / v2, 0, 1)
		object:__wf_atom_edd3fec6((1 - v4 * v4 * v4) * 0.05)
		Sleep(0)
	end
end