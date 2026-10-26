local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = 0
local purchasedItems = nil
local v7 = nil
local v8 = false
local v9 = nil
local v10 = nil
local v11 = false
local uiTexture_DefaultClan = nil
local v12 = nil
local id = 1
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CardUtilitiesRedux")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("Lotus.Scripts.Libs.StoryLib")
local v13 = nil
local v14 = nil
local flag = false
local v15 = nil
local flag2 = false
local v16 = {
	NONE = 1,
	ACCEPT_DECLINE = 2,
	GIFT = 3,
	TELEPORT = 4,
	WEB_BROWSER = 5,
	EMAIL_SETTINGS = 6
}
local v17 = {
	{ "/Lotus/Language/CommunityMessages/VoidTraderAppearanceTitle" },
	{ "DARVO NOTHING FOR NOW" },
	{ "/Lotus/Language/G1Quests/DeathMarkMessage" },
	{ "/Lotus/Language/G1Quests/DeathSquadTitle", "/Lotus/Language/G1Quests/BrandedTitle" },
	{ "/Lotus/Language/G1Quests/HarvesterTitle" },
	{ "/Lotus/Language/Items/EventDoubleAffinityName" },
	{ "/Lotus/Language/Items/EventDoubleCreditsName" },
	{ "/Lotus/Language/Items/EventDoubleDropRateName", "/Lotus/Language/Inbox/SteelPathRefundTitle" },
	{ "/Lotus/Language/Items/EventDoubleResourceName" },
	{ "/Lotus/Language/Inbox/HardModeRewardMsgTitle" },
	{ "/Lotus/Language/Menu/GiftReceivedConfirmationSubject" },
	{ "/Lotus/Language/Menu/Mailbox_ClanInvite_Title" },
	{ "/Lotus/Language/QuestInbox/TwitchDropInboxTitle" },
	{
		"/Lotus/Language/G1Quests/FC_CORPUS_InvasionThankyouMessageSubject",
		"/Lotus/Language/G1Quests/FC_GRINEER_InvasionThankyouMessageSubject"
	},
	{
		"/Lotus/Language/Messages/Anniversary2019MsgTitle",
		"/Lotus/Language/Messages/Anniversary2019MissionTitleA",
		"/Lotus/Language/Messages/Anniversary2019MissionTitleB",
		"/Lotus/Language/Messages/Anniversary2019MissionTitleC",
		"/Lotus/Language/Messages/Anniversary2019MissionTitleD",
		"/Lotus/Language/Messages/Anniversary2019MissionTitleE",
		"/Lotus/Language/Messages/Anniversary2020MsgTitle",
		"/Lotus/Language/Messages/Anniversary2020MissionTitleF",
		"/Lotus/Language/Messages/Anniversary2020MissionTitleG",
		"/Lotus/Language/Messages/Anniversary2020MissionTitleH"
	},
	{ "/Lotus/Language/Inbox/TrueMasterFontTitle" },
	{ "/Lotus/Language/Inbox/Prime2022Streamer01DropInboxMsgTitle" },
	{ "/Lotus/Language/Inbox/50thAnniversaryGiveawaySubject" }
}
local v18 = WeakResource("/SF/Types/Game/SFWeapon")
local v19 = {}
local v20 = {}
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = 0
local v26 = 1
local v27 = 0
local v28 = nil
local v29 = false
local v30 = nil
local v31 = 0
local v32 = 0
local v34 = 0
local v35 = nil
local flag3 = false
local mContextInfo = nil
local mTransmission = nil
local v36 = nil
local mCinematic = nil
local v37 = false
local flag4 = false
local v38 = false
local v39 = nil
local v40 = {}
local v41 = false
local v42 = false
local mTag = 1
local v43 = nil
local v44 = false
local v45 = false
local v46 = 0
local v47 = false
local v48 = {}
local fn
local fn2
local fn3
local fn4
local fn5
local fn6
local fn7
local fn8
local fn9

local function fn10()
	return v29 or _T.StoryLib_PlayingCin
end

function IsInputBlocked()
	return fn10()
end

function GetCards()
	return nil
end

function GetSelectedCards()
	return nil
end

function GetSelectedElement()
	return nil
end

local function fn11()
	local v49 = {}

	for i = #v20, 1, -1 do
		local v50 = v20[i]

		if v50.mVisible then
			table.insert(v49, {
				Label = v50.mLabel,
				CallBack = v50.mCallback,
				CallOut = v50.mCallout
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v49, getfenv(1))
	end
end

local function fn12()
	v29 = true
	fn2(true)
	v:SelectElementById(1)

	if __wf_atom_7e8ad928(v35) then
		v35 = mMovie:__wf_atom_5e6e15c8("PopupFrame", 0)
	end

	mMovie:__wf_atom_e57658c2("PopupFrame", 12, 0)
	mMovie:__wf_atom_e57658c2("PopupFrame", 0, v35 - 50)
	__wf_atom_ec43d06e(mMovie, "PopupFrame", 7, { 12, 0 }, { 100, v35 }, 0.4, 0, function()
		v29 = false
	end)
end

local function fn13()
	if fn10() then
		return
	end

	v29 = true

	if v35 == nil then
		mMovie:Close()
	else
		__wf_atom_ec43d06e(mMovie, "PopupFrame", 7, { 12, 0 }, { 0, v35 - 50 }, 0.2, 0, function()
			mMovie:Close()
		end)
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			_T.gLastHighPriorityMessageCount = __wf_atom_9be88b01:__wf_atom_153e689d()
		end
	end
end

function TransitionOut()
	fn13()
end

local function fn14(p)
	if not __wf_atom_7e8ad928(gRegion) then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(p)
	end
end

local function fn15(p)
	local mSenderIcon = p.mSenderIcon

	if __wf_atom_d9227398() or __wf_atom_72884638("Graphics.UseWeGameCensoring") then
		for i = 1, #censoredIcons do
			if mSenderIcon ~= censoredIcons[i] then
				continue
			end

			mSenderIcon = censoredIconReplacements[i]
			break
		end
	end

	local ordisPostWarIcon2 = Resource(mSenderIcon)

	if ordisPostWarIcon2 ~= nil then
		return ordisPostWarIcon2
	end

	if p.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSupportSender" then
		return (WeakResource("/Lotus/Interface/Graphics/LotusSymbol.png"))
	end

	if p.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender" then
		return lotusDefaultIcon
	end

	if p.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender_PostWar" then
		return v48.icon
	end

	if p.mSender == "/Lotus/Language/Bosses/Ordis" then
		ordisPostWarIcon2 = ordisPostWarIcon
	end

	return ordisPostWarIcon2
end

local function fn16()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v3 = gGameData:__wf_atom_90763c09()

	if module3.IsParadoxPath() then
		for i, v49 in ipairs(v3) do
			if v49.mIsRead or v49.mSubject ~= "/Lotus/Language/CommunityMessages/VoidTraderAppearanceTitle" then
				continue
			end

			table.remove(v3, i)
			return
		end
	end
end

function OnAcknowledgeInboxMessage(p, _)
	if p then
		fn16()
		local movie = __wf_atom_8e4fda44:FindMovie(notificationsMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("RefreshBoosters", "")
		end

		if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v3)) then
			v12.mSkipRead = true
			local v49 = v3[v12.Id]

			if not __wf_atom_7e8ad928(v49) and #v49.mGifts > 0 then
				fn7(v49)
				fn6()
				return
			end
		end
	end

	v29 = false
end

local function fn17(mId)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			v29 = true
			__wf_atom_9be88b01:__wf_atom_534be828(mId, "OnAcknowledgeInboxMessage")
		end
	end
end

function CollectionFocused(_)
	if fn10() then
		return
	end

	module2.ZoomCard(nil, (nil).mClipName .. ".Card", true)
	module.PlaySound(_G.UISound_Focus)
end

function CollectionUnfocused(_)
	if fn10() then
		return
	end

	module2.ZoomCard(nil, (nil).mClipName .. ".Card", false)
end

local function fn18(instance, object, p)
	if __wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(object) then
		return nil
	end

	if string.find(instance:GetName(), "ZanukaPet") ~= nil then
		return Localize("/Lotus/Language/Kingpins/CorpusPetName", { LICH_NAME = p })
	end

	if instance:IsA(v18) then
		return SF.__wf_atom_62a48c60(object:__wf_atom_014a76a2():c_str() .. "|" .. p)
	end

	return nil
end

local function fn19(p, LICH_NAME)
	local v49 = v3[p]
	local v50 = #v49.mAttachments
	local v51 = #v49.mCountedAttachments
	local _ = #v49.mCoupons
	local v52 = #v49.mSyndicateAttachments
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.AttachmentGrid", 1, v34 + 10)
	v5:RemoveElements(true, true)

	if v49.mCredits > 0 then
		local v53 = { Count = 1 }
		v53.Icon = largeCreditsIcon
		v53.Themed = true
		v53.Name = module.SeparateWithCommas(v49.mCredits, 0) .. " " .. Localize("/Lotus/Language/Actions/CreditsIncrease", {})
		v5:AddElement(v53, true)
	end

	if v49.mPremiumCredits > 0 then
		local v53 = { Count = 1 }
		v53.Icon = largePlatIcon
		v53.Themed = true
		v53.Name = module.SeparateWithCommas(v49.mPremiumCredits, 0) .. " " .. Localize("/Lotus/Language/Dojo/TradeTypePlatinum", {})
		v5:AddElement(v53, true)
	end

	if v49.mPrimeTokens > 0 then
		local v53 = { Count = 1 }
		v53.Icon = primeTokenIcon
		v53.Themed = true
		v53.Name = module.SeparateWithCommas(v49.mPrimeTokens, 0) .. " " .. Localize("/Lotus/Language/PrimeStore/Store_PrimeTokens", {})
		v5:AddElement(v53, true)
	end

	for i = 1, v50 do
		local mAttachment = v49.mAttachments[i]
		local v53 = nil

		if not __wf_atom_7e8ad928(mAttachment) then
			if mAttachment:IsA(__wf_atom_cb425ff5) then
				v53 = Resource(mAttachment)
			elseif mAttachment:IsA(__wf_atom_f3c8513b) then
				v53 = v13:__wf_atom_232fd31d(mAttachment)
			end
		end

		if __wf_atom_7e8ad928(v53) or __wf_atom_7e8ad928(v53:GetIconTexture()) then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(mMovie, v53, { GetVisibilityMaterial = true }, nil, nil, true)

		if LICH_NAME ~= nil then
			local name = fn18(mAttachment, v53, LICH_NAME)

			if name ~= nil then
				storeItemInfo.Name = name
			end
		end

		v5:AddElement(storeItemInfo, true)
	end

	for i = 1, v51 do
		local mCountedAttachment = v49.mCountedAttachments[i]
		local __wf_atom_232fd31d = v13:__wf_atom_232fd31d(mCountedAttachment.mItemType)

		if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
			continue
		end

		local storeItemInfo = module4.GetStoreItemInfo(
			mMovie,
			__wf_atom_232fd31d,
			{ GetVisibilityMaterial = true },
			nil,
			nil,
			true
		)
		storeItemInfo.QuantityMultiplier = mCountedAttachment.mItemCount

		if LICH_NAME ~= nil then
			local name = fn18(mCountedAttachment.mItemType, __wf_atom_232fd31d, LICH_NAME)

			if name ~= nil then
				storeItemInfo.Name = name
			end
		end

		v5:AddElement(storeItemInfo, true)
	end

	for i = 1, v52 do
		local mSyndicateAttachment = v49.mSyndicateAttachments[i]
		local v53 = { Count = 1 }
		v53.Icon = largeSyndicateRepIcon
		v53.Themed = true
		v53.Name = module.FormatNumber(mSyndicateAttachment.mStanding, 0) .. " " .. Localize("/Lotus/Language/Menu/Profile_Reputation", {})
		v5:AddElement(v53, true)
	end

	v5.Width = v6 - 50
	module6.FitGridToWidth(v5)
	v5:Redraw(nil, true, true)
	local v53 = math.ceil(v5:GetHowManyElements() / v5.mColumns) * (v5.ElementHeight + v5.ElementDimBuffer)
	v34 += v53
end

local function fn20()
	mMovie:__wf_atom_290807ee("PopupFrame.Content.GiftPanel.Gift")
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Gift", 0, 0)
	v7:RemoveTimer(v24)
	v24 = nil
end

local function fn21()
	module.PlaySound(shakeGiftSound)
	__wf_atom_ec43d06e(mMovie, "PopupFrame.Content.GiftPanel.Gift", 8, { function(p)
			local v49 = math.sin(3.1415927410125732 * 8 * p) * 10
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Gift", 0, v49)
		end }, { 1 }, 1, 0, function()
		v24 = v7:AddTimer(4, function()
			fn21()
		end)
	end)
end

fn7 = function(data)
	if __wf_atom_7e8ad928(v13) then
		return
	end

	local mGiftType = data.mGifts[1].mGiftType

	if __wf_atom_7e8ad928(mGiftType) then
		return
	end

	local storeItem

	if mGiftType:IsA(__wf_atom_cb425ff5) then
		storeItem = Resource(mGiftType)
	else
		storeItem = v13:__wf_atom_232fd31d(mGiftType)
	end

	local mLocalizationArgs = data.mLocalizationArgs
	local mTag2 = 1

	for i = 1, #mLocalizationArgs do
		if tostring(mLocalizationArgs[i].mKey) == "GIFT_QUANTITY" then
			mTag2 = tonumber((tostring(mLocalizationArgs[i].mTag)))
		end
	end

	if not __wf_atom_7e8ad928(storeItem) then
		local storeItemInfo = module4.GetStoreItemInfo(mMovie, storeItem, nil, nil, nil, true)
		local ternary = module.Ternary(storeItemInfo.Themed, 256, 358)
		mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel.Gift.Item", "Icon", 14, ternary)
		mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel.Gift.Item", "Backer", 14, ternary)
		module4.DrawItem(mMovie, "PopupFrame.Content.GiftPanel.Gift.Item", storeItemInfo)
		local gridItemName = module6.GetGridItemName(mMovie, {}, {
			Name = storeItemInfo.Name,
			StoreItem = storeItem,
			QuantityMultiplier = mTag2
		})
		mMovie:__wf_atom_50d60589("PopupFrame.Content.GiftPanel.Name", 36, gridItemName)
	end

	mMovie:__wf_atom_7d7314f1("PopupFrame.Content.GiftPanel.Desc.text", "/Lotus/Language/Menu/GiftSender", {
		SENDER = data.mSender
	})
	local v50 = 0
	local v51 = 1
	local v52 = 1
	local v53 = 1

	if data.mIsRead then
		v50 = 100
		v51 = 160
		v52 = 137
		v53 = 40
	else
		fn21()
	end

	v23:SetVisible(v50 == 0)
	v23:SetAlpha(100 - v50)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Name", 12, v50)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Desc", 12, v50)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndStop", v51)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndStop", v52)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndStop", v53)
end

local function fn22(p)
	local __wf_atom_e0c3cbeb = p.mDate:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
	local v49 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
	local v50 = StringSplit("/", v49)
	return (Localize("/Lotus/Language/Inbox/TimeStamp", {
		MONTH = v50[1],
		DAY = v50[2],
		YEAR = v50[3],
		TIME = v50[4]
	}))
end

function KickOffCinematicChild()
	if __wf_atom_7e8ad928(_T.InboxCinematic) then
		return
	end

	_T.RadioChatterDisabled = true

	if not __wf_atom_7e8ad928(_T.curTransmission) then
		module3.ClearTransmissionQueue()
		module3.InterruptTransmission()
	end

	local v49 = WeakResource("/Lotus/Interface/Inbox.swf")
	gGameRules:__wf_atom_411c9025(true)
	_T.StoryLib_MoviesToAlpha = { v49 }
	_T.StoryLib_BlockTransmissions = true
	module7.PlayCinematic(_T.InboxCinematic, nil)
	local movie = __wf_atom_8e4fda44:FindMovie(v49)

	while _T.StoryLib_PlayingCin and not __wf_atom_7e8ad928(movie) do
		Sleep(0)
	end

	gGameRules:__wf_atom_411c9025(false)

	if not __wf_atom_7e8ad928(movie) then
		movie:SetVisible(true)
	end

	_T.RadioChatterDisabled = nil
end

local function fn23(mCinematic2)
	if not __wf_atom_7e8ad928((gRegion:__wf_atom_c3b255b8())) then
		return
	end

	_T.InboxCinematic = mCinematic2
	gRegion:__wf_atom_c4f78a8f():__wf_atom_8a035cd5(Symbol("KickOffCinematicChild"), false)
end

local function fn24(p)
	local v49

	if not (v3 == nil or p == nil or not (p > 0 and p <= #v3)) then
		v49 = v3[p]
	end

	local v50 = v49 == nil
	mMovie:__wf_atom_2dedec1a("Empty", 13, v50)
	mMovie:__wf_atom_2dedec1a("PopupFrame", 13, not v50)
	v20[3].mVisible = not v50

	if v50 then
		v20[2].mVisible = false
		fn11()
	else
		if __wf_atom_7e8ad928(v49.mGifts) or v49.mIsRead then
			v20[2].mVisible = true
		else
			v20[2].mVisible = false
		end

		fn11()

		if v49.mAcceptAction == 2 and v49.mContextInfo == "" then
			fn3((tostring(v49.mId)))
			return
		end

		mMovie:__wf_atom_2dedec1a("PopupFrame.Underline", 13, true)
		local mMessage = v49.mMessage
		local v51 = string.gsub(mMessage, "|r|n", "\r\n")
		local mLocalizationArgs = v49.mLocalizationArgs
		local isUGCRestricted = module.IsUGCRestricted()
		local v52 = {}
		local flag5 = false
		local v53 = nil
		local v54 = nil
		local v55 = false
		local v56 = true

		for i = 1, #mLocalizationArgs do
			local mKey = tostring(mLocalizationArgs[i].mKey)
			local mTag2 = tostring(mLocalizationArgs[i].mTag)

			if isUGCRestricted and (mKey == "attacker_name" or mKey == "ATTACKER_NAME") then
				v52[mKey] = ""
			elseif isUGCRestricted and mKey == "GIFTER_NAME" then
				v52.GIFTER_NAME = mMovie:__wf_atom_8e9ac384(mTag2, false)
				v55 = true
			elseif isUGCRestricted and (mKey == "clan" or mKey == "their_clan") then
				v52[mKey] = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_GuildBtn", false)
			elseif isUGCRestricted and mKey == "alliance" then
				v52.alliance = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/View_Alliance_Short", false)
			elseif mKey == "GIFT_TYPE" then
				local v57 = WeakResource(mTag2)

				if v57:IsA(__wf_atom_cb425ff5) then
					v54 = Resource(v57)
				else
					v54 = v13:__wf_atom_232fd31d(v57)
				end

				if not __wf_atom_7e8ad928(v54) then
					v52.TYPE_NAME = mMovie:__wf_atom_8e9ac384(tostring(v54:__wf_atom_014a76a2()), false)
				end
			elseif mKey == "GIFT_DURABILITY" then
				v53 = tonumber(mTag2)
			elseif mKey == "LICH_NAME" then
				v52.LICH_NAME = TitleCase(mTag2)
				v56 = false
			elseif mKey == "PLAYER_NAMES" then
				local v57 = StringSplit(",", mTag2)
				local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
				local __wf_atom_7f395d54 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_7f395d54()
				local v58 = ""

				for j = 1, #v57 do
					local v59 = v57[j]

					if not __wf_atom_7f395d54 and Engine.__wf_atom_940f8971(v59) ~= __wf_atom_63bb2bc6 then
						v59 = Localize("/Lotus/Language/Multiplayer/CrossPlayPlayer", false)
					end

					v58 ..= "- " .. v59 .. "<br>"
				end

				v52.PLAYER_NAMES = v58
			elseif tonumber(mTag2) then
				v52[mKey] = module.FormatNumber(mTag2)
			else
				v52[mKey] = mMovie:__wf_atom_8e9ac384(mTag2, false, v52)
			end

			if mKey == "GIFTER_NAME" or mKey == "PLAYER_NAME" or mKey == "PLAYER_NAMES" then
				flag5 = true
			end
		end

		if Engine.__wf_atom_578fc9dd() then
			if flag5 then
				mMovie:__wf_atom_50d60589("PopupFrame.Content.MsgText", 49, "Arial Unicode MS")
				mMovie:__wf_atom_50d60589("PopupFrame.Subject", 49, "Arial Unicode MS")
			else
				mMovie:__wf_atom_50d60589("PopupFrame.Content.MsgText", 49, "Noto Sans")
				mMovie:__wf_atom_50d60589("PopupFrame.Subject", 49, "Noto Sans")
			end
		end

		if v52.TYPE_NAME ~= nil and v53 ~= nil and not __wf_atom_7e8ad928(v54:GetItem()) then
			if not v54:GetItem():IsA(__wf_atom_f9559e3c) or Resource(v54:GetItem()):__wf_atom_4eb36b35() then
				if v53 == 0 then
					v52.TYPE_NAME = Localize("/Lotus/Language/Menu/Global_3Days", {}) .. " " .. v52.TYPE_NAME
				elseif v53 == 1 then
					v52.TYPE_NAME = Localize("/Lotus/Language/Menu/Global_7Days", {}) .. " " .. v52.TYPE_NAME
				end
			else
				local __wf_atom_5df94bc3 = __wf_atom_c67f9605:__wf_atom_5df94bc3(v53)
				v52.TYPE_NAME ..= " (" .. Localize("/Lotus/Language/Menu/Global_BoosterUses", {
					NUM_USES = __wf_atom_5df94bc3
				}) .. ")"
			end
		end

		if v52.NODE_NAME then
			local starChart = module3.GetStarChart()

			if __wf_atom_7e8ad928(starChart) then
				v52.NODE_NAME = ""
			else
				local v57 = Symbol(v52.NODE_NAME)
				v52.NODE_NAME = Localize(tostring(starChart:__wf_atom_d5226f21(v57).locTag), {})
				v52.NODE_REGION_NAME = Localize(tostring(starChart:__wf_atom_db2d8292(v57).name), {})
			end
		end

		if v52.PLAYER_NAME == nil and not __wf_atom_7e8ad928(gRegion) then
			local v57 = gRegion:__wf_atom_e23b2855()[1]

			if not __wf_atom_7e8ad928(v57) then
				v52.PLAYER_NAME = v57:__wf_atom_6be84646(true)
			end
		end

		if v52.CLAN_NAME == nil and not __wf_atom_7e8ad928(gGameData) then
			if isUGCRestricted then
				v52.CLAN_NAME = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_GuildBtn", false)
			else
				v52.CLAN_NAME = gGameData:__wf_atom_84083b39()
			end
		end

		if
			v49.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender_PostWar"
			or v49.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender"
		then
			v52.LOTUS_NAME = v48.localizedName
		end

		local v57 = "#" .. string.format("%X", v19.Content)
		v52.OPEN_COLOR = "</font><font color=\"" .. ("#" .. string.format("%X", v19.FloatingContent)) .. "\">"
		v52.CLOSE_COLOR = "</font><font color=\"" .. v57 .. "\">"
		v52.OPEN_BOLD = "<b>"
		v52.CLOSE_BOLD = "</b>"
		local v58 = ("<p><font color=\"" .. v57 .. "\">") .. mMovie:__wf_atom_8e9ac384(v51, true, v52)
		local v59 = v55 and "" or v58

		if not __wf_atom_7e8ad928(v49.mGifts) and v41 then
			v59 = __wf_atom_f8f86fc5(v59, 0)
		end

		if #v49.mModPacks > 0 then
			v59 ..= "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mailbox_ModPackNotification", false)

			for i = 1, #v49.mModPacks do
				local mModPack = v49.mModPacks[i]
				local c_str = v13:__wf_atom_232fd31d(mModPack):__wf_atom_014a76a2():c_str()
				v59 ..= "\r\n" .. mMovie:__wf_atom_8e9ac384(c_str, false)
			end
		end

		if
			v56
			and (#v49.mAttachments > 0 or #v49.mCountedAttachments > 0 or #v49.mCoupons > 0 or v49.mCredits > 0 or v49.mAcceptAction == 1)
		then
			v59 ..= "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Mailbox_AttachmentNotification",
				false
			)
		end

		local v60 = nil

		for i = 1, #v17 do
			local v61 = v17[i]

			for j = 1, #v61 do
				if not (v61[j] == v49.mSubject or v61[j] == v49.mMessage) then
					continue
				end

				v60 = recurringEmailBackers[i]
				break
			end
		end

		mMovie:__wf_atom_c90af43a("PopupFrame.RecurringBacker", v60)
		mMovie:__wf_atom_2dedec1a("PopupFrame.RecurringBacker", 13, v60 ~= nil)
		mMovie:__wf_atom_2dedec1a("PopupFrame.Watermark", 13, v60 == nil)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v49.mSubject, false, v52)
		local v61 = v59 .. "</font></p>"
		mMovie:__wf_atom_50d60589("PopupFrame.Content.MsgText", 36, v61)
		mMovie:__wf_atom_7d7314f1("PopupFrame.Subject.text", __wf_atom_8e9ac384)
		mMovie:__wf_atom_50d60589("PopupFrame.Timestamp", 36, fn22(v49))
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Subject", 1)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Subject", 41)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Timestamp", 41)
		local v62 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + 5
		mMovie:__wf_atom_e57658c2("PopupFrame.Timestamp", 1, v62)
		mMovie:__wf_atom_e57658c2("PopupFrame.Underline", 1, v62 + __wf_atom_5e6e15c8_3 + 10)
		v31 = v62 + __wf_atom_5e6e15c8_3 + 20
		mMovie:__wf_atom_e57658c2("PopupFrame.Content", 1, v31)
		mMovie:__wf_atom_e57658c2("PopupFrame.ScrollBarContent", 1, v31 + 3)
		fn2()
		local none = v16.NONE
		local none2 = v16.NONE
		mTransmission = v49.mTransmission
		mCinematic = v49.mCinematic
		v36 = Symbol(v49.mTutorialTag)
		v45 = mTransmission ~= nil or not __wf_atom_7e8ad928(mCinematic)
		mMovie:__wf_atom_2dedec1a("PopupFrame.TransBtn", 13, v45)

		if v49.mAcceptAction == 2 or v49.mAcceptAction == 3 or v49.mAcceptAction == 4 then
			none = v16.ACCEPT_DECLINE
			none2 = v16.ACCEPT_DECLINE
		elseif v49.mTeleportLocation == 0 then
			if v49.mSubject == twitchPrimeSubject or v49.mURL ~= "" then
				none2 = v16.WEB_BROWSER
			elseif v49.mSubject == "/Lotus/Language/Inbox/EmailLinkSubject" then
				none2 = v16.EMAIL_SETTINGS
			end
		else
			none2 = v16.TELEPORT
		end

		local v63 = not __wf_atom_7e8ad928(v49.mGifts)
		mMovie:__wf_atom_2dedec1a("PopupFrame.Content.GiftPanel", 13, v63)
		fn20()

		if not __wf_atom_7e8ad928(v28) then
			v28:Destroy()
			v28 = nil
		end

		if v63 then
			fn7(v49)
		end

		v34 = module.Round(mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.MsgText", 41)) + 5
		v21:SetVisible(none ~= v16.NONE)
		v22:SetVisible(none2 ~= v16.NONE)
		local mMovie2 = mMovie
		mMovie2:__wf_atom_976dcedd(
			v21.mClipName,
			"forceMenuSelection",
			none ~= v16.NONE and Engine.IsPlayingWithController()
		)
		local mMovie3 = mMovie
		mMovie3:__wf_atom_976dcedd(
			v22.mClipName,
			"forceMenuSelection",
			none2 ~= v16.NONE and Engine.IsPlayingWithController()
		)

		if none ~= v16.NONE or none2 ~= v16.NONE then
			local v68 = v34 + 10
			local ternary = module.Ternary(none == v16.ACCEPT_DECLINE, 200, 400)
			local ternary2 = module.Ternary(none2 == v16.ACCEPT_DECLINE, 200, 400)
			local v69, v70

			if none2 == v16.NONE or none == v16.NONE then
				v69 = v6 / 2 - ternary / 2
				v70 = v6 / 2 - ternary2 / 2
			else
				local v71 = ternary + ternary2 + 30
				v69 = v6 / 2 - v71 / 2
				v70 = v69 + ternary + 30
			end

			v21:SetPosition(v69, v68)
			v22:SetPosition(v70, v68)
			local v71 = none == v16.Gift and "/Lotus/Language/Menu/Mailbox_UnwrapGift"
				or "/Lotus/Language/Menu/Mailbox_Accept"
			v21.mLabel = mMovie:__wf_atom_8e9ac384(v71, false)
			v21:SetWidth(ternary)
			v21:Redraw()
			local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mailbox_Decline", false)

			if none2 == v16.TELEPORT then
				local location = v49.mTeleportLocation ~= 1 and ""
					or Localize("/Lotus/Language/Menu/NavBar_Store", false)
				__wf_atom_8e9ac384_2 = Localize("/Lotus/Language/Menu/Mailbox_TeleportToLocation", {
					LOCATION = location
				})
			elseif none2 == v16.WEB_BROWSER then
				local v72 = not v49.mURLBtnLocTag:__wf_atom_8598f3a9()
					and "/Lotus/Language/Menu/Mailbox_OpenWebBrowser"
					or v49.mURLBtnLocTag:c_str()
				__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v72, false)
			elseif none2 == v16.EMAIL_SETTINGS then
				__wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Settings/Inbox_OpenSettings", false)
			end

			v22.State = none2
			v22.mLabel = __wf_atom_8e9ac384_2
			v22:SetWidth(ternary2)
			v22:Redraw()
			v34 += 45
		end

		fn19(p, v52.LICH_NAME)
		local mVisibleProp = v32 / v34

		if mVisibleProp < 1 then
			mMovie:__wf_atom_2dedec1a("PopupFrame.ScrollBarContent", 13, true)

			if not __wf_atom_7e8ad928(v4) then
				v4.mVisibleProp = mVisibleProp
				local v69 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.MsgText", 43) * (1 - v4.mVisibleProp)
				v4.mScrollStep = 1 / (v69 / 3)
				v4:RedrawScrollBar()
			end
		else
			mMovie:__wf_atom_2dedec1a("PopupFrame.ScrollBarContent", 13, false)
		end

		v4:SetScrollValue(0, nil, true)
		v4.mIsActive = mVisibleProp < 1

		if not v49.mIsRead then
			local v69 = false

			for i = 1, #mLocalizationArgs do
				local mKey = tostring(mLocalizationArgs[i].mKey)
				local mTag2 = tostring(mLocalizationArgs[i].mTag)

				if mKey ~= "CREDIT_REWARD" or __wf_atom_7e8ad928(gRegion) then
					continue
				end

				local v70 = gRegion:__wf_atom_e23b2855()[1]

				if __wf_atom_7e8ad928(v70) or __wf_atom_7e8ad928(__wf_atom_539492fe) then
					continue
				end

				__wf_atom_539492fe:__wf_atom_9aca19e0(v70, Symbol("BATTLE_PAY"), mTag2)
				__wf_atom_539492fe:__wf_atom_c2038c7a(v70, Symbol("BATTLE_PAY_PAID"))
				v69 = true
			end

			if
				not __wf_atom_7e8ad928(gRegion)
				and not v69
				and string.find(v49.mSubject, "InvasionThankyouMessageSubject")
			then
				local v70 = gRegion:__wf_atom_e23b2855()[1]

				if not (__wf_atom_7e8ad928(v70) or __wf_atom_7e8ad928(__wf_atom_539492fe)) then
					__wf_atom_539492fe:__wf_atom_9aca19e0(v70, Symbol("BATTLE_PAY"), 20000)
					__wf_atom_539492fe:__wf_atom_c2038c7a(v70, Symbol("BATTLE_PAY_PAID"))
				end
			end

			if __wf_atom_7e8ad928(v49.mGifts) then
				fn17(v49.mId)
			end

			if not (__wf_atom_7e8ad928(mTransmission) or flag4) then
				fn(mTransmission)
			end

			if not __wf_atom_7e8ad928(mCinematic) then
				v37 = true
			end

			if v49.mSubject == twitchPrimeSubject and not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
				__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("INBOX"), "TWITCH_OPENED")
			end
		end
	end
end

local function fn25(data)
	return #data.mAttachments > 0
		or #data.mCountedAttachments > 0
		or #data.mCoupons > 0
		or #data.mSyndicateAttachments > 0
end

local function fn26(p)
	v2:RemoveElements(true, true)
	local v49 = {}
	local sec = nil
	local v50 = 1

	for i = 1, #v3 do
		__wf_atom_83c14687(0)
		local v51 = v3[i]

		if
			v47
			and not v42
			and (v51.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender" or v51.mSender == "/Lotus/Language/Bosses/Ordis")
			and v51.mDate.sec - 1639587600 > 0
		then
			if v51.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender" then
				v51.mSender = "/Lotus/Language/Menu/Mailbox_WarframeSender_PostWar"
			end

			v51.mSenderIcon = nil
		end

		local date = fn22(v51)
		local icon = fn15(v51)
		local anchor

		if not __wf_atom_7e8ad928(icon) then
			anchor = Type(icon:__wf_atom_5b41f63b())
		end

		local senderLoc

		if v51.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSender_PostWar" then
			senderLoc = v48.localizedName
		else
			senderLoc = mMovie:__wf_atom_8e9ac384(v51.mSender, false)
		end

		table.insert(v49, {
			Id = i,
			IsClanMessage = v51.mSubject == "/Lotus/Language/Clan/Clan_AscensionCeremonyInProgress",
			DateSec = v51.mDate.sec,
			Date = date,
			SenderLoc = senderLoc,
			Sender = v51.mSender,
			Icon = icon,
			Anchor = anchor
		})

		if not p or v51.mIsRead or not (sec == nil or v51.mDate.sec < sec) then
			continue
		end

		sec = v51.mDate.sec
		v50 = i
	end

	table.sort(v49, v2.mSortBy)

	for i = 1, #v49 do
		v2:AddElement(v49[i], true)
	end

	fn5()
	v12 = nil
	v2:Redraw(nil, nil, true)

	if p then
		v2:FocusElementById(v50)
	else
		v2:FocusElement(1)
	end

	v2:SelectCurrentElement()
	mMovie:__wf_atom_2dedec1a("PopupFrame.SortMenu", 13, #v3 ~= 0)

	if #v3 == 0 then
		fn24(-1)
	end
end

local function fn27()
	if __wf_atom_7e8ad928(gGameData) or v2 ~= nil then
		return
	end

	mMovie:__wf_atom_2dedec1a("PopupFrame", 13, true)
	fn16()
	local module8 = require("EE.Interface.Components.List")
	local module9 = require("EE.Interface.Components.ScrollBar")
	v2 = module8.CreateList(mMovie, "PopupFrame.MessageList.Message1")
	v2.mLineClips = {
		"Line",
		"Tips",
		"Sparkles1.Sparkle1",
		"Sparkles1.Sparkle2",
		"Sparkles1.Sparkle3",
		"Sparkles2.Sparkle1",
		"Sparkles2.Sparkle2",
		"Sparkles2.Sparkle3"
	}
	v2.mVisibleElements = 6
	v2.mScroll = 1
	v2.mForcedVerticalSeparation = 105
	v2.mWrapAroundNavigation = false
	v2.mElementTransitionTime = 0.01
	v2:SetCallbacks("ElementPressed", "ElementFocused", "ElementUnfocused")
	mMovie:__wf_atom_e57658c2("TransmissionFrame.ImageOuter.Image", 15, 600)
	mMovie:__wf_atom_e57658c2("PopupFrame.Bg", 15, v2.mVisibleElements * v2.mForcedVerticalSeparation + 40)
	mMovie:OverrideMaterial("TransmissionFrame.ImageOuter.Image", _G.UIMaterial_SmoothEdgeNoDepthTest)
	mMovie:OverrideMaterial("PopupFrame.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"PopupFrame.Bg",
		"RectInnerColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0.1
	)
	mMovie:__wf_atom_1ca72041(
		"PopupFrame.Bg",
		"RectEdgeColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0.2
	)

	function v2.mClipCreatedCallback(p, _)
		mMovie:SetFrameCallback(p .. ".Lines", "OnLineFrame")
	end

	function v2.UpdateFocused(p, p2, p3, p4)
		if p.mClipName == nil then
			return
		end

		local ternary = module.Ternary(p2, v19.FloatingContentHighlight, v19.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Sender", 44, ternary)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Subject", 44, ternary)
		local ternary2 = module.Ternary(p2 or p3, v19.FloatingContentHighlightObject, v19.FloatingContentObject)
		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			ternary2.r,
			ternary2.g,
			ternary2.b,
			p2 and 0.7 or p3 and 0.4 or 0.2
		)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Corner", 13, p3)

		if p2 then
			mMovie:__wf_atom_2dedec1a(p.mClipName .. ".Highlight", 13, true)
		end

		__wf_atom_ec43d06e(
			mMovie,
			p.mClipName .. ".Highlight",
			8,
			{ 15 },
			{ module.Ternary(p2, 51, 1) },
			module.Ternary(p4, 0, 0.4),
			0,
			function()
				if not p2 and p.mClipName ~= nil then
					mMovie:__wf_atom_2dedec1a(p.mClipName .. ".Highlight", 13, false)
				end
			end
		)
	end

	function v2.mOnFocusedCallback(p)
		local v49 = not __wf_atom_7e8ad928(v12) and v12.Id == p.Id
		v2.UpdateFocused(p, true, v49)
		module.PlaySound(_G.UISound_Focus)
	end

	function v2.mOnUnfocusedCallback(p)
		local v49 = not __wf_atom_7e8ad928(v12) and v12.Id == p.Id
		v2.UpdateFocused(p, false, v49)
		module.PlaySound(_G.UISound_Unfocus)
	end

	function v2.mOnSelectedCallback(p)
		if v12 then
			if v12.mSkipRead then
				v12.mSkipRead = nil
			end

			if v12.mClipName ~= nil then
				__wf_atom_ec43d06e(mMovie, v12.mClipName .. ".Lines", 8, { 12 }, { 0 }, 0.2)
			end

			v2.UpdateFocused(v12, false, false)
			local v49 = v3[v12.Id]
			mMovie:__wf_atom_7f57ab2f(v12.mClipName, "Read", 13, not (__wf_atom_7e8ad928(v49) or v49.mIsRead))
			fn5()
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ItemTipSection)
		end

		v12 = p
		id = p.Id

		if p.mClipName ~= nil then
			mMovie:__wf_atom_290807ee(p.mClipName .. ".Lines")
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Lines", 12, 100)
			__wf_atom_86cbd68d(mMovie, p.mClipName .. ".Lines.gotoAndPlay", 1)
		end

		v2.mElementDrawCallback(p)
		fn24(p.Id)
	end

	function v2:SetLineVisRanges(p)
		for i = 1, #self.mLineClips do
			mMovie:OverrideMaterial(p .. "." .. self.mLineClips[i], messageListVisibleRangeMaterial)
		end
	end

	function v2.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		local focusedElement = v2:GetFocusedElement()
		local v49 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id
		local v50 = not __wf_atom_7e8ad928(v12) and v12.Id == data.Id
		local senderLoc = data.SenderLoc
		local v51 = v3[data.Id]

		if __wf_atom_7e8ad928(v51) then
			return
		end

		local icon = data.Icon

		if data.IsClanMessage then
			icon = uiTexture_DefaultClan
		end

		if icon == nil then
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "SenderIcon", 13, false)
		else
			mMovie:__wf_atom_933bbce0(data.mClipName .. ".SenderIcon", icon, messageListVisibleRangeMaterial)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "SenderIcon", 13, true)
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "Lines", 11, v19.FloatingContentHighlight)

		if v50 then
			__wf_atom_86cbd68d(mMovie, data.mClipName .. ".Lines.gotoAndPlay", 1)
		else
			__wf_atom_86cbd68d(mMovie, data.mClipName .. ".Lines.gotoAndStop", 1)
		end

		local v52 = v51.mIsRead and not data.mSkipRead
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Read", 13, not v52)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Subject", 14, module.Ternary(v52, 320, 265))

		if fn25(v51) then
			senderLoc ..= " " .. mMovie:__wf_atom_8e9ac384("<ATTACHMENT>", true)
		end

		if
			string.find(data.Sender, "/Lotus/") and not string.find(data.Sender, "VoidTraderName")
			or icon ~= nil and string.find(icon:__wf_atom_5b41f63b(), "/Lotus/Interface/Graphics/WorldStatePanel/")
		then
			senderLoc = TitleCase(senderLoc)
		end

		mMovie:__wf_atom_48bd5a59(data.mClipName, "Sender", 36, data.Date)

		if Engine.__wf_atom_578fc9dd() then
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Sender", 49, "Arial Unicode MS")
		end

		module.SetFittedText(mMovie, data.mClipName .. ".Subject", senderLoc, "...")
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Subject", 41)
		local v53 = -((__wf_atom_5e6e15c8 + mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Sender", 41) + 5) / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Subject", 1, v53)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender", 1, v53 + __wf_atom_5e6e15c8 + 5)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Divider", 11, v19.FloatingContent)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Read", 11, v19.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Corner", 11, v19.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Highlight", 11, v19.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Corner", 12, 100)
		mMovie:OverrideMaterial(data.mClipName .. ".Sender", messageListTextVisibleRangeMaterial)
		mMovie:OverrideMaterial(data.mClipName .. ".Subject", messageListTextVisibleRangeMaterial)
		mMovie:__wf_atom_933bbce0(data.mClipName .. ".Read", unreadIcon, messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(data.mClipName .. ".Divider", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(data.mClipName .. ".Corner", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(data.mClipName .. ".Highlight.Light", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(data.mClipName .. ".Bg", messageBackerVisibleRangeMaterial)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Lines", 100, data.Id)
		v2:SetLineVisRanges(data.mClipName .. ".Lines.Line1")
		mMovie:__wf_atom_1ca72041(
			data.mClipName .. ".Bg",
			"RectInnerColor",
			v19.Background1Object.r,
			v19.Background1Object.g,
			v19.Background1Object.b,
			0.9
		)
		v2.UpdateFocused(data, v49, v50, true)
	end

	v2:AttachScrollBar("PopupFrame.ScrollBarMessages", -5)
	v2:EnableSmoothScroll()
	local module10 = require("Lotus.Interface.Components.DropDownMenu")
	v = module10.Create(mMovie, "PopupFrame.SortMenu")
	v.mWidth = 225
	v.mStartingDepth = tonumber(__wf_atom_86cbd68d(mMovie, v.mRootClipName .. ".getDepth"))
	v.mMainButton:SetWidth(225)
	v:SetCallbacks("SortByPressed", "SortByFocused", "SortByUnfocused")

	function v.RecentSort(p, p2)
		return p.DateSec > p2.DateSec
	end

	function v.mOnSelectedCallback(p)
		if v2.mSortBy ~= p.Attribute then
			v2.mSortBy = p.Attribute
			fn26()
		end
	end

	function v.OnExpandCallback(p, p2)
		__wf_atom_86cbd68d(mMovie, p.mRootClipName .. ".swapDepths", 5555)

		if p2 and Engine.__wf_atom_5df63302() then
			local rootBasedPosition, v49 = p.UTIL.GetRootBasedPosition(mMovie, p.mRootClipName)
			mMovie:__wf_atom_2625efb4(rootBasedPosition + 19, v49 + 1)
		end
	end

	function v.OnCollapseCallback(p, _)
		__wf_atom_86cbd68d(mMovie, p.mRootClipName .. ".swapDepths", p.mStartingDepth)
	end

	v:AddElement({
		Name = "/Lotus/Language/Inbox/SortByRecent",
		SortId = "RECENT",
		Attribute = function(p, p2)
			return v.RecentSort(p, p2)
		end
	}, true)
	v:AddElement({
		Name = "/Lotus/Language/Inbox/SortBySender",
		SortId = "SENDER",
		Attribute = function(p, p2)
			if p.SenderLoc == p2.SenderLoc then
				return v.RecentSort(p, p2)
			end

			return p.SenderLoc < p2.SenderLoc
		end
	}, true)
	v:AddElement({
		Name = "/Lotus/Language/Inbox/SortByAttachment",
		SortId = "ATTACHMENT",
		Attribute = function(p, p2)
			local v49 = v3[p.Id]
			local v50 = v3[p2.Id]

			if v49 == nil or v50 == nil then
				return v.RecentSort(p, p2)
			end

			local v51 = fn25(v49)
			local v52 = fn25(v50)

			if v51 and not v52 then
				return true
			end

			if v51 or not v52 then
				return v.RecentSort(p, p2)
			end

			return false
		end
	}, true)
	v:AddElement({
		Name = "/Lotus/Language/Menu/Item_GiftToPlayerShort",
		SortId = "GIFT",
		Attribute = function(p, p2)
			local v49 = v3[p.Id]
			local v50 = v3[p2.Id]

			if v49 == nil or v50 == nil then
				return v.RecentSort(p, p2)
			end

			local v51 = #v49.mGifts > 0
			local v52 = #v50.mGifts > 0

			if v51 and not v52 then
				return true
			end

			if v51 or not v52 then
				return v.RecentSort(p, p2)
			end

			return false
		end
	}, true)
	v:Redraw()
	v4 = module9.CreateScrollBar(mMovie, "PopupFrame.ScrollBarContent", 420, 0.5)
	v4.mEnableSmoothScroll = true

	function v4.mScrollValueChangedCallback(p, _)
		mMovie:__wf_atom_e57658c2("PopupFrame.Content", 1, v31 - (v34 - v32) * p)
	end

	mMovie:__wf_atom_976dcedd("PopupFrame.ScrollBarContent.Scrub", "startScrubCallback", "ContentScrubStartDrag")
	mMovie:__wf_atom_976dcedd("PopupFrame.ScrollBarContent.Scrub", "stopScrubCallback", "ContentScrubStopDrag")
	mMovie:__wf_atom_976dcedd("PopupFrame.ScrollBarContent", "clickScrollBarCallback", "ContentScrollBarClick")
	v4:Initialize()
	table.insert(v20, {
		mVisible = true,
		mLabel = "/Lotus/Language/Menu/Mailbox_Close",
		mCallback = function()
			mMovie:Execute("OnClosePressed", "")
		end,
		mCallout = "MENU_CANCEL"
	})
	table.insert(v20, {
		mVisible = #v3 > 0,
		mLabel = "/Lotus/Language/Menu/Mailbox_Delete",
		mCallback = function()
			mMovie:Execute("OnDeleteMessagePressed", "")
		end,
		mCallout = "MENU_GENERIC1"
	})
	table.insert(v20, {
		mVisible = #v3 > 0,
		mLabel = "/Lotus/Language/Menu/Mailbox_DeleteAllRead",
		mCallback = function()
			mMovie:Execute("OnDeleteAllReadMessagesPressed", "")
		end,
		mCallout = "MENU_RTHUMB"
	})
	fn11()
	local module11 = require("Lotus.Interface.Components.ThemedButton")
	v21 = module11.Create(
		mMovie,
		"PopupFrame.Content.AcceptBtn",
		"/Lotus/Language/Menu/Mailbox_Accept",
		"OnAcceptPressed",
		"<MENU_SELECT>"
	)
	v21:SetWidth(200)
	v21.mAlignment = "center"
	v21.mEdgeAlpha = 10
	v21.mUnfocusedEdgeColor = 9
	v21:SetVisibleRangeMaterials(
		contentVisibleRangeMaterial,
		contentTextVisibleRangeMaterial,
		contentRectangleVisibleRangeMaterial
	)
	v22 = module11.Create(
		mMovie,
		"PopupFrame.Content.DeclineBtn",
		"/Lotus/Language/Menu/Mailbox_Decline",
		"OnDeclinePressed",
		"<MENU_RTRIGGER2>"
	)
	v22:SetWidth(200)
	v22.mAlignment = "center"
	v22.mEdgeAlpha = 10
	v22.mUnfocusedEdgeColor = 9
	v22:SetVisibleRangeMaterials(
		contentVisibleRangeMaterial,
		contentTextVisibleRangeMaterial,
		contentRectangleVisibleRangeMaterial
	)
	v21:SetVisible(false)
	v22:SetVisible(false)
	v21:Redraw()
	v22:Redraw()

	if #v3 == 0 then
		fn24(-1)
	end

	fn12()

	if not __wf_atom_7e8ad928(v30) then
		v30:SetActive(false)
	end
end

function OnLineFrame(p, p2)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p, 100)

	if v2:GetElementById(__wf_atom_5e6e15c8) ~= nil then
		local v49 = nil

		if p2 == "Line2Vis" then
			v49 = p .. ".Line2"
		elseif p2 == "Line3Vis" then
			v49 = p .. ".Line3"
		elseif p2 == "Line4Vis" then
			v49 = p .. ".Line4"
		end

		if v49 ~= nil then
			v2:SetLineVisRanges(v49)
		end
	end
end

fn5 = function()
	if __wf_atom_7e8ad928(v2) then
		return
	end

	local count = 0
	v2:RunForAllElements(function(p)
		local v49 = v3[p.Id]

		if not __wf_atom_7e8ad928(v49) and (not v49.mIsRead or p.mSkipRead) then
			count += 1
		end
	end)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Unread", 13, count > 0)
	mMovie:__wf_atom_7d7314f1("PopupFrame.Unread.text", "/Lotus/Language/Inbox/UnreadCount", {
		COUNT = module.FormatNumber(count)
	})
end

local function fn28()
	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		return
	end

	flag2 = true

	if not flag then
		fn27()
	end
end

function OnInboxSyncComplete()
	fn28()
end

fn2 = function(p)
	if __wf_atom_7e8ad928(v2) then
		return
	end

	if p then
		local screenDimensions, v49 = module.GetScreenDimensions(mMovie)
		local rootBasedPosition, _ = module.GetRootBasedPosition(mMovie, "PopupFrame.Panel")
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Panel", 0)
		v6 = screenDimensions - (rootBasedPosition + 79)
		mMovie:__wf_atom_e57658c2("PopupFrame.Panel", 14, v6)
		mMovie:__wf_atom_e57658c2("PopupFrame.Watermark", 0, __wf_atom_5e6e15c8 + (v6 - 112))
		mMovie:__wf_atom_e57658c2("PopupFrame.RecurringBacker", 0, __wf_atom_5e6e15c8 + (v6 - 2))
		mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn", 0, __wf_atom_5e6e15c8 + (v6 - 45))
		mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel", 0, v6 / 2)
		module6.DrawSeparator(mMovie, "PopupFrame.Underline", v6 - 40)
		local v50 = math.min(1093.47, v6 - 100)
		mMovie:__wf_atom_e57658c2("TransmissionFrame", 14, v50)
		mMovie:__wf_atom_e57658c2("TransmissionFrame", 0, rootBasedPosition + (v6 - v50) / 2)
		mMovie:__wf_atom_e57658c2("PopupFrame.Subject", 14, v6 - 105)
		mMovie:__wf_atom_e57658c2("PopupFrame.Timestamp", 14, v6 - 105)
		mMovie:__wf_atom_e57658c2("PopupFrame.Content.MsgText", 14, v6 - 45)
		mMovie:__wf_atom_e57658c2("PopupFrame.ScrollBarContent", 0, __wf_atom_5e6e15c8 + (v6 - 15))
		mMovie:__wf_atom_e57658c2("Empty", 1, module.Round(v49 / 2))
		mMovie:__wf_atom_e57658c2("Empty.Bg", 14, screenDimensions + 20)
		mMovie:__wf_atom_e57658c2("Empty.Label", 0, screenDimensions / 2 - 100)

		if not __wf_atom_7e8ad928(v12) then
			mMovie:__wf_atom_50d60589("PopupFrame.Subject", 36, "")
			mMovie:__wf_atom_50d60589("PopupFrame.Timestamp", 36, "")
			mMovie:__wf_atom_50d60589("PopupFrame.Content.MsgText", 36, "")
			fn24(v12.Id)
			return
		end
	end

	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("PopupFrame", 1)
	local v49 = v2.mVisibleElements * v2.mForcedVerticalSeparation - 5
	local visibilitySize = module.GetVisibilitySize(mMovie, v49)
	local visibilityCenter = module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8 + v49 / 2)
	messageListVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	messageListVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	messageListTextVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	messageListTextVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	messageBackerVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
	messageBackerVisibleRangeMaterial:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
	v32 = 615 - v31
	v4.mHeight = v32 + 10
	local visibilitySize2 = module.GetVisibilitySize(mMovie, v32)
	local visibilityCenter2 = module.GetVisibilityCenter(mMovie, __wf_atom_5e6e15c8 + v31 + v32 / 2)
	local v50 = { contentVisibleRangeMaterial, contentTextVisibleRangeMaterial, contentRectangleVisibleRangeMaterial }

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v51 in pairs(uiMaterial_Mod) do
			table.insert(v50, v51)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v51 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v50, v51)
		end
	end

	for _, v51 in pairs(_G.UIMaterial_ArchonShardsStore) do
		table.insert(v50, v51)
	end

	for _, v51 in pairs(_G.UIMaterial_CosmeticEnhancersStore) do
		table.insert(v50, v51)
	end

	for _, v51 in pairs(v50) do
		v51:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize2)
		v51:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter2)
	end
end

function onViewportSizeChanged(_, _)
	fn2(true)
end

local function fn29()
	if __wf_atom_7e8ad928(giftOpeningFx) then
		return
	end

	local rootBasedPosition, v49 = module3.GetRootBasedPosition(mMovie, "PopupFrame.Content.GiftPanel.Gift")
	v28 = module3.CreateScreenParticles(mMovie, giftOpeningFx, rootBasedPosition, v49 - 30)

	if not __wf_atom_7e8ad928(v28) then
		module3.ApplyParticleThemeColors(v28)
	end

	module.PlaySound(openGiftSound)
end

fn6 = function()
	if __wf_atom_7e8ad928(v12) then
		return
	end

	local v49 = v3[v12.Id]

	if __wf_atom_7e8ad928(v49) then
		return
	end

	if not __wf_atom_7e8ad928(v49.mGifts) then
		for i = 1, #v49.mLocalizationArgs do
			if tostring(v49.mLocalizationArgs[i].mKey) == "GIFT_QUANTITY" then
				mTag = tonumber((tostring(v49.mLocalizationArgs[i].mTag)))
			end
		end

		v40 = {}

		if #v49.mGifts > 1 then
			if v13:__wf_atom_232fd31d(v49.mGifts[1].mGiftType):__wf_atom_efa6f447() == 17 then
				for i = 2, #v49.mGifts do
					local __wf_atom_232fd31d = v13:__wf_atom_232fd31d(v49.mGifts[i].mGiftType)

					if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
						table.insert(v40, { __wf_atom_232fd31d, v49.mGifts[i].mFingerprint })
					end
				end
			else
				print("multiple stackable items received")
			end
		end
	end

	fn20()
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndPlay", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndPlay", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndPlay", 1)
	local v50 = { function(p)
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Name", 12, p)
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Desc", 12, p)
			v23:SetAlpha(100 - p)
		end }
	__wf_atom_ec43d06e(mMovie, "PopupFrame.Content.GiftPanel.Gift.Name", 8, v50, { 100 }, 2, 0, function()
		v23:SetVisible(false)
	end)
	v7:AddTimer(3, function()
		v29 = #v40 > 0

		if #v40 > 0 then
			v25 = #v40 / mTag
			v26 = 1
			v27 = mTag
			mMovie:__wf_atom_e57658c2("_root", 12, 0)
			fn8()
		end
	end)
end

function AcknowledgeGift()
	if __wf_atom_7e8ad928(v12) or fn10() then
		return
	end

	local v49 = v3[v12.Id]

	if __wf_atom_7e8ad928(v49) then
		return
	end

	fn17(v49.mId)
end

local function fn30()
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.GiftPanel", 13, false)
	mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel", "Glow", 11, v19.Background3)
	mMovie:__wf_atom_c90af43a("PopupFrame.Content.GiftPanel.Gift.Item.Backer", _G.UITexture_Blueprint)
	mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel", "Name", 44, v19.FloatingContent)
	mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel", "Desc", 44, v19.Content)
	mMovie:SetFrameCallback("PopupFrame.Content.GiftPanel.Gift", "OnGiftFrame")
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndStop", 1)
	local module8 = require("Lotus.Interface.Components.ThemedButton")
	v23 = module8.Create(
		mMovie,
		"PopupFrame.Content.GiftPanel.UnwrapBtn",
		"/Lotus/Language/Inbox/GiftUnwrap",
		"AcknowledgeGift"
	)
	v23.mAnchor = module.CENTER_ALIGNED
	v23:SetSpecialMode(true)
	v23:Redraw()
end

function OnGiftFrame(_, p)
	if p == "Effects" then
		fn29()
	end
end

local function fn31()
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.MsgText", 44, v19.Content)
	mMovie:OverrideMaterial("PopupFrame.Content.MsgText", contentTextVisibleRangeMaterial)
	fn30()
end

local function fn32()
	purchasedItems = module3.GetAllPurchasedItems()
	local module8 = require("EE.Interface.Components.Grid")
	v5 = module8.CreateGrid(mMovie, "PopupFrame.Content.AttachmentGrid.Attachment", nil, 5, 5)
	v5:SetCallbacks("AttachmentPressed", "AttachmentFocused", "AttachmentUnfocused")
	v5.mShowLabels = true
	v5.PurchasedItems = purchasedItems
	v5.PurchasedIsDictionary = true
	v5.ElementDimBuffer = 10
	v5.ElementWidth = 160
	v5.ElementHeight = 160
	v5.Height = 3000
	v5.RectangleVisibleRangeMaterial = contentRectangleVisibleRangeMaterial
	v5.VisibleRangeMaterial = contentVisibleRangeMaterial
	v5.TextVisibleRangeMaterial = contentTextVisibleRangeMaterial
	v5.FlareVisibleRangeMaterial = contentFlareVisibleRangeMaterial
	module6.InitializeGridItem(mMovie, v5)

	function v5.mClipCreatedCallback(p, _)
		module6.OnGridItemCreated(mMovie, v5, p)
	end

	function v5.mOnFocusedCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		module6.OnGridItemFocusChanged(mMovie, v5, p, {
			IsFocused = true,
			ShowInfoPopup = true,
			DisableSaturation = true
		})
	end

	function v5.mOnUnfocusedCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		module6.OnGridItemFocusChanged(mMovie, v5, p, {
			HideLockedOnFocus = true,
			IsFocused = false,
			DisableSaturation = true
		})
	end

	function v5.mElementDrawCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		local focusedElement = v5:GetFocusedElement()
		local isFocused = focusedElement ~= nil and focusedElement.Id == p.Id
		module6.DrawGridItem(mMovie, v5, p, { IsFocused = isFocused, DisableSaturation = true })
	end
end

function OnEmblemReady(p, p2)
	if p and not Resource(p2):__wf_atom_5583ebb9() then
		uiTexture_DefaultClan = Resource(p2)

		if not __wf_atom_7e8ad928(v2) then
			v2:RunForAllVisibleElements(function(p3)
				v2.mElementDrawCallback(p3)
			end)
		end
	end
end

function Initialize()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	v43 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	_T.OpeningMailbox = nil

	if __wf_atom_7e8ad928(v43) then
		mMovie:Close()
		return
	end

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()

		if not __wf_atom_7e8ad928(settings) then
			v41 = settings:__wf_atom_bb0f4637()
			v42 = settings:__wf_atom_a35494b3()
		end
	end

	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v7 = module8.CreateTimerMgr()
	uiTexture_DefaultClan = _G.UITexture_DefaultClan

	if
		not module.IsUGCRestricted()
		and v43:__wf_atom_5ff594a3() ~= ""
		and v43:__wf_atom_620befcd()
		and not v43:__wf_atom_100362b3()
	then
		local __wf_atom_5ff594a3 = v43:__wf_atom_5ff594a3()
		local __wf_atom_0b80c61f = __wf_atom_c67f9605:__wf_atom_0b80c61f(__wf_atom_5ff594a3)

		if __wf_atom_0b80c61f ~= nil then
			gGameRules:RequestResource(__wf_atom_0b80c61f, "OnEmblemReady")
		end
	end

	v19 = {
		Content = module5.GetColor(6, true),
		Background1 = module5.GetColor(2, true),
		Background3 = module5.GetColor(4, true),
		FloatingContent = module5.GetColor(9, true),
		FloatingContentHighlight = module5.GetColor(10, true)
	}
	v19.Background1Object = module.ConvertColorNumberToProceduralRGB(v19.Background1)
	v19.FloatingContentObject = module.ConvertColorNumberToProceduralRGB(v19.FloatingContent)
	v19.FloatingContentHighlightObject = module.ConvertColorNumberToProceduralRGB(v19.FloatingContentHighlight)
	v47 = module3.HasCompletedNewWar()

	if v47 then
		v48.localizedName = module3.GetLocalizedLotusName()
	else
		v48.localizedName = Localize("/Lotus/Language/Menu/Mailbox_WarframeSender", {})
	end

	local v49 = {}

	if not __wf_atom_7e8ad928(gGameRules) then
		v13 = gGameRules:__wf_atom_964056fd()
	end

	if __wf_atom_7e8ad928(v13) then
		table.insert(v49, __wf_atom_c67f9605:__wf_atom_964056fd():__wf_atom_5b41f63b())
	end

	if #v49 > 0 then
		flag = true
		v14 = UISys.__wf_atom_c0dbe47c(v49)
	end

	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	local v50

	if not __wf_atom_7e8ad928(gRegion) then
		v50 = gRegion:__wf_atom_c4f78a8f()
	end

	if v50:__wf_atom_f63d17c0() then
		v50:__wf_atom_e424c72a(false)

		if _T.DailyTributeLoginState == nil then
			v44 = true
		end
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0.25, nil, false)
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mailbox_Inbox", false))
	end

	local v51 = string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mailbox_NoMessages", true))
	mMovie:__wf_atom_7d7314f1("Empty.Label.text", v51)
	mMovie:__wf_atom_e57658c2("Empty.Label", 44, v19.FloatingContent)
	mMovie:OverrideMaterial("Empty.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Empty.Bg",
		"RectInnerColor",
		v19.Background1Object.r,
		v19.Background1Object.g,
		v19.Background1Object.b,
		0.9
	)
	mMovie:__wf_atom_1ca72041(
		"Empty.Bg",
		"RectEdgeColor",
		v19.FloatingContentObject.r,
		v19.FloatingContentObject.g,
		v19.FloatingContentObject.b,
		0.2
	)
	mMovie:__wf_atom_2dedec1a("PopupFrame.RecurringBacker", 13, false)
	mMovie:__wf_atom_e57658c2("PopupFrame.RecurringBacker", 12, 80)
	mMovie:__wf_atom_e57658c2("PopupFrame.Underline", 11, v19.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("PopupFrame.Watermark", 11, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.Subject", 44, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.Timestamp", 44, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.Unread", 44, v19.FloatingContent)
	mMovie:OverrideMaterial("PopupFrame.Panel", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"PopupFrame.Panel",
		"RectInnerColor",
		v19.Background1Object.r,
		v19.Background1Object.g,
		v19.Background1Object.b,
		0.9
	)
	mMovie:__wf_atom_1ca72041(
		"PopupFrame.Panel",
		"RectEdgeColor",
		v19.FloatingContentObject.r,
		v19.FloatingContentObject.g,
		v19.FloatingContentObject.b,
		0.2
	)
	mMovie:__wf_atom_2dedec1a("PopupFrame.TransBtn", 13, false)
	mMovie:SetCallbacks("PopupFrame.TransBtn.Btn", "TransBtnFocused", "TransBtnUnfocused", "TransBtnPressed", nil)
	mMovie:OverrideMaterial("PopupFrame.TransBtn.Icon", _G.UIMaterial_VitruvianLines)
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Icon", 11, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Outline", 11, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Outline", 12, 20)
	fn31()
	fn32()
	mMovie:__wf_atom_2dedec1a("TransmissionFrame.ImageOuter.Image", 13, false)
	__wf_atom_86cbd68d(mMovie, "TransmissionFrame.ImageOuter.Image.swapDepths", 3000)
	mMovie:__wf_atom_2dedec1a("Empty", 13, false)
	mMovie:__wf_atom_2dedec1a("PopupFrame", 13, false)
	mMovie:__wf_atom_e57658c2("PopupFrame.Bg", 12, 0)

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("PopupFrame.Subject", 49, "Arial Unicode MS")
	end

	local module9 = require("Lotus.Interface.Components.ThemedSpinner")
	v30 = module9.Create(mMovie, "Spinner")
	v30:SetActive(flag or not _T.SkipMailboxSync)

	if _T.SkipMailboxSync then
		fn28()
	else
		v43:__wf_atom_6646ca4d("OnInboxSyncComplete")
	end

	_T.SkipMailboxSync = false

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_INBOX")
	end

	if Engine.__wf_atom_2a979d69() then
		mMovie:__wf_atom_dac78d3d(true)
	end
end

function Shutdown()
	fn14(0)

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_INBOX")
	end

	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
	module6.ClearGridModMaterials()

	if not __wf_atom_7e8ad928(v28) then
		v28:Destroy()
		v28 = nil
	end

	if not (__wf_atom_7e8ad928(_T.HideBackground) or v8) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	if not __wf_atom_7e8ad928(gRegion) and v44 then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_e424c72a(true)
		end
	end
end

function Update()
	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Update(__wf_atom_fa1258d0())
	end

	if not __wf_atom_7e8ad928(v30) then
		v30:Update()
	end

	if v39 ~= nil and v39:IsLoading() and v39:LoadingComplete() then
		v39:FinishLoad()
	end

	if v9 ~= nil and not __wf_atom_7e8ad928(_T.curTransmission) then
		if not v11 and v9 == _T.curTransmission then
			v10 = _T.curTransmission:__wf_atom_cb26a501()
			v11 = true
		end

		if v9 ~= _T.curTransmission then
			if __wf_atom_7e8ad928(v10) or v10 ~= _T.curTransmission then
				fn9()
			else
				v9 = v10
				v10 = v9:__wf_atom_cb26a501()
			end
		end
	end

	if fn10() then
		return
	end

	if flag then
		if not v14:__wf_atom_86399a47() then
			return
		end

		flag = false

		if __wf_atom_7e8ad928(v13) then
			v13 = Resource(__wf_atom_c67f9605:__wf_atom_964056fd())
		end

		if __wf_atom_7e8ad928(v15) then
			v15 = Resource(loginRewardsManifestType)
		end

		if flag2 then
			fn27()
		end
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Update(__wf_atom_fa1258d0())
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		print("Inbox: new build is available! Bailing since message could contain new items that don't exist in current build.")

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowRequireExitMessage", "/Lotus/Language/Menu/MainMenu_NewBuildAvailable")
		end

		if _T.IsInScreenStack == nil or not _T.IsInScreenStack("Inbox") then
			fn13()
		else
			_T.GoToPreviousScreen()
		end
	else
		if v45 and not flag4 then
			v46 -= __wf_atom_084b3e93()

			if v46 < 0 then
				v46 = 3
				module.CreateParticles(mMovie, "PopupFrame.TransBtn", replayTransmissionPulseFx, 0, 27)
			end
		end

		if v37 and not flag then
			v37 = false
			fn23(mCinematic)
		end
	end
end

local function fn33(instance)
	local v49 = Resource(instance)
	local module8 = require("Lotus.Interface.Libs.DioramaLoader")
	v39 = module8.CreateDioramaLoader(mMovie)
	v39:LoadDiorama(v49:GetInfo().level)
end

local function fn34(p)
	mMovie:__wf_atom_2dedec1a("TransmissionFrame.ImageOuter.Image", 13, p)
	mMovie:__wf_atom_2dedec1a("PopupFrame", 67, not p)
	__wf_atom_ec43d06e(mMovie, "PopupFrame.MessageList", 8, { function(p2)
			local ternary = module.Ternary(p, 100 - p2, 30 + p2)
			mMovie:__wf_atom_e57658c2("PopupFrame.MessageList", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.SortMenu", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.Unread", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.ScrollBarMessages", 12, ternary)
		end }, { 70 }, 1, 0)
end

fn = function(mTransmission2)
	if __wf_atom_7e8ad928(mTransmission2) then
		return
	end

	v20[2].mVisible = false
	fn11()
	flag4 = true
	v38 = false
	_T.RadioChatterDisabled = true

	if not __wf_atom_7e8ad928(_T.curTransmission) then
		module3.ClearTransmissionQueue()
		module3.InterruptTransmission()
	end

	if mTransmission2:IsA(__wf_atom_bfb77700) then
		fn33(mTransmission2)
		return
	end

	module3.ForceCloseTransmission(true)
	fn34(true)
	_T.TransmissionOverrideMovie = mMovie
	_T.TransmissionOverrideMainClipName = "TransmissionFrame"
	_T.TransmissionOverrideX = mMovie:__wf_atom_5e6e15c8("PopupFrame.ImageOuter", 14)
	_T.TransmissionOverrideY = mMovie:__wf_atom_5e6e15c8("PopupFrame.ImageOuter", 15)
	v9 = mTransmission2
	v11 = false
	module3.CreateHudlessTransmission(mTransmission2)
end

fn9 = function()
	if v9 == nil then
		return
	end

	v9 = nil
	v10 = nil
	fn34(false)
	v20[2].mVisible = true
	fn11()
	fn24(id)

	if
		not v38
		and not __wf_atom_7e8ad928(v3)
		and id ~= nil
		and not (__wf_atom_7e8ad928(v3[id]) or __wf_atom_7e8ad928(v3[id].mOrdisReactionTransmission))
	then
		module3.ForceCloseTransmission(true)
		module3.CreateHudlessTransmission(v3[id].mOrdisReactionTransmission)
	end

	flag4 = false
	_T.RadioChatterDisabled = nil

	if not __wf_atom_7e8ad928(v36) and v36:__wf_atom_8598f3a9() then
		_T.QuickSelectTutorialName = tostring(v36)
		_T.OpenScreen("Intel")
		fn13()
	end
end

function OnTransmissionDone()
	fn9()
end

local function fn35()
	v38 = true

	if v39 == nil then
		local movie = __wf_atom_8e4fda44:FindMovie(transmissionMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("PreviewClose", "")
		end
	else
		fn9()
		v39:LoadDiorama(nil)
		v39 = nil
	end
end

function OnClosePressed()
	if flag4 then
		fn35()
		return
	end

	if _T.IsInScreenStack ~= nil and _T.IsInScreenStack("Inbox") then
		_T.GoToPreviousScreen()
		return
	end

	fn13()
	module.PlaySound(_G.UISound_GridOpenTwo)
end

local function fn36()
	if not (__wf_atom_7e8ad928(welcomeToClanScreen) or __wf_atom_8e4fda44:__wf_atom_6b69b901(welcomeToClanScreen)) then
		mMovie:PushChildMovie(welcomeToClanScreen)
	end
end

function OpenClanWelcome()
	fn36()
end

local function fn37()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01())) then
		return
	end

	local v49 = nil

	for i = 1, #v3 do
		if v3[i].mAcceptAction == 2 then
			v49 = i
		end
	end

	if v49 == nil then
		fn36()
		flag3 = false
		mContextInfo = nil
	elseif v3[v49].mContextInfo == mContextInfo then
		fn3((tostring(v3[v49].mId)))
	else
		fn4(v3[v49].mContextInfo, true)
	end
end

fn3 = function(p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v29 = true

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end

	gGameData:DeleteInboxMessage(p, "OnDeleteMessage")
end

function OnDeleteMessage()
	v29 = false

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01()))) then
		fn16()
		fn26()
	end

	if flag3 then
		fn37()
	end

	module.PlaySound(_G.UISound_GridOpenTwo)
end

function OnDeleteMessagePressed()
	if fn10() or id == nil or __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())) then
		return
	end

	if v3 == nil or #v3 < id then
		return
	end

	local v49 = v3[id]
	local mDeclineAction = v49.mDeclineAction

	if mDeclineAction == 0 then
		fn3((tostring(v3[id].mId)))
		id = nil
	elseif mDeclineAction == 2 then
		fn4(v49.mContextInfo, true)
	elseif mDeclineAction == 3 then
		fn4(v49.mContextInfo)
	end
end

function ConfirmDeleteAllReadMessages(p)
	if tonumber(p) ~= 4 or __wf_atom_7e8ad928((__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01())) then
		return
	end

	if v3 == nil or #v3 < id then
		return
	end

	fn3("DeleteAllRead")
	id = nil
end

function OnDeleteAllReadMessagesPressed()
	if fn10() or id == nil then
		return
	end

	module.ShowYesOrNoMessage("/Lotus/Language/Menu/Mailbox_DeleteAllReadConfirmation", "ConfirmDeleteAllReadMessages")
end

function RollOver()
	module.PlaySound(beepSound)
end

function ElementFocused(p)
	if not (fn10() or __wf_atom_7e8ad928(v2)) then
		v2:FocusElementById(tonumber(p), true)
	end
end

function ElementUnfocused(p)
	if not __wf_atom_7e8ad928(v2) then
		v2:UnfocusElementById((tonumber(p)))
	end
end

function ElementPressed(p)
	if not (fn10() or __wf_atom_7e8ad928(v2)) then
		v2:SelectElementById((tonumber(p)))
	end
end

function ContentScrubStartDrag()
	if not __wf_atom_7e8ad928(v4) then
		v4:StartDrag()
	end
end

function ContentScrubStopDrag()
	if not __wf_atom_7e8ad928(v4) then
		v4:StopDrag()
	end
end

function ContentScrollBarClick()
	if not __wf_atom_7e8ad928(v4) then
		v4:ClickScrollBar()
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not (flag4 or __wf_atom_7e8ad928(v2)) then
		local mScrollBar = v2.mScrollBar

		if mMovie:__wf_atom_5e6e15c8("_root", 30) > 550 then
			mScrollBar = v4
		end

		if
			not fn10()
			and not __wf_atom_7e8ad928(mScrollBar)
			and mMovie:__wf_atom_a91463a8(mScrollBar.mClipName, 13)
		then
			mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
		end
	end
end

local function fn38(mTeleportLocation)
	local v49 = mTeleportLocation == 1 and "Market" or ""
	local movie = __wf_atom_8e4fda44:FindMovie(topMenuMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("TriggerConsole", v49)
	end
end

local function fn39()
	print("guild invitation declined")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01())) then
		return
	end

	local v49 = v3[id]
	local mDeclineAction = v49.mDeclineAction
	local state = v22.State

	if mDeclineAction == 2 then
		fn4(v49.mContextInfo, true)
	elseif mDeclineAction == 3 then
		fn4(v49.mContextInfo)
	elseif v49.mTeleportLocation ~= 0 then
		fn38(v49.mTeleportLocation)
	elseif v49.mSubject == twitchPrimeSubject then
		module.DoOpenWebBrowser(twitchPrimeURL, nil, true)

		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("OPENED_BROWSER_LINK"), "INBOX_TWITCH")
		end
	elseif v49.mURL ~= "" then
		module.DoOpenWebBrowser(v49.mURL, nil, true)
	elseif state == v16.EMAIL_SETTINGS and not __wf_atom_7e8ad928(_T.TopMenuMovie) then
		if _T.TopMenuMovie:Execute("DisableCloseWhenChildMovieIsDone", "") then
			_T.Settings_CloseTopMenu = true
		end

		v8 = true
		_T.Settings_AutoSelectCategory = "Account"
		_T.TopMenuMovie:Execute("AutoSelectElement", "Settings")
		fn13()
	end
end

function OnDeclinePressed()
	fn39()
end

local function fn40()
	print("guild or alliance invitation confirmed or join request accepted")
	fn3((tostring(v3[id].mId)))
	v21:SetVisible(false)
	v22:SetVisible(false)
end

function OnAcceptAction(p, _)
	v29 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		fn40()
	end
end

function OnAcceptActionAlliance(p, _)
	v29 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p == 0 then
		fn40()
	else
		local flag5 = true
		local v49

		if p == 101 then
			v49 = "/Lotus/Language/Menu/SocialOverlay_NonExistentGuildError"
		elseif p == 103 then
			v49 = "/Lotus/Language/Clan/AddToAllianceFail_MaxSize"
		elseif p == 104 then
			v49 = "/Lotus/Language/Dojo/Generic_INVALID_PERMISSION"
		elseif p == 105 then
			v49 = "/Lotus/Language/Clan/ConfirmAllianceFail_TryAgain"
			flag5 = false
		else
			v49 = "/Lotus/Language/Clan/ConfirmAllianceFail_Generic"
		end

		module.ShowMessage(v49)

		if flag5 then
			fn39()
		end
	end
end

function OnAcceptClanInvite(p, value)
	v29 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		fn37()
		return
	end

	module.ShowMessage("/Lotus/Language/Clan/ConfirmGuildFail")
	flag3 = false

	if string.find(value, "Log%-in") == nil then
		fn3((tostring(v3[id].mId)))
	end
end

function OnBoosterPackShown()
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	v29 = false
end

fn8 = function()
	_T.boosterPackCards = {}

	for _ = 1, v25 do
		table.insert(_T.boosterPackCards, v40[1])
		table.remove(v40, 1)
	end

	v27 -= 1
	_T.queuedBoosterPacks = module.Ternary(v27 == 0, nil, v27)
	local v49 = mMovie:PushChildMovie(boosterPackMovie)
	module.PlaySound(_G.UISound_Purchase)

	if v27 < 1 then
		v49:Execute("SetCallback", "OnBoosterPackShown")
	else
		v49:Execute("SetCallback", "ProcessBoosterPacks")
	end

	if mTag > 1 then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Pack_Display_Count", false)
		v49:Execute("SetCaption", (string.format(__wf_atom_8e9ac384, v26, mTag)))
	end

	v49:Execute("SetNumOptions", 1)
	v26 += 1
end

function ProcessBoosterPacks()
	fn8()
end

function OnAcceptPressed()
	if v3 == nil or #v3 < id then
		return
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return
	end

	local v49 = v3[id]

	if not __wf_atom_7e8ad928(v49.mGifts) then
		return
	end

	local mAcceptAction = v49.mAcceptAction

	if mAcceptAction == 2 or mAcceptAction == 3 or mAcceptAction == 4 then
		v29 = true

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		end
	end

	if mAcceptAction == 2 then
		flag3 = true
		mContextInfo = v49.mContextInfo
		__wf_atom_9be88b01:__wf_atom_dafee647("OnAcceptClanInvite", v49.mContextInfo)
	elseif mAcceptAction == 3 then
		__wf_atom_9be88b01:__wf_atom_0e30f5e7("OnAcceptActionAlliance", v49.mContextInfo)
	end

	print(mAcceptAction)
end

local function fn41(value)
	if string.find(string.lower(value), "not in a guild") ~= nil then
		return true
	end

	if string.find(value, "Request not valid anymore.") == nil then
		return string.find(value, "Only a ruler can leave an alliance") ~= nil
	end

	return true
end

fn4 = function(mContextInfo2, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v29 = true

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end

	if p then
		gGameData:__wf_atom_35d6ac08(mContextInfo2, "OnDeclineAction")
	else
		gGameData:__wf_atom_5b148924(mContextInfo2, "OnDeclineAction")
	end
end

function OnDeclineAction(p, p2)
	v29 = false

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	local v49 = fn41(p2)

	if not (p or v49) then
		print(p2)
		return
	end

	print("guild or alliance invitation declined")

	if v49 then
		print(p2)
	end

	local mDeclineAction = v3[id].mDeclineAction

	if mDeclineAction == 2 or mDeclineAction == 3 or mDeclineAction == 4 then
		fn3((tostring(v3[id].mId)))
	end

	v21:SetVisible(false)
	v22:SetVisible(false)
end

function OnGamepadTransition(p)
	local v49 = p == "true"

	if not __wf_atom_7e8ad928(v21) then
		local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v21.mClipName, 13)
		mMovie:__wf_atom_976dcedd(v21.mClipName, "forceMenuSelection", __wf_atom_a91463a8 and not v49)
		v21:Redraw()
	end

	if not __wf_atom_7e8ad928(v22) then
		local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v22.mClipName, 13)
		mMovie:__wf_atom_976dcedd(v22.mClipName, "forceMenuSelection", __wf_atom_a91463a8 and not v49)
		v22:Redraw()
	end
end

function TransBtnFocused()
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Icon", 11, v19.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Outline", 12, 80)
end

function TransBtnUnfocused()
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Icon", 11, v19.FloatingContent)
	mMovie:__wf_atom_e57658c2("PopupFrame.TransBtn.Outline", 12, 20)
end

function TransBtnPressed()
	if mTransmission == nil then
		if not __wf_atom_7e8ad928(mCinematic) then
			v37 = true
		end
	elseif not flag4 then
		fn(mTransmission)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v) then
		v:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v) then
		v:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (fn10() or __wf_atom_7e8ad928(v)) then
		v:SelectElementById(tonumber(p), true)
	end
end

function AttachmentFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:FocusElementById((tonumber(p)))
	end
end

function AttachmentUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElementById((tonumber(p)))
	end
end

function SupportsThemes()
	return true
end

function HideScreenForPlatPurchase(p)
	if p == "true" then
		__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0)
	else
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.15, 0)
	end
end

local v49 = 0
local v50 = 0
local v51 = false

function onRawInputEvent(_, p, p2)
	if Engine.__wf_atom_2a979d69() and not __wf_atom_7e8ad928(v4) and v4.mIsActive then
		if p == "EN_MOUSE_B0" then
			v49 = mMovie:__wf_atom_7c4b8de8()
			v50 = -v4:GetScrollValue()

			if p2 == "1" then
				v51 = true
			else
				v51 = false
			end
		elseif p == "EN_MOUSE_Y" and v51 then
			local __wf_atom_7c4b8de8 = mMovie:__wf_atom_7c4b8de8()
			local v52 = __wf_atom_7c4b8de8 - v49
			v49 = __wf_atom_7c4b8de8
			local _, v53 = module.GetScreenDimensions(mMovie)
			v50 += v52 / v53
			v4:SetScrollValue(-v50, nil, true)
		end
	end
end