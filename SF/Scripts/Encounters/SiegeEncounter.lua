local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.NightFoldLib")
require("EE.Interface.Utilities")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("Lotus.Scripts.Libs.AudioLib")
local module7 = require("SF.Scripts.Libs.SparrowLib")
local module8 = require("SF.Scripts.Libs.TaleLib")
local module9 = require("SF.Scripts.Libs.StatsLib")
local module10 = require("SF.Scripts.Libs.ChallengeLib")
local v = WeakResource("/SF/Types/Player/Ghost/SfGhostAvatar")
local v2 = WeakResource("/SF/Types/Player/Ghost/SfSparrowGhostAvatar")
local v3 = Symbol("MT_SUBBOSS")
local v4 = Symbol("Neutral")
local v5 = Symbol("TENNO")
local v6 = Symbol("CollectorCallback")
local __wf_atom_0a6a5887s = {}
local v7 = 1
local v8 = 1
local v9 = nil
local siegeTrigger2 = nil
local v10 = nil
local v11 = ""
local v12 = {}
local v13 = {}
local count = 0
local abandonTime2 = 0
local flag = false
local v14 = nil
local v15 = {}
local count2 = 0
local v16 = 0
local v17 = {
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/SiegeArtifact"),
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/SiegeTacticalMap"),
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/SiegeEscapeBalloon")
}
local v18 = {
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/OdeOptrix"),
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/SiegeOdeSignals"),
	Type("/SF/Types/Game/Encounters/EncounterScriptPlugins/SpawnMineLayingOdeDrone")
}

local function fn(instance, p)
	if __wf_atom_7e8ad928(instance) then
		return false
	end

	local position

	if module2.IsInNightFold(instance) then
		position = instance:__wf_atom_4c2e0189()
	else
		position = instance:GetPosition()
	end

	local v19 = __wf_atom_7e8ad928(p) or p

	if __wf_atom_7e8ad928(position) then
		return false
	end

	if instance:IsA(__wf_atom_9e85eea2) or not v19 then
		return siegeTrigger2:__wf_atom_1eaf335c(position)
	end

	return Distance(siegeTrigger2:GetPosition(), position) < abandonDistance
end

local function fn2()
	v12 = gRegion:__wf_atom_ef7900cf()

	for _, v19 in ipairs(v12) do
		if v19:IsKilled() or v19:IsA(v) or v19:IsA(v2) then
			continue
		end

		local v20 = nil
		local flag2 = true

		for i, v21 in ipairs(v13) do
			if v21 ~= v19 then
				continue
			end

			v20 = i
			flag2 = false
			break
		end

		if flag2 then
			v20 = 0
		end

		if not (v20 == 0 and fn(v19)) then
			continue
		end

		table.insert(v13, v19)
		__wf_atom_55142dd4(v19, "OnKilled")
	end
end

local function fn3(p)
	if #v12 == 0 then
		return true
	end

	local v19 = __wf_atom_7e8ad928(p) or p

	for _, v20 in ipairs(v12) do
		if __wf_atom_7e8ad928(v20) or v20:IsKilled() or v20:IsA(v2) or v20:IsA(v) then
			return true
		end

		if fn(v20, v19) then
			return true
		end
	end

	return false
end

local function fn4()
	v9 = module2.WaitForAiDir()
	local flag2 = true
	__wf_atom_0a6a5887s = {}

	for _, v19 in siegeHintTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v19)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			flag2 = false
			break
		else
			table.insert(__wf_atom_0a6a5887s, __wf_atom_0a6a5887)
			local __wf_atom_e370bfde = __wf_atom_0a6a5887:__wf_atom_e370bfde()
			local __wf_atom_5b6b447d = __wf_atom_0a6a5887:__wf_atom_5b6b447d()
			local flag3 = false

			for _, v20 in ipairs(__wf_atom_e370bfde) do
				if v20 ~= v3 then
					continue
				end

				flag3 = true
				break
			end

			if flag3 then
				if __wf_atom_5b6b447d == EMPTY_SYMBOL then
					if not v9:PrimeMissionOnHint(v3, __wf_atom_0a6a5887) then
						flag2 = false
						break
					end
				elseif __wf_atom_5b6b447d ~= v3 then
					flag2 = false
				end
			else
				flag2 = false
				break
			end
		end
	end

	if flag2 then
		return flag2
	end

	for _, v19 in ipairs(__wf_atom_0a6a5887s) do
		if __wf_atom_7e8ad928(v19) or v19:__wf_atom_5b6b447d() ~= v3 then
			continue
		end

		v19:__wf_atom_75628d88(EMPTY_SYMBOL)
	end
end

local function fn5()
	if __wf_atom_7e8ad928(soulModeAttachType) then
		return
	end

	for _, v19 in ipairs(v15) do
		if __wf_atom_7e8ad928(v19) then
			continue
		end

		local __wf_atom_be0bea4a = v19:__wf_atom_be0bea4a()

		for _, v20 in ipairs(__wf_atom_be0bea4a) do
			if v20:IsA(soulModeAttachType) then
				v20:Destroy()
			end
		end
	end
end

local function fn6(p, p2)
	if not __wf_atom_7e8ad928(notificationMovie) then
		for _, v19 in ipairs(v13) do
			if __wf_atom_7e8ad928(v19) then
				continue
			end

			local __wf_atom_a96eb2aa = v19:__wf_atom_a96eb2aa()
			module6.EnableNearestTaggedSoundSysVolume(Symbol("SiegeMusic"), false, v19:GetPosition())

			if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				continue
			end

			if p then
				gGameRules:__wf_atom_6680e8ba(
					__wf_atom_a96eb2aa,
					notificationMovie,
					"SiegeEnd",
					{ p2, siegeLocationTitleLoc:c_str(), tostring(6), (tostring(1.5)) },
					6,
					"SiegeEnded",
					true
				)
			else
				gGameRules:__wf_atom_6680e8ba(
					__wf_atom_a96eb2aa,
					notificationMovie,
					"SiegeAbandoned",
					{ siegeLocationTitleLoc:c_str(), tostring(6), (tostring(1.5)) },
					6,
					"SiegeAbandoned",
					true
				)
			end
		end
	end
end

local function fn7(object) -- 5 equivalent calls inferred from this helper
	local name = object:__wf_atom_db682341()

	if __wf_atom_7e8ad928(name) or name == EMPTY_SYMBOL then
		name = object:GetName()
	end

	return name
end

local function fn8(p)
	local jobBoardsInRange = module8.GetJobBoardsInRange(siegeTrigger2:GetPosition(), Range(0, 500), true)
	local v19 = siegeTrigger2
	local v20 = "Siege" .. tostring(fn7(v19)) -- inferred equivalent call

	if not p then
		module8.RemoveFromAllJobBoards(v20)
		return
	end

	local v21 = nil

	local function fn9(object)
		if __wf_atom_7e8ad928(v21) then
			v21 = gRegion:CreateEntity(siegeMarkerType, siegeTrigger2:GetPosition(), __wf_atom_80368bb1)
			object:SetMarker(v21)
			object:SetEnemyLevel(siegeTrigger2)
		end
	end

	local v22 = Localize(siegeLocationTitleLoc:c_str(), false)
	local v23 = string.gsub(Localize("/SF/Language/Objectives/SiegeLongDesc", false), "|LOCATION|", v22)
	module8.AddToJobBoards(
		v20,
		jobBoardsInRange,
		Localize("/SF/Language/Progression/SiegeStarted", false) .. " " .. v22,
		v23,
		siegeMarkerType,
		fn9
	)
end

local function fn9()
	if infamyStandingIncrease > 0 then
		local v19 = -scorePenaltyForAbandon * infamyStandingIncrease
		gGameData:__wf_atom_e7f3cb75(infamySyndicate, v19)
		fn6(false)
		module9.TrackSiegeEnd(siegeLocationTitleLoc, false, v19)
	end

	fn5()
	fn4()
end

local function fn10()
	module4.RegisterPreventNighfoldUsage(true)
	module5.RegisterHideHud(true)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		__wf_atom_c4f78a8f:__wf_atom_aeb02c14(blockMovementInputFilter)
		local nearestTagged = gRegion:FindNearestTagged(Symbol("SiegeBalloon"), __wf_atom_c4f78a8f:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			local motionControl = __wf_atom_c4f78a8f:MotionControl()
			local gameCamera = gRegion:GetGameCamera()
			local v19 = __wf_atom_c4f78a8f:EyePosition() - Vector(0, 0.25, 0)
			local v20 = v19 + __wf_atom_9341614d(Vector(0, 0, -1), gameCamera:__wf_atom_dc309f8a())
			local v21 = __wf_atom_fa8d0177(v20, __wf_atom_f55d6358(v19, nearestTagged:GetPosition(), 0.5))
			local v22 = Vector()
			VectorAdd(
				v22,
				__wf_atom_c4f78a8f:GetPosition(),
				__wf_atom_9341614d(
					Vector(0, 0, -1),
					__wf_atom_fa8d0177(__wf_atom_c4f78a8f:GetPosition(), nearestTagged:GetPosition())
				) * 2
			)
			motionControl:__wf_atom_d327aef9(v22, 0, true, true, v21, 1.75, false, true)
			local v23 = __wf_atom_c4f78a8f:EyePosition() - Vector(0, 0.25, 0)
			local v24 = v22 + Vector(0, 0.5, 0) + __wf_atom_9341614d(
				Vector(1.5, 1, -2),
				Rotation(__wf_atom_fa8d0177(v22, nearestTagged:GetPosition()).heading, 0, 0)
			)
			local v25 = __wf_atom_fa8d0177(v24, __wf_atom_f55d6358(v23, nearestTagged:GetPosition(), 0.5))
			__wf_atom_c4f78a8f:Teleport(__wf_atom_c4f78a8f:GetPosition(), Rotation(v25.heading, 0, 0))
			__wf_atom_c4f78a8f:__wf_atom_f0f9fb38(v25)
			v14 = gRegion:CreateEntity(cameraSpotType, v24, v25)
			__wf_atom_c4f78a8f:CameraControl():__wf_atom_fd14c463(1)
			__wf_atom_c4f78a8f:CameraControl():SetCameraSpot(v14, 0.5)
		end
	end
end

local function fn11()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module6.EnableNearestTaggedSoundSysVolume(Symbol("SiegeMusic"), false, __wf_atom_c4f78a8f:GetPosition())
	local v19 = math.min(maxDeathPenalty, scorePenaltyPerDeath * count)
	local v20 = scorePenaltyForObjectiveFailed * _T.SiegeObjectiveStatus
	local v21 = 1 - v19 - v20
	local v22 = 0
	local v23 = "0"

	if v21 > 0.9 then
		v22 = 2
		v23 = "2"
	elseif v21 > 0.7 then
		v22 = 1
		v23 = "1"
	end

	print("Siege deaths: " .. count)
	print("Siege objective status: " .. _T.SiegeObjectiveStatus)
	print("Siege score: " .. v21 .. ", final tier: " .. v22)
	v16 = infamyStandingIncrease * v21

	if module.IsHardModeActive() then
		v16 += infamyStandingIncrease * hardModeBonus
	end

	if v16 > 0 then
		for _, v24 in ipairs(v13) do
			if __wf_atom_7e8ad928(v24) then
				continue
			end

			local __wf_atom_a96eb2aa = v24:__wf_atom_a96eb2aa()

			if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
				gGameRules:__wf_atom_746fba0c(__wf_atom_a96eb2aa, infamySyndicate, v16)
			end
		end
	end

	module9.TrackSiegeEnd(siegeLocationTitleLoc, true, v16)
	module10.NotifyTagAllPlayers(Symbol("SIEGE_COMPLETE"))
	local name = fn7(siegeTrigger2) -- inferred equivalent call
	gGameData:__wf_atom_a975522c(name, 3600 * siegeResetHours, true, "")
	fn8(false)
	Sleep(2)
	fn6(true, v23)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		local __wf_atom_330f77f5 = __wf_atom_eab484a7:__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			while __wf_atom_330f77f5:__wf_atom_aaf836a8() do
				Sleep(0)
			end
		end
	end

	local v24 = __wf_atom_8d119bab(0, 1)
	local __wf_atom_0b43ffae = rewardManifest:__wf_atom_0b43ffae(v22, v24)

	if __wf_atom_0b43ffae ~= -1 then
		local tieredItem = rewardManifest:GetTieredItem(v22, __wf_atom_0b43ffae)
		local item = tieredItem.mStoreItem:GetItem()
		local v25 = Type(item)

		for _, v26 in ipairs(v13) do
			if __wf_atom_7e8ad928(v26) or __wf_atom_7e8ad928(v25) then
				continue
			end

			for _ = 1, __wf_atom_7e8ad928(tieredItem) and 1 or tieredItem:GetCount() do
				if item:IsA(__wf_atom_a75640c1) then
					local __wf_atom_d2b2176d = v26:__wf_atom_d2b2176d()

					if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
						__wf_atom_d2b2176d:__wf_atom_e7ac08e7(v25, "")
					end
				else
					v26:GiveItem(v25, false)
				end
			end
		end
	end

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		if not __wf_atom_7e8ad928(v14) then
			gRegion:__wf_atom_dd1e4d10(v14)
			local cameraControl = __wf_atom_c4f78a8f:CameraControl()

			if not __wf_atom_7e8ad928(cameraControl) then
				cameraControl:__wf_atom_fd14c463(0)
				cameraControl:SetCameraSpot(nil, 0)
				cameraControl:__wf_atom_fd14c463(1)
			end
		end

		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PlayerProgressCelebrationSiege"), false)
		__wf_atom_c4f78a8f:__wf_atom_cf966a74(blockMovementInputFilter)
	end

	module4.RegisterPreventNighfoldUsage(false)
	module5.RegisterHideHud(false)
	fn5()
end

function PlayerProgressCelebrationSiege(_)
	local v19 = { InfamyDelta = math.round(v16) }

	for _, v20 in ipairs(v13) do
		if __wf_atom_7e8ad928(v20) then
			continue
		end

		local __wf_atom_a96eb2aa = v20:__wf_atom_a96eb2aa()

		if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
			gGameRules:__wf_atom_8085277a(
				__wf_atom_a96eb2aa,
				"/SF/Language/Progression/SiegeCompleted",
				1,
				Symbol("Default"),
				cjson.encode(v19)
			)
		end
	end
end

local function fn12()
	for i = #v15, 1, -1 do
		if __wf_atom_7e8ad928(v15[i]) or v15[i]:IsKilled() then
			table.remove(v15, i)
		end
	end

	for _, v19 in ipairs(__wf_atom_0a6a5887s) do
		local __wf_atom_be637430 = v19:__wf_atom_be637430()

		for _, v20 in ipairs(__wf_atom_be637430) do
			local __wf_atom_50a7d83e = v20:__wf_atom_50a7d83e()

			if
				__wf_atom_7e8ad928(__wf_atom_50a7d83e)
				or __wf_atom_50a7d83e:__wf_atom_e93896ba() == v4
				or __wf_atom_50a7d83e:IsKilled()
			then
				continue
			end

			local v21 = false

			for _, v22 in ipairs(v15) do
				if v22 ~= __wf_atom_50a7d83e then
					continue
				end

				v21 = true
				break
			end

			if v21 then
				continue
			end

			if highlightSiegeEnemies and not __wf_atom_7e8ad928(soulModeAttachType) then
				__wf_atom_50a7d83e:Attach(soulModeAttachType, EMPTY_SYMBOL)
			end

			__wf_atom_55142dd4(__wf_atom_50a7d83e, "OnKilled")
			table.insert(v15, __wf_atom_50a7d83e)
		end
	end

	local __wf_atom_57e5ac18 = gRegion:__wf_atom_57e5ac18()

	for _, v19 in ipairs(__wf_atom_57e5ac18) do
		local __wf_atom_e93896ba = v19:__wf_atom_e93896ba()

		if
			v19:IsKilled()
			or not v19:IsA(__wf_atom_9e85eea2)
			or __wf_atom_e93896ba == v4
			or __wf_atom_e93896ba == v5
		then
			continue
		end

		local v20 = false

		for _, v21 in ipairs(v15) do
			if v21 ~= v19 then
				continue
			end

			v20 = true
			break
		end

		if v20 or not fn(v19) then
			continue
		end

		if highlightSiegeEnemies and not __wf_atom_7e8ad928(soulModeAttachType) then
			v19:Attach(soulModeAttachType, EMPTY_SYMBOL)
		end

		__wf_atom_55142dd4(v19, "OnKilled")
		table.insert(v15, v19)
	end
end

local function fn13()
	for _, v19 in siegeHintTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v19)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) or __wf_atom_0a6a5887:__wf_atom_5b6b447d() == v3 then
			continue
		end

		__wf_atom_0a6a5887:__wf_atom_71694ad6(0)
		__wf_atom_0a6a5887:__wf_atom_75628d88(EMPTY_SYMBOL)
	end
end

local function fn14(p)
	module7.RemoveSparrowDestination(nil, v11)
	module7.RemoveSparrowDestination(nil, v11 .. "Drop")

	if #siegeProgressionObjects < p or p == -1 then
		return
	end

	local siegeProgressionObject = siegeProgressionObjects[p]
	module7.AddSparrowDestination(siegeProgressionObject, siegeTrigger2, v11, module7.PRIORITY.HIGH)
end

function OnActivated(p)
	if p == siegeProgressionObjects[v8] then
		v8 += 1
		fn14(v8)
	end
end

local function fn15()
	local __wf_atom_db682341 = siegeTrigger2:__wf_atom_db682341()
	local v19 = 5

	while true do
		fn2()

		if fn3() then
			if flag then
				gGameRules:__wf_atom_008b0b38(false, 0, "/SF/Language/Objectives/AbandoningSiege")
				flag = false
			end
		else
			if flag then
				abandonTime2 -= __wf_atom_03df4e1d()

				if abandonTime2 <= 0 then
					gGameRules:__wf_atom_008b0b38(false, 0, "/SF/Language/Objectives/AbandoningSiege")
					flag = false
					fn9()
					fn13()
					break
				end
			else
				abandonTime2 = abandonTime
			end

			local v20 = abandonTime2
			gGameRules:__wf_atom_008b0b38(true, math.ceil(v20), "/SF/Language/Objectives/AbandoningSiege")
			flag = true
		end

		if not __wf_atom_7e8ad928(_T.SiegeBurningStartSymbol) and _T.SiegeBurningStartSymbol == __wf_atom_db682341 then
			fn10()
			fn11()
			_T.SiegeBurningStartSymbol = nil
		end

		if not __wf_atom_7e8ad928(_T.BurnedRopeSymbol) and _T.BurnedRopeSymbol == __wf_atom_db682341 then
			_T.BurnedRopeSymbol = nil
			break
		end

		if v19 <= 0 then
			fn12()
			v19 = 5
		else
			v19 -= __wf_atom_03df4e1d()
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(module2.GetReviveShrinePreference()) and module2.IsReviveShrineImperative() then
		module2.SetReviveShrinePreference(nil, false)
	end
end

function StartSiege(object, p)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	v9 = module2.WaitForAiDir()

	if not gRegion:IsMaster() then
		print("Player is client")
		return
	end

	local ongoingSiege = fn7(object) -- inferred equivalent call
	v11 = tostring(ongoingSiege)

	while __wf_atom_7e8ad928(gGameData) do
		Sleep(0)
	end

	if not (gGameData:__wf_atom_20bf298d(ongoingSiege) and _T.OngoingSiege == nil) then
		return
	end

	local v19 = true

	for _, v20 in siegeHintTags do
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v20)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			v19 = false
			break
		else
			table.insert(__wf_atom_0a6a5887s, __wf_atom_0a6a5887)
		end
	end

	if not (v19 and fn4()) then
		return
	end

	for i = 1, #__wf_atom_0a6a5887s do
		local v20 = __wf_atom_0a6a5887s[i]

		if not __wf_atom_7e8ad928(v20) then
			v20:__wf_atom_99a5d75c("OnChildEncStatusChanged", (Symbol(tostring(siegeHintTags[i]) .. "EncCallback")))
		end
	end

	siegeTrigger2 = object
	v10 = p
	_T.OngoingSiege = ongoingSiege
	fn2()
	fn12()

	for _, v20 in siegeProgressionObjects do
		__wf_atom_55142dd4(v20, "OnActivated")
	end

	v8 = 1
	fn14(v8)
	module3.TrackEntry(v11, 4, true)
	module9.TrackSiegeStart(siegeLocationTitleLoc)

	if not __wf_atom_7e8ad928(resurrectionShrine) then
		module2.SetReviveShrinePreference(resurrectionShrine, true)
	end

	if not __wf_atom_7e8ad928(notificationMovie) then
		Sleep(siegeNotificationDelay)

		for _, v20 in ipairs(v13) do
			if __wf_atom_7e8ad928(v20) then
				continue
			end

			local __wf_atom_a96eb2aa = v20:__wf_atom_a96eb2aa()

			if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
				continue
			end

			gGameRules:__wf_atom_6680e8ba(
				__wf_atom_a96eb2aa,
				notificationMovie,
				"SiegeStart",
				{ siegeLocationTitleLoc:c_str(), (tostring(11)) },
				11,
				"SiegeStarted",
				true
			)
			module6.EnableNearestTaggedSoundSysVolume(Symbol("SiegeMusic"), true, v20:GetPosition())
		end
	end

	_T.SiegeObjectiveStatus = 0
	local count3 = #v17
	local count4 = #v18
	local count5 = #availableAdditionalObjectiveHints

	if count3 > 0 and count5 > 0 then
		local availableAdditionalObjectiveHint = availableAdditionalObjectiveHints[math.random(1, count5)]
		local v20 = { v17[math.random(1, count3)] }
		module2.StartPluginScripts(v20, __wf_atom_0a6a5887s[availableAdditionalObjectiveHint])
	end

	if count4 > 0 and count5 > 0 then
		local availableAdditionalObjectiveHint = availableAdditionalObjectiveHints[math.random(1, count5)]
		local v20 = math.random(1, count4)

		if includeEmptyRandomEncounter and math.random() < count4 / (count4 + 1) then
			local v21 = { v18[v20] }
			module2.StartPluginScripts(v21, __wf_atom_0a6a5887s[availableAdditionalObjectiveHint])
		end
	end

	fn15()
	module3.UntrackEntry(v11, 4)
	module7.RemoveSparrowDestination(nil, v11)
	module7.RemoveSparrowDestination(nil, v11 .. "Drop")
	local _ = #siegeProgressionObjects < -1
	_T.OngoingSiege = nil
end

function OnChildEncStatusChanged(object)
	if not module.IsMissionEncounter(object) then
		return
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()
	local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()

	if __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		print("OnChildEncStatusChanged error: " .. object:GetName() .. " has no parent hint!")
	else
		tostring(__wf_atom_26b04ea9:__wf_atom_db682341())

		if __wf_atom_4026dfb5 == 3 or __wf_atom_4026dfb5 == 4 then
			if __wf_atom_7e8ad928(startingObj) then
				v7 += 1
				local v19 = math.floor(infamyStandingIncrease / #siegeHintTags)

				if v19 > 0 then
					for _, v20 in ipairs(v13) do
						if __wf_atom_7e8ad928(v20) then
							continue
						end

						local __wf_atom_a96eb2aa = v20:__wf_atom_a96eb2aa()

						if not (__wf_atom_7e8ad928(__wf_atom_a96eb2aa) or __wf_atom_7e8ad928(gGameRules)) then
							gGameRules:__wf_atom_746fba0c(__wf_atom_a96eb2aa, infamySyndicate, v19)
						end
					end
				end
			else
				local v19 = siegeTrigger2
				local v20 = tostring(fn7(v19)) -- inferred equivalent call
				module7.AddSparrowDestination(startingObj, nil, v20, module7.PRIORITY.QUEST + 1, Range(0, 30))
			end
		end
	end
end

function OnKilled(object)
	local v19 = nil
	local flag2 = true

	for i, v20 in ipairs(v13) do
		if v20 ~= object then
			continue
		end

		v19 = i
		flag2 = false
		break
	end

	if flag2 then
		v19 = 0
	end

	if v19 > 0 then
		count += 1
		table.remove(v13, v19)
	else
		for i = #v15, 1, -1 do
			if v15[i] ~= object then
				continue
			end

			table.remove(v15, i)
			count2 += 1

			if __wf_atom_7e8ad928(soulModeAttachType) then
				continue
			end

			local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

			for _, v20 in ipairs(__wf_atom_be0bea4a) do
				if v20:IsA(soulModeAttachType) then
					v20:Destroy()
				end
			end
		end
	end
end

function StartSiegeContextAction(_)
	if __wf_atom_7e8ad928(siegeTrigger) or not gRegion:IsMaster() then
		return
	end

	siegeTrigger:FirePort("Execute")
end

function SiegeAvailableScriptTrigger(p)
	module2.WaitForLevel()

	if __wf_atom_7e8ad928(siegeTrigger) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(gGameData) then
		return
	end

	local siegeTrigger3 = siegeTrigger
	local name = siegeTrigger3:__wf_atom_db682341()

	if __wf_atom_7e8ad928(name) or name == EMPTY_SYMBOL then
		name = siegeTrigger3:GetName()
	end

	local v19 = nil
	siegeTrigger2 = siegeTrigger
	local v20 = 30

	while not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(siegeTrigger2)) do
		v20 -= 2

		if v20 <= 0 then
			v20 = 30
			fn2()
			local v21 = not gGameData:__wf_atom_20bf298d(name)

			if v21 then
				siegeTrigger2:FirePort("Disable")
			end

			if v19 ~= v21 and not fn3(false) then
				if v21 then
					if not __wf_atom_7e8ad928(timerActivePortForwarder) then
						timerActivePortForwarder:FirePort("TriggerPort")
					end
				else
					if not __wf_atom_7e8ad928(timerInactivePortForwarder) then
						timerInactivePortForwarder:FirePort("TriggerPort")
					end

					siegeTrigger2:FirePort("Enable")

					if #siegeHintTags > 0 then
						gRegion:__wf_atom_0a6a5887(siegeHintTags[1]):__wf_atom_99a5d75c(
							"OnChildEncStatusChanged",
							(Symbol(tostring(siegeHintTags[1]) .. "EncCallback"))
						)
					end

					fn13()
				end

				v19 = v21
			end
		end

		Sleep(2)
	end
end

local function fn16(object)
	if not __wf_atom_7e8ad928(collectorDropTable) then
		local __wf_atom_e93896ba = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_e93896ba(0)
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
		local enemyLevel = module.GetEnemyLevel(object)
		local v19 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

		for _, v20 in pairs(__wf_atom_3c8e1a7a) do
			local playerAvatar = v20:GetPlayerAvatar(0)

			if
				__wf_atom_7e8ad928(playerAvatar)
				or not (playerAvatar:__wf_atom_1c8f7b2d(object) <= 200)
				or __wf_atom_7e8ad928((playerAvatar:__wf_atom_d2b2176d()))
			then
				continue
			end

			collectorDropTable:__wf_atom_0ad20b11(playerAvatar, object, __wf_atom_e93896ba, v19)
		end
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if
		not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
		and __wf_atom_c4f78a8f == gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("PlayerProgressCelebration"), false)
	end
end

function PlayerProgressCelebration(p)
	if not __wf_atom_7e8ad928(p) then
		module3.TriggerPlayerProgressionCelebration(p, nil)
	end
end

function CollectorAbandoned()
	gGameData:__wf_atom_e7f3cb75(infamySyndicate, 20)
	fn6(false)
end

function OnCollectorStatusChanged(object)
	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()

	if __wf_atom_4026dfb5 == 6 then
		object:__wf_atom_84ba6e45(v6)
		CollectorAbandoned()
	elseif __wf_atom_4026dfb5 == 4 then
		object:__wf_atom_84ba6e45(v6)
		fn16(object)
	end
end

function MonitorCollector(object)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		__wf_atom_3d96ddcd:__wf_atom_7dd025d4("OnCollectorStatusChanged", v6)
	end
end

function SiegeTriggerInit(object)
	module2.WaitForLevel()
	module2.WaitForLoginSequence()
	module2.WaitForAiDir()
	siegeTrigger2 = object

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local name = fn7(object) -- inferred equivalent call

	while not __wf_atom_7e8ad928(gGameData) do
		if gGameData:__wf_atom_20bf298d(name) then
			fn8(true)
			break
		else
			Sleep(60)
		end
	end
end