require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.EncounterLib")
local v = nil
local v2 = Vector(0, 0, 1)
local v3 = Rotation(0, 0, 0)
local v4 = nil
local v5 = {}
local gameCamera = nil
local v6 = nil
local v7 = Symbol("ButtSlam")

local function fn(object, creator)
	if object ~= gRegion:__wf_atom_c4f78a8f() then
		return
	end

	local __wf_atom_68de036a = creator:__wf_atom_68de036a()
	local damageData = Engine.DamageData()
	damageData:__wf_atom_6b472125(creator)
	damageData:__wf_atom_34a8a27a(creator)
	damageData:__wf_atom_6d7ec072(Engine.UpgradedValue(damageAmount + damageRankMod * __wf_atom_68de036a))
	damageData.stabilityDamage = stabilityDamage + stabilityDamageRankMod * __wf_atom_68de036a
	damageData:__wf_atom_7498285f(damageType, 1)
	damageData:__wf_atom_d6f4d914(damageProc, true)
	damageData.baseProcChance = procChance
	object:__wf_atom_649bf33e(damageData)
end

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if __wf_atom_7e8ad928(__wf_atom_9a1e4ed3) then
		return 0
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v7)

	if
		not __wf_atom_7e8ad928(__wf_atom_0a6a5887)
		and object2:__wf_atom_8a6b8fc3(__wf_atom_0a6a5887) > allowedDistanceFromLeashTag
	then
		return 0
	end

	local avatar = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3().avatar

	if __wf_atom_9a1e4ed3.visible and __wf_atom_9a1e4ed3:__wf_atom_a3309443() then
		local distanceToTarget = __wf_atom_9a1e4ed3.distanceToTarget

		if
			distanceToTarget >= 0
			and distanceToTarget <= triggerDistance
			and avatar:__wf_atom_a2a18137().y - object2:__wf_atom_a2a18137().y <= 2.5
		then
			object:__wf_atom_f7170fc9(avatar)
			return 1
		end
	end

	return 0
end

function CameraFoVIn(object)
	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(cameraControl) do
		cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(1, FoVAmount, __wf_atom_24a82b69(total))))
		total += __wf_atom_084b3e93() * 3
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_25382a0d(FoVAmount)
	end
end

function CameraFoVOut(object)
	local cameraControl = object:CameraControl()

	if __wf_atom_7e8ad928(cameraControl) then
		return
	end

	local total = 0

	while total <= 1 and not __wf_atom_7e8ad928(cameraControl) do
		cameraControl:__wf_atom_25382a0d((__wf_atom_104bfe98(FoVAmount, 1, __wf_atom_24a82b69(total))))
		total += __wf_atom_084b3e93() * 3
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(cameraControl) then
		cameraControl:__wf_atom_25382a0d(1)
	end
end

local function fn2(avatar)
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	local motionControl = avatar:MotionControl()

	if not __wf_atom_7e8ad928(motionControl) then
		motionControl:__wf_atom_99fc7a82(false)
	end

	avatar:__wf_atom_a142b1ea(true)

	if avatar:__wf_atom_a586ea4c(avatarAttachFx) then
		local __wf_atom_bb3e7833 = avatar:__wf_atom_bb3e7833(avatarAttachFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	if gameCamera:__wf_atom_a586ea4c(screenFx) then
		local __wf_atom_bb3e7833 = gameCamera:__wf_atom_bb3e7833(screenFx)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end

	CameraFoVOut(avatar)

	if __wf_atom_7e8ad928(_T.BromiusSmogAffected) then
		_T.BromiusSmogAffected = {}
	end

	if not __wf_atom_7e8ad928(_T.BromiusSmogAffected[avatar:__wf_atom_18aa6e58()]) then
		_T.BromiusSmogAffected[avatar:__wf_atom_18aa6e58()] = false
	end

	v4 = nil
end

local function fn3(avatar)
	if __wf_atom_7e8ad928(avatar) then
		return
	end

	if
		not __wf_atom_7e8ad928(_T.BromiusSmogAffected)
		and not __wf_atom_7e8ad928(_T.BromiusSmogAffected[avatar:__wf_atom_18aa6e58()])
		and _T.BromiusSmogAffected[avatar:__wf_atom_18aa6e58()]
	then
		return
	end

	local motionControl = avatar:MotionControl()

	if not __wf_atom_7e8ad928(motionControl) then
		motionControl:__wf_atom_99fc7a82(true)
	end

	avatar:__wf_atom_a142b1ea(false)

	if not avatar:__wf_atom_a586ea4c(avatarAttachFx) then
		avatar:Attach(avatarAttachFx, Symbol("GAME_C1_SPINE5"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end

	if not gameCamera:__wf_atom_a586ea4c(screenFx) then
		gameCamera:Attach(screenFx, EMPTY_SYMBOL, v2, v3)
		CameraFoVIn(avatar)
	end

	if __wf_atom_7e8ad928(_T.BromiusSmogAffected) then
		_T.BromiusSmogAffected = {}
	end

	_T.BromiusSmogAffected[avatar:__wf_atom_18aa6e58()] = true
end

function AttackAndTrace(instance)
	instance:SetVisibility(true)
	local __wf_atom_921c1a5f = instance:__wf_atom_921c1a5f(handAttackAnim, false, false, 0, EMPTY_SYMBOL)
	local v8 = handAttackAnim:__wf_atom_091354f5(Symbol(swipeEventSymbol)) * __wf_atom_921c1a5f
	local v9 = __wf_atom_921c1a5f - handAttackAnim:__wf_atom_091354f5(Symbol(swipeEndEventSymbol)) * __wf_atom_921c1a5f
	Sleep(v8)
	local v10 = {}
	local total = 0

	for i = 1, #weaponBones do
		table.insert(v10, instance:__wf_atom_1c374cc9(weaponBones[i]))
	end

	local v11 = __wf_atom_921c1a5f - v8 - v9
	local v12 = false

	while not v12 and total < v11 do
		for i = 1, #weaponBones do
			local __wf_atom_1c374cc9 = instance:__wf_atom_1c374cc9(weaponBones[i], true)

			if showDebug then
				gRegion:__wf_atom_8d991675(__wf_atom_1c374cc9, meleeRange, debugColour, 1)
			end

			local __wf_atom_4ea726bc = gRegion:__wf_atom_4ea726bc(
				v10[i],
				__wf_atom_1c374cc9,
				meleeRange,
				acceptedTargetsTypes,
				nil
			)

			for _, v13 in pairs(__wf_atom_4ea726bc) do
				local __wf_atom_18aa6e58 = v13:__wf_atom_18aa6e58()

				if
					__wf_atom_7e8ad928(_T.BromiusSmogAffected)
					or __wf_atom_7e8ad928(_T.BromiusSmogAffected[__wf_atom_18aa6e58])
					or not _T.BromiusSmogAffected[__wf_atom_18aa6e58]
				then
					continue
				end

				fn(v13, instance:GetCreator())
				v12 = true
			end

			v10[i] = __wf_atom_1c374cc9
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if total < __wf_atom_921c1a5f then
		Sleep(__wf_atom_921c1a5f - total)
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function ClientHostSpawnHand(object, _, p, object2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_18aa6e58 = gRegion:GetPlayerAvatar():__wf_atom_18aa6e58()

	if
		__wf_atom_7e8ad928(_T.BromiusSmogAffected)
		or __wf_atom_7e8ad928(_T.BromiusSmogAffected[__wf_atom_18aa6e58])
		or not _T.BromiusSmogAffected[__wf_atom_18aa6e58]
	then
		return
	end

	if showDebug then
		gRegion:__wf_atom_b5c21154(p, 1, debugColour, Rotation(0, 90, 0), DebugHandSpawnPosCircleLifeTime)
		gRegion:__wf_atom_5b35a0c8(
			p,
			Color(0, 255, 0),
			"Spanwed for: " .. object2:GetName(),
			2,
			DebugHandSpawnPosCircleLifeTime
		)
	end

	local v8 = __wf_atom_fa8d0177(p, object2:GetPosition())
	v8.bank = 0

	if not __wf_atom_7e8ad928(handEmergingFX) then
		gRegion:CreateEntity(handEmergingFX, p, v8, __wf_atom_6009c8ed, __wf_atom_6009c8ed, 3):SetMeshScale(handEmergingFXScale)
		Sleep(handSpawnDelay)
	end

	if not __wf_atom_7e8ad928(handEmergeFX) then
		gRegion:CreateEntity(handEmergeFX, p, v8, __wf_atom_6009c8ed, __wf_atom_6009c8ed, 3):SetMeshScale(handEmergeFXScale)
	end

	v8.pitch = spawnHandRotationPitchAdjust
	local entity = gRegion:CreateEntity(
		handSpawnFX,
		p + Vector(0, 0.05, 0),
		v8 + Rotation(-10, 0, 0),
		__wf_atom_6009c8ed,
		__wf_atom_6009c8ed,
		3
	)
	entity:SetVisibility(false)
	hideBody(entity)
	Sleep(0.05)
	entity:__wf_atom_8a035cd5(Symbol("AttackAndTrace"), false)
end

function SpawnHand(object, object2)
	if handSpawnChance > Random(0, 1) then
		local v8 = math.rad((__wf_atom_5784a397(-handSpawnMaxAngle, handSpawnMaxAngle)))
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		local position = object:GetPosition()
		local v9 = Rotation(__wf_atom_4e50d390.heading, 0, 0)
		local v10 = __wf_atom_9341614d(
			Vector(handSpawnDistance * math.sin(v8), 0, handSpawnDistance * math.cos(v8)),
			v9
		) + position

		if not __wf_atom_7e8ad928(v6) then
			v10 = v6:__wf_atom_0e0a6fee(v10) + spawnHandNavPosOffset
		end

		local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
		secondaryScriptArgs:__wf_atom_37d0a93a(v10)
		secondaryScriptArgs:__wf_atom_a17e41c6(object)

		if not __wf_atom_7e8ad928(object2) then
			object2:ActivateSecondaryScript(
				mOwner:__wf_atom_e14d8a8c(),
				Symbol("ClientHostSpawnHand"),
				secondaryScriptArgs
			)
		end
	elseif showDebug then
		local v8 = math.rad((__wf_atom_5784a397(-handSpawnMaxAngle, handSpawnMaxAngle)))
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		local position = object:GetPosition()
		local v9 = Rotation(__wf_atom_4e50d390.heading, 0, 0)
		local v10 = __wf_atom_9341614d(
			Vector(handSpawnDistance * math.sin(v8), 0, handSpawnDistance * math.cos(v8)),
			v9
		) + position

		if not __wf_atom_7e8ad928(v6) then
			v10 = v6:__wf_atom_0e0a6fee(v10) + spawnHandNavPosOffset
		end

		gRegion:__wf_atom_b5c21154(v10, 1, debugColour, Rotation(0, 90, 0), DebugHandSpawnPosCircleLifeTime)
		gRegion:__wf_atom_5b35a0c8(
			v10,
			Color(0, 255, 0),
			"Unluck no spawn for: " .. object:GetName(),
			2,
			DebugHandSpawnPosCircleLifeTime
		)
	end
end

local function fn4(_, __wf_atom_e55d02aa)
	if gRegion:IsMaster() then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v8 in ipairs(__wf_atom_ef7900cf) do
			if __wf_atom_7e8ad928(v8) then
				continue
			end

			local __wf_atom_18aa6e58 = v8:__wf_atom_18aa6e58()
			local __wf_atom_846af4f8 = v8:__wf_atom_7470861b():__wf_atom_846af4f8(6)

			if __wf_atom_7e8ad928(v5[__wf_atom_18aa6e58]) then
				continue
			end

			if v5[__wf_atom_18aa6e58].buffTime > 0 then
				if __wf_atom_846af4f8 > 0 then
					if smogHandSpawnStackThreshold <= __wf_atom_846af4f8 then
						if v5[__wf_atom_18aa6e58].handSpawnTime <= 0 then
							if not __wf_atom_7e8ad928(v5[__wf_atom_18aa6e58].avatar) then
								SpawnHand(v5[__wf_atom_18aa6e58].avatar, __wf_atom_e55d02aa)
							end

							v5[__wf_atom_18aa6e58].handSpawnTime = handSpawnInterval
						end

						v5[__wf_atom_18aa6e58].handSpawnTime -= __wf_atom_084b3e93()
					end

					v5[__wf_atom_18aa6e58].buffTime -= __wf_atom_084b3e93()
				end
			else
				v5[__wf_atom_18aa6e58] = nil
			end
		end
	end

	if not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v4.avatar) or __wf_atom_7e8ad928(v4.buffTime)) then
		local avatar = v4.avatar
		local __wf_atom_846af4f8 = v4.avatar:__wf_atom_7470861b():__wf_atom_846af4f8(6)

		if v4.buffTime > 0 then
			fn3(avatar)

			if showDebug then
				gRegion:__wf_atom_5b35a0c8(
					avatar:GetPosition() + Vector(0, 2, 0),
					Color(0, 255, 0),
					v4.buffTime .. "  Poision Count: " .. __wf_atom_846af4f8,
					5,
					0
				)
			end

			v4.buffTime -= __wf_atom_084b3e93()
		else
			fn2(avatar)
		end
	end
end

local function fn5(p) -- 1 equivalent call inferred from this helper
	return 1 - math.pow(1 - p, smogEaseFunctionFactor)
end

function SpawnSmog(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local playerAvatar = gRegion:GetPlayerAvatar()
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	gameCamera = gRegion:GetGameCamera()

	if gRegion:IsMaster() then
		v6 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local v8 = object:GetPosition() + spawnSmogOffset
	local entity = gRegion:CreateEntity(spawnSmogDeco, v8 + FXOffset, __wf_atom_80368bb1)
	v = gRegion:CreateEntity(smogFxType, v8 + FXOffset, __wf_atom_80368bb1)
	_T.BromiusSmogVFX = entity
	local v9 = object:Attach(castSmogFx, Symbol("GAME_C1_SPINE1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)

	if not __wf_atom_7e8ad928(entity) then
		entity:SetMeshScale(0)
	end

	local __wf_atom_68de036a = object:__wf_atom_68de036a()
	local total = 0
	local total2 = 0

	while total < spawnSmogLifeTime + smogDebuffTime + spawnSmogGrowTime do
		local spawnSmogRadius2

		if total < spawnSmogGrowTime then
			spawnSmogRadius2 = fn5(total2 / spawnSmogGrowTime) * spawnSmogRadius -- inferred equivalent call
		else
			if not __wf_atom_7e8ad928(v9) then
				v9:Destroy()
			end

			spawnSmogRadius2 = spawnSmogRadius
		end

		if total < spawnSmogLifeTime + spawnSmogGrowTime then
			local v10 = spawnSmogRadius2 / 5

			if not __wf_atom_7e8ad928(entity) then
				entity:SetMeshScale(v10)
				Effects.__wf_atom_8cc6ad8e(entity, Vector(spawnSmogRadius2, spawnSmogRadius2, spawnSmogRadius2))
				entity:__wf_atom_8f04e01e(spawnSmogRadius2 / spawnSmogRadius)
			end

			if showDebug then
				local spawnSmogLifeTime2 = spawnSmogLifeTime + spawnSmogGrowTime - total

				if total < spawnSmogGrowTime then
					spawnSmogLifeTime2 = spawnSmogLifeTime
				end

				gRegion:__wf_atom_5b35a0c8(
					v8 + spawnSmogOffset,
					Color(0, 255, 0),
					"Life Time: " .. spawnSmogLifeTime2,
					2,
					0
				)
				gRegion:__wf_atom_b5c21154(
					v8 + spawnSmogOffset + Vector(0, 1, 0),
					spawnSmogRadius2,
					debugColour,
					Rotation(0, 90, 0),
					0
				)
			end

			for _, avatar in ipairs(__wf_atom_ef7900cf) do
				if
					__wf_atom_7e8ad928(avatar)
					or __wf_atom_7e8ad928(entity)
					or not (avatar:__wf_atom_8a6b8fc3(entity) < spawnSmogRadius2)
				then
					if not (__wf_atom_7e8ad928(avatar) or __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5[avatar:__wf_atom_18aa6e58()])) then
						v5[avatar:__wf_atom_18aa6e58()].poisonProcTime = smogPoisonProcApplyInterval
					end
				else
					if __wf_atom_7e8ad928(v5) then
						v5 = {}
					end

					if __wf_atom_7e8ad928(v5[avatar:__wf_atom_18aa6e58()]) then
						v5[avatar:__wf_atom_18aa6e58()] = {
							avatar = avatar,
							handSpawnTime = 0,
							buffTime = 0,
							poisonProcTime = 0
						}
					end

					if v5[avatar:__wf_atom_18aa6e58()].poisonProcTime <= 0 then
						v5[avatar:__wf_atom_18aa6e58()].avatar = avatar
						v5[avatar:__wf_atom_18aa6e58()].buffTime = smogDebuffTime
						v5[avatar:__wf_atom_18aa6e58()].poisonProcTime = smogPoisonProcApplyInterval

						if avatar == playerAvatar then
							if __wf_atom_7e8ad928(v4) then
								v4 = { avatar = playerAvatar, buffTime = smogDebuffTime }
							else
								v4.avatar = playerAvatar
								v4.buffTime = smogDebuffTime
							end
						end

						if gRegion:IsMaster() then
							local damageData = Engine.DamageData()
							damageData.baseAmount = smogPoisonDamageWhenApplyAmount + __wf_atom_68de036a * smogPoisonDamageWhenApplyAmountRankMod
							damageData:__wf_atom_6b472125(object)
							damageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
							damageData:__wf_atom_d6f4d914(6, true)
							local v11 = (__wf_atom_7e8ad928(avatar:__wf_atom_7470861b()) or __wf_atom_7e8ad928(avatar:__wf_atom_7470861b():__wf_atom_de83324e(6)))
								and 0
								or avatar:__wf_atom_7470861b():__wf_atom_de83324e(6):__wf_atom_1e34340d()
							damageData:__wf_atom_8e0ba0ec(smogDebuffTime - v11)
							avatar:__wf_atom_649bf33e(damageData)
						end
					end

					v5[avatar:__wf_atom_18aa6e58()].poisonProcTime -= __wf_atom_084b3e93()
				end
			end
		elseif not __wf_atom_7e8ad928(entity) then
			entity:PlayTriggeredFade()
			entity = nil
			_T.BromiusSmogVFX = nil

			if not __wf_atom_7e8ad928(v) then
				v:Destroy()
				v = nil
			end
		end

		fn4(object, __wf_atom_e55d02aa)
		total += __wf_atom_084b3e93()
		total2 += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not (__wf_atom_7e8ad928(v4) or __wf_atom_7e8ad928(v4.avatar)) then
		fn2(v4.avatar)
	end

	v5 = nil
end

function ActivateAbility(_, object, _, _)
	if gRegion:IsMaster() then
		object:__wf_atom_30e3d82b():__wf_atom_b414eabf()
	end

	if not __wf_atom_7e8ad928(castAnim) then
		local __wf_atom_921c1a5f = object:__wf_atom_921c1a5f(castAnim, false, 2, 1, true)
		local v8 = castAnim:__wf_atom_091354f5(Symbol(castAnimEventSymbol)) * __wf_atom_921c1a5f
		Sleep(v8)
	end

	object:__wf_atom_8a035cd5(Symbol("SpawnSmog"), false)

	while object:__wf_atom_c138b19b(castAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(loopAnim) then
		object:__wf_atom_921c1a5f(loopAnim, false, 2, 2, true)
	end

	Sleep(spawnSmogGrowTime)
end

function DeactivateAbility(_, object, _, _)
	if not (__wf_atom_7e8ad928(endAnim) or __wf_atom_7e8ad928(object) or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
		object:__wf_atom_921c1a5f(endAnim, true, 2, 1, true)
	end
end

function hideBody(object)
	for _, v8 in ipairs(boneToHideList) do
		if not __wf_atom_7e8ad928(v8) then
			object:__wf_atom_83fac646(v8, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
		end
	end

	for _, v8 in ipairs(boneToResetList) do
		if not __wf_atom_7e8ad928(v8) then
			object:__wf_atom_83fac646(v8, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(1000, 1000, 1000))
		end
	end
end