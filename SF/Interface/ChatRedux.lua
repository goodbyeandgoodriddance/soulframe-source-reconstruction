mInitChannelInfo = { Set = false, Id = -1 }
mPendingProfileName = nil
local v = {
	zawStoreItem = Resource("/Lotus/StoreItems/Weapons/Ostron/Melee/LotusModularWeapon"),
	ampStoreItem = Resource("/Lotus/StoreItems/Weapons/Sentients/OperatorAmplifiers/OperatorAmpWeapon"),
	moaPetStoreItem = Resource("/Lotus/StoreItems/Types/Friendly/Pets/MoaPets/MoaPetPowerSuit"),
	kdriveStoreItem = Resource("/Lotus/StoreItems/Types/Vehicles/Hoverboard/HoverboardSuit"),
	primaryRifleType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Primary/LotusModularPrimary"),
	primaryShotgunType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Primary/LotusModularPrimaryShotgun"),
	primaryBeamType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Primary/LotusModularPrimaryBeam"),
	primarySniperType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Primary/LotusModularPrimary"),
	primaryLauncherType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Primary/LotusModularPrimary"),
	secondaryRifleType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Secondary/LotusModularSecondary"),
	secondaryBeamType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Secondary/LotusModularSecondaryBeam"),
	secondaryShotgunType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Secondary/LotusModularSecondaryShotgun"),
	secondarySniperType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Secondary/LotusModularSecondary"),
	secondaryLauncherType = Resource("/Lotus/StoreItems/Weapons/SolarisUnited/Secondary/LotusModularSecondary")
}
local v2 = {
	Red = _G.UIColor_Red,
	Green = _G.UIColor_Green,
	Orange = _G.UIColor_Orange,
	Blue = _G.UIColor_Blue,
	Purple = 7690684,
	LightYellow = _G.UIColor_LightYellow,
	BlueGreen = _G.UIColor_BlueGreen,
	USERLIST_ROW_COLOR = _G.UIColor_Yellow,
	TAB_DECO_LINE_COLOR = 8298979,
	ChatNameColor = _G.UIColor_Orange,
	ChatMessageColor = _G.UIColor_Tan
}
local UIColor_DarkerBrown = _G.UIColor_DarkerBrown
local UIColor_White = _G.UIColor_White
local v3 = {
	SPAM_DETECTION_PERIOD = 5,
	MSGS_PER_PERIOD = 5,
	SPAM_LOCKOUT_TIME = 30,
	TRADE_SPAM_DETECTION_PERIOD = 120,
	TRADE_MSGS_PER_PERIOD = 1,
	SPAM_REPEATED_MESSAGE_DETECTION_PERIOD = 120,
	GLOBAL_LINK_PERIOD = 15,
	DEFAULT_BREAK_MSG_PERIOD = 3600
}
local DEFAULT_BREAK_MSG_PERIOD = nil
local v4 = {
	MIN_ALPHA = 10,
	MAX_ALPHA = 125,
	FADE_DURATION = 0.5,
	timer = 0.5,
	dir = -1
}
local v5 = { Text = nil, From = nil }
local user2 = nil
local v6 = 1
local v7 = {
	"-",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"_",
	"[",
	"]",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z"
}
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CrossPlatformUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIUtilities")
local module5 = require("Lotus.Interface.CardUtilitiesRedux")
local module6 = require("Lotus.Interface.LotusNetworkUtilities")
local module7 = require("Lotus.Interface.SequencerUtilities")
local module8 = require("Lotus.Interface.ModularWeaponUtilities")
local module9 = require("Lotus.Interface.UIStyleUtilities")
local module10 = require("SF.Scripts.Libs.StatsLib")
local module11 = require("Lotus.Interface.Libs.PreviewLinkUtilities")
local module12 = require("Lotus.Interface.Components.PresenceHelper")
local module13 = require("SF.Interface.SFUtilities")
local module14 = require("EE.Interface.Components.List")
require("EE.Interface.Components.ScrollBar")
local module15 = require("Lotus.Interface.TextSuggest")
mInputBlocked = true
mInSubScreen = false
mInitialized = false
mSelectedUser = nil
mInvitedUser = nil
mGameData = nil
mProfileSettings = nil
mMouseDown = false
mFocusTabDownStart = nil
mWindow = nil
mGameRules = nil
mIsInGameplay = nil
mIsInFrontEnd = nil
mIsInDojo = nil
mIsInPVP = nil
mUIMode = nil
mEnableRegionChat = false
mEnableRecruitingChat = false
mEnableTradeChat = false
mEnableQAChat = false
mEnableCouncilChat = false
mChatWorldNotifications = true
mEmojiSettings = { Enabled = true, EmoticonConversion = true }
mChatScale = 1
miOSChatScale = 1.75
mContextMenu = nil
mChildMovie = nil
mViewportWidth = 0
mViewportHeight = 0
mDoFilter = true
mDoMotdFilter = true
mTextSizeIndex = 2
mInlinePrivateMessages = true
mActiveTabNotificationsOnly = false
mMuteNotificationSounds = false
mChatHidden = false
mExpandCalloutOffsetX = 0
mExpandCalloutOffsetY = 0
mCrossPlatformEnabled = false
local elementById = nil
local v8 = {
	Msg = "",
	CurrItemString = "",
	OmegaLinks = {},
	SongLinks = {},
	ZawLinks = {},
	AmpLinks = {},
	MoaPetLinks = {},
	KdriveLinks = {},
	KitgunLinks = {},
	AppearanceLinks = {},
	CachedAppearanceLink = nil,
	ModConfigLinks = {},
	CachedModConfigLink = nil,
	ShawzinLinks = {},
	CachedShawzinLink = nil,
	GuildReplacement = false
}

local function fn()
	local gGameData2 = nil

	if __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			gGameData2 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		end
	else
		gGameData2 = gGameData
	end

	return not __wf_atom_7e8ad928(gGameData2)
		and gGameData2:__wf_atom_24908c96()
		and gGameData2:__wf_atom_a04e4a53() >= 30
end

local v9 = {
	truemaster = { RequirementsMet = fn },
	truemasteralt = { RequirementsMet = fn }
}
CALLBACK_IDENTIFIER = Symbol("ChatRedux")
mCompletedFirstWorldSync = false
local v10 = {}
local v11 = {}
local v12 = {}
local v13 = {}
local v14 = {
	ALERT = 0,
	NEWS = 1,
	GOAL = 2,
	INVASION = 3,
	BUILD = 4,
	PVPAFFECTOR = 5
}
local v15 = {
	OMEGA_STRING_LOC = "/Lotus/Language/Items/OmegaModGenericName",
	OMEGA_TYPE_PREFIX = "/Lotus/Upgrades/Mods/Randomized/",
	OMEGA_STOREITEM_PREFIX = "/Lotus/StoreItems/Upgrades/Mods/Randomized/",
	OMEGA_MAX_LINKS = 5,
	STEP_SEQUENCER_NOTEPACK_PREFIX = "/Lotus/Types/Game/NotePacks/",
	STEP_SEQUENCER_STRING_LOC = "/Lotus/Language/Menu/Composition_Song",
	STEP_SEQUENCER_STRING_PREFIX = "/Lotus/Language/Menu/Composition_Song_Prefix",
	STEP_SEQUENCER_PREVIEW = WeakResource("/Lotus/Types/StoreItems/Packages/StepSequencerPreview"),
	STEP_SEQUENCER_MAX_LINKS = 1,
	StepSequencerPrefixString = "",
	StepSequencerPendingRequest = nil,
	StepSequencerLoader = nil,
	ZAW_STRING_LOC = "/Lotus/Language/Weapons/LotusModularWeaponName",
	ZAW_STRING_PREFIX = "/Lotus/Language/Menu/Chat_Zaw_Link_Prefix",
	ZAW_MAX_LINKS = 3,
	ZawPrefixString = "",
	AMP_STRING_LOC = "/Lotus/Language/Items/OperatorVoidBeam",
	AMP_STRING_PREFIX = "/Lotus/Language/Menu/Chat_Amp_Link_Prefix",
	AMP_MAX_LINKS = 3,
	AmpPrefixString = "",
	MOA_PET_STRING_LOC = "/Lotus/Language/SolarisVenus/MoaPetItem",
	MOA_PET_STRING_PREFIX = "/Lotus/Language/SolarisVenus/Chat_Moa_Pet_Link_Prefix",
	MOA_MAX_LINKS = 4,
	MoaPetPrefixString = "",
	KDRIVE_STRING_LOC = "/Lotus/Language/SolarisVenus/KDriveItem",
	KDRIVE_STRING_PREFIX = "/Lotus/Language/SolarisVenus/Chat_KDrive_Link_Prefix",
	KDRIVE_MAX_LINKS = 4,
	KDrivePrefixString = "",
	KITGUN_STRING_LOC = "/Lotus/Language/SolarisVenus/Kitgun_Singular",
	KITGUN_STRING_PREFIX = "/Lotus/Language/SolarisVenus/Chat_Kitgun_Link_Prefix",
	KITGUN_MAX_LINKS = 3,
	KitgunPrefixString = "",
	APPEARANCE_STRING_LOC = "/Lotus/Language/Menu/Appearance_Prefix",
	APPEARANCE_STRING_PREFIX = "/Lotus/Language/Menu/Appearance_Prefix",
	APPEARANCE_MAX_LINKS = 1,
	AppearancePrefixString = "",
	MOD_CONFIG_STRING_LOC = "/Lotus/Language/Menu/Mod_Prefix",
	MOD_CONFIG_STRING_PREFIX = "/Lotus/Language/Menu/Mod_Prefix",
	MOD_CONFIG_MAX_LINKS = 1,
	ModConfigPrefixString = "",
	SHAWZIN_STRING_LOC = "/Lotus/Language/Menu/Shawzin_Prefix",
	SHAWZIN_STRING_PREFIX = "/Lotus/Language/Menu/Shawzin_Prefix",
	SHAWZIN_MAX_LINKS = 1,
	ShawzinPrefixString = ""
}
local v16 = "[] "
local v17 = nil
local v18 = nil
local v19 = {}
local v20 = {}
local v21 = nil
local v22 = {}
local v23 = nil
local v24 = false
local v25 = 3
local v26 = false
local v27 = false
local v28 = false
local v29 = false
local v30 = nil
local v31 = nil
local v32 = {
	InProgress = false,
	PlayerId = nil,
	PlayerName = "",
	TempAddToChatPartners = false,
	PendingRequestName = ""
}
local mInvitedUser2 = nil
local v34 = {}
local v35 = 1
local fn2
local fn3
local fn4
local fn5
local fn6
local fn7
local fn8
local fn9
local fn10
local mCachedAllianceMotd = ""
local mCachedGuildMotd = ""
local v38 = 0
local flag = false
local v39 = false
local v40 = ""
local decrement = 0
local v41 = 0
local v42 = false
local v43 = { ResizingWindow = false, RefreshChatHistoryCooldown = 0, ResizeRequired = false }
local v44 = nil
local v45 = nil
local v46 = nil
local v47 = nil
local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
local v48 = false
local v49 = nil
local v50 = false
local v51 = false
mPendingAddFriendMessage = ""
local v52 = {
	CHANNEL_SESSION = 0,
	CHANNEL_HUB = 1,
	CHANNEL_CLAN = 2,
	CHANNEL_ALLIANCE = 3,
	CHANNEL_COUNCIL = 4,
	CHANNEL_GLOBAL = 5,
	CHANNEL_QA = 6,
	CHANNEL_RECRUITING = 7,
	CHANNEL_TRADE = 8,
	CHANNEL_PRIVATE_CHAT = 9
}

local function fn11()
	for k, v53 in pairs(v52) do
		if v53 == mWindow:GetActivePanel().mChannelType then
			return k
		end
	end

	return nil
end

function IsInputBlocked()
	return mInputBlocked
end

local function fn12()
	v5.Text = nil
	v5.From = nil
end

local function fn13(value, p)
	while true do
		local v53 = false

		for k in string.gmatch(value, "%[([^%[^%]]-)%]") do
			local v54 = k:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
			local v55

			if p or k == "" or __wf_atom_7e8ad928(nil) or (nil):__wf_atom_ce963400(k, true) == "" then
				v55 = k:gsub("%%", "%%%0")
				v53 = true
			else
				v55 = "[" .. TitleCase(k) .. "]"
			end

			value = string.gsub(value, "%[" .. v54 .. "%]", v55)
		end

		if not v53 then
			return value
		end
	end
end

local function fn14()
	if not __wf_atom_7e8ad928(mGameData) then
		local message = mGameData:__wf_atom_664d8613().message
		local __wf_atom_f1ec36d3 = mGameData:__wf_atom_f1ec36d3()

		if mDoMotdFilter then
			message = __wf_atom_f8f86fc5(message, 0)
			__wf_atom_f1ec36d3 = __wf_atom_f8f86fc5(__wf_atom_f1ec36d3, 0)
		end

		mCachedAllianceMotd = fn13(message)
		mCachedGuildMotd = fn13(__wf_atom_f1ec36d3)
	end
end

local function fn15(value)
	if __wf_atom_b953295d():c_str() ~= "_en" then
		return ""
	end

	local v53

	if Engine.__wf_atom_fc67ba71() then
		local v54 = string.gsub(value, "_EAST$", "")
		v53 = string.gsub(v54, "_WEST$", "")
	else
		local v54 = string.gsub(value, "_EAST$", "_E")
		v53 = string.gsub(v54, "_WEST$", "_W")
	end

	local v54 = string.gsub(v53, "NORTH_AMERICA", "NA")
	local v55 = string.gsub(v54, "SOUTH_AMERICA", "SA")
	local v56 = string.gsub(v55, "OCEANIA", "AS")
	local v57 = string.gsub(v56, "SOUTH_AMERICA", "SA")

	if not string.find(v57, "_") and string.len(v57) > 2 then
		v57 = string.sub(v57, 1, 2)
	end

	return "_" .. v57
end

local function fn16()
	return __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		and not __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_51613fe5()
end

local function fn17(p, p2)
	local __wf_atom_449cc668 = gClient:__wf_atom_449cc668()

	if __wf_atom_449cc668 and mWindow then
		local activePanel = mWindow:GetActivePanel()

		if not __wf_atom_7e8ad928(activePanel) then
			local v53 = __wf_atom_7e8ad928(p2) and {} or p2
			activePanel:_onLineAdded(mMovie:__wf_atom_8e9ac384(p, false, v53), activePanel.MESSAGE_TYPE_SYSTEM, "")
		end
	end

	return __wf_atom_449cc668
end

function SystemMessage(p)
	if __wf_atom_7e8ad928(mWindow) then
		return
	end

	mWindow:SystemMessage(p)
end

function ChannelSystemMessage(p, p2)
	if __wf_atom_7e8ad928(mWindow) then
		return
	end

	mWindow:ChannelSystemMessage(p, (tonumber(p2)))
end

function ChannelNotificationMessage(p, p2)
	if __wf_atom_7e8ad928(mWindow) then
		return
	end

	mWindow:ChannelNotificationMessage(p, (tonumber(p2)))
end

local function fn18()
	local v53 = false
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(__wf_atom_7190444e)) then
		local activePanel = mWindow:GetActivePanel()
		return not __wf_atom_7e8ad928(activePanel)
			and __wf_atom_7190444e:__wf_atom_f5faa72a("#" .. activePanel.mChannelName)
			and true
			or false
	end

	return v53
end

local function fn19(value)
	if not fn18() then
		return
	end

	if
		value:find("%[OMG%-.*%]")
		or value:find("%[SONG%-.*%]")
		or value:find("%[ZAW%-.*%]")
		or value:find("%[AMP%-.*%]")
		or value:find("%[MOA%-.*%]")
		or value:find("%[KDR%-.*%]")
		or value:find("%[KIT%-.*%]")
		or value:find("%[FF%-.*%]")
		or value:find("%[MOD%-.*%]")
		or value:find("%[SHZN%-.*%]")
		or value:find("{GUILD=.*}")
	then
		return
	end

	if #v34 >= 20 then
		table.remove(v34, 1)
	end

	if #v34 > 0 and string.lower(v34[#v34]) == string.lower(value) then
		return
	end

	table.insert(v34, value)
	v35 = #v34 + 1
end

local function fn20(ternary)
	if #v34 == 0 or not fn18() or v35 > #v34 and ternary > 0 then
		return
	end

	local v53 = __wf_atom_421b01aa(v35 + ternary, 1, #v34 + 1)

	if v53 ~= v35 then
		v35 = v53
		local ternary2 = module.Ternary(#v34 < v53, "", v34[v35])
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 36, ternary2)
		local v54 = string.len(ternary2)
		mMovie:__wf_atom_e57658c2("Window.SendMessageBar.MessageBox", 85, v54)
	end
end

local function fn21(p, p2, p3, p4)
	if p3 == 1 then
		module.ShowMessage(p)
	elseif p4 then
		module.ShowYesOrNoMessage(p, p2)
	else
		module.ShowConfirmMessage(p, p2)
	end
end

local function fn22(p, p2, p3, p4)
	mContextMenu.mLongestElement = 0
	mContextMenu:Redraw(p3, p4)

	for i = 1, mContextMenu:GetHowManyElements() do
		local elementInIndex = mContextMenu:GetElementInIndex(i)

		if not (__wf_atom_7e8ad928(elementInIndex) or __wf_atom_7e8ad928(elementInIndex.Button)) then
			elementInIndex.Button:SetWidth(mContextMenu.mLongestElement + 20)
		end
	end

	local v53 = mContextMenu.mLongestElement + 40
	local v54 = mContextMenu:GetHowManyElements() * mContextMenu.mForcedVerticalSeparation + 22
	mMovie:__wf_atom_e57658c2("ContextMenu.Bg", 14, v53)
	mMovie:__wf_atom_e57658c2("ContextMenu.Bg", 15, v54)
	mMovie:__wf_atom_e57658c2("ContextMenu.Bg", 12, 0)

	if p2 + v54 >= mViewportHeight then
		p2 -= v54
	end

	mMovie:__wf_atom_e57658c2("ContextMenu", 0, p)
	mMovie:__wf_atom_e57658c2("ContextMenu", 1, p2)
end

local function fn23(p, p2)
	if _G.StalkerMode then
		return
	end

	mMovie:__wf_atom_2dedec1a("ContextMenu", 67, true)
	mMovie:__wf_atom_2dedec1a("ContextMenu", 13, true)

	if Engine.__wf_atom_2a979d69() then
		local v53 = mWindow.mUserPanel.mClipPath .. ".Panel.UserList"
		local v54 = mMovie:__wf_atom_5e6e15c8(v53, 0) + mMovie:__wf_atom_5e6e15c8(v53, 14)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v53, 1)
		p, p2 = module.TransformPositionToGlobal(mMovie, v53, v54, __wf_atom_5e6e15c8)
	elseif __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		p = mMovie:__wf_atom_5e6e15c8("_root", 30) + 4
		p2 = mMovie:__wf_atom_5e6e15c8("_root", 31) - 4
	end

	mMovie:__wf_atom_976dcedd("Window", "noMenuSelection", true)
	fn22(p, p2, nil, true)

	if
		Engine.__wf_atom_4078373f()
		and mContextMenu:GetHowManyElements() >= 1
		and not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel))
	then
		mWindow.mUserPanel:UpdateListFocus()
	end
end

local function fn24()
	mMovie:__wf_atom_2dedec1a("ContextMenu", 67, false)
	mMovie:__wf_atom_2dedec1a("ContextMenu", 13, false)
	mMovie:__wf_atom_976dcedd("Window", "noMenuSelection", false)

	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel) or __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl)) then
		local focusedElement = mWindow.mUserPanel.mListControl:GetFocusedElement()

		if __wf_atom_7e8ad928(mWindow.mUserPanel.mStoredUserFocusId) and not __wf_atom_7e8ad928(focusedElement) then
			mWindow.mUserPanel.mListControl:UnfocusElementById(focusedElement.Id)
		elseif
			not __wf_atom_7e8ad928(mWindow.mUserPanel.mStoredUserFocusId)
			and (__wf_atom_7e8ad928(focusedElement) or mWindow.mUserPanel.mStoredUserFocusId ~= focusedElement.Id)
		then
			mWindow.mUserPanel.mListControl:FocusElementById(mWindow.mUserPanel.mStoredUserFocusId)
		end
	end
end

local function fn25()
	local imeGetFocusedValue = module15.IMEGetFocusedValue(v18)
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36)
	local v53 = v40
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mWindow.mInputPanel.mClipPath .. ".MessageBox", 85)
	local v54 = __wf_atom_875c8d7a(__wf_atom_387f260e, __wf_atom_5e6e15c8)
	local v55 = string.sub(__wf_atom_387f260e, 0, v54 - string.len(v53))
	local v56 = string.sub(__wf_atom_387f260e, v54 + 1)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Whitespace", false)
	local v57 = __wf_atom_8e9ac384 == "-" and "" or __wf_atom_8e9ac384

	if string.sub(imeGetFocusedValue, 1, 1) == "@" and string.find(imeGetFocusedValue, " ") then
		imeGetFocusedValue = "@\"" .. string.sub(imeGetFocusedValue, 2) .. "\""
	end

	local v58 = v55 .. imeGetFocusedValue .. v57 .. v56
	mMovie:__wf_atom_50d60589(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36, v58)
	module15.CloseIME(v18)
	mMovie:__wf_atom_46a6af3b(mWindow.mInputPanel.mClipPath .. ".MessageBox")
	mWindow.mInputPanel:SetFocus(true)
	mMovie:__wf_atom_4c1c1986(
		mWindow.mInputPanel.mClipPath,
		"MessageBox",
		85,
		__wf_atom_5e6e15c8 + (string.len(imeGetFocusedValue) - string.len(v53) + string.len(v57))
	)
	mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
	module15.IMESetFocusedOption(1, v18)
	flag = false
	v39 = false
end

function MouseCatcherPressed(_) end

function WindowTitlePress()
	if not (__wf_atom_7e8ad928(mWindow) or mInputBlocked) then
		mWindow:OnWindowTitlePress()
	end
end

function WindowTitleRelease()
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:OnWindowTitleRelease()
	end
end

function WindowTitleRollOver()
	if not (__wf_atom_7e8ad928(mWindow) or mInputBlocked) then
		mWindow:OnWindowTitleRollOver()
	end
end

function WindowTitleRollOut()
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:OnWindowTitleRollOut()
	end
end

function BottomResizePress()
	if mWindow ~= nil and not mInputBlocked then
		mWindow:OnResizePress(mWindow.mBottomResizeClipName)
	end
end

function BottomResizeRelease()
	if mWindow ~= nil then
		mWindow:OnResizeRelease(mWindow.mBottomResizeClipName)
	end
end

function BottomResizeRollOver()
	if mWindow ~= nil and not mInputBlocked then
		mWindow:OnResizeRollOver(mWindow.mBottomResizeClipName)
	end
end

function BottomResizeRollOut()
	if mWindow ~= nil then
		mWindow:OnResizeRollOut(mWindow.mBottomResizeClipName)
	end
end

function TopResizePressed()
	if mWindow ~= nil and not mInputBlocked then
		mWindow:OnResizePress(mWindow.mTopResizeClipName)
	end
end

function TopResizeRelease()
	if mWindow ~= nil then
		mWindow:OnResizeRelease(mWindow.mTopResizeClipName)
	end
end

function TopResizeRollOver()
	if mWindow ~= nil and not mInputBlocked then
		mWindow:OnResizeRollOver(mWindow.mTopResizeClipName)
	end
end

function TopResizeRollOut()
	if mWindow ~= nil then
		mWindow:OnResizeRollOut(mWindow.mTopResizeClipName)
	end
end

function Global_onRelease()
	local _ = mWindow == nil
end

function UserLineRollOver(p)
	if
		__wf_atom_7e8ad928(mWindow)
		or mInputBlocked
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl)
	then
		return
	end

	mWindow.mUserPanel.mStoredUserFocusId = tonumber(p)

	if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
		return
	end

	mWindow.mUserPanel.mListControl:FocusElementById(tonumber(p), true)
end

function UserLineRollOut(p)
	if
		__wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl)
	then
		return
	end

	mWindow.mUserPanel.mStoredUserFocusId = nil

	if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
		return
	end

	mWindow.mUserPanel.mListControl:UnfocusElementById((tonumber(p)))
end

function UserLinePressed(p)
	if
		__wf_atom_7e8ad928(mWindow)
		or mInputBlocked
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl)
		or mMovie:__wf_atom_a91463a8("ContextMenu", 67)
	then
		return
	end

	mWindow.mUserPanel.mListControl:SelectElementById((tonumber(p)))
end

function EmoteRollOver(p)
	if
		__wf_atom_7e8ad928(mWindow)
		or mInputBlocked
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mEmoteGrid)
	then
		return
	end

	mWindow.mUserPanel.mEmoteGrid:FocusElementById((tonumber(p)))
end

function EmoteRollOut(p)
	if
		__wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mEmoteGrid)
	then
		return
	end

	mWindow.mUserPanel.mEmoteGrid:UnfocusElementById((tonumber(p)))
end

function EmotePressed(p)
	if __wf_atom_7e8ad928(mWindow) or mInputBlocked or __wf_atom_7e8ad928(mWindow.mUserPanel) then
		return
	end

	mWindow.mUserPanel.mEmoteGrid:SelectElementById((tonumber(p)))
	module.PlaySound(_G.UISound_ItemTipSection)
end

local function fn26(p)
	local v53 = mWindow._getPrivateChatChannelPrefix() .. p

	for _, v54 in pairs(mWindow.mPanelList) do
		if v54 ~= nil and v54.mChannelName == v53 then
			return v54
		end
	end

	return nil
end

local function fn27(value, p, p2)
	local crossPlatformUniquePlayerName = module2.GetCrossPlatformUniquePlayerName(
		value,
		mWindow.mPrivateChatPartners,
		nil,
		nil,
		true
	)
	local mNextPrivateChatId = mWindow.mNextPrivateChatId
	local v53 = "#" .. mWindow._getPrivateChatChannelPrefix() .. value
	local v54 = mWindow:OnChannelStateChanged(
		mWindow.CHANNEL_ENTER,
		v53,
		crossPlatformUniquePlayerName,
		mNextPrivateChatId
	)

	if not __wf_atom_7e8ad928(mGameData) then
		if p2 == nil then
			p2 = false
		end

		v54.mHasAccount = mGameData:__wf_atom_72bffca2(crossPlatformUniquePlayerName, p, p2)
	end

	mWindow.mNextPrivateChatId = mWindow.mNextPrivateChatId + 1
	mWindow.mPrivateChatPartners[string.lower(value)] = crossPlatformUniquePlayerName
	return v54
end

local function fn28(p, p2, p3, p4)
	local v53 = fn26(p)

	if __wf_atom_7e8ad928(v53) and not p4 then
		return (fn27(p, p2, p3))
	end

	return v53
end

local function fn29(name, accountId, isCrossSave)
	local v53 = fn28(name, accountId, isCrossSave, true)
	local flag2 = true

	if __wf_atom_7e8ad928(v53) then
		if not __wf_atom_7e8ad928(mGameData) then
			if accountId == __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e75653c3() then
				mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CannotWhisperSelf", false))
				return false
			end

			if not flag2 then
				local v54 = { mGameData:__wf_atom_0f109cd4(), mGameData:__wf_atom_ca48a66f(), mGameData:GetRecent() }

				for i = 1, #v54 do
					local v55 = v54[i]

					for j = 1, #v55 do
						if not (v55[j].mDisplayName == name and v55[j].mStatus == 0) then
							continue
						end

						flag2 = true
						break
					end

					if flag2 then
						break
					end
				end
			end
		end

		if flag2 then
			v53 = fn27(name, accountId, isCrossSave)
		else
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_InitiatePMFailed", false))
		end
	end

	if not __wf_atom_7e8ad928(v53) then
		mWindow:SetActive(v53)
	end

	return flag2
end

local function fn30(p)
	for i = 0, 4 do
		if module4.UTF8(57344 + i) == p then
			return true
		end
	end

	return false
end

local function fn31()
	if
		Engine.IsPlayingWithController()
		and not __wf_atom_7e8ad928(_T.ForegroundMovie)
		and _T.CanShowPlayTypeDropDown
	then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "true")
	end

	_T.gToolTip = nil
	mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_SIMPLE)
	fn24()

	if Engine.__wf_atom_2a979d69() then
		if _T.TopMenuOpen then
			mUIMode = module3.GetUIMode()

			if mUIMode == module3.UI_MODE_IN_SPACE_SHIP then
				mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 0, -50)
				mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 1, 30)
			else
				mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 0, -185)
				mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 1, 30.5)
			end
		end

		if _T.UIInputEnabled and not _T.TopMenuOpen then
			mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 0, -80)
			mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 1, 30)
		end

		UpdateExpandCalloutPos()
	end
end

local function fn32(p)
	if __wf_atom_7e8ad928(gRegion) then
		return true
	end

	if p == module3.HIDDEN_PLAYER_NAME then
		return false
	end

	if
		mUIMode ~= module3.UI_MODE_IN_GAME
		or __wf_atom_7e8ad928(gGameRules)
		or not gGameRules:IsA(__wf_atom_88d33e05)
		or gGameRules:IsA(__wf_atom_3066d015)
	then
		return true
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) or __wf_atom_eab484a7:__wf_atom_8537d7d4() == 255 then
		return true
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, #__wf_atom_3c8e1a7a do
		local v54 = __wf_atom_3c8e1a7a[i]

		if v54:__wf_atom_6be84646() == p then
			return v54:__wf_atom_8537d7d4() == __wf_atom_eab484a7:__wf_atom_8537d7d4() or _T.PvpMode and _T.PvpMode == 3
		end
	end

	return false
end

function ConfirmWeaponRetrieve(p)
	if tonumber(p) == 4 then
		_T.gOpenWeaponRecoveryMission()
	end
end

function MinimizeButton()
	if not mInputBlocked then
		fn31()
	end
end

local function fn33()
	return mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE
end

function IsMinimized()
	return fn33()
end

local function fn34(mParent, mClipName)
	return {
		mParent = mParent,
		mWindow = {},
		mClipName = mClipName,
		mClipParent = mParent.mClipName,
		mClipPath = mParent.mClipName .. "." .. mClipName,
		["mListControl"] = nil,
		mStoredUserFocusId = nil,
		mUserLocator = nil,
		mIsExpanded = false,
		mUserListInterpolating = false,
		Initialize = function(self, p, p2)
			self.mWindow.x = 0
			self.mWindow.ReverseX = true
			self.mWindow.y = 0
			self.mWindow.width = 194
			self.mWindow.height = 27
			self.mWindow.ReverseHeight = true
			local list = module14.CreateList(mMovie, self.mClipPath .. ".Panel.UserList.User1")
			list:SetCallbacks(
				"UserLinePressed",
				"UserLineRollOver",
				"UserLineRollOut",
				nil,
				nil,
				nil,
				"UserLineRollOut"
			)
			list.mElementTransitionTime = 0

			function list:setTextColour(p3, p4)
				if p3 == nil then
					return
				end

				local uiColor_Gold = _G.UIColor_Gold
				local v53

				if p4 then
					v53 = _G.UIColor_Yellow
				else
					v53 = not __wf_atom_7e8ad928(mGameData) and mGameData:__wf_atom_56f280e3(p3.User) and 6710886
						or uiColor_Gold
				end

				mMovie:__wf_atom_4c1c1986(p3.mClipName, "Name", 44, v53)
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".Panel.UserList.User1.Name", 50)
			self.mListControl = list
			self.mListControl.mVisibleElements = 10
			self.mListControl.mForcedVerticalSeparation = math.ceil(__wf_atom_5e6e15c8 * 1.2)
			self.mListControl.mIsVisible = false

			function self.mListControl:OnElementTransitionStarted(p3)
				mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, false)
				self.mDrawnElements += 1
				p3.mDrawnIndex = self.mDrawnElements
				mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, false)
			end

			function self.mListControl.OnElementTransitionEnded(_, p3)
				if p3 and p3.mClipName then
					v17:AddTimer(0.1, function()
						if p3 and p3.mClipName then
							mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, true)
						end
					end, false, nil)
				end
			end

			function self.mListControl.ToggleFocus(object, p3, p4)
				local v53 = self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_GAMEPLAY_SIMPLE
				local v54 = object.mIsVisible
					and not (self.mUserLocator.mIsExpanded or mMovie:__wf_atom_a91463a8("ContextMenu", 13))
				mMovie:__wf_atom_7f57ab2f(
					p3.mClipName,
					"Callout",
					13,
					Engine.IsPlayingWithController() and p4 and v54 and v53 and p3.User ~= mWindow.mUser
				)
				object:setTextColour(p3, p4)
			end

			function self.mListControl.mElementDrawCallback(data)
				if data == nil or data.mClipName == nil then
					return
				end

				local user = data.User

				if data.DisplayName ~= nil then
					user = data.DisplayName
				end

				module.SetFittedText(mMovie, data.mClipName .. ".Name", user, "...")

				if self.mParent.mFontName ~= nil then
					mMovie:__wf_atom_48bd5a59(data.mClipName, "Name", 49, "Spectral SC")
				end

				local focusedElement = self.mListControl:GetFocusedElement()
				self.mListControl:ToggleFocus(data, not __wf_atom_7e8ad928(focusedElement) and focusedElement == data)
				mMovie:__wf_atom_7d7314f1(data.mClipName .. ".Callout.Tf.text", "<MENU_SELECT>")
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg", 13, data.mDrawnIndex % 2 ~= 0)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 0)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, v2.USERLIST_ROW_COLOR)
			end

			function self.mListControl.mOnFocusedCallback(p3)
				if p3 == nil or p3.mClipName == nil then
					return
				end

				self.mListControl:ToggleFocus(p3, true)
			end

			function self.mListControl.mOnUnfocusedCallback(p3)
				if p3 == nil or p3.mClipName == nil then
					return
				end

				_T.gToolTip = nil
				self.mListControl:ToggleFocus(p3, false)
			end

			function self.mListControl.mOnSelectedCallback(p3)
				if p3 == nil or p3.AccountId == nil then
				end
			end

			self.mListControl._ListControl_Redraw = self.mListControl.Redraw

			function self.mListControl:Redraw(p3, p4, p5)
				self.mDrawnElements = 0
				self:_ListControl_Redraw(p3, p4, p5)

				if not p4 then
					self.mDrawnElements = 0
					self:RunForAllVisibleElements(function(state)
						self.mDrawnElements += 1
						state.mDrawnIndex = self.mDrawnElements
						mMovie:__wf_atom_7f57ab2f(state.mClipName, "Btn", 67, true)
						mMovie:__wf_atom_7f57ab2f(state.mClipName, "Bg", 13, state.mDrawnIndex % 2 ~= 0)
					end)
				end

				local count = #self.mElements
				local v53 = self.mVisibleElements / count
				self.mScrollBar.mScrollStep = 1 / (count - self.mVisibleElements)
				self.mScrollBar:SetVisibleProp(v53, true)
			end

			local module16 = require("SF.Interface.Components.Scrollbar")
			local scrollBar = module16.CreateScrollBar(getfenv(1), self.mClipPath .. ".Panel.UserList.ScrollBar", {
				mEnableSmoothScroll = false
			})

			function scrollBar.mScrollValueChangedCallback(p3, _)
				local v53 = #self.mListControl.mElements - self.mListControl.mVisibleElements
				local v54 = __wf_atom_421b01aa(module.Round(v53 * p3) + 1, 0, v53 + 1)
				self.mListControl:SetScroll(v54)
			end

			self.mListControl.mScrollBar = scrollBar
			self.mListControl.mScrollAlwaysVisible = true

			if Engine.__wf_atom_2a979d69() then
				self.mListControl:EnableDragScrolling()
				self.mListControl:EnableSmoothScroll()
				self.mListControl:SetScroll(1, true)
			end

			function self.mListControl.mScrollBar.mScrubStopDragCallback()
				local v53 = list:GetHowManyElements() - list.mVisibleElements
				local v54 = __wf_atom_421b01aa(module.Round(v53 * self.mListControl.mScrollBar.mCurrentScroll), 0, v53) / v53

				if v54 ~= self.mListControl.mScrollBar.mCurrentScroll then
					self.mListControl.mScrollBar:SetScrollValue(v54)
				end
			end

			local module17 = require("EE.Interface.Components.Grid")
			self.mUserLocator = module17.CreateGrid(mMovie, self.mClipPath .. ".AlphabetIndex.Grid.Element", nil, 5, 6)
			self.mUserLocator:SetCallbacks(
				"AlphabetIndexPressed",
				"AlphabetIndexRollOver",
				"AlphabetIndexRollOut",
				nil,
				nil,
				nil,
				"AlphabetIndexRollOut"
			)
			self.mUserLocator.mIsExpanded = false
			self.mUserLocator.mColumnSeparation = 15
			self.mUserLocator.mRowSeparation = 15
			self.mUserLocator.mGridWidth = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".AlphabetIndex.Grid.Bg", 14) + 1

			function self.mUserLocator.ToggleExpanded(p3)
				p3.mIsExpanded = not p3.mIsExpanded
				mWindow:SetPosition(mWindow.mWindow.x, mWindow.mWindow.y)
				mMovie:__wf_atom_e57658c2(
					"Window.UserPanel.Panel.LocatorBtn.Arrow",
					16,
					module.Ternary(p3.mIsExpanded, 180, 0)
				)

				if not __wf_atom_7e8ad928(mProfileSettings) then
					mProfileSettings:__wf_atom_fe3d68a9(p3.mIsExpanded)
				end

				self:UpdateListFocus()
			end

			function self.mUserLocator.OnElementTransitionStarted(_, p3)
				mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, false)
			end

			function self.mUserLocator.OnElementTransitionEnded(_, p3)
				if p3 and p3.mClipName then
					v17:AddTimer(0.1, function()
						if p3 and p3.mClipName then
							mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, true)
						end
					end, false, nil)
				end
			end

			function self.mUserLocator.mOnFocusedCallback(p3)
				if p3.mClipName == nil then
					return
				end

				mMovie:__wf_atom_4c1c1986(p3.mClipName, "Letter", 44, _G.UIColor_Yellow)
				mMovie:__wf_atom_4c1c1986(p3.mClipName, "Letter", 12, 100)
			end

			function self.mUserLocator.mOnUnfocusedCallback(p3)
				if p3.mClipName == nil then
					return
				end

				mMovie:__wf_atom_4c1c1986(p3.mClipName, "Letter", 44, _G.UIColor_White)
				mMovie:__wf_atom_4c1c1986(p3.mClipName, "Letter", 12, 50)
			end

			function self.mUserLocator.mOnSelectedCallback(p3)
				if __wf_atom_7e8ad928(self.mListControl) then
					return
				end

				local activePanel = mWindow:GetActivePanel()

				if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(activePanel.mAlphabetIndex[p3.index])) then
					self:FocusElement(activePanel.mAlphabetIndex[p3.index])
				end
			end

			function self.mUserLocator.mElementDrawCallback(data)
				if data.mClipName == nil then
					return
				end

				local focusedElement = self.mUserLocator:GetFocusedElement()
				local v53 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.mId == data.mId
				mMovie:__wf_atom_48bd5a59(data.mClipName, "Letter", 36, data.Letter)
				mMovie:__wf_atom_4c1c1986(
					data.mClipName,
					"Letter",
					44,
					module.Ternary(v53, _G.UIColor_Yellow, _G.UIColor_White)
				)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Letter", 12, module.Ternary(v53, 100, 50))
			end

			mMovie:__wf_atom_c0d7a318(self.mClipPath, "AlphabetIndex.Grid.Bg", "noMenuSelection", true)
			self.mUserLocator:AddElement({ Letter = "#", index = 1 }, true)
			self.mUserLocator:AddElement({ Letter = "@", index = 12 }, true)

			for i = 15, #v7 do
				self.mUserLocator:AddElement({ Letter = v7[i], index = i }, true)
			end

			self.mUserLocator:Redraw()
			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "AlphabetIndex", 13, false)
			self.mEmoteGrid = module17.CreateGrid(mMovie, self.mClipPath .. ".Panel.EmoteGrid.EmoteElement", nil, 5, 7)
			self.mEmoteGrid:SetCallbacks("EmotePressed", "EmoteRollOver", "EmoteRollOut", nil, nil, nil, "EmoteRollOut")
			self.mEmoteGrid.mInitialX = self.mEmoteGrid.mInitialX + 3
			self.mEmoteGrid.mIsVisible = false
			self.mEmoteGrid.mColumnSeparation = 35
			self.mEmoteGrid.mRowSeparation = 33
			self.mEmoteGrid.mScrollAlwaysVisible = true
			self.mEmoteGrid._RedrawScrollBar = self.mEmoteGrid.RedrawScrollBar

			function self.mEmoteGrid.RedrawScrollBar(object)
				local v53 = math.ceil(object:GetHowManyElements() / object.mColumns) + object.mExtraRowScroll
				local mRows = object.mRows
				local v54 = mRows < v53
				object.mScrollBar:SetVisible(v54)

				if v54 then
					object.mScrollBar:SetVisibleProp(mRows / v53)
					local coordsRelativeToParent = mWindow:GetCoordsRelativeToParent(mWindow.mWindow)
					object.mScrollBar:SetHeight(coordsRelativeToParent.height - 12, true, true)
					object.mScrollBar.mScrollStep = 1 / (v53 - mRows)
				end
			end

			function self.mEmoteGrid.OnElementTransitionStarted(_, p3)
				mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, false)
			end

			function self.mEmoteGrid.OnElementTransitionEnded(_, p3)
				if p3 and p3.mClipName then
					v17:AddTimer(0.1, function()
						if p3 and p3.mClipName then
							mMovie:__wf_atom_2dedec1a(p3.mClipName, 67, true)
						end
					end, false, nil)
				end
			end

			function self.mEmoteGrid.mOnFocusedCallback(p3)
				if p3.mClipName == nil then
					return
				end

				if
					mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
					or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL and not Engine.__wf_atom_2a979d69()
				then
					_T.gToolTip = p3.mTag
				end

				mMovie:__wf_atom_7f57ab2f(p3.mClipName, "Bg", 13, true)
			end

			function self.mEmoteGrid.mOnUnfocusedCallback(p3)
				if p3.mClipName == nil then
					return
				end

				_T.gToolTip = nil
				mMovie:__wf_atom_7f57ab2f(p3.mClipName, "Bg", 13, false)
			end

			function self.mEmoteGrid.mOnSelectedCallback(p3)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Window.SendMessageBar.MessageBox", 85)
				local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36)
				mMovie:__wf_atom_50d60589(
					"Window.SendMessageBar.MessageBox",
					36,
					__wf_atom_f34ce385(__wf_atom_387f260e, p3.mTag, __wf_atom_5e6e15c8_2)
				)

				if not (Engine.__wf_atom_4078373f() or Engine.__wf_atom_2a979d69()) then
					mWindow.mInputPanel:GiveChatFocus()
				end
			end

			function self.mEmoteGrid.mElementDrawCallback(data)
				if data.mClipName == nil then
					return
				end

				local focusedElement = self.mEmoteGrid:GetFocusedElement()
				local v53 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id
				local __wf_atom_b4b867f2 = mMovie:__wf_atom_b4b867f2(data.mTag, true)
				mMovie:__wf_atom_48bd5a59(data.mClipName, "Emoji", 36, __wf_atom_b4b867f2)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 12, 25)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg", 13, v53)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Tag", 13, false)
				mMovie:__wf_atom_50d60589(data.mClipName .. ".Tag", 36, data.mTag)

				if self.mParent.mFontName ~= nil then
					mMovie:__wf_atom_48bd5a59(data.mClipName, "Tag", 49, self.mParent.mFontName)
				end
			end

			local module18 = require("SF.Interface.Components.Scrollbar")
			local scrollBar2 = module18.CreateScrollBar(getfenv(1), self.mClipPath .. ".Panel.EmoteGrid.ScrollBar", {
				mEnableSmoothScroll = false
			})

			function scrollBar2.mScrollValueChangedCallback(p3, _)
				self.mEmoteGrid:ScrollValueChangedCallback(p3)
			end

			self.mEmoteGrid.mScrollBar = scrollBar2

			if Engine.__wf_atom_2a979d69() then
				self.mEmoteGrid:EnableDragScrolling()
				self.mEmoteGrid:EnableSmoothScroll()
				self.mEmoteGrid:SetScroll(1, true)
			end

			for i = 1, #v19 do
				self.mEmoteGrid:AddElement({ mTag = v19[i] }, true)
			end

			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.EmoteGrid", 13, false)
			self:SetSize(p, p2)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.Fill", 12, 0)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.Fill", 11, UIColor_DarkerBrown)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeTop", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeTop", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeRight", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeRight", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeBottom", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeBottom", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorSeparator", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorSeparator", 12, 40)
			mMovie:SetCallbacks(
				self.mClipPath .. ".Panel.LocatorBtn.Btn",
				"AlphabetExpanderFocused",
				"AlphabetExpanderUnfocused",
				"AlphabetExpanderPressed",
				nil
			)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn", 12, 100)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn.Bg", 12, 0)
			AlphabetExpanderUnfocused()
			mMovie:__wf_atom_7d7314f1(self.mClipPath .. ".Panel.LocatorBtn.Callout.Tf.text", "<MENU_RTHUMB>")
			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.LocatorBtn.Callout", 13, false)
			mMovie:__wf_atom_7d7314f1(
				self.mClipPath .. ".Panel.LocatorBtn.Label.text",
				"/Lotus/Language/Menu/Chat_AlphabetGridBtn"
			)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".Panel.LocatorBtn.Label", 40)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel.UserList", 14)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn.Arrow", 0, __wf_atom_5e6e15c8_2 + 5)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn.Btn", 14, __wf_atom_5e6e15c8_3)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn.Callout", 0, __wf_atom_5e6e15c8_2 / 2 - 13)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorBtn.Bg", 14, __wf_atom_5e6e15c8_3)
			mMovie:OverrideMaterial(self.mClipPath .. ".Panel.LocatorBtn.Bg", inputBarBackerMaterial)
			mMovie:SetCallbacks(self.mClipPath .. ".AlphabetIndex.Grid.Bg", "AlphabetIndexBgFocused", nil, nil, nil)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.Bg", 11, UIColor_DarkerBrown)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.Bg", 12, 75)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeTop", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeTop", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeRight", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeRight", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeBottom", 11, UIColor_White)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex.Grid.EdgeBottom", 12, 25)

			if Engine.__wf_atom_2a979d69() then
				mMovie:__wf_atom_e57658c2("Blacker", 12, 80)
				mMovie:__wf_atom_e57658c2("Blacker", 11, UIColor_DarkerBrown)
				mMovie:__wf_atom_e57658c2(
					"Blacker",
					14,
					mMovie:__wf_atom_d5a50cb5() * mMovie:__wf_atom_5e6e15c8("_root", 5) / 100
				)
				mMovie:__wf_atom_e57658c2(
					"Blacker",
					15,
					mMovie:__wf_atom_c4f6543f() * mMovie:__wf_atom_5e6e15c8("_root", 6) / 100
				)
				mMovie:__wf_atom_e57658c2("Blacker", 0, 0)
				mMovie:__wf_atom_e57658c2("Blacker", 1, 0)
				mMovie:__wf_atom_e57658c2(self.mClipPath .. ".AlphabetIndex", 5, 170)
				mMovie:__wf_atom_e57658c2(self.mClipPath .. ".AlphabetIndex", 6, 170)
			end
		end,
		FocusElement = function(self, p)
			self.mListControl:FocusElement(p)
		end,
		UpdateListFocus = function(self)
			local focusedElement = self.mListControl:GetFocusedElement()

			if not __wf_atom_7e8ad928(focusedElement) then
				self.mListControl.mElementDrawCallback(focusedElement)
			end
		end,
		Clear = function(self)
			if self.mListControl:GetHowManyElements() > 0 then
				self.mListControl:SetScroll(0)
				self.mListControl:RemoveElements(true, true)
			end
		end,
		Update = function(self, p)
			if not (__wf_atom_7e8ad928(self.mListControl) or __wf_atom_7e8ad928(self.mListControl.mScrollBar)) then
				self.mListControl.mScrollBar:Update(p)
			end

			if
				not Engine.__wf_atom_fc67ba71()
				and not Engine.__wf_atom_2a979d69()
				and not __wf_atom_8e4fda44:__wf_atom_084a721a()
				and mWindow.mInputPanel.mIsFocused
			then
				if module15.IMEGetAndClearClicked() and v39 then
					fn25()
				end

				self:UpdateTextSuggestion()
			end

			if not __wf_atom_7e8ad928(self.mEmoteGrid) then
				local v53 = self.mEmoteGrid:Update(p)

				if Engine.__wf_atom_2a979d69() and v53 then
					local v54 = __wf_atom_421b01aa(
						self.mEmoteGrid.mScroll,
						1,
						self.mEmoteGrid:GetHowManyElements() - self.mEmoteGrid:GetHowManyVisibleElements() + 1
					)

					if v54 ~= self.mEmoteGrid.mScroll then
						self.mEmoteGrid:SetScroll(v54, true)
					end

					self.mEmoteGrid:Redraw(nil, false, true)
				end
			end
		end,
		UpdateTextSuggestion = function(self)
			v39 = mMovie:__wf_atom_a91463a8(mWindow.mInputPanel.mClipPath .. ".MessageBox", 87)

			if v39 then
				flag = true
			end

			if flag == false then
				module15.CloseIME(v18)
				v39 = false
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(mWindow.mInputPanel.mClipPath .. ".MessageBox", 85)

			if __wf_atom_5e6e15c8 == nil then
				return true
			end

			local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36)

			if __wf_atom_5e6e15c8 > 0 then
				__wf_atom_5e6e15c8 = __wf_atom_875c8d7a(__wf_atom_387f260e, __wf_atom_5e6e15c8)
			end

			local flag2 = false
			local v53 = string.sub(__wf_atom_387f260e, __wf_atom_5e6e15c8, __wf_atom_5e6e15c8)

			if v38 and string.len(__wf_atom_387f260e) < v38 then
				module15.CloseIME(v18)
				v39 = false
				mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
				module15.IMESetOptions("", v18, false)
				v21 = ""
				flag = false
				v38 = string.len(__wf_atom_387f260e)
			elseif not v39 and flag and (v53 == ":" or v53 == "@" or v53 == "[" or v53 == "{") then
				local v54 = string.sub(__wf_atom_387f260e, v38, __wf_atom_5e6e15c8)

				for _, v56 in pairs(v19) do
					if v56 ~= string.lower(v54) then
						continue
					end

					flag2 = true
					break
				end

				if not flag2 then
					v38 = __wf_atom_5e6e15c8
					v21 = v53
				end
			end

			local v54 = string.sub(__wf_atom_387f260e, v38, __wf_atom_5e6e15c8)

			if v40 == v54 then
				return
			end

			v40 = v54
			local v55 = string.gsub(v54, "\"", "")

			if string.len(v55) == 0 and v39 then
				module15.CloseIME(v18)
				v39 = false
				mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
				module15.IMESetOptions("", v18, false)
				v21 = ""
				flag = false
			end

			local v56 = __wf_atom_d99ae0ec(v55)
			local v57 = {}
			local count = 0
			local v58 = ""

			if flag2 then
				module15.CloseIME(v18)
				v39 = false
				mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
				module15.IMESetOptions("", v18, false)
				flag = false
			else
				if v21 == "@" then
					local mChannelType, mUserList

					if not __wf_atom_7e8ad928(mWindow:GetActivePanel()) then
						mChannelType = mWindow:GetActivePanel().mChannelType
						mUserList = mWindow:GetActivePanel().mUserList
					end

					local v59

					if
						mChannelType == mWindow.CHANNEL_SESSION
						or mChannelType == mWindow.CHANNEL_CLAN
						or mChannelType == mWindow.CHANNEL_ALLIANCE
					then
						v59 = mUserList
					else
						v59 = v22
					end

					if mUserList ~= nil then
						for k, _ in pairs(v59) do
							local v61 = mUserList[k]

							if not (v61 ~= nil and v61.isOnline and string.find(
								"@" .. __wf_atom_d99ae0ec(v61.displayName),
								v56,
								1,
								true
							) ~= nil) then
								continue
							end

							table.insert(v57, "@" .. v61.displayName)
							count += 1

							if count >= 8 then
								break
							end
						end
					end
				elseif v21 == ":" then
					for _, v59 in ipairs(v19) do
						if not (string.find(v59, module.EscapeMagicCharacters(v56)) == 1 and count < 8) then
							continue
						end

						table.insert(v57, v59)
						count += 1
					end
				elseif v21 == "[" and #v56 >= 2 then
					local _ = "^" .. v56:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
					local v59 = {}

					local function fn35(list)
						for i = 1, #list do
							table.insert(v59, list[i])
						end
					end

					if not __wf_atom_7e8ad928(nil) then
						local v60 = string.sub(v56, 2)
						fn35((nil):__wf_atom_7023fcbc(v60))
						fn35((nil):__wf_atom_abff3924(v60))
						fn35((nil):__wf_atom_5efd31d4(v60, 0))
						fn35((nil):__wf_atom_5efd31d4(v60, 1))
						fn35((nil):__wf_atom_5efd31d4(v60, 6))
						fn35((nil):__wf_atom_5efd31d4(v60, 7))
						fn35((nil):__wf_atom_5efd31d4(v60, 2))
					end

					for i = 1, #v59 do
						if count < 8 then
							table.insert(v57, (TitleCase(v59[i])))
							count += 1
						else
							break
						end
					end
				elseif v21 == "{" then
					local v59 = "^" .. v56:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
					local v60 = {}

					for _, v61 in ipairs(mWindow.mGuildSuggest) do
						if not string.find(v61, v59) then
							continue
						end

						table.insert(v60, v61)

						if not (count < 8) then
							continue
						end

						table.insert(v57, (v61:gsub("(%l)([^%s^%-]*)", function(value, p)
							return string.upper(value) .. p
						end)))
						count += 1
					end
				end

				if v21 == "[" then
					for i = 1, #v57 do
						v57[i] = string.sub(v57[i], 1, string.len(v57[i]) - 1)
					end
				end

				table.sort(v57, function(a, b)
					return b < a
				end)

				if v21 == "[" then
					for i = 1, #v57 do
						v57[i] ..= "]"
					end
				end

				for _, v59 in ipairs(v57) do
					v58 = v59 .. "|" .. v58
				end

				if count == 1 and flag2 then
					count = 0
				else
					v58 ..= v55
				end
			end

			local v59 = string.len(v58)

			if flag and count > 0 and (v21 ~= ":" or #v55 > 2) then
				module15.OpenIME(v18)
				mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, true)
				v39 = true
				module15.IMESetTip(v55, v18)
				module15.IMESetTipCursor(v59, v18)
				module15.IMESetOptions(v58, v18, false)
				module15.Update(v18)
			elseif flag and (count == 0 or v21 == ":" and #v55 <= 2) then
				module15.IMESetOptions("", v18, false)
				module15.CloseIME(v18)
				module15.Update(v18)
				mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
				v39 = false
			end
		end,
		UpdateElementVisibilityRange = function(self, p)
			self.mListControl.mScrollBar:SetHeight(p - 39)
			self.mListControl.mVisibleElements = math.floor(math.floor(p - 36) / self.mListControl.mForcedVerticalSeparation)
		end,
		OnUserJoin = function(self, p)
			if not (__wf_atom_7e8ad928(self.mListControl.mScroll) or __wf_atom_7e8ad928(self.mListControl.mScrollBar)) then
				local mScroll = self.mListControl.mScroll

				if p < mScroll or self.mListControl.mScrollBar:GetScrollValue() == 1 then
					self.mListControl:SetScroll(mScroll + 1)
				end
			end

			local focusedElementIndex = self.mListControl:GetFocusedElementIndex()

			if not __wf_atom_7e8ad928(focusedElementIndex) and p <= focusedElementIndex then
				self:FocusElement(
					__wf_atom_421b01aa(focusedElementIndex + 1, 1, self.mListControl:GetHowManyElements()),
					true
				)
			end
		end,
		OnUserLeave = function(self, p)
			if not (__wf_atom_7e8ad928(self.mListControl.mScroll) or __wf_atom_7e8ad928(self.mListControl.mScrollBar)) then
				local mScroll = self.mListControl.mScroll

				if p < mScroll then
					self.mListControl:SetScroll(mScroll - 1)
				end
			end

			local focusedElementIndex = self.mListControl:GetFocusedElementIndex()

			if not __wf_atom_7e8ad928(focusedElementIndex) and p < focusedElementIndex then
				self:FocusElement(
					__wf_atom_421b01aa(focusedElementIndex - 1, 1, self.mListControl:GetHowManyElements()),
					true
				)
			end
		end,
		SetSize = function(self)
			local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mWindow)
			self.mActiveRect = coordsRelativeToParent
			self:ToggleList(self.mIsExpanded, true)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.Fill", 14, coordsRelativeToParent.width)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.Fill", 15, coordsRelativeToParent.height + 5)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Blurer", 14, coordsRelativeToParent.width - 1)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Blurer", 15, coordsRelativeToParent.height + 5)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Mask", 14, coordsRelativeToParent.width)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Mask", 15, coordsRelativeToParent.height + 8)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeBottom", 1, coordsRelativeToParent.height - 1)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeRight", 0, coordsRelativeToParent.width - 1)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.EdgeRight", 15, coordsRelativeToParent.height)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LocatorSeparator", 1, coordsRelativeToParent.height - 27)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.LeftShadow", 15, coordsRelativeToParent.height - 2)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.TopShadow", 14, coordsRelativeToParent.width - 2)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.RightShadow", 0, coordsRelativeToParent.width - 1)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.RightShadow", 15, coordsRelativeToParent.height - 2)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.BottomShadow", 1, coordsRelativeToParent.height - 1)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel.BottomShadow", 14, coordsRelativeToParent.width - 2)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".Panel.UserList.ScrollBar", 14)

			if not __wf_atom_7e8ad928(__wf_atom_5e6e15c8) then
				mMovie:__wf_atom_4c1c1986(
					self.mClipPath,
					"Panel.UserList.ScrollBar",
					0,
					coordsRelativeToParent.width - __wf_atom_5e6e15c8 / 2 + 8
				)
			end

			mMovie:__wf_atom_e57658c2(self.mClipPath, 0, coordsRelativeToParent.x)
			mMovie:__wf_atom_e57658c2(self.mClipPath, 1, coordsRelativeToParent.y)
			self.mEmoteGrid.mRows = math.floor((coordsRelativeToParent.height - 32) / self.mEmoteGrid.mRowSeparation)
			self.mEmoteGrid.mVisibleElements = self.mEmoteGrid.mRows * self.mEmoteGrid.mColumns
			self.mEmoteGrid:Redraw(nil, false, true)

			if
				self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_MENU_SIMPLE
				and self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_GAMEPLAY_SIMPLE
			then
				self:UpdateElementVisibilityRange(coordsRelativeToParent.height)
				self.mListControl:Redraw(nil, true, true)
			end
		end,
		ToggleLocator = function(self, _)
			local ternary = module.Ternary(self.mUserLocator.mIsExpanded, -self.mUserLocator.mGridWidth, 0)

			if not mWindow.mUserPanel.mUserLocator.mIsExpanded then
				mMovie:__wf_atom_7f57ab2f(self.mClipPath, "AlphabetIndex", 13, true)
			end

			mMovie:__wf_atom_c0d7a318(self.mClipPath, "AlphabetIndex", "noMenuSelection", true)
			__wf_atom_ec43d06e(mMovie, self.mClipPath .. ".AlphabetIndex.Grid", 8, { 0 }, { ternary }, 0.25, 0)
			__wf_atom_ec43d06e(
				mMovie,
				self.mClipPath .. ".AlphabetIndex.Blurer",
				8,
				{ 0 },
				{ ternary },
				0.25,
				0,
				function()
					if not mWindow.mUserPanel.mUserLocator.mIsExpanded then
						mMovie:__wf_atom_7f57ab2f(self.mClipPath, "AlphabetIndex", 13, false)
					end

					mMovie:__wf_atom_c0d7a318(
						self.mClipPath,
						"AlphabetIndex",
						"noMenuSelection",
						not mWindow.mUserPanel.mUserLocator.mIsExpanded
					)
				end
			)
			mWindow.mUserPanel.mUserLocator:ToggleExpanded()
		end,
		ToggleList = function(self, mIsExpanded, p)
			mMovie:__wf_atom_290807ee(self.mClipPath .. ".Panel")
			mMovie:__wf_atom_290807ee(self.mClipPath .. ".AlphabetIndex")

			if mIsExpanded == nil then
				self.mIsExpanded = not self.mIsExpanded
			else
				self.mIsExpanded = mIsExpanded
			end

			mWindow:SetPosition(mWindow.mWindow.x, mWindow.mWindow.y)

			if not self.mIsExpanded and self.mUserLocator.mIsExpanded then
				self:ToggleLocator()
			end

			local ternary = module.Ternary(self.mIsExpanded, 0, -self.mActiveRect.width)
			local ternary2 = module.Ternary(self.mIsExpanded, self.mActiveRect.width, 0)

			if p then
				mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel", 13, self.mIsExpanded)
				mMovie:__wf_atom_4c1c1986(self.mClipPath, "Panel", 0, ternary)
				mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Blurer", 13, self.mIsExpanded)
				mMovie:__wf_atom_4c1c1986(self.mClipPath, "Blurer", 0, ternary)
				mMovie:__wf_atom_7f57ab2f(
					self.mClipPath,
					"AlphabetIndex",
					13,
					not __wf_atom_7e8ad928(self.mUserLocator) and self.mUserLocator.mIsExpanded
				)
				mMovie:__wf_atom_4c1c1986(self.mClipPath, "AlphabetIndex", 0, ternary2)
			else
				if self.mIsExpanded then
					mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel", 13, true)
					mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Blurer", 13, true)

					if not __wf_atom_7e8ad928(self.mUserLocator) and self.mUserLocator.mIsExpanded then
						mMovie:__wf_atom_7f57ab2f(self.mClipPath, "AlphabetIndex", 13, true)
					end
				end

				self.mUserListInterpolating = true
				local v53 = mWindow:GetCoordsRelativeToParent(mWindow.mChatPanelWindow).width - mMovie:__wf_atom_5e6e15c8(
					mWindow.mClipName .. ".TabbedChatPanel.Fill",
					0
				) * 2 + module.Ternary(self.mIsExpanded, self.mActiveRect.width, 0) + 4
				__wf_atom_ec43d06e(mMovie, mWindow.mClipName .. ".TabbedChatPanel.Fill", 2, { 14 }, { v53 }, 0.25)
				__wf_atom_ec43d06e(
					mMovie,
					mWindow.mClipName .. ".TabMenu.WindowTitle.Fill",
					2,
					{ 14 },
					{ v53 - 12 },
					0.25
				)
				__wf_atom_ec43d06e(mMovie, self.mClipPath .. ".Panel", 2, { 0 }, { ternary }, 0.25, 0, function()
					if not self.mIsExpanded then
						mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel", 13, false)
						mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Blurer", 13, false)
						mMovie:__wf_atom_7f57ab2f(self.mClipPath, "AlphabetIndex", 13, false)
					end

					self.mUserListInterpolating = false
				end)
				__wf_atom_ec43d06e(mMovie, self.mClipPath .. ".Blurer", 2, { 0 }, { ternary }, 0.25, 0)
				__wf_atom_ec43d06e(mMovie, self.mClipPath .. ".AlphabetIndex", 2, { 0 }, { ternary2 }, 0.25, 0)
			end
		end,
		ToggleListVis = function(self, p, p2)
			if self.mIsExpanded and self.mListControl.mIsVisible ~= p then
				if not p and self.mUserLocator.mIsExpanded then
					self:ToggleLocator()
				end
			else
				self:ToggleList(nil, p2)
			end

			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.LocatorSeparator", 13, p)
			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.LocatorBtn", 13, p)
			self.mListControl.mIsVisible = p and self.mIsExpanded
			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.UserList", 13, self.mListControl.mIsVisible)
			mMovie:__wf_atom_e57658c2(
				"Window.SendMessageBar.UserListBtn.Arrow",
				16,
				module.Ternary(p and self.mIsExpanded, 180, 0)
			)
			mMovie:__wf_atom_e57658c2(
				"Window.SendMessageBar.UserListBtn",
				12,
				module.Ternary(p and self.mIsExpanded, 100, 50)
			)
			self.mEmoteGrid.mIsVisible = not p and self.mIsExpanded
			mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Panel.EmoteGrid", 13, self.mEmoteGrid.mIsVisible)
			mMovie:__wf_atom_e57658c2(
				"Window.SendMessageBar.EmojiBtn.Arrow",
				16,
				module.Ternary(not p and self.mIsExpanded, 180, 0)
			)
			mMovie:__wf_atom_e57658c2(
				"Window.SendMessageBar.EmojiBtn",
				12,
				module.Ternary(not p and self.mIsExpanded, 100, 50)
			)
			mMovie:__wf_atom_e57658c2(
				"Window.MouseCatcherBtn",
				14,
				mWindow.mWindow.width + module.Ternary(
					self.mListControl.mIsVisible or self.mEmoteGrid.mIsVisible,
					self.mActiveRect.width,
					0
				)
			)

			if Engine.IsPlayingWithController() then
				mMovie:__wf_atom_e57658c2(
					"Window.SendMessageBar.EmojiBtn",
					12,
					module.Ternary(self.mEmoteGrid.mIsVisible, 100, 50)
				)
				mMovie:__wf_atom_e57658c2(
					"Window.SendMessageBar.UserListBtn",
					12,
					module.Ternary(self.mListControl.mIsVisible, 100, 50)
				)
			end

			if not __wf_atom_7e8ad928(mProfileSettings) then
				mProfileSettings:__wf_atom_313505c5(self.mListControl.mIsVisible)
				mProfileSettings:__wf_atom_2e66876a(self.mEmoteGrid.mIsVisible)
			end

			module.PlaySound(_G.UISound_ItemTip)
			self:UpdateListFocus()
		end
	}
end

local function fn35(mParent, mClipName)
	local v53 = {
		mParent = mParent,
		mWindow = {},
		mClipName = mClipName,
		mClipParent = mParent.mClipName,
		mClipPath = mParent.mClipName .. "." .. mClipName,
		mIsFocused = false,
		MAX_MSG_LIMIT = 400,
		MAX_MSG_LENGTH_NORMAL = 300,
		MAX_MSG_LENGTH_RECRUIT_TRADE = 180
	}
	v53.mMaxMsgLength = v53.MAX_MSG_LENGTH_NORMAL
	v53.mInitPromptXPos = mMovie:__wf_atom_5e6e15c8(v53.mClipPath .. ".Prompt", 0)
	v53.CharLimitWarning = mMovie:__wf_atom_8e9ac384("<WARNING>", true)
	v53.CharLimitError = mMovie:__wf_atom_8e9ac384("<PROBLEM>", true)
	v53.TimerIcon = mMovie:__wf_atom_8e9ac384("<TIMER>", true)
	v53.CharLimitFlashTime = 0

	function v53:Initialize(p, p2)
		self.mWindow.x = 0
		self.mWindow.y = 0
		self.mWindow.ReverseY = true
		self.mWindow.width = 0
		self.mWindow.ReverseWidth = true
		self.mWindow.height = 35
		self:SetSize(p, p2)

		local function fn36(p3, p4, p5, p6, p7)
			mMovie:__wf_atom_e57658c2(p3, 12, module.Ternary(Engine.IsPlayingWithController(), 100, 50))
			mMovie:__wf_atom_7d7314f1(p3 .. ".Callout.Tf.text", p4)
			mMovie:__wf_atom_7f57ab2f(p3, "Callout", 13, Engine.IsPlayingWithController())
			mMovie:__wf_atom_c90af43a(p3 .. ".Icon", p5)

			if p6 ~= nil and p7 ~= nil then
				mMovie:__wf_atom_4c1c1986(p3, "Icon", 14, p6)
				mMovie:__wf_atom_4c1c1986(p3, "Icon", 15, p7)
			end

			mMovie:__wf_atom_7f57ab2f(p3, "Arrow", 13, not Engine.IsPlayingWithController())
			mMovie:OverrideMaterial(p3 .. ".Highlight", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(p3 .. ".Highlight", "RectInnerColor", 0, 0, 0, 0)
			mMovie:__wf_atom_1ca72041(
				p3 .. ".Hightlight",
				"RectEdgeColor",
				_G.UIColorObject_White.r,
				_G.UIColorObject_White.g,
				_G.UIColorObject_White.b,
				0.8
			)
			mMovie:__wf_atom_7f57ab2f(p3, "Highlight", 13, false)
		end

		mMovie:__wf_atom_4c1c1986(self.mClipPath, "Arrow", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "Arrow", 12, 25)
		mMovie:SetCallbacks(
			self.mClipPath .. ".EmojiBtn",
			"EmojiBtnFocused",
			"EmojiBtnUnfocused",
			"EmojiBtnPressed",
			nil
		)
		fn36(self.mClipPath .. ".EmojiBtn", "<MENU_RTRIGGER1>", emojiGridBtnIcon)
		mMovie:__wf_atom_4c1c1986(
			self.mClipPath,
			"EmojiBtn.Callout",
			0,
			mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".EmojiBtn.Callout", 0) - 5
		)
		mMovie:SetCallbacks(
			self.mClipPath .. ".UserListBtn",
			"UserListBtnFocused",
			"UserListBtnUnfocused",
			"UserListBtnPressed",
			nil
		)
		fn36(self.mClipPath .. ".UserListBtn", "", userListBtnIcon)
		fn36(self.mClipPath .. ".HyperlinkBtn", "<MENU_LTHUMB>", hyperlinkBtnIcon, 32, 32)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "HyperlinkBtn", 13, false)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "HyperlinkBtn.Callout", 13, true)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "HyperlinkBtn.Arrow", 13, false)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "HyperlinkBtn.Icon", 12, 100)
		fn36(self.mClipPath .. ".HideWindowBtn", "", collapsedBtnIcon)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "HideWindowBtn", 13, false)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "HideWindowBtn.Highlight", 13, true)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "HideWindowBtn.Icon", 12, 100)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeBottomLeft", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeBottomLeft", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeTriangle", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeTriangle", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeFill", 11, UIColor_DarkerBrown)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeFill", 12, 75)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeBottom", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeBottom", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeTop", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeTop", 12, 40)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeRight", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeRight", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "DecoLine", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "DecoLine", 12, 25)
		mMovie:OverrideMaterial(self.mClipPath .. ".Bg", inputBackerMaterial)
		mMovie:OverrideMaterial(self.mClipPath .. ".BarBg", inputBarBackerMaterial)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "MessageBox", 81, _G.UIColor_White)
		mMovie:__wf_atom_4c1c1986(
			self.mClipPath,
			"Prompt",
			12,
			module.Ternary(Engine.IsPlayingWithController(), 100, 50)
		)
		mMovie:__wf_atom_50d60589(self.mClipPath .. ".Prompt", 36, "")
		mMovie:__wf_atom_7d7314f1(self.mClipPath .. ".Callout.Tf.text", "<MENU_GENERIC1>")
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "Callout", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "CharLimit", 13, false)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "CharLimit.Warning", 13, false)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "CharLimit.Warning", 89, true)
		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "CharLimit.SpamTime", 89, true)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "CharLimit.SpamTime", 11, _G.UIColor_Black)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "CharLimit.Bg", 12, 75)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "MessageBox", 44, _G.UIColor_Beige)

		if Engine.IsPlayingWithController() then
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "Prompt", 0, self.mInitPromptXPos + 25)
			mMovie:__wf_atom_4c1c1986(self.mClipPath, "MessageBox", 0, self.mInitPromptXPos + 25)
		end

		if Engine.__wf_atom_fc67ba71() and fn16() then
			mMovie:__wf_atom_2dedec1a(self.mClipPath, 13, false)
		end
	end

	function v53:SetSize(_, _)
		local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mWindow)
		mMovie:__wf_atom_e57658c2(self.mClipPath, 0, coordsRelativeToParent.x)
		mMovie:__wf_atom_e57658c2(self.mClipPath, 1, coordsRelativeToParent.y)
		local v54 = coordsRelativeToParent.width - mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".Bg", 0)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "Bg", 14, v54 + 8)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "BarBg", 14, v54 + 16)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "Bg", 12, 75)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "BarBg", 12, 75)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "BgBlurer", 14, v54)
		local isPlayingWithController = Engine.IsPlayingWithController()
		local v55 = 0
		local v56, v57

		if Engine.__wf_atom_2a979d69() then
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".EmojiBtn", 5, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".EmojiBtn", 6, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".UserListBtn", 5, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".UserListBtn", 6, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".EmojiBtn", 1, coordsRelativeToParent.height - 36)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".UserListBtn", 1, coordsRelativeToParent.height - 36)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".HideWindowBtn", 5, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".HideWindowBtn", 6, 133)
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".HideWindowBtn", 1, coordsRelativeToParent.height - 36)

			if Engine.IsPlayingWithController() then
				v56 = 100
				v57 = 65
				v55 = 30
			else
				v56 = 80
				v57 = 40
			end
		else
			v56 = 70
			v57 = 40
		end

		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EmojiBtn", 0, coordsRelativeToParent.width - v56)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "UserListBtn", 0, coordsRelativeToParent.width - v57)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "HideWindowBtn", 0, coordsRelativeToParent.width - v55)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "HyperlinkBtn", 0, coordsRelativeToParent.width - 140)
		mMovie:__wf_atom_4c1c1986(
			self.mClipPath,
			"EdgeTop",
			14,
			coordsRelativeToParent.width - mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".EdgeTop", 0) - 1
		)
		mMovie:__wf_atom_4c1c1986(
			self.mClipPath,
			"EdgeBottom",
			14,
			coordsRelativeToParent.width - mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".EdgeBottom", 0)
		)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "EdgeRight", 0, coordsRelativeToParent.width - 1)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "CharLimit", 0, coordsRelativeToParent.width - 11)
		self.mParent:GetActivePanel()
		local total = 120

		if isPlayingWithController then
			total += 32
		end

		mMovie:__wf_atom_4c1c1986(self.mClipPath, "MessageBox", 14, coordsRelativeToParent.width - total)
		__wf_atom_86cbd68d(mMovie, self.mClipPath .. ".MessageBox.updateTextFormat")
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "FocusButton", 14, coordsRelativeToParent.width - 100)

		if Engine.__wf_atom_2a979d69() then
			mMovie:__wf_atom_e57658c2(self.mClipPath .. ".FocusButton", 14, coordsRelativeToParent.width - 140)
		end
	end

	function v53:SetFocus(mIsFocused)
		self.mIsFocused = mIsFocused
	end

	function v53:UpdateDefaultText()
		local name

		if __wf_atom_7e8ad928(self.mParent.mTabMenu) or __wf_atom_7e8ad928(self.mParent.mTabMenu.mSelectedElement) then
			name = ""
		else
			name = self.mParent.mTabMenu.mSelectedElement.Name

			if self.mParent.mMode ~= self.mParent.CHANNEL_PRIVATE_CHAT then
				name = string.upper(name)
			end
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_DefaultText", false, {
			CHANNEL = name
		})
		mMovie:__wf_atom_50d60589(self.mClipPath .. ".Prompt", 36, __wf_atom_8e9ac384)
	end

	function v53:GiveChatFocus()
		mMovie:__wf_atom_46a6af3b(self.mClipPath .. ".MessageBox")
		mMovie:Execute("MessageBoxFocused", "")
	end

	return v53
end

local function fn36(value, list, list2)
	local v53 = 1
	local v54 = nil
	local v55 = nil

	local function fn37(p)
		v54, v55 = value:find(p, v53)
		return v54 ~= nil
	end

	local function fn38()
		return value:sub(v53, v55)
	end

	local v56 = 1

	while v53 <= value:len() do
		if not fn37("^%s+") then
			if fn37("^\"[^\"]*\"") or fn37("^'[^']*'") then
				table.insert(list, v56, fn38())
				table.insert(list2, v56, fn38():sub(2, -2))
				v56 += 1
			elseif fn37("[^%s%z]+") then
				table.insert(list, v56, fn38())
				table.insert(list2, v56, fn38())
				v56 += 1
			else
				v55 = v53
			end
		end

		v53 = v55 + 1
	end
end

local function fn37(p, p2)
	local msg = mMovie:__wf_atom_387f260e(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36)

	if Engine.__wf_atom_4078373f() then
		msg = p
	end

	if Engine.__wf_atom_2a979d69() then
		msg = p or msg
	end

	if v8.Msg ~= "" then
		msg = v8.Msg
	end

	local v53 = string.gsub(msg, "［", "[")
	local v54 = string.gsub(v53, "］", "]")
	local v55 = module3.ValidateTrueMaster(v54)

	if mEmojiSettings.Enabled and mEmojiSettings.EmoticonConversion then
		v55 = " " .. v55 .. " "

		for k, v56 in pairs(v20) do
			local v57 = StringSplit(",", v56)

			for i = 1, #v57 do
				v55 = string.gsub(v55, "%f[%S]" .. v57[i] .. "%f[%s]", k)
			end
		end
	end

	local v56 = __wf_atom_bb4529ac(v55)

	if p2 then
		mMovie:__wf_atom_50d60589(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36, "")
	end

	local v57 = __wf_atom_0a63ecce(v56)
	local v58 = {}
	local v59 = {}

	if not __wf_atom_7e8ad928(v57) and v57 ~= "" then
		fn36(v57, v58, v59)
	end

	return v57, v58, v59
end

local function fn38(p)
	local _ = mUIMode == module3.UI_MODE_IN_GAME

	if __wf_atom_7e8ad928(gGameRules) or not gGameRules:__wf_atom_788e1625() then
		module10.LogChatCommandUsed("/unstuck", module10.mChatCommandType.FailPosition)
		print("ChatRedux: Unstuck command failed!")
	else
		if v30 ~= nil and not (p - v30 > 120) then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_UnstuckCooldown", false))
			return
		end

		module10.LogChatCommandUsed("/unstuck", module10.mChatCommandType.SuccessPosition)
		v30 = __wf_atom_c4e218a2()
		gGameRules:__wf_atom_820388df()
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_UnstuckExecuted", false))
	end
end

local v53 = {
	GetOmegaCards = function()
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return false
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return false
		end

		local inventory = __wf_atom_9be88b01:GetInventory()

		if __wf_atom_7e8ad928(inventory) then
			return false
		end

		local upgrades = inventory:GetUpgrades()
		local __wf_atom_16cdad3a = __wf_atom_16cdad3a
		local result = {}

		for i = 1, #upgrades do
			__wf_atom_83c14687(0)
			local mItemType = upgrades[i].mItemType

			if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(__wf_atom_16cdad3a) then
				continue
			end

			table.insert(result, {
				Card = module5.CardFromArtifact(upgrades[i], i),
				mCardIndex = i,
				Count = 1
			})
		end

		return result
	end,
	GetStepSequencers = function()
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return false
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_7e8ad928((__wf_atom_9be88b01:GetInventory())) then
			return false
		end

		local maxSavedSequencers = module7.GetMaxSavedSequencers(notePackManifest)
		local stepSequencers = mGameData:GetInventory():GetStepSequencers()
		local result = {}

		for i, stepSequencer in ipairs(stepSequencers) do
			if maxSavedSequencers < i then
				break
			end

			local mName = stepSequencer.mName

			if mName == nil or mName == "" then
				mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Composition_SaveSong", false, {
					INDEX = i
				})
			end

			table.insert(result, { mName = mName, Song = stepSequencer, mTintIcons = true })
		end

		return result
	end,
	GetModularWeapons = function(p)
		local result = {}

		if __wf_atom_7e8ad928(mGameData) then
			return result
		end

		local inventory = mGameData:GetInventory()

		if __wf_atom_7e8ad928(inventory) then
			return result
		end

		local v54 = nil
		local zawStoreItem = nil

		if p == 0 then
			v54 = inventory:__wf_atom_4259c789()
			zawStoreItem = v.zawStoreItem
		elseif p == 1 then
			v54 = inventory:__wf_atom_9683bef6()
			zawStoreItem = v.ampStoreItem
		elseif p == 6 then
			v54 = inventory:__wf_atom_260a9632()
			zawStoreItem = v.moaPetStoreItem
		elseif p == 7 then
			v54 = inventory:__wf_atom_072f6737()
			zawStoreItem = v.kdriveStoreItem
		elseif p == 2 or p == 3 then
			local __wf_atom_4f67b86c = inventory:__wf_atom_4f67b86c()
			v54 = __wf_atom_4f67b86c == nil and {} or __wf_atom_4f67b86c
			local __wf_atom_20b04548 = inventory:__wf_atom_20b04548()

			for _, v55 in pairs(__wf_atom_20b04548) do
				table.insert(v54, v55)
			end
		end

		for i = 1, #v54 do
			local rawItem = v54[i]

			if not (#rawItem.mModularParts > 0) then
				continue
			end

			local v56 = __wf_atom_c67f9605:__wf_atom_a1680b24(rawItem.mItemType) <= __wf_atom_c67f9605:__wf_atom_b4a75eaa(
				rawItem.mXP,
				rawItem.mItemType
			)
			local ownedStatus = rawItem.mPolarized > 0 and "Forma" or v56 and "Max" or "Owned"

			if zawStoreItem == nil then
				local v58 = 10

				for j = 1, #rawItem.mModularParts do
					if
						__wf_atom_7e8ad928(rawItem.mModularParts[j])
						or not rawItem.mModularParts[j]:IsA(__wf_atom_0ed0314b)
					then
						continue
					end

					v58 = rawItem.mModularParts[j]:IsA(__wf_atom_0d68d4a6) and 2 or 3
					break
				end

				if v58 ~= 10 then
					for j = 1, #rawItem.mModularParts do
						if not rawItem.mModularParts[j]:IsA(__wf_atom_5314fe50) then
							continue
						end

						local __wf_atom_bff4fcf8 = Resource(rawItem.mModularParts[j]):__wf_atom_bff4fcf8()

						if __wf_atom_bff4fcf8 == 0 then
							zawStoreItem = module.Ternary(v58 == 2, v.primaryRifleType, v.secondaryRifleType)
							break
						end

						if __wf_atom_bff4fcf8 == 1 then
							zawStoreItem = module.Ternary(v58 == 2, v.primaryShotgunType, v.secondaryShotgunType)
							break
						end

						if __wf_atom_bff4fcf8 == 2 then
							zawStoreItem = module.Ternary(v58 == 2, v.primarySniperType, v.secondarySniperType)
							break
						end

						if __wf_atom_bff4fcf8 == 3 then
							zawStoreItem = module.Ternary(v58 == 2, v.primaryLauncherType, v.secondaryLauncherType)
							break
						end

						if __wf_atom_bff4fcf8 ~= 4 then
							break
						end

						zawStoreItem = module.Ternary(v58 == 2, v.primaryBeamType, v.secondaryBeamType)
						break
					end
				end
			end

			table.insert(result, {
				OwnedStatus = ownedStatus,
				Polarized = rawItem.mPolarized,
				Name = module.Ternary(rawItem.mItemName ~= "", rawItem.mItemName, nil),
				StoreItem = zawStoreItem,
				RawItem = rawItem
			})
		end

		return result
	end,
	GetWeaponConfigs = function()
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			return false
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			return false
		end

		local __wf_atom_a4299765 = __wf_atom_9be88b01:__wf_atom_a4299765()
		local result = {}

		for _, mLoadoutType in ipairs({ 0, 1 }) do
			local v55 = false

			for i = 0, SF.__wf_atom_c537ab75 do
				local __wf_atom_d21f18f2 = __wf_atom_a4299765:__wf_atom_d21f18f2(mLoadoutType, i)

				if __wf_atom_7e8ad928(__wf_atom_d21f18f2.mItem.mItemType) then
					continue
				end

				v55 = i == 0 or v55

				if not v55 then
					continue
				end

				local v56 = Resource(__wf_atom_d21f18f2.mItem.mItemType)

				if not __wf_atom_7e8ad928(v56) then
					table.insert(result, {
						mName = mMovie:__wf_atom_8e9ac384(v56:__wf_atom_014a76a2():c_str(), false),
						mStoredItem = __wf_atom_d21f18f2,
						mLoadoutType = mLoadoutType,
						mLoadoutSlot = i
					})
				end
			end
		end

		return result
	end,
	CanLink = function()
		return not __wf_atom_7e8ad928(gRegion)
			and gRegion:IsMaster()
			and not __wf_atom_7e8ad928(gGameRules)
			and (gGameRules:IsA(__wf_atom_311a7128) or gGameRules:__wf_atom_95862cc1())
	end
}

local function fn39(msg, currItemString, p, p2)
	local v54 = currItemString:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
	v8.Msg = string.gsub(msg, "%[" .. v54 .. "%]", "[" .. p .. "]", 1)
	local v55 = "{" .. p .. "}"
	p2[v55] = module.Ternary(p2[v55] == nil, 0, p2[v55]) + 1

	if mWindow.mActivePanelName ~= "" then
		local mMaxMsgLength = mWindow.mInputPanel.mMaxMsgLength
		mWindow.mInputPanel.mMaxMsgLength = mWindow.mInputPanel.MAX_MSG_LIMIT

		if not mWindow.mPanelList[mWindow.mActivePanelName]:OnMessageSent() then
			mMovie:__wf_atom_50d60589(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36, "")
		end

		mWindow.mInputPanel.mMaxMsgLength = mMaxMsgLength
	end
end

function RecursiveOmegaReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.OmegaLinks)
end

function RecursiveSongReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.SongLinks)
end

function RecursiveZawReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.ZawLinks)
end

function RecursiveAmpReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.AmpLinks)
end

function RecursiveMoaPetReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.MoaPetLinks)
end

function RecursiveKDriveReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.KdriveLinks)
end

function RecursiveKitgunReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.KitgunLinks)
end

function RecursiveAppearanceReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.AppearanceLinks)
end

function RecursiveModConfigReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.ModConfigLinks)
end

function RecursiveShawzinReplace(p)
	fn39(v8.Msg, v8.CurrItemString, p, v8.ShawzinLinks)
end

local function fn40(value, p)
	local activePanel = mWindow:GetActivePanel()

	if __wf_atom_7e8ad928(activePanel) then
		return true
	end

	local time2 = __wf_atom_c4e218a2()
	local v55 = p == activePanel.mParent.mPanelShortcuts[mWindow.CHANNEL_TRADE]

	if v55 and _G.TradeSpamBlockTime ~= nil then
		if time2 - _G.TradeSpamBlockTime > v3.TRADE_SPAM_DETECTION_PERIOD then
			_G.TradeSpamBlockTime = nil
			activePanel.mSpamBlockTime = nil
		else
			activePanel.DisplaySpamMessage(activePanel, true)
			return true
		end
	elseif activePanel.mSpamBlockTime ~= nil then
		if time2 - activePanel.mSpamBlockTime > v3.SPAM_LOCKOUT_TIME then
			activePanel.mSpamBlockTime = nil
		else
			activePanel.DisplaySpamMessage(activePanel, false)
			return true
		end
	end

	local message = string.lower(value)
	local v57 = { "%s+", "%p+" }

	for i = 1, #v57 do
		message = string.gsub(message, v57[i], "")
	end

	for i = 97, 122 do
		local v58 = string.char(i)
		message = string.gsub(message, v58 .. v58 .. "+", v58)
	end

	local v58 = nil

	if not v55 then
		for i = 1, #activePanel.mLastMessageData do
			local v59 = activePanel.mLastMessageData[i]

			if not (message == v59.Message and time2 - v59.Time < v3.SPAM_REPEATED_MESSAGE_DETECTION_PERIOD) then
				continue
			end

			v58 = math.max(1, (math.floor(0.5 + (v3.SPAM_REPEATED_MESSAGE_DETECTION_PERIOD - (time2 - v59.Time)))))
			break
		end
	end

	if
		p ~= activePanel.mParent.mPanelShortcuts[mWindow.CHANNEL_GLOBAL]
		and p ~= activePanel.mParent.mPanelShortcuts[mWindow.CHANNEL_RECRUITING]
		and not v55
	then
		return false
	end

	if v58 == nil then
		local ternary = module.Ternary(v55, v3.TRADE_MSGS_PER_PERIOD, v3.MSGS_PER_PERIOD)

		if ternary <= #activePanel.mLastMessageData then
			table.remove(activePanel.mLastMessageData, 1)
		end

		table.insert(activePanel.mLastMessageData, { Message = message, Time = time2 })

		if ternary <= #activePanel.mLastMessageData then
			local time = activePanel.mLastMessageData[1].Time
			local v59 = time2 - time

			if v55 then
				if v59 < v3.TRADE_SPAM_DETECTION_PERIOD then
					_G.TradeSpamBlockTime = time
					activePanel.mSpamBlockTime = time
					activePanel.mLastMessageData = {}
				end
			elseif v59 < v3.SPAM_DETECTION_PERIOD then
				activePanel.mSpamBlockTime = time
				activePanel.mLastMessageData = {}
			end
		end
	else
		if not __wf_atom_7e8ad928(activePanel) then
			activePanel:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_DupMessageBlock", false, {
				TIME = tostring(v58)
			}))
		end

		return true
	end

	return false
end

local function fn41(p)
	local v54 = string.sub(mWindow:GetActivePanel().mChannelName, 1, 1)
	local v55 = {
		G = "/Lotus/Language/Menu/Chat_GlobalTitle",
		Q = "/Lotus/Language/Menu/Chat_QandATitle",
		R = "/Lotus/Language/Menu/Chat_RecruitingTitle",
		T = "/Lotus/Language/Menu/Chat_TradeTitle",
		D = "/Lotus/Language/Menu/Chat_CouncilTitle",
		H = "/SF/Language/Menu/Chat_HubTitle"
	}

	if p == nil then
		return ""
	end

	if v55[v54] == nil then
		return (mMovie:__wf_atom_8e9ac384(p, false))
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v55[v54], false)
	return (mMovie:__wf_atom_8e9ac384(p, false, { CHANNEL = __wf_atom_8e9ac384 }))
end

local function fn42(user, p)
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()
	local activePanel = mWindow:GetActivePanel()
	local v54 = "#" .. activePanel.mChannelName
	__wf_atom_7190444e:__wf_atom_dde77296(v54, user, (fn41(p)))
	activePanel:_removeUserMsgs(user)
	mGameData:__wf_atom_0500a65b(user, v54)
end

local function fn43(p, p2, p3, p4, p5)
	local activePanel = mWindow:GetActivePanel()
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()
	local v54 = "#" .. activePanel.mChannelName
	v49 = nil
	local flag2 = true
	local v55 = ""

	if activePanel.mChannelType == mWindow.CHANNEL_CLAN then
		local __wf_atom_ca48a66f = mGameData:__wf_atom_ca48a66f()

		for i = 1, #__wf_atom_ca48a66f do
			if __wf_atom_ca48a66f[i].mDisplayName ~= p then
				continue
			end

			if __wf_atom_ca48a66f[i].mRank ~= 1 then
				break
			end

			flag2 = false
			v55 = "/Lotus/Language/Menu/Chat_KickWarlordFromClanError"
			break
		end
	end

	if v31 ~= nil then
		flag2 = false
		v55 = "/Lotus/Language/Menu/Chat_KickInProgress"
	end

	if flag2 then
		if p2 then
			__wf_atom_7190444e:Kick(p, v54, p5)
		else
			__wf_atom_7190444e:Ban(p, v54, p3, 0, p4, p5)
		end
	elseif v55 ~= "" then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(v55, false))
	end
end

function ConfirmModeratorKickBan(p)
	if tonumber(p) == 4 then
		fn43(v49.NAME, v49.KICK, v49.DURATION, v49.REASON, v49.MSG)
	end
end

local function fn44(user, p, duration)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Chat_ConfirmModeratorKick", false, {
		NAME = user
	})

	if not p then
		__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Chat_ConfirmModeratorBan", false, {
			NAME = user,
			DURATION = duration
		})
	end

	module.ShowYesOrNoMessage(__wf_atom_8e9ac384, "ConfirmModeratorKickBan")
end

local function fn45(user, p, kick, duration, p2)
	if __wf_atom_7e8ad928(user) and not __wf_atom_7e8ad928(elementById) then
		user = elementById.User
	end

	local activePanel = mWindow:GetActivePanel()
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

	if __wf_atom_7e8ad928(user) or __wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(__wf_atom_7190444e) then
		return
	end

	if v49 ~= nil or v31 ~= nil then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_KickInProgress", false))
		return
	end

	local msg = fn41(p2)

	if p then
		user = Engine.__wf_atom_ba49d4ed(user)
	end

	if activePanel.mChannelType ~= mWindow.CHANNEL_CLAN and activePanel.mChannelType ~= mWindow.CHANNEL_ALLIANCE then
		fn43(user, kick, duration, "", msg)
		return
	end

	v49 = {
		NAME = user,
		KICK = kick,
		DURATION = duration,
		REASON = "",
		MSG = msg
	}
	fn44(user, kick, duration)
end

local function fn46(p)
	if p == nil then
		v49 = nil
	else
		fn43(p.Name, v49.KICK, v49.DURATION, v49.REASON, v49.MSG)
	end
end

function KickIDResult(p, p2)
	local v54, v55, v56 = fn5(p, p2, false)

	if #v54 == 0 then
		local activePanel = mWindow:GetActivePanel()

		if not (__wf_atom_7e8ad928(activePanel) or v56) then
			local v57

			if v55 then
				v57 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/CannotKickSelf", false)
			else
				v57 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/NoOnlineUser", false, {
					USER = v49.NAME
				})
			end

			activePanel:SystemMessage(v57)
		end

		v49 = nil
	elseif #v54 == 1 then
		fn43(v54[1].Name, v49.KICK, v49.DURATION, v49.REASON, v49.MSG)
	else
		fn6(v54, fn46)
	end
end

local function fn47(user, mChannelName)
	if __wf_atom_7e8ad928(user) and not __wf_atom_7e8ad928(elementById) then
		user = elementById.User
	end

	local v54 = mMovie:__wf_atom_5e6e15c8("_root", 30) + 4
	local v55 = mMovie:__wf_atom_5e6e15c8("_root", 31) - 4
	mContextMenu:RemoveElements(true, true)
	local v56 = { "Caps", "Spam", "Topic", "Abuse", "UsePrivateMessages" }
	local v57 = string.sub(mChannelName, 1, 1)

	if v57 == "T" then
		table.insert(v56, "TradeEULA")
	else
		table.insert(v56, "Trading")
	end

	if v57 ~= "R" then
		table.insert(v56, "Recruiting")
	end

	if v57 ~= "G" then
		table.insert(v56, "UseRegion")
	end

	mContextMenu:AddElement({
		Name = "/Lotus/Language/IRC/Silent",
		PressedCallback = function()
			fn42(user, nil)
		end
	}, true)

	for i = 1, #v56 do
		local name = "/Lotus/Language/IRC/" .. v56[i]
		local v59 = "/Lotus/Language/IRC/Flush_" .. v56[i]
		mContextMenu:AddElement({
			Name = name,
			PressedCallback = function()
				fn42(user, v59)
			end
		}, true)
	end

	fn23(v54, v55)
	return false
end

local function fn48(user, mChannelName)
	if __wf_atom_7e8ad928(user) and not __wf_atom_7e8ad928(elementById) then
		user = elementById.User
	end

	local v54 = mMovie:__wf_atom_5e6e15c8("_root", 30) + 4
	local v55 = mMovie:__wf_atom_5e6e15c8("_root", 31) - 4
	mContextMenu:RemoveElements(true, true)
	mContextMenu:AddElement({
		Name = "/Lotus/Language/IRC/Silent",
		PressedCallback = function()
			fn45(user, false, false, "5m")
		end
	}, true)
	local v56 = { "Caps", "Spam", "Topic", "Abuse", "UsePrivateMessages" }
	local v57 = string.sub(mChannelName, 1, 1)

	if v57 == "T" then
		table.insert(v56, "TradeEULA")
	else
		table.insert(v56, "Trading")
	end

	if v57 ~= "R" then
		table.insert(v56, "Recruiting")
	end

	if v57 ~= "G" then
		table.insert(v56, "UseRegion")
	end

	for i = 1, #v56 do
		local name = "/Lotus/Language/IRC/" .. v56[i]
		local v59 = "/Lotus/Language/IRC/Kicked_" .. v56[i]
		mContextMenu:AddElement({
			Name = name,
			PressedCallback = function()
				fn45(user, false, false, "5m", v59)
			end
		}, true)
	end

	fn23(v54, v55)
	return false
end

local function fn49(p)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mInSubScreen = p

	if Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(_T.SetButtonBarEnabled) then
		if p then
			_T.SetButtonBarEnabled(true)
		else
			_T.SetButtonBarEnabled(mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE)
		end
	end

	local v54 = mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
	local v55 = p or v54 or mChatHidden
	mInputBlocked = p
	mMovie:__wf_atom_c884ca43(v55)
	mMovie:__wf_atom_b4ffb30f(not v55)
	mMovie:__wf_atom_e57658c2("_root", 12, module.Ternary(p, 0, 100))
	local ternary = module.Ternary(
		not p and Engine.IsPlayingWithController() and _T.TopMenuOpen and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL,
		0.6,
		0
	)
	mMovie:__wf_atom_0cf0fdbe(ternary)
end

function BanPlayer()
	local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

	if __wf_atom_7e8ad928(__wf_atom_7190444e) then
		v31 = nil
		return
	end

	__wf_atom_7190444e:Ban(v31.Name, v31.ChannelName, v31.Duration, v31.Mode, v31.Reason, v31.Message)
	v31 = nil
end

local function fn50(user, p)
	local reason

	if __wf_atom_7e8ad928(user) and not __wf_atom_7e8ad928(elementById) then
		user = elementById.User
		reason = module.Ternary(elementById.Reason ~= nil, elementById.Reason, "")
	else
		reason = ""
	end

	if __wf_atom_7e8ad928(user) then
		return
	end

	if p then
		user = Engine.__wf_atom_ba49d4ed(user)
	end

	if v31 ~= nil then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_KickInProgress", false))
		return
	end

	if not __wf_atom_7e8ad928(mChildMovie) then
		mChildMovie:Close()
	end

	fn49(true)
	mChildMovie = mMovie:PushChildMovie(Resource(genericSettingsMovie))
	mChildMovie:Execute(
		"SetTitle",
		mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanPlayer", true, { NAME = user })
	)
	mChildMovie:Execute("SetConfirmButtonActive", "true")

	function _T.BanPlayerSettingsDone(list, p2)
		_T.BanPlayerSettingsDone = nil
		_T.GetSettings = nil
		fn49(false)

		if not __wf_atom_7e8ad928(p2) then
			return
		end

		if user ~= nil and user ~= "" then
			local activePanel = mWindow:GetActivePanel()
			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if
				__wf_atom_7e8ad928(activePanel)
				or __wf_atom_7e8ad928(__wf_atom_7190444e)
				or (activePanel.mChannelType == mWindow.CHANNEL_CLAN or activePanel.mChannelType == mWindow.CHANNEL_ALLIANCE)
			then
				return
			end

			v31 = {
				Name = user,
				Kick = false,
				Mode = list[1].mValue,
				Duration = list[2].mValue,
				ChannelName = "#" .. activePanel.mChannelName,
				Reason = reason,
				Message = ""
			}
			mMovie:Execute("BanPlayer", "")
		end
	end

	mChildMovie:Execute("SetCallBack", "BanPlayerSettingsDone")

	function _T.GetSettings()
		return {
			{
				mLabel = "/Lotus/Language/Menu/Chat_BanMenu_Mode",
				mType = module3.TOGGLE,
				mValue = 0,
				mToggleValues = {
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanOption_Channel", false),
						Value = 0
					},
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanOption_Id", false),
						Value = 1
					},
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanOption_Ip", false),
						Value = 3
					}
				}
			},
			{
				mLabel = "/Lotus/Language/Menu/Chat_BanMenu_Duration",
				mType = module3.TOGGLE,
				mValue = "1h",
				mToggleValues = {
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanDuration_1H", false),
						Value = "1h"
					},
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanDuration_1D", false),
						Value = "1d"
					},
					{
						Label = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_BanDuration_1W", false),
						Value = "1w"
					}
				}
			}
		}
	end

	mChildMovie:Execute("SetElementsFunction", "GetSettings")
end

fn6 = function(list, fn51)
	if not __wf_atom_7e8ad928(mChildMovie) then
		mChildMovie:Close()
	end

	fn49(true)
	mChildMovie = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(mChildMovie) then
		mInputBlocked = true
		mChildMovie:Execute("SetTitle", "/Lotus/Language/Chat/PlayerSelection")
		mChildMovie:__wf_atom_f62a8704("SetTitleCaseText", { "false", "true" })

		function _T.PlayerSelectionDone(list2)
			_T.PlayerSelectionDone = nil
			_T.GetPlayerList = nil
			mInputBlocked = false
			fn49(false)

			if __wf_atom_7e8ad928(list2) or list2[1] == nil then
				fn51(nil)
			else
				fn51(list2[1].mChatMember)
			end
		end

		mChildMovie:Execute("SetCallBack", "PlayerSelectionDone")

		function _T.GetPlayerList()
			local result = {}

			for i = 1, #list do
				table.insert(result, {
					mName = Engine.__wf_atom_1b118af6(list[i].Name),
					mChatMember = list[i]
				})
			end

			return result
		end

		mChildMovie:Execute("SetElementsFunction", "GetPlayerList")
	end
end

local function fn51(value)
	local v54 = string.sub(value, 1, 1)
	return v54 == "G" or v54 == "R" or v54 == "T" or v54 == "D" or v54 == "H" or v54 == "O" or v54 == "Q"
end

local function fn52(p)
	if p == 6 or p == 7 then
		return 4
	end

	return 3
end

local function fn53(list, p)
	local v54 = { modularStrikes, modularGrips, modularLinks }
	local v55

	if p == 6 then
		v55 = { modularMoaPetLegs, modularMoaPetHeads, modularMoaPetEngines, modularMoaPetPayloads }
	elseif p == 7 then
		v55 = { modularKDriveDecks, modularKDriveEngines, modularKDriveFronts, modularKDriveJets }
	elseif p == 1 then
		v55 = { ampBarrels, ampChasis, ampGrips }
	else
		v55 = (p == 2 or p == 3) and { modularGunHandles, modularGunBarrels, modularGunClips } or v54
	end

	local v56 = { Gild = false, Parts = {} }

	if #list < fn52(p) then
		print("ChatRedux::ModularLink: DecodeModularWeapon did not return the correct number of parts.")
		return
	end

	v56.Gild = tonumber(list[1]) == 1

	for i = 1, #v55 do
		local v57 = v55[i]
		local v58 = tonumber(list[i + 1])

		if v58 == nil or #v57 <= v58 then
			print("ChatRedux::ModularLink: Index could not be found in part table.")
			return
		else
			table.insert(v56.Parts, v57[v58 + 1])
		end
	end

	return v56
end

function LinkAppearance()
	if __wf_atom_7e8ad928(_T.AppearanceStoredItem) then
		return
	end

	local cachedAppearanceLink = module11.ConstructAppearanceLink(
		_T.AppearanceStoredItem.StoredItem,
		_T.AppearanceStoredItem.LoadOutType,
		_T.AppearanceStoredItem.LoadOutSlot
	)

	if not cachedAppearanceLink then
		return
	end

	v8.CachedAppearanceLink = cachedAppearanceLink
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v15.APPEARANCE_STRING_LOC, false)

	if not string.find(__wf_atom_387f260e, "%[" .. __wf_atom_8e9ac384 .. "%]") then
		local v55 = __wf_atom_387f260e .. " [" .. __wf_atom_8e9ac384 .. "]"
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 36, v55)
	end

	_T.AppearanceStoredItem = nil
	module.PlaySound(_G.UISound_Select)

	if fn33() then
		fn2()
	end
end

function LinkModConfig()
	if __wf_atom_7e8ad928(_T.ModConfigStoredItem) then
		return
	end

	local cachedModConfigLink = module11.ConstructModLink(
		_T.ModConfigStoredItem.StoredItem,
		_T.ModConfigStoredItem.LoadOutType,
		_T.ModConfigStoredItem.LoadOutSlot
	)

	if not cachedModConfigLink then
		return
	end

	v8.CachedModConfigLink = cachedModConfigLink
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v15.MOD_CONFIG_STRING_LOC, false)

	if not string.find(__wf_atom_387f260e, "%[" .. __wf_atom_8e9ac384 .. "%]") then
		local v55 = __wf_atom_387f260e .. " [" .. __wf_atom_8e9ac384 .. "]"
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 36, v55)
	end

	_T.ModConfigStoredItem = nil
	module.PlaySound(_G.UISound_Select)

	if fn33() then
		fn2()
	end
end

function LinkShawzin()
	if __wf_atom_7e8ad928(_G.RecordedSong) then
		return
	end

	v8.CachedShawzinLink = "SHZN-" .. _G.RecordedSong
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v15.SHAWZIN_STRING_LOC, false)

	if not string.find(__wf_atom_387f260e, "%[" .. __wf_atom_8e9ac384 .. "%]") then
		local v54 = __wf_atom_387f260e .. " [" .. __wf_atom_8e9ac384 .. "]"
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 36, v54)
	end

	module.PlaySound(_G.UISound_Select)

	if fn33() then
		fn2()
	end
end

local function fn54(mParent, value, mChannelType, mFriendlyName, mIsChatEnabled)
	local v54 = {
		MESSAGE_TYPE_INVALID = -1,
		MESSAGE_TYPE_REGION = 0,
		MESSAGE_TYPE_CLAN = 1,
		MESSAGE_TYPE_SQUAD = 2,
		MESSAGE_TYPE_TRADE = 3,
		MESSAGE_TYPE_HUB = 4,
		MESSAGE_TYPE_JOIN_CHANNEL = 5,
		MESSAGE_TYPE_LEAVE_CHANNEL = 6,
		MESSAGE_TYPE_COUNCIL = 7,
		MESSAGE_TYPE_SYSTEM = 8,
		MESSAGE_TYPE_BROADCAST = 9,
		MESSAGE_TYPE_RECRUITING = 10,
		MESSAGE_TYPE_ALLIANCE = 11,
		MESSAGE_TYPE_FRIEND = 12,
		MESSAGE_TYPE_INGAME_WHISPER = 13,
		MESSAGE_TYPE_NOTIFICATION = 14,
		MESSAGE_TYPE_STAFF = 15,
		MESSAGE_TYPE_WG_MOD = 16,
		mParent = mParent,
		mIsActive = false,
		mIsChatEnabled = mIsChatEnabled,
		mIsFlashingEnabled = mChannelType ~= mWindow.CHANNEL_GLOBAL and mChannelType ~= mWindow.CHANNEL_RECRUITING and mChannelType ~= mWindow.CHANNEL_TRADE and mChannelType ~= mWindow.CHANNEL_QA,
		mCanFlash = false
	}
	local v56 = string.gsub(value, "#", "")
	v54.mFriendlyName = mFriendlyName
	v54.mChannelName = v56
	v54.mClipName = v56
	v54.mClipTemplate = mParent.mClipName .. ".TabbedChatPanel"
	v54.mClipPath = v54.mClipTemplate
	v54.mUserList = {}
	v54.mChatHistory = {}
	v54.mHasHyperlink = false
	v54.mRegularMessageCount = 0
	v54.mMaxVisibleChatLines = 0
	v54.mMaxChatHistory = 200
	v54.mTextScroll = nil
	v54.mScrollBack = 0
	v54.mCachedLines = {}
	v54.mChannelType = 0
	v54.mLastMessageData = {}
	v54.mSpamBlockTime = nil
	v54.mStoredFocusIndex = nil
	v54.mPreviousPresState = nil
	v54.mAlphabetIndex = {}

	function v54:ClearHistory()
		self.mChatHistory = {}
		self.mHasHyperlink = false
	end

	function v54:PopulateFilterList()
		mWindow.mFilterList:RemoveElements(true, true)

		if not __wf_atom_7e8ad928(mProfileSettings) then
			print("Chat: Filters for " .. self.mChannelName .. ":")
			local __wf_atom_0cff5ea1 = mProfileSettings:__wf_atom_0cff5ea1((string.sub(self.mChannelName, 1, 1)))
			local v57 = __wf_atom_d99ae0ec("[" .. mMovie:__wf_atom_8e9ac384(v15.APPEARANCE_STRING_LOC, false) .. ":")
			local v58 = __wf_atom_d99ae0ec("[" .. mMovie:__wf_atom_8e9ac384(v15.MOD_CONFIG_STRING_PREFIX, false) .. ":")
			local v59 = __wf_atom_d99ae0ec("[" .. mMovie:__wf_atom_8e9ac384(v15.SHAWZIN_STRING_LOC, false) .. ":")

			for i = 1, #__wf_atom_0cff5ea1 do
				local filter = __wf_atom_d99ae0ec(__wf_atom_0cff5ea1[i].filter)
				local label

				if filter == "[ff-" then
					label = v57
				elseif filter == "[mod-" then
					label = v58
				elseif filter == "[song-" then
					label = v59
				else
					label = filter
				end

				local v62 = {
					Label = label,
					Filter = filter,
					Include = __wf_atom_0cff5ea1[i].include
				}
				mWindow.mFilterList:AddElement(v62, true)
				print("Filter: " .. v62.Filter .. ", " .. module.Ternary(v62.Include, "Include", "Exclude"))
			end
		end

		mWindow.mFilterList:Redraw(nil, nil, true)
	end

	function v54:Initialize(_, _)
		self.mChannelType = mChannelType
		local module16 = require("SF.Interface.Components.Scrollbar")

		if self.mTextScroll == nil then
			self.mTextScroll = module16.CreateScrollBar(getfenv(1), self.mClipPath .. ".ScrollBar", {
				mEnableSmoothScroll = false
			})
		end

		self.mTextScroll.mInitialY = 0
		self.mTextScroll.mInitialHitzoneScaleX = mWindow.mInitChatPanelScrollXScale or 1

		function self.mTextScroll.mScrollValueChangedCallback(p, _)
			local v57 = #self.mChatHistory - self.mMaxVisibleChatLines
			self.mScrollBack = __wf_atom_421b01aa(module.Round(v57 * (1 - p)), 0, v57)

			if self.mIsActive then
				self:RefreshText()
			end
		end

		self.mTextScroll._TextScroll_StartDrag = self.mTextScroll.StartDrag

		function self.mTextScroll.StartDrag(_)
			local activePanel = mWindow:GetActivePanel()

			if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(activePanel.mTextScroll)) then
				activePanel.mTextScroll:_TextScroll_StartDrag()
			end
		end

		self.mTextScroll._TextScroll_StopDrag = self.mTextScroll.StopDrag

		function self.mTextScroll.StopDrag(_)
			local activePanel = mWindow:GetActivePanel()

			if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(activePanel.mTextScroll)) then
				activePanel.mTextScroll:_TextScroll_StopDrag()
			end
		end

		self.mTextScroll._TextScroll_ClickScrollBar = self.mTextScroll.ClickScrollBar

		function self.mTextScroll.ClickScrollBar(_)
			local activePanel = mWindow:GetActivePanel()

			if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(activePanel.mTextScroll)) then
				activePanel.mTextScroll:_TextScroll_ClickScrollBar()
			end
		end

		self.mTextScroll:OnGamepadTransition(not Engine.IsPlayingWithController())
		self.mTextScroll:ScrubRollOut()
		self.mTextScroll:SetScrollValue(1)
	end

	function v54:Update(p)
		if not __wf_atom_7e8ad928(self.mTextScroll) then
			self.mTextScroll:Update(p)
		end

		if self.queuedBroadcastMessage then
			self:_onLineAdded(self.queuedBroadcastMessage, self.MESSAGE_TYPE_BROADCAST, "")
			self.queuedBroadcastMessage = nil
		end
	end

	function v54:OnMessageSent(p)
		if __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0))) or not self.mIsChatEnabled then
			return
		end

		local v57, v58, v59 = fn37(p, false)

		if v57 == "" or __wf_atom_7e8ad928(v57) then
			return
		end

		if string.len(v57) > self.mParent.mInputPanel.mMaxMsgLength then
			if self.mParent.mInputPanel.mMaxMsgLength == self.mParent.mInputPanel.MAX_MSG_LIMIT then
				self:_onLineAdded(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ExceededMsgIRCLengthLimitError", false),
					self.MESSAGE_TYPE_SYSTEM,
					""
				)
			else
				self:_onLineAdded(
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ExceededMsgLengthLimitError", false, {
						LIMIT = self.mParent.mInputPanel.mMaxMsgLength
					}),
					self.MESSAGE_TYPE_SYSTEM,
					""
				)
			end

			module.PlaySound(_G.UISound_Error)
			self.mParent.mInputPanel.CharLimitFlashTime = 2.5
			return true
		else
			local function fn55(items)
				local total = 0

				for _, item in pairs(items) do
					total += item
				end

				return total
			end

			fn19(v57)
			local v60 = __wf_atom_c4e218a2()
			local v61 = 1
			local _ = v61 < #v57

			if
				fn55(v8.OmegaLinks) > 0
				or fn55(v8.SongLinks) > 0
				or fn55(v8.ZawLinks) > 0
				or fn55(v8.AmpLinks) > 0
				or fn55(v8.MoaPetLinks) > 0
				or fn55(v8.KdriveLinks) > 0
				or fn55(v8.KitgunLinks) > 0
				or fn55(v8.AppearanceLinks) > 0
				or fn55(v8.ModConfigLinks) > 0
				or fn55(v8.ShawzinLinks) > 0
			then
				v58 = {}
				v59 = {}

				if not __wf_atom_7e8ad928(v57) and v57 ~= "" then
					fn36(v57, v58, v59)
				end
			end

			if v8.GuildReplacement or not string.find(v57, "{GUILD=.*}") then
				if not v8.GuildReplacement and mWindow.mCachedGuildId ~= nil and mWindow.mCachedGuildId ~= "" then
					v61 = 1

					while v61 < #v57 do
						local v62, v63 = string.find(v57, "{[^%]%[{}]*}", v61)

						if not v62 then
							break
						end

						local v64 = string.sub(v57, v62 + 1, v63 - 1)
						local v65 = string.lower(v64)
						local v66, _ = module2.RemoveNumericSuffixFromName(mGameData:__wf_atom_84083b39())

						if
							v65 ~= string.lower(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ClanTitle", false))
							and v65 ~= string.lower(v66)
						then
							v66 = nil
						end

						if v66 then
							local v67 = v64:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
							v57 = string.gsub(
								v57,
								"{" .. v67 .. "}",
								"{GUILD=" .. mWindow.mCachedGuildId .. ":" .. v66 .. "}",
								1
							)
							v8.GuildReplacement = true
						end

						v61 = v63 + 1
					end

					if v8.GuildReplacement and mWindow.mActivePanelName ~= "" then
						v8.Msg = v57
						local mMaxMsgLength = self.mParent.mInputPanel.mMaxMsgLength
						self.mParent.mInputPanel.mMaxMsgLength = self.mParent.mInputPanel.MAX_MSG_LIMIT

						if not mWindow.mPanelList[mWindow.mActivePanelName]:OnMessageSent() then
							mMovie:__wf_atom_50d60589(mWindow.mInputPanel.mClipPath .. ".MessageBox", 36, "")
						end

						self.mParent.mInputPanel.mMaxMsgLength = mMaxMsgLength
						return
					end
				end

				v8.GuildReplacement = false
				local v62 = "#" .. self.mChannelName
				local count = #v58
				v58[1] = string.lower(v58[1])
				local activePanel = mWindow:GetActivePanel()
				local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

				local function fn56()
					v61 = 1

					while v61 < #v57 do
						local v63, v64 = string.find(v57, "%[[^%]%[]*%]", v61)

						if not v63 then
							break
						end

						local itemname = string.sub(v57, v63 + 1, v64 - 1)
						local v66 = "{" .. itemname .. "}"

						if
							itemname == ""
							or __wf_atom_7e8ad928(nil)
							or (nil):__wf_atom_ce963400(itemname, true) == ""
						then
							if
								v8.OmegaLinks[v66] == nil
								and v8.SongLinks[v66] == nil
								and v8.ZawLinks[v66] == nil
								and v8.AmpLinks[v66] == nil
								and v8.MoaPetLinks[v66] == nil
								and v8.KdriveLinks[v66] == nil
								and v8.KitgunLinks[v66] == nil
								and v8.AppearanceLinks[v66] == nil
								and v8.ModConfigLinks[v66] == nil
								and v8.ShawzinLinks[v66] == nil
								and itemname ~= "DE"
							then
								local activePanel2 = mWindow:GetActivePanel()

								if not __wf_atom_7e8ad928(activePanel2) then
									activePanel2:SystemMessage(mMovie:__wf_atom_8e9ac384(
										"/Lotus/Language/Menu/Chat_InvalidLinkedItem",
										false,
										{ ITEMNAME = itemname }
									))
								end

								return false
							else
								v61 = v64 + 1
							end
						else
							local v67 = TitleCase(itemname)
							local v68 = itemname:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
							v57 = string.gsub(v57, "%[" .. v68 .. "%]", "[" .. v67 .. "]")
							v61 = v64 + 1
						end
					end

					return true
				end

				local flag2 = false

				if (v58[1] == "/w" or v58[1] == "/whisper") and not _G.StalkerMode then
					if not fn56() then
						module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
					elseif count >= 3 then
						local from = v59[2]

						if module.GetInvalidNameCharacters(from, v16) == 0 then
							local _, v64 = string.find(v57, v58[2] .. " ", 0, true)

							if v64 == nil then
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								return
							end

							local v65 = v64 + 1
							v57 = string.sub(v57, v65, -1)

							if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
								v5.Text = v57
								v5.From = from
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								__wf_atom_7190444e:Who(from, "PrivateConvoPlayerIDResultOutgoing")
							end
						else
							self:_onLineAdded(
								mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/SocialOverlay_NonExistentUserError",
									false
								),
								self.MESSAGE_TYPE_SYSTEM,
								""
							)
						end
					else
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpWhisper", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
					end
				else
					if v58[1] == "/s" then
						v62 = self.mParent.mPanelShortcuts[mWindow.CHANNEL_SESSION]

						if v62 == nil then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						self.mParent:SwitchModes(mWindow.CHANNEL_SESSION)

						if not (count > 1) then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						local _, v63 = string.find(v57, " ")

						if v63 == nil then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						local v64 = v63 + 1
						v57 = string.sub(v57, v64, -1)
						module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
					elseif v58[1] == "/g" then
						v62 = self.mParent.mPanelShortcuts[mWindow.CHANNEL_GLOBAL]

						if v62 == nil then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						self.mParent:SwitchModes(mWindow.CHANNEL_GLOBAL)

						if not (count > 1) then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						local _, v63 = string.find(v57, " ")

						if v63 == nil then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							return
						end

						module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
						local v64 = v63 + 1
						v57 = string.sub(v57, v64, -1)
					elseif v58[1] == "/?" or v58[1] == "/help" or v58[1] == "/h" then
						module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpGlobal", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpSquad", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpWhisper", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpIgnore", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpTabSwitch", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_AddFriendHelp_Windows", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_RemoveFriendHelp", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpInvite", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpGoto", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpUnstuck", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpJoin", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/Chat_HelpDND", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/Chat_HelpNormal", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)
						self:_onLineAdded(
							mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpUserLink", false),
							self.MESSAGE_TYPE_SYSTEM,
							""
						)

						if Engine.__wf_atom_84bb79c2() then
							self:_onLineAdded(
								mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpGamertags", false),
								self.MESSAGE_TYPE_SYSTEM,
								""
							)
						end

						return
					elseif v58[1] == "/t" then
						module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
						self.mParent:cycleActiveTab(module.INCREMENT)
						return
					elseif v58[1] == "/i" or v58[1] == "/ignore" then
						if #v58 == 2 then
							if module.GetInvalidNameCharacters(v59[2], v16) == 0 then
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								self.mParent:ToggleIgnoreUser(v59[2], true)
							else
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
								mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/SocialOverlay_NonExistentUserError",
									false
								))
							end
						else
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
							self:_onLineAdded(
								mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpIgnore", false),
								self.MESSAGE_TYPE_SYSTEM,
								""
							)
						end

						return
					elseif (v58[1] == "/f" or v58[1] == "/friend") and not _G.StalkerMode then
						if #v58 < 3 or #v58 > 4 then
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_AddFriendHelp_Windows",
								false
							))
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_RemoveFriendHelp",
								false
							))
						elseif v58[2] == "a" or v58[2] == "add" then
							if module.GetInvalidNameCharacters(v59[3], v16) == 0 then
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								mPendingAddFriendMessage = v59[4] or ""
								module3.AddFriend(v59[3], "OnAddFriendResultToPanel", mPendingAddFriendMessage)
							else
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
								mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/SocialOverlay_NonExistentUserError",
									false
								))
							end
						elseif #v58 == 3 and (v58[2] == "r" or v58[2] == "remove") then
							if not __wf_atom_7e8ad928(mGameData) then
								module10.LogChatCommandUsed(
									v58[1] .. " " .. v58[2],
									module10.mChatCommandType.SuccessNormal
								)
								mGameData:__wf_atom_f5e50738(v59[3], "OnRemoveFriendResultToPanel")
							end
						else
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_AddFriendHelp_Windows",
								false
							))
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_RemoveFriendHelp",
								false
							))
						end

						return
					elseif (v58[1] == "/invite" or v58[1] == "/inv") and not _G.StalkerMode then
						if count == 2 then
							local v63 = v59[2]
							local v64 = module.GetInvalidNameCharacters(v63, v16) ~= 0
								and "/Lotus/Language/Menu/SocialOverlay_NonExistentUserError"
								or module6.CheckGameInvitePermission(nil, v63)

							if v64 then
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
								mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(v64, false))
							else
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								fn9(v63)
							end
						else
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_HelpInvite",
								false
							))
						end

						return
					elseif v58[1] == "/goto" then
						if not fn56() then
							return
						end

						if count == 2 and not __wf_atom_7e8ad928(mWindow.mUserPanel) then
							local v63 = string.upper(v58[2])
							local v64 = false

							for i = 1, #self.mAlphabetIndex do
								if v63 ~= v7[i] then
									continue
								end

								mWindow.mUserPanel:FocusElement(self.mAlphabetIndex[i])
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								v64 = true
								break
							end

							if not v64 then
								local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/Chat_GotoUnknownIndex",
									false,
									{ LETTER = v58[2] }
								)
								mWindow:SystemMessage(__wf_atom_8e9ac384)
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
							end
						else
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpGoto", false))
						end

						return
					else
						if v58[1] == "/unstuck" then
							fn38(v60)
							return
						end

						if v58[1] == "/join" or _G.StalkerMode and v58[1] == "/stalk" then
							if count == 2 then
								local v63

								if v32.InProgress then
									v63 = "/Lotus/Language/Menu/Chat_JoinInProgress"
								elseif module.GetInvalidNameCharacters(v59[2], v16) ~= 0 then
									v63 = "/Lotus/Language/Menu/SocialOverlay_NonExistentUserError"
								elseif module3.InQuestCommitment(gGameData) and module3.IsCampLevel() then
									v63 = "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
								else
									v63 = nil
								end

								if v63 then
									module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
									mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(v63, false))
								elseif not __wf_atom_7e8ad928(mGameData) then
									v32.InProgress = true
									v32.PlayerId = nil
									v32.PlayerName = ""
									v32.TempAddToChatPartners = false
									v32.Presence = nil
									local __wf_atom_cb06fe38 = mGameData:__wf_atom_cb06fe38()
									local v64 = string.lower(v59[2])

									for i = 1, #__wf_atom_cb06fe38 do
										local mDisplayName = string.lower(__wf_atom_cb06fe38[i].mDisplayName)

										if not (mDisplayName == v64 or Engine.__wf_atom_746f9d1b(mDisplayName) == v64) then
											continue
										end

										v32.PlayerId = __wf_atom_cb06fe38[i].mId
										v32.PlayerName = __wf_atom_cb06fe38[i].mDisplayName
										break
									end

									module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)

									if v32.PlayerId == nil then
										v32.PendingRequestName = v59[2]
										mGameData:__wf_atom_6a4bcc2b(v59[2], true, "JoinPlayerIDResult")
									else
										local playerId = v32.PlayerId

										if Engine.__wf_atom_84bb79c2() then
											playerId ..= "_" .. Engine.__wf_atom_940f8971(v32.PlayerName)
										end

										mGameData:__wf_atom_c7c2a30f({ playerId }, "OnGetPresenceForJoin")
									end
								end
							else
								mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/Chat_HelpJoin",
									false
								))
							end

							return
						elseif v58[1] == "/dnd" then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
							_G.mDoNotDisturb = not _G.mDoNotDisturb
							local v63 = "/Lotus/Language/SystemMessages/" .. module.Ternary(_G.mDoNotDisturb, "DoNotDisturb", "Normal")
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(v63, false))
							return
						elseif v58[1] == "/normal" then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
							_G.mDoNotDisturb = false
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/SystemMessages/Normal",
								false
							))
							return
						elseif
							v58[1] == "/deop"
							and not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(__wf_atom_7190444e))
						then
							if __wf_atom_7190444e:DeOperator("#" .. activePanel.mChannelName) then
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								mWindow:SystemMessage("DeOperator succeeded!")
							else
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.FailNormal)
								mWindow:SystemMessage("DeOperator failed.")
							end

							return
						elseif mCrossPlatformEnabled or v58[1] ~= "/kick" or #v58 ~= 2 then
							if
								mCrossPlatformEnabled
								or v58[1] ~= "/ban"
								or #v58 ~= 2
								or __wf_atom_7e8ad928(activePanel)
								or __wf_atom_7e8ad928(__wf_atom_7190444e)
								or not (__wf_atom_7190444e:__wf_atom_f5faa72a("#" .. activePanel.mChannelName) and fn51(activePanel.mChannelName))
							then
								local _ = v58[1] == "/itemlist"
								local _ = v58[1] == "/secretitemlist"

								if v58[1] == "/relaunch" and #v58 == 1 and not Engine.__wf_atom_fc67ba71() then
									module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
									__wf_atom_8e4fda44:__wf_atom_bcb70491(Resource("/EE/Editor/ToolMenus/Commands/CmdRelaunch"))
									return
								else
									flag2 = true
								end
							else
								module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
								fn50(v59[2], true)
								return
							end
						else
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.SuccessNormal)
							fn45(v59[2], true, false, "5m")
							return
						end
					end

					if not fn56() then
						return
					end

					if flag2 then
						local v63 = string.sub(v58[1], 1, 1)

						if v63 == "/" or v63 == "!" then
							module10.LogChatCommandUsed(v58[1], module10.mChatCommandType.UnknownCommand)
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_UnknownCommand",
								false
							) .. " " .. string.sub(v57, 2))
							mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
								"/Lotus/Language/Menu/Chat_HelpPrompt",
								false
							))
							return
						end
					end

					if _T.WareframeMiniGameChatCallback then
						return _T.WareframeMiniGameChatCallback(self, v57)
					end

					if fn40(v57, v62) then
						return true
					end

					if fn51(self.mChannelName) and (fn55(v8.AppearanceLinks) > 0 or fn55(v8.ModConfigLinks) > 0) then
						_G.Chat_GlobalLinkCooldown = __wf_atom_c4e218a2()
					end

					if
						string.sub(v62, 1, 1) == "#"
						and string.sub(v62, 2, 2) == mWindow._getPrivateChatChannelPrefix()
					then
						v62 = string.sub(self.mChannelName, 2)

						if not __wf_atom_7e8ad928(mGameData) and mGameData:__wf_atom_56f280e3(v62) then
							self:_onLineAdded(
								mMovie:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/Chat_CannotWhisperIgnoredPlayer",
									false,
									{ PLAYER_NAME = v62 }
								),
								self.MESSAGE_TYPE_SYSTEM,
								""
							)
							return
						end
					end

					if not (__wf_atom_7e8ad928(__wf_atom_7190444e) or _G.StalkerMode) then
						__wf_atom_7190444e:__wf_atom_e3bb0902(v57, v62, true)
						local v63 = fn11()

						if v63 ~= nil then
							__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CHAT_MESSAGE_SENT"), v63)
						end
					end
				end
			else
				local activePanel = mWindow:GetActivePanel()

				if not __wf_atom_7e8ad928(activePanel) then
					activePanel:SystemMessage(mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/Chat_InvalidClanLink",
						false
					))
				end
			end
		end
	end

	function v54.DisplaySpamMessage(p, p2)
		local ternary = module.Ternary(
			p2,
			"/Lotus/Language/Menu/Chat_SpamBlockTrade",
			"/Lotus/Language/Menu/Chat_SpamBlock"
		)
		local time = math.floor(module.Ternary(p2, v3.TRADE_SPAM_DETECTION_PERIOD, v3.SPAM_LOCKOUT_TIME) - (__wf_atom_c4e218a2() - module.Ternary(p2, _G.TradeSpamBlockTime, p.mSpamBlockTime)))
		local activePanel = mWindow:GetActivePanel()

		if not __wf_atom_7e8ad928(activePanel) then
			activePanel:SystemMessage(mMovie:__wf_atom_8e9ac384(ternary, false, { TIME = time }))
		end

		module.PlaySound(_G.UISound_Error)
		mWindow.mInputPanel.CharLimitFlashTime = 2.5
	end

	function v54:_makeUserEntry(value2, isOnline)
		local v57 = {
			isOnline = isOnline,
			name = value2,
			displayName = value2,
			lowercaseName = string.lower(value2)
		}
		local __wf_atom_746f9d1b = Engine.__wf_atom_746f9d1b(v57.lowercaseName)
		local flag2 = false

		if Engine.__wf_atom_fe47f148(v57.name) ~= "" then
			for i = 0, 4 do
				local UTF8 = module4.UTF8(57344 + i)
				local v58 = self.mUserList[__wf_atom_746f9d1b .. UTF8]

				if not v58 or v58.hasSuffix or v58.name == value2 then
					continue
				end

				v58.displayName = Engine.__wf_atom_1b118af6(v58.name)
				v58.hasSuffix = true
				flag2 = true

				for j = 1, self.mParent.mUserPanel.mListControl:GetHowManyElements() do
					if not (self.mParent.mUserPanel.mListControl.mElements[j] ~= nil and self.mParent.mUserPanel.mListControl.mElements[j].User == v58.name) then
						continue
					end

					self.mParent.mUserPanel.mListControl.mElements[j].DisplayName = v58.displayName
					break
				end
			end
		end

		if flag2 then
			v57.displayName = Engine.__wf_atom_1b118af6(value2)
			v57.hasSuffix = true
			self.mParent.mUserPanel.mListControl:Redraw(nil, true, true)
		end

		return v57
	end

	function v54:OnUserInChannelCommon(value2, p, p2)
		if p2 == nil then
			p2 = false
		end

		if self.mChannelName ~= p or value2 == module3.HIDDEN_PLAYER_NAME then
			return
		end

		if string.find(value2, "@") ~= nil then
			value2 = string.sub(value2, 2, -1)
		end

		local userEntry = self:_makeUserEntry(value2, true)

		if self.mIsActive then
			local v57 = {
				User = userEntry.name,
				DisplayName = userEntry.displayName,
				UserLower = userEntry.lowercaseName,
				Channel = self.mChannelName
			}
			local v58 = #self.mParent.mUserPanel.mListControl.mElements + 1
			local userLower = v57.UserLower
			local v59 = 1

			while v59 < v58 do
				__wf_atom_83c14687(0)
				local v60 = math.floor((v59 + v58) / 2)
				local userLower2 = self.mParent.mUserPanel.mListControl.mElements[v60].UserLower

				if userLower2 == userLower then
					return
				end

				if userLower < userLower2 then
					v58 = v60
				else
					v59 = v60 + 1
				end
			end

			for i = 1, #self.mAlphabetIndex do
				if not (v58 < self.mAlphabetIndex[i] or v58 == self.mAlphabetIndex[i] and string.upper((string.sub(v57.UserLower, 1, 1))) < v7[i]) then
					continue
				end

				self.mAlphabetIndex[i] = self.mAlphabetIndex[i] + 1
			end

			self.mParent.mUserPanel.mListControl:InsertElement(v58, v57, true)

			if
				not p2
				and self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_MENU_SIMPLE
				and self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_GAMEPLAY_SIMPLE
			then
				local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mParent.mUserPanel.mWindow)
				self.mParent.mUserPanel:UpdateElementVisibilityRange(coordsRelativeToParent.height)
				self.mParent.mUserPanel:OnUserJoin(v58)
				self.mParent.mUserPanel.mListControl:Redraw(nil, false, true)
				self.mParent.mUserPanel.mListControl:RunForAllVisibleElements(function(p3)
					if p3 ~= nil and p3.mClipName ~= nil then
						mMovie:__wf_atom_e57658c2(p3.mClipName, 1, self.mParent.mUserPanel.mListControl:CalculateY(p3))
					end
				end)
			end
		end

		self.mUserList[userEntry.lowercaseName] = userEntry
		return true
	end

	function v54:PopulateUserList(p)
		if not self.mIsActive then
			return
		end

		if p == false then
			self.mStoredFocusIndex = mWindow.mUserPanel.mListControl:GetFocusedElementIndex()
		end

		self.mParent.mUserPanel:Clear()

		if Engine.__wf_atom_fc67ba71() and fn16() then
			return
		end

		if
			self.mVisualMode ~= self.VISUAL_MODE_MENU_SIMPLE
			and self.mVisualMode ~= self.VISUAL_MODE_GAMEPLAY_SIMPLE
		then
			local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mParent.mUserPanel.mWindow)
			self.mParent.mUserPanel:UpdateElementVisibilityRange(coordsRelativeToParent.height)
		end

		if self.mChannelType >= mWindow.CHANNEL_PRIVATE_CHAT then
			local v57 = string.sub(self.mChannelName, 2)
			local v58 = string.lower(Engine.__wf_atom_746f9d1b(v57))
			local crossPlatformUniquePlayerName = module2.GetCrossPlatformUniquePlayerName(
				v57,
				mWindow.mPrivateChatPartners,
				nil,
				nil,
				true
			)
			self.mParent.mUserPanel.mListControl:AddElement(
				{
					Id = 1,
					User = crossPlatformUniquePlayerName,
					UserLower = string.lower(crossPlatformUniquePlayerName),
					Channel = self.mChannelName
				},
				true
			)
			local v59 = string.lower(Engine.__wf_atom_746f9d1b(mWindow.mUser))
			mWindow.mPrivateChatUseUniqueName = v59 == v58
		else
			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
				local __wf_atom_55b0f070 = __wf_atom_7190444e:__wf_atom_55b0f070("#" .. self.mChannelName)

				if not __wf_atom_7e8ad928(__wf_atom_55b0f070) and #__wf_atom_55b0f070 > 0 then
					self.mInitialPopulationDone = true
					local v57 = #__wf_atom_55b0f070
					local v58 = self.mChannelType == mWindow.CHANNEL_SESSION
					self.mAlphabetIndex = {}
					local v59 = 1

					for i = 1, v57 do
						__wf_atom_83c14687(0)
						local member = __wf_atom_55b0f070[i].member

						if not ((not v58 or fn32(member)) and member ~= module3.HIDDEN_PLAYER_NAME) then
							continue
						end

						local userEntry = self:_makeUserEntry(member, true)
						self.mUserList[string.lower(member)] = userEntry
						mWindow.mUserPanel.mListControl:AddElement({
							Id = i,
							User = userEntry.name,
							DisplayName = userEntry.displayName,
							UserLower = userEntry.lowercaseName,
							Channel = self.mChannelName
						}, true)

						if not (v59 == 1 or string.sub(userEntry.lowercaseName, 1, 1) ~= v7[v59 - 1]) then
							continue
						end

						for j = v59, #v7 do
							if string.upper((string.sub(userEntry.lowercaseName, 1, 1))) ~= v7[j] then
								continue
							end

							for k = v59, j - 1 do
								self.mAlphabetIndex[k] = i
							end

							self.mAlphabetIndex[j] = i
							v59 = j + 1
							break
						end
					end

					local howManyElements = mWindow.mUserPanel.mListControl:GetHowManyElements()

					for i = v59, #v7 do
						self.mAlphabetIndex[i] = howManyElements
					end
				end
			end

			mWindow.mPrivateChatUseUniqueName = false
		end

		self.mParent.mUserPanel.mListControl:Redraw(nil, true, true)
		local howManyElements = mWindow.mUserPanel.mListControl:GetHowManyElements()

		if
			Engine.IsPlayingWithController()
			and not __wf_atom_7e8ad928(self.mStoredFocusIndex)
			and howManyElements > 0
		then
			if howManyElements < self.mStoredFocusIndex then
				mWindow.mUserPanel:FocusElement(howManyElements)
			else
				mWindow.mUserPanel:FocusElement(self.mStoredFocusIndex)
			end
		end
	end

	function v54:OnUserJoin(p, p2, _, p3)
		if self.mChannelName ~= p2 then
			return
		end

		if not self.mInitialPopulationDone then
			self:PopulateUserList(false)
		end

		if self.mInitialPopulationDone then
			self:OnUserInChannelCommon(p, p2, p3)
		end
	end

	function v54:OnUserLeave(value2, p, p2)
		if self.mChannelName ~= p or self.mChannelType >= mWindow.CHANNEL_PRIVATE_CHAT then
			return
		end

		self.mUserList[string.lower(value2)] = self:_makeUserEntry(value2, false)

		if self.mIsActive then
			local howManyElements = self.mParent.mUserPanel.mListControl:GetHowManyElements()
			local v57 = howManyElements
			local v58 = 1
			local v59 = nil

			while v58 < v57 do
				__wf_atom_83c14687(0)
				v59 = math.floor((v58 + v57) / 2)
				local mElement = self.mParent.mUserPanel.mListControl.mElements[v59]

				if __wf_atom_7e8ad928(mElement) or mElement.User == value2 then
					break
				end

				if mElement.UserLower > string.lower(value2) then
					v57 = v59
				else
					v58 = v59 + 1
					v59 = v58
				end
			end

			if v59 ~= nil then
				local mElement = self.mParent.mUserPanel.mListControl.mElements[v59]

				if not __wf_atom_7e8ad928(mElement) and mElement.User == value2 then
					for i = 1, #self.mAlphabetIndex do
						if v59 < self.mAlphabetIndex[i] or v59 == self.mAlphabetIndex[i] and v59 == howManyElements then
							self.mAlphabetIndex[i] = self.mAlphabetIndex[i] - 1
						end
					end

					self.mParent.mUserPanel.mListControl:RemoveElement(v59, true, true)

					if
						self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_MENU_SIMPLE
						and self.mParent.mVisualMode ~= self.mParent.VISUAL_MODE_GAMEPLAY_SIMPLE
					then
						local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mParent.mUserPanel.mWindow)
						self.mParent.mUserPanel:UpdateElementVisibilityRange(coordsRelativeToParent.height)
						self.mParent.mUserPanel:OnUserLeave(v59)
						self.mParent.mUserPanel.mListControl:Redraw(nil, false, true)
					end
				end
			end
		end

		if p2 then
			self:_removeUserMsgs(value2)
		end
	end

	function v54:_getLineVars(value2, p, p2)
		local v57 = nil
		local chatNameColor = v2.ChatNameColor
		local chatMessageColor = v2.ChatMessageColor

		if p2 == self.MESSAGE_TYPE_SYSTEM then
			return value2, v57, v2.ChatMessageColor, chatMessageColor
		end

		if p2 == self.MESSAGE_TYPE_BROADCAST then
			return value2, v57, v2.Green, v2.Green
		end

		if p2 == self.MESSAGE_TYPE_NOTIFICATION then
			if self.mChannelType == mWindow.CHANNEL_HUB and gMatchingService:__wf_atom_a676a953() then
				return value2, v57, v2.ChatNameColor, v2.ChatNameColor
			end

			return value2, v57, v2.ChatMessageColor, chatMessageColor
		else
			if p2 == self.MESSAGE_TYPE_CLAN or p2 == self.MESSAGE_TYPE_ALLIANCE then
				chatNameColor = v2.Green
			elseif p2 == self.MESSAGE_TYPE_SQUAD then
				chatNameColor = v2.Blue
			elseif p2 == self.MESSAGE_TYPE_COUNCIL then
				chatNameColor = v2.Orange
			elseif p2 == self.MESSAGE_TYPE_FRIEND or p2 == self.MESSAGE_TYPE_INGAME_WHISPER then
				chatNameColor = v2.LightYellow
			elseif p2 == self.MESSAGE_TYPE_STAFF or p2 == self.MESSAGE_TYPE_WG_MOD then
				chatNameColor = v2.Purple
				chatMessageColor = v2.Purple
			end

			if not p then
				return value2, v57, chatMessageColor, chatMessageColor
			end

			local v58 = string.find(value2, ":")

			if self.mParent.mShowTimeStamps ~= nil and self.mParent.mShowTimeStamps then
				v58 = string.find(value2, ":", 8)
			end

			if v58 == nil then
				v58 = 1

				if p2 == self.MESSAGE_TYPE_CLAN then
					chatMessageColor = v2.Green
				end
			end

			return string.sub(value2, 0, v58 - 1), string.sub(value2, v58), chatNameColor, chatMessageColor
		end
	end

	function v54:_makeLineEntry(p, messageType, displayName)
		local v57 = module.SanitizeTextForHTML(p)

		if displayName ~= nil then
			local v58 = string.lower(displayName)
			local v59 = self.mUserList[v58]

			if v59 then
				displayName = v59.displayName
			elseif mWindow.mPrivateChatUseUniqueName and mWindow.mPrivateChatPartners[v58] then
				displayName = mWindow.mPrivateChatPartners[v58]
			end
		end

		local v58 = true
		local v59 = { Item = {}, Guild = {} }
		local v60 = { Item = 1, Guild = 1 }

		if
			string.find(v57, "%[OMG%-.*%]") ~= nil
			or string.find(v57, "%[SONG%-.*%]") ~= nil
			or string.find(v57, "%[ZAW%-.*%]") ~= nil
			or string.find(v57, "%[AMP%-.*%]") ~= nil
			or string.find(v57, "%[MOA%-.*%]") ~= nil
			or string.find(v57, "%[KDR%-.*%]") ~= nil
			or string.find(v57, "%[KIT%-.*%]") ~= nil
			or string.find(v57, "%[FF%-.*%]") ~= nil
			or string.find(v57, "%[MOD%-.*%]") ~= nil
			or string.find(v57, "%[SHZN%-.*%]") ~= nil
			or string.find(v57, "{GUILD=.*}") ~= nil
		then
			local v61 = 0
			local v62 = nil
			local v63 = ""

			while v61 <= #v57 do
				v61 = string.find(v57, "[%[{%]}]", v61 + 1)

				if __wf_atom_7e8ad928(v61) then
					break
				end

				local v64 = string.sub(v57, v61, v61)

				if v64 == "[" then
					v62 = v61
					v63 = "item"
				elseif v64 == "{" then
					v62 = v61
					v63 = "clan"
				elseif not __wf_atom_7e8ad928(v62) and v63 == "item" and v64 == "]" or v63 == "clan" and v64 == "}" then
					local linkString = string.sub(v57, v62 + 1, v61 - 1)

					if v63 == "item" then
						local v66 = string.lower(linkString)

						if string.sub(v66, 1, 4) == "omg-" then
							local v67 = string.find(linkString, ":")

							if v67 ~= nil then
								local upgradeInfo = SF.UpgradeInfo()
								upgradeInfo.mItemType = WeakResource(v15.OMEGA_TYPE_PREFIX .. string.sub(linkString, 5, v67 - 1))
								local mInstance = upgradeInfo.mInstance

								if not __wf_atom_7e8ad928(mInstance) then
									local __wf_atom_85682a6d = mInstance:__wf_atom_85682a6d((string.sub(linkString, v67 + 1)))
									local __wf_atom_0796a629 = mInstance:__wf_atom_0796a629(__wf_atom_85682a6d)

									if not mInstance:__wf_atom_ffb2b866(__wf_atom_85682a6d) then
										__wf_atom_0796a629 = TitleCase(mMovie:__wf_atom_8e9ac384(
											"/Lotus/Language/Omega/OmegaUnidentified",
											false
										)) .. " " .. __wf_atom_0796a629
									end

									local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString .. "\">"
									table.insert(v59.Item, {
										Name = __wf_atom_0796a629,
										LinkStart = linkStart,
										LinkString = linkString
									})
									local v69 = string.gsub(v57, "%[OMG%-[^%]]+%]", "[" .. __wf_atom_0796a629 .. "]", 1)
									v61 = v61 + #v69 - #v57
									v57 = v69
									v58 = false
								end
							end
						elseif string.sub(v66, 1, 5) == "song-" then
							local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString .. "\">"
							local v68 = string.find(linkString, ":")

							if v68 ~= nil then
								local name = v15.StepSequencerPrefixString .. string.sub(linkString, 6, v68 - 1)
								table.insert(v59.Item, {
									Name = name,
									LinkStart = linkStart,
									LinkString = linkString
								})
								local v70 = string.gsub(v57, "%[SONG%-[^%]]+%]", "[" .. name .. "]", 1)
								v61 = v61 + #v70 - #v57
								v57 = v70
								v58 = false
							end
						elseif
							string.sub(v66, 1, 4) == "zaw-"
							or string.sub(v66, 1, 4) == "amp-"
							or string.sub(v66, 1, 4) == "moa-"
							or string.sub(v66, 1, 4) == "kdr-"
							or string.sub(v66, 1, 4) == "kit-"
						then
							local zawPrefixString = v15.ZawPrefixString
							local v67 = "ZAW%-"

							if string.sub(v66, 1, 4) == "amp-" then
								zawPrefixString = v15.AmpPrefixString
								v67 = "AMP%-"
							elseif string.sub(v66, 1, 4) == "moa-" then
								zawPrefixString = v15.MoaPetPrefixString
								v67 = "MOA%-"
							elseif string.sub(v66, 1, 4) == "kdr-" then
								zawPrefixString = v15.KDrivePrefixString
								v67 = "KDR%-"
							elseif string.sub(v66, 1, 4) == "kit-" then
								zawPrefixString = v15.KitgunPrefixString
								v67 = "KIT%-"
							end

							local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString .. "\">"
							local v69 = string.find(linkString, ":")

							if v69 ~= nil then
								local name = zawPrefixString .. string.sub(linkString, 5, v69 - 1)
								table.insert(v59.Item, {
									Name = name,
									LinkStart = linkStart,
									LinkString = linkString
								})
								local v71 = string.gsub(v57, "%[" .. v67 .. "[^%]]+%]", "[" .. name .. "]", 1)
								v61 = v61 + #v71 - #v57
								v57 = v71
								v58 = false
							end
						elseif string.sub(v66, 1, 3) == "ff-" then
							local appearancePrefixString = v15.AppearancePrefixString
							local storeItem = module11.GetStoreItemFromLink(linkString)

							if not __wf_atom_7e8ad928(storeItem) then
								appearancePrefixString ..= ": " .. mMovie:__wf_atom_8e9ac384(
									storeItem:__wf_atom_014a76a2():c_str(),
									false
								)
							end

							local linkString2 = module11.ConstructLinkPostReceive(linkString, displayName)
							local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString2 .. "\">"
							table.insert(v59.Item, {
								Name = appearancePrefixString,
								LinkStart = linkStart,
								LinkString = linkString2
							})
							local v69 = string.gsub(v57, "%[FF%-[^%]]+%]", "[" .. appearancePrefixString .. "]", 1)
							v61 = v61 + #v69 - #v57
							v57 = v69
							v58 = false
						elseif string.sub(v66, 1, 4) == "mod-" then
							local modConfigPrefixString = v15.ModConfigPrefixString
							local storeItem = module11.GetStoreItemFromLink(linkString)

							if not __wf_atom_7e8ad928(storeItem) then
								modConfigPrefixString ..= ": " .. mMovie:__wf_atom_8e9ac384(
									storeItem:__wf_atom_014a76a2():c_str(),
									false
								)
							end

							local linkString2 = module11.ConstructLinkPostReceive(linkString, nil)
							local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString2 .. "\">"
							table.insert(v59.Item, {
								Name = modConfigPrefixString,
								LinkStart = linkStart,
								LinkString = linkString2
							})
							local v69 = string.gsub(v57, "%[MOD%-[^%]]+%]", "[" .. modConfigPrefixString .. "]", 1)
							v61 = v61 + #v69 - #v57
							v57 = v69
							v58 = false
						elseif string.sub(v66, 1, 5) == "shzn-" then
							local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString .. "\">"
							local shawzinPrefixString = v15.ShawzinPrefixString
							table.insert(v59.Item, {
								Name = shawzinPrefixString,
								LinkStart = linkStart,
								LinkString = linkString
							})
							local v68 = string.gsub(v57, "%[SHZN%-[^%]]+%]", "[" .. shawzinPrefixString .. "]", 1)
							v61 = v61 + #v68 - #v57
							v57 = v68
							v58 = false
						end
					else
						local linkString2 = string.sub(v57, v62 + 1, v61 - 1)

						if string.sub(linkString2, 1, 6) == "GUILD=" then
							local v67 = string.find(linkString2, ":")

							if v67 == nil then
								print("Invalid guild link: " .. linkString2)
							else
								local v68 = string.find(v57, ":")
								local v69

								if v68 then
									v69 = string.sub(v57, 1, v68 - 1)
								end

								local name = string.sub(linkString2, v67 + 1)

								if v69 then
									linkString2 ..= ":" .. v69
								end

								local linkStart = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. linkString2 .. "\">"
								table.insert(v59.Guild, {
									Name = name,
									LinkStart = linkStart,
									LinkString = linkString2
								})
								local v72 = string.gsub(v57, "{GUILD=[^}]+}", "{" .. name .. "}", 1)
								v61 = v61 + #v72 - #v57
								v57 = v72
								v58 = false
							end
						end
					end

					v62 = nil
					v63 = ""
				end
			end
		end

		if
			v58
			and mDoFilter
			and messageType ~= self.MESSAGE_TYPE_BROADCAST
			and messageType ~= self.MESSAGE_TYPE_SYSTEM
		then
			local v61 = string.find(v57, ":")
			local v62 = ""

			if self.mParent.mShowTimeStamps ~= nil and self.mParent.mShowTimeStamps then
				local v63 = string.find(v57, "]", v61)

				if v63 ~= nil then
					local v64 = v63 + 1
					v62 = string.sub(v57, 1, v64)
					v57 = string.sub(v57, v64 + 1, (string.len(v57)))
					v61 = string.find(v57, ":")
				end
			end

			if v61 and v61 < string.len(v57) then
				if __wf_atom_d9227398() then
					displayName = __wf_atom_f8f86fc5(string.sub(v57, 1, v61 - 1), 0)
				elseif displayName == nil then
					displayName = string.sub(v57, 1, v61 - 1)
				end

				local v63 = string.sub(v57, v61 + 1, (string.len(v57)))
				local v64

				if v63:find("%[.-%-.-:.*%]") then
					local v65 = {}
					local count = 0
					local v66 = string.gsub(v63, "(%[.-%-.-:)(.*)(%])", function(p2, p3, p4)
						count += 1
						local v67 = "[REP" .. count .. "]"
						v65[v67] = p3
						return p2 .. v67 .. p4
					end)
					local v67 = __wf_atom_f8f86fc5(v66, 0)
					v64 = string.gsub(v67, "%[REP%d-%]", function(p2)
						return v65[p2]
					end)
				else
					v64 = __wf_atom_f8f86fc5(v63, 0)
				end

				v57 = v62 .. displayName .. ":" .. v64
			end
		end

		mMovie:__wf_atom_50d60589(self.mClipPath .. ".ChatArea", 36, v57)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".ChatArea", 43)
		local v61 = v57
		local result = {}

		for i = 1, __wf_atom_5e6e15c8 do
			local text = __wf_atom_86cbd68d(mMovie, self.mClipPath .. ".ChatArea.getLine", i - 1)
			local v63 = text:len()
			local endSpace

			if i < __wf_atom_5e6e15c8 then
				endSpace = v61:sub(v63 + 1, v63 + 1) == " "

				if endSpace then
					v63 += 1
				end

				v61 = v61:sub(v63 + 1)
			end

			result[i] = {
				text = text,
				messageType = messageType,
				firstLine = i == 1,
				hyperLinks = {},
				endSpace = endSpace
			}
		end

		local activePanel = mWindow:GetActivePanel()
		local v62 = __wf_atom_7e8ad928(activePanel) and {} or activePanel.mUserList

		for i = 1, __wf_atom_5e6e15c8 do
			local text = result[i].text

			if string.find(v57, "%[.*%]") ~= nil or string.find(v57, "{.*}") ~= nil or string.find(v57, "@") ~= nil then
				local v63 = 0
				local v64 = ""
				local v65 = nil
				local total = 0
				local flag2 = false
				local v66 = {}

				while v63 <= #result[i].text do
					if v64 == "username" then
						v63 += 1
					else
						v63 = string.find(result[i].text, "[@%[{%]}]", v63 + 1)

						if __wf_atom_7e8ad928(v63) then
							break
						end
					end

					local v67 = string.sub(result[i].text, v63, v63)

					if v67 == "@" then
						table.insert(v66, v63)
						local v68

						if v63 + 1 < #result[i].text and string.sub(result[i].text, v63 + 1, v63 + 1) == "\"" then
							v68 = v63 + 1
							local v69 = string.find(result[i].text, "\"", v68 + 1)

							if v69 ~= nil then
								v68 = v69 - 1
								flag2 = true
							end
						else
							v68 = v63
						end

						if v68 + 4 < #result[i].text and string.sub(result[i].text, v68 + 1, v68 + 4) == "[DE]" then
							v68 += 4
						end

						v65 = v63
						v63 = v68
						v64 = "username"
					elseif
						__wf_atom_7e8ad928(v65)
						or v64 ~= "username"
						or not flag2
						and v63 ~= #result[i].text
						and string.find(string.sub(result[i].text, v63 + 1, v63 + 1), "[%a%d_%-%.]")
					then
						if v67 == "[" then
							table.insert(v66, v63)
							v65 = v63
							v64 = "item"
						elseif v67 == "{" then
							table.insert(v66, v63)
							v65 = v63
							v64 = "clan"
						elseif
							not __wf_atom_7e8ad928(v65)
							and (v64 == "item" and v67 == "]" or v64 == "clan" and v67 == "}")
						then
							local ternary = module.Ternary(v67 == "]", "Item", "Guild")
							local ternary2 = module.Ternary(ternary == "Item", "[", "{")
							local ternary3 = module.Ternary(ternary == "Item", "]", "}")
							local name = string.sub(result[i].text, v65 + 1, v63 - 1)
							local flag3 = true
							local v69

							if #v59[ternary] >= v60[ternary] then
								v69 = v59[ternary][v60[ternary]]
							end

							if name ~= "" then
								if
									v69 == nil
									or name ~= v69.Name
									and (ternary ~= "Item" or not string.find(v69.Name, "%[" .. name .. "%]"))
									and (ternary ~= "Guild" or not string.find(v69.Name, "{" .. name .. "}"))
								then
									if ternary == "Item" and name ~= "" and not __wf_atom_7e8ad928(nil) then
										local __wf_atom_ce963400 = (nil):__wf_atom_ce963400(name)

										if __wf_atom_ce963400 ~= "" then
											local v70 = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. __wf_atom_ce963400 .. "\">" .. ternary2 .. name .. ternary3 .. "</a>"
											text = string.sub(text, 0, v65 + total - 1) .. v70 .. string.sub(text, v63 + total + 1)
											total += #v70 - #name - 2
											table.insert(result[i].hyperLinks, {
												Name = name,
												Item = __wf_atom_ce963400,
												LinkType = "Item"
											})
										end
									end
								elseif name == v69.Name then
									local v70 = v69.LinkStart .. ternary2 .. v69.Name .. ternary3 .. "</a>"
									text = string.sub(text, 0, v65 + total - 1) .. v70 .. string.sub(text, v63 + total + 1)
									total += #v70 - #name - 2
									v60[ternary] += 1
									table.insert(result[i].hyperLinks, {
										Name = v69.Name,
										Item = v69.LinkString,
										LinkType = ternary
									})
								else
									flag3 = false
									v66[#v66] = nil

									if #v66 > 0 then
										v65 = v66[#v66]
									end
								end
							end

							if flag3 then
								v64 = ""
								v65 = nil
								v66 = {}
							end
						end
					else
						if fn30(string.sub(result[i].text, v63 + 1, v63 + 3)) then
							v63 += 3
						end

						local v68 = string.sub(result[i].text, v65, v63)
						local v69 = v63 - v65 + 1

						if flag2 then
							v68 = string.gsub(v68, "\"", "")
						end

						local v70 = string.lower((string.sub(v68, 2)))
						local v71 = v62[v70]

						if not v71 then
							for j = 0, 4 do
								v71 = v62[v70 .. module4.UTF8(57344 + j)]

								if v71 then
									break
								end
							end
						end

						if v71 then
							v68 = "@" .. v71.displayName
						end

						if v71 and v71.isOnline then
							local v72 = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. v68 .. "\">" .. v68 .. "</a>"
							text = string.sub(text, 0, v65 + total - 1) .. v72 .. string.sub(text, v63 + total + 1)
							total += #v72 - v69
						end

						v64 = ""
						v65 = nil
						v66 = {}
					end
				end

				if
					(v64 == "item" or v64 == "clan")
					and i ~= tonumber(__wf_atom_5e6e15c8)
					and not __wf_atom_7e8ad928(v65)
				then
					local v67 = 0

					while v67 <= #result[i + 1].text do
						v67 = string.find(result[i + 1].text, "[%[{%]}]", v67 + 1)

						if __wf_atom_7e8ad928(v67) then
							break
						end

						local v68 = string.sub(result[i + 1].text, v67, v67)

						if v68 == "[" or v68 == "{" then
							break
						end

						if not (v68 == "]" or v68 == "}") then
							continue
						end

						local ternary = module.Ternary(v68 == "]", "Item", "Guild")
						local ternary2 = module.Ternary(ternary == "Item", "[", "{")
						local ternary3 = module.Ternary(ternary == "Item", "]", "}")
						local v69 = string.sub(result[i].text, v65 + 1)
						local v70 = string.sub(result[i + 1].text, 0, v67 - 1)
						local v71

						if result[i].endSpace then
							v71 = v69 .. " " .. v70
						else
							v71 = v69 .. v70
						end

						local v72

						if #v59[ternary] >= v60[ternary] then
							v72 = v59[ternary][v60[ternary]]
						end

						if ternary == "Item" and not __wf_atom_7e8ad928(nil) then
							local __wf_atom_ce963400 = (nil):__wf_atom_ce963400(v71)

							if __wf_atom_ce963400 ~= "" then
								local name = string.lower(v71):gsub("(%l)([^%s^%-]*)", function(value2, p2)
									return string.upper(value2) .. p2
								end)
								local v74 = "<a color=\"#33ccff\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:" .. __wf_atom_ce963400 .. "\">"
								text = string.sub(text, 0, v65 + total - 1) .. v74 .. "[" .. string.sub(text, v65 + 1 + total)
								result[i + 1].text = string.sub(result[i + 1].text, 0, v67 - 1) .. "]</a>" .. string.sub(result[i + 1].text, v67 + 1)
								table.insert(result[i].hyperLinks, {
									Name = name,
									Item = __wf_atom_ce963400,
									LinkType = "Item"
								})
								break
							end
						end

						if not (v72 ~= nil and v71 == v72.Name) then
							continue
						end

						local v73 = v72.LinkStart .. ternary2 .. v72.Name .. ternary3 .. "</a>"
						text = string.sub(text, 0, v65 + total - 1) .. v72.LinkStart .. ternary2 .. string.sub(text, v65 + total + 1)
						total += #v73 - #v71 - 2
						v60[ternary] += 1
						result[i + 1].text = string.sub(result[i + 1].text, 0, v67 - 1) .. ternary3 .. "</a>" .. string.sub(result[i + 1].text, v67 + 1)
						table.insert(result[i].hyperLinks, {
							Name = v72.Name,
							Item = v72.LinkString,
							LinkType = ternary
						})
						break
					end
				end
			end

			result[i].text = text
		end

		return result
	end

	function v54:RefreshText(_)
		__wf_atom_83c14687(0)
		local count = 0

		if self.mLineLog ~= nil then
			local count2 = #self.mLineLog
			local v57 = #self.mChatHistory

			if count2 > 0 then
				for i = count2, 1, -1 do
					if #self.mChatHistory >= self.mMaxChatHistory then
						break
					end

					if i % 50 == 0 then
						__wf_atom_83c14687(0)
					end

					local v58 = self.mLineLog[i]
					local text = v58.text
					local sender = v58.sender
					self.mHasHyperlink = self.mHasHyperlink or #v58.hyperLinks > 0

					if sender ~= nil and sender ~= "" then
						v22[string.lower(sender)] = true
					end

					if v57 ~= 0 then
						continue
					end

					local ternary = module.Ternary(mEmojiSettings.Enabled, mMovie:__wf_atom_b4b867f2(text, true), text)

					if self.mParent.mShowTimeStamps ~= nil and self.mParent.mShowTimeStamps then
						ternary = v58.timeStamp .. ternary
					end

					local lineEntry = self:_makeLineEntry(ternary, v58.messageType, v58.sender)

					for j = #lineEntry, 1, -1 do
						if lineEntry[j].text ~= "" then
							table.insert(self.mChatHistory, 1, lineEntry[j])
						end
					end
				end
			end
		end

		if Engine.IsPlayingWithController() then
			mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.HyperlinkBtn", 13, self.mHasHyperlink)
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".ChatArea", 50)
		local coordsRelativeToParent = self.mParent:GetCoordsRelativeToParent(self.mParent.mChatPanelWindow)

		if Engine.__wf_atom_2a979d69() and mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE then
			self.mMaxVisibleChatLines = 2
		else
			self.mMaxVisibleChatLines = math.max(
				math.floor(mMovie:__wf_atom_5e6e15c8(self.mClipPath .. ".ChatArea", 15) / (__wf_atom_5e6e15c8 * 1.3)),
				0
			)
		end

		local count2 = #self.mChatHistory
		local v57 = count2 - self.mMaxVisibleChatLines + 1 - math.max(0, self.mScrollBack)
		local v58 = __wf_atom_421b01aa(v57, 1, count2)
		local v59 = "<a color=\"#%X\" hovercolor=\"" .. convertColorNumberToHex .. "\" href=\"#onHyperlinkPressed:@"
		local v60 = {}
		local count3 = 0

		while v58 > 0 and v58 <= count2 and count < self.mMaxVisibleChatLines do
			local v61 = self.mChatHistory[v58]
			local lineVars, v62, v63, v64 = self:_getLineVars(v61.text, v61.firstLine, v61.messageType)
			local v65 = nil

			if next(v60) ~= nil then
				table.insert(v60, "<br>")
			end

			if count == self.mMaxVisibleChatLines - 1 or v58 == count2 then
				v65 = #v60 + 1
			end

			if v62 == nil then
				if
					(v61.messageType == self.MESSAGE_TYPE_SYSTEM or v61.messageType == self.MESSAGE_TYPE_BROADCAST or v61.messageType == self.MESSAGE_TYPE_NOTIFICATION)
					and v61.firstLine
				then
					table.insert(v60, string.format("<font color=\"#%X\">", v63))
				end

				table.insert(v60, lineVars)
			else
				table.insert(v60, string.format(v59, v63))
				table.insert(v60, lineVars .. "|" .. tostring(v58))
				table.insert(v60, "\">")
				table.insert(v60, "<b><font face=\"Spectral SC\">" .. lineVars .. "</font></b>")
				table.insert(v60, string.format("</a><font color=\"#%X\">", v64))
				table.insert(v60, v62)
			end

			if __wf_atom_7e8ad928(v65) then
				if count == 0 and v62 == nil then
					local v66 = lineVars:find("<a")
					local v67 = lineVars:find("</a")
					local _, v68 = lineVars:gsub("<a", "")
					local _, v69 = lineVars:gsub("</a", "")

					if (v68 ~= v69 or v66 == nil or v67 == nil or v66 < v67) and not (v68 < v69) or not (v58 > 1) then
						if v58 == 1 and not __wf_atom_7e8ad928(v67) and (__wf_atom_7e8ad928(v66) or v67 < v66) then
							v60[1] = string.gsub(v60[1], "</a>", "", 1)
						end
					else
						local text = self.mChatHistory[v58 - 1].text

						if #text > 0 then
							local v70 = 0
							local v71 = nil

							while v70 ~= nil do
								local v72 = text:find("<a", v70)

								if v72 == nil then
									v70 = nil
								else
									v70 = v72 + 1
									v71 = v72
								end
							end

							local v72 = text:find(">", v71)
							table.insert(v60, #v60, text:sub(v71, v72))
						end
					end
				end
			else
				local flag2 = false
				local total = 0
				local total2 = 0

				for i = v65, #v60 do
					local v66 = v60[i]

					if not flag2 then
						local v67 = v66:find("</a>")

						if v67 == nil then
							if v66:find("<a") then
								flag2 = true
							end
						else
							v66 = v66:sub(v67 + 4)
							flag2 = true
						end
					end

					if not flag2 then
						continue
					end

					local _, v67 = v66:gsub("<a", "")
					local _, v68 = v66:gsub("</a", "")
					total += v67
					total2 += v68
				end

				if total2 < total then
					table.insert(v60, "</a>")
				end
			end

			count3 += 1
			count += 1
			v58 += 1
		end

		for _ = 1, count3 do
			table.insert(v60, "</font>")
		end

		local v61 = "<p><font >" .. table.concat(v60) .. "</font></p>"
		mMovie:__wf_atom_50d60589(self.mClipPath .. ".ChatArea", 36, v61)
		local v62 = self.mMaxVisibleChatLines / #self.mChatHistory
		local v63

		if v62 > 0 then
			v63 = v62 < 1
		else
			v63 = false
		end

		mMovie:__wf_atom_7f57ab2f(self.mClipPath, "ScrollBar.Scrub", 13, v63)
		mMovie:__wf_atom_4c1c1986(self.mClipPath, "ScrollBar", 12, module.Ternary(v63, 100, 50))

		if coordsRelativeToParent.height ~= nil then
			self.mTextScroll:SetHeight(coordsRelativeToParent.height - 16)
		end
	end

	function v54:OnDeactivated()
		self.mIsActive = false
		self.mStoredFocusIndex = mWindow.mUserPanel.mListControl:GetFocusedElementIndex()

		if __wf_atom_7e8ad928(self.mStoredFocusIndex) then
			self.mStoredFocusIndex = mWindow.mUserPanel.mListControl.mScroll
		end
	end

	function v54:OnActivated(_)
		if self.mIsActive then
			return
		end

		self.mIsActive = true
		self:RefreshText()
		local count = #self.mCachedLines

		if count > 0 then
			for i = 1, count do
				__wf_atom_83c14687(0)
				local mCachedLine = self.mCachedLines[i]
				self:_onLineAdded(
					mCachedLine.Line,
					mCachedLine.MsgType,
					mCachedLine.TimeStamp,
					i < count,
					true,
					mCachedLine.sender
				)
			end

			self.mCachedLines = {}
		end

		self.mParent.mMode = self.mChannelType
		self:PopulateFilterList()
		self.mParent.mTabMenu:OnSelected(self.mTabElement)

		if
			self.mParent.mVisualMode == self.mParent.VISUAL_MODE_MENU_SIMPLE
			or self.mParent.mVisualMode == self.mParent.VISUAL_MODE_GAMEPLAY_SIMPLE
			or not self.mIsChatEnabled
			or Engine.__wf_atom_fc67ba71() and fn16()
		then
			mMovie:__wf_atom_7f57ab2f(self.mParent.mClipName, "SendMessageBar", 13, false)
		else
			mMovie:__wf_atom_7f57ab2f(self.mParent.mClipName, "SendMessageBar", 13, true)
		end

		if
			not Engine.__wf_atom_4078373f()
			and not Engine.__wf_atom_2a979d69()
			and not Engine.__wf_atom_5df63302()
			and not __wf_atom_7e8ad928(mWindow.mInputPanel)
			and mMovie:__wf_atom_a91463a8(mWindow.mInputPanel.mClipPath, 13)
		then
			mWindow.mInputPanel:GiveChatFocus()
		end

		self:PopulateUserList(true)
	end

	function v54:_removeUserMsgs(p)
		local v57 = { self.mLineLog, self.mCachedLines }

		for i = 1, #v57 do
			if v57[i] == nil then
				continue
			end

			local v58 = v57[i]
			local v59 = 1

			while v59 <= #v58 do
				__wf_atom_83c14687(0)

				if v58[v59].sender == nil or v58[v59].sender ~= p then
					v59 += 1
				else
					table.remove(v58, v59)
				end
			end
		end

		self:ClearHistory()

		if self.mIsActive then
			self:RefreshText()
		end
	end

	function v54:_onLineAdded(value2, MESSAGE_TYPE_INVALID, timeStamp, p, p2, value3)
		if
			not self.mIsChatEnabled
			or Engine.__wf_atom_fc67ba71() and fn16() and MESSAGE_TYPE_INVALID ~= self.MESSAGE_TYPE_BROADCAST
		then
			return
		end

		if MESSAGE_TYPE_INVALID == nil then
			MESSAGE_TYPE_INVALID = self.MESSAGE_TYPE_INVALID
		end

		if
			MESSAGE_TYPE_INVALID == self.MESSAGE_TYPE_JOIN_CHANNEL
			or MESSAGE_TYPE_INVALID == self.MESSAGE_TYPE_LEAVE_CHANNEL
		then
			return
		end

		if not p2 then
			self.mCanFlash = true
		end

		if
			(not self.mIsActive or self.mParent.mVisualMode == self.mParent.VISUAL_MODE_MENU_SIMPLE)
			and MESSAGE_TYPE_INVALID ~= self.MESSAGE_TYPE_SYSTEM
			and MESSAGE_TYPE_INVALID ~= self.MESSAGE_TYPE_BROADCAST
			and not __wf_atom_7e8ad928(self.mTabElement)
		then
			if self.mIsFlashingEnabled then
				self.mParent.mTabMenu:StartFlashing(self.mTabElement)
			end

			if MESSAGE_TYPE_INVALID ~= self.MESSAGE_TYPE_FRIEND then
				local v57 = string.lower(value2)
				local v58, v59 = string.find(v57, self.mParent.mSearchUserName, 0, true)

				if v58 ~= nil and string.find(v57, "^[^%s%p]", v59 + 1) == nil then
					if not (mMuteNotificationSounds or __wf_atom_7e8ad928(_G.UISound_ChatDM)) then
						module.PlaySound(_G.UISound_ChatDM)
					end

					self.mParent.mTabMenu:ShowPersonalNotification(self.mTabElement)
				end
			end
		end

		if not self.mIsActive then
			self.mCachedLines[#self.mCachedLines + 1] = {
				Line = value2,
				MsgType = MESSAGE_TYPE_INVALID,
				TimeStamp = timeStamp,
				sender = value3
			}
			return
		end

		if not p2 then
			self.mParent:ResetFadeOutTimer()
		end

		if self.mLineLog == nil then
			self.mLineLog = {}
		end

		while #self.mLineLog > self.mMaxChatHistory do
			table.remove(self.mLineLog, 1)
		end

		local v57 = #self.mLineLog + 1
		self.mLineLog[v57] = {
			text = value2,
			messageType = MESSAGE_TYPE_INVALID,
			timeStamp = timeStamp,
			sender = value3,
			hyperLinks = {}
		}
		local ternary = module.Ternary(mEmojiSettings.Enabled, mMovie:__wf_atom_b4b867f2(value2, true), value2)

		if self.mParent.mShowTimeStamps ~= nil and self.mParent.mShowTimeStamps then
			ternary = timeStamp .. ternary
		end

		local lineEntry = self:_makeLineEntry(ternary, MESSAGE_TYPE_INVALID, value3)

		while #self.mChatHistory + #lineEntry > self.mMaxChatHistory do
			table.remove(self.mChatHistory, 1)
		end

		for i = 1, #lineEntry do
			if lineEntry[i].text == "" then
				continue
			end

			table.insert(self.mChatHistory, lineEntry[i])

			for j = 1, #lineEntry[i].hyperLinks do
				table.insert(self.mLineLog[v57].hyperLinks, lineEntry[i].hyperLinks[j])
			end
		end

		if value3 ~= nil and value3 ~= "" then
			v22[string.lower(value3)] = true
		end

		self.mHasHyperlink = self.mHasHyperlink or #self.mLineLog[v57].hyperLinks > 0
		local count = #self.mChatHistory
		local v58 = self.mMaxVisibleChatLines / count
		self.mTextScroll.mScrollStep = 1 / (count - self.mMaxVisibleChatLines)
		self.mTextScroll:SetVisibleProp(v58, true)

		if self.mScrollBack > 0 then
			self.mScrollBack = __wf_atom_421b01aa(self.mScrollBack + #lineEntry, 0, self.mMaxChatHistory)
			local count2 = #self.mChatHistory
			local v59 = self.mScrollBack / (count2 - self.mMaxVisibleChatLines)
			self.mTextScroll:SetScrollValue(1 - v59, nil, count2 == self.mMaxChatHistory)
		else
			self.mTextScroll:SetScrollValue(1)
		end

		if not p then
			self:RefreshText()
		end
	end

	function v54:SystemMessage(p, p2)
		self:_onLineAdded(p, self.MESSAGE_TYPE_SYSTEM, "", false, p2)
	end

	function v54:NotificationMessage(p)
		self:_onLineAdded(p, self.MESSAGE_TYPE_NOTIFICATION, "")
	end

	function v54:OnChatMessageReceived(p, value2, value3, p2, p3, p4, p5)
		if not self.mIsChatEnabled then
			return
		end

		local MESSAGE_TYPE_BROADCAST = nil
		local v57 = ""
		local v58 = ""

		if string.find(value2, "#") == nil then
			if p == "" then
				MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_BROADCAST
				v57 = value3
			elseif self.mChannelType >= self.mParent.CHANNEL_PRIVATE_CHAT then
				return
			end
		else
			if value2 ~= "#" .. self.mChannelName then
				return
			end

			if p == "" then
				if value3 == "" or string.sub(value2, 2, 2) ~= self.mParent:_getClanChannelPrefix() then
					if value3 ~= "" and string.sub(value3, 1, 1) == "/" then
						value3 = mMovie:__wf_atom_8e9ac384(value3, false)
					end

					if Engine.__wf_atom_2a979d69() then
						value3 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/IRC/Chat_LegalDisclaimer_IOS", false)
					end

					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_SYSTEM
					v57 = value3
				else
					v57 = mMovie:__wf_atom_8e9ac384(value3, false)
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_CLAN
				end
			else
				local v59 = string.sub(value2, 2, 2)

				if
					p5 >= 3
					and v59 ~= self.mParent:_getClanChannelPrefix()
					and v59 ~= self.mParent:_getAllianceChannelPrefix()
					and (mUIMode ~= module3.UI_MODE_IN_DOJO or v59 ~= self.mParent:_getHubChannelPrefix())
				then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_STAFF
				elseif
					v50
					and p5 >= 2
					and v59 ~= self.mParent:_getClanChannelPrefix()
					and v59 ~= self.mParent:_getAllianceChannelPrefix()
					and (mUIMode ~= module3.UI_MODE_IN_DOJO or v59 ~= self.mParent:_getHubChannelPrefix())
				then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_WG_MOD
				elseif v59 == self.mParent:_getRegionChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_REGION
				elseif v59 == self.mParent:_getClanChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_CLAN
				elseif v59 == self.mParent:_getSquadChannelPrefix() then
					if not fn32(p) then
						return
					end

					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_SQUAD
				elseif v59 == self.mParent:_getCouncilChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_COUNCIL
				elseif v59 == self.mParent:_getRecruitingChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_RECRUITING
				elseif v59 == self.mParent:_getTradeChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_TRADE
				elseif v59 == self.mParent:_getAllianceChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_ALLIANCE
				elseif v59 == self.mParent:_getHubChannelPrefix() then
					MESSAGE_TYPE_BROADCAST = self.MESSAGE_TYPE_HUB
				end

				v57 = mMovie:__wf_atom_8e9ac384(v58, true) .. p .. ": " .. value3
			end
		end

		self:_onLineAdded(v57, MESSAGE_TYPE_BROADCAST, p2, p3, p4, p)
	end

	function v54:OnResizePress()
		self.Resizing = true
		self.mParent.mUserPanel:Clear()
	end

	function v54:OnResizeRelease()
		if self.Resizing then
			self.Resizing = false
			self:PopulateUserList(false)
		end
	end

	return v54
end

function ChatChannelJoinUserList(p, p2)
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:OnChatChannelJoinUserList(p, p2)
	end
end

function ChatChannelJoin(p, p2)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mMovie)) then
		mWindow:OnUserJoin(p, p2)
	end
end

function ChatChannelLeft(p, p2)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mMovie)) then
		local v54 = StringSplit(",", p2)
		local v55, v56

		if #v54 == 2 then
			v55 = v54[1]

			if v54[2] == "true" then
				v56 = true
			else
				v56 = false
			end
		else
			v55 = ""
			v56 = false
		end

		mWindow:OnUserLeave(p, v55, v56)
	end
end

function ChatMessageReceived(p, value)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mMovie)) then
		if _G.StalkerMode and value and string.find(value, "Welcome, Tenno.") then
			return
		else
			mWindow:OnChatMessageReceived(p, value)
		end
	end
end

function InvalidWhisperTarget(p)
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:OnInvalidWhisperTarget(p)
	end
end

function OnClanStateChanged(p)
	if not (__wf_atom_7e8ad928(mWindow) or module.IsUGCRestricted()) then
		mWindow:OnChannelStateChanged(p, "#Cclanname")
	end
end

function WindowTabSelected(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mGrid) or mInputBlocked) then
		mWindow.mGrid:SelectElementById((tonumber(p)))
	end
end

function WindowTabFocused(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mGrid) or mInputBlocked) then
		mWindow.mGrid:FocusElementById((tonumber(p)))
	end
end

function WindowTabUnfocused(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mGrid)) then
		mWindow.mGrid:UnfocusElementById((tonumber(p)))
	end
end

function EntryFocused(p)
	if
		not __wf_atom_7e8ad928(mWindow)
		and not __wf_atom_7e8ad928(mWindow.mTabMenu)
		and not mInputBlocked
		and not __wf_atom_7e8ad928((mWindow.mTabMenu:GetElementById((tonumber(p)))))
		and (Engine.IsPlayingWithController() or mWindow.mTabMenu:IsMouseInTabMask())
	then
		mWindow.mTabMenu:FocusElementById((tonumber(p)))
	end
end

function EntryUnfocused(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mTabMenu)) then
		mWindow.mTabMenu:UnfocusElementById((tonumber(p)))
	end
end

function EntryPressed(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mTabMenu) or mInputBlocked) then
		mWindow:OnWindowTitlePress()
		module.PlaySound(_G.UISound_ItemTipSection)
		local elementById2 = mWindow.mTabMenu:GetElementById((tonumber(p)))

		if
			not __wf_atom_7e8ad928(elementById2)
			and (Engine.IsPlayingWithController() or mWindow.mTabMenu:IsMouseInTabMask())
		then
			mWindow:SetActive(mWindow.mPanelList[elementById2.ChannelName])

			if fn33() then
				fn2(false)

				if not Engine.IsPlayingWithController() then
					mWindow.mTabMenu:UnfocusElementById((tonumber(p)))
				end
			end

			if Engine.__wf_atom_2a979d69() then
				mFocusTabDownStart = __wf_atom_c4e218a2()
			end
		end
	end
end

function EntryReleased(_)
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:OnWindowTitleRelease()

		if Engine.__wf_atom_2a979d69() then
			mFocusTabDownStart = nil
		end
	end
end

fn2 = function(p)
	if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
		module.CreateParticles(mMovie, "Window.SendMessageBar.ChatIcon", _G.UIFx_ConsolePress, 0, 0)
	end

	if Engine.IsPlayingWithController() then
		_T.gToolTip = nil
	end

	if Engine.__wf_atom_2a979d69() then
		local v54 = mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_FULL, p)

		if v54 then
			mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn", 0, -30)
			UpdateExpandCalloutPos()
			module.CreateParticles(mMovie, "Window.SendMessageBar.ChatIcon", _G.UIFx_ConsolePress, 60, 20)
		end
	else
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_FULL, p)
	end

	if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
		_T.ForegroundMovie:Execute("TogglePlayTypeDropDown", "false")
	end
end

function MaximizeButton()
	if not mInputBlocked then
		fn2()
	end
end

function IsMaximized()
	return not __wf_atom_7e8ad928(mWindow) and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
end

function IsFull()
	return not __wf_atom_7e8ad928(mWindow)
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
end

function AlphabetExpanderFocused()
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Callout", 12, 100)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Arrow", 12, 100)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Btn", 12, 100)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Label", 44, _G.UIColor_Yellow)
end

function AlphabetExpanderUnfocused()
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Callout", 12, 50)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Arrow", 12, 50)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Btn", 12, 50)
	mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Label", 44, _G.UIColor_Gold)
end

local function fn55()
	if
		not mInputBlocked
		and not __wf_atom_7e8ad928(mWindow.mUserPanel)
		and not __wf_atom_7e8ad928(mWindow.mUserPanel.mUserLocator)
		and mWindow.mUserPanel.mIsExpanded
		and not mWindow.mUserPanel.mUserListInterpolating
	then
		if Engine.IsPlayingWithController() then
			module.CreateParticles(mMovie, "Window.UserPanel.Panel.LocatorBtn.Callout", _G.UIFx_ConsolePress, 0, 0)
		end

		mWindow.mUserPanel:ToggleLocator()
	end
end

function AlphabetExpanderPressed()
	fn55()
end

function AlphabetIndexRollOver(p)
	if
		mInputBlocked
		or __wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mUserLocator)
		or not mWindow.mUserPanel.mUserLocator.mIsExpanded
	then
		return
	end

	mWindow.mUserPanel.mUserLocator:FocusElementById((tonumber(p)))
end

function AlphabetIndexRollOut(p)
	if
		mInputBlocked
		or __wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mUserLocator)
		or not mWindow.mUserPanel.mUserLocator.mIsExpanded
	then
		return
	end

	mWindow.mUserPanel.mUserLocator:UnfocusElementById((tonumber(p)))
end

function AlphabetIndexPressed(p)
	if
		mInputBlocked
		or __wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mUserLocator)
		or not mWindow.mUserPanel.mUserLocator.mIsExpanded
	then
		return
	end

	mWindow.mUserPanel.mUserLocator:SelectElementById((tonumber(p)))
end

function ChatConnectionChanged(p, p2)
	if not (__wf_atom_7e8ad928(mMovie) or __wf_atom_7e8ad928(mWindow)) then
		mWindow:OnConnectionChanged(p, p2)
	end
end

function OnIgnoreUser(user, p)
	if p ~= "nil" then
		if p == "true" then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_IgnoringUser", false, {
				USER = user
			}))
		else
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ListeningUser", false, {
				USER = user
			}))
		end
	end
end

local function fn56(mClipName2)
	local v54 = {
		VISUAL_MODE_INVALID = -1,
		VISUAL_MODE_MENU_FULL = 0,
		VISUAL_MODE_MENU_SIMPLE = 1,
		VISUAL_MODE_GAMEPLAY_SIMPLE = 2,
		VISUAL_MODE_GAMEPLAY_FULL = 3,
		CHANNEL_EXIT = 0,
		CHANNEL_ENTER = 1,
		CHANNEL_SESSION = 0,
		CHANNEL_HUB = 1,
		CHANNEL_CLAN = 2,
		CHANNEL_ALLIANCE = 3,
		CHANNEL_COUNCIL = 4,
		CHANNEL_GLOBAL = 5,
		CHANNEL_QA = 6,
		CHANNEL_RECRUITING = 7,
		CHANNEL_TRADE = 8,
		CHANNEL_PRIVATE_CHAT = 9,
		mClipName = mClipName2,
		mUser = "",
		mMouseX = 0,
		mMouseY = 0,
		mMouseIsDragging = false,
		mWindow = {},
		mChatPanelWindow = {},
		mWindowTitle = {},
		mWindowStatus = {},
		mCachedGuildId = nil,
		mCachedGuildMotd = "",
		mCachedAllianceId = nil,
		mCachedAllianceMotd = "",
		mCachedSessionID = nil,
		mCachedCurSessionName = "",
		mCachedOldSessionName = "",
		mCachedHostHistoryCount = 1,
		mCachedCouncilLevel = 0,
		mCachedRecruiting = false,
		mCachedHubID = nil,
		mCachedUIMode = nil,
		mCachedPersistentRelayHubActive = false,
		mIsScenarioChannel = false,
		mFocusHubOnActive = true,
		mFontIndex = 1,
		mInputPanel = nil,
		mUserPanel = nil,
		mPanelList = {},
		mPanelShortcuts = {},
		mActivePanelName = "",
		mPrevPanelName = "",
		mFontButtonWidth = 0,
		mTabMenu = nil
	}
	v54.mNextPrivateChatId = v54.CHANNEL_PRIVATE_CHAT
	v54.mDelayedFadeOutTimer = module.Ternary(__wf_atom_72884638("HUD.UseAlternateHud"), 0.01, 8)
	v54.mActiveTabListFadeOutTimer = 0
	v54.mMenuTabListFadeOutTimer = 0
	v54.mActiveChatFadeOutTimer = 0
	v54.mIsConnected = false
	v54.mPendingChannels = {}
	v54.mPendingGlobalChannelName = nil
	v54.mPendingRecruitingChannelName = nil
	v54.mPendingTradeChannelName = nil
	v54.mPendingCouncilChannelName = nil
	v54.mPendingQAChannelName = nil
	v54.mVisualMode = v54.VISUAL_MODE_INVALID
	v54.mMode = v54.CHANNEL_GLOBAL
	v54.mTopResizeClipName = "Window.TabMenu.Resize"
	v54.mBottomResizeClipName = "Window.WindowStatus.Resize"
	v54.mHasRecievedBroadcast = false
	v54.mReconnecting = false
	v54.mMenuPanelXPos = 0
	v54.mLeftArrowFocused = false
	v54.mLeftArrowFlashing = false
	v54.mRightArrowFocused = false
	v54.mRightArrowFlashing = false
	v54.mFilterList = nil
	v54.mFilterBtnOffset = 20
	v54.mInitChatPanelScrollXScale = mMovie:__wf_atom_5e6e15c8(mClipName2 .. ".TabbedChatPanel.ScrollBar.HitZone", 5)
	v54.mInQuestCommitment = module3.InQuestCommitment()
	v54.mPrivateChatPartners = {}
	v54.mPrivateChatUseUniqueName = false

	function v54:OnConnectionChanged(p, p2)
		local mIsConnected = tonumber(p) ~= 0
		local v56 = 0

		if mIsConnected then
			if self.mReconnecting then
				self:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_Reconnected", false))
				self.mReconnecting = false
			end
		else
			if p2 == "Reconnect" then
				self.mReconnecting = false
			elseif p2 ~= "" then
				self:SystemMessage(p2)

				if self.mIsConnected then
					self.mReconnecting = true
				end
			end

			if __wf_atom_7e8ad928(gMatchingService) then
				return
			end

			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
				v56 = __wf_atom_7190444e:__wf_atom_d30c4678()
			end
		end

		self.mIsConnected = mIsConnected
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.WindowTitle.Arrows", 13, self.mIsConnected)
		mMovie:__wf_atom_7f57ab2f(
			self.mClipName,
			"TabMenu.WindowTitle.Spinner",
			13,
			not self.mIsConnected and v56 < 120
		)

		if mIsConnected then
			if #self.mPendingChannels > 0 then
				local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

				if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
					for i = 1, #self.mPendingChannels do
						__wf_atom_7190444e:__wf_atom_0beacbb1(self.mPendingChannels[i])
					end
				end

				self.mPendingChannels = {}
			end
		elseif not __wf_atom_7e8ad928(mWindow.mPanelList) then
			for _, v57 in pairs(mWindow.mPanelList) do
				local v58 = "#" .. v57.mChannelName
				local v59

				if
					v57.mChannelType == self.CHANNEL_GLOBAL and self.mPendingGlobalChannelName ~= nil
					or v57.mChannelType == self.CHANNEL_RECRUITING and self.mPendingRecruitingChannelName ~= nil
					or v57.mChannelType == self.CHANNEL_TRADE and self.mPendingTradeChannelName ~= nil
					or v57.mChannelType == self.CHANNEL_QA and self.mPendingQAChannelName ~= nil
				then
					v59 = true
				elseif v57.mChannelType == self.CHANNEL_COUNCIL then
					v59 = self.mPendingCouncilChannelName ~= nil
				else
					v59 = false
				end

				if
					not v59
					and string.sub(v58, 2, 2) ~= self._getPrivateChatChannelPrefix()
					and module.FindInTable(self.mPendingChannels, v58) == -1
				then
					table.insert(self.mPendingChannels, v58)
				end

				v57.mInitialPopulationDone = false
			end
		end
	end

	function v54:SetVisualMode(VISUAL_MODE_GAMEPLAY_SIMPLE, p)
		local v55 = 100
		local v56 = { "Window.TabMenu" }
		local v57 = {
			"Window.FontIncrease",
			"Window.TabbedChatPanel.ScrollBar",
			"Window.TabbedChatPanel.Fill",
			"Window.TabbedChatPanel.Divider",
			"Window.TabbedChatPanel.EdgeLeft",
			"Window.TabbedChatPanel.EdgeRight",
			"Window.TabbedChatPanel.DecoLine",
			"Window.TabbedChatPanel.DecoCurve",
			"Window.TabbedChatPanel.FilterBtn",
			"Window.TabbedChatPanel.FilterList",
			"Window.TabbedChatPanel.FilterListMask",
			"Window.SendMessageBar",
			"Window.UserPanel",
			"Window.MouseCatcherBtn",
			"Window.WindowStatus"
		}

		if mChatHidden then
			VISUAL_MODE_GAMEPLAY_SIMPLE = self.VISUAL_MODE_GAMEPLAY_SIMPLE
		end

		if __wf_atom_72884638("Lotus.EnableTraceLogging") then
			print("SetVisualMode(" .. VISUAL_MODE_GAMEPLAY_SIMPLE .. ")")
		end

		if Engine.IsPlayingWithController() then
			table.insert(v57, "Window.TabbedChatPanel.FilterCallout")

			if _T.TopMenuOpen and VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL then
				mMovie:__wf_atom_0cf0fdbe(0.6)
			else
				mMovie:__wf_atom_0cf0fdbe(0)
			end
		end

		local v58

		if mWindow:GetActivePanel() then
			v58 = fn11()
		end

		if
			VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL
			or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
		then
			mMovie:__wf_atom_976dcedd("Window", "noMenuSelection", false)
			mMovie:__wf_atom_976dcedd("Window.TabMenu", "noMenuSelection", false)

			if __wf_atom_21342f4a ~= nil and v58 ~= nil then
				__wf_atom_21342f4a:StartTimer(Symbol("IN_CHAT_VIEW_TIME"), v58)
			end
		else
			mMovie:__wf_atom_976dcedd("Window", "noMenuSelection", true)
			mMovie:__wf_atom_976dcedd("Window.TabMenu", "noMenuSelection", true)

			if __wf_atom_21342f4a ~= nil and v58 ~= nil then
				__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_CHAT_VIEW_TIME"), v58)
			end
		end

		local chatMaximized = VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL
			or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
		_T.ChatMaximized = chatMaximized

		if not mInSubScreen then
			if VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_SIMPLE or mChatHidden then
				mMovie:__wf_atom_c884ca43(true)
				mMovie:__wf_atom_b4ffb30f(false)
			elseif
				VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL
				or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
				or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_SIMPLE
			then
				mMovie:__wf_atom_c884ca43(false)
				mMovie:__wf_atom_b4ffb30f(true)
			end
		end

		if chatMaximized then
			if not __wf_atom_7e8ad928(self.mUserPanel) then
				local coordsRelativeToParent = self:GetCoordsRelativeToParent(self.mUserPanel.mWindow)
				self.mUserPanel:UpdateElementVisibilityRange(coordsRelativeToParent.height)
				self.mUserPanel.mListControl:Redraw(nil, nil, true)
			end

			local activePanel = self:GetActivePanel()

			if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(self.mTabMenu)) then
				self.mTabMenu:StopFlashing(activePanel.mTabElement)
			end
		else
			local __wf_atom_94bf489f = mMovie:__wf_atom_94bf489f()

			if not __wf_atom_7e8ad928(__wf_atom_94bf489f) and __wf_atom_94bf489f == "MessageBox" then
				mMovie:__wf_atom_2004c47f()
			end
		end

		local mVisualMode = self.mVisualMode

		if
			VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL
			or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
			or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_SIMPLE
		then
			mMovie:__wf_atom_e57658c2("Window.Hint", 12, 0)
		end

		if
			VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL and self.mVisualMode ~= self.VISUAL_MODE_MENU_FULL
			or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
			and self.mVisualMode ~= self.VISUAL_MODE_GAMEPLAY_FULL
		then
			self.mVisualMode = VISUAL_MODE_GAMEPLAY_SIMPLE
			self:SetCompressed(false, not p)

			for k, v60 in pairs(self.mPanelList) do
				if __wf_atom_7e8ad928(v60) or k == self.mActivePanelName then
					continue
				end

				v60:RefreshText()
			end

			if __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
				if not __wf_atom_7e8ad928(self.mTabMenu) and self.mTabMenu:GetHowManyElements() > 0 then
					local elementInIndex = self.mTabMenu:GetElementInIndex(1)

					if not __wf_atom_7e8ad928(elementInIndex) then
						self:SetActive(self.mPanelList[elementInIndex.ChannelName])
					end
				end
			else
				self.mPanelList[self.mActivePanelName]:RefreshText()
			end

			if
				not Engine.__wf_atom_4078373f()
				and not Engine.__wf_atom_2a979d69()
				and not Engine.__wf_atom_5df63302()
				and not __wf_atom_7e8ad928(self.mInputPanel)
				and (VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL)
			then
				self.mInputPanel:GiveChatFocus()
			end
		elseif VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_SIMPLE then
			self.mVisualMode = VISUAL_MODE_GAMEPLAY_SIMPLE
			self:SetCompressed(true, not p)
		end

		if VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_SIMPLE then
			v55 = 0
			_T.gToolTip = nil

			if mVisualMode == self.VISUAL_MODE_MENU_SIMPLE then
				self:HideFadeOut()
			end
		else
			self:ResetFadeOutTimer()
			mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel", 12, 100)
		end

		self.mVisualMode = VISUAL_MODE_GAMEPLAY_SIMPLE

		for i = 1, #v56 do
			mMovie:__wf_atom_e57658c2(v56[i], 12, v55)
			mMovie:__wf_atom_2dedec1a(v56[i], 13, v55 > 0)
		end

		for i = 1, #v57 do
			mMovie:__wf_atom_2dedec1a(v57[i], 13, chatMaximized)
		end

		local v60 = VISUAL_MODE_GAMEPLAY_SIMPLE ~= self.VISUAL_MODE_MENU_SIMPLE

		if __wf_atom_72884638("HUD.UseAlternateHud") then
			v60 = chatMaximized
		end

		mMovie:__wf_atom_2dedec1a("Window.TabbedChatPanel", 13, v60)
		mMovie:__wf_atom_2dedec1a(
			"Window.TabMenu.MenuPanel",
			13,
			VISUAL_MODE_GAMEPLAY_SIMPLE ~= self.VISUAL_MODE_GAMEPLAY_SIMPLE
		)

		if not (__wf_atom_7e8ad928(self.mTabMenu) or __wf_atom_7e8ad928(self.mTabMenu.mSelectedElement)) then
			if
				VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_SIMPLE
				and self.mTabMenu.mSelectedElement.isFlashing
			then
				self.mTabMenu:StopFlashing(self.mTabMenu.mSelectedElement)
			end

			self.mTabMenu:SetTabColour(self.mTabMenu.mSelectedElement, false)
		end

		if self.mVisualMode == self.VISUAL_MODE_GAMEPLAY_SIMPLE then
			self.mSimpleTabList:Redraw(nil, true, true)
		end

		if Engine.__wf_atom_2a979d69() then
			_T.MinimizeChat = MinimizeButton
			mMovie:__wf_atom_2dedec1a("Window.Hint", 13, false)
			mMovie:__wf_atom_2dedec1a("Window.TabMenu.MinMaxBtn.Separator", 13, false)
			mMovie:__wf_atom_2dedec1a("Window.TabMenu.Resize", 13, false)
			mMovie:__wf_atom_2dedec1a("Window.WindowStatus.Resize", 13, false)
			local ternary = module.Ternary(
				not mInputBlocked and _T.TopMenuOpen and self.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL,
				0.6,
				0
			)
			mMovie:__wf_atom_0cf0fdbe(ternary)
			mUIMode = module3.GetUIMode()
			local v61 = (_T.ArsenalOpen or _T.ArsenalUpgradeOpen or _T.ModScreenOpen) and IsMaximized()
			local topMenuOpen

			if mUIMode == module3.UI_MODE_IN_GAME then
				topMenuOpen = _T.TopMenuOpen
			else
				topMenuOpen = false
			end

			local topMenuOpen2

			if mUIMode == module3.UI_MODE_IN_GAME then
				topMenuOpen2 = false
			else
				topMenuOpen2 = _T.TopMenuOpen
			end

			if mUIMode == module3.UI_MODE_IN_SPACE_SHIP and not _T.UIInputEnabled then
				mMovie:__wf_atom_2dedec1a("Window.TabMenu.MinMaxBtn", 13, false)
			elseif topMenuOpen or v61 or topMenuOpen2 then
				mMovie:__wf_atom_2dedec1a("Window.TabMenu.MinMaxBtn", 13, true)
			else
				mMovie:__wf_atom_2dedec1a("Window.TabMenu.MinMaxBtn", 13, false)
			end

			if Engine.IsPlayingWithController() then
				mMovie:__wf_atom_2dedec1a("Window.TabMenu.ExpandCallout", 13, true)
			end

			if self.mVisualMode == self.VISUAL_MODE_GAMEPLAY_SIMPLE then
				for k, v62 in pairs(self.mPanelList) do
					if __wf_atom_7e8ad928(v62) or k == self.mActivePanelName then
						continue
					end

					v62:RefreshText()
				end

				if not __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
					local v62 = self.mPanelList[self.mActivePanelName]
					mMovie:__wf_atom_50d60589(v62.mClipPath .. ".ChatArea", 36, "")
				end
			end
		end

		self:SetMinMaxBtnPos()

		if not __wf_atom_7e8ad928(self.mInputPanel) then
			mMovie:__wf_atom_4c1c1986(self.mInputPanel.mClipPath, "Callout", 12, v55)
		end

		if not mInSubScreen and Engine.IsPlayingWithController() and _T.SetButtonBarEnabled then
			if
				VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_GAMEPLAY_FULL
				or VISUAL_MODE_GAMEPLAY_SIMPLE == self.VISUAL_MODE_MENU_FULL
			then
				_T.SetButtonBarEnabled(false)
			else
				_T.SetButtonBarEnabled(true)
			end
		end
	end

	function v54:OnWindowTitlePress()
		mMovie:__wf_atom_976dcedd(self.mClipName, "trackAsMenu", true)
		self.mWindowTitle.isDragging = true
	end

	function v54:OnWindowTitleRelease()
		mMovie:__wf_atom_976dcedd(self.mClipName, "trackAsMenu", false)
		self.mWindowTitle.isDragging = false
	end

	function v54.OnWindowTitleRollOver() end

	function v54.OnWindowTitleRollOut() end

	function v54:OnResizePress(resizeClipName)
		if self.mVisualMode == self.VISUAL_MODE_MENU_SIMPLE then
			return
		end

		mMovie:__wf_atom_976dcedd(resizeClipName, "trackAsMenu", true)
		mMovie:__wf_atom_e57658c2(resizeClipName, 12, 100)
		self.mWindowStatus.isDragging = true
		self.mWindowStatus.ResizeClipName = resizeClipName

		if self.mPanelList[self.mActivePanelName] ~= nil then
			self.mPanelList[self.mActivePanelName]:OnResizePress()
		end
	end

	function v54:OnResizeRelease(p)
		mMovie:__wf_atom_976dcedd(p, "trackAsMenu", false)
		mMovie:__wf_atom_e57658c2(p, 12, 50)
		self.mWindowStatus.isDragging = mMouseDown

		if self.mPanelList[self.mActivePanelName] ~= nil then
			self.mPanelList[self.mActivePanelName]:OnResizeRelease()
		elseif self.Resizing then
			self.Resizing = false
		end
	end

	function v54:OnResizeRollOver(p)
		mMovie:__wf_atom_e57658c2(p, 12, 75)
	end

	function v54:OnResizeRollOut(p)
		mMovie:__wf_atom_e57658c2(p, 12, 50)
	end

	function v54:GetCoordsRelativeToParent(data)
		return {
			x = data.x + module.Ternary(data.ReverseX, self.mWindow.width, 0),
			y = data.y + module.Ternary(data.ReverseY, self.mWindow.height, 0),
			width = data.width + module.Ternary(data.ReverseWidth, self.mWindow.width, 0),
			height = data.height + module.Ternary(data.ReverseHeight, self.mWindow.height, 0)
		}
	end

	function v54:CreateSimpleTabList()
		self.mSimpleTabList = module14.CreateList(mMovie, self.mClipName .. ".Hint.SimpleTabList.SimpleElement")
		self.mSimpleTabList.mForcedHorizontalSeparation = 0
		self.mSimpleTabList.mForcedVerticalSeparation = 0
		self.mSimpleTabList.mFlashDuration = 3

		function self.mSimpleTabList:GetIndexForTabId(p)
			local v55 = 2

			for i = 2, self:GetHowManyElements() do
				if p <= self:GetElementInIndex(i).mTabId then
					break
				else
					v55 += 1
				end
			end

			return v55
		end

		function self.mSimpleTabList:GetElementByTabId(p)
			local v55 = nil

			for i = 1, self:GetHowManyElements() do
				local elementInIndex = self:GetElementInIndex(i)

				if elementInIndex.mTabId == p then
					return elementInIndex
				else
					v55 = nil
				end
			end

			return v55
		end

		function self.mSimpleTabList:ShowPersonalNotification(mTabId, p)
			local elementByTabId = self:GetElementByTabId(mTabId)

			if __wf_atom_7e8ad928(elementByTabId) then
				if p then
					self:InsertElement(
						self:GetIndexForTabId(mTabId),
						{ mTabId = mTabId, mHasPersonalNotification = true },
						mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE,
						true
					)
				end
			else
				elementByTabId.mHasPersonalNotification = true

				if not __wf_atom_7e8ad928(elementByTabId.mClipName) then
					mMovie:__wf_atom_7f57ab2f(elementByTabId.mClipName, "Dot", 13, true)
				end
			end
		end

		function self.mSimpleTabList:FlashTab(p)
			local elementInIndex = self:GetElementInIndex((self:GetIndexForTabId(p)))

			if not __wf_atom_7e8ad928(elementInIndex) then
				elementInIndex.mFlashingTimer = mWindow.mDelayedFadeOutTimer
				elementInIndex.mBouncing = false
			end
		end

		function self.mSimpleTabList:AddTab(mTabId)
			self:InsertElement(
				self:GetIndexForTabId(mTabId),
				{ mTabId = mTabId },
				mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE,
				true
			)
		end

		function self.mSimpleTabList:RemoveTab(p, p2)
			local elementByTabId = self:GetElementByTabId(p)

			if not __wf_atom_7e8ad928(elementByTabId) then
				if elementByTabId.mIndex == 1 then
					if not __wf_atom_7e8ad928(elementByTabId.mClipName) then
						elementByTabId.mHasPersonalNotification = false
						mMovie:__wf_atom_7f57ab2f(elementByTabId.mClipName, "Dot", 13, false)

						if p2 then
							elementByTabId.mTabId = nil
							mMovie:__wf_atom_2dedec1a(elementByTabId.mClipName, 13, false)
						end
					end
				else
					local v55 = mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
					self:RemoveElement(elementByTabId.mIndex, v55, v55)
				end
			end
		end

		function self.mSimpleTabList.CalculateX(object, p)
			local mInitialX = object.mInitialX

			if p.mIndex > 1 then
				local elementInIndex = object:GetElementInIndex(p.mIndex - 1)

				if not __wf_atom_7e8ad928(elementInIndex) then
					mInitialX = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0) + mMovie:__wf_atom_5e6e15c8(
						elementInIndex.mClipName .. ".SelectedLine",
						14
					) + 5
				end
			end

			return mInitialX
		end

		function self.mSimpleTabList.mElementDrawCallback(data)
			if data.mClipName == nil or __wf_atom_7e8ad928(self.mTabMenu) then
				return
			end

			mMovie:__wf_atom_2dedec1a(data.mClipName, 13, data.mTabId ~= nil)

			if data.mTabId == nil then
				return
			end

			local elementById2 = self.mTabMenu:GetElementById(data.mTabId)

			if __wf_atom_7e8ad928(elementById2) then
				return
			end

			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 52, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Icon", 13, not __wf_atom_7e8ad928(elementById2.Icon))
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, (__wf_atom_7e8ad928(elementById2.Icon)))
			local v55

			if __wf_atom_7e8ad928(elementById2.Icon) then
				mMovie:__wf_atom_7d7314f1(data.mClipName .. ".Label.text", elementById2.Name)
				v55 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Label", 40)
			else
				mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", elementById2.Icon)
				v55 = 16
			end

			mMovie:__wf_atom_4c1c1986(data.mClipName, "Dot", 11, _G.UIColor_Red)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Dot", 13, data.mHasPersonalNotification == true)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Dot", 0, v55)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "SelectedLine", 11, v2.TAB_DECO_LINE_COLOR)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "SelectedLine", 14, v55)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "SelectedLine", 13, data.mIndex == 1)
		end

		if Engine.IsPlayingWithController() then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Hint.SimpleTabList", 0)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint.SimpleTabList", 0, __wf_atom_5e6e15c8 + 5)
		end

		self.mSimpleTabList:AddElement({ mTabId = nil }, true)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint.SimpleTabListMask", 1, -50)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint.SimpleTabListMask", 15, 100)
	end

	function v54:SetArrowVisibilities(p)
		local v55 = not p

		if v55 then
			if self.mVisualMode == self.VISUAL_MODE_MENU_FULL or self.mVisualMode == self.VISUAL_MODE_GAMEPLAY_FULL then
				v55 = not __wf_atom_7e8ad928(self.mTabMenu) and self.mTabMenu:GetHowManyElements() > 1
			else
				v55 = false
			end
		end

		local isPlayingWithController = Engine.IsPlayingWithController()
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.LeftBumper", 13, isPlayingWithController and v55)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.RightBumper", 13, isPlayingWithController and v55)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.LeftArrow", 13, not isPlayingWithController and v55)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.RightArrow", 13, not isPlayingWithController and v55)
	end

	function v54:AddTab(name, channelName, isActive)
		local v55 = self.mPanelList[channelName]
		local mChannelType = v55.mChannelType
		local icon

		if channelIcons[v55.mChannelType + 1] ~= nil then
			icon = channelIcons[v55.mChannelType + 1]
		end

		local v57 = 1
		local v58 = {
			Icon = icon,
			Name = name,
			ChannelName = channelName,
			IsActive = isActive,
			Id = mChannelType,
			isFlashing = false
		}

		for _ = 1, self.mTabMenu:GetHowManyElements() do
			local elementInIndex = self.mTabMenu:GetElementInIndex(v57)

			if v58.Id < elementInIndex.Id then
				break
			else
				v57 += 1
			end
		end

		print("ChatRedux::AddTab: Adding tab with channel name: " .. channelName .. " to index " .. tostring(v57))
		local v59 = self.mTabMenu:InsertElement(v57, v58)

		if
			v55.mIsFlashingEnabled
			and v55.mCanFlash
			and #v55.mCachedLines > 0
			and not (Engine.__wf_atom_fc67ba71() and fn16())
		then
			self.mTabMenu:StartFlashing(v59)
		end

		if Engine.__wf_atom_2a979d69() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			mMovie:__wf_atom_2dedec1a(v59.mClipName, 13, false)
		end

		self:SetArrowVisibilities()
		return v58
	end

	function v54:RemoveTab(value, p)
		local v55 = string.sub(value, 2, -1)
		print("ChatRedux::RemoveTab: Removing tab with name " .. v55 .. ", pSkipRedraw: " .. tostring(p))
		local count = #self.mTabMenu.mElements

		for i = 1, count do
			local mElement = self.mTabMenu.mElements[i]

			if mElement.ChannelName ~= v55 then
				continue
			end

			self.mTabMenu:StopFlashing(mElement, true)

			if count > 1 and not p then
				self.mTabMenu:OnRemoveElement(mElement, i)
			end

			self.mTabMenu:RemoveElement(i, p, p)
			break
		end

		self:SetArrowVisibilities()
	end

	function v54:_initializeTabs()
		self.mTabMenu = module14.CreateList(mMovie, "Window.TabMenu.MenuPanel.MenuEntry")
		self.mTabMenu:SetCallbacks(
			"EntryReleased",
			"EntryFocused",
			"EntryUnfocused",
			"EntryPressed",
			nil,
			nil,
			"EntryReleased"
		)
		self.mTabMenu.mForcedVerticalSeparation = 0
		self.mTabMenu.mForcedHorizontalSeparation = 0
		self.mTabMenu.mInitialX = 0
		self.mTabMenu.mParent = self
		__wf_atom_86cbd68d(
			mMovie,
			self.mTabMenu.mClipName .. ".swapDepths",
			self.mTabMenu.mInitialDepth + self.mTabMenu.mDepthDirection
		)

		function self.mTabMenu:OnRemoveElement(p, p2)
			local elementInIndex = self:GetElementInIndex(self:GetHowManyElements())

			if self.mInitialX >= 0 or __wf_atom_7e8ad928(elementInIndex) then
				return
			end

			local v55

			if elementInIndex.Id == p.Id then
				local elementInIndex2 = self:GetElementInIndex(p2 - 1)

				if __wf_atom_7e8ad928(elementInIndex2) then
					return
				else
					v55 = mMovie:__wf_atom_5e6e15c8(elementInIndex2.mClipName, 0) + mMovie:__wf_atom_5e6e15c8(
						elementInIndex2.mClipName .. ".Bg",
						14
					)
				end
			else
				local elementInIndex2 = self:GetElementInIndex(p2 + 1)

				if __wf_atom_7e8ad928(elementInIndex2) then
					return
				end

				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(elementInIndex2.mClipName, 0)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
				local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0)
				local v56 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName .. ".Bg", 14) - 10
				v55 = __wf_atom_5e6e15c8_3 - (__wf_atom_5e6e15c8 - __wf_atom_5e6e15c8_2) + v56
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.TabMask", 14)

			if v55 < __wf_atom_5e6e15c8 then
				self.mInitialX += math.min(__wf_atom_5e6e15c8 - v55, (math.abs(self.mInitialX)))
			end
		end

		function self.mTabMenu:ShowPersonalNotification(state)
			if __wf_atom_7e8ad928(state) then
				return
			end

			if not state.hasPersonalNotification then
				state.hasPersonalNotification = true
				mMovie:__wf_atom_7f57ab2f(state.mClipName, "Dot", 13, true)

				if not __wf_atom_7e8ad928(mWindow.mSimpleTabList) then
					mWindow.mSimpleTabList:ShowPersonalNotification(state.Id, true)
				end
			end
		end

		function self.mTabMenu:HidePersonalNotification(state)
			if __wf_atom_7e8ad928(state) then
				return
			end

			if state.hasPersonalNotification then
				state.hasPersonalNotification = false
				mMovie:__wf_atom_7f57ab2f(state.mClipName, "Dot", 13, false)
			end
		end

		function self.mTabMenu:StartFlashing(state)
			if not __wf_atom_7e8ad928(state) then
				if not state.isFlashing then
					state.isFlashing = true

					if
						not mMuteNotificationSounds
						and (state.Id == mWindow.CHANNEL_SESSION or state.Id >= mWindow.CHANNEL_PRIVATE_CHAT)
					then
						local ternary = module.Ternary(
							state.Id == mWindow.CHANNEL_SESSION,
							_G.UISound_ChatSquad,
							_G.UISound_ChatPM
						)

						if not __wf_atom_7e8ad928(ternary) then
							module.PlaySound(ternary)
						end
					end

					if
						not __wf_atom_7e8ad928(mWindow.mSimpleTabList)
						and (self.mSelectedElement == nil or self.mSelectedElement.Id ~= state.Id)
					then
						mWindow.mSimpleTabList:AddTab(state.Id)
					end
				end

				if
					not __wf_atom_7e8ad928(mWindow.mSimpleTabList)
					and mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
				then
					local v55

					if self.mSelectedElement == nil then
						v55 = false
					else
						v55 = self.mSelectedElement.Id == state.Id
					end

					if not mActiveTabNotificationsOnly or v55 then
						mWindow:ResetFadeOutTimer(not v55)
					end

					mWindow.mSimpleTabList:FlashTab(state.Id)
				end
			end
		end

		function self.mTabMenu:StopFlashing(state, p)
			if not __wf_atom_7e8ad928(state) then
				self:HidePersonalNotification(state)

				if state.isFlashing then
					state.isFlashing = false
					self:SetTabColour(state, false)
				end

				if not __wf_atom_7e8ad928(mWindow.mSimpleTabList) then
					mWindow.mSimpleTabList:RemoveTab(state.Id, p)
				end
			end
		end

		function self.mTabMenu:SetTabColour(data, p, p2)
			if data == nil then
				return
			end

			local v55 = 100
			local uiColor_Beige = _G.UIColor_Beige
			local focusedElement = self:GetFocusedElement()
			local v56 = not __wf_atom_7e8ad928(focusedElement)

			if v56 then
				if focusedElement.Id == data.Id then
					v56 = not p
				else
					v56 = false
				end
			end

			if
				self.mSelectedElement == nil
				or self.mSelectedElement.Id ~= data.Id
				or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE and data.isFlashing
			then
				if v56 then
					uiColor_Beige = _G.UIColor_LightYellow
					v55 = 100
				elseif data.isFlashing and not __wf_atom_7e8ad928(p2) then
					v55 = p2
				end
			else
				if
					mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
					or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
				then
					uiColor_Beige = _G.UIColor_Yellow
				end

				v55 = 100
			end

			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 12, v55)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, uiColor_Beige)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, v55)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, uiColor_Beige)
		end

		function self.mTabMenu:DrawDecoLine(p)
			if __wf_atom_7e8ad928(p) or p.mClipName == nil then
				return
			end

			local v55

			if self.mSelectedElement == nil then
				v55 = false
			else
				v55 = self.mSelectedElement.Id == p.Id
			end

			mMovie:__wf_atom_7f57ab2f(p.mClipName, "DecoLine", 13, v55)

			if not v55 then
				return
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p.mClipName .. ".Bg", 14)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "DecoLine", 14, __wf_atom_5e6e15c8 - 4)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "DecoLine", 11, v2.TAB_DECO_LINE_COLOR)
		end

		function self.mTabMenu:SetRightBumperPos()
			local howManyElements = self:GetHowManyElements()

			if howManyElements == 0 then
				mWindow:SetMinMaxBtnPos()
				return
			end

			local v55 = nil

			for i = howManyElements, 1, -1 do
				local elementInIndex = self:GetElementInIndex(i)

				if
					__wf_atom_7e8ad928(elementInIndex)
					or elementInIndex.mClipName == nil
					or not mMovie:__wf_atom_253d7085(elementInIndex.mClipName)
				then
					continue
				end

				v55 = elementInIndex
				break
			end

			if __wf_atom_7e8ad928(v55) then
				mWindow:SetMinMaxBtnPos()
				return
			end

			local v56 = mMovie:__wf_atom_cfc41e35(mWindow.mClipName, "TabMenu.MenuPanel", 0) + mMovie:__wf_atom_5e6e15c8(v55.mClipName, 0) + mMovie:__wf_atom_cfc41e35(v55.mClipName, "Label", 40) + 16
			local v57 = mMovie:__wf_atom_cfc41e35(mWindow.mClipName, "TabMenu.TabMask", 0) + mMovie:__wf_atom_5e6e15c8(
				mWindow.mClipName .. ".TabMenu.TabMask",
				14
			)
			local v58 = mMovie:__wf_atom_5e6e15c8(mWindow.mClipName .. ".TabMenu.RightBumper.Tf", 40) / 2
			local v59 = v56 + v58 + 12

			if v57 + v58 < v59 then
				v59 = v57 + v58
			end

			mMovie:__wf_atom_4c1c1986(mWindow.mClipName, "TabMenu.RightBumper", 0, v59)
			local v60 = mMovie:__wf_atom_5e6e15c8(mWindow.mClipName .. ".TabMenu.RightArrow", 14) / 2
			local v61 = v56 + v60 + 2

			if v57 + v60 < v61 then
				v61 = v57 + v60
			end

			mMovie:__wf_atom_4c1c1986(mWindow.mClipName, "TabMenu.RightArrow", 0, v61)
			mWindow:SetMinMaxBtnPos()
		end

		self.mTabMenu._TabMenu_Redraw = self.mTabMenu.Redraw

		function self.mTabMenu:Redraw(p, p2, p3)
			self:_TabMenu_Redraw(p, p2, p3)
			self:SetRightBumperPos()
		end

		function self.mTabMenu.CalculateX(object, p)
			local mInitialX = object.mInitialX

			if p.Id == object.mElements[1].Id then
				mInitialX = 8
				return mInitialX
			end

			local elementInIndex = object:GetElementInIndex(object:GetElementIndexById(p.Id) - 1)

			if __wf_atom_7e8ad928(elementInIndex) then
				return mInitialX
			end

			local mClipName = elementInIndex.mClipName

			if not __wf_atom_7e8ad928(mClipName) then
				mMovie:__wf_atom_253d7085(mClipName)
			end

			local v55 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName .. ".Label", 40) + 16
			return mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0) + v55 + 1 + 16
		end

		function self.mTabMenu.mElementDrawCallback(mTabElement)
			__wf_atom_86cbd68d(mMovie, mTabElement.mClipName .. ".setMask", "Window.TabMenu.TabMask")

			if not __wf_atom_7e8ad928(self.mPanelList[mTabElement.ChannelName]) then
				self.mPanelList[mTabElement.ChannelName].mTabElement = mTabElement
			end

			mMovie:__wf_atom_7f57ab2f(mTabElement.mClipName, "Icon", 13, mTabElement.Icon ~= nil)
			mMovie:__wf_atom_7f57ab2f(mTabElement.mClipName, "Label", 13, mTabElement.Icon == nil)

			if mTabElement.Icon == nil then
				mMovie:__wf_atom_7d7314f1(mTabElement.mClipName .. ".Label.text", mTabElement.Name)
			else
				mMovie:__wf_atom_c90af43a(mTabElement.mClipName .. ".Icon", mTabElement.Icon)
			end

			mMovie:OverrideMaterial(mTabElement.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			mWindow.mTabMenu:SetTabColour(mTabElement, false)
			mMovie:__wf_atom_1ca72041(
				mTabElement.mClipName .. ".Bg",
				"RectEdgeColor",
				_G.UIColorObject_White.r,
				_G.UIColorObject_White.g,
				_G.UIColorObject_White.b,
				0.05
			)
			local ternary = module.Ternary(
				mTabElement.Icon == nil,
				mMovie:__wf_atom_5e6e15c8(mTabElement.mClipName .. ".Label", 40) + 14,
				35
			)
			mMovie:__wf_atom_4c1c1986(mTabElement.mClipName, "Btn", 14, ternary)
			mMovie:__wf_atom_4c1c1986(mTabElement.mClipName, "Bg", 14, ternary)
			mMovie:__wf_atom_4c1c1986(mTabElement.mClipName, "Dot", 11, _G.UIColor_Red)
			mMovie:__wf_atom_7f57ab2f(mTabElement.mClipName, "Dot", 13, mTabElement.hasPersonalNotificion == true)
			mMovie:__wf_atom_4c1c1986(mTabElement.mClipName, "Dot", 0, ternary - 8)
			local v55

			if self.mTabMenu.mSelectedElement == nil then
				v55 = false
			else
				v55 = self.mTabMenu.mSelectedElement.Id == mTabElement.Id
			end

			mMovie:__wf_atom_7f57ab2f(mTabElement.mClipName, "BookendLeft", 13, v55)
			mMovie:__wf_atom_7f57ab2f(mTabElement.mClipName, "BookendRight", 13, v55)
			mMovie:__wf_atom_4c1c1986(mTabElement.mClipName, "BookendRight", 0, ternary + 8)
			self.mTabMenu:DrawDecoLine(mTabElement)
		end

		function self.mTabMenu:IsMouseInTabMask()
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu", 0)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.TabMask", 0)
			local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.TabMask", 14)

			if Engine.__wf_atom_2a979d69() then
				__wf_atom_5e6e15c8_4 *= miOSChatScale
			end

			return not (__wf_atom_5e6e15c8 < mWindow.mWindow.x + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 or mWindow.mWindow.x + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 + __wf_atom_5e6e15c8_4 < __wf_atom_5e6e15c8)
		end

		function self.mTabMenu.mOnFocusedCallback(p)
			mWindow.mTabMenu:SetTabColour(p, false)

			if
				not __wf_atom_7e8ad928(p.Icon)
				and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
				and not Engine.__wf_atom_2a979d69()
			then
				_T.gToolTip = p.Name
			end
		end

		function self.mTabMenu.mOnUnfocusedCallback(p)
			mWindow.mTabMenu:SetTabColour(p, true)
			_T.gToolTip = nil
		end

		self.mTabMenu._TabMenu_OnSelected = self.mTabMenu.OnSelected

		function self.mTabMenu.OnSelected(object, p)
			local v55 = mMovie:__wf_atom_cfc41e35(p.mClipName, "Label", 40) + 16
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.TabMask", 14)
			self.mTabMenu:StopFlashing(p)

			if __wf_atom_5e6e15c8 < 0 then
				local v56 = -__wf_atom_5e6e15c8
				self.mTabMenu.mInitialX = self.mTabMenu.mInitialX + v56
			elseif __wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8 + v55 then
				local v56 = __wf_atom_5e6e15c8 + v55 - __wf_atom_5e6e15c8_2
				self.mTabMenu.mInitialX = self.mTabMenu.mInitialX - v56
			end

			if object.mSelectedElement ~= nil then
				local _id = object.mSelectedElement.Id
			end

			object:_TabMenu_OnSelected(p)
			mWindow.mTabMenu:Redraw(nil, true)
		end

		function self.mTabMenu.mOnSelectedCallback(p)
			mWindow.mTabMenu:SetTabColour(p, false)
			self.mTabMenu:DrawDecoLine(p)
			local v55 = mWindow.mPanelList[p.ChannelName]

			if not v55.mIsActive then
				mWindow:SetActive(v55)
			end

			if not __wf_atom_7e8ad928(self.mSimpleTabList) then
				self.mSimpleTabList.mElements[1].mTabId = p.Id

				if self.mVisualMode == self.VISUAL_MODE_GAMEPLAY_SIMPLE then
					self.mSimpleTabList.mElementDrawCallback(self.mSimpleTabList.mElements[1])
				end
			end

			if not __wf_atom_7e8ad928(self.mInputPanel) then
				self.mInputPanel.mMaxMsgLength = module.Ternary(
					self.mMode == self.CHANNEL_RECRUITING or self.mMode == self.CHANNEL_TRADE,
					self.mInputPanel.MAX_MSG_LENGTH_RECRUIT_TRADE,
					self.mInputPanel.MAX_MSG_LENGTH_NORMAL
				)
				self.mInputPanel:UpdateDefaultText()
			end
		end

		self:InitializeTabArrows()
	end

	function v54:SetTabMenuPanelPos(p)
		if p then
			if Engine.IsPlayingWithController() then
				self.mMenuPanelXPos = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabMenu.LeftBumper", 0) + mMovie:__wf_atom_5e6e15c8(
					self.mClipName .. ".TabMenu.LeftBumper.Tf",
					40
				) / 2 + 8
			else
				self.mMenuPanelXPos = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabMenu.LeftArrow", 0) + mMovie:__wf_atom_5e6e15c8(
					self.mClipName .. ".TabMenu.LeftArrow",
					14
				) / 2
			end
		end

		local mMenuPanelXPos = self.mMenuPanelXPos
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.TabMask", 0, mMenuPanelXPos - 8)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.MenuPanel", 0, mMenuPanelXPos)
	end

	function v54:InitializeTabArrows(p)
		self.mTabMenu.mInitialX = 0
		self:SetArrowVisibilities(not p)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftArrow", 12, 50)
		mMovie:SetCallbacks(
			self.mClipName .. ".TabMenu.LeftArrow.Btn",
			"LeftArrowFocused",
			"LeftArrowUnfocused",
			"LeftArrowClicked",
			nil
		)
		mMovie:SetCallbacks(
			self.mClipName .. ".TabMenu.RightArrow.Btn",
			"RightArrowFocused",
			"RightArrowUnfocused",
			"RightArrowClicked",
			nil
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.RightArrow", 12, 50)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.ExpandCallout", 0, 10)
		mMovie:__wf_atom_7d7314f1(self.mClipName .. ".TabMenu.LeftBumper.Tf.text", "<MENU_LTRIGGER2>")
		mMovie:__wf_atom_7d7314f1(self.mClipName .. ".TabMenu.RightBumper.Tf.text", "<MENU_RTRIGGER2>")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftBumper", 0, 24)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftBumper", 1, 15)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.RightBumper", 1, 15)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftArrow", 0, 15)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftArrow", 1, 20)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.RightArrow", 1, 20)
		mMovie:__wf_atom_c90af43a(
			self.mClipName .. ".TabMenu.RightArrow.Icon",
			Resource("/SF/Interface/Graphics/Crafting/SideArrow.png")
		)
		mMovie:__wf_atom_c90af43a(
			self.mClipName .. ".TabMenu.LeftArrow.Icon",
			Resource("/SF/Interface/Graphics/Crafting/SideArrow.png")
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.LeftArrow.Icon", 5, -50)
		self:SetTabMenuPanelPos(true)
	end

	function v54:SetActive(object)
		if object == nil or object.mChannelName == self.mActivePanelName then
			return
		end

		local mChannelType

		if not (self.mActivePanelName == "" or __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName])) then
			mChannelType = self.mPanelList[self.mActivePanelName].mChannelType
			self.mPrevPanelName = self.mActivePanelName
			self.mPanelList[self.mActivePanelName]:OnDeactivated()

			if
				mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
				or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
			then
				local v55 = fn11()

				if __wf_atom_21342f4a ~= nil and v55 ~= nil then
					__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_CHAT_VIEW_TIME"), v55)
				end
			end
		end

		if object ~= nil then
			v22 = {}
			object:RefreshText()
			self.mActivePanelName = object.mChannelName
			self.mPanelList[object.mChannelName]:OnActivated(mChannelType)

			if
				mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
				or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
			then
				local v55 = fn11()

				if __wf_atom_21342f4a ~= nil and v55 ~= nil then
					__wf_atom_21342f4a:StartTimer(Symbol("IN_CHAT_VIEW_TIME"), v55)
				end
			end

			local mChannelType2 = mWindow:GetActivePanel().mChannelType
			local v55 = mChannelType2 == v52.CHANNEL_RECRUITING
				or mChannelType2 == v52.CHANNEL_QA
				or mChannelType2 == v52.CHANNEL_GLOBAL

			if not __wf_atom_7e8ad928(mProfileSettings) and v55 then
				mProfileSettings:__wf_atom_36df4ff8(mChannelType2)
			end
		end
	end

	function v54:Shutdown()
		if __wf_atom_7e8ad928(gMatchingService) then
			return
		end

		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if __wf_atom_7e8ad928(__wf_atom_7190444e) then
			return
		end

		for _, v55 in pairs(self.mPanelList) do
			if
				__wf_atom_7e8ad928(v55)
				or not (v55.mChannelType == self.CHANNEL_GLOBAL or v55.mChannelType == self.CHANNEL_RECRUITING or v55.mChannelType == self.CHANNEL_TRADE or v55.mChannelType == self.CHANNEL_QA)
			then
				continue
			end

			__wf_atom_7190444e:__wf_atom_d23db924("#" .. v55.mChannelName)
		end
	end

	function v54:SystemMessage(p)
		self:ResetFadeOutTimer()
		local flag2 = false

		for _, v55 in pairs(self.mPanelList) do
			if __wf_atom_7e8ad928(v55) then
				continue
			end

			v55:SystemMessage(p)
			flag2 = true
		end

		if flag2 then
			return
		end

		local v55 = self.mClipName .. ".TabbedChatPanel"
		local v56 = string.format("<p><font color=\"#%X\">", _G.UIColor_White) .. p .. "</font></p>"
		mMovie:__wf_atom_50d60589(v55 .. ".ChatArea", 36, v56)
	end

	function v54:ChannelSystemMessage(p, p2)
		self:ResetFadeOutTimer()

		for _, v55 in pairs(self.mPanelList) do
			if __wf_atom_7e8ad928(v55) or v55.mChannelType ~= p2 then
				continue
			end

			v55:SystemMessage(p)
		end
	end

	function v54:NotificationMessage(p)
		self:ResetFadeOutTimer()

		for _, v55 in pairs(self.mPanelList) do
			if not __wf_atom_7e8ad928(v55) then
				v55:NotificationMessage(p)
			end
		end
	end

	function v54:ChannelNotificationMessage(p, p2)
		self:ResetFadeOutTimer()

		for _, v55 in pairs(self.mPanelList) do
			if __wf_atom_7e8ad928(v55) or v55.mChannelType ~= p2 then
				continue
			end

			v55:NotificationMessage(p)
		end
	end

	function v54:SwitchModes(mMode)
		self.mMode = mMode

		if mMode ~= nil then
			local mPanelShortcut = self.mPanelShortcuts[mMode]

			if mPanelShortcut == nil then
				return
			end

			local v55 = string.find(mPanelShortcut, "#")

			if v55 ~= nil then
				mPanelShortcut = string.sub(mPanelShortcut, v55 + 1, -1)
			end

			if self.mPanelList[mPanelShortcut] == nil then
				return
			else
				self:SetActive(self.mPanelList[mPanelShortcut])
			end
		end
	end

	function v54:ToggleIgnoreUser(name, p)
		if (not p and 0 or module.GetInvalidNameCharacters(name, v16)) ~= 0 then
			self:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false))
			return
		end

		if not __wf_atom_7e8ad928(mGameData) then
			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if p and not __wf_atom_7e8ad928(__wf_atom_7190444e) then
				if mCrossPlatformEnabled then
					user2 = name
					__wf_atom_7190444e:Who(name, "IgnorePlayerWhoResult")
				elseif Engine.__wf_atom_746f9d1b(name) == __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(true) then
					self:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CannotIgnoreSelf", false))
					return
				else
					module3.ToggleIgnoreUser(name, true, "OnIgnoreUser")
				end
			else
				fn8({ Name = name })
			end
		end

		for i = 1, self.mUserPanel.mListControl:GetHowManyElements() do
			if not (self.mUserPanel.mListControl.mElements[i] ~= nil and self.mUserPanel.mListControl.mElements[i].User == name) then
				continue
			end

			self.mUserPanel.mListControl.mElementDrawCallback(self.mUserPanel.mListControl.mElements[i])
			break
		end
	end

	function v54:SetInitWindowPosition(_)
		local v55 = mViewportWidth * 0.025
		local v56 = mViewportHeight * -0.75

		if not (Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69() or __wf_atom_7e8ad928(mProfileSettings)) then
			local v57, v58

			if mProfileSettings:__wf_atom_32d10f7e(true) then
				v57 = mProfileSettings:__wf_atom_990eb10e(true, true)
				v58 = mProfileSettings:__wf_atom_990eb10e(true, false)
			end

			if v57 ~= nil then
				if v58 > 0.5 and v57 < 0.5 then
					v57 = 0
					v58 = -0.75
				end

				v55 = v57 * mViewportWidth
				v56 = v58 * mViewportHeight
			end
		end

		if v55 < 0 then
			v55 = -v55
		end

		if mViewportWidth / 2 < v55 then
			v55 -= self.mWindow.width
		end

		if v56 < 0 then
			v56 = -v56
		end

		if mViewportHeight / 2 < v56 then
			v56 = v56 - self.mWindow.height - 27
		end

		self:SetPosition(module.Round(v55), module.Round(v56), true, false)
	end

	function v54:SetInitWindowSize()
		local v55, v56

		if Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69() or __wf_atom_7e8ad928(mProfileSettings) then
			v55 = 0
			v56 = 0
		else
			local __wf_atom_674a408c = mProfileSettings:__wf_atom_674a408c(true, true)
			local __wf_atom_674a408c2 = mProfileSettings:__wf_atom_674a408c(true, false)
			v55 = __wf_atom_674a408c * mViewportWidth
			v56 = __wf_atom_674a408c2 * mViewportHeight
		end

		self:SetSize(module.Round(v55), module.Round(v56))
	end

	function v54:UpdateFilterPositions()
		local ternary = module.Ternary(Engine.IsPlayingWithController(), self.mFilterBtnOffset, 0)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.FilterBtn", 0, self.mOrigFilterPos.Btn + ternary)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.FilterList", 0, self.mOrigFilterPos.List + ternary)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabbedChatPanel.FilterListMask",
			0,
			self.mOrigFilterPos.Mask + ternary
		)
	end

	function v54:InitializeChatArea()
		local v55 = self.mClipName .. ".TabbedChatPanel"
		mMovie:SetCallbacks(v55 .. ".FilterBtn", "FilterBtnFocused", "FilterBtnUnfocused", nil, "FilterBtnPressed")
		mMovie:__wf_atom_c90af43a(v55 .. ".FilterBtn", chatFilterMgrIcon)
		mMovie:__wf_atom_7d7314f1(v55 .. ".FilterCallout.Tf.text", "<MENU_GENERIC2>")
		mMovie:__wf_atom_7f57ab2f(v55, "FilterCallout", 13, Engine.IsPlayingWithController())
		self:UpdateFilterPositions()
		self.mFilterList = module14.CreateList(mMovie, v55 .. ".FilterList.Element")
		self.mFilterList:SetCallbacks("FilterSelected", "FilterFocused", "FilterUnfocused")
		self.mFilterList.mForcedVerticalSeparation = 0
		self.mFilterList.mForcedHorizontalSeparation = 5

		function self.mFilterList.mOnFocusedCallback(p)
			mMovie:__wf_atom_1ca72041(
				p.mClipName .. ".Bg",
				"RectEdgeColor",
				_G.UIColorObject_Yellow.r,
				_G.UIColorObject_Yellow.g,
				_G.UIColorObject_Yellow.b,
				0.9
			)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "CrossIcon", 11, _G.UIColor_Yellow)
		end

		function self.mFilterList.mOnUnfocusedCallback(p)
			mMovie:__wf_atom_1ca72041(
				p.mClipName .. ".Bg",
				"RectEdgeColor",
				_G.UIColorObject_White.r,
				_G.UIColorObject_White.g,
				_G.UIColorObject_White.b,
				0.25
			)
			mMovie:__wf_atom_4c1c1986(p.mClipName, "CrossIcon", 11, _G.UIColor_White)
		end

		function self.mFilterList.mOnSelectedCallback(data)
			local activePanel = self:GetActivePanel()

			if not (__wf_atom_7e8ad928(activePanel) or __wf_atom_7e8ad928(mProfileSettings)) then
				mProfileSettings:__wf_atom_1329cee2(
					string.sub(activePanel.mChannelName, 1, 1),
					Engine.ChatFilter(data.Filter, data.Include)
				)
				self.mFilterList:RemoveElement(data.mIndex)
			end
		end

		function self.mFilterList.AdjustBtnWidth(p)
			if p.mClipName == nil then
				return
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Window.TabbedChatPanel.FilterListMask", 14)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(p.mClipName, 0)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(p.mClipName .. ".Bg", 14)
			local v56 = __wf_atom_5e6e15c8_2 < __wf_atom_5e6e15c8
			mMovie:__wf_atom_7f57ab2f(p.mClipName, "Btn", 13, v56)

			if v56 then
				local v57 = math.min(__wf_atom_5e6e15c8_3, __wf_atom_5e6e15c8 - __wf_atom_5e6e15c8_2)
				mMovie:__wf_atom_4c1c1986(p.mClipName, "Btn", 14, v57)
			end
		end

		function self.mFilterList.mElementDrawCallback(data)
			local v56 = "<p>"

			if not data.Include then
				v56 ..= "<font color=\"#C80406\">" .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/FilterMgr_ExcludeTag",
					false
				) .. " </font>"
			end

			local v57 = v56 .. "<font color=\"#FFFFFF\">" .. data.Label .. "</font></p>"
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, v57)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Label", 40)
			mMovie:OverrideMaterial(data.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg",
				"RectEdgeColor",
				_G.UIColorObject_White.r,
				_G.UIColorObject_White.g,
				_G.UIColorObject_White.b,
				0.25
			)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Bg",
				"RectInnerColor",
				_G.UIColorObject_Black.r,
				_G.UIColorObject_Black.g,
				_G.UIColorObject_Black.b,
				0.95
			)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 14, __wf_atom_5e6e15c8 + 42)
			self.mFilterList.AdjustBtnWidth(data)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Separator", 12, 25)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Separator", 0, __wf_atom_5e6e15c8 + 15)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "CrossIcon", 11, _G.UIColor_White)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "CrossIcon", 0, __wf_atom_5e6e15c8 + 15)
		end

		function self.mFilterList.CalculateX(data, p)
			local mInitialX = data.mInitialX

			for i = 1, p.mIndex - 1 do
				mInitialX = mInitialX + mMovie:__wf_atom_5e6e15c8(data.mElements[i].mClipName .. ".Bg", 14) + data.mForcedHorizontalSeparation
			end

			return mInitialX
		end

		mMovie:__wf_atom_384aa4e8(v55 .. ".ChatArea", "ShowHyperlinkItem")
		mMovie:__wf_atom_c0d7a318(v55, "ChatArea", "ignoreIconOffset", true)
		mMovie:__wf_atom_4c1c1986(v55, "ChatArea", 44, _G.UIColor_Beige)
		mMovie:__wf_atom_4c1c1986(v55, "Fill", 11, UIColor_DarkerBrown)
		mMovie:__wf_atom_4c1c1986(v55, "Divider", 12, 50)
		mMovie:__wf_atom_4c1c1986(v55, "Fill", 12, 95)
		mMovie:__wf_atom_4c1c1986(v55, "EdgeLeft", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(v55, "EdgeLeft", 12, 25)
		mMovie:__wf_atom_4c1c1986(v55, "EdgeRight", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(v55, "EdgeRight", 12, 25)
		mMovie:__wf_atom_4c1c1986(v55, "DecoLine", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(v55, "DecoLine", 12, 25)
		mMovie:__wf_atom_4c1c1986(v55, "DecoCurve", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(v55, "DecoCurve", 12, 25)
		mMovie:__wf_atom_7f57ab2f(v55, "ScrollBar.Scrub", 13, false)
		mMovie:__wf_atom_7f57ab2f(v55, "ScrollBar", 13, false)
	end

	function v54:Initialize(_, _, _, _)
		self.mWindow.x = 0
		self.mWindow.y = 0
		self.mWindow.width = 0
		self.mWindow.height = 0
		self.mWindow.minWidth = 460
		self.mWindow.minHeight = 255
		self.mWindow.maxWidth = 0.8
		self.mWindow.maxHeight = 0.7
		self.mWindow.minimizeY = -40
		self.mWindow.minimizeX = 120
		self.mWindow.stageWidth = mMovie:__wf_atom_97cd8326()
		self.mWindow.stageHeight = mMovie:__wf_atom_54eeda24()
		self.mChatPanelWindow.x = 1
		self.mChatPanelWindow.y = 33
		self.mChatPanelWindow.width = 0
		self.mChatPanelWindow.ReverseWidth = true
		self.mChatPanelWindow.height = -32
		self.mChatPanelWindow.ReverseHeight = true
		self.mOrigFilterPos = {
			List = mMovie:__wf_atom_5e6e15c8("Window.TabbedChatPanel.FilterList", 0),
			Mask = mMovie:__wf_atom_5e6e15c8("Window.TabbedChatPanel.FilterListMask", 0),
			Btn = mMovie:__wf_atom_5e6e15c8("Window.TabbedChatPanel.FilterBtn", 0)
		}
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu", 0, 6)
		self.mWindowTitle.isDragging = false
		self.mWindowTitle.height = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabMenu.WindowTitle", 15)
		self.mWindowStatus.isDragging = false
		self.mWindowStatus.height = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".WindowStatus", 15)
		mMovie:__wf_atom_976dcedd(self.mClipName, "Id", "Window")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "MouseCatcherBtn", 0, 0)
		mMovie:SetCallbacks(
			self.mClipName .. ".TabMenu.WindowTitle.Fill",
			"WindowTitleRollOver",
			"WindowTitleRollOut",
			"WindowTitleRelease",
			"WindowTitlePress"
		)
		mMovie:SetReleaseOutsideCallback(self.mClipName .. ".TabMenu.WindowTitle.Fill", "WindowTitleRelease")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.Fill", 11, UIColor_DarkerBrown)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.Fill", 12, 75)
		mMovie:OverrideMaterial(self.mClipName .. ".TabMenu.WindowTitle.Fill", inputBarBackerMaterial)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeTop", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeTop", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeLeft", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeLeft", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeRight", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeRight", 12, 25)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeBottom", 11, UIColor_White)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeBottom", 12, 40)
		mMovie:SetCallbacks(
			self.mClipName .. ".WindowStatus.Resize",
			"BottomResizeRollOver",
			"BottomResizeRollOut",
			"BottomResizeRelease",
			"BottomResizePress"
		)
		mMovie:SetReleaseOutsideCallback(self.mClipName .. ".WindowStatus.Resize", "BottomResizeRelease")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "WindowStatus.Resize", 0, 0)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "WindowStatus.Resize", 12, 50)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabbedChatPanel.ScrollBar", 13, false)
		self:InitializeChatArea()
		self.mUserPanel = fn34(self, "UserPanel")
		self.mUserPanel:Initialize(self.mWindow.width, self.mWindow.height)
		self.mInputPanel = fn35(self, "SendMessageBar")
		self.mInputPanel:Initialize(self.mWindow.width, self.mWindow.height)
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			self.mUser = __wf_atom_18a5d83b:__wf_atom_6be84646()
			self.mUserSuffixed = Engine.__wf_atom_1b118af6(self.mUser)

			if Engine.__wf_atom_fe47f148(self.mUser) ~= "" then
				self.mPrivateChatPartners[string.lower(self.mUser)] = self.mUserSuffixed
			end

			self.mSearchUserName = "@" .. string.lower(__wf_atom_18a5d83b:__wf_atom_6be84646(true))
		end

		self.mCachedIsCounselor = 0
		self:_initializeTabs()
		self:CreateSimpleTabList()
		mMovie:SetCallbacks(
			self.mClipName .. ".TabMenu.Resize",
			"TopResizeRollOver",
			"TopResizeRollOut",
			"TopResizeRelease",
			"TopResizePressed"
		)
		mMovie:SetReleaseOutsideCallback(self.mClipName .. ".TabMenu.Resize", "TopResizeRelease")
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.Resize", 12, 50)
		mMovie:SetCallbacks(
			self.mClipName .. ".TabMenu.MinMaxBtn",
			"MinMaxBtnFocused",
			"MinMaxBtnUnfocused",
			"MinMaxBtnClicked",
			nil
		)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.MinMaxBtn", 13, not Engine.IsPlayingWithController())
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".TabMenu.MinMaxBtn.Icon", minimizeButtonIcon)

		if Engine.__wf_atom_2a979d69() then
			local color = module9.GetColor(9, true)
			module.ConvertColorNumberToProceduralRGB(color)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.MinMaxBtn.Icon", 13, false)
		else
			mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.MinMaxBtn.Icon", 12, 50)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.MinMaxBtn.Separator", 12, 25)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.MinMaxBtn.Separator", 11, UIColor_White)
		end

		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.ExpandCallout", 13, false)
		fn10()
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if not (__wf_atom_7e8ad928(__wf_atom_7190444e) or __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(mGameData)) then
			mGameData:__wf_atom_3e4527e4("ChatChannelJoin")
			mGameData:__wf_atom_7cb7a89f("ChatChannelLeft")
			mGameData:__wf_atom_ec4ac5a7("ChatChannelJoinUserList")
			mGameData:__wf_atom_06c7cb8d("ChatMessageReceived")
			mGameData:__wf_atom_5b9efe67("InvalidWhisperTarget")
			mGameData:__wf_atom_24fdcb7d("SystemMessage")
			mGameData:__wf_atom_09c7484d("ChatConnectionChanged")
			self.mIsConnected = __wf_atom_7190444e:__wf_atom_328bcb8f()

			if self.mIsConnected then
				local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()
				local v55 = __wf_atom_7e8ad928(__wf_atom_15811761) and "" or __wf_atom_15811761:__wf_atom_855a3505()
				local v56 = "#" .. self._getSquadChannelPrefix() .. v55

				if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
					local __wf_atom_34812bc6 = __wf_atom_7190444e:__wf_atom_34812bc6()

					if not __wf_atom_7e8ad928(__wf_atom_34812bc6) and #__wf_atom_34812bc6 > 0 then
						for i = 1, #__wf_atom_34812bc6 do
							if not (string.sub(__wf_atom_34812bc6[i], 2, 2) == self._getSquadChannelPrefix() and v56 ~= __wf_atom_34812bc6[i]) then
								continue
							end

							__wf_atom_7190444e:__wf_atom_d23db924(__wf_atom_34812bc6[i])
						end
					end
				end
			end

			local __wf_atom_cb06fe38 = mGameData:__wf_atom_cb06fe38()

			if not __wf_atom_7e8ad928(__wf_atom_cb06fe38) then
				for i = 1, #__wf_atom_cb06fe38 do
					local v55 = __wf_atom_cb06fe38[i]
					fn28(v55.mDisplayName, v55.mId, v55.mIsCrossSaveAccount)
				end
			end
		end

		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.WindowTitle.Arrows", 13, self.mIsConnected)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "TabMenu.WindowTitle.Spinner", 13, not self.mIsConnected)
		mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel", 12, 0)
		mMovie:__wf_atom_e57658c2("Window.Hint", 12, 0)
		self:SetInitWindowSize()
		self:SetInitWindowPosition()
		self:SetVisualMode(self.mVisualMode)

		if not __wf_atom_7e8ad928(mProfileSettings) then
			local __wf_atom_9670052d = mProfileSettings:__wf_atom_9670052d()
			local __wf_atom_67e2b9ef = mProfileSettings:__wf_atom_67e2b9ef()
			local __wf_atom_ce709956 = mProfileSettings:__wf_atom_ce709956()

			if __wf_atom_9670052d or __wf_atom_67e2b9ef then
				self.mUserPanel:ToggleListVis(__wf_atom_9670052d, true)
			else
				mMovie:__wf_atom_e57658c2(
					"Window.MouseCatcherBtn",
					14,
					mWindow.mWindow.width + module.Ternary(
						self.mUserPanel.mListControl.mIsVisible or self.mUserPanel.mEmoteGrid.mIsVisible,
						self.mUserPanel.mActiveRect.width,
						0
					)
				)
			end

			if not __wf_atom_67e2b9ef and __wf_atom_9670052d and __wf_atom_ce709956 then
				self.mUserPanel:ToggleLocator()
			end
		end

		if Engine.__wf_atom_2a979d69() then
			local v55 = self.mClipName .. ".SendMessageBar"
			local v56 = tonumber(__wf_atom_86cbd68d(mMovie, v55 .. ".EdgeTop.getDepth"))
			local v57 = tonumber(__wf_atom_86cbd68d(mMovie, v55 .. ".EdgeFill.getDepth"))

			if v56 < v57 then
				__wf_atom_86cbd68d(mMovie, v55 .. ".EdgeTop.swapDepths", v57)
				__wf_atom_86cbd68d(mMovie, v55 .. ".EdgeFill.swapDepths", v56)
			end

			self.mChatPanelWindow.height = self.mChatPanelWindow.height - 6
			mMovie:__wf_atom_e57658c2(v55 .. ".Bg", 15, mMovie:__wf_atom_5e6e15c8(v55 .. ".Bg", 15) + 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".BgBlurer", 15, mMovie:__wf_atom_5e6e15c8(v55 .. ".BgBlurer", 15) + 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".Bg", 1, mMovie:__wf_atom_5e6e15c8(v55 .. ".Bg", 1) - 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".BgBlurer", 1, mMovie:__wf_atom_5e6e15c8(v55 .. ".BgBlurer", 1) - 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeTop", 14, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTop", 14) + 2)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeTop", 15, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTop", 15) + 1)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeTop", 0, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTop", 0) - 4)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeTop", 1, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTop", 1) - 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeFill", 14, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeFill", 14) + 8)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeFill", 15, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeFill", 15) + 8)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeFill", 0, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeFill", 0) - 6)
			mMovie:__wf_atom_e57658c2(v55 .. ".EdgeFill", 1, mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeFill", 1) - 8)
			mMovie:__wf_atom_e57658c2(
				v55 .. ".EdgeTriangle",
				0,
				mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTriangle", 0) - 3
			)
			mMovie:__wf_atom_e57658c2(
				v55 .. ".EdgeTriangle",
				1,
				mMovie:__wf_atom_5e6e15c8(v55 .. ".EdgeTriangle", 1) - 3
			)
			mMovie:__wf_atom_e57658c2(v55 .. ".Prompt", 0, mMovie:__wf_atom_5e6e15c8(v55 .. ".Prompt", 0) + 2)
		end
	end

	function v54:OnMessageSent(p)
		v8.Msg = ""
		v8.CurrItemString = ""
		v8.OmegaLinks = {}
		v8.SongLinks = {}
		v8.ZawLinks = {}
		v8.AmpLinks = {}
		v8.MoaPetLinks = {}
		v8.KdriveLinks = {}
		v8.KitgunLinks = {}
		v8.AppearanceLinks = {}
		v8.ModConfigLinks = {}
		v8.ShawzinLinks = {}
		v8.GuildReplacement = false

		if self.mActivePanelName == "" then
			local _, v55, _ = fn37(p, true)

			if #v55 == 1 and v55[1] == "/unstuck" then
				fn38(__wf_atom_c4e218a2())
			end
		elseif not self.mPanelList[self.mActivePanelName]:OnMessageSent(p) then
			mMovie:__wf_atom_50d60589(self.mInputPanel.mClipPath .. ".MessageBox", 36, "")
		end

		self:ResetFadeOutTimer()
	end

	function v54:OnUserJoin(p, value)
		if string.find(value, "#") ~= nil then
			value = string.sub(value, 2, -1)
		end

		if string.sub(value, 1, 1) == self._getSquadChannelPrefix() and not fn32(p) then
			return
		end

		if not __wf_atom_7e8ad928(self.mPanelList[value]) then
			self.mPanelList[value]:OnUserJoin(p, value)
		end
	end

	function v54:OnUserLeave(p, value, p2)
		if string.find(value, "#") ~= nil then
			value = string.sub(value, 2, -1)
		end

		if not __wf_atom_7e8ad928(self.mPanelList[value]) then
			self.mPanelList[value]:OnUserLeave(p, value, p2)
		end
	end

	function v54:cycleActiveTab(p)
		if __wf_atom_7e8ad928(self.mTabMenu.mSelectedElement) or self.mTabMenu:GetHowManyElements() <= 1 then
			return
		end

		local howManyElements = self.mTabMenu.mSelectedElement.mIndex + p

		if self.mTabMenu:GetHowManyElements() < howManyElements then
			howManyElements = 1
		elseif howManyElements <= 0 then
			howManyElements = self.mTabMenu:GetHowManyElements()
		end

		local elementInIndex = self.mTabMenu:GetElementInIndex(howManyElements)

		if not __wf_atom_7e8ad928(elementInIndex) then
			self:SetActive(self.mPanelList[elementInIndex.ChannelName])
		end

		module.PlaySound(_G.UISound_ItemTipSection)
	end

	function v54:OnChannelStateChanged(p, value, p2, mChannelType, _, p3)
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if __wf_atom_7e8ad928(__wf_atom_7190444e) then
			return
		end

		if p == self.CHANNEL_ENTER and not __wf_atom_7e8ad928(gRegion) then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			if
				not __wf_atom_7e8ad928(__wf_atom_3c8e1a7a)
				and #__wf_atom_3c8e1a7a > 0
				and __wf_atom_3c8e1a7a[1]:__wf_atom_fabb6718()
			then
				print("Ghost player, not joining channel")
				return
			end
		end

		if p2 == nil then
			p2 = value
		end

		local v55 = nil
		local v56 = tonumber(p)

		if v56 == 1 then
			if mChannelType == self.CHANNEL_GLOBAL then
				self.mPendingGlobalChannelName = value
			elseif mChannelType == self.CHANNEL_RECRUITING then
				self.mPendingRecruitingChannelName = value
			elseif mChannelType == self.CHANNEL_TRADE then
				self.mPendingTradeChannelName = value
			elseif mChannelType == self.CHANNEL_QA then
				self.mPendingQAChannelName = value
			elseif mChannelType == self.CHANNEL_COUNCIL then
				self.mPendingCouncilChannelName = value
			elseif string.sub(value, 2, 2) ~= self._getPrivateChatChannelPrefix() then
				if self.mIsConnected then
					__wf_atom_7190444e:__wf_atom_0beacbb1(value)
				elseif module.FindInTable(self.mPendingChannels, value) == -1 then
					table.insert(self.mPendingChannels, value)
				end
			end

			v55 = fn54(self, value, mChannelType, p2, true)
			v55:Initialize(self.mWindow.width, self.mWindow.height)
			self.mPanelList[v55.mChannelName] = v55
			local v57 = __wf_atom_7e8ad928(mGameData) and {} or mGameData:__wf_atom_0a442189()

			for i = 1, #v57 do
				local channel = v57[i].channel
				local v58 = string.sub(channel, 1, 1) == "#"
				local entries = v57[i].entries

				for j = 1, #entries do
					__wf_atom_83c14687(0)
					local timeStamp = entries[j].timeStamp
					local content = entries[j].content
					local v59 = timeStamp == nil and "" or timeStamp

					if v58 or entries[j].source == "" then
						v55:OnChatMessageReceived(
							entries[j].source,
							channel,
							content,
							v59,
							true,
							true,
							entries[j].userType
						)
					else
						local v60 = StringSplit(",", channel)

						if
							v60 ~= nil
							and #v60 == 2
							and (self._getPrivateChatChannelPrefix() .. v60[1] == v55.mChannelName or self._getPrivateChatChannelPrefix() .. v60[2] == v55.mChannelName)
						then
							v55:_onLineAdded(
								entries[j].source .. ": " .. content,
								v55.MESSAGE_TYPE_FRIEND,
								v59,
								false,
								true,
								entries[j].source
							)
						end
					end
				end
			end

			if Engine.__wf_atom_fc67ba71() and fn16() then
				if Engine.__wf_atom_84bb79c2() then
					v55:_onLineAdded(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_ContentRestriction_XBone", false),
						v55.MESSAGE_TYPE_BROADCAST,
						"",
						true
					)
				elseif Engine.__wf_atom_b290ec01() then
					v55:_onLineAdded(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_ContentRestriction_Switch", false),
						v55.MESSAGE_TYPE_BROADCAST,
						"",
						true
					)
				else
					v55:_onLineAdded(
						mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_ContentRestriction", false),
						v55.MESSAGE_TYPE_BROADCAST,
						"",
						true
					)
				end
			end

			local mTabElement = self:AddTab(p2, v55.mChannelName)
			self.mPanelList[v55.mChannelName].mTabElement = mTabElement

			if mChannelType == mInitChannelInfo.Id and mInitChannelInfo.Set == true then
				self:SetActive(self.mPanelList[v55.mChannelName])
			else
				mWindow:SetSize(mWindow.mWindow.width, mWindow.mWindow.height)
			end
		else
			local v57

			if string.find(value, "#") == nil then
				v57 = value
			else
				v57 = string.sub(value, 2, -1)
			end

			if v57 == self.mActivePanelName then
				if __wf_atom_7e8ad928(self.mPanelList[self.mPrevPanelName]) then
					self:cycleActiveTab(module.INCREMENT)
				else
					self:SetActive(self.mPanelList[self.mPrevPanelName])
				end

				if v57 == self.mActivePanelName then
					self.mActivePanelName = ""
				end
			end

			if self.mPanelList[v57] ~= nil then
				self.mPanelShortcuts[self.mPanelList[v57].mChannelType] = nil
				self.mPanelList[v57] = nil
			end

			self:RemoveTab(value, p3)

			if string.find(value, "#") == nil then
				value = "#" .. value
			end

			local v58 = string.sub(value, 2, 2) == self._getHubChannelPrefix(self)

			if string.sub(value, 2, 2) ~= self._getPrivateChatChannelPrefix() and not v58 then
				__wf_atom_7190444e:__wf_atom_d23db924(value)
			end

			if v58 and self.mIsScenarioChannel then
				self.mIsScenarioChannel = false
				self.mCachedPersistentRelayHubActive = false
			end

			if mChannelType == self.CHANNEL_GLOBAL and self.mPendingGlobalChannelName ~= nil then
				self.mPendingGlobalChannelName = nil
			elseif mChannelType == self.CHANNEL_RECRUITING and self.mPendingRecruitingChannelName ~= nil then
				self.mPendingRecruitingChannelName = nil
			elseif mChannelType == self.CHANNEL_TRADE and self.mPendingTradeChannelName ~= nil then
				self.mPendingTradeChannelName = nil
			elseif mChannelType == self.CHANNEL_QA and self.mPendingQAChannelName ~= nil then
				self.mPendingQAChannelName = nil
			elseif mChannelType == self.CHANNEL_COUNCIL and self.mPendingCouncilChannelName ~= nil then
				self.mPendingCouncilChannelName = nil
			end

			local v59 = module.FindInTable(self.mPendingChannels, value)

			if v59 == -1 then
				table.remove(self.mPendingChannels, -1)
			end

			if self.mActivePanelName == "" then
				if not __wf_atom_7e8ad928(self.mUserPanel) then
					self.mUserPanel:Clear()
					mMovie:__wf_atom_50d60589("Window.SendMessageBar.Prompt", 36, "")
				end

				mMovie:__wf_atom_50d60589("Window.TabbedChatPanel.ChatArea", 36, "")
			end
		end

		if
			v56 == self.CHANNEL_ENTER
			and not __wf_atom_7e8ad928(gRegion)
			and not __wf_atom_7e8ad928(v55)
			and self.mWelcome == nil
		then
			v55:_onLineAdded(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_HelpPrompt", false),
				v55.MESSAGE_TYPE_SYSTEM,
				""
			)
			self.mCachedLines = {}
			self.mWelcome = { done = 1 }
		end

		return v55
	end

	function v54:OnChatMessageReceived(p, p2)
		if p == "" then
			for _, v55 in pairs(self.mPanelList) do
				if not __wf_atom_7e8ad928(v55) then
					v55:OnChatMessageReceived("", "", p2, "")
				end
			end

			local v55 = __wf_atom_d99ae0ec(p2)
			local time = string.match(v55, "hotfix.*(%d+)%s*minute")

			if time == nil then
				time = string.match(v55, "update.*(%d+)%s*minute")
			end

			local v57 = string.match(v55, "deploy.*%s.*remain") ~= nil or string.match(v55, "deploy.*%s.*stay") ~= nil
			local v58 = string.match(v55, "deploy.*%s.*restart") ~= nil

			if _T.ShowNotification ~= nil and (v57 or v58 or time ~= nil) then
				local v59 = string.match(v55, "updat") ~= nil
				local v61 = 10
				local v62 = false
				local v63

				if v57 then
					if v59 then
						v63 = mMovie:__wf_atom_8e9ac384("/SF/Language/Notifications/UpdateDeploying", false)
					else
						v63 = mMovie:__wf_atom_8e9ac384("/SF/Language/Notifications/HotfixDeploying", false)
					end

					v61 = 600
				elseif v58 then
					v63 = mMovie:__wf_atom_8e9ac384("/SF/Language/Notifications/PatchDeployed", false)
					v62 = true
				elseif v59 then
					v63 = mMovie:__wf_atom_8e9ac384("/SF/Language/Notifications/UpdateTimeLeft", false, {
						TIME = time
					})
				else
					v63 = mMovie:__wf_atom_8e9ac384("/SF/Language/Notifications/HotfixTimeLeft", false, {
						TIME = time
					})
				end

				_T.ShowNotification(v63, v59 and "UpdateInbound" or "HotfixInbound", true, v61, _G.UIColor_Yellow, v62)
			end
		else
			local v55 = StringSplit(",", p)
			local name = v55[1]
			local v57 = v55[2]
			local v58 = v55[3]
			local ternary = module.Ternary(v55[4] == nil, 0, (tonumber(v55[4])))
			local accountId = v55[5]
			local isCrossSave = v55[6] == "X"
			local v61 = string.sub(v57, 1, 1) == "#"
			local v62 = v58 == nil and "" or v58

			if name == "" then
				local v63 = StringSplit(",", p2, 3)

				if #v63 > 1 and v61 and v63[1] == "clear" then
					local v64 = v63[2]

					if string.find(v57, "#") ~= nil then
						v57 = v57:sub(2, -1)
					end

					if not __wf_atom_7e8ad928(self.mPanelList[v57]) then
						self.mPanelList[v57]:_removeUserMsgs(v64)
					end

					if not __wf_atom_7e8ad928(mGameData) then
						mGameData:__wf_atom_0500a65b(v64, "#" .. v57)
					end

					if #v63 == 3 and v64 == self.mUser then
						self.mPanelList[v57]:NotificationMessage(v63[3])
					end

					return
				end
			elseif not v61 then
				if v57 == self.mUser then
					v57 = name
				end

				local v63 = fn28(v57, nil, nil, true)
				local __wf_atom_940f8971 = Engine.__wf_atom_940f8971(name)
				local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
				local mCrossPlatformEnabled = mCrossPlatformEnabled or __wf_atom_940f8971 == __wf_atom_63bb2bc6

				if
					name == self.mUser
					or not _G.mDoNotDisturb and mCrossPlatformEnabled
					or not __wf_atom_7e8ad928(v63)
				then
					if __wf_atom_7e8ad928(v63) then
						if accountId == nil then
							local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

							if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
								__wf_atom_7190444e:__wf_atom_496d6987(name, "PrivateConvoPlayerIDResultIncoming")
							end
						else
							fn7({ AccountId = accountId, Name = name, IsCrossSave = isCrossSave }, true)
							v63 = fn28(v57, nil, nil, true)
						end
					elseif not __wf_atom_7e8ad928(v63) then
						v63:_onLineAdded(name .. ": " .. p2, v63.MESSAGE_TYPE_FRIEND, v62, false, false, name)
					end
				end

				if name ~= self.User then
					local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

					if not __wf_atom_7e8ad928(__wf_atom_7190444e) and __wf_atom_7e8ad928(v63) then
						if _G.mDoNotDisturb then
							__wf_atom_7190444e:__wf_atom_e3bb0902(
								mMovie:__wf_atom_8e9ac384("/Lotus/Language/SystemMessages/Chat_AutoReply", false),
								name,
								false
							)
						elseif not mCrossPlatformEnabled then
							__wf_atom_7190444e:__wf_atom_e3bb0902(
								mMovie:__wf_atom_8e9ac384("/Multiplayer/ChatPlayerCrossPlayOff", false, {
									USER = self.mUser
								}),
								name,
								false
							)
						end
					end
				end

				if mInlinePrivateMessages and name ~= self.mUser and not _G.mDoNotDisturb and mCrossPlatformEnabled then
					local activePanel = self:GetActivePanel()

					if
						not __wf_atom_7e8ad928(activePanel)
						and not __wf_atom_7e8ad928(v63)
						and activePanel.mChannelName ~= v63.mChannelName
					then
						activePanel:_onLineAdded(
							name .. ": " .. p2,
							activePanel.MESSAGE_TYPE_INGAME_WHISPER,
							v62,
							false,
							false,
							name
						)
					end
				end

				return
			end

			for _, v63 in pairs(self.mPanelList) do
				if not __wf_atom_7e8ad928(v63) then
					v63:OnChatMessageReceived(name, v57, p2, v62, false, false, ternary)
				end
			end
		end
	end

	function v54:OnInvalidWhisperTarget(friend)
		if friend == v5.From then
			fn12()
		end

		if string.find(friend, "#") == nil and _T.WareframeMiniGameChatCallback == nil then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_FriendOffline", false, {
				FRIEND = friend
			})

			if not __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
				self.mPanelList[self.mActivePanelName]:SystemMessage(__wf_atom_8e9ac384)
			end
		end
	end

	function v54:OnChatChannelJoinUserList(value, p)
		local v55 = StringSplit(",", p)

		if string.find(value, "#") ~= nil then
			value = value:sub(2, -1)
		end

		local v56 = string.sub(value, 1, 1) == self._getSquadChannelPrefix()

		if not __wf_atom_7e8ad928(self.mPanelList[value]) then
			if not self.mPanelList[value].mInitialPopulationDone then
				self.mPanelList[value]:PopulateUserList(true)
				return
			end

			local count = #v55

			for i = 1, count do
				if not v56 or fn32(v55[i]) then
					self.mPanelList[value]:OnUserJoin(v55[i], value, i < count)
				end
			end
		end
	end

	function v54._getRegionChannelPrefix()
		return "G"
	end

	function v54:_getPlatformSuffix(p, p2)
		local v55 = ""
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local v56 = __wf_atom_18a5d83b:__wf_atom_a3e6cd18() and not p
		local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()

		if p2 == self:_getTradeChannelPrefix() then
			if __wf_atom_18a5d83b:__wf_atom_68c57190() then
				if (__wf_atom_18a5d83b:__wf_atom_e75653c3() ~= __wf_atom_18a5d83b:__wf_atom_8becc743() and 0 or __wf_atom_63bb2bc6) == 0 then
					v55 = "_XS"
				else
					v56 = true
				end
			else
				v56 = true
			end
		end

		if not v56 then
			return v55
		end

		if __wf_atom_63bb2bc6 == 0 then
			return v55 .. "_WIN"
		elseif __wf_atom_63bb2bc6 == 2 then
			return v55 .. "_PS"
		elseif __wf_atom_63bb2bc6 == 1 then
			return v55 .. "_XB"
		elseif __wf_atom_63bb2bc6 == 3 then
			return v55 .. "_SWI"
		elseif __wf_atom_63bb2bc6 == 4 then
			return v55 .. "_IOS"
		end

		return v55
	end

	function v54:_getGlobalChannelName(p)
		local v55 = "#" .. p .. string.upper(__wf_atom_b953295d():c_str())

		if not __wf_atom_7e8ad928(mProfileSettings) then
			v55 ..= fn15(mProfileSettings:__wf_atom_35ea3fce():__wf_atom_74123a24())
		end

		return v55 .. self:_getPlatformSuffix(mCrossPlatformEnabled, p)
	end

	function v54:_getRegionChannel()
		return self:_getGlobalChannelName(self:_getRegionChannelPrefix())
	end

	function v54._getSquadChannelPrefix(_)
		return "S"
	end

	function v54:_joinSquadChannel(p)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_SquadTitle", false)
		local v55 = self:OnChannelStateChanged(self.CHANNEL_ENTER, p, __wf_atom_8e9ac384, self.CHANNEL_SESSION)
		self.mPanelShortcuts[self.CHANNEL_SESSION] = p

		if not (__wf_atom_7e8ad928(v55) or gMatchingService:__wf_atom_a676a953()) then
			self:SetActive(v55)
		end
	end

	function v54:_updateSquad()
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()
		local mCachedSessionID

		if not __wf_atom_7e8ad928(__wf_atom_15811761) then
			mCachedSessionID = __wf_atom_15811761:__wf_atom_855a3505()
		end

		if mCachedSessionID ~= self.mCachedSessionID then
			print("CHATREDUX - SessionId does not match cached id;")

			if self.mCachedSessionID == nil then
				print("CHATREDUX - No cached session id.")
			else
				print("CHATREDUX - CachedSessionID: " .. self.mCachedSessionID)
			end

			if mCachedSessionID == nil then
				print("CHATREDUX - No session id.")
			else
				print("CHATREDUX - SessionID: " .. mCachedSessionID)
			end

			local function fn57(p)
				return "#" .. self:_getSquadChannelPrefix() .. tostring(p)
			end

			if self.mCachedSessionID ~= nil and self.mCachedSessionID ~= "" then
				print("CHATREDUX - CachedSessionID2: " .. self.mCachedSessionID)
				self.mCachedOldSessionName = fn57(self.mCachedSessionID)
				self:OnChannelStateChanged(self.CHANNEL_EXIT, self.mCachedOldSessionName, "")
				self.mPanelShortcuts[self.CHANNEL_SESSION] = nil
			end

			if mCachedSessionID ~= nil and mCachedSessionID ~= "" then
				print("CHATREDUX - SessionID2: " .. mCachedSessionID .. " - " .. tostring(mCachedSessionID))
				self.mCachedCurSessionName = fn57(mCachedSessionID)
				self:_joinSquadChannel(self.mCachedCurSessionName)
			end

			self.mCachedSessionID = mCachedSessionID
		end

		local gPromotedToHost = gPromotedToHost
		local mCachedHostHistoryCount

		if gPromotedToHost or __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
			mCachedHostHistoryCount = 1
		else
			mCachedHostHistoryCount = gGameRules:__wf_atom_53de117e()

			if mCachedHostHistoryCount == 1 and self.mCachedHostHistoryCount > 1 then
				self.mCachedHostHistoryCount = 1
			elseif self.mCachedHostHistoryCount < mCachedHostHistoryCount then
				gPromotedToHost = true
			else
				gPromotedToHost = false
			end
		end

		if gPromotedToHost then
			local mCachedCurSessionName = self.mCachedCurSessionName
			local mCachedOldSessionName = self.mCachedOldSessionName

			if mCachedCurSessionName ~= "" and mCachedOldSessionName ~= "" then
				self.mCachedHostHistoryCount = mCachedHostHistoryCount
				self.mCachedCurSessionName = ""
				self.mCachedOldSessionName = ""
				self:OnChannelStateChanged(self.CHANNEL_EXIT, mCachedCurSessionName, "")
				mGameData:__wf_atom_777e612a(mCachedCurSessionName, mCachedOldSessionName)
				self:_joinSquadChannel(mCachedCurSessionName)
			end
		end
	end

	function v54:_updateHub()
		local __wf_atom_a676a953 = gMatchingService:__wf_atom_a676a953()

		if __wf_atom_a676a953 and self.mCachedPersistentRelayHubActive and _T.HubChannel == nil then
			_T.HubChannel = self.mCachedHubID
		end

		local v55

		if _T.HubChannel == nil then
			v55 = false
		else
			v55 = self.mCachedHubID == nil
		end

		if
			self.mCachedUIMode == module3.UI_MODE_IN_SPACE_HUB
			and mUIMode ~= module3.UI_MODE_IN_SPACE_HUB
			and not __wf_atom_a676a953
			or self.mCachedPersistentRelayHubActive ~= __wf_atom_a676a953
		then
			_T.HubChannel = nil
			v55 = true
		elseif self.mCachedUIMode ~= mUIMode then
			self.mFocusHubOnActive = self.mCachedUIMode ~= module3.UI_MODE_IN_GAME
		end

		self.mCachedUIMode = mUIMode
		self.mCachedPersistentRelayHubActive = __wf_atom_a676a953

		if
			self.mCachedPersistentRelayHubActive
			and self.mCachedUIMode == module3.UI_MODE_IN_GAME
			and _T.HubChannel == nil
		then
			local __wf_atom_58c4b875 = gMatchingService:__wf_atom_58c4b875()

			if __wf_atom_58c4b875 ~= "" then
				_T.HubChannel = __wf_atom_58c4b875
				v55 = true
			end
		end

		if
			not v55
			and (mUIMode ~= module3.UI_MODE_IN_SPACE_HUB and mUIMode ~= module3.UI_MODE_IN_DOJO and not __wf_atom_a676a953 or self.mCachedHubID == _T.HubChannel)
		then
			return
		end

		self.mIsScenarioChannel = self.mIsScenarioChannel or self.mCachedPersistentRelayHubActive

		local function fn57(p)
			return "#" .. self:_getHubChannelPrefix(self) .. "_" .. tostring(p)
		end

		if self.mCachedHubID ~= nil then
			local v56 = fn57(self.mCachedHubID)
			self:OnChannelStateChanged(self.CHANNEL_EXIT, v56, "")
			self.mPanelShortcuts[self.CHANNEL_HUB] = nil
		end

		if _T.HubChannel ~= nil then
			local v56 = string.find(string.lower(_T.HubChannel), "scenario") and "/Lotus/Language/Game/Scenario"
				or mIsInDojo and "/Lotus/Language/Locations/Dojo"
				or "/SF/Language/Menu/Chat_HubTitle"
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v56, false)
			local v57 = fn57(_T.HubChannel)
			local v58 = self:OnChannelStateChanged(self.CHANNEL_ENTER, v57, __wf_atom_8e9ac384, self.CHANNEL_HUB)
			self.mPanelShortcuts[self.CHANNEL_HUB] = v57

			if
				not __wf_atom_7e8ad928(v58)
				and not v58.mIsActive
				and self.mCachedHubID == nil
				and self.mFocusHubOnActive
			then
				self:SetActive(v58)
			end
		end

		self.mCachedHubID = _T.HubChannel
	end

	function v54._getClanChannelPrefix()
		return "C"
	end

	function v54:_getCouncilChannelPrefix()
		return "D"
	end

	function v54:_getRecruitingChannelPrefix()
		return "R"
	end

	function v54:_getTradeChannelPrefix()
		return "T"
	end

	function v54:_getQAChannelPrefix()
		return "Q"
	end

	function v54:_getAllianceChannelPrefix()
		return "A"
	end

	function v54._getPrivateChatChannelPrefix(_)
		return "F"
	end

	function v54._getHubChannelPrefix(p)
		if _T.HubChannel and string.find(string.lower(_T.HubChannel), "scenario") or p and p.mIsScenarioChannel then
			return "O"
		end

		return (module.Ternary(mUIMode == module3.UI_MODE_IN_DOJO, "J", "H"))
	end

	function v54:_updateCouncil()
		local mCachedIsCounselor = mEnableCouncilChat
			and not __wf_atom_7e8ad928(mGameData)
			and mGameData:__wf_atom_b3f93cda()

		if
			self.mPendingCouncilChannelName ~= nil
			and self.mIsConnected
			and self.mVisualMode ~= self.VISUAL_MODE_MENU_SIMPLE
		then
			local v56 = "#" .. self.mActivePanelName

			if self.mPendingCouncilChannelName == v56 or _G.hasJoinedCouncilChat then
				local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

				if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
					__wf_atom_7190444e:__wf_atom_0beacbb1(self.mPendingCouncilChannelName)
				end

				self.mPendingCouncilChannelName = nil
				_G.hasJoinedCouncilChat = true
			end
		end

		if mCachedIsCounselor ~= self.mCachedIsCounselor then
			local function fn57()
				return "#" .. self:_getCouncilChannelPrefix() .. self:_getPlatformSuffix(mCrossPlatformEnabled)
			end

			if self.mCachedIsCounselor then
				local v56 = fn57()
				self:OnChannelStateChanged(self.CHANNEL_EXIT, v56, "")
				self.mPanelShortcuts[self.CHANNEL_COUNCIL] = nil
			end

			if mCachedIsCounselor then
				local v56 = fn57()
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CouncilTitle", false)
				self:OnChannelStateChanged(self.CHANNEL_ENTER, v56, __wf_atom_8e9ac384, self.CHANNEL_COUNCIL)
				self.mPanelShortcuts[self.CHANNEL_COUNCIL] = v56
			end

			self.mCachedIsCounselor = mCachedIsCounselor
		end
	end

	function v54:_getRecruitingChannel()
		return self:_getGlobalChannelName(self:_getRecruitingChannelPrefix())
	end

	function v54:_getTradeChannel()
		return self:_getGlobalChannelName(self:_getTradeChannelPrefix())
	end

	function v54:_getQAChannel()
		return self:_getGlobalChannelName(self:_getQAChannelPrefix())
	end

	function v54:SetPendingChannelName(p, p2)
		if p2 == self.CHANNEL_GLOBAL then
			self.mPendingGlobalChannelName = p
		elseif p2 == self.CHANNEL_RECRUITING then
			self.mPendingRecruitingChannelName = p
		elseif p2 == self.CHANNEL_TRADE then
			self.mPendingTradeChannelName = p
		elseif p2 == self.CHANNEL_QA then
			self.mPendingQAChannelName = p
		end
	end

	function v54:SetIsChannelEnabled(mRegionChatEnabled, p)
		if p == self.CHANNEL_GLOBAL then
			self.mRegionChatEnabled = mRegionChatEnabled
		elseif p == self.CHANNEL_RECRUITING then
			self.mRecruitingChatEnabled = mRegionChatEnabled and not _G.StalkerMode
		elseif p == self.CHANNEL_TRADE then
			self.mTradeChatEnabled = mRegionChatEnabled and not _G.StalkerMode
		elseif p == self.CHANNEL_QA then
			self.mQAChatEnabled = mRegionChatEnabled and not _G.StalkerMode
		end
	end

	function v54:_updateGlobalChat(p, p2, p3, p4)
		local v55 = p3 and not self.mInQuestCommitment

		if
			p ~= nil
			and self.mIsConnected
			and self.mVisualMode ~= self.VISUAL_MODE_MENU_SIMPLE
			and p == "#" .. self.mActivePanelName
		then
			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
				__wf_atom_7190444e:__wf_atom_0beacbb1(p)
			end

			self:SetPendingChannelName(nil, p4)
		end

		if p2 == nil or p2 ~= v55 then
			self:SetIsChannelEnabled(v55, p4)
			local regionChannel = self:_getRegionChannel()
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_GlobalTitle", false)

			if p4 == self.CHANNEL_RECRUITING then
				regionChannel = self:_getRecruitingChannel()
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_RecruitingTitle", false)
			elseif p4 == self.CHANNEL_TRADE then
				regionChannel = self:_getTradeChannel()
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_TradeTitle", false)
			elseif p4 == self.CHANNEL_QA then
				regionChannel = self:_getQAChannel()
				__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_QandATitle", false)
			end

			if self.mPanelShortcuts[p4] ~= nil and (not v55 or regionChannel ~= self.mPanelShortcuts[p4]) then
				self:OnChannelStateChanged(self.CHANNEL_EXIT, self.mPanelShortcuts[p4], __wf_atom_8e9ac384, p4)
			end

			if v55 and self.mPanelShortcuts[p4] == nil then
				self:OnChannelStateChanged(self.CHANNEL_ENTER, regionChannel, __wf_atom_8e9ac384, p4, true)
				self.mPanelShortcuts[p4] = regionChannel

				if not self.mIsConnected then
					self:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ConnectingTitle", false))
				end
			end
		end

		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if
			self.mPanelShortcuts[p4] ~= nil
			and __wf_atom_7e8ad928(self:GetActivePanel())
			and v27
			and not _G.StalkerMode
		then
			if __wf_atom_18a5d83b:__wf_atom_01fbbcf8("default_qa") then
				if p4 == self.CHANNEL_QA or not mEnableQAChat then
					self:SetActive(self.mPanelList[string.gsub(self.mPanelShortcuts[p4], "#", "")])
				end
			else
				self:SetActive(self.mPanelList[string.gsub(self.mPanelShortcuts[p4], "#", "")])
			end
		end
	end

	function v54:_updateAlliance(p, p2)
		if __wf_atom_7e8ad928(mGameData) then
			return
		end

		local __wf_atom_12956d9a = mGameData:__wf_atom_12956d9a()
		local v55 = mGameData:__wf_atom_3fa20d02() or mGameData:__wf_atom_4fb36ef5()
		local v56

		if p == p2 then
			v56 = false
		elseif __wf_atom_12956d9a == "" then
			v56 = false
		else
			v56 = v55
		end

		if __wf_atom_12956d9a ~= self.mCachedAllianceId or v56 then
			if self.mCachedAllianceId ~= nil and not v56 then
				local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

				if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
					__wf_atom_7190444e:__wf_atom_239e1070(true)
				end
			end

			local function fn57(value, p3)
				local v57 = string.gsub(value, " ", "_")
				local v58 = not v55 and "" or self:_getPlatformSuffix(p3)
				return "#" .. self:_getAllianceChannelPrefix() .. tostring(v57) .. v58
			end

			if v56 or self.mCachedAllianceId ~= nil and self.mCachedAllianceId ~= "" then
				local v57 = fn57(self.mCachedAllianceId, p)
				self:OnChannelStateChanged(self.CHANNEL_EXIT, v57, "")
				self.mPanelShortcuts[self.CHANNEL_CLAN] = nil
			end

			if __wf_atom_12956d9a ~= "" then
				local v57 = fn57(__wf_atom_12956d9a, p2)
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_AllianceTitle", false)
				self:OnChannelStateChanged(self.CHANNEL_ENTER, v57, __wf_atom_8e9ac384, self.CHANNEL_ALLIANCE)
				self.mPanelShortcuts[self.CHANNEL_ALLIANCE] = v57
			end

			self.mCachedAllianceId = __wf_atom_12956d9a
		end

		if self.mCachedAllianceMotd ~= mCachedAllianceMotd then
			local v57 = self.mCachedAllianceMotd == ""

			if __wf_atom_12956d9a == "" or module.IsUGCRestricted() then
				self.mCachedAllianceMotd = mCachedAllianceMotd
				return
			end

			for k, v58 in pairs(self.mPanelList) do
				if
					__wf_atom_7e8ad928(v58)
					or v58.mChannelType ~= self.CHANNEL_ALLIANCE
					or self.mActivePanelName ~= k
				then
					continue
				end

				v58:SystemMessage(mCachedAllianceMotd, v57)
				self.mCachedAllianceMotd = mCachedAllianceMotd
				return
			end
		end
	end

	function v54:_updateClan(p, p2)
		if __wf_atom_7e8ad928(mGameData) then
			return
		end

		local mCachedGuildId = mGameData:__wf_atom_100362b3() and "" or mGameData:__wf_atom_5ff594a3()
		local __wf_atom_4fb36ef5 = mGameData:__wf_atom_4fb36ef5()
		local v56

		if p == p2 then
			v56 = false
		elseif mCachedGuildId == "" then
			v56 = false
		else
			v56 = __wf_atom_4fb36ef5
		end

		if mCachedGuildId ~= self.mCachedGuildId or v56 then
			if self.mCachedGuildId ~= nil and not v56 then
				local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

				if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
					__wf_atom_7190444e:__wf_atom_239e1070(true)
				end
			end

			local function fn57(value, p3)
				local v57 = string.gsub(value, " ", "_")
				local v58 = not __wf_atom_4fb36ef5 and "" or self:_getPlatformSuffix(p3)
				return "#" .. self:_getClanChannelPrefix() .. tostring(v57) .. v58
			end

			if v56 or self.mCachedGuildId ~= nil and self.mCachedGuildId ~= "" then
				local v57 = fn57(self.mCachedGuildId, p)
				self:OnChannelStateChanged(self.CHANNEL_EXIT, v57, "")
				self.mPanelShortcuts[self.CHANNEL_CLAN] = nil
			end

			if mCachedGuildId ~= "" then
				local v57 = fn57(mCachedGuildId, p2)
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ClanTitle", false)
				self:OnChannelStateChanged(self.CHANNEL_ENTER, v57, __wf_atom_8e9ac384, self.CHANNEL_CLAN)
				self.mPanelShortcuts[self.CHANNEL_CLAN] = v57
			end

			self.mCachedGuildId = mCachedGuildId
			local v57, _ = module2.RemoveNumericSuffixFromName(mGameData:__wf_atom_84083b39())
			local v58 = { mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ClanTitle", false), v57 }
			self.mGuildSuggest = {}

			if v58[2] ~= "" then
				for _, v59 in ipairs(v58) do
					table.insert(self.mGuildSuggest, "{" .. string.lower(v59) .. "}")
				end
			end
		end

		if self.mCachedGuildMotd ~= mCachedGuildMotd then
			local v57 = self.mCachedGuildMotd == ""

			if mCachedGuildId == "" or module.IsUGCRestricted() then
				self.mCachedGuildMotd = mCachedGuildMotd
				return
			end

			for k, v58 in pairs(self.mPanelList) do
				if __wf_atom_7e8ad928(v58) or v58.mChannelType ~= self.CHANNEL_CLAN or self.mActivePanelName ~= k then
					continue
				end

				v58:SystemMessage(mCachedGuildMotd, v57)
				break
			end

			self.mCachedGuildMotd = mCachedGuildMotd
		end
	end

	function v54:UpdateFadeOut(p, p2, p3, p4)
		if self.mVisualMode ~= p4 then
			return p2
		end

		p2 -= p
		local v55 = 100

		if p2 <= 0 then
			v55 = 0
			p2 = 0
		elseif p2 <= 1 then
			v55 = p2 * 100
		end

		mMovie:__wf_atom_e57658c2(p3, 12, v55)
		return p2
	end

	function v54:UpdateFlashingElement()
		if self.mFlashingTimer ~= nil then
			local v55 = self.mFlashingTimer == mWindow.mDelayedFadeOutTimer
			local mFlashAlpha = mWindow.mFlashAlpha
			self.mFlashingTimer -= __wf_atom_fa1258d0()

			if self.mFlashingTimer <= 0 then
				mMovie:__wf_atom_290807ee(self.mClipName .. ".Icon")
				mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 1, 8)
				self.mFlashingTimer = nil
				mFlashAlpha = 100
			end

			mMovie:__wf_atom_e57658c2(self.mClipName, 12, mFlashAlpha)

			if not self.mBouncing and self.mFlashingTimer ~= nil then
				self.mBouncing = true
				__wf_atom_ec43d06e(
					mMovie,
					self.mClipName .. ".Icon",
					8,
					{ 1 },
					{ 0 },
					0.25,
					module.Ternary(v55, 0, 1),
					function()
						__wf_atom_ec43d06e(mMovie, self.mClipName .. ".Icon", 4, { 1 }, { 8 }, 0.5, 0, function()
							self.mBouncing = false
						end)
					end
				)
			end
		end
	end

	function v54:Update(p)
		if self.mIsConnected then
			if __wf_atom_7e8ad928(mGameData) or __wf_atom_7e8ad928(mProfileSettings) then
				print("ChatRedux::Update GameData and profilesettings dead")
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
					mGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
					mProfileSettings = __wf_atom_18a5d83b:Settings()
				end

				if __wf_atom_7e8ad928(mGameData) or __wf_atom_7e8ad928(mProfileSettings) then
					return
				end
			end

			local mCrossPlatformEnabled2 = mCrossPlatformEnabled
			mCrossPlatformEnabled = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_7f395d54()
			local v55 = mCrossPlatformEnabled ~= mCrossPlatformEnabled2
			self:_updateHub()
			self:_updateSquad()

			if v55 then
				if mCrossPlatformEnabled then
					v16 ..= " #"
				else
					v16 = "[] "
				end

				print("Cross Play Setting changed to " .. tostring(mCrossPlatformEnabled))
			end

			self:_updateGlobalChat(
				self.mPendingGlobalChannelName,
				self.mRegionChatEnabled,
				mEnableRegionChat and not v55,
				self.CHANNEL_GLOBAL
			)
			self:_updateGlobalChat(
				self.mPendingRecruitingChannelName,
				self.mRecruitingChatEnabled,
				mEnableRecruitingChat and not v55,
				self.CHANNEL_RECRUITING
			)
			self:_updateGlobalChat(
				self.mPendingQAChannelName,
				self.mQAChatEnabled,
				mEnableQAChat and not v55,
				self.CHANNEL_QA
			)
		end

		if self.mFadeActive then
			self.mActiveTabListFadeOutTimer = self:UpdateFadeOut(
				p,
				self.mActiveTabListFadeOutTimer,
				"Window.Hint",
				self.VISUAL_MODE_GAMEPLAY_SIMPLE
			)
			self.mActiveChatFadeOutTimer = self:UpdateFadeOut(
				p,
				self.mActiveChatFadeOutTimer,
				"Window.TabbedChatPanel",
				self.VISUAL_MODE_GAMEPLAY_SIMPLE
			)
			self.mMenuTabListFadeOutTimer = self:UpdateFadeOut(
				p,
				self.mMenuTabListFadeOutTimer,
				"Window.TabMenu",
				self.VISUAL_MODE_MENU_SIMPLE
			)

			if self.mActiveTabListFadeOutTimer <= 0 and self.mActiveChatFadeOutTimer <= 0 then
				self.mFadeActive = false
				mMovie:SetVisible(false)
			end
		end

		v4.timer += v4.dir * p

		if v4.timer < 0 or v4.timer > v4.FADE_DURATION then
			v4.timer = __wf_atom_421b01aa(v4.timer, 0, v4.FADE_DURATION)
			v4.dir *= -1
		end

		local v55 = v4.timer / v4.FADE_DURATION
		local mFlashAlpha = __wf_atom_104bfe98(v4.MIN_ALPHA, v4.MAX_ALPHA, v55)

		if not __wf_atom_7e8ad928(self.mSimpleTabList) then
			self.mFlashAlpha = mFlashAlpha
			self.mSimpleTabList:RunForAllElements(self.UpdateFlashingElementDelegate)
		end

		if not __wf_atom_7e8ad928(self.mInputPanel) and self.mInputPanel.CharLimitFlashTime > 0 then
			self.mInputPanel.CharLimitFlashTime = self.mInputPanel.CharLimitFlashTime - p

			if self.mInputPanel.CharLimitFlashTime <= 0 then
				mMovie:__wf_atom_e57658c2("Window.SendMessageBar.CharLimit", 12, 100)
				self.mInputPanel.CharLimitFlashTime = 0
			else
				mMovie:__wf_atom_e57658c2("Window.SendMessageBar.CharLimit", 12, __wf_atom_104bfe98(50, 100, v55))
			end
		end

		if mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE then
			return
		end

		if not __wf_atom_7e8ad928(self.mTabMenu) then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.TabMask", 14)
			local mLeftArrowFlashing = false
			local mRightArrowFlashing = false

			for i = 1, self.mTabMenu:GetHowManyElements() do
				local elementInIndex = self.mTabMenu:GetElementInIndex(i)

				if __wf_atom_7e8ad928(elementInIndex) or not elementInIndex.isFlashing then
					continue
				end

				mWindow.mTabMenu:SetTabColour(elementInIndex, false, mFlashAlpha)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0)
				local v59 = __wf_atom_5e6e15c8_2 == nil and 0 or __wf_atom_5e6e15c8_2
				local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName .. ".Bg", 14)
				local v60 = __wf_atom_5e6e15c8_3 == nil and 0 or __wf_atom_5e6e15c8_3

				if mLeftArrowFlashing or not (v59 + v60 < 0) then
					if not mRightArrowFlashing and __wf_atom_5e6e15c8 < v59 then
						mRightArrowFlashing = true
					end
				else
					mLeftArrowFlashing = true
				end
			end

			if
				not mWindow.mLeftArrowFocused
				and (mLeftArrowFlashing ~= mWindow.mLeftArrowFlashing or mLeftArrowFlashing)
			then
				mMovie:__wf_atom_e57658c2(
					module.Ternary(
						Engine.IsPlayingWithController(),
						"Window.TabMenu.LeftBumper",
						"Window.TabMenu.LeftArrow"
					),
					12,
					module.Ternary(mLeftArrowFlashing, mFlashAlpha, 50)
				)
			end

			if
				not mWindow.mRightArrowFocused
				and (mRightArrowFlashing ~= mWindow.mRightArrowFlashing or mRightArrowFlashing)
			then
				mMovie:__wf_atom_e57658c2(
					module.Ternary(
						Engine.IsPlayingWithController(),
						"Window.TabMenu.RightBumper",
						"Window.TabMenu.RightArrow"
					),
					12,
					module.Ternary(mRightArrowFlashing, mFlashAlpha, 100)
				)
			end

			mWindow.mLeftArrowFlashing = mLeftArrowFlashing
			mWindow.mRightArrowFlashing = mRightArrowFlashing

			if decrement ~= 0 then
				if v41 == 0 then
					if not Engine.__wf_atom_d2059813() then
						mWindow:cycleActiveTab(decrement)
					end

					decrement = 0
				else
					v41 -= 1
				end
			end
		end

		local __wf_atom_387f260e = mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36)
		mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.Prompt", 13, __wf_atom_387f260e == "")

		if not __wf_atom_7e8ad928(mWindow) then
			local v57 = false
			local v58 = 0
			local v59

			if Engine.IsPlayingWithController() then
				v59 = false
			else
				local v60 = mWindow.mInputPanel.mMaxMsgLength - string.len(__wf_atom_387f260e)
				v59 = v60 <= 20
				mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.CharLimit.Warning", 13, v59)

				if v59 then
					local ternary = module.Ternary(
						v60 >= 0,
						mWindow.mInputPanel.CharLimitWarning,
						mWindow.mInputPanel.CharLimitError
					)
					mMovie:__wf_atom_50d60589(
						"Window.SendMessageBar.CharLimit.Warning",
						36,
						ternary .. " " .. tostring(v60)
					)
					mMovie:__wf_atom_e57658c2(
						"Window.SendMessageBar.CharLimit.Warning",
						44,
						module.Ternary(v60 >= 0, _G.UIColor_Black, _G.UIColor_Red)
					)
					v58 = mMovie:__wf_atom_5e6e15c8("Window.SendMessageBar.CharLimit.Warning", 40) + 16
				end
			end

			local activePanel = mWindow:GetActivePanel()

			if not __wf_atom_7e8ad928(activePanel) then
				local v60 = activePanel.mChannelType == mWindow.CHANNEL_TRADE
				local ternary = module.Ternary(v60, _G.TradeSpamBlockTime, activePanel.mSpamBlockTime)

				if ternary ~= nil then
					local v61 = module.Ternary(v60, v3.TRADE_SPAM_DETECTION_PERIOD, v3.SPAM_LOCKOUT_TIME) - (__wf_atom_c4e218a2() - ternary)

					if v61 > 0 then
						local ternary2 = module.Ternary(v59, -20, 3)
						mMovie:__wf_atom_e57658c2("Window.SendMessageBar.CharLimit.SpamTime", 1, ternary2)
						mMovie:__wf_atom_50d60589(
							"Window.SendMessageBar.CharLimit.SpamTime",
							36,
							mWindow.mInputPanel.TimerIcon .. " " .. tostring((math.floor(v61))) .. "s"
						)
						v58 = math.max(
							v58,
							mMovie:__wf_atom_5e6e15c8("Window.SendMessageBar.CharLimit.SpamTime", 40) + 16
						)
						v57 = true
					end
				end
			end

			mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.CharLimit.SpamTime", 13, v57)
			local v60 = v59 or v57
			mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.CharLimit", 13, v60)

			if v60 then
				local v61 = 23 * module.Ternary(v59 and v57, 2, 1)
				mMovie:__wf_atom_e57658c2("Window.SendMessageBar.CharLimit.Bg", 14, v58)
				mMovie:__wf_atom_e57658c2("Window.SendMessageBar.CharLimit.Bg", 15, v61)
			end
		end

		if v43.RefreshChatHistoryCooldown > 0 then
			v43.RefreshChatHistoryCooldown -= p
		end

		_T.MouseInChatArea = fn3()
		local mMouseIsDragging = (self.mWindowTitle.isDragging or self.mWindowStatus.isDragging)
			and not Engine.__wf_atom_2a979d69()

		if mMouseIsDragging then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

			if self.mInitMouseX == nil then
				self.mInitMouseX = __wf_atom_5e6e15c8
				self.mInitMouseY = __wf_atom_5e6e15c8_2
				self.mInitWindowX = self.mWindow.x
				self.mInitWindowY = self.mWindow.y
				self.mInitWindowW = self.mWindow.width
				self.mInitWindowH = self.mWindow.height
			end

			if self.mPrevMouseX == __wf_atom_5e6e15c8 and self.mPrevMouseY == __wf_atom_5e6e15c8_2 then
				if v43.ResizeRequired and v43.RefreshChatHistoryCooldown <= 0 then
					v43.ResizeRequired = false

					for _, v58 in pairs(self.mPanelList) do
						v58:ClearHistory()
					end

					if not __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
						self.mPanelList[self.mActivePanelName]:RefreshText(true)
					end
				end
			else
				local v58 = __wf_atom_5e6e15c8 - self.mInitWindowX - (self.mInitMouseX - self.mInitWindowX)
				local v59 = __wf_atom_5e6e15c8_2 - self.mInitWindowY - (self.mInitMouseY - self.mInitWindowY)

				if self.mWindowTitle.isDragging then
					self:SetPosition(self.mInitWindowX + v58, self.mInitWindowY + v59, true, false)
				elseif self.mWindowStatus.isDragging then
					v43.ResizingWindow = true

					if self.mWindowStatus.ResizeClipName == self.mTopResizeClipName then
						self:SetPosition(self.mInitWindowX, self.mInitWindowY + v59, true, false)
						v59 = -v59
					end

					self:SetSize(
						math.min(self.mInitWindowW + v58, 1738),
						self.mInitWindowH + v59,
						v43.RefreshChatHistoryCooldown <= 0
					)
				end
			end

			self.mPrevMouseX = __wf_atom_5e6e15c8
			self.mPrevMouseY = __wf_atom_5e6e15c8_2
		else
			self.mInitMouseX = nil
			self.mInitMouseY = nil
			self.mPrevMouseX = nil
			self.mPrevMouseY = nil
			self.mInitWindowX = nil
			self.mInitWindowY = nil
			self.mInitWindowW = nil
			self.mInitWindowH = nil

			if v43.ResizingWindow then
				v43.ResizingWindow = false
				v43.ResizeRequired = false
				v43.RefreshChatHistoryCooldown = 0

				for _, v58 in pairs(self.mPanelList) do
					v58:ClearHistory()
				end

				if not __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
					self.mPanelList[self.mActivePanelName]:RefreshText(true)
				end
			end
		end

		if self.mMouseIsDragging ~= mMouseIsDragging then
			self:SetPosition(self.mWindow.x, self.mWindow.y, true, false)
		end

		self.mMouseIsDragging = mMouseIsDragging

		if mMouseIsDragging then
			_T.MouseInChatArea = true
		end

		self.mUserPanel:Update(p)

		for _, v58 in pairs(self.mPanelList) do
			if not __wf_atom_7e8ad928(v58) then
				v58:Update(p)
			end
		end
	end

	function v54:SetCompressed(p, p2)
		local v55 = { "Window.TabMenu.WindowTitle", "Window.WindowStatus", "Window.TabMenu.Resize" }

		if p2 and not (__wf_atom_7e8ad928(_G.UISound_WindowOpen) or __wf_atom_7e8ad928(_G.UISound_WindowClose)) then
			module.PlaySound(module.Ternary(not p, _G.UISound_WindowOpen, _G.UISound_WindowClose))
		end

		local v56 = not p and 0 or self.mWindow.height - 10
		mMovie:__wf_atom_2dedec1a("Window.TabMenu.ExpandCallout", 13, p)
		mMovie:__wf_atom_e57658c2("Window.TabMenu", 1, v56)

		if Engine.__wf_atom_2a979d69() then
			for i = 1, mWindow.mTabMenu:GetHowManyElements() do
				mMovie:__wf_atom_2dedec1a(mWindow.mTabMenu:GetElementInIndex(i).mClipName, 13, not p)
			end
		end

		for i = 1, #v55 do
			mMovie:__wf_atom_2dedec1a(v55[i], 13, not p)
		end

		self:SetArrowVisibilities()
		self:SetPosition(self.mWindow.x, self.mWindow.y, false, p2)
	end

	function v54:SetPosition(p, p2, p3, _)
		local v55 = 27
		local width = self.mWindow.width
		local v56 = self.mWindow.height + 27
		local ternary = module.Ternary(module.ShouldMoveIntoTitleSafe(), mViewportWidth * 0.05, 0)
		local ternary2 = module.Ternary(module.ShouldMoveIntoTitleSafe(), mViewportHeight * 0.05, 0)

		if Engine.__wf_atom_2a979d69() then
			ternary *= miOSChatScale
			ternary2 *= miOSChatScale
			v55 *= miOSChatScale
		end

		local v57

		if self.mVisualMode == self.VISUAL_MODE_MENU_SIMPLE then
			local v58 = p2 + mMovie:__wf_atom_5e6e15c8("Window.TabMenu", 1)
			v57 = p2 + (__wf_atom_421b01aa(v58, ternary2, mViewportHeight - v55 - ternary2) - v58)
		else
			v57 = __wf_atom_421b01aa(p2, ternary2, mViewportHeight - v56 - ternary2)
		end

		if self.mUserPanel.mIsExpanded then
			width += self.mUserPanel.mWindow.width

			if self.mUserPanel.mUserLocator.mIsExpanded then
				width += self.mUserPanel.mUserLocator.mGridWidth
			end
		end

		local v58 = __wf_atom_421b01aa(p, ternary, mViewportWidth - width - ternary)
		self.mWindow.x = v58
		self.mWindow.y = v57
		mMovie:__wf_atom_e57658c2(self.mClipName, 0, v58)
		mMovie:__wf_atom_e57658c2(self.mClipName, 1, v57)

		if p3 and not (Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69()) then
			if v58 + width / 2 > mViewportWidth / 2 then
				v58 = -(v58 + width)
			end

			if v57 + v56 / 2 > mViewportHeight / 2 then
				v57 = -(v57 + v56)
			end

			local v59 = __wf_atom_421b01aa(v58 / mViewportWidth, -1, 1)
			local v60 = __wf_atom_421b01aa(v57 / mViewportHeight, -1, 1)

			if not __wf_atom_7e8ad928(mProfileSettings) then
				mProfileSettings:__wf_atom_88062846(true, true, v59)
				mProfileSettings:__wf_atom_88062846(true, false, v60)
			end
		end
	end

	function v54:SetMinMaxBtnPos()
		local mMovie2 = mMovie
		mMovie2:__wf_atom_7f57ab2f(
			self.mClipName,
			"TabMenu.MinMaxBtn.Separator",
			13,
			self.mVisualMode == self.VISUAL_MODE_MENU_SIMPLE and not Engine.__wf_atom_2a979d69()
		)
		local v58 = self.mWindow.width - 48

		if self.mVisualMode == self.VISUAL_MODE_MENU_SIMPLE and not Engine.__wf_atom_2a979d69() then
			v58 = module.Ternary(
				Engine.IsPlayingWithController(),
				mMovie:__wf_atom_5e6e15c8("Window.TabMenu.RightBumper", 0),
				mMovie:__wf_atom_5e6e15c8("Window.TabMenu.RightArrow", 0)
			) - 6
		end

		if Engine.__wf_atom_2a979d69() then
			local v59 = self.mWindow.height - 101
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName, 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(self.mClipName, 1)
			v58 = -__wf_atom_5e6e15c8 + 49
			local v60 = -__wf_atom_5e6e15c8_2 + v59

			if self.mVisualMode ~= self.VISUAL_MODE_MENU_SIMPLE then
				v60 += self.mWindow.height
			end

			if self.mVisualMode == self.VISUAL_MODE_GAMEPLAY_SIMPLE then
				v60 = 50
				v58 = -8
			end

			mMovie:__wf_atom_e57658c2(self.mClipName .. ".TabMenu.MinMaxBtn", 1, v60)
		end

		local __wf_atom_86cbd68d = __wf_atom_86cbd68d
		local mMovie3 = mMovie
		__wf_atom_86cbd68d(
			mMovie3,
			self.mClipName .. ".TabMenu.MinMaxBtn.Icon.gotoAndStop",
			module.Ternary(
				self.mVisualMode == self.VISUAL_MODE_MENU_SIMPLE and not Engine.__wf_atom_2a979d69(),
				"Min",
				"Max"
			)
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.MinMaxBtn", 0, v58)

		if Engine.IsPlayingWithController() and Engine.__wf_atom_2a979d69() then
			UpdateExpandCalloutPos()
		end
	end

	function v54:SetSize(p, p2, p3)
		local width = __wf_atom_421b01aa(p, self.mWindow.minWidth, mViewportWidth * self.mWindow.maxWidth)
		local height = __wf_atom_421b01aa(p2, self.mWindow.minHeight, mViewportHeight * self.mWindow.maxHeight)
		self.mWindow.width = width
		self.mWindow.height = height
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.Fill", 14, width)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.FillBlurer", 14, width - 2)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeTop", 14, width - 2)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeBottom", 14, width - 2)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.EdgeRight", 0, width - 1)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "WindowStatus", 1, height + 18)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "WindowStatus", 0, width - 9)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint", 1, height + 6)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Hint.SimpleTabListMask", 14, width)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "FontIncrease", 0, width - (self.mFontButtonWidth + 3) * 2)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "MouseCatcherBtn", 1, 0)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "MouseCatcherBtn", 15, height + self.mWindowTitle.height)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabMenu.TabMask",
			14,
			self.mWindow.width - 70 - mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabMenu.TabMask", 0)
		)

		if not __wf_atom_7e8ad928(mWindow.mTabMenu) then
			mWindow.mTabMenu:SetRightBumperPos()
		end

		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabMenu.Resize",
			0,
			self.mWindow.width - mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabMenu.Resize", 14) - 1
		)
		local coordsRelativeToParent = self:GetCoordsRelativeToParent(self.mChatPanelWindow)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel", 0, self.mChatPanelWindow.x)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel", 1, self.mChatPanelWindow.y)
		local v57 = coordsRelativeToParent.width - mMovie:__wf_atom_5e6e15c8(
			self.mClipName .. ".TabbedChatPanel.Fill",
			0
		) * 2 + module.Ternary(self.mUserPanel.mIsExpanded, self.mUserPanel.mActiveRect.width, 0) + 4
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.Fill", 14, v57)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabMenu.WindowTitle.Fill", 14, v57 - 12)
		mMovie:OverrideMaterial(self.mClipName .. ".TabbedChatPanel.Fill", mainBackerMaterial)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabbedChatPanel.Fill",
			15,
			coordsRelativeToParent.height - mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabbedChatPanel.Fill", 1) * 2
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.Divider", 15, coordsRelativeToParent.height)
		mMovie:OverrideMaterial(self.mClipName .. ".TabbedChatPanel.Divider", verticalDividerMaterial)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.FillBlurer", 14, coordsRelativeToParent.width)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.FillBlurer", 15, coordsRelativeToParent.height)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.EdgeRight", 0, coordsRelativeToParent.width)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.EdgeRight", 15, coordsRelativeToParent.height)

		if Engine.__wf_atom_2a979d69() then
			mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.EdgeLeft", 15, 191)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.DecoLine", 15, 205)
		else
			mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"TabbedChatPanel.EdgeLeft",
				15,
				coordsRelativeToParent.height - 31
			)
			mMovie:__wf_atom_4c1c1986(
				self.mClipName,
				"TabbedChatPanel.DecoLine",
				15,
				coordsRelativeToParent.height - 17
			)
		end

		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabbedChatPanel.ScrollBar", 14)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabbedChatPanel.ScrollBar",
			0,
			coordsRelativeToParent.width - __wf_atom_5e6e15c8 / 2 + 3
		)

		if Engine.__wf_atom_578fc9dd() then
			mMovie:__wf_atom_48bd5a59(self.mClipName, "TabbedChatPanel.ChatArea", 49, "Arial Unicode MS")
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.ChatArea", 14, coordsRelativeToParent.width - 18)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "TabbedChatPanel.ChatArea", 15, coordsRelativeToParent.height - 25)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabbedChatPanel.ChatArea",
			1,
			coordsRelativeToParent.height - 25 - 16
		)
		mMovie:__wf_atom_48bd5a59(self.mClipName, "TabbedChatPanel.ChatArea", 46, "bottom")
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"TabbedChatPanel.FilterListMask",
			14,
			coordsRelativeToParent.width - 49
		)

		if not __wf_atom_7e8ad928(self.mFilterList) then
			self.mFilterList:RunForAllElements(function(p4)
				self.mFilterList.AdjustBtnWidth(p4)
			end)
		end

		v43.ResizeRequired = not p3

		if p3 then
			v43.RefreshChatHistoryCooldown = 0.25
		end

		for _, v58 in pairs(self.mPanelList) do
			if p3 or not v58.mIsActive then
				v58:ClearHistory()
			else
				local v59 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabbedChatPanel.ChatArea", 43) - 1

				if v59 ~= self.numLines or v58.mMaxVisibleChatLines < v59 then
					v43.RefreshChatHistoryCooldown = 0.25
					v58:ClearHistory()
				end
			end
		end

		if not __wf_atom_7e8ad928(self.mPanelList[self.mActivePanelName]) then
			self.mPanelList[self.mActivePanelName]:RefreshText(true)
			self.numLines = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".TabbedChatPanel.ChatArea", 43) - 1
		end

		self.mUserPanel:SetSize(width, height)
		self.mInputPanel:SetSize(width, height)

		if not (Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69()) then
			local v58 = __wf_atom_421b01aa(self.mWindow.width / mViewportWidth, 0, 1)
			local v59 = __wf_atom_421b01aa(self.mWindow.height / mViewportHeight, 0, 1)

			if not __wf_atom_7e8ad928(mProfileSettings) then
				mProfileSettings:__wf_atom_ee520df6(true, true, v58)
				mProfileSettings:__wf_atom_ee520df6(true, false, v59)
			end
		end
	end

	function v54:GetActivePanel()
		return self.mPanelList[self.mActivePanelName]
	end

	function v54:SetFontSize(p)
		local activePanel = self:GetActivePanel()
		local v55 = { 25.8, 25.8, 25.8 }
		local v56 = { -2, -2, -2 }
		local v57 = ({ 23, 23, 23 })[p]
		local v58 = ({ "FixedSize", "Arial Unicode MS", "Arial Unicode MS" })[p]
		local mFontName = (Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69()) and "Arial Unicode MS" or v58
		mMovie:__wf_atom_50d60589("Window.TabbedChatPanel.ChatArea", 49, mFontName)
		mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel.ChatArea", 50, v57)
		mMovie:__wf_atom_50d60589("Window.TabbedChatPanel.ChatArea", 36, "")
		mMovie:__wf_atom_976dcedd("Window.Hint", "Callout", mFontName)
		self.mFontName = mFontName
		local smallChatTextMaterial = smallChatTextMaterial

		if p ~= 1 or Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69() then
			if ({ _ko = true, _ja = true, _zh = true, _tc = true })[__wf_atom_b953295d():c_str()] then
				smallChatTextMaterial = scalingChatAsianTextMaterial
			else
				smallChatTextMaterial = scalingChatTextMaterial
			end
		end

		mMovie:__wf_atom_3eb83f41(smallChatTextMaterial)

		for _, v60 in pairs(self.mPanelList) do
			v60:ClearHistory()
		end

		if not __wf_atom_7e8ad928(activePanel) then
			activePanel:RefreshText(true)
		end

		for _, v60 in pairs({ ".MessageBox", ".Prompt" }) do
			local v61 = self.mInputPanel.mClipPath .. v60
			mMovie:__wf_atom_50d60589(v61, 49, mFontName)
			mMovie:__wf_atom_e57658c2(v61, 50, v57)
			mMovie:__wf_atom_e57658c2(v61, 15, v55[p])
			mMovie:__wf_atom_e57658c2(v61, 1, v56[p])
		end

		if not (__wf_atom_7e8ad928(self.mUserPanel) or __wf_atom_7e8ad928(self.mUserPanel.mListControl)) then
			self.mUserPanel.mListControl:RunForAllVisibleElements(function(p2)
				self.mUserPanel.mListControl.mElementDrawCallback(p2)
			end)
		end

		if not (__wf_atom_7e8ad928(self.mUserPanel) or __wf_atom_7e8ad928(self.mUserPanel.mEmoteGrid)) then
			self.mUserPanel.mEmoteGrid:RunForAllVisibleElements(function(p2)
				self.mUserPanel.mEmoteGrid.mElementDrawCallback(p2)
			end)
		end

		mMovie:__wf_atom_50d60589("Window.UserPanel.Panel.LocatorBtn.Label", 49, mFontName)
		mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn.Label", 44, _G.UIColor_Gold)
	end

	function v54:ResetFadeOutTimer(p)
		self.mActiveTabListFadeOutTimer = self.mDelayedFadeOutTimer
		self.mMenuTabListFadeOutTimer = self.mDelayedFadeOutTimer

		if not p then
			self.mActiveChatFadeOutTimer = self.mDelayedFadeOutTimer
		end

		self.mFadeActive = true
		mMovie:SetVisible(true)
	end

	function v54:HideFadeOut(p)
		self.mActiveTabListFadeOutTimer = 0
		self.mMenuTabListFadeOutTimer = 0

		if not p then
			self.mActiveChatFadeOutTimer = 0
		end

		self.mFadeActive = true
	end

	function v54.ToggleSelectedElement(p, p2)
		local mListControl = p.mUserPanel.mListControl

		if mMovie:__wf_atom_a91463a8("ContextMenu", 13) then
			mListControl = mContextMenu
		end

		local focusedElementIndex = mListControl:GetFocusedElementIndex()
		local v55 = __wf_atom_7e8ad928(focusedElementIndex) and 0 or focusedElementIndex
		local v56

		if mListControl.mWrapAroundNavigation then
			v56 = module.ToggleValue(v55, p2, 1, mListControl:GetHowManyElements())
		else
			v56 = __wf_atom_421b01aa(v55 + p2, 1, mListControl:GetHowManyElements())
		end

		if mListControl == p.mUserPanel.mListControl then
			mWindow.mUserPanel:FocusElement(v56)
		else
			mListControl:FocusElement(v56)
		end
	end

	return v54
end

local function fn57(mViewportWidth2, mViewportHeight2, p)
	local v54 = mChatScale * module.Ternary(not Engine.__wf_atom_2a979d69(), 1, 0.9)
	mMovie:__wf_atom_e57658c2("_root", 5, v54 * 100)
	mMovie:__wf_atom_e57658c2("_root", 6, v54 * 100)
	mViewportWidth /= mChatScale
	mViewportHeight /= mChatScale

	if not __wf_atom_7e8ad928(mWindow) and p then
		local v55 = 1 - (mViewportWidth2 - mWindow.mWindow.x) / mViewportWidth2
		local v56 = 1 - (mViewportHeight2 - mWindow.mWindow.y) / mViewportHeight2
		local width = mWindow.mWindow.width
		local v57 = mWindow.mWindow.height + mWindow.mWindowTitle.height
		local v58 = width / mViewportWidth2
		local v59 = width / mViewportWidth
		local v60 = v57 / mViewportHeight2
		local v61 = v57 / mViewportHeight
		local v62 = v55 <= 0.5

		if v62 ~= (v55 + v58 <= 0.5) then
			local v63 = 0.5 - v55
			v62 = v55 + v58 - v63 < v63
		end

		local v63

		if v62 then
			v63 = mViewportWidth * v55
		else
			v63 = mViewportWidth * (v58 - v59 + v55)
		end

		local v64 = v56 <= 0.5

		if v64 ~= (v56 + v60 <= 0.5) then
			local v65 = 0.5 - v56
			v64 = v56 + v58 - v65 < v65
		end

		local v65

		if v64 then
			v65 = mViewportHeight * v56
		else
			v65 = mViewportHeight * (v60 - v61 + v56)
		end

		mWindow:SetPosition(v63, v65, true, false)
	end
end

local function fn58(p, p2, p3)
	local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
	local mViewportWidth2 = mViewportWidth
	local mViewportHeight2 = mViewportHeight
	local v54 = tonumber(p)
	local v55 = tonumber(p2)

	if Engine.__wf_atom_fc67ba71() or v54 < __wf_atom_97cd8326 or v55 < __wf_atom_54eeda24 then
		mViewportWidth = __wf_atom_97cd8326
		mViewportHeight = __wf_atom_54eeda24
	else
		mViewportWidth = math.max(v54, __wf_atom_97cd8326)
		mViewportHeight = math.max(v55, __wf_atom_54eeda24)
	end

	fn57(mViewportWidth2, mViewportHeight2, p3)
end

function onHudMarginsChanged()
	if not __wf_atom_7e8ad928(mWindow) and Engine.IsPlayingWithController() then
		mWindow:SetInitWindowSize()
		mWindow:SetInitWindowPosition()

		if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_SIMPLE)
		end
	end
end

function onViewportSizeChanged(p, p2)
	local mViewportHeight2 = mViewportHeight
	fn58(p, p2)

	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:SetInitWindowSize()
		mWindow:SetInitWindowPosition(mViewportHeight2 < mViewportHeight)

		if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_SIMPLE)
		end
	end
end

function Shutdown()
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow:Shutdown()
	end

	_T.MinimizeChat = nil

	if __wf_atom_7e8ad928(mGameData) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			mGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		end
	end

	if not __wf_atom_7e8ad928(mGameData) then
		mGameData:__wf_atom_35b2fc84("OnSyncWorldState", CALLBACK_IDENTIFIER)
	end
end

function ContextItemFocused(p)
	if __wf_atom_7e8ad928(mContextMenu) or mInputBlocked then
		return
	end

	mContextMenu:FocusElementById((tonumber(p)))
end

function ContextItemUnfocused(p)
	if __wf_atom_7e8ad928(mContextMenu) then
		return
	end

	mContextMenu:UnfocusElementById((tonumber(p)))
end

function ContextItemPressed(p)
	if __wf_atom_7e8ad928(mContextMenu) or mInputBlocked then
		return
	end

	mContextMenu:SelectElementById((tonumber(p)))
end

local function fn59()
	mContextMenu = module14.CreateList(mMovie, "ContextMenu.Btn1")
	mContextMenu.mLongestElement = 0
	mContextMenu.mForcedVerticalSeparation = 32
	mContextMenu.mWrapAroundNavigation = false
	mContextMenu.mVisibleElements = 8

	function mContextMenu.mOnSelectedCallback(p)
		if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.PressedCallback) then
			return
		end

		local v54

		if __wf_atom_7e8ad928(p.callbackParam) then
			v54 = p.PressedCallback()
		else
			v54 = p.PressedCallback(p.callbackParam)
		end

		if __wf_atom_7e8ad928(v54) or v54 then
			fn24()
		end
	end

	function mContextMenu:mElementDrawCallback()
		if __wf_atom_7e8ad928(self) then
			return
		end

		local module16 = require("SF.Interface.Components.Button")
		self.Button = module16.Create(mMovie, self.mClipName, self.Name)
		self.Button:SetId(self.Id)
		self.Button.mMinSize = 200
		self.Button.mAlignment = "left"
		self.Button.mTextBuffer = 10

		function self.Button.mOnReleasedCallback()
			mContextMenu.mOnSelectedCallback(self)
		end

		self.Button:Redraw()
		self.Button:Resize()
		mMovie:OverrideMaterial(self.mClipName .. ".TextHolder.Label", _G.UIMaterial_PlainText)
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(self.mClipName, "TextHolder.Label", 40)
		mContextMenu.mLongestElement = math.max(mContextMenu.mLongestElement, __wf_atom_cfc41e35)
	end

	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module9.GetColor(9, true, false))
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module9.GetColor(2, true, false))
	mMovie:OverrideMaterial("ContextMenu.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"ContextMenu.Bg",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.3
	)
	mMovie:__wf_atom_1ca72041(
		"ContextMenu.Bg",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.9
	)
	mMovie:__wf_atom_2dedec1a("ContextMenu", 67, false)
	mMovie:__wf_atom_2dedec1a("ContextMenu", 13, false)
end

local function fn60(mIds, list, p)
	if p == v14.NEWS then
		for i = 1, #list do
			v11[i] = {}
			v11[i].id = tostring(list[i].mId)
			v11[i].dateSec = list[i].mDate.sec
		end
	else
		if p == v14.PVPAFFECTOR then
		end

		for i = 1, #list do
			mIds[i] = tostring(list[i].mId)
		end
	end
end

local function fn61(p)
	local starChart = module3.GetStarChart()
	local __wf_atom_d5226f21 = starChart:__wf_atom_d5226f21(p.mMissionInfo.location)
	local v54 = Localize(__wf_atom_d5226f21.locTag:c_str(), nil)
	local v55 = Localize(starChart:__wf_atom_161b95d4()[__wf_atom_d5226f21.region + 1].name, nil)
	local rewardDesc = module3.GetRewardDesc(mMovie, p.mMissionInfo.missionReward, nil, true)
	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(p.mExpiry)
	local v56 = Localize("/Lotus/Language/Menu/Notification_Expiry", nil)
	local v57 = string.format(v56, module3.GetTwitterStyleTime(__wf_atom_db2b0cee))
	return Localize("/Lotus/Language/Menu/Notification_Alert", nil) .. ": " .. v54 .. " (" .. v55 .. ") - " .. rewardDesc .. ", " .. v57
end

local function fn62(p)
	if p.mMsg == "" then
		return nil
	end

	return Localize("/Lotus/Language/Menu/Notification_News", nil) .. ": " .. p.mMsg
end

local function fn63()
	local ternary = module.Ternary(
		v26,
		"/Lotus/Language/Menu/Notification_NewBuildSubjectReminder",
		"/Lotus/Language/Menu/Notification_NewBuildSubject"
	)
	local v54 = Localize(ternary, nil) .. ": " .. Localize("/Lotus/Language/Menu/MainMenu_NewBuildAvailableInGame", nil)
	v26 = true
	return v54
end

local function fn64(data)
	local v54 = Localize(data.mDesc, nil)
	local v55 = ""

	if #data.mTypes > 0 or not __wf_atom_7e8ad928(data.mItemType) then
		v55 = (data.mBounty and "/Lotus/Language/Menu/Notification_Bounty" or v55) .. ": "
	end

	return Localize(v55, nil) .. v54
end

local function fn65(data)
	local v54 = Localize(data.mLocTag:c_str(), nil)
	local starChart = module3.GetStarChart()
	local __wf_atom_d5226f21 = starChart:__wf_atom_d5226f21(data.mNode)
	local v55 = Localize(__wf_atom_d5226f21.locTag:c_str(), nil)
	local rewardDesc = module3.GetRewardDesc(mMovie, data.mAttackerReward)
	local rewardDesc2 = module3.GetRewardDesc(mMovie, data.mDefenderReward)
	local v56 = Localize(starChart:__wf_atom_161b95d4()[__wf_atom_d5226f21.region + 1].name, nil)
	local v57 = Localize("/Lotus/Language/Menu/MissionBoard_InvasionRewardCompare", nil)
	return v54 .. ": " .. v55 .. " (" .. v56 .. ") - " .. (data.mFaction == 2 and "" or rewardDesc .. " " .. v57 .. " ") .. rewardDesc2
end

local function fn66(p)
	local v54 = Resource(p.mChallengeTypeRefID)
	local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(p.mEndDate)
	local v55 = Localize("/Lotus/Language/Menu/Notification_Expiry", nil)
	local v56 = string.format(v55, module3.GetTwitterStyleTime(__wf_atom_db2b0cee))
	return Localize(tostring(v54.mLocName), nil) .. ": " .. v56
end

function OnSyncInbox()
	if not __wf_atom_7e8ad928(mGameData) then
		local __wf_atom_153e689d = mGameData:__wf_atom_153e689d()

		if __wf_atom_153e689d > 0 and _T.gLastHighPriorityMessageCount ~= __wf_atom_153e689d then
			_T.gQueueMailbox = true
			_T.gLastHighPriorityMessageCount = __wf_atom_153e689d
		end
	end
end

local function fn67(p, p2)
	if _T.ShowNotification ~= nil then
		_T.ShowNotification(p, p2)
	end
end

local function fn68(mIds, list, p)
	if p ~= v14.BUILD then
		for i = #mIds, 1, -1 do
			__wf_atom_83c14687(0)
			local flag2 = true

			if p == v14.NEWS then
				for j = 1, #list do
					if v11[i].id ~= tostring(list[j].mId) then
						continue
					end

					flag2 = false
					break
				end
			else
				for j = 1, #list do
					if p == v14.PVPAFFECTOR then
					end

					local mId = tostring(list[j].mId)

					if mIds[i] ~= mId then
						continue
					end

					flag2 = false
					break
				end
			end

			if flag2 then
				table.remove(mIds, i)
			end
		end
	end

	local count = #mIds

	for i = 1, #list do
		__wf_atom_83c14687(0)
		local v54 = true

		if p == v14.PVPAFFECTOR then
		end

		local mId = tostring(list[i].mId)

		if p == v14.NEWS then
			local sec = list[i].mDate.sec

			for j = 1, count do
				if not (mId == v11[j].id and sec == v11[j].dateSec) then
					continue
				end

				v54 = false
				break
			end
		elseif p == v14.BUILD then
			v54 = true
		else
			for j = 1, count do
				if mId ~= mIds[j] then
					continue
				end

				v54 = false
				break
			end
		end

		if not v54 or __wf_atom_7e8ad928(mGameData) then
			continue
		end

		local v55 = 0
		local v56 = nil
		local v57 = nil

		if p == v14.NEWS then
			local v58 = #mIds + 1
			v11[v58] = {}
			v11[v58].id = mId
			v11[v58].dateSec = list[i].mDate.sec
		elseif p ~= v14.BUILD then
			mIds[#mIds + 1] = mId
		end

		if p == v14.ALERT then
			v56 = fn61(list[i])
			v55 = Engine.__wf_atom_db2b0cee(list[i].mActivation)
			v57 = "Alert"
		elseif p == v14.NEWS then
			v56 = fn62(list[i])
		elseif p == v14.GOAL then
			v56 = fn64(list[i])
			v55 = Engine.__wf_atom_db2b0cee(list[i].mActivation)
		elseif p == v14.INVASION then
			v56 = fn65(list[i])
			v55 = Engine.__wf_atom_db2b0cee(list[i].mActivation)
			v57 = "Invasion"
		elseif p == v14.BUILD then
			v56 = fn63()
			v55 = 0
			v57 = "NewBuild"
		elseif p == v14.PVPAFFECTOR then
			local v58 = list[i]

			if v58.mCategory == 3 then
				v56 = fn66(v58)
				local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v58.mStartDate)
				local __wf_atom_db2b0cee2 = Engine.__wf_atom_db2b0cee(v58.mEndDate)
				local v59 = __wf_atom_db2b0cee < 0 and 1 or __wf_atom_db2b0cee
				v55 = __wf_atom_db2b0cee2 < 0 and 0 or v59
				v57 = SF.__wf_atom_33553dd1(v58.mPVPMode)
			end
		end

		if not v56 then
			continue
		end

		if v55 > 0 then
			v17:AddTimer(v55, function()
				fn67(v56, v57)
			end)
		else
			fn67(v56, v57)
		end
	end
end

local function fn69()
	if mIsInFrontEnd or not (__wf_atom_7e8ad928(gGameRules) or gGameRules:InDojo()) then
		return
	end

	if v25 > 0 then
		local minutes = v25 * 5
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/MainMenu_NewBuildAvailableCountdown",
			false,
			{ MINUTES = minutes }
		)
		local v55 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_NewBuildAvailable", false) .. "\r\n\r\n" .. __wf_atom_8e9ac384
		module.ShowMessage(v55)
		v25 -= 1
	else
		local v54 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_NewBuildAvailable", false) .. "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/MainMenu_NewBuildAvailableKicked",
			false
		)
		module.ShowMessage(v54)
		v17:AddTimer(2, function()
			__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
			__wf_atom_a0f6588f:LogOut()
			Engine.Disconnect(false)
		end, false, nil)
	end
end

function OnSyncWorldState(p, _)
	if
		not p
		or __wf_atom_7e8ad928(mGameData)
		or __wf_atom_7e8ad928(gGameRules)
		or _T.DisableChatWorldStateNotifications
	then
		return
	end

	fn14()
	local __wf_atom_92662866 = mGameData:__wf_atom_92662866()

	if mCompletedFirstWorldSync then
		if not __wf_atom_7e8ad928(__wf_atom_92662866) then
			if v48 then
				fn68(v10, __wf_atom_92662866.mAlerts, v14.ALERT)
				fn68(v11, __wf_atom_92662866.mEvents, v14.NEWS)
				fn68(v12, __wf_atom_92662866.mGoals, v14.GOAL)
				fn68(v13, __wf_atom_92662866.mInvasions, v14.INVASION)
			end

			if __wf_atom_c67f9605:__wf_atom_6d03a710() then
				local v54 = {}
				table.insert(v54, { mId = MongoId() })
				fn68({}, v54, v14.BUILD)
				fn69()
			end
		end
	else
		if v48 then
			fn60(v10, __wf_atom_92662866.mAlerts, v14.ALERT)
			fn60(v11, __wf_atom_92662866.mEvents, v14.NEWS)
			fn60(v12, __wf_atom_92662866.mGoals, v14.GOAL)
			fn60(v13, __wf_atom_92662866.mInvasions, v14.INVASION)
		end

		mCompletedFirstWorldSync = true
	end
end

local function fn70(p)
	if __wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mProfileSettings) then
		return
	end

	fn10()
	mInitChannelInfo.Id = mProfileSettings:__wf_atom_18272b86()

	if mInitChannelInfo.Id == -1 then
		mInitChannelInfo.Id = v52.CHANNEL_QA
	end

	mInitChannelInfo.Set = true
	v28 = false
	local __wf_atom_7b64fd68 = __wf_atom_8e4fda44:__wf_atom_7b64fd68("TOGGLE_CHAT_WINDOW", false, false, false)

	for _, v55 in ipairs(__wf_atom_7b64fd68) do
		if not string.find(v55, "KEY_RETURN") then
			continue
		end

		v28 = true
		break
	end

	local __wf_atom_61850393 = mProfileSettings:__wf_atom_61850393()
	local emoticonConversion = mProfileSettings:EmoticonConversion()
	local v55 = false
		or mEmojiSettings.Enabled ~= __wf_atom_61850393
		or mEmojiSettings.EmoticonConversion ~= emoticonConversion
	mEmojiSettings.Enabled = __wf_atom_61850393
	mEmojiSettings.EmoticonConversion = emoticonConversion

	if mEmojiSettings.Enabled then
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 88, ":@[{")
	else
		mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 88, "@[{")
	end

	mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
	local __wf_atom_2d9acb55 = mProfileSettings:__wf_atom_2d9acb55()

	if not __wf_atom_7e8ad928(_G.UIMaterial_EmojiColors[__wf_atom_2d9acb55]) then
		mMovie:__wf_atom_83f8b076(_G.UIMaterial_EmojiColors[__wf_atom_2d9acb55])
	end

	mEnableRegionChat = mProfileSettings:__wf_atom_c4957d90()
	mEnableRecruitingChat = mProfileSettings:__wf_atom_16718f5a() and not _G.StalkerMode
	mEnableTradeChat = mProfileSettings:__wf_atom_99cc76ea() and not _G.StalkerMode
	mEnableQAChat = mProfileSettings:__wf_atom_b0360a9d() and not _G.StalkerMode
	mEnableCouncilChat = mProfileSettings:__wf_atom_200e5842()

	if not Engine.__wf_atom_fc67ba71() then
		mChatScale = mProfileSettings:__wf_atom_982dbb50()
	end

	if Engine.__wf_atom_2a979d69() then
		mChatScale = miOSChatScale
	end

	mChatWorldNotifications = mProfileSettings:__wf_atom_64954b7f()
	local __wf_atom_71cbcb69 = mProfileSettings:__wf_atom_71cbcb69()

	if v55 or mWindow.mShowTimeStamps == nil or mWindow.mShowTimeStamps ~= __wf_atom_71cbcb69 then
		mWindow.mShowTimeStamps = __wf_atom_71cbcb69

		for k, v56 in pairs(mWindow.mPanelList) do
			if __wf_atom_7e8ad928(v56) or k == mWindow.mActivePanelName then
				continue
			end

			v56:ClearHistory()
			v56:RefreshText()
		end

		if not __wf_atom_7e8ad928(mWindow.mPanelList[mWindow.mActivePanelName]) then
			mWindow.mPanelList[mWindow.mActivePanelName]:ClearHistory()
			mWindow.mPanelList[mWindow.mActivePanelName]:RefreshText()
		end
	end

	local __wf_atom_35ea3fce = mProfileSettings:__wf_atom_35ea3fce()

	if not __wf_atom_7e8ad928(__wf_atom_35ea3fce) then
		if __wf_atom_35ea3fce.regionId == 7 then
			DEFAULT_BREAK_MSG_PERIOD = v3.DEFAULT_BREAK_MSG_PERIOD

			if _G.LAST_BREAK_MSG == nil then
				_G.LAST_BREAK_MSG = __wf_atom_c4e218a2()
			end
		else
			DEFAULT_BREAK_MSG_PERIOD = nil
		end
	end

	mDoFilter = mProfileSettings:__wf_atom_bb0f4637()
	mDoMotdFilter = mDoFilter or v50 or Engine.__wf_atom_84bb79c2()
	local __wf_atom_caa573d0 = mProfileSettings:__wf_atom_caa573d0()

	if __wf_atom_caa573d0 ~= mTextSizeIndex or p then
		mTextSizeIndex = __wf_atom_caa573d0
		mWindow:SetFontSize(mTextSizeIndex)
	end

	mMovie:__wf_atom_433c28ce(__wf_atom_caa573d0 == 1)

	if not p then
		mWindow.mRegionChatEnabled = module.Ternary(mEnableRegionChat, nil, mWindow.mRegionChatEnabled)
		mWindow.mRecruitingChatEnabled = module.Ternary(mEnableRecruitingChat, nil, mWindow.mRecruitingChatEnabled)
		mWindow.mTradeChatEnabled = module.Ternary(mEnableTradeChat, nil, mWindow.mTradeChatEnabled)
		mWindow.mQAChatEnabled = module.Ternary(mEnableQAChat, nil, mWindow.mQAChatEnabled)
	end

	mInlinePrivateMessages = mProfileSettings:__wf_atom_4f2decd9()
	mActiveTabNotificationsOnly = mProfileSettings:__wf_atom_79aa2892()
	mMuteNotificationSounds = mProfileSettings:__wf_atom_e5adbd97()
end

function OnProfileSaved()
	fn70(false)
	fn58(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true)
end

function OnInitPresenceResync() end

local function fn71()
	local omegaCards = module3.GetOmegaCards()

	if not __wf_atom_7e8ad928(nil) then
		(nil):UpdateOmegaSuggestTree(omegaCards)
	end
end

function UpdateOmegaSuggestTree()
	fn71()
end

local function fn72(p)
	if __wf_atom_7e8ad928(mGameData) then
		return
	end

	local inventory = mGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):UpdateModularSuggestTree(inventory, p)
	end
end

function UpdateModularSuggestTree(p)
	fn72(p)
end

local function fn73()
	mGameRules = gGameRules
	mIsInGameplay = not __wf_atom_7e8ad928(mGameRules) and module3.IsInMissionOrDojo()
	mIsInFrontEnd = not mIsInGameplay
	mUIMode = module3.GetUIMode()
	mIsInPVP = mUIMode ~= module3.UI_MODE_IN_DOJO
		and not __wf_atom_7e8ad928(mGameRules)
		and mGameRules:IsPvpEnabled()
		and mGameRules:__wf_atom_cf2a28e8() ~= 5
	mIsInDojo = mUIMode == module3.UI_MODE_IN_DOJO
end

local function fn74()
	local v54 = __wf_atom_d99ae0ec(__wf_atom_8e4fda44:__wf_atom_8aadd5c9())
	v19 = StringSplit(",", v54)

	for i = #v19, 1, -1 do
		local v55 = v9[v19[i]]

		if v55 == nil or v55.RequirementsMet() then
			v19[i] = ":" .. v19[i] .. ":"
		else
			table.remove(v19, i)
		end
	end

	table.sort(v19, function(a, b)
		return a < b
	end)
end

function Initialize()
	mMovie:__wf_atom_7df746cd(0)
	mMovie:__wf_atom_433c28ce(false)
	_G.mDoNotDisturb = false
	v50 = Engine.__wf_atom_578fc9dd()
	local module16 = require("Lotus.Interface.Libs.TimerMgr")
	v17 = module16.CreateTimerMgr()
	fn73()
	v48 = module3.HasCompletedVorsPrize()
	mMovie:SetFocusedCallbacks("Window.SendMessageBar.MessageBox", "MessageBoxFocused", "MessageBoxUnfocused", nil, nil)
	mMovie:SetCallbacks("Window.SendMessageBar.FocusButton", nil, nil, "SendMessageBarClicked", nil)
	mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.MessageBox", 98, true)
	mMovie:SetCallbacks("Window.MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	mMovie:__wf_atom_976dcedd("Window.MouseCatcherBtn", "noMenuSelection", true)
	mMovie:__wf_atom_976dcedd("Window.TabMenu.WindowTitle.Fill", "noMenuSelection", true)
	v23 = module12.Create()
	table.insert(v23.mMoviesToSync, clanMovie)
	table.insert(v23.mMoviesToSync, friendsMovie)
	table.insert(v23.mMoviesToSync, WeakResource("/Lotus/Interface/InvitePanel.swf"))
	table.insert(v23.mMoviesToSync, module.GetChatMovie())
	fn74()

	if not (Engine.__wf_atom_fc67ba71() or Engine.__wf_atom_2a979d69()) then
		v18 = __wf_atom_8e4fda44:FindMovie(IMEOverlayMovie)

		if __wf_atom_7e8ad928(v18) and not __wf_atom_7e8ad928(IMEOverlayMovie) then
			v18 = mMovie:PushChildMovie(IMEOverlayMovie)
		end
	end

	mGameData = nil
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		mGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()
		mProfileSettings = __wf_atom_18a5d83b:Settings()
		mCrossPlatformEnabled = __wf_atom_18a5d83b:__wf_atom_7f395d54()

		if mCrossPlatformEnabled then
			v16 ..= "#"
		end
	end

	if not __wf_atom_7e8ad928(mGameData) then
		mGameData:GetInventory()
	end

	v15.OmegaSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.OMEGA_STRING_LOC, false))
	v15.StepSequencerPrefixString = mMovie:__wf_atom_8e9ac384(v15.STEP_SEQUENCER_STRING_PREFIX, false)
	v15.StepSequencerSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.STEP_SEQUENCER_STRING_LOC, false))
	v15.ZawPrefixString = mMovie:__wf_atom_8e9ac384(v15.ZAW_STRING_PREFIX, false)
	v15.ZawSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.ZAW_STRING_LOC, false))
	v15.AmpPrefixString = mMovie:__wf_atom_8e9ac384(v15.AMP_STRING_PREFIX, false)
	v15.AmpSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.AMP_STRING_LOC, false))
	v15.MoaPetPrefixString = mMovie:__wf_atom_8e9ac384(v15.MOA_PET_STRING_PREFIX, false)
	v15.MoaPetSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.MOA_PET_STRING_LOC, false))
	v15.KDrivePrefixString = mMovie:__wf_atom_8e9ac384(v15.KDRIVE_STRING_PREFIX, false)
	v15.KDriveSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.KDRIVE_STRING_LOC, false))
	v15.KitgunPrefixString = mMovie:__wf_atom_8e9ac384(v15.KITGUN_STRING_PREFIX, false)
	v15.KitgunSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.KITGUN_STRING_LOC, false))
	v15.AppearancePrefixString = mMovie:__wf_atom_8e9ac384(v15.APPEARANCE_STRING_PREFIX, false)
	v15.AppearanceSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.APPEARANCE_STRING_LOC, false))
	v15.ModConfigPrefixString = mMovie:__wf_atom_8e9ac384(v15.MOD_CONFIG_STRING_PREFIX, false)
	v15.ModConfigSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.MOD_CONFIG_STRING_LOC, false))
	v15.ShawzinPrefixString = mMovie:__wf_atom_8e9ac384(v15.SHAWZIN_STRING_PREFIX, false)
	v15.ShawzinSearchable = __wf_atom_d99ae0ec(mMovie:__wf_atom_8e9ac384(v15.SHAWZIN_STRING_LOC, false))
	fn71()
	fn72(0)
	fn72(1)
	fn72(6)
	fn72(7)
	fn72(2)
	v20[":angry:"] = ">:%("
	v20[":awe:"] = ":o,:O"
	v20[":awkward:"] = ":|"
	v20[":cool:"] = "8%)"
	v20[":heart:"] = "<3"
	v20[":heartbroken:"] = "</3"
	v20[":kiss:"] = ":%*"
	v20[":laugh:"] = "XD"
	v20[":satisfied:"] = ":D"
	v20[":nerd:"] = "8|"
	v20[":sad:"] = ":%("
	v20[":sadcry:"] = ":'%("
	v20[":shock:"] = "o.O,O.o"
	v20[":smile:"] = ":%)"
	v20[":suspicion:"] = ":\\,:/"
	v20[":tongue:"] = ":P"
	v20[":wink:"] = ";%)"

	if not (Engine.__wf_atom_fc67ba71() or __wf_atom_7e8ad928(mProfileSettings)) then
		mChatScale = mProfileSettings:__wf_atom_982dbb50()
	end

	if Engine.__wf_atom_2a979d69() then
		mChatScale = miOSChatScale
	end

	fn58(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v17:AddTimer(2, function()
		v27 = true
	end)
	mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel.ScrollBar", 12, 0)
	mMovie:__wf_atom_dac78d3d(true)
	mWindow = fn56("Window")
	mWindow.mVisualMode = module.Ternary(
		not __wf_atom_7e8ad928(_T.UIInputEnabled) and _T.UIInputEnabled,
		mWindow.VISUAL_MODE_MENU_SIMPLE,
		mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
	)

	if __wf_atom_72884638("Lotus.EnableTraceLogging") then
		print("InitChatVisualMode: " .. mWindow.mVisualMode)
	end

	mWindow:Initialize(10, 400, 460, 240)
	mMovie:__wf_atom_50d60589("Window.SendMessageBar.MessageBox", 36, "")
	fn59()
	module3.InitializeContextMenu(mMovie)

	if not Engine.IsPlayingWithController() then
		mMovie:__wf_atom_b4ffb30f(true)
	end

	mInitialized = true
	mInputBlocked = false
	fn70(true)
	mMovie:__wf_atom_0b73c540(true)
	fn14()
	local __wf_atom_18a5d83b2 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b2) then
		__wf_atom_55142dd4(__wf_atom_18a5d83b2:__wf_atom_9be88b01(), "OnProfileSaved")
	end

	if not __wf_atom_7e8ad928(mGameData) then
		mGameData:__wf_atom_0d091b56("OnSyncWorldState", CALLBACK_IDENTIFIER, false)
	end

	_T.ChatOnSubScreenChanged = fn49
	_T.ChatReinit = false

	if not Engine.__wf_atom_2a979d69() then
		return
	end

	mMovie:__wf_atom_2dedec1a("Window.TabMenu.WindowTitle", 67, false)
end

function ContextMenuFrameRollOut() end

function ContextMenuRollOut() end

function ContextMenuRelease(p)
	if p == "undefined" then
		return
	end

	local mListItem = _T.ContextMenu.mListItems[tonumber(p)]

	if __wf_atom_7e8ad928(mListItem) then
		return
	end

	local pressedCallback = mListItem:PressedCallback()

	if __wf_atom_7e8ad928(pressedCallback) or pressedCallback then
		_T.ContextMenu:Hide()
	end
end

local function fn75(user)
	if __wf_atom_7e8ad928(user) and not __wf_atom_7e8ad928(elementById) then
		user = elementById.User
	end

	if not __wf_atom_7e8ad928(user) then
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if not __wf_atom_7e8ad928(__wf_atom_7190444e) then
			v5.From = user
			__wf_atom_7190444e:__wf_atom_496d6987(user, "PrivateConvoPlayerIDResultOutgoing")
		end

		if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			fn2()
		end
	end
end

function TalkToPlayer(p)
	local v54 = fn28(p, nil, nil, true)

	if __wf_atom_7e8ad928(v54) then
		fn75(p)
		return
	end

	mWindow:SetActive(v54)

	if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
		fn2()
	end
end

fn9 = function(p)
	local v54 = module6.CheckGameInvitePermission(nil, p)

	if v54 then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(v54, false))
	elseif not __wf_atom_7e8ad928(mInvitedUser) then
		print("Warning: existing invited user not yet handled")
	elseif __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
		if
			__wf_atom_7e8ad928(gGameRules)
			or not (gGameRules:IsA(__wf_atom_589d05aa) and gGameRules:__wf_atom_72fc675e().soloMode)
		then
			mInvitedUser = p
			module6.HostSquadSession("SendInvite")
		else
			module.ShowMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GameInvitesDisabled", false))
		end
	else
		mInvitedUser = p
		SendInvite()
	end
end

function SendInvite()
	if __wf_atom_7e8ad928(mInvitedUser) then
		return
	end

	mInvitedUser2 = mInvitedUser
	mGameData:__wf_atom_6a4bcc2b(mInvitedUser, true, "GameInvitePlayerIDResults")
	mInvitedUser = nil
end

function InviteUser(p)
	fn9(p)
end

local function fn76()
	if __wf_atom_7e8ad928(elementById) then
		return
	end

	fn9(elementById.User)
end

local function fn77(p, p2)
	if p2 then
		if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			fn2(false)
		elseif mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE then
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		end
	end

	local v54 = p == nil and "" or p
	local v55 = string.gsub(v54, "!", ",")
	local v56 = fn5(true, v55)

	if #v56 == 1 then
		local v57 = v56[1]

		if not (__wf_atom_7e8ad928(v57.AccountId) or __wf_atom_7e8ad928(v57.Name)) then
			local v58 = fn28(v57.Name, v57.AccountId, v57.IsCrossSave)

			if not (__wf_atom_7e8ad928(v58) or v58.mIsActive) then
				mWindow:SetActive(v58)
			end
		end
	end
end

function WhisperPlayer(p)
	fn77(p, true)
end

function EnteringTrade(p)
	fn77(p, false)
end

function EnteringMenu()
	if mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL then
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_SIMPLE, true)
	end
end

function ExitingMenu()
	if v6 == 1 then
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE, true)
	end
end

function EnableInput()
	if
		mWindow
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_SIMPLE, true)
	end
end

local function fn78(p)
	if not __wf_atom_7e8ad928(mWindow) then
		if p == nil then
			p = false
		end

		if
			mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
			or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
		then
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_FULL, p)
		else
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE, p)
		end
	end
end

function DisableInput()
	fn78(true)
end

local function fn79(mChannelName, p)
	local v54 = ""

	if __wf_atom_7e8ad928(mChannelName) then
		local activePanel = mWindow:GetActivePanel()

		if not __wf_atom_7e8ad928(activePanel) then
			v54 = string.sub(activePanel.mChannelName, 2, -1)
			mWindow:OnChannelStateChanged(mWindow.CHANNEL_EXIT, "#" .. activePanel.mChannelName, "", nil, nil, p)
		end
	else
		mWindow:OnChannelStateChanged(mWindow.CHANNEL_EXIT, "#" .. mChannelName, "", nil, nil, p)
		v54 = string.sub(mChannelName, 2, -1)
	end

	if not __wf_atom_7e8ad928(mGameData) then
		mGameData:__wf_atom_daf43580(v54)
	end
end

local function fn80()
	for _, v54 in pairs(mWindow.mPanelList) do
		if string.sub(v54.mChannelName, 1, 1) ~= mWindow._getPrivateChatChannelPrefix() then
			continue
		end

		fn79(v54.mChannelName, true)
	end

	mWindow.mTabMenu.mInitialX = 0
	mWindow.mTabMenu:Redraw(nil, true, true)
end

function CloseAllConvos()
	fn80()
end

local v54 = nil

function OnGuildChanges(p, p2)
	if __wf_atom_7e8ad928(mGameData) then
		return
	end

	if p then
		if v54 ~= nil then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/OrderInvite_Success", false, {
				PLAYER_NAME = v54
			}))
		end
	else
		local addToGuildErrorMsg = module.ParseAddToGuildErrorMsg(p2)
		print("FAILURE: " .. p2)
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(addToGuildErrorMsg, false))
	end

	v54 = nil
end

local function fn81(user)
	if __wf_atom_7e8ad928(mGameData) then
		return
	end

	v54 = user
	mGameData:__wf_atom_4773d482(user, "OnGuildChanges")

	if not __wf_atom_7e8ad928(mWindow) and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
		mWindow:SetVisualMode(mWindow.VISUAL_MODE_MENU_FULL)
	end
end

local function fn82()
	if not __wf_atom_7e8ad928(elementById) then
		fn81(elementById.User)
	end
end

function ViewXBLiveAccountIdResult(p, p2)
	if not p then
		return
	end

	gMatchingService:__wf_atom_5d789280(p2)
end

local function fn83(data)
	_T.SelectedProfileId = data.AccountId
	_T.SelectedProfileName = data.Name
	_T.SelectedProfileIsCrossSave = data.IsCrossSave
	_T.SelectedProfileImage = nil
	_T.OpenScreenAsync("Profile")

	if Engine.__wf_atom_2a979d69() then
		fn31()
	end
end

local function fn84(p)
	if p ~= nil then
		fn83(p)
	end
end

function ViewWarframeProfileAccountIdResult(p, p2)
	local mPendingProfileName2 = mPendingProfileName
	mPendingProfileName = nil

	if p then
		local v55, _, _ = fn5(p, p2, false)

		for i = #v55, 1, -1 do
			local v56 = v55[i]

			if v56.WasInCachedList then
				continue
			end

			local __wf_atom_640a4779 = Engine.__wf_atom_640a4779(v56.Platform, v56.Name)
			local v57 = string.lower(__wf_atom_640a4779)
			local v58 = false

			for _, v60 in pairs(mWindow.mPanelList) do
				if v60.mUserList[v57] == nil then
					continue
				end

				v58 = true
				break
			end

			if not (v58 or gGameData:__wf_atom_2b71f867({ __wf_atom_640a4779 }, 1) == "") or v58 then
				continue
			end

			v55[i] = nil
		end

		if #v55 == 0 then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/NoOnlineUser", false, {
				USER = mPendingProfileName2
			}))
		end

		if __wf_atom_7e8ad928(_T.OpenScreenAsync) or #v55 == 0 then
			return
		end

		if #v55 == 1 then
			fn83(v55[1])
		else
			fn6(v55, fn84)
		end
	else
		print("FAILURE: " .. p2)

		if not __wf_atom_7e8ad928(mWindow) then
			local activePanel = mWindow:GetActivePanel()

			if not __wf_atom_7e8ad928(activePanel) then
				activePanel:SystemMessage(mMovie:__wf_atom_8e9ac384(module.ParseConnectionErrorMsg(p2), false))
			end
		end
	end
end

local function fn85()
	if fn17("/Lotus/Language/Menu/Chat_LoadingScreenBlocked") or __wf_atom_7e8ad928(mGameData) then
		return
	end

	if not (__wf_atom_7e8ad928(elementById) or __wf_atom_7e8ad928(elementById.User)) then
		local user = elementById.User
		local activePanel = mWindow:GetActivePanel()
		local v55 = __wf_atom_7e8ad928(activePanel) and "" or activePanel.mChannelName

		local function fn86(p)
			fn49(false)
			local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

			if
				p ~= nil
				and p == "OffensiveName"
				and not __wf_atom_7e8ad928(__wf_atom_7190444e)
				and fn51(v55)
				and __wf_atom_7190444e:__wf_atom_f5faa72a("#" .. v55)
			then
				__wf_atom_7190444e:Ban(user, "", "1m", 1, "OffensiveName", "")
			end
		end

		module13.ShowReportMenu(mMovie, user, fn86)
		fn49(true)
	end
end

local function fn86(value, p, p2, p3)
	local ternary = module.Ternary(p3 ~= nil, p3, mWindow:GetActivePanel())
	local v55 = false

	if p3 == nil then
		if type(value) == "string" then
			local v56 = StringSplit("|", value)
			local reason = (not (#v56 > 1) or __wf_atom_7e8ad928(ternary) or ternary.mChatHistory[tonumber(v56[2])] == nil)
				and ""
				or "#" .. ternary.mChannelName
			elementById = {
				Id = 1,
				User = v56[1],
				UserLower = string.lower(v56[1]),
				Reason = reason
			}
			v55 = true
		else
			elementById = mWindow.mUserPanel.mListControl:GetElementById((tonumber(value)))
		end
	else
		local user = string.sub(ternary.mChannelName, 2)
		elementById = {
			Id = 1,
			User = user,
			UserLower = string.lower(user),
			Channel = ternary.mChannelName
		}
	end

	if __wf_atom_7e8ad928(ternary) or elementById == nil then
		return
	end

	local user = elementById.User
	local v56 = user == mWindow.mUser or v55 and mWindow.mUserSuffixed == user

	if v56 then
		return
	end

	local v57 = __wf_atom_7e8ad928(gGameData)
	local v58 = not v57 and gGameData:__wf_atom_6c1f42ce(user)
	local v59 = not v57 and gGameData:__wf_atom_5ff594a3() ~= MongoId()
	local v60 = not v57 and gGameData:__wf_atom_290608cb(user)
	mContextMenu:RemoveElements(true, true)

	if not (v56 or Engine.__wf_atom_fc67ba71() and fn16()) then
		if string.sub(ternary.mChannelName, 1, 1) == mWindow._getPrivateChatChannelPrefix() then
			if not __wf_atom_7e8ad928(p3) or Engine.IsPlayingWithController() then
				mContextMenu:AddElement(
					{
						Name = "/Lotus/Language/Menu/SocialOverlay_CloseFriendsTabBtn",
						PressedCallback = fn79,
						callbackParam = ternary.mChannelName
					},
					true
				)
				mContextMenu:AddElement(
					{
						Name = "/Lotus/Language/Menu/SocialOverlay_CloseAllFriendTabsBtn",
						PressedCallback = fn80
					},
					true
				)
			end
		else
			mContextMenu:AddElement(
				{ Name = "/Lotus/Language/Menu/Chat_ContextMenu_Talk", PressedCallback = fn75 },
				true
			)
		end
	end

	if ternary.mHasAccount == nil or ternary.mHasAccount then
		if __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) or module6.ShowInviteCommand() then
			mContextMenu:AddElement(
				{
					Name = "/Lotus/Language/Menu/SocialOverlay_ContextInvite",
					PressedCallback = fn76
				},
				true
			)
		end

		local v61 = Engine.__wf_atom_940f8971(user) ~= Engine.__wf_atom_63bb2bc6()
		local mCrossPlatformEnabled = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_bdc99e61()
			and mCrossPlatformEnabled

		if not v61 or mCrossPlatformEnabled then
			if not v58 then
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/SocialOverlay_AddFriend",
					PressedCallback = function()
						module3.AddFriend(user, "OnAddFriendResultToDialog")
					end
				}, true)
			end

			local v62 = not v61 or mGameData:__wf_atom_4fb36ef5()

			if v59 and not v60 and not v57 and gGameData:__wf_atom_4a5a45f5(2) and v62 then
				mContextMenu:AddElement(
					{
						Name = "/Lotus/Language/Menu/SocialOverlay_OrderInvite",
						PressedCallback = fn82
					},
					true
				)
			end
		end

		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()
		local v62 = "#" .. ternary.mChannelName

		if
			ternary.mUserList[string.lower(user)] ~= nil
			and not __wf_atom_7e8ad928(__wf_atom_7190444e)
			and __wf_atom_7190444e:__wf_atom_f5faa72a(v62)
			and __wf_atom_7190444e:__wf_atom_b98abc13(v62, user) == 0
		then
			if fn51(ternary.mChannelName) then
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/Chat_ContextMenu_Flush",
					PressedCallback = function(p4)
						return fn47(p4, ternary.mChannelName)
					end
				}, true)
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/Chat_ContextMenu_Kick",
					PressedCallback = function(p4)
						return fn48(p4, ternary.mChannelName)
					end
				}, true)
				mContextMenu:AddElement(
					{ Name = "/Lotus/Language/Menu/Chat_ContextMenu_Ban", PressedCallback = fn50 },
					true
				)
			else
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/Chat_ContextMenu_SimpleKick",
					PressedCallback = function(p4)
						fn45(p4, false, false, "5m")
					end
				}, true)
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/Chat_ContextMenu_Ban1H",
					PressedCallback = function(p4)
						fn45(p4, false, false, "1h")
					end
				}, true)
				mContextMenu:AddElement({
					Name = "/Lotus/Language/Menu/Chat_ContextMenu_Ban1D",
					PressedCallback = function(p4)
						fn45(p4, false, false, "1d")
					end
				}, true)
			end
		end

		mContextMenu:AddElement({
			Name = "/Lotus/Language/Menu/SocialOverlay_ReportPlayer",
			PressedCallback = function(_)
				fn85()
			end
		}, true)
	end

	fn23(p, p2)
end

local function fn87()
	mInputBlocked = true
end

function Close()
	fn87()
end

local function fn88()
	local v55

	if _T.HideChat == nil then
		v55 = false
	else
		v55 = _T.HideChat > 0
	end

	if mChatHidden == v55 then
		return
	end

	mChatHidden = v55

	if mChatHidden then
		fn31()
	end

	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { module.Ternary(v55, 0, 100) }, 0.2)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not mInitialized then
		return
	end

	local v55 = __wf_atom_fa1258d0()
	local v56 = __wf_atom_c4e218a2()

	if mGameRules ~= gGameRules and not __wf_atom_7e8ad928(gGameRules) then
		fn73()
		mWindow:SetInitWindowSize()
		mWindow:SetInitWindowPosition()
	end

	mWindow:Update(v55)
	fn88()

	if __wf_atom_7e8ad928(_T.ChatReinit) then
		__wf_atom_6302a0bf()
		fn78()
		_T.ChatOnSubScreenChanged = fn49
		_T.ChatReinit = false
	end

	mMovie:__wf_atom_88d9cd84(v55)

	if not __wf_atom_7e8ad928(v17) then
		v17:Update(v55)
	end

	if not __wf_atom_7e8ad928(v23) then
		v23:Update(v56)
	end

	if not __wf_atom_7e8ad928(mGameData) and v24 then
		v24 = false
		mGameData:__wf_atom_df6df879("OnLitePresenceUpdated", false)
	end

	if DEFAULT_BREAK_MSG_PERIOD ~= nil then
		local v57 = v56 - _G.LAST_BREAK_MSG

		if DEFAULT_BREAK_MSG_PERIOD <= v57 then
			mWindow:SystemMessage((mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/BreakAdvice", false)))
			_G.LAST_BREAK_MSG = v56
		end
	end

	if __wf_atom_7e8ad928(_T.ContextMenu) then
		module3.InitializeContextMenu(mMovie)
	end

	module7.UpdateStepSequencer(v15.StepSequencerLoader)
	module15.Update(v18)

	if Engine.__wf_atom_2a979d69() and mFocusTabDownStart and v56 - mFocusTabDownStart > 0.25 then
		local focusedElement = mWindow.mTabMenu:GetFocusedElement()

		if
			not __wf_atom_7e8ad928(focusedElement)
			and string.sub(focusedElement.ChannelName, 1, 1) == mWindow._getPrivateChatChannelPrefix()
		then
			local v57 = mWindow.mPanelList[focusedElement.ChannelName]

			if v57 ~= nil then
				fn86(nil, nil, nil, v57)
			end
		end

		mFocusTabDownStart = nil
	end
end

function SetGameplayVisualMode()
	if not Engine.IsPlayingWithController() and mWindow ~= nil then
		fn78()
	end
end

function ToggleFocus()
	if
		Engine.__wf_atom_fc67ba71()
		and (_T.IsButtonBarInputBlocked and _T.IsButtonBarInputBlocked() and not (_T.SpectatorHudOpen or _T.TRADING_POST_OPEN) or not __wf_atom_7e8ad928(v44))
	then
		return
	end

	v29 = true

	if not __wf_atom_7e8ad928(mWindow) then
		if mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE then
			mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_FULL)
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				__wf_atom_18a5d83b:__wf_atom_b2098de3(0)
			end
		elseif mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				__wf_atom_18a5d83b:__wf_atom_b2098de3(0)
			end

			fn2()
		elseif Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69() then
			if mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL then
				fn24()
				mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE)
			elseif mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
				fn31()
			end
		end
	end
end

local function fn89(p)
	if __wf_atom_7e8ad928(mWindow.mTabMenu) or #mWindow.mTabMenu.mElements <= 1 then
		return
	end

	fn24()
	mWindow:cycleActiveTab(p)
	local v55, v56

	if Engine.IsPlayingWithController() then
		v55 = "Window.TabMenu.LeftBumper"
		v56 = "Window.TabMenu.RightBumper"
	else
		v55 = "Window.TabMenu.LeftArrow"
		v56 = "Window.TabMenu.RightArrow"
	end

	if Engine.IsPlayingWithController() then
		if p == module.DECREMENT then
			module.CreateParticles(mMovie, v55, _G.UIFx_ConsolePress, 0, 4)
		else
			module.CreateParticles(mMovie, v56, _G.UIFx_ConsolePress, 0, 4)
		end
	end
end

function LeftArrowFocused()
	mWindow.mLeftArrowFocused = true
	mMovie:__wf_atom_e57658c2("Window.TabMenu.LeftArrow", 12, 100)
end

function LeftArrowUnfocused()
	mWindow.mLeftArrowFocused = false
	mMovie:__wf_atom_e57658c2("Window.TabMenu.LeftArrow", 12, 50)
end

function LeftArrowClicked()
	fn89(module.DECREMENT)
end

function RightArrowFocused()
	mWindow.mRightArrowFocused = true
	mMovie:__wf_atom_e57658c2("Window.TabMenu.RightArrow", 12, 100)
end

function RightArrowUnfocused()
	mWindow.mRightArrowFocused = false
	mMovie:__wf_atom_e57658c2("Window.TabMenu.RightArrow", 12, 50)
end

function RightArrowClicked()
	fn89(module.INCREMENT)
end

function MinMaxBtnFocused()
	if not Engine.__wf_atom_2a979d69() then
		mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn.Icon", 12, 100)
	end

	module.PlaySound(_G.UISound_Focus)
end

function MinMaxBtnUnfocused()
	if not Engine.__wf_atom_2a979d69() then
		mMovie:__wf_atom_e57658c2("Window.TabMenu.MinMaxBtn.Icon", 12, 50)
	end
end

function MinMaxBtnClicked()
	if not mInputBlocked then
		if fn33() then
			fn2(false)
		else
			fn4()
		end
	end
end

function onKeyDown_MENU_LEFT_FROM_ANALOG()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
	then
		return true
	end
end

function onKeyDown_MENU_RIGHT_FROM_ANALOG()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
	then
		return true
	end
end

local function fn90()
	local __wf_atom_94bf489f = mMovie:__wf_atom_94bf489f()
	return not __wf_atom_7e8ad928(__wf_atom_94bf489f) and __wf_atom_94bf489f == "MessageBox"
end

function onKeyDown_MENU_SELECT()
	if
		(Engine.IsPlayingWithController() or not fn90())
		and (not Engine.IsPlayingWithController() or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL)
	then
		return
	else
		return true
	end
end

function onKeyUp_MENU_SELECT()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		or not Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL and fn90()
	then
		return true
	end
end

function ScreenStackUpdated(p)
	if not __wf_atom_7e8ad928(p) then
		v6 = tonumber(p)
		local __wf_atom_1dca1cfb = __wf_atom_8e4fda44:__wf_atom_1dca1cfb()

		if
			not __wf_atom_7e8ad928(__wf_atom_1dca1cfb)
			and not __wf_atom_7e8ad928(mMovie)
			and __wf_atom_1dca1cfb ~= mMovie
			and __wf_atom_1dca1cfb:__wf_atom_7fc4c74c() >= mMovie:__wf_atom_7fc4c74c()
			and not fn33()
			and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
			and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
		then
			fn31()
		end
	end
end

fn4 = function()
	if mMovie:__wf_atom_a91463a8("ContextMenu", 13) then
		fn24()
		return
	end

	if mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL then
		fn31()
		return
	end

	mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE)
	module.PlaySound(_G.UISound_WindowClose)
end

function onKeyDown_MENU_CANCEL()
	if
		mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
		or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return true
	end
end

function onKeyUp_MENU_CANCEL()
	if
		mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return
	end

	if not mInputBlocked then
		fn4()
	end

	return true
end

function OSKSendMessageCallback(p, p2)
	if not p then
		mWindow:OnMessageSent(p2)
	end
end

function SendMessageCallback(p, p2)
	if not __wf_atom_7e8ad928(p) and tonumber(p) == 4 then
		mWindow:OnMessageSent(p2)
	end
end

function SendMessageWithOSK()
	if Engine.IsPlayingWithController() then
		module13.ShowInputDialog(
			mMovie,
			"/Lotus/Language/Menu/SocialOverlay_Btn",
			mMovie:__wf_atom_387f260e("Window.SendMessageBar.MessageBox", 36),
			0,
			"SendMessageCallback",
			"OSKSendMessageCallback",
			{ isMultiline = false, cancelDisabled = false, forChat = true, doFilter = false }
		)
	end
end

function onKeyDown_MENU_GENERIC1()
	if
		not Engine.IsPlayingWithController()
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return
	end

	if
		not mInputBlocked
		and not __wf_atom_7e8ad928(mWindow.mInputPanel)
		and mMovie:__wf_atom_a91463a8(mWindow.mInputPanel.mClipPath, 13)
	then
		mMovie:Execute("SendMessageWithOSK", "")
	end

	return true
end

function onKeyUp_MENU_GENERIC1()
	if Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
		return true
	end
end

function onKeyDown_MENU_GENERIC2()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		and not mInputBlocked
	then
		return true
	end
end

function onKeyUp_MENU_GENERIC2()
	if Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
		return true
	end
end

function onKeyUp_MENU_LTHUMB()
	if Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
		return true
	end
end

function onKeyDown_MENU_LTHUMB()
	if
		Engine.IsPlayingWithController()
		and not __wf_atom_7e8ad928(hyperlinkSelectionMovie)
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		and not mInputBlocked
	then
		if fn17("/Lotus/Language/Menu/Chat_LoadingScreenBlocked") then
			return
		end

		local activePanel = mWindow:GetActivePanel()

		if not __wf_atom_7e8ad928(activePanel) then
			local result = {}

			for i = #activePanel.mLineLog, 1, -1 do
				if not (#activePanel.mLineLog[i].hyperLinks > 0) then
					continue
				end

				table.insert(result, {
					Text = activePanel.mLineLog[i].text,
					Hyperlinks = activePanel.mLineLog[i].hyperLinks
				})

				if #result == 10 then
					break
				end
			end

			if #result > 0 then
				v46 = mMovie:PushChildMovie(hyperlinkSelectionMovie)

				function _T.GetMessagesWithHyperlinks()
					return result
				end

				v46:Execute("SetElementsFunction", "GetMessagesWithHyperlinks")

				function _T.OnHyperlinkSelectionClosed()
					_T.GetMessagesWithHyperlinks = nil
					_T.OnHyperlinkSelectionClosed = nil

					if __wf_atom_7e8ad928(v44) then
						fn49(false)
					end
				end

				v46:Execute("SetOnCloseFunction", "OnHyperlinkSelectionClosed")
				fn49(true)
			end
		end
	end
end

function onKeyUp_MENU_RTHUMB()
	if Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
		return true
	end
end

function onKeyDown_MENU_RTHUMB()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		and not mInputBlocked
		and not mMovie:__wf_atom_a91463a8("ContextMenu", 67)
		and not __wf_atom_7e8ad928(mWindow.mUserPanel)
		and mWindow.mUserPanel.mIsExpanded
		and mWindow.mUserPanel.mListControl.mIsVisible
	then
		fn55()
	end
end

function onKeyDown_MENU_LTRIGGER2()
	if
		not Engine.IsPlayingWithController()
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return
	end

	if not mInputBlocked then
		fn89(module.DECREMENT)
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if
		not Engine.IsPlayingWithController()
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return
	end

	if not mInputBlocked then
		fn89(module.INCREMENT)
	end

	return true
end

function onKeyUp_MENU_RTRIGGER1()
	if Engine.IsPlayingWithController() and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL then
		return true
	end
end

function onKeyDown_MENU_RTRIGGER1()
	if
		Engine.IsPlayingWithController()
		and (mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL)
		and not (mInputBlocked or mMovie:__wf_atom_a91463a8("ContextMenu", 67))
	then
		if mWindow.mUserPanel.mEmoteGrid.mIsVisible then
			mWindow.mUserPanel:ToggleListVis(true)
		elseif mWindow.mUserPanel.mListControl.mIsVisible then
			mWindow.mUserPanel:ToggleListVis(true)
		else
			mWindow.mUserPanel:ToggleListVis(false)
		end

		module.CreateParticles(mMovie, "Window.SendMessageBar.EmojiBtn.Callout", _G.UIFx_ConsolePress, 0, 0)
	end
end

local function fn91()
	if
		__wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or not mWindow.mUserPanel.mIsExpanded
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		return false
	end

	local v55 = mWindow.mWindow.x + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 0) + mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 0)
	local v56 = mWindow.mWindow.y + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 1) + mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 1)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if Engine.__wf_atom_2a979d69() then
		__wf_atom_5e6e15c8 *= miOSChatScale
		__wf_atom_5e6e15c8_2 *= miOSChatScale
	end

	if
		v55 <= __wf_atom_5e6e15c8_3
		and __wf_atom_5e6e15c8_3 <= v55 + __wf_atom_5e6e15c8
		and v56 <= __wf_atom_5e6e15c8_4
		and __wf_atom_5e6e15c8_4 <= v56 + __wf_atom_5e6e15c8_2
	then
		return true
	end

	return false
end

local function fn92(focusedElement)
	if
		__wf_atom_7e8ad928(mWindow)
		or __wf_atom_7e8ad928(focusedElement)
		or __wf_atom_7e8ad928(focusedElement.mClipName)
	then
		return false
	end

	local v55 = mWindow.mWindow.x + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 0) + mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 0) + mMovie:__wf_atom_5e6e15c8(
		"Window.UserPanel.Panel.UserList",
		0
	) + mMovie:__wf_atom_5e6e15c8(focusedElement.mClipName, 0) + mMovie:__wf_atom_5e6e15c8(
		focusedElement.mClipName .. ".Btn",
		0
	)
	local v56 = mWindow.mWindow.y + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 1) + mMovie:__wf_atom_5e6e15c8("Window.UserPanel.Panel", 1) + mMovie:__wf_atom_5e6e15c8(
		"Window.UserPanel.Panel.UserList",
		1
	) + mMovie:__wf_atom_5e6e15c8(focusedElement.mClipName, 1) + mMovie:__wf_atom_5e6e15c8(
		focusedElement.mClipName .. ".Btn",
		1
	)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(focusedElement.mClipName .. ".Btn", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(focusedElement.mClipName .. ".Btn", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if Engine.__wf_atom_2a979d69() then
		__wf_atom_5e6e15c8 *= miOSChatScale
		__wf_atom_5e6e15c8_2 *= miOSChatScale
	end

	if
		v55 <= __wf_atom_5e6e15c8_3
		and __wf_atom_5e6e15c8_3 <= v55 + __wf_atom_5e6e15c8
		and v56 <= __wf_atom_5e6e15c8_4
		and __wf_atom_5e6e15c8_4 <= v56 + __wf_atom_5e6e15c8_2
	then
		return true
	end

	return false
end

local function fn93()
	if
		__wf_atom_7e8ad928(mWindow)
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
		or __wf_atom_7e8ad928(mWindow.mUserPanel)
		or __wf_atom_7e8ad928(mWindow.mUserPanel.mUserLocator)
		or not mWindow.mUserPanel.mUserLocator.mIsExpanded
	then
		return false
	end

	local v55 = mWindow.mWindow.x + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 0) + mMovie:__wf_atom_5e6e15c8(
		"Window.UserPanel.AlphabetIndex",
		0
	) + mMovie:__wf_atom_5e6e15c8("Window.UserPanel.AlphabetIndex.Grid", 0)
	local v56 = mWindow.mWindow.y + mMovie:__wf_atom_5e6e15c8("Window.UserPanel", 1) + mMovie:__wf_atom_5e6e15c8(
		"Window.UserPanel.AlphabetIndex",
		1
	)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Window.UserPanel.AlphabetIndex", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Window.UserPanel.AlphabetIndex", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if Engine.__wf_atom_2a979d69() then
		__wf_atom_5e6e15c8 *= miOSChatScale
		__wf_atom_5e6e15c8_2 *= miOSChatScale
	end

	if
		v55 <= __wf_atom_5e6e15c8_3
		and __wf_atom_5e6e15c8_3 <= v55 + __wf_atom_5e6e15c8
		and v56 <= __wf_atom_5e6e15c8_4
		and __wf_atom_5e6e15c8_4 <= v56 + __wf_atom_5e6e15c8_2
	then
		return true
	end

	return false
end

local function fn94()
	if __wf_atom_7e8ad928(mContextMenu) or not (mContextMenu:GetHowManyElements() > 0) then
		return false
	end

	local v55 = mMovie:__wf_atom_5e6e15c8("ContextMenu", 0) + mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 0)
	local v56 = mMovie:__wf_atom_5e6e15c8("ContextMenu", 1) + mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 1)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("ContextMenu.Bg", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if
		v55 <= __wf_atom_5e6e15c8_3
		and __wf_atom_5e6e15c8_3 <= v55 + __wf_atom_5e6e15c8
		and v56 <= __wf_atom_5e6e15c8_4
		and __wf_atom_5e6e15c8_4 <= v56 + __wf_atom_5e6e15c8_2
	then
		return true
	end

	return false
end

fn3 = function()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

	if mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE then
		if not mMovie:__wf_atom_253d7085("Window.TabMenu") then
			return false
		end

		local v55 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu", 0) + 23
		local v56 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu", 1) + 3
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.WindowTitle.Fill", 14)
		local v57 = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.WindowTitle.Fill", 15) - 5
		return mWindow.mWindow.x + v55 <= __wf_atom_5e6e15c8
			and __wf_atom_5e6e15c8 <= mWindow.mWindow.x + v55 + __wf_atom_5e6e15c8_3
			and mWindow.mWindow.y + v56 <= __wf_atom_5e6e15c8_2
			and __wf_atom_5e6e15c8_2 <= mWindow.mWindow.y + v56 + v57
	else
		local ternary = module.Ternary(mWindow.mUserPanel.mIsExpanded, mWindow.mUserPanel.mWindow.width, 0)

		if Engine.__wf_atom_2a979d69() then
			ternary *= miOSChatScale
		end

		local v56 = mWindow.mWindow.x <= __wf_atom_5e6e15c8
			and __wf_atom_5e6e15c8 <= mWindow.mWindow.x + mWindow.mWindow.width + ternary
			and mWindow.mWindow.y <= __wf_atom_5e6e15c8_2
			and __wf_atom_5e6e15c8_2 <= mWindow.mWindow.y + mWindow.mWindow.height + 35
			or fn93()

		if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
			return v56 or fn94()
		end

		return v56
	end
end

function onRawInputEvent(_, p, p2, p3)
	local v55 = false
	local v56 = p == (Engine.__wf_atom_b290ec01() and "EN_GAMEPAD_BUTTON_RIGHT" or "EN_GAMEPAD_BUTTON_BOTTOM")
		and "EN_MOUSE_B0"
		or p

	if v56 == "EN_MOUSE_B0" then
		mMouseDown = p2 == "1"
	end

	if v56 == "EN_LSHIFT" or v56 == "EN_RSHIFT" then
		v42 = p2 == "1"
	end

	if v56 == "EN_LALT" or v56 == "EN_RALT" then
		v55 = p2 == "1"
	end

	if Engine.__wf_atom_2a979d69() then
		if
			string.find(v56, "MOUSE_B0") ~= nil
			and p2 == "0"
			and tonumber(p3) == 0
			and not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel))
		then
			if not __wf_atom_7e8ad928(mWindow.mUserPanel.mEmoteGrid) then
				mWindow.mUserPanel.mEmoteGrid:StopScrollDrag()
			end

			if not __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl) then
				mWindow.mUserPanel.mListControl:StopScrollDrag()
			end
		end

		if not __wf_atom_7e8ad928(mWindow) and string.find(v56, "EN_MOUSE_B0") ~= nil then
			local focusedElement = mWindow.mTabMenu:GetFocusedElement()

			if p2 == "0" and not __wf_atom_7e8ad928(focusedElement) and elementById then
				local v57 = mWindow.mPanelList[focusedElement.ChannelName]

				if not __wf_atom_7e8ad928(focusedElement) and elementById.Channel == v57.mChannelName then
					return
				end
			end
		end
	end

	if
		v55
		or not string.find(v56, "_TAB")
		or p2 ~= "0"
		or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_MENU_FULL
		and mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
		or mInputBlocked
	then
		if p2 == "0" and flag and v39 and not mInputBlocked then
			if string.find(v56, "_ENTER") then
				fn25()
			elseif string.find(v56, "EN_LEFT") then
				local v57 = tonumber(module15.IMEGetFocusedIndex(v18))

				if v57 ~= 1 then
					module15.IMESetFocusedOption(v57 - 1, v18)
				end
			elseif string.find(v56, "EN_RIGHT") then
				local v57 = tonumber(module15.IMEGetFocusedIndex(v18))

				if v57 ~= module15.IMEGetNumOptions(v18) then
					module15.IMESetFocusedOption(v57 + 1, v18)
				end
			end
		elseif p2 == "0" and not mInputBlocked then
			if string.find(v56, "_ENTER") == nil then
				if string.find(v56, "EN_MOUSE_B0") == nil and not string.find(v56, "EN_MOUSE_B1") then
					if string.find(v56, "EN_UP") ~= nil or string.find(v56, "EN_DOWN") ~= nil then
						fn20(module.Ternary(v56 == "EN_UP", -1, 1))
					end
				else
					if
						(mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL)
						and mMovie:__wf_atom_a91463a8("ContextMenu", 67)
						and not fn94()
					then
						fn24()
					end

					if
						__wf_atom_7e8ad928(mWindow)
						or mWindow.mVisualMode ~= mWindow.VISUAL_MODE_GAMEPLAY_FULL
						or fn3()
					then
						if
							not __wf_atom_7e8ad928(mWindow)
							and not __wf_atom_7e8ad928(mWindow.mUserPanel)
							and not __wf_atom_7e8ad928(mWindow.mTabMenu)
							and (mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL)
						then
							local focusedElement = mWindow.mUserPanel.mListControl:GetFocusedElement()
							local focusedElement2 = mWindow.mTabMenu:GetFocusedElement()

							if
								__wf_atom_7e8ad928(focusedElement)
								or not fn92(focusedElement)
								or string.find(v56, "EN_MOUSE_B1") == nil
								and (string.find(v56, "EN_MOUSE_B0") == nil or mMovie:__wf_atom_a91463a8("ContextMenu", 67))
							then
								if
									string.find(v56, "EN_MOUSE_B1")
									and not __wf_atom_7e8ad928(focusedElement2)
									and string.sub(focusedElement2.ChannelName, 1, 1) == mWindow._getPrivateChatChannelPrefix()
								then
									local v57 = mWindow.mPanelList[focusedElement2.ChannelName]

									if v57 ~= nil then
										fn86(nil, nil, nil, v57)
									end
								end
							else
								fn86((tonumber(focusedElement.Id)))
							end
						end
					elseif
						not mWindow.mWindowTitle.isDragging
						and not mWindow.mWindowStatus.isDragging
						and not Engine.__wf_atom_2a979d69()
						and mMovie:__wf_atom_94bf489f() == nil
					then
						mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE)
					end
				end
			elseif not (__wf_atom_7e8ad928(mWindow) or Engine.__wf_atom_4078373f()) then
				if v28 and v29 then
					v29 = false
				elseif
					not __wf_atom_7e8ad928(mWindow.mInputPanel)
					and (mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL)
				then
					mWindow:OnMessageSent()

					if
						module3.GetUIMode() ~= module3.UI_MODE_IN_SPACE_SHIP
						and mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
					then
						mWindow:SetVisualMode(mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE)
					end
				end
			end
		end
	else
		fn24()

		if v42 then
			v41 = 1
			decrement = module.DECREMENT
		else
			decrement = module.INCREMENT
		end
	end

	return 1
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if mInputBlocked or not fn3() then
		return
	end

	if mMovie:__wf_atom_a91463a8("ContextMenu", 67) then
		return true
	end

	local v55 = tonumber(p)
	local activePanel = mWindow:GetActivePanel()
	local mTextScroll

	if not __wf_atom_7e8ad928(activePanel) then
		mTextScroll = activePanel.mTextScroll
	end

	if fn91() then
		if mWindow.mUserPanel.mListControl.mIsVisible then
			mTextScroll = mWindow.mUserPanel.mListControl.mScrollBar
		else
			mTextScroll = mWindow.mUserPanel.mEmoteGrid.mScrollBar
		end
	elseif fn93() then
		mTextScroll = mWindow.mUserPanel.mUserLocator.mScrollBar
	end

	if not __wf_atom_7e8ad928(mTextScroll) then
		mTextScroll:ScrollBy(v55 * mTextScroll.mScrollStep, false, true)
	end

	return true
end

function OnGetFriendsResult(p, _)
	if not p then
		return
	end

	local movie = __wf_atom_8e4fda44:FindMovie(friendsMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("RefreshFriendsWindow", "")
	end
end

local function fn95(p)
	if p ~= nil then
		print("Picked " .. p.mName)
		local mPendingAddFriendMessage = mPendingAddFriendMessage
		module3.AddFriend(p.mName, "OnAddFriendResultToPanel", mPendingAddFriendMessage)
	end
end

local function fn96(list, fn97)
	if not __wf_atom_7e8ad928(mChildMovie) then
		mChildMovie:Close()
	end

	mChildMovie = mMovie:PushChildMovie(_G.UIMovie_GenericMenu)

	if not __wf_atom_7e8ad928(mChildMovie) then
		mInputBlocked = true
		mChildMovie:Execute("SetTitle", "/Lotus/Language/Chat/PlayerSelection")
		mChildMovie:__wf_atom_f62a8704("SetTitleCaseText", { "false", "true" })

		function _T.PlayerSelectionDone(list2)
			_T.PlayerSelectionDone = nil
			_T.GetPlayerList = nil
			mInputBlocked = false

			if __wf_atom_7e8ad928(list2) or list2[1] == nil then
				fn97(nil)
			else
				fn97(list2[1])
			end
		end

		mChildMovie:Execute("SetCallBack", "PlayerSelectionDone")

		function _T.GetPlayerList()
			local result = {}

			for i = 1, #list do
				local v55 = list[i]

				if v55.mDisplayName == nil then
					local __wf_atom_1b118af6 = Engine.__wf_atom_1b118af6(v55)
					table.insert(result, {
						mName = __wf_atom_1b118af6,
						mUserId = __wf_atom_1b118af6
					})
				else
					local __wf_atom_1b118af6 = Engine.__wf_atom_1b118af6(v55.mDisplayName)
					local mName

					if v55.mPlatformNames == nil then
						mName = __wf_atom_1b118af6
					else
						local count = #v55.mPlatformNames
						local v57 = __wf_atom_1b118af6 .. " ("

						for j = 1, count do
							v57 ..= Engine.__wf_atom_1b118af6(v55.mPlatformNames[j])

							if j < count then
								v57 ..= ", "
							end
						end

						mName = v57 .. " )"
					end

					table.insert(result, { mName = mName, mUserId = __wf_atom_1b118af6 })
				end
			end

			return result
		end

		mChildMovie:Execute("SetElementsFunction", "GetPlayerList")
	end
end

function OnAddFriendResultToPanel(p, p2, value)
	if p == "true" then
		if string.find(value, "%[") == 1 and string.find(value, "%]") then
			fn96(cjson.decode(value), fn95)
			return true
		elseif string.find(value, "%{\"Results") == 1 then
			fn96(mGameData:__wf_atom_4ca9dd3e(), fn95)
			return true
		elseif string.find(value, "%{\"CrossPlayDisabled") == 1 then
			local decoded = cjson.decode(value)

			if decoded and decoded.CrossPlayDisabled then
				mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Multiplayer/InvitePlayerCrossPlayOff", false, {
					USER = decoded.CrossPlayDisabled
				}))
			end

			return true
		else
			mGameData:__wf_atom_e1c832d0("OnGetFriendsResult")
		end
	end

	mPendingAddFriendMessage = ""
	mWindow:SystemMessage(p2)
	return true
end

function OnAddFriendResultToDialog(p, _)
	if p == "true" then
		mGameData:__wf_atom_e1c832d0("OnGetFriendsResult")
	end
end

function OnRemoveFriendResultToPanel(p, p2)
	if p then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_FriendRemoveConfirm", false))
		return
	end

	print("FAILURE: " .. p2)
	mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(module.ParseConnectionErrorMsg(p2), false))
end

function SendGameInviteCallback(p)
	mWindow:SystemMessage(p, false)
end

fn7 = function(data, p)
	if p then
		local v55 = fn28(data.Name, data.AccountId, data.IsCrossSave)

		if not (v55.mIsActive or __wf_atom_7e8ad928(v55.mTabElement) or __wf_atom_7e8ad928(mWindow)) then
			mWindow.mTabMenu:StartFlashing(v55.mTabElement)
		end
	elseif not data.CanCrossPlay then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Multiplayer/InvitePlayerCrossPlayOff", false, {
			USER = data.Name
		}))
	elseif fn29(data.Name, data.AccountId, data.IsCrossSave) and not __wf_atom_7e8ad928(v5.Text) then
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if not (__wf_atom_7e8ad928(__wf_atom_7190444e) or fn40(v5.Text, data.Name)) then
			__wf_atom_7190444e:__wf_atom_e3bb0902(v5.Text, data.Name, true)
			fn12()
		end
	end
end

local function fn97(p)
	if p == nil then
		fn12()
	else
		fn7(p, false)
	end
end

fn5 = function(p, value, p2)
	local v55 = {}
	local v56 = false
	local v57 = false

	if p then
		local accounts, v58 = module2.GetAccountsFromIrcWhoQueryResults(p, value)
		return accounts, v58, false
	end

	print("FAILURE: " .. value)
	local activePanel = mWindow:GetActivePanel()

	if __wf_atom_7e8ad928(activePanel) then
		return v55, v56, v57
	end

	local v58 = ""

	if p2 or string.find(value, "NOSUCHNICK ") ~= 1 then
		if string.find(value, "Previous WHO request still in flight") == 1 then
			v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/PreviousRequestBlocking", false)
		elseif not mCrossPlatformEnabled then
			v58 = mMovie:__wf_atom_8e9ac384(module.ParseConnectionErrorMsg(value), false)
		end
	else
		local friend = string.sub(value, string.len("NOSUCHNICK ") + 1)
		v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_FriendOffline", false, {
			FRIEND = friend
		})
	end

	if v58 ~= "" then
		activePanel:SystemMessage(v58)
		v57 = true
	end

	return v55, v56, v57
end

function PrivateConvoPlayerIDResultOutgoing(p, p2)
	local v55, v56, v57 = fn5(p, p2, false)
	local name = nil

	for i = #v55, 1, -1 do
		if __wf_atom_7e8ad928(mGameData) or not mGameData:__wf_atom_56f280e3(v55[i].Name) then
			continue
		end

		name = v55[i].Name
		table.remove(v55, i)
	end

	if #v55 == 0 then
		local activePanel = mWindow:GetActivePanel()

		if not (__wf_atom_7e8ad928(activePanel) or v57) then
			local v58

			if v56 then
				v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CannotWhisperSelf", false)
			elseif name then
				v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CannotWhisperIgnoredPlayer", false, {
					PLAYER_NAME = name
				})
			else
				v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/NoOnlineUser", false, {
					USER = v5.From
				})
			end

			activePanel:SystemMessage(v58)
		end

		fn12()
	elseif #v55 == 1 then
		fn7(v55[1], false)
	else
		fn6(v55, fn97)
	end
end

function PrivateConvoPlayerIDResultIncoming(p, p2)
	local v55 = fn5(p, p2, true)

	if #v55 == 1 then
		fn7(v55[1], true)
	end
end

local function fn98(data)
	if data == nil then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:__wf_atom_e75653c3() == data.AccountId then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame", false))
	elseif not data.CanCrossPlay then
		mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Multiplayer/InvitePlayerCrossPlayOff", false, {
			USER = data.Name
		}))
	elseif data.Name ~= nil then
		gMatchingService:__wf_atom_b83bc045(
			data.AccountId,
			data.Name,
			module6.GetSquadMissionForInvite(),
			"SendGameInviteCallback",
			data.Platform
		)
	end
end

function InviteOnSelection(ircUserId, name, accountId, p, p2)
	fn98({
		IrcUserId = ircUserId,
		Name = name,
		AccountId = accountId,
		Platform = tonumber(p),
		CanCrossPlay = p2 == "true"
	})
end

local function fn99(data)
	if data == nil then
		return
	end

	mMovie:__wf_atom_f62a8704("InviteOnSelection", {
		data.IrcUserId,
		data.Name,
		data.AccountId,
		tostring(data.Platform),
		(tostring(data.CanCrossPlay))
	})
end

local function fn100(p, p2)
	local v55, v56, v57 = fn5(p, p2, false)

	if #v55 == 0 then
		print("FAILURE: " .. p2)

		if v56 then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame",
				false
			))
		elseif mCrossPlatformEnabled and not v57 then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Chat/NoOnlineUser", false, {
				USER = mInvitedUser2
			}))
		end
	elseif #v55 == 1 then
		fn98(v55[1])
	else
		fn6(v55, fn99)
	end

	mInvitedUser2 = nil
end

function GameInvitePlayerIDResults(p, p2)
	fn100(p, p2)
end

fn8 = function(p)
	if p == nil then
		return
	end

	module3.ToggleIgnoreUser(p.Name, false, "OnIgnoreUser")
end

function IgnorePlayerWhoResult(p, p2)
	local v55, v56, v57 = fn5(p, p2, false)

	if #v55 == 0 then
		if v56 then
			mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_CannotIgnoreSelf", false))
			return
		end

		local __wf_atom_da0f1b0d = gGameData:__wf_atom_da0f1b0d(user2, false)

		if #__wf_atom_da0f1b0d == 0 then
			if not v57 then
				mWindow:SystemMessage(Localize("/Lotus/Language/Chat/NoOnlineUser", { USER = user2 }))
			end
		elseif #__wf_atom_da0f1b0d == 1 then
			local v58 = { Name = __wf_atom_da0f1b0d[1] }
			fn8(v58)
		else
			for i = 1, #__wf_atom_da0f1b0d do
				table.insert(v55, { Name = __wf_atom_da0f1b0d[i] })
			end

			fn6(v55, fn8)
		end
	elseif #v55 == 1 then
		fn8(v55[1])
	else
		fn6(v55, fn8)
	end
end

fn10 = function()
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.LeftBumper.Tf.text", "<MENU_LTRIGGER2>")
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.RightBumper.Tf.text", "<MENU_RTRIGGER2>")
	local isPlayingWithController = Engine.IsPlayingWithController()
	local ternary = module.Ternary(isPlayingWithController, "<TOGGLE_CHAT_WINDOW_ALT>", "<TOGGLE_CHAT_WINDOW>")
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(ternary, true)
	local v55 = (__wf_atom_8e9ac384 == ternary or Engine.__wf_atom_dd1285f1()) and "" or __wf_atom_8e9ac384
	mMovie:__wf_atom_7d7314f1("Window.Hint.Callout.text", v55)
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.ExpandCallout.Tf.text", v55)
	mMovie:__wf_atom_7d7314f1("Window.TabbedChatPanel.FilterCallout.Tf.text", "<MENU_GENERIC2>")
	mMovie:__wf_atom_7d7314f1("Window.SendMessageBar.Callout.Tf.text", "<MENU_GENERIC1>")
	mMovie:__wf_atom_7d7314f1("Window.SendMessageBar.EmojiBtn.Callout.Tf.text", "<MENU_RTRIGGER1>")
	mMovie:__wf_atom_7d7314f1("Window.SendMessageBar.HyperlinkBtn.Callout.Tf.text", "<MENU_LTHUMB>")
	mMovie:__wf_atom_7d7314f1("Window.UserPanel.Panel.LocatorBtn.Callout.Tf.text", "<MENU_RTHUMB>")
end

function UpdateExpandCalloutPos()
	mExpandCalloutOffsetX = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.MinMaxBtn", 14) / 2 - 25
	mExpandCalloutOffsetY = mMovie:__wf_atom_5e6e15c8("Window.TabMenu.MinMaxBtn", 15) / 2 + 1
	mMovie:__wf_atom_e57658c2(
		"Window.TabMenu.ExpandCallout",
		0,
		mMovie:__wf_atom_5e6e15c8("Window.TabMenu.MinMaxBtn", 0) + mExpandCalloutOffsetX
	)
	mMovie:__wf_atom_e57658c2(
		"Window.TabMenu.ExpandCallout",
		1,
		mMovie:__wf_atom_5e6e15c8("Window.TabMenu.MinMaxBtn", 1) + mExpandCalloutOffsetY
	)
end

local function fn101()
	if not (__wf_atom_7e8ad928(mWindow.mUserPanel) or __wf_atom_7e8ad928(mWindow.mUserPanel.mEmoteGrid)) then
		mWindow.mUserPanel.mEmoteGrid:RemoveElements(true, true)

		for i = 1, #v19 do
			mWindow.mUserPanel.mEmoteGrid:AddElement({ mTag = v19[i] }, true)
		end

		mWindow.mUserPanel.mEmoteGrid:RunForAllVisibleElements(function(p)
			mWindow.mUserPanel.mEmoteGrid.mElementDrawCallback(p)
		end)
	end
end

function ReloadEmoticonList()
	fn74()
	fn101()
	mWindow:SetSize(mWindow.mWindow.width, mWindow.mWindow.height)
end

function IconCacheFlushed()
	mMovie:__wf_atom_7d7314f1("Window.Hint.Callout.text", "")
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.ExpandCallout.Tf.text", "")
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.LeftBumper.Tf.text", "")
	mMovie:__wf_atom_7d7314f1("Window.TabMenu.RightBumper.Tf.text", "")
	fn10()

	if Engine.IsPlayingWithController() then
		if not __wf_atom_7e8ad928(v17) then
			v17.mTimers = {}
		end

		if not __wf_atom_7e8ad928(mWindow) then
			if not __wf_atom_7e8ad928(mWindow.mInputPanel) then
				mMovie:__wf_atom_7d7314f1(mWindow.mInputPanel.mClipPath .. ".Callout.Tf.text", "<MENU_GENERIC1>")
			end

			if not __wf_atom_7e8ad928(mWindow.mPanelList[mWindow.mActivePanelName]) then
				mWindow.mPanelList[mWindow.mActivePanelName]:RefreshText(true)
			end

			mWindow.mUserPanel.mListControl:RunForAllElements(function(p)
				if p.mClipName ~= nil then
					mMovie:__wf_atom_7d7314f1(p.mClipName .. ".Callout.Tf.text", "<MENU_SELECT>")
				end
			end)
		end
	end

	local v55 = mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
		or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
	mMovie:__wf_atom_2dedec1a("Window.TabbedChatPanel.FilterCallout", 13, Engine.IsPlayingWithController() and v55)
	mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.EmojiBtn.Callout", 13, Engine.IsPlayingWithController())
	mMovie:__wf_atom_2dedec1a("Window.UserPanel.Panel.LocatorBtn.Callout", 13, false)

	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mInputPanel)) then
		mWindow.mInputPanel.CharLimitWarning = mMovie:__wf_atom_8e9ac384("<WARNING>", true)
		mWindow.mInputPanel.CharLimitError = mMovie:__wf_atom_8e9ac384("<PROBLEM>", true)
		mWindow.mInputPanel.TimerIcon = mMovie:__wf_atom_8e9ac384("<TIMER>", true)
		mMovie:__wf_atom_4c1c1986(
			mWindow.mInputPanel.mClipPath,
			"Prompt",
			0,
			module.Ternary(
				Engine.IsPlayingWithController(),
				mWindow.mInputPanel.mInitPromptXPos + 25,
				mWindow.mInputPanel.mInitPromptXPos
			)
		)
		mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "Callout", 13, Engine.IsPlayingWithController())
	end

	mMovie:__wf_atom_2dedec1a(
		"Window.TabMenu.ExpandCallout",
		13,
		mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE
	)

	if
		mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
		or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL
	then
		mWindow:InitializeTabArrows(true)
	end

	fn101()
end

function SendMessageBarClicked()
	if not (Engine.__wf_atom_4078373f() or Engine.__wf_atom_5df63302() or __wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mInputPanel)) then
		mWindow.mInputPanel:GiveChatFocus()
	end
end

local function fn102()
	if __wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mGameData) then
		return
	end

	local __wf_atom_cb06fe38 = mGameData:__wf_atom_cb06fe38()

	for i = 1, #__wf_atom_cb06fe38 do
		local v55 = __wf_atom_cb06fe38[i]
		local v56 = mWindow._getPrivateChatChannelPrefix() .. v55.mDisplayName
		local v57 = mWindow.mPanelList[v56]

		if not (v57 ~= nil and v55.mHasAccount) then
			continue
		end

		if v57.mPreviousPresState ~= nil and v57.mPreviousPresState ~= v55.mPresence.state then
			local v58 = nil

			if v57.mPreviousPresState == 0 and v55.mPresence.state ~= 0 then
				v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_PrivateConvoOnline", false, {
					PARTNER = v55.mDisplayName
				})
			elseif v57.mPreviousPresState ~= 0 and v55.mPresence.state == 0 then
				v58 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_PrivateConvoOffline", false, {
					PARTNER = v55.mDisplayName
				})
			end

			if v58 ~= nil then
				v57:SystemMessage(v58)
			end
		end

		v57.mPreviousPresState = v55.mPresence.state
	end
end

function ResyncRichPresence()
	if _T.NextRichPresenceResync == nil then
		_T.NextRichPresenceResync = __wf_atom_c4e218a2() + module12.RICH_PRESENCE_RESYNC_INTERVAL
	end
end

function OnLitePresenceUpdated(p)
	if p then
		fn102()
	end

	if _T.NextLitePresenceResync == nil then
		_T.NextLitePresenceResync = __wf_atom_c4e218a2() + module12.LITE_PRESENCE_RESYNC_INTERVAL
	end
end

function ResyncLitePresence()
	v24 = true
end

function CanResyncPresence()
	if not __wf_atom_7e8ad928(mGameData) then
		local __wf_atom_cb06fe38 = mGameData:__wf_atom_cb06fe38()

		if __wf_atom_cb06fe38 ~= nil and #__wf_atom_cb06fe38 > 0 then
			return true
		end
	end

	return false
end

local function fn103(_)
	_T.BackgroundMovie:Execute("RefreshLoadout", "")
	_T.marketDetailedViewParms = { ITEM = nil, CALLBACK = fn103 }
end

function OnDetailedViewComplete(_)
	v44 = nil
	mInputBlocked = false

	if __wf_atom_7e8ad928(v45) then
		if not __wf_atom_7e8ad928(_T.GetScreenRes) then
			local movie = __wf_atom_8e4fda44:FindMovie(_T.GetScreenRes("Store"))

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("RefreshVisibilityMaterials", "")
			end
		end
	else
		v45:Execute("HideScreen", "false")
		v45 = nil
	end

	if not (Engine.IsPlayingWithController() or Engine.__wf_atom_2a979d69() or Engine.__wf_atom_5df63302()) then
		mWindow.mInputPanel:GiveChatFocus()
	end

	fn49(false)

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("RefreshLoadout", "")
	end

	_T.ChatLinkOpen = false
end

function ShowHyperlinkItem(value)
	if fn17("/Lotus/Language/Menu/Chat_LoadingScreenBlocked") or _G.StalkerMode then
		return
	end

	if string.sub(value, 1, 1) == "@" then
		local v55

		if value:match("^@%[[0-9][0-9]:[0-9][0-9]%] ") == nil then
			v55 = string.sub(value, 2)
		else
			v55 = string.sub(value, string.find(value, " ") + 1)
		end

		fn86(v55)
	elseif string.sub(value, 1, 6) == "GUILD=" then
		local v55 = string.find(value, ":")
		local selectedProfileId = string.sub(value, 7, v55 - 1)
		local selectedProfileName = string.sub(value, v55 + 1)
		_T.SelectedIsGuild = true
		_T.SelectedProfileName = selectedProfileName
		_T.SelectedProfileId = selectedProfileId
		_T.OpenScreenAsync("Profile")
	else
		if not __wf_atom_7e8ad928(v44) then
			return
		end

		local zawStoreItem = nil
		local upgradeFingerprint = nil
		local song = nil
		local modularInfo = nil
		local additionalDesc = ""

		if string.lower((string.sub(value, 1, 4))) == "omg-" then
			local v59 = string.find(value, ":")
			local upgradeInfo = SF.UpgradeInfo()
			upgradeInfo.mItemType = WeakResource(v15.OMEGA_TYPE_PREFIX .. string.sub(value, 5, v59 - 1))
			local mInstance = upgradeInfo.mInstance

			if not __wf_atom_7e8ad928(mInstance) then
				upgradeFingerprint = mInstance:__wf_atom_85682a6d((string.sub(value, v59 + 1)))
				zawStoreItem = Resource(v15.OMEGA_STOREITEM_PREFIX .. string.sub(value, 5, v59 - 1))
			end
		elseif string.lower((string.sub(value, 1, 5))) == "song-" then
			local v59 = string.find(value, ":")

			if v59 == nil then
				return
			end

			local v60 = v59 + 1
			local v61 = string.find(value, ":", v60)

			if v61 == nil then
				return
			end

			local fingerPrint = string.sub(value, v60, v61 - 1)
			local notePackInfo = {}

			for i = 0, 3 - 1 do
				local v64 = string.find(value, ":", v61 + 1)

				if v64 == nil then
					v64 = string.len(value) + 1
				end

				local notePack = WeakResource(v15.STEP_SEQUENCER_NOTEPACK_PREFIX .. string.sub(value, v61 + 1, v64 - 1))

				if not __wf_atom_7e8ad928(notePack) then
					table.insert(notePackInfo, { NoteType = i, NotePack = notePack })
				end

				v61 = v64
			end

			if _T.ComposeToolOpen == nil then
				if _G.UIMovie_DetailedPurchaseDialog ~= nil then
					zawStoreItem = Resource(v15.STEP_SEQUENCER_PREVIEW)
					song = { NotePackInfo = notePackInfo, FingerPrint = fingerPrint }
				end
			else
				v15.StepSequencerPendingRequest = {
					NotePackInfo = notePackInfo,
					FingerPrint = fingerPrint
				}
				module.ShowYesOrNoMessage("/Lotus/Language/Menu/Composition_ConfirmLoad", "ConfirmLoadSong")
			end
		elseif
			string.lower((string.sub(value, 1, 4))) == "zaw-"
			or string.lower((string.sub(value, 1, 4))) == "amp-"
			or string.lower((string.sub(value, 1, 4))) == "moa-"
			or string.lower((string.sub(value, 1, 4))) == "kdr-"
			or string.lower((string.sub(value, 1, 4))) == "kit-"
		then
			zawStoreItem = v.zawStoreItem

			if string.sub(string.lower(value), 1, 4) == "amp-" then
				zawStoreItem = v.ampStoreItem
			elseif string.sub(string.lower(value), 1, 4) == "moa-" then
				zawStoreItem = v.moaPetStoreItem
			elseif string.sub(string.lower(value), 1, 4) == "kdr-" then
				zawStoreItem = v.kdriveStoreItem
			elseif string.sub(string.lower(value), 1, 4) == "kit-" then
				zawStoreItem = nil
			end

			local v59 = string.find(value, ":") + 1
			local v60

			if string.sub(string.lower(value), 1, 4) == "moa-" then
				v60 = DecodeModularWeapon(
					string.sub(value, v59),
					#modularMoaPetLegs,
					#modularMoaPetHeads,
					#modularMoaPetEngines,
					#modularMoaPetPayloads
				)
				modularInfo = fn53(StringSplit(",", v60), 6)
			elseif string.sub(string.lower(value), 1, 4) == "kdr-" then
				v60 = DecodeModularWeapon(
					string.sub(value, v59),
					#modularKDriveDecks,
					#modularKDriveEngines,
					#modularKDriveFronts,
					#modularKDriveJets
				)
				modularInfo = fn53(StringSplit(",", v60), 7)
			elseif string.sub(string.lower(value), 1, 4) == "amp-" then
				v60 = DecodeModularWeapon(string.sub(value, v59), #ampBarrels, #ampChasis, #ampGrips)
				modularInfo = fn53(StringSplit(",", v60), 1)
			elseif string.sub(string.lower(value), 1, 4) == "kit-" then
				v60 = DecodeModularWeapon(
					string.sub(value, v59),
					#modularGunHandles,
					#modularGunBarrels,
					#modularGunClips
				)
				modularInfo = fn53(StringSplit(",", v60), 2)
			else
				v60 = DecodeModularWeapon(string.sub(value, v59), #modularStrikes, #modularGrips, #modularLinks)
				modularInfo = fn53(StringSplit(",", v60))
			end

			if v60 ~= "" and modularInfo ~= nil then
				modularInfo.Name = string.sub(value, 5, v59 - 2)

				if zawStoreItem == nil then
					local v61 = 10

					for i = 1, #modularInfo.Parts do
						if not modularInfo.Parts[i]:IsA(__wf_atom_0ed0314b) then
							continue
						end

						v61 = modularInfo.Parts[i]:IsA(__wf_atom_0d68d4a6) and 2 or 3
						break
					end

					if v61 ~= 10 then
						for i = 1, #modularInfo.Parts do
							if not modularInfo.Parts[i]:IsA(__wf_atom_5314fe50) then
								continue
							end

							local __wf_atom_bff4fcf8 = Resource(modularInfo.Parts[i]):__wf_atom_bff4fcf8()

							if __wf_atom_bff4fcf8 == 0 then
								zawStoreItem = module.Ternary(v61 == 2, v.primaryRifleType, v.secondaryRifleType)
								break
							end

							if __wf_atom_bff4fcf8 == 1 then
								zawStoreItem = module.Ternary(v61 == 2, v.primaryShotgunType, v.secondaryShotgunType)
								break
							end

							if __wf_atom_bff4fcf8 == 2 then
								zawStoreItem = module.Ternary(v61 == 2, v.primarySniperType, v.secondarySniperType)
								break
							end

							if __wf_atom_bff4fcf8 == 3 then
								zawStoreItem = module.Ternary(v61 == 2, v.primaryLauncherType, v.secondaryLauncherType)
								break
							end

							if __wf_atom_bff4fcf8 ~= 4 then
								break
							end

							zawStoreItem = module.Ternary(v61 == 2, v.primaryBeamType, v.secondaryBeamType)
							break
						end
					end
				end
			end
		elseif string.lower((string.sub(value, 1, 5))) == "shzn-" then
			if __wf_atom_7e8ad928(_T.ShawzinMovie) then
				fn21(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MustUseShawzin", false), "", 1)
			else
				if not fn33() then
					fn4()
				end

				if Engine.__wf_atom_fc67ba71() then
					_T.ShawzinMovie:Execute("SetLoadedSong", string.sub(value, 6) .. ",nil," .. 4)
				else
					_T.ShawzinMovie:Execute("LoadSongToMemory", (string.sub(value, 6)))
				end
			end
		else
			local appearancePreviewMovie = appearancePreviewMovie
			local v59, v60 = module11.VerifyAppearanceLink(value, true)
			local v61

			if v59 or v60 then
				v61 = "AppearancePreviewDone"
			else
				appearancePreviewMovie = modPreviewMovie
				v59, v60 = module11.VerifyModLink(value, true)
				v61 = "ModPreviewDone"
			end

			if v59 then
				if v53.CanLink() then
					local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/Lotus/Interface/ColorPicker.swf"))

					if not __wf_atom_7e8ad928(movie) then
						movie:Execute("Close", "true")
					end

					mChildMovie = mMovie:PushChildMovie(appearancePreviewMovie)

					if not __wf_atom_7e8ad928(mChildMovie) then
						mInputBlocked = true
						fn49(true)

						_T[v61] = function()
							_T[v61] = nil
							mInputBlocked = false
							fn49(false)
						end

						mChildMovie:Execute("SetOnCloseCallback", v61)
						mChildMovie:Execute("SetLink", value)
					end
				else
					fn21(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/NotAllowedInMission", false), "", 1)
				end
			elseif v60 then
				fn21(mMovie:__wf_atom_8e9ac384(v60, false), "", 1)
			elseif not __wf_atom_7e8ad928(nil) then
				local __wf_atom_105d324f = (nil):__wf_atom_105d324f(value)

				if not __wf_atom_7e8ad928(__wf_atom_105d324f) then
					zawStoreItem = Resource(__wf_atom_105d324f)
				end
			end
		end

		if not __wf_atom_7e8ad928(zawStoreItem) then
			local anchor = Type(zawStoreItem:__wf_atom_5b41f63b())
			v45 = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_DetailedPurchaseDialog)

			if not __wf_atom_7e8ad928(v45) then
				v45:Execute("HideScreen", "true")
			end

			v44 = mMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)

			if modularInfo ~= nil then
				local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

				if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
					additionalDesc = "<br>" .. module8.GetPartsText(
						v44,
						modularInfo.Parts,
						__wf_atom_964056fd,
						true,
						true
					)
				end
			end

			if
				zawStoreItem:ShowInMarket()
				and module3.GetUIMode() ~= module3.UI_MODE_IN_GAME
				and module3.CheckSteamPurchaseAvailability(zawStoreItem) ~= "UNAVAILABLE"
			then
				_T.marketDetailedViewParms = {
					ITEM = {
						StoreItem = zawStoreItem,
						AdditionalDesc = additionalDesc,
						ModularInfo = modularInfo,
						UpgradeFingerprint = upgradeFingerprint,
						Sale = module3.GetSaleInfo(zawStoreItem)
					},
					CALLBACK = fn103,
					Anchor = anchor
				}
			else
				_T.marketDetailedViewParms = {
					ITEM = {
						StoreItem = zawStoreItem,
						AdditionalDesc = additionalDesc,
						ModularInfo = modularInfo,
						CanGiftOverride = false,
						CanPurchaseOverride = false,
						UpgradeFingerprint = upgradeFingerprint,
						Song = song,
						Anchor = anchor
					}
				}
			end

			v44:Execute("SetIgnoreTopMenu", "true")
			v44:Execute("SetExitCallback", "OnDetailedViewComplete")
			fn49(true)
		end
	end

	module4.OnHyperlinkPressed(mMovie)
	_T.ChatLinkOpen = true
end

function RollOver()
	module.PlaySound(_G.UISound_Focus)
end

function UserListBtnFocused()
	mMovie:__wf_atom_e57658c2("Window.SendMessageBar.UserListBtn", 12, 100)
end

function UserListBtnUnfocused()
	local v55 = (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel) or __wf_atom_7e8ad928(mWindow.mUserPanel.mListControl) or not (mWindow.mUserPanel.mIsExpanded and mWindow.mUserPanel.mListControl.mIsVisible))
		and 40
		or 100
	mMovie:__wf_atom_e57658c2("Window.SendMessageBar.UserListBtn", 12, v55)
end

local function fn104()
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel)) then
		if fn33() then
			fn2(false)
		end

		mWindow.mUserPanel:ToggleListVis(true)
	end
end

function UserListBtnPressed()
	fn104()
end

function EmojiBtnFocused()
	mMovie:__wf_atom_e57658c2("Window.SendMessageBar.EmojiBtn", 12, 100)
end

function EmojiBtnUnfocused()
	local v55 = (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel) or __wf_atom_7e8ad928(mWindow.mUserPanel.mEmoteGrid) or not (mWindow.mUserPanel.mIsExpanded and mWindow.mUserPanel.mEmoteGrid.mIsVisible))
		and 40
		or 100
	mMovie:__wf_atom_e57658c2("Window.SendMessageBar.EmojiBtn", 12, v55)
end

local function fn105()
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mUserPanel)) then
		if fn33() then
			fn2(false)
		end

		mWindow.mUserPanel:ToggleListVis(false)
	end
end

function EmojiBtnPressed()
	fn105()
end

function FilterBtnFocused()
	mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel.FilterBtn", 11, _G.UIColor_Yellow)
end

function FilterBtnUnfocused()
	mMovie:__wf_atom_e57658c2("Window.TabbedChatPanel.FilterBtn", 11, _G.UIColor_White)
end

function FilterBtnPressed()
	if __wf_atom_7e8ad928(mWindow) then
		return
	end

	local activePanel = mWindow:GetActivePanel()

	if __wf_atom_7e8ad928(activePanel) or fn17("/Lotus/Language/Menu/Chat_LoadingScreenBlocked") then
		return
	end

	local mFriendlyName = activePanel.mFriendlyName
	v47 = mMovie:PushChildMovie(chatFilterMgrMovie)

	function _T.OnChatFilterMgrClosed()
		_T.OnChatFilterMgrClosed = nil

		if __wf_atom_7e8ad928(mMovie) then
			return
		end

		activePanel:PopulateFilterList()
		fn49(false)
	end

	v47:Execute("SetOnCloseFunction", "OnChatFilterMgrClosed")

	if activePanel.mChannelType == mWindow.CHANNEL_PRIVATE_CHAT then
		mFriendlyName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_PrivateTitle", false)
	end

	v47:Execute("SetChannelName", mFriendlyName)
	v47:Execute("SetChannel", (string.sub(activePanel.mChannelName, 1, 1)))
	fn49(true)
end

function FilterSelected(p)
	if not (mInputBlocked or __wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mFilterList)) then
		mWindow.mFilterList:SelectElementById((tonumber(p)))
	end
end

function FilterFocused(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mFilterList)) then
		mWindow.mFilterList:FocusElementById((tonumber(p)))
	end
end

function FilterUnfocused(p)
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mFilterList)) then
		mWindow.mFilterList:UnfocusElementById((tonumber(p)))
	end
end

function MessageBoxFocused()
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mInputPanel)) then
		local __wf_atom_1a698565 = __wf_atom_8e4fda44:__wf_atom_1a698565()

		if not __wf_atom_7e8ad928(__wf_atom_1a698565) then
			__wf_atom_1a698565:__wf_atom_2004c47f()
		end

		mWindow.mInputPanel:SetFocus(true)

		if flag then
			v40 = ""
		end

		if Engine.__wf_atom_2a979d69() and Engine.IsOSKAvailable() then
			gRegion:__wf_atom_06b65d2b(
				mMovie:__wf_atom_76657dba(mWindow.mInputPanel.mClipPath .. ".MessageBox", "text"),
				"title",
				"hint",
				false,
				false,
				true,
				"OSKSendMessageCallback",
				mWindow.mInputPanel.mMaxMsgLength
			)
		end
	end
end

function MessageBoxUnfocused()
	if not (__wf_atom_7e8ad928(mWindow) or __wf_atom_7e8ad928(mWindow.mInputPanel)) then
		mWindow.mInputPanel:SetFocus(false)

		if flag then
			module15.CloseIME(v18)
			mMovie:__wf_atom_7f57ab2f(mWindow.mInputPanel.mClipPath, "MessageBox", 87, false)
			v39 = false
		end
	end
end

function ConfirmLoadSong(p)
	if tonumber(p) == 4 and v15.StepSequencerPendingRequest ~= nil then
		_T.ComposeToolRequest = v15.StepSequencerPendingRequest
	end

	v15.StepSequencerPendingRequest = nil
end

local function fn106(p, p2, p3)
	if not __wf_atom_7e8ad928(mWindow) then
		if p ~= nil then
			if _G.StalkerMode then
				p = module.Ternary(p2, "Acquiring target...", "Target not in mission...")
			end

			if p3 and p3.customDialogFunction then
				p3.customDialogFunction()
			else
				mWindow:SystemMessage(mMovie:__wf_atom_8e9ac384(p, false))
			end
		end

		v32.InProgress = false
		v32.PendingRequestName = ""

		if v32.TempAddToChatPartners and not __wf_atom_7e8ad928(mGameData) then
			mGameData:__wf_atom_daf43580(v32.PlayerName)
		end

		if _G.StalkerMode and p2 then
			fn4()
		end

		if v51 then
			v51 = false

			if gMatchingService:__wf_atom_a676a953() and _T.ScenarioSquadMembersChanged then
				_T.ScenarioSquadMembersChanged(
					__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_6be84646(),
					false,
					true
				)
			end
		end
	end

	v51 = false
end

function OnJoinLobbyComplete(p)
	if p then
		gMatchingService:__wf_atom_7027399a(5)
		fn106(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_JoinSuccess", false, {
				PLAYER_NAME = v32.PlayerName
			}),
			p
		)
	else
		local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
		fn106(__wf_atom_91952c92 == "" and "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail" or __wf_atom_91952c92)
	end
end

function OnFindSessionComplete(p)
	local v55, v56 = module6.CheckSingleSessionResults(
		p,
		false,
		v32.Presence.session.teamId,
		nil,
		mMovie,
		"OnFindSessionComplete"
	)

	if type(v55) == "string" then
		fn106(v55, false, v56)
		return
	end

	if not module6.ShowJoinSessionCommand(v32.Presence) then
		fn106(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Session_LeaveMission", false), p)
		return
	end

	v51 = gMatchingService:__wf_atom_a676a953() and gMatchingService:__wf_atom_1b24a1bb()
	gMatchingService:JoinSquadSession(
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0),
		v55,
		false,
		v32.Presence.session.teamId,
		"OnJoinLobbyComplete"
	)
end

function OnGetPresenceForJoin(p)
	if not p then
		fn106(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_GetPresenceFail", false, {
			PLAYER_NAME = v32.PlayerName
		}))
	elseif not __wf_atom_7e8ad928(mGameData) then
		local __wf_atom_cb06fe38 = mGameData:__wf_atom_cb06fe38()
		local mPresence = nil

		for i = 1, #__wf_atom_cb06fe38 do
			if __wf_atom_cb06fe38[i].mId ~= v32.PlayerId then
				continue
			end

			mPresence = __wf_atom_cb06fe38[i].mPresence
			break
		end

		local v55 = module6.CheckJoinSessionPermission(mPresence)
		local v56 = not v55
			and mPresence.session.regionId == 3
			and not mGameData:__wf_atom_139834cf(v32.PlayerId)
			and "/Lotus/Language/Menu/SocialOverlay_SessionRequiresInvite"
			or v55

		if v56 then
			fn106(v56)
		else
			v32.Presence = mPresence:Copy()
			module6.FindSessionById(mPresence.session.id, "OnFindSessionComplete", false, true)
		end
	end
end

function AlphabetIndexBgFocused() end

local function fn107(data)
	if not data.CanCrossPlay then
		fn106(mMovie:__wf_atom_8e9ac384("/Multiplayer/InvitePlayerCrossPlayOff", false, {
			USER = data.Name
		}))
	elseif not __wf_atom_7e8ad928(mGameData) and data.AccountId ~= "" and data.Name ~= "" then
		v32.PlayerId = data.AccountId
		v32.PlayerName = data.Name
		v32.TempAddToChatPartners = true
		local v55 = data.IsCrossSave ~= nil and data.IsCrossSave
		mGameData:__wf_atom_72bffca2(data.Name, data.AccountId, v55)

		if Engine.__wf_atom_84bb79c2() then
			mGameData:__wf_atom_c7c2a30f({ data.IrcUserId }, "OnGetPresenceForJoin")
		else
			mGameData:__wf_atom_c7c2a30f({ data.AccountId }, "OnGetPresenceForJoin")
		end
	end
end

function JoinOnSelection(ircUserId, name, accountId, p, p2)
	fn107({
		IrcUserId = ircUserId,
		Name = name,
		AccountId = accountId,
		CanCrossPlay = p == "true",
		IsCrossSave = p2 == "true"
	})
end

local function fn108(data)
	if data == nil then
		fn106(nil, false)
	else
		mMovie:__wf_atom_f62a8704("JoinOnSelection", {
			data.IrcUserId,
			data.Name,
			data.AccountId,
			tostring(data.CanCrossPlay),
			(tostring(data.IsCrossSave))
		})
	end
end

function JoinPlayerIDResult(p, p2)
	if not p then
		fn106(module.ParseConnectionErrorMsg(p2))
		return
	end

	local v55, v56 = fn5(p, p2)

	if #v55 == 0 then
		if v56 then
			fn106("/Lotus/Language/Menu/SocialOverlay_PlayerAlreadyInGame")
		else
			fn106(Localize("/Lotus/Language/Chat/NoOnlineUser", { USER = v32.PendingRequestName }))
		end

		v32.PendingRequestName = ""
	elseif #v55 == 1 then
		fn107(v55[1])
	else
		fn6(v55, fn108)
	end
end

function OnGamepadTransition(p)
	local v55 = p == "true"
	fn10()

	if not __wf_atom_7e8ad928(mWindow) then
		local v56 = mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL
			or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_FULL

		if Engine.__wf_atom_4078373f() or not v56 or __wf_atom_7e8ad928(mWindow.mInputPanel) then
			if Engine.__wf_atom_4078373f() then
				mMovie:__wf_atom_2004c47f()
			end
		else
			mWindow.mInputPanel:GiveChatFocus()
		end

		mWindow:SetTabMenuPanelPos(true)
		mWindow:SetArrowVisibilities()

		if not __wf_atom_7e8ad928(mWindow.mTabMenu) then
			mWindow.mTabMenu:SetRightBumperPos()
		end

		mWindow:SetMinMaxBtnPos()
		local ternary = module.Ternary(
			not (mInputBlocked or v55) and _T.TopMenuOpen and mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_FULL,
			0.6,
			0
		)
		mMovie:__wf_atom_0cf0fdbe(ternary)
		local v57 = not (__wf_atom_7e8ad928(v44) and __wf_atom_7e8ad928(v47) and __wf_atom_7e8ad928(v46) and __wf_atom_7e8ad928(mChildMovie))
		local v58 = v55
			or mWindow.mVisualMode == mWindow.VISUAL_MODE_GAMEPLAY_SIMPLE
			or mWindow.mVisualMode == mWindow.VISUAL_MODE_MENU_SIMPLE
			or v57

		if not __wf_atom_7e8ad928(_T.SetButtonBarEnabled) then
			_T.SetButtonBarEnabled(v58)
		end

		mMovie:__wf_atom_2dedec1a("Window.TabbedChatPanel.FilterCallout", 13, not v55 and v56)
		mWindow:UpdateFilterPositions()
		mWindow.mInputPanel:SetSize()
		local coordsRelativeToParent = mWindow:GetCoordsRelativeToParent(mWindow.mInputPanel.mWindow)
		local activePanel = mWindow:GetActivePanel()
		local total = 120

		if not v55 then
			total += 32
		end

		mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.HideWindowBtn", 13, false)
		mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.EmojiBtn.Callout", 13, not v55)
		mMovie:__wf_atom_e57658c2(
			"Window.SendMessageBar.Prompt",
			0,
			module.Ternary(
				Engine.IsPlayingWithController(),
				mWindow.mInputPanel.mInitPromptXPos + 25,
				mWindow.mInputPanel.mInitPromptXPos
			)
		)
		mMovie:__wf_atom_e57658c2("Window.SendMessageBar.MessageBox", 0, mWindow.mInputPanel.mInitPromptXPos)
		mMovie:__wf_atom_e57658c2("Window.SendMessageBar.MessageBox", 14, coordsRelativeToParent.width - total)
		mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.Callout", 13, not v55)
		mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.MessageBox", 67, v55)
		mMovie:__wf_atom_2dedec1a("Window.UserPanel.Panel.LocatorBtn.Callout", 13, false)
		mMovie:__wf_atom_e57658c2("Window.UserPanel.Panel.LocatorBtn", 12, module.Ternary(v55, 50, 100))

		if not __wf_atom_7e8ad928(activePanel) then
			mMovie:__wf_atom_2dedec1a("Window.SendMessageBar.HyperlinkBtn", 13, not v55 and activePanel.mHasHyperlink)
		end

		if not __wf_atom_7e8ad928(mWindow.mUserPanel) then
			local function fn109(p2, p3)
				local v59 = "Window.SendMessageBar." .. p2
				mMovie:__wf_atom_7f57ab2f(v59, "Arrow", 13, v55)
				mMovie:__wf_atom_e57658c2(v59, 12, module.Ternary(not v55 and p3, 100, 50))
			end

			fn109(
				"HideWindowBtn",
				not (mWindow.mUserPanel.mEmoteGrid.mIsVisible or mWindow.mUserPanel.mListControl.mIsVisible)
			)
			fn109("UserListBtn", mWindow.mUserPanel.mListControl.mIsVisible)
			fn109("EmojiBtn", mWindow.mUserPanel.mEmoteGrid.mIsVisible)
			mWindow.mUserPanel.mListControl:RunForAllVisibleElements(function(p2)
				mWindow.mUserPanel.mListControl.mElementDrawCallback(p2)
			end)
		end

		if Engine.__wf_atom_2a979d69() then
			UpdateExpandCalloutPos()
		end
	end
end

function onKeyDown_TOGGLE_CHAT_WINDOW_ALT()
	local __wf_atom_1dca1cfb = __wf_atom_8e4fda44:__wf_atom_1dca1cfb()

	if
		__wf_atom_7e8ad928(__wf_atom_1dca1cfb)
		or __wf_atom_7e8ad928(mMovie)
		or __wf_atom_1dca1cfb == mMovie
		or not (__wf_atom_1dca1cfb:__wf_atom_7fc4c74c() >= mMovie:__wf_atom_7fc4c74c() and fn33())
	then
		return
	else
		return true
	end
end

function ForceLargeFont()
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow.SetFontSize(mWindow, 3)
	end
end

function OnAddToChatChannel(p)
	if not __wf_atom_7e8ad928(mWindow) and mWindow.mCachedGuildId ~= nil then
		local v55 = fn13(p, true)
		local v56 = "#C" .. mWindow.mCachedGuildId
		mWindow:OnChatMessageReceived("," .. v56 .. ",,,", v55)
	end
end

function OnAddToGlobalChannel(p)
	if not __wf_atom_7e8ad928(mWindow) then
		local regionChannel = mWindow:_getRegionChannel()
		mWindow:OnChatMessageReceived("," .. regionChannel .. ",,,", p)
	end

	_T.ShowNotification(p)
end

function OnNotifyAscensionCeremonyBegun(p)
	if _T.ShowNotification ~= nil then
		_T.ShowNotification(p, "EventReminder", false, 8)
	end
end

function OnQuestsChanged()
	if not __wf_atom_7e8ad928(mWindow) then
		mWindow.mInQuestCommitment = module3.InQuestCommitment()
	end
end

function SetTouchLayout()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	if _T.Touch_GetChatOffset then
		local touch_GetChatOffset = _T.Touch_GetChatOffset()
		local v55 = mMovie:__wf_atom_d5a50cb5() * touch_GetChatOffset.x / (mMovie:__wf_atom_5e6e15c8("_root", 5) / 100)
		local v56 = mMovie:__wf_atom_5e6e15c8("_root", 6) / 100
		local v57 = mMovie:__wf_atom_c4f6543f() * touch_GetChatOffset.y / v56 - mWindow.mWindow.height / v56 + 220

		if fn33() then
			v57 += mMovie:__wf_atom_5e6e15c8("Window.SendMessageBar.MessageBox", 15) * mMovie:__wf_atom_5e6e15c8("Window.SendMessageBar", 5) / 100 * mMovie:__wf_atom_5e6e15c8("Window", 5) / 100
		end

		mWindow:SetPosition(module.Round(v55), module.Round(v57))
	end
end