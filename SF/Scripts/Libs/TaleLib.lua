module(..., package.seeall)
local module = require("SF.Scripts.Libs.SparrowLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local module5 = require("SF.Scripts.Libs.QuestLib")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module7 = require("SF.Scripts.Libs.DungeonLocationInfo")
local v = Symbol("ReservedForTale")
local v2 = Symbol("MT_SUBBOSS")
local v3 = Resource("/SF/Types/Game/MarkerInfos/EncounterMarkerInfoArea")
local v4 = Resource("/SF/Types/Game/MarkerInfos/TaleMarkerInfoArea")
local v5 = Resource("/SF/Types/Game/MarkerInfos/SparrowQuestMarkerInfo")
local v6 = {
	SilentRoseSyndicate = {
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/SilentRoseFactionMarkerInfoOne"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/SilentRoseFactionMarkerInfoTwo"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/SilentRoseFactionMarkerInfoThree")
	},
	ChampionSyndicate = {
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/KingsFactionMarkerInfoOne"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/KingsFactionMarkerInfoTwo"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/KingsFactionMarkerInfoThree")
	},
	FeySyndicate = {
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/AlcaFactionMarkerInfoOne"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/AlcaFactionMarkerInfoTwo"),
		Resource("/SF/Types/Game/MarkerInfos/FactionQuest/AlcaFactionMarkerInfoThree")
	}
}
local v7 = nil
local v8 = nil
STATE = {
	GENERATED = 0,
	ACTIVEHIDDEN = 1,
	ACCEPTED = 2,
	INPROGRESS = 3,
	COMPLETED = 4,
	ABANDONED = 5
}
expiryTime = 3600
rerollTime = 900

function LogSavedPath(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ce8bea3a = object:__wf_atom_ce8bea3a()
	print("Tale Path Fingerprint --------------")
	print(__wf_atom_ce8bea3a)
	print("------------------------------------")
end

function CountNodes(list)
	local total = 0

	for _, v9 in ipairs(list) do
		total += #v9
	end

	return total
end

function ReserveHint(object, p)
	if p then
		object:__wf_atom_ed6d3248(v)
	else
		object:__wf_atom_68e563a5(v)
	end
end

function HintIsReserved(object)
	local __wf_atom_cc31ec3f = object:__wf_atom_cc31ec3f()
	local v9 = Symbol("TaleLocation")

	for _, v10 in ipairs(__wf_atom_cc31ec3f) do
		if v10 == v or v10 == v9 then
			return true
		end
	end

	return false
end

function ShouldStopEncounters()
	local isInOverworld = module6.IsInOverworld()

	if GetPlayerFaction() == EMPTY_SYMBOL then
		return true
	end

	if module4.IsHardModeActive() then
		_T.EncounterEarlyOutLogMsg = "Red night is active"
		return true
	end

	if not module5.TalesAllowed() then
		_T.EncounterEarlyOutLogMsg = "An active quest task is blocking tales"
		return true
	end

	if isInOverworld then
		return false
	end

	local activeDungeonTaleInfo, _, _ = module7.GetActiveDungeonTaleInfo()

	if __wf_atom_7e8ad928(activeDungeonTaleInfo) then
		_T.EncounterEarlyOutLogMsg = "No tasks active for this dungeon"
		return true
	end

	return false
end

function SetLocations(p)
	v8 = p
end

local function fn(encHint, object, p)
	local subbossTaleTitle = object:__wf_atom_4f3855f9():c_str()
	local c_str = object:__wf_atom_c1f3dd00():c_str()
	local v9 = nil

	if p ~= v2 then
		return subbossTaleTitle, c_str, v9
	end

	local subBossName = nil

	if module6.IsInOverworld() then
		local __wf_atom_e919fb8e = encHint:__wf_atom_e919fb8e()

		if __wf_atom_e919fb8e.subBossName ~= nil then
			subBossName = __wf_atom_e919fb8e.subBossName
		end

		if __wf_atom_e919fb8e.subbossTaleTitle ~= nil then
			subbossTaleTitle = __wf_atom_e919fb8e.subbossTaleTitle
		end
	else
		local _
		_, subBossName, subbossTaleTitle = module7.GetThisDungeonSubBoss()
	end

	if subBossName ~= nil then
		v9 = { BOSSNAME = subBossName }
	end

	return subbossTaleTitle, c_str, v9
end

function GetNameAndDescriptionForNode(p)
	local v9 = v8[p.locationId]

	if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9.encHint) then
		return "", "", nil
	end

	local __wf_atom_969b3725 = v9.encHint:__wf_atom_969b3725()

	for _, v10 in ipairs(__wf_atom_969b3725) do
		if v10:__wf_atom_55116686() == p.missionTag then
			return fn(v9.encHint, v10, p.missionTag)
		end
	end

	return "", "", nil
end

function ClearTrackedTale()
	if _T.ActiveTales == nil then
		return
	end

	local trackedJournalEntry = module5.GetTrackedJournalEntry()

	if trackedJournalEntry == nil then
		return
	end

	for _, activeTale in ipairs(_T.ActiveTales) do
		if activeTale.hudId ~= trackedJournalEntry.mId then
			continue
		end

		activeTale:SetIsTracked(false)
		break
	end
end

function TrackTaleById(p)
	if not (_T.ActiveTales ~= nil and p ~= nil) then
		return
	end

	local trackedJournalEntry = module5.GetTrackedJournalEntry()

	if trackedJournalEntry ~= nil and trackedJournalEntry.mId ~= p then
		ClearTrackedTale()
	end

	for _, activeTale in ipairs(_T.ActiveTales) do
		if activeTale.hudId ~= p then
			continue
		end

		activeTale:SetIsTracked(true)
		break
	end
end

local function fn2(p)
	for _, list in ipairs(p.paths) do
		for _, v9 in ipairs(list) do
			if not (#v9.nextNodes > 1) then
				continue
			end

			for i, nextNode in ipairs(v9.nextNodes) do
				local v10 = p.paths[nextNode.p][nextNode.n]

				for j, nextNode2 in ipairs(v9.nextNodes) do
					if i == j then
						continue
					end

					if __wf_atom_7e8ad928(v10.pairedNodes) then
						v10.pairedNodes = {}
					end

					table.insert(v10.pairedNodes, nextNode2)
				end
			end
		end
	end
end

local function fn3(p)
	for _, list in ipairs(p.paths) do
		for _, v9 in ipairs(list) do
			if __wf_atom_7e8ad928(v9.tempNextNodeSymbols) or not (#v9.tempNextNodeSymbols > 0) then
				continue
			end

			v9.nextNodes = {}

			for _, tempNextNodeSymbol in ipairs(v9.tempNextNodeSymbols) do
				local _, _, v10, v11 = FindPathNodeWithId(tostring(tempNextNodeSymbol), { p })

				if v10 and v11 then
					table.insert(v9.nextNodes, { p = v10, n = v11 })
				else
					print("Path node [" .. tostring(tempNextNodeSymbol) .. "] not found")
				end
			end

			v9.tempNextNodeSymbols = nil
		end
	end
end

local function fn4(p)
	for _, list in ipairs(p.paths) do
		for _, v9 in ipairs(list) do
			local name, desc, descParams = GetNameAndDescriptionForNode(v9)
			v9.name = name
			v9.desc = desc
			v9.descParams = descParams
		end
	end

	fn3(p)
	fn2(p)
end

local function fn5(state, p, p2, p3, p4, p5)
	local v9 = p2[state.locationId]

	if __wf_atom_7e8ad928(v9) or not __wf_atom_7e8ad928(state.marker) then
		return
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local encHint = v9.encHint

	if __wf_atom_7e8ad928(encHint) then
		return
	end

	local position = encHint:GetPosition()
	local taggedInstanceRef = module4.FindTaggedInstanceRef(encHint, Symbol("EntranceMarkerWp"))

	if not __wf_atom_7e8ad928(taggedInstanceRef) then
		position = taggedInstanceRef:GetPosition()
	end

	if __wf_atom_7e8ad928(state.marker) then
		local v10 = p3 or GetMarkerTypeForNode(state, p2)

		if __wf_atom_7e8ad928(v10) then
			return
		end

		local __wf_atom_0e0a6fee = v7:__wf_atom_0e0a6fee(position, 100, 100)
		local entity = gRegion:CreateEntity(v10, __wf_atom_0e0a6fee + Vector(0, 10, 0), __wf_atom_80368bb1)

		if p then
			entity:__wf_atom_44962dd2(4)
		elseif state.completed then
			entity:__wf_atom_44962dd2(3)
		elseif state.wasPrimed then
			entity:__wf_atom_44962dd2(2)
		else
			entity:__wf_atom_44962dd2(1)
		end

		entity:__wf_atom_01b26dab(encHint)
		entity:__wf_atom_9d79cb42(state.missionTag)
		local __wf_atom_969b3725 = encHint:__wf_atom_969b3725()

		for _, v11 in ipairs(__wf_atom_969b3725) do
			local __wf_atom_55116686 = v11:__wf_atom_55116686()

			if __wf_atom_55116686 ~= entity:__wf_atom_55116686() then
				continue
			end

			local v12, v13, v14 = fn(encHint, v11, __wf_atom_55116686)

			if v14 ~= nil then
				v13 = Localize(v13, v14)
			end

			local v15 = p4 or Symbol(v12)
			local v16 = p5 or Symbol(v13)
			entity:__wf_atom_c2a0916e(v15)
			entity:__wf_atom_313b2fd2(v16)
			break
		end

		state.marker = entity
	end
end

function CreateTale(faction, paths, tier, encounterSchema)
	local v9 = {
		faction = faction,
		paths = paths,
		encounterSchema = encounterSchema,
		state = STATE.GENERATED,
		startTime = module3.GetSecondCount(),
		totalNodes = CountNodes(paths),
		abandonTimer = -120,
		tier = tier,
		expiryTime = expiryTime,
		rerollTime = rerollTime,
		pathId = 0,
		isTracked = false,
		isPreviewed = false
	}
	fn4(v9)
	local v10 = v9.paths[1][#v9.paths[1]]
	local name, desc, descParams = GetNameAndDescriptionForNode(v10)
	v9.name = name
	v9.desc = desc
	v9.descParams = descParams
	v9.markerType = GetMarkerTypeForNode(v10, v8)
	v9.hudId = "TALE" .. "-T" .. tier .. "-" .. v10.locationId

	if module6.IsInOverworld() and faction ~= EMPTY_SYMBOL then
		v9.introMarkerType = v6[tostring(faction)][v9.tier] or GetMarkerTypeForNode(v10, v8)
		v9.regionId = v8[paths[1][1].locationId].regionId
		local v11 = 999
		local v12 = 1

		for _, list in ipairs(paths) do
			for _, v13 in ipairs(list) do
				if v8[v13.locationId] == nil then
					continue
				end

				local enemyLevel = module4.GetEnemyLevel(v8[v13.locationId].encHint)
				v11 = math.min(enemyLevel.minValue, v11)
				v12 = math.max(enemyLevel.maxValue, v12)
				ReserveHint(v8[v13.locationId].encHint, true)
			end
		end

		v9.enemyLevel = Range(v11, v12)
	else
		v9.enemyLevel = module4.GetEnemyLevel()
	end

	function v9:SetJobBoard(jobBoardAction)
		self.jobBoardAction = jobBoardAction
	end

	function v9.GetJobBoard(p)
		return p.jobBoardAction
	end

	function v9:SetState(state)
		self.state = state
	end

	function v9.GetFirstNode(p)
		return p.paths[1][1]
	end

	function v9.GetFirstHint(p)
		local v11 = v8[p.paths[1][1].locationId]

		if v11 == nil then
			return nil
		end

		return v11.encHint
	end

	function v9.GetFinalNode(p)
		return p.paths[1][#p.paths[1]]
	end

	function v9.GetFinalHint(p)
		local v11 = v8[p.paths[1][#p.paths[1]].locationId]

		if v11 == nil then
			return nil
		end

		return v11.encHint
	end

	function v9.CreatePathMarkers(p)
		CreateTalePathMarkers(p, v8)
		local result = {}

		for _, list in ipairs(p.paths) do
			for _, v11 in ipairs(list) do
				if v11.marker ~= nil then
					table.insert(result, v11)
				end
			end
		end

		return result
	end

	function v9.ClearPathMarkers(p)
		for _, list in ipairs(p.paths) do
			for _, v11 in ipairs(list) do
				if __wf_atom_7e8ad928(v11.marker) then
					continue
				end

				v11.marker:Destroy()
				v11.marker = nil
			end
		end
	end

	function v9.ShowAreaMarkers(p, p2)
		for _, list in ipairs(p.paths) do
			for _, v11 in ipairs(list) do
				if v8[v11.locationId] == nil or __wf_atom_7e8ad928(v8[v11.locationId].encHint) then
					continue
				end

				local registeredObjectsOfType = module4.GetRegisteredObjectsOfType(
					v8[v11.locationId].encHint,
					__wf_atom_0f520c3c
				)

				for _, v12 in ipairs(registeredObjectsOfType) do
					if not v12:IsA(v3) then
						continue
					end

					if p2 then
						v12:Enable()
					else
						v12:Disable()
					end
				end
			end
		end
	end

	function v9:SetIsPreviewed(isPreviewed)
		self.isPreviewed = isPreviewed
	end

	function v9:SetIsTracked(isTracked)
		local trackedJournalEntry = module5.GetTrackedJournalEntry()

		if (self.isTracked or not __wf_atom_7e8ad928(self.paths[1][1].marker)) == isTracked then
			if
				isTracked and trackedJournalEntry ~= nil and trackedJournalEntry.mId == self.hudId
				or not isTracked and (trackedJournalEntry == nil or trackedJournalEntry.mId ~= self.hudId)
			then
				return
			end
		end

		self.isTracked = isTracked

		if self.isTracked then
			module5.TrackEntry(self.hudId, 1, true)
		else
			module5.UntrackEntry(self.hudId, 1)
		end
	end

	function v9:IsActive()
		return not (self.state < STATE.ACCEPTED or self.state >= STATE.ABANDONED)
	end

	function v9:Update()
		if _T.JobBoardOpen or not self:IsActive() then
			return
		end

		local trackedJournalEntry = module5.GetTrackedJournalEntry()

		if trackedJournalEntry == nil and self.isTracked then
			self:SetIsTracked(false)
		end

		if trackedJournalEntry ~= nil then
			if trackedJournalEntry.mId == self.hudId and not self.isTracked then
				self:SetIsTracked(true)
			elseif trackedJournalEntry.mId ~= self.hudId and self.isTracked then
				self:SetIsTracked(false)
			end
		end
	end

	function v9.GetActiveNode(p)
		for _, v11 in ipairs(p.paths[1]) do
			if v11.wasPrimed and not v11.completed then
				return v11
			end
		end

		return nil
	end

	return v9
end

function CreateNode(locationId, missionTag)
	return { locationId = locationId, missionTag = missionTag }
end

function IsMissionEncounter(object)
	local __wf_atom_dd85e6db = object:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) or __wf_atom_dd85e6db:__wf_atom_55116686() == EMPTY_SYMBOL then
		return false
	end

	return true
end

function FindPathNodeWithId(p, list)
	local v9 = nil
	local v10 = nil
	local v11 = nil
	local v12 = nil

	if __wf_atom_7e8ad928(list) or not (#list > 0) then
		return v9, v10, v11, v12
	end

	for i, v13 in ipairs(list) do
		for j, list2 in ipairs(v13.paths) do
			for k, v14 in ipairs(list2) do
				if v14.locationId ~= p then
					continue
				end

				v12 = k
				v11 = j
				v10 = i
				v9 = v14
				break
			end

			if not __wf_atom_7e8ad928(v9) then
				break
			end
		end
	end

	return v9, v10, v11, v12
end

function CreatePathData(list, p, p2, list2)
	local result = {}
	local v9 = 1
	local v10 = #list
	local v11 = __wf_atom_7e8ad928(list2) and 1 or #list2 + 1

	if p then
		v9 += 1
	end

	if p2 then
		math.max(v10 - 1, v9)
	end

	for i = 1, #list do
		local v12 = { locationId = list[i].id, missionTag = list[i].missionTag, nextNodes = {} }
		local v13 = false

		for j, list3 in ipairs(list2) do
			for k, v14 in ipairs(list3) do
				if v14.locationId ~= list[i].id then
					continue
				end

				if i == 1 then
					table.insert(v14.nextNodes, { p = v11, n = 1 })
				end

				if i == #list then
					table.insert(result[math.max(1, #result)].nextNodes, { p = j, n = k })
				end

				v13 = true
			end
		end

		if not v13 then
			table.insert(result, v12)
		end
	end

	for i, v12 in ipairs(result) do
		if i < #result then
			table.insert(v12.nextNodes, {
				p = v11,
				n = i + 1
			})
		end
	end

	return result
end

function JournalTrackNextTale()
	if _T.ActiveTales == nil or #_T.ActiveTales == 0 or module5.IsAnythingTracked() or not module6.IsInOverworld() then
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local regionId = module6.GetRegionIdFromDensityVolume(__wf_atom_c4f78a8f:GetPosition())
	local v9 = 3.4028234663852886e38
	local v10 = nil

	for _, activeTale in ipairs(_T.ActiveTales) do
		if not (activeTale.nextNodePos ~= nil and activeTale.regionId == regionId) then
			continue
		end

		local __wf_atom_a5304c35 = __wf_atom_c4f78a8f:__wf_atom_a5304c35(activeTale.nextNodePos)

		if not (__wf_atom_a5304c35 < v9 or v10 == nil) then
			continue
		end

		v10 = activeTale
		v9 = __wf_atom_a5304c35
	end

	if v10 ~= nil then
		v10:SetIsTracked(true)
	end
end

function GetMarkerTypeForNode(p, p2)
	local v9 = p2[p.locationId]

	if __wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(v9.encHint) then
		return v5
	end

	local __wf_atom_969b3725 = v9.encHint:__wf_atom_969b3725()

	for _, v10 in ipairs(__wf_atom_969b3725) do
		if v10:__wf_atom_55116686() ~= p.missionTag then
			continue
		end

		if v10:__wf_atom_7026c43c() then
			return nil
		end

		local __wf_atom_12d9eb4f = v10:__wf_atom_12d9eb4f()

		if __wf_atom_7e8ad928(__wf_atom_12d9eb4f) then
			break
		else
			return __wf_atom_12d9eb4f
		end
	end

	return v5
end

function SparrowDestId(p)
	return module2.GetObjectId(p.encHint)
end

function GetObjectiveIdFromNode(p)
	if __wf_atom_7e8ad928(p) then
		return ""
	end

	return p.locationId .. "-" .. tostring(p.missionTag)
end

function GetObjectiveIdFromOverworld(p)
	if __wf_atom_7e8ad928(p) then
		return ""
	end

	return p.overworldLocationId .. "-" .. tostring(p.missionTag)
end

function EnableEncounterMarker(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(v7) then
		v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local registeredObjectsOfType = module4.GetRegisteredObjectsOfType(object, __wf_atom_0f520c3c)

	for _, v9 in ipairs(registeredObjectsOfType) do
		if v9:IsA(v3) then
			v9:Destroy()
		end
	end

	if p then
		local position = object:GetPosition()
		local __wf_atom_0e0a6fee = v7:__wf_atom_0e0a6fee(position, 50, 100)
		local taggedInstanceRef = module4.FindTaggedInstanceRef(object, Symbol("EntranceMarkerWp"))

		if not __wf_atom_7e8ad928(taggedInstanceRef) then
			taggedInstanceRef:GetPosition()
		end

		object:__wf_atom_d494454b((module4.CreateAreaMarker(v4, __wf_atom_0e0a6fee, 25)))
	end

	local __wf_atom_90813fa0 = object:__wf_atom_90813fa0()

	if (__wf_atom_7e8ad928(__wf_atom_90813fa0) or not __wf_atom_90813fa0:__wf_atom_7026c43c()) and not p2 then
		if p then
			local v9

			if not (__wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p3.marker)) then
				v9 = p3.marker:__wf_atom_e32e2012()
			end

			local v10 = math.max(object:__wf_atom_103377cc(), 10)
			module.AddSparrowDestination(
				object,
				object,
				nil,
				module.PRIORITY.TALE,
				Range(v10, 3.4028234663852886e38),
				nil,
				nil,
				v9,
				true,
				true
			)
		else
			module.RemoveSparrowDestination(object)
		end
	end
end

function CreateTalePathMarkers(p, p2)
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6()) then
		return
	end

	local v9 = 0

	for _, path in ipairs(p.paths) do
		v9 = math.max(v9, #path)
	end

	for i = 1, v9 do
		for j, path in ipairs(p.paths) do
			if #path < i then
				break
			end

			if j == 1 and i == #path and #path > 1 then
				fn5(path[i], true, p2)
			else
				fn5(path[i], false, p2)
			end
		end
	end

	if v9 == 1 then
		return
	end

	local v10 = p.pathId == nil and 1 or p.pathId * 8 + 1

	for i, list in ipairs(p.paths) do
		for j, v11 in ipairs(list) do
			if __wf_atom_7e8ad928(v11.marker) then
				continue
			end

			if i == 1 and j == 1 then
				local v12 = math.clamp(v10, 0, 254)
				v11.marker:__wf_atom_0e1ed5eb(v12)
				v10 = v12 + 1
			end

			if __wf_atom_7e8ad928(v11.nextNodes) or #v11.nextNodes == 0 then
				if j < #list then
					local v12 = list[j + 1]

					if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v12.marker)) then
						v11.marker:__wf_atom_83cb10eb(v12.marker)
						local v13 = math.clamp(v10, 0, 254)
						v12.marker:__wf_atom_0e1ed5eb(v13)
						v10 = v13 + 1
					end
				end
			else
				for _, nextNode in ipairs(v11.nextNodes) do
					local v12 = p.paths[nextNode.p][nextNode.n]

					if __wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v12.marker) then
						continue
					end

					v11.marker:__wf_atom_83cb10eb(v12.marker)
					local v13 = math.clamp(v10, 0, 254)
					v12.marker:__wf_atom_0e1ed5eb(v13)
					v10 = v13 + 1
				end
			end
		end
	end
end

function GetPlayerFaction()
	if __wf_atom_7e8ad928(gGameData) then
		return EMPTY_SYMBOL
	end

	local __wf_atom_0cbd9965 = gGameData:__wf_atom_0cbd9965()

	if __wf_atom_0cbd9965 ~= EMPTY_SYMBOL then
		local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(__wf_atom_0cbd9965)

		if not __wf_atom_7e8ad928(__wf_atom_51dd1b95) and __wf_atom_51dd1b95.mInitiated then
			return __wf_atom_0cbd9965
		end
	end

	return EMPTY_SYMBOL
end

local v9 = Symbol("MapTreeJobBoard")

function AddToJobBoards(id, list, name, description, markerType, setupCallback, selectedCallback)
	local v10 = {
		id = id,
		name = name,
		description = description,
		markerType = markerType,
		setupCallback = setupCallback,
		selectedCallback = selectedCallback,
		SetMarker = function(state, marker)
			state.marker = marker
			state.marker:__wf_atom_73179db0(Symbol(state.name))
		end,
		SetEnemyLevel = function(p, p2, p3)
			p.enemyLevel = p3 or module4.GetEnemyLevel(p2)
		end
	}

	for _, v11 in ipairs(list) do
		local __wf_atom_e919fb8e = v11:__wf_atom_e919fb8e()
		local v12 = nil

		for _, v13 in ipairs(__wf_atom_e919fb8e.eventInfo) do
			if v13.id == id then
				v12 = v13
			end
		end

		if v12 then
			continue
		end

		__wf_atom_e919fb8e.eventInfo = __wf_atom_e919fb8e.eventInfo or {}
		table.insert(__wf_atom_e919fb8e.eventInfo, v10)
	end

	_T.RefreshJobBoard = true
end

function RemoveFromAllJobBoards(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v9)

	for _, v10 in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e919fb8e = v10:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.eventInfo) then
			continue
		end

		for i = #__wf_atom_e919fb8e.eventInfo, 1, -1 do
			if __wf_atom_e919fb8e.eventInfo[i].id ~= p then
				continue
			end

			if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.marker) then
				__wf_atom_e919fb8e.marker:Destroy()
			end

			table.remove(__wf_atom_e919fb8e.eventInfo, i)
		end
	end
end

function RemoveFromJobBoards(p, list)
	if __wf_atom_7e8ad928(list) then
		list = gRegion:__wf_atom_2226b35c(v9)
	end

	for _, v10 in ipairs(list) do
		local __wf_atom_e919fb8e = v10:__wf_atom_e919fb8e()

		if __wf_atom_7e8ad928(__wf_atom_e919fb8e.eventInfo) then
			continue
		end

		for i = #__wf_atom_e919fb8e.eventInfo, 1, -1 do
			if __wf_atom_e919fb8e.eventInfo[i].id == p then
				table.remove(__wf_atom_e919fb8e.eventInfo, i)
			end
		end
	end
end

function GetJobBoardsInRegion(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v9)

	for i = #__wf_atom_2226b35c, 1, -1 do
		if module6.GetRegionIdFromDensityVolume(__wf_atom_2226b35c[i]:GetPosition()) ~= p then
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	return __wf_atom_2226b35c
end

function GetJobBoardsInRange(p, p2, p3)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v9, p, p2.minValue, p2.maxValue)

	if p3 then
		__wf_atom_439c0d29 = #__wf_atom_439c0d29 == 0 and { gRegion:FindNearestTagged(v9, p) } or __wf_atom_439c0d29
	end

	return __wf_atom_439c0d29
end

function GetAllJobBoards()
	return (gRegion:__wf_atom_2226b35c(v9))
end

function GetJobRegion(p, p2)
	if not __wf_atom_7e8ad928(p) then
		p2 = module6.GetRegionIdFromDensityVolume(p)
	end

	return p2
end

function DebugDrawAllHints(items)
	local v10 = {
		Color(255, 150, 150),
		Color(150, 255, 150),
		Color(150, 150, 255),
		Color(150, 255, 255),
		Color(255, 150, 255),
		Color(255, 255, 150),
		Color(255, 255, 255)
	}

	for _, item in pairs(items) do
		if _T.DebugDrawAllHintsIsolated and #item.connections > 2 then
			continue
		end

		local regionId = module6.GetRegionIdFromDensityVolume(item.encPos)
		local v11 = v10[math.min(regionId, #v10)] or Color(255, 0, 0)
		gRegion:__wf_atom_5b35a0c8(item.encPos, v11, "R:" .. tostring(regionId), 1.5, 0)

		if not __wf_atom_7e8ad928(item.connections) then
			local _ = #item.connections == 0
		end

		if not module4.GetMissionEncounterAllowed(item.encHint) then
			gRegion:__wf_atom_5b35a0c8(
				item.encPos + Vector(1, 35, 1),
				Color(255, 0, 0),
				"GetMissionEncounterAllowed=false",
				1.5,
				0
			)
		end

		gRegion:__wf_atom_628723a6(item.encPos, item.encPos + Vector(0, 30, 0), v11, 0)
		gRegion:__wf_atom_5b35a0c8(
			item.encPos + Vector(1, 31, 1),
			v11,
			tostring(item.encHintTag) .. " " .. item.level.minValue .. "-" .. item.level.maxValue,
			1,
			0
		)

		for _, connection in ipairs(item.connections) do
			gRegion:__wf_atom_628723a6(
				items[connection.id].encPos + Vector(0, 30, 0),
				item.encPos + Vector(0, 30, 0),
				Color(128, 0, 0),
				0
			)
			gRegion:__wf_atom_5b35a0c8(
				__wf_atom_f55d6358(items[connection.id].encPos + Vector(0, 30, 0), item.encPos + Vector(0, 30, 0), 0.5),
				Color(255, 0, 0),
				tostring((math.ceil(connection.dist))),
				1,
				0
			)
		end
	end
end

function DebugDrawTalesFromImGui(list, p)
	if __wf_atom_7e8ad928(list) or #list == 0 then
		return
	end

	local v10 = Color(255, 255, 0)
	local v11 = Color(255, 128, 0)

	for _, v12 in ipairs(list) do
		for i, list2 in ipairs(v12.paths) do
			for j, v13 in ipairs(list2) do
				local v14 = p[v13.locationId]

				if __wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v14.encHint) then
					continue
				end

				if not __wf_atom_7e8ad928(v13.nextNodes) then
					for _, nextNode in ipairs(v13.nextNodes) do
						local v15 = p[v12.paths[nextNode.p][nextNode.n].locationId]
						local v16 = __wf_atom_f55d6358(
							v15.encPos + Vector(0, 30, 0),
							v14.encPos + Vector(0, 30, 0),
							0.5
						)
						local v17 = __wf_atom_f55d6358(
							v15.encPos + Vector(0, 30, 0),
							v14.encPos + Vector(0, 30, 0),
							0.55
						)
						gRegion:__wf_atom_628723a6(v15.encPos + Vector(0, 30, 0), v14.encPos + Vector(0, 30, 0), v11, 0)
						gRegion:__wf_atom_7185c43a(v16, v17, 10, v11, false, 0)
					end
				end

				if j < #list2 then
					local v15 = p[list2[j + 1].locationId]
					local v16 = __wf_atom_f55d6358(v15.encPos + Vector(0, 30, 0), v14.encPos + Vector(0, 30, 0), 0.5)
					local v17 = __wf_atom_f55d6358(v15.encPos + Vector(0, 30, 0), v14.encPos + Vector(0, 30, 0), 0.55)
					gRegion:__wf_atom_628723a6(v15.encPos + Vector(0, 30, 0), v14.encPos + Vector(0, 30, 0), v10, 0)
					gRegion:__wf_atom_7185c43a(v16, v17, 10, v10, false, 0)
				end

				if _T.DebugDrawTaleActivationRadius then
					gRegion:__wf_atom_b5c21154(
						v14.encPos + Vector(0, 20, 0),
						v14.encHint:__wf_atom_103377cc(),
						Color(255, 255, 0),
						Rotation(0, 90, 0),
						0
					)
					gRegion:__wf_atom_b5c21154(
						v14.encPos + Vector(0, 20, 0),
						v14.encHint:__wf_atom_8f18e876(),
						Color(0, 255, 0),
						Rotation(0, 90, 0),
						0
					)
					gRegion:__wf_atom_b5c21154(
						v14.encPos + Vector(0, 20, 0),
						v14.encHint:__wf_atom_4a0ffa6e(),
						Color(255, 0, 0),
						Rotation(0, 90, 0),
						0
					)
					gRegion:__wf_atom_b5c21154(
						v14.encPos + Vector(0, 20, 0),
						math.max(175, v14.encHint:__wf_atom_4a0ffa6e()),
						Color(0, 64, 255),
						Rotation(0, 90, 0),
						0
					)
				end

				gRegion:__wf_atom_8d991675(v14.encPos, v14.encHint:__wf_atom_103377cc(), Color(100, 100, 0), 0)
				gRegion:__wf_atom_628723a6(v14.encPos + Vector(0, 30, 0), v14.encPos, v10, 0)
				gRegion:__wf_atom_5b35a0c8(
					v14.encPos + Vector(0, 32, 0),
					v10,
					tostring(j) .. ": " .. tostring(v13.locationId) .. " : " .. tostring(v13.missionTag) .. " : " .. tostring(v14.level.minValue) .. "-" .. tostring(v14.level.maxValue),
					1,
					0
				)

				if i ~= 1 then
					continue
				end

				if j == 1 then
					gRegion:__wf_atom_5b35a0c8(v14.encPos + Vector(0, 40, 0), v10, "START", 2, 0)
				elseif j == #list2 then
					gRegion:__wf_atom_5b35a0c8(v14.encPos + Vector(0, 40, 0), v10, "BOSS", 2, 0)
				end
			end
		end

		if __wf_atom_7e8ad928(v12.startObject) then
			continue
		end

		local position = v12.startObject:GetPosition()
		gRegion:__wf_atom_628723a6(position, position + Vector(0, 20, 0), v10, 0)
		gRegion:__wf_atom_5b35a0c8(position + Vector(0, 2, 0), v10, "Starting Point", 1, 0)
	end
end