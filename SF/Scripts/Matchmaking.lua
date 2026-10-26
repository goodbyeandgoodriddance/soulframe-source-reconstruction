local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusNetworkUtilities")
local module3 = require("SF.Interface.SFUtilities")
local module4 = require("SF.Scripts.Libs.QuestLib")
local v = {
	NONE = 0,
	FOUND_JOINING_SQUAD = 1,
	NOT_FOUND = 2,
	SEARCH_IN_PROGRESS = 3,
	FOUND_SQUAD_JOINED = 4,
	FOUND_SQUAD_JOIN_FAILED = 5,
	HOSTING_NEW_SQUAD = 6,
	HOST_READY = 7
}
local v2 = WeakResource("/SF/Objects/SpiritCreatures/Shrine")
local v3 = Symbol("HardModeActive")

local function fn(object)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	local v4 = ""

	if useShrineLocation and not __wf_atom_7e8ad928(object) then
		local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			v4 = __wf_atom_3d96ddcd:__wf_atom_5b41f63b()

			if not __wf_atom_7e8ad928(shrineFX) then
				__wf_atom_3d96ddcd:Attach(shrineFX, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end

	local name = __wf_atom_8ad59546:GetName()
	local v5 = v4:gsub("/[Ll][Aa][Yy][Ee][Rr]", ""):gsub("[Ss][Hh][Rr][Ii][Nn][Ee]", ""):gsub("/", "")
	local gameModeName = name:gsub("/[Ll][Aa][Yy][Ee][Rr]", ""):gsub("/", "") .. v5
	_T.GameModeName = gameModeName
	local v6 = __wf_atom_ef9aeb11(gameModeName)
	print("Matchmaking: GameModeName-", gameModeName, "GameModeID- ", v6)
	return v6
end

local function fn2(gameModeId, p, p2)
	while gMatchingService:IsBlockingTaskPending() do
		Sleep(0)
	end

	print("Matchmaking: FindPublicSessionsForNode")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local settings = __wf_atom_18a5d83b:Settings()
	local __wf_atom_7611b6b4 = settings:__wf_atom_7611b6b4()
	local sessionSearch = Engine.SessionSearch()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 1
	else
		sessionSearch.matchType = 2
	end

	sessionSearch.gameModeId = gameModeId
	sessionSearch.regionId = __wf_atom_7611b6b4.regionId
	local __wf_atom_5ff594a3 = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_5ff594a3()

	if __wf_atom_5ff594a3 == MongoId() then
		sessionSearch.guildId = ""
	else
		sessionSearch.guildId = __wf_atom_5ff594a3
	end

	local __wf_atom_517d18d6 = settings:__wf_atom_517d18d6()

	if __wf_atom_517d18d6 < 1500 then
		sessionSearch.maxPing = __wf_atom_517d18d6
	end

	if __wf_atom_72884638("Multiplayer.DedicatedServersOnly") or p2 then
		sessionSearch.dedicatedServer = true
	end

	gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, p)
	return true
end

function OnClientSessionMerge(p)
	print("Multiplayer: OnClientSessionMerge(" .. tostring(p) .. ")")

	if p then
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if not __wf_atom_7e8ad928(__wf_atom_15811761) then
			print("Session id=" .. tostring(__wf_atom_15811761:__wf_atom_3d56acba()))
			_T.ShowNotification("/SF/Language/Matchmaking/PlayerFound", "Matchmaking", true, nil, nil, true)
		end
	end
end

function OnJoinPublicLobbyComplete(p)
	print("Matchmaking: OnJoinPublicLobbyComplete - " .. tostring(p))

	if p then
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if not __wf_atom_7e8ad928(__wf_atom_15811761) then
			print("Session id=" .. tostring(__wf_atom_15811761:__wf_atom_3d56acba()))
		end

		gMatchingService:UpdatePresence()
		gMatchingService:SendMissionLoadRequest()
		_T.publicSessionSearchResult = v.FOUND_SQUAD_JOINED
		print("Matchmaking: OnJoinPublicLobbyComplete(Group Found & Joined Succeeded)")
	else
		_T.publicSessionSearchResult = v.FOUND_SQUAD_JOIN_FAILED
		print("Matchmaking: OnJoinPublicLobbyComplete(Group Found & Joined FAILED)")
		_T.ShowNotification("/SF/Language/Matchmaking/JoinFailed", "Matchmaking", true, nil, nil, true)
	end
end

local function fn3() -- 1 equivalent call inferred from this helper
	if not __wf_atom_7e8ad928(_G.matchmakingTimeoutActive) and _G.matchmakingTimeoutActive then
		_G.matchmakingTimeout = 0
		return
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol("_MatchmakingTimeout"), false)
	end
end

function OnLobbyReady()
	print("Matchmaking: OnLobbyReady")
	_T.publicSessionSearchResult = v.HOST_READY
	gMatchingService:UpdatePresence()
	fn3() -- inferred equivalent call
end

function _MatchmakingTimeout()
	_G.matchmakingTimeout = 0
	_G.matchmakingTimeoutActive = true
	local isInOverworld = module.IsInOverworld()

	while _G.matchmakingTimeout < matchmakingTimeoutSeconds do
		Sleep(1)
		_G.matchmakingTimeout += 1

		if
			__wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761()))
			or __wf_atom_7e8ad928(_G.matchmakingTimeoutActive)
			or not _G.matchmakingTimeoutActive
			or isInOverworld ~= module.IsInOverworld()
		then
			break
		end
	end

	if not __wf_atom_7e8ad928(_T.GameModeName) then
		__wf_atom_21342f4a:__wf_atom_008d812c(Symbol("MATCHMAKING_SEARCH_TIME"))

		if _G.matchmakingTimeout >= matchmakingTimeoutSeconds then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("MATCHMAKING_HOST_SESSION_TIMEOUT"), _T.GameModeName)
		end
	end

	AbortPublicGame()
end

function OnPlayerJoined(p)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
		return
	end

	if not __wf_atom_7e8ad928(_T.GameModeName) then
		__wf_atom_21342f4a:__wf_atom_008d812c(Symbol("MATCHMAKING_SEARCH_TIME"))
	end

	local count = #gMatchingService:__wf_atom_bb46d8b6()
	__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("MATCHMAKING_HOST_SESSION_PLAYER_JOINED"), count)
	__wf_atom_21342f4a:__wf_atom_3c9aa248(
		Symbol("MATCHMAKING_HOST_SESSION_PLAYER_JOINED_TIME"),
		count,
		"",
		_G.matchmakingTimeout
	)
	print("Matchmaking: Player (" .. p .. ") has joined")
end

function OnPlayerLeft(p)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
		return
	end

	print("Matchmaking: Player (" .. p .. ") has left")
end

local function fn4()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()

	if gMatchingService:__wf_atom_c5171bd3() then
		__wf_atom_7611b6b4.matchType = 0
	else
		__wf_atom_7611b6b4.matchType = 2
	end

	__wf_atom_7611b6b4.minPlayers = 1
	__wf_atom_7611b6b4.maxPlayers = 4
	__wf_atom_7611b6b4.originalSessionId = ""

	if __wf_atom_7e8ad928(_T.GameModeName) then
		print("Matchmaking: GameModeID not set, finding nearest shrine")
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v4

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local all = gRegion:FindAll(v2)
			local sortByDistance = module.SortByDistance(all, __wf_atom_c4f78a8f:GetPosition())

			if #sortByDistance >= 1 then
				v4 = sortByDistance[1]
			end
		end

		__wf_atom_7611b6b4.gameModeId = fn(v4)
	else
		__wf_atom_7611b6b4.gameModeId = __wf_atom_ef9aeb11(_T.GameModeName)
	end

	if not __wf_atom_7e8ad928(_T.GameModeName) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("MATCHMAKING_HOST_SESSION"), _T.GameModeName)
	end

	gMatchingService:HostSquadSession(__wf_atom_18a5d83b, __wf_atom_7611b6b4, "OnLobbyReady")
	gMatchingService:SetSquadHostHubLevelName("")
	gMatchingService:__wf_atom_a55a86f9("OnPlayerJoined")
	gMatchingService:__wf_atom_f008492e(Symbol("Matchmaking"), "OnPlayerLeft")
	_T.publicSessionSearchResult = v.HOSTING_NEW_SQUAD
end

local function fn5(p) -- 2 equivalent calls inferred from this helper
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:__wf_atom_8a035cd5(Symbol(p), false)
	end
end

function OnSessionSettingsUpdated()
	if not __wf_atom_7e8ad928(_G.matchmakingTimeoutActive) and _G.matchmakingTimeoutActive then
		_G.matchmakingTimeout = 0
		return
	end

	fn5("_MatchmakingTimeout") -- inferred equivalent call
end

function _UpdateHostSession(object)
	gMatchingService:__wf_atom_a551abb0()
	local settings = object:GetSettings()
	settings.regionId = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings():__wf_atom_7611b6b4().regionId

	if __wf_atom_7e8ad928(_T.GameModeName) then
		print("Matchmaking: GameModeID not set, finding nearest shrine")
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v4

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			local all = gRegion:FindAll(v2)
			local sortByDistance = module.SortByDistance(all, __wf_atom_c4f78a8f:GetPosition())

			if #sortByDistance >= 1 then
				v4 = sortByDistance[1]
			end
		end

		settings.gameModeId = fn(v4)
	else
		settings.gameModeId = __wf_atom_ef9aeb11(_T.GameModeName)
	end

	gGameRules:UnHideGameSession()
	gMatchingService:__wf_atom_c8d901d4(settings, "OnSessionSettingsUpdated")
	gMatchingService:__wf_atom_a55a86f9("OnPlayerJoined")
	gMatchingService:__wf_atom_f008492e(Symbol("Matchmaking"), "OnPlayerLeft")
	gMatchingService:UpdatePresence()
end

function JoinTimerCompleted()
	local matchmakingSession = _T.matchmakingSession

	if __wf_atom_7e8ad928(matchmakingSession) then
		OnJoinPublicLobbyComplete(false)
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		gMatchingService:MergeSquadSession(
			__wf_atom_18a5d83b,
			matchmakingSession,
			false,
			255,
			false,
			"OnJoinPublicLobbyComplete"
		)
		_T.publicSessionSearchResult = v.FOUND_JOINING_SQUAD
		print("Matchmaking: OnPublicSessionFound(Group Found - Joining...)")
	end

	_T.matchmakingSession = nil
end

function _MergeSquadSession()
	local flag = false
	local v4 = false
	local v5 = {
		SHOW_PAUSE_MENU = { function(p, p2)
				if p and p2 then
					flag = true
				end
			end },
		JUMP = { function(p, p2)
				if p and p2 then
					v4 = true
				end
			end }
	}
	local timer = 10

	while timer > 0 do
		_T.ShowNotification(
			Localize("/SF/Language/Matchmaking/SessionFound", { TIMER = timer }),
			"Matchmaking",
			true,
			-1,
			nil,
			true,
			nil,
			nil,
			v5
		)
		Sleep(1)
		timer -= 1

		if flag or v4 then
			break
		end
	end

	if flag then
		AbortPublicGame()
	else
		JoinTimerCompleted()
	end
end

function OnPublicSessionFound(_)
	print("Matchmaking: OnPublicSessionFound")
	local __wf_atom_754c4d7d = gMatchingService:__wf_atom_754c4d7d()
	gMatchingService:__wf_atom_d7c90859(OnClientSessionMerge)

	if #__wf_atom_754c4d7d > 0 then
		if not __wf_atom_7e8ad928(_T.GameModeName) then
			__wf_atom_21342f4a:__wf_atom_008d812c(Symbol("MATCHMAKING_SEARCH_TIME"))
		end

		_T.matchmakingSession = __wf_atom_754c4d7d[1]
		fn5("_MergeSquadSession") -- inferred equivalent call
	else
		_T.publicSessionSearchResult = v.NOT_FOUND
		print("Matchmaking: OnPublicSessionFound(Group Not Found) - Hosting new session")
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if __wf_atom_7e8ad928(__wf_atom_15811761) then
			fn4()
		else
			_UpdateHostSession(__wf_atom_15811761)
		end
	end
end

local function fn6() -- 1 equivalent call inferred from this helper
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		if __wf_atom_bb46d8b6[i].isLocal then
			return __wf_atom_bb46d8b6[i]
		end
	end

	return nil
end

function CheckMatchmakingPermission()
	if not gRegion:IsMaster() then
		print("Matchmaking: CheckMatchmakingPermission(Failure)- You are not the host / Already in a session")
		return "/SF/Language/Matchmaking/AlreadyInGame"
	end

	if not module4.HasCompletedQuest(WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")) then
		print("Matchmaking: CheckMatchmakingPermission(Failure)- You have not completed the tutorial quest")
		return "/SF/Language/Matchmaking/SessionJoinFromTutorial"
	end

	if gGameRules:__wf_atom_d163c8e5(v3, 0) ~= 0 then
		print("Matchmaking: CheckMatchmakingPermission(Failure)- Hard mode (cogah) has been activated")
		return "/SF/Language/Matchmaking/Cogah"
	end

	if module3.GetIsBlockingPartyInvites() then
		print("Matchmaking: CheckMatchmakingPermission(Failure)- Currently blocking party invites")
		return "/SF/Language/Matchmaking/Blocked"
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) then
		local v4 = fn6() -- inferred equivalent call

		if v4 ~= nil and v4.teamToJoin ~= nil and __wf_atom_15811761:__wf_atom_7dc42df1(v4.teamToJoin) == 0 then
			print("Matchmaking: CheckMatchmakingPermission(Failure)- Squad Full")
			return "/SF/Language/Matchmaking/FullParty"
		end
	end

	local v4 = module2.CheckGameInvitePermission()

	if not __wf_atom_7e8ad928(v4) then
		print("Matchmaking: CheckMatchmakingPermission(Failure)- LOTUS_NET.CheckGameInvitePermission() failed")
		return "/SF/Language/Matchmaking/NotAvailable"
	end

	return v4
end

function LookForPublicGame(p, object)
	local v4 = CheckMatchmakingPermission()

	if v4 == nil then
		module.UnequipWeapon(object, true)
		local v5 = object:Attach(whistleDeco, Symbol("GAME_L1_WEAPON1"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
		object:PlaySound(castSound, false, 0, false)

		if not __wf_atom_7e8ad928(activateAnim) then
			object:__wf_atom_8914dfde("RockSummon", (object:__wf_atom_921c1a5f(activateAnim, false, 4, 1, true)))
		end

		if gRegion:IsMaster() then
			while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
				if
					object:__wf_atom_c138b19b(activateAnim)
					or object:__wf_atom_3c281634(activateAnim)
					or __wf_atom_7e8ad928(v5)
				then
					Sleep(0)
				else
					gRegion:__wf_atom_dd1e4d10(v5)
					break
				end
			end
		else
			while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
				if
					__wf_atom_7e8ad928(v5)
					or object:__wf_atom_c138b19b(activateAnim)
					or object:__wf_atom_3c281634(activateAnim)
				then
					Sleep(0)
				else
					v5:Destroy()
					break
				end
			end
		end

		ShowUIDialog()
		_T.publicSessionSearchResult = v.SEARCH_IN_PROGRESS
		print("Matchmaking: LookForPublicGame(Search In Progress)")
		fn2(fn(p), "OnPublicSessionFound", false)

		if gRegion:IsMaster() and not __wf_atom_7e8ad928(_T.GameModeName) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("MATCHMAKING_SEARCH"), _T.GameModeName)
			__wf_atom_21342f4a:StartTimer(Symbol("MATCHMAKING_SEARCH_TIME"), _T.GameModeName)
		end
	elseif not __wf_atom_7e8ad928(_T.ShowNotification) then
		_T.ShowNotification(v4, "Matchmaking", true, nil, nil, true)
	end
end

function AbortPublicGame()
	_T.publicSessionSearchResult = v.NONE
	print("Matchmaking: AbortPublicGame(Public Game aborted)")
	_G.matchmakingTimeoutActive = false
	_T.matchmakingSession = nil

	if not __wf_atom_7e8ad928(_T.ShowNotification) then
		_T.ShowNotification("/SF/Language/Matchmaking/SearchAborted", "Matchmaking", true, nil, nil, true)
	end

	ClosePublicGameLobby()
end

function OnCloseSessionSettingsUpdated() end

function ClosePublicGameLobby()
	if gRegion:IsMaster() then
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if not __wf_atom_7e8ad928(__wf_atom_15811761) then
			local settings = __wf_atom_15811761:GetSettings()
			settings.gameModeId = 0
			gMatchingService:__wf_atom_c8d901d4(settings, "OnCloseSessionSettingsUpdated")
			gMatchingService:__wf_atom_a8847956(Symbol("Matchmaking"))
		end

		gGameRules:UnHideGameSession()
		_T.publicSessionSearchResult = v.NONE
	end
end

function ShowUIDialog()
	if __wf_atom_7e8ad928(_T.ShowNotification) then
		return
	end

	if gRegion:IsMaster() then
		_T.ShowNotification("/SF/Language/Matchmaking/DialogSearchingMessage", "Matchmaking", true, nil, nil, true)
	elseif __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
		_T.ShowNotification(
			"/SF/Language/Matchmaking/DialogDesc_ClientCannotSearch",
			"Matchmaking",
			true,
			nil,
			nil,
			true
		)
	else
		_T.ShowNotification("[HC] Host started matchmaking", "Matchmaking", true, nil, nil, true)
	end
end