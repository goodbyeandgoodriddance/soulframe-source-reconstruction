local v = Resource("/EE/Types/Physics/Kinematic")
local v2 = Resource("/EE/Types/Physics/KinematicTrigger")
local v3 = Symbol("GAME_C1_COG")
Symbol("WaterBubbleSpiderAttachWaypoint")
WeakResource("/SF/Types/Game/ReflectorButton")
local vineBridgeModules2 = {}
local vineRemoveModules2 = {}
local v4 = nil
local v5 = nil
local v6 = {}
local v7 = nil
local v8 = { LINEAR = 0, QUADRATIC = 1, SQUARE = 2, SMOOTH = 3 }
local v9 = {
	SETUP = 0,
	HIDING = 1,
	DESCENDING = 2,
	HARVESTING = 3,
	ASCENDING = 4
}
local v10 = { DESCENDING = 0, RICOCHET = 1 }
local module = require("SF.Scripts.Libs.CommonFunctionsLib")

local function fn(_)
	vineRemoveModules2 = vineRemoveModules
	local vineRemoveModules = {}

	for k, vineRemoveModule in pairs(vineRemoveModules2) do
		vineRemoveModule:FirePort("PlayReverseTriggeredFade")
		table.insert(vineRemoveModules, vineRemoveModule)
		local v11 = nil

		if not (delaysAfterModuleGrowth[k] or k == #vineRemoveModules2) then
			continue
		end

		for _, v12 in pairs(vineRemoveModules) do
			local tableGetIndex = module.TableGetIndex(vineBridgeEffectDecoTypes, v12:__wf_atom_1bb5b1ff())
			local vineBridgeGrowTime = vineBridgeGrowTimes[tableGetIndex]
			local v13 = __wf_atom_7e8ad928(vineBridgeGrowTime) and 1 or vineBridgeGrowTime

			if __wf_atom_7e8ad928(v11) then
				v11 = v13
			elseif v11 < v13 then
				v11 = v13
			end

			v12:__wf_atom_2d56d046(v2)

			if k == #vineRemoveModules2 and k > 1 and not __wf_atom_7e8ad928(vineBridgeGrowFinalSound) then
				v12:PlaySound(vineBridgeGrowFinalSound, false)
			elseif __wf_atom_7e8ad928(vineBridgeGrowSounds[tableGetIndex]) then
				if not __wf_atom_7e8ad928(vineBridgeGrowSound) then
					v12:PlaySound(vineBridgeGrowSound, false)
				end
			else
				v12:PlaySound(vineBridgeGrowSounds[tableGetIndex], false)
			end
		end

		Sleep(v11)
		vineRemoveModules = {}
	end
end

local function fn2(p)
	vineBridgeModules2 = vineBridgeModules

	for k, vineBridgeModule in pairs(vineBridgeModules2) do
		if vineBridgeModule:IsA(__wf_atom_3ae8d73b) then
			continue
		end

		local tableGetIndex = module.TableGetIndex(vineBridgeStaticDecoTypes, vineBridgeModule)
		local v11

		if not __wf_atom_7e8ad928(tableGetIndex) then
			v11 = vineBridgeEffectDecoTypes[tableGetIndex]
		end

		local __wf_atom_c082fc3d = vineBridgeModule:__wf_atom_c082fc3d()

		if __wf_atom_7e8ad928(v11) then
			continue
		end

		local entity = gRegion:CreateEntity(
			v11,
			vineBridgeModule:GetPosition(),
			vineBridgeModule:__wf_atom_dc309f8a(),
			p,
			p
		)

		if __wf_atom_7e8ad928(entity) or __wf_atom_7e8ad928(vineBridgeModule) then
			continue
		end

		vineBridgeModules2[k] = entity
		entity:SetMeshScale(__wf_atom_c082fc3d)
	end

	local vineBridgeModules = {}

	for k, vineBridgeModule in pairs(vineBridgeModules2) do
		if vineBridgeModule:IsA(__wf_atom_6a50bd07) then
			vineBridgeModule:FirePort("Show")
			vineBridgeModule:Enable()
		else
			vineBridgeModule:FirePort("PlayTriggeredFade")
			table.insert(vineBridgeModules, vineBridgeModule)
			local v11 = nil

			if delaysAfterModuleGrowth[k] or k == #vineBridgeModules2 then
				for _, v12 in pairs(vineBridgeModules) do
					local tableGetIndex = module.TableGetIndex(vineBridgeEffectDecoTypes, v12:__wf_atom_1bb5b1ff())
					local vineBridgeGrowTime = vineBridgeGrowTimes[tableGetIndex]
					local v13 = __wf_atom_7e8ad928(vineBridgeGrowTime) and 1 or vineBridgeGrowTime

					if __wf_atom_7e8ad928(v11) then
						v11 = v13
					elseif v11 < v13 then
						v11 = v13
					end

					v12:__wf_atom_2d56d046(v)

					if k == #vineBridgeModules2 and k > 1 and not __wf_atom_7e8ad928(vineBridgeGrowFinalSound) then
						v12:PlaySound(vineBridgeGrowFinalSound, false)
					elseif __wf_atom_7e8ad928(vineBridgeGrowSounds[tableGetIndex]) then
						if not __wf_atom_7e8ad928(vineBridgeGrowSound) then
							v12:PlaySound(vineBridgeGrowSound, false)
						end
					else
						v12:PlaySound(vineBridgeGrowSounds[tableGetIndex], false)
					end
				end

				Sleep(v11)
				vineBridgeModules = {}
			end
		end
	end
end

function GrowVineBridgeAction(_, p)
	fn2(p)
end

function GrowAndShrinkAction(_, p)
	fn2(p)
	fn(p)
end

function GrowMultiplayerBridge(p)
	if not __wf_atom_7e8ad928(p) and #gRegion:__wf_atom_3c8e1a7a() > 1 then
		fn2(p)
	end
end

function GrowVineBridge(p)
	if not __wf_atom_7e8ad928(p) then
		fn2(p)
	end
end

function GrowVineBridgeButtonOnEnabled(object)
	while not object:__wf_atom_b81a6e66() do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Activate()
		fn2(object)
	end
end

function GrowVineBridgeCorruptedButtonOnEnabled(object)
	for _, v11 in pairs(corruptedNodes) do
		v11:FirePort("Show")

		if __wf_atom_7e8ad928(corruptedBeamType) then
			continue
		end

		local entity = gRegion:CreateEntity(corruptedBeamType, v11:GetPosition(), __wf_atom_80368bb1, v11)
		entity:AttachToInPlace(v11, EMPTY_SYMBOL)
		local __wf_atom_c082fc3d = v11:__wf_atom_c082fc3d()

		if __wf_atom_c082fc3d ~= 1 then
			entity:__wf_atom_e310f01f(entity:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d, entity:__wf_atom_45c0553e())
		end

		entity:__wf_atom_b2394158(object, EMPTY_SYMBOL)
	end

	while not object:__wf_atom_b81a6e66() do
		if #corruptedNodes == 0 then
			object:Activate()
		else
			for k, v11 in pairs(corruptedNodes) do
				if __wf_atom_7e8ad928(v11) then
					table.remove(corruptedNodes, k)
				end
			end
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:Activate()
		fn2(object)
	end
end

function FlowerHitLoop(instance)
	Sleep(0)
	module.Deflect(instance)
	instance:Destroy()
end

function BeanFlowerOnDamaged(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("FlowerHitLoop"), false)
	end
end

function ShakeVineShield(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	local v11 = Symbol("GrowthMaxRadius")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_8d0b7f88)
	local v12 = 0
	local v13 = 0.25

	while v12 < v13 do
		v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93(), 0, v13)
		local v14 = __wf_atom_104bfe98(0, 0.5, v12 / v13)
		local v15 = __wf_atom_104bfe98(0.2, 1, (v12 / v13) ^ 2)

		if not __wf_atom_7e8ad928(object) then
			object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v14)
			object:SetMaterialParam(v11, v15)
		end

		for _, v16 in pairs(__wf_atom_f582136d) do
			if __wf_atom_7e8ad928(v16) then
				continue
			end

			v16:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v14)
			v16:SetMaterialParam(v11, v15)
		end

		Sleep(0)
	end

	Sleep(0.75)
	local v14 = 0
	local v15 = 1

	while v14 < v15 do
		v14 = __wf_atom_421b01aa(v14 + __wf_atom_084b3e93(), 0, v15)
		local v16 = __wf_atom_104bfe98(0.5, 0, (math.sqrt(v14 / v15)))
		local v17 = __wf_atom_104bfe98(1, 0.2, (v14 / v15) ^ 2)

		if not __wf_atom_7e8ad928(object) then
			object:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v16)
			object:SetMaterialParam(v11, v17)
		end

		for _, v18 in pairs(__wf_atom_f582136d) do
			if __wf_atom_7e8ad928(v18) then
				continue
			end

			v18:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, v16)
			v18:SetMaterialParam(v11, v17)
		end

		Sleep(0)
	end

	__wf_atom_e919fb8e.noise = false
end

function DecoDeflectUpdate(object)
	Sleep(0)
	module.Deflect(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

function VineShieldOnHit(object, _)
	if not __wf_atom_7e8ad928(vineShieldHitFx) then
		gRegion:CreateEntity(vineShieldHitFx, object:GetPosition(), object:__wf_atom_dc309f8a())
	end

	if not __wf_atom_7e8ad928(vineShieldHitSound) then
		object:PlaySound(vineShieldHitSound, false)
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_e919fb8e.noise then
		object:__wf_atom_8a035cd5(Symbol("ShakeVineShield"), false)
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("DecoDeflectUpdate"), false)
	end

	object:SetHealth(object:__wf_atom_95174740())
end

function RicochetButtonHitFeedback(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	object:__wf_atom_c082fc3d()
	object:__wf_atom_ec90d09a(true)
	object:PlaySound(ricochetMushroomHitSound, false)
	Sleep(0.1)
	object:__wf_atom_ec90d09a(false)
	__wf_atom_e919fb8e.noise = false
end

function RicochetButtonOnHit(object)
	if not object:__wf_atom_e919fb8e().noise then
		object:__wf_atom_8a035cd5(Symbol("RicochetButtonHitFeedback"), false)
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(ricochetButtonSkelDeco)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:FirePort("PlayTriggeredAnim")
	end

	if gRegion:IsMaster() and not __wf_atom_7e8ad928(object) then
		object:SetHealth((object:__wf_atom_95174740()))
	end
end

local function fn3()
	if #v6 > 0 then
		for i = #v6, 1, -1 do
			if not __wf_atom_7e8ad928(v6[i]) then
				v6[i]:Destroy()
			end
		end
	end

	v6 = {}

	if not __wf_atom_7e8ad928(v7) then
		v7:Destroy()
	end

	v7 = nil
end

local function fn4(list, p)
	local v11 = Color(0, 255, 0)
	local v12 = Color(255, 0, 0)
	local v13

	if p then
		v13 = 1
	else
		v11 = v12
		v13 = 0.2
	end

	local flag = false

	local function fn5(items) -- 1 equivalent call inferred from this helper
		local count = 0

		for _, item in pairs(items) do
			if not __wf_atom_7e8ad928(item.startEntity) then
				count += 1
			end
		end

		return count
	end

	if #v6 == 0 then
		flag = true
	elseif #v6 == fn5(list) then -- inferred equivalent call
		for k, v14 in pairs(v6) do
			if __wf_atom_7e8ad928(v14) then
				flag = true
			elseif __wf_atom_7e8ad928(v6[k]) or __wf_atom_7e8ad928(list[k + 1]) then
				flag = true
			elseif v6[k]:GetCreator() ~= list[k + 1].startEntity then
				flag = true
			end
		end

		if not __wf_atom_7e8ad928(v6[1]) then
			if p or not v6[1]:IsA(ricochetSuccessBeamType) then
				if p and not v6[1]:IsA(ricochetSuccessBeamType) then
					flag = true
				end
			else
				flag = true
			end
		end
	else
		flag = true
	end

	if flag then
		fn3()
	end

	for k, v14 in pairs(list) do
		if __wf_atom_7e8ad928(v14.startPos) or __wf_atom_7e8ad928(v14.endPos) then
			continue
		end

		if not __wf_atom_7e8ad928(v14.startEntity) then
			local v15

			if flag then
				local v16

				if p then
					v16 = ricochetSuccessBeamType
				else
					v16 = ricochetBeamType
				end

				v15 = gRegion:CreateEntity(v16, v14.startPos, __wf_atom_80368bb1, v14.startEntity)
				table.insert(v6, k - 1, v15)
			else
				v15 = v6[k - 1]
			end

			if not __wf_atom_7e8ad928(v15) then
				v15:SetPosition(v14.startPos)
				v15:__wf_atom_a64eca67(v14.endPos)
			end
		end

		if k ~= #list then
			continue
		end

		local endPos = v14.endPos

		if not __wf_atom_7e8ad928(v14.endEntity) and v14.endEntity:IsA(__wf_atom_7b01f9ce) then
			local __wf_atom_3d96ddcd = v14.endEntity:__wf_atom_3d96ddcd()

			if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
				endPos = __wf_atom_3d96ddcd:GetPosition()
			end
		end

		if flag and not __wf_atom_7e8ad928(ricochetEndpointFxType) then
			v7 = gRegion:CreateEntity(ricochetEndpointFxType, endPos, __wf_atom_80368bb1)
		end

		gRegion:__wf_atom_8d991675(endPos, v13, v11, 0)
	end
end

local fn5

local function fn6(p, p2) -- 1 equivalent call inferred from this helper
	return p - 2 * Dot(p, p2) * p2
end

fn5 = function(position, endPos, p, startEntity, p2)
	local v11 = {}
	local v12 = __wf_atom_7e8ad928(p2) and {} or p2
	local v13 = { __wf_atom_67c46eba, __wf_atom_ca04301b, __wf_atom_be0a175e }
	local endPos2 = Vector()
	local v14 = Rotation()
	local v15 = endPos - position
	Normalize(v15)
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(position, endPos + v15, startEntity, v13, nil, endPos2, v14)

	if __wf_atom_7e8ad928(__wf_atom_267afa54) then
		v11.startPos = position
		v11.endPos = endPos
		v11.startEntity = startEntity
		v11.endEntity = nil
		table.insert(v12, v11)
	else
		local v16 = endPos2 + fn6(v15, __wf_atom_9341614d(Vector(0, 0, 1), v14)) * 50 -- inferred equivalent call
		v11.startPos = position
		v11.endPos = endPos2
		v11.startEntity = startEntity
		v11.endEntity = __wf_atom_267afa54
		table.insert(v12, v11)

		if __wf_atom_267afa54:IsA(__wf_atom_8d0b7f88) and __wf_atom_267afa54:__wf_atom_6f31525e() and p >= 0 then
			return (fn5(endPos2, v16, p - 1, __wf_atom_267afa54, v12))
		end
	end

	return v12
end

local v11 = Vector()
local flag = true

function OnPredictiveHitFound(object, p)
	if p or __wf_atom_7e8ad928(object) then
		flag = true
		v11 = object:__wf_atom_d825bd01()
	else
		flag = false
	end
end

local function fn7(endEntity, hitTargetTypes) -- 1 equivalent call inferred from this helper
	for _, className in pairs(hitTargetTypes) do
		if endEntity:IsA(className) then
			return true
		end
	end

	return false
end

function RicochetButton(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_f53c239e)
	local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
	local ___wf_atom_28d5d4aa2 = __wf_atom_28d5d4aa

	if __wf_atom_7e8ad928(_T.puzzleRicochetForecastTimer) then
		_T.puzzleRicochetForecastTimer = 0
	end

	local v12 = nil

	while object:IsEnabled() do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local v13 = not __wf_atom_7e8ad928(__wf_atom_bb3e7833)
				and __wf_atom_bb3e7833:__wf_atom_1c85e812(__wf_atom_c4f78a8f)
			local puzzleRicochetForecastOn = __wf_atom_c4f78a8f:__wf_atom_92aa9d91():__wf_atom_3911136e()
				or _T.puzzleRicochetForecastTimer > 0
			_T.puzzleRicochetForecastOn = puzzleRicochetForecastOn
			local v14 = false

			if v13 and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:CameraControl()) then
				if not _T.puzzleRicochetForecastOn then
					_T.ShowImpactMessage("[HC] Use Soul View to see ricochet lines", -1)
				end

				if _T.puzzleRicochetForecastOn then
					local __wf_atom_a8e8c5c4 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_a8e8c5c4()

					if not __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) and __wf_atom_a8e8c5c4:IsA(__wf_atom_77e05d3b) then
						__wf_atom_a8e8c5c4:__wf_atom_49e22055(object, "OnPredictiveHitFound")
						v14 = true
					end
				end
			else
				if _T.puzzleRicochetForecastOn then
					_T.HideImpactMessage()
				end

				fn3()
			end

			if not v14 then
				flag = false
			end

			if flag then
				local __wf_atom_dd7246c7 = __wf_atom_c4f78a8f:CameraControl():__wf_atom_dd7246c7()

				if not __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
					v12 = fn5(__wf_atom_dd7246c7:GetPosition(), v11, 5)

					if not __wf_atom_7e8ad928(v12) and _T.puzzleRicochetForecastOn and v13 then
						local v15 = false
						local endEntity = v12[#v12].endEntity

						if not __wf_atom_7e8ad928(endEntity) and fn7(endEntity, hitTargetTypes) then -- inferred equivalent call
							v15 = true
						end

						fn4(v12, v15)
					end

					_T.puzzleRicochetForecastTimer = 10
				end
			end

			if _T.puzzleRicochetForecastTimer > 0 then
				_T.puzzleRicochetForecastTimer = _T.puzzleRicochetForecastTimer - __wf_atom_084b3e93()
			else
				fn3()
			end

			if not __wf_atom_7e8ad928(v12) and _T.puzzleRicochetForecastOn then
				_T.HideImpactMessage()
			end
		end

		Sleep(0)
	end
end

function WaterBubbleSlotOnEnabled(object)
	while not __wf_atom_7e8ad928(object) do
		if object:__wf_atom_b81a6e66() then
			gRegion:CreateEntity(
				wateringEffectType,
				object:GetPosition() + Vector(0, -0.5, 0),
				object:__wf_atom_dc309f8a() + Rotation(90, -90, 90)
			)
			object:PlaySound(waterBubbleActivateSound, false)
			break
		else
			Sleep(0)
		end
	end
end

local function fn8(object, position, p, total, p2, p3)
	if __wf_atom_7e8ad928(object) or not (total < p2) then
		return total
	end

	local v12 = total / p2

	if p3 ~= v8.LINEAR then
		if p3 == v8.QUADRATIC then
			v12 = math.pow(v12, 2)
		elseif p3 == v8.SQUARE then
			v12 = math.sqrt(v12)
		elseif p3 == v8.SMOOTH then
			v12 = __wf_atom_24a82b69(v12)
		end
	end

	object:SetPosition((__wf_atom_f55d6358(position, p, v12)))
	total += __wf_atom_084b3e93()
	return total
end

local function fn9(object, object2)
	local entity = gRegion:CreateEntity(spiderBeamType, object:GetPosition(), object:__wf_atom_dc309f8a())
	entity:__wf_atom_dc5956fc(object, v3)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()

	if __wf_atom_c082fc3d ~= 1 then
		entity:__wf_atom_e310f01f(entity:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d, entity:__wf_atom_45c0553e())
	end

	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(__wf_atom_3a0953be)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = object2
	end

	entity:__wf_atom_b2394158(__wf_atom_bb3e7833, EMPTY_SYMBOL)
	return entity
end

local function fn10(position, p)
	local v12

	if p then
		v12 = position + Vector(0, 100, 0)
	else
		v12 = position - Vector(0, 100, 0)
	end

	local v13 = Vector(0, -3, 0)
	local v14 = { __wf_atom_6a50bd07 }
	local v15 = Vector()
	gRegion:__wf_atom_c20d246a(position + v13, v12, v14, nil, v15)

	if __wf_atom_7e8ad928(v15) or v15 == __wf_atom_28d5d4aa then
		return
	end

	v15.x = position.x
	v15.z = position.z

	if p then
		return v15
	end

	local v16 = Vector(v15.x, v15.y, v15.z)

	if not v4:__wf_atom_bd5c14eb(v16, 0.5, 0, 99) then
		v4:__wf_atom_bd5c14eb(v16, 5, 0, 99)
	end

	if not __wf_atom_7e8ad928(v16) and v16 ~= v15 and Distance(v15, v16) < 1 then
		if v15.y < v16.y then
			return (Vector(v16.x, v15.y, v16.z))
		end

		return v16
	end

	return v15
end

local function fn11(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_a8553251 = gRegion:__wf_atom_a8553251()

	for _, v12 in pairs(__wf_atom_a8553251) do
		if object:__wf_atom_1c85e812(v12) then
			return true
		end
	end

	return false
end

function WaterCarrierSpiderOnHit(object, _)
	if gRegion:IsMaster() then
		if object:IsEnabled() and object:__wf_atom_fd9131f8() then
			object:Activate()
		end

		if not __wf_atom_7e8ad928(object) then
			object:SetHealth((object:__wf_atom_95174740()))
		end
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("DecoRemoveAttachedDeco"), false)
	end
end

function WaterCarrierSpiderOnEnabled(object)
	v4 = gRegion:__wf_atom_2202ffb6()
	v5 = object

	if __wf_atom_7e8ad928(object) then
		return
	end

	local position = object:GetPosition()
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(holeDeco)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:__wf_atom_e6ed03c8()
		__wf_atom_bb3e7833:SetVisibility(true)
	end

	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(__wf_atom_f53c239e)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
		__wf_atom_bb3e7833_2:__wf_atom_e6ed03c8()
		__wf_atom_bb3e7833_2:SetPosition(position - Vector(0, ricochetSpiderDescendOffset / 2, 0))
	end

	local __wf_atom_bb3e7833_3 = object:__wf_atom_bb3e7833(bubbleDeco)
	local position2

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		position2 = fn10(position, true)
		__wf_atom_bb3e7833 = gRegion:CreateEntity(
			spiderHideoutWaypointType,
			position2 + Vector(0, 1, 0),
			__wf_atom_80368bb1
		)
	else
		position2 = __wf_atom_bb3e7833:GetPosition()
	end

	local v12 = nil

	if spiderKindIndex == v10.DESCENDING then
		v12 = fn10(position, false)
	elseif spiderKindIndex == v10.RICOCHET then
		v12 = position2 - Vector(0, ricochetSpiderDescendOffset, 0)
	end

	local v13 = Distance(position2, v12)
	fn9(object, __wf_atom_bb3e7833)
	local _ = { __wf_atom_bb3e7833 }
	local v14 = __wf_atom_5784a397(2, 8)
	object:__wf_atom_e792b90b(true)
	local v15 = nil
	local v16 = 0
	local v17 = 0

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_f2317dfd = object:__wf_atom_f2317dfd()
		local v18 = not __wf_atom_7e8ad928(v15) and v15 ~= __wf_atom_f2317dfd

		if __wf_atom_f2317dfd == v9.SETUP then
			object:__wf_atom_0e990c03(v9.HIDING)
		elseif __wf_atom_f2317dfd == v9.HIDING then
			if v18 then
				object:MakeInvulnerable()
				object:SetVisibility(false)
				object:__wf_atom_e792b90b(false)
				__wf_atom_bb3e7833_3:SetVisibility(false)

				if object:__wf_atom_b81a6e66() then
					object:Deactivate()

					if spiderDisableOnPickUpDrop then
						object:Disable()
					end
				end
			end

			if not object:IsEnabled() then
				break
			end

			if spiderKindIndex == v10.DESCENDING then
				Sleep(v14)
				object:__wf_atom_0e990c03(v9.DESCENDING)
			elseif
				spiderKindIndex == v10.RICOCHET
				and not fn11(__wf_atom_bb3e7833_2)
				and __wf_atom_7e8ad928(gRegion:__wf_atom_e2db08ce(__wf_atom_9c4e6f99, position, 5))
			then
				Sleep(1)
				object:__wf_atom_0e990c03(v9.DESCENDING)
			end
		elseif __wf_atom_f2317dfd == v9.DESCENDING then
			if v18 then
				position = object:GetPosition()
				object:SetVisibility(true)
				object:__wf_atom_e792b90b(true)
				__wf_atom_bb3e7833_3:SetVisibility(false)

				if spiderKindIndex == v10.DESCENDING then
					__wf_atom_bb3e7833_3:SetVisibility(false)
				elseif spiderKindIndex == v10.RICOCHET then
					__wf_atom_bb3e7833_3:SetVisibility(true)
				end

				object:MakeVulnerable()
				v17 = v13 / spiderDescendSpeed
				v16 = 0

				if not __wf_atom_7e8ad928(spiderSpawnSound) then
					object:PlaySound(spiderSpawnSound, false)
				end
			end

			if object:__wf_atom_b81a6e66() then
				object:__wf_atom_0e990c03(v9.ASCENDING)
			end

			if v16 < v17 then
				v16 = fn8(object, position2, v12, v16, v17, v8.SMOOTH)
			else
				object:__wf_atom_0e990c03(v9.HARVESTING)
			end
		elseif __wf_atom_f2317dfd == v9.HARVESTING then
			if v18 and not __wf_atom_7e8ad928(spiderSplashEffectType) then
				gRegion:CreateEntity(
					spiderSplashEffectType,
					object:__wf_atom_1c374cc9(v3) + Vector(0, 0.5, 0),
					__wf_atom_80368bb1
				)
			end

			object:__wf_atom_e792b90b(false)

			if spiderKindIndex == v10.DESCENDING then
				Sleep(0.5)
				object:__wf_atom_0e990c03(v9.ASCENDING)
			elseif spiderKindIndex == v10.RICOCHET and (fn11(__wf_atom_bb3e7833_2) or object:__wf_atom_b81a6e66()) then
				object:__wf_atom_0e990c03(v9.ASCENDING)
			end
		elseif __wf_atom_f2317dfd == v9.ASCENDING then
			if v18 then
				object:__wf_atom_e792b90b(true)
				position = object:GetPosition()
				v13 = Distance(position, position2)
				v17 = v13 / spiderAscendSpeed
				v16 = 0

				if spiderKindIndex == v10.DESCENDING and not object:__wf_atom_b81a6e66() then
					__wf_atom_bb3e7833_3:SetVisibility(true)
				end

				if not __wf_atom_7e8ad928(spiderSplashEffectType) then
					gRegion:CreateEntity(
						spiderSplashEffectType,
						object:__wf_atom_1c374cc9(v3) + Vector(0, 0.5, 0),
						__wf_atom_80368bb1
					)
				end
			end

			if v13 * (1 - v16 / v17) < 1 and v13 * (v16 / v17) < 1 and object:__wf_atom_fd9131f8() then
				object:MakeInvulnerable()
			elseif not object:__wf_atom_fd9131f8() then
				object:MakeVulnerable()
			end

			if object:__wf_atom_b81a6e66() and __wf_atom_bb3e7833_3:IsVisible() then
				position = object:GetPosition()
				v13 = Distance(position, position2)
				__wf_atom_bb3e7833_3:SetVisibility(false)
				gRegion:CreateEntity(
					bubblePickUpType,
					__wf_atom_bb3e7833_3:GetPosition(),
					__wf_atom_bb3e7833_3:__wf_atom_dc309f8a(),
					object
				)
				v17 = v13 / spiderDescendSpeed
				v16 = 0
			end

			if v16 < v17 then
				v16 = fn8(object, position, position2, v16, v17, v8.LINEAR)
			else
				object:__wf_atom_0e990c03(v9.HIDING)
			end
		end

		Sleep(0)
		v15 = __wf_atom_f2317dfd
	end
end

function AutoAlignRicochetButtons(_)
	if __wf_atom_7e8ad928(idealPlayerGroundWaypoint) then
		return
	end

	local v12 = idealPlayerGroundWaypoint:GetPosition() + idealPlayerGroundOffset
	local position = ricochetTarget:GetPosition()
	local v13 = {}

	local function fn12(p, p2, p3)
		local v14 = p - p2
		local v15 = p3 - p2
		local normalized = Normalize(v14)
		local normalized2 = Normalize(v15)
		gRegion:__wf_atom_628723a6(p2, p2 + normalized, Color(0, 255, 0), 50)
		gRegion:__wf_atom_628723a6(p2, p2 + normalized2, Color(0, 255, 0), 50)
		return normalized + normalized2
	end

	local v14 = {}

	local function fn13(heading, pitch, bank)
		local v15 = math.cos(heading * 0.5)
		local v16 = math.sin(heading * 0.5)
		local v17 = math.cos(pitch * 0.5)
		local v18 = math.sin(pitch * 0.5)
		local v19 = math.cos(bank * 0.5)
		local v20 = math.sin(bank * 0.5)
		local v21 = v19 * v18 * v15 + v20 * v17 * v16
		local v22 = v19 * v17 * v16 - v20 * v18 * v15
		local v23 = v20 * v17 * v15 + v19 * v18 * v16
		local v24 = v19 * v17 * v15 - v20 * v18 * v16
		return {
			x = v21,
			y = v22,
			z = -v23,
			w = v24
		}
	end

	for _, v15 in pairs(ricochetButtons) do
		table.insert(v13, (v15:GetPosition()))
	end

	table.insert(v13, 1, v12)
	table.insert(v13, #v13 + 1, position)

	for k, v15 in pairs(v13) do
		if k > 1 and k < #v13 then
			table.insert(v14, (fn12(v13[k - 1], v15, v13[k + 1])))
		end
	end

	local function fn14(p) -- 3 equivalent calls inferred from this helper
		return math.floor(p * 100) / 100
	end

	for k, v15 in pairs(ricochetButtons) do
		local position2 = v15:GetPosition()
		local v16 = __wf_atom_fa8d0177(position2, position2 + v14[k]) + ricochetButtonRotationCompensation
		local v17 = Rotation(fn14(v16.heading), fn14(v16.pitch), fn14(v16.bank)) -- inferred equivalent call
		local v18 = "X = " .. string.format("%.2f", (tostring(v17.heading))) .. ", Y = " .. string.format("%.2f", (tostring(v17.pitch)))
		gRegion:__wf_atom_5b35a0c8(v15:GetPosition(), Color(0, 255, 0), v18, 2, 50)
		local v19 = fn13(math.rad(v17.heading), math.rad(v17.pitch), math.rad(v17.bank))
		local v20 = "Rotation={" .. tostring(v19.x) .. "," .. tostring(v19.y) .. "," .. tostring(v19.z) .. "," .. tostring(v19.w) .. "}"
		print(tostring(v15:GetName()) .. "ricochet rotation (after asterisk): *" .. v20)
		v15:__wf_atom_9b788a35(v17)
	end

	gRegion:__wf_atom_8d991675(idealPlayerGroundWaypoint:GetPosition(), 0.2, Color(0, 255, 0), 50)
end