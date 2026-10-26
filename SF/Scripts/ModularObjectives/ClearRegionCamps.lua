local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.SparrowLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local __wf_atom_50a7d83es = {}

local function fn(list, isDynamic)
	local result = {}

	for _, hint in ipairs(list) do
		local __wf_atom_4026dfb5 = hint:__wf_atom_4026dfb5()

		if
			not hint:IsEnabled()
			or not (__wf_atom_4026dfb5 < 3)
			or (hint:__wf_atom_f43d338d() or hint:__wf_atom_c6ecf9af())
		then
			continue
		end

		if __wf_atom_4026dfb5 == 2 and hint:__wf_atom_3634e6d2() == 0 then
			print("Valid active hint found but it has no enemies remaining!")
		else
			table.insert(result, { hint = hint, isDynamic = isDynamic })
		end
	end

	return result
end

function Main(object)
	print("Clear camp encounter started")
	v = module.WaitForAiDir()
	v5 = 0
	v6 = 0
	v4 = 0
	v2 = object:__wf_atom_26b04ea9()
	v7 = object:__wf_atom_dd85e6db()
	local __wf_atom_12d9eb4f = v7:__wf_atom_12d9eb4f()
	local v9, v10

	if isSubObjective then
		v9 = "SubObjective-" .. v7:GetName()
		v10 = v2
		v2 = object:__wf_atom_1271ed80()
	else
		v10 = object
	end

	if __wf_atom_7e8ad928(v2) then
		v2 = object
	end

	local __wf_atom_d0c8d09f = v7:__wf_atom_d0c8d09f()
	local position = v2:GetPosition()
	local __wf_atom_103377cc = v2:__wf_atom_103377cc()
	local isInOverworld = module.IsInOverworld()
	local v11 = v7:__wf_atom_7026c43c() and not isInOverworld
	object:__wf_atom_8e6fec76(1)
	local v12 = {}
	local total = 0

	for _, v13 in ipairs(validEncounterHintTypes) do
		local v14

		if v11 then
			v14 = gRegion:FindAll(v13)
		else
			v14 = gRegion:FindAll(v13, position, 0, __wf_atom_103377cc)
		end

		if not includeDerivedHintTypes then
			for i = #v14, 1, -1 do
				if v14[i]:__wf_atom_e14d8a8c() ~= v13 then
					table.remove(v14, i)
				end
			end
		end

		local v15 = fn(v14, false)
		v12 = module.MergeTables(v12, v15)
	end

	for _, v13 in ipairs(validDynamicEncounterTags) do
		local v14 = fn(v:SelectEncounterHints(v13, 50, 3.4028234663852886e38, position, 0, __wf_atom_103377cc), true)
		v12 = module.MergeTables(v12, v14)
	end

	if #v12 == 0 then
		print("No valid encounterhints available to run this mission!")
		object:__wf_atom_8e6fec76(6)
	else
		if _T.PlayEncounterTransmissions then
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

		v3 = {}
		v8 = {}
		v4 = math.min(numCampsToClear, #v12)
		local v13 = 999
		local v14 = 0
		local v15

		if v11 then
			local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("LevelEntranceWp"))
			local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("LevelExitWp"))
			v15 = module.GetLayerIndex(__wf_atom_0a6a5887) + 1
			local v16 = module.GetLayerIndex(__wf_atom_0a6a5887_2) - 1
			local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Objective"))

			for _, v17 in ipairs(__wf_atom_2226b35c) do
				local v18 = v:__wf_atom_3c9cb048(v17:GetPosition()) + 1

				if __wf_atom_7e8ad928(v18) then
					continue
				end

				if v14 < v18 and v18 < v16 then
					v14 = v18
				end

				if v18 < v13 and v15 < v18 then
					v13 = v18
				end
			end

			if __wf_atom_7e8ad928(v13) then
				v14 = math.ceil((__wf_atom_104bfe98(v15, v16, 0.666)))
				v13 = v14
			end
		end

		while (v4 <= 0 or #v3 < v4) and #v12 > 0 do
			local v16 = __wf_atom_5784a397(1, #v12)
			local v17

			if v12[v16].isDynamic then
				local __wf_atom_4026dfb5 = v12[v16].hint:__wf_atom_4026dfb5()

				if __wf_atom_4026dfb5 == 0 then
					if isInOverworld then
						module2.SetEncounterBoostEnemies(v12[v16].hint, true)
					end

					v17 = not __wf_atom_7e8ad928((v:ActivateRandomEncounterAtSpecificHint(v12[v16].hint, 5, 5, v2)))
						or false
				else
					v17 = __wf_atom_4026dfb5 < 3 or false
				end
			else
				if isInOverworld then
					module2.SetEncounterBoostEnemies(v12[v16].hint, true)
				end

				v17 = true
			end

			if v17 then
				v12[v16].areaMarker = nil

				if v11 and dungeonEscalation then
					local layerIndex = module.GetLayerIndex(v12[v16].hint)

					if not __wf_atom_7e8ad928(layerIndex) then
						if layerIndex == v14 then
							local hint = v12[v16].hint
							module2.SetEncounterBoostEnemies(hint, true)
						elseif layerIndex < v13 and layerIndex <= v15 + 1 then
							local hint = v12[v16].hint
							module2.SetEncounterHeaviesBlocked(hint, true)
						end
					end
				end

				if not isInOverworld then
					module3.AddSparrowDestination(v12[v16].hint)
				end

				table.insert(v3, v12[v16])
			end

			table.remove(v12, v16)
		end

		v4 = #v3

		if showCounter then
			module5.UpdateOrAddHudCounterTask(v10, v9, nil, v5, v4, nil, object)
		else
			module5.UpdateOrAddHudTask(v10, v9, nil, nil, false, object)
		end

		module2.RemoveMissionMarker(v2)

		if __wf_atom_7e8ad928(object) then
			return
		end

		object:__wf_atom_8e6fec76(2)
		local v16 = false

		while not module2.PrimedMissionShouldShutDown(object, v2) do
			if total >= 3 then
				local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
				local flag = false

				for _, v17 in ipairs(__wf_atom_ef7900cf) do
					for _, v18 in ipairs(v3) do
						if not (v17:__wf_atom_1c8f7b2d(v18.hint) <= 60) then
							continue
						end

						flag = true
						break
					end

					if not flag then
						continue
					end

					module5.UpdateVisibility(true)
					break
				end

				if markIndividualEnemies then
					for i = #v3, 1, -1 do
						if __wf_atom_7e8ad928(v3[i]) or v3[i].hint:__wf_atom_4026dfb5() ~= 2 then
							continue
						end

						local __wf_atom_6199ef01 = v3[i].hint:__wf_atom_6199ef01()
						local __wf_atom_50a7d83es2 = {}

						for _, v17 in ipairs(__wf_atom_6199ef01) do
							local __wf_atom_50a7d83e = v17:__wf_atom_50a7d83e()

							if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
								continue
							end

							table.insert(__wf_atom_50a7d83es2, __wf_atom_50a7d83e)
							local v18 = false

							for j = #__wf_atom_50a7d83es, 1, -1 do
								if __wf_atom_7e8ad928(__wf_atom_50a7d83es[j]) or __wf_atom_50a7d83es[j]:IsKilled() then
									table.remove(__wf_atom_50a7d83es, j)
								elseif __wf_atom_50a7d83es[j] == __wf_atom_50a7d83e then
									v18 = true
									break
								end
							end

							if v18 then
								continue
							end

							if
								not __wf_atom_7e8ad928(soulModeAttachType)
								and __wf_atom_7e8ad928(__wf_atom_50a7d83e:__wf_atom_bb3e7833(soulModeAttachType))
							then
								__wf_atom_50a7d83e:Attach(soulModeAttachType, EMPTY_SYMBOL)
								__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")

								if not isInOverworld then
									module3.AddSparrowDestination(
										__wf_atom_50a7d83e,
										object,
										nil,
										module3.PRIORITY.HIGH
									)
								end
							end

							table.insert(__wf_atom_50a7d83es, __wf_atom_50a7d83e)
						end

						if not (#__wf_atom_50a7d83es2 > 0) then
							continue
						end

						local averagePosition = module.GetAveragePosition(__wf_atom_50a7d83es2, true)
						local v17 = 20

						for _, v18 in ipairs(__wf_atom_50a7d83es2) do
							v17 = math.max(v17, (v18:__wf_atom_a5304c35(averagePosition)))
						end

						if __wf_atom_7e8ad928(areaMarkerType) or not __wf_atom_7e8ad928(v3[i].areaMarker) then
							if not __wf_atom_7e8ad928(v3[i].areaMarker) then
								v3[i].marker:SetPosition(averagePosition)
								v3[i].areaMarker:SetPosition(averagePosition)
								v3[i].areaMarker:__wf_atom_400189c4((math.max(20, v17 + 5)))
							end
						else
							v3[i].areaMarker = module2.CreateAreaMarker(
								areaMarkerType,
								v3[i].hint:GetPosition(),
								(math.max(15, v17 + 5))
							)
							object:__wf_atom_d494454b(v3[i].areaMarker)

							if not __wf_atom_7e8ad928(__wf_atom_12d9eb4f) then
								v3[i].marker = gRegion:CreateEntity(
									__wf_atom_12d9eb4f,
									v3[i].hint:GetPosition(),
									__wf_atom_80368bb1
								)
								object:__wf_atom_d494454b(v3[i].marker)
							end

							if not isInOverworld then
								module3.RemoveSparrowDestination(v3[i].hint)
								module3.AddSparrowDestination(
									v3[i].areaMarker,
									object,
									nil,
									module3.PRIORITY.HIGH,
									Range(v3[i].hint:__wf_atom_103377cc(), 3.4028234663852886e38)
								)
							end
						end
					end
				end

				total = 0
			else
				total += __wf_atom_084b3e93()
			end

			for i = #v3, 1, -1 do
				if not (__wf_atom_7e8ad928(v3[i].hint) or not v3[i].hint:IsEnabled() or v3[i].hint:__wf_atom_4026dfb5() == 4 or v3[i].hint:__wf_atom_f43d338d()) then
					continue
				end

				v5 += 1

				if not __wf_atom_7e8ad928(v3[i].areaMarker) then
					v3[i].areaMarker:Destroy()
				end

				if not __wf_atom_7e8ad928(v3[i].marker) then
					v3[i].marker:Destroy()
				end

				module3.RemoveSparrowDestination(v3[i].hint)
				table.insert(v8, v3[i])
				table.remove(v3, i)
			end

			if not v16 then
				local v17 = v5

				if v4 / 2 < v17 then
					local taggedInTileType = module.FindTaggedInTileType(
						Symbol("StreamingDungeonExitWp"),
						Symbol("Exit")
					)

					if not __wf_atom_7e8ad928(taggedInTileType) and #taggedInTileType > 0 then
						v:AddEncounter(seekingPatrol)
						v:__wf_atom_c4c644af(taggedInTileType[1]:GetPosition(), seekingPatrol, v2)
					end

					v16 = true
				end
			end

			if v5 ~= v6 then
				if showCounter then
					module5.UpdateOrAddHudCounterTask(v10, v9, nil, v5, v4, nil, object)
				end

				v6 = v5

				if v4 <= v5 or #v3 == 0 or object:__wf_atom_4026dfb5() == 4 then
					print("Completed, no camps remaining")
					object:__wf_atom_8e6fec76(4)
					break
				end
			end

			local _debugDrawDailyLocations = _T.DebugDrawDailyLocations
			Sleep(0)
		end

		if __wf_atom_7e8ad928(object) then
			return
		end

		v3 = module.MergeTables(v3, v8)

		for _, v17 in ipairs(v3) do
			module2.SetEncounterBoostEnemies(v17.hint, false)
		end

		if object:__wf_atom_4026dfb5() == 4 then
			module5.CompleteHudTask(v10, nil, v9)

			if not isSubObjective then
				Sleep(4)

				if __wf_atom_7e8ad928(object) then
					return
				end
			end
		else
			object:__wf_atom_8e6fec76(6)
		end

		if not isSubObjective then
			module5.RemoveHudGroup(object)
		end

		module2.RemoveObjects(object)
		print("Clear camp encounter ended")
	end
end

function OnKilled(object)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(soulModeAttachType)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end