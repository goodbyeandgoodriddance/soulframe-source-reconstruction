local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.EncounterLib")
local module6 = require("SF.Scripts.Libs.StatsLib")
local module7 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module8 = require("Lotus.Interface.LotusUtilities")
local module9 = require("SF.Scripts.Libs.TaleLib")
local module10 = require("SF.Scripts.Libs.DungeonLocationInfo")
local module11 = require("SF.Scripts.Libs.CodexLib")
local module12 = require("EE.Interface.Utilities")
local module13 = require("Lotus.Scripts.Libs.Query")
local module14 = require("SF.Scripts.Libs.RaycastLib")
local module15 = require("SF.Scripts.Libs.ChallengeLib")
local v = WeakResource("/SF/Interface/JobBoard.swf")
local v2 = WeakResource("/SF/Types/Game/Encounters/Tales/RegionMissionEncounterHint")
local v3 = WeakResource("/SF/Types/Game/Encounters/Locations/DungeonEntranceHintUndercity")
local v4 = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
local v5 = WeakResource("/SF/Types/Player/Ghost/PlayerSparrowAvatar")
local v6 = Symbol("TaleLocation")
local v7 = Symbol("MapTreeJobBoard")
local v8 = Symbol("TaleNpcWp")
local v9 = Range(75, 200)
local v10 = Range(50, 150)
local v11 = {
	blessing = "MT_BLESSING",
	clearcamp = "MT_CLEARCAMP",
	clearlargecamp = "MT_CLEARCAMP_LARGE",
	clearcorruption = "MT_CLEAR_CORRUPTION",
	patrol = "MT_CLEAR_PATROL",
	gather = "MT_GATHER",
	intel = "MT_INTEL",
	intelenemydrop = "MT_INTEL_ENEMIES",
	rescue = "MT_RESCUE",
	retrieve = "MT_RETRIEVE",
	retrievebomb = "MT_RETRIEVE_BOMB",
	sabcannon = "MT_SABOTAGE_CANNON",
	sabincense = "MT_SABOTAGE_INCENSE",
	sabpolluter = "MT_SABOTAGE_POLLUTER",
	vendor = "MT_VENDOR",
	cryptkey = "MT_CRYPT_KEY",
	sprout = "MT_SPROUT_PATCH",
	knights = "MT_KNIGHT_WAVES",
	mockeries = "MT_MOCKERIES"
}
local v12 = {
	any = "MT_DUNGEON",
	boss = "MT_DUNGEON_MINIBOSS",
	cages = "MT_DUNGEON_CAGES",
	puzzles = "MT_DUNGEON_PUZZLE",
	corrupt = "MT_DUNGEON_CLEARCORRUPTION",
	crypt = "MT_CRYPT_RETRIEVE"
}
local v13 = {
	patrol = "MT_CLEAR_PATROL_BOSS",
	miniboss = "MT_MINIBOSS",
	stag = "MT_VadagarStagBoss",
	bear = "MT_VadagarBearBoss",
	sprout = "MT_SPROUT_BOSS",
	subboss = "MT_SUBBOSS"
}
local v14 = {
	v13.miniboss,
	v13.patrol,
	v13.stag,
	v13.bear,
	v12.boss,
	v12.cages,
	v12.puzzles,
	v12.corrupt,
	v13.subboss
}
local v15 = {
	v11.clearlargecamp,
	v11.sabcannon,
	v11.sabincense,
	v13.patrol,
	v13.miniboss,
	v13.stag,
	v13.bear,
	v13.sprout,
	v12.crypt,
	v11.knights
}
local v16 = {
	v11.sabpolluter,
	v11.clearcamp,
	v11.rescue,
	v11.patrol,
	v11.clearcorruption,
	v11.sprout,
	v11.gather
}
local v17 = {
	v13.miniboss,
	v13.patrol,
	v13.stag,
	v13.bear,
	v12.any,
	v12.boss,
	v12.cages,
	v12.puzzles,
	v12.corrupt,
	v13.sprout,
	v12.crypt,
	v11.sabcannon,
	v13.subboss
}
local v18 = {
	[v11.clearlargecamp] = 0.65,
	[v13.patrol] = 0.75,
	[v12.boss] = 0.6,
	[v13.stag] = 2,
	[v13.bear] = 2,
	[v12.cages] = 0.3,
	[v12.puzzles] = 0.3,
	[v12.corrupt] = 0.6
}
local v19 = { [v13.miniboss] = 0.5, [v13.stag] = 0.5, [v13.bear] = 0.5 }
local v20 = { [v11.sabincense] = 0.5 }
local v21 = {
	[v11.blessing] = 1,
	[v11.retrievebomb] = 1,
	[v11.retrieve] = 2,
	[v11.vendor] = 1,
	[v11.gather] = 2,
	[v11.clearlargecamp] = 1,
	[v11.sabcannon] = 1,
	[v11.cryptkey] = 1,
	[v11.knights] = 1
}
local v22 = {}
local v23 = {
	[v11.sabpolluter] = 0.7,
	[v11.retrieve] = 0.2,
	[v11.patrol] = 0.3,
	[v11.intel] = 0.2,
	[v11.intelenemydrop] = 0.2
}
local v24 = {}
local retrieve = v11.retrieve
v24[retrieve] = { [v11.retrieve] = 0, [v11.blessing] = 0.1, [v11.vendor] = 0 }
local patrol = v11.patrol
v24[patrol] = { [v11.patrol] = 0.1 }
local clearcamp = v11.clearcamp
v24[clearcamp] = { [v11.clearcamp] = 0.1 }
local clearlargecamp = v11.clearlargecamp
v24[clearlargecamp] = {
	[v11.clearlargecamp] = 0,
	[v11.retrieve] = 2,
	[v11.blessing] = 2,
	[v11.vendor] = 2
}
local rescue = v11.rescue
v24[rescue] = { [v12.cages] = 2, [v12.puzzles] = 2 }
local sabpolluter = v11.sabpolluter
v24[sabpolluter] = { [v11.clearcorruption] = 2 }
local sabincense = v11.sabincense
v24[sabincense] = { [v11.sabincense] = 0 }
local retrievebomb = v11.retrievebomb
v24[retrievebomb] = { [v11.retrievebomb] = 0, [v11.sabcannon] = 5 }
local blessing = v11.blessing
v24[blessing] = {
	[v11.blessing] = 0,
	[v11.retrieve] = 0.1,
	[v11.vendor] = 0.1,
	[v12.cages] = 2,
	[v12.puzzles] = 2,
	[v12.corrupt] = 2
}
local intel = v11.intel
v24[intel] = { [v11.intel] = 0, [v11.intelenemydrop] = 0, [v12.cages] = 2, [v12.puzzles] = 2 }
local intelenemydrop = v11.intelenemydrop
v24[intelenemydrop] = {
	[v11.intel] = 0,
	[v11.intelenemydrop] = 0,
	[v12.cages] = 2,
	[v12.puzzles] = 2
}
local gather = v11.gather
v24[gather] = { [v11.gather] = 0, [v11.vendor] = 0.5, [v11.blessing] = 0.5, [v11.retrieve] = 0.5 }
local vendor = v11.vendor
v24[vendor] = {
	[v11.vendor] = 0,
	[v11.blessing] = 0.1,
	[v11.retrieve] = 0,
	[v11.clearcamp] = 2,
	[v11.clearlargecamp] = 2,
	[v11.retrievebomb] = 0.1,
	[v12.cages] = 2,
	[v12.puzzles] = 2,
	[v12.corrupt] = 2
}
local clearcorruption = v11.clearcorruption
v24[clearcorruption] = { [v11.sabpolluter] = 1.5, [v11.clearcorruption] = 2 }
local v25 = {}
local blessing2 = v11.blessing
v25[blessing2] = { [v11.retrieve] = 2, [v11.vendor] = 2 }
local retrieve2 = v11.retrieve
v25[retrieve2] = { [v11.retrieve] = 0.5, [v11.blessing] = 2, [v11.vendor] = 2 }
local vendor2 = v11.vendor
v25[vendor2] = { [v11.blessing] = 2, [v11.retrieve] = 2 }
local gather2 = v11.gather
v25[gather2] = { [v11.retrieve] = 1.5, [v11.vendor] = 1.5, [v11.blessing] = 1.5 }
local retrievebomb2 = v11.retrievebomb
v25[retrievebomb2] = { [v11.retrieve] = 2, [v11.vendor] = 2, [v11.blessing] = 2 }
local v26 = {
	[v11.retrieve] = { 0.1 },
	[v11.blessing] = { 0.1 },
	[v11.vendor] = { 0.1 }
}
local v27 = {}
local bear = v13.bear
v27[bear] = { [v11.sabincense] = 1.5, [v11.sabpolluter] = 2, [v11.knights] = 2 }
local stag = v13.stag
v27[stag] = { [v11.sabincense] = 1.5, [v11.sabpolluter] = 2, [v11.knights] = 2 }
local retrieve3 = v11.retrieve
v27[retrieve3] = {
	[v11.intel] = 2,
	[v11.intelenemydrop] = 3,
	[v11.clearlargecamp] = 3,
	[v11.clearcamp] = 2,
	[v11.blessing] = 0,
	[v11.vendor] = 0,
	[v11.gather] = 0
}
local sabcannon = v11.sabcannon
v27[sabcannon] = { [v11.retrievebomb] = 1000 }
local cages = v12.cages
v27[cages] = { [v11.vendor] = 0, [v11.clearlargecamp] = 0.2 }
local puzzles = v12.puzzles
v27[puzzles] = { [v11.vendor] = 0, [v11.clearlargecamp] = 0.2 }
local corrupt = v12.corrupt
v27[corrupt] = { [v11.sabpolluter] = 3, [v11.clearcorruption] = 3, [v11.knights] = 2 }
local sabincense2 = v11.sabincense
v27[sabincense2] = { [v11.clearcamp] = 0.5 }
local sprout = v13.sprout
v27[sprout] = { [v11.sprout] = 3 }
local knights = v11.knights
v27[knights] = { [v11.sabpolluter] = 3, [v11.clearcorruption] = 3 }
local v28 = { [v11.retrieve] = 0.25, [v11.vendor] = 0.25, [v11.retrievebomb] = 3 }
local v29 = {
	[v11.retrievebomb] = { v11.sabcannon },
	[v11.cryptkey] = { v12.crypt }
}
local v30 = {
	[v11.sabcannon] = { v11.retrievebomb },
	[v12.crypt] = { v11.cryptkey }
}
local v31 = {
	[v13.stag] = WeakResource("/SF/Types/Quests/TCDemoQuest"),
	[v13.bear] = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest"),
	[v13.sprout] = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest"),
	[v11.sprout] = WeakResource("/SF/Types/Quests/OmenBeastQuests/BromiusQuest")
}
local v32 = {}
local v62 = nil
local v63 = nil
local v64 = nil
local flag = false
local v65 = nil
local activeTales = nil
local encHints = {}
local missionTags = {}
local v67 = nil
local total = 0
local v68 = nil
local v69 = nil
local v70 = nil
local v71 = nil
local v72 = {}
local v73 = nil
local v74 = {
	{
		{
			locationId = "FonnishFortRuins",
			missionTag = Symbol("MT_INTEL"),
			nextNodes = {
				{ p = 1, n = 2 }
			}
		},
		{
			locationId = "NewVisciiEntryCamp",
			missionTag = Symbol("MT_CLEARCAMP"),
			nextNodes = {
				{ p = 1, n = 3 }
			}
		},
		{ locationId = "MendicantKingTestHint", missionTag = Symbol("MT_MENDICANTKING") }
	}
}

local function fn()
	local v75 = {
		{
			{
				locationId = tostring(_T.ForcedTestLocation.encHintTag),
				missionTag = _T.ForcedTestLocation.availableMissionTags[_T.ForcedTestLocation.testSelection]
			}
		}
	}
	return (module9.CreateTale(v70, v75, 1))
end

local function fn2(p)
	if math.random() < 0.9 then
		return
	end

	v70 = v70 or module9.GetPlayerFaction()
	local v75 = tostring(v70)
	local roseTransmissionSet = roseTransmissionSet

	if v75 == "ChampionSyndicate" then
		roseTransmissionSet = kingTransmissionSet
	elseif v75 == "FeySyndicate" then
		roseTransmissionSet = alcaTransmissionSet
	end

	module3.PlayGlobalTransmission(roseTransmissionSet, Symbol(p), false)
end

local function fn3(p, list)
	for _, v75 in ipairs(list) do
		if v75:IsA(v5) then
			return true
		end

		local v76

		if module.IsInNightFold(v75) then
			v76 = v75:__wf_atom_4c2e0189()
		else
			v76 = v75:GetPosition()
		end

		if module.GetRegionIdFromDensityVolume(v76) == p.regionId then
			return true
		end
	end

	return false
end

local function fn4(state)
	if __wf_atom_7e8ad928(v65) then
		print("No usable locations here")
		return false
	end

	local v75 = v65[state.locationId]

	if __wf_atom_7e8ad928(v75) then
		print("No location to prime! " .. state.locationId)
		return false
	end

	local encHint = v75.encHint

	if __wf_atom_7e8ad928(encHint) then
		print("Missing EncounterHint!")
		return false
	end

	if not module5.GetMissionEncounterAllowed(v75.encHint) then
		return false
	end

	local missionTag = state.missionTag

	if __wf_atom_7e8ad928(missionTag) or missionTag == EMPTY_SYMBOL then
		return false
	end

	encHint:Enable()
	encHint:__wf_atom_71694ad6(0)

	if __wf_atom_7e8ad928(v62:PrimeMissionOnHint(missionTag, encHint)) then
		print("Failed to prime encounter " .. state.locationId .. " since it has an existing primed mission " .. tostring(missionTag))
		return false
	end

	if not module.IsInOverworld() then
		module5.AddDungeonObjective(encHint)
	end

	if not encHint:__wf_atom_90813fa0():__wf_atom_7026c43c() then
		module9.EnableEncounterMarker(encHint, true, state.skipSparrow, state)
	end

	if not __wf_atom_7e8ad928(state.marker) then
		if state.marker:__wf_atom_68dff988() == 4 then
			state.marker:__wf_atom_44962dd2(5)
		else
			state.marker:__wf_atom_44962dd2(2)
		end
	end

	encHint:__wf_atom_99a5d75c("OnChildEncStatusChanged", (Symbol(state.locationId .. "EncCallback")))
	encHint:__wf_atom_ed6d3248(v6)
	state.wasPrimed = true
	print("PrimeLocation done")
	return true
end

local function fn5(p, p2)
	local v75 = v65[p2.locationId]

	if __wf_atom_7e8ad928(v75) then
		print("No location to unprime!")
		return false
	end

	if __wf_atom_7e8ad928(v75.encHint) then
		print("No EncounterHint!")
		return false
	end

	local encHintTag = tostring(v75.encHintTag)
	print("Unpriming location " .. encHintTag)
	v75.encHint:__wf_atom_75628d88(EMPTY_SYMBOL)

	if v75.encHint:IsA(v2) then
		v75.encHint:Disable()
	end

	v75.encHint:__wf_atom_68e563a5(v6)
	module7.RemoveHudTask(p, p.hudId, module9.GetObjectiveIdFromNode(p2), 3.7)
	module7.RemoveHudTask(p, p.hudId, encHintTag .. "_or", 3.7)
	module9.EnableEncounterMarker(v75.encHint, false)
	module2.RemoveSparrowDestination(v75.encHint, module9.SparrowDestId(v75))
	module7.RemoveHudTask(v75.encHint, nil, nil, 3.7)
	return true
end

local function fn6(data, p)
	local path = data.paths[1]

	if path == nil or #path == 0 or data.state < module9.STATE.ACCEPTED then
		return
	end

	local nodeIndex = 1

	while path[nodeIndex] ~= nil and path[nodeIndex].completed do
		nodeIndex += 1
	end

	local nodes = {}

	if v64 then
		for k, v77 in path do
			local desc = v77.desc
			local v78 = {}

			for k2, descParam in pairs(v77.descParams) do
				v78[k2] = Localize(descParam, nil)
			end

			table.insert(nodes, (Localize(desc, v78)))

			if not (v77.pairedNodes ~= nil and #v77.pairedNodes > 0) then
				continue
			end

			for i = 1, #v77.pairedNodes do
				local v79 = data.paths[v77.pairedNodes[i].p][v77.pairedNodes[i].n]

				if v79 == nil then
					continue
				end

				local desc2 = v79.desc
				local v80 = {}

				for k2, descParam in pairs(v79.descParams) do
					v80[k2] = Localize(descParam, nil)
				end

				local v81 = Localize(desc2, v80)
				nodes[k] ..= "\r\n" .. Localize("/SF/Language/Objectives/Or", false) .. "\r\n" .. Localize(v81, false)
			end
		end
	else
		local v77 = {}

		for k, descParam in pairs(path[nodeIndex].descParams) do
			v77[k] = Localize(descParam, nil)
		end

		nodes = { Localize(path[nodeIndex].desc, v77) }
	end

	local node = path[nodeIndex]

	if node == nil then
		return
	end

	local v78 = {}

	for k, descParam in pairs(node.descParams) do
		v78[k] = Localize(descParam, nil)
	end

	local shortDesc = Localize(node.desc, v78)
	module11.AddTalesEntry(data.hudId, {
		Name = data.name,
		Nodes = nodes,
		Data = {
			Entity = data,
			Id = data.hudId,
			NodeIndex = nodeIndex,
			Node = node,
			ShortDesc = shortDesc,
			Tale = data
		}
	}, p)
end

local function fn7(state, list)
	if list == nil or #list == 0 then
		return
	end

	if __wf_atom_7e8ad928(v63) or module.IsInOverworld() ~= v64 then
		print("Streaming during PrimeNodes")
		return
	end

	local flag2 = false

	for i, v75 in ipairs(list) do
		if not fn4(v75) then
			continue
		end

		if v64 and i > 1 then
			local v76 = v75
			local v77 = i
			table.insert(v72, {
				delay = 4,
				Update = function()
					local v78 = v76.locationId .. "_or"
					module7.AddHudTask(
						state,
						state.hudId,
						v78,
						"/SF/Language/Objectives/Or",
						nil,
						false,
						nil,
						3,
						v77 * 2 - 1
					)
				end
			})
		end

		local v76 = v75
		local v77 = i

		local function fn8()
			module7.AddHudTask(
				state,
				state.hudId,
				module9.GetObjectiveIdFromNode(v76),
				v76.desc,
				nil,
				false,
				nil,
				nil,
				v77 * 2,
				{ TextParams = v76.descParams }
			)
		end

		if v64 then
			table.insert(v72, { delay = 4, Update = fn8 })
		else
			fn8()
		end

		flag2 = true

		if state == nil then
			continue
		end

		local path = state.paths[1]
		local v79 = 1

		while path[v79] ~= nil and path[v79].completed do
			v79 += 1
		end

		fn6(state)
		state.nextNodePos = v65[v75.locationId].encPos
		module6.TrackTaleNodePrimed(state, v75, v65[v75.locationId].encHint, i, v79)
	end

	if flag2 then
		local name

		if #list == 1 then
			local _
			name, _ = module9.GetNameAndDescriptionForNode(list[1], v65)
		else
			name = "/SF/Language/Objectives/ChoosePath"
		end

		if v64 and state ~= nil then
			name = state.name
		end

		table.insert(v72, {
			delay = 4,
			Update = function()
				module7.AddHudTitle(state, state.hudId, name)
			end
		})
		module7.SetGroupPriority(state, state.hudId, module7.HUD_PRIORITY.JOB_ACTIVE)
	end
end

local function fn8(p, p2)
	local v75 = p.paths[p2.p][p2.n]
	v75.unreachable = true

	if not __wf_atom_7e8ad928(v75.marker) and v75.marker:__wf_atom_68dff988() ~= 7 then
		v75.marker:__wf_atom_44962dd2(7)
	end

	if not v73 then
		fn5(p, v75)
	end
end

local function fn9(state, node)
	for _, pairedNode in ipairs(node.pairedNodes) do
		local v75 = state.paths[pairedNode.p][pairedNode.n]

		for _, nextNode in ipairs(v75.nextNodes) do
			if nextNode.p ~= pairedNode.p then
				continue
			end

			local v76 = false

			for i, list in ipairs(state.paths) do
				if i == pairedNode.p then
					continue
				end

				for _, v77 in ipairs(list) do
					for _, nextNode2 in ipairs(v77.nextNodes) do
						if not (nextNode2.p == nextNode.p and nextNode2.n == nextNode.n) then
							continue
						end

						v76 = true
						break
					end
				end
			end

			if not v76 then
				fn8(state, nextNode)
			end
		end

		fn8(state, pairedNode)
	end
end

local function fn10(paths, mEncounterIdx, mDifficultyTier)
	local encounterPath = SF.EncounterPath()
	encounterPath.mEncounterIdx = mEncounterIdx
	encounterPath.mDifficultyTier = mDifficultyTier
	local encounterPathNodes = {}

	for _, list in ipairs(paths) do
		for _, v75 in ipairs(list) do
			local locationId = v75.locationId

			if not __wf_atom_7e8ad928(v75.overworldLocationId) then
				locationId = v75.overworldLocationId
			end

			local encounterPathNode = SF.EncounterPathNode(Symbol(locationId), v75.missionTag)
			encounterPathNode.mCompleted = v75.completed == true
			local mNextNodes = {}

			for _, nextNode in ipairs(v75.nextNodes) do
				table.insert(mNextNodes, (Symbol(paths[nextNode.p][nextNode.n].locationId)))
			end

			encounterPathNode.mNextNodes = mNextNodes
			table.insert(encounterPathNodes, encounterPathNode)
		end
	end

	encounterPath.mPath = encounterPathNodes
	return encounterPath
end

local function fn11(object, p)
	if not __wf_atom_7e8ad928(object) then
		if not p and object.state >= module9.STATE.INPROGRESS then
			local pathId = object.pathId
			gGameData:__wf_atom_47a4a85f(v70, pathId, nil, 0, 0)
			gGameRules:CommitInventoryCheckpointToDB(0, 0)
		end

		local path = object.paths[1]
		local locationId = path[#path].locationId
		local v75 = v65[locationId]

		if object.state >= module9.STATE.ACCEPTED and not __wf_atom_7e8ad928(v75) then
			table.insert(encHints, v75.encHint)

			if #encHints > 6 then
				table.remove(encHints, 1)
			end

			for _, list in ipairs(object.paths) do
				for _, v76 in ipairs(list) do
					if not __wf_atom_7e8ad928(v76.marker) then
						v76.marker:Destroy()
					end

					if not fn5(object, v76) then
						continue
					end

					local markerType2 = module9.GetMarkerTypeForNode(v76, v65)

					if __wf_atom_7e8ad928(markerType2) then
						markerType2 = markerType
					end

					local v77 = v65[v76.locationId]
					local registeredObjectsOfType = module5.GetRegisteredObjectsOfType(v77.encHint, markerType2)

					for _, v78 in ipairs(registeredObjectsOfType) do
						v78:Destroy()
					end

					module9.ReserveHint(v77.encHint, false)
				end
			end

			if not __wf_atom_7e8ad928(object.startObject) then
				object.startObject:Destroy()
			end

			if not __wf_atom_7e8ad928(object.acceptedMarker) then
				object.acceptedMarker:Destroy()
			end
		end

		if object.state >= module9.STATE.ACCEPTED then
			local function fn12()
				module7.RemoveHudGroup(object, object.hudId)
			end

			if p then
				object.paused = true
			else
				table.insert(v72, { delay = 3.7, Update = fn12 })
				module11.RemoveTalesEntry(object.hudId)
				object:SetIsTracked(false)
			end

			module2.RemoveAllDestinationsForTale(object.hudId)
			module6.TrackTaleEnd(object, object.state == module9.STATE.ABANDONED)
		end

		for i = #activeTales, 1, -1 do
			if activeTales[i] == object then
				table.remove(activeTales, i)
			end
		end
	end

	module2.RefreshSparrowDestinations()
	_T.ProgressionScreenDisabled = false
	_T.RefreshJobBoard = true
end

local function fn12(state)
	if __wf_atom_7e8ad928(state) then
		print("Removing saved long tale")
	end

	v70 = module9.GetPlayerFaction()

	if v70 == EMPTY_SYMBOL then
		return
	end

	if not module.IsInOverworld() then
		print("Early out for streaming in SaveNewTale")
		return
	end

	if state.pathId >= 10 then
		print("TEMP ID CHANGE TO PREVENT ENDLESS ACCOUNT ARRAY")
		state.pathId %= 10
	end

	local paths = nil
	local encounterSchema = nil
	local pathId = 0

	if __wf_atom_7e8ad928(state) then
		for i = #activeTales, 1, -1 do
			if not (activeTales[i].state >= module9.STATE.ACCEPTED) then
				continue
			end

			encounterSchema = activeTales[1].encounterSchema
			paths = activeTales[1].paths
			pathId = activeTales[1].pathId or 0
			break
		end
	else
		encounterSchema = state.encounterSchema
		paths = state.paths
		pathId = state.pathId or 0
	end

	local v75 = flag and __wf_atom_7e8ad928(encounterSchema) and {
			mEncounterIdx = 0,
			mDifficultyTier = 0
		}
		or encounterSchema

	if __wf_atom_7e8ad928(paths) or __wf_atom_7e8ad928(v75) then
		gGameData:__wf_atom_47a4a85f(v70, pathId, nil, 1, 0)
		print("Cleared existing saved tale path")
	else
		local mEncounterIdx = not v75 and 0 or v75.mEncounterIdx or 0
		local mDifficultyTier = v75 and v75.mDifficultyTier or 0
		local v77 = fn10(paths, mEncounterIdx, mDifficultyTier)
		local secondCount = module8.GetSecondCount()
		gGameData:__wf_atom_47a4a85f(v70, pathId, v77.mPath, v77.mEncounterIdx, v77.mDifficultyTier)
		gGameData:__wf_atom_5a4536e1(v70, pathId, secondCount)
		state.startTime = secondCount
		print("Saved new tale path")
		module9.LogSavedPath(v77)
	end

	gGameRules:CommitInventoryCheckpointToDB(0, 0)

	if not __wf_atom_7e8ad928(state) then
		state.state = module9.STATE.INPROGRESS
	end
end

local function fn13(state)
	local missionTag = state.missionTag
	local v75 = {}
	local v76 = {}

	for k, v77 in pairs(v65) do
		for _, availableMissionTag in ipairs(v77.availableMissionTags) do
			if availableMissionTag == missionTag then
				table.insert(v75, {
					id = k,
					missionTag = availableMissionTag,
					encHint = v77.encHint
				})
			end
		end
	end

	if #v75 == 0 and #v76 == 0 then
		print("No available locations here")
		return false
	end

	local v77 = Symbol("Objective")

	for i = #v75, 1, -1 do
		local __wf_atom_e800787c = v75[i].encHint:__wf_atom_e800787c()

		if not (__wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= v77) then
			continue
		end

		table.insert(v76, v75[i])
		table.remove(v75, i)
	end

	local v78

	if #v75 > 0 then
		v78 = v75[__wf_atom_5784a397(1, #v75)]
	elseif #v76 > 0 then
		local function fn14(p, p2)
			return v62:__wf_atom_5e5adb53(p.encHint) > v62:__wf_atom_5e5adb53(p2.encHint)
		end

		table.sort(v76, fn14)
		v78 = v76[1]
	else
		return false
	end

	state.overworldLocationId = state.locationId
	state.locationId = tostring(v65[v78.id].encHintTag)
	state.missionTag = v78.missionTag
	return true
end

local function fn14(p, p2)
	if __wf_atom_7e8ad928((gRegion:__wf_atom_0a6a5887(p.mLocationTag))) then
		if v64 then
			print("Nil EncounterHint " .. p2.locationId)
			return false
		end
	else
		if __wf_atom_7e8ad928(v65[p2.locationId]) then
			print("Can't find location " .. p2.locationId)
			return false
		end

		local availableMissionTags = v65[p2.locationId].availableMissionTags

		if #availableMissionTags > 0 and not module.IsInTable(p2.missionTag, availableMissionTags) then
			print("Mission tag " .. tostring(p.mMissionTag) .. " no longer exists on hint " .. p2.locationId)
			return false
		end
	end

	return true
end

local function fn15(p)
	if module5.GetSubbossEncounterTemplateName(p) ~= nil then
		local subBossTimerSymb = module5.GetSubBossTimerSymb(p, module5.IsHardModeActive())

		if not (__wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_b3cdb701(subBossTimerSymb)) then
			return true
		end
	end

	return false
end

local function fn16(finalHint)
	if module5.GetSubbossEncounterTemplateName(finalHint) ~= nil then
		local subBossTimerSymb = module5.GetSubBossTimerSymb(finalHint, module5.IsHardModeActive())

		if not __wf_atom_7e8ad928(gGameData) and gGameData:__wf_atom_b3cdb701(subBossTimerSymb) then
			return true
		end
	end

	return false
end

local function fn17(p)
	v70 = module9.GetPlayerFaction()

	if v70 == EMPTY_SYMBOL then
		return
	end

	print("Unpacking Affiliation " .. tostring(v70))
	v71 = gGameData:__wf_atom_51dd1b95(v70)
	local v75

	if flag and p ~= nil then
		v71.mEncounterPaths = { p }
		v75 = true
	end

	if #v71.mEncounterPaths == 0 then
		return
	end

	local secondCount = module8.GetSecondCount()
	local flag2 = false

	if v64 and not v75 then
		v73 = true

		for i = #v71.mEncounterPaths, 1, -1 do
			local v76 = i - 1
			local __wf_atom_56ec30cb = gGameData:__wf_atom_56ec30cb(v70, v76)
			local mEncounterPath = v71.mEncounterPaths[i]

			if not (__wf_atom_7e8ad928(mEncounterPath) or __wf_atom_56ec30cb + module9.expiryTime < secondCount or __wf_atom_7e8ad928(mEncounterPath.mPath) or #mEncounterPath.mPath == 0) then
				continue
			end

			gGameData:__wf_atom_47a4a85f(v70, v76, nil, 0, 0)
			gGameRules:CommitInventoryCheckpointToDB(0, 0)
			table.remove(v71.mEncounterPaths, i)
			flag2 = true
		end
	end

	for i = 1, #v71.mEncounterPaths do
		print("Unpacking pathId " .. i)
		local mEncounterPath = v71.mEncounterPaths[i]
		local v76 = 1
		local v77 = {}
		local pathId = i - 1

		if __wf_atom_7e8ad928(mEncounterPath.mPath) or #mEncounterPath.mPath == 0 then
			continue
		end

		for _, v79 in ipairs(mEncounterPath.mPath) do
			local v80 = {
				locationId = tostring(v79.mLocationTag),
				missionTag = Symbol(v79.mMissionTag),
				completed = v79.mCompleted,
				nextNodes = {}
			}
			v80.tempNextNodeSymbols = v79.mNextNodes

			if not fn14(v79, v80) then
				continue
			end

			if __wf_atom_7e8ad928(v77[v76]) then
				v77[v76] = {}
			end

			print("ReconstructedNode node " .. v80.locationId .. " missionTag " .. tostring(v80.missionTag) .. " completed " .. tostring(v80.completed))
			table.insert(v77[v76], v80)

			if #v79.mNextNodes == 0 then
				v76 += 1
			end
		end

		if not (#v77 > 0) then
			continue
		end

		local v79 = {
			mEncounterIdx = mEncounterPath.mEncounterIdx,
			mDifficultyTier = mEncounterPath.mDifficultyTier
		}
		local v80 = math.min(#v77[1], 3)
		local tale = module9.CreateTale(v70, v77, v80, v79)
		tale.pathId = pathId
		tale.startTime = gGameData:__wf_atom_56ec30cb(v70, pathId)
		tale.introDialogPlayed = true

		if v64 then
			local firstHint = tale:GetFirstHint()

			if firstHint ~= nil then
				local position = firstHint:GetPosition()
				local regionId = module.GetRegionIdFromDensityVolume(position)
				local jobBoardsInRegion = module9.GetJobBoardsInRegion(regionId)
				tale.jobBoardAction = module.NearestObject(position, jobBoardsInRegion, nil, true)
			end
		end

		if fn16(tale:GetFinalHint()) then
			print("Subboss recently defeated, removing tale!")
		else
			print("Unpacked saved tale path")
			tale:SetState(module9.STATE.ACCEPTED)
			table.insert(activeTales, tale)
			module9.LogSavedPath(mEncounterPath)
			module9.CreateTalePathMarkers(tale, v65)

			if flag2 then
				fn12(tale)
			end

			v67 = v67 or {}

			for j, list in ipairs(tale.paths) do
				for k, node in ipairs(list) do
					if not node.completed or node.unreachable then
						continue
					end

					table.insert(v67, { node = node, t = tale.pathId, p = j, n = k })
				end
			end

			if v64 then
				fn6(tale)
			end

			module6.TrackTaleStart(tale, true)

			if not v64 then
				local activeDungeonTaleInfo, _, v81 = module10.GetActiveDungeonTaleInfo()

				if not __wf_atom_7e8ad928(activeDungeonTaleInfo) then
					for _, v82 in ipairs(activeTales) do
						for _, list in ipairs(v82.paths) do
							for _, v84 in ipairs(list) do
								if v84.completed or v84.missionTag ~= v81 or not fn13(v84) then
									continue
								end

								module7.RemoveHudTask(v82, v82.hudId, module9.GetObjectiveIdFromOverworld(v84))
								local nameAndDescriptionForNode, desc, descParams = module9.GetNameAndDescriptionForNode(v84)
								v82.name = nameAndDescriptionForNode
								v82.desc = desc
								v82.descParams = descParams
								local nameAndDescriptionForNode2, desc2, descParams2 = module9.GetNameAndDescriptionForNode(v84)
								v84.name = nameAndDescriptionForNode2
								v84.desc = desc2
								v84.descParams = descParams2
								v82:SetState(module9.STATE.INPROGRESS)
								fn7(v82, { v84 })
								break
							end
						end
					end
				end
			end
		end
	end
end

local function fn18(p, p2)
	local locationId = p2.locationId

	if not __wf_atom_7e8ad928(p2.overworldLocationId) then
		locationId = p2.overworldLocationId
	end

	local pathId = p.pathId
	v70 = module9.GetPlayerFaction()
	local v75

	if v70 ~= EMPTY_SYMBOL then
		v71 = gGameData:__wf_atom_51dd1b95(v70)

		if pathId < #v71.mEncounterPaths then
			v75 = v71.mEncounterPaths[pathId + 1]
		else
			v75 = SF.EncounterPath()
		end
	end

	if v75 then
		for _, v76 in ipairs(v75.mPath) do
			if tostring(v76.mLocationTag) ~= locationId then
				continue
			end

			gGameData:CompleteEncounterPathNode(v70, p.pathId, v76.mLocationTag)
			print("SetNodeDbCompleted: Faction " .. tostring(v70) .. "Location " .. tostring(v76.mLocationTag) .. " pathId " .. tostring(p.pathId) .. " completed")

			if #v76.mNextNodes == 0 then
				local v77 = v64 and 0 or 1
				gGameRules:CommitInventoryCheckpointToDB(0, 0, v77)
			end

			return
		end
	end
end

local function fn19(encHint, p, p2)
	if __wf_atom_7e8ad928(encHint) then
		return
	end

	local v75 = math.max(encHint:__wf_atom_4a0ffa6e(), 150)
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local enemyLevel = module5.GetEnemyLevel(encHint)
	local v76 = Range(1, 20)
	local v77 = Range(1000, 3000)
	local v78 = __wf_atom_421b01aa((enemyLevel.maxValue - v76.minValue) / (v76.maxValue - v76.minValue), 0, 1)
	local v79 = __wf_atom_104bfe98(v77.minValue, v77.maxValue, v78)
	local rounded = module.Round(v79, -2)
	print("Rewards for hint " .. tostring(encHint:__wf_atom_db682341()))
	_T.FactionTaleXpHack = 1000
	local isInOverworld = module.IsInOverworld()

	for _, v80 in pairs(__wf_atom_3c8e1a7a) do
		local playerAvatar = v80:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

		if
			__wf_atom_7e8ad928(__wf_atom_d2b2176d)
			or not (not isInOverworld or playerAvatar:__wf_atom_1c8f7b2d(encHint) <= v75)
		then
			continue
		end

		__wf_atom_d2b2176d:__wf_atom_355b9a20(rounded, playerAvatar, EMPTY_SYMBOL)
	end

	if p2.state >= module9.STATE.ACCEPTED then
		fn18(p2, p)
	end
end

function TaleNpcChildScript(instance)
	local position = instance:GetPosition()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v75 = 60

	while not __wf_atom_7e8ad928(instance) do
		if #__wf_atom_7d789620:__wf_atom_3fe13ea3(position, 120) == 0 then
			v75 -= 5
		end

		if v75 <= 0 then
			instance:Destroy()
			break
		else
			Sleep(5)
		end
	end
end

local function fn20(object)
	if not v64 then
		_T.CreateTaleNpcAtDungeonExit = true
		return
	end

	if __wf_atom_7e8ad928(v70) or v70 == EMPTY_SYMBOL or module9.ShouldStopEncounters() then
		return
	end

	local v75 = tostring(v70)
	local v76 = ({
		SilentRoseSyndicate = npcTypesRose,
		ChampionSyndicate = npcTypesKing,
		FeySyndicate = npcTypesAlca
	})[v75]
	local v77 = v76[__wf_atom_5784a397(1, #v76)]
	local v78 = nil

	if __wf_atom_7e8ad928(v77) then
		print("No tale npc available for this faction! " .. v75)
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		print("No player avatar found!")
		return
	end

	local position, v79

	if _T.CreateTaleNpcAtDungeonExit then
		position = __wf_atom_c4f78a8f:GetPosition()
		v79 = Range(30, 50)
		_T.CreateTaleNpcAtDungeonExit = nil
	else
		local v80 = WeakResource("/SF/Types/Gameplay/DungeonEntranceWaypoint")
		local all = gRegion:FindAll(v80, __wf_atom_c4f78a8f:GetPosition(), 0, 50)

		if not __wf_atom_7e8ad928(all) and #all > 0 then
			return
		end

		if __wf_atom_7e8ad928(object) then
			position = __wf_atom_c4f78a8f:GetPosition()
			v79 = Range(30, 50)
			v78 = gRegion:__wf_atom_f738b4af(v8, position, 10, 100)

			if not (__wf_atom_7e8ad928(v78) or v78:IsEnabled()) then
				v78 = nil
			end
		else
			position = v65[object:GetFinalNode().locationId].encHint:GetPosition()
			v79 = Range(50, 70)
		end
	end

	local v80

	if __wf_atom_7e8ad928(v78) then
		local __wf_atom_28ce676a = v62:__wf_atom_28ce676a()
		__wf_atom_28ce676a:__wf_atom_267bfc41(position, v79, 8)
		__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
		__wf_atom_28ce676a:__wf_atom_4a7833f4()
		__wf_atom_28ce676a:__wf_atom_655394dc()
		__wf_atom_28ce676a:__wf_atom_06c7577b()
		__wf_atom_28ce676a:__wf_atom_7e9d12f8(40)
		__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
		__wf_atom_28ce676a:__wf_atom_bacad54b()
		__wf_atom_28ce676a:__wf_atom_9699b67c(false)
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
		__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("TaleStartSpawn"), Color("0xFF00FF"))
		v80 = module13.GetPositions(8, __wf_atom_28ce676a)
		local __wf_atom_5e5adb53 = v62:__wf_atom_5e5adb53(v63)

		for i = #v80, 1, -1 do
			if v62:__wf_atom_3c9cb048(v80[i]) ~= __wf_atom_5e5adb53 then
				table.remove(v80, i)
			end
		end

		if #v80 == 0 then
			print("Nowhere to spawn the tale npc!")
			return
		end
	end

	local v81 = __wf_atom_c4f78a8f or gRegion:__wf_atom_c4f78a8f()
	local position2, v82

	if __wf_atom_7e8ad928(v78) then
		if __wf_atom_7e8ad928(v81) then
			local v83 = v80[__wf_atom_5784a397(1, #v80)]
			position2 = module14.GetGroundPos(v83)
			v82 = __wf_atom_fa8d0177(position2, position)
		else
			local position3 = v81:GetPosition()
			local nearestPositionToObject = module.NearestPositionToObject(v81, v80, nil, true)
			position2 = module14.GetGroundPos(nearestPositionToObject)
			v82 = __wf_atom_fa8d0177(position2, position3)
			v82.bank = 0
			v82.pitch = 0
		end
	else
		position2 = v78:GetPosition()
		v82 = __wf_atom_fa8d0177(position2, position)
		v78:Disable()
	end

	local entity = gRegion:CreateEntity(v77, position2, v82)
	local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_0f520c3c)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:Enable()
		__wf_atom_bb3e7833:__wf_atom_44962dd2(1)
	end

	entity:__wf_atom_8a035cd5(Symbol("TaleNpcChildScript"), false)
	module2.AddSparrowDestination(entity, v63, "TaleEndNpc", module2.PRIORITY.HIGH, Range(0, 100))
end

local function fn21()
	if __wf_atom_7e8ad928(v70) or v70 == EMPTY_SYMBOL then
		return
	end

	local v75 = tostring(v70)
	local v76 = {
		SilentRoseSyndicate = npcTypesRose,
		ChampionSyndicate = npcTypesKing,
		FeySyndicate = npcTypesAlca
	}
	local v77 = {
		SilentRoseSyndicate = Symbol("SilentRoseEntrance"),
		ChampionSyndicate = Symbol("KithOfKingsEntrance"),
		FeySyndicate = Symbol("AlcasChildrenEntrance")
	}
	local v78 = v76[v75][1]

	if __wf_atom_7e8ad928(v78) then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(v77[v75])

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v8, __wf_atom_0a6a5887:GetPosition(), 0, 50)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			local entity = gRegion:CreateEntity(
				v78,
				__wf_atom_f738b4af:GetPosition(),
				__wf_atom_f738b4af:__wf_atom_dc309f8a()
			)
			local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_0f520c3c)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				__wf_atom_bb3e7833:Destroy()
			end

			module2.AddSparrowDestination(entity, v63, "TaleHubEntranceNpc", module2.PRIORITY.HIGH, Range(0, 100))
		end
	end
end

local function fn22(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if __wf_atom_7e8ad928(v69) then
		v69 = {}

		for _, v76 in ipairs({ v11, v12, v13 }) do
			for _, v77 in pairs(v76) do
				if flag then
					table.insert(v69, Symbol(v77))
				elseif not module.IsInTable(v77, v32) then
					table.insert(v69, Symbol(v77))
				end
			end
		end
	end

	local __wf_atom_e370bfde = object:__wf_atom_e370bfde()

	for i = #__wf_atom_e370bfde, 1, -1 do
		local v75 = false

		for _, v77 in ipairs(v69) do
			if __wf_atom_e370bfde[i] ~= v77 then
				continue
			end

			v75 = true
			break
		end

		if not v75 then
			table.remove(__wf_atom_e370bfde, i)
		end
	end

	for i = #__wf_atom_e370bfde, 1, -1 do
		for k, v76 in pairs(v31) do
			if tostring(__wf_atom_e370bfde[i]) ~= k or module4.HasCompletedQuest(v76) then
				continue
			end

			table.remove(__wf_atom_e370bfde, i)
			break
		end
	end

	return __wf_atom_e370bfde
end

local function fn23(p, p2, p3)
	for _, v75 in ipairs(activeTales) do
		if not (__wf_atom_7e8ad928(p3) or v75.regionId == p3) then
			continue
		end

		for _, list in ipairs(v75.paths) do
			for _, v76 in ipairs(list) do
				if __wf_atom_7e8ad928(v65[v76.locationId].encHint) then
					continue
				end

				if tostring(p.encHintTag) == v76.locationId or p.encHint:IsPrimed() then
					return true
				end

				if not p2 then
					continue
				end

				local __wf_atom_1c8f7b2d = p.encHint:__wf_atom_1c8f7b2d(v65[v76.locationId].encHint)

				if __wf_atom_1c8f7b2d <= v9.minValue or __wf_atom_1c8f7b2d <= p.encHint:__wf_atom_8f18e876() then
					return true
				end
			end
		end
	end

	return false
end

local function fn24(p, p2, p3, p4)
	local v75 = p2 or v14
	local result = {}
	local v76 = 0
	local v77 = {}
	local __wf_atom_277481bd = v62:__wf_atom_277481bd(Symbol("PostBromiusQuest"))
	local v78 = WeakResource("/SF/Types/Game/Encounters/Locations/DungeonEntranceHintNeathuns")

	if __wf_atom_7e8ad928(_T.DevSelectedNodeInfo) then
		for k, v79 in pairs(v65) do
			if
				__wf_atom_7e8ad928(v79.encHint)
				or p ~= v79.regionId
				or not (__wf_atom_7e8ad928(p3) or not (v79.level.minValue < p3))
			then
				continue
			end

			if not ((__wf_atom_277481bd or not v79.encHint:IsA(v78)) and (v79.isSubboss or not fn15(v79.encHint))) then
				continue
			end

			if
				module.IsInTable(v79.encHint, encHints)
				or not module5.GetMissionEncounterAllowed(v79.encHint)
				or fn23(v79, true, p)
			then
				continue
			end

			if v79.isDungeonEntrance then
				if not __wf_atom_7e8ad928(p4) and v79.encHint:__wf_atom_b3bb0c43(p4.maxValue) == 0 then
					continue
				end
			elseif v79.assignedJobBoard == nil or v79.assignedJobBoard ~= _T.currentJobBoard then
				if v79.encHint:__wf_atom_b3bb0c43(v79.encHint:__wf_atom_8f18e876()) > 0 then
					continue
				end

				if not (__wf_atom_7e8ad928(p4) or __wf_atom_7e8ad928(_T.currentJobBoard)) then
					local __wf_atom_1c8f7b2d = _T.currentJobBoard:__wf_atom_1c8f7b2d(v79.encHint)

					if __wf_atom_1c8f7b2d < p4.minValue or p4.maxValue < __wf_atom_1c8f7b2d then
						continue
					end
				end
			else
				print("Found assigned job board")
			end

			for _, availableMissionTag in ipairs(v79.availableMissionTags) do
				local v80 = tostring(availableMissionTag)

				if not module.IsInTable(v80, v75) then
					continue
				end

				if module.IsInTable(v80, missionTags) and v80 ~= v13.subboss then
					if __wf_atom_7e8ad928(v77[v80]) then
						v77[v80] = {}
					end

					table.insert(v77[v80], k)
				else
					if __wf_atom_7e8ad928(result[v80]) then
						result[v80] = {}
					end

					table.insert(result[v80], k)
					v76 += 1
				end
			end
		end
	else
		local missionTag = tostring(_T.DevSelectedNodeInfo.missionTag)

		if __wf_atom_7e8ad928(result[missionTag]) then
			result[missionTag] = {}
		end

		table.insert(result[missionTag], (tostring(_T.DevSelectedNodeInfo.tag)))
		v76 = 1
	end

	if v76 == 0 then
		result = v77
	end

	return result
end

local function fn25(state)
	local id = state.id
	local v75 = v65[id]

	if not __wf_atom_7e8ad928(v75.connections) and #v75.connections > 0 then
		return
	end

	v75.connections = {}
	local dist = 3.4028234663852886e38
	local id2 = nil

	for k, v78 in pairs(v65) do
		if id == k or v75.regionId ~= v65[k].regionId or __wf_atom_7e8ad928(v78.encHint) then
			continue
		end

		local v79 = false

		if not __wf_atom_7e8ad928(v78.connections) and #v78.connections > 0 then
			for _, connection in ipairs(v78.connections) do
				if connection.id ~= id then
					continue
				end

				table.insert(v75.connections, { id = k, dist = connection.dist })
				v79 = true
				break
			end
		end

		if v79 then
			continue
		end

		local v80 = v9

		if v78.isDungeonEntrance or v65[k].isDungeonEntrace then
			v80 = v10
		end

		local __wf_atom_a5304c35 = v78.encHint:__wf_atom_a5304c35(v75.encPos)

		if v80.minValue <= __wf_atom_a5304c35 and __wf_atom_a5304c35 <= v80.maxValue then
			local __wf_atom_57856d42 = v62:__wf_atom_57856d42(v75.encPos, v78.encPos)

			if not __wf_atom_7e8ad928(__wf_atom_57856d42) and __wf_atom_57856d42 > 0 then
				__wf_atom_a5304c35 = __wf_atom_57856d42
			end
		else
			__wf_atom_a5304c35 = 0
		end

		if not (v80.minValue <= __wf_atom_a5304c35) then
			continue
		end

		if __wf_atom_a5304c35 <= 250 then
			table.insert(v75.connections, { id = k, dist = __wf_atom_a5304c35 })
		end

		if not (__wf_atom_a5304c35 < dist) then
			continue
		end

		id2 = k
		dist = __wf_atom_a5304c35
	end

	if #v75.connections == 0 and dist <= 250 then
		table.insert(v75.connections, { id = id2, dist = dist })
	end

	v75.connections = module12.ShuffleTable(v75.connections)
end

local function fn26(p, p2, p3, list, p4, list2, p5)
	local v75 = tostring(p2)
	tostring(v70)
	local v76 = tostring(v68)
	local v77 = v22[v75] or 1
	local count = 0
	local v78

	if not __wf_atom_7e8ad928(p) then
		v78 = tostring(p)
	end

	for i, v79 in ipairs(list) do
		if (__wf_atom_7e8ad928(list2) or i > 1) and v79.missionTag == p2 then
			count += 1
		end
	end

	if not __wf_atom_7e8ad928(list2) then
		for _, v79 in ipairs(list2) do
			if v79.missionTag == p2 then
				count += 1
			end
		end
	end

	if (v21[v75] or 2) <= count then
		return 0
	end

	if count > 0 then
		if __wf_atom_7e8ad928(v23[v75]) then
			v77 *= 0.4 ^ count
		else
			v77 *= v23[v75] ^ count
		end
	end

	if not (__wf_atom_7e8ad928(v30[v78]) or module.IsInTable(v75, v30[v78])) then
		return 0
	end

	if not __wf_atom_7e8ad928(v29[v75]) then
		local v79 = false

		for _, v80 in ipairs(v29[v75]) do
			if v76 == v80 or v78 == v80 then
				v79 = true
			else
				for _, v82 in ipairs(list) do
					if v82.missionTag ~= p2 then
						continue
					end

					v79 = true
					break
				end
			end
		end

		if not v79 then
			return 0
		end
	end

	if p4 <= 2 and not __wf_atom_7e8ad928(v28[v75]) then
		v77 *= v28[v75]
	end

	if not __wf_atom_7e8ad928(v78) then
		if p3 or __wf_atom_7e8ad928(v24[v78]) or __wf_atom_7e8ad928(v24[v78][v75]) then
			if p3 and not (__wf_atom_7e8ad928(v24[v75]) or __wf_atom_7e8ad928(v24[v75][v78])) then
				v77 *= v24[v75][v78]
			end
		else
			v77 *= v24[v78][v75]
		end
	end

	if v77 == 0 then
		return v77
	end

	if p4 > 2 and not __wf_atom_7e8ad928(p) and p3 and not __wf_atom_7e8ad928(v26[v75]) then
		local v79 = #list == 1 and 3 or #list == p4 - 1 and 1 or 2

		if not __wf_atom_7e8ad928(v26[v75][v79]) then
			v77 *= v26[v75][v79]
		end
	end

	if not __wf_atom_7e8ad928(v27[v68]) then
		if __wf_atom_7e8ad928(v27[v68][v75]) then
			if not __wf_atom_7e8ad928(v27[v68].DEFAULT) then
				v77 *= v27[v68].DEFAULT
			end
		else
			v77 *= v27[v68][v75]
		end
	end

	if v77 == 0 or (__wf_atom_7e8ad928(p5) or __wf_atom_7e8ad928(list2) or not (#list2 > 0)) then
		return v77
	end

	local v79 = list2[p5 + #list]

	if __wf_atom_7e8ad928(v79) then
		return v77
	end

	local missionTag = tostring(v79.missionTag)

	if #list == 1 and v75 == missionTag then
		return 0
	end

	if not (__wf_atom_7e8ad928(v25[missionTag]) or __wf_atom_7e8ad928(v25[missionTag][v75])) then
		return v77 * v25[missionTag][v75]
	end

	if __wf_atom_7e8ad928(v25[v75]) or __wf_atom_7e8ad928(v25[v75][missionTag]) then
		if v75 == missionTag then
			return v77 * 0.2
		end

		return v77
	else
		return v77 * v25[v75][missionTag]
	end
end

local function fn27(connection, list, p, p2)
	for i = 1, #list do
		if connection.id == list[i].id then
			return true
		end

		if p2 == nil then
			continue
		end

		local v75 = v65[list[i].id]

		if p.encHint:__wf_atom_a5304c35(v75.encPos) < p2 then
			return true
		end
	end
end

local function fn28(state, list, p, p2, maxValue, p3, p4, p5)
	local result = {}
	local connections = v65[state.id].connections
	local v75 = v65[state.id]
	local v76

	if #list > 1 then
		v76 = v65[list[#list - 1].id]
	end

	for _, connection in ipairs(connections) do
		local v77 = v65[connection.id]
		local v78 = 1

		if __wf_atom_7e8ad928(v77) or __wf_atom_7e8ad928(v77.encHint) then
			continue
		end

		if not __wf_atom_7e8ad928(p3) and connection.id == p3.id and not __wf_atom_7e8ad928(p3.missionTag) then
			table.insert(result, { id = connection.id, missionTag = p3.missionTag, weight = 1 })
			return result
		end

		if
			__wf_atom_7e8ad928(v75.availableMissionTags)
			or #v75.availableMissionTags == 0
			or p2 and v77.overworldLevel.maxValue > v75.overworldLevel.maxValue
		then
			continue
		end

		if
			not (p2 or not (v75.overworldLevel.maxValue > v77.overworldLevel.maxValue))
			or (v77.encHint:__wf_atom_f43d338d() or v77.encHint:__wf_atom_b3bb0c43(70) > 0)
		then
			continue
		end

		local enRouteMissionTags = v65[connection.id].enRouteMissionTags

		if #enRouteMissionTags == 0 or fn15(v77.encHint) or not module5.GetMissionEncounterAllowed(v77.encHint) then
			continue
		end

		if
			fn23(v77)
			or fn27(connection, list, v77)
			or fn27(connection, p, v77, v9.minValue)
			or fn27(connection, p5, v77, 60)
		then
			continue
		end

		if not __wf_atom_7e8ad928(v76) then
			local encPos = v75.encPos
			local v79 = v76.encPos - encPos
			local v80 = v77.encPos - encPos
			v79.y = 0
			v80.y = 0
			Normalize(v79)
			Normalize(v80)
			local v81 = __wf_atom_d08b2f29(v80, v79)

			if v81 < 70 then
				continue
			end

			if v81 <= 110 and v81 >= 70 then
				local v82 = (v81 - 70) / 40
				v78 = __wf_atom_104bfe98(0.01, 1, v82)
			end
		end

		if not (v78 > 0) then
			continue
		end

		for _, enRouteMissionTag in ipairs(enRouteMissionTags) do
			local weight = fn26(state.missionTag, enRouteMissionTag, p2, list, maxValue, p, p4) * v78

			if weight > 0 then
				table.insert(result, {
					id = connection.id,
					missionTag = enRouteMissionTag,
					weight = weight
				})
			end
		end
	end

	return result
end

local function fn29(list, p, _, p2, p3)
	if p2 then
		local total2 = 0
		local v75 = p3 or v18

		for k, _ in pairs(list) do
			total2 += v75[k] or 1
		end

		local v76 = __wf_atom_8d119bab(0, total2)
		local total3 = 0

		for k, _ in pairs(list) do
			total3 += v75[k] or 1

			if v76 <= total3 then
				return k
			end
		end
	else
		local v75

		if __wf_atom_7e8ad928(p) then
			v75 = #list
		else
			v75 = math.min(#list, p)
		end

		table.sort(list, function(a, b)
			return a.weight > b.weight
		end)
		local total2 = 0

		for i = 1, v75 do
			total2 += list[i].weight
		end

		local v76 = math.random() * total2
		local total3 = 0
		local v77 = 1

		for i = 1, v75 do
			total3 += list[i].weight

			if not (v76 <= total3) then
				continue
			end

			v77 = i
			break
		end

		return v77
	end
end

local function fn30()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local regionId = module.GetRegionIdFromDensityVolume(__wf_atom_c4f78a8f:GetPosition())
	local v75 = {}

	for k, v76 in pairs(v65) do
		if v76.regionId ~= regionId then
			continue
		end

		local __wf_atom_e370bfde = v76.encHint:__wf_atom_e370bfde()

		for i = #__wf_atom_e370bfde, 1, -1 do
			if module.IsInTable(tostring(__wf_atom_e370bfde[i]), v14) then
				continue
			end

			if not module.IsInTable(tostring(__wf_atom_e370bfde[i]), v15) then
				continue
			end

			table.remove(__wf_atom_e370bfde, i)
		end

		if #__wf_atom_e370bfde > 0 then
			table.insert(v75, {
				id = k,
				missionTag = __wf_atom_e370bfde[__wf_atom_5784a397(1, #__wf_atom_e370bfde)]
			})
		end
	end

	return v75[__wf_atom_5784a397(1, #v75)]
end

local function fn31(p, p2, p3, p4, p5, p6, p7, p8)
	local v75 = Range(70, 350)
	local v76 = {}
	local v77 = {}
	local v78 = 0

	for _, v79 in ipairs(v65) do
		v79.connections = nil
	end

	local function fn32(id, missionTag, missionTag2)
		local enRouteMissionTags = v65[id].enRouteMissionTags

		if #enRouteMissionTags > 0 then
			local v79 = {}

			for _, enRouteMissionTag in ipairs(enRouteMissionTags) do
				local weight = fn26(missionTag, enRouteMissionTag, false, v77, p2.maxValue) * fn26(enRouteMissionTag, missionTag2, true, v77, p2.maxValue)

				if weight > 0 then
					table.insert(v79, {
						id = id.id,
						missionTag = enRouteMissionTag,
						weight = weight
					})
				end
			end

			if #v79 > 0 then
				table.sort(v79, function(a, b)
					return a.weight > b.weight
				end)
				return v79[1].missionTag
			end
		end
	end

	local v79 = {}
	local count = 0

	for _, v80 in ipairs(activeTales) do
		for _, list in ipairs(v80.paths) do
			for _, v81 in ipairs(list) do
				table.insert(v79, { id = v81.locationId })
			end
		end
	end

	local function fn33(state, p9, p10, p11, p12, p13, p14, p15)
		if not __wf_atom_7e8ad928(p11) and p11 <= #v76 then
			return
		end

		v78 += 1
		v77[v78] = { id = state.id, missionTag = state.missionTag }
		count += 1
		_T.TaleGenTime = _T.TaleGenTime or 0
		local v80 = false

		if v78 == p9.maxValue then
			v80 = true
		elseif v78 < p9.maxValue then
			fn25(state)

			if __wf_atom_7e8ad928(state.children) then
				state.children = fn28(state, v77, p12, p15, p9.maxValue, p10, p14, v79)
			end

			if #state.children == 0 then
				if v78 >= p9.minValue then
					v80 = true
				end
			else
				if
					not __wf_atom_7e8ad928(p10)
					and v78 > 1
					and #state.children == 1
					and state.children[1].id == p10.id
				then
					local missionTag = fn32(v77[v78].id, v77[v78 - 1].missionTag, p10.missionTag)

					if not __wf_atom_7e8ad928(missionTag) then
						v77[v78].missionTag = missionTag
					end
				end

				while #state.children > 0 and (__wf_atom_7e8ad928(p11) or #v76 < p11) do
					if _T.TaleGenTime >= 3 then
						print("Tale generator time limit reached (GenerateTree)")
						return
					end

					if count > 250 then
						Sleep(0)
						count = 0
						_T.TaleGenTime += __wf_atom_084b3e93()
					end

					local v81 = fn29(state.children, 5, true)
					fn33(state.children[v81], p9, p10, p11, p12, p13, p14, p15)
					table.remove(state.children, v81)
				end
			end
		end

		if v80 and (__wf_atom_7e8ad928(p10) or not __wf_atom_7e8ad928(p10) and state.id == p10.id) then
			if __wf_atom_7e8ad928(p13) or not __wf_atom_7e8ad928(_T.DevSelectedNodeInfo) then
				local v81 = v77
				local v82 = {}

				for i = 1, #v81 do
					table.insert(v82, v81[i])
				end

				table.insert(v76, v82)
			elseif not __wf_atom_7e8ad928(v65[state.id].encHint) then
				local __wf_atom_a5304c35 = v65[state.id].encHint:__wf_atom_a5304c35(p13)

				if __wf_atom_a5304c35 <= v75.maxValue and v75.minValue <= __wf_atom_a5304c35 then
					local v81 = v77
					local v82 = {}

					for i = 1, #v81 do
						table.insert(v82, v81[i])
					end

					table.insert(v76, v82)
				end
			end
		end

		state.children = nil
		v77[v78] = nil
		v78 -= 1
	end

	fn33(p, p2, p3, p4, p5, p7, p8, p6)

	if not p6 then
		return v76
	end

	local result = {}

	for _, v80 in ipairs(v76) do
		local v81 = {}

		for i = #v80, 1, -1 do
			table.insert(v81, v80[i])
		end

		table.insert(result, v81)
	end

	return result
end

local function fn32(p, list)
	for i, v76 in ipairs(list) do
		if v76.mTag == Symbol(p) then
			return i - 1
		end
	end

	return nil
end

local function fn33(object, p)
	local v75 = {
		mEncounterIdx = 0,
		mDifficultyTier = 0,
		mPathLength = Range(3, 4),
		mMaxBranches = 0,
		mEnemyLevel = Range(0, 0)
	}

	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(object) then
		return v75
	end

	local v76 = Resource(object:__wf_atom_6e1dcf41())

	if __wf_atom_7e8ad928(v76) then
		return v75
	end

	local __wf_atom_a838ae3a = v76:__wf_atom_a838ae3a()
	local mEncounterIdx = fn32(p, __wf_atom_a838ae3a)

	if mEncounterIdx == nil then
		print(p .. " not found as schema, defaulting to EncounterIdx 0")
	end

	local v78 = __wf_atom_a838ae3a[mEncounterIdx + 1]
	v75.mEncounterIdx = mEncounterIdx
	local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(v70)
	local v79 = __wf_atom_7e8ad928(__wf_atom_51dd1b95) and 0 or __wf_atom_51dd1b95.mTitle or 0
	local mDifficultyTier2 = 0

	for i = 1, #v78.mDifficultyTiers do
		if v78.mDifficultyTiers[i].mRankReq <= v79 then
			mDifficultyTier2 = i - 1
		end
	end

	if mDifficultyTier2 < #v78.mDifficultyTiers then
		local mDifficultyTier = v78.mDifficultyTiers[mDifficultyTier2 + 1]
		v75.mDifficultyTier = mDifficultyTier2
		v75.mPathLength.minValue = v78.mMinPathLength
		v75.mPathLength.maxValue = v78.mMaxPathLength
		v75.mMaxBranches = mDifficultyTier.mMaxBranches
		v75.mEnemyLevel.minValue = mDifficultyTier.mEnemyLevel.minValue
		v75.mEnemyLevel.maxValue = mDifficultyTier.mEnemyLevel.maxValue
	end

	return v75
end

function PostFillEncounterSchema(object, state, list)
	if __wf_atom_7e8ad928(object) or #list == 0 then
		return
	end

	local v75 = v65[list[1].locationId]
	local v76 = Resource(object:__wf_atom_6e1dcf41())
	local v77 = v75 and not __wf_atom_7e8ad928(v76) and module5.GetEnemyLevel(v75.encHint)

	if v77 then
		local __wf_atom_48a8e71b = v77:__wf_atom_48a8e71b(0.5)
		local __wf_atom_a838ae3a = v76:__wf_atom_a838ae3a()
		state.mDifficultyTier = 0

		if #__wf_atom_a838ae3a > state.mEncounterIdx then
			local v78 = __wf_atom_a838ae3a[state.mEncounterIdx + 1]

			for i, mDifficultyTier in ipairs(v78.mDifficultyTiers) do
				if __wf_atom_48a8e71b < mDifficultyTier.mEnemyLevel.minValue then
					break
				end

				state.mDifficultyTier = i - 1

				if __wf_atom_48a8e71b < mDifficultyTier.mEnemyLevel.maxValue then
					break
				end
			end
		end

		print("Enemy level " .. tostring(v77) .. ", encounter idx " .. state.mEncounterIdx .. ", difficulty tier " .. state.mDifficultyTier)
	end
end

local function fn34(value, p, tier)
	_T.DevGenerateNewShortPath = nil
	local devTaleLength

	if __wf_atom_7e8ad928(_T.DevTaleLength) then
		devTaleLength = value or 2
	else
		devTaleLength = _T.DevTaleLength
		_T.DevTaleLength = nil
	end

	local v75, v76

	if devTaleLength == 1 then
		v75 = v16
		v76 = v20
	else
		v75 = v15
		v76 = v19
	end

	local v77 = Range(150, 400)

	if devTaleLength == 1 then
		v77 = Range(50, 200)
	end

	if __wf_atom_7e8ad928(_T.currentJobBoard) then
		return
	end

	local position = _T.currentJobBoard:GetPosition()
	local v78 = fn24(p, v75, nil, v77)
	local v79 = nil

	if module.CountTableItems(v78) == 0 then
		return
	end

	_T.TaleGenTime = 0

	while __wf_atom_7e8ad928(v79) and module.CountTableItems(v78) > 0 do
		if _T.TaleGenTime >= 3 then
			print("Tale generator time limit reached (GenerateLongTale)")
			return
		end

		if not module.IsInOverworld() then
			break
		end

		local v80 = fn29(v78, nil, true, p, v76)

		if not __wf_atom_7e8ad928(v80) and not __wf_atom_7e8ad928(v78[v80]) and #v78[v80] > 0 then
			local v81 = __wf_atom_5784a397(1, #v78[v80])
			local v82 = v78[v80][v81]
			local missionTag = Symbol(v80)
			v68 = v80

			if devTaleLength > 1 then
				local v84 = fn31(
					{ id = v82, missionTag = missionTag },
					Range(devTaleLength, devTaleLength),
					nil,
					1,
					nil,
					true,
					position
				)

				if #v84 > 0 then
					v79 = module9.CreatePathData(v84[1])
				end
			else
				v79 = {
					{ locationId = v82, missionTag = missionTag }
				}
			end

			table.remove(v78[v80], v81)
		end

		if #v78[v80] == 0 then
			v78[v80] = nil
		end

		Sleep(0)
		_T.TaleGenTime += __wf_atom_084b3e93()
	end

	if __wf_atom_7e8ad928(v79) or not (#v79 > 0) then
		print("Invalid short path")
		print("No valid short tale locations found here")
	else
		local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(v70)
		local v80 = fn33(__wf_atom_13d5b7e9, #v79 == 1 and "SingleNode" or "ShortPath")
		PostFillEncounterSchema(__wf_atom_13d5b7e9, v80, v79)
		local tale = module9.CreateTale(v70, { v79 }, tier, v80)
		tale.tier = tier
		tale.pathId = #activeTales
		tale.jobBoardAction = _T.currentJobBoard
		tale.trackInJournal = true
		table.insert(activeTales, tale)
		return activeTales[#activeTales]
	end
end

local function fn35(region, p)
	print("Generate tale stages")
	_T.DevGenerateNewTalePath = nil
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or module.IsInNightFold(__wf_atom_c4f78a8f) then
		print("Player is nil or in the nightfold!")
		return
	end

	local position

	if __wf_atom_7e8ad928(_T.currentJobBoard) then
		if not flag then
			return
		end

		position = gRegion:__wf_atom_c4f78a8f():GetPosition()
	else
		position = _T.currentJobBoard:GetPosition()
	end

	local v75 = fn24(region, nil, nil, Range(200, 700))

	if module.CountTableItems(v75) == 0 then
		print("No valid boss nodes found!")
		return
	end

	v70 = module9.GetPlayerFaction()
	_T.TaleGenTime = 0
	local __wf_atom_13d5b7e9 = __wf_atom_c67f9605:__wf_atom_13d5b7e9(v70)
	local v76 = fn33(__wf_atom_13d5b7e9, "LongPath")
	print("Generating main path...")
	local v77 = {}

	while #v77 == 0 and module.CountTableItems(v75) > 0 do
		if _T.TaleGenTime >= 3 then
			print("Tale generator time limit reached (GenerateLongTale)")
			return
		end

		if not module.IsInOverworld() then
			break
		end

		local v78 = fn29(v75, nil, true, region)

		if not __wf_atom_7e8ad928(v78) and not __wf_atom_7e8ad928(v75[v78]) and #v75[v78] > 0 then
			local v79 = __wf_atom_5784a397(1, #v75[v78])
			v68 = v78
			local flag2 = false

			for _, v81 in pairs(v12) do
				if v78 ~= v81 then
					continue
				end

				flag2 = true
				break
			end

			if flag2 then
				v76.mPathLength.maxValue = math.max(v76.mPathLength.maxValue - 1, 3)
				v76.mPathLength.minValue = math.min(v76.mPathLength.maxValue, v76.mPathLength.minValue)
			end

			v77 = fn31({ id = v75[v78][v79], missionTag = Symbol(v78) }, v76.mPathLength, nil, 1, nil, true, position)
			table.remove(v75[v78], v79)

			if #v75[v78] == 0 then
				v75[v78] = nil
			end
		end

		Sleep(0)
		_T.TaleGenTime += __wf_atom_084b3e93()
	end

	if #v77 == 0 then
		print("No valid paths found nearby!")
		return
	end

	print("Finished generating main path")
	local v78 = v77[1]

	for _, v79 in ipairs(v78) do
		if not (#v79 > #v78 or #v79 == #v78 and math.random() < 0.5) then
			continue
		end

		v78 = v79
	end

	local v79 = { (module9.CreatePathData(v78)) }
	print("Generating branch...")

	if #v78 >= 3 then
		local v80 = {}

		for i = 1, #v78 - 2 do
			for j = i + 2, #v78 do
				table.insert(v80, {
					startnum = i,
					endnum = j,
					length = j - i + 1
				})
			end
		end

		local v81 = __wf_atom_5784a397(math.min(#v78, 4), #v78)
		table.sort(v80, function(a, b)
			return a.length ~= v81 and b.length == v81
		end)

		for i = #v80, 1, -1 do
			local v82 = v80[i]
			local v83 = math.min(v82.endnum - v82.startnum + 1, #v78)
			local v84 = fn31(v78[v82.startnum], Range(v83, v83), v78[v82.endnum], 1, v78, false, nil, v82.startnum)

			if not (#v84 > 0) then
				continue
			end

			table.insert(v79, (module9.CreatePathData(v84[1], true, true, v79)))
			break
		end
	end

	print("Finished generating branch")

	if #v79 > 0 then
		PostFillEncounterSchema(__wf_atom_13d5b7e9, v76, v79[1])
	end

	print("Post process trimming branches -----------------------------")

	for i, list in ipairs(v79) do
		for j, v80 in ipairs(list) do
			local v81 = ""

			for _, nextNode in ipairs(v80.nextNodes) do
				v81 ..= "{" .. nextNode.p .. "," .. nextNode.n .. "}"
			end

			print("Node " .. i .. "." .. j .. ": " .. v80.locationId .. "-" .. tostring(v80.missionTag) .. "-" .. v81)
		end
	end

	for _, list in ipairs(v79) do
		for _, v80 in ipairs(list) do
			if not (#v80.nextNodes >= 2) then
				continue
			end

			local v81 = v79[v80.nextNodes[1].p][v80.nextNodes[1].n]
			local v82 = v79[v80.nextNodes[2].p][v80.nextNodes[2].n]

			if v81.missionTag ~= v82.missionTag then
				continue
			end

			print("found duplicate mission tag in branch " .. v80.nextNodes[2].p)
			v79[v80.nextNodes[2].p] = {}
			table.remove(v80.nextNodes, 2)
		end
	end

	print("Finished generating path -----------------------------")

	for i, list in ipairs(v79) do
		for j, v80 in ipairs(list) do
			local v81 = ""

			for _, nextNode in ipairs(v80.nextNodes) do
				v81 ..= "{" .. nextNode.p .. "," .. nextNode.n .. "}"
			end

			print("Node " .. i .. "." .. j .. ": " .. v80.locationId .. "-" .. tostring(v80.missionTag) .. "-" .. v81)
		end
	end

	print("------------------------------------------------------")
	local secondCount = module8.GetSecondCount()
	_T.ProgressionScreenDisabled = true

	if __wf_atom_7e8ad928(gGameData) then
		print("missing game data")
		return
	end

	local count = #activeTales
	gGameData:__wf_atom_5a4536e1(v70, count, secondCount)
	activeTales = activeTales or {}
	local tale = module9.CreateTale(v70, v79, p, v76)
	tale.pathId = count
	tale.jobBoardAction = _T.currentJobBoard
	tale.region = region
	tale.startTime = secondCount
	tale.trackInJournal = true
	table.insert(activeTales, tale)
	return activeTales[#activeTales]
end

local function fn36(currentJobBoard, p)
	local count = 0

	for _, v75 in ipairs(activeTales) do
		if v75.jobBoardAction == currentJobBoard and (p == nil or v75.tier == p) then
			count += 1
		end
	end

	return count
end

local function fn37(currentJobBoard) -- 1 equivalent call inferred from this helper
	return currentJobBoard:__wf_atom_db682341() == Symbol("FactionLedgerJobBoard")
end

local function fn38(p)
	local currentJobBoard = _T.currentJobBoard

	if __wf_atom_7e8ad928(currentJobBoard) then
		return
	end

	local secondCount = module8.GetSecondCount()
	local __wf_atom_e919fb8e = _T.currentJobBoard:__wf_atom_e919fb8e()
	local region = __wf_atom_e919fb8e.region
	__wf_atom_e919fb8e.lastGenTime = __wf_atom_e919fb8e.lastGenTime or 0

	if __wf_atom_7e8ad928(region) then
		region = module.GetRegionIdFromDensityVolume(currentJobBoard:GetPosition())
	end

	local v75 = {
		{ numNodes = 1 },
		{ numNodes = 2 },
		{ numNodes = 4 }
	}
	local v76 = p ~= nil and { v75[p] } or v75
	local flag2 = false

	if fn37(currentJobBoard) then -- inferred equivalent call
		if fn36(currentJobBoard) == 0 then
			local v77 = math.random()
			local v78

			if v77 <= 0.2 then
				v78 = fn35(region, 3)
			elseif v77 <= 0.5 then
				v78 = fn34(2, region, 2)
			else
				v78 = fn34(1, region, 1)
			end

			if v78 ~= nil then
				v78.hasNoteJobBoard = true
			end
		end
	elseif __wf_atom_e919fb8e.lastGenTime + module9.rerollTime <= secondCount then
		for i = #v76, 1, -1 do
			if fn36(currentJobBoard, i) ~= 0 then
				continue
			end

			local v77

			if v76[i].numNodes < 3 then
				v77 = fn34(v76[i].numNodes, region, i)
			else
				v77 = fn35(region, i)
			end

			if not __wf_atom_7e8ad928(v77) then
				__wf_atom_e919fb8e.lastGenTime = secondCount
				flag2 = true
				table.insert(missionTags, (tostring(v77:GetFinalNode().missionTag)))

				if #missionTags > 3 then
					table.remove(missionTags, 1)
				end
			end

			Sleep(0)
		end
	end

	if flag2 then
		_T.RefreshJobBoard = true
	end

	_T.currentJobBoard = nil
end

local function fn39()
	v65 = {}
	local v75 = Symbol("DungeonHandlerHint")
	local all = gRegion:FindAll(__wf_atom_f806fd7a)
	local v76 = Symbol(v13.subboss)

	local function fn40(object) -- 1 equivalent call inferred from this helper
		return object:__wf_atom_e919fb8e().subbossCanSpawnInTales
	end

	for _, encHint in ipairs(all) do
		local __wf_atom_db682341 = encHint:__wf_atom_db682341()

		if __wf_atom_db682341 == EMPTY_SYMBOL then
			continue
		end

		local availableMissionTags = fn22(encHint)
		local __wf_atom_e370bfde = encHint:__wf_atom_e370bfde()

		if not (#availableMissionTags > 0 or flag and #__wf_atom_e370bfde > 0 and _G.DevIncludeAllMissionTags) then
			continue
		end

		local position = encHint:GetPosition()
		local v79 = tostring(__wf_atom_db682341)
		local isA = encHint:IsA(v3)
		local isSubboss = false
		local enemyLevel = module5.GetEnemyLevel(encHint)
		local level

		if isA then
			level = module5.GetDungeonEnemyLevelFromSurface(encHint)
		else
			level = module5.GetEnemyLevel(encHint)

			if v64 and fn15(encHint) then
				if not fn40(encHint) then -- inferred equivalent call
					continue
				end

				if not isA then
					for i = #availableMissionTags, 1, -1 do
						if availableMissionTags[i] ~= v76 then
							table.remove(availableMissionTags, i)
						end
					end
				end

				isSubboss = true
			end
		end

		local v82 = {
			encHint = encHint,
			encHintTag = __wf_atom_db682341,
			encPos = encHint:GetPosition(),
			availableMissionTags = availableMissionTags,
			status = 0,
			level = level,
			overworldLevel = enemyLevel,
			isSubboss = isSubboss
		}
		v82.regionId = module9.GetJobRegion(v82.encPos)

		if flag and _G.DevIncludeAllMissionTags then
			v82.availableMissionTags = __wf_atom_e370bfde
		end

		if isA or v82.isSubboss then
			local regionId = module.GetRegionIdFromDensityVolume(position)
			local jobBoardsInRegion = module9.GetJobBoardsInRegion(regionId)
			v82.assignedJobBoard = nil

			while #jobBoardsInRegion > 0 do
				local nearestObject = module.NearestObject(position, jobBoardsInRegion, nil, true, true)

				if jobBoardsInRegion[nearestObject]:__wf_atom_a5304c35(position) > 100 or #jobBoardsInRegion == 1 then
					v82.assignedJobBoard = jobBoardsInRegion[nearestObject]
					break
				else
					table.remove(jobBoardsInRegion, nearestObject)
				end
			end
		end

		v82.enRouteMissionTags = {}

		for _, availableMissionTag in ipairs(v82.availableMissionTags) do
			if not module.IsInTable(tostring(availableMissionTag), v17) then
				table.insert(v82.enRouteMissionTags, availableMissionTag)
			end
		end

		v82.enRouteMissionTags = module12.ShuffleTable(v82.enRouteMissionTags)

		if __wf_atom_db682341 == v75 then
			v82.isGlobalDungeonHint = true
		end

		if isA then
			local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(v4, position, 80)
			v82.isDungeonEntrance = true
			v82.dungeonEntrance = __wf_atom_e2db08ce
		end

		local __wf_atom_e529dedd = v82.encHint:__wf_atom_e529dedd()

		for _, v83 in ipairs(__wf_atom_e529dedd) do
			if not module9.IsMissionEncounter(v83) then
				continue
			end

			v82.status = v83:__wf_atom_4026dfb5()
			break
		end

		if __wf_atom_7e8ad928(v65[v79]) then
			v65[v79] = v82
		else
			local v83 = v79 .. "-Duplicate-" .. encHint:GetName()
			v65[v83] = v82
			print("Duplicate hint found with tag " .. v79)
		end
	end

	local testEncounterLocations = {}

	for k, v78 in pairs(v65) do
		testEncounterLocations[k] = v78
	end

	table.sort(testEncounterLocations, function(a, b)
		return tostring(a.encHintTag) < tostring(b.encHintTag)
	end)
	_T.TestEncounterLocations = testEncounterLocations
	_T.SelectFinalEncounterLocation = fn30
	_T.GeneratePaths = fn31
end

function OnChildEncStatusChanged(object)
	if not module9.IsMissionEncounter(object) or v65 == nil then
		return
	end

	local __wf_atom_4026dfb5 = object:__wf_atom_4026dfb5()
	local __wf_atom_26b04ea9 = object:__wf_atom_26b04ea9()

	if __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		print("OnChildEncStatusChanged error: " .. object:GetName() .. " has no parent hint!")
	else
		local v75 = tostring(__wf_atom_26b04ea9:__wf_atom_db682341())
		print("OnChildEncStatusChanged: " .. v75 .. " has new status " .. module5.STATE_STR[__wf_atom_4026dfb5])
		local pathNode, v76, v77, v78 = module9.FindPathNodeWithId(v75, activeTales)
		local v79 = v65[v75]

		if not __wf_atom_7e8ad928(pathNode) then
			pathNode.status = __wf_atom_4026dfb5

			if __wf_atom_4026dfb5 == 3 or __wf_atom_4026dfb5 == 4 then
				if __wf_atom_7e8ad928(v67) then
					v67 = {}
				end

				table.insert(v67, { node = pathNode, t = activeTales[v76].pathId, p = v77, n = v78 })
				object:__wf_atom_68e563a5(v6)
				local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.taleMessage = nil
			end

			if __wf_atom_4026dfb5 >= 3 and not __wf_atom_7e8ad928(v79) then
				module9.EnableEncounterMarker(v79.encHint, false)
				module2.RemoveSparrowDestination(v79.encHint, module9.SparrowDestId(v79))
			end
		end
	end
end

local function fn40(p)
	print("Tale expired (_T.ForcedTestLocation)")
	local v75

	if __wf_atom_7e8ad928(p) then
		v75 = fn()
		v75.introDialogPlayed = true
	else
		v75 = module9.CreateTale(v70, p, 1)
		v75.regionId = v65[v75.paths[1][1].locationId].regionId
	end

	v75.state = module9.STATE.ACCEPTED
	v75.trackInJournal = true
	table.insert(activeTales, v75)
	module9.CreateTalePathMarkers(v75, v65)
	fn12(v75)

	for i = 1, #v72 do
		v72[i].delay = 0
	end

	_T.ForcedTestLocation = nil
	_G.DevForceEnableEncountersInDungeons = not v64
end

local function fn41()
	if not __wf_atom_7e8ad928(_T.DevRemoveTale) then
		print("_T.DevRemoveTale" .. tostring(_T.DevRemoveTale))
		fn11(activeTales[_T.DevRemoveTale])
		_T.DevRemoveTale = nil
	end

	if _T.DevRemoveAllTales then
		for i = #activeTales, 1, -1 do
			fn11(activeTales[i])
			Sleep(0)
		end

		_T.DevRemoveAllTales = nil
	end

	if not __wf_atom_7e8ad928(_T.ForcedShutdownLocation) then
		for _, v75 in ipairs(activeTales) do
			for _, list in ipairs(v75.paths) do
				for _, v77 in ipairs(list) do
					if v77.locationId ~= tostring(_T.ForcedShutdownLocation.encHintTag) then
						continue
					end

					fn11(v75)
					break
				end
			end
		end

		_T.ForcedShutdownLocation = nil
	end

	if _T.DebugDrawTalePath then
		module9.DebugDrawTalesFromImGui(activeTales, v65)
	end

	if _T.DebugDrawAllHints then
		module9.DebugDrawAllHints(v65)
	end

	if _T.DevUseCustomPath then
		fn40(v74)
		_T.DevUseCustomPath = nil
	end

	if not (__wf_atom_7e8ad928(_T.DevGenerateNewTalePath) and __wf_atom_7e8ad928(_T.DevGenerateNewShortPath)) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local jobRegion = module9.GetJobRegion(__wf_atom_c4f78a8f:GetPosition())
			_T.currentJobBoard = gRegion:FindNearestTagged(v7, __wf_atom_c4f78a8f:GetPosition())

			if __wf_atom_7e8ad928(_T.DevGenerateNewTalePath) then
				if not __wf_atom_7e8ad928(_T.DevGenerateNewShortPath) then
					fn34(_T.DevTaleLength, jobRegion, _T.DevTaleLength)
				end
			else
				fn35(jobRegion, 3)
			end

			_T.currentJobBoard = nil
		end
	end
end

local function fn42(p, p2)
	for i = #activeTales, 1, -1 do
		if activeTales[i].state == module9.STATE.ABANDONED then
			fn11(activeTales[i])
		elseif
			activeTales[i].hasNoteJobBoard
			and activeTales[i].state < module9.STATE.ACCEPTED
			and __wf_atom_7e8ad928(activeTales[i].jobBoardAction)
		then
			fn11(activeTales[i])
		elseif _T.JobBoardEntity == nil and activeTales[i].state < module9.STATE.ACCEPTED and not p2 then
			activeTales[i].rerollTime = activeTales[i].rerollTime - p

			if activeTales[i].rerollTime <= 0 then
				fn11(activeTales[i])
			end
		end
	end

	if v64 then
		if p2 or total >= 10 then
			local secondCount = module8.GetSecondCount()
			local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
			local v75 = false

			for _, v76 in ipairs(activeTales) do
				if not (v76.state >= module9.STATE.ACCEPTED and v76.startTime ~= nil) then
					continue
				end

				local v77 = fn3(v76, __wf_atom_ef7900cf)

				if p2 or not v77 then
					if not (v76.state >= module9.STATE.ACCEPTED and v76.startTime + v76.expiryTime < secondCount) then
						local startTime = v76.startTime

						if not (secondCount + 604800 < startTime) then
							continue
						end
					end

					print("Tale passed its expiry date (" .. tostring(secondCount) .. " > " .. tostring(v76.startTime) .. " + " .. tostring(v76.expiryTime) .. ")")

					if not v75 and v76.totalNodes > 2 and not p2 then
						fn2("Fail")
						v75 = true
					end

					fn11(v76)
				else
					v76.startTime = module8.GetSecondCount()
					gGameData:__wf_atom_5a4536e1(v70, v76.pathId, v76.startTime)
				end
			end

			total = 0
		else
			total += p
		end

		if p2 then
			return
		end
	end
end

local function fn43(p)
	local result = {}
	local result2 = {}

	for _, v75 in pairs(v65) do
		if
			__wf_atom_7e8ad928(v75.encHint)
			or not (v75.isSubboss or not fn15(v75.encHint))
			or not module5.GetMissionEncounterAllowed(v75.encHint)
		then
			continue
		end

		local v76 = { encHint = v75.encHint, missionTags = {} }

		for _, availableMissionTag in ipairs(v75.availableMissionTags) do
			local v77 = tostring(availableMissionTag)

			if module.IsInTable(v77, p) then
				table.insert(v76.missionTags, availableMissionTag)
			end
		end

		if not (#v76.missionTags > 0) then
			continue
		end

		if v64 then
			if result[v75.regionId] == nil then
				result[v75.regionId] = {}
			end

			table.insert(result[v75.regionId], v76)
		else
			table.insert(result2, v76)
		end
	end

	if v64 then
		return result
	end

	return result2
end

local function fn44()
	if not module4.HasCompletedQuest(WeakResource("/SF/Types/Quests/TCDemoQuest")) then
		print("RandomBosses early out, must complete Garren")
		return
	end

	local v75 = {}

	if v64 then
		local v77 = fn43({ v13.miniboss, v13.patrol, v12.boss })
		local v78 = {
			Range(1, 1),
			Range(2, 3),
			Range(1, 2),
			Range(2, 2),
			Range(2, 3),
			Range(1, 1),
			(Range(0, 0))
		}

		for i = 1, #v78 do
			local v79 = v77[i]
			local v80 = v78[i] or Range(0, 0)
			local v81 = math.floor((math.min(__wf_atom_5784a397(v80.minValue, v80.maxValue), #v79 * 0.5)))
			print("Region " .. i .. " - " .. v81 .. " bosses")

			if v81 == 0 then
				continue
			end

			for _ = 1, v81 do
				while #v79 > 0 do
					local v82 = __wf_atom_5784a397(1, #v79)
					local v83 = false

					for _, v85 in ipairs(v75) do
						if not (v79[v82].encHint:__wf_atom_1c8f7b2d(v85.encHint) < 400) then
							continue
						end

						v83 = true
						break
					end

					if v83 or module.IsInOverworld() and not v79[v82].encHint:IsEnabled() then
						table.remove(v79, v82)
					else
						table.insert(v75, v79[v82])
						table.remove(v79, v82)
						break
					end
				end
			end
		end
	else
		local currentLocation = module10.GetCurrentLocation()

		if not (__wf_atom_7e8ad928(currentLocation) or __wf_atom_7e8ad928(_G.DungeonEntranceInfo) or __wf_atom_7e8ad928(_G.DungeonEntranceInfo[currentLocation])) then
			local ambientMissionTag = tostring(_G.DungeonEntranceInfo[currentLocation].ambientMissionTag)

			if not __wf_atom_7e8ad928(ambientMissionTag) and ambientMissionTag ~= "" then
				local v76 = fn43({ ambientMissionTag })
				v75 = { v76[__wf_atom_5784a397(1, #v76)] }
			end
		end
	end

	for _, v76 in ipairs(v75) do
		local missionTag = v76.missionTags[__wf_atom_5784a397(1, #v76.missionTags)]

		if not module.IsInOverworld() then
			v76.encHint:Enable()
		end

		if __wf_atom_7e8ad928(v62:PrimeMissionOnHint(missionTag, v76.encHint)) then
			print("Failed to prime random boss encounter")
		end
	end
end

local function fn45()
	print("Setup")
	local loginSequencePlayed = _G.LoginSequencePlayed
	module.WaitForLevel()
	module.WaitForLoginSequence()
	v62 = module.WaitForAiDir()
	Sleep(3)

	if not gRegion:IsMaster() then
		print("Player is client")
		return
	end

	_T.EncounterEarlyOutLogMsg = nil
	flag = false
	v64 = module.IsInOverworld()
	activeTales = {}
	_G.ImGuiEncounterFilter = nil
	_T.TestEncounterLocations = nil
	fn39()
	module9.SetLocations(v65)
	fn17()
	fn44()
	local hudIds = {}

	for _, v75 in ipairs(activeTales) do
		table.insert(hudIds, v75.hudId)
	end

	module11.RemoveTalesEntriesExcept(hudIds)
	fn20()

	if flag then
		_T.ImportEncounterPath = fn17
		_T.ExportEncounterPath = fn10
		_T.TestAllConnections = fn25
	end

	if loginSequencePlayed ~= true then
		print("Login sequence hadn't played when we started, we must have just logged in; we'll remove any old tales")
		fn42(0, true)
	end

	fn21()
	print("Completed setup")
end

local function fn46()
	if __wf_atom_7e8ad928(v63) or module.IsInOverworld() ~= v64 then
		print("Streaming")
		return false
	end

	if not gRegion:IsMaster() then
		print("Player became client")
		return false
	end

	if not __wf_atom_7e8ad928(gGameData) then
		return true
	end

	print("gGameData is nil!")
	return false
end

local function fn47(state)
	print("Tale starting")
	fn12(state)
	module9.CreateTalePathMarkers(state, v65)
	state.state = module9.STATE.INPROGRESS

	if not __wf_atom_7e8ad928(state.acceptedMarker) then
		state.acceptedMarker:Destroy()
	end

	fn6(state, state.trackInJournal)
	state.trackInJournal = nil
	module6.TrackTaleStart(state, false)
end

local function fn48(state)
	local result = {}

	if not __wf_atom_7e8ad928(v67) and #v67 > 0 then
		local nextNodes = {}

		for i = #v67, 1, -1 do
			if v67[i].t ~= state.pathId then
				continue
			end

			local node = v67[i].node
			node.completed = true
			local path = state.paths[1]

			if not (v73 or path[#path].completed) then
				fn18(state, node)
			end

			if not __wf_atom_7e8ad928(node.marker) then
				if node.marker:__wf_atom_68dff988() == 4 or node.marker:__wf_atom_68dff988() == 5 then
					node.marker:__wf_atom_44962dd2(6)
				else
					node.marker:__wf_atom_44962dd2(3)
				end
			end

			if not v73 then
				module7.CompleteHudTask(state, state.hudId, module9.GetObjectiveIdFromNode(node), 3.7)
				module7.RemoveHudTask(state, state.hudId, node.locationId .. "_or", 3.7)
				module11.RemoveTalesEntry(state.hudId)
				module2.RemoveAllDestinationsForTale(state.hudId)

				if v65[node.locationId] ~= nil then
					module6.TrackTaleNodeComplete(state, node, v65[node.locationId].encHint, v67[i].t, v67[i].n)
				end
			end

			fn9(state, node)

			if not __wf_atom_7e8ad928(node.nextNodes) then
				for _, nextNode in ipairs(node.nextNodes) do
					if not node.unreachable then
						table.insert(nextNodes, nextNode)
					end
				end
			end

			table.remove(v67, i)
		end

		if state.isTracked and not state.transmissionPlayed and #nextNodes > 1 and math.random() <= 0.33 then
			fn2("PathChoice")
			state.transmissionPlayed = true
		end

		for _, v75 in ipairs(nextNodes) do
			local v76

			if not __wf_atom_7e8ad928(state.paths[v75.p]) then
				v76 = state.paths[v75.p][v75.n]
			end

			if __wf_atom_7e8ad928(v76) or v76.unreachable or v76.completed then
				print("null nextNode")
			else
				if
					state.isTracked
					and #state.paths[v75.p] > 2
					and not state.transmissionPlayed
					and math.random() <= 0.33
				then
					local v77 = math.floor(#state.paths[v75.p] / 2)

					if v75.n == v77 then
						fn2("Middle")
					end

					state.transmissionPlayed = true
				end

				table.insert(result, v76)
			end
		end
	end

	v73 = nil
	return result
end

function _TrackNextTaleJournalEntry()
	Sleep(20)
	module9.JournalTrackNextTale()
end

function CompleteTale(p, p2, p3)
	if not __wf_atom_7e8ad928(v65[p3]) then
		print("Tale completed")
		fn19(v65[p3].encHint, p2, p)
		fn2("Success")
		fn20(p)

		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:Upload(Symbol("TALE_COMPLETE"))
		end

		module15.NotifyTagAllPlayers(Symbol("TALE_COMPLETE"))

		if not v64 then
			module10.ClearDungeonTaleInfo()
		end

		fn11(p)

		if v64 and not __wf_atom_7e8ad928(v63) then
			v63:__wf_atom_8a035cd5(Symbol("_TrackNextTaleJournalEntry"), false)
		end
	end
end

function RunMultiStageTale(p)
	v63 = p
	fn45()
	local total2 = 999
	local v75 = false

	while fn46() do
		local v76 = __wf_atom_03df4e1d()

		if total2 > 2 then
			if v75 and not module9.ShouldStopEncounters() then
				_T.EncounterEarlyOutLogMsg = nil
				print("Encounters unblocked")
				v75 = false
			elseif not v75 and module9.ShouldStopEncounters() then
				v75 = true

				for _, v77 in ipairs(activeTales) do
					fn11(v77, true)
				end

				print("Encounters blocked")
			end

			for _, v77 in ipairs(activeTales) do
				v77:Update()

				if
					v77.state ~= module9.STATE.INPROGRESS
					or v77.introDialogPlayed
					or not __wf_atom_7e8ad928(__wf_atom_8e4fda44:FindMovie(v))
				then
					continue
				end

				fn2("Intro")
				v77.introDialogPlayed = true
			end

			total2 = 0
		else
			total2 += v76
		end

		fn42(v76)

		for i = #v72, 1, -1 do
			if v72[i].delay > 0 then
				v72[i].delay -= v76
			else
				v72[i].Update()
				table.remove(v72, i)
				Sleep(0)
			end
		end

		_T.ActiveTales = activeTales

		if not (v75 and __wf_atom_7e8ad928(_T.ForcedTestLocation)) then
			if flag and not __wf_atom_7e8ad928(_T.ForcedTestLocation) then
				fn40()
			else
				fn38()
			end

			for _, v77 in ipairs(activeTales) do
				local v78 = {}

				if v77.state < module9.STATE.ACTIVEHIDDEN or __wf_atom_7e8ad928(v77.paths) or #v77.paths == 0 then
					continue
				end

				if v77.state ~= module9.STATE.ACTIVEHIDDEN then
					if v77.state == module9.STATE.ACCEPTED then
						fn47(v77)
					elseif v77.state == module9.STATE.INPROGRESS then
						v78 = fn48(v77)

						for i, list in ipairs(v77.paths) do
							for j, v80 in ipairs(list) do
								if i == 1 and j == 1 and not (v80.completed or v80.wasPrimed) then
									table.insert(v78, v80)
								else
									if not v80.completed and v80.wasPrimed and (v80.status == 0 or v80.status == 6) then
										local encHint = v65[v80.locationId].encHint
										local v81

										if __wf_atom_7e8ad928(encHint) then
											v81 = false
										else
											v81 = encHint:__wf_atom_5b6b447d() == v80.missionTag
										end

										if not v81 then
											table.insert(v78, v80)
											continue
										end
									end

									if i == 1 and v80.completed and j == #list then
										CompleteTale(v77, v80, v80.locationId)
										break
									end
								end
							end
						end
					end
				end

				fn7(v77, v78)
			end
		end

		if flag then
			fn41()
		end

		Sleep(0)
	end

	_T.TestEncounterLocations = nil
	print("RunRegionMissionEncounters: ended")
end