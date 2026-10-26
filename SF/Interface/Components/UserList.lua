module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Interface.CrossPlatformUtilities")

function Create(p, mRootClip, _, mSortClipName, p2)
	local module5 = require("EE.Interface.Components.ItemList")
	local mVisRangeMaterials = {
		Icon = _G.UIMaterial_PopupVerticalVisibilityRange,
		Text = _G.UIMaterial_PopupVerticalVisibilityRangeText,
		UnfocusedItem = _G.UIMaterial_PopupBackerBorderSingle,
		FocusedItem = _G.UIMaterial_PopupBackerBorderSingle,
		SelectedItem = _G.UIMaterial_PopupBackerBorderSingle
	}
	local v = module5.Create(p, mRootClip, {
		mCanSelectItem = true,
		mTabsInitialY = 68,
		mVisRangeMaterials = mVisRangeMaterials
	})
	v.mPrefix = "UserList(" .. mRootClip .. ")::"
	v.mRootClip = mRootClip
	v.mSortClipName = mSortClipName
	v.mContextMenuClipName = nil
	v.mUserCount = {}
	v.ONLINE = 1
	v.OFFLINE = 2
	v.PENDING = 3
	v.STEAM = 4
	v.mDoProfanityFilter = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings():__wf_atom_bb0f4637()
	v.mIsUGCRestricted = module.IsUGCRestricted()
	v.mApplyThemes = true
	v.mContentOffset = 70
	v.mForcedVerticalSeparation = 60
	v.mContentHeight = 580
	v.InviteState = { INVITESENT = 1, INSQUAD = 2, DECLINE = 3 }

	function v.HideMenus(p3)
		if not __wf_atom_7e8ad928(p3.mContextMenu) and p3.mContextMenu.mVisible then
			p3.mContextMenu:Hide()
			return true
		end

		if __wf_atom_7e8ad928(p3.mSortMenu) or not p3.mSortMenu:IsExpanded() then
			return
		end

		p3.mSortMenu.mMainButton:Pressed(true, true)
		return true
	end

	function v:GetPlanetAndNodeFromModeId(p3)
		local v2 = nil
		local v3 = nil
		local v4 = ""
		local v5

		if p3 == 0 or __wf_atom_7e8ad928(self.mStarChart) then
			v5 = ""
			return v2, v3, v5
		end

		local v6 = nil
		local displayedNodeName = module2.GetDisplayedNodeNameFromGameModeId(p3)
		v5 = module2.GetNodeModifierTagFromGameModeId(p3)

		if displayedNodeName then
			v3 = self.mStarChart:__wf_atom_d5226f21(Symbol(displayedNodeName))

			if
				v3
				and v3.name ~= EMPTY_SYMBOL
				and v3.region ~= module2.REGION_ID_PVP
				and v3.region ~= module2.REGION_ID_CLAN_DOJO
			then
				v6 = self.mRegions[v3.region + 1]

				if v3.mission.missionType == 32 then
					v4 = "_SPACE"
				end
			end
		end

		if v6 == nil then
			local region = module2.GetRegionFromGameModeId(p3)

			if region then
				v6 = self.mRegions[region]
			end
		end

		if v6 == nil then
			return v2, v3, v5
		end

		if module2.IsDuviriNode(displayedNodeName) then
			return string.upper(Localize("/Lotus/Language/Duviri/Duviri", {})), v3, v5
		end

		v2 = string.upper(self.mMovie:__wf_atom_8e9ac384(tostring(v6.name) .. v4, false))
		return v2, v3, v5
	end

	function v:GetSessionPlayers(list, list2)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local v2 = MongoId(__wf_atom_18a5d83b:__wf_atom_e75653c3())
		local v3 = {}

		for i = 1, #list2 do
			local v4 = list2[i]

			if not ((v4.mPresence.state == 3 or v4.mPresence.state == 4) and v4.mPresence.session.id ~= "" and v4.mId ~= v2) then
				continue
			end

			if module3.CheckJoinSessionPermission(v4.mPresence) ~= nil then
				continue
			end

			if v3[v4.mPresence.session.id] == nil or list[v3[v4.mPresence.session.id]] == nil then
				local gameModeId = v4.mPresence.session.gameModeId
				local planetAndNodeFromModeId, node, modifierTag = self:GetPlanetAndNodeFromModeId(gameModeId)

				if planetAndNodeFromModeId ~= nil and node ~= nil then
					table.insert(list, {
						Friend = { v4 },
						Planet = planetAndNodeFromModeId,
						Node = node,
						ModifierTag = modifierTag,
						GameModeId = gameModeId
					})
					v3[v4.mPresence.session.id] = #list
				end
			else
				table.insert(list[v3[v4.mPresence.session.id]].Friend, v4)
			end
		end

		module.ShuffleTable(list)
	end

	v._UserList_Redraw = v.Redraw

	function v:Redraw(p3, p4, p5)
		if self.mSortingChanged or p4 then
			self:ItemList_RemoveElements(true, true)

			if self.mSortBy then
				if type(self.mSortBy) == "function" then
					table.sort(self.mUnfilteredElements, self.mSortBy)
				elseif self.mLastSortBy then
					if type(self.mLastSortBy) == "function" then
						table.sort(self.mUnfilteredElements, function(a, b)
							return (self:DoubleSortWithFunction(a, b))
						end)
					else
						table.sort(self.mUnfilteredElements, function(a, b)
							return (self:DoubleSort(a, b))
						end)
					end
				else
					table.sort(self.mUnfilteredElements, function(a, b)
						return (self:Sort(a, b))
					end)
				end
			end

			__wf_atom_83c14687(0)
			self.mSortingChanged = false

			for i = 1, #self.mUnfilteredElements do
				__wf_atom_83c14687(0)
				self.mUnfilteredElements[i].mClipName = nil

				if self:FilterElement(self.mUnfilteredElements[i]) then
					self:ItemList_AddElement(self.mUnfilteredElements[i], true)
				end
			end
		end

		self:_UserList_Redraw(p3, p4, p5)
		local __wf_atom_5e6e15c8 = v.mMovie:__wf_atom_5e6e15c8(mRootClip, 1)

		if self.mSortMenu then
			v.mMovie:__wf_atom_e57658c2(mSortClipName, 1, __wf_atom_5e6e15c8 + 44)
		end

		if self.mSearchBox then
			self.mSearchBox:SetPosition(nil, __wf_atom_5e6e15c8 + 44)
		end

		v.mMovie:__wf_atom_4c1c1986(mRootClip, "Offset.Scroll", 1, 40)
		v.mMovie:__wf_atom_4c1c1986(mRootClip, "TitleBar.Backer", 14, 450)
		v.mMovie:__wf_atom_4c1c1986(mRootClip, "TitleBar.Backer", 15, 50)
		local __wf_atom_cfc41e35 = v.mMovie:__wf_atom_cfc41e35(mRootClip, "TitleBar.Backer", 0)
		v.mMovie:__wf_atom_4c1c1986(mRootClip, "TitleBar.DetailLeft", 0, __wf_atom_cfc41e35 - 225)
		v.mMovie:__wf_atom_4c1c1986(mRootClip, "TitleBar.DetailRight", 0, __wf_atom_cfc41e35 + 225)
	end

	v._UserList_OnDraw = v.OnDraw

	function v:OnDraw(data, p3)
		if data.mClipName == nil then
			return
		end

		self:_UserList_OnDraw(data, p3)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgMask", 14, self.mMovie:__wf_atom_5e6e15c8(self.mRootClip, 14))
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgMask", 0, 0)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgEndLeft", 0, 41)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgEndLeft", 15, 50)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgEndRight", 15, 50)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgFill", 15, 50)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Name", 1, -16)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Status", 1, -16)
		self.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Name", 13, not data.Filler)
		self.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Rank", 13, not data.Filler)
		self.mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon", 13, not data.Filler)

		if data.Filler then
			return
		end

		local ternary = module.Ternary(data.mInviteState == v.InviteState.INVITESENT, 50, 100)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgFill", 12, ternary)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgEndLeft", 12, ternary)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "BgEndRight", 12, ternary)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Name", 12, ternary)
		self.mMovie:__wf_atom_4c1c1986(data.mClipName, "Status", 12, ternary)
		local rankString = ""

		if self.mShowClanRank then
			rankString = data.RankString
		elseif data.mInviteState == v.InviteState.INVITESENT or data.Categories[1] == self.PENDING then
			rankString = self.mMovie:__wf_atom_8e9ac384("/SF/Language/Game/Presence_InviteSent", false)
		elseif data.mInviteState == v.InviteState.INSQUAD then
			rankString = self.mMovie:__wf_atom_8e9ac384("/SF/Language/Game/Presence_InSquad", false)
		elseif data.mInviteState == v.InviteState.DECLINE then
			rankString = self.mMovie:__wf_atom_8e9ac384("/SF/Language/Game/Presence_Decline", false)
		elseif data.Categories[1] ~= self.PENDING and data.Categories[1] ~= self.OFFLINE then
			if data.State == 3 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_PreGameLobby", false)
			elseif data.State == 4 then
				local gameModeId = data.Friend.mPresence.session.gameModeId
				local planetAndNodeFromModeId

				if gameModeId == module2.BuildGameModeIdForClanDojo() then
					planetAndNodeFromModeId = self.mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Game/Presence_Dojo",
						false
					)
				elseif gameModeId == module2.BuildGameModeIdForDojoDuel() then
					planetAndNodeFromModeId = self.mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Game/Presence_DojoDuel",
						false
					)
				else
					local __wf_atom_8e9ac384 = self.mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Game/Presence_InGame",
						false
					)

					if gameModeId == module2.BuildGameModeIdForPhotobooth() then
						planetAndNodeFromModeId = __wf_atom_8e9ac384 .. " : " .. self.mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/Loadout_Photobooth",
							false
						)
					elseif gameModeId == module2.BuildGameModeIdForSimulacrum() then
						planetAndNodeFromModeId = __wf_atom_8e9ac384 .. " : " .. self.mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/Game/DangerRoomConsole",
							false
						)
					else
						local v2
						planetAndNodeFromModeId, v2 = self:GetPlanetAndNodeFromModeId(gameModeId)

						if planetAndNodeFromModeId == nil then
							planetAndNodeFromModeId = __wf_atom_8e9ac384
						elseif v2 ~= nil then
							if string.find(string.lower((tostring(v2.name))), "pvpnode") then
								planetAndNodeFromModeId = self.mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Missions/MissionName_PVP",
									false
								)
							end

							local v3 = string.upper(self.mMovie:__wf_atom_8e9ac384(v2.locTag:c_str(), true))

							if _G.CachedGoalInfo[tostring(v2.name)] then
								v3 = string.upper(Localize(_G.CachedGoalInfo[tostring(v2.name)].mDesc, true))
							elseif _T.LockedGoalList and _T.LockedGoalList[tostring(v2.name)] then
								v3 = string.upper(Localize(_T.LockedGoalList[tostring(v2.name)].mDesc, true))
							elseif v2.name == EMPTY_SYMBOL and module2.IsKeyGameModeId(gameModeId) then
								local v4 = gameModeId % 1000
								local __wf_atom_8be9ed2b = self.mStarChart:__wf_atom_8be9ed2b(v4)
								local v5 = Type(__wf_atom_8be9ed2b)
								local v6 = Resource(v5)

								if not __wf_atom_7e8ad928(v6) then
									local v7 = tostring(v6:__wf_atom_014a76a2())

									if string.find(v7, "SquadLink") then
										planetAndNodeFromModeId = self.mMovie:__wf_atom_8e9ac384(
											"/Lotus/Language/G1Quests/FlotillaOperation",
											false
										)
									end

									v3 = self.mMovie:__wf_atom_8e9ac384(v7, false)
								end
							end

							if module2.IsHardGameModeId(gameModeId) then
								v3 ..= " (" .. self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/HardMode", true) .. ")"
							end

							planetAndNodeFromModeId ..= " : " .. v3
						end
					end
				end

				rankString = TitleCase(planetAndNodeFromModeId)
			elseif data.State == 0 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_Offline", false)
			elseif data.State == 1 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_Online", false)
			else
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_InMenus", false)
			end
		end

		self.mMovie:__wf_atom_50d60589(data.mClipName .. ".Status", 36, TitleCase(rankString))
	end

	v._UserList_OnClipCreated = v.OnClipCreated

	function v.OnClipCreated(object, p3, p4)
		object:_UserList_OnClipCreated(p3, p4)
		object.mMovie:__wf_atom_4c1c1986(p3, "Name", 50, 23)
		object.mMovie:__wf_atom_4c1c1986(p3, "Status", 50, 23)
	end

	v.UserList_OnFocused = v.OnFocused

	function v.OnFocused(object, p3)
		if p3.mInviteState == v.InviteState.INVITESENT then
			return
		end

		object:UserList_OnFocused(p3)
		object.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Name", 1, -16)
		object.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Status", 1, -16)
	end

	v.UserList_OnUnfocused = v.OnUnfocused

	function v.OnUnfocused(object, p3)
		if p3.mInviteState == v.InviteState.INVITESENT then
			return
		end

		object:UserList_OnUnfocused(p3)
		object.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Name", 1, -16)
		object.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Status", 1, -16)
	end

	v.UserList_OnSelected = v.OnSelected

	function v.OnSelected(object, p3, p4)
		if p3.mInviteState == v.InviteState.INVITESENT then
			return
		end

		object:UserList_OnSelected(p3, p4)
	end

	function v.GetUsers(_)
		print("Error: This function needs to be overloaded to get the users you wanna show (friends, clan, etc).")
		assert(false)
		return {}
	end

	function v.BuildUser(_, friend, id, p3)
		local v2 = {
			Id = id,
			Friend = friend,
			Name = friend.mDisplayName,
			User = friend.mDisplayName,
			UserLower = string.lower(friend.mDisplayName),
			AccountId = friend.mId,
			State = friend.mPresence.state,
			Status = friend.mStatus,
			AvatarImageType = friend.mActiveAvatarImageType,
			LastLogin = friend.mLastLogin.sec,
			PlayerLevel = friend.mPlayerLevel,
			Categories = {},
			HideGridItem = true,
			HideBookend = true,
			GlowOnFocus = true,
			AnimateIn = true,
			PlatformFamily = Engine.__wf_atom_940f8971(friend.mDisplayName)
		}

		if v2.LastLogin ~= nil and v2.LastLogin ~= "" then
			v2.LastLoginSeconds = Engine.__wf_atom_db2b0cee((tonumber(v2.LastLogin)))
		end

		if p3 ~= nil then
			v2.UniqueName = module4.GetCrossPlatformUniquePlayerName(friend.mDisplayName, p3, "mDisplayName")
		end

		return v2
	end

	function v.ViewWarframeProfile(p3, data)
		if not __wf_atom_7e8ad928(data) then
			_T.SelectedProfileName = data.User
			_T.SelectedProfileId = data.AccountId
			_T.SelectedProfileImage = data.AvatarImageType
			_T.OpenScreenAsync("Profile", p3.mMovie)
		end
	end

	function v.ViewConsoleProfile(_, p3)
		if Engine.__wf_atom_84bb79c2() then
			if not __wf_atom_7e8ad928(gGameData) then
				gGameData:__wf_atom_2af00357(p3, "ViewConsoleCallback")
			end
		else
			gMatchingService:__wf_atom_5d789280(p3)
		end
	end

	function v.Shutdown(_)
		_T.gToolTip = nil
	end

	function v.ResyncRichPresence(object)
		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		local v2 = {}
		object:RunForAllVisibleElements(function(p3)
			if p3 == nil or p3.AccountId == nil then
				return
			end

			local accountId = tostring(p3.AccountId)

			if Engine.__wf_atom_84bb79c2() and p3.PlatformFamily ~= nil then
				table.insert(v2, accountId .. "_" .. p3.PlatformFamily)
			else
				table.insert(v2, accountId)
			end
		end)
		gGameData:__wf_atom_c7c2a30f(v2, "OnRichPresenceUpdated")
	end

	function v:AddSortBy(p3)
		if self.mSortMenu then
			self.mSortMenu:AddElement(p3)
		end
	end

	function v.GetSortById(p3, _)
		if p3.mUserAssignedSortId then
			return p3.mUserAssignedSortId
		end

		local mSelectedElement = p3.mSortMenu and p3.mSortMenu.mSelectedElement

		if mSelectedElement then
			return mSelectedElement.SortId
		end

		return nil
	end

	function v:SetSortBy(p3, p4)
		if self.mSortMenu then
			local id = nil
			self.mSortMenu:RunForAllElements(function(data)
				if data.SortId == p3 or data.SortId == nil and data.Attribute == p3 then
					id = data.Id
				end
			end)

			if id then
				if self.mSortBy == nil then
					self.mSortMenu:Redraw(nil, true, true)
				end

				self.mSortMenu:SelectElementById(id, not p4)
			end
		end
	end

	function v:SetSortBy_Internal(p3, p4, p5)
		local attribute = p3.Attribute

		if self.mSortMenu ~= nil and self.mSortBy ~= attribute then
			local v2 = self.mSortBy == nil
			self.mSortingChanged = true
			self.mLastSortBy = self.mSortBy
			self.mSortBy = attribute

			if p5 then
				self.mUserAssignedSortId = p3.SortId
			end

			if not v2 then
				self:SetScroll(1, true)
				self:Redraw(p4, true, false)
			end
		end
	end

	local mMovie = v.mMovie
	local v2 = 22
	local v3 = (mMovie:__wf_atom_cfc41e35(v.mRootClip, "bg", 14) - v2 * 2 + 10) / 2 - 10
	local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
	local v4 = v2 + mMovie:__wf_atom_cfc41e35(v.mRootClip, "bg", 2)

	if v.mSortClipName then
		local module6 = require("SF.Interface.Components.DropDownMenu")
		v.mSortMenu = module6.Create(p, v.mSortClipName)
		v.mSortMenu:SetWidth(v3)
		v.mSortMenu:SetCallbacks("SortByPressed", "SortByFocused", "SortByUnfocused")
		v.mSortMenu.mDepthDirection = 1
		v.mSortMenu.mStartingDepth = tonumber(__wf_atom_86cbd68d(v.mMovie, v.mSortClipName .. ".getDepth"))

		function v.mSortMenu.mOnSelectedCallback(p3, p4)
			if v.mSortBy ~= p3.Attribute then
				v:SetSortBy_Internal(p3, nil, p4)

				if v.mSortMenu.mSelectedElement == nil then
					v.mSortMenu:UpdateSelectedText(p3)
				end
			end
		end

		function v.mSortMenu.mElementDrawCallback(data)
			local uiMaterial_DepthTestText = v.mMovie:__wf_atom_a224b472() and _G.UIMaterial_DepthTestText
				or _G.UIMaterial_PlainText
			v.mMovie:OverrideMaterial(data.mClipName .. ".Label", uiMaterial_DepthTestText)
			v.mMovie:__wf_atom_50d60589(data.mClipName .. ".Label", 36, data.Name)
			v.mMovie:__wf_atom_7f57ab2f(
				data.mClipName,
				"Check",
				13,
				v.mSortMenu.mSelectedElement ~= nil and v.mSortMenu.mSelectedElement.Id == data.Id
			)
		end

		function v.mSortMenu.OnExpandCallback(p3, p4)
			__wf_atom_86cbd68d(p3.mMovie, v.mSortClipName .. ".swapDepths", 5555)

			if p4 and Engine.__wf_atom_5df63302() then
				local rootBasedPosition, v5 = p3.UTIL.GetRootBasedPosition(v.mMovie, v.mSortClipName)
				v.mMovie:__wf_atom_2625efb4(rootBasedPosition + 19, v5 + 1)
			end
		end

		function v.mSortMenu.OnCollapseCallback(p3, _)
			__wf_atom_86cbd68d(p3.mMovie, v.mSortClipName .. ".swapDepths", p3.mStartingDepth)
		end

		local uiMaterial_DepthTestText = v.mMovie:__wf_atom_a224b472() and _G.UIMaterial_DepthTestText
			or _G.UIMaterial_PlainText
		v.mMovie:OverrideMaterial(v.mSortClipName .. ".Selected", uiMaterial_DepthTestText)
	end

	function v:Sort(p3, p4)
		if p3.Friend ~= nil and p4.Friend ~= nil and p3.Friend.mFavorite ~= p4.Friend.mFavorite then
			return p3.Friend.mFavorite
		end

		if Engine.__wf_atom_fc67ba71() then
			if p3.PlatformFamily == __wf_atom_63bb2bc6 and p4.PlatformFamily ~= __wf_atom_63bb2bc6 then
				return true
			end

			if p3.PlatformFamily ~= __wf_atom_63bb2bc6 and p4.PlatformFamily == __wf_atom_63bb2bc6 then
				return false
			end
		end

		return p3[self.mSortBy] ~= nil and p4[self.mSortBy] ~= nil and p3[self.mSortBy] < p4[self.mSortBy]
	end

	function v:DoubleSort(p3, p4)
		local v5

		if p3[self.mSortBy] == nil or p4[self.mSortBy] == nil then
			v5 = false
			return false
		end

		if p3[self.mSortBy] == p4[self.mSortBy] and p3[self.mLastSortBy] ~= nil and p4[self.mLastSortBy] ~= nil then
			return p3[self.mLastSortBy] < p4[self.mLastSortBy]
		end

		return p3[self.mSortBy] < p4[self.mSortBy]
	end

	function v:DoubleSortWithFunction(p3, p4)
		if p3[self.mSortBy] == p4[self.mSortBy] then
			return (self.mLastSortBy(p3, p4))
		end

		return p3[self.mSortBy] < p4[self.mSortBy]
	end

	if v.mSortMenu ~= nil then
		mMovie:__wf_atom_e57658c2(v.mSortClipName, 0, v4 + v3 + 10)
		v.mSortMenu.mMainButton.SortButtonPressed = v.mSortMenu.mMainButton.Pressed

		function v.mSortMenu.mMainButton:Pressed(p3, p4)
			self:SortButtonPressed(p3, p4)

			if not __wf_atom_7e8ad928(v.mContextMenu) then
				local v5 = __wf_atom_7e8ad928(v.mContextMenu:GetFocusedElement())

				if v.mMovie:__wf_atom_a91463a8(v.mContextMenuClipName, 67) and v5 then
					v.mContextMenu:Hide()
				end
			end
		end

		v:AddSortBy({
			Name = TitleCase(mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false)),
			SortId = "NAME",
			Attribute = "UserLower"
		})

		if mMovie:Execute("IsAllianceUserList", "") then
			v:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ClanTier", false),
				SortId = "TIER",
				Attribute = "Tier"
			})
			v:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Members", false),
				SortId = "MEMBERS",
				Attribute = "MemberCount"
			})
		else
			v:AddSortBy({
				Name = TitleCase(mMovie:__wf_atom_8e9ac384("/SortingLabels/LastLoggedOn", false)),
				SortId = "LAST_LOGGED_ON",
				Attribute = "LastLoginSeconds"
			})
			v:AddSortBy({
				Name = TitleCase(mMovie:__wf_atom_8e9ac384("/SortingLabels/RecentLogon", false)),
				SortId = "MOST_RECENT_LOGON",
				Attribute = function(p3, p4)
					if p3 == nil or p3.LastLoginSeconds == nil then
						return false
					end

					return p4 == nil or p4.LastLoginSeconds == nil or p3.LastLoginSeconds > p4.LastLoginSeconds
				end
			})
		end

		local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
		local v5 = __wf_atom_7e8ad928(gGameData) and "" or gGameData:__wf_atom_6340bbd5(__wf_atom_6d61d595)
		v:SetSortBy(v5 == "" and "NAME" or v5)
	end

	if mMovie:__wf_atom_253d7085(p2) then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InputPromptSearch", false)
		local module6 = require("SF.Interface.Components.InputField")
		local mSearchBox = module6.Create(p, p2, { mCallout = "<MENU_LTHUMB>" })
		mSearchBox:SetWidth(v3)
		mSearchBox:SetPosition(v4)
		mSearchBox:SetType(mSearchBox.TYPE.SEARCH, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
		mSearchBox.mToolTip = v.mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InvitePanelSearchTooltip", false)
		mSearchBox:SetHint("/SF/Language/Menu/InputPromptSearch")
		mSearchBox:Redraw()
		v.mSearchBox = mSearchBox

		function v.AdditionalFilterFunction(p3)
			local user = p3.User

			if user == nil then
				return false
			end

			local ternary = module.Ternary(v.mApplyThemes, mSearchBox.mLabel, mSearchBox.mSearchTerm)

			if ternary == nil or ternary == "" then
				return true
			end

			return string.find(__wf_atom_d99ae0ec(user), __wf_atom_d99ae0ec(ternary), 1, true) ~= nil
		end
	end

	if v.mContextMenuClipName then
		local module6 = require("EE.Interface.Components.List")
		v.mContextMenu = module6.CreateList(v.mMovie, v.mContextMenuClipName .. ".Btn1")
		v.mContextMenu:SetCallbacks("ContextItemPressed", "ContextItemFocused", "ContextItemUnfocused")
		v.mContextMenu.mLongestElement = 0
		v.mContextMenu.mForcedVerticalSeparation = 32
		v.mContextMenu.mWrapAroundNavigation = false
		v.mContextMenu.mVisibleElements = 8
		v.mContextMenu.mVisible = false

		function v.mContextMenu:Hide()
			v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 67, false)
			v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 13, false)
			v.mMovie:__wf_atom_976dcedd(v.mRootClip, "noMenuSelection", false)
			local focusedElement = v:GetFocusedElement()

			if __wf_atom_7e8ad928(v.mStoredFocusId) and not __wf_atom_7e8ad928(focusedElement) then
				v:UnfocusElementById(focusedElement.Id)
			elseif
				not __wf_atom_7e8ad928(v.mStoredFocusId)
				and (__wf_atom_7e8ad928(focusedElement) or v.mStoredFocusId ~= focusedElement.Id)
			then
				v:FocusElementById(v.mStoredFocusId)
			end

			self.mVisible = false
		end

		function v.mContextMenu:Show(p3, p4, p5)
			if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p4) then
				p3 = v.mMovie:__wf_atom_5e6e15c8("_root", 30) + 10
				p4 = v.mMovie:__wf_atom_5e6e15c8("_root", 31) + 8
			end

			_T.gToolTip = nil
			v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 67, true)
			v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 13, true)
			v.mMovie:__wf_atom_976dcedd(v.mRootClip, "noMenuSelection", true)
			self.mLongestElement = 0
			self:Redraw(nil, true)
			local v5 = { x = p3, y = p4 }

			for i = 1, self:GetHowManyElements() do
				local elementInIndex = self:GetElementInIndex(i)

				if __wf_atom_7e8ad928(elementInIndex) then
					continue
				end

				if v.mApplyThemes and not __wf_atom_7e8ad928(elementInIndex.Button) then
					elementInIndex.Button:SetWidth(self.mLongestElement + 20)
				else
					v.mMovie:__wf_atom_4c1c1986(elementInIndex.mClipName, "Btn", 14, self.mLongestElement + 10)
					v.mMovie:__wf_atom_4c1c1986(elementInIndex.mClipName, "Bg", 14, self.mLongestElement + 15)
				end
			end

			if not p5 then
				local _, v6 = module.GetScreenDimensions(v.mMovie)
				local v7 = v5.y + self:GetHowManyElements() * self.mForcedVerticalSeparation + 18

				if v6 < v7 then
					local v8 = v6 - v7
					v5.y += v8
				end

				v.mMovie:__wf_atom_e57658c2(v.mContextMenuClipName, 0, module.Round(v5.x))
				v.mMovie:__wf_atom_e57658c2(v.mContextMenuClipName, 1, module.Round(v5.y))
			end

			v.mMovie:__wf_atom_4c1c1986(
				v.mContextMenuClipName,
				"Frame",
				14,
				self.mLongestElement + module.Ternary(v.mApplyThemes, 40, 35)
			)
			v.mMovie:__wf_atom_4c1c1986(
				v.mContextMenuClipName,
				"Frame",
				15,
				self:GetHowManyElements() * self.mForcedVerticalSeparation + module.Ternary(v.mApplyThemes, 22, 18)
			)
			self.mVisible = true
		end

		function v.mContextMenu:SetElementColor(p3, p4)
			if v.mApplyThemes then
				return
			end

			local uiColor_White = _G.UIColor_White
			local uiColor_Black = _G.UIColor_Black
			local focusedElement = v.mContextMenu:GetFocusedElement()

			if not p4 and not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == p3.Id then
				uiColor_White = _G.UIColor_Yellow
				uiColor_Black = _G.UIColor_Black
			end

			v.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Bg", 11, uiColor_White)
			v.mMovie:__wf_atom_4c1c1986(p3.mClipName, "Label", 11, uiColor_Black)
		end

		function v.mContextMenu.mOnFocusedCallback(p3)
			v.mContextMenu:SetElementColor(p3, false)
		end

		function v.mContextMenu.mOnUnfocusedCallback(p3)
			v.mContextMenu:SetElementColor(p3, true)
		end

		function v.mContextMenu.mOnSelectedCallback(p3)
			if __wf_atom_7e8ad928(p3) or __wf_atom_7e8ad928(p3.PressedCallback) then
				return
			end

			local pressedCallback = p3.PressedCallback()

			if __wf_atom_7e8ad928(pressedCallback) or pressedCallback then
				v.mContextMenu:Hide()
			end
		end

		function v.mContextMenu:mElementDrawCallback()
			if __wf_atom_7e8ad928(self) then
				return
			end

			if v.mApplyThemes then
				local module7 = require("Lotus.Interface.Components.ThemedButton")
				self.Button = module7.Create(v.mMovie, self.mClipName, self.Name, nil, nil, nil, nil, v:GetParentEnv())
				self.Button:SetId(self.Id)
				self.Button.mMinSize = 200
				self.Button.mAlignment = "left"
				self.Button.mTextBuffer = 10
				self.Button.mOnFocusedCallback = v.mContextMenu.mOnFocusedCallback
				self.Button.mOnUnfocusedCallback = v.mContextMenu.mOnUnfocusedCallback
				self.Button.mOnPressedCallback = v.mContextMenu.mOnSelectedCallback
				self.Button.PressedCallback = self.PressedCallback
				self.Button:Redraw()
			else
				v.mContextMenu:SetElementColor(self, false)
				v.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Label.text", self.Name)
			end

			local __wf_atom_cfc41e35 = v.mMovie:__wf_atom_cfc41e35(self.mClipName, "Label", 40)
			v.mContextMenu.mLongestElement = math.max(v.mContextMenu.mLongestElement, __wf_atom_cfc41e35)
		end

		v.mMovie:__wf_atom_4c1c1986(v.mContextMenuClipName, "Frame", 12, 50)
		v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 67, false)
		v.mMovie:__wf_atom_2dedec1a(v.mContextMenuClipName, 13, false)
	end

	v:Redraw(nil, true)
	return v
end