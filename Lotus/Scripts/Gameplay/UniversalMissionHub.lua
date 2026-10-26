local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local fn
local fn2
local transmission = WeakResource("/Lotus/Sounds/Dialog/Taunts/RailjackBeacon/BeaconAidRequest")
local v = WeakResource("/Lotus/Fx/Gameplay/ScenarioBeacon/ScenarioBeaconHealFX")
local v2 = { 1, 2, 3 }
local v3 = { 4, 5, 6 }
local v4 = Symbol("UniversalMissionHub")
local v5 = nil
local v6 = { 100, 300, 1000 }
local v7 = { 100, 300, 1000 }
local v8 = false
local v9 = { healthPerSecond = 200, maxHealthBonus = 500, maxHeals = 3000 }

local function fn3(p)
	if p then
		print("LogScenarioActivity: " .. p)
	end

	local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

	if
		__wf_atom_7e8ad928(movie)
		or __wf_atom_7e8ad928(gMatchingService:__wf_atom_7190444e())
		or not gMatchingService:__wf_atom_7190444e():__wf_atom_328bcb8f()
	then
		__wf_atom_f2daf912(p)
	elseif p then
		movie:__wf_atom_f62a8704("ChannelNotificationMessage", { p, "1" })
	end
end

local function fn4(eventName, p, propName, encoded, propOp)
	if eventName == nil and propName == nil or eventName == "" and propName == "" then
		return
	end

	if not _G.Scenario then
		print("_SendScenarioHubEvent: _G.Scenario not initialized!")
		_G.Scenario = {}
	end

	if _G.Scenario.SendObj == nil then
		_G.Scenario.SendObj = {}
	end

	local epochNum = _G.Scenario.EpochNum

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_589d05aa) then
		local scenarioId = gGameRules:__wf_atom_72fc675e().scenarioId

		if scenarioId and scenarioId ~= "" then
			local v10 = 0
			local v11 = {}

			while true do
				v10 = string.find(scenarioId, "_", v10 + 1)

				if v10 == nil then
					break
				end

				v11[#v11 + 1] = v10
			end

			epochNum = string.sub(scenarioId, v11[#v11] + 1)
		end
	end

	local epochNum2 = epochNum == nil and 0 or epochNum
	local v10 = "UniversalMissionHub::SendScenarioHubEvent for epochNum=" .. tostring(epochNum2) .. "\n"

	if eventName then
		v10 ..= " eventName=" .. tostring(eventName)
	end

	if p then
		v10 ..= " eventValues=" .. tostring(p)
	end

	if propName then
		v10 ..= " propName=" .. tostring(propName)
	end

	if encoded then
		v10 ..= " propValue=" .. tostring(encoded)
	end

	if propOp then
		v10 ..= " propOp=" .. tostring(propOp)
	end

	print(v10)

	if eventName ~= nil and eventName ~= "" then
		local eventValues = type(p) ~= "table" and { p } or p
		_G.Scenario.SendObj[eventName] = {
			eventName = eventName,
			eventValues = eventValues,
			epochNum = epochNum2
		}
	end

	if propName ~= nil and propName ~= "" then
		if propOp == "inc" and _G.Scenario.SendObj[propName] and _G.Scenario.SendObj[propName].propValue ~= nil then
			local typeName = type(_G.Scenario.SendObj[propName].propValue)

			if typeName == "number" then
				encoded = _G.Scenario.SendObj[propName].propValue + encoded
			elseif typeName == "string" and type(encoded) == "string" then
				local decoded = cjson.decode(encoded)
				local decoded2 = cjson.decode(_G.Scenario.SendObj[propName].propValue)

				if decoded2 ~= nil and decoded ~= nil then
					for k, v11 in pairs(decoded2) do
						if not (type(decoded[k]) == "number" and type(v11) == "number") then
							continue
						end

						decoded2[k] = v11 + decoded[k]
						decoded[k] = nil
					end

					for k, v11 in pairs(decoded) do
						decoded2[k] = v11
					end

					encoded = cjson.encode(decoded2)
				end
			end
		end

		_G.Scenario.SendObj[propName] = {
			propName = propName,
			propValue = encoded,
			epochNum = epochNum2
		}

		if propOp ~= "" then
			_G.Scenario.SendObj[propName].propOp = propOp
		end
	end
end

function SendScenarioHubEvent(eventName, p, propName, p2, propOp)
	fn4(eventName, p, propName, p2, propOp)
end

local function fn5()
	if not _G.Scenario.SendObj then
		return
	end

	local v10 = { eventData = {} }

	for _, v11 in pairs(_G.Scenario.SendObj) do
		table.insert(v10.eventData, v11)
	end

	local encoded = cjson.encode(v10)
	gMatchingService:__wf_atom_6ff767a1("all", encoded)
	_G.Scenario.SendObj = nil
end

local function fn6(scenario)
	scenario.PushLeaders = {}
	scenario.PullLeaders = {}
	scenario.Medalists = {}

	if scenario.scoreStats then
		if not scenario.scoreStats.GroundScore then
			scenario.scoreStats.GroundScore = {}
		end

		if not scenario.scoreStats.SpaceScore then
			scenario.scoreStats.SpaceScore = {}
		end

		local v10 = { scenario.scoreStats.GroundScore, scenario.scoreStats.SpaceScore }
		local v11 = { scenario.PushLeaders, scenario.PullLeaders }
		local v12 = { v2, v3 }

		for i = 1, #v10 do
			local v13 = v10[i]
			local v14 = v11[i]

			if not v13 then
				continue
			end

			v14.KillCodes = {}

			for k, score in pairs(v13) do
				table.insert(v14.KillCodes, { name = k, score = score, rank = 0 })
			end

			table.sort(v14.KillCodes, function(a, b)
				return a.score > b.score
			end)
			local score = nil
			local count = 0

			for _, killCode in ipairs(v14.KillCodes) do
				if killCode.score ~= score then
					score = killCode.score
					count += 1
				end

				killCode.rank = count
				local v15

				if i == 1 then
					v15 = v6
				else
					v15 = v7
				end

				for j = #v15, 1, -1 do
					if not (killCode.score >= v15[j]) then
						continue
					end

					local name = killCode.name

					if not scenario.Medalists[name] then
						scenario.Medalists[name] = {}
					end

					table.insert(scenario.Medalists[name], v12[i][j])
					break
				end
			end
		end
	end

	__wf_atom_8e4fda44:__wf_atom_4dd9e6f4("RefreshLeaderBoards", "")
end

local function fn7(playerName, message)
	if _T.ScenarioTransmissions == nil then
		_T.ScenarioTransmissions = {}
	end

	print("ShowSupportTransmission from " .. tostring(playerName) .. " for " .. message)
	table.insert(_T.ScenarioTransmissions, {
		playerName = playerName,
		message = message,
		transmission = transmission
	})
	module2.CreateHudlessTransmission(transmission)
end

local function fn8()
	if not _G.Scenario then
		return
	end

	local v10 = "\r\nLocation: " .. tostring(gMatchingService:__wf_atom_706d8455())

	if _G.Scenario.ScenarioId then
		v10 ..= "\r\nScenarioId: " .. _G.Scenario.ScenarioId
	end

	if _G.Scenario.StartTime then
		v10 ..= "\r\nStartTime: " .. _G.Scenario.StartTime
	end

	if _G.Scenario.EndTime then
		v10 ..= "\r\nEndTime: " .. _G.Scenario.EndTime
	end

	if _G.Scenario.ProgressReq then
		local progressReq = _G.Scenario.ProgressReq

		if _G.Scenario.State and _G.Scenario.State.Progress then
			progressReq = tostring(_G.Scenario.State.Progress) .. " / " .. _G.Scenario.ProgressReq
		end

		v10 ..= "\r\nRequiredProgress: " .. progressReq
	end

	local v11 = v10 .. "\r\nPlayers: "
	local __wf_atom_df6512ff = gMatchingService:__wf_atom_df6512ff()

	for i = 1, #__wf_atom_df6512ff do
		local v12 = v11 .. __wf_atom_df6512ff[i]

		if _T.ScenarioInitiator and __wf_atom_df6512ff[i] == _T.ScenarioInitiator then
			v12 ..= "[*]"
		end

		if i < #__wf_atom_df6512ff then
			v11 = v12 .. ", "
		else
			v11 = v12 .. "\r\n"
		end
	end

	if _G.Scenario.SquadInfos then
		v11 ..= "Squads:\r\n"

		for k, squadInfo in pairs(_G.Scenario.SquadInfos) do
			v11 ..= "  " .. k .. "=[" .. cjson.encode(squadInfo) .. "]\r\n"
		end
	end

	for k, v12 in pairs(_G.Scenario.State) do
		local v13 = v11 .. k .. "="

		if type(v12) == "table" then
			for _, v14 in pairs(v12) do
				v13 ..= tostring(v14) .. ","
			end

			v11 = v13 .. "\r\n"
		else
			v11 = v13 .. tostring(v12) .. "\r\n"
		end
	end

	if _G.Scenario.LastEvent then
		v11 ..= "LastEvent: " .. cjson.encode(_G.Scenario.LastEvent) .. "\r\n"
	end

	if _G.Scenario.PushQueue then
		local v12 = v11 .. "PushQueue: "

		for k, v13 in pairs(_G.Scenario.PushQueue) do
			local v14 = v12 .. "\"" .. k .. "\"=["

			for _, v15 in pairs(v13) do
				v14 ..= v15 .. ", "
			end

			v12 = v14 .. "] "
		end

		v11 = v12 .. "\r\n"
	end

	if _G.Scenario.PullQueue then
		local v12 = v11 .. "PullQueue: "

		for k, v13 in pairs(_G.Scenario.PullQueue) do
			local v14 = v12 .. "\"" .. k .. "\"=["

			for _, v15 in pairs(v13) do
				v14 ..= v15 .. ", "
			end

			v12 = v14 .. "] "
		end

		v11 = v12 .. "\r\n"
	end

	if _G.Scenario.pushStats then
		local v12 = v11 .. "PushStats: "

		for k, pushStat in pairs(_G.Scenario.pushStats) do
			v12 ..= k .. ": "

			for k2, v13 in pairs(pushStat) do
				v12 ..= k2 .. "=" .. tostring(v13) .. ", "
			end
		end

		v11 = v12 .. "\r\n"
	end

	if _G.Scenario.pullStats then
		local v12 = v11 .. "PullStats: "

		for k, pullStat in pairs(_G.Scenario.pullStats) do
			v12 ..= k .. ": "

			for k2, v13 in pairs(pullStat) do
				v12 ..= k2 .. "=" .. tostring(v13) .. ", "
			end
		end

		v11 = v12 .. "\r\n"
	end

	if _G.Scenario.PushResult then
		local consumer = _G.Scenario.PushResult.consumer
		local v12 = (consumer == nil or consumer == "") and "pending" or consumer
		v11 ..= "LastPushResult: " .. _G.Scenario.PushResult.name .. " pushed " .. _G.Scenario.PushResult.prop .. " -> " .. v12 .. "\r\n"
	end

	if _G.Scenario.PullResult then
		local producer = _G.Scenario.PullResult.producer
		local v12 = (producer == nil or producer == "") and "waiting" or producer
		v11 ..= "LastPullResult: " .. _G.Scenario.PullResult.name .. " pulled " .. _G.Scenario.PullResult.prop .. " -> " .. v12 .. "\r\n"
	end

	gMatchingService:__wf_atom_89df55fd(v11)

	if _T.ScenarioDebugInfoChangedCallback then
		_T.ScenarioDebugInfoChangedCallback()
	end
end

local function fn9()
	return {
		State = {},
		LastEvent = nil,
		ActivityLog = {},
		PeerNameList = nil,
		PeerNamesAnnounced = nil,
		SquadInfos = {},
		ChangesReceived = nil,
		PushQueue = nil,
		PullQueue = nil,
		PushResult = nil,
		PullResult = nil,
		SendObj = nil,
		SendObjTimer = 0,
		ProgressReq = 100,
		EpochNum = 0,
		StartTime = "1585062900",
		EndTime = "1585073700"
	}
end

local function fn10()
	if
		not _G.Scenario.ChangesReceived
		or #_G.Scenario.ChangesReceived == 0
		or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))
	then
		return
	end

	if _T.ScenarioProcessDelayTest ~= nil then
		_T.ScenarioProcessDelayTest = _T.ScenarioProcessDelayTest - __wf_atom_fa1258d0()

		if _T.ScenarioProcessDelayTest > 0 then
			return
		end
	end

	local v10 = _G.Scenario.Initialized == nil
	_G.Scenario.Initialized = true
	local count = 0

	while _G.Scenario.ChangesReceived and #_G.Scenario.ChangesReceived > 0 do
		local v11 = table.remove(_G.Scenario.ChangesReceived, 1)
		print("ApplyChangesReceived: processing entry " .. count)
		count += 1

		if v11.lastEvent and (_G.Scenario.LastEvent == nil or v11.lastEvent.id ~= _G.Scenario.LastEvent.id) then
			_G.Scenario.LastEvent = v11.lastEvent

			if not v10 then
				local name = _G.Scenario.LastEvent.name
				local v12 = string.find(name, "Support") == 1
				local v13, v14

				if v12 then
					local value = _G.Scenario.LastEvent.values[1]
					local sender = _G.Scenario.LastEvent.sender
					local __wf_atom_6be84646 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646()
					local v15

					if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
						v15 = gMatchingService:__wf_atom_15811761():__wf_atom_6c164199()
					end

					if value == __wf_atom_6be84646 or v15 and value == v15 then
						if _T.ScenarioSquadSupportReceived == nil then
							fn7(
								sender,
								Localize("/Lotus/Language/SquadLink/" .. name .. "Sent", {
									PLAYER_NAME = __wf_atom_6be84646
								})
							)
						end

						v13 = true
					else
						if sender == __wf_atom_6be84646 or v15 and sender == v15 then
							fn7(
								value,
								Localize("/Lotus/Language/SquadLink/" .. name .. "Received", {
									PLAYER_NAME = sender
								})
							)
						end

						v13 = false
					end

					local v16 = Localize("/Lotus/Language/SquadLink/" .. name .. "ItemName", nil)
					v14 = Localize("/Lotus/Language/SquadLink/SquadSupportEventLog", {
						PLAYER_NAME = sender,
						ITEM_NAME = v16,
						RECEIVER_NAME = value
					})
				else
					v13 = true
				end

				if v13 and _T.ScenarioEventHandlers and _T.ScenarioEventHandlers[name] then
					_T.ScenarioEventHandlers[name](_G.Scenario.LastEvent.values)
				end

				local v15 = (_G.Scenario.LastEvent.values == nil or _G.Scenario.LastEvent.values[1] == nil) and ""
					or _G.Scenario.LastEvent.values[1]

				if not v12 then
					if name == "WaveSuccess" then
						v14 = Localize("/Lotus/Language/SquadLink/WaveSuccess", nil)
					elseif name == "WaveFail" then
						v14 = Localize("/Lotus/Language/SquadLink/WaveFail", nil)
					else
						v14 = Localize("/Lotus/Language/SquadLink/SquadEventLog", {
							PLAYER_NAME = _G.Scenario.LastEvent.sender,
							EVENT_NAME = name,
							VALUE = v15
						})
					end
				end

				fn3(v14)
			end
		end

		if v11.reset then
			_G.Scenario = fn9()
		end

		if v11.id then
			_G.Scenario.ScenarioId = v11.id
		end

		if v11.epochNum then
			_G.Scenario.EpochNum = v11.epochNum
		end

		if v11.startTime then
			_G.Scenario.StartTime = v11.startTime
		end

		if v11.endTime then
			_G.Scenario.EndTime = v11.endTime
		end

		if v11.lastCriteriaUpdateTime then
			_G.Scenario.LastCriteriaUpdateTime = v11.lastCriteriaUpdateTime
		end

		if v11.completed ~= nil then
			_G.Scenario.Completed = v11.completed
		end

		if v11.progressReq then
			_G.Scenario.ProgressReq = v11.progressReq
		end

		if v11.cooldown then
			_G.Scenario.Cooldown = v11.cooldown
		end

		if v11.nextEpoch then
			_G.Scenario.NextEpoch = v11.nextEpoch
		end

		if v11.lastScenario then
			_G.Scenario.LastScenario = v11.lastScenario
		end

		if v11.state then
			_G.Scenario.State.LastStateModifier = module.Ternary(
				v11.lastStateModifier ~= nil,
				v11.lastStateModifier,
				""
			)

			if next(v11.state) == nil then
				_G.Scenario.State = {}
			else
				for k, v12 in pairs(v11.state) do
					if not (_G.Scenario.State[k] == nil or _G.Scenario.State[k] ~= v12) then
						continue
					end

					local v13

					if k == "Progress" then
						v13 = Localize("/Lotus/Language/SquadLink/SquadStateProgressChangeLog", {
							PLAYER_NAME = _G.Scenario.State.LastStateModifier,
							VALUE = tostring(v12)
						})
					else
						v13 = Localize("/Lotus/Language/SquadLink/SquadStateChangeLog", {
							PLAYER_NAME = _G.Scenario.State.LastStateModifier,
							PROPERTY_NAME = k,
							VALUE = tostring(v12)
						})
					end

					if not v10 then
						fn3(v13)
					end

					if _T.ScenarioStateChangeHandlers and _T.ScenarioStateChangeHandlers[k] then
						_T.ScenarioStateChangeHandlers[k](_G.Scenario.State[k], v12)
					end

					_G.Scenario.State[k] = v12
				end
			end
		end

		if v11.squads then
			local v12 = _G.Scenario.PeerNamesAnnounced == nil

			if v12 then
				_G.Scenario.PeerNamesAnnounced = {}
			end

			for k, squad in pairs(v11.squads) do
				if squad == "delete" then
					if _G.Scenario.SquadInfos[k] then
						_G.Scenario.SquadInfos[k] = nil
					end
				else
					local decoded = cjson.decode(squad)
					local location = decoded.location

					if decoded.location then
						decoded.locationDesc = ""

						if string.find(location, "CrewBattle") or string.find(location, "DeepSpace") then
							decoded.locationDesc = "Space"
						elseif string.find(location, "ForestOpLink") then
							decoded.locationDesc = "Ground"
						else
							decoded.locationDesc = "Flotilla"
						end

						if
							not v10
							and _G.Scenario.SquadInfos[k]
							and _G.Scenario.SquadInfos[k].locationDesc
							and decoded.locationDesc ~= _G.Scenario.SquadInfos[k].locationDesc
						then
							fn3(Localize("/Lotus/Language/SquadLink/SquadChangedLocation", {
								PLAYER_NAME = k,
								LOCATION = Localize("/Lotus/Language/SquadLink/Location" .. decoded.locationDesc, nil)
							}))
						end
					end

					if v12 then
						for _, member in pairs(decoded.members) do
							_G.Scenario.PeerNamesAnnounced[member] = true
						end
					end

					_G.Scenario.SquadInfos[k] = decoded
				end
			end
		end

		if v11.initiator then
			_T.ScenarioInitiator = v11.initiator
		end

		if v11.pushQueue then
			_G.Scenario.PushQueue = v11.pushQueue
		end

		if v11.pullQueue then
			_G.Scenario.PullQueue = v11.pullQueue
		end

		if v11.pushResult then
			local v12 = "/Lotus/Language/SquadLink/Flotilla" .. v11.pushResult.prop

			if not v11.pushResult.pushedTo or v11.pushResult.pushedTo == "" then
				v12 ..= "Single"
			end

			local v13 = Localize(v12, {})
			local v14, v15

			if v11.pushResult.pushedTo == "" then
				v14 = { PLAYER_NAME = v11.pushResult.name, ITEM_NAME = v13 }
				v15 = "/Lotus/Language/SquadLink/SquadPushedItem"
			else
				v14 = {
					PLAYER_NAME = v11.pushResult.name,
					ITEM_NAME = v13,
					RECEIVER_NAME = v11.pushResult.pushedTo
				}
				v15 = "/Lotus/Language/SquadLink/SquadPushedItemToPlayer"
			end

			fn3(Localize(v15, v14))

			if _T.ScenarioPushHandlers and _T.ScenarioPushHandlers[v11.pushResult.prop] then
				_T.ScenarioPushHandlers[v11.pushResult.prop](v11.pushResult.name)
			end

			if
				v11.pushResult.pushedTo ~= ""
				and _T.ScenarioPullHandlers
				and _T.ScenarioPullHandlers[v11.pushResult.prop]
			then
				_T.ScenarioPullHandlers[v11.pushResult.prop](v11.pushResult.pushedTo, v11.pushResult.name)
			end

			_G.Scenario.PushResult = v11.pushResult
		end

		if v11.pullResult then
			local v12 = Localize("/Lotus/Language/SquadLink/Flotilla" .. v11.pullResult.prop, {})
			local v13, v14

			if v11.pullResult.pulledFrom == "" then
				v13 = {
					PLAYER_NAME = v11.pullResult.name,
					ITEM_NAME = v12,
					RECEIVER_NAME = v11.pullResult.pulledFrom
				}
				v14 = "/Lotus/Language/SquadLink/SquadPulledItem"
			else
				v13 = {
					PLAYER_NAME = v11.pullResult.pulledFrom,
					ITEM_NAME = v12,
					RECEIVER_NAME = v11.pullResult.name
				}
				v14 = "/Lotus/Language/SquadLink/SquadPulledItemFromPlayer"
			end

			fn3(Localize(v14, v13))

			if _T.ScenarioPullHandlers and _T.ScenarioPullHandlers[v11.pullResult.prop] then
				_T.ScenarioPullHandlers[v11.pullResult.prop](v11.pullResult.name, v11.pullResult.pulledFrom)
			end

			_G.Scenario.PullResult = v11.pullResult
		end

		if v11.pushStats then
			_G.Scenario.pushStats = v11.pushStats
		end

		if v11.pullStats then
			_G.Scenario.pullStats = v11.pullStats
		end

		if not (v11.scoreStats or v11.reset) then
			continue
		end

		local scenario = _G.Scenario
		local scoreStats = v11.scoreStats

		if v11.reset then
			scenario = _G.Scenario.LastScenario

			if scenario then
				scoreStats = scenario.scoreStats
			end
		end

		if not (scenario and scoreStats) then
			continue
		end

		if not scenario.scoreStats then
			scenario.scoreStats = {}
		end

		for k, scoreStat in pairs(scoreStats) do
			if scenario.scoreStats[k] == nil then
				scenario.scoreStats[k] = {}
			end

			for k2, v12 in pairs(scoreStat) do
				scenario.scoreStats[k][k2] = v12
			end
		end

		fn6(scenario)
	end

	if _G.Scenario.KickReconnectPending then
		_G.Scenario.KickReconnectPending = nil

		if _T.ScenarioKickRejoinHandlers then
			for _, scenarioKickRejoinHandler in pairs(_T.ScenarioKickRejoinHandlers) do
				if type(scenarioKickRejoinHandler) == "function" then
					scenarioKickRejoinHandler()
				end
			end
		end
	end

	fn8()
end

local function fn11(p)
	if not (gMatchingService:__wf_atom_607c7363() or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())) then
		return
	end

	if __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		return
	end

	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
	local v10 = { members = {} }

	for i = 1, #__wf_atom_bb46d8b6 do
		table.insert(v10.members, __wf_atom_bb46d8b6[i].name)
	end

	local name = ""
	local __wf_atom_8b0475eb = gMatchingService:__wf_atom_8b0475eb()

	if __wf_atom_8b0475eb and __wf_atom_8b0475eb ~= "" then
		local decoded = cjson.decode(__wf_atom_8b0475eb)

		if decoded.name then
			name = decoded.name
		end
	end

	if name ~= "" and string.find(name, "/") then
		local v11 = string.find(name, "/[^/]*$")

		if v11 then
			name = string.sub(name, v11 + 1)
		end
	end

	v10.location = p or name

	if _T.ScenarioLocalSquadMissionStatus then
		v10.missionStatus = _T.ScenarioLocalSquadMissionStatus
	end

	if _T.ScenarioReadyForSquadSupportStatus then
		v10.readyForSupportStatus = _T.ScenarioReadyForSquadSupportStatus
	end

	if _T.ScenarioSquadSupportReceived then
		v10.hasReceivedSupport = _T.ScenarioSquadSupportReceived
	end

	local encoded = cjson.encode(v10)
	fn4(nil, nil, __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(), encoded, "squad")
end

function OnSyncWorldState()
	local v10 = Symbol("SquadLinkEvent")
	local mGoals = gGameData:__wf_atom_92662866().mGoals
	v5 = nil

	for _, mGoal in pairs(mGoals) do
		if mGoal.mTag ~= v10 then
			continue
		end

		v5 = mGoal:Copy()
		local mMetadata = v5.mMetadata

		if mMetadata == "" then
			break
		end

		local v11 = false
		local decoded = cjson.decode(mMetadata)

		if decoded then
			if decoded.groundTiers then
				for i = 1, #decoded.groundTiers do
					if decoded.groundTiers[i] == v6[i] then
						continue
					end

					v6[i] = decoded.groundTiers[i]
					v11 = true
				end
			end

			if decoded.spaceTiers then
				for i = 1, #decoded.spaceTiers do
					if decoded.spaceTiers[i] == v7[i] then
						continue
					end

					v7[i] = decoded.spaceTiers[i]
					v11 = true
				end
			end
		end

		if not v11 then
			break
		end

		fn6(_G.Scenario)
		break
	end
end

local function fn12()
	_G.Scenario.PeerNameList = {}
	local __wf_atom_df6512ff = gMatchingService:__wf_atom_df6512ff()

	for _, v10 in pairs(__wf_atom_df6512ff) do
		table.insert(_G.Scenario.PeerNameList, v10)
	end
end

local function fn13() end

local function fn14() end

function Start()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	if _G.Scenario == nil then
		_G.Scenario = fn9()
	end

	gMatchingService:__wf_atom_9ad738f8("ScenarioHub", "OnRelayP2PData")
	gMatchingService:__wf_atom_aa1891ca("ScenarioHub", "OnRelayPeerListChanged")
	gGameData:__wf_atom_0d091b56("OnSyncWorldState", v4, true)
	local v10 = false

	while _G.Scenario do
		if _T.ScenarioGlobalsInitialized or _T.TunnelIndex then
			if _T.TunnelIndex then
				_T.ScenarioGlobalsInitialized = false
			end
		else
			fn()
			v10 = true
		end

		if v10 and gMatchingService:__wf_atom_d309183e() then
			if not _G.Scenario.PeerNameList then
				fn12()
			end

			fn11()
			v10 = false
		end

		local v11 = __wf_atom_fa1258d0()
		_G.Scenario.SendObjTimer = _G.Scenario.SendObjTimer - v11

		if _G.Scenario.SendObj and _G.Scenario.SendObjTimer <= 0 then
			fn5()
			_G.Scenario.SendObjTimer = 0.5
		end

		fn10()

		if _T.ScenarioGameLoopUpdate then
			_T.ScenarioGameLoopUpdate(v11)
		end

		if not __wf_atom_7e8ad928(gGameRules) then
			if gGameRules:__wf_atom_95862cc1() and not v8 then
				_T.ScenarioEventHandlers = {}
				_T.ScenarioEventHandlers.WaveSuccess = fn13
				_T.ScenarioEventHandlers.WaveFail = fn14
				v8 = true
			elseif not gGameRules:__wf_atom_95862cc1() and v8 then
				v8 = false
			end
		end

		Sleep(0)
	end
end

function Shutdown()
	_G.Scenario = nil
	_T.ScenarioGlobalsInitialized = nil
	_T.ScenarioInitiator = nil
	_T.ScenarioPlayerCount = nil
	_T.PendingScenarioHubShutdown = nil
	_T.ScenarioHubStarted = false
	_T.SendScenarioHubEvent = nil
	_T.LogScenarioActivity = nil
	_T.ScenarioSquadMembersChanged = nil
	_T.ShowScenarioSupportTransmission = nil
	_T.ScenarioSetLocalSquadMissionStatus = nil
	_T.SetSquadSupportReceived = nil
	_T.ShowScenarioDebugControls = nil
	_T.ScenarioKickRejoinHandlers = nil
end

function OnRelayConnected(_, _) end

function OnRelayP2PData(_, p)
	local decoded = cjson.decode(p)

	if decoded.scenario == nil then
		return
	end

	print("UniversalMissionHub::OnRelayP2PData\n" .. p)

	if _T.ScenarioProcessDelayTest ~= nil and _T.ScenarioProcessDelayTest < 0 then
		_T.ScenarioProcessDelayTest = Random(1, 3)
	end

	if not _G.Scenario.ChangesReceived then
		_G.Scenario.ChangesReceived = {}
	end

	table.insert(_G.Scenario.ChangesReceived, decoded.scenario)
end

function OnRelayPeerListChanged(p, p2)
	if __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		return
	end

	local __wf_atom_df6512ff = gMatchingService:__wf_atom_df6512ff()

	if __wf_atom_df6512ff then
		_T.ScenarioPlayerCount = #__wf_atom_df6512ff
	else
		_T.ScenarioPlayerCount = 0
	end

	local v10 = false

	for _, v11 in pairs(__wf_atom_df6512ff) do
		if _T.ScenarioInitiator and _T.ScenarioInitiator == v11 then
			v10 = true
		end
	end

	if _T.ScenarioInitiator == __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646() then
		if #__wf_atom_df6512ff == 1 then
			if _T.ShowNotification then
				_T.ShowNotification("Beacon assistant left", "SquadMemberInvited")
			end

			print("No beacon assistants remaining, shutting down beacon")
			_T.PendingScenarioHubShutdown = true
		end
	elseif _T.ScenarioInitiator and _T.ScenarioInitiator ~= "" and not v10 then
		if _T.ShowNotification then
			_T.ShowNotification("Beacon initiator left", "SquadMemberInvited")
		end

		print("scenario host left, shutting down beacon")
		_T.PendingScenarioHubShutdown = true
	end

	if _G.Scenario.PeerNamesAnnounced and p2 ~= "" then
		local flag = true

		if p then
			if _G.Scenario.PeerNamesAnnounced[p2] then
				flag = false
			else
				_G.Scenario.PeerNamesAnnounced[p2] = true
			end
		else
			_G.Scenario.PeerNamesAnnounced[p2] = nil

			if _G.Scenario.PeerNamesAnnounced == nil then
				_G.Scenario.PeerNamesAnnounced = {}
			end
		end

		if flag then
			local ternary = module.Ternary(
				p,
				"/Lotus/Language/SquadLink/PlayerJoined",
				"/Lotus/Language/SquadLink/PlayerLeft"
			)
			fn3(Localize(ternary, { PLAYER_NAME = p2 }))
		end
	end

	fn12()
	fn8()
end

local function fn15(propName, p, p2)
	if
		p2
		and not p
		and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))
		and propName == __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646()
	then
		fn4(nil, nil, propName, "delete", "squad")
	else
		fn11()
	end
end

local function fn16(tag, p)
	if
		not _T.ScenarioLocalSquadMissionStatus
		or _T.ScenarioLocalSquadMissionStatus.tag ~= tag
		or _T.ScenarioLocalSquadMissionStatus.value ~= p
	then
		_T.ScenarioLocalSquadMissionStatus = { tag = tag, value = p }
		fn11()
	end
end

local function fn17(value)
	_T.ScenarioSquadSupportReceived = value or " "
	fn11()
end

fn = function()
	_T.ScenarioHubStarted = true
	_T.HubSkipEoM = true
	_T.SendScenarioHubEvent = fn4
	_T.LogScenarioActivity = fn3
	_T.ScenarioSquadMembersChanged = fn15
	_T.ShowScenarioSupportTransmission = fn7
	_T.ScenarioSetLocalSquadMissionStatus = fn16
	_T.SetSquadSupportReceived = fn17
	_T.ShowScenarioDebugControls = fn2
	_T.ScenarioGlobalsInitialized = true
end

local function fn18(p) -- 4 equivalent calls inferred from this helper
	if _T.SendScenarioHubEvent then
		_T.SendScenarioHubEvent(nil, nil, "Progress", p, "inc")
	else
		__wf_atom_f2daf912("(hub not active!) Progress increased by " .. p)
	end
end

local function fn19(p)
	if _T.SendScenarioHubEvent then
		_T.SendScenarioHubEvent(nil, nil, "KillCodes", nil, p)

		if p == "pull" then
			if not _T.ScenarioDebugPullKillCodeCounter then
				_T.ScenarioDebugPullKillCodeCounter = 0
			end

			_T.ScenarioDebugPullKillCodeCounter = _T.ScenarioDebugPullKillCodeCounter + 1

			if _T.ScenarioDebugPullKillCodeCounter >= 9 then
				_T.ScenarioDebugPullKillCodeCounter = 0
				fn18(1) -- inferred equivalent call
			end
		end
	else
		__wf_atom_f2daf912("(hub not active!) " .. p .. " KillCodes")
	end
end

fn2 = function()
	local __wf_atom_5d67a2c5 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(__wf_atom_5d67a2c5) then
		__wf_atom_5d67a2c5:Execute("SetTitle", "It's like an army of magical space unicorns only better")

		function _T.DebugSelectionDone(list)
			_T.DebugSelectionDone = nil
			_T.GetDebugChoices = nil

			if not __wf_atom_7e8ad928(list) and not __wf_atom_7e8ad928(list[1]) and list[1].mCallback then
				list[1].mCallback()
			end
		end

		__wf_atom_5d67a2c5:Execute("SetCallBack", "DebugSelectionDone")
		local v10 = WeakResource("/Lotus/Scripts/Gameplay/UniversalMissionHub.lua")

		function _T.GetDebugChoices()
			return {
				{
					mName = "Push KillCode",
					mCallback = function()
						fn19("push")
					end
				},
				{
					mName = "Pull KillCode",
					mCallback = function()
						fn19("pull")
					end
				},
				{
					mName = "KillCode Roulette (50 Random Pushes & Pulls)",
					mCallback = function()
						gRegion:__wf_atom_c4f78a8f():__wf_atom_51009507(
							Resource(v10),
							Symbol("RandomKillCodesDispatcher"),
							false
						)
					end
				},
				{
					mName = "+1 Progress",
					mCallback = function()
						fn18(1) -- inferred equivalent call
					end
				},
				{
					mName = "+10 Progress",
					mCallback = function()
						fn18(10) -- inferred equivalent call
					end
				},
				{
					mName = "-1 Progress",
					mCallback = function()
						fn18(-1) -- inferred equivalent call
					end
				},
				{
					mName = "Fake Travel To Ground",
					mCallback = function()
						fn11("ForestOpLink")
					end
				},
				{
					mName = "Fake Travel To Space",
					mCallback = function()
						fn11("CrewBattle")
					end
				},
				{
					mName = "Fake Return To Flotilla",
					mCallback = function()
						fn11("")
					end
				},
				{
					mName = "View Realtime JSON",
					mCallback = function()
						gRegion:__wf_atom_c4f78a8f():__wf_atom_51009507(
							Resource(v10),
							Symbol("RealTimeJsonViewer"),
							false
						)
					end
				},
				{
					mName = "Force Wave Refresh",
					mCallback = function()
						fn4("ForceRefresh")
					end
				},
				{
					mName = "Fill Hub Instance",
					mCallback = function()
						fn4(nil, nil, "*DebugFillInstance*", nil, "squad")
					end
				},
				{
					mName = "Drop Player From Hub",
					mCallback = function()
						fn4(nil, nil, "*DebugDropPlayer*", nil, "squad")
					end
				},
				{
					mName = "Fake Slow Hub Connection",
					mCallback = function()
						_T.ScenarioProcessDelayTest = Random(1, 3)
					end
				},
				{
					mName = module.Ternary(_T.ScenarioSpamTest, "Stop Spam Test", "Spam Push Test"),
					mCallback = function()
						gRegion:__wf_atom_c4f78a8f():__wf_atom_51009507(Resource(v10), Symbol("SpamDispatcher"), false)
					end
				}
			}
		end

		__wf_atom_5d67a2c5:Execute("SetElementsFunction", "GetDebugChoices")
	end
end

_T.ShowScenarioDebugControls = fn2

function RandomKillCodesDispatcher()
	for _ = 1, 50 do
		if Random(0, 1) < 0.55 then
			fn19("push")
		else
			fn19("pull")
		end

		Sleep(0.5)
	end
end

function RealTimeJsonViewer()
	module.ShowMessage("Gathering info...\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n")
	local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_ConfirmMovie)
	movie:__wf_atom_50d60589("Dialog.Label", 45, "left")

	function _T.ScenarioDebugInfoChangedCallback()
		if __wf_atom_7e8ad928(movie) then
			return
		end

		local v10 = not _G.Scenario and "hub not active" or string.gsub(cjson.encode(_G.Scenario), "},\"", "}\r\n\"")
		movie:__wf_atom_50d60589("Dialog.Label", 36, v10)
		print(v10)
	end

	Sleep(0)
	_T.ScenarioDebugInfoChangedCallback()

	while not __wf_atom_7e8ad928(movie) do
		Sleep(0)
	end

	_T.ScenarioDebugInfoChangedCallback = nil
end

function HealScenarioBeacon(object)
	local __wf_atom_44e5f023 = gGameRules:__wf_atom_44e5f023({ v:__wf_atom_5b41f63b() })
	gGameRules:__wf_atom_3e17734e(__wf_atom_44e5f023)
	local v10 = object:Attach(Type(v), EMPTY_SYMBOL)
	object:__wf_atom_506144ee(object:GetMaxHealth() + v9.maxHealthBonus)
	local maxHealth = object:GetMaxHealth()
	local v11 = 0

	while
		not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and _T.scenarioBeaconHeals ~= nil
		and _T.scenarioBeaconHeals < v9.maxHeals
	do
		local __wf_atom_c6f1f83d = object:__wf_atom_c6f1f83d()

		if __wf_atom_c6f1f83d < maxHealth then
			v11 += v9.healthPerSecond * __wf_atom_084b3e93()

			if maxHealth < __wf_atom_c6f1f83d + v11 then
				v11 = maxHealth - __wf_atom_c6f1f83d
			end

			if _T.scenarioBeaconHeals + v11 <= v9.maxHeals then
				local v12 = math.floor(v11)
				_T.scenarioBeaconHeals = _T.scenarioBeaconHeals + v12
				object:Heal(object, v12)
				v11 -= v12
			elseif _T.scenarioBeaconHeals < v9.maxHeals then
				local v12 = v9.maxHeals - _T.scenarioBeaconHeals
				_T.scenarioBeaconHeals = v9.maxHeals
				object:Heal(object, v12)
			end
		else
			v11 = 0
		end

		Sleep(0)
	end

	if not __wf_atom_7e8ad928(v10) then
		v10:Destroy()
	end
end

function OnKickedFromHub()
	if _G.Scenario then
		_G.Scenario.KickReconnectPending = true
	end
end

function SpamDispatcher()
	_T.ScenarioSpamTest = module.Ternary(_T.ScenarioSpamTest, false, true)
	local count = 0

	while _T.ScenarioSpamTest do
		if __wf_atom_5784a397(1, 2) == 1 then
			fn19("push")
		else
			count += 1
			fn11("Spam" .. count)
		end

		Sleep(Random(0, 1))
	end
end