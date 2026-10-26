local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.LotusNetworkUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.TextSuggest")
local module7 = require("Lotus.Interface.Components.PresenceHelper")
local v = false
local v2 = false
local v3 = false
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = 0
local v10 = 0
local total = 0
local name = nil
local v11 = nil
local v12 = nil
local v13 = nil
local flag = false
local v14 = ""
local v15 = { Real = {}, Tags = {}, Indexer = {} }
local v16 = "/Lotus/Language/Menu/SocialOverlay_Invite"
local v17 = false
local v18 = {}
local fn
local fn2
local fn3
local fn4
local v19 = nil
local v20 = {
	{ IconIndex = 9, Name = "/SF/Language/Menu/InvitePlatformFriends" },
	{ IconIndex = 10, Name = "/SF/Language/Menu/RecentFriendInvite" }
}
local mSelectedCategoryId = 1

function IsInputBlocked()
	return v2
end

local function fn5(p)
	if p then
		mMovie:__wf_atom_46a6af3b(p)
	end
end

local function fn6(value, p)
	v12 = value

	if not p then
		v6.mSearchBox:SetText(value or "")
	end

	local v21 = value == nil and "" or " " .. value
	v7:SetText(TitleCase(mMovie:__wf_atom_8e9ac384(v16, false)) .. v21)
end

local function fn7()
	v18.FloatingContent = module5.GetColor(9, true)
	v18.FloatingContentObject = module.ConvertColorNumberToProceduralRGB(v18.FloatingContent)
	v18.FloatingContentHighlight = module5.GetColor(10, true)
	v18.FloatingContentHighlightObject = module.ConvertColorNumberToProceduralRGB(v18.FloatingContentHighlight)
	v18.Content = module5.GetColor(6, true)
	v18.Background1 = module5.GetColor(2, true)
	v18.Background1Object = module.ConvertColorNumberToProceduralRGB(v18.Background1)
	v18.Background3 = module5.GetColor(4, true)
	v18.BackerHighlight = module5.GetColor(1, true)
	v18.Negative = module5.GetColor(12, true)
	mMovie:__wf_atom_e57658c2("Feedback.Label", 44, v18.FloatingContentHighlight)
end

local function fn8()
	local module8 = require("SF.Interface.Components.UserList")
	mMovie:__wf_atom_e57658c2("UserList", 1, 125)
	v6 = module8.Create(getfenv(1), "UserList", "OnInvite", "SortMenu", "SearchBox")
	v6.CLAN = 4
	v6.RECENT = 5
	v6.STEAM = 6
	v6.mKeepTitle = true
	module.PlaySound(_G.UISound_Select)
	module.PlaySound(_G.UISound_WindowOpen)

	function v6:UpdateSelected(data)
		if data and data.mClipName then
			local v21 = not data.Filler and __wf_atom_d99ae0ec(data.User) == v6.mSearchBox.mLowerSearchTerm
			mMovie:__wf_atom_4c1c1986(data.mClipName, "CornerPiece", 12, module.Ternary(v21, 100, 0))
		end
	end

	function v6.mOnSelectedCallback(data)
		if data.mInviteState == v6.InviteState.INVITESENT then
			return
		end

		if __wf_atom_7e8ad928(v8) or v8.Id ~= data.Id or not (Time() - v9 < 0.5) then
			v9 = Time()
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ItemTipSection)
			v8 = data
			fn6(data.User, true)
			v7:SetActive(true)
			mMovie:__wf_atom_50d60589("Feedback.Label", 36, data.User)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("InputField", 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("InputField", 1)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Feedback.Label", 40)
			mMovie:__wf_atom_e57658c2("Feedback", 0, __wf_atom_5e6e15c8 + 8 + __wf_atom_5e6e15c8_3 * 0.5)
			mMovie:__wf_atom_e57658c2("Feedback", 1, __wf_atom_5e6e15c8_2 + 18)
			mMovie:__wf_atom_e57658c2("Feedback", 5, 300)
			mMovie:__wf_atom_e57658c2("Feedback", 6, 300)
			mMovie:__wf_atom_e57658c2("Feedback", 12, 35)
			__wf_atom_ec43d06e(mMovie, "Feedback", 2, { 12, 5, 6 }, { 0, 100, 100 }, 0.4)
		else
			fn2()
			v6.UpdateFocused(data, false)
		end
	end

	function v6:Populate()
		self:RemoveElements(true, true)
		v15.Real = {}
		v15.Tags = {}
		v15.Indexer = {}
		self.mUserCount[self.ONLINE] = 0
		self.mUserCount[self.CLAN] = 0
		self.mUserCount[self.RECENT] = 0
		local users = self:GetUsers()
		local count = 0

		if v6.mCategoryMenu.mSelectedCategoryId == 1 then
			for i = 1, #users do
				__wf_atom_83c14687(0)
				count += 1
				local user = self:BuildUser(users[i], count)
				local online = self.ONLINE

				if user.Status == 9 or user.Status == 0 then
					local _ = user.State == 0

					if user.Status == 9 then
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
				table.insert(v15.Real, { Name = user.User, LowerName = string.lower(user.User) })
				self:AddElement(user, true)
			end
		end

		local __wf_atom_6be84646 = v4:__wf_atom_6be84646()
		local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()

		if v6.mCategoryMenu.mSelectedCategoryId == 2 then
			local recent = self:GetRecent()

			for i = 1, #recent do
				__wf_atom_83c14687(0)
				count += 1
				local user = self:BuildUser(recent[i], count)
				local online = self.ONLINE

				if user.State == 0 then
					online = self.OFFLINE
				end

				local _ = online == self.ONLINE

				if not (user.User ~= __wf_atom_6be84646 and Engine.__wf_atom_940f8971(user.User) == __wf_atom_63bb2bc6) then
					continue
				end

				local crossPlatformUniquePlayerName = module2.GetCrossPlatformUniquePlayerName(
					user.User,
					recent,
					"mDisplayName"
				)
				table.insert(user.Categories, self.RECENT)
				self.mUserCount[self.RECENT] = self.mUserCount[self.RECENT] + 1
				table.insert(v15.Real, {
					Name = crossPlatformUniquePlayerName,
					LowerName = string.lower(user.User)
				})
				user.UniqueName = crossPlatformUniquePlayerName
				self:AddElement(user, true)
			end
		end

		table.sort(v15.Real, function(a, b)
			return a.LowerName < b.LowerName
		end)
		local v21 = nil

		for i = 1, #v15.Real do
			table.insert(v15.Tags, v15.Real[i].LowerName)
			local v22 = string.sub(v15.Tags[i], 1, 1)

			if v22 == v21 then
				continue
			end

			v15.Indexer[v22] = i
			v21 = v22
		end

		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()
		self:RunForAllElements(function(p)
			for i = 1, #__wf_atom_bb46d8b6 do
				if __wf_atom_bb46d8b6[i].onlineId ~= p.AccountId.mId then
					continue
				end

				p.mInviteState = v6.InviteState.INSQUAD
				break
			end
		end)
		self:Redraw(nil, true, true)
	end

	function v6:GetRecent()
		if __wf_atom_7e8ad928(v5) then
			return {}
		end

		return (v5:GetRecent())
	end

	function v6:GetUsers()
		if __wf_atom_7e8ad928(v5) then
			return {}
		end

		return (v5:__wf_atom_0f109cd4())
	end

	v6.mSearchBox._MemberListInputFieldTextChanged = v6.mSearchBox.InputFieldTextChanged

	function v6.mSearchBox:InputFieldTextChanged(p)
		v6.mSearchBox:_MemberListInputFieldTextChanged(p)
		v6.mSearchBox.mLowerSearchTerm = __wf_atom_d99ae0ec(p)
		v6:RunForAllVisibleElements(function(p2)
			v6:UpdateSelected(p2)
		end)
		v7:SetActive(self.mLabel ~= "")
		fn6(p, true)
		v6:Redraw(nil, true, true)
		v3 = true
	end

	v6:SetTitle("/SF/Language/Menu/InvitePanelTitle")
	v6:SetCategories(v20, nil, true)
end

function OnLitePresenceUpdated(_)
	v10 = 1

	if _T.NextLitePresenceResync == nil then
		_T.NextLitePresenceResync = __wf_atom_c4e218a2() + module7.LITE_PRESENCE_RESYNC_INTERVAL
	end

	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module7.RICH_PRESENCE_RESYNC_INTERVAL
	end
end

local function fn9()
	if not __wf_atom_7e8ad928(v5) then
		v5:__wf_atom_bd2c8427("OnLitePresenceUpdated", true)
	end
end

function ResyncLitePresence() end

function OnRichPresenceUpdated(_)
	v10 = 1

	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module7.RICH_PRESENCE_RESYNC_INTERVAL
	end
end

function ResyncRichPresence() end

function CanResyncPresence()
	return false
end

fn2 = function()
	if v2 or __wf_atom_7e8ad928(v5) then
		return
	end

	local user

	if v12 and v12 ~= "" then
		user = v12

		if v8 ~= nil and user == v8.User then
			user = v8.User
		end
	else
		user = ""
	end

	if v8 ~= nil then
		v8.mInviteState = v6.InviteState.INVITESENT
		v6:Redraw(nil, true)
		v8 = nil
	end

	if #user == 0 then
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

	local __wf_atom_746f9d1b = Engine.__wf_atom_746f9d1b(user)
	local invalidNameCharacters = module.GetInvalidNameCharacters(__wf_atom_746f9d1b, v21)

	if invalidNameCharacters ~= 0 then
		module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			user,
			invalidNameCharacters,
			invalidNameCharacters
		))
		return
	end

	local v22 = v11 == nil and module4.CheckGameInvitePermission(nil, user)

	if v22 then
		module.ShowMessage(v22, nil, 0)
		return
	end

	name = user

	if v11 == nil then
		v5:__wf_atom_6a4bcc2b(name, true, "GameInvitePlayerIDResults")
	else
		fn3({ Name = name })
	end
end

function OnInvite()
	fn2()
end

local function fn10(p, p2)
	if v2 or __wf_atom_7e8ad928(v5) or tonumber(p) == 5 then
		return
	end

	v6.mSearchBox:InputFieldTextChanged(p2, true)
	fn2()
end

function InvitePlayer(p, p2)
	fn10(p, p2)
end

function OSKInvitePlayer(p, p2)
	fn10(p and 5 or 0, p2)
end

function OnAddFriend(p, _)
	if p == "true" then
		module.PlaySound(_G.UISound_SweetenerOne)
	end
end

function AddFriend()
	if v2 or __wf_atom_7e8ad928(v5) then
		return
	end

	local user

	if v12 and v12 ~= "" then
		user = v12

		if v8 ~= nil and user == v8.User then
			user = v8.User
		end
	else
		user = ""
	end

	if #user == 0 then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local invalidNameCharacters = module.GetInvalidNameCharacters(user, "[]")
	local v21 = nil
	local v22 = __wf_atom_bb4529ac(user)
	local v23

	if invalidNameCharacters > 0 then
		v23 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
			v22,
			invalidNameCharacters,
			invalidNameCharacters
		)
	else
		v23 = v22 == "" and "/Lotus/Language/Menu/SocialOverlay_EnterUsername"
			or string.lower(v22) == string.lower(__wf_atom_18a5d83b:__wf_atom_6be84646(true))
			and "/Lotus/Language/Menu/SocialOverlay_FriendAddSelfError"
			or v21
	end

	if v23 == nil then
		module3.AddFriend(v22, "OnAddFriend", "")
	else
		module.ShowMessage(v23)
	end
end

local function fn11()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, mMovie:__wf_atom_d5a50cb5())
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, mMovie:__wf_atom_c4f6543f())
end

local function fn12()
	v6.mSpinner:SetActive(false)
	local scrollValue = v6.mScrollBar:GetScrollValue()
	v6:Populate()
	v6.mSortBy = "UserLower"

	if scrollValue ~= nil then
		v6.mScrollBar:SetScrollValue(scrollValue, false)
	end
end

function MouseCatcherPressed() end

function Initialize()
	_T.InvitePanelOpen = true

	if not (gGameRules:IsA(__wf_atom_88d33e05) or gGameRules:__wf_atom_b450ace7()) then
		v17 = true
		gGameRules:__wf_atom_411c9025(true)
	end

	v4 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	assert(not __wf_atom_7e8ad928(v4))
	v5 = v4:__wf_atom_9be88b01()
	fn7()
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)

	if not Engine.__wf_atom_fc67ba71() then
		v13 = __wf_atom_8e4fda44:FindMovie(IMEOverlayMovie)

		if __wf_atom_7e8ad928(v13) and not __wf_atom_7e8ad928(IMEOverlayMovie) then
			v13 = mMovie:PushChildMovie(IMEOverlayMovie)
			flag = true
		end
	end

	mMovie:__wf_atom_976dcedd("MouseCatcherBtn", "noMenuSelection", true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	fn11()
	fn8()
	v6.mSpinner:SetActive(true)
	mMovie:__wf_atom_e57658c2(
		"InviteBtn",
		1,
		mMovie:__wf_atom_5e6e15c8("UserList", 1) + mMovie:__wf_atom_5e6e15c8("UserList", 15) - 75
	)
	local module8 = require("SF.Interface.Components.Button")
	v7 = module8.Create(mMovie, "InviteBtn", v16, "OnInvite", "<MENU_GENERIC1>")
	v7:SetVariant(module8.VARIANTS.SPECIAL_BUTTON)
	v7:SetAnchor(module.CENTER_ALIGNED)
	v7:SetActive(false)
	v7:Redraw()
	v5:__wf_atom_330f71b3("FriendInfoChanged")
	v5:__wf_atom_e391b0d2("RecentPlayersChanged")
	fn9()
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_7df746cd(_G.UIColor_DarkerBrown)
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
	mMovie:__wf_atom_2dedec1a("AddFriendPopup", 13, false)
	mMovie:__wf_atom_e57658c2("AddFriendPopup.Label", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_50d60589(
		"AddFriendPopup.Label",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InvitePanel_NoFriendFound", false)
	)
	mMovie:__wf_atom_c90af43a("AddFriendPopup.Bg", friendPopupBg)
	local v21 = module8.Create(
		mMovie,
		"AddFriendPopup.AddFriendBtn",
		"/SF/Language/Menu/InvitePanel_SendFriendRequest",
		"AddFriend",
		"<MENU_GENERIC1>"
	)
	v21:SetVariant(module8.VARIANTS.SPECIAL_BUTTON)
	v21:SetAnchor(module.CENTER_ALIGNED)
	v21:Redraw()
	v = true
end

function FriendInfoChanged()
	v10 = 1
end

function RecentPlayersChanged(_, _)
	v10 = 1
end

local function fn13()
	local mLabel = v6.mSearchBox.mLabel
	local flag2 = false

	if mLabel == v14 then
		return
	end

	v14 = mLabel
	local v21 = string.lower(mLabel)
	local v22 = ""
	local count = 0
	local v23 = false

	if v21 ~= "" then
		local name2 = ""
		local v24 = string.len(v21)
		local v25 = string.sub(v21, 1, 1)
		local v26 = v15.Indexer[v25]

		if v26 ~= nil then
			for i = v26, #v15.Tags do
				local tag = v15.Tags[i]

				if string.sub(tag, 1, v24) == v21 and name2 ~= v15.Real[i].Name then
					flag2 = true
					v23 = v21 == tag or v23
					name2 = v15.Real[i].Name
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
			v22 ..= v14
		end

		module6.OpenIME(v13)
		module6.IMESetTip(v14, v13)
		module6.IMESetTipCursor(string.len(v14), v13)
		module6.IMESetOptions(v22, v13, false)

		if v23 and module6.IMEGetFocusedIndex() > module6.IMEGetNumOptions(v13) then
			module6.IMESetFocusedOption(1, v13)
		end

		mMovie:__wf_atom_2dedec1a(v6.mSearchBox.mLabelClipName, 87, true)
	else
		module6.IMESetOptions("", v13, false)
		module6.CloseIME(v13)
		mMovie:__wf_atom_2dedec1a(v6.mSearchBox.mLabelClipName, 87, false)
	end
end

local function fn14()
	local imeGetFocusedValue = module6.IMEGetFocusedValue(v13)
	v14 = imeGetFocusedValue
	fn6(imeGetFocusedValue, true)
	mMovie:__wf_atom_e57658c2(v6.mSearchBox.mLabelClipName, 85, (string.len(imeGetFocusedValue)))
	module6.CloseIME(v13)
	module6.IMESetFocusedOption(1, v13)
	mMovie:__wf_atom_2dedec1a(v6.mSearchBox.mLabelClipName, 87, false)
	v6.mSearchBox:Pressed(true)
end

local function fn15(p, mInviteState)
	v6:RunForAllVisibleElements(function(p2)
		if p2.User == p then
			p2.mInviteState = mInviteState
		end
	end)
	v6:Redraw(nil, true)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v then
		return
	end

	local v21 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v21)

	if v10 > 0 then
		total += v21
		v10 -= v21

		if v10 <= 0 or total >= 5 then
			total = 0
			fn12()
		end
	end

	if mSelectedCategoryId ~= v6.mCategoryMenu.mSelectedCategoryId then
		mSelectedCategoryId = v6.mCategoryMenu.mSelectedCategoryId
		v6:Populate()
	end

	if not (__wf_atom_8e4fda44:__wf_atom_084a721a() or __wf_atom_7e8ad928(v13)) then
		if v6.mSearchBox.mSelected then
			if module6.IMEGetAndClearClicked() then
				fn14()
			end

			fn13()
		end

		module6.Update(v13)
	end

	if not v2 and not v6.mSpinner.mActive and v3 then
		v3 = false
		mMovie:__wf_atom_2dedec1a("AddFriendPopup", 13, #v6.mElements == 0)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v6.mSortMenu) then
		v6.mSortMenu:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (v2 or __wf_atom_7e8ad928(v6.mSortMenu)) then
		v6.mSortMenu:SelectElementById(tonumber(p), true)
	end
end

function Shutdown()
	if v6 ~= nil then
		v6:Shutdown()
	end

	if v11 ~= nil then
		_T[v11] = nil
	end

	if not __wf_atom_7e8ad928(gRegion) and not __wf_atom_7e8ad928(gGameRules) and v17 then
		gGameRules:__wf_atom_411c9025(false)
	end

	if not __wf_atom_7e8ad928(v13) then
		if flag then
			v13:Close()
		elseif module6.IsVisible() then
			module6.CloseIME(v13)
		end
	end

	_T.InvitePanelOpen = false
	_T.ScenarioBeaconInvite = false
	_T.gToolTip = nil
end

function MessageReviewed()
	fn5(v6.mSearchBox.mLabelClipName)
end

fn3 = function(data)
	if v11 == nil then
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
			fn15(data.Name, v6.InviteState.INSQUAD)
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

local function fn16(accounts, fn17)
	if not __wf_atom_7e8ad928(v19) then
		v19:Close()
	end

	v19 = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(v19) then
		v2 = true
		v19:Execute("SetTitle", "/Lotus/Language/Chat/PlayerSelection")
		v19:__wf_atom_f62a8704("SetTitleCaseText", { "false", "true" })

		function _T.PlayerSelectionDone(list)
			_T.PlayerSelectionDone = nil
			_T.GetPlayerList = nil
			v2 = false

			if __wf_atom_7e8ad928(list) or list[1] == nil then
				fn17(nil)
			else
				fn17(list[1].mChatMember)
			end
		end

		v19:Execute("SetCallBack", "PlayerSelectionDone")

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

		v19:Execute("SetElementsFunction", "GetPlayerList")
	end
end

function InviteOnSelection(accountId, name2, p)
	local v21 = { Name = name2, AccountId = accountId, Platform = tonumber(p) }
	fn3(v21)
end

local function fn17(data)
	if data == nil then
		return
	end

	mMovie:__wf_atom_f62a8704("InviteOnSelection", { data.AccountId, data.Name, (tostring(data.Platform)) })
end

function GameInvitePlayerIDResults(p, p2)
	name = nil
	local accounts, _ = module2.GetAccountsFromIrcWhoQueryResults(p, p2)

	if #accounts == 0 then
		fn5("")
		module.ShowMessage("/Lotus/Language/Menu/SocialOverlay_NonExistentUserError")
	elseif #accounts > 1 then
		fn16(accounts, fn17)
	else
		fn3(accounts[1])
	end
end

function SendGameInviteCallback(value)
	fn5("")

	if __wf_atom_7e8ad928(_T.ShowNotification) or __wf_atom_7e8ad928(mMovie) then
		print("SendGameInviteCallback: " .. value)
	else
		_T.ShowNotification(value, "SquadMemberInvited")
		fn6()
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/SocialOverlay_GameInviteDeclined",
		false,
		{ PLAYER = "" }
	)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/SocialOverlay_GameInviteOffline",
		false,
		{ PLAYER = "" }
	)

	if string.find(value, __wf_atom_8e9ac384) then
		fn15(value:gsub(__wf_atom_8e9ac384, ""), v6.InviteState.DECLINE)
	elseif string.find(value, __wf_atom_8e9ac384_2) then
		fn15(value:gsub(__wf_atom_8e9ac384_2, ""), nil)
	end

	module.PlaySound(_G.UISound_Select)
	module.PlaySound(_G.UISound_SweetenerOne)
	fn4()
end

function onRawInputEvent(_, value, p)
	if p == "0" and not v2 then
		if string.find(value, "_ENTER") == nil then
			if module6.IsVisible() and (string.find(value, "EN_LEFT") or string.find(value, "EN_RIGHT")) then
				local v21 = tonumber(module6.IMEGetFocusedIndex(v13))
				local ternary = module.Ternary(string.find(value, "EN_LEFT"), -1, 1)
				module6.IMESetFocusedOption(v21 + ternary, v13)
			end
		elseif not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie) then
			if module6.IsVisible() then
				fn14()
			else
				fn2()
			end
		end
	end
end

local function fn18()
	if name ~= nil and v11 ~= nil and not __wf_atom_7e8ad928(_T[v11]) then
		_T[v11](name)
	end

	mMovie:Close()
end

function Close()
	fn18()
end

fn = function()
	v2 = true

	local function fn19(p)
		mMovie:__wf_atom_0cf0fdbe((1 - p) * 0.9)
	end

	if not __wf_atom_7e8ad928(mMovie) then
		__wf_atom_ec43d06e(mMovie, "_root", 1, { 12, 4, fn19 }, { 0, 8000, 1 }, 0.2, 0, fn18)
	end

	module.PlaySound(_G.UISound_WindowClose)
end

function TransitionOut()
	fn()
end

function onKeyDown_MENU_LTRIGGER2()
	if not (v2 or __wf_atom_7e8ad928(v6)) then
		v6:GetActiveCategoryId()
		v6:SetActiveCategoryId(module.Ternary(v6:GetActiveCategoryId() + 1 > #v20, 1, v6:GetActiveCategoryId() + 1))
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (v2 or __wf_atom_7e8ad928(v6)) then
		v6:SetActiveCategoryId(module.Ternary(v6:GetActiveCategoryId() - 1 < 1, #v20, v6:GetActiveCategoryId() - 1))
	end

	return true
end

function onViewportSizeChanged(_, _)
	fn11()
end

function ShowConsoleProfile()
	if v6 == nil then
		return
	end

	local focusedElement = v6:GetFocusedElement()

	if focusedElement ~= nil then
		module3.ViewConsoleProfile(focusedElement.User)
	elseif v8 == nil then
		module.ShowMessage("/Lotus/Language/Menu/ViewGamercardNoSelectedUser")
	else
		module3.ViewConsoleProfile(v8.User)
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
		and v6 ~= nil
		and v6:GetFocusedElement() ~= nil
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
	if not (v2 or __wf_atom_7e8ad928(v6.mScrollBar)) then
		v6.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function SetButtonDesc(p)
	v16 = p

	if v7 ~= nil then
		v7:SetText(v16)
		v7:Redraw()
	end
end

function SetCallback(p)
	v11 = p
end

function SetDefaultName(p)
	fn6(p == nil and "" or p, true)
end

function OnGamepadTransition(p)
	if v7 ~= nil then
		v7:Redraw()
	end

	mMovie:__wf_atom_2004c47f()
end

function SupportsThemes()
	return true
end