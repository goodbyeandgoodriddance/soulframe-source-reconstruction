module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.LotusNetworkUtilities")
local module4 = require("Lotus.Interface.CrossPlatformUtilities")

function Create(p, p2, p3, p4, mContextMenuClipName, p5, p6, p7, data)
	local module5 = require("Lotus.Interface.Components.CategorizedGrid")
	local categorizedGrid = module5.CreateCategorizedGrid(
		p,
		p2,
		1,
		p6,
		p3,
		p4,
		p5,
		nil,
		nil,
		Engine.__wf_atom_2a979d69()
	)
	categorizedGrid.mPrefix = "UserList(" .. p2 .. ")::"
	categorizedGrid.mAddFillerElements = false
	categorizedGrid.mSelectedScale = 100
	categorizedGrid.mSortMenuHorizontalOffset = nil
	categorizedGrid.mSortMenuVerticalOffset = nil
	categorizedGrid.mContextMenuClipName = mContextMenuClipName
	categorizedGrid.mRowSeparation = 33
	categorizedGrid.mShowMasteryRank = true
	categorizedGrid.mShowClanRank = true
	categorizedGrid.mUserCount = {}
	categorizedGrid.mStoredFocusId = nil
	categorizedGrid.ONLINE = 1
	categorizedGrid.OFFLINE = 2
	categorizedGrid.PENDING = 3
	categorizedGrid.STEAM = 4
	categorizedGrid.mIsFocused = false
	categorizedGrid.mStarChart = module2.GetStarChart()
	categorizedGrid.mHookedUpCallbacks = false
	categorizedGrid.mPendingIncCount = 0
	categorizedGrid.mDoProfanityFilter = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings():__wf_atom_bb0f4637()
	categorizedGrid.mIsUGCRestricted = module.IsUGCRestricted()
	categorizedGrid.mSwapDepth = true
	local uiColorObject_White = _G.UIColorObject_White
	local uiColorObject_White2 = _G.UIColorObject_White

	if categorizedGrid.mApplyThemes and not __wf_atom_7e8ad928(data) then
		if not __wf_atom_7e8ad928(data.FloatingContentObject) then
			uiColorObject_White = data.FloatingContentObject
		end

		if not __wf_atom_7e8ad928(data.Background1Object) then
			uiColorObject_White2 = data.Background1Object
		end
	end

	categorizedGrid.mMovie:OverrideMaterial(categorizedGrid.mRootClip .. ".ListBg", _G.UIMaterial_RectangleNoDepth)
	categorizedGrid.mMovie:__wf_atom_1ca72041(
		categorizedGrid.mRootClip .. ".ListBg",
		"RectEdgeColor",
		uiColorObject_White.r,
		uiColorObject_White.g,
		uiColorObject_White.b,
		0.3
	)
	categorizedGrid.mMovie:__wf_atom_1ca72041(
		categorizedGrid.mRootClip .. ".ListBg",
		"RectInnerColor",
		uiColorObject_White2.r,
		uiColorObject_White2.g,
		uiColorObject_White2.b,
		0.4
	)

	function categorizedGrid:GetParentEnv()
		if self.mParentEnv ~= nil then
			return self.mParentEnv
		end

		local v = 1
		local mParentEnv

		repeat
			mParentEnv = getfenv(v)
			v += 1
		until mParentEnv.mMovie

		self.mParentEnv = mParentEnv
		return mParentEnv
	end

	function categorizedGrid.HideMenus(p8)
		if not __wf_atom_7e8ad928(p8.mContextMenu) and p8.mContextMenu.mVisible then
			p8.mContextMenu:Hide()
			return true
		end

		if __wf_atom_7e8ad928(p8.mSortMenu) or not p8.mSortMenu:IsExpanded() then
			return
		end

		p8.mSortMenu.mMainButton:Pressed(true, true)
		return true
	end

	function categorizedGrid.GetPlanetAndNodeFromNodeName(data2, p8)
		local v = ""
		local v2 = -1
		local v3 = {}

		if __wf_atom_7e8ad928(data2.mStarChart) then
			return v, v2, v3
		end

		local __wf_atom_d5226f21 = data2.mStarChart:__wf_atom_d5226f21(p8)

		if not __wf_atom_d5226f21 then
			__wf_atom_d5226f21 = {}
			return v, v2, __wf_atom_d5226f21
		end

		local mRegion = data2.mRegions[__wf_atom_d5226f21.region + 1]
		v2 = __wf_atom_d5226f21.region + 1

		if mRegion == nil then
			return v, v2, __wf_atom_d5226f21
		end

		return string.upper(data2.mMovie:__wf_atom_8e9ac384(tostring(mRegion.name), false)), v2, __wf_atom_d5226f21
	end

	function categorizedGrid:GetPlanetAndNodeFromModeId(p8)
		local v = nil
		local v2 = nil
		local v3 = ""
		local v4

		if p8 == 0 or __wf_atom_7e8ad928(self.mStarChart) then
			v4 = ""
			return v, v2, v4
		end

		local v5 = nil
		local displayedNodeName = module2.GetDisplayedNodeNameFromGameModeId(p8)
		v4 = module2.GetNodeModifierTagFromGameModeId(p8)

		if displayedNodeName then
			v2 = self.mStarChart:__wf_atom_d5226f21(Symbol(displayedNodeName))

			if
				v2
				and v2.name ~= EMPTY_SYMBOL
				and v2.region ~= module2.REGION_ID_PVP
				and v2.region ~= module2.REGION_ID_CLAN_DOJO
			then
				v5 = self.mRegions[v2.region + 1]

				if v2.mission.missionType == 32 then
					v3 = "_SPACE"
				end
			end
		end

		if v5 == nil then
			local region = module2.GetRegionFromGameModeId(p8)

			if region then
				v5 = self.mRegions[region]
			end
		end

		if v5 == nil then
			return v, v2, v4
		end

		if module2.IsDuviriNode(displayedNodeName) then
			return string.upper(Localize("/Lotus/Language/Duviri/Duviri", {})), v2, v4
		end

		v = string.upper(self.mMovie:__wf_atom_8e9ac384(tostring(v5.name) .. v3, false))
		return v, v2, v4
	end

	function categorizedGrid:GetSessionPlayers(list, list2)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local v = MongoId(__wf_atom_18a5d83b:__wf_atom_e75653c3())
		local v2 = {}

		for i = 1, #list2 do
			local v3 = list2[i]

			if not ((v3.mPresence.state == 3 or v3.mPresence.state == 4) and v3.mPresence.session.id ~= "" and v3.mId ~= v) then
				continue
			end

			if module3.CheckJoinSessionPermission(v3.mPresence) ~= nil then
				continue
			end

			if v2[v3.mPresence.session.id] == nil or list[v2[v3.mPresence.session.id]] == nil then
				local gameModeId = v3.mPresence.session.gameModeId
				local planetAndNodeFromModeId, node, modifierTag = self:GetPlanetAndNodeFromModeId(gameModeId)

				if planetAndNodeFromModeId ~= nil and node ~= nil then
					table.insert(list, {
						Friend = { v3 },
						Planet = planetAndNodeFromModeId,
						Node = node,
						ModifierTag = modifierTag,
						GameModeId = gameModeId
					})
					v2[v3.mPresence.session.id] = #list
				end
			else
				table.insert(list[v2[v3.mPresence.session.id]].Friend, v3)
			end
		end

		module.ShuffleTable(list)
	end

	categorizedGrid._UserList_Redraw = categorizedGrid.Redraw

	function categorizedGrid:Redraw(p8, p9, p10)
		self.mDrawnElements = 0

		if self.mSwapDepth then
			local focusedElement = self:GetFocusedElement()

			if
				not __wf_atom_7e8ad928(focusedElement)
				and focusedElement.mClipName ~= nil
				and focusedElement.mOrigDepth ~= nil
			then
				__wf_atom_86cbd68d(self.mMovie, focusedElement.mClipName .. ".swapDepths", focusedElement.mOrigDepth)
				focusedElement.mOrigDepth = nil
			end
		end

		self:_UserList_Redraw(p8, p9, p10)

		if self.mSwapDepth then
			local focusedElement = self:GetFocusedElement()

			if
				not __wf_atom_7e8ad928(focusedElement)
				and focusedElement.mClipName ~= nil
				and focusedElement.mOrigDepth == nil
			then
				focusedElement.mOrigDepth = tonumber(__wf_atom_86cbd68d(
					self.mMovie,
					focusedElement.mClipName .. ".getDepth"
				))
				__wf_atom_86cbd68d(
					self.mMovie,
					focusedElement.mClipName .. ".swapDepths",
					self.mInitialDepth + (self.mTopClipIndexUsed + 1) * self.mDepthDirection
				)
			end
		end

		if self.mCategoryMenu ~= nil then
			self.mCategoryMenu:RefreshCategoryCounts()
		end
	end

	function categorizedGrid.SetupPreInterpolationValues(_, _) end

	categorizedGrid.GetInterpolationProperties = categorizedGrid.DefaultAlphaInterpolation
	categorizedGrid._UserList_OnFocused = categorizedGrid.OnFocused

	function categorizedGrid:OnFocused(state)
		if state.mClipName == nil then
			return
		end

		self:_UserList_OnFocused(state)

		if state.Friend and not self.mIsUGCRestricted then
			if state.Friend.mNote == "" then
				_T.gToolTip = nil
			else
				if self.ClearTooltipTimerId ~= nil then
					self.mTimerMgr:RemoveTimer(self.ClearTooltipTimerId)
					self.ClearTooltipTimerId = nil
				end

				if categorizedGrid.mDoProfanityFilter then
					_T.gToolTip = __wf_atom_f8f86fc5(state.Friend.mNote, 0)
				else
					_T.gToolTip = state.Friend.mNote
				end

				local rootBasedPosition, v = module.GetRootBasedPosition(self.mMovie, state.mClipName .. ".Note")

				if rootBasedPosition ~= 0 and v ~= 0 then
					local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(state.mClipName .. ".Note", 15)
					local v2 = rootBasedPosition + __wf_atom_5e6e15c8 / 2 + 5
					local v3 = v - __wf_atom_5e6e15c8 / 2 + 1
					local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(self.mMovie, {
						x = v2,
						y = v3
					})
					_T.gToolTipCoords = {
						x = transformPixelToViewportCoordinates.x,
						y = transformPixelToViewportCoordinates.y
					}
				end
			end
		end

		if self.mSwapDepth and state.mOrigDepth == nil then
			state.mOrigDepth = tonumber(__wf_atom_86cbd68d(self.mMovie, state.mClipName .. ".getDepth"))
			__wf_atom_86cbd68d(
				self.mMovie,
				state.mClipName .. ".swapDepths",
				self.mInitialDepth + (self.mTopClipIndexUsed + 1) * self.mDepthDirection
			)
		end

		local uiColor_Yellow = _G.UIColor_Yellow

		if self.mApplyThemes and not __wf_atom_7e8ad928(data) then
			uiColor_Yellow = data.FloatingContentHighlight
			local floatingContentHighlightObject = data.FloatingContentHighlightObject
			local background1Object = data.Background1Object
			self.mMovie:__wf_atom_1ca72041(
				state.mClipName .. ".Bg",
				"RectEdgeColor",
				floatingContentHighlightObject.r,
				floatingContentHighlightObject.g,
				floatingContentHighlightObject.b,
				0.9
			)
			self.mMovie:__wf_atom_1ca72041(
				state.mClipName .. ".Bg",
				"RectInnerColor",
				background1Object.r,
				background1Object.g,
				background1Object.b,
				1
			)
			self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Highlight", 13, true)
			__wf_atom_ec43d06e(self.mMovie, state.mClipName .. ".Highlight", 8, { 15 }, { 25 }, 0.25)
		end

		if state.PlayerName ~= nil then
			local v = "<p><font color=\"" .. module.ConvertColorNumberToHex(uiColor_Yellow) .. "\">" .. state.PlayerName .. "</font></p>"
			self.mMovie:__wf_atom_50d60589(state.mClipName .. ".Name", 36, v)
		end

		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Name", 44, uiColor_Yellow)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Rank", 44, uiColor_Yellow)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "LastOnline", 44, uiColor_Yellow)
	end

	categorizedGrid._UserList_OnUnfocused = categorizedGrid.OnUnfocused

	function categorizedGrid:OnUnfocused(state)
		if state.mClipName == nil then
			return
		end

		self:_UserList_OnUnfocused(state)

		if state.Friend and not self.mIsUGCRestricted then
			if __wf_atom_7e8ad928(self.mTimerMgr) or self.ClearTooltipTimerId ~= nil then
				_T.gToolTip = nil
			else
				self.ClearTooltipTimerId = self.mTimerMgr:AddTimer(0.1, function()
					_T.gToolTip = nil
				end)
			end
		end

		if self.mSwapDepth and state.mOrigDepth ~= nil then
			__wf_atom_86cbd68d(self.mMovie, state.mClipName .. ".swapDepths", state.mOrigDepth)
			state.mOrigDepth = nil
		end

		local uiColor_White = _G.UIColor_White

		if self.mApplyThemes and not __wf_atom_7e8ad928(data) then
			uiColor_White = data.FloatingContent
			local floatingContentHighlightObject = data.FloatingContentHighlightObject
			local floatingContentObject = data.FloatingContentObject
			local ternary = module.Ternary(state.mDrawnIndex % 2 ~= 0, 0.1, 0)
			self.mMovie:OverrideMaterial(state.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			self.mMovie:__wf_atom_1ca72041(
				state.mClipName .. ".Bg",
				"RectEdgeColor",
				floatingContentHighlightObject.r,
				floatingContentHighlightObject.g,
				floatingContentHighlightObject.b,
				0
			)
			self.mMovie:__wf_atom_1ca72041(
				state.mClipName .. ".Bg",
				"RectInnerColor",
				floatingContentObject.r,
				floatingContentObject.g,
				floatingContentObject.b,
				ternary
			)
			__wf_atom_ec43d06e(self.mMovie, state.mClipName .. ".Highlight", 8, { 15 }, { 1 }, 0.25, 0, function()
				self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Highlight", 13, false)
			end)
		end

		if state.PlayerName ~= nil then
			local v = "<p><font color=\"" .. module.ConvertColorNumberToHex(uiColor_White) .. "\">" .. state.PlayerName .. "</font></p>"
			self.mMovie:__wf_atom_50d60589(state.mClipName .. ".Name", 36, v)
		end

		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Name", 44, uiColor_White)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Rank", 44, uiColor_White)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "LastOnline", 44, uiColor_White)
	end

	categorizedGrid._UserList_OnDraw = categorizedGrid.OnDraw

	function categorizedGrid:OnDraw(state, p8)
		if state.mClipName == nil then
			return
		end

		self:_UserList_OnDraw(state, p8)
		self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Name", 13, not state.Filler)
		self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Rank", 13, not state.Filler)
		self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Icon", 13, not state.Filler)

		if state.Filler then
			return
		end

		local v = not __wf_atom_7e8ad928(self:GetFocusedElement()) and state.Id == self:GetFocusedElement().Id
		local ternary = module.Ternary(v, _G.UIColor_Yellow, _G.UIColor_White)
		self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Highlight", 13, self.mApplyThemes and v)

		if self.mApplyThemes and not __wf_atom_7e8ad928(data) then
			ternary = module.Ternary(v, data.FloatingContentHighlight, data.FloatingContent)
			self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Highlight", 11, data.FloatingContentHighlight)
			self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Highlight", 12, 20)
			self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Highlight", 15, module.Ternary(v, 25, 1))
			local floatingContentHighlightObject = data.FloatingContentHighlightObject
			local ternary2 = module.Ternary(v, 0.9, 0)
			local ternary3 = module.Ternary(v, data.Background1Object, data.FloatingContentObject)
			local ternary4 = module.Ternary(state.mDrawnIndex % 2 ~= 0, 0.1, 0)
			local v2 = v and 1 or ternary4
			self.mMovie:OverrideMaterial(state.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)

			if not __wf_atom_7e8ad928(floatingContentHighlightObject) then
				self.mMovie:__wf_atom_1ca72041(
					state.mClipName .. ".Bg",
					"RectEdgeColor",
					floatingContentHighlightObject.r,
					floatingContentHighlightObject.g,
					floatingContentHighlightObject.b,
					ternary2
				)
			end

			if not __wf_atom_7e8ad928(ternary3) then
				self.mMovie:__wf_atom_1ca72041(
					state.mClipName .. ".Bg",
					"RectInnerColor",
					ternary3.r,
					ternary3.g,
					ternary3.b,
					v2
				)
			end
		else
			self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Bg", 13, state.mDrawnIndex % 2 ~= 0)
		end

		local user = state.User

		if state.UniqueName ~= nil then
			user = state.UniqueName
		end

		if not __wf_atom_7e8ad928(state.Friend) and state.Friend.mFavorite then
			user = "<font color=\"" .. module.ConvertColorNumberToHex(data.FloatingContentHighlight) .. "\">" .. self.mMovie:__wf_atom_8e9ac384("<STAR>", true) .. "</font>" .. user
		end

		if self.mShowMasteryRank then
			user ..= " " .. self.mMovie:__wf_atom_8e9ac384("<RANK_" .. tostring(state.PlayerLevel) .. ">", true) .. module2.ProcessPlayerLevel(state.PlayerLevel)
		end

		state.PlayerName = user

		if not __wf_atom_7e8ad928(data) then
			user = "<p><font color=\"" .. module.ConvertColorNumberToHex(ternary) .. "\">" .. state.PlayerName .. "</font></p>"
		end

		if Engine.__wf_atom_578fc9dd() then
			self.mMovie:__wf_atom_48bd5a59(state.mClipName, "Name", 49, "Arial Unicode MS")
		end

		self.mMovie:__wf_atom_2dedec1a(state.mClipName .. ".Name", 54, true)
		self.mMovie:__wf_atom_50d60589(state.mClipName .. ".Name", 36, user)
		local rankString = ""

		if self.mShowClanRank then
			rankString = state.RankString
		elseif state.Categories[1] ~= self.PENDING and state.Categories[1] ~= self.OFFLINE then
			if state.State == 3 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_PreGameLobby", false)
			elseif state.State == 4 then
				local gameModeId = state.Friend.mPresence.session.gameModeId
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
			elseif state.State == 0 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_Offline", false)
			elseif state.State == 1 then
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_Online", false)
			else
				rankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Game/Presence_InMenus", false)
			end
		end

		self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Rank", 54, true)
		self.mMovie:__wf_atom_48bd5a59(state.mClipName, "Rank", 46, "center")
		self.mMovie:__wf_atom_50d60589(state.mClipName .. ".Rank", 36, rankString)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Rank", 44, ternary)
		module.SetFitText(self.mMovie, state.mClipName .. ".LastOnline", "...")
		self.mMovie:__wf_atom_50d60589(state.mClipName .. ".LastOnline", 36, state.LastLoginStr)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "LastOnline", 44, ternary)
		self.mMovie:__wf_atom_4c1c1986(state.mClipName, "Note", 11, ternary)

		if state.Friend then
			self.mMovie:__wf_atom_7f57ab2f(
				state.mClipName,
				"Note",
				13,
				not self.mIsUGCRestricted and state.Friend.mNote ~= ""
			)
		end

		local uiTexture_ProfilePlaceHolder = _G.UITexture_ProfilePlaceHolder
		self.mMovie:__wf_atom_c90af43a(state.mClipName .. ".Icon", uiTexture_ProfilePlaceHolder)
	end

	function categorizedGrid:OnElementTransitionStarted(p8)
		self.mDrawnElements += 1
		p8.mDrawnIndex = self.mDrawnElements
		self.mMovie:__wf_atom_2dedec1a(p8.mClipName, 67, false)
	end

	function categorizedGrid:GetUsers()
		print("Error: This function needs to be overloaded to get the users you wanna show (friends, clan, etc).")
		assert(false)
		return {}
	end

	function categorizedGrid:BuildUser(data2, id, p8)
		local v = {
			Id = id,
			Friend = data2,
			User = data2.mDisplayName,
			UserLower = string.lower(data2.mDisplayName),
			AccountId = data2.mId,
			State = data2.mPresence.state,
			Status = data2.mStatus,
			AvatarImageType = data2.mActiveAvatarImageType,
			LastLogin = data2.mLastLogin.sec,
			PlayerLevel = data2.mPlayerLevel,
			Categories = {},
			PlatformFamily = Engine.__wf_atom_940f8971(data2.mDisplayName)
		}

		if p8 ~= nil then
			v.UniqueName = module4.GetCrossPlatformUniquePlayerName(data2.mDisplayName, p8, "mDisplayName")
		end

		if not self.mShowClanRank or __wf_atom_7e8ad928(gGameData) then
			return v
		end

		local __wf_atom_47806362 = gGameData:__wf_atom_47806362()
		local v2 = {}

		for i, v3 in ipairs(__wf_atom_47806362) do
			local mName = v3.mName
			v2[i] = self.mMovie:__wf_atom_8e9ac384(mName, false)

			if v2[i] == mName then
				v2[i] = v3.mName
			end
		end

		if data2.mRank == nil then
			v.Rank = -1
		else
			v.Rank = data2.mRank
		end

		if data2.mStatus == 0 or data2.mNote == "" then
			v.RankString = v2[v.Rank + 1]
		else
			v.RankString = self.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Rank_Applicant", false)
			return v
		end

		return v
	end

	function categorizedGrid:Populate()
		local users = self:GetUsers()
		self.mUserCount[self.ONLINE] = 0
		self.mUserCount[self.PENDING] = 0
		self.mUserCount[self.OFFLINE] = 0
		self.mUserCount[self.STEAM] = 0
		self.mPendingIncCount = 0
		local count = 0

		for i = 1, #users do
			__wf_atom_83c14687(0)
			count += 1
			local user = self:BuildUser(users[i], count, users)
			local online = self.ONLINE
			user.LastLoginSeconds = 0
			user.LastLoginStr = ""

			if user.Status == 9 then
				online = self.STEAM
			elseif user.Status == 0 then
				if user.State == 0 then
					online = self.OFFLINE

					if user.LastLogin ~= nil and user.LastLogin ~= "" then
						user.LastLoginSeconds = Engine.__wf_atom_db2b0cee((tonumber(user.LastLogin)))
					end

					if user.LastLoginSeconds ~= 0 then
						user.LastLoginStr = module2.GetTwitterStyleTime(-1 * user.LastLoginSeconds, false)
					end
				end
			else
				online = self.PENDING
				self.mPendingIncCount += module.Ternary(user.Status == 1, 1, 0)
			end

			if not (user.Status ~= 9 or user.State ~= 0) then
				continue
			end

			self.mUserCount[online] = self.mUserCount[online] + 1
			table.insert(user.Categories, online)
			self:AddElement(user, true)
		end
	end

	function categorizedGrid.ViewWarframeProfile(p8, data2)
		if not __wf_atom_7e8ad928(data2) then
			_T.SelectedProfileName = data2.User
			local _t = _T
			local selectedProfileId

			if data2.mCachedId then
				selectedProfileId = data2.mCachedId
			else
				selectedProfileId = data2.AccountId
			end

			_t.SelectedProfileId = selectedProfileId
			_T.SelectedProfileImage = data2.AvatarImageType
			_T.OpenScreenAsync("Profile", p8.mMovie)
		end
	end

	function categorizedGrid:HookUpCallbacks()
		assert(not self.mHookedUpCallbacks)
		self.mHookedUpCallbacks = true
		local parentEnv = self:GetParentEnv()

		function parentEnv.ViewConsoleCallback(p8, p9)
			if not p8 then
				return
			end

			gMatchingService:__wf_atom_5d789280(p9)
		end
	end

	function categorizedGrid.ViewConsoleProfile(_, p8)
		if Engine.__wf_atom_84bb79c2() then
			if not __wf_atom_7e8ad928(gGameData) then
				gGameData:__wf_atom_2af00357(p8, "ViewConsoleCallback")
			end
		else
			gMatchingService:__wf_atom_5d789280(p8)
		end
	end

	function categorizedGrid.Shutdown(object)
		_T.gToolTip = nil
		local sortById = object:GetSortById()

		if not (__wf_atom_7e8ad928(sortById) or __wf_atom_7e8ad928(gGameData)) then
			local __wf_atom_6d61d595 = object.mMovie:__wf_atom_6d61d595()
			gGameData:__wf_atom_00283c1e(__wf_atom_6d61d595, sortById)
		end
	end

	categorizedGrid._UserList_ScrollValueChangedCallback = categorizedGrid.ScrollValueChangedCallback

	function categorizedGrid:ScrollValueChangedCallback(p8, p9)
		self._UserList_ScrollValueChangedCallback(self, p8, p9)
		self.mDrawnElements = 0
		self:RunForAllVisibleElements(function(state)
			self.mDrawnElements += 1
			state.mDrawnIndex = self.mDrawnElements

			if not self.mApplyThemes or __wf_atom_7e8ad928(data) then
				self.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Bg", 13, state.mDrawnIndex % 2 ~= 0)
				return
			end

			local floatingContentObject = data.FloatingContentObject
			local ternary = module.Ternary(state.mDrawnIndex % 2 ~= 0, 0.1, 0)
			self.mMovie:__wf_atom_1ca72041(
				state.mClipName .. ".Bg",
				"RectInnerColor",
				floatingContentObject.r,
				floatingContentObject.g,
				floatingContentObject.b,
				ternary
			)
		end)
	end

	categorizedGrid._NextCategory = categorizedGrid.NextCategory

	function categorizedGrid.NextCategory(p8)
		if not __wf_atom_7e8ad928(p8.mContextMenu) and p8.mContextMenu.mVisible then
			p8.mContextMenu:Hide()
		end

		categorizedGrid:_NextCategory()
	end

	categorizedGrid._PreviousCategory = categorizedGrid.PreviousCategory

	function categorizedGrid.PreviousCategory(p8)
		if not __wf_atom_7e8ad928(p8.mContextMenu) and p8.mContextMenu.mVisible then
			p8.mContextMenu:Hide()
		end

		categorizedGrid:_PreviousCategory()
	end

	function categorizedGrid.ResyncRichPresence(object)
		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		local v = {}
		object:RunForAllVisibleElements(function(p8)
			if p8 == nil or p8.AccountId == nil then
				return
			end

			local accountId = tostring(p8.AccountId)

			if Engine.__wf_atom_84bb79c2() and p8.PlatformFamily ~= nil then
				table.insert(v, accountId .. "_" .. p8.PlatformFamily)
			else
				table.insert(v, accountId)
			end
		end)
		gGameData:__wf_atom_c7c2a30f(v, "OnRichPresenceUpdated")
	end

	if categorizedGrid.mCategoryMenu ~= nil then
		categorizedGrid.mCategoryMenu.UserList = categorizedGrid

		if categorizedGrid.mApplyThemes then
			categorizedGrid.mCategoryMenu.mAlign = module.LEFT_ALIGNED
			categorizedGrid.mCategoryMenu._UserList_SetCategoryLabel = categorizedGrid.mCategoryMenu.SetCategoryLabel

			function categorizedGrid.mCategoryMenu:SetCategoryLabel(p8, p9)
				local v = categorizedGrid.mUserCount[p9.Category] == nil and 0
					or categorizedGrid.mUserCount[p9.Category]
				self:_UserList_SetCategoryLabel(module.FormatNumber(v) .. " " .. p8)
			end
		end

		function categorizedGrid.mCategoryMenu:UpdateCount(p8)
			if p8 == nil or p8.mClipName == nil then
				return
			end

			if self.mApplyThemes then
				local v = p8.Category == categorizedGrid.PENDING and categorizedGrid.mPendingIncCount > 0
				self.mMovie:__wf_atom_7f57ab2f(p8.mClipName, "UpperIcon", 13, v)
			else
				local v = categorizedGrid.mUserCount[p8.Category] == nil and 0
					or categorizedGrid.mUserCount[p8.Category]
				self.mMovie:__wf_atom_48bd5a59(p8.mClipName, "Counter", 36, (tostring(v)))
				local __wf_atom_5e6e15c8 = self.mMovie:__wf_atom_5e6e15c8(p8.mClipName .. ".Counter", 40)
				local uiColor_Black = _G.UIColor_Black

				if p8.Category == categorizedGrid.PENDING and categorizedGrid.mPendingIncCount > 0 then
					uiColor_Black = _G.UIColor_Red
				end

				self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "CounterBg", 11, uiColor_Black)
				self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "CounterBg", 12, 50)
				self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "CounterBg", 14, __wf_atom_5e6e15c8 + 10)
			end
		end

		function categorizedGrid.mCategoryMenu:RefreshCategoryCounts()
			if self.mApplyThemes then
				self:SetCategoryLabel(self.mSelectedElement.Name, self.mSelectedElement)
			end

			self:RunForAllElements(function(p8)
				self:UpdateCount(p8)
			end)
		end

		categorizedGrid.mCategoryMenu._CategoriesMenu_OnDraw = categorizedGrid.mCategoryMenu.OnDraw

		function categorizedGrid.mCategoryMenu:OnDraw(p8, p9)
			if p8 == nil or p8.mClipName == nil then
				return
			end

			if self.mApplyThemes then
				self.mMovie:__wf_atom_c90af43a(p8.mClipName .. ".UpperIcon", categorizedGrid.mUpperIcon)
				self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "UpperIcon", 14, 24)
				self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "UpperIcon", 15, 24)

				if not (__wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(data.Positive)) then
					self.mMovie:__wf_atom_4c1c1986(p8.mClipName, "UpperIcon", 11, data.Positive)
				end
			end

			self:_CategoriesMenu_OnDraw(p8, p9)
			self:UpdateCount(p8)
		end
	end

	local mMovie = categorizedGrid.mMovie
	local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
	categorizedGrid._UserList_Sort = categorizedGrid.Sort

	function categorizedGrid.Sort(object, p8, p9)
		if p8.Friend ~= nil and p9.Friend ~= nil and p8.Friend.mFavorite ~= p9.Friend.mFavorite then
			return p8.Friend.mFavorite
		end

		if not Engine.__wf_atom_fc67ba71() then
			return object:_UserList_Sort(p8, p9)
		end

		if p8.PlatformFamily == __wf_atom_63bb2bc6 and p9.PlatformFamily ~= __wf_atom_63bb2bc6 then
			return true
		end

		if p8.PlatformFamily ~= __wf_atom_63bb2bc6 and p9.PlatformFamily == __wf_atom_63bb2bc6 then
			return false
		end

		return object:_UserList_Sort(p8, p9)
	end

	if categorizedGrid.mSortMenu ~= nil then
		if not categorizedGrid.mApplyThemes then
			categorizedGrid.mSortMenu:SetWidth(289)
			mMovie:__wf_atom_e57658c2(categorizedGrid.mSortClipName, 0, 303)
		end

		categorizedGrid.mSortMenu.mMainButton.SortButtonPressed = categorizedGrid.mSortMenu.mMainButton.Pressed

		function categorizedGrid.mSortMenu.mMainButton:Pressed(p8, p9)
			self:SortButtonPressed(p8, p9)

			if not __wf_atom_7e8ad928(categorizedGrid.mContextMenu) then
				local v = __wf_atom_7e8ad928(categorizedGrid.mContextMenu:GetFocusedElement())

				if categorizedGrid.mMovie:__wf_atom_a91463a8(categorizedGrid.mContextMenuClipName, 67) and v then
					categorizedGrid.mContextMenu:Hide()
				end
			end
		end

		categorizedGrid:AddSortBy({
			Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false),
			SortId = "NAME",
			Attribute = "UserLower"
		})

		if mMovie:Execute("IsAllianceUserList", "") then
			categorizedGrid:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ClanTier", false),
				SortId = "TIER",
				Attribute = "Tier"
			})
			categorizedGrid:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Members", false),
				SortId = "MEMBERS",
				Attribute = "MemberCount"
			})
		else
			if p7 then
				categorizedGrid:AddSortBy({
					Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/ClanRank", false),
					SortId = "CLAN_RANK",
					Attribute = function(data2, data3)
						if data2.Rank ~= data3.Rank then
							return data2.Rank < data3.Rank
						end

						if data2.Friend.mNote ~= "" and data3.Friend.mNote ~= "" then
							return data2.UserLower < data3.UserLower
						end

						return data2.Friend.mNote ~= "" and data3.Friend.mNote == ""
					end
				})
			end

			categorizedGrid:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/LastLoggedOn", false),
				SortId = "LAST_LOGGED_ON",
				Attribute = "LastLoginSeconds"
			})
			categorizedGrid:AddSortBy({
				Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/RecentLogon", false),
				SortId = "MOST_RECENT_LOGON",
				Attribute = function(p8, p9)
					return p8.LastLoginSeconds > p9.LastLoginSeconds
				end
			})

			if not Engine.__wf_atom_fc67ba71() then
				categorizedGrid:AddSortBy({
					Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Platform", false),
					SortId = "PLATFORM",
					Attribute = function(p8, p9)
						if p8.PlatformFamily == __wf_atom_63bb2bc6 and p9.PlatformFamily ~= __wf_atom_63bb2bc6 then
							return true
						end

						if p8.PlatformFamily == __wf_atom_63bb2bc6 or p9.PlatformFamily ~= __wf_atom_63bb2bc6 then
							return p8.UserLower < p9.UserLower
						end

						return false
					end
				})
			end
		end

		local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
		local v = __wf_atom_7e8ad928(gGameData) and "" or gGameData:__wf_atom_6340bbd5(__wf_atom_6d61d595)
		categorizedGrid:SetSortBy(v == "" and "NAME" or v)
	end

	local v = categorizedGrid.mRootClip .. ".Search"

	if mMovie:__wf_atom_253d7085(v) then
		local mSearchBox

		if categorizedGrid.mApplyThemes then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
			local module6 = require("Lotus.Interface.Components.ThemedInputField")
			mSearchBox = module6.Create(mMovie, v, nil, nil, "<MENU_LTHUMB>")
			mSearchBox:SetType(mSearchBox.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
			mSearchBox.mMinSize = 175
			mSearchBox.mMaxSize = 175
			mSearchBox.mTextBuffer = 4
			mSearchBox.mAltButtonIcon = _G.UITexture_Search
			mSearchBox.mAltButtonVisible = true
			mSearchBox.mUnfocusedUnderlineColorOverride = nil
			mSearchBox.BaseInputFieldTextChanged = mSearchBox.InputFieldTextChanged

			function mSearchBox:InputFieldTextChanged(p8)
				local mLabel = self.mLabel
				self:BaseInputFieldTextChanged(p8)
				local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

				if self.mAltButtonicon ~= uiTexture_Search then
					self.mAltButtonicon = uiTexture_Search
					self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
				end

				if mLabel ~= self.mLabel and categorizedGrid ~= nil then
					categorizedGrid:Redraw(nil, true, true)
				end
			end

			mSearchBox.BaseOnGamepadTransition = mSearchBox.OnGamepadTransition

			function mSearchBox:OnGamepadTransition()
				self:BaseOnGamepadTransition()
				local mAltButtonVisible = not Engine.IsPlayingWithController()
				self.mAltButtonVisible = mAltButtonVisible
				self.mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
			end

			mSearchBox:SetHint("/Lotus/Language/Menu/SearchPrompt")
			mSearchBox:Redraw()
		else
			local module6 = require("Lotus.Interface.Components.SearchBox")
			mSearchBox = module6.Create(categorizedGrid.mMovie, v)
			mSearchBox.mWidth = 289

			function mSearchBox.OnSearchChanged(_)
				categorizedGrid:Redraw(nil, true, true)
			end

			mSearchBox:Initialize()
			mMovie:__wf_atom_e57658c2(v, 0, 142)
		end

		categorizedGrid.mSearchBox = mSearchBox

		function categorizedGrid.AdditionalFilterFunction(p8)
			local user = p8.User

			if user == nil then
				return true
			end

			local ternary = module.Ternary(categorizedGrid.mApplyThemes, mSearchBox.mLabel, mSearchBox.mSearchTerm)

			if ternary == nil or ternary == "" then
				return false
			end

			return string.find(__wf_atom_d99ae0ec(user), __wf_atom_d99ae0ec(ternary), 1, true) == nil
		end
	end

	if not categorizedGrid.mContextMenuClipName then
		return categorizedGrid
	end

	local module6 = require("EE.Interface.Components.List")
	categorizedGrid.mContextMenu = module6.CreateList(
		categorizedGrid.mMovie,
		categorizedGrid.mContextMenuClipName .. ".Btn1"
	)
	categorizedGrid.mContextMenu:SetCallbacks("ContextItemPressed", "ContextItemFocused", "ContextItemUnfocused")
	categorizedGrid.mContextMenu.mLongestElement = 0
	categorizedGrid.mContextMenu.mForcedVerticalSeparation = 32
	categorizedGrid.mContextMenu.mWrapAroundNavigation = false
	categorizedGrid.mContextMenu.mVisibleElements = 8
	categorizedGrid.mContextMenu.mVisible = false

	function categorizedGrid.mContextMenu:Hide()
		categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 67, false)
		categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 13, false)
		categorizedGrid.mMovie:__wf_atom_976dcedd(categorizedGrid.mRootClip, "noMenuSelection", false)
		local focusedElement = categorizedGrid:GetFocusedElement()

		if __wf_atom_7e8ad928(categorizedGrid.mStoredFocusId) and not __wf_atom_7e8ad928(focusedElement) then
			categorizedGrid:UnfocusElementById(focusedElement.Id)
		elseif
			not __wf_atom_7e8ad928(categorizedGrid.mStoredFocusId)
			and (__wf_atom_7e8ad928(focusedElement) or categorizedGrid.mStoredFocusId ~= focusedElement.Id)
		then
			categorizedGrid:FocusElementById(categorizedGrid.mStoredFocusId)
		end

		self.mVisible = false
	end

	function categorizedGrid.mContextMenu:Show(p8, p9, p10)
		if __wf_atom_7e8ad928(p8) or __wf_atom_7e8ad928(p9) then
			p8 = categorizedGrid.mMovie:__wf_atom_5e6e15c8("_root", 30) + 10
			p9 = categorizedGrid.mMovie:__wf_atom_5e6e15c8("_root", 31) + 8
		end

		_T.gToolTip = nil
		categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 67, true)
		categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 13, true)
		categorizedGrid.mMovie:__wf_atom_976dcedd(categorizedGrid.mRootClip, "noMenuSelection", true)
		self.mLongestElement = 0
		self:Redraw(nil, true)
		local v2 = { x = p8, y = p9 }

		for i = 1, self:GetHowManyElements() do
			local elementInIndex = self:GetElementInIndex(i)

			if __wf_atom_7e8ad928(elementInIndex) then
				continue
			end

			if categorizedGrid.mApplyThemes and not __wf_atom_7e8ad928(elementInIndex.Button) then
				elementInIndex.Button:SetWidth(self.mLongestElement + 20)
			else
				categorizedGrid.mMovie:__wf_atom_4c1c1986(
					elementInIndex.mClipName,
					"Btn",
					14,
					self.mLongestElement + 10
				)
				categorizedGrid.mMovie:__wf_atom_4c1c1986(elementInIndex.mClipName, "Bg", 14, self.mLongestElement + 15)
			end
		end

		if not p10 then
			local _, v3 = module.GetScreenDimensions(categorizedGrid.mMovie)
			local v4 = v2.y + self:GetHowManyElements() * self.mForcedVerticalSeparation + 18

			if v3 < v4 then
				local v5 = v3 - v4
				v2.y += v5
			end

			categorizedGrid.mMovie:__wf_atom_e57658c2(categorizedGrid.mContextMenuClipName, 0, module.Round(v2.x))
			categorizedGrid.mMovie:__wf_atom_e57658c2(categorizedGrid.mContextMenuClipName, 1, module.Round(v2.y))
		end

		categorizedGrid.mMovie:__wf_atom_4c1c1986(
			categorizedGrid.mContextMenuClipName,
			"Frame",
			14,
			self.mLongestElement + module.Ternary(categorizedGrid.mApplyThemes, 40, 35)
		)
		categorizedGrid.mMovie:__wf_atom_4c1c1986(
			categorizedGrid.mContextMenuClipName,
			"Frame",
			15,
			self:GetHowManyElements() * self.mForcedVerticalSeparation + module.Ternary(categorizedGrid.mApplyThemes, 22, 18)
		)
		self.mVisible = true
	end

	function categorizedGrid.mContextMenu:SetElementColor(p8, p9)
		if categorizedGrid.mApplyThemes then
			return
		end

		local uiColor_White = _G.UIColor_White
		local uiColor_Black = _G.UIColor_Black
		local focusedElement = categorizedGrid.mContextMenu:GetFocusedElement()

		if not p9 and not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == p8.Id then
			uiColor_White = _G.UIColor_Yellow
			uiColor_Black = _G.UIColor_Black
		end

		categorizedGrid.mMovie:__wf_atom_4c1c1986(p8.mClipName, "Bg", 11, uiColor_White)
		categorizedGrid.mMovie:__wf_atom_4c1c1986(p8.mClipName, "Label", 11, uiColor_Black)
	end

	function categorizedGrid.mContextMenu.mOnFocusedCallback(p8)
		categorizedGrid.mContextMenu:SetElementColor(p8, false)
	end

	function categorizedGrid.mContextMenu.mOnUnfocusedCallback(p8)
		categorizedGrid.mContextMenu:SetElementColor(p8, true)
	end

	function categorizedGrid.mContextMenu.mOnSelectedCallback(p8)
		if __wf_atom_7e8ad928(p8) or __wf_atom_7e8ad928(p8.PressedCallback) then
			return
		end

		local pressedCallback = p8.PressedCallback()

		if __wf_atom_7e8ad928(pressedCallback) or pressedCallback then
			categorizedGrid.mContextMenu:Hide()
		end
	end

	function categorizedGrid.mContextMenu:mElementDrawCallback()
		if __wf_atom_7e8ad928(self) then
			return
		end

		if categorizedGrid.mApplyThemes then
			local module7 = require("Lotus.Interface.Components.ThemedButton")
			self.Button = module7.Create(
				categorizedGrid.mMovie,
				self.mClipName,
				self.Name,
				nil,
				nil,
				nil,
				nil,
				categorizedGrid:GetParentEnv()
			)
			self.Button:SetId(self.Id)
			self.Button.mMinSize = 200
			self.Button.mAlignment = "left"
			self.Button.mTextBuffer = 10
			self.Button.mOnFocusedCallback = categorizedGrid.mContextMenu.mOnFocusedCallback
			self.Button.mOnUnfocusedCallback = categorizedGrid.mContextMenu.mOnUnfocusedCallback
			self.Button.mOnPressedCallback = categorizedGrid.mContextMenu.mOnSelectedCallback
			self.Button.PressedCallback = self.PressedCallback
			self.Button:Redraw()
		else
			categorizedGrid.mContextMenu:SetElementColor(self, false)
			categorizedGrid.mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Label.text", self.Name)
		end

		local __wf_atom_cfc41e35 = categorizedGrid.mMovie:__wf_atom_cfc41e35(self.mClipName, "Label", 40)
		categorizedGrid.mContextMenu.mLongestElement = math.max(
			categorizedGrid.mContextMenu.mLongestElement,
			__wf_atom_cfc41e35
		)
	end

	if categorizedGrid.mApplyThemes and not __wf_atom_7e8ad928(data) then
		categorizedGrid.mMovie:OverrideMaterial(
			categorizedGrid.mContextMenuClipName .. ".Frame",
			_G.UIMaterial_RectangleNoDepth
		)
		categorizedGrid.mMovie:__wf_atom_1ca72041(
			categorizedGrid.mContextMenuClipName .. ".Frame",
			"RectEdgeColor",
			data.FloatingContentObject.r,
			data.FloatingContentObject.g,
			data.FloatingContentObject.b,
			0.3
		)
		categorizedGrid.mMovie:__wf_atom_1ca72041(
			categorizedGrid.mContextMenuClipName .. ".Frame",
			"RectInnerColor",
			data.Background1Object.r,
			data.Background1Object.g,
			data.Background1Object.b,
			0.9
		)
	else
		categorizedGrid.mMovie:__wf_atom_4c1c1986(categorizedGrid.mContextMenuClipName, "Frame", 12, 50)
	end

	categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 67, false)
	categorizedGrid.mMovie:__wf_atom_2dedec1a(categorizedGrid.mContextMenuClipName, 13, false)
	return categorizedGrid
end