local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.UIUtilities")
local module6 = require("Lotus.Interface.CrossPlatformUtilities")
local module7 = require("SF.Interface.SFUtilities")
local module8 = require("Lotus.Interface.Libs.TimerMgr")
local module9 = require("Lotus.Interface.Components.PresenceHelper")
local v = {
	"/Lotus/Language/Game/Faction_GrineerUC",
	"/Lotus/Language/Game/Faction_CorpusUC",
	"/Lotus/Language/Game/Faction_InfestationUC",
	"/Lotus/Language/Game/Faction_OrokinUC"
}
local flag = true
local flag2 = false
local v2 = false
local v3 = nil
local mTimerMgr = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local friend = nil
local user = nil
local v12 = 0
local v13 = false
local v14 = nil
local v15 = nil
local v16 = false
local v17 = false
local v18 = {}

function IsInputBlocked()
	return false
end

function Shutdown()
	if v4 ~= nil then
		v4:Shutdown()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(gRegion) and v17 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_e424c72a(true)
		end
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Close()
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_FRIENDS_MAIN")
	end
end

local function fn()
	local topMenuChildButtons = {}
	local _ = not Engine.__wf_atom_fc67ba71()
	table.insert(topMenuChildButtons, {
		Label = "/Lotus/Language/Menu/Exit",
		CallBack = ExitScreen,
		CallOut = "MENU_CANCEL"
	})
	_T.TopMenuChildButtons = topMenuChildButtons
	_T.TopMenuChildButtonOptions = nil
end

local function fn2()
	local scrollValue = v4.mScrollBar:GetScrollValue()

	if v2 and v9 ~= nil then
		v9:SetActive(false)
	end

	v4:RemoveElements(true, true)
	v4:Populate()
	v4:RunForAllElements(function(p)
		if p.Friend.mId:__wf_atom_b70c3343() then
			gGameData:__wf_atom_6a4bcc2b(p.Friend.mDisplayName, false, "OnPendingFriendAccountIdResult")
		end
	end)
	v4:Redraw(nil, false, true)

	if scrollValue ~= nil then
		v4.mScrollBar:SetScrollValue(scrollValue, false)
	end

	if scrollValue ~= nil then
		v4.mScrollBar:SetScrollValue(scrollValue, false)
	end
end

function RefreshFriendsWindow()
	v12 = 0.001
end

function OnGetFriendsResult(p, p2)
	if p then
		v12 = 0.001
	else
		module.ShowMessage(module.ParseAddFriendErrorMsg(p2))
	end
end

function OnRichPresenceUpdated(p)
	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module9.RICH_PRESENCE_RESYNC_INTERVAL
	end

	if not p or __wf_atom_7e8ad928(v3) then
		return
	end

	if v12 <= 0 then
		v12 = 1
	end

	if v10 ~= nil then
		v10:SetActive(false)
	end

	local users = v4:GetUsers()
	local users2 = {}

	for i = 1, #users do
		local user2 = users[i]

		if user2.mStatus == 0 and user2.mPresence.state ~= 0 then
			table.insert(users2, user2)
		end
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:RemoveElements(true, true)
		local v19 = {}
		v4:GetSessionPlayers(v19, users2)
		mMovie:__wf_atom_2dedec1a("Sessions.Hint", 13, #v19 == 0)
		table.sort(v19, function(a, b)
			return a.Friend[1].mDisplayName < b.Friend[1].mDisplayName
		end)

		for i = 1, #v19 do
			v11:AddElement(v19[i], true)
		end

		v11:Redraw(nil, true, true)
	end
end

function ResyncRichPresence()
	if not __wf_atom_7e8ad928(v4) then
		v4:ResyncRichPresence()
	end
end

function OnLitePresenceUpdated(_)
	if _T.NextLitePresenceResync == nil then
		_T.NextLitePresenceResync = __wf_atom_c4e218a2() + module9.LITE_PRESENCE_RESYNC_INTERVAL
	end

	if not v2 then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module.Ternary(v2, module9.RICH_PRESENCE_RESYNC_INTERVAL, 2)
	end

	v2 = true

	if flag2 then
		v12 = 1
	end
end

function ResyncLitePresence()
	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_9d71d716("OnLitePresenceUpdated")
	end
end

function CanResyncPresence()
	return flag2 and v2
end

function OnPendingFriendAccountIdResult(p, p2)
	local accounts, _ = module6.GetAccountsFromIrcWhoQueryResults(p, p2, true)

	if #accounts == 1 then
		v4:RunForAllElements(function(p3)
			if p3.Friend.mDisplayName == accounts[1].Name then
				p3.mCachedId = accounts[1].AccountId
			end
		end)
	end
end

local function fn3()
	local module10 = require("Lotus.Interface.Components.UserList")
	v4 = module10.Create(
		mMovie,
		"UserList.Members.Member1",
		"UserList.Categories",
		"UserList.MemberSort",
		"ContextMenu",
		"UserList",
		19,
		false,
		v18
	)
	v4.mCategoryMenu.mShowCallouts = false
	v4.mUpperIcon = unreadIcon
	v4.mTimerMgr = mTimerMgr
	v4:HookUpCallbacks()
	v4.mShowClanRank = false
	v4:SetCallbacks("MenuItemPressed", "MenuItemFocused", "MenuItemUnfocused")
	v4:AttachScrollBar(v4.mRootClip .. ".MemberScrollBar", 5)
	v4.mScrollBarHorizontalOffset = nil
	v4.mSortMenu:SetWidth(205)
	v4.mShowMasteryRank = false

	if v4.mCategoryMenu ~= nil then
		v4:AddCategory({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_OnlineLabel", false),
			Icon = userListCategoriesTextures[1],
			Category = v4.ONLINE
		})
		v4:AddCategory({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_PendingLabel", false),
			Icon = userListCategoriesTextures[2],
			Category = v4.PENDING
		})
		v4:AddCategory({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_OfflineLabel", false),
			Icon = userListCategoriesTextures[3],
			Category = v4.OFFLINE
		})
	end

	function v4.mOnSelectedCallback(_) end

	function v4.mElementDrawCallback(_) end

	function v4:GetUsers()
		if __wf_atom_7e8ad928(v3) then
			return nil
		end

		return (v3:__wf_atom_0f109cd4())
	end

	function v4.IsFriendInfo(_)
		return true
	end

	v4:Populate()
	v4:RunForAllElements(function(p)
		if p.Friend.mId:__wf_atom_b70c3343() then
			gGameData:__wf_atom_6a4bcc2b(p.Friend.mDisplayName, false, "OnPendingFriendAccountIdResult")
		end
	end)
	local online = v4.ONLINE

	if _T.Friend_AutoTab ~= nil then
		online = _T.Friend_AutoTab
		_T.Friend_AutoTab = nil
	end

	v4:SetCategory(online)
	v4:Redraw()
	v4.mMuteGridOpenSound = true
end

local function fn4()
	local module10 = require("Lotus.Interface.Components.UserList")
	v5 = module10.Create(
		mMovie,
		"RecentPlayers.PlayerList.RecentPlayer",
		nil,
		nil,
		"RecentContextMenu",
		"RecentPlayers",
		8,
		false,
		v18
	)
	v5.mTimerMgr = mTimerMgr
	v5:HookUpCallbacks()
	v5.mShowClanRank = false
	v5.mShowMasteryRank = false
	v5:SetCallbacks("RecentMenuItemPressed", "RecentMenuItemFocused", "RecentMenuItemUnfocused")
	v5:AttachScrollBar(v5.mRootClip .. ".ScrollBar", 5)
	v5.mScrollBarHorizontalOffset = nil

	function v5.mOnSelectedCallback(_) end

	function v5.mElementDrawCallback(_) end

	function v5:GetUsers()
		if __wf_atom_7e8ad928(v3) then
			return nil
		end

		return (v3:GetRecent())
	end

	v5:Populate()
	v5:Redraw()
	v5.mMuteGridOpenSound = true
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_RecentPlayersBtn", false)
	mMovie:__wf_atom_50d60589("RecentPlayers.Title", 36, string.upper(__wf_atom_8e9ac384))
	mMovie:__wf_atom_e57658c2("RecentPlayers.Title", 44, v18.FloatingContent)
end

local function fn5()
	local module10 = require("Lotus.Interface.Components.ThemedSpinner")
	v10 = module10.Create(mMovie, "SessionSpinner", function(p)
		mMovie:__wf_atom_2dedec1a("SessionSpinner", 13, p)
	end)
	v10:SetActive(true)
	mMovie:__wf_atom_7d7314f1("Sessions.Title.text", "/SF/Language/Clan/SessionList_Title")
	mMovie:__wf_atom_e57658c2("Sessions.Title", 44, v18.FloatingContent)
	mMovie:__wf_atom_2dedec1a("Sessions.Hint", 13, false)
	mMovie:__wf_atom_7d7314f1("Sessions.Hint.text", "/Lotus/Language/Menu/Clan_NoSessionsAvailable")
	mMovie:__wf_atom_e57658c2("Sessions.Hint", 44, v18.FloatingContent)
	mMovie:OverrideMaterial("Sessions.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Sessions.Bg",
		"RectEdgeColor",
		v18.FloatingContentObject.r,
		v18.FloatingContentObject.g,
		v18.FloatingContentObject.b,
		0.3
	)
	mMovie:__wf_atom_1ca72041(
		"Sessions.Bg",
		"RectInnerColor",
		v18.Background1Object.r,
		v18.Background1Object.g,
		v18.Background1Object.b,
		0.4
	)
	local module11 = require("EE.Interface.Components.List")
	v11 = module11.CreateList(mMovie, "Sessions.Element", 3)
	v11.mForcedVerticalSeparation = 107
	v11:SetCallbacks("SessionPressed", "SessionFocused", "SessionUnfocused")
	v11:AttachScrollBar("Sessions.ScrollBar", 0)

	function v11.mClipCreatedCallback(p, _)
		mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			p .. ".Bg",
			"RectEdgeColor",
			v18.FloatingContentObject.r,
			v18.FloatingContentObject.g,
			v18.FloatingContentObject.b,
			0.3
		)
		mMovie:__wf_atom_1ca72041(p .. ".Bg", "RectInnerColor", 0, 0, 0, 0)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 11, v18.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 12, 30)
		mMovie:__wf_atom_4c1c1986(p, "Highlight", 15, 1)
		mMovie:__wf_atom_4c1c1986(p, "Separator", 11, v18.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p, "Separator", 12, 30)
		mMovie:__wf_atom_4c1c1986(p, "Count", 44, v18.FloatingContent)
	end

	function v11.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			v18.FloatingContentHighlightObject.r,
			v18.FloatingContentHighlightObject.g,
			v18.FloatingContentHighlightObject.b,
			0.8
		)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 8, { 15 }, { 50 }, 0.2)
	end

	function v11.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			v18.FloatingContentObject.r,
			v18.FloatingContentObject.g,
			v18.FloatingContentObject.b,
			0.3
		)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Highlight", 8, { 15 }, { 1 }, 0.2)
	end

	function v11.mOnSelectedCallback(_)
		if friend then
			return
		end

		print("Friends.lua - JoinSelected")

		if Engine.__wf_atom_84bb79c2() then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				__wf_atom_18a5d83b:__wf_atom_b2098de3(1)
			end

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_18a5d83b:__wf_atom_b2644498() then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GameJoinDisabledXBone", false))
			end
		end

		local mSelectedElement = v11.mSelectedElement

		if not __wf_atom_7e8ad928(mSelectedElement) then
			if mSelectedElement.JoinFailReason ~= nil then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384(mSelectedElement.JoinFailReason, false))
				return
			end

			local v19 = module3.CheckJoinSessionPermission(mSelectedElement.Friend[1].mPresence)

			if v19 then
				module.ShowMessage(mMovie:__wf_atom_8e9ac384(v19, false))
			else
				friend = mSelectedElement.Friend[1]
				module3.FindSessionById(friend.mPresence.session.id, "OnFindSessionComplete", false, true)
			end
		end
	end

	function v11:mElementDrawCallback()
		local mMissionInfo = nil
		local v19 = nil
		local v20 = nil

		if self.ModifierTag and self.ModifierTag ~= "" then
			local name = tostring(self.Node.name)

			if self.ModifierTag == module2.EVENT_TAG then
				if _G.CachedGoalInfo[name] then
					mMissionInfo = _G.CachedGoalInfo[name].mMissionInfo
					v19 = mMovie:__wf_atom_8e9ac384(_G.CachedGoalInfo[name].mDesc, false)
				elseif _T.LockedGoalMissionInfo and _T.LockedGoalMissionInfo[name] then
					mMissionInfo = _T.LockedGoalMissionInfo[name].mMissionInfo
					v19 = mMovie:__wf_atom_8e9ac384(_T.LockedGoalMissionInfo[name].mDesc, false)
				end
			elseif self.ModifierTag == module2.ALERT_TAG and _T.CachedAlerts[name] then
				mMissionInfo = _T.CachedAlerts[name].mAlertInfo.mMissionInfo
			elseif self.ModifierTag == module2.INVASION_ATTACKER_TAG and _T.CachedInvasionInfo[name] then
				mMissionInfo = _T.CachedInvasionInfo[name].mAttackerMissionInfo
			elseif self.ModifierTag == module2.INVASION_DEFENDER_TAG and _T.CachedInvasionInfo[name] then
				mMissionInfo = _T.CachedInvasionInfo[name].mDefenderMissionInfo
			elseif self.ModifierTag == module2.SYNDICATE_MISSION_TAG and _T.CachedSyndicateMissions[name] then
				mMissionInfo = _T.CachedSyndicateMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.SORTIE_MISSION_TAG and _T.CachedSortieMissions[name] then
				mMissionInfo = _T.CachedSortieMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.LITE_SORTIE_MISSION_TAG and _T.CachedLiteSortieMissions[name] then
				mMissionInfo = _T.CachedLiteSortieMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.ACTIVE_MISSION_TAG and _T.CachedActiveMissions[name] then
				mMissionInfo = _T.CachedActiveMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.KUVA_TOWER_MISSION_TAG and _T.CachedGhostTowerMissions[name] then
				mMissionInfo = _T.CachedGhostTowerMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.ELITE_ALERT_TAG and _T.CachedEliteAlertMissions[name] then
				mMissionInfo = _T.CachedEliteAlertMissions[name].mMissionInfo
			elseif self.ModifierTag == module2.HARD_DAILY_TAG and _T.CachedHardModeDailyMissions[name] then
				mMissionInfo = _T.CachedHardModeDailyMissions[name].mission
			elseif self.ModifierTag == module2.KEY_TAG then
				local v21 = self.GameModeId % 1000
				local __wf_atom_8be9ed2b = v4.mStarChart:__wf_atom_8be9ed2b(v21)
				local v22 = Type(__wf_atom_8be9ed2b)
				local v23 = Resource(v22)

				if not __wf_atom_7e8ad928(v23) then
					v20 = v23
				end
			end
		end

		if __wf_atom_7e8ad928(mMissionInfo) then
			mMissionInfo = v4.mStarChart:BuildMissionForLocation(self.Node.name)
		end

		local missionTypeName = module2.GetMissionTypeName(mMissionInfo)
		local v21 = self.Node.region + 1 == module2.REGION_ID_VOID and "Void" or missionTypeName
		local v22

		if
			__wf_atom_7e8ad928(self.Friend)
			or self.Friend[1].mPresence.session.gameModeId ~= module2.BuildGameModeIdForPhotobooth()
		then
			if
				__wf_atom_7e8ad928(self.Friend)
				or self.Friend[1].mPresence.session.gameModeId ~= module2.BuildGameModeIdForSimulacrum()
			then
				local v23 = TitleCase(mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Missions/MissionName_" .. missionTypeName,
					false
				))
				local planet = TitleCase(self.Planet)
				local node = TitleCase(mMovie:__wf_atom_8e9ac384(self.Node.locTag:c_str(), false))

				if _G.CachedGoalInfo[tostring(self.Node.name)] then
					node = string.upper(Localize(_G.CachedGoalInfo[tostring(self.Node.name)].mDesc, false))
				elseif _T.LockedGoalList and _T.LockedGoalList[tostring(self.Node.name)] then
					node = string.upper(Localize(_T.LockedGoalList[tostring(self.Node.name)].mDesc, true))
				end

				if v19 == nil then
					if self.Node.nodeType == 3 then
						v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SessionCycle_HubMissionDesc", false, {
							PLANET = planet,
							NODE = node
						})
					elseif v21 == "PVP" then
						v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SessionCycle_PvPMissionDesc", false, {
							TYPE = v23,
							NODE = node
						})
					elseif mMissionInfo.missionType == 30 then
						v22 = mMovie:__wf_atom_8e9ac384(v23, false)
					elseif __wf_atom_7e8ad928(v20) then
						if self.Node.name == module2.APARTMENT_NODE_TAG then
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Zariman/ZarimanApartment", true)
							v22 = ""
						else
							local v24 = v[mMissionInfo.faction + 1]
							v22 = (planet .. ": " .. node .. " (" .. v23 .. ")<br>") .. TitleCase(mMovie:__wf_atom_8e9ac384(v24, false)) .. " " .. module.FormatNumber(mMissionInfo.minEnemyLevel) .. "-" .. module.FormatNumber(mMissionInfo.maxEnemyLevel)
						end
					else
						local v24 = tostring(v20:__wf_atom_014a76a2())
						v22 = mMovie:__wf_atom_8e9ac384(v24, false)

						if string.find(v24, "SquadLink") then
							v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/G1Quests/FlotillaOperation", false) .. ": " .. v22
						end
					end
				else
					v22 = v19 .. " (" .. mMovie:__wf_atom_8e9ac384(v23, false) .. ")"
				end

				if module2.IsHardGameModeId(self.GameModeId) then
					v22 ..= " (" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/HardMode", true) .. ")"
				end
			else
				v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/DangerRoomConsole", false)
			end
		else
			v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Photobooth", false)
		end

		if self.Friend[1] == nil then
			return
		end

		local mDisplayName = self.Friend[1].mDisplayName
		local mPlayerLevel = tostring(self.Friend[1].mPlayerLevel)
		local v23 = mDisplayName .. " " .. mMovie:__wf_atom_8e9ac384("<RANK_" .. mPlayerLevel .. ">", true) .. module2.ProcessPlayerLevel(self.Friend[1].mPlayerLevel)
		local v24 = (("<p><font color=\"" .. v18.FloatingContentHex .. "\">" .. v23 .. "<br>") .. "<font color=\"" .. v18.FloatingContentHighlightHex .. "\">" .. v22 .. "</font>") .. "</font></p>"
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 46, "center")
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Label", 36, v24)
		local uiTexture_ProfilePlaceHolder = _G.UITexture_ProfilePlaceHolder
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", uiTexture_ProfilePlaceHolder)
		local filledSlots = self.Friend[1].mPresence.session.filledSlots
		local v25 = filledSlots + module.Ternary(filledSlots == 0, 1, 0)
		mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Count.text", "/SF/Language/Clan/SessionList_Count", {
			CURRENT = module.FormatNumber(v25),
			TOTAL = module.FormatNumber(self.Friend[1].mPresence.session.totalSlots)
		})
		local uiMode = module2.GetUIMode()
		self.JoinFailReason = nil

		if
			uiMode ~= module2.UI_MODE_IN_SPACE_SHIP
			and uiMode ~= module2.UI_MODE_IN_SPACE_HUB
			and uiMode ~= module2.UI_MODE_IN_DOJO
		then
			self.JoinFailReason = "/Lotus/Language/Menu/Session_LeaveMission"
		end
	end
end

local function fn6()
	mMovie:Close()
end

local function fn7()
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { 100, 0 }, 0.35, 0, function()
		flag = false
	end)
end

local function fn8()
	flag = true
	_T.gToolTip = nil

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0, fn6)
	end
end

function TransitionOut()
	fn8()
end

function ExitScreen()
	if _T.IsInScreenStack ~= nil and _T.IsInScreenStack("Friends") then
		_T.GoToPreviousScreen()
		return
	end

	fn8()
	module.PlaySound(_G.UISound_GridOpenTwo)
end

local function fn9()
	if v16 then
		v16 = false

		if gMatchingService:__wf_atom_a676a953() and _T.ScenarioSquadMembersChanged then
			_T.ScenarioSquadMembersChanged(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(), false, true)
		end
	end

	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if _T.IsInScreenStack == nil or not _T.IsInScreenStack("Friends") then
		fn8()
	else
		_T.GoToPreviousScreen()
	end

	local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

	if not __wf_atom_7e8ad928(__wf_atom_15811761) then
		local __wf_atom_6c164199 = __wf_atom_15811761:__wf_atom_6c164199()
		gMatchingService:__wf_atom_8b36b57b(__wf_atom_6c164199)
		_T.BackgroundMovie:Execute("GoToLobby", "")
	end
end

function OnJoinLobbyComplete(p)
	print("OnJoinLobbyComplete | result: " .. tostring(p))

	if p then
		gMatchingService:__wf_atom_7027399a(4)
		v13 = gMatchingService:__wf_atom_8b3e33a6() == 0

		if not v13 then
			fn9()
		end
	else
		_T.BackgroundMovie:Execute("ShowBlockingMessage", 0)
		local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
		local v19 = __wf_atom_91952c92 == "" and "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
			or __wf_atom_91952c92
		module.ShowMessage(v19)
	end

	friend = nil
end

function OnJoinGameplaySquadComplete(p)
	print("OnJoinGameplaySquadComplete(" .. tostring(p) .. ")")
	friend = nil

	if p then
		gMatchingService:__wf_atom_7027399a(4)
	end

	if v16 then
		v16 = false

		if gMatchingService:__wf_atom_a676a953() and _T.ScenarioSquadMembersChanged then
			_T.ScenarioSquadMembersChanged(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(), false, true)
		end
	end
end

function Close_Dialog(_)
	print("Close_Dialog")
	friend = nil
end

function OnFindSessionComplete(p)
	local v19, v20 = module3.CheckSingleSessionResults(
		p,
		false,
		friend.mPresence.session.teamId,
		nil,
		mMovie,
		"OnFindSessionComplete"
	)

	if type(v19) == "string" then
		if v20 and v20.customDialogFunction then
			v20.customDialogFunction()
		else
			module.ShowMessage(v19, "Close_Dialog", 0)
		end

		friend = nil
	else
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local teamId = friend.mPresence.session.teamId
		v16 = gMatchingService:__wf_atom_a676a953() and gMatchingService:__wf_atom_1b24a1bb()

		if __wf_atom_7e8ad928(gRegion) or not module2.IsInGamePlay() then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
			gMatchingService:JoinSquadSession(__wf_atom_18a5d83b, v19, false, teamId, "OnJoinLobbyComplete")
		else
			print("Friends.lua - OnFindSessionComplete, connect to lobby")
			gMatchingService:JoinSquadSession(__wf_atom_18a5d83b, v19, false, teamId, "OnJoinGameplaySquadComplete")
		end
	end
end

function OnAppReturnedFromConstrainedState()
	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_e1c832d0("OnGetFriendsResult")
	end
end

local function fn10()
	module5.DrawSeparator(mMovie, "Options.BottomLine", 350)
	mMovie:__wf_atom_e57658c2("Options.BottomLine", 11, v18.FloatingContent)
	mMovie:__wf_atom_2dedec1a("Options.Icon", 13, false)
	local module10 = require("EE.Interface.Components.List")
	v8 = module10.CreateList(mMovie, "Options.Option1", 3)
	v8.mForcedVerticalSeparation = 80
	v8:SetCallbacks("OptionPressed", "OptionFocused", "OptionUnfocused")

	function v8.mElementDrawCallback(data)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Image", data.Image)
		mMovie:__wf_atom_2dedec1a(data.mClipName .. ".Image", 13, not __wf_atom_7e8ad928(data.Image))
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", data.Icon)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, v18.FloatingContent)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 14, 60)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 15, 60)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 0, 40)
		local v19 = TitleCase(mMovie:__wf_atom_8e9ac384(data.Label, false))
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, v19)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, v18.FloatingContent)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Overlay", 11, v18.Background1)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Overlay", 12, 70)
		mMovie:OverrideMaterial(data.mClipName .. ".Edges", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Edges",
			"RectEdgeColor",
			v18.FloatingContentObject.r,
			v18.FloatingContentObject.g,
			v18.FloatingContentObject.b,
			0.35
		)
		mMovie:__wf_atom_1ca72041(data.mClipName .. ".Edges", "RectInnerColor", 0, 0, 0, 0)
	end

	function v8.mOnFocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Overlay", 8, { 12 }, { 10 }, 0.15)
		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Edges",
			"RectEdgeColor",
			v18.FloatingContentHighlightObject.r,
			v18.FloatingContentHighlightObject.g,
			v18.FloatingContentHighlightObject.b,
			0.8
		)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 44, v18.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 11, v18.FloatingContentHighlight)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Icon", 8, { 14, 15 }, { 70, 70 }, 0.2)
	end

	function v8.mOnUnfocusedCallback(p)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Overlay", 8, { 12 }, { 70 }, 0.15)
		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Edges",
			"RectEdgeColor",
			v18.FloatingContentObject.r,
			v18.FloatingContentObject.g,
			v18.FloatingContentObject.b,
			0.35
		)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Label", 44, v18.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Icon", 11, v18.FloatingContent)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Icon", 8, { 14, 15 }, { 60, 60 }, 0.2)
	end

	function v8.mOnSelectedCallback(p)
		mMovie:Execute(p.Callback, "")
	end

	v8:AddElement(
		{
			Label = "/Lotus/Language/Menu/SocialOverlay_AddFriendBtn",
			Icon = optionsIcons[1],
			Callback = "AddFriendBtn"
		},
		true
	)
	Engine.__wf_atom_fc67ba71()
	v8:Redraw()
end

function Initialize()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	mTimerMgr = module8.CreateTimerMgr()
	v3 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	mMovie:__wf_atom_e57658c2("_root", 4, -5000)
	v18 = {
		Positive = module4.GetColor(11, true),
		Content = module4.GetColor(6, true),
		Background1 = module4.GetColor(2, true),
		FloatingContent = module4.GetColor(9, true),
		FloatingContentHighlight = module4.GetColor(10, true)
	}
	v18.Background1Object = module.ConvertColorNumberToProceduralRGB(v18.Background1)
	v18.FloatingContentObject = module.ConvertColorNumberToProceduralRGB(v18.FloatingContent)
	v18.FloatingContentHighlightObject = module.ConvertColorNumberToProceduralRGB(v18.FloatingContentHighlight)
	v18.FloatingContentHex = module.ConvertColorNumberToHex(v18.FloatingContent)
	v18.FloatingContentHighlightHex = module.ConvertColorNumberToHex(v18.FloatingContentHighlight)
	fn()
	fn10()
	mMovie:__wf_atom_2dedec1a("ContextMenu", 13, false)
	mMovie:__wf_atom_2dedec1a("RecentContextMenu", 13, false)

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/FriendsUpperCase", false))
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	local v19

	if not __wf_atom_7e8ad928(gRegion) then
		v19 = gRegion:__wf_atom_c4f78a8f()
	end

	if not __wf_atom_7e8ad928(v19) and v19:__wf_atom_f63d17c0() then
		v19:__wf_atom_e424c72a(false)
		v17 = true
	end

	local module10 = require("Lotus.Interface.Components.ThemedSpinner")
	v9 = module10.Create(mMovie, "ListSpinner.Spinner", function(p)
		mMovie:__wf_atom_2dedec1a("ListSpinner", 13, p)
	end)
	v9:SetBackerVisible(false)
	v9:SetActive(true)
	mMovie:__wf_atom_e57658c2("ListSpinner.Bg", 11, v18.Background1)
	fn3()
	fn4()
	fn5()
	v3:__wf_atom_330f71b3("FriendInfoChanged")
	v3:__wf_atom_f21a84ca("FriendAdded")

	if
		not __wf_atom_7e8ad928(v3)
		and (v3:__wf_atom_e17e8a24() or Engine.__wf_atom_84bb79c2())
		and not __wf_atom_7e8ad928(v3)
	then
		v3:__wf_atom_e1c832d0("OnGetFriendsResult")
	end

	_T.NextLitePresenceResync = nil
	_T.NextRichPresenceResync = nil

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_9d71d716("OnLitePresenceUpdated")
	end

	fn7()
	mMovie:__wf_atom_0cf0fdbe(module4.MovieBackgroundAlpha)
	mMovie:__wf_atom_7df746cd(module4.MovieBackgroundColor)
	gClient:__wf_atom_7ea73984("OnAppReturnedFromConstrainedState")
	flag2 = true

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_FRIENDS_MAIN")
	end
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not flag2 then
		return
	end

	local v19 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v19)

	if not __wf_atom_7e8ad928(v10) then
		v10:Update()
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Update()
	end

	mTimerMgr:Update(v19)

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		gGameRules:ShowPauseMenu()
	end

	if v13 and gMatchingService:__wf_atom_8b3e33a6() > 0 then
		v13 = false
		fn9()
		print("Friends.lua: Joined squad.")
	end

	if v12 > 0 then
		v12 -= __wf_atom_fa1258d0()

		if v12 <= 0 then
			fn2()
		end
	end
end

function MenuItemFocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4.mStoredFocusId = tonumber(p)

		if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
			return
		else
			v4:FocusElementById((tonumber(p)))
		end
	end
end

function MenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v4) then
		v4.mStoredFocusId = nil

		if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
			return
		else
			v4:UnfocusElementById((tonumber(p)))
		end
	end
end

function MenuItemPressed(p)
	if not (flag or __wf_atom_7e8ad928(v4)) then
		v4:SelectElementById((tonumber(p)))
		module.PlaySound(_G.UISound_ItemTip)
	end
end

function RecentMenuItemFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5.mStoredFocusId = tonumber(p)

		if mMovie:__wf_atom_a91463a8("RecentContextMenu", 67) then
			return
		else
			v5:FocusElementById((tonumber(p)))
		end
	end
end

function RecentMenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5.mStoredFocusId = nil

		if mMovie:__wf_atom_a91463a8("RecentContextMenu", 67) then
			return
		else
			v5:UnfocusElementById((tonumber(p)))
		end
	end
end

function RecentMenuItemPressed(p)
	if not (flag or __wf_atom_7e8ad928(v5)) then
		v5:SelectElementById((tonumber(p)))
		module.PlaySound(_G.UISound_ItemTip)
	end
end

function CategoryFocused(p)
	if not (flag or __wf_atom_7e8ad928(v4.mCategoryMenu)) then
		v4.mCategoryMenu:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v4.mCategoryMenu) then
		v4.mCategoryMenu:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (flag or __wf_atom_7e8ad928(v4.mCategoryMenu)) then
		v4.mCategoryMenu:SelectElementById(tonumber(p), true)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v4.mSortMenu) then
		v4.mSortMenu:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v4.mSortMenu) then
		v4.mSortMenu:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (flag or __wf_atom_7e8ad928(v4.mSortMenu)) then
		v4.mSortMenu:SelectElementById(tonumber(p), true)
	end
end

function DropDownArrowPressed()
	if not __wf_atom_7e8ad928(v4.mSortMenu) then
		v4.mSortMenu:ArrowPressed()
	end
end

function DropDownArrowFocused()
	if not __wf_atom_7e8ad928(v4.mSortMenu) then
		v4.mSortMenu:ArrowFocused()
	end
end

function DropDownArrowUnfocused()
	if not __wf_atom_7e8ad928(v4.mSortMenu) then
		v4.mSortMenu:ArrowUnfocused()
	end
end

function RollOver()
	module.PlaySound(_G.UISound_Focus)
end

local function fn11(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2) -- 1 equivalent call inferred from this helper
	return __wf_atom_5e6e15c8 >= 1154
		and __wf_atom_5e6e15c8 <= 1499
		and __wf_atom_5e6e15c8_2 >= 442
		and __wf_atom_5e6e15c8_2 <= 797
end

local function fn12(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2) -- 1 equivalent call inferred from this helper
	return __wf_atom_5e6e15c8 >= 1154
		and __wf_atom_5e6e15c8 <= 1499
		and __wf_atom_5e6e15c8_2 >= 166
		and __wf_atom_5e6e15c8_2 <= 446
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
		return
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)
	local mScrollBar = v4.mScrollBar

	if fn11(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2) and not __wf_atom_7e8ad928(v11) then -- inferred equivalent call
		mScrollBar = v11.mScrollBar
	elseif fn12(__wf_atom_5e6e15c8, __wf_atom_5e6e15c8_2) and not __wf_atom_7e8ad928(v5) then -- inferred equivalent call
		mScrollBar = v5.mScrollBar
	end

	if not (flag or __wf_atom_7e8ad928(mScrollBar)) then
		mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyUp_MENU_CANCEL()
	if flag then
		return
	end

	if __wf_atom_7e8ad928(v4) or not v4:HideMenus() then
		ExitScreen()
	end
end

function FriendInfoChanged()
	if flag2 then
		v12 = 1
	end
end

function FriendAdded()
	if flag2 and not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_e1c832d0("OnGetFriendsResult")
	end
end

function RecruitFriend()
	if __wf_atom_d9227398() then
		module.ShowMessage("/Lotus/Language/Menu/KubrowLocked_Busy")
	else
		module.DoOpenWebBrowser("https://www.soulframe.com/referral")
	end

	module.PlaySound(_G.UISound_Select)
	module.PlaySound(_G.UISound_ButtonSelect)
	module.PlaySound(_G.UISound_SweetenerOne)
end

function OnInvitePlayer(p)
	if _T.ShowNotification ~= nil then
		_T.ShowNotification(p, "SquadMemberInvited")
	end
end

local function fn13()
	if not __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
		InvitePlayer()
	elseif
		__wf_atom_7e8ad928(gGameRules)
		or not (gGameRules:IsA(__wf_atom_589d05aa) and gGameRules:__wf_atom_72fc675e().soloMode)
	then
		module3.HostSquadSession("InvitePlayer")
	else
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GameInvitesDisabled", false))
	end
end

function InvitePlayer()
	if not v6 then
		return
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_9141808b()
	end

	module.PlaySound(_G.UISound_SweetenerOne)
	local platform = v6.platform or 6
	gMatchingService:__wf_atom_b83bc045(
		v6.AccountId,
		v6.User,
		module3.GetSquadMissionForInvite(),
		"OnInvitePlayer",
		platform
	)
end

local function fn14()
	if friend ~= nil then
		return
	end

	local v19 = module3.CheckJoinSessionPermission(v6.Friend.mPresence)

	if v19 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384(v19, false))
		return
	end

	print("Friends.lua - JoinSession")
	friend = v6.Friend
	module3.FindSessionById(friend.mPresence.session.id, "OnFindSessionComplete", false, true)
end

function OnAddToGuild(p, p2)
	if p or __wf_atom_7e8ad928(v3) then
		if user ~= nil then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/OrderInvite_Success", false, {
				PLAYER_NAME = user
			}))
		end
	else
		local addToGuildErrorMsg = module.ParseAddToGuildErrorMsg(p2)
		print("FAILURE: " .. p2)
		module.ShowMessage(addToGuildErrorMsg)
	end

	user = nil
end

function OnAddFriend(p, _)
	if p == "true" then
		module.PlaySound(_G.UISound_SweetenerOne)
		v12 = 0.001
	end
end

local function fn15(p, p2)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(p, "[]")
	local v19 = nil
	local v20 = __wf_atom_bb4529ac(p)
	local v21 = string.find(v20, "#")

	if invalidNameCharacters > 0 then
		v19 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			v20,
			invalidNameCharacters,
			invalidNameCharacters
		)
	elseif v20 == "" then
		v19 = "/Lotus/Language/Menu/SocialOverlay_EnterUsername"
	elseif string.lower(v20) == string.lower(__wf_atom_18a5d83b:__wf_atom_6be84646(true)) then
		v19 = "/Lotus/Language/Menu/SocialOverlay_FriendAddSelfError"
	elseif v21 ~= nil then
		local v22 = string.sub(v20, v21 + 1)
		local v23 = string.len(v22) == 3

		if v23 then
			local v24 = string.byte(v22, 1)

			if v24 < 48 or v24 > 57 then
				v23 = false
			else
				local v25 = string.byte(v22, 2)

				if v25 < 48 or v25 > 57 then
					v23 = false
				else
					local v26 = string.byte(v22, 3)

					if v26 < 48 or v26 > 57 then
						v23 = false
					end
				end
			end
		end

		v19 = not v23 and "/Lotus/Language/Menu/SocialOverlay_NonExistentUserError" or v19
	end

	if v19 == nil then
		module2.AddFriend(v20, "OnAddFriend", p2)
	else
		module.ShowMessage(v19)
	end
end

function AddFriend(p, p2)
	fn15(p, p2)
end

function OSKAddFriendCallback(p, p2)
	if not p then
		fn15(p2)
	end
end

function AddFriendCallback(p, p2)
	if not __wf_atom_7e8ad928(p) and tonumber(p) == 4 then
		fn15(p2)
	end
end

function AddFriendBtn()
	if module2.FriendLimitReached(mMovie, "OnAddFriend") then
		return
	end

	if Engine.__wf_atom_84bb79c2() then
		local _, v19 = module7.ShowInputDialog(
			mMovie,
			"/Lotus/Language/Menu/SocialOverlay_AddFriend",
			"",
			256,
			"AddFriendCallback",
			"OSKAddFriendCallback"
		)
		v7 = v19
	else
		module.PlaySound(_G.UISound_Select)
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.titleString = "/Lotus/Language/Menu/SocialOverlay_AddFriend"
		dialogSettings.firstString = "/SF/Language/Menu/Menu_Confirm"
		local v19 = nil
		local v20 = nil

		function _T.DialogSetupCallback(p)
			v19 = p.AddInputFieldComponent()
			v19:SetHint("/Lotus/Language/Menu/Global_Name")
			v19:SetMaxChars(30)
			v20 = p.AddInputFieldComponent()
			v20:SetHint("/Lotus/Language/Menu/Message")
			v20:SetMaxChars(200)
			v20:SetMultiline(true, 4)
			v20:SetHeight(210)
		end

		dialogSettings:SetCallback(function(p)
			if tonumber(p) == 4 then
				AddFriend(v19.mLabel, v20.mLabel)
			end
		end)
		module.ShowCustomMessage(dialogSettings)
	end
end

local function fn16(p, value)
	if p then
		return
	end

	local v19 = Localize("/Lotus/Language/Menu/BatchRemoveFriendsConfirmWord", false)

	if string.lower(value) ~= v19 then
		module.ShowErrorMessage("/Lotus/Language/Dojo/VaultContributionDecoIncorrectConfirmWord")
		return
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:Close()
		v15 = nil
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 4
	dialogSettings.locString = "/Lotus/Language/Menu/Store_PleaseWait"
	v15 = module.ShowCustomMessage(dialogSettings)
	gGameData:BatchRemoveFriends(
		v14.DaysLoggedOut,
		v14.SkipClanmates,
		v14.SkipFriendIds,
		v14.SkipFriendNames,
		"OnRemoveFriendResultToDialog"
	)
end

function BatchRemoveConfirmWordOSK(p, p2)
	fn16(p, p2)
end

function BatchRemoveConfirmWord(p, _, p2)
	fn16(tonumber(p2) ~= 4, p)
end

local function fn17()
	local v19 = Localize("/Lotus/Language/Menu/BatchRemoveFriendsConfirmWord", false)
	local v20 = Localize("/Lotus/Language/Menu/BatchRemoveFriendsConfirm", {
		BATCH_REMOVE = string.upper(v19)
	})
	local _, v21 = module7.ShowInputDialog(mMovie, v20, "", 20, "BatchRemoveConfirmWord", "BatchRemoveConfirmWordOSK")

	if not __wf_atom_7e8ad928(v21) then
		v21:Execute("SetConditionalWord", v19)
	end
end

function ConditionalFirstConfirm(p)
	if tonumber(p) == 4 then
		fn17()
	end
end

function BatchRemoveFriends()
	if not __wf_atom_7e8ad928(v7) then
		v7:Close()
	end

	v7 = _T.OpenScreen("GenericSettings")
	v7:Execute("SetTitle", "/Lotus/Language/Menu/FriendsRemove")

	function _T.SettingsChangesDone(list, p)
		_T.GetSettings = nil
		_T.SettingsChangesDone = nil

		if not __wf_atom_7e8ad928(p) then
			return
		end

		module.PlaySound(_G.UISound_GridOpen)
		module.PlaySound(_G.UISound_DialogOpen)
		local mDays = list[1].mToggleValues[list[1].mValue].mDays
		local mValue = list[2].mValue
		local v19 = {}
		local skipFriendNames = {}
		local skipFriendIds = {}

		for k in string.gmatch(list[3].mContent, "[^ ,]+") do
			v19[k] = true
		end

		local __wf_atom_0f109cd4 = gGameData:__wf_atom_0f109cd4()

		for _, v20 in ipairs(__wf_atom_0f109cd4) do
			if not v19[v20.mDisplayName] then
				continue
			end

			if v20.mId:__wf_atom_b70c3343() then
				table.insert(skipFriendNames, v20.mDisplayName)
			else
				table.insert(skipFriendIds, MongoId(v20.mId.mId))
			end

			v19[v20.mDisplayName] = nil
		end

		for k, _ in pairs(v19) do
			table.insert(skipFriendNames, k)
		end

		v14 = {
			DaysLoggedOut = mDays,
			SkipClanmates = mValue,
			SkipFriendIds = skipFriendIds,
			SkipFriendNames = skipFriendNames
		}

		if not Engine.__wf_atom_fc67ba71() then
			fn17()
			return
		end

		local v20 = Localize("/Lotus/Language/Dojo/VaultContributionDecoConfirmShort", {
			DECOS = ""
		})
		module.ShowConfirmMessage(v20, "ConditionalFirstConfirm", 3)
	end

	v7:Execute("SetCallBack", "SettingsChangesDone")

	function _T.GetSettings()
		local v19 = {}
		table.insert(v19, {
			mLabel = "/Lotus/Language/Menu/FriendsLastLoginTime",
			mType = module2.TOGGLE,
			mValue = 4,
			mToggleValues = {
				{
					Label = Localize("/Lotus/Language/Menu/Chat_BanDuration_1W", { TIME = 1 }),
					Value = 1,
					mDays = 7
				},
				{
					Label = Localize("/Lotus/Language/Menu/TimeFormat_Month", { TIME = 1 }),
					Value = 2,
					mDays = 30
				},
				{
					Label = Localize("/Lotus/Language/Menu/TimeFormat_Months", { TIME = 3 }),
					Value = 3,
					mDays = 91
				},
				{
					Label = Localize("/Lotus/Language/Menu/TimeFormat_Months", { TIME = 6 }),
					Value = 4,
					mDays = 182
				},
				{
					Label = Localize("/Lotus/Language/Menu/TimeFormat_Year", { TIME = 1 }),
					Value = 5,
					mDays = 365
				}
			}
		})
		table.insert(v19, {
			mLabel = "/Lotus/Language/Menu/FriendsSkipClanmates",
			mType = module2.CHECKBOX,
			mValue = false
		})
		table.insert(v19, {
			mLabel = "/Lotus/Language/Menu/FriendsSkipNames",
			mType = module2.INPUTBOX,
			mMaxChars = 500,
			mMultiLine = false,
			mSkipAutoFocus = true
		})
		return v19
	end

	v7:Execute("SetElementsFunction", "GetSettings")
	v7:Execute("SetConfirmButtonActive", "true")
	v7:Execute("EnableHints", "")
end

function OnConfirmFriendResult(p, p2)
	if not p then
		module.ShowMessage(module.ParseAddFriendErrorMsg(p2))
		return
	end

	local decoded = cjson.decode(p2)
	local displayName = ""

	if decoded and decoded.Friends and decoded.Friends[1] then
		displayName = decoded.Friends[1].DisplayName
	elseif v6 and v6.Friend then
		displayName = v6.Friend.mDisplayName
	end

	local username = "<font color=\"#DD9F38\">" .. displayName .. "</font>"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/SocialOverlay_FriendConfirmed", true, {
		USERNAME = username
	})
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = __wf_atom_8e9ac384
	dialogSettings.titleString = "/SF/Language/Menu/SocialOverlay_FriendConfirmedHeading"
	module.ShowCustomMessage(dialogSettings)
	v12 = 0.001
end

function OnRemoveFriendResultToDialog(p, p2)
	if not __wf_atom_7e8ad928(v15) then
		v15:Close()
		v15 = nil
	end

	if not p then
		module.ShowMessage(module.ParseAddFriendErrorMsg(p2))
		return
	end

	local decoded = cjson.decode(p2)
	local count = decoded.Friends and #decoded.Friends or 0

	if decoded.FriendNames then
		count += #decoded.FriendNames
	end

	if count > 1 or count == 0 then
		module.ShowMessage(Localize("/Lotus/Language/Menu/SocialOverlay_FriendsRemoveConfirm", {
			COUNT = count
		}))
	else
		module.ShowMessage(Localize("/Lotus/Language/Menu/SocialOverlay_FriendRemoveConfirm", {}))
	end

	v12 = 0.001
end

local function fn18(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(v3) then
		if string.find(v6.Friend.mDisplayName, " ") and v6.Friend.mId:__wf_atom_b70c3343() then
			v6.Friend.mDisplayName = string.gsub(v6.Friend.mDisplayName, " ", "%%20")
		end

		v3:__wf_atom_49d863d3(v6.Friend, "OnRemoveFriendResultToDialog")
	end
end

function RemoveFriendConfirm(p)
	fn18(p)
end

local function fn19()
	if Engine.__wf_atom_84bb79c2() then
		fn18(4)
		return
	end

	local username = "<font color=\"#DD9F38\">" .. v6.Friend.mDisplayName .. "</font>"
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/SocialOverlay_RemoveFriendConfirm", true, {
		USERNAME = username
	})
	module.ShowConfirmMessage(
		__wf_atom_8e9ac384,
		"RemoveFriendConfirm",
		nil,
		"/SF/Language/Menu/SocialOverlay_RemoveFriendConfirmHeading"
	)
end

function OnRemoveAllFriendsIndividualResult(p, p2)
	if p then
		v12 = 0.001
	else
		module.ShowMessage(module.ParseAddFriendErrorMsg(p2))
	end
end

function OnRemoveAllFriendsResult(p, p2)
	if not p then
		module.ShowMessage(module.ParseAddFriendErrorMsg(p2))
		return
	end

	module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_FriendRemoveConfirm", false))
	v12 = 0.001
end

function RemoveAllFriendsConfirm(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_fb6ef353("OnRemoveAllFriendsResult")
	end
end

function OnSetFriendNoteResult(p, p2)
	if p then
		local decoded = cjson.decode(p2)
		local v19

		if decoded.Id then
			v19 = MongoId(decoded.Id)
		end

		for i = 1, #v4.mElements do
			if not (v4.mElements[i].AccountId == v19 or v4.mElements[i].Friend.mDisplayName == decoded.Name or #v4.mElements[i].Friend.mPlatformNames > 0 and table.find(
				v4.mElements[i].Friend.mPlatformNames,
				decoded.Name
			) ~= nil) then
				continue
			end

			v4.mElements[i].Friend.mNote = decoded.Note

			if v4.mElements[i].mClipName ~= nil then
				mMovie:__wf_atom_7f57ab2f(v4.mElements[i].mClipName, "Note", 13, decoded.Note ~= "")
			end

			if v4:GetFocusedElement() ~= v4.mElements[i] then
				break
			end

			if decoded.Note == "" then
				_T.gToolTip = nil
				return
			end

			if v4.mDoProfanityFilter then
				_T.gToolTip = __wf_atom_f8f86fc5(decoded.Note, 0)
			else
				_T.gToolTip = decoded.Note
			end

			return
		end
	end
end

function OnSetFriendFavoriteResult(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if not p then
		module.ShowErrorMessage("/Lotus/Language/Chat/SetFriendFavoriteFail")
		return
	end

	local decoded = cjson.decode(p2)
	local v19

	if decoded.Id then
		v19 = MongoId(decoded.Id)
	end

	for i = 1, #v4.mElements do
		if not (v4.mElements[i].AccountId == v19 or v4.mElements[i].Friend.mDisplayName == decoded.Name or #v4.mElements[i].Friend.mPlatformNames > 0 and table.find(
			v4.mElements[i].Friend.mPlatformNames,
			decoded.Name
		) ~= nil) then
			continue
		end

		v4.mElements[i].Friend.mFavorite = decoded.Favorite
		break
	end

	v4:Redraw(nil, true, true)
end

function SetFriendNote(p, p2)
	if not __wf_atom_7e8ad928(p) and tonumber(p) == 4 then
		v3:SetFriendNote(v6.Friend, p2, "OnSetFriendNoteResult")
	end
end

function OSKSetFriendNote(p, p2)
	if not p then
		v3:SetFriendNote(v6.Friend, p2, "OnSetFriendNoteResult")
	end
end

function OnIgnoreUser(user2, p)
	if p ~= "nil" then
		if p == "true" then
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_IgnoringUser", false, {
				USER = user2
			}))
		else
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ListeningUser", false, {
				USER = user2
			}))
		end
	end
end

local function fn20(focusedElement, p)
	v6 = focusedElement
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(v3) then
		return
	end

	local v19 = v6.User == __wf_atom_18a5d83b:__wf_atom_6be84646()
	local __wf_atom_940f8971 = Engine.__wf_atom_940f8971(v6.User)
	local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
	v6.platform = __wf_atom_940f8971
	local ternary = module.Ternary(p, v5.mContextMenu, v4.mContextMenu)
	ternary:RemoveElements(true, true)

	if not v19 and (p or v6.State ~= 0) then
		if
			not Engine.__wf_atom_fc67ba71()
			or not Engine.__wf_atom_84bb79c2() and __wf_atom_18a5d83b:__wf_atom_51613fe5()
			or Engine.__wf_atom_84bb79c2() and __wf_atom_18a5d83b:__wf_atom_e3850439()
		then
			ternary:AddElement({
				Name = "/Lotus/Language/Menu/Chat_ContextMenu_Talk",
				PressedCallback = function()
					local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())

					if not __wf_atom_7e8ad928(movie) then
						movie:Execute("TalkToPlayer", v6.User)
					end
				end
			}, true)
		end

		if not module7.GetIsBlockingPartyInvites() then
			ternary:AddElement({
				Name = "/Lotus/Language/Menu/SocialOverlay_ContextInvite",
				PressedCallback = function()
					fn13()
				end
			}, true)

			if module3.ShowJoinSessionCommand(v6.Friend.mPresence) and v6.Status == 0 then
				ternary:AddElement({
					Name = "/Lotus/Language/Menu/SocialOverlay_JoinSession",
					PressedCallback = function()
						fn14()
					end
				}, true)
			end
		end
	end

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) and v6.Friend.mId:__wf_atom_b70c3343() then
		local _ = v6.mCachedId == nil
	end

	if p then
		local user2 = v6.User
		local v20

		if not __wf_atom_7e8ad928(v3) then
			local __wf_atom_0f109cd4 = v3:__wf_atom_0f109cd4()
			local flag3 = true

			for i = 1, #__wf_atom_0f109cd4 do
				if __wf_atom_0f109cd4[i].mDisplayName ~= user2 then
					continue
				end

				v20 = true
				flag3 = false
				break
			end

			if flag3 then
				v20 = false
			end
		end

		if not v20 and __wf_atom_940f8971 == __wf_atom_63bb2bc6 then
			ternary:AddElement({
				Name = "/Lotus/Language/Menu/SocialOverlay_AddFriend",
				PressedCallback = function()
					module2.AddFriend(v6.User)
				end
			}, true)
		end
	elseif v6.Status == 1 then
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_AcceptFriend",
			PressedCallback = function()
				if not __wf_atom_7e8ad928(gGameData) then
					gGameData:__wf_atom_2e6558d0(v6.AccountId, "OnConfirmFriendResult")
				end
			end
		}, true)
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_AcceptAllFriends",
			PressedCallback = function()
				if not __wf_atom_7e8ad928(gGameData) then
					gGameData:__wf_atom_06853341("OnConfirmFriendResult")
				end
			end
		}, true)
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_DeclineFriend",
			PressedCallback = function()
				fn19()
			end
		}, true)
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_DeclineAllFriends",
			PressedCallback = function()
				module.ShowConfirmMessage("/Lotus/Language/Menu/RemoveFriend_Confirm", "RemoveAllFriendsConfirm")
			end
		}, true)
	else
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_Remove",
			PressedCallback = function()
				fn19()
			end
		}, true)
	end

	local __wf_atom_ca48a66f = v3:__wf_atom_ca48a66f()

	if #__wf_atom_ca48a66f > 0 and v3:__wf_atom_4a5a45f5(2) then
		local v20 = false

		for i = 1, #__wf_atom_ca48a66f do
			if not (not __wf_atom_ca48a66f[i].mId:__wf_atom_b70c3343() and __wf_atom_ca48a66f[i].mId == v6.AccountId or __wf_atom_ca48a66f[i].mDisplayName == v6.Friend.mDisplayName or table.find(
				__wf_atom_ca48a66f[i].mPlatformNames,
				v6.Friend.mDisplayName
			)) then
				continue
			end

			v20 = true
			break
		end

		if not v20 then
			ternary:AddElement({
				Name = "/Lotus/Language/Menu/SocialOverlay_OrderInvite",
				PressedCallback = function()
					user = v6.User

					if not __wf_atom_7e8ad928(v3) then
						v3:__wf_atom_4773d482(v6.User, "OnAddToGuild")
					end
				end
			}, true)
		end
	end

	if Engine.__wf_atom_fc67ba71() and not Engine.__wf_atom_b290ec01() and __wf_atom_940f8971 == __wf_atom_63bb2bc6 then
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/ShowGamerCard_Windows",
			PressedCallback = function()
				v4:ViewConsoleProfile(v6.User)
			end
		}, true)
	end

	if p then
		ternary:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_ReportPlayer",
			PressedCallback = function()
				v7 = module7.ShowReportMenu(mMovie, v6.User)
				return false
			end
		}, true)
		ternary:AddElement({
			Name = v3:__wf_atom_56f280e3(v6.User) and "/Lotus/Language/Menu/Chat_ContextMenu_Listen" or "/Lotus/Language/Menu/Chat_ContextMenu_Ignore",
			PressedCallback = function()
				local user2 = v6.User
				module2.ToggleIgnoreUser(user2, false, "OnIgnoreUser")
			end
		}, true)
	else
		if v6.Status ~= 1 then
			ternary:AddElement({
				Name = v6.Friend.mFavorite and "/Lotus/Language/Chat/ContextMenu_Unfavorite" or "/Lotus/Language/Chat/ContextMenu_Favorite",
				PressedCallback = function()
					_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
					v3:__wf_atom_998d422e(v6.Friend, not v6.Friend.mFavorite, "OnSetFriendFavoriteResult")
				end
			}, true)
		end

		if not v4.mIsUGCRestricted then
			ternary:AddElement({
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_EditFriendNote", false) .. " " .. mMovie:__wf_atom_8e9ac384("<NOTE>", true),
				PressedCallback = function()
					local _, v20 = module7.ShowInputDialog(
						mMovie,
						"/Lotus/Language/Menu/SocialOverlay_EditFriendNote",
						v6.Friend.mNote,
						200,
						"SetFriendNote",
						"OSKSetFriendNote",
						{ isMultiline = true }
					)
					v7 = v20
				end
			}, true)
		end
	end

	if ternary:GetHowManyElements() > 0 then
		ternary:Show()
	end
end

function onRawInputEvent(_, value, p)
	if
		p ~= "0"
		or flag
		or __wf_atom_7e8ad928(v4)
		or __wf_atom_7e8ad928(v4.mContextMenu)
		or __wf_atom_7e8ad928(v5)
		or __wf_atom_7e8ad928(v5.mContextMenu)
	then
		return 1
	end

	local v19 = Engine.__wf_atom_b290ec01() and "EN_GAMEPAD_BUTTON_RIGHT" or "EN_GAMEPAD_BUTTON_BOTTOM"
	local v20 = string.find(value, "EN_MOUSE_B0") ~= nil or string.find(value, v19) ~= nil
	local v21 = string.find(value, "EN_MOUSE_B1") ~= nil
	local v22 = __wf_atom_7e8ad928(v4.mContextMenu:GetFocusedElement())
	local v23 = __wf_atom_7e8ad928(v5.mContextMenu:GetFocusedElement())

	if not (v20 or v21) then
		return 1
	end

	if mMovie:__wf_atom_a91463a8(v4.mContextMenuClipName, 67) and v22 then
		v4.mContextMenu:Hide()
	elseif mMovie:__wf_atom_a91463a8(v5.mContextMenuClipName, 67) and v23 then
		v5.mContextMenu:Hide()
	end

	if v21 or v20 and (v22 or v23) then
		local focusedElement = v4:GetFocusedElement()
		local focusedElement2 = v5:GetFocusedElement()

		if __wf_atom_7e8ad928(focusedElement) then
			if not __wf_atom_7e8ad928(focusedElement2) then
				fn20(focusedElement2, true)
			end
		else
			fn20(focusedElement, false)
		end
	end

	return 1
end

function onViewportSizeChanged(_, _) end

function OptionPressed(p)
	if flag or v8 == nil then
		return
	end

	v8:SelectElementById((tonumber(p)))
end

function OptionFocused(p)
	if v8 == nil then
		return
	end

	v8:FocusElementById((tonumber(p)))
end

function OptionUnfocused(p)
	if v8 == nil then
		return
	end

	v8:UnfocusElementById((tonumber(p)))
end

function SessionPressed(p)
	if flag or v11 == nil then
		return
	end

	v11:SelectElementById((tonumber(p)))
end

function SessionFocused(p)
	if v11 == nil then
		return
	end

	v11:FocusElementById((tonumber(p)))
end

function SessionUnfocused(p)
	if v11 == nil then
		return
	end

	v11:UnfocusElementById((tonumber(p)))
end

function IgnoreParentCloseRequest()
	return true
end

function SupportsThemes()
	return true
end

function OpenedFromPauseMenu()
	mMovie:__wf_atom_0cf0fdbe(0)
end

function PrepareToClose()
	fn8()
end