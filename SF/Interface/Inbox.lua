local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.StoreItemUtilities")
local module4 = require("SF.Interface.Libs.UIUtilities")
local module5 = require("SF.Interface.Libs.ItemUtil")
local module6 = require("Lotus.Scripts.Libs.StoryLib")
local module7 = require("Lotus.Interface.CrossPlatformUtilities")
local module8 = require("SF.Interface.Libs.OdeCipher")
local module9 = require("EE.Interface.AnchorMgr")
local v = {
	NONE = 1,
	ACCEPT_DECLINE = 2,
	GIFT = 3,
	TELEPORT = 4,
	WEB_BROWSER = 5,
	EMAIL_SETTINGS = 6,
	MUSEUM = 7,
	COUPON = 8
}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = false
local uiTexture_DefaultClan = nil
local v12 = nil
local id = 1
local v13 = nil
local v14 = nil
local v15 = false
local v16 = nil
local v17 = false
local v18 = false
local flag = false
local v19 = WeakResource("/Lotus/Types/Items/ShipFeatureItems/ShipFeatureItem")
local v20 = WeakResource("/SF/Interface/Graphics/StoreItems/Ancestors/CharacterPortrait")
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = 0
local v27 = 1
local v28 = 0
local v29 = nil
local v30 = false
local v31 = nil
local v32 = 0
local v33 = nil
local flag2 = false
local mContextInfo = nil
local mTransmission = nil
local v34 = nil
local mCinematic = nil
local mMuseum = nil
local mCustomData = nil
local v35 = false
local flag3 = false
local v36 = nil
local v37 = {}
local v38 = false
local mTag = 1
local v39 = false
local v40 = 0
local v41 = nil

local function fn(p)
	if __wf_atom_7e8ad928(v3) then
		return
	end

	if p then
		local _, v42 = module.GetScreenDimensions(mMovie)
		mMovie:__wf_atom_e57658c2("Empty", 1, module.Round(v42 / 2))

		if not __wf_atom_7e8ad928(v12) then
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Subject", 36, "")
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Timestamp", 36, "")
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Body.Message.Label", 36, "")
			UpdateMessageContent(v12.Id)
		end
	end
end

function onViewportSizeChanged(_, _)
	fn(true)
end

function IsInputBlocked()
	return v30 or _T.StoryLib_PlayingCin
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

local function fn2()
	if __wf_atom_7e8ad928(v3) then
		return
	end

	local count = 0
	v3:RunForAllElements(function(p)
		local v42 = v4[p.Id]

		if not __wf_atom_7e8ad928(v42) and (not v42.mIsRead or p.mSkipRead) then
			count += 1
		end
	end)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Messages.Unread", 13, count > 0)
	mMovie:__wf_atom_7d7314f1("PopupFrame.Messages.Unread.text", "/SF/Language/Inbox/UnreadCount", {
		COUNT = module.FormatNumber(count)
	})
end

local function fn3(mContextInfo2, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v30 = true

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end

	if p then
		gGameData:__wf_atom_35d6ac08(mContextInfo2, "OnDeclineAction")
	else
		gGameData:__wf_atom_5b148924(mContextInfo2, "OnDeclineAction")
	end
end

local function fn4()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()
	return not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) and __wf_atom_2ad5cd23:__wf_atom_6d61d595() == topMenuMovie
end

local function fn5(p, value)
	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:Execute(p, value or "")
		return
	end

	print(p)
	LogBug("callback failed because mMovie is null")
end

local function fn6()
	local topMenuChildButtons = {}

	if #v4 > 0 and _T.InboxCinematic == nil then
		table.insert(topMenuChildButtons, {
			Label = "/Lotus/Language/Menu/Mailbox_DeleteAllRead",
			CallBack = function()
				fn5("OnDeleteAllReadMessagesPressed")
			end,
			CallOut = "MENU_RTHUMB"
		})
		table.insert(topMenuChildButtons, {
			Label = "/Lotus/Language/Menu/Mailbox_Delete",
			CallBack = function()
				fn5("OnDeleteMessagePressed")
			end,
			CallOut = "MENU_GENERIC2"
		})
	end

	_T.TopMenuChildButtons = topMenuChildButtons
	_T.TopMenuChildButtonOptions = nil

	if fn4() then
		mMovie:__wf_atom_2ad5cd23():Execute("UpdateButtons", "")
	elseif not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, topMenuChildButtons, getfenv(1))
	end
end

local function fn7(p)
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

	local soulframeSupportIcon2 = Resource(mSenderIcon)

	if soulframeSupportIcon2 == nil and p.mSender == "/Lotus/Language/Menu/Mailbox_WarframeSupportSender" then
		soulframeSupportIcon2 = soulframeSupportIcon
	end

	return soulframeSupportIcon2
end

local function fn8()
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v4 = gGameData:__wf_atom_90763c09()

	for _, tmpFilterMessageId in ipairs(_T.TMPFilterMessageIds) do
		for i = 1, #v4 do
			if v4[i].mId ~= tmpFilterMessageId then
				continue
			end

			table.remove(v4, i)
			break
		end
	end

	for i = #v4, 1, -1 do
		local v42 = v4[i]

		if not (string.find(v42.mSender, "^/Lotus/") or string.find(v42.mSubject, "^/Lotus/")) then
			continue
		end

		table.remove(v4, i)
	end
end

local function fn9(p)
	local v42 = v4[p]
	local v43 = #v42.mAttachments
	local v44 = #v42.mCountedAttachments
	local count = #v42.mCoupons
	local v45 = #v42.mSyndicateAttachments
	local v46 = {}
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.ClaimCouponBtn", 13, false)

	if v42.mCredits > 0 then
		local v47 = { Count = v42.mCredits }
		v47.Icon = largeCreditsIcon
		v47.Themed = true
		v47.Name = module.SeparateWithCommas(v42.mCredits, 0) .. " " .. Localize("/SF/Language/Currency/CurrencyName", nil)
		v47.LocalizedDesc = Localize("/SF/Language/Currency/CurrencyDesc", nil)
		v47.CustomEntry = true
		table.insert(v46, v47)
	end

	if v42.mPremiumCredits > 0 then
		local v47 = { Count = v42.mPremiumCredits }
		v47.Icon = largePlatIcon
		v47.Themed = true
		v47.Name = module.SeparateWithCommas(v42.mPremiumCredits, 0) .. " " .. Localize("/SF/Language/Currency/PremiumCurrencyName", nil)
		v47.LocalizedDesc = Localize("/SF/Language/Currency/PremiumCurrencyDesc", nil)
		v47.CustomEntry = true
		table.insert(v46, v47)
	end

	if v42.mPrimeTokens > 0 then
		local v47 = { Count = v42.mPrimeTokens }
		v47.Icon = primeTokenIcon
		v47.Themed = true
		v47.Name = module.SeparateWithCommas(v42.mPrimeTokens, 0) .. " " .. Localize("/Lotus/Language/PrimeStore/Store_PrimeTokens", {})
		v47.CustomEntry = true
		table.insert(v46, v47)
	end

	for i = 1, v43 do
		local mAttachment = v42.mAttachments[i]
		local v47 = nil

		if not __wf_atom_7e8ad928(mAttachment) then
			if mAttachment:IsA(__wf_atom_cb425ff5) then
				v47 = Resource(mAttachment)
			elseif mAttachment:IsA(__wf_atom_f3c8513b) and not __wf_atom_7e8ad928(v13) then
				v47 = v13:__wf_atom_232fd31d(mAttachment)
			end
		end

		if __wf_atom_7e8ad928(v47) or __wf_atom_7e8ad928(v47:GetIconTexture()) then
			continue
		end

		table.insert(v46, (module3.GetStoreItemInfo(mMovie, v47, { GetVisibilityMaterial = true }, nil, nil, true)))
	end

	for i = 1, v44 do
		local mCountedAttachment = v42.mCountedAttachments[i]
		local v47

		if not __wf_atom_7e8ad928(v13) then
			v47 = v13:__wf_atom_232fd31d(mCountedAttachment.mItemType)
		end

		if __wf_atom_7e8ad928(v47) then
			continue
		end

		local storeItemInfo = module3.GetStoreItemInfo(mMovie, v47, { GetVisibilityMaterial = true }, nil, nil, true)
		storeItemInfo.QuantityMultiplier = mCountedAttachment.mItemCount
		table.insert(v46, storeItemInfo)
	end

	local v47 = false
	local v48 = __wf_atom_7e8ad928(nil) and {} or (nil):__wf_atom_5ddf81f6()

	if count == 1 then
		local mCoupon = v42.mCoupons[1]
		local v49 = nil

		for i = 1, #v48 do
			if v48[i].mCouponSku ~= mCoupon.mSKU then
				continue
			end

			v49 = v48[i]
			break
		end

		if v49 and v49.mCouponType == 2 then
			local __wf_atom_ff62ea3d = gGameData:__wf_atom_ff62ea3d()
			local _ = Engine.__wf_atom_db2b0cee(mCoupon.mExpiry) > 0
				and v42.mIsRead
				and (__wf_atom_ff62ea3d.mDiscount == 0 or __wf_atom_ff62ea3d.mCouponSku ~= mCoupon.mSKU)

			if v42.mIsRead and (__wf_atom_ff62ea3d.mDiscount == 0 or __wf_atom_ff62ea3d.mCouponSku ~= mCoupon.mSKU) then
				mMovie:__wf_atom_2dedec1a("PopupFrame.Content.ClaimCouponBtn", 13, false)
			else
				mMovie:__wf_atom_2dedec1a("PopupFrame.Content.ClaimCouponBtn", 13, true)
				local module10 = require("Lotus.Interface.Components.ThemedButton")
				v24 = module10.Create(
					mMovie,
					"PopupFrame.Content.ClaimCouponBtn",
					"/Lotus/Language/Menu/DailyTributeClaimAndUseCoupon",
					"OnClaimAndUseCoupon"
				)
				v24:SetSpecialMode(true)
				v24:Redraw()
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Coupon", 0)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Coupon", 1)
				local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Coupon", 15)
				mMovie:__wf_atom_e57658c2("PopupFrame.Content.ClaimCouponBtn", 0, __wf_atom_5e6e15c8 - v24.mWidth / 2)
				mMovie:__wf_atom_e57658c2(
					"PopupFrame.Content.ClaimCouponBtn",
					1,
					__wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 - 20
				)
			end

			v47 = true
		end
	end

	if not v47 then
		for i = 1, count do
			local mCoupon = v42.mCoupons[i]

			for j = 1, #v48 do
				local v49 = v48[j]

				if v49.mCouponSku ~= mCoupon.mSKU then
					continue
				end

				local v50 = { Icon = v49.mIcon, Name = Localize(v49.mDisplayName, {}) }

				if v49.mAmount ~= 0 then
					if v49.mCouponType == 2 then
						if v49.mAmount > 100 then
							v50.Name = Localize(v49.mDisplayName, {
								PERCENT = module.FormatNumber(v49.mAmount - 100)
							})
						end
					else
						v50.Name = module.FormatNumber(v49.mAmount) .. "% " .. v50.Name
					end
				end

				if mCoupon.mExpiry.sec == "" then
					if mCoupon.mDuration > 0 then
						local secondsToFormattedTime = module2.SecondsToFormattedTime(mMovie, mCoupon.mDuration, false)
						v50.Name ..= " (" .. string.format(
							Localize("/Lotus/Language/Menu/Notification_Expiry", {}),
							secondsToFormattedTime
						) .. ")"
					end
				else
					local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(mCoupon.mExpiry)

					if __wf_atom_db2b0cee <= 0 then
						v50.Name ..= " (" .. Localize("/Lotus/Language/Menu/Expired", {}) .. ")"
					else
						local secondsToFormattedTime = module2.SecondsToFormattedTime(mMovie, __wf_atom_db2b0cee, false)
						v50.Name ..= " (" .. string.format(
							Localize("/Lotus/Language/Menu/Notification_Expiry", {}),
							secondsToFormattedTime
						) .. ")"
					end
				end

				table.insert(v46, v50)
				break
			end
		end
	end

	for i = 1, v45 do
		local mSyndicateAttachment = v42.mSyndicateAttachments[i]
		local v49 = { Count = mSyndicateAttachment.mStanding }
		v49.Icon = largeSyndicateRepIcon
		v49.Themed = true
		v49.Name = module.FormatNumber(mSyndicateAttachment.mStanding, 0) .. " " .. Localize("/Lotus/Language/Menu/Profile_Reputation", {})
		table.insert(v46, v49)
	end

	v6:RemoveElements(true, true)

	for i = 1, #v46 do
		local v49 = v46[i]
		v49.Premium = true
		v49.ShowCount = v49.Count ~= nil and v49.Count > 1
		v6:AddElement(v49, true)
	end

	local count2 = #v6.mElements
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Body.AttachmentGrid", 13, count2 > 0)

	if count2 > 0 then
		v6.mColumnSeparation = v6.mColumns < count2 and 116 or 119
		v6.mRowSeparation = v6.mColumnSeparation
		v6.mScrollBar.mHeight = v6.mColumnSeparation
		local v49 = 649 - mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Body", 1) - 119
		mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.AttachmentGrid", 1, v49)
		v32 = v49 - 20
	end

	v6:Redraw(nil, true, true)
end

local function fn10(p)
	local mDate

	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mDate) then
		mDate = MongoDateTime()
		mDate.sec = string.format("%u", gGameRules:__wf_atom_93691ff2())
	else
		mDate = p.mDate
	end

	local __wf_atom_e0c3cbeb = mDate:__wf_atom_e0c3cbeb(Engine.__wf_atom_578fc9dd())
	local v42 = string.gsub(__wf_atom_e0c3cbeb, " ", "/")
	local v43 = StringSplit("/", v42)
	local _, day, month, year = module8.ConvertDateToGame(v43[4], v43[2], v43[1], v43[3])
	return (Localize("/SF/Language/Codex/TimeStamp", { DAY = day, MONTH = month, YEAR = year }))
end

function PlayingCinematic(p)
	local v42 = p == "true"
	fn6()
	mMovie:__wf_atom_0c1c47f2(module.Ternary(v42, noMouseInputFilter, defaultInputFilter))
	mMovie:__wf_atom_69a0663a(not v42)
	mMovie:__wf_atom_fbca497c(not v42)
end

function KickOffCinematicChild()
	if __wf_atom_7e8ad928(_T.InboxCinematic) then
		return
	end

	local movie = __wf_atom_8e4fda44:FindMovie(WeakResource("/SF/Interface/Inbox.swf"))

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("PlayingCinematic", "true")
	end

	gGameRules:__wf_atom_411c9025(true)
	_T.RadioChatterDisabled = true
	_T.StoryLib_BlockTransmissions = true
	module6.PlayCinematic(_T.InboxCinematic, nil, true)
	gGameRules:__wf_atom_411c9025(false)
	_T.InboxCinematic = nil
	_T.RadioChatterDisabled = nil

	if not __wf_atom_7e8ad928(_T.ConfirmSkipDialog) then
		_T.ConfirmSkipDialog:Close()
	end

	_T.ConfirmSkipDialog = nil

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("PlayingCinematic", "false")
	end
end

local function fn11(mCinematic2)
	if not __wf_atom_7e8ad928((gRegion:__wf_atom_c3b255b8())) then
		return
	end

	_T.InboxCinematic = mCinematic2
	gRegion:__wf_atom_c4f78a8f():__wf_atom_8a035cd5(Symbol("KickOffCinematicChild"), false)
end

local function fn12(p)
	mMovie:__wf_atom_2dedec1a("TransmissionFrame.ImageOuter.Image", 13, p)
	mMovie:__wf_atom_2dedec1a("PopupFrame", 67, not p)
	__wf_atom_ec43d06e(mMovie, "PopupFrame.Messages.List", 8, { function(p2)
			local ternary = module.Ternary(p, 100 - p2, 30 + p2)
			mMovie:__wf_atom_e57658c2("PopupFrame.Messages.List", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.Messages.SortMenu", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.Messages.Unread", 12, ternary)
			mMovie:__wf_atom_e57658c2("PopupFrame.Messages.ScrollBar", 12, ternary)
		end }, { 70 }, 1, 0)
end

local function fn13(mTransmission2)
	if __wf_atom_7e8ad928(mTransmission2) then
		return
	end

	flag3 = true
	fn6()
	_T.RadioChatterDisabled = true

	if not __wf_atom_7e8ad928(_T.curTransmission) then
		module2.ClearTransmissionQueue()
		module2.InterruptTransmission()
	end

	module2.ForceCloseTransmission(true)
	fn12(true)
	_T.TransmissionOverrideMovie = mMovie
	_T.TransmissionOverrideMainClipName = "TransmissionFrame"
	_T.TransmissionOverrideX = mMovie:__wf_atom_5e6e15c8("TransmissionFrame.ImageOuter.Image", 14)
	_T.TransmissionOverrideY = mMovie:__wf_atom_5e6e15c8("TransmissionFrame.ImageOuter.Image", 15)
	v9 = mTransmission2
	v11 = false
	module2.CreateHudlessTransmission(mTransmission2)
end

local function fn14(mTag2)
	local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
	local v42 = StringSplit(",", mTag2)
	local v43 = ""
	local v44 = ""
	local v45 = ""

	for i = 1, #v42 do
		local __wf_atom_ed508ae4 = Engine.__wf_atom_ed508ae4(v42[i])

		if __wf_atom_ed508ae4 == "" and Engine.__wf_atom_940f8971(v42[i]) ~= 6 then
			__wf_atom_ed508ae4 = v42[i]
		end

		if __wf_atom_ed508ae4 == "" then
			__wf_atom_ed508ae4 = v42[i]
			v44 = __wf_atom_ed508ae4
		elseif Engine.__wf_atom_940f8971(__wf_atom_ed508ae4) == __wf_atom_63bb2bc6 then
			v44 = __wf_atom_ed508ae4
		end

		if i == 1 then
			v45 = __wf_atom_ed508ae4
			v43 = v45
			v45 = v43
		else
			if i == 2 then
				v43 ..= " ("
			end

			local v46 = v43 .. __wf_atom_ed508ae4

			if i < #v42 then
				v43 = v46 .. ", "
			else
				v43 = v46 .. ")"
			end
		end
	end

	if __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_7f395d54() then
		return v45, v43
	end

	if v44 == "" then
		v45 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Multiplayer/CrossPlayPlayer", false)
		v43 = v45
	else
		v43 = v44
		v45 = v43
		v43 = v45
	end

	return v45, v43
end

local function fn15(p)
	v3:RemoveElements(true, true)
	local v42 = {}
	local sec = nil
	local v43 = 1

	for k, v44 in v4 do
		__wf_atom_83c14687(0)
		fn10(v44)
		local icon = fn7(v44)
		local anchor

		if not __wf_atom_7e8ad928(icon) then
			anchor = Type(icon:__wf_atom_5b41f63b())
		end

		local mSender = nil

		if v44.mSender == "/Lotus/Language/Clan/InboxClanNameSender" then
			local _
			mSender, _ = module7.RemoveNumericSuffixFromName(gGameData:__wf_atom_84083b39())
		elseif #v44.mGifts > 0 or v44.mSubject == "/Lotus/Language/Menu/GiftReceivedConfirmationSubject" then
			local mLocalizationArgs = v44.mLocalizationArgs

			for i = 1, #mLocalizationArgs do
				local mKey = tostring(mLocalizationArgs[i].mKey)
				local mTag2 = tostring(mLocalizationArgs[i].mTag)

				if not (mKey == "GIFTER_NAME" or mKey == "RECIPIENT_NAME") then
					continue
				end

				local _
				mSender, _ = fn14(mTag2)
				break
			end
		elseif
			v44.mSubject == "/Lotus/Language/Menu/Mailbox_ClanInvite_Title"
			or v44.mSubject == "/Lotus/Language/Menu/Mailbox_AllianceInvite_Title"
		then
			mSender = Engine.__wf_atom_ed508ae4(v44.mSender)

			if mSender == "" then
				mSender = v44.mSender
			end
		else
			mSender = mMovie:__wf_atom_8e9ac384(v44.mSender, false)
		end

		table.insert(v42, {
			Id = k,
			IsClanMessage = v44.mSubject == "/Lotus/Language/Clan/Clan_AscensionCeremonyInProgress",
			DateSec = v44.mDate.sec,
			Date = Localize(v44.mSubject, nil),
			SenderLoc = mSender,
			Sender = v44.mSender,
			Icon = icon,
			Anchor = anchor
		})

		if not p or v44.mIsRead or not (sec == nil or sec < v44.mDate.sec) then
			continue
		end

		sec = v44.mDate.sec
		v43 = k
	end

	table.sort(v42, v3.mSortBy)

	for _, v44 in v42 do
		v3:AddElement(v44, true)
	end

	fn2()
	v12 = nil
	v3:Redraw(nil, nil, true)

	if p then
		v3:FocusElementById(v43)
	else
		v3:FocusElement(1)
	end

	v3:SelectCurrentElement()
	mMovie:__wf_atom_2dedec1a("PopupFrame.Messages.SortMenu", 13, #v4 ~= 0)

	if #v4 == 0 then
		UpdateMessageContent(-1)
	end
end

local function fn16()
	mMovie:__wf_atom_290807ee("PopupFrame.Content.GiftPanel.Gift")
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Gift", 0, 0)
	v8:RemoveTimer(v25)
	v25 = nil
end

local function fn17()
	if __wf_atom_7e8ad928(v12) then
		return
	end

	local v42 = v4[v12.Id]

	if __wf_atom_7e8ad928(v42) then
		return
	end

	if not __wf_atom_7e8ad928(v42.mGifts) then
		for i = 1, #v42.mLocalizationArgs do
			if tostring(v42.mLocalizationArgs[i].mKey) == "GIFT_QUANTITY" then
				mTag = tonumber((tostring(v42.mLocalizationArgs[i].mTag)))
			end
		end

		v37 = {}

		if #v42.mGifts > 1 then
			if v13:__wf_atom_232fd31d(v42.mGifts[1].mGiftType):__wf_atom_efa6f447() == 17 then
				for i = 2, #v42.mGifts do
					local __wf_atom_232fd31d = v13:__wf_atom_232fd31d(v42.mGifts[i].mGiftType)

					if not __wf_atom_7e8ad928(__wf_atom_232fd31d) then
						table.insert(v37, { __wf_atom_232fd31d, v42.mGifts[i].mFingerprint })
					end
				end
			else
				print("multiple stackable items received")
			end
		end
	end

	fn16()
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndPlay", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndPlay", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndPlay", 1)
	local v43 = { function(p)
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Name", 12, p)
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Desc", 12, p)
			v23:SetAlpha(100 - p)
		end }
	__wf_atom_ec43d06e(mMovie, "PopupFrame.Content.GiftPanel.Gift.Name", 8, v43, { 100 }, 2, 0, function()
		v23:SetVisible(false)
	end)
	v8:AddTimer(3, function()
		v30 = #v37 > 0

		if #v37 > 0 then
			v26 = #v37 / mTag
			v27 = 1
			v28 = mTag
			mMovie:__wf_atom_e57658c2("_root", 12, 0)
			ProcessBoosterPacks()
		end
	end)
end

local function fn18()
	module.PlaySound(shakeGiftSound)
	__wf_atom_ec43d06e(mMovie, "PopupFrame.Content.GiftPanel.Gift", 8, { function(p)
			local v42 = math.sin(3.1415927410125732 * 8 * p) * 10
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Gift", 0, v42)
		end }, { 1 }, 1, 0, function()
		v25 = v8:AddTimer(4, function()
			fn18()
		end)
	end)
end

local function fn19(data, p)
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

	local v43

	if __wf_atom_7e8ad928(storeItem) then
		v43 = false
	else
		local storeItemInfo = module3.GetStoreItemInfo(mMovie, storeItem, nil, nil, nil, true)
		v43 = storeItem:__wf_atom_955f7fe0()
		local ternary = module.Ternary(storeItemInfo.Themed, 256, 358)
		mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel.Gift.Item", "Icon", 14, ternary)
		mMovie:__wf_atom_4c1c1986("PopupFrame.Content.GiftPanel.Gift.Item", "Backer", 14, ternary)
		module3.DrawItem(mMovie, "PopupFrame.Content.GiftPanel.Gift.Item", storeItemInfo)
		local gridItemName = module4.GetGridItemName(mMovie, {}, {
			Name = storeItemInfo.Name,
			StoreItem = storeItem,
			QuantityMultiplier = mTag2
		})
		mMovie:__wf_atom_50d60589("PopupFrame.Content.GiftPanel.Name", 36, gridItemName)
	end

	local mSender = data.mSender

	if p ~= nil and p ~= "" then
		mSender = p
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/GiftSender", false, {
		SENDER = mSender
	})

	if v43 then
		__wf_atom_8e9ac384 ..= "\r\n" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/TennoGenLockRecipient", false)
	end

	mMovie:__wf_atom_50d60589("PopupFrame.Content.GiftPanel.Desc", 36, __wf_atom_8e9ac384)
	local v44 = 0
	local v45 = 1
	local v46 = 1
	local v47 = 1

	if data.mIsRead then
		v44 = 100
		v45 = 160
		v46 = 137
		v47 = 40
	else
		fn18()
	end

	v23:SetVisible(v44 == 0)
	v23:SetAlpha(100 - v44)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Name", 12, v44)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel.Desc", 12, v44)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndStop", v45)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndStop", v46)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndStop", v47)
end

function OnAcknowledgeInboxMessage(p, value)
	if p then
		fn8()

		if string.find(value, "DeletedMessage") then
			fn15()
		end

		local movie = __wf_atom_8e4fda44:FindMovie(notificationsMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("RefreshBoosters", "")
		end

		if not (__wf_atom_7e8ad928(v12) or __wf_atom_7e8ad928(v4)) then
			v12.mSkipRead = true
			local v42 = v4[v12.Id]

			if not __wf_atom_7e8ad928(v42) then
				local mAttachments = v42.mAttachments

				if mAttachments then
					local flag4 = false

					for i = 1, #mAttachments do
						local mAttachment = mAttachments[i]

						if __wf_atom_7e8ad928(mAttachment) or not mAttachment:IsA(v19) then
							continue
						end

						flag4 = true
						break
					end

					if flag4 then
						module2.UpdateUIConsoleTriggers(false)
					end
				end

				if #v42.mGifts > 0 then
					local mLocalizationArgs = v42.mLocalizationArgs
					local v43 = nil

					for i = 1, #mLocalizationArgs do
						local mKey = tostring(mLocalizationArgs[i].mKey)
						local mTag2 = tostring(mLocalizationArgs[i].mTag)

						if mKey ~= "GIFTER_NAME" then
							continue
						end

						local _
						v43, _ = fn14(mTag2)
						break
					end

					fn19(v42, v43)
					fn17()
					return
				end
			end
		end
	end

	v30 = false
end

local function fn20(mId)
	if Engine.__wf_atom_b6edc589() and not __wf_atom_7e8ad928(gGameData) then
		local v42 = nil

		for i = 1, #v4 do
			if v4[i].mId ~= mId then
				continue
			end

			v42 = v4[i]
			break
		end

		if v42 then
			for _, _ in v42.mAttachments do

			end

			for _, _ in v42.mCountedAttachments do

			end
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			v30 = true
			__wf_atom_9be88b01:__wf_atom_534be828(mId, "OnAcknowledgeInboxMessage")
		end
	end
end

function AcknowledgeGift()
	if __wf_atom_7e8ad928(v12) or IsInputBlocked() then
		return
	end

	local v42 = v4[v12.Id]

	if __wf_atom_7e8ad928(v42) then
		return
	end

	fn20(v42.mId)
end

function OnGiftFrame(_, p)
	if p == "Effects" then
		if __wf_atom_7e8ad928(giftOpeningFx) then
			return
		end

		local rootBasedPosition, v42 = module2.GetRootBasedPosition(mMovie, "PopupFrame.Content.GiftPanel.Gift")
		v29 = module2.CreateScreenParticles(mMovie, giftOpeningFx, rootBasedPosition, v42 - 30)
		module.PlaySound(openGiftSound)
	end
end

local function fn21()
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.GiftPanel", 13, false)
	mMovie:__wf_atom_c90af43a("PopupFrame.Content.GiftPanel.Gift.Item.Backer", _G.UITexture_Blueprint)
	mMovie:SetFrameCallback("PopupFrame.Content.GiftPanel.Gift", "OnGiftFrame")
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.GiftPanel.Gift.Lotus.Dots.gotoAndStop", 1)
	local module10 = require("Lotus.Interface.Components.ThemedButton")
	v23 = module10.Create(
		mMovie,
		"PopupFrame.Content.GiftPanel.UnwrapBtn",
		"/Lotus/Language/Inbox/GiftUnwrap",
		"AcknowledgeGift"
	)
	v23.mAnchor = module.CENTER_ALIGNED
	v23:SetSpecialMode(true)
	v23:Redraw()
end

function OpenClanWelcome()
	if not (__wf_atom_7e8ad928(welcomeToClanScreen) or __wf_atom_8e4fda44:__wf_atom_6b69b901(welcomeToClanScreen)) then
		mMovie:PushChildMovie(welcomeToClanScreen)
	end
end

local function fn22(p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	v30 = true

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end

	gGameData:DeleteInboxMessage(p, "OnDeleteMessage")
end

local function fn23()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01())) then
		return
	end

	local v42 = nil

	for i = 1, #v4 do
		if v4[i].mAcceptAction == 2 then
			v42 = i
		end
	end

	if v42 == nil then
		OpenClanWelcome()
		flag2 = false
		mContextInfo = nil
	elseif v4[v42].mContextInfo == mContextInfo then
		fn22(tostring(v4[v42].mId))
	else
		fn3(v4[v42].mContextInfo, true)
	end
end

function OnDeleteMessage()
	v30 = false

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01()))) then
		fn8()
		fn15()
	end

	if flag2 then
		fn23()
	end

	module.PlaySound(_G.UISound_GridOpenTwo)
end

function OnDeleteMessagePressed()
	if IsInputBlocked() or id == nil or __wf_atom_7e8ad928(gGameData) or v4 == nil or #v4 < id then
		return
	end

	local v42 = v4[id]
	local mDeclineAction = v42.mDeclineAction

	if mDeclineAction == 0 then
		if __wf_atom_7e8ad928(v42.mCinematic) then
			fn22(tostring(v4[id].mId))
			id = nil
		else
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/1999/Mailbox_DeleteReadCinConfirmation",
				false
			)
			module.ShowYesOrNoMessage(__wf_atom_8e9ac384, function(p)
				if p == 4 then
					fn22(tostring(v4[id].mId))
					id = nil
				end
			end)
		end
	elseif mDeclineAction == 2 then
		fn3(v42.mContextInfo, true)
	elseif mDeclineAction == 3 then
		fn3(v42.mContextInfo)
	end
end

function ConfirmDeleteAllReadMessages(p)
	if tonumber(p) ~= 4 or __wf_atom_7e8ad928(gGameData) or v4 == nil or #v4 < id then
		return
	end

	local mIds = {}
	local flag4 = false

	for _, v42 in ipairs(v4) do
		if __wf_atom_7e8ad928(v42.mCinematic) then
			table.insert(mIds, v42.mId)
		else
			flag4 = true
		end
	end

	if flag4 then
		if #mIds == 0 then
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/1999/Mailbox_DeleteAllReadCinsOnlyConfirmation",
				false
			)
			module.ShowYesOrNoMessage(__wf_atom_8e9ac384, function(p2)
				if p2 == 4 then
					fn22("DeleteAllRead")
					id = nil
				end
			end)
		else
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 5
			dialogSettings.locString = "/Lotus/Language/1999/Mailbox_DeleteAllReadWithCinsConfirmation"
			dialogSettings.firstString = "/Menu/Confirm_Item_Yes"
			dialogSettings.secondString = "/Menu/Confirm_Item_No"
			dialogSettings.thirdString = "/Menu/Confirm_Item_Cancel"
			dialogSettings:SetCallback(function(p2)
				if p2 == 4 then
					fn22("DeleteAllRead")
					id = nil
				elseif p2 == 6 then
					_T.TMPFilterMessageIds = _T.TMPFilterMessageIds or {}

					for _, v42 in ipairs(mIds) do
						table.insert(_T.TMPFilterMessageIds, v42)
					end

					fn22("DeleteAllReadNonCin")
					id = nil
				end
			end)
			module.ShowCustomMessage(dialogSettings)
		end
	else
		fn22("DeleteAllRead")
		id = nil
	end
end

function OnDeleteAllReadMessagesPressed()
	if IsInputBlocked() or id == nil then
		return
	end

	module.ShowYesOrNoMessage("/Lotus/Language/Menu/Mailbox_DeleteAllReadConfirmation", "ConfirmDeleteAllReadMessages")
end

function UpdateMessageContent(p)
	local v42 = #v4 == 0
	mMovie:__wf_atom_2dedec1a("Empty", 13, v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Body", 13, not v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Coupon", 13, not v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.ClaimCouponBtn", 13, not v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.GiftPanel", 13, not v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Subject", 13, not v42)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Timestamp", 13, not v42)
	fn6()

	if v42 then
		return
	end

	local v43 = v4[p]

	if v43.mAcceptAction == 2 and v43.mContextInfo == "" then
		fn22(tostring(v43.mId))
		return
	end

	local mMessage = v43.mMessage
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.Coupon", 13, false)
	local v44 = string.gsub(mMessage, "|r|n", "\r\n")
	local mLocalizationArgs = v43.mLocalizationArgs
	local isUGCRestricted = module.IsUGCRestricted()
	local v45 = {}
	local v46 = nil
	local flag4 = false
	local v47 = nil
	local v48 = ""
	local v49 = false
	local v50 = ""

	for i = 1, #mLocalizationArgs do
		local mKey = tostring(mLocalizationArgs[i].mKey)
		local mTag2 = tostring(mLocalizationArgs[i].mTag)

		if isUGCRestricted and (mKey == "attacker_name" or mKey == "ATTACKER_NAME") then
			v45[mKey] = ""
		elseif mKey == "GIFTER_NAME" or mKey == "RECIPIENT_NAME" then
			v50, v48 = fn14(mTag2)
			v45[mKey] = mMovie:__wf_atom_8e9ac384(mTag2, false)
			v49 = isUGCRestricted
		elseif isUGCRestricted and (mKey == "clan" or mKey == "their_clan") then
			v45[mKey] = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_GuildBtn", false)
		elseif isUGCRestricted and mKey == "alliance" then
			v45.alliance = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/View_Alliance_Short", false)
		elseif mKey == "GIFT_TYPE" then
			local v51 = WeakResource(mTag2)

			if not __wf_atom_7e8ad928(v51) then
				if v51:IsA(__wf_atom_cb425ff5) then
					v46 = Resource(v51)
				else
					v46 = v13:__wf_atom_232fd31d(v51)
				end
			end

			if not __wf_atom_7e8ad928(v46) then
				v45.TYPE_NAME = mMovie:__wf_atom_8e9ac384(tostring(v46:__wf_atom_014a76a2()), false)
			end
		elseif mKey == "GIFT_DURABILITY" then
			v47 = tonumber(mTag2)
		elseif mKey == "PLAYER_NAMES" then
			local v51 = StringSplit(",", mTag2)
			local __wf_atom_63bb2bc6 = Engine.__wf_atom_63bb2bc6()
			local __wf_atom_7f395d54 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_7f395d54()
			local v52 = ""

			for j = 1, #v51 do
				local v53 = v51[j]

				if not __wf_atom_7f395d54 and Engine.__wf_atom_940f8971(v53) ~= __wf_atom_63bb2bc6 then
					v53 = Localize("/Lotus/Language/Multiplayer/CrossPlayPlayer", false)
				end

				v52 ..= "- " .. v53 .. "<br>"
			end

			v45.PLAYER_NAMES = v52
		elseif tonumber(mTag2) then
			v45[mKey] = module.FormatNumber(mTag2)
		else
			v45[mKey] = mMovie:__wf_atom_8e9ac384(mTag2, false, v45)
		end

		if mKey == "GIFTER_NAME" or mKey == "PLAYER_NAME" or mKey == "PLAYER_NAMES" then
			flag4 = true
		end
	end

	if Engine.__wf_atom_578fc9dd() then
		if flag4 then
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Body.Message.Label", 49, "Arial Unicode MS")
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Subject", 49, "Arial Unicode MS")
		else
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Body.Message.Label", 49, "Noto Sans")
			mMovie:__wf_atom_50d60589("PopupFrame.Content.Subject", 49, "Noto Sans")
		end
	end

	if v45.TYPE_NAME ~= nil and v47 ~= nil and not (__wf_atom_7e8ad928(v46) or __wf_atom_7e8ad928(v46:GetItem())) then
		if v47 == 0 then
			v45.TYPE_NAME = Localize("/Lotus/Language/Menu/Global_3Days", {}) .. " " .. v45.TYPE_NAME
		elseif v47 == 1 then
			v45.TYPE_NAME = Localize("/Lotus/Language/Menu/Global_7Days", {}) .. " " .. v45.TYPE_NAME
		end
	end

	if v45.NODE_NAME then
		local starChart = module2.GetStarChart()

		if __wf_atom_7e8ad928(starChart) then
			v45.NODE_NAME = ""
		else
			local v51 = Symbol(v45.NODE_NAME)
			v45.NODE_NAME = Localize(tostring(starChart:__wf_atom_d5226f21(v51).locTag), {})
			v45.NODE_REGION_NAME = Localize(tostring(starChart:__wf_atom_db2d8292(v51).name), {})
		end
	end

	if v45.PLAYER_NAME == nil and not __wf_atom_7e8ad928(gRegion) then
		local v51 = gRegion:__wf_atom_e23b2855()[1]

		if not __wf_atom_7e8ad928(v51) then
			v45.PLAYER_NAME = v51:__wf_atom_6be84646(true)
		end
	end

	if v45.CLAN_NAME == nil and not __wf_atom_7e8ad928(gGameData) then
		if isUGCRestricted then
			v45.CLAN_NAME = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_GuildBtn", false)
		else
			local v51, _ = module7.RemoveNumericSuffixFromName(gGameData:__wf_atom_84083b39())
			v45.CLAN_NAME = v51
		end
	end

	if v48 ~= "" then
		v45.GIFTER_NAME = v48
		v45.RECIPIENT_NAME = v48
	end

	local v51 = "<p><font >" .. mMovie:__wf_atom_8e9ac384(v44, true, v45)
	local v52 = v49 and "" or v51

	if not __wf_atom_7e8ad928(v43.mGifts) and v38 then
		v52 = __wf_atom_f8f86fc5(v52, 0)
	end

	if #v43.mModPacks > 0 then
		v52 ..= "\r\n\r\n" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Mailbox_ModPackNotification", false)

		for i = 1, #v43.mModPacks do
			local mModPack = v43.mModPacks[i]
			local c_str = v13:__wf_atom_232fd31d(mModPack):__wf_atom_014a76a2():c_str()
			v52 ..= "\r\n" .. mMovie:__wf_atom_8e9ac384(c_str, false)
		end
	end

	if v50 ~= "" then
		v45.GIFTER_NAME = v50
		v45.RECIPIENT_NAME = v50
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v43.mSubject, false, v45)
	local v53 = v52 .. "</font></p>"
	mMovie:__wf_atom_50d60589("PopupFrame.Content.Body.Message.Label", 36, v53)
	mMovie:__wf_atom_7d7314f1("PopupFrame.Content.Subject.text", __wf_atom_8e9ac384)
	mMovie:__wf_atom_50d60589("PopupFrame.Content.Timestamp", 36, fn10(v43))
	local v54 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Subject", 1) + math.ceil((mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Subject", 41))) + 5
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Timestamp", 1, v54)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body", 1, v54 + 54)
	fn()
	local none = v.NONE
	local none2 = v.NONE
	mTransmission = v43.mTransmission
	mCinematic = v43.mCinematic
	mMuseum = v43.mMuseum
	mCustomData = v43.mCustomData
	v34 = Symbol(v43.mTutorialTag)
	v39 = mTransmission ~= nil or not __wf_atom_7e8ad928(mCinematic)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.TransBtn", 13, v39)

	if v43.mAcceptAction == 2 or v43.mAcceptAction == 3 or v43.mAcceptAction == 4 then
		none = v.ACCEPT_DECLINE
		none2 = v.ACCEPT_DECLINE
	elseif v43.mTeleportLocation == 0 then
		if v43.mURL == "" then
			if v43.mSubject == "/Lotus/Language/Inbox/EmailLinkSubject" then
				none2 = v.EMAIL_SETTINGS
			elseif not __wf_atom_7e8ad928(mMuseum) and module2.GetUIMode() == module2.UI_MODE_IN_SPACE_SHIP then
				none2 = v.MUSEUM
			end
		else
			none2 = v.WEB_BROWSER
		end
	else
		none2 = v.TELEPORT
	end

	local v55 = not __wf_atom_7e8ad928(v43.mGifts)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.GiftPanel", 13, v55)
	fn16()

	if not __wf_atom_7e8ad928(v29) then
		v29:Destroy()
		v29 = nil
	end

	if v55 then
		fn19(v43, v50)
	end

	v32 = 510
	v21:SetVisible(none ~= v.NONE)
	v22:SetVisible(none2 ~= v.NONE)
	local mMovie2 = mMovie
	mMovie2:__wf_atom_976dcedd(v21.mClipName, "forceMenuSelection", none ~= v.NONE and Engine.IsPlayingWithController())
	local mMovie3 = mMovie
	mMovie3:__wf_atom_976dcedd(
		v22.mClipName,
		"forceMenuSelection",
		none2 ~= v.NONE and Engine.IsPlayingWithController()
	)
	fn9(p)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Subject", 0)
	local v60 = v7 - __wf_atom_5e6e15c8 * 2
	local v61

	if v39 then
		v61 = v60 - mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.TransBtn", 14) - 20
	else
		v61 = v60
	end

	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Subject", 14, v61)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Timestamp", 14, v61)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.GiftPanel", 0, v7 / 2)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.Message.Label", 14, v60)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.Message.Label", 15, v32)

	if v5 ~= nil then
		v5:SetScrollValue(0, false, true)
		v5.mHeight = nil
		v5.mVisibleProp = nil
		v5:Resize()

		if v5.mVisible then
			local v62 = v60 - mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Body.Message.ScrollBar", 14) - 20
			mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.Message.Label", 14, v62)
			v5.mHeight = nil
			v5.mVisibleProp = nil
			v5:Resize()
		end
	end

	if not v43.mIsRead then
		local v62 = false

		for i = 1, #mLocalizationArgs do
			local mKey = tostring(mLocalizationArgs[i].mKey)
			local mTag2 = tostring(mLocalizationArgs[i].mTag)

			if mKey ~= "CREDIT_REWARD" or __wf_atom_7e8ad928(gRegion) then
				continue
			end

			local v63 = gRegion:__wf_atom_e23b2855()[1]

			if __wf_atom_7e8ad928(v63) or __wf_atom_7e8ad928(__wf_atom_539492fe) then
				continue
			end

			__wf_atom_539492fe:__wf_atom_9aca19e0(v63, Symbol("BATTLE_PAY"), mTag2)
			__wf_atom_539492fe:__wf_atom_c2038c7a(v63, Symbol("BATTLE_PAY_PAID"))
			v62 = true
		end

		if
			not __wf_atom_7e8ad928(gRegion)
			and not v62
			and string.find(v43.mSubject, "InvasionThankyouMessageSubject")
		then
			local v63 = gRegion:__wf_atom_e23b2855()[1]

			if not (__wf_atom_7e8ad928(v63) or __wf_atom_7e8ad928(__wf_atom_539492fe)) then
				__wf_atom_539492fe:__wf_atom_9aca19e0(v63, Symbol("BATTLE_PAY"), 20000)
				__wf_atom_539492fe:__wf_atom_c2038c7a(v63, Symbol("BATTLE_PAY_PAID"))
			end
		end

		if __wf_atom_7e8ad928(v43.mGifts) then
			fn20(v43.mId)
		end

		if not (__wf_atom_7e8ad928(mTransmission) or flag3) then
			local v63

			if mTransmission == ghoulIntroInboxTransmission or mTransmission == ghoulOutroInboxTransmission then
				local __wf_atom_0dec86a1 = gGameData:GetInventory():__wf_atom_0dec86a1()
				local count = 0

				for _, v64 in pairs(__wf_atom_0dec86a1) do
					local mItemType = v64.mItemType

					if __wf_atom_7e8ad928(mItemType) or not mItemType:IsA(ghoulLoreFragmentType) then
						continue
					end

					if v64.mItemCount < 4 then
						break
					else
						count += 1
					end
				end

				v63 = count >= 13
			else
				v63 = false
			end

			if not v63 then
				fn13(mTransmission)
			end
		end

		if not __wf_atom_7e8ad928(mCinematic) then
			v35 = true
		end
	end
end

local function fn24(data)
	return #data.mAttachments > 0
		or #data.mCountedAttachments > 0
		or #data.mCoupons > 0
		or #data.mSyndicateAttachments > 0
		or data.mCredits > 0
		or data.mPremiumCredits > 0
		or data.mPrimeTokens > 0
end

local function fn25()
	v30 = true
	fn(true)
	v2:SelectElementById(1)

	if __wf_atom_7e8ad928(v33) then
		v33 = mMovie:__wf_atom_5e6e15c8("PopupFrame", 0)
	end

	mMovie:__wf_atom_e57658c2("PopupFrame", 12, 0)
	mMovie:__wf_atom_e57658c2("PopupFrame", 0, v33 - 50)
	__wf_atom_ec43d06e(mMovie, "PopupFrame", 7, { 12, 0 }, { 100, v33 }, 0.4, 0, function()
		v30 = false
	end)
	mMovie:__wf_atom_e57658c2("Empty", 12, 0)
	mMovie:__wf_atom_e57658c2("Empty", 0, v33 - 50)
	__wf_atom_ec43d06e(mMovie, "Empty", 7, { 12, 0 }, { 100, v33 }, 0.4, 0)
end

function TransitionOut()
	if IsInputBlocked() then
		return
	end

	v30 = true

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		if v33 == nil then
			mMovie:Close()
		else
			__wf_atom_ec43d06e(mMovie, "PopupFrame", 7, { 12, 0 }, { 0, v33 - 50 }, 0.2, 0, function()
				mMovie:Close()
			end)
		end
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			_T.gLastHighPriorityMessageCount = __wf_atom_9be88b01:__wf_atom_153e689d()
		end
	end
end

local function fn26()
	if __wf_atom_7e8ad928(gGameData) or v3 ~= nil then
		return
	end

	mMovie:__wf_atom_2dedec1a("PopupFrame", 13, true)
	fn8()
	local module10 = require("EE.Interface.Components.List")
	local module11 = require("SF.Interface.Components.Scrollbar")
	v3 = module10.CreateNewList(getfenv(1), "PopupFrame.Messages.List.Message1")
	v3.mVisibleElements = 6
	v3.mForcedVerticalSeparation = 90
	mMovie:OverrideMaterial("TransmissionFrame.ImageOuter.Image", _G.UIMaterial_SmoothEdgeNoDepthTest)

	function v3.mClipCreatedCallback(p, _)
		mMovie:OverrideMaterial(p .. ".Sender.Icon", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Sender.IconBg", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Label", messageListTextVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Read", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Gift", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Bg", messageListVisibleRangeMaterial)
		mMovie:OverrideMaterial(p .. ".Sender.IconWax", messageListVisibleRangeMaterial)
		mMovie:__wf_atom_c90af43a(p .. ".Read", unreadIcon)
		mMovie:__wf_atom_48bd5a59(p, "Label", 46, "center")

		if Engine.__wf_atom_578fc9dd() then
			mMovie:__wf_atom_48bd5a59(p, "Label", 49, "Arial Unicode MS")
		end

		mMovie:__wf_atom_4c1c1986(p, "Label", 44, _G.UIColor_MediumBrown)
	end

	function v3.UpdateFocused(p, p2, p3, _)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Sender.IconWax", 13, p3)
		local mMovie2 = mMovie
		local v42 = p.mClipName .. ".Bg"
		local v43

		if p3 then
			v43 = listItemBackerSelected
		else
			v43 = listItemBacker
		end

		mMovie2:__wf_atom_c90af43a(v42, v43)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Bg", 11, (p3 or not p2) and 16777215 or _G.UIColor_FadedTint)
	end

	function v3.mOnFocusedCallback(p)
		local v42 = not __wf_atom_7e8ad928(v12) and v12.Id == p.Id
		v3.UpdateFocused(p, true, v42)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Sender", 2, { 5, 6 }, { 110, 110 }, 0.3)
		module.PlaySound(_G.UISound_Focus)
	end

	function v3.mOnUnfocusedCallback(p)
		local v42 = not __wf_atom_7e8ad928(v12) and v12.Id == p.Id
		v3.UpdateFocused(p, false, v42)
		__wf_atom_ec43d06e(mMovie, p.mClipName .. ".Sender", 2, { 5, 6 }, { 100, 100 }, 0.15)
		module.PlaySound(_G.UISound_Unfocus)
	end

	function v3.mOnSelectedCallback(p)
		if v12 then
			if v12.mSkipRead then
				v12.mSkipRead = nil
			end

			v3.UpdateFocused(v12, false, false)
			local v42 = v4[v12.Id]
			mMovie:__wf_atom_7f57ab2f(v12.mClipName, "Read", 13, not (__wf_atom_7e8ad928(v42) or v42.mIsRead))
			fn2()
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ItemTipSection)
			__wf_atom_86cbd68d(mMovie, "PopupFrame.Content.Papers.gotoAndPlay", "PlayMailSelect")
		end

		v12 = p
		id = p.Id
		v3.mElementDrawCallback(p)
		UpdateMessageContent(p.Id)
	end

	function v3.mElementDrawCallback(data)
		if data.mClipName == nil then
			return
		end

		local focusedElement = v3:GetFocusedElement()
		local v42 = not __wf_atom_7e8ad928(focusedElement) and focusedElement.Id == data.Id
		local v43 = not __wf_atom_7e8ad928(v12) and v12.Id == data.Id
		local senderLoc = data.SenderLoc
		local v44 = v4[data.Id]

		if __wf_atom_7e8ad928(v44) then
			return
		end

		local icon = data.Icon

		if data.IsClanMessage then
			icon = uiTexture_DefaultClan
		end

		if icon == nil then
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Sender.Icon", 13, false)
		else
			mMovie:__wf_atom_c90af43a(data.mClipName .. ".Sender.Icon", icon)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Sender.Icon", 13, true)

			if icon:IsA(v20) then
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 1, 10)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 14, 78)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 15, 78)
			else
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 1, 0)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 14, 68)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Sender.Icon", 15, 68)
			end
		end

		local v45 = v44.mIsRead and not data.mSkipRead
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Read", 13, not v45)
		local v46 = fn24(v44)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Gift", 13, v46)
		local v47 = "<p><font >" .. senderLoc .. "<br><font face=\"Spectral Italic\" size=\"20\">" .. data.Date .. "</font></font></p>"
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, v47)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Bg", listItemBacker)
		v3.UpdateFocused(data, v42, v43, true)
	end

	v3:AttachScrollBar("PopupFrame.Messages.ScrollBar", {
		mVisRangeMaterials = { messageListVisibleRangeMaterial, messageListTextVisibleRangeMaterial }
	})
	local module12 = require("Lotus.Interface.Components.DropDownMenu")
	v2 = module12.Create(mMovie, "PopupFrame.Messages.SortMenu")
	v2.mWidth = 225
	v2.mStartingDepth = tonumber(__wf_atom_86cbd68d(mMovie, v2.mRootClipName .. ".getDepth"))
	v2.mMainButton:SetWidth(225)
	v2:SetCallbacks("SortByPressed", "SortByFocused", "SortByUnfocused")

	function v2.RecentSort(p, p2)
		return p.DateSec > p2.DateSec
	end

	function v2.mOnSelectedCallback(p)
		if v3.mSortBy ~= p.Attribute then
			v3.mSortBy = p.Attribute
			fn15(v3:GetHowManyElements() == 0)
		end
	end

	function v2.OnExpandCallback(p, p2)
		__wf_atom_86cbd68d(mMovie, p.mRootClipName .. ".swapDepths", 5555)

		if p2 and Engine.__wf_atom_5df63302() then
			local rootBasedPosition, v42 = p.UTIL.GetRootBasedPosition(mMovie, p.mRootClipName)
			mMovie:__wf_atom_2625efb4(rootBasedPosition + 19, v42 + 1)
		end
	end

	function v2.OnCollapseCallback(p, _)
		__wf_atom_86cbd68d(mMovie, p.mRootClipName .. ".swapDepths", p.mStartingDepth)
	end

	v2:AddElement({
		Name = "/SortingLabels/Recent",
		SortId = "RECENT",
		Attribute = function(p, p2)
			return v2.RecentSort(p, p2)
		end
	}, true)
	v2:AddElement({
		Name = "/SortingLabels/Sender",
		SortId = "SENDER",
		Attribute = function(p, p2)
			if p.SenderLoc == p2.SenderLoc then
				return v2.RecentSort(p, p2)
			end

			return p.SenderLoc < p2.SenderLoc
		end
	}, true)
	v2:AddElement({
		Name = "/SortingLabels/Attachment",
		SortId = "ATTACHMENT",
		Attribute = function(p, p2)
			local v42 = v4[p.Id]
			local v43 = v4[p2.Id]

			if v42 == nil or v43 == nil then
				return v2.RecentSort(p, p2)
			end

			local v44 = fn24(v42)
			local v45 = fn24(v43)

			if v44 and not v45 then
				return true
			end

			if v44 or not v45 then
				return v2.RecentSort(p, p2)
			end

			return false
		end
	}, true)
	v2:AddElement({
		Name = "/Lotus/Language/Menu/Item_GiftToPlayerShort",
		SortId = "GIFT",
		Attribute = function(p, p2)
			local v42 = v4[p.Id]
			local v43 = v4[p2.Id]

			if v42 == nil or v43 == nil then
				return v2.RecentSort(p, p2)
			end

			local v44 = #v42.mGifts > 0
			local v45 = #v43.mGifts > 0

			if v44 and not v45 then
				return true
			end

			if v44 or not v45 then
				return v2.RecentSort(p, p2)
			end

			return false
		end
	}, true)
	v2:Redraw()
	v5 = module11.CreateScrollBar(getfenv(1), "PopupFrame.Content.Body.Message.ScrollBar", {
		mClipToScroll = "PopupFrame.Content.Body.Message.Label",
		mVisRangeMaterials = { contentVisibleRangeMaterial, contentTextVisibleRangeMaterial }
	})
	fn6()
	local module13 = require("Lotus.Interface.Components.ThemedButton")
	v21 = module13.Create(
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
	v22 = module13.Create(
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
	v21:SetVisible(false)
	v22:SetVisible(false)
	v21:Redraw()
	v22:Redraw()

	if #v4 == 0 then
		UpdateMessageContent(-1)
	end

	fn25()

	if not __wf_atom_7e8ad928(v31) then
		v31:SetActive(false)
	end
end

local function fn27()
	local __wf_atom_cbaae68f = gGameData:__wf_atom_cbaae68f()

	if __wf_atom_7e8ad928(__wf_atom_cbaae68f) then
		v18 = false
		return
	end

	v17 = true
	v18 = true
	table.insert(__wf_atom_cbaae68f, lotusSymbolIcon:__wf_atom_5b41f63b())
	table.insert(__wf_atom_cbaae68f, lotusDefaultIcon:__wf_atom_5b41f63b())
	v16 = UISys.__wf_atom_c0dbe47c(__wf_atom_cbaae68f)
end

function OnInboxSyncComplete()
	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		return
	end

	flag = true

	if not v15 then
		fn27()
	end
end

local function fn28()
	mMovie:__wf_atom_e57658c2("PopupFrame.Messages.Unread", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Subject", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Timestamp", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.Message.Label", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.AttachmentGrid.Title", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.Body.AttachmentGrid.Subtitle", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_50d60589(
		"PopupFrame.Content.Body.AttachmentGrid.Title",
		36,
		Localize("/SF/Language/Codex/Spoils", nil)
	)
	mMovie:__wf_atom_50d60589(
		"PopupFrame.Content.Body.AttachmentGrid.Subtitle",
		36,
		Localize("/SF/Language/Inbox/DeliveredToInventory", nil)
	)
	mMovie:OverrideMaterial("PopupFrame.Content.Body.Message.Label", contentTextVisibleRangeMaterial)
	mMovie:__wf_atom_c90af43a("PopupFrame.Backer", backerImage)
	mMovie:__wf_atom_c90af43a("PopupFrame.Content.Panel", contentBackerImage)
	fn21()
end

local function fn29()
	local module10 = require("EE.Interface.Components.Grid")
	v6 = module10.CreateNewGrid(getfenv(1), "PopupFrame.Content.Body.AttachmentGrid.Attachment", {
		mColumns = 6,
		mRows = 1,
		mColumnSeparation = 119,
		mRowSeparation = 119,
		mPadding = 0,
		mShowInfoPopup = true,
		mVisRangeMaterials = {
			Icon = attachmentsVisibleRangeMaterial,
			Text = attachmentsTextVisibleRangeMaterial,
			FocusedItem = attachmentsFocusedBorderVisibleRangeMaterial
		}
	})

	function v6.mClipCreatedCallback(p, p2)
		if p2 == nil or p == nil then
			return
		end

		module5.Initialize(mMovie, p, p2, v6)
		mMovie:__wf_atom_7f57ab2f(p, "IconOutline", 13, false)
		mMovie:__wf_atom_c90af43a(p .. ".IconBg", gridItemIconBacker)
	end

	function v6:mOnFocusedCallback()
		if self == nil or self.mClipName == nil then
			return
		end

		self.Focused = true
		module5.UpdateFocus(mMovie, self.mClipName, self, v6)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconOutline", 13, true)
		module.PlaySound(inboxRolloverSound)
	end

	function v6:mOnUnfocusedCallback()
		if self == nil or self.mClipName == nil then
			return
		end

		self.Focused = false
		module5.UpdateFocus(mMovie, self.mClipName, self, v6)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "IconOutline", 13, false)
	end

	function v6.mElementDrawCallback(p)
		if p == nil or p.mClipName == nil then
			return
		end

		module5.Update(mMovie, p.mClipName, p, v6)
	end

	v6:AttachScrollBar("PopupFrame.Content.Body.AttachmentGrid.ScrollBar", {
		mVisRangeSizeOffset = -20,
		mVisRangeMaterials = {
			attachmentsVisibleRangeMaterial,
			attachmentsTextVisibleRangeMaterial,
			attachmentsFocusedBorderVisibleRangeMaterial
		}
	})
end

function OnEmblemReady(p, p2)
	if p and not Resource(p2):__wf_atom_5583ebb9() then
		uiTexture_DefaultClan = Resource(p2)

		if not __wf_atom_7e8ad928(v3) then
			v3:RunForAllVisibleElements(function(p3)
				v3.mElementDrawCallback(p3)
			end)
		end
	end
end

function Initialize()
	_T.OpeningMailbox = nil
	module.PlaySound(inboxOpenSound)

	if __wf_atom_7e8ad928(gGameData) then
		mMovie:Close()
		return
	end

	v7 = mMovie:__wf_atom_5e6e15c8("PopupFrame.Content.Panel", 14)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()

		if not __wf_atom_7e8ad928(settings) then
			v38 = settings:__wf_atom_bb0f4637()
		end
	end

	local module10 = require("Lotus.Interface.Libs.TimerMgr")
	v8 = module10.CreateTimerMgr()
	uiTexture_DefaultClan = _G.UITexture_DefaultClan
	local v42 = {}

	if not __wf_atom_7e8ad928(gGameRules) then
		v13 = gGameRules:__wf_atom_964056fd()
	end

	if __wf_atom_7e8ad928(v13) then
		table.insert(v42, __wf_atom_c67f9605:__wf_atom_964056fd():__wf_atom_5b41f63b())
	end

	if #v42 > 0 then
		v15 = true
		v14 = UISys.__wf_atom_c0dbe47c(v42)
	end

	v41 = module9.Create(mMovie, true)
	v41:Register(mMovie, "Empty", { v41.ANCHOR_V_CENTRE, v41.ANCHOR_H_CENTRE })
	v41:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	mMovie:__wf_atom_e57658c2("Empty.EmptySparrow", 12, 80)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Inbox/NoMessages", true)
	mMovie:__wf_atom_7d7314f1("Empty.Label.text", __wf_atom_8e9ac384)
	mMovie:__wf_atom_e57658c2("Empty.Label", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_e57658c2("Empty.Label", 12, 87)
	mMovie:__wf_atom_2dedec1a("PopupFrame.Content.TransBtn", 13, false)
	mMovie:SetCallbacks(
		"PopupFrame.Content.TransBtn.Btn",
		"TransBtnFocused",
		"TransBtnUnfocused",
		"TransBtnPressed",
		nil
	)
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.TransBtn.Outline", 12, 20)
	fn28()
	fn29()
	mMovie:__wf_atom_2dedec1a("TransmissionFrame.ImageOuter.Image", 13, false)
	__wf_atom_86cbd68d(mMovie, "TransmissionFrame.ImageOuter.Image.swapDepths", 3000)
	mMovie:__wf_atom_2dedec1a("Empty", 13, false)
	mMovie:__wf_atom_2dedec1a("PopupFrame", 13, false)

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("PopupFrame.Content.Subject", 49, "Arial Unicode MS")
	end

	local module11 = require("Lotus.Interface.Components.ThemedSpinner")
	v31 = module11.Create(mMovie, "Spinner")
	v31:SetActive(v15 or not _T.SkipMailboxSync)

	if _T.SkipMailboxSync then
		OnInboxSyncComplete()
	else
		gGameData:__wf_atom_6646ca4d("OnInboxSyncComplete")
	end

	_T.SkipMailboxSync = false

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_INBOX")
	end

	if Engine.__wf_atom_b6edc589() then
		mMovie:__wf_atom_dac78d3d(true)
		_T.UIInputEnabled = true
	end
end

function Shutdown()
	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "COMMUNICATION_INBOX")
	end

	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil

	if not __wf_atom_7e8ad928(v29) then
		v29:Destroy()
		v29 = nil
	end
end

function Update()
	local v42 = __wf_atom_fa1258d0()

	if __wf_atom_7e8ad928(mMovie:__wf_atom_2ad5cd23()) then
		gGameRules:ShowPauseMenu()
	end

	if not __wf_atom_7e8ad928(mMovie) then
		mMovie:__wf_atom_88d9cd84(v42)
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Update(v42)
	end

	if not __wf_atom_7e8ad928(v31) then
		v31:Update()
	end

	if v36 ~= nil and v36:IsLoading() and v36:LoadingComplete() then
		v36:FinishLoad()
	end

	if v9 ~= nil and not __wf_atom_7e8ad928(_T.curTransmission) then
		if not v11 and v9 == _T.curTransmission then
			v10 = _T.curTransmission:__wf_atom_cb26a501()
			v11 = true
		end

		if v9 ~= _T.curTransmission then
			if __wf_atom_7e8ad928(v10) or v10 ~= _T.curTransmission then
				OnTransmissionDone()
			else
				v9 = v10
				v10 = v9:__wf_atom_cb26a501()
			end
		end
	end

	if v15 and not __wf_atom_7e8ad928(v14) and v14:__wf_atom_86399a47() then
		v15 = false

		if __wf_atom_7e8ad928(v13) then
			v13 = Resource(__wf_atom_c67f9605:__wf_atom_964056fd())
		end

		__wf_atom_7e8ad928(nil)

		if flag then
			fn27()
		end
	elseif v17 and not __wf_atom_7e8ad928(v16) and v16:__wf_atom_86399a47() or not v18 then
		v17 = false
		fn26()
	end

	if IsInputBlocked() then
		return
	end

	if __wf_atom_c67f9605:__wf_atom_6d03a710() then
		print("Inbox: new build is available! Bailing since message could contain new items that don't exist in current build.")

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowRequireExitMessage", "/Lotus/Language/Menu/MainMenu_NewBuildAvailable")
		end

		if _T.IsInScreenStack == nil or not _T.IsInScreenStack("Inbox") then
			TransitionOut()
		else
			_T.GoToPreviousScreen()
		end
	else
		if v39 and not flag3 then
			v40 -= __wf_atom_084b3e93()

			if v40 < 0 then
				v40 = 3
				module.CreateParticles(mMovie, "PopupFrame.Content.TransBtn", replayTransmissionPulseFx, 0, 27)
			end
		end

		if v35 and not v15 then
			v35 = false
			_T.InboxCustomData = nil

			if not __wf_atom_7e8ad928(mCustomData) and mCustomData ~= "" then
				_T.InboxCustomData = cjson.decode(mCustomData)
			end

			fn11(mCinematic)
		end
	end
end

function OnTransmissionDone()
	if v9 == nil then
		return
	end

	v9 = nil
	v10 = nil
	fn12(false)
	UpdateMessageContent(id)
	flag3 = false
	_T.RadioChatterDisabled = nil
	fn6()

	if not __wf_atom_7e8ad928(v34) and v34:__wf_atom_8598f3a9() then
		_T.QuickSelectTutorialName = tostring(v34)
		_T.OpenScreen("Intel")
		TransitionOut()
	end
end

local function fn30()
	if v36 == nil then
		local movie = __wf_atom_8e4fda44:FindMovie(transmissionMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("PreviewClose", "")
		end
	else
		OnTransmissionDone()
		v36:LoadDiorama(nil)
		v36 = nil
	end
end

function OnConfirmSkipCinematic(p)
	if tonumber(p) == 4 then
		local __wf_atom_c3b255b8 = __wf_atom_392793db:__wf_atom_c3b255b8()

		if not __wf_atom_7e8ad928(__wf_atom_c3b255b8) and __wf_atom_c3b255b8:__wf_atom_7d4910e4() then
			__wf_atom_f2daf912("Skipping Inbox Cinematic")
			__wf_atom_c3b255b8:Skip()
			local movie = __wf_atom_8e4fda44:FindMovie(subtitlesMovie)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("DisplaySubTitle", "")
			end
		end
	end

	_T.ConfirmSkipDialog = nil
end

function OnSkipCinematic()
	if not __wf_atom_7e8ad928(__wf_atom_392793db) then
		local __wf_atom_c3b255b8 = __wf_atom_392793db:__wf_atom_c3b255b8()

		if not __wf_atom_7e8ad928(__wf_atom_c3b255b8) and __wf_atom_c3b255b8:__wf_atom_7d4910e4() then
			_T.ConfirmSkipDialog = module.ShowMessage(
				Localize("/Menu/SkipCinematicConfirm", false),
				"OnConfirmSkipCinematic",
				1
			)
		end
	end
end

function onKeyUp_MENU_CANCEL()
	if _T.InboxCinematic then
		OnSkipCinematic()
	elseif flag3 then
		fn30()
	else
		if IsInputBlocked() then
			return false
		end

		TransitionOut()
		module.PlaySound(_G.UISound_GridOpenTwo)
	end

	return true
end

local function fn31(mTeleportLocation)
	local v42 = mTeleportLocation == 1 and "Market" or ""
	local movie = __wf_atom_8e4fda44:FindMovie(topMenuMovie)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("TriggerConsole", v42)
	end
end

function OnClaimAndUseCoupon()
	if _T.TopMenuOpen then
		_T.CloseScreen("Menu")
	end

	module3.OpenPremiumCurrencySelection(mMovie)
end

function OnMuseumStreamed(p, p2)
	_T.TopMenuMovie:Execute("ForceClose", "")
	module4.OnMuseumStreamed(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	mMovie:Close()
end

function OnDeclinePressed()
	print("guild invitation declined")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928((__wf_atom_18a5d83b:__wf_atom_9be88b01())) then
		return
	end

	local v42 = v4[id]
	local mDeclineAction = v42.mDeclineAction
	local state = v22.State

	if mDeclineAction == 2 then
		fn3(v42.mContextInfo, true)
	elseif mDeclineAction == 3 then
		fn3(v42.mContextInfo)
	elseif v42.mTeleportLocation ~= 0 then
		fn31(v42.mTeleportLocation)
	elseif v42.mURL ~= "" then
		module.DoOpenWebBrowser(v42.mURL, nil, true)
	elseif state == v.EMAIL_SETTINGS then
		TransitionOut()
	elseif state == v.MUSEUM and not __wf_atom_7e8ad928(mMuseum) then
		module4.StreamMuseum(mMuseum)
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	elseif state == v.COUPON then
		module3.OpenPremiumCurrencySelection(mMovie)
	end
end

local function fn32()
	print("guild or alliance invitation confirmed or join request accepted")
	fn22(tostring(v4[id].mId))
	v21:SetVisible(false)
	v22:SetVisible(false)
end

function OnAcceptAction(p, _)
	v30 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		fn32()
	end
end

function OnAcceptActionAlliance(p, _)
	v30 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p == 0 then
		fn32()
	else
		local flag4 = true
		local v42

		if p == 101 then
			v42 = "/Lotus/Language/Menu/SocialOverlay_NonExistentGuildError"
		elseif p == 103 then
			v42 = "/Lotus/Language/Clan/AddToAllianceFail_MaxSize"
		elseif p == 104 then
			v42 = "/Lotus/Language/Dojo/Generic_INVALID_PERMISSION"
		elseif p == 105 then
			v42 = "/Lotus/Language/Clan/ConfirmAllianceFail_TryAgain"
			flag4 = false
		else
			v42 = "/Lotus/Language/Clan/ConfirmAllianceFail_Generic"
		end

		module.ShowMessage(v42)

		if flag4 then
			OnDeclinePressed()
		end
	end
end

function OnAcceptClanInvite(p, value)
	v30 = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		fn23()
		return
	end

	module.ShowMessage("/Lotus/Language/Clan/ConfirmGuildFail")
	flag2 = false

	if string.find(value, "Log%-in") == nil then
		fn22(tostring(v4[id].mId))
	end
end

function OnBoosterPackShown()
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	v30 = false
end

function ProcessBoosterPacks()
	_T.boosterPackCards = {}

	for _ = 1, v26 do
		table.insert(_T.boosterPackCards, v37[1])
		table.remove(v37, 1)
	end

	v28 -= 1
	_T.queuedBoosterPacks = module.Ternary(v28 == 0, nil, v28)
	local v42 = mMovie:PushChildMovie(boosterPackMovie)
	module.PlaySound(_G.UISound_Purchase)

	if v28 < 1 then
		v42:Execute("SetCallback", "OnBoosterPackShown")
	else
		v42:Execute("SetCallback", "ProcessBoosterPacks")
	end

	if mTag > 1 then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Pack_Display_Count", false)
		v42:Execute("SetCaption", (string.format(__wf_atom_8e9ac384, v27, mTag)))
	end

	v42:Execute("SetNumOptions", 1)
	v27 += 1
end

function OnAcceptPressed()
	if v4 == nil or #v4 < id then
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

	local v42 = v4[id]

	if not __wf_atom_7e8ad928(v42.mGifts) then
		return
	end

	local mAcceptAction = v42.mAcceptAction

	if mAcceptAction == 2 or mAcceptAction == 3 or mAcceptAction == 4 then
		v30 = true

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		end
	end

	if mAcceptAction == 2 then
		flag2 = true
		mContextInfo = v42.mContextInfo
		__wf_atom_9be88b01:__wf_atom_dafee647("OnAcceptClanInvite", v42.mContextInfo)
	elseif mAcceptAction == 3 then
		__wf_atom_9be88b01:__wf_atom_0e30f5e7("OnAcceptActionAlliance", v42.mContextInfo)
	end

	print(mAcceptAction)
end

local function fn33(value)
	if string.find(string.lower(value), "not in a guild") ~= nil then
		return true
	end

	if string.find(value, "Request not valid anymore.") == nil then
		return string.find(value, "Only a ruler can leave an alliance") ~= nil
	end

	return true
end

function OnDeclineAction(p, p2)
	v30 = false

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	local v42 = fn33(p2)

	if not (p or v42) then
		print(p2)
		return
	end

	print("guild or alliance invitation declined")

	if v42 then
		print(p2)
	end

	local mDeclineAction = v4[id].mDeclineAction

	if mDeclineAction == 2 or mDeclineAction == 3 or mDeclineAction == 4 then
		fn22(tostring(v4[id].mId))
	end

	v21:SetVisible(false)
	v22:SetVisible(false)
end

function OnGamepadTransition(p)
	local v42 = p == "true"

	if not __wf_atom_7e8ad928(v21) then
		local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v21.mClipName, 13)
		mMovie:__wf_atom_976dcedd(v21.mClipName, "forceMenuSelection", __wf_atom_a91463a8 and not v42)
		v21:Redraw()
	end

	if not __wf_atom_7e8ad928(v22) then
		local __wf_atom_a91463a8 = mMovie:__wf_atom_a91463a8(v22.mClipName, 13)
		mMovie:__wf_atom_976dcedd(v22.mClipName, "forceMenuSelection", __wf_atom_a91463a8 and not v42)
		v22:Redraw()
	end
end

function TransBtnFocused()
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.TransBtn.Outline", 12, 80)
end

function TransBtnUnfocused()
	mMovie:__wf_atom_e57658c2("PopupFrame.Content.TransBtn.Outline", 12, 20)
end

function TransBtnPressed()
	if mTransmission == nil then
		if not __wf_atom_7e8ad928(mCinematic) then
			v35 = true
		end
	elseif not flag3 then
		fn13(mTransmission)
	end
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v2) then
		v2:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v2) then
		v2:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (IsInputBlocked() or __wf_atom_7e8ad928(v2)) then
		v2:SelectElementById(tonumber(p), true)
	end
end

function AttachmentFocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:FocusElementById((tonumber(p)))
	end
end

function AttachmentUnfocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:UnfocusElementById((tonumber(p)))
	end
end

function PrepareToClose()
	TransitionOut()
end

function HideScreenForPlatPurchase(p)
	if p == "true" then
		__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0)
	else
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 100 }, 0.15, 0)
	end
end