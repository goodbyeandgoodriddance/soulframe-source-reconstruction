local v = Symbol("SparrowWait")
local v2 = Symbol("SparrowOffsetAvoidVehicle")
local v3 = Symbol("SparrowPerchPoint")
local v4 = Symbol("SparrowHoverPoint")
local v5 = Symbol("SPARROW_GUIDE_VFX")
local v6 = Symbol("SPARROW_LIGHT")
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local flag = false
local v12 = false
local v13 = {}
local v14 = 0
local flag2 = false
local v15 = nil
local v16 = false
local v17 = nil
local v18 = WeakResource("/SF/Types/Player/Ghost/SfGhostAvatar")
local v19 = WeakResource("/SF/Types/Game/MarkerInfos/PaintedMarkerInfo")
local v20 = Resource("/SF/Animations/Wildlife/Sparrow/PerchIdle01_anim.fbx")
local v21 = Type("/SF/Fx/Abilities/Common/Bird/BirdExplosionFX")
local v22 = WeakResource("/SF/Types/NeutralCreatures/SparrowAvatar")
local v23 = WeakResource("/SF/Types/Player/EnvoyAvatar")
local v24 = WeakResource("/SF/Types/Quests/AncestorProgression/TuvalkaneProgression/QuestAssets/TuvalkanesHelmetWeapon")
local v25 = 0
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Scripts.Libs.StatsLib")

local function fn(position)
	if __wf_atom_7e8ad928(position) then
		v13 = {}
		return
	end

	local v26 = nil
	local v27

	if not __wf_atom_7e8ad928(landAnim) then
		v27 = gRegion:__wf_atom_439c0d29(v3, position, 0, 5)
	end

	if not __wf_atom_7e8ad928(toHoverAnim) then
		v26 = gRegion:__wf_atom_439c0d29(v4, position, 0, 5)
	end

	v13 = module.MergeTables(v27, v26)
end

local function fn2()
	if __wf_atom_7e8ad928(v9) then
		return
	end

	v13 = module.RemoveNilEntries(v13)
	local v26 = {}

	for _, v27 in ipairs(v13) do
		if v27:IsEnabled() then
			table.insert(v26, v27)
		end
	end

	if #v26 == 0 then
		return
	end

	local nearestObject = module.NearestObject(v17, v26, nil, true)
	local v27 = nearestObject:__wf_atom_db682341() == v4
	local position = nearestObject:GetPosition()
	local v28 = __wf_atom_fa8d0177(v9:GetPosition(), position)
	v8:__wf_atom_5a0e15fd(v, 1)
	local landAnim2 = nil
	local toHoverAnim2, idleHoverAnim2

	if v27 then
		toHoverAnim2 = toHoverAnim
		idleHoverAnim2 = idleHoverAnim
	else
		idleHoverAnim2 = perchLoopAnim
		landAnim2 = landAnim
		toHoverAnim2 = rotateAnim
	end

	if not __wf_atom_7e8ad928(landAnim2) then
		v9:__wf_atom_e4df34a5(false)
		v9:__wf_atom_3c986cd9(position, v28, false)
		v9:__wf_atom_921c1a5f(landAnim2, true, 3, 1, true)

		while not __wf_atom_7e8ad928(v9) and v9:__wf_atom_c138b19b(landAnim2) do
			Sleep(0)
		end

		v9:__wf_atom_e4df34a5(true)
	end

	if not __wf_atom_7e8ad928(toHoverAnim2) then
		local v29

		if __wf_atom_7e8ad928(v10) then
			v29 = v9:GetPosition()
		else
			v29 = v10:GetPosition()
		end

		local v30 = __wf_atom_fa8d0177(position, v29)
		v9:__wf_atom_3c986cd9(position, v30, false)
		v9:__wf_atom_921c1a5f(toHoverAnim2, true, 3, 1, true)
	end

	if not __wf_atom_7e8ad928(idleHoverAnim2) then
		v9:__wf_atom_921c1a5f(idleHoverAnim2, false, 3, 2, true)
	end

	local _sparrowDebugDraw = _T.SparrowDebugDraw
	v11 = nearestObject

	if v27 then
		v12 = true
	else
		flag = true
	end

	v9:__wf_atom_98a0c9bd(v5, false)
	return true
end

local function fn3()
	if not __wf_atom_7e8ad928(v9) then
		if v9:__wf_atom_c138b19b(perchLoopAnim) then
			v9:__wf_atom_921c1a5f(takeOffAnim, false, 3, 1, true)
		elseif v9:__wf_atom_c138b19b(idleHoverAnim) then
			v9:__wf_atom_921c1a5f(fromHoverAnim, false, 0, 1, true)
		end

		v9:__wf_atom_98a0c9bd(v5, true)
	end

	v11 = nil
	flag = false
	v12 = false
	v8:ClearAgentBlackboardEntry(v)
end

local function fn4(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_43cc9de1 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("PerchAnim"))

		if not __wf_atom_7e8ad928(__wf_atom_43cc9de1) then
			perchLoopAnim = __wf_atom_43cc9de1
		end

		local __wf_atom_43cc9de1_2 = __wf_atom_e55d02aa:__wf_atom_43cc9de1(Symbol("TakeOffAnim"))

		if not __wf_atom_7e8ad928(__wf_atom_43cc9de1_2) then
			takeOffAnim = __wf_atom_43cc9de1_2
		end
	end
end

local function fn5(p, heading) -- 2 equivalent calls inferred from this helper
	if p - heading > 180 then
		p -= 360
	end

	if p - heading < -180 then
		p += 360
	end

	return p - heading
end

local function fn6(p, object)
	local position = Vector(0, 0, 0)
	local currentSparrowDestination = module2.GetCurrentSparrowDestination()
	local v26

	if __wf_atom_7e8ad928(currentSparrowDestination) or __wf_atom_7e8ad928(currentSparrowDestination.entity) then
		v26 = false
	else
		position = currentSparrowDestination.entity:GetPosition()
		v26 = true
	end

	local v27 = Symbol("GAME_C1_NECK2")
	local v28 = Symbol("GAME_C1_NECK1")
	local __wf_atom_8e4cf043 = object:__wf_atom_8e4cf043(Symbol("GAME_C1_ROOT"))
	local position2 = object:GetPosition()
	local v29 = __wf_atom_fa8d0177(position2, position)
	local heading = __wf_atom_8e4cf043.heading
	local v30 = fn5(v29.heading, heading) -- inferred equivalent call
	local v31 = __wf_atom_104bfe98(0, v30, v14)
	local flag3 = false

	if v26 and Abs(v30) < 90 and p < 3 then
		object:__wf_atom_c2377fc8(v27, true)
		object:__wf_atom_c2377fc8(v28, true)
		v14 += __wf_atom_084b3e93() * 2
		v14 = __wf_atom_421b01aa(v14, 0, 1)
		object:__wf_atom_2f0092a2(v27, Rotation(v31 / 2, 0, 0))
		object:__wf_atom_2f0092a2(v28, Rotation(v31 / 2, 0, 0))

		if not flag2 then
			object:__wf_atom_921c1a5f(nil, false)
			flag3 = true
		end

		flag2 = true
	else
		if v14 <= 0 then
			object:__wf_atom_c2377fc8(v27, false)
			object:__wf_atom_c2377fc8(v28, false)
		else
			object:__wf_atom_2f0092a2(v27, Rotation(v31 / 2, 0, 0))
			object:__wf_atom_2f0092a2(v28, Rotation(v31 / 2, 0, 0))
		end

		v14 -= __wf_atom_084b3e93() * 5
		v14 = __wf_atom_421b01aa(v14, 0, 1)

		if flag2 then
			object:__wf_atom_921c1a5f(nil, false)
			flag3 = true
		end

		flag2 = false
	end

	while flag3 do
		Sleep(0)

		if flag2 then
			object:__wf_atom_921c1a5f(armPerchLookLoopAnim, false, 3, 2, true)
		else
			object:__wf_atom_921c1a5f(armPerchLoopAnim, false, 3, 2, true)
		end

		flag3 = false
	end
end

local function fn7(instance, object)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) then
		return
	end

	instance:__wf_atom_98a0c9bd(v5, false)
	instance:__wf_atom_98a0c9bd(v6, false)
	local shoulderTakeOffBackAnim = shoulderTakeOffBackAnim

	if math.random(0, 1) < 0.5 then
		shoulderTakeOffBackAnim = shoulderTakeOffFrontAnim
	end

	instance:__wf_atom_921c1a5f(nil, false)
	Sleep(0)
	instance:__wf_atom_921c1a5f(shoulderTakeOffBackAnim, true, 3, 1, true)

	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_be7f08c9(false)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

local function fn8(p, p2) -- 5 equivalent calls inferred from this helper
	local v26 = p + p2

	if v26 >= 180 then
		return v26 - 360
	end

	if v26 < -180 then
		return v26 + 360
	end

	return v26
end

local function fn9(object, object2, sparrowImmediateShoulderPerch)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		return
	end

	__wf_atom_e919fb8e.sparrowFlyingToShoulder = true
	object:__wf_atom_78ad8b9f(6, 1)
	object:__wf_atom_e4df34a5(false)
	object:__wf_atom_18619c34(1.25)
	object:__wf_atom_98a0c9bd(v5, false)
	object:__wf_atom_98a0c9bd(v6, false)

	if
		sparrowImmediateShoulderPerch
		and not (__wf_atom_7e8ad928(shoulderLandFrontAnim) or __wf_atom_7e8ad928(shoulderLandBackAnim))
	then
		local v26 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1")) + __wf_atom_9341614d(
			module2.GetShoulderOffset(object2),
			object2:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1"))
		) + Vector(0, object2:__wf_atom_3d840c93(175), 0)
		local v27 = __wf_atom_fa8d0177(object:GetPosition(), v26)
		local __wf_atom_3d840c93 = object2:__wf_atom_3d840c93(173)
		local heading = v27.heading
		local shoulderLandFrontAnim = shoulderLandFrontAnim

		if math.sign(__wf_atom_3d840c93) == math.sign(heading) then
			shoulderLandFrontAnim = shoulderLandBackAnim
		end

		local rotation = Rotation
		local v28 = rotation(fn8(__wf_atom_3d840c93, 15), 0, 0) -- inferred equivalent call
		local __wf_atom_df9e931d = shoulderLandFrontAnim:__wf_atom_df9e931d(Symbol("GAME_C1_ROOT"), 1)
		object:SetPosition(v26 - __wf_atom_df9e931d)
		object:__wf_atom_921c1a5f(shoulderLandFrontAnim, false, 2, 1, false)
		Sleep(0)
		local __wf_atom_8bb4ded3 = shoulderLandFrontAnim:__wf_atom_8bb4ded3()
		local total = 0

		while
			not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(object2)
			and object:__wf_atom_c138b19b(shoulderLandFrontAnim)
		do
			if not module2.CanShoulderPerch(object2) then
				fn7(object, object2)
				return
			end

			total += __wf_atom_084b3e93()
			local v29 = __wf_atom_421b01aa(total / __wf_atom_8bb4ded3, 0, 1)
			local v30 = __wf_atom_421b01aa(__wf_atom_24a82b69(total / (__wf_atom_8bb4ded3 - 1)), 0, 1)
			local v31 = __wf_atom_8bb4ded3 - 1 <= total and 1 or v30
			local v32 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1")) + __wf_atom_9341614d(
				module2.GetShoulderOffset(object2),
				object2:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1"))
			) + Vector(0, object2:__wf_atom_3d840c93(175), 0)
			local v33 = fn8(object2:__wf_atom_3d840c93(173), 15) -- inferred equivalent call
			local __wf_atom_df9e931d2, v34 = shoulderLandFrontAnim:__wf_atom_df9e931d(Symbol("GAME_C1_ROOT"), v29)
			local v35 = v26 + __wf_atom_9341614d(__wf_atom_df9e931d2 - __wf_atom_df9e931d, v28)
			local v36 = v35 + (v32 + __wf_atom_9341614d(__wf_atom_df9e931d2 - __wf_atom_df9e931d, Rotation(v33, 0, 0)) - v35) * v31
			local v37 = fn5(v33, v28.heading) -- inferred equivalent call
			local __wf_atom_d919c2d7 = __wf_atom_d919c2d7
			local rotation2 = Rotation
			object:Teleport(v36, (__wf_atom_d919c2d7(v34, rotation2(fn8(v28.heading, v37 * v31), 0, 0)))) -- inferred equivalent call
			Sleep(0)
		end
	else
		local _ = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1")) + module2.GetShoulderOffset(object2)

		while not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(object2)) do
			if not module2.CanShoulderPerch(object2) then
				fn7(object, object2)
				return
			end

			local v26 = object2:__wf_atom_1c374cc9(Symbol("GAME_R1_ARM1")) + module2.GetShoulderOffset(object2)

			if
				not __wf_atom_7e8ad928(v26)
				and (object:__wf_atom_c215662d(v26) < 0.04000000000000001 or object:__wf_atom_c215662d(v26) <= (10 * __wf_atom_084b3e93()) ^ 2)
			then
				break
			end

			if object:__wf_atom_c215662d(v26) > 4 then
				__wf_atom_30e3d82b:__wf_atom_b783ff91(v26)
			else
				local v27 = v26 - object:GetPosition()
				Normalize(v27)
				local v28 = __wf_atom_fa8d0177(object:GetPosition(), v26)
				local v29 = v27 * 10
				object:Teleport(object:GetPosition() + v29 * __wf_atom_084b3e93(), v28)
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
		end
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	__wf_atom_e919fb8e.sparrowShoulderPerching = true
	__wf_atom_e919fb8e.sparrowFlyingToShoulder = false
	local v26 = fn8(object2:__wf_atom_3d840c93(173), 15) -- inferred equivalent call
	local v27 = Rotation(v26, 0, 0)
	local v28 = __wf_atom_0a00e162(object2:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1")))
	local shoulderOffset = module2.GetShoulderOffset(object2)
	local v29 = __wf_atom_d919c2d7(v28, v27)
	object2:AttachEntity(object, Symbol("GAME_R1_ARM1"), shoulderOffset, v29)
	local __wf_atom_c082fc3d = object2:__wf_atom_c082fc3d()

	if __wf_atom_c082fc3d ~= 1 then
		object:__wf_atom_e310f01f(object:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d, object:__wf_atom_45c0553e())
	end

	object:SetMeshScale(1.25)
	local v30 = __wf_atom_7e8ad928(object2:__wf_atom_278a2d05()) and 0 or Length(object2:__wf_atom_278a2d05())

	if not sparrowImmediateShoulderPerch then
		object:__wf_atom_921c1a5f(landAnim, true, 3, 1, true)
	end

	if v30 < 1 then
		object:__wf_atom_921c1a5f(armPerchLoopAnim, false, 3, 2, true)
	elseif v30 < 3 then
		object:__wf_atom_921c1a5f(armPerchWalkLoopAnim, false, 3, 2, true)
	else
		object:__wf_atom_921c1a5f(armPerchJogLoopAnim, false, 3, 2, true)
	end
end

local function fn10(object, object2)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	v25 = 0.5
	object:__wf_atom_78ad8b9f(6, 1)
	local __wf_atom_e919fb8e = object2:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.sparrowShoulderPerching = false
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local __wf_atom_2f2bada0 = object:__wf_atom_2f2bada0()
	__wf_atom_2f2bada0.heading = __wf_atom_2f2bada0.heading
	local currentSparrowDestination = module2.GetCurrentSparrowDestination()

	if __wf_atom_7e8ad928(currentSparrowDestination) or __wf_atom_7e8ad928(currentSparrowDestination.entity) then
		if not __wf_atom_7e8ad928(object:__wf_atom_30e3d82b()) then
			object:__wf_atom_30e3d82b():__wf_atom_b783ff91(object2:GetPosition() + __wf_atom_9341614d(
				Vector(0, 0, 1.5),
				object2:__wf_atom_2f2bada0()
			))
		end
	else
		local position = currentSparrowDestination.entity:GetPosition()
		__wf_atom_2f2bada0 = __wf_atom_fa8d0177(object:GetPosition(), position)
		object:__wf_atom_98a0c9bd(v5, true)
		object:__wf_atom_98a0c9bd(v6, true)
	end

	object:__wf_atom_e6ed03c8()
	object:Teleport(__wf_atom_a2a18137, __wf_atom_2f2bada0)
	object:__wf_atom_921c1a5f(nil, false)
end

local function fn11(data) -- 1 equivalent call inferred from this helper
	return data.x * data.x + data.y * data.y + data.z * data.z
end

local function fn12(object, path)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(path) or #path == 0 then
		return nil
	end

	if #path == 1 then
		v15 = 1
		return 1
	end

	if not __wf_atom_7e8ad928(v15) and v15 >= #path then
		return #path
	end

	local __wf_atom_0e0a6fee = v7:__wf_atom_0e0a6fee(object:GetPosition())

	if __wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(v16) or not v16 then
		local v26 = __wf_atom_a93b9922(__wf_atom_0e0a6fee, path[1])
		local v27 = 1

		for i = 2, #path do
			local v28 = path[i - 1]
			local v29 = path[i]
			local v30

			if v28 ~= v29 then
				local v31 = __wf_atom_0e0a6fee - v28
				local v32 = v29 - v28
				local v33 = Dot(v31, v32) / fn11(v32) -- inferred equivalent call
				v30 = v28 + __wf_atom_421b01aa(v33, 0, 1) * (v29 - v28)
			end

			if __wf_atom_7e8ad928(v30) then
				continue
			end

			local v31 = __wf_atom_a93b9922(__wf_atom_0e0a6fee, v30)

			if not (v31 < v26) then
				continue
			end

			v27 = i
			v26 = v31
		end

		v15 = v27

		if v26 < 4 then
			v16 = true
		end
	elseif __wf_atom_a93b9922(__wf_atom_0e0a6fee, path[v15]) <= 1 then
		v15 += 1
	end

	return v15
end

function SparrowGuide(object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8a035cd5(Symbol("UpdateSparrowMeshScale"), false)
	end

	if not gRegion:IsMaster() then
		return
	end

	v9 = object
	v8 = object:__wf_atom_30e3d82b()
	v10 = object:__wf_atom_6f4c1c1b()

	while __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v10) do
		Sleep(0)
		v8 = object:__wf_atom_30e3d82b()
		v10 = object:__wf_atom_6f4c1c1b()
	end

	local __wf_atom_e919fb8e = v10:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.sparrowShoulderPerching = false
	__wf_atom_e919fb8e.sparrowFlyingToShoulder = false
	fn4(object)
	v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v7:Enable(true)

	if __wf_atom_e919fb8e.noSparrowBehavior then
		return
	end

	if __wf_atom_e919fb8e.sparrowImmediateShoulderPerch then
		SparrowShoulderPerchLoop(object)
	else
		SparrowGuideLoop(object)
	end
end

function SparrowGuideLoop(object)
	if __wf_atom_7e8ad928(object) or not gRegion:IsMaster() then
		return
	end

	v10 = object:__wf_atom_6f4c1c1b()

	if __wf_atom_7e8ad928(v10) then
		return
	end

	local position = nil
	local v26 = nil
	local v27 = nil
	local v28 = nil
	local path = nil
	local total = 0
	local v29 = false
	local none = module4.mSparrowDestinationType.None
	local v30 = true
	flag = false
	v12 = false
	object:__wf_atom_78ad8b9f(6, 0)
	object:__wf_atom_98a0c9bd(v6, true)
	v10:__wf_atom_5512b97b(true)

	if not __wf_atom_7e8ad928(v10) and v10:IsA(v18) then
		local __wf_atom_ef151cfd = v10:__wf_atom_a96eb2aa():__wf_atom_ef151cfd()

		if not (__wf_atom_7e8ad928(_T.PlayerShrinePosition) or __wf_atom_7e8ad928(_T.PlayerShrinePosition[__wf_atom_ef151cfd])) then
			position = v7:__wf_atom_0e0a6fee(_T.PlayerShrinePosition[__wf_atom_ef151cfd], 20, 10, true)
		end
	end

	local v31 = 20

	if _T.SparrowMode == "WaitAndHover" then
		local __wf_atom_28224c27 = v10:__wf_atom_d2b2176d():__wf_atom_28224c27(4)
		v31 = not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:IsA(v24) and 6 or v31
	end

	local __wf_atom_3d96ddcd = v10:__wf_atom_3d96ddcd()
	local v32

	if
		__wf_atom_7e8ad928(__wf_atom_3d96ddcd)
		or not __wf_atom_3d96ddcd:IsA(__wf_atom_47cae841)
		or __wf_atom_3d96ddcd:__wf_atom_4221009f() ~= v10
	then
		v32 = false
	else
		v8:__wf_atom_5a0e15fd(v2, 1)
		v32 = true
	end

	while
		(total < 7 or flag or _T.SparrowMode == "WaitAndHover" or _T.SparrowMode == "KeepActive")
		and not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v9) or v9:IsKilled() or __wf_atom_7e8ad928(v10) or v10:IsKilled())
	do
		v10 = v9:__wf_atom_6f4c1c1b()

		if __wf_atom_7e8ad928(v10) or flag and v9:__wf_atom_1c8f7b2d(v10) > 40 and _T.SparrowMode ~= "WaitAndHover" then
			break
		end

		if not v10:IsA(v18) then
			if _T.SparrowMode ~= "WaitAndHover" and __wf_atom_7e8ad928(v28) and _T.GetFlashMarker then
				v28 = _T.GetFlashMarker(v19, v10:__wf_atom_a96eb2aa())

				if not __wf_atom_7e8ad928(v28) then
					position = v7:__wf_atom_0e0a6fee(v28.pos, 20, 10, true)
					none = module4.mSparrowDestinationType.Waypoint
				end
			end

			if __wf_atom_7e8ad928(v28) then
				v26 = module2.GetCurrentSparrowDestination()

				if not __wf_atom_7e8ad928(v26) and __wf_atom_7e8ad928(v26.entity) then
					module2.UpdateSparrowDestination("SparrowGuide")
				end

				if not v29 and not __wf_atom_7e8ad928(v26) and v26.allowMultiple and total >= 0.5 then
					local currentSparrowMultiDestinations = module2.GetCurrentSparrowMultiDestinations()
					table.sort(currentSparrowMultiDestinations, function(a, b)
						return not (__wf_atom_7e8ad928(a.distance) or __wf_atom_7e8ad928(b.distance))
							and a.distance < b.distance
					end)

					if
						not __wf_atom_7e8ad928(currentSparrowMultiDestinations)
						and #currentSparrowMultiDestinations > 1
					then
						none = module4.mSparrowDestinationType.Multi

						for _, currentSparrowMultiDestination in ipairs(currentSparrowMultiDestinations) do
							if
								__wf_atom_7e8ad928(currentSparrowMultiDestination)
								or __wf_atom_7e8ad928(currentSparrowMultiDestination.entity)
								or currentSparrowMultiDestination.id == v26.id
							then
								continue
							end

							local v33 = __wf_atom_fa8d0177(
								v9:GetPosition(),
								currentSparrowMultiDestination.entity:GetPosition()
							)
							local __wf_atom_54cf3d0a = v7:__wf_atom_54cf3d0a(
								Type(sparrowMirageAgentType),
								v9:GetPosition(),
								v33
							)

							if __wf_atom_7e8ad928(__wf_atom_54cf3d0a) then
								continue
							end

							local __wf_atom_50a7d83e = __wf_atom_54cf3d0a:__wf_atom_50a7d83e()

							if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
								continue
							end

							__wf_atom_50a7d83e:__wf_atom_6a95c7b8(v10)
							__wf_atom_50a7d83e:__wf_atom_7b6d5fb3(
								Symbol("destinationId"),
								currentSparrowMultiDestination.id
							)
							module2.ApplySparrowCustomization(v10, __wf_atom_50a7d83e)
						end

						if not __wf_atom_7e8ad928(sparrowSplitVFX) then
							object:Attach(
								sparrowSplitVFX,
								EMPTY_SYMBOL,
								__wf_atom_28d5d4aa,
								__wf_atom_80368bb1,
								object,
								1
							)
						end

						if not __wf_atom_7e8ad928(sparrowSplitSFX) then
							object:PlaySound(sparrowSplitSFX, false)
						end
					end

					v29 = true
				end

				if v26 ~= v27 then
					v17 = nil

					if __wf_atom_7e8ad928(v26) or __wf_atom_7e8ad928(v26.entity) then
						path = nil
					else
						none = module4.mSparrowDestinationType.Single

						if v26.entity:IsA(__wf_atom_9e85eea2) then
							position = v7:__wf_atom_6acb01b3(v26.entity, 2, 5, true)
						else
							position = v7:__wf_atom_0e0a6fee(v26.entity:GetPosition(), 20, 10, true)
						end

						if __wf_atom_7e8ad928(v26.path) then
							path = module2.GenerateLocalRoadPath(position, v10)
						else
							path = v26.path
						end
					end

					v27 = v26
				end

				if
					not __wf_atom_7e8ad928(v26)
					and not __wf_atom_7e8ad928(v26.entity)
					and not __wf_atom_7e8ad928(path)
					and #path > 0
				then
					if _T.SparrowMode == "WaitAndHover" and not __wf_atom_7e8ad928(v17) then
						for i = #path, 1, -1 do
							if not (i > 1 and v17 == path[i - 1] and v10:__wf_atom_a5304c35(path[i - 1]) < v31) then
								continue
							end

							position = path[i]
							break
						end
					else
						local v33 = fn12(v9, path)

						if not (__wf_atom_7e8ad928(v33) or __wf_atom_7e8ad928(path[v33])) then
							position = path[v33]
						end
					end
				end

				if
					not flag
					and __wf_atom_7e8ad928(v26)
					and (v17 == nil or v17 ~= position)
					and not __wf_atom_7e8ad928(v9)
				then
					local taggedInTileType = module.FindTaggedInTileType(
						Symbol("StreamingDungeonExitWp"),
						Symbol("Exit")
					)

					if not __wf_atom_7e8ad928(taggedInTileType) and #taggedInTileType > 0 then
						none = module4.mSparrowDestinationType.Exit
						local v33 = nil
						local v34 = 99999999

						for i = 1, #taggedInTileType do
							if v33 == nil then
								v33 = taggedInTileType[i]
							else
								local __wf_atom_c215662d = taggedInTileType[i]:__wf_atom_c215662d(v9:GetPosition())

								if __wf_atom_c215662d < v34 then
									v33 = taggedInTileType[i]
									v34 = __wf_atom_c215662d
								end
							end
						end

						if v33 ~= nil then
							position = v33:GetPosition()
						end
					end
				end
			end
		end

		local v33

		if v17 == position then
			v33 = false
		else
			if __wf_atom_7e8ad928(position) then
				v8:ClearAgentBlackboardEntry(v)
				v8:__wf_atom_24ddbdc3()
			else
				if flag then
					fn3()
					total = 0
				else
					v8:ClearAgentBlackboardEntry(v)
				end

				v8:__wf_atom_b783ff91(position)
				v9:__wf_atom_e06358f3(Symbol("IDLE"))
				local _sparrowDebugDraw = _T.SparrowDebugDraw
			end

			v17 = position
			fn(position)
			v33 = true
		end

		local v34 = 1.5

		if __wf_atom_7e8ad928(v17) then
			if total > 2 then
				break
			end
		else
			v34 = 3
		end

		if v25 > 0 then
			v25 -= 0.25
		else
			v9:__wf_atom_18619c34(v34)
		end

		if v30 and total >= 0.5 then
			if not __wf_atom_7e8ad928(v26) then
				if v26.priority == module2.PRIORITY.EXIT then
					none = module4.mSparrowDestinationType.Exit
				elseif v26.priority == module2.PRIORITY.QUEST then
					none = module4.mSparrowDestinationType.Quest
				elseif v26.priority == module2.PRIORITY.TALE then
					none = module4.mSparrowDestinationType.Tale
				end
			end

			module4.LogUseSparrowGuide(none, v26, v17)
			v30 = false
		end

		if (flag or v12) and (__wf_atom_7e8ad928(v11) or v33 or not v11:IsEnabled()) then
			fn3()
			total = 0
		elseif not __wf_atom_7e8ad928(v17) then
			local __wf_atom_a5304c35 = v9:__wf_atom_a5304c35(v17)

			if flag or v12 or not (__wf_atom_a5304c35 <= 3) then
				if
					not flag
					and not v12
					and not __wf_atom_7e8ad928(v26)
					and v26.range.minValue > 0
					and __wf_atom_a5304c35 < v26.range.minValue
				then
					v8:__wf_atom_24ddbdc3()
					v9:__wf_atom_e06358f3(Symbol("SearchHover"))
				end
			else
				fn2()
			end
		end

		if v32 and v9:__wf_atom_1c8f7b2d(v10) > 4 then
			v8:ClearAgentBlackboardEntry(v2)
			local _sparrowDebugDraw = _T.SparrowDebugDraw
			v32 = false
		end

		total += 0.25
		Sleep(0.25)
	end

	if not __wf_atom_7e8ad928(v9) and not __wf_atom_7e8ad928(v10) and module2.CanShoulderPerch(v10) then
		SparrowShoulderPerchLoop(v9)
		return
	end

	if not __wf_atom_7e8ad928(v10) then
		local __wf_atom_e919fb8e = v10:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.sparrowImmediateShoulderPerch = false
		v10:__wf_atom_be7f08c9(false)
		v10:__wf_atom_5512b97b(false)
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Destroy()
	end
end

function SparrowMirageGuide(instance)
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

	while __wf_atom_7e8ad928(__wf_atom_30e3d82b) do
		__wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()
		Sleep(0)
	end

	local __wf_atom_6f4c1c1b = instance:__wf_atom_6f4c1c1b()

	if not __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) and __wf_atom_6f4c1c1b:IsA(v18) then
		instance:Destroy()
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	fn4(instance)
	local __wf_atom_50753bed = instance:__wf_atom_50753bed(Symbol("destinationId"))
	local total = 0
	local v26 = nil

	while __wf_atom_7e8ad928(__wf_atom_50753bed) and not (total >= 10) do
		__wf_atom_50753bed = instance:__wf_atom_50753bed(Symbol("destinationId"))
		total += 0.1
		Sleep(0.1)
	end

	local sparrowDestination = module2.GetSparrowDestinationById(__wf_atom_50753bed)
	local path

	if not (__wf_atom_7e8ad928(sparrowDestination) or __wf_atom_7e8ad928(sparrowDestination.entity)) then
		if sparrowDestination.entity:IsA(__wf_atom_9e85eea2) then
			v26 = __wf_atom_7d789620:__wf_atom_6acb01b3(sparrowDestination.entity, 2, 5, true)
		else
			v26 = __wf_atom_7d789620:__wf_atom_0e0a6fee(sparrowDestination.entity:GetPosition(), 20, 10, true)
		end

		if __wf_atom_7e8ad928(sparrowDestination.path) then
			path = module2.GenerateLocalRoadPath(v26, __wf_atom_6f4c1c1b)
		else
			path = sparrowDestination.path
		end
	end

	while
		total < 7
		and not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_7e8ad928(instance) or instance:IsKilled())
	do
		local __wf_atom_6f4c1c1b2 = instance:__wf_atom_6f4c1c1b()

		if
			__wf_atom_7e8ad928(__wf_atom_6f4c1c1b2)
			or __wf_atom_6f4c1c1b2:IsKilled()
			or __wf_atom_6f4c1c1b2:IsA(v18)
		then
			break
		end

		if
			not __wf_atom_7e8ad928(sparrowDestination)
			and not __wf_atom_7e8ad928(sparrowDestination.entity)
			and not __wf_atom_7e8ad928(path)
			and #path > 0
		then
			local v27 = fn12(instance, path)

			if not (__wf_atom_7e8ad928(v27) or __wf_atom_7e8ad928(path[v27])) then
				v26 = path[v27]
			end
		end

		if v17 ~= v26 then
			if __wf_atom_7e8ad928(v26) then
				__wf_atom_30e3d82b:__wf_atom_24ddbdc3()
			else
				__wf_atom_30e3d82b:__wf_atom_b783ff91(v26)
				local _sparrowDebugDraw = _T.SparrowDebugDraw
			end

			v17 = v26
		end

		total += 0.1
		Sleep(0.1)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function SparrowShoulderPerchLoop(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6f4c1c1b = object:__wf_atom_6f4c1c1b()

	if __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) or not module2.CanShoulderPerch(__wf_atom_6f4c1c1b) then
		return
	end

	if flag or v12 then
		fn3()
	end

	local __wf_atom_e919fb8e = __wf_atom_6f4c1c1b:__wf_atom_e919fb8e()
	__wf_atom_6f4c1c1b:__wf_atom_5512b97b(false)
	object:__wf_atom_78ad8b9f(6, 1)
	object:__wf_atom_18619c34(1.25)
	local sparrowImmediateShoulderPerch = __wf_atom_e919fb8e.sparrowImmediateShoulderPerch
	__wf_atom_e919fb8e.sparrowImmediateShoulderPerch = false
	fn9(object, __wf_atom_6f4c1c1b, sparrowImmediateShoulderPerch)

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		return
	end

	local flag3 = false
	local v26

	if __wf_atom_7e8ad928(__wf_atom_6f4c1c1b:__wf_atom_278a2d05()) then
		v26 = 0
	else
		v26 = Length(__wf_atom_6f4c1c1b:__wf_atom_278a2d05())
	end

	while
		__wf_atom_e919fb8e.sparrowShoulderPerching
		and not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(__wf_atom_6f4c1c1b)
		and module2.CanShoulderPerch(__wf_atom_6f4c1c1b)
	do
		local shoulderOffset = module2.GetShoulderOffset(__wf_atom_6f4c1c1b)
		local v27 = fn8(__wf_atom_6f4c1c1b:__wf_atom_3d840c93(173), 15) -- inferred equivalent call
		local v28 = Rotation(v27, 0, 0)
		local v29 = __wf_atom_0a00e162(__wf_atom_6f4c1c1b:__wf_atom_8e4cf043(Symbol("GAME_R1_ARM1")))
		object:__wf_atom_e310f01f(shoulderOffset, __wf_atom_d919c2d7(v29, v28))
		local v30 = __wf_atom_7e8ad928(__wf_atom_6f4c1c1b:__wf_atom_278a2d05()) and 0
			or Length(__wf_atom_6f4c1c1b:__wf_atom_278a2d05())

		if not flag2 then
			if flag3 then
				if v26 < 1 then
					object:__wf_atom_921c1a5f(armPerchLoopAnim, false, 3, 2, true)
				elseif v26 < 3 then
					object:__wf_atom_921c1a5f(armPerchWalkLoopAnim, false, 3, 2, true)
				else
					object:__wf_atom_921c1a5f(armPerchJogLoopAnim, false, 3, 2, true)
				end
			end

			flag3 = false

			if v30 >= 1 and v26 < 1 then
				object:__wf_atom_921c1a5f(nil, false)
				flag3 = true
			elseif v30 >= 3 and v26 < 3 then
				object:__wf_atom_921c1a5f(nil, false)
				shoulderOffset += Vector(-0.005, 0, 0)
				flag3 = true
			elseif v30 < 3 and v26 >= 3 then
				object:__wf_atom_921c1a5f(nil, false)
				shoulderOffset += Vector(-0.005, 0, 0)
				flag3 = true
			elseif v30 < 1 and v26 >= 1 then
				object:__wf_atom_921c1a5f(nil, false)
				flag3 = true
			end
		end

		fn6(v30, object)
		Sleep(0)
		v26 = v30
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_6f4c1c1b) then
		return
	end

	fn10(object, __wf_atom_6f4c1c1b)

	if v10:__wf_atom_8a7e7fd5() then
		object:__wf_atom_8a035cd5(Symbol("SparrowGuideLoop"), false)
	else
		fn7(object, __wf_atom_6f4c1c1b)
	end
end

function TestSkyClear()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("OvercastPostVolume"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:Disable()
	end

	local v26 = Symbol("DefaultMainSky")
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for i = 1, #all do
		local v27 = all[i]

		if v27:__wf_atom_db682341() == v26 then
			v27:__wf_atom_e2779837(true)
			v27:Enable(true)
			v27:SetTimeOfDay(19)
			v27:__wf_atom_2ee34f0b(Vector(-0.5, 0.2, -0.5))
			v27:__wf_atom_d0e0a161(true)
		else
			v27:Enable(false)
		end
	end
end

function SpawnSparrow(object, _)
	if __wf_atom_7e8ad928(object) then
		return
	end

	while not gRegion:__wf_atom_2202ffb6():ReadyToCreateAgents() do
		Sleep(0.1)
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e) then
		return
	end

	local sparrowForPlayer = module2.GetSparrowForPlayer(object)

	if not __wf_atom_7e8ad928(sparrowForPlayer) then
		local __wf_atom_30e3d82b = sparrowForPlayer:__wf_atom_30e3d82b()

		if
			not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_30e3d82b:__wf_atom_88d6f7ef() < 3
			and not (__wf_atom_e919fb8e.sparrowFlyingToShoulder or __wf_atom_e919fb8e.sparrowShoulderPerching)
		then
			return
		end
	end

	local __wf_atom_28224c27 = object:__wf_atom_d2b2176d():__wf_atom_28224c27(4)
	local v26 = not __wf_atom_7e8ad928(__wf_atom_28224c27) and __wf_atom_28224c27:IsA(v24) and true or false
	local sparrowSpawnAnim = sparrowSpawnAnim

	if object:__wf_atom_b2f8ef81() then
		local __wf_atom_e14d8a8c = object:__wf_atom_3d96ddcd():__wf_atom_e14d8a8c()

		if __wf_atom_e14d8a8c == wolfAvatarType then
			sparrowSpawnAnim = sparrowWolfSpawnAnim
		end

		if __wf_atom_e14d8a8c == horseAvatarType then
			sparrowSpawnAnim = sparrowHorseSpawnAnim
		end
	end

	object:Attach(castFxType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not (__wf_atom_7e8ad928(sparrowSpawnAnim) or v26) then
		local __wf_atom_33b8b73f = object:__wf_atom_33b8b73f(sparrowSpawnAnim, false, 2, 1, true, true)

		if animEvent:__wf_atom_8598f3a9() then
			__wf_atom_33b8b73f = sparrowSpawnAnim:__wf_atom_091354f5(animEvent) * __wf_atom_33b8b73f
		end

		if __wf_atom_33b8b73f > 0 then
			local __wf_atom_35a10d3c = object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0)
			SF.__wf_atom_4659f336(__wf_atom_35a10d3c, false, false)
			local envoyInventoryControl = module3.GetEnvoyInventoryControl()

			if not __wf_atom_7e8ad928(envoyInventoryControl) then
				envoyInventoryControl:__wf_atom_58112034(__wf_atom_35a10d3c, false, false)
			end

			while
				not __wf_atom_7e8ad928(object)
				and (__wf_atom_33b8b73f > 0 and object:__wf_atom_c138b19b(sparrowSpawnAnim) or object:__wf_atom_3c281634(sparrowSpawnAnim))
			do
				Sleep(0)
				__wf_atom_33b8b73f -= __wf_atom_084b3e93()
			end

			SF.__wf_atom_4659f336(__wf_atom_35a10d3c, true, false)
			local envoyInventoryControl2 = module3.GetEnvoyInventoryControl()

			if not __wf_atom_7e8ad928(envoyInventoryControl2) then
				envoyInventoryControl2:__wf_atom_58112034(__wf_atom_35a10d3c, true, false)
			end
		end
	end

	__wf_atom_e919fb8e.sparrowImmediateShoulderPerch = false
	v15 = nil
	v16 = nil

	if __wf_atom_e919fb8e.sparrowShoulderPerching and not __wf_atom_7e8ad928(sparrowForPlayer) then
		__wf_atom_e919fb8e.sparrowShoulderPerching = false
		object:__wf_atom_be7f08c9(true)
		object:__wf_atom_5512b97b(true)
	else
		if not __wf_atom_7e8ad928(sparrowForPlayer) then
			sparrowForPlayer:Destroy()
		end

		v8, v9 = module2.SpawnSparrow(object, sparrowAgentType)

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_be7f08c9(not __wf_atom_7e8ad928(v9))

			if __wf_atom_7e8ad928(v9) then
				object:__wf_atom_5512b97b(false)
			end
		end
	end
end

function SparrowInNightfoldSetup(p, p2)
	while not __wf_atom_7e8ad928(p) do
		if _T.SpawnNightfoldSparrow then
			Sleep(0.5)
			module2.SpawnSparrow(p2, sparrowAgentType)
			_T.SpawnNightfoldSparrow = nil
		end

		Sleep(0)
	end
end

function WaitAndDestroyBeachSparrow(object)
	while module.IsStreamingLevel() do
		Sleep(0)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("BeachCinematic"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		while not (__wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_7d4910e4()) do
			if _G.LoginSequencePlayed then
				gRegion:__wf_atom_dd1e4d10(object)
				return
			else
				Sleep(0)
			end
		end

		while not __wf_atom_7e8ad928(__wf_atom_0a6a5887) and __wf_atom_0a6a5887:__wf_atom_7d4910e4() do
			Sleep(0)
		end
	end

	object:__wf_atom_f4133158()
	Sleep(0)
	object:__wf_atom_921c1a5f(v20, false, true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local v26 = nil

	while
		__wf_atom_7e8ad928(v26)
		and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(object) < 15
	do
		if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		end

		v26 = gRegion:__wf_atom_0a6a5887(Symbol("SparrowGuide"))
		Sleep(0)
	end

	gRegion:CreateEntity(v21, object:GetPosition(), object:__wf_atom_dc309f8a())
	gRegion:__wf_atom_dd1e4d10(object)
end

function SparrowNagTrigger(object, object2)
	if __wf_atom_7e8ad928(object2) or not object2:__wf_atom_8efce136() then
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local position

	if not __wf_atom_7e8ad928(destinationEntity) then
		position = destinationEntity:GetPosition()
	end

	while
		not __wf_atom_7e8ad928(object)
		and not __wf_atom_7e8ad928(object2)
		and not object2:IsKilled()
		and not module.IsInNightFold(object2)
		and module.IsInOverworld()
	do
		local position2 = object2:GetPosition()

		if object:__wf_atom_1eaf335c(position2) then
			Sleep(1)
		elseif __wf_atom_7e8ad928((module2.GetSparrowForPlayer(object2))) then
			if __wf_atom_7e8ad928(destinationEntity) then
				local currentSparrowDestination = module2.GetCurrentSparrowDestination()

				if
					__wf_atom_7e8ad928(currentSparrowDestination)
					or __wf_atom_7e8ad928(currentSparrowDestination.entity)
				then
					Sleep(1)
					continue
				else
					position = currentSparrowDestination.entity:GetPosition()
				end
			end

			local v26 = __wf_atom_fa8d0177(position2, position)
			local v27 = __wf_atom_9341614d(object2:__wf_atom_a06d543c(), v26)
			local v28 = __wf_atom_fa8d0177(position, position2)
			local v29 = position2 + __wf_atom_9341614d(Vector(0, 0, 7), v28)
			v29.y = object2:EyePosition().y
			local v30 = v29 + object2:__wf_atom_a06d543c() * 2
			local v31 = position2 + Vector(0, 1.25, 0)
			local v32 = __wf_atom_fa8d0177(v30, v31)
			local __wf_atom_54cf3d0a = __wf_atom_7d789620:__wf_atom_54cf3d0a(sparrowAgentType, v30, v32)

			if __wf_atom_7e8ad928(__wf_atom_54cf3d0a) then
				Sleep(5)
			else
				local __wf_atom_50a7d83e = __wf_atom_54cf3d0a:__wf_atom_50a7d83e()
				__wf_atom_54cf3d0a:__wf_atom_5a0e15fd(v, 1)
				__wf_atom_50a7d83e:__wf_atom_6a95c7b8(object2)
				__wf_atom_50a7d83e:__wf_atom_921c1a5f(idleHoverAnim, false, 3, 2, false)
				Sleep(0.2)

				if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_50a7d83e)) then
					__wf_atom_50a7d83e:__wf_atom_e4df34a5(false)
					__wf_atom_50a7d83e:__wf_atom_3c986cd9(v31, v32, false)
					__wf_atom_50a7d83e:__wf_atom_921c1a5f(takeOffAnim, false, 3, 1, false)

					while
						not __wf_atom_7e8ad928(__wf_atom_50a7d83e)
						and __wf_atom_50a7d83e:__wf_atom_a5304c35(v31) > 0.5
					do
						object2:GetPosition()
						v31 = object2:GetPosition() + Vector(0, 1.25, 0)
						__wf_atom_50a7d83e:__wf_atom_3c986cd9(
							v31,
							__wf_atom_fa8d0177(__wf_atom_50a7d83e:GetPosition(), v31),
							false
						)
						Sleep(0)
					end

					Sleep(0.1)

					if not (__wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(__wf_atom_50a7d83e)) then
						local damageData = Engine.DamageData()
						damageData.baseAmount = 0
						damageData:__wf_atom_7498285f(0, 1)
						damageData:__wf_atom_d6f4d914(16, true)
						damageData:__wf_atom_34a8a27a(__wf_atom_50a7d83e)
						damageData:__wf_atom_12cf5317(v27 * 100)
						local position3 = object2:GetPosition()
						object2:__wf_atom_649bf33e(damageData)
						local __wf_atom_dc309f8a = object2:__wf_atom_dc309f8a()
						local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()
						local total = 0

						while total <= 1 and not __wf_atom_7e8ad928(object2) do
							total += __wf_atom_084b3e93()
							local v33 = __wf_atom_24a82b69(total) / 1
							object2:__wf_atom_f0f9fb38(__wf_atom_9d2f097a(__wf_atom_4e50d390, v26, v33))
							object2:Teleport(position3, __wf_atom_9d2f097a(__wf_atom_dc309f8a, v26, v33))
							Sleep(0)
						end

						if not (__wf_atom_7e8ad928(__wf_atom_54cf3d0a) or __wf_atom_7e8ad928(__wf_atom_50a7d83e)) then
							__wf_atom_50a7d83e:__wf_atom_e4df34a5(true)
							__wf_atom_54cf3d0a:ClearAgentBlackboardEntry(v)
						end

						Sleep(3)

						if not (__wf_atom_7e8ad928(object2) or object2:__wf_atom_a586ea4c(WeakResource(sparrowTutorialTrigger))) then
							object2:Attach(sparrowTutorialTrigger, EMPTY_SYMBOL)
						end

						Sleep(10)
						Sleep(1)
					end
				end
			end
		else
			Sleep(1)
		end
	end
end

function UpdateSparrowMeshScale(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.ignoreInitialSparrowScale == nil or __wf_atom_e919fb8e.ignoreInitialSparrowScale == false then
		object:SetMeshScale(1.25)
		Sleep(0)

		if
			__wf_atom_e919fb8e.ignoreInitialSparrowScale == nil
			or __wf_atom_e919fb8e.ignoreInitialSparrowScale == false
		then
			object:SetMeshScale(1.25)
		end
	end

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_ebd8e688 = object:__wf_atom_ebd8e688()

		if __wf_atom_ebd8e688 < object:__wf_atom_c082fc3d() then
			if object:__wf_atom_c082fc3d() - __wf_atom_ebd8e688 < 2 * __wf_atom_084b3e93() then
				object:SetMeshScale(__wf_atom_ebd8e688)
			else
				object:SetMeshScale((math.max(
					object:__wf_atom_c082fc3d() - 2 * __wf_atom_084b3e93(),
					__wf_atom_ebd8e688
				)))
			end
		elseif object:__wf_atom_c082fc3d() < __wf_atom_ebd8e688 then
			if __wf_atom_ebd8e688 - object:__wf_atom_c082fc3d() < 2 * __wf_atom_084b3e93() then
				object:SetMeshScale(__wf_atom_ebd8e688)
			else
				object:SetMeshScale((math.min(
					object:__wf_atom_c082fc3d() + 2 * __wf_atom_084b3e93(),
					__wf_atom_ebd8e688
				)))
			end
		end

		Sleep(0)
	end
end

function DestroyGuideFxAfter(instance)
	while
		not __wf_atom_7e8ad928(instance:__wf_atom_f7e7be53())
		and (Type(instance:__wf_atom_f7e7be53()) == v22 or Type(instance:__wf_atom_f7e7be53()) == v23)
	do
		Sleep(1)
	end

	Sleep(10)
	instance:Destroy()
end