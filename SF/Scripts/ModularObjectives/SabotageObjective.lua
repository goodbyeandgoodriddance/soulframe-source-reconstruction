local v = WeakResource("/EE/Types/Navigation/DynamicNavMeshVolume")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.RaycastLib")
local module6 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v2 = nil
local v3 = {}
local v4 = {}
local v5 = 0
local v6 = 0
local v7 = -1
local v8 = nil
local __wf_atom_c4c644afs = {}
local v9 = {}
local v10 = nil
local v11 = nil
local position = nil
local v12 = {}
local v13 = nil

local function fn(instance)
	if __wf_atom_7e8ad928(instance) or instance:IsA(__wf_atom_67c46eba) and instance:IsKilled() then
		return true
	end

	if (instance:IsA(__wf_atom_6a50bd07) or instance:IsA(__wf_atom_8b8e8b22)) and not instance:IsEnabled() then
		return true
	end

	if
		instance:IsA(__wf_atom_6a50bd07)
		or not (instance:IsA(__wf_atom_8d0b7f88) and instance:__wf_atom_c6f1f83d() <= 0)
	then
		return false
	end

	return true
end

local function fn2()
	local v14 = {}

	for _, v15 in ipairs(typeSpawnPointTags) do
		local pointInstances = module2.FindPointInstances(v11, nil, v15)
		local v16

		if module.IsInOverworld() then
			v16 = gRegion:__wf_atom_439c0d29(v15, position, 0, v13)
		else
			v16 = gRegion:__wf_atom_2226b35c(v15)

			if #v16 > 0 and not v8:__wf_atom_7026c43c() then
				v16 = module.FilterObjectsInLayerIndex(module.GetLayerIndex(v11), v16)
			end
		end

		local mergeTables = module.MergeTables(v14, pointInstances, true)
		v14 = module.MergeTables(mergeTables, v16, true)
	end

	return v14
end

local function fn3(object, p, p2)
	local v14 = {}

	if destroyableObjectTag ~= EMPTY_SYMBOL then
		local pointInstances = module2.FindPointInstances(v11, nil, destroyableObjectTag)
		local v15

		if module.IsInOverworld() then
			v15 = gRegion:__wf_atom_439c0d29(destroyableObjectTag, object:GetPosition(), 0, v13)
		else
			v15 = gRegion:__wf_atom_2226b35c(destroyableObjectTag)

			if #v15 > 0 and not v8:__wf_atom_7026c43c() then
				v15 = module.FilterObjectsInLayerIndex(module.GetLayerIndex(v11), v15)
			end
		end

		local mergeTables = module.MergeTables(v14, pointInstances, true)
		v14 = module.MergeTables(mergeTables, v15, true)
	end

	local v15 = fn2()

	if v13 > 0 and not __wf_atom_7e8ad928(v15) and #v15 > 0 then
		for _, v16 in ipairs(v15) do
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(destroyableObjectTag, v16:GetPosition(), 0, v13)
			v14 = module.MergeTables(v14, __wf_atom_439c0d29, true)
		end
	end

	if p and #typesToSpawn > 0 then
		for _, v16 in ipairs(typesToSpawn) do
			local registeredObjectsOfType = module2.GetRegisteredObjectsOfType(object, v16)
			v14 = module.MergeTables(v14, registeredObjectsOfType, true)
		end
	end

	if canReenableObjects and not reenableSelectionOnly then
		for _, v16 in ipairs(v14) do
			if not (v16:IsA(__wf_atom_6a50bd07) or v16:IsA(__wf_atom_8b8e8b22)) or v16:IsEnabled() then
				continue
			end

			v16:Enable()
		end
	end

	if not (p2 or reenableSelectionOnly) then
		for i = #v14, 1, -1 do
			if fn(v14[i]) then
				table.remove(v14, i)
			end
		end
	end

	return v14
end

local function fn4(object)
	v3 = {}
	math.max(v11:__wf_atom_103377cc(), 50)
	local v14 = fn3(object, false, false)

	if #v14 > 0 then
		local randomizeTableOrder = module.RandomizeTableOrder(v14)

		for i = 1, math.min(numberToDestroy, #randomizeTableOrder) do
			table.insert(v3, randomizeTableOrder[i])
		end
	end

	if canReenableObjects and reenableSelectionOnly then
		for _, v15 in pairs(v3) do
			if not (v15:IsA(__wf_atom_6a50bd07) or v15:IsA(__wf_atom_8b8e8b22)) or v15:IsEnabled() then
				continue
			end

			v15:Enable()
		end
	end

	if #typesToSpawn > 0 and #typeSpawnPointTags > 0 and #v3 < numberToDestroy then
		local v15 = fn2()

		if not __wf_atom_7e8ad928(v15) and #v15 > 0 then
			for i = 1, math.min(numberToDestroy - #v3, #v15) do
				local position2 = v15[i]:GetPosition()
				local __wf_atom_dc309f8a = v15[i]:__wf_atom_dc309f8a()
				local v16 = typesToSpawn[__wf_atom_5784a397(1, #typesToSpawn)]
				local v17

				if alignRotationToGround then
					v17, __wf_atom_dc309f8a = module5.GetGroundAlignedSpawnPosRot(v16, position2, __wf_atom_dc309f8a)
				else
					v17 = module5.GetGroundPos(position2)
				end

				local v18

				if v16:IsA(__wf_atom_9fb5995f) and __wf_atom_7e8ad928(nil) then
					local enemyLevel = module2.GetEnemyLevel(object)
					local v19 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
					v18 = v2:__wf_atom_402b3832(v16, v17, __wf_atom_dc309f8a, module2.DEFAULT_TEAM, v19, nil):__wf_atom_50a7d83e()
				else
					v18 = gRegion:CreateEntity(v16, v17, __wf_atom_dc309f8a)
				end

				v18:__wf_atom_b811702e(destroyableObjectTag)
				table.insert(v3, v18)
				object:__wf_atom_d494454b(v18)

				if v15[i]:IsA(v) then
					v15[i]:FirePort("Disable")
				end
			end
		end
	end

	v5 = math.min(numberToDestroy, #v3)

	if not __wf_atom_7e8ad928(guardEncounter) and numGuardedObjectives > 0 then
		v2:AddEncounter(guardEncounter)
	end
end

local function fn5(hudRange)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v14 in ipairs(__wf_atom_ef7900cf) do
		for _, v15 in ipairs(v3) do
			if v14:__wf_atom_1c8f7b2d(v15) <= hudRange then
				return true
			end
		end
	end

	return false
end

function FortifyArea(p)
	module2.EnableFortificationHints(p)
end

function Main(object)
	print("Sabotage encounter started")
	module.WaitForLevel()
	v2 = module.WaitForAiDir()
	v8 = object:__wf_atom_dd85e6db()
	v11 = object:__wf_atom_26b04ea9() or object

	if __wf_atom_7e8ad928(v11) then
		v11 = object
	end

	position = v11:GetPosition()
	v10 = v11:__wf_atom_103377cc()
	v13 = math.max(v10, 50)
	local __wf_atom_12d9eb4f = v8:__wf_atom_12d9eb4f()
	local __wf_atom_d0c8d09f = v8:__wf_atom_d0c8d09f()
	local __wf_atom_2b1fe281 = object:__wf_atom_2b1fe281()
	local v14 = false
	local isInOverworld = module.IsInOverworld()
	object:__wf_atom_8e6fec76(1)

	if __wf_atom_2b1fe281 > 0 then
		v6 = __wf_atom_2b1fe281
		v3 = fn3(object, true, false)
		v5 = math.min(numberToDestroy, #v3)
	else
		if removeExistingDestroyablesOnStart and not removeDestroyablesOnComplete then
			local v15 = fn3(object, true, true)

			for _, v16 in ipairs(v15) do
				v16:Destroy()
			end
		end

		fn4(object)

		if #v3 == 0 then
			print("Aborting encounter, no valid sabotage objects found!")
			object:__wf_atom_8e6fec76(4)
			return
		else
			local v15 = Vector()

			for i, v16 in ipairs(v3) do
				if not __wf_atom_7e8ad928(soulModeAttachType) then
					object:__wf_atom_d494454b((v16:Attach(soulModeAttachType, EMPTY_SYMBOL)))
				end

				if (v16:IsA(__wf_atom_6a50bd07) or v16:IsA(__wf_atom_8b8e8b22)) and not v16:IsEnabled() then
					v16:Enable()
				end

				if not isInOverworld and markObjectivesOnMap and not __wf_atom_7e8ad928(__wf_atom_12d9eb4f) then
					object:__wf_atom_d494454b((v16:Attach(__wf_atom_12d9eb4f, EMPTY_SYMBOL)))
				end

				if
					not __wf_atom_7e8ad928(guardEncounter)
					and numGuardedObjectives > 0
					and i <= numGuardedObjectives
				then
					v9[i] = 1
				end

				if addSparrowDestinations then
					module3.AddSparrowDestination(
						v3[i],
						v11,
						nil,
						module3.PRIORITY.HIGH,
						Range(sparrowDestRadius, v11:__wf_atom_8f18e876() + 1)
					)
				end

				v15 += v16:GetPosition()
			end

			local v16 = v15 / #v3
			local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v16, 50, 100)

			if markAverageLocation or markObjectivesOnMap then
				module2.RemoveMissionMarker(v11)
			end

			if markAverageLocation then
				local _markObjectivesOnMap = markObjectivesOnMap
			end

			local v17 = position

			if not markAverageLocation then
				__wf_atom_0e0a6fee = v17
			end

			local registeredAreaMarker = module2.GetRegisteredAreaMarker(v11)

			if not __wf_atom_7e8ad928(registeredAreaMarker) then
				local __wf_atom_4e28532a = registeredAreaMarker:__wf_atom_4e28532a()
				local v18 = 0

				for _, v19 in ipairs(v3) do
					if __wf_atom_4e28532a < v19:__wf_atom_1c8f7b2d(registeredAreaMarker) then
						v18 = math.max(v18, v19:__wf_atom_a5304c35(__wf_atom_0e0a6fee) + 5)
					end
				end

				if v18 > 0 then
					registeredAreaMarker:SetPosition(__wf_atom_0e0a6fee)
					registeredAreaMarker:__wf_atom_400189c4((math.min(v18 + 10, 300)))
				end
			end

			if _T.PlayEncounterTransmissions or not module.IsInOverworld() then
				if __wf_atom_7e8ad928(questToCheck) then
					module4.PlayGlobalTransmission(__wf_atom_d0c8d09f, introTransmissionTag)
				else
					module4.PlayQuestDependentTransmission(
						__wf_atom_d0c8d09f,
						questToCheck,
						introTransmissionTag,
						introTransmissionPostQuestTag
					)
				end
			end

			if not __wf_atom_7e8ad928(subOjectiveTypes) and #subOjectiveTypes > 0 then
				for _, v18 in ipairs(subOjectiveTypes) do
					v2:AddEncounter(v18)
					local v19 = v2:ActivateSpecificEncounterNearPos(position, 1, 10, v18, 0, 1, v11)
					table.insert(v12, v19)
				end
			end
		end
	end

	module6.RemoveHudTask(object, nil, "OnPrimed")

	if module2.WaitForParentEncounterActive(object) then
		object:__wf_atom_8e6fec76(2)
		local total = 0

		while true do
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

			if module2.PrimedMissionShouldShutDown(object, v11, v3, 100) then
				break
			end

			for i = #v3, 1, -1 do
				if fn(v3[i]) then
					if
						markObjectivesOnMap
						and not (__wf_atom_7e8ad928(__wf_atom_12d9eb4f) or __wf_atom_7e8ad928(v3[i]))
					then
						local __wf_atom_bb3e7833 = v3[i]:__wf_atom_bb3e7833(__wf_atom_12d9eb4f)

						if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
							__wf_atom_bb3e7833:Destroy()
						end
					end

					if addSparrowDestinations then
						module3.RemoveSparrowDestination(v3[i])
					end

					table.insert(v4, v3[i])
					table.remove(v3, i)
				else
					local position2 = v3[i]:GetPosition()
					local _debugDrawDailyLocations = _T.DebugDrawDailyLocations

					if v9[i] == 1 then
						local nearbyPlayers = module2.GetNearbyPlayers(
							position2,
							guardEncounterStartDist,
							__wf_atom_ef7900cf
						)

						if not __wf_atom_7e8ad928(nearbyPlayers) and #nearbyPlayers > 0 then
							local nearbyEnemies = module2.FindNearbyEnemies(
								position2,
								guardEncounterMinDistFromOtherEnemies
							)

							if __wf_atom_7e8ad928(nearbyEnemies) or #nearbyEnemies <= 1 then
								local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(position2)
								local __wf_atom_c4c644af = v2:__wf_atom_c4c644af(__wf_atom_0e0a6fee, guardEncounter)

								if not __wf_atom_7e8ad928(__wf_atom_c4c644af) then
									table.insert(__wf_atom_c4c644afs, __wf_atom_c4c644af)
									print("Started guard encounter")
								end
							end

							v9[i] = 2
						end
					end
				end
			end

			local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			v6 = v5 - #v3

			if v7 < v6 then
				if hudRange > 0 then
					if v5 > 1 then
						module6.UpdateOrAddHudCounterTask(object, nil, nil, v6, v5)
					else
						module6.UpdateOrAddHudTask(object)
					end
				end

				v7 = v6
				object:__wf_atom_8776856a(v6)
			end

			if hudRange > 0 then
				if total >= 3 then
					if fn5(hudRange) then
						module6.UpdateVisibility(true)
					end

					total = 0
				else
					total += __wf_atom_084b3e93()
				end
			end

			if hudRange > 0 and not v14 and v5 <= v6 then
				module6.CompleteHudTask(object)
				v14 = true
			end

			if #v12 > 0 then
				for i = #v12, 1, -1 do
					if __wf_atom_7e8ad928(v12[i]) then
						table.remove(v12, i)
					end
				end
			end

			if #v12 == 0 and v5 <= v6 or object:__wf_atom_4026dfb5() == 4 then
				object:__wf_atom_8e6fec76(4)
				break
			else
				Sleep(0)
			end
		end

		if __wf_atom_7e8ad928(object) then
			return
		end

		if object:__wf_atom_4026dfb5() == 4 then
			if hudRange > 0 then
				module6.CompleteHudTask(object)
			end

			Sleep(4)

			if __wf_atom_7e8ad928(object) then
				return
			end
		else
			object:__wf_atom_8e6fec76(6)
		end

		if hudRange > 0 then
			module6.RemoveHudGroup(object)
		end

		print("Sabotage encounter ended")

		while
			#v3 > 0
			and not __wf_atom_7e8ad928(object)
			and not __wf_atom_7e8ad928(v11)
			and v11:__wf_atom_0cc670d2() > 0
		do
			Sleep(0)
		end

		if removeDestroyablesOnComplete then
			for _, v15 in ipairs(typeSpawnPointTags) do
				module2.RemoveObjects(object, v15, true)
			end
		end
	elseif not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8e6fec76(6)
	end
end

function OnPrimed(_) end