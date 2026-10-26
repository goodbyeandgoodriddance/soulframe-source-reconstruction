local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("SF.Interface.SFUtilities")
local module3 = require("Lotus.Interface.SyndicateUtilities")
local module4 = require("EE.Interface.Utilities")
local module5 = require("SF.Interface.Libs.ItemUtil")
local module6 = require("Lotus.Interface.StoreItemUtilities")
local module7 = require("SF.Interface.Libs.UIUtilities")
local module8 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local asyncLoader = module7.CreateAsyncLoader()
local v5 = nil
local v6 = true
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local flag = false
local total = 0
local flag2 = false
local flag3 = false
local v11 = false
local v12 = false
local showSyndicate = nil
local v13 = nil
local mLabel = ""
local v14 = nil
local v15 = Resource("/Lotus/Types/Game/Store/ProductsManifest")

local function fn()
	if __wf_atom_7e8ad928(showSyndicate) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local __wf_atom_e0f044e1 = showSyndicate:__wf_atom_e0f044e1()
	return gGameData:__wf_atom_51dd1b95(__wf_atom_e0f044e1).mInitiated
end

local function fn2(p, p2, reputationInfoForSyndicate, p3, p4, _, __wf_atom_3721e8fd)
	local v16 = p .. ".FactionRank"
	local v17 = module4.FormatNumber(p3) .. "/" .. module4.FormatNumber(p4)
	local v18 = not (p4 > 0) and 1 or p3 / p4 + 0.0001
	mMovie:__wf_atom_4c1c1986(v16, "RankBar.Cap", 0, v18 * 256 - 4)
	mMovie:__wf_atom_4c1c1986(v16, "RankBar.Mask", 14, v18 * 256)
	mMovie:__wf_atom_48bd5a59(v16, "Text.RankProgress", 36, v17)
	mMovie:__wf_atom_48bd5a59(v16, "Text.RankNumber", 36, reputationInfoForSyndicate)
	mMovie:__wf_atom_48bd5a59(v16, "Text.FactionTitle", 36, p2)
	mMovie:__wf_atom_4c1c1986(v16, "Text.RankProgress", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_4c1c1986(v16, "Text.RankNumber", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(v16, "Text.FactionTitle", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_c90af43a(v16 .. ".SmallFactionIcon", __wf_atom_3721e8fd)
	module2.CenterClipAroundText(mMovie, v16 .. ".Text.FactionTitle", v16 .. ".LeftLeaf", true, 30)
	module2.CenterClipAroundText(mMovie, v16 .. ".Text.FactionTitle", v16 .. ".RightLeaf", false, 28)
end

local function fn3(p, p2, __wf_atom_dc1594a9, __wf_atom_2c7ac218)
	local v16 = p .. ".DailyStanding"
	local v17 = __wf_atom_2c7ac218 - __wf_atom_dc1594a9
	local v18 = not (__wf_atom_2c7ac218 > 0) and 1 or v17 / __wf_atom_2c7ac218 + 0.0001
	local v19 = module4.FormatNumber(v17) .. "/" .. module4.FormatNumber(__wf_atom_2c7ac218)
	mMovie:__wf_atom_4c1c1986(v16, "RankBar.Cap", 0, v18 * 256 - 4)
	mMovie:__wf_atom_4c1c1986(v16, "RankBar.Mask", 14, v18 * 256)
	mMovie:__wf_atom_48bd5a59(v16, "Count", 36, v19)
	mMovie:__wf_atom_48bd5a59(v16, "Title", 36, p2)
	mMovie:__wf_atom_48bd5a59(v16, "Count", 0, -mMovie:__wf_atom_cfc41e35(v16, "Count", 14) / 2)
	mMovie:__wf_atom_48bd5a59(v16, "Title", 0, -mMovie:__wf_atom_cfc41e35(v16, "Title", 14) / 2)
	mMovie:__wf_atom_4c1c1986(v16, "Title", 11, _G.UIColor_Tan)
	mMovie:__wf_atom_4c1c1986(v16, "Count", 11, _G.UIColor_Tan)
	module2.CenterClipAroundText(mMovie, v16 .. ".Title", v16 .. ".LeftLeaf", true, 30)
	module2.CenterClipAroundText(mMovie, v16 .. ".Title", v16 .. ".RightLeaf", false, 25)
end

local function fn4(instance)
	if instance:IsA(WeakResource("/SF/Syndicates/FeySyndicate")) then
		return 5
	end

	return 15
end

local function fn5(showSyndicate2)
	if __wf_atom_7e8ad928(showSyndicate2) or __wf_atom_7e8ad928(mMovie) then
		return
	end

	showSyndicate = showSyndicate2
	showSyndicate2:__wf_atom_3721e8fd()
	local _, v16, v17, _, _ = module.GetReputationInfoForSyndicate(showSyndicate2)
	local mRankProgress = not (v17 > 0) and 0 or v16 / v17 * 100
	local v18 = __wf_atom_7e8ad928(showSyndicate2:__wf_atom_72e5f32c()) and "<REPUTATION>"
		or "<" .. tostring(showSyndicate2:__wf_atom_72e5f32c()) .. ">"
	local reputationInfoForSyndicate, v19, v20, v21, _ = module.GetReputationInfoForSyndicate(showSyndicate2)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(showSyndicate2:__wf_atom_818ea3a7():c_str(), false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(showSyndicate2:__wf_atom_0da28bec():c_str(), false)
	local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/VotivesHint", true, {
		FACTION_NAME = __wf_atom_8e9ac384
	})
	local __wf_atom_3721e8fd = showSyndicate2:__wf_atom_3721e8fd()
	local iconTexture = showSyndicate2:GetIconTexture()
	local v22 = not showSyndicate2:__wf_atom_75de2a4d() and ""
		or mMovie:__wf_atom_8e9ac384(showSyndicate2:__wf_atom_30fc1c90(reputationInfoForSyndicate):c_str(), false)
	v13 = reputationInfoForSyndicate
	fn2("Container.InfoPanel", v22, reputationInfoForSyndicate, v19, v20, v21, __wf_atom_3721e8fd)
	local v23 = mMovie:__wf_atom_cfc41e35("Container.InfoPanel", "Bg", 14) - 80
	mMovie:__wf_atom_4c1c1986("Container.InfoPanel", "Description", 0, -v23 / 2)
	mMovie:__wf_atom_4c1c1986("Container.InfoPanel", "Description", 14, v23)
	local convertColorNumberToHex = module4.ConvertColorNumberToHex(_G.UIColor_Yellow)
	local v24 = "<p><font color=\"" .. module4.ConvertColorNumberToHex(_G.UIColor_Tan) .. "\">" .. "<font face=\"Spectral SC\" size=\"36\" color=\"" .. convertColorNumberToHex .. "\">" .. __wf_atom_8e9ac384 .. "<br></font>" .. __wf_atom_8e9ac384_2 .. "<br><br><font color=\"" .. convertColorNumberToHex .. "\">" .. __wf_atom_8e9ac384_3 .. "</font></font></p>"
	mMovie:__wf_atom_48bd5a59("Container.InfoPanel", "Description", 36, v24)
	local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35("Container.InfoPanel", "Description", 41)
	local v25 = 110 + (mMovie:__wf_atom_cfc41e35("Container.InfoPanel", "FactionRank", 1) - 110) / 2 - __wf_atom_cfc41e35 / 2
	mMovie:__wf_atom_4c1c1986("Container.InfoPanel", "Description", 1, v25)
	mMovie:__wf_atom_4c1c1986(
		"Container.InfoPanel",
		"DailyStanding",
		1,
		v25 - mMovie:__wf_atom_cfc41e35("Container.InfoPanel", "DailyStanding", 15)
	)
	mMovie:__wf_atom_c90af43a("Container.InfoPanel.FactionIcon", iconTexture)
	mMovie:__wf_atom_4c1c1986("Container.InfoPanel", "FactionIcon", 12, fn4(showSyndicate2))
	local v26 = __wf_atom_c67f9605:__wf_atom_8d7c7c8b() <= reputationInfoForSyndicate
	v11 = v21 and fn() and not v26
	SetRankupVisible(v11 and not v12)
	SetFavorsVisible(v6)
	local _, amount, _, _, _ = module.GetReputationInfoForSyndicate(showSyndicate2)
	local __wf_atom_bca3f82a = showSyndicate2:__wf_atom_bca3f82a()

	if __wf_atom_bca3f82a > 0 and __wf_atom_bca3f82a < 3 then
		local __wf_atom_dc1594a9 = gGameData:__wf_atom_dc1594a9(__wf_atom_bca3f82a)
		local __wf_atom_2c7ac218 = __wf_atom_c67f9605:__wf_atom_2c7ac218(gGameData:__wf_atom_a04e4a53())

		if showSyndicate2:__wf_atom_73f36e1b() then
			mMovie:__wf_atom_7f57ab2f("Container.InfoPanel", "DailyStanding", 13, true)
			fn3(
				"Container.InfoPanel",
				mMovie:__wf_atom_8e9ac384("/SF/Language/Syndicates/DailyCap", true),
				__wf_atom_dc1594a9,
				__wf_atom_2c7ac218
			)
		else
			mMovie:__wf_atom_7f57ab2f("Container.InfoPanel", "DailyStanding", 13, false)
		end
	end

	mMovie:OverrideMaterial("Container.InfoPanel", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.Bg", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionName", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.Description", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionIcon", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.SmallFactionIcon", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.DecoIcon", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.LeftLeaf", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.RightLeaf", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.RankBar", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.RankBar.Cap", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.Text.RankNumber", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.Text.RankProgress", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.FactionRank.Text.FactionTitle", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.Title", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.Count", dissolveMaterialSDF)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.Icon", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.LeftLeaf", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.RightLeaf", dissolveMaterial)
	mMovie:OverrideMaterial("Container.InfoPanel.DailyStanding.RankBar", dissolveMaterial)
	local mCustomCurrencies = {
		{
			Icon = mMovie:__wf_atom_8e9ac384(v18, true),
			Amount = amount,
			Name = Localize("/SF/Language/Currency/StandingCurrencyName", nil),
			LocalizedDesc = __wf_atom_8e9ac384_3
		}
	}
	local v27 = {
		mMovie = mMovie,
		mLabel = mLabel,
		mLevel = reputationInfoForSyndicate,
		mRankProgress = mRankProgress,
		mCustomCurrencies = mCustomCurrencies,
		mOverwriteCurrencies = true,
		mMinWidth = 608
	}

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v27)
	end
end

function SetNPCName(p)
	mLabel = p

	if not __wf_atom_7e8ad928(showSyndicate) then
		fn5(showSyndicate)
	end
end

local function fn6(p)
	__wf_atom_ec43d06e(mMovie, "Container.InfoPanel", 0, { function(p2)
			if p then
				p2 = 1 - p2
			end

			for _, v16 in v14 do
				v16:__wf_atom_a042ff6c(Symbol("Dissolve"), p2)
			end
		end }, { 1 }, 0.5)
end

function SetOnShowOfferingsVendor(p)
	v8 = p
end

local function fn7()
	local __wf_atom_e0f044e1 = showSyndicate:__wf_atom_e0f044e1()
	local __wf_atom_51dd1b95 = gGameData:__wf_atom_51dd1b95(__wf_atom_e0f044e1)
	return __wf_atom_51dd1b95:__wf_atom_c984c1f3(__wf_atom_51dd1b95.mTitle)
end

function ShowOfferingsVendor()
	if __wf_atom_7e8ad928(showSyndicate) then
		return
	end

	local v16 = false

	if fn7() then
		flag2 = true
	else
		v16 = flag2 and true or false
	end

	if v8 ~= nil and not __wf_atom_7e8ad928(_T[v8]) then
		_T[v8]()
	end

	local v17 = {}
	module3.InitializeSyndicateData(showSyndicate, v17)
	local reputationInfoForSyndicate, reputation, reputationRequired, hasEnoughReputationForSacrifice = module.GetReputationInfoForSyndicate(showSyndicate)
	v17.Level = reputationInfoForSyndicate
	v17.Reputation = reputation
	v17.ReputationRequired = reputationRequired
	v17.HasEnoughReputationForSacrifice = hasEnoughReputationForSacrifice
	v17.CurrentTitle = "/Lotus/Language/Syndicates/NeutralTitle"
	_T.VendorSyndicate = showSyndicate
	_T.OnVendorBuyItem = OnClaimOffering
	v = module3.CreateFavorsMovie(mMovie, vendorMovie, flag2, v17, "", false)
	v:Execute("SetOnBuyVendorItem", "OnVendorBuyItem")
	v:Execute("SetRewardMode", tostring(flag2) .. "," .. tostring(v16))
	SetFavorsVisible(false)
	SetRankupVisible(false)
	v12 = true
	fn6()
end

function SetOnCloseFunction(p)
	v7 = p
end

local function fn8()
	if flag then
		return
	end

	flag = true

	if v7 ~= nil and not __wf_atom_7e8ad928(_T[v7]) then
		_T[v7]()
	end

	module2.DissolveOutAndClose(mMovie)

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	mMovie:__wf_atom_0c1c47f2(nil)
end

local function fn9()
	local v16 = {}

	if not flag2 then
		table.insert(v16, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = fn8,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v16, getfenv(1))
	end
end

local function fn10()
	local module9 = require("SF.Interface.Components.Button")
	v2 = module9.Create(
		mMovie,
		"Container.InfoPanel.RankUpButton",
		"/SF/Language/Syndicates/FactionRankUp",
		"AskToRankUp"
	)
	v2:SetVariant(module9.VARIANTS.SPECIAL_BUTTON)
	v2:SetAnchor(module4.CENTER_ALIGNED)
	v3 = module9.Create(
		mMovie,
		"Container.InfoPanel.ViewFavoursButton",
		"/SF/Language/Syndicates/ViewFavors",
		"ShowOfferingsVendor"
	)
	v3:SetVariant(module9.VARIANTS.SPECIAL_BUTTON)
	v3:SetAnchor(module4.CENTER_ALIGNED)
end

local function fn11()
	local module9 = require("EE.Interface.Components.List")
	v4 = module9.CreateList(mMovie, "RankUpCelebration.RewardList.Element1", 3)
	v4.mForcedHorizontalSeparation = 98
	v4.mForcedVerticalSeparation = 0

	function v4.CalculateX(object, p)
		local mIndex = p.mIndex

		if mIndex == nil then
			mIndex = object:GetElementIndexById(p.Id)
		end

		if __wf_atom_7e8ad928(mIndex) then
			return object.mInitialX
		end

		local v16 = -(#object.mElements - 1) * object.mForcedHorizontalSeparation / 2 + (mIndex - 1) * object.mForcedHorizontalSeparation
		return object.mInitialX + v16
	end

	function v4:mElementDrawCallback()
		self.ShowCount = true
		self.AnimateIn = true
		module5.Initialize(mMovie, self.mClipName, self)
	end
end

local function fn12(mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(v15) then
		return nil
	end

	return v15:__wf_atom_232fd31d(mItemType)
end

local function fn13()
	if not __wf_atom_7e8ad928(v) and flag2 then
		v:Execute("Close", "")
		flag3 = true
	end

	flag = false
	flag2 = false
	fn9()
end

function ClaimRewards()
	if flag2 then
		ShowOfferingsVendor()
	else
		fn13()
	end
end

local function fn14(showSyndicate2, p)
	if __wf_atom_7e8ad928(showSyndicate2) then
		return
	end

	flag = true

	if fn7() then
		flag2 = true
	end

	fn9()
	local c_str = showSyndicate2:__wf_atom_818ea3a7():c_str()
	local __wf_atom_c14d1e89 = showSyndicate2:__wf_atom_c14d1e89()
	local rewards = {}

	for _, v16 in pairs(__wf_atom_c14d1e89) do
		if v16.level ~= p then
			continue
		end

		rewards = v16.rewards
		break
	end

	module7.ShowRankUpPopup(getfenv(1), flag2, ClaimRewards, c_str, p, rankUpRaysMaterial, linesMaterial, rankUpSparks)
	v4:RemoveElements(true, true)
	local __wf_atom_c4f6543f = mMovie:__wf_atom_c4f6543f()
	local half__wf_atom_c4f6543f = __wf_atom_c4f6543f / 2
	local v16 = {
		_G.UIMaterial_VerticalVisibilityRange,
		_G.UIMaterial_VerticalVisibilityRangeText,
		_G.UIMaterial_UnfocusedBorder
	}
	module4.ScaleVisRangeMaterials(mMovie, half__wf_atom_c4f6543f, __wf_atom_c4f6543f, false, v16, 0)
	module4.ScaleSlicedMaterials(mMovie, v16)
	local mItemTypes = {}

	for _, reward in ipairs(rewards) do
		local mItemType = reward.mItemType
		table.insert(mItemTypes, mItemType)
		local mItemCount = reward.mItemCount
		local v17 = fn12(mItemType)
		local storeItemInfo = module6.GetStoreItemInfo(mMovie, v17, { ItemInfo = mItemType }, nil, nil, true)
		storeItemInfo.mItem = mItemType
		storeItemInfo.Count = math.min(mItemCount, 999999)
		v4:AddElement(storeItemInfo, true)
	end

	asyncLoader:LoadMultipleResources("ShowRankUp", mItemTypes, function(_)
		v4:Redraw(nil, true, true)
	end)
end

function SetOnRankUp(p)
	v10 = p
end

function OnRankUpResult(p)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if not p then
		return
	end

	fn5(showSyndicate)
	fn14(showSyndicate, v13)
	module4.PlaySound(syndicateRankUpUISound)
end

function TestRankUp() end

function RankUp(p)
	if tonumber(p) ~= 4 or __wf_atom_7e8ad928(showSyndicate) then
		return
	end

	local ternary = module4.Ternary(fn(), v13 + 1, 0)
	gGameData:__wf_atom_1e0d81b6(showSyndicate:__wf_atom_e0f044e1(), ternary, "OnRankUpResult")
	_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
		"2",
		"/SF/Language/Syndicates/RankUpWaitingMessage"
	})

	if v10 ~= nil and not __wf_atom_7e8ad928(_T[v10]) then
		_T[v10](ternary)
	end
end

function AskToRankUp()
	module4.ShowConfirmMessage("/SF/Language/Syndicates/FactionRankUpConfirm", "RankUp")
end

function ChildClosed()
	SetFavorsVisible(true)
	fn6(true)

	if flag3 then
		flag3 = false
		ShowOfferingsVendor()
	else
		SetRankupVisible(v11)
		v12 = false
	end
end

function SetOnClaimOffering(p)
	v9 = p
end

function OnClaimOffering(p)
	fn13()

	if not __wf_atom_7e8ad928(showSyndicate) then
		fn5(showSyndicate)
	end

	if not (__wf_atom_7e8ad928(v9) or __wf_atom_7e8ad928(_T[v9])) then
		_T[v9](p)
	end
end

function SetFavorsVisible(p)
	v6 = p
	v3:SetVisible(v6)
end

function SetRankupVisible(p)
	v2:SetVisible(p)
	mMovie:__wf_atom_2dedec1a("Container.InfoPanel.FactionRank.RankUpFlair", 13, p)
end

function Initialize()
	module2.RegisterHideHud(true)
	module2.DissolveIn(mMovie)
	module2.ShowBackground({ mFade = module4.LEFT_ALIGNED })
	v5 = module8.Create(mMovie)
	v5:Register(mMovie, "RankUpCelebration", { v5.ANCHOR_V_CENTRE, v5.ANCHOR_H_CENTRE })
	v14 = { dissolveMaterial, dissolveMaterialSDF }
	fn9()
	fn10()
	fn11()
	mMovie:__wf_atom_2dedec1a("RankUpCelebration", 13, false)

	if __wf_atom_7e8ad928(_T.ShowSyndicate) then
		showSyndicate = Resource("/SF/Syndicates/ChampionSyndicate")
	else
		showSyndicate = _T.ShowSyndicate
	end

	fn5(showSyndicate)
	onViewportSizeChanged()
end

function Update()
	local v16 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v16)
	asyncLoader:Update()
	total += v16
	local v17 = total * 360 / 25 % 360
	mMovie:__wf_atom_e57658c2("RankUpCelebration.Rank.LeafCircle", 16, v17)
end

function Shutdown()
	module2.RegisterHideHud(false)
	module2.HideBackground()
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v5) then
		v5:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end