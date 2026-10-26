module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
require("Lotus.Interface.UIUtilities")
SANCTUARY_ONSLAUGHT_NODE = Symbol("SolNode801")
SANCTUARY_ONSLAUGHT_CHALLENGE_NODE = Symbol("SolNode802")
FRAME_FIGHTER_NODE = Symbol("SolNode973")
JCE_CAN_PLAY = 0
JCE_MASTERY_LOCKED = 1
JCE_SYNDICATE_TITLE_LOCKED = 2
JCE_CHAIN_PROGRESS_LOCKED = 3
JCE_ITEM_LOCKED = 4
JCE_ERROR = 5
local v = WeakResource()
local v2 = WeakResource()
local v3 = WeakResource()
local v4 = WeakResource("/SF/Types/Game/SFPvpGameRules")
local v5 = Symbol("ConclaveSyndicate")
local v6 = WeakResource("/SF/Types/Player/PlayerPowerSuit")
local v7 = WeakResource()
local v8 = WeakResource()

local function fn()
	if
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_dd9a0bb8) or gGameRules:IsA(__wf_atom_1316e0c2) or gGameRules:IsA(__wf_atom_abe10cec) or gGameRules:IsA(__wf_atom_e714d8ac) or gGameRules:IsA(__wf_atom_ed7f8200))
	then
		return false
	end

	return true
end

local function fn2(list, list2)
	local __wf_atom_a4299765 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765()
	local __wf_atom_6b29f1ed = __wf_atom_a4299765:__wf_atom_6b29f1ed()

	for i, v9 in ipairs(list) do
		local v10 = false
		local mItemCount = 0
		local item = v9:GetItem()

		if __wf_atom_7e8ad928(item) then
			continue
		end

		local __wf_atom_efa6f447 = v9:__wf_atom_efa6f447()
		local text = "/Lotus/Language/Menu/MissionNeedItemSolo"

		if __wf_atom_efa6f447 == 11 then
			if item:IsA(__wf_atom_d5a2d4b7) and gGameData:GetInventory():__wf_atom_e3bbb1ae(item) then
				v10 = true
			end
		elseif __wf_atom_efa6f447 == 2 then
			text = "/Lotus/Language/Menu/MissionNeedGearSolo"

			for j = 1, #__wf_atom_6b29f1ed do
				local v11 = __wf_atom_6b29f1ed[j]
				local mItemType = v11.mItemType

				if item == v then
					if mItemType == item or mItemType == v2 then
						mItemCount = v11.mItemCount
						v10 = true
					end
				elseif not __wf_atom_7e8ad928(mItemType) and mItemType:IsA(item) then
					mItemCount = v11.mItemCount
					v10 = true
				end
			end
		else
			if i <= #list2 and list2[i] == 2021 and gGameData:GetInventory():__wf_atom_c9e583ca(item) == 0 then
				v10 = true
				mItemCount = -1
			end

			for _, v11 in pairs({ 0, 1, 2, 3 }) do
				local __wf_atom_ed5c034d = __wf_atom_a4299765:__wf_atom_ed5c034d(0, v11)

				if __wf_atom_7e8ad928(__wf_atom_ed5c034d.mItemType) or not __wf_atom_ed5c034d.mItemType:IsA(item) then
					continue
				end

				v10 = true
				mItemCount = -1
				break
			end
		end

		if not v10 then
			return {
				text = text,
				ITEM = Localize(tostring(v9:__wf_atom_014a76a2()), false)
			}
		end

		if mItemCount >= 0 and i <= #list2 and list2[i] > 1 and mItemCount < list2[i] then
			return {
				text = "/Lotus/Language/Menu/MissionNeedItemQuantitySolo",
				ITEM = Localize(tostring(v9:__wf_atom_014a76a2()), false),
				value = list2[i]
			}
		end
	end
end

local function fn3(list, p)
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	if __wf_atom_7e8ad928(__wf_atom_bb46d8b6) or #__wf_atom_bb46d8b6 <= 1 then
		local v9 = fn2(list, p)

		if v9 then
			return v9
		end
	else
		for _, v9 in ipairs(__wf_atom_bb46d8b6) do
			local decoded = cjson.decode(v9.loadout)

			for _, v10 in ipairs(list) do
				local v11 = false
				local item = v10:GetItem()

				if __wf_atom_7e8ad928(item) then
					continue
				end

				if item:IsA(v7) then
					local _hasFissureum = decoded.HasFissureum
				else
					for i = 1, #decoded.Consumables do
						local v12 = WeakResource(decoded.Consumables[i])

						if item == v then
							if v12 == item or v12 == v2 then
								v11 = true
							end
						elseif not __wf_atom_7e8ad928(v12) and v12:IsA(item) then
							v11 = true
						end
					end

					if not v11 then
						local normal = decoded.NORMAL

						for _, v12 in pairs({ 0, 1, 2, 3 }) do
							local v13 = normal[v12 + 1]

							if __wf_atom_7e8ad928(v13.ItemType) then
								continue
							end

							local v14 = WeakResource(v13.ItemType)

							if __wf_atom_7e8ad928(v14) or not v14:IsA(item) then
								continue
							end

							v11 = true
							break
						end
					end

					if not v11 then
						if #__wf_atom_bb46d8b6 == 1 or v9.isLocal then
							return {
								text = "/Lotus/Language/Menu/MissionNeedItemSolo",
								ITEM = Localize(tostring(v10:__wf_atom_014a76a2()), false)
							}
						end

						return {
							text = "/Lotus/Language/Menu/MissionNeedItemSquad",
							player = v9.name,
							ITEM = Localize(tostring(v10:__wf_atom_014a76a2()), false)
						}
					end
				end
			end
		end
	end
end

function CheckItemRequirements(p, p2)
	return fn3(p, p2)
end

local function fn4(p, p2, p3)
	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(p)

	if __wf_atom_7e8ad928(__wf_atom_13d5b7e9) or __wf_atom_7e8ad928(gGameData) then
		return JCE_ERROR
	end

	local v9 = Resource(__wf_atom_13d5b7e9:__wf_atom_6e1dcf41())

	if __wf_atom_7e8ad928(v9) then
		return JCE_ERROR
	end

	local __wf_atom_7bf42726 = v9:__wf_atom_7bf42726()

	for i = 1, #__wf_atom_7bf42726 do
		local v10 = __wf_atom_7bf42726[i]

		if v10.mLocationTag ~= p2 then
			continue
		end

		local count = 0

		for j = 1, #v10.mJobs do
			local mJob = v10.mJobs[j]

			if gGameData:__wf_atom_e44b96c7(v10.mLocationTag, WeakResource(mJob.mJobInfo)) then
				count += 1
			end

			if mJob.mJobInfo ~= p3 then
				continue
			end

			if mJob.mMasteryReq > gGameData:__wf_atom_a04e4a53() then
				return
					JCE_MASTERY_LOCKED,
					Localize("/Lotus/Language/OstronCrafting/JobBoard_MasteryLocked", {
						RANK = module.FormatNumber(mJob.mMasteryReq)
					})
			end

			local __wf_atom_e173a80e = gGameData:__wf_atom_e173a80e()
			local mTitle = 0

			for k = 1, #__wf_atom_e173a80e do
				if __wf_atom_e173a80e[k].mTag ~= p then
					continue
				end

				mTitle = __wf_atom_e173a80e[k].mTitle
				break
			end

			if mTitle < mJob.mSyndicateTitleReq then
				local __wf_atom_c14d1e89 = __wf_atom_13d5b7e9:__wf_atom_c14d1e89()
				local v11 = ""

				for _, v12 in pairs(__wf_atom_c14d1e89) do
					if v12.level ~= mJob.mSyndicateTitleReq then
						continue
					end

					v11 = v12.titleLoc:c_str()
					break
				end

				local v12 = Localize("/Lotus/Language/OstronCrafting/JobBoard_SyndicateTitleLocked", {
					TITLE = string.upper(Localize(v11, nil))
				})
				return JCE_SYNDICATE_TITLE_LOCKED, v12
			else
				if count < j - 1 then
					return
						JCE_CHAIN_PROGRESS_LOCKED,
						Localize("/Lotus/Language/OstronCrafting/JobBoard_ChainProgressLocked", {})
				end

				local v11 = #mJob.mRequiredItems > 0 and fn2(mJob.mRequiredItems)

				if not v11 then
					return JCE_CAN_PLAY
				end

				local v12 = Localize(v11.text, { ITEM = v11.ITEM })
				return JCE_ITEM_LOCKED, v12
			end
		end
	end

	return JCE_ERROR
end

function GetJobChainMissionEligibility(p, p2, p3)
	local v9, v10 = fn4(p, p2, p3)
	return v9, v10
end

function GetJobChainMissionEligibilityFromSquadMissionInfo(_)
	return JCE_CAN_PLAY, nil
end

local function fn5(object)
	if __wf_atom_7e8ad928(object) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return false
		end

		object = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(object) then
			return false
		end
	end

	local __wf_atom_da43e3f3 = object:GetInventory():__wf_atom_da43e3f3()

	for i = 1, #__wf_atom_da43e3f3 do
		if __wf_atom_da43e3f3[i].mItemType:IsA(v3) then
			return true
		end
	end

	return false
end

function HasTennoConRelayAccess(p)
	return (fn5(p))
end

local function fn6(p, p2, mission, p3)
	if
		__wf_atom_c67f9605:__wf_atom_6d03a710()
		and (not gGameRules:IsA(__wf_atom_dd9a0bb8) or __wf_atom_7e8ad928(mission) or mission.missionType ~= 18 and __wf_atom_7e8ad928(mission.keyChainName))
	then
		if string.find(tostring(p), "Dojo") ~= nil or string.find(tostring(p), "_HUB") ~= nil then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_5d9ae734())) then
				return nil
			end
		end

		return {
			text = Localize("/Lotus/Language/Menu/MainMenu_NewBuildMissionsBlocked", nil)
		}
	else
		local v9 = false
		local ternary = module.Ternary(p, tostring(p), "")
		local v10 = string.find(ternary, module2.TAG_SEPERATOR)
		local v11 = string.find(ternary, module2.SORTIE_MISSION_TAG) ~= nil
		local v12, v13

		if v10 then
			v12 = string.sub(ternary, v10 + 1)
			v13 = string.sub(ternary, 1, v10 - 1)
		else
			v13 = ternary
		end

		local v14, v15, starChart, missionReward, items, item, missionRewardExtra, items2, item2, v16, v17, level, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, decoded, pvpValue, v28, v29, v30, v31, v32, v33, v34, count, v35, v36, decoded2, v37, count2, v38, v39, v40, v41, v42, v43, v44, v45, v46, decoded3, v47, v48, v49, v50, _, v52, v53, v54, v55, v56, itemType, v57, v58, text, v60, v61, v62, v63, v64, v65, v66, mItemType, mItemCount, v67, v68, text2, v70, v71, v72, v73, mTitle, v74, v75, v76, v77

		if v13 == "TennoConHUB2" then
			if not fn5(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()) then
				return {
					text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
				}
			end

			if __wf_atom_7e8ad928(mission) then
				if
					_T.CachedAlerts == nil
					or not (_T.CachedAlerts[v13] and _T.CachedAlerts[v13].mVisible and string.find(ternary, module2.ALERT_TAG))
				then
					if _G.CachedGoalInfo[v13] and string.find(ternary, module2.EVENT_TAG) then
						mission = _G.CachedGoalInfo[v13].mMissionInfo:Copy()

						if mission.goalTag == EMPTY_SYMBOL then
							mission.goalTag = _G.CachedGoalInfo[v13].mTag
						end
					elseif
						_T.CachedSyndicateMissions == nil
						or not (_T.CachedSyndicateMissions[v13] and _T.CachedSyndicateMissions[v13].mVisible and string.find(ternary, module2.SYNDICATE_MISSION_TAG))
					then
						if _T.CachedSortieMissions == nil or not (_T.CachedSortieMissions[v13] and v11) then
							if
								_T.CachedActiveMissions == nil
								or not (_T.CachedActiveMissions[v13] and string.find(ternary, module2.ACTIVE_MISSION_TAG))
							then
								if
									_T.CachedInvasionInfo == nil
									or not (_T.CachedInvasionInfo[v13] and string.find(ternary, module2.INVASION_ATTACKER_TAG))
								then
									if
										_T.CachedInvasionInfo == nil
										or not (_T.CachedInvasionInfo[v13] and string.find(ternary, module2.INVASION_DEFENDER_TAG))
									then
										if
											_T.CachedEliteAlertMissions == nil
											or not (_T.CachedEliteAlertMissions[v13] and string.find(ternary, module2.ELITE_ALERT_TAG))
										then
											if
												_T.CachedHardModeDailyMissions == nil
												or not (_T.CachedHardModeDailyMissions[v13] and string.find(ternary, module2.HARD_DAILY_TAG))
											then
												if string.find(ternary, module2.KEY_TAG) then
													v14 = string.sub(ternary, 1, v10 - 1)
													Type(v14)
													v15 = Resource(v14)

													if not __wf_atom_7e8ad928(v15) then
														mission = v15:__wf_atom_72fc675e()
														v9 = string.find(v13, "ArchwingQuest/MissionFive") ~= nil
													end
												else
													if not __wf_atom_7e8ad928(gGameRules) then
														if gGameRules:IsA(__wf_atom_e714d8ac) or fn() then
															starChart = gGameRules:__wf_atom_aaa23ad1()
														else
															starChart = gGameRules:GetStarChart()
														end
													end

													if __wf_atom_7e8ad928(starChart) then
														return nil
													end

													mission = starChart:BuildMissionForLocation(Symbol(v13))

													if
														_T.gPendingMission ~= nil
														and #_T.gPendingMission.requiredItems > 0
													then
														mission.requiredItems = _T.gPendingMission.requiredItems
													end
												end
											else
												mission = _T.CachedHardModeDailyMissions[v13].mission
											end
										else
											mission = _T.CachedEliteAlertMissions[v13].mMissionInfo
										end
									else
										mission = _T.CachedInvasionInfo[v13].mDefenderMissionInfo
									end
								else
									mission = _T.CachedInvasionInfo[v13].mAttackerMissionInfo
								end
							else
								mission = _T.CachedActiveMissions[v13].mMissionInfo
							end
						else
							mission = _T.CachedSortieMissions[v13].mMissionInfo
						end
					else
						mission = _T.CachedSyndicateMissions[v13].mMissionInfo
					end
				else
					mission = _T.CachedAlerts[v13].mAlertInfo.mMissionInfo
				end
			elseif not __wf_atom_7e8ad928(mission.levelKeyName) then
				if string.find(tostring(mission.levelKeyName:__wf_atom_5b41f63b()), "ArchwingQuest/MissionFive") == nil then
					v9 = false
				else
					v9 = true
				end
			end

			if module2.IsOverOmegaLimit() then
				if v11 then
					return {
						text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictSortie", nil)
					}
				end

				missionReward = mission.missionReward

				if not __wf_atom_7e8ad928(missionReward) then
					items = missionReward.items

					for i = 1, #items do
						item = items[i]:GetItem()

						if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_16cdad3a) then
							return {
								text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictMission", nil)
							}
						end
					end
				end

				missionRewardExtra = mission.missionRewardExtra

				if not __wf_atom_7e8ad928(missionRewardExtra) then
					items2 = missionRewardExtra.items

					for i = 1, #items2 do
						item2 = items2[i]:GetItem()

						if not __wf_atom_7e8ad928(item2) and item2:IsA(__wf_atom_16cdad3a) then
							return {
								text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictMission", nil)
							}
						end
					end
				end
			end

			if Engine.__wf_atom_84bb79c2() then
				v16 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if not __wf_atom_7e8ad928(v16) then
					v17 = v16:__wf_atom_9be88b01()

					if __wf_atom_7e8ad928(v17) or not v17:__wf_atom_df64c481() then
						level = gRegion:__wf_atom_ade7f08f().level

						if not __wf_atom_c67f9605:__wf_atom_172c2f5c(level) then
							return {
								text = Localize("/Lotus/Language/Menu/SocialOverlay_SessionJoinFromTutorial", nil)
							}
						end
					end
				end
			end

			if
				mission
				and mission.conclaveRange ~= nil
				and (mission.conclaveRange.minValue ~= 0 or mission.conclaveRange.maxValue ~= 0)
			then
				if
					p2
					or gMatchingService:__wf_atom_1b24a1bb()
					or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
				then
					v18 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

					if not __wf_atom_7e8ad928(v18) then
						v19 = v18:__wf_atom_9be88b01():__wf_atom_a4299765()

						if mission.conclaveRangePerItem then
							for i = 0, 6 - 1 do
								v20 = v19:__wf_atom_4a5fdb87(0, i)

								if mission.conclaveRange.maxValue < v20 then
									v21 = Resource(v19:__wf_atom_ed5c034d(0, i).mItemType)
									v22 = Localize(tostring(v21:__wf_atom_014a76a2()), false)
									return {
										text = "/Lotus/Language/Menu/PvpValueFailureSoloItem",
										value = v20,
										MIN = mission.conclaveRange.minValue,
										MAX = mission.conclaveRange.maxValue,
										ITEM = v22
									}
								else
									v23 = v19:__wf_atom_4a5fdb87(1, i)

									if mission.conclaveRange.maxValue < v23 then
										v24 = Resource(v19:__wf_atom_ed5c034d(1, i).mItemType)
										v25 = Localize(tostring(v24:__wf_atom_014a76a2()), false)
										return {
											text = "/Lotus/Language/Menu/PvpValueFailureSoloItem",
											value = v23,
											MIN = mission.conclaveRange.minValue,
											MAX = mission.conclaveRange.maxValue,
											ITEM = v25
										}
									end
								end
							end
						else
							v26 = v19:__wf_atom_698cee43()
							print("Local PVP value: " .. tostring(v26))

							if v26 < mission.conclaveRange.minValue or mission.conclaveRange.maxValue < v26 then
								return {
									text = "/Lotus/Language/Menu/PvpValueFailureSolo",
									value = v26,
									MIN = mission.conclaveRange.minValue,
									MAX = mission.conclaveRange.maxValue
								}
							end
						end
					end
				end

				v27 = gMatchingService:__wf_atom_bb46d8b6()

				for i = 1, #v27 do
					decoded = cjson.decode(v27[i].loadout)
					pvpValue = decoded.PvpValue

					if mission.conclaveRangePerItem then
						pvpValue = decoded.PvpValueItemMax
					end

					if not (pvpValue < mission.conclaveRange.minValue or mission.conclaveRange.maxValue < pvpValue) then
						continue
					end

					print("PVP value " .. tostring(pvpValue) .. "[" .. tostring(mission.conclaveRange.minValue) .. " - " .. tostring(mission.conclaveRange.maxValue) .. "]")

					if #v27 == 1 or v27[i].isLocal then
						return {
							text = "/Lotus/Language/Menu/PvpValueFailureSolo",
							value = pvpValue,
							MIN = mission.conclaveRange.minValue,
							MAX = mission.conclaveRange.maxValue
						}
					end

					if not p3 then
						return {
							text = "/Lotus/Language/Menu/PvpValueFailureSquad",
							value = pvpValue,
							MIN = mission.conclaveRange.minValue,
							MAX = mission.conclaveRange.maxValue,
							player = v27[i].name
						}
					end
				end
			end

			if mission and mission.archwingRequired then
				v28 = gMatchingService:__wf_atom_bb46d8b6()

				if __wf_atom_7e8ad928(v28) or #v28 <= 1 or p3 then
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765()
					v29 = not (__wf_atom_7e8ad928((nil).mItemType) or __wf_atom_7e8ad928((nil).mItemType) or __wf_atom_7e8ad928((nil).mItemType))

					if not (v9 and v29) then
						return { text = "/Lotus/Language/Menu/ArchwingFailureSolo" }
					end
				else
					for i = 1, #v28 do
						if #v28 == 1 or v28[i].isLocal then
							return { text = "/Lotus/Language/Menu/ArchwingFailureSolo" }
						end

						return {
							text = "/Lotus/Language/Menu/ArchwingFailureSquad",
							player = v28[i].name
						}
					end
				end
			end

			if string.find(ternary, module2.HARD_MODE_TAG) and not module2.HasUnlockedHardMode() then
				return {
					text = Localize("/Lotus/Language/Labels/SteelPathRequired", nil)
				}
			end

			v30 = fn3(mission.requiredItems, mission.requiredItemCounts)

			if v30 then
				if
					not __wf_atom_7e8ad928(_T.RequiredQuestItemsTransmission)
					and string.find(tostring(mission.goalTag), "Quest")
				then
					module2.CreateHudlessTransmission(_T.RequiredQuestItemsTransmission)
				end

				return v30
			else
				if not __wf_atom_7e8ad928(mission.exclusiveWeapon) then
					v31 = gMatchingService:__wf_atom_bb46d8b6()
					v32 = mission.exclusiveWeapon:IsA(__wf_atom_77e05d3b)

					if __wf_atom_7e8ad928(v31) or #v31 <= 1 or p3 then
						v33 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765()
						v34 = { 1, 2, 3 }
						count = 0
						v35 = false

						for i = 1, #v34 do
							v36 = v33:__wf_atom_ed5c034d(0, v34[i])

							if __wf_atom_7e8ad928(v36.mItemType) then
								count += 1
							elseif
								v36.mItemType:IsA(mission.exclusiveWeapon)
								or v32 and v36.mItemType:IsA(__wf_atom_d560b05c)
							then
								v35 = true
							end
						end

						if not v35 then
							return {
								text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequired",
								ITEM = Localize(tostring(Resource(mission.exclusiveWeapon):__wf_atom_014a76a2()), false)
							}
						end
					else
						for i = 1, #v31 do
							decoded2 = cjson.decode(v31[i].loadout)
							v37 = { decoded2.NORMAL[2], decoded2.NORMAL[3], decoded2.NORMAL[4] }
							count2 = 0
							v38 = false

							for j = 1, #v37 do
								if __wf_atom_7e8ad928(v37[j]) or __wf_atom_7e8ad928(v37[j].ItemType) then
									count2 += 1
								else
									v39 = WeakResource(v37[j].ItemType)

									if __wf_atom_7e8ad928(v39) then
										count2 += 1
									elseif v39:IsA(mission.exclusiveWeapon) or v32 and v39:IsA(__wf_atom_d560b05c) then
										v38 = true
									end
								end
							end

							if v38 then
								continue
							end

							v40 = Localize(tostring(Resource(mission.exclusiveWeapon):__wf_atom_014a76a2()), false)

							if #v31 == 1 or v31[i].isLocal then
								return {
									text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequired",
									ITEM = v40
								}
							end

							return {
								text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequiredSquad",
								player = v31[i].name,
								ITEM = v40
							}
						end
					end
				end

				if mission.masteryReq ~= nil and mission.masteryReq > 0 then
					v41 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
					v42 = string.find(string.lower(ternary), "scenario") ~= nil

					if v41:__wf_atom_a04e4a53() >= mission.masteryReq then
						v43 = true
					else
						v43 = not v42
							and not __wf_atom_7e8ad928(mission.gameRules)
							and mission.gameRules:IsA(__wf_atom_e714d8ac)

						if v43 then
							if v41:__wf_atom_651b839e() > 0 then
								v43 = true
							else
								v43 = v41:__wf_atom_74a5c96e()

								if not v43 then
									if v13 == "TradeHUB1" then
										v43 = gGameData:__wf_atom_edca9dbf() > 0
									else
										v43 = false
									end
								end
							end
						end
					end

					if not v43 then
						return {
							text = Localize("/Lotus/Language/Game/MissionMasteryRequired", {
								RANK = mission.masteryReq
							})
						}
					end
				end

				if mission.maxSuitReq then
					v44 = gMatchingService:__wf_atom_bb46d8b6()

					if __wf_atom_7e8ad928(v44) or #v44 <= 1 or p3 then
						v45 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765():__wf_atom_ed5c034d(
							0,
							0
						)
						v46 = not __wf_atom_7e8ad928(v45)
							and __wf_atom_c67f9605:__wf_atom_b4a75eaa(v45.mXP, v45.mItemType) >= __wf_atom_c67f9605:__wf_atom_a1680b24(v45.mItemType)

						if not v46 and gGameData:__wf_atom_a04e4a53() >= 30 and not __wf_atom_7e8ad928(v45) then
							if v45.mPolarized == nil then
								v46 = false
							else
								v46 = v45.mPolarized > 0
							end
						end

						if not v46 then
							return { text = "/Lotus/Language/Menu/MissionMaxSuitRequired" }
						end
					else
						for i = 1, #v44 do
							decoded3 = cjson.decode(v44[i].loadout)
							v47 = decoded3.NORMAL[1]
							v48 = not __wf_atom_7e8ad928(v47)
								and v47.Level >= __wf_atom_c67f9605:__wf_atom_a1680b24(nil)

							if not v48 and decoded3.PlayerLevel and decoded3.PlayerLevel >= 30 then
								if v47.Polarized == nil then
									v48 = false
								else
									v48 = v47.Polarized > 0
								end
							end

							if v48 then
								continue
							end

							if #v44 == 1 or v44[i].isLocal then
								return { text = "/Lotus/Language/Menu/MissionMaxSuitRequired" }
							end

							return {
								text = "/Lotus/Language/Menu/MissionMaxSuitRequiredSquad",
								player = v44[i].name
							}
						end
					end
				end

				if _T.CachedNodesPendingDestruction and _T.CachedNodesPendingDestruction[v13] then
					v49 = _T.CachedNodesPendingDestruction[v13]

					if v49.shouldLock and Engine.__wf_atom_db2b0cee(v49.lockTime) < 60 then
						return {
							text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
						}
					end
				end

				if not __wf_atom_7e8ad928(mission.gameRules) and mission.gameRules:IsA(v4) then
					v50 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
					_ = not v50:__wf_atom_51dd1b95(v5).mInitiated
					v52 = v50:__wf_atom_baf71316()

					if __wf_atom_7e8ad928(v52) or #v52 == 0 then
						return {
							text = Localize("/Lotus/Language/Game/ConclaveLoadoutRequired", nil)
						}
					end
				end

				if mission.missionType == 18 and mission.nightmare then
					v53 = gMatchingService:__wf_atom_bb46d8b6()
					v54 = {}

					for i = 1, #v53 do
						v55 = { cjson.decode(v53[i].loadout).NORMAL[1] }

						for j = 1, #v55 do
							v56 = v55[j]

							if __wf_atom_7e8ad928(v56) or __wf_atom_7e8ad928(v56.ItemType) then
								continue
							end

							itemType = v56.ItemType
							v57 = WeakResource(v56.ItemType)

							while not __wf_atom_7e8ad928(v57) and v57 ~= v6 do
								itemType = v57:__wf_atom_5b41f63b()
								v57 = v57:__wf_atom_2ad5cd23()
							end

							if v54[itemType] then
								v54[itemType] += 1
							else
								v54[itemType] = 1
							end

							if v54[itemType] > 2 then
								return {
									text = "/Lotus/Language/Menu/NightmareRaidSuitConditionFail",
									nil
								}
							end
						end
					end
				end

				if not (__wf_atom_7e8ad928(mission.questReq) or module2.HasCompletedQuest(mission.questReq)) then
					v58 = true
					text = "/Lotus/Language/Game/MissionQuestRequired"

					if
						__wf_atom_7e8ad928(mission.gameRules)
						or not mission.gameRules:IsA(__wf_atom_e714d8ac)
						or __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest() ~= mission.questReq
					then
						if mission.questReq == WeakResource("/Lotus/Types/Keys/SolarisQuest/SolarisQuestKeyChain") then
							if mission.jobId == "" then
								v60, v61 = module2.GetActiveQuest(gGameData)

								if v60 == WeakResource("/Lotus/Types/Keys/NewWarQuest/NewWarQuestKeyChain") then
									v58 = false
								end
							else
								v58 = false
							end
						elseif
							mission.questReq == WeakResource("/Lotus/Types/Keys/InfestedMicroplanetQuest/InfestedMicroplanetQuestKeyChain")
							and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest() == mission.questReq
						then
							v58 = false
						end
					else
						if not _T.ActiveQuestLoaded then
							_T.SpotLoadedQuest = Resource(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest())
							_T.ActiveQuestLoaded = true
						end

						v62, v63, v64 = module2.GetActiveQuest(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())
						v58 = v63 < 3
						text = "/Lotus/Language/Menu/MissionLocationUnavailable"
					end

					if v58 then
						v65 = Resource(mission.questReq)
						return {
							text = text,
							ITEM = Localize(tostring(v65:__wf_atom_014a76a2()), nil)
						}
					end
				end

				if not __wf_atom_7e8ad928(mission.miscItemFee.mItemType) and mission.miscItemFee.mItemCount > 0 then
					v66 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():__wf_atom_c84817dd()
					mItemType = mission.miscItemFee.mItemType
					mItemCount = 0

					for i = 1, #v66 do
						if not v66[i].mItemType:IsA(mItemType) then
							continue
						end

						mItemCount = v66[i].mItemCount
						break
					end

					if mItemCount < mission.miscItemFee.mItemCount then
						v67 = Resource(mission.miscItemFee.mItemType)
						v68 = Localize(tostring(v67:__wf_atom_014a76a2()), false)
						text2 = Localize("/Lotus/Language/Game/MissionMiscItemRequired", {
							COUNT = mission.miscItemFee.mItemCount,
							ITEM = v68
						})

						if v67:IsA(v8) then
							text2 ..= "\r\n\r\n" .. Localize("/Lotus/Language/Episodes/AntiSerumInjectorReq", {
								COUNT = mission.miscItemFee.mItemCount,
								ITEM = v68
							})
						end

						return { text = text2 }
					end
				end

				if _T.LockedGoalList and _T.LockedGoalList[v13] then
					return {
						text = "/Lotus/Language/Menu/SocialOverlay_EventMissionLocked",
						nil
					}
				end

				v70 = mission:__wf_atom_b984b7fc()

				if
					#v70 > 0
					and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_7050e489() < v70[1].mCreditsFee
				then
					return {
						text = "/Lotus/Language/Menu/ArenaInsuffMinCredits",
						nil
					}
				end

				v71 = Symbol(v13)

				if _T.CachedConstructionProjects then
					for k, cachedConstructionProject in pairs(_T.CachedConstructionProjects) do
						if
							v71 == cachedConstructionProject.rebuildNode and cachedConstructionProject.progress ~= 0
							or v71 == cachedConstructionProject.info.mNode
							and (cachedConstructionProject.progress == 0 or cachedConstructionProject.progress == 1 and v12 == "HUB" or cachedConstructionProject.progress == 2 and v12 == "Event")
						then
							return {
								text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
							}
						end
					end
				end

				if mission and string.find(tostring(mission.goalTag), "Nightwave") then
					v72 = Symbol("RadioLegionSyndicate")
					v73 = gGameData:__wf_atom_e173a80e()
					mTitle = 0

					for k, v79 in pairs(v73) do
						if v79.mTag ~= v72 then
							continue
						end

						mTitle = v79.mTitle
						break
					end

					if mTitle < 5 then
						return {
							text = Localize("/Lotus/Language/Alerts/NightwaveAlertReq", {
								TITLE = 5
							})
						}
					end
				end

				if
					string.find(string.lower(ternary), "scenario")
					and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))
				then
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_b2644498()
				end

				v74 = v13 == "CrewBattleNode557" and 0 or v13 == "CrewBattleNode558" and 1 or nil

				if not v74 then
					return nil
				end

				v75 = gGameData:__wf_atom_e3602b99()
				v76 = false

				if v75:IsActive() and v75.mWeakened then
					v77 = Resource(v75.mManifest)
					v76 = not __wf_atom_7e8ad928(v77) and v77:__wf_atom_e93896ba() == v74 or false
				end

				if v76 then
					return nil
				end

				if v74 == 0 then
					return { text = "/Lotus/Language/Nemesis/MissionGrineerNemesisRequired" }
				elseif v74 == 1 then
					return { text = "/Lotus/Language/Nemesis/MissionCorpusNemesisRequired" }
				end

				return nil
			end
		else
			if __wf_atom_7e8ad928(mission) then
				if
					_T.CachedAlerts == nil
					or not (_T.CachedAlerts[v13] and _T.CachedAlerts[v13].mVisible and string.find(ternary, module2.ALERT_TAG))
				then
					if _G.CachedGoalInfo[v13] and string.find(ternary, module2.EVENT_TAG) then
						mission = _G.CachedGoalInfo[v13].mMissionInfo:Copy()

						if mission.goalTag == EMPTY_SYMBOL then
							mission.goalTag = _G.CachedGoalInfo[v13].mTag
						end
					elseif
						_T.CachedSyndicateMissions == nil
						or not (_T.CachedSyndicateMissions[v13] and _T.CachedSyndicateMissions[v13].mVisible and string.find(ternary, module2.SYNDICATE_MISSION_TAG))
					then
						if _T.CachedSortieMissions == nil or not (_T.CachedSortieMissions[v13] and v11) then
							if
								_T.CachedActiveMissions == nil
								or not (_T.CachedActiveMissions[v13] and string.find(ternary, module2.ACTIVE_MISSION_TAG))
							then
								if
									_T.CachedInvasionInfo == nil
									or not (_T.CachedInvasionInfo[v13] and string.find(ternary, module2.INVASION_ATTACKER_TAG))
								then
									if
										_T.CachedInvasionInfo == nil
										or not (_T.CachedInvasionInfo[v13] and string.find(ternary, module2.INVASION_DEFENDER_TAG))
									then
										if
											_T.CachedEliteAlertMissions == nil
											or not (_T.CachedEliteAlertMissions[v13] and string.find(ternary, module2.ELITE_ALERT_TAG))
										then
											if
												_T.CachedHardModeDailyMissions == nil
												or not (_T.CachedHardModeDailyMissions[v13] and string.find(ternary, module2.HARD_DAILY_TAG))
											then
												if string.find(ternary, module2.KEY_TAG) then
													v14 = string.sub(ternary, 1, v10 - 1)
													Type(v14)
													v15 = Resource(v14)

													if not __wf_atom_7e8ad928(v15) then
														mission = v15:__wf_atom_72fc675e()
														v9 = string.find(v13, "ArchwingQuest/MissionFive") ~= nil
													end
												else
													if not __wf_atom_7e8ad928(gGameRules) then
														if gGameRules:IsA(__wf_atom_e714d8ac) or fn() then
															starChart = gGameRules:__wf_atom_aaa23ad1()
														else
															starChart = gGameRules:GetStarChart()
														end
													end

													if __wf_atom_7e8ad928(starChart) then
														return nil
													end

													mission = starChart:BuildMissionForLocation(Symbol(v13))

													if
														_T.gPendingMission ~= nil
														and #_T.gPendingMission.requiredItems > 0
													then
														mission.requiredItems = _T.gPendingMission.requiredItems
													end
												end
											else
												mission = _T.CachedHardModeDailyMissions[v13].mission
											end
										else
											mission = _T.CachedEliteAlertMissions[v13].mMissionInfo
										end
									else
										mission = _T.CachedInvasionInfo[v13].mDefenderMissionInfo
									end
								else
									mission = _T.CachedInvasionInfo[v13].mAttackerMissionInfo
								end
							else
								mission = _T.CachedActiveMissions[v13].mMissionInfo
							end
						else
							mission = _T.CachedSortieMissions[v13].mMissionInfo
						end
					else
						mission = _T.CachedSyndicateMissions[v13].mMissionInfo
					end
				else
					mission = _T.CachedAlerts[v13].mAlertInfo.mMissionInfo
				end
			elseif not __wf_atom_7e8ad928(mission.levelKeyName) then
				if string.find(tostring(mission.levelKeyName:__wf_atom_5b41f63b()), "ArchwingQuest/MissionFive") == nil then
					v9 = false
				else
					v9 = true
				end
			end

			if module2.IsOverOmegaLimit() then
				if v11 then
					return {
						text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictSortie", nil)
					}
				end

				missionReward = mission.missionReward

				if not __wf_atom_7e8ad928(missionReward) then
					items = missionReward.items

					for i = 1, #items do
						item = items[i]:GetItem()

						if not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_16cdad3a) then
							return {
								text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictMission", nil)
							}
						end
					end
				end

				missionRewardExtra = mission.missionRewardExtra

				if not __wf_atom_7e8ad928(missionRewardExtra) then
					items2 = missionRewardExtra.items

					for i = 1, #items2 do
						item2 = items2[i]:GetItem()

						if not __wf_atom_7e8ad928(item2) and item2:IsA(__wf_atom_16cdad3a) then
							return {
								text = Localize("/Lotus/Language/Menu/OmegaLimit_RestrictMission", nil)
							}
						end
					end
				end
			end

			if Engine.__wf_atom_84bb79c2() then
				v16 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if not __wf_atom_7e8ad928(v16) then
					v17 = v16:__wf_atom_9be88b01()

					if __wf_atom_7e8ad928(v17) or not v17:__wf_atom_df64c481() then
						level = gRegion:__wf_atom_ade7f08f().level

						if not __wf_atom_c67f9605:__wf_atom_172c2f5c(level) then
							return {
								text = Localize("/Lotus/Language/Menu/SocialOverlay_SessionJoinFromTutorial", nil)
							}
						end
					end
				end
			end

			if
				mission
				and mission.conclaveRange ~= nil
				and (mission.conclaveRange.minValue ~= 0 or mission.conclaveRange.maxValue ~= 0)
			then
				if
					p2
					or gMatchingService:__wf_atom_1b24a1bb()
					or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
				then
					v18 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

					if not __wf_atom_7e8ad928(v18) then
						v19 = v18:__wf_atom_9be88b01():__wf_atom_a4299765()

						if mission.conclaveRangePerItem then
							for i = 0, 6 - 1 do
								v20 = v19:__wf_atom_4a5fdb87(0, i)

								if mission.conclaveRange.maxValue < v20 then
									v21 = Resource(v19:__wf_atom_ed5c034d(0, i).mItemType)
									v22 = Localize(tostring(v21:__wf_atom_014a76a2()), false)
									return {
										text = "/Lotus/Language/Menu/PvpValueFailureSoloItem",
										value = v20,
										MIN = mission.conclaveRange.minValue,
										MAX = mission.conclaveRange.maxValue,
										ITEM = v22
									}
								else
									v23 = v19:__wf_atom_4a5fdb87(1, i)

									if mission.conclaveRange.maxValue < v23 then
										v24 = Resource(v19:__wf_atom_ed5c034d(1, i).mItemType)
										v25 = Localize(tostring(v24:__wf_atom_014a76a2()), false)
										return {
											text = "/Lotus/Language/Menu/PvpValueFailureSoloItem",
											value = v23,
											MIN = mission.conclaveRange.minValue,
											MAX = mission.conclaveRange.maxValue,
											ITEM = v25
										}
									end
								end
							end
						else
							v26 = v19:__wf_atom_698cee43()
							print("Local PVP value: " .. tostring(v26))

							if v26 < mission.conclaveRange.minValue or mission.conclaveRange.maxValue < v26 then
								return {
									text = "/Lotus/Language/Menu/PvpValueFailureSolo",
									value = v26,
									MIN = mission.conclaveRange.minValue,
									MAX = mission.conclaveRange.maxValue
								}
							end
						end
					end
				end

				v27 = gMatchingService:__wf_atom_bb46d8b6()

				for i = 1, #v27 do
					decoded = cjson.decode(v27[i].loadout)
					pvpValue = decoded.PvpValue

					if mission.conclaveRangePerItem then
						pvpValue = decoded.PvpValueItemMax
					end

					if not (pvpValue < mission.conclaveRange.minValue or mission.conclaveRange.maxValue < pvpValue) then
						continue
					end

					print("PVP value " .. tostring(pvpValue) .. "[" .. tostring(mission.conclaveRange.minValue) .. " - " .. tostring(mission.conclaveRange.maxValue) .. "]")

					if #v27 == 1 or v27[i].isLocal then
						return {
							text = "/Lotus/Language/Menu/PvpValueFailureSolo",
							value = pvpValue,
							MIN = mission.conclaveRange.minValue,
							MAX = mission.conclaveRange.maxValue
						}
					end

					if not p3 then
						return {
							text = "/Lotus/Language/Menu/PvpValueFailureSquad",
							value = pvpValue,
							MIN = mission.conclaveRange.minValue,
							MAX = mission.conclaveRange.maxValue,
							player = v27[i].name
						}
					end
				end
			end

			if mission and mission.archwingRequired then
				v28 = gMatchingService:__wf_atom_bb46d8b6()

				if __wf_atom_7e8ad928(v28) or #v28 <= 1 or p3 then
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765()
					v29 = not (__wf_atom_7e8ad928((nil).mItemType) or __wf_atom_7e8ad928((nil).mItemType) or __wf_atom_7e8ad928((nil).mItemType))

					if not (v9 and v29) then
						return { text = "/Lotus/Language/Menu/ArchwingFailureSolo" }
					end
				else
					for i = 1, #v28 do
						if #v28 == 1 or v28[i].isLocal then
							return { text = "/Lotus/Language/Menu/ArchwingFailureSolo" }
						end

						return {
							text = "/Lotus/Language/Menu/ArchwingFailureSquad",
							player = v28[i].name
						}
					end
				end
			end

			if string.find(ternary, module2.HARD_MODE_TAG) and not module2.HasUnlockedHardMode() then
				return {
					text = Localize("/Lotus/Language/Labels/SteelPathRequired", nil)
				}
			end

			v30 = fn3(mission.requiredItems, mission.requiredItemCounts)

			if v30 then
				if
					not __wf_atom_7e8ad928(_T.RequiredQuestItemsTransmission)
					and string.find(tostring(mission.goalTag), "Quest")
				then
					module2.CreateHudlessTransmission(_T.RequiredQuestItemsTransmission)
				end

				return v30
			else
				if not __wf_atom_7e8ad928(mission.exclusiveWeapon) then
					v31 = gMatchingService:__wf_atom_bb46d8b6()
					v32 = mission.exclusiveWeapon:IsA(__wf_atom_77e05d3b)

					if __wf_atom_7e8ad928(v31) or #v31 <= 1 or p3 then
						v33 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765()
						v34 = { 1, 2, 3 }
						count = 0
						v35 = false

						for i = 1, #v34 do
							v36 = v33:__wf_atom_ed5c034d(0, v34[i])

							if __wf_atom_7e8ad928(v36.mItemType) then
								count += 1
							elseif
								v36.mItemType:IsA(mission.exclusiveWeapon)
								or v32 and v36.mItemType:IsA(__wf_atom_d560b05c)
							then
								v35 = true
							end
						end

						if not v35 then
							return {
								text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequired",
								ITEM = Localize(tostring(Resource(mission.exclusiveWeapon):__wf_atom_014a76a2()), false)
							}
						end
					else
						for i = 1, #v31 do
							decoded2 = cjson.decode(v31[i].loadout)
							v37 = { decoded2.NORMAL[2], decoded2.NORMAL[3], decoded2.NORMAL[4] }
							count2 = 0
							v38 = false

							for j = 1, #v37 do
								if __wf_atom_7e8ad928(v37[j]) or __wf_atom_7e8ad928(v37[j].ItemType) then
									count2 += 1
								else
									v39 = WeakResource(v37[j].ItemType)

									if __wf_atom_7e8ad928(v39) then
										count2 += 1
									elseif v39:IsA(mission.exclusiveWeapon) or v32 and v39:IsA(__wf_atom_d560b05c) then
										v38 = true
									end
								end
							end

							if v38 then
								continue
							end

							v40 = Localize(tostring(Resource(mission.exclusiveWeapon):__wf_atom_014a76a2()), false)

							if #v31 == 1 or v31[i].isLocal then
								return {
									text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequired",
									ITEM = v40
								}
							end

							return {
								text = "/Lotus/Language/Menu/MissionExclusiveWeaponRequiredSquad",
								player = v31[i].name,
								ITEM = v40
							}
						end
					end
				end

				if mission.masteryReq ~= nil and mission.masteryReq > 0 then
					v41 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
					v42 = string.find(string.lower(ternary), "scenario") ~= nil

					if v41:__wf_atom_a04e4a53() >= mission.masteryReq then
						v43 = true
					else
						v43 = not v42
							and not __wf_atom_7e8ad928(mission.gameRules)
							and mission.gameRules:IsA(__wf_atom_e714d8ac)

						if v43 then
							if v41:__wf_atom_651b839e() > 0 then
								v43 = true
							else
								v43 = v41:__wf_atom_74a5c96e()

								if not v43 then
									if v13 == "TradeHUB1" then
										v43 = gGameData:__wf_atom_edca9dbf() > 0
									else
										v43 = false
									end
								end
							end
						end
					end

					if not v43 then
						return {
							text = Localize("/Lotus/Language/Game/MissionMasteryRequired", {
								RANK = mission.masteryReq
							})
						}
					end
				end

				if mission.maxSuitReq then
					v44 = gMatchingService:__wf_atom_bb46d8b6()

					if __wf_atom_7e8ad928(v44) or #v44 <= 1 or p3 then
						v45 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_a4299765():__wf_atom_ed5c034d(
							0,
							0
						)
						v46 = not __wf_atom_7e8ad928(v45)
							and __wf_atom_c67f9605:__wf_atom_b4a75eaa(v45.mXP, v45.mItemType) >= __wf_atom_c67f9605:__wf_atom_a1680b24(v45.mItemType)

						if not v46 and gGameData:__wf_atom_a04e4a53() >= 30 and not __wf_atom_7e8ad928(v45) then
							if v45.mPolarized == nil then
								v46 = false
							else
								v46 = v45.mPolarized > 0
							end
						end

						if not v46 then
							return { text = "/Lotus/Language/Menu/MissionMaxSuitRequired" }
						end
					else
						for i = 1, #v44 do
							decoded3 = cjson.decode(v44[i].loadout)
							v47 = decoded3.NORMAL[1]
							v48 = not __wf_atom_7e8ad928(v47)
								and v47.Level >= __wf_atom_c67f9605:__wf_atom_a1680b24(nil)

							if not v48 and decoded3.PlayerLevel and decoded3.PlayerLevel >= 30 then
								if v47.Polarized == nil then
									v48 = false
								else
									v48 = v47.Polarized > 0
								end
							end

							if v48 then
								continue
							end

							if #v44 == 1 or v44[i].isLocal then
								return { text = "/Lotus/Language/Menu/MissionMaxSuitRequired" }
							end

							return {
								text = "/Lotus/Language/Menu/MissionMaxSuitRequiredSquad",
								player = v44[i].name
							}
						end
					end
				end

				if _T.CachedNodesPendingDestruction and _T.CachedNodesPendingDestruction[v13] then
					v49 = _T.CachedNodesPendingDestruction[v13]

					if v49.shouldLock and Engine.__wf_atom_db2b0cee(v49.lockTime) < 60 then
						return {
							text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
						}
					end
				end

				if not __wf_atom_7e8ad928(mission.gameRules) and mission.gameRules:IsA(v4) then
					v50 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
					_ = not v50:__wf_atom_51dd1b95(v5).mInitiated
					v52 = v50:__wf_atom_baf71316()

					if __wf_atom_7e8ad928(v52) or #v52 == 0 then
						return {
							text = Localize("/Lotus/Language/Game/ConclaveLoadoutRequired", nil)
						}
					end
				end

				if mission.missionType == 18 and mission.nightmare then
					v53 = gMatchingService:__wf_atom_bb46d8b6()
					v54 = {}

					for i = 1, #v53 do
						v55 = { cjson.decode(v53[i].loadout).NORMAL[1] }

						for j = 1, #v55 do
							v56 = v55[j]

							if __wf_atom_7e8ad928(v56) or __wf_atom_7e8ad928(v56.ItemType) then
								continue
							end

							itemType = v56.ItemType
							v57 = WeakResource(v56.ItemType)

							while not __wf_atom_7e8ad928(v57) and v57 ~= v6 do
								itemType = v57:__wf_atom_5b41f63b()
								v57 = v57:__wf_atom_2ad5cd23()
							end

							if v54[itemType] then
								v54[itemType] += 1
							else
								v54[itemType] = 1
							end

							if v54[itemType] > 2 then
								return {
									text = "/Lotus/Language/Menu/NightmareRaidSuitConditionFail",
									nil
								}
							end
						end
					end
				end

				if not (__wf_atom_7e8ad928(mission.questReq) or module2.HasCompletedQuest(mission.questReq)) then
					v58 = true
					text = "/Lotus/Language/Game/MissionQuestRequired"

					if
						__wf_atom_7e8ad928(mission.gameRules)
						or not mission.gameRules:IsA(__wf_atom_e714d8ac)
						or __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest() ~= mission.questReq
					then
						if mission.questReq == WeakResource("/Lotus/Types/Keys/SolarisQuest/SolarisQuestKeyChain") then
							if mission.jobId == "" then
								v60, v61 = module2.GetActiveQuest(gGameData)

								if v60 == WeakResource("/Lotus/Types/Keys/NewWarQuest/NewWarQuestKeyChain") then
									v58 = false
								end
							else
								v58 = false
							end
						elseif
							mission.questReq == WeakResource("/Lotus/Types/Keys/InfestedMicroplanetQuest/InfestedMicroplanetQuestKeyChain")
							and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest() == mission.questReq
						then
							v58 = false
						end
					else
						if not _T.ActiveQuestLoaded then
							_T.SpotLoadedQuest = Resource(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():GetActiveQuest())
							_T.ActiveQuestLoaded = true
						end

						v62, v63, v64 = module2.GetActiveQuest(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())
						v58 = v63 < 3
						text = "/Lotus/Language/Menu/MissionLocationUnavailable"
					end

					if v58 then
						v65 = Resource(mission.questReq)
						return {
							text = text,
							ITEM = Localize(tostring(v65:__wf_atom_014a76a2()), nil)
						}
					end
				end

				if not __wf_atom_7e8ad928(mission.miscItemFee.mItemType) and mission.miscItemFee.mItemCount > 0 then
					v66 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory():__wf_atom_c84817dd()
					mItemType = mission.miscItemFee.mItemType
					mItemCount = 0

					for i = 1, #v66 do
						if not v66[i].mItemType:IsA(mItemType) then
							continue
						end

						mItemCount = v66[i].mItemCount
						break
					end

					if mItemCount < mission.miscItemFee.mItemCount then
						v67 = Resource(mission.miscItemFee.mItemType)
						v68 = Localize(tostring(v67:__wf_atom_014a76a2()), false)
						text2 = Localize("/Lotus/Language/Game/MissionMiscItemRequired", {
							COUNT = mission.miscItemFee.mItemCount,
							ITEM = v68
						})

						if v67:IsA(v8) then
							text2 ..= "\r\n\r\n" .. Localize("/Lotus/Language/Episodes/AntiSerumInjectorReq", {
								COUNT = mission.miscItemFee.mItemCount,
								ITEM = v68
							})
						end

						return { text = text2 }
					end
				end

				if _T.LockedGoalList and _T.LockedGoalList[v13] then
					return {
						text = "/Lotus/Language/Menu/SocialOverlay_EventMissionLocked",
						nil
					}
				end

				v70 = mission:__wf_atom_b984b7fc()

				if
					#v70 > 0
					and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_7050e489() < v70[1].mCreditsFee
				then
					return {
						text = "/Lotus/Language/Menu/ArenaInsuffMinCredits",
						nil
					}
				end

				v71 = Symbol(v13)

				if _T.CachedConstructionProjects then
					for k, cachedConstructionProject in pairs(_T.CachedConstructionProjects) do
						if
							v71 == cachedConstructionProject.rebuildNode and cachedConstructionProject.progress ~= 0
							or v71 == cachedConstructionProject.info.mNode
							and (cachedConstructionProject.progress == 0 or cachedConstructionProject.progress == 1 and v12 == "HUB" or cachedConstructionProject.progress == 2 and v12 == "Event")
						then
							return {
								text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
							}
						end
					end
				end

				if mission and string.find(tostring(mission.goalTag), "Nightwave") then
					v72 = Symbol("RadioLegionSyndicate")
					v73 = gGameData:__wf_atom_e173a80e()
					mTitle = 0

					for k, v79 in pairs(v73) do
						if v79.mTag ~= v72 then
							continue
						end

						mTitle = v79.mTitle
						break
					end

					if mTitle < 5 then
						return {
							text = Localize("/Lotus/Language/Alerts/NightwaveAlertReq", {
								TITLE = 5
							})
						}
					end
				end

				if
					string.find(string.lower(ternary), "scenario")
					and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))
				then
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_b2644498()
				end

				v74 = v13 == "CrewBattleNode557" and 0 or v13 == "CrewBattleNode558" and 1 or nil

				if not v74 then
					return nil
				end

				v75 = gGameData:__wf_atom_e3602b99()
				v76 = false

				if v75:IsActive() and v75.mWeakened then
					v77 = Resource(v75.mManifest)
					v76 = not __wf_atom_7e8ad928(v77) and v77:__wf_atom_e93896ba() == v74 or false
				end

				if v76 then
					return nil
				end

				if v74 == 0 then
					return { text = "/Lotus/Language/Nemesis/MissionGrineerNemesisRequired" }
				elseif v74 == 1 then
					return { text = "/Lotus/Language/Nemesis/MissionCorpusNemesisRequired" }
				end

				return nil
			end
		end
	end
end

function CheckConclaveRequirements(p, p2, p3, p4)
	return (fn6(p, p2, p3, p4))
end

local function fn7(data)
	if not data then
		return
	end

	if data.customDialogFunction then
		_T.PendingMissionReqErrorDialog = data.customDialogFunction
	elseif data.text then
		local v9 = Localize(data.text, {
			PLAYER_NAME = data.player,
			VALUE = data.value,
			MIN = data.MIN,
			MAX = data.MAX,
			ITEM = data.ITEM
		})
		module.ShowMessage(v9)
	end
end

function ShowMissionRequirementsError(p)
	fn7(p)
end

function TryLaunchOnslaught(p)
	local ternary = module.Ternary(p, SANCTUARY_ONSLAUGHT_CHALLENGE_NODE, SANCTUARY_ONSLAUGHT_NODE)
	local starChart

	if not __wf_atom_7e8ad928(gGameRules) then
		if gGameRules:IsA(__wf_atom_e714d8ac) or fn() then
			starChart = gGameRules:__wf_atom_aaa23ad1()
		else
			starChart = gGameRules:GetStarChart()
		end
	end

	local v9 = fn6(ternary, true, (starChart:BuildMissionForLocation(ternary)))

	if v9 ~= nil then
		fn7(v9)
		return
	end

	local v10 = { name = tostring(ternary), quest = "", difficulty = nil }
	local encoded = cjson.encode(v10)
	gMatchingService:SendSquadMission(encoded)
end

function TryLaunchFrameFighter()
	local starChart

	if not __wf_atom_7e8ad928(gGameRules) then
		if gGameRules:IsA(__wf_atom_e714d8ac) or fn() then
			starChart = gGameRules:__wf_atom_aaa23ad1()
		else
			starChart = gGameRules:GetStarChart()
		end
	end

	local missionForLocation = starChart:BuildMissionForLocation(FRAME_FIGHTER_NODE)
	local v9 = fn6(FRAME_FIGHTER_NODE, true, missionForLocation)

	if v9 == nil then
		local v10 = { name = tostring(FRAME_FIGHTER_NODE), quest = "", difficulty = nil }
		local encoded = cjson.encode(v10)
		gMatchingService:SendSquadMission(encoded)
	else
		local v10 = Localize(v9.text, {
			PLAYER_NAME = v9.player,
			VALUE = v9.value,
			MIN = v9.MIN,
			MAX = v9.MAX,
			ITEM = v9.ITEM
		})
		module.ShowMessage(v10)
	end
end