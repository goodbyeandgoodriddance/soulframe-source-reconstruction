local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
require("Lotus.Interface.UIStyleUtilities")
local module3 = require("SF.Interface.Libs.ItemUtil")
local module4 = require("SF.Interface.Libs.StatsUtil")
local module5 = require("SF.Interface.Libs.UIUtilities")
local module6 = require("Lotus.Interface.StoreItemUtilities")
local module7 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local v3 = nil
local asyncLoader = module5.CreateAsyncLoader()
local buttonSize2 = 0
local v4 = nil
local v5 = nil
local v6 = nil
local flag = true
local count = 0
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = false
local v12 = false
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = true
local v17 = nil
local v18 = false
local v19 = nil
local v20 = nil
local dialogGridItems = nil
local flag2 = false
local v21 = nil
local v22 = false
local v23 = nil
local label = "/Menu/Confirm_Item_Ok"
local label2 = "/Menu/Confirm_Item_Yes"
local label3 = "/Menu/Confirm_Item_No"
local label4 = ""
local delay = nil
local delay2 = nil
local v24 = nil
local v25 = false
local v26 = 0
local v27 = 0
local v28 = 0
local v29 = 0
local v30 = 0
local v31 = 0
local v32 = nil
local v39 = nil
local v40 = nil
local v41 = nil
local v42 = nil
local v43 = 0
local v44 = nil
local _ = { _ko = true, _ja = true, _zh = true, _tc = true }
local v45 = {}
local v46 = 1
local v47 = 1

local function fn()
	return (delay or delay2 or v24) ~= nil
end

local function fn2()
	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Beige)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v14, true)

	if fn() then
		if #__wf_atom_8e9ac384 > 0 then
			__wf_atom_8e9ac384 ..= "<br><br>"
		end

		__wf_atom_8e9ac384 ..= mMovie:__wf_atom_8e9ac384("/Menu/HoldToConfirm", false)
	end

	local v48 = "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. __wf_atom_8e9ac384 .. "</font></p>"
	mMovie:__wf_atom_50d60589("Dialog.Content.Label", 36, v48)
end

local function fn3()
	if _T.AdditionalDesc then
		mMovie:__wf_atom_50d60589("Dialog.Content.AdditionalDesc.Label", 36, _T.AdditionalDesc)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc", 12, 100)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc.Bg", 11, _G.UIColor_DarkBrown)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc.Bg", 12, 60)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.AdditionalDesc.Label", 41)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc.Bg", 15, __wf_atom_5e6e15c8 + 32)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc.Label", 1, -(__wf_atom_5e6e15c8 / 2) - 4)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.AdditionalDesc.Label", 40)
		local visibilitySize = module.GetVisibilitySize(mMovie, __wf_atom_5e6e15c8_2, true)
		local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 40, true)
		mMovie:OverrideMaterial("Dialog.Content.AdditionalDesc.Bg", secondLabelBackerMaterial)
		mMovie:__wf_atom_1ca72041("Dialog.Content.AdditionalDesc.Bg", "VisibilitySize", visibilitySize, 0, 0, 0)
		mMovie:__wf_atom_1ca72041("Dialog.Content.AdditionalDesc.Bg", "VisibilityFadeSize", visibilityFadeSize, 0, 0, 0)
	end
end

local function fn4()
	local v48 = #v15 > 0
	mMovie:__wf_atom_2dedec1a("Dialog.Title.Border", 13, v48)
	mMovie:__wf_atom_2dedec1a("Dialog.Title.Backer", 13, v48)
	mMovie:__wf_atom_2dedec1a("Dialog.Title.Label", 13, v48)

	if v48 then
		local v49 = "<p><font color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">" .. mMovie:__wf_atom_8e9ac384(v15, true) .. "</font></p>"
		mMovie:__wf_atom_50d60589("Dialog.Title.Label", 36, v49)
		local v50 = mMovie:__wf_atom_5e6e15c8("Dialog.Title.Label", 40) + 2 * (borderTexturePadding + titlePadding)
		mMovie:__wf_atom_e57658c2("Dialog.Title.Border", 14, v50)
		mMovie:__wf_atom_e57658c2("Dialog.Title.Backer", 14, v50)

		if not __wf_atom_7e8ad928(vinesTexture) then
			local v51 = math.min(v26 / 2 - v28, v50 / 2 - borderTexturePadding)
			mMovie:__wf_atom_e57658c2("Dialog.Title.LeftVines", 0, -v51)
			mMovie:__wf_atom_e57658c2("Dialog.Title.RightVines", 0, v51)
		end
	elseif not __wf_atom_7e8ad928(vinesTexture) then
		mMovie:__wf_atom_e57658c2("Dialog.Title.LeftVines", 0, 0)
		mMovie:__wf_atom_e57658c2("Dialog.Title.RightVines", 0, 0)
	end
end

local function fn5()
	fn2()
	fn3()
	fn4()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 11, 0)
end

function Initialize()
	if __wf_atom_7e8ad928(_G.CommonResourcesType) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(uiCommonResourcesMovie)
	end

	mMovie:__wf_atom_384aa4e8("Dialog.Content.Label", "OnHyperlinkPressed")

	if _T.ShowSquadAsItems then
		dialogGridItems = gMatchingService:__wf_atom_bb46d8b6()
		flag2 = true
		_T.ShowSquadAsItems = nil
	else
		dialogGridItems = _T.DialogGridItems
		_T.DialogGridItems = nil
	end

	v = module7.Create(mMovie)
	v:Register(mMovie, "Dialog", { v.ANCHOR_V_CENTRE, v.ANCHOR_H_CENTRE })

	if not __wf_atom_7e8ad928(_T.Dialog_PositionOverride) then
		mMovie:__wf_atom_e57658c2("Dialog", 0, _T.Dialog_PositionOverride)
	end

	_T.DialogOpen = true
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Content", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Scrollbar", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Border", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 12, 0)
	mMovie:__wf_atom_2dedec1a("Dialog.Content.Input", 13, false)
	mMovie:__wf_atom_2dedec1a("Dialog.Content.DropdownContainer", 13, false)
	mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc", 12, 0)
	mMovie:OverrideMaterial("Dialog.Border", borderMaterial)
	mMovie:__wf_atom_e57658c2("Dialog.Border", 11, _G.UIColor_Gold)
	mMovie:OverrideMaterial("Dialog.Backer.Blurer", _G.UIMaterial_BackerBorderFill)
	mMovie:OverrideMaterial("Dialog.Backer.Fill", _G.UIMaterial_BackerBorderFill)
	mMovie:__wf_atom_e57658c2("Dialog.Backer.Fill", 12, _G.UIAlpha_FadedBacker)
	mMovie:__wf_atom_e57658c2("Dialog.Backer.Fill", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_e57658c2("Dialog.Title", 12, 0)
	mMovie:OverrideMaterial("Dialog.Title.Border", borderMaterial)
	mMovie:__wf_atom_e57658c2("Dialog.Title.Border", 11, _G.UIColor_Gold)
	mMovie:OverrideMaterial("Dialog.Title.Backer.Blurer", _G.UIMaterial_BackerBorderFill)
	mMovie:OverrideMaterial("Dialog.Title.Backer.Fill", _G.UIMaterial_BackerBorderFill)
	mMovie:__wf_atom_e57658c2("Dialog.Title.Backer.Fill", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_c90af43a("Dialog.Title.LeftVines", vinesTexture)
	mMovie:__wf_atom_c90af43a("Dialog.Title.RightVines", vinesTexture)
	mMovie:OverrideMaterial("Dialog.Content.AdditionalDesc.Bg", secondLabelBackerMaterial)

	if not __wf_atom_7e8ad928(_T.Dialog_BackerAlphaOverride) then
		mMovie:__wf_atom_e57658c2("Dialog.Backer.Fill", 12, _T.Dialog_BackerAlphaOverride)
	end

	if __wf_atom_7e8ad928(vinesTexture) then
		mMovie:__wf_atom_2dedec1a("Dialog.Title.LeftVines", 13, false)
		mMovie:__wf_atom_2dedec1a("Dialog.Title.RightVines", 13, false)
	else
		local __wf_atom_80cf57aa = vinesTexture:__wf_atom_80cf57aa()
		v28 = __wf_atom_80cf57aa.x / (__wf_atom_80cf57aa.y / vineHeight)
		mMovie:__wf_atom_e57658c2("Dialog.Title.LeftVines", 14, v28)
		mMovie:__wf_atom_e57658c2("Dialog.Title.LeftVines", 15, vineHeight)
		mMovie:__wf_atom_e57658c2("Dialog.Title.RightVines", 14, v28)
		mMovie:__wf_atom_e57658c2("Dialog.Title.RightVines", 15, vineHeight)
	end

	mMovie:__wf_atom_2dedec1a("Dialog.Content.Image", 13, false)
	mMovie:OverrideMaterial("Dialog.Content.Divider", _G.UIMaterial_Divider)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Divider", 12, 40)

	if _T.SetButtons then
		_T.SetButtons(mMovie, {}, getfenv(1))
	end

	local module8 = require("Lotus.Interface.Components.ThemedSpinner")
	v3 = module8.Create(mMovie, "Dialog.Spinner")
	v3:SetActive(false)
	local module9 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module9.CreateTimerMgr()
	flag = false
	v9 = {}
	v9[6] = true
	v9[4] = true
	v9[5] = true
	v10 = {}
	v10[1] = true
	v10[2] = true
	v10[3] = true
	module.PlaySound(_G.UISound_WindowOpen)

	if _T.LiteModeBlocking then
		v8 = 0
		mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, v8 * 100)
	end

	for _, v48 in ipairs(v45) do
		mMovie:__wf_atom_2dedec1a(v48.clip, 13, false)
	end

	table.clear(v45)
	v46 = 1
	v47 = 1

	if not __wf_atom_7e8ad928(_T.DialogSetupCallback) then
		_T.DialogSetupCallback(getfenv(1))
		_T.DialogSetupCallback = nil
	end

	fn5()
end

local function fn6(p, p2)
	local v48 = p and 0.5 or 0.25
	local v49 = v48 / 2
	local ternary = module.Ternary(p, 0.01, 0)
	local ternary2 = module.Ternary(p, 100, 0)
	__wf_atom_ec43d06e(mMovie, "Dialog.Title", 2, { 12 }, { ternary2 }, v49, ternary)
	__wf_atom_ec43d06e(mMovie, "Dialog.Content", 2, { 12 }, { ternary2 }, v49, ternary, p2)

	if v6 > 0 then
		__wf_atom_ec43d06e(mMovie, "Dialog.Border", 2, { 12 }, { ternary2 }, v48, ternary)
		__wf_atom_ec43d06e(mMovie, "Dialog.Backer", 2, { 12 }, { ternary2 }, v48, ternary)
	else
		v3:SetActive(p, v49, ternary)
	end
end

function MouseCatcherPressed(_) end

local function fn7()
	local screenDimensions, v48 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, v48)
end

function onViewportSizeChanged(p, p2)
	fn7()

	if v ~= nil then
		v:Update(p, p2)
	end
end

local function fn8()
	return v27
end

local function fn9(p)
	v27 += p
end

local function fn10()
	local v48 = fn8()
	mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 1, v48 - 2)
	local v49 = v26 / 2
	local v50 = hOuterPadding + v30 - v49
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.IconBacker", 15)

	if __wf_atom_7e8ad928(v19) then
		mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 14, v26 - hOuterPadding * 2)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 0, hOuterPadding - v49)
	else
		local v51 = v50 + v32 + hInnerPadding
		mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 0, v51)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Callout", 0, v51)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 14, v49 - v51 - hOuterPadding)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Callout", 14, v49 - v51 - hOuterPadding)
	end

	local v51 = not (mMovie:__wf_atom_5e6e15c8("Dialog.Content.Label", 40) > 0) and 0
		or math.ceil(mMovie:__wf_atom_5e6e15c8("Dialog.Content.Label", 41) + vInnerPadding)
	local v52 = v51 > 500

	if v52 then
		v51 = 500
		local total = 500
		local total2 = 30

		if v13 then
			v51 -= __wf_atom_5e6e15c8 / 2
			total += __wf_atom_5e6e15c8 / 2
			total2 += __wf_atom_5e6e15c8 / 2
		end

		mMovie:__wf_atom_e57658c2("Dialog.Content.Label", 15, v51)
		mMovie:OverrideMaterial("Dialog.Content.Label", _G.UIMaterial_VerticalVisibilityRangeText)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Scrollbar", 12, 100)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Scrollbar", 0, v26 / 2 - hOuterPadding + 10)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Scrollbar", 1, mMovie:__wf_atom_5e6e15c8("Dialog.Content.Label", 1))
		local module8 = require("SF.Interface.Components.Scrollbar")
		v44 = module8.CreateScrollBar(getfenv(1), "Dialog.Content.Scrollbar", {
			mClipToScroll = "Dialog.Content.Label",
			mVisRangeMaterials = { _G.UIMaterial_VerticalVisibilityRangeText },
			mVisRangeFadeSize = 10
		})
		v44.mEnableSmoothScroll = true
	end

	if not __wf_atom_7e8ad928(v19) then
		local v53 = v50 + v32 / 2
		mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 0, v53)
		mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 0, v53)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Glow", 0, v53)

		if mMovie:__wf_atom_5e6e15c8("Dialog.Content.Callout", 40) > 0 then
			mMovie:__wf_atom_e57658c2("Dialog.Content.Callout", 1, v48 + vInnerPadding + v51)
			v51 += mMovie:__wf_atom_5e6e15c8("Dialog.Content.Callout", 41) + vInnerPadding
		end

		v51 = math.max(v51, __wf_atom_5e6e15c8)
		local v54 = v48 + v51 / 2
		mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 1, v54)
		mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 1, v54)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Glow", 1, v54)
	end

	fn9(v51 + vInnerPadding)
	return v52
end

local function fn11()
	if _T.AdditionalDesc then
		local v48 = fn8()
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.AdditionalDesc", 15)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc", 1, v48 + 30)
		mMovie:__wf_atom_e57658c2("Dialog.Content.AdditionalDesc.Bg", 14, v26 - hOuterPadding * 2)
		fn9(__wf_atom_5e6e15c8)
	end
end

local function fn12()
	if not _T.DialogBackerMessage then
		mMovie:__wf_atom_2dedec1a("Dialog.Content.BackerMessageSymbol", 13, false)
		return
	end

	local v48 = fn8()
	mMovie:__wf_atom_2dedec1a("Dialog.Content.BackerMessageSymbol", 13, true)
	mMovie:__wf_atom_e57658c2("Dialog.Content.BackerMessageSymbol", 1, v48)
	mMovie:__wf_atom_50d60589(
		"Dialog.Content.BackerMessageSymbol.BackerMessageText",
		36,
		mMovie:__wf_atom_8e9ac384(_T.DialogBackerMessage, true)
	)
	mMovie:__wf_atom_50d60589("Dialog.Content.BackerMessageSymbol.BackerMessageText", 11, _G.UIColor_Beige)
	_T.DialogBackerMessage = nil
	fn9(mMovie:__wf_atom_5e6e15c8("Dialog.Content.BackerMessageSymbol", 15))
end

local function fn13()
	local v48 = #dialogGridItems > 0
	local dialogGridItemOwner = _T.DialogGridItemOwner
	_T.DialogGridItemOwner = nil
	mMovie:__wf_atom_2dedec1a("Dialog.Content.ListContainer", 13, v48)

	if v48 then
		local v49 = fn8()
		local module8 = require("EE.Interface.Components.ItemGrid")
		v21 = module8.Create(getfenv(1), "Dialog.Content.ListContainer", {
			mClipCreatedCallback = function(p)
				mMovie:__wf_atom_1ca72041(p .. ".Icon", "VisibilitySize", 2, 0, 0, 0)
				mMovie:__wf_atom_1ca72041(p .. ".IconBg", "VisibilitySize", 2, 0, 0, 0)
				mMovie:__wf_atom_1ca72041(p .. ".IconOutline", "VisibilitySize", 2, 0, 0, 0)
			end,
			mOnFocusedCallback = function(infoPopup_Data)
				local mClipName = infoPopup_Data.mClipName
				asyncLoader:AbortLoad("Tooltip")

				if v23 ~= nil then
					v23()
				end

				local function fn14()
					local statOwner = dialogGridItemOwner
					local creator

					if not __wf_atom_7e8ad928(statOwner) then
						creator = statOwner:__wf_atom_818ea3a7()
					end

					if infoPopup_Data.creator and infoPopup_Data.creator ~= nil then
						creator = infoPopup_Data.creator
					end

					infoPopup_Data.RawItem = nil
					local proxyWeapon, v51 = module4.CreateProxyWeapon(
						statOwner,
						infoPopup_Data.Type,
						infoPopup_Data.Xp,
						infoPopup_Data.weaponUpgrades,
						infoPopup_Data.weaponFingerprints,
						infoPopup_Data.quality,
						nil,
						infoPopup_Data.mShiny,
						creator
					)
					v23 = v51
					infoPopup_Data.StatWeapon = proxyWeapon
					infoPopup_Data.StatOwner = statOwner
					infoPopup_Data.HideAbilities = true
					infoPopup_Data.MetaData = not infoPopup_Data.MetaData and {} or infoPopup_Data.MetaData
					infoPopup_Data.MetaData.HidePrice = true
					module5.SetItemInfoPopupRect(
						mMovie,
						infoPopup_Data,
						mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 2),
						mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 3),
						mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 14),
						mMovie:__wf_atom_cfc41e35(mClipName, "Btn", 15)
					)
					_T.InfoPopup_Data = infoPopup_Data
				end

				if infoPopup_Data.CustomEntry then
					fn14()
				else
					asyncLoader:LoadResource("Tooltip", infoPopup_Data.Type, function()
						fn14()
					end)
				end
			end,
			mOnUnfocusedCallback = function(_)
				if v23 ~= nil then
					v23()
					v23 = nil
				end

				_T.InfoPopup_Data = nil
			end,
			mColumns = 4,
			mRows = math.ceil(#dialogGridItems / 4),
			mPadding = vInnerPadding,
			mColumnSeparation = 122,
			mRowSeparation = 122,
			mScrollAlwaysVisible = false,
			mScrollBarOffset = 18,
			mBackerVisible = false,
			mAlignment = module.CENTER_ALIGNED
		})
		mMovie:__wf_atom_e57658c2("Dialog.Content.ListContainer", 1, v49 - 10)
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		for _, dialogGridItem in dialogGridItems do
			if __wf_atom_7e8ad928(dialogGridItem) or __wf_atom_7e8ad928(dialogGridItem.mItemType) then
				continue
			end

			local v50 = WeakResource(dialogGridItem.mItemType)
			local v51 = nil

			if __wf_atom_964056fd and v50 then
				local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(v50)

				if __wf_atom_232fd31d then
					v51 = module6.GetStoreItemInfo(mMovie, __wf_atom_232fd31d, {
						ItemInfo = dialogGridItem
					})
				end
			end

			if v51 == nil then
				v51 = module6.GetItemTypeInfo(mMovie, dialogGridItem)
			end

			if not __wf_atom_7e8ad928(dialogGridItem) then
				local weaponElementUpgradesAndFingerprintsNoRawItem, weaponFingerprints = module4.GetWeaponElementUpgradesAndFingerprintsNoRawItem(dialogGridItem)

				if not __wf_atom_7e8ad928(weaponElementUpgradesAndFingerprintsNoRawItem) then
					v51.weaponUpgrades = weaponElementUpgradesAndFingerprintsNoRawItem
				end

				if not __wf_atom_7e8ad928(weaponFingerprints) then
					v51.weaponFingerprints = weaponFingerprints
				end

				v51.quality = dialogGridItem.mQuality
				v51.creator = dialogGridItem.mCreator
			end

			if v51 ~= nil then
				v21:AddElement(v51, true)
			end
		end

		for _, dialogGridItem in dialogGridItems do
			if __wf_atom_7e8ad928(dialogGridItem.loadout) then
				continue
			end

			local name = dialogGridItem.name
			local profileImage = cjson.decode(dialogGridItem.loadout).ProfileImage
			local iconTexture = nil

			if #profileImage > 0 then
				local v50 = Resource(profileImage)

				if not __wf_atom_7e8ad928(v50) then
					iconTexture = v50:GetIconTexture()
				end
			end

			if __wf_atom_7e8ad928(iconTexture) then
				iconTexture = _G.UITexture_ProfilePlaceHolder
			end

			local v50 = {
				Name = name,
				Description = dialogGridItem.isLocal and "/SF/Language/Matchmaking/LocalPlayerDesc" or "/SF/Language/Matchmaking/OtherPlayerDesc",
				Icon = iconTexture,
				CustomEntry = true
			}
			v21:AddElement(v50, true)
		end

		for _ = #dialogGridItems, 3 do
			local v50 = {
				Name = mMovie:__wf_atom_8e9ac384("/SF/Language/Matchmaking/NoPlayer", true),
				Description = "/SF/Language/Matchmaking/NoPlayerDesc",
				Icon = timerIcon,
				CustomEntry = true,
				IconAlphaOverride = 50,
				IconColorOverride = _G.UIColor_Tan,
				IconWidthOverride = 48,
				IconHeightOverride = 48
			}
			v21:AddElement(v50, true)
		end

		v21:Redraw(nil, true, true)
		fn9(v21.mRowSeparation * v21.mRows - 10)
	end
end

local function fn14(p)
	local v48 = fn8()
	local v49 = v26 - hOuterPadding * 2
	p.inputField:SetPosition(-v49 / 2, v48)
	p.inputField:SetWidth(v49)
	mMovie:__wf_atom_2dedec1a(p.clip, 13, true)
	fn9(p.inputField.mHeight + vInnerPadding * 2)
end

local function fn15(p)
	local v48 = fn8()
	local v49 = v26 - hOuterPadding * 2
	mMovie:__wf_atom_e57658c2(p.clip, 0, -v49 / 2)
	mMovie:__wf_atom_e57658c2(p.clip, 1, v48)
	p.dropDownMenu:SetWidth(v49)
	mMovie:__wf_atom_2dedec1a(p.clip, 13, true)
	fn9(p.dropDownMenu.mMainButton.mHeight + vInnerPadding * 2)
	p.dropDownMenu:Redraw(nil, true, true)
end

local function fn16()
	if v6 == nil then
		return
	end

	local v48 = vOuterPadding + borderTexturePadding
	v27 = v48
	v26 = (buttonSize2 + hInnerPadding) * v6 - hInnerPadding + hOuterPadding * 2
	v26 = math.max(v26, (math.max(minDialogWidth, v43)))

	if __wf_atom_7e8ad928(v19) then
		if not __wf_atom_7e8ad928(v13) then
			v26 = math.max(v26, v32)
		end
	else
		v26 = math.max(v26, hOuterPadding + v32 + hInnerPadding + v29 + hOuterPadding)
	end

	if #v15 > 0 then
		mMovie:__wf_atom_e57658c2("Dialog.Title.Label", 14, v26)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Title.Label", 40)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Dialog.Title.Label", 43)
		local v49 = (v28 + v48) * 2

		if __wf_atom_5e6e15c8_2 == 1 then
			v26 = math.max(__wf_atom_5e6e15c8 + v49 + 2, v26)
		end

		local v50 = v26 - v49
		mMovie:__wf_atom_e57658c2("Dialog.Title.Label", 14, v50)
		mMovie:__wf_atom_e57658c2("Dialog.Title.Label", 0, -v50 / 2 + 2)
		local v51 = mMovie:__wf_atom_5e6e15c8("Dialog.Title.Label", 41) + vInnerPadding * 2
		mMovie:__wf_atom_e57658c2(
			"Dialog.Title.Label",
			1,
			-v51 / 2 + mMovie:__wf_atom_5e6e15c8("Dialog.Title.Label", 42)
		)
		mMovie:__wf_atom_e57658c2("Dialog.Title.Border", 15, v51 + borderTexturePadding * 2)
		mMovie:__wf_atom_e57658c2("Dialog.Title.Backer", 15, v51 + borderTexturePadding * 2)
		v27 = v51 / 2 + borderTexturePadding + vInnerPadding
	end

	fn2()
	fn3()
	fn4()
	local v49 = fn10()

	for _, v50 in ipairs(v45) do
		if v50.type == "InputField" then
			fn14(v50)
		elseif v50.type == "DropDownMenu" then
			fn15(v50)
		end
	end

	fn11()
	fn12()
	fn13()
	local v50 = vInnerPadding + (topButtonPadding or vInnerPadding) + dividerPadding * 2
	mMovie:__wf_atom_e57658c2("Dialog.Content.Divider", 1, v27 + v50 / 2)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Divider", 14, v26 - hOuterPadding)
	v27 += v50
	local v51 = (v6 - 1) * (buttonSize2 + hInnerPadding)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Buttons", 0, -v51 / 2)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Buttons", 1, v27)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.Buttons.Button.Btn", 15)
	local v52 = v27 + __wf_atom_5e6e15c8 / 2
	v27 = v27 + __wf_atom_5e6e15c8 + v48 + topButtonPadding
	mMovie:__wf_atom_e57658c2("Dialog.Spinner", 1, v52 - v27 / 2)
	fn7()
	local v53 = -(v27 - borderTexturePadding) / 2
	mMovie:__wf_atom_e57658c2("Dialog.Title", 1, v53)
	mMovie:__wf_atom_e57658c2("Dialog.Content", 1, v53)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Guide", 14, v26)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Guide", 15, v27)
	v26 += borderTexturePadding * 2
	v27 += borderTexturePadding * 2
	mMovie:__wf_atom_e57658c2("Dialog.Border", 14, v26)
	mMovie:__wf_atom_e57658c2("Dialog.Border", 15, v27)
	mMovie:__wf_atom_e57658c2("Dialog.Backer", 14, v26)
	mMovie:__wf_atom_e57658c2("Dialog.Backer", 15, v27)

	if v49 then
		v44:ResizeVisRangeMaterials()
	end
end

local function fn17()
	buttonSize2 = buttonSize

	if v4 ~= nil then
		v4:Redraw(nil, false, true)
	end

	if Engine.IsPlayingWithController() then
		buttonSize2 += 40
	end

	buttonSize2 += hInnerPadding

	if v4 ~= nil then
		v4.mForcedHorizontalSeparation = buttonSize2 + hInnerPadding
		v4:Redraw(nil, true, true)
	end

	fn16()
end

local function fn18(p)
	local v48 = tonumber(p)
	v6 = __wf_atom_7e8ad928(v48) and 1 or v48
end

function SetNumOptions(p)
	fn18(p)
end

local function fn19(object)
	__wf_atom_86cbd68d(mMovie, "Dialog.Content.gotoAndStop", 1)
	v19 = nil
	local v48 = not __wf_atom_7e8ad928(object)

	if v48 then
		if v13 == object then
			v48 = false
		else
			v48 = not object:__wf_atom_5583ebb9()
		end
	end

	if v48 then
		v13 = object
		mMovie:__wf_atom_933bbce0("Dialog.Content.Image", v13, _G.UIMaterial_Rectangle)
		mMovie:__wf_atom_1ca72041("Dialog.Content.Image", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041("Dialog.Content.Image", "RectInnerColor", 1, 1, 1, 1)

		if v39 == nil then
			local __wf_atom_80cf57aa = v13:__wf_atom_80cf57aa()

			if v32 == nil then
				v32 = 512
			end

			v39 = __wf_atom_80cf57aa.y / (__wf_atom_80cf57aa.x / v32)
		elseif v32 == nil then
			local __wf_atom_80cf57aa = v13:__wf_atom_80cf57aa()
			v32 = __wf_atom_80cf57aa.x / (__wf_atom_80cf57aa.y / v39)
		end

		mMovie:__wf_atom_e57658c2("Dialog.Content.Image", 14, v32)
		mMovie:__wf_atom_e57658c2("Dialog.Content.Image", 15, v39)
		mMovie:__wf_atom_50d60589("Dialog.Content.Label", 45, v40 or "center")
		mMovie:__wf_atom_50d60589("Dialog.Content.AdditionalDesc.Label", 45, v40 or "center")
	else
		v13 = nil
	end

	mMovie:__wf_atom_2dedec1a("Dialog.Content.Image", 13, v48)
	fn16()

	if v48 and not __wf_atom_7e8ad928(v42) then
		module.CreateUIParticles(mMovie, "Dialog.Content.Image", v42)
	end
end

local function fn20(icon)
	__wf_atom_86cbd68d(mMovie, "Dialog.Content.gotoAndStop", 2)
	v13 = nil
	v32 = v32 or 150
	v39 = v39 or v32
	module3.Initialize(mMovie, "Dialog.Content.Item", {
		Icon = icon,
		SkipDefaultMaterials = false,
		Focused = true
	})
	mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 14, v32 + borderTexturePadding)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 15, v39 + borderTexturePadding)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 5, 100)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Item", 6, 100)
	mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 12, 100)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Item.IconBg", 12, 100)
	mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 14, v32 + borderTexturePadding + 23)
	mMovie:__wf_atom_e57658c2("Dialog.Content.IconBacker", 15, v39 + borderTexturePadding + 23)
	mMovie:__wf_atom_c90af43a("Dialog.Content.IconBacker", vinesBackerTexture)
	mMovie:OverrideMaterial("Dialog.Content.Glow.Shadow", mRankUpBgMaterial)
	mMovie:OverrideMaterial("Dialog.Content.Glow.Mist", mRankUpBgMaterial)
	mMovie:__wf_atom_e57658c2("Dialog.Content.Callout", 44, _G.UIColor_Beige)
	mMovie:__wf_atom_2dedec1a("Dialog.Content.Callout", 52, false)
	mMovie:__wf_atom_50d60589("Dialog.Content.Callout", 36, mMovie:__wf_atom_8e9ac384(v20, true))
	mMovie:__wf_atom_50d60589("Dialog.Content.Callout", 45, "center")
	v29 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.Callout", 40)

	if v29 > 500 then
		mMovie:__wf_atom_2dedec1a("Dialog.Content.Callout", 52, true)
		v29 = mMovie:__wf_atom_5e6e15c8("Dialog.Content.Callout", 40)
	end

	fn16()

	if not __wf_atom_7e8ad928(v42) then
		module.CreateUIParticles(mMovie, "Dialog.Content.Item", v42)
	end
end

local function fn21(object)
	v19 = object
	fn20(object:GetIconTexture())
end

function SetCallout(p)
	v20 = p

	if not __wf_atom_7e8ad928(v19) then
		fn21(v19)
	end
end

function ResourceReady(p, p2)
	if p then
		local icon = Resource(p2)

		if icon:IsA(__wf_atom_d501c105) then
			if v41 ~= "Left" then
				fn19(icon)
				return
			end

			v13 = icon
			v19 = {}
			fn20(icon)
		elseif icon:IsA(__wf_atom_cb425ff5) then
			fn21(icon)
		elseif icon:IsA(slotItemType) then
			fn21(icon)
		else
			print("Unhandled resource: " .. icon:__wf_atom_5b41f63b())
		end
	end
end

function SetGridItems()
	fn16()
end

function SetImage(value, p, p2, p3, p4, p5, p6, p7)
	local v48 = tonumber(p3)

	if v48 ~= nil then
		v30 = v48
	end

	local v49 = tonumber(p6)

	if v49 ~= nil then
		v31 = v49
	end

	v32 = tonumber(p)
	v39 = tonumber(p2)

	if p4 ~= "" and p4 ~= "nil" then
		v40 = p4
	end

	if p5 ~= "" and p5 ~= "nil" then
		v42 = Resource(p5)
	end

	v41 = p7

	if type(value) == "string" then
		if not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:RequestResource(value, "ResourceReady")
		end
	elseif __wf_atom_1ef90898(value) then
		if not __wf_atom_7e8ad928(gGameRules) then
			gGameRules:RequestResource(value:__wf_atom_5b41f63b(), "ResourceReady")
		end
	else
		ResourceReady(true, value)
	end
end

local function fn22(value, list)
	local v48 = _G.StalkerMode
		and value
		and string.find(value, "You will be returned to")
		and "Target's transference connection was interrupted..."
		or value
	local flag3

	if v48 == v14 then
		flag3 = false
	else
		if
			(v48 == "/Menu/SkipCinematicConfirm" or v48 == mMovie:__wf_atom_8e9ac384(
				"/Menu/SkipCinematicConfirm",
				false
			))
			and (module2.InQuestCommitment(gGameData) or _T.ForceHoldToSkip)
		then
			v25 = true
			delay = 1

			if #list == 0 then
				v48 = ""
				list = "/Menu/SkipCinematicConfirm"
			end

			gGameRules:__wf_atom_fb52d63c()
		end

		v14 = v48
		flag3 = true
	end

	if list ~= v15 then
		v15 = list
		flag3 = true
	end

	if flag3 then
		fn2()
		fn4()
	end
end

function SetText(p, p2)
	fn22(p, p2)
end

function SetTextAlign(p)
	mMovie:__wf_atom_50d60589("Dialog.Content.Label", 45, p)
	mMovie:__wf_atom_50d60589("Dialog.Content.AdditionalDesc.Label", 45, p)
	v40 = p
end

local function fn23(p)
	v7 = p
end

function SetCallback(p)
	fn23(p)
end

function SetYesTag(p)
	label2 = p
end

function SetNoTag(p)
	label3 = p
end

local function fn24()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if __wf_atom_2ad5cd23 == nil or v7 == nil then
		if not __wf_atom_7e8ad928(v5) then
			mMovie:__wf_atom_b35a24ab(v5)
		end
	else
		local v48 = ""
		local v49

		if v5 == 4 then
			module.PlaySound(_G.UISound_ButtonSelect)
			v49 = "Yes"
		else
			v49 = v5 == 5 and "No" or v5 == 6 and "Third" or v48
		end

		__wf_atom_2ad5cd23:Execute(v7, v49)
	end

	v11 = true

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_24ce2091("")
	end
end

function Shutdown()
	_T.DialogOpen = nil
	_T.Dialog_PositionOverride = nil
	_T.Dialog_BackerAlphaOverride = nil
	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
	_T.AdditionalDesc = nil

	if v25 and not __wf_atom_7e8ad928(gGameRules) and gGameRules:Paused() then
		gGameRules:__wf_atom_9141808b()
	end

	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(-1)
	end

	if not v11 and v12 then
		v5 = 5
		fn24()
	end

	if v23 ~= nil then
		v23()
		v23 = nil
	end

	asyncLoader:ClearResources()
end

local function fn25()
	return v16 or v6 == 0
end

local function fn26()
	fn24()
	mMovie:Close()
end

local function fn27()
	module.PlaySound(_G.UISound_WindowClose)
	v16 = true
	__wf_atom_ec43d06e(mMovie, "MouseCatcherBtn", 0, { 12 }, { 0 }, 0.2)
	fn6(false, fn26)
end

function TransitionOut()
	fn27()
end

local function fn28(p)
	if not fn25() then
		print("Dialog::" .. "SendResult(" .. tostring(p) .. ")")
		v5 = p

		if v5 == 4 then
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ButtonSelect)
		else
			if v5 == 5 then
			end

			module.PlaySound(_G.UISound_Select)
		end

		if v9[p] then
			fn27()
		else
			fn24()
		end
	end
end

function SendResult_MENU_SELECT()
	if not (fn25() or v17) then
		print("SendResult_MENU_SELECT()")
		fn28(4)
	end

	return true
end

function SendResult_MENU_CANCEL()
	if not fn25() and v6 > 1 and not v17 then
		print("SendResult_MENU_CANCEL()")
		fn28(5)
	end

	return true
end

function SendResult_MENU_GENERIC2()
	if not fn25() and v6 > 2 and not v17 then
		print("SendResult_MENU_GENERIC1()")
		fn28(6)
	end

	return true
end

function ButtonPressed(p, p2)
	if not p2 then
		return
	end

	local mSendResultCallback = p.mSendResultCallback

	if #mSendResultCallback > 0 then
		mMovie:Execute(mSendResultCallback, "")
	end
end

local function fn29()
	if not __wf_atom_7e8ad928(v4) then
		v4:FocusElement(v6)
		v16 = false
	end

	if _T.DialogOpenCallback ~= nil then
		_T.DialogOpenCallback()
		_T.DialogOpenCallback = nil
	end
end

local function fn30()
	flag = true
	local _ = { mClipName = "Dialog" }

	if v6 == 0 then
		mMovie:__wf_atom_2dedec1a("Dialog.Content.Buttons", 13, false)
		fn16()
	else
		local module8 = require("SF.Interface.Components.Button")
		local module9 = require("EE.Interface.Components.List")
		v4 = module9.CreateList(mMovie, "Dialog.Content.Buttons.Button")
		v4.mTransitionInDeltaY = 0
		v4.mTransitionOutDeltaY = 0
		v4.mElementTransitionTime = 0
		v4.mForcedVerticalSeparation = 0

		function v4:mElementDrawCallback()
			if __wf_atom_7e8ad928(self.mButton) then
				local mButton = module8.Create(mMovie, self.mClipName, self.Label, nil, "<" .. self.Callout .. ">")
				mButton.mOnPressCompletedCallback = ButtonPressed
				mButton:SetId(self.Id)
				mButton.mSendResultCallback = "SendResult_" .. self.Callout
				mButton.mHoldDuration = self.Delay or 0
				local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(self.mClipName, "TextHolder.Label", 40)
				local v49 = __wf_atom_cfc41e35 == nil and 0 or __wf_atom_cfc41e35

				if buttonSize2 < v49 then
					buttonSize2 = v49
				end

				mButton:Redraw()
				self.mButton = mButton
			else
				self.mButton:SetPosition(
					mMovie:__wf_atom_5e6e15c8(self.mClipName, 0),
					mMovie:__wf_atom_5e6e15c8(self.mClipName, 1),
					module.CENTER_ALIGNED
				)
				self.mButton:SetWidth(buttonSize2)
			end
		end

		if v6 == 1 then
			v4:AddElement({ Label = label, Result = 4, Callout = "MENU_SELECT", Delay = delay }, true)
		elseif v6 >= 2 then
			v4:AddElement({ Label = label2, Result = 4, Callout = "MENU_SELECT", Delay = delay }, true)

			if v6 == 3 then
				v4:AddElement({
					Label = label4,
					Result = 6,
					Callout = "MENU_GENERIC2",
					Delay = delay2
				}, true)
			end

			local v48 = v4
			local v49 = { Label = label3, Result = 5, Callout = "MENU_CANCEL", Delay = 0 }
			local delay3

			if v6 == 3 then
				delay3 = v24
			else
				delay3 = delay2
			end

			v49.Delay = delay3
			v48:AddElement(v49, true)
		end

		fn17()
	end

	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 12, 0)
	__wf_atom_ec43d06e(mMovie, "MouseCatcherBtn", 0, { 12 }, { module.Ternary(v8 ~= nil, v8, 0.9) * 100 }, 0.2, 0)
	mMovie:__wf_atom_e57658c2("_root", 12, 100)
	fn6(true)
	v2:AddTimer(0.2, fn29)
end

function Update()
	local v48 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v48)

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v48)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:Update()
	end

	asyncLoader:Update()

	if flag2 then
		local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

		if #__wf_atom_bb46d8b6 ~= #dialogGridItems then
			dialogGridItems = __wf_atom_bb46d8b6
			SetGridItems()
		end
	end

	if flag then
		return
	end

	if not __wf_atom_7e8ad928(v14) and v6 ~= nil then
		fn30()
		return
	end

	count += 1

	if count > 5 then
		mMovie:Close()
	end
end

function AddDropDownMenuComponent(options)
	local v48 = v47
	local clip = "Dialog.Content.DropdownContainer" .. v48

	if not mMovie:__wf_atom_253d7085(clip) then
		__wf_atom_86cbd68d(
			mMovie,
			"Dialog.Content.DropdownContainer.duplicateMovieClip",
			"DropdownContainer" .. v48,
			v48 + 1000
		)
	end

	v47 += 1
	require("SF.Interface.Components.InputField")
	local module8 = require("SF.Interface.Components.DropDownMenu")
	local dropDownMenu = module8.Create(getfenv(1), clip .. ".Dropdown", options or {})
	table.insert(v45, { type = "DropDownMenu", clip = clip, dropDownMenu = dropDownMenu })
	fn16()
	return dropDownMenu
end

function AddInputFieldComponent(options)
	local v48 = v46
	local clip = "Dialog.Content.Input" .. v48

	if not mMovie:__wf_atom_253d7085(clip) then
		__wf_atom_86cbd68d(mMovie, "Dialog.Content.Input.duplicateMovieClip", "Input" .. v48, v48)
	end

	v46 += 1
	local module8 = require("SF.Interface.Components.InputField")
	local v50 = options or {}
	v50.mSkipAutoFocus = v48 ~= 1
	local inputField = module8.Create(getfenv(1), clip, v50)
	inputField:SetType(inputField.TYPE.PLAIN)
	inputField.Library_InputFieldFocused = inputField.InputFieldFocused

	function inputField.InputFieldFocused(object, p)
		if p then
			v17 = object
		elseif object == v17 then
			v17 = nil
		end

		object:Library_InputFieldFocused(p)
	end

	inputField:UpdateColors()
	table.insert(v45, { type = "InputField", clip = clip, inputField = inputField })
	fn16()
	return inputField
end

local function fn31()
	local flag3 = false
	local inputField = nil

	for _, v48 in ipairs(v45) do
		if v48.type ~= "InputField" then
			continue
		end

		if flag3 then
			inputField = v48.inputField
		elseif v48.inputField == v17 then
			flag3 = true
		end
	end

	if not inputField then
		return false
	end

	inputField:TryPressed(true)
	return true
end

function CreateOkCancel(p, p2, p3, p4)
	print("Dialog::" .. "CreateOkCancel(description=" .. p .. ", leftItem=" .. tostring(p3) .. ", rightItem=" .. tostring(p4) .. ")")

	if
		(__wf_atom_7e8ad928(p3) or p3 == "" or p3 == "undefined")
		and (__wf_atom_7e8ad928(p4) or p4 == "" or p4 == "undefined")
	then
		fn18(0)
	else
		fn18(2)
		label2 = p3
		label3 = p4
	end

	fn22(p, p2)
end

function CreateOk(p, p2, p3)
	print("Dialog::" .. "CreateOk(description=" .. p .. ", leftItem=" .. tostring(p3) .. ")")

	if __wf_atom_7e8ad928(p3) or p3 == "" or p3 == "undefined" then
		fn18(0)
	else
		fn18(1)
		label = p3
	end

	fn22(p, p2)
end

function CreateMultiButtonDialog(p, p2, p3, p4, p5)
	print("Dialog::" .. "CreateMultiButtonDialog(description=" .. p .. ", firstItem=" .. tostring(p3) .. ", secondItem=" .. tostring(p4) .. ", thirdItem=" .. tostring(p5) .. ")")

	if
		(__wf_atom_7e8ad928(p3) or p3 == "" or p3 == "undefined")
		and (__wf_atom_7e8ad928(p4) or p4 == "" or p4 == "undefined")
		and (__wf_atom_7e8ad928(p5) or p5 == "" or p5 == "undefined")
	then
		fn18(0)
	else
		fn18(3)
		label2 = p3
		label4 = p4
		label3 = p5
	end

	fn22(p, p2)
end

function onRawInputEvent(gDialogDeviceID, p, p2)
	if v16 and not __wf_atom_7e8ad928(v4) then
		return false
	end

	if p == "EN_LSHIFT" or p == "EN_RSHIFT" then
		v22 = p2 == "1"
	end

	if p == "EN_ENTER" and p2 == "1" then
		if v17 and (not v17.mMultiline or v22) and not fn31() then
			fn28(4)
		end
	elseif p == "EN_TAB" and p2 == "1" then
		if v17 then
			fn31()
		end
	elseif p == "EN_ESCAPE" then
		fn28(5)
	end

	_T.gDialogDeviceID = gDialogDeviceID
	return false
end

local function fn32(p, p2)
	v10[p] = p2

	if not __wf_atom_7e8ad928(v4) then
		local elementInIndex = v4:GetElementInIndex(p)

		if not __wf_atom_7e8ad928(elementInIndex) then
			local mButton = elementInIndex.mButton

			if not __wf_atom_7e8ad928(mButton) then
				mButton:SetActive(p2)
			end
		end
	end
end

function SetButtonActive(p)
	fn32(tonumber(p), true)
end

function SetButtonInactive(p)
	fn32(tonumber(p), false)
end

function SetResultClosesMovie(p)
	v9[tonumber(p)] = true
end

function SetResultDoesNotCloseMovie(p)
	v9[tonumber(p)] = false
end

function ForceClose()
	mMovie:Close()
end

function SetDisableLocalization(p)
	v18 = p == "true"
end

function SetButtonDelays(p, p2, p3)
	delay = tonumber(p)
	delay2 = tonumber(p2)
	v24 = tonumber(p3)
end

function SetSendCallbackOnShutdown(p)
	v12 = p == "true"
end

function SetWidthOverride(p)
	v43 = tonumber(p)
end

function onKeyDown_HIDE_PAUSE_MENU()
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW()
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW_ALT()
	return true
end

function onKeyDown_MENU_LEFT()
	if v21 == nil or v21.mCurrentElementIndex == nil then
		return
	end

	local elementInIndex = v21:GetElementInIndex(v21.mCurrentElementIndex)

	if v21:GetElementColumn(elementInIndex) ~= 1 then
		return
	end

	local v48 = mMovie:__wf_atom_79258be8() - v21.mColumnSeparation
	local __wf_atom_7c4b8de8 = mMovie:__wf_atom_7c4b8de8()
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v48, __wf_atom_7c4b8de8)
	mMovie:__wf_atom_fbca497c(false)
	return true
end

function onKeyDown_MENU_RIGHT()
	if v21 == nil or v21.mCurrentElementIndex == nil then
		return
	end

	local elementInIndex = v21:GetElementInIndex(v21.mCurrentElementIndex)

	if v21:GetElementColumn(elementInIndex) ~= v21.mColumns then
		return
	end

	local v48 = mMovie:__wf_atom_79258be8() + v21.mColumnSeparation
	local __wf_atom_7c4b8de8 = mMovie:__wf_atom_7c4b8de8()
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(v48, __wf_atom_7c4b8de8)
	mMovie:__wf_atom_fbca497c(false)
	return true
end

function onKeyDown_MENU_UP()
	if v21 == nil or v21.mCurrentElementIndex == nil then
		return
	end

	local elementInIndex = v21:GetElementInIndex(v21.mCurrentElementIndex)

	if v21:GetElementRow(elementInIndex) ~= 1 then
		return
	end

	local __wf_atom_79258be8 = mMovie:__wf_atom_79258be8()
	local v48 = mMovie:__wf_atom_7c4b8de8() - v21.mRowSeparation
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(__wf_atom_79258be8, v48)
	mMovie:__wf_atom_fbca497c(false)
	return true
end

function onKeyDown_MENU_DOWN()
	if v21 == nil or v21.mCurrentElementIndex == nil then
		return
	end

	local elementInIndex = v21:GetElementInIndex(v21.mCurrentElementIndex)

	if v21:GetElementRow(elementInIndex) ~= math.floor(v21.mRows) then
		return
	end

	local __wf_atom_79258be8 = mMovie:__wf_atom_79258be8()
	local v48 = mMovie:__wf_atom_7c4b8de8() + v21.mRowSeparation
	gRegion:__wf_atom_eab484a7():__wf_atom_a16f9b3c(__wf_atom_79258be8, v48)
	mMovie:__wf_atom_fbca497c(false)
	return true
end

function OnGamepadTransition(p)
	mMovie:__wf_atom_fbca497c(p == "true")
	fn17()
end

function OnStyleChangedCallback()
	fn5()
end

function SupportsThemes()
	return true
end

function OpenFileFlashMovie(_, _)
	TestInputField()
end

function DummyCallback() end

function TestConfirmationBox()
	module.ShowYesOrNoMessage(
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END",
		"DummyCallback",
		nil,
		"Test Test Test"
	)
end

function TestShortText()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus. END"
	dialogSettings.titleString = "Test Test Test"
	module.ShowCustomMessage(dialogSettings)
end

function TestLongTextLongTitle()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END"
	dialogSettings.titleString = "Test Test TestTest Test TestTest Test TestTest Test Test"
	module.ShowCustomMessage(dialogSettings)
end

function TestLongText()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END"
	dialogSettings.titleString = "Test Test Test"
	module.ShowCustomMessage(dialogSettings)
end

function TestShowLongOptionsMessage()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 5
	dialogSettings.firstString = "Super_Long_Confirm_Item_Yes"
	dialogSettings.secondString = "Super_Long_Confirm_Item_No"
	dialogSettings.thirdString = "Super_Long_Confirm_Item_Maybe_So?"
	dialogSettings.firstDelay = 2
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END"
	dialogSettings.titleString = "Test Test TestTest Test TestTest Test TestTest Test Test"
	module.ShowCustomMessage(dialogSettings)
end

function TestStoreItem()
	local v48 = WeakResource("/SF/StoreItems/Types/Items/Consumables/VerminiaPotion")
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END"
	dialogSettings.titleString = "Test Title"
	dialogSettings.icon = v48:__wf_atom_5b41f63b() .. ",100,100,nil,nil,/Lotus/Fx/Interface/IdentifyResourceFanfare"
	module.ShowCustomMessage(dialogSettings):Execute("SetCallout", "Test Callout")
end

function TestWithIcon()
	local v48 = Resource("/SF/Interface/Graphics/WaypointMarkers/Tree.png")
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 0
	dialogSettings.locString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in nisi sed elit vestibulum bibendum imperdiet quis turpis. Duis convallis tempus lectus, fermentum consequat orci porttitor ac. Praesent sollicitudin orci ut eros pretium auctor. Proin eget sodales elit. Nunc tincidunt bibendum finibus. Morbi enim ipsum, feugiat nec augue vitae, ornare fermentum risus. Aliquam placerat risus tortor, a vestibulum leo sodales blandit. Praesent ut ultrices nulla. Ut porta ultrices ligula, a scelerisque ipsum volutpat eu.Integer efficitur sem ante, nec vehicula lectus ornare malesuada. Cras cursus rhoncus felis non laoreet. Proin venenatis, dui eget ultricies mollis, enim nulla hendrerit mauris, a blandit massa nisi quis urna. Proin et sem vel tellus dapibus laoreet ac maximus lacus. Donec elementum eleifend magna vel pretium. Aliquam ac mollis diam. In nec vulputate urna. Vestibulum eu magna at quam rutrum porta. Sed ut dui vel leo euismod facilisis et id magna.Vivamus laoreet commodo accumsan. Duis eros magna, consectetur ut leo eget, iaculis dignissim risus. Fusce molestie mollis finibus. Mauris semper, neque nec facilisis dignissim, sapien augue porta ex, fermentum congue purus orci nec mauris. Vivamus nec nunc accumsan, accumsan risus nec, hendrerit diam. Mauris in mi pulvinar, suscipit lectus eu, mollis quam. Sed mi est, interdum ut aliquam sit amet, interdum eu nisi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Integer elementum pulvinar facilisis. Nam eros enim, rutrum et sem eget, auctor vehicula mauris.Nam eu quam non lacus efficitur rhoncus sit amet in metus. Suspendisse hendrerit nisi a tincidunt iaculis. Vestibulum sodales augue vitae luctus placerat. Quisque varius ultrices ex, mollis lacinia est rutrum dictum. Proin posuere, ex sit amet tempus elementum, sapien erat semper purus, a malesuada odio purus at ipsum. Sed ut placerat eros. Vivamus euismod diam metus. Fusce magna velit, facilisis non diam vel, rutrum blandit felis. Donec et tellus eget elit mollis consequat eget ac erat.Ut in tellus dignissim, pellentesque ex sed, viverra leo. Aliquam accumsan, nunc pretium efficitur imperdiet, augue libero malesuada sapien, et placerat ante mi eu augue. Nullam erat ipsum, laoreet a nisi ac, faucibus pharetra sapien. Vestibulum dapibus justo et sapien ullamcorper, sed cursus metus rhoncus. In turpis purus, rutrum a pulvinar id, sollicitudin id sapien. Nulla vitae dui id erat bibendum efficitur ut vel diam. Ut pharetra interdum lectus non consequat. In tincidunt sagittis turpis, eu pretium nunc vehicula nec. Nullam tempus, leo vitae eleifend eleifend, felis risus posuere tortor, eu tristique turpis orci non elit. Ut ultricies convallis nisi, id feugiat ex finibus lobortis. Fusce pellentesque accumsan feugiat. Nunc sit amet pulvinar lorem. Curabitur imperdiet leo eget mi auctor rutrum. Sed sodales tristique sodales. Suspendisse vulputate maximus pulvinar. END"
	dialogSettings.alignment = 0
	dialogSettings.icon = v48:__wf_atom_5b41f63b() .. ",100,100,nil,nil,nil,nil,Left"
	module.ShowCustomMessage(dialogSettings)
end

function TestInputField()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.titleString = "Test Title"
	dialogSettings.firstString = "Super_Long_Confirm_Item_Yes"
	dialogSettings.secondString = "Super_Long_Confirm_Item_No"
	local v48 = nil

	function _T.DialogSetupCallback(p)
		p.AddInputFieldComponent()
		p.AddInputFieldComponent()
		v48 = p.AddDropDownMenuComponent()
		v48:AddElement({ Name = "Test1", Id = 1 })
		v48:AddElement({ Name = "Test2", Id = 2 })
		v48:AddElement({ Name = "Test3", Id = 3 })
		v48:SelectElementById(1)
		v48:Redraw(nil, true, true)
	end

	dialogSettings:SetCallback(function(_) end)
	module.ShowCustomMessage(dialogSettings)
end

function TestEverythingAtOnce()
	WeakResource("/SF/Types/StoreItems/SlotItems/WeaponSlotItem")
	_T.DialogGridItems = { gMatchingService:__wf_atom_bb46d8b6() }
	_T.DialogGridItemOwner = gRegion:__wf_atom_c4f78a8f()
	_T.DialogBackerMessage = "[HC] Dialog backer message"
	_T.AdditionalDesc = "[HC] Additional Desc"
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "[HC] Short body text"
	dialogSettings.titleString = "Test Title"
	dialogSettings.firstString = "Super_Long_Confirm_Item_Yes"
	dialogSettings.secondString = "Super_Long_Confirm_Item_No"
	module.ShowCustomMessage(dialogSettings)
end

function OnHyperlinkPressed(p)
	module.DoOpenWebBrowser(p)
	module5.OnHyperlinkPressed(mMovie)
end