local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.LotusNetworkUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.TextSuggest")
local module7 = require("Lotus.Interface.Components.PresenceHelper")
local v = false
local v2 = false
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 0
local v9 = 0
local total = 0
local v10 = nil
local v11 = nil
local name = nil
local v12 = nil
local v13 = false
local v14 = nil
local flag = false
local v15 = ""
local v16 = { Real = {}, Tags = {}, Indexer = {} }
local v17 = "/Lotus/Language/Menu/SocialOverlay_Invite"
local v18 = false
local v19 = {}
local fn
local fn2
local fn3
local fn4
local v20 = nil

function IsInputBlocked()
	return v2
end

local function fn5(p)
	mMovie:__wf_atom_46a6af3b(p)
end

local function fn6()
	v19.FloatingContent = module5.GetColor(9, true)
	v19.FloatingContentObject = module.ConvertColorNumberToProceduralRGB(v19.FloatingContent)
	v19.FloatingContentHighlight = module5.GetColor(10, true)
	v19.FloatingContentHighlightObject = module.ConvertColorNumberToProceduralRGB(v19.FloatingContentHighlight)
	v19.Content = module5.GetColor(6, true)
	v19.Background1 = module5.GetColor(2, true)
	v19.Background1Object = module.ConvertColorNumberToProceduralRGB(v19.Background1)
	v19.Background3 = module5.GetColor(4, true)
	v19.BackerHighlight = module5.GetColor(1, true)
	v19.Negative = module5.GetColor(12, true)
	mMovie:__wf_atom_e57658c2("Feedback.Label", 44, v19.FloatingContentHighlight)
end

local function fn7()
	local module8 = require("Lotus.Interface.Components.UserList")

	if Engine.__wf_atom_2a979d69() then
		v5 = module8.Create(mMovie, "UserList.Members.Member1", "Categories", nil, nil, "UserList", 7, true, v19)
	else
		v5 = module8.Create(mMovie, "UserList.Members.Member1", "Categories", nil, nil, "UserList", 10, true, v19)
	end

	v5:HookUpCallbacks()
	v5:SetCallbacks("MenuItemPressed", "MenuItemFocused", "MenuItemUnfocused")
	v5.mRowSeparation = 46
	v5:AttachScrollBar(v5.mRootClip .. ".MemberScrollBar", -1)
	v5.mAddFillerElements = true
	v5.mScrollAlwaysVisible = true
	v5.mScrollBarHorizontalOffset = nil
	v5.mShowClanRank = false
	v5.mHighlightAlphaFocusedOverride = 20
	v5.mEdgeAlphaOffset = 25
	v5.mFillerEdgeAlpha = 5
	v5.mSwapDepth = false
	v5.CLAN = 4
	v5.RECENT = 5
	v5.STEAM = 6
	v5.mCategoryMenu.mDisplayMode = v5.mCategoryMenu.Modes.BOTH
	v5.mCategoryMenu.mContentAlign = module.CENTER_ALIGNED
	v5.mCategoryMenu.mForceWidth = 199
	v5.mCategoryMenu.mPadding = 2

	function v5.mCategoryMenu.UpdateCount(p, p2)
		if p2 == nil or p2.mClipName == nil then
			return
		end

		local __wf_atom_76657dba = mMovie:__wf_atom_76657dba(p2.mClipName .. ".UserCount")

		if __wf_atom_76657dba == nil or __wf_atom_76657dba == "undefined" then
			__wf_atom_86cbd68d(mMovie, p2.mClipName .. ".attachMovie", "UserCount", "UserCount", 100)
			mMovie:__wf_atom_48bd5a59(p2.mClipName, "UserCount.Counter", 46, "center")
			mMovie:__wf_atom_7f57ab2f(p2.mClipName, "UserCount.Counter", 54, true)
			mMovie:__wf_atom_4c1c1986(p2.mClipName, "UserCount.Counter", 44, v19.FloatingContent)
			mMovie:__wf_atom_4c1c1986(p2.mClipName, "UserCount.Bg", 11, v19.Background3)
		end

		local v21 = p.UserList.mUserCount[p2.Category] == nil and 0 or p.UserList.mUserCount[p2.Category]
		mMovie:__wf_atom_48bd5a59(p2.mClipName, "UserCount.Counter", 36, (tostring(v21)))
		local v22 = mMovie:__wf_atom_5e6e15c8(p2.mClipName .. ".UserCount.Counter", 5) / 100
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p2.mClipName .. ".UserCount.Counter", 40)
		mMovie:__wf_atom_4c1c1986(p2.mClipName, "UserCount.Bg", 14, (__wf_atom_5e6e15c8 + 6) * v22)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p2.mClipName .. ".Backer", 14)
		mMovie:__wf_atom_4c1c1986(p2.mClipName, "UserCount", 0, __wf_atom_5e6e15c8_2 - 2)
		mMovie:__wf_atom_4c1c1986(p2.mClipName, "UserCount", 1, -6)
	end

	module.PlaySound(_G.UISound_Select)
	module.PlaySound(_G.UISound_WindowOpen)

	function v5:UpdateSelected(data)
		if data and data.mClipName then
			local v21 = not data.Filler and __wf_atom_d99ae0ec(data.User) == v11.mLowerSearchTerm
			mMovie:__wf_atom_4c1c1986(data.mClipName, "CornerPiece", 12, module.Ternary(v21, 100, 0))
		end
	end

	function v5:FocusChanged(p, p2, _)
		if p and p.mClipName then
			self:UpdateColors(p, p2, false, true)
			local ternary = module.Ternary(p2, v19.FloatingContentHighlight, v19.FloatingContent)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Name", 44, ternary)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Rank", 44, ternary)
		end
	end

	function v5.OnFocused(object, p)
		object:_UserList_OnFocused(p)
	end

	function v5.OnUnfocused(object, p)
		object:_UserList_OnUnfocused(p)
	end

	function v5.mOnFocusedCallback(p)
		fn4()
		local v21 = v7 ~= nil and v7.Id == p.Id
		v5:FocusChanged(p, true, v21)
	end

	function v5.mOnUnfocusedCallback(p)
		fn4()
		local v21 = v7 ~= nil and v7.Id == p.Id
		v5:FocusChanged(p, false, v21)
	end

	function v5.mOnSelectedCallback(p)
		if not __wf_atom_7e8ad928(v7) and v7.Id == p.Id and Time() - v8 < 0.5 then
			fn2()
			return
		end

		v8 = Time()
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_ItemTipSection)
		v7 = p
		v11:SetText(p.User)
		mMovie:__wf_atom_50d60589("Feedback.Label", 36, p.User)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("InputField", 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("InputField", 1)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Feedback.Label", 40)
		mMovie:__wf_atom_e57658c2("Feedback", 0, __wf_atom_5e6e15c8 + 8 + __wf_atom_5e6e15c8_3 * 0.5)
		mMovie:__wf_atom_e57658c2("Feedback", 1, __wf_atom_5e6e15c8_2 + 18)
		mMovie:__wf_atom_e57658c2("Feedback", 5, 300)
		mMovie:__wf_atom_e57658c2("Feedback", 6, 300)
		mMovie:__wf_atom_e57658c2("Feedback", 12, 35)
		__wf_atom_ec43d06e(mMovie, "Feedback", 2, { 12, 5, 6 }, { 0, 100, 100 }, 0.4)
	end

	v5._MemberList_OnDraw = v5.OnDraw

	function v5.OnDraw(object, data, p)
		object:_MemberList_OnDraw(data, p)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Rank", 13, not (data.HideStatus or data.Filler or v13))
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "IconBg", 13, not data.Filler)
		local focusedElement = v5:GetFocusedElement()
		local v21

		if focusedElement == nil then
			v21 = false
		else
			v21 = focusedElement.Id == data.Id
		end

		local v22

		if v7 == nil then
			v22 = false
		else
			v22 = v7.Id == data.Id
		end

		mMovie:OverrideMaterial(data.mClipName .. ".RectangleBg", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(data.mClipName .. ".IconBg", _G.UIMaterial_RectangleNoDepth)
		local convertColorNumberToProceduralRGB = object.UTIL.ConvertColorNumberToProceduralRGB(v19.Background1)
		local convertColorNumberToProceduralRGB2 = object.UTIL.ConvertColorNumberToProceduralRGB(v19.BackerHighlight)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".IconBg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.2
		)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".IconBg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.25
		)
		mMovie:OverrideMaterial(data.mClipName .. ".CornerPiece.Bg", _G.UIMaterial_RectangleNoDepth)
		local convertColorNumberToProceduralRGB3 = object.UTIL.ConvertColorNumberToProceduralRGB(v19.FloatingContentHighlight)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".CornerPiece.Bg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			0.75
		)
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".CornerPiece.Bg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			0
		)
		v5:FocusChanged(data, v21, v22)
		v5:UpdateSelected(data)
	end

	function v5:Populate()
		v16.Real = {}
		v16.Tags = {}
		v16.Indexer = {}
		self.mUserCount[self.ONLINE] = 0
		self.mUserCount[self.CLAN] = 0
		self.mUserCount[self.RECENT] = 0
		local users = self:GetUsers()
		local count = 0

		for i = 1, #users do
			__wf_atom_83c14687(0)
			count += 1
			local user = self:BuildUser(users[i], count)
			local online = self.ONLINE
			user.LastLoginSeconds = 0
			user.LastLoginStr = ""

			if user.Status == 9 or user.Status == 0 then
				if user.State == 0 and not v13 then
					online = self.OFFLINE
				elseif user.Status == 9 then
					online = self.STEAM
				end
			else
				online = self.PENDING
			end

			if not (online == self.ONLINE or online == self.STEAM) then
				continue
			end

			self.mUserCount[self.ONLINE] = self.mUserCount[self.ONLINE] + 1
			table.insert(user.Categories, online)
			table.insert(v16.Real, { Name = user.User, LowerName = string.lower(user.User) })
			self:AddElement(user, true)
		end

		local __wf_atom_6be84646 = v3:__wf_atom_6be84646()
		local clanMembers = self:GetClanMembers()

		for i = 1, #clanMembers do
			__wf_atom_83c14687(0)
			count += 1
			local user = self:BuildUser(clanMembers[i], count)
			local online = self.ONLINE

			if user.State == 0 then
				online = self.OFFLINE
			end

			if not ((online == self.ONLINE or v13) and user.User ~= __wf_atom_6be84646) then
				continue
			end

			table.insert(user.Categories, self.CLAN)
			table.insert(v16.Real, { Name = user.User, LowerName = string.lower(user.User) })
			self.mUserCount[self.CLAN] = self.mUserCount[self.CLAN] + 1
			self:AddElement(user, true)
		end

		local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
		local recent = self:GetRecent()

		for i = 1, #recent do
			__wf_atom_83c14687(0)
			count += 1
			local user = self:BuildUser(recent[i], count)
			local online = self.ONLINE

			if user.State == 0 then
				online = self.OFFLINE
			end

			if not ((online == self.ONLINE or v13) and user.User ~= __wf_atom_6be84646 and (not v13 or Engine.__wf_atom_940f8971(user.User) == __wf_atom_63bb2bc6)) then
				continue
			end

			local crossPlatformUniquePlayerName = module2.GetCrossPlatformUniquePlayerName(
				user.User,
				recent,
				"mDisplayName"
			)
			table.insert(user.Categories, self.RECENT)
			self.mUserCount[self.RECENT] = self.mUserCount[self.RECENT] + 1
			table.insert(v16.Real, {
				Name = crossPlatformUniquePlayerName,
				LowerName = string.lower(user.User)
			})
			user.UniqueName = crossPlatformUniquePlayerName
			self:AddElement(user, true)
		end

		table.sort(v16.Real, function(a, b)
			return a.LowerName < b.LowerName
		end)
		local v21 = nil

		for i = 1, #v16.Real do
			table.insert(v16.Tags, v16.Real[i].LowerName)
			local v22 = string.sub(v16.Tags[i], 1, 1)

			if v22 == v21 then
				continue
			end

			v16.Indexer[v22] = i
			v21 = v22
		end
	end

	function v5:GetClanMembers()
		if __wf_atom_7e8ad928(v4) then
			return {}
		end

		return (v4:__wf_atom_ca48a66f())
	end

	function v5:GetRecent()
		if __wf_atom_7e8ad928(v4) then
			return {}
		end

		return (v4:GetRecent())
	end

	function v5:GetUsers()
		if __wf_atom_7e8ad928(v4) then
			return {}
		end

		return (v4:__wf_atom_0f109cd4())
	end

	v5.SetCategory_Internal_Parent = v5.SetCategory_Internal

	function v5.SetCategory_Internal(_, p)
		v5.mShowMasteryRank = p ~= v5.RECENT
		v5:SetCategory_Internal_Parent(p)
	end

	function v5.AdditionalFilterFunction(p)
		return p.User == nil
	end

	v5:AddCategory({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/FriendsUpperCase", false),
		Icon = userListCategoriesTextures[1],
		Category = v5.ONLINE
	})
	v5:AddCategory({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_Recent", false),
		Icon = userListCategoriesTextures[3],
		Category = v5.RECENT
	})
	v5:SetCategory(v5.ONLINE)
end

function OnLitePresenceUpdated(_)
	v9 = 1

	if _T.NextLitePresenceResync == nil then
		_T.NextLitePresenceResync = __wf_atom_c4e218a2() + module7.LITE_PRESENCE_RESYNC_INTERVAL
	end

	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module7.RICH_PRESENCE_RESYNC_INTERVAL
	end
end

local function fn8()
	if not __wf_atom_7e8ad928(v4) then
		v4:__wf_atom_bd2c8427("OnLitePresenceUpdated", true)
	end
end

function ResyncLitePresence()
	if not v13 then
		fn8()
	end
end

function OnRichPresenceUpdated(_)
	v9 = 1

	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module7.RICH_PRESENCE_RESYNC_INTERVAL
	end
end

function ResyncRichPresence()
	if not (v13 or __wf_atom_7e8ad928(v5)) then
		v5:ResyncRichPresence()
	end
end

function CanResyncPresence()
	return not v13
end

fn2 = function()
	if v2 or __wf_atom_7e8ad928(v4) then
		return
	end

	local mLabel

	if v11.mLabel == "" then
		mLabel = ""
	else
		mLabel = v11.mLabel

		if v7 ~= nil and mLabel == v7.User then
			mLabel = v7.User
		end
	end

	if #mLabel == 0 then
		return
	end

	local v21 = "[]"
	local __wf_atom_7f395d54 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_7f395d54()

	if __wf_atom_7f395d54 or Engine.__wf_atom_84bb79c2() then
		v21 ..= " "

		if __wf_atom_7f395d54 then
			v21 ..= "#"
		end
	end

	local __wf_atom_746f9d1b = Engine.__wf_atom_746f9d1b(mLabel)
	local invalidNameCharacters = module.GetInvalidNameCharacters(__wf_atom_746f9d1b, v21)

	if invalidNameCharacters ~= 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			mLabel,
			invalidNameCharacters,
			invalidNameCharacters
		))
		return
	end

	local v22 = v12 == nil and module4.CheckGameInvitePermission(nil, mLabel)

	if v22 then
		module.ShowMessage(v22, nil, 0)
		return
	end

	name = mLabel

	if v13 and v12 ~= nil then
		fn3({ Name = name })
	else
		v4:__wf_atom_6a4bcc2b(name.Name, true, "GameInvitePlayerIDResults")
	end
end

function OnInvite()
	fn2()
end

local function fn9(p, _, p2)
	if v2 or __wf_atom_7e8ad928(v4) or tonumber(p2) == 5 then
		return
	end

	v11:InputFieldTextChanged(p, true)
	fn2()
end

function InvitePlayer(p, p2, p3)
	fn9(p, p2, p3)
end

function OSKInvitePlayer(p, p2)
	fn9(p2, "", p and 5 or 0)
end

local function fn10()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, mMovie:__wf_atom_d5a50cb5())
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, mMovie:__wf_atom_c4f6543f())
end

local function fn11()
	v10:SetActive(false)
	local scrollValue = v5.mScrollBar:GetScrollValue()
	v5:RemoveElements(true, true)
	v5:Populate()
	v5.mSortBy = "UserLower"
	v5:Redraw(nil, false, true)

	if scrollValue ~= nil then
		v5.mScrollBar:SetScrollValue(scrollValue, false)
	end
end

function MouseCatcherPressed() end

function Initialize()
	_T.InvitePanelOpen = true

	if not (gGameRules:IsA(__wf_atom_88d33e05) or gGameRules:__wf_atom_b450ace7()) then
		v18 = true
		gGameRules:__wf_atom_411c9025(true)
	end

	v3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	assert(not __wf_atom_7e8ad928(v3))
	v4 = v3:__wf_atom_9be88b01()
	fn6()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	local module8 = require("Lotus.Interface.Components.ThemedSpinner")
	v10 = module8.Create(mMovie, "ListSpinner")
	v10:SetActive(true)

	if not Engine.__wf_atom_fc67ba71() then
		v14 = __wf_atom_8e4fda44:FindMovie(IMEOverlayMovie)

		if __wf_atom_7e8ad928(v14) and not __wf_atom_7e8ad928(IMEOverlayMovie) then
			v14 = mMovie:PushChildMovie(IMEOverlayMovie)
			flag = true
		end
	end

	mMovie:__wf_atom_976dcedd("MouseCatcherBtn", "noMenuSelection", true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	fn10()
	fn7()
	local module9 = require("Lotus.Interface.Components.ThemedButton")
	v6 = module9.Create(mMovie, "InviteBtn", v17, "OnInvite", "<MENU_GENERIC1>")
	v6:SetSpecialMode()
	v6:SetWidth(127)
	v6:SetActive(false)
	v6:Redraw()
	local module10 = require("Lotus.Interface.Components.ThemedInputField")
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/InvitePlanel_PlayerName", false)
	v11 = module10.Create(mMovie, "InputField", nil, nil, "<MENU_LTHUMB>")
	v11:SetType(v11.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384, "OSKInvitePlayer")
	v11:SetMaxChars(30)
	v11.mMinSize = 350
	v11.mMaxSize = 350
	v11.mTextBuffer = 4
	v11.mLowerSearchTerm = ""
	v11.mAltButtonVisible = nil
	v11.mUnfocusedUnderlineColorOverride = nil
	v11.BaseInputFieldTextChanged = v11.InputFieldTextChanged

	function v11:UpdateIconVisibility()
		local mAltButtonVisible = not Engine.IsPlayingWithController() and self.mLabel ~= ""

		if self.mAltButtonVisible ~= mAltButtonVisible then
			self.mAltButtonVisible = mAltButtonVisible
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
		end
	end

	function v11:InputFieldTextChanged(p)
		v11.mLowerSearchTerm = __wf_atom_d99ae0ec(p)
		v5:RunForAllVisibleElements(function(p2)
			v5:UpdateSelected(p2)
		end)
		self:BaseInputFieldTextChanged(p)
		v11:UpdateIconVisibility()
		v6:SetActive(self.mLabel ~= "")
	end

	v11.BaseOnGamepadTransition = v11.OnGamepadTransition

	function v11.OnGamepadTransition(object)
		object:BaseOnGamepadTransition()
		v11:UpdateIconVisibility()
	end

	v11:SetHint("/Lotus/Language/Menu/InvitePlanel_PlayerName")
	v11:Redraw()
	v13 = _T.SetShowOfflinePlayers == true
	_T.SetShowOfflinePlayers = nil

	if v13 then
		fn11()
	else
		v4:__wf_atom_330f71b3("FriendInfoChanged")
		v4:__wf_atom_e391b0d2("RecentPlayersChanged")
		fn8()
	end

	mMovie:__wf_atom_dac78d3d(true)
	local color = module5.GetColor(2, true)
	mMovie:__wf_atom_7df746cd(color)
	mMovie:__wf_atom_e57658c2("_root", 4, 8000)
	__wf_atom_ec43d06e(mMovie, "_root", 2, {
		12,
		4,
		function(p)
			mMovie:__wf_atom_0cf0fdbe(p * 0.9)
		end
	}, { 100, 0, 1 }, 0.2, 0)
	fn4()
	mMovie:__wf_atom_50d60589("Feedback.Label", 36, "")
	mMovie:__wf_atom_e57658c2("Feedback", 12, 0)
	v = true
end

function FriendInfoChanged()
	v9 = 1
end

function RecentPlayersChanged(_, _)
	v9 = 1
end

local function fn12()
	local mLabel = v11.mLabel
	local flag2 = false

	if mLabel == v15 then
		return
	end

	v15 = mLabel
	local v21 = string.lower(mLabel)
	local v22 = ""
	local count = 0
	local v23 = false

	if v21 ~= "" then
		local name2 = ""
		local v24 = string.len(v21)
		local v25 = string.sub(v21, 1, 1)
		local v26 = v16.Indexer[v25]

		if v26 ~= nil then
			for i = v26, #v16.Tags do
				local tag = v16.Tags[i]

				if string.sub(tag, 1, v24) == v21 and name2 ~= v16.Real[i].Name then
					flag2 = true
					v23 = v21 == tag or v23
					name2 = v16.Real[i].Name
					v22 ..= name2 .. "|"
					count += 1

					if count >= 8 then
						break
					end
				elseif v25 ~= string.sub(tag, 1, 1) then
					break
				end
			end
		end
	end

	if flag2 then
		if not v23 then
			v22 ..= v15
		end

		module6.OpenIME(v14)
		module6.IMESetTip(v15, v14)
		module6.IMESetTipCursor(string.len(v15), v14)
		module6.IMESetOptions(v22, v14, false)

		if v23 and module6.IMEGetFocusedIndex() > module6.IMEGetNumOptions(v14) then
			module6.IMESetFocusedOption(1, v14)
		end

		mMovie:__wf_atom_2dedec1a(v11.mLabelClipName, 87, true)
	else
		module6.IMESetOptions("", v14, false)
		module6.CloseIME(v14)
		mMovie:__wf_atom_2dedec1a(v11.mLabelClipName, 87, false)
	end
end

local function fn13()
	local imeGetFocusedValue = module6.IMEGetFocusedValue(v14)
	v15 = imeGetFocusedValue
	v11:SetText(imeGetFocusedValue)
	mMovie:__wf_atom_e57658c2(v11.mLabelClipName, 85, (string.len(imeGetFocusedValue)))
	module6.CloseIME(v14)
	module6.IMESetFocusedOption(1, v14)
	mMovie:__wf_atom_2dedec1a(v11.mLabelClipName, 87, false)
	v11:Pressed(true)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v then
		return
	end

	local v21 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v21)

	if not __wf_atom_7e8ad928(v10) then
		v10:Update()
	end

	if v9 > 0 then
		total += v21
		v9 -= v21

		if v9 <= 0 or total >= 5 then
			total = 0
			fn11()
		end
	end

	if not (__wf_atom_8e4fda44:__wf_atom_084a721a() or __wf_atom_7e8ad928(v14)) then
		if v11.mSelected then
			if module6.IMEGetAndClearClicked() then
				fn13()
			end

			fn12()
		end

		module6.Update(v14)
	end
end

function MenuItemFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5.mStoredFocusId = tonumber(p)
		v5:FocusElementById((tonumber(p)))
	end
end

function MenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5.mStoredFocusId = nil
		v5:UnfocusElementById((tonumber(p)))
	end
end

function MenuItemPressed(p)
	if not (v2 or __wf_atom_7e8ad928(v5)) then
		v5:SelectElementById((tonumber(p)))
	end
end

function CategoryFocused(p)
	if not (v2 or __wf_atom_7e8ad928(v5.mCategoryMenu)) then
		v5.mCategoryMenu:FocusElementById((tonumber(p)))
	end
end

function CategoryUnfocused(p)
	if not __wf_atom_7e8ad928(v5.mCategoryMenu) then
		v5.mCategoryMenu:UnfocusElementById((tonumber(p)))
	end
end

function CategoryPressed(p)
	if not (v2 or __wf_atom_7e8ad928(v5.mCategoryMenu)) then
		v5.mCategoryMenu:SelectElementById(tonumber(p), true)
	end
end

function Shutdown()
	if v5 ~= nil then
		v5:Shutdown()
	end

	if v12 ~= nil then
		_T[v12] = nil
	end

	if not __wf_atom_7e8ad928(gRegion) and not __wf_atom_7e8ad928(gGameRules) and v18 then
		gGameRules:__wf_atom_411c9025(false)
	end

	if not __wf_atom_7e8ad928(v14) then
		if flag then
			v14:Close()
		elseif module6.IsVisible() then
			module6.CloseIME(v14)
		end
	end

	_T.InvitePanelOpen = false
	_T.ScenarioBeaconInvite = false
	_T.gToolTip = nil
end

function MessageReviewed()
	fn5(v11.mLabelClipName)
end

fn3 = function(data)
	if v12 == nil then
		if data.Name == module3.HIDDEN_PLAYER_NAME then
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_NonExistentUserError", false),
				"MessageReviewed"
			)
			return
		end

		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

		for i = 1, #__wf_atom_bb46d8b6 do
			if __wf_atom_bb46d8b6[i].onlineId ~= data.AccountId then
				continue
			end

			fn5("")
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame", false),
				"MessageReviewed"
			)
			return
		end

		local v21

		if _T.ScenarioBeaconInvite then
			v21 = cjson.encode({
				name = tostring(gMatchingService:__wf_atom_706d8455()),
				quest = "",
				difficulty = ""
			})
		else
			v21 = module4.GetSquadMissionForInvite()
		end

		gMatchingService:__wf_atom_b83bc045(data.AccountId, data.Name, v21, "SendGameInviteCallback", data.Platform)
	else
		name = data.Name
		fn()
	end
end

local function fn14(accounts, fn15)
	if not __wf_atom_7e8ad928(v20) then
		v20:Close()
	end

	v20 = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(v20) then
		v2 = true
		v20:Execute("SetTitle", "/Lotus/Language/Chat/PlayerSelection")
		v20:__wf_atom_f62a8704("SetTitleCaseText", { "false", "true" })

		function _T.PlayerSelectionDone(list)
			_T.PlayerSelectionDone = nil
			_T.GetPlayerList = nil
			v2 = false

			if __wf_atom_7e8ad928(list) or list[1] == nil then
				fn15(nil)
			else
				fn15(list[1].mChatMember)
			end
		end

		v20:Execute("SetCallBack", "PlayerSelectionDone")

		function _T.GetPlayerList()
			local result = {}

			for i = 1, #accounts do
				table.insert(result, {
					mName = Engine.__wf_atom_1b118af6(accounts[i].Name),
					mChatMember = accounts[i]
				})
			end

			return result
		end

		v20:Execute("SetElementsFunction", "GetPlayerList")
	end
end

function InviteOnSelection(accountId, name2, p)
	local v21 = { Name = name2, AccountId = accountId, Platform = tonumber(p) }
	fn3(v21)
end

local function fn15(data)
	if data == nil then
		return
	end

	mMovie:__wf_atom_f62a8704("InviteOnSelection", { data.AccountId, data.Name, (tostring(data.Platform)) })
end

function GameInvitePlayerIDResults(p, p2)
	local user = name
	name = nil
	local accounts, v21 = module2.GetAccountsFromIrcWhoQueryResults(p, p2)

	if #accounts == 0 then
		fn5("")

		if v13 then
			module.ShowMessage("/Lotus/Language/Menu/SocialOverlay_NonExistentUserError")
		elseif v21 then
			module.ShowMessage("/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame")
		else
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/NoOnlineUser", false, {
					USER = user
				}),
				"MessageReviewed"
			)
		end
	elseif #accounts > 1 then
		fn14(accounts, fn15)
	else
		fn3(accounts[1])
	end
end

function SendGameInviteCallback(p)
	fn5("")

	if __wf_atom_7e8ad928(_T.ShowNotification) or __wf_atom_7e8ad928(mMovie) then
		print("SendGameInviteCallback: " .. p)
	else
		_T.ShowNotification(p, "SquadMemberInvited")
		v11:SetText("")
	end

	module.PlaySound(_G.UISound_Select)
	module.PlaySound(_G.UISound_SweetenerOne)
	fn4()
end

function onRawInputEvent(_, value, p)
	if p == "0" and not v2 then
		if string.find(value, "_ENTER") == nil then
			if module6.IsVisible() and (string.find(value, "EN_LEFT") or string.find(value, "EN_RIGHT")) then
				local v21 = tonumber(module6.IMEGetFocusedIndex(v14))
				local ternary = module.Ternary(string.find(value, "EN_LEFT"), -1, 1)
				module6.IMESetFocusedOption(v21 + ternary, v14)
			end
		elseif not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie) then
			if module6.IsVisible() then
				fn13()
			else
				fn2()
			end
		end
	end
end

local function fn16()
	if name ~= nil and v12 ~= nil and not __wf_atom_7e8ad928(_T[v12]) then
		_T[v12](name)
	end

	mMovie:Close()
end

function Close()
	fn16()
end

fn = function()
	v2 = true

	local function fn17(p)
		mMovie:__wf_atom_0cf0fdbe((1 - p) * 0.9)
	end

	if not __wf_atom_7e8ad928(mMovie) then
		__wf_atom_ec43d06e(mMovie, "_root", 1, { 12, 4, fn17 }, { 0, 8000, 1 }, 0.2, 0, fn16)
	end

	module.PlaySound(_G.UISound_WindowClose)
end

function TransitionOut()
	fn()
end

function onKeyDown_MENU_LTRIGGER2()
	if not (v2 or __wf_atom_7e8ad928(v5)) then
		v5:PreviousCategory()
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (v2 or __wf_atom_7e8ad928(v5)) then
		v5:NextCategory()
	end

	return true
end

function onViewportSizeChanged(_, _)
	fn10()
end

function ShowConsoleProfile()
	if v5 == nil then
		return
	end

	local focusedElement = v5:GetFocusedElement()

	if focusedElement ~= nil then
		module3.ViewConsoleProfile(focusedElement.User)
	elseif v7 == nil then
		module.ShowMessage("/Lotus/Language/Menu/ViewGamercardNoSelectedUser")
	else
		module3.ViewConsoleProfile(v7.User)
	end
end

fn4 = function()
	local v21 = {}

	if Engine.__wf_atom_84bb79c2() then
		table.insert(v21, {
			Label = "/Lotus/Language/Menu/ShowPlatformParty",
			CallBack = module.DoShowPlatformParty,
			CallOut = "MENU_RTRIGGER1"
		})
	end

	if
		not Engine.__wf_atom_b290ec01()
		and Engine.__wf_atom_fc67ba71()
		and v5 ~= nil
		and v5:GetFocusedElement() ~= nil
	then
		table.insert(v21, {
			Label = "/Lotus/Language/Menu/ShowGamerCard_Windows",
			CallBack = function()
				mMovie:Execute("ShowConsoleProfile", "")
			end,
			CallOut = "MENU_GENERIC2"
		})
	end

	table.insert(v21, {
		Label = "/Lotus/Language/Menu/Global_Back",
		CallBack = fn,
		CallOut = "MENU_CANCEL"
	})

	if _T.SetButtons then
		_T.SetButtons(mMovie, v21, getfenv(1))
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (v2 or __wf_atom_7e8ad928(v5.mScrollBar)) then
		v5.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function SetButtonDesc(p)
	v17 = p

	if v6 ~= nil then
		v6:SetText(v17)
		v6:Redraw()
	end
end

function SetCallback(p)
	v12 = p
end

function SetDefaultName(p)
	v11:SetText(p == nil and "" or p)
end

function OnGamepadTransition(p)
	if v6 ~= nil then
		v6:Redraw()
	end

	mMovie:__wf_atom_2004c47f()
end

function SupportsThemes()
	return true
end