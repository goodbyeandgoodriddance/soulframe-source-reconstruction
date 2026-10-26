local v = Symbol("BlockingBehavior")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
	local __wf_atom_9a1e4ed3 = __wf_atom_30e3d82b:__wf_atom_9a1e4ed3()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or not (npcUseRange:Contains(__wf_atom_9a1e4ed3.distanceToTarget) and __wf_atom_30e3d82b:__wf_atom_da5e11fd(__wf_atom_9a1e4ed3.avatar:GetPosition()))
	then
		return 0
	end

	local __wf_atom_694c2c5b = __wf_atom_30e3d82b:__wf_atom_694c2c5b()
	local count = 0

	for i = 1, #__wf_atom_694c2c5b do
		local v2 = false

		if not __wf_atom_7e8ad928(__wf_atom_694c2c5b[i]) then
			local __wf_atom_9af7625d = __wf_atom_694c2c5b[i]:__wf_atom_9af7625d(object2)

			if __wf_atom_9af7625d <= maxRangeFromSwapper * maxRangeFromSwapper then
				if not preferMovingAway or minRangeFromSwapper * minRangeFromSwapper <= __wf_atom_9af7625d then
					v2 = __wf_atom_694c2c5b[i]:__wf_atom_9af7625d(__wf_atom_9a1e4ed3.avatar) <= maxRangeOfSwapperFromEnemy * maxRangeOfSwapperFromEnemy
						or false
				end

				count += 1
			end
		end

		if not (v2 and minimumAllyCount <= count) then
			continue
		end

		object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
		return 1
	end

	return 0
end

local function fn(object, object2)
	local position

	if __wf_atom_7e8ad928(object2) then
		if __wf_atom_7e8ad928(object:__wf_atom_eda97f5a()) then
			position = object:__wf_atom_50a7d83e():GetPosition()
		else
			position = object:__wf_atom_eda97f5a():GetPosition()
		end
	else
		position = object2:GetPosition()
	end

	local __wf_atom_694c2c5b = object:__wf_atom_694c2c5b()

	if __wf_atom_694c2c5b == nil or #__wf_atom_694c2c5b == 0 then
		return {}
	end

	local function fn2(object3, object4)
		if preferMovingAway then
			return __wf_atom_a93b9922(object3:GetPosition(), position) > __wf_atom_a93b9922(object4:GetPosition(), position)
		end

		return __wf_atom_a93b9922(object3:GetPosition(), position) < __wf_atom_a93b9922(object4:GetPosition(), position)
	end

	table.sort(__wf_atom_694c2c5b, fn2)
	local result = {}
	table.insert(result, __wf_atom_694c2c5b[1])

	for i = 2, #__wf_atom_694c2c5b do
		if #result >= swappingAlliesWarningCount then
			break
		end

		local flag = true

		for j = 1, #result do
			if not (__wf_atom_a93b9922(__wf_atom_694c2c5b[i]:GetPosition(), result[j]:GetPosition()) < minDistanceBetweenAlliesPickedForTarget * minDistanceBetweenAlliesPickedForTarget) then
				continue
			end

			flag = false
			break
		end

		if flag then
			table.insert(result, __wf_atom_694c2c5b[i])
		end
	end

	if not (#result < swappingAlliesWarningCount and #__wf_atom_694c2c5b >= swappingAlliesWarningCount) then
		return result
	end

	for i = 2, #__wf_atom_694c2c5b do
		local flag = true

		for j = 1, #result do
			if __wf_atom_694c2c5b[i] ~= result[j] then
				continue
			end

			flag = false
			break
		end

		if flag then
			table.insert(result, __wf_atom_694c2c5b[i])
		end

		if #result >= swappingAlliesWarningCount then
			break
		end
	end

	return result
end

function ActivateAbility(object, object2, p, _)
	local secondaryScriptArgs = SF.SecondaryScriptArgs(true)
	secondaryScriptArgs:__wf_atom_a17e41c6(p)
	object:ActivateSecondaryScript(mOwner:__wf_atom_e14d8a8c(), Symbol("CreateBoard"), secondaryScriptArgs)

	if gRegion:IsMaster() and not blockingAnimations then
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v, object2)
		end
	end

	object2:__wf_atom_9b5dcd3b(activateAnim, false, 4, 3, blockingAnimations)

	if gRegion:IsMaster() then
		local v2 = fn(object2:__wf_atom_30e3d82b(), p)
		local v3 = {}

		if not __wf_atom_7e8ad928(warningDecoAttachmentOnAllies) then
			for i = 1, #v2 do
				table.insert(
					v3,
					(v2[i]:Attach(
						warningDecoAttachmentOnAllies,
						warningDecoAttachmentBone,
						warningDecoAttachmentOffset,
						warningDecoAttachmentRotation,
						object2
					))
				)

				if not __wf_atom_7e8ad928(swapperSelectedAnim) then
					v2[i]:__wf_atom_921c1a5f(swapperSelectedAnim, false, 4, 1, true)
				end
			end
		end

		object2:__wf_atom_8914dfde(teleportBeginAnimEvent, teleportBeginAnimTimeout)
		local position = object2:GetPosition()
		local __wf_atom_dc309f8a = object2:__wf_atom_dc309f8a()
		local __wf_atom_eda97f5a = object2:__wf_atom_30e3d82b():__wf_atom_eda97f5a()
		local v4 = nil
		local v5 = 0

		if not __wf_atom_7e8ad928(__wf_atom_eda97f5a) then
			for i = 1, #v2 do
				if __wf_atom_7e8ad928(v2[i]) or v2[i]:IsKilled() then
					continue
				end

				local __wf_atom_9af7625d = v2[i]:__wf_atom_9af7625d(object2)

				if not (__wf_atom_9af7625d <= maxRangeFromSwapper * maxRangeFromSwapper and minRangeFromSwapper * minRangeFromSwapper <= __wf_atom_9af7625d) then
					continue
				end

				local __wf_atom_9af7625d2 = v2[i]:__wf_atom_9af7625d(__wf_atom_eda97f5a)

				if __wf_atom_7e8ad928(v4) then
					v4 = v2[i]
				elseif preferMovingAway then
					if v5 < __wf_atom_9af7625d2 then
						v4 = v2[i]
						v5 = __wf_atom_9af7625d2
					end
				elseif __wf_atom_9af7625d2 < v5 then
					v4 = v2[i]
					v5 = __wf_atom_9af7625d2
				end
			end
		end

		if __wf_atom_7e8ad928(v4) then
			object2:__wf_atom_921c1a5f(failedTeleportCasterAnim, false, 4, 1, blockingAnimations)
		else
			local position2 = v4:GetPosition()
			gRegion:CreateEntity(teleportFxOnCasterPos, position2, __wf_atom_80368bb1)

			if __wf_atom_7e8ad928(__wf_atom_eda97f5a) then
				object2:Teleport(position2, object2:__wf_atom_dc309f8a())
			else
				object2:Teleport(position2, __wf_atom_fa8d0177(position2, __wf_atom_eda97f5a:GetPosition()))
			end

			gRegion:CreateEntity(teleportFxOnSwapperPos, position, __wf_atom_80368bb1)
			object2:__wf_atom_921c1a5f(postTeleportCasterAnim, false, 4, 1, blockingAnimations)
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Teleport(position, __wf_atom_dc309f8a)
		end

		for i = 1, #v2 do
			if not __wf_atom_7e8ad928(v2[i]) then
				v2[i]:__wf_atom_921c1a5f(postTeleportSwapperAnim, false, 4, 1, false)
			end
		end

		for i = 1, #v3 do
			if not __wf_atom_7e8ad928(v3[i]) then
				gRegion:__wf_atom_dd1e4d10(v3[i])
			end
		end
	else
		local v2 = 3

		while v2 > 0 and not object2:__wf_atom_c138b19b(postTeleportCasterAnim) do
			Sleep(0)
			v2 -= __wf_atom_084b3e93()
		end
	end

	if radialDamageAnimEvent ~= "" or impactDamageAnimEvent ~= "" then
		object2:__wf_atom_8a035cd5(Symbol("DoPostTeleportExplosion"), false)
	end

	Sleep(1)

	if not __wf_atom_7e8ad928(postTeleportCasterAnim) then
		while object2:__wf_atom_c138b19b(postTeleportCasterAnim) do
			Sleep(0.1)
		end
	end

	if not __wf_atom_7e8ad928(failedTeleportCasterAnim) then
		while object2:__wf_atom_c138b19b(failedTeleportCasterAnim) do
			Sleep(0.1)
		end
	end
end

local function fn2(object, object2)
	if __wf_atom_7e8ad928(object2) then
		local __wf_atom_4e50d390 = object:__wf_atom_4e50d390()
		__wf_atom_4e50d390.pitch = 0
		__wf_atom_4e50d390.bank = 0
		return __wf_atom_e97f3142(__wf_atom_4e50d390), __wf_atom_4e50d390
	else
		local v2 = __wf_atom_fa8d0177(object:GetPosition(), object2:GetPosition())
		v2.pitch = 0
		v2.bank = 0
		return __wf_atom_e97f3142(v2), v2
	end
end

function CreateBoard(object, _, p)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	if not __wf_atom_7e8ad928(perSquareDecoration) or debugDraw then
		local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
		local v2

		if not __wf_atom_7e8ad928(__wf_atom_2202ffb6) then
			v2 = __wf_atom_2202ffb6:__wf_atom_7d789620()
		end

		local v3, v4 = fn2(__wf_atom_6009c8ed, p)
		local v5 = __wf_atom_9341614d(v3, Rotation(90, 0, 0))
		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(__wf_atom_6009c8ed:GetPosition() + v3 * firstTileForwardOffset + v5 * firstTileSidewaysOffset)
		local v6 = Vector()
		local v7 = Vector()
		local __wf_atom_80368bb1 = __wf_atom_80368bb1
		local v8 = 0
		local v9 = 0

		for i = 1, squareCountPerRowAndColumn do
			for j = 1, squareCountPerRowAndColumn do
				local v10 = 0 - (squareCountPerRowAndColumn - 1) / 2 + (j - 1)
				local v11 = __wf_atom_0e0a6fee + v3 * (i - 1) * squareSize - v5 * v10 * squareSize
				v6.x = v11.x
				v6.y = v11.y + 0.25 + floorSearchRaycastHeight + v8 * 1.6
				v6.z = v11.z
				v7.x = v11.x
				v7.y = v11.y - (4 + floorSearchRaycastHeight + v9 * 1.6)
				v7.z = v11.z
				local v12 = Vector()
				local v13 = Rotation()

				if gRegion:__wf_atom_267afa54(v6, v7, __wf_atom_6009c8ed, raycastIgnoreTypes, nil, v12, v13, true) then
					local v14 = v12.y - __wf_atom_0e0a6fee.y

					if v8 < v14 then
						v8 = v14
					end

					if v14 < v9 then
						v9 = v14
					end

					if alignTilesToGround then
						__wf_atom_80368bb1.heading = v4.heading
						__wf_atom_80368bb1.pitch = 0
						__wf_atom_80368bb1.bank = 0
						__wf_atom_80368bb1 = __wf_atom_d919c2d7(__wf_atom_80368bb1, v13)
					end

					if debugDraw then
						gRegion:__wf_atom_b5c21154(v12, squareSize / 2, debugBoardColor, debugRot, 5)
					end

					if not __wf_atom_7e8ad928(perSquareDecoration) then
						gRegion:CreateEntity(perSquareDecoration, v12, __wf_atom_80368bb1, __wf_atom_6009c8ed):__wf_atom_7ebba814(__wf_atom_6009c8ed)
					end
				end

				Sleep(0)
			end

			Sleep(timeBetweenRowGeneration)
		end
	end
end

function DoPostTeleportExplosion(object)
	local v2

	if impactDamageAnimEvent ~= "" then
		local v3 = Time()
		object:__wf_atom_8914dfde(impactDamageAnimEvent, 10)

		if Time() - v3 > 9.999 then
			return
		end

		object:PlaySound(impactSound, false)
		v2 = gRegion:CreateEntity(impactExplosionFx, object:GetPosition(), __wf_atom_80368bb1)
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(impactDamage))
		radialDamageData.stabilityDamage = impactStabilityDamage
		radialDamageData.radius = impactDamageRadius
		radialDamageData.fallOff = impactDamageFalloff
		radialDamageData.staticCoverOnly = true
		radialDamageData:__wf_atom_7498285f(impactDamageType, 1)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(__wf_atom_d2b2176d:__wf_atom_e55d02aa())
		radialDamageData:__wf_atom_98d98d81(object:GetPosition())
		radialDamageData.hitAirborneTargets = impactHitAirborneTargets
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end

	if radialDamageAnimEvent ~= "" then
		local v3 = Time()
		object:__wf_atom_8914dfde(radialDamageAnimEvent, 10)

		if Time() - v3 > 9.999 then
			return
		end

		if not __wf_atom_7e8ad928(v2) then
			v2:Destroy()
		end

		gRegion:CreateEntity(radialExplosionFx, object:GetPosition(), __wf_atom_80368bb1)
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()
		local radialDamageData = Engine.RadialDamageData()
		radialDamageData:__wf_atom_6d7ec072(Engine.UpgradedValue(radialDamage))
		radialDamageData.stabilityDamage = radialStabilityDamage
		radialDamageData.radius = radialDamageRadius
		radialDamageData.fallOff = radialDamageFalloff
		radialDamageData.staticCoverOnly = true
		radialDamageData:__wf_atom_7498285f(explodeDamageType, 1)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(__wf_atom_d2b2176d:__wf_atom_e55d02aa())
		radialDamageData:__wf_atom_98d98d81(object:GetPosition())
		radialDamageData.hitAirborneTargets = radialDamageHitAirborneTargets
		gRegion:__wf_atom_f6ec80de(radialDamageData)
	end
end

function DeactivateAbility(_, object, _, _)
	if not blockingAnimations then
		local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_42b767a2(v)
		end
	end
end