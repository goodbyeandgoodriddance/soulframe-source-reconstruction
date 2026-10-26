local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.CardUtilitiesRedux")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.LotusUtilities")
local module6 = require("Lotus.Interface.RewardUtilities")
local module7 = require("Lotus.Interface.StoreItemUtilities")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local flag = true
local v5 = nil
local v6 = {}
local v7 = {}
local v8 = nil
local v9 = false
local storeItem = nil
local v10 = false
local v11 = 0
local v12 = nil
local v13 = nil
local fn
local v14 = nil
local v15 = nil
local v16 = nil

local function fn2(_, _)
	local v17 = {
		rewardVisibleRangeMat,
		rewardRectangleVisibleRangeMat,
		rewardTextVisibleRangeMat,
		rewardFlareVisibleRangeMat
	}

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v18 in pairs(uiMaterial_Mod) do
			table.insert(v17, v18)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v18 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v17, v18)
		end
	end

	for _, v18 in pairs(_G.UIMaterial_CosmeticEnhancersStoreHorizontal) do
		table.insert(v17, v18)
	end

	local v18 = mMovie:__wf_atom_5e6e15c8("Rewards", 0) + 307.5
	local visibilityCenter = module.GetVisibilityCenter(mMovie, v18, true)
	local visibilitySize = module.GetVisibilitySize(mMovie, 615, true)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 5)

	for _, v19 in pairs(v17) do
		v19:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
		v19:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
		v19:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end
end

function onViewportSizeChanged(p, p2)
	fn2(p, p2)
end

local function fn3()
	v6.Background1 = module4.GetColor(2, true)
	v6.Content = module4.GetColor(6, true)
	v6.FloatingContent = module4.GetColor(9, true)
	v6.FloatingContentHighlight = module4.GetColor(10, true)
	v6.BackerHighlight = module4.GetColor(1, true)
end

function GetSelectedCards()
	return nil
end

function GetSelectedElement()
	return nil
end

local function fn4()
	if not __wf_atom_8e4fda44:__wf_atom_6b69b901(backgroundMovie) then
		v14 = __wf_atom_8e4fda44:__wf_atom_5d67a2c5(backgroundMovie)
	end

	mMovie:__wf_atom_e57658c2("SideSelection", 12, 0)
	__wf_atom_ec43d06e(mMovie, "SideSelection", 7, { 12 }, { 100 }, 0.25, 0, function()
		flag = false
	end)
end

local function fn5(list)
	print("DefenseReward::TransitionOut")

	if flag then
		return
	end

	fn(list, true)
	flag = true
	_T.UI_ContinueResponse = v4
	v15:AddTimer(1, function()
		if not __wf_atom_7e8ad928(v14) then
			v14:Execute("TransitionOut", "")
		end
	end)
	__wf_atom_ec43d06e(mMovie, "_root", 7, { 12 }, { 0 }, 0.35, 1, function()
		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle()
		end

		if not __wf_atom_7e8ad928(v3) then
			v3:Close()
		end

		gGameRules:__wf_atom_411c9025(false)

		if v == "Left" then
			local movie = __wf_atom_8e4fda44:FindMovie(endOfMatchMovie)

			if not __wf_atom_7e8ad928(movie) then
				movie:Execute("DisablePause", "")
			end
		end

		mMovie:Close()
	end)
end

function TransitionOut(list)
	if list ~= nil then
		local v17 = StringSplit(".", list)
		list = {}

		for i = 1, #v17, 2 do
			table.insert(list, {
				Id = v17[i],
				Vote = module.Ternary(v17[i + 1] == "1", 1, 2)
			})
		end
	end

	fn5(list)
end

local function fn6()
	local module8 = require("EE.Interface.Components.Grid")
	v5 = module8.CreateGrid(mMovie, "Rewards.Element", nil, 1, 5)
	v5:SetCallbacks(nil, "RewardFocused", "RewardUnfocused")
	v5.ElementWidth = 110
	v5.ElementHeight = 110
	v5.ElementDimBuffer = 15
	v5.Width = 110
	v5.Height = 650
	v5.mEdgeAlphaOffset = 10
	v5.Horizontal = true
	v5.ModScale = 42
	module2.InitializeGridItem(mMovie, v5)
	v5:AttachScrollBar("Rewards.ScrollBar", -11, true)
	v5:EnableSmoothScroll()
	v5.RectangleVisibleRangeMaterial = rewardRectangleVisibleRangeMat
	v5.VisibleRangeMaterial = rewardVisibleRangeMat
	v5.TextVisibleRangeMaterial = rewardTextVisibleRangeMat
	v5.FlareVisibleRangeMaterial = rewardFlareVisibleRangeMat

	function v5.CalculateX(object, p)
		local v17 = object.mInitialX + (object:GetElementRow(p) - 1) * object.mRowSeparation

		if object.mSmoothScroll then
			return v17 - object:GetScroll() % 1 * object.mRowSeparation
		end

		return v17
	end

	function v5.CalculateY(p, _)
		return p.mInitialY
	end

	function v5.mClipCreatedCallback(p, _)
		module2.OnGridItemCreated(mMovie, v5, p .. ".Item")
	end

	function v5:mOnFocusedCallback()
		if self.mClipName == nil then
			return
		end

		local isSelected

		if v5.mSelectedElement == nil then
			isSelected = false
		else
			isSelected = self.Id == v5.mSelectedElement.Id
		end

		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		self.mBaseClipName = mClipName
		module2.OnGridItemFocusChanged(mMovie, v5, self, {
			ZoomYShift = -100,
			IsSelected = isSelected,
			IsFocused = true,
			ShowInfoPopup = true
		})
		self.mClipName = mClipName
	end

	function v5:mOnUnfocusedCallback()
		if self.mClipName == nil then
			return
		end

		local isSelected

		if v5.mSelectedElement == nil then
			isSelected = false
		else
			isSelected = self.Id == v5.mSelectedElement.Id
		end

		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		module2.OnGridItemFocusChanged(mMovie, v5, self, {
			IsSelected = isSelected,
			IsFocused = false,
			ShowInfoPopup = true
		})
		self.mClipName = mClipName
	end

	function v5:mElementDrawCallback()
		if self.mClipName == nil then
			return
		end

		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(v6.Background1)
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(v6.BackerHighlight)
		mMovie:OverrideMaterial(self.mClipName .. ".Check.Bg", rewardRectangleVisibleRangeMat)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Check.Bg",
			"RectEdgeColor",
			convertColorNumberToProceduralRGB2.r,
			convertColorNumberToProceduralRGB2.g,
			convertColorNumberToProceduralRGB2.b,
			0.5
		)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Check.Bg",
			"RectInnerColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.5
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Check.Checkmark", 11, v6.BackerHighlight)
		mMovie:__wf_atom_7f57ab2f(
			self.mClipName,
			"Check.Checkmark",
			13,
			not (self.Filler or self.Afk or self.GreedNextReward)
		)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "NextReward", 13, self.Filler == true)
		local wave = self.Wave
		local v17 = "/Lotus/Language/Game/Wave"

		if gGameRules:__wf_atom_72fc675e().missionType == 13 or gGameRules:__wf_atom_e22d6f15() == 21 or v9 then
			v17 = "/Lotus/Language/Game/Round"
		else
			wave *= 5
		end

		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v17, false)
		mMovie:__wf_atom_48bd5a59(self.mClipName, "NextReward.Text1", 36, TitleCase(__wf_atom_8e9ac384))
		mMovie:__wf_atom_48bd5a59(self.mClipName, "NextReward.Wave", 36, module.FormatNumber(wave))
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SingleReward", false)
		mMovie:__wf_atom_7d7314f1(self.mClipName .. ".NextReward.Text2.text", TitleCase(__wf_atom_8e9ac384_2))
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Text1", 44, v6.FloatingContent)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Wave", 44, v6.FloatingContent)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Text2", 44, v6.FloatingContent)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Text1", 12, 75)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Wave", 12, 50)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "NextReward.Text2", 12, 75)

		for _, v18 in pairs({ "NextReward.Text1", "NextReward.Wave", "NextReward.Text2" }) do
			mMovie:OverrideMaterial(self.mClipName .. "." .. v18, rewardTextVisibleRangeMat)
		end

		mMovie:OverrideMaterial(self.mClipName .. ".Check.Checkmark", rewardVisibleRangeMat)
		local mClipName = self.mClipName
		self.mClipName = mClipName .. ".Item"
		mMovie:__wf_atom_e57658c2(self.mClipName, 100, self.Id)
		mMovie:SetCallbacks(self.mClipName, v5.mRollOverElementCallback, v5.mRollOutElementCallback, nil, nil)
		module2.DrawGridItem(mMovie, v5, self, {
			IgnoreCount = self.Filler,
			Locked = self.Afk,
			LockedMsg = "/Lotus/Language/Menu/NotEligibleForReward"
		})
		self.mClipName = mClipName
	end
end

local function fn7()
	local wave = 0

	for i = 1, #v8 do
		local storeItem2 = v8[i].storeItem
		local v17 = { Name = "" }

		if __wf_atom_7e8ad928(storeItem2) then
			v17.Afk = true
		else
			v17 = module7.GetStoreItemInfo(mMovie, storeItem2, {
				GameData = gGameData,
				AppendInfo = { Count = v8[i].itemCount }
			})
			v17.UpgradeFingerprint = ""
			v17.QuantityMultiplier = v8[i].itemCount
		end

		if gGameRules:__wf_atom_72fc675e().missionType == 13 or gGameRules:__wf_atom_72fc675e().missionType == 21 then
			v17.Wave = i
		else
			v17.Wave = v8[i].wave
		end

		v5:AddElement(v17, true)
		wave = v17.Wave
	end

	if v9 then
		local storeItemInfo = module7.GetStoreItemInfo(mMovie, storeItem, {
			GameData = gGameData,
			AppendInfo = { Count = 1 }
		})
		storeItemInfo.GreedNextReward = true
		storeItemInfo.Wave = 1
		storeItemInfo.UpgradeFingerprint = ""
		v5:AddElement(storeItemInfo, true)
	else
		for i = 1, math.max(v5.mRows - v5:GetHowManyElements(), 1) do
			v5:AddElement({
				Wave = wave + i,
				Filler = true
			}, true)
		end
	end

	v5:SetScroll(v5:GetHowManyElements(), true)
	v5:Redraw()
end

local function fn8(p)
	if v == p then
		return
	end

	if v ~= nil then
		__wf_atom_86cbd68d(mMovie, "SideSelection." .. v .. "Image.gotoAndPlay", "TransOut")
		mMovie:OverrideMaterial("SideSelection." .. v .. "Image.Bg", nil)
	end

	__wf_atom_86cbd68d(mMovie, "SideSelection." .. p .. "Image.gotoAndPlay", "TransIn")
	mMovie:OverrideMaterial("SideSelection." .. p .. "Image.Bg", bgRightMaterial)
	v = p
	local ternary = module.Ternary(v == "Left", false, true)

	if ternary ~= v4 then
		v4 = ternary

		if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_dd9a0bb8) then
			gGameRules:__wf_atom_dfbbcc12(v4)
		end

		module.PlaySound(_G.UISound_ButtonSelect)
	end

	if v == "Left" then
		module.PlaySound(rewardLeaveSound)
	else
		module.PlaySound(rewardStaySound)
	end
end

local function fn9(p, p2, p3)
	if p2 and not p3 then
		module.PlaySound(_G.UISound_Focus)
	end

	local ternary = module.Ternary(p3 == true, 0, 0.2)
	local v17 = p == "Right" and { "Excalibur", "Vauban", "Trinity", "Bg" }
		or { "Bluesky", "Liset", "Grasshopper", "Gyroscope", "Bg" }
	local v18 = (p2 or v == p) and 0 or module.Ternary(p == "Right", -55, -70)

	for _, v19 in ipairs(v17) do
		__wf_atom_ec43d06e(mMovie, "SideSelection." .. p .. "Image." .. v19, 2, { 70 }, { v18 }, ternary)
	end

	__wf_atom_ec43d06e(
		mMovie,
		"SideSelection.Frame.CurvedArrow" .. p,
		2,
		{ 12 },
		{ module.Ternary(p2, 100, 35) },
		ternary
	)
	local ternary2 = module.Ternary(not p2, v6.FloatingContent, v6.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("SideSelection.Title" .. p, 44, ternary2)
end

local function fn10()
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.CenterDividerLeft", 11, v6.FloatingContent)
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.CenterDividerRight", 11, v6.FloatingContent)
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.TitleDecoLeft", 11, v6.FloatingContent)
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.TitleDecoRight", 11, v6.FloatingContent)
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.TitleDecoLeft", 12, 55)
	mMovie:__wf_atom_e57658c2("SideSelection.Frame.TitleDecoRight", 12, 55)

	for _, v17 in ipairs({
		"CurvedArrowLeft",
		"CurvedArrowRight",
		"CrossSectionTopRight",
		"CrossSectionBottomRight",
		"CrossSectionBottomLeft",
		"CrossSectionTopLeft"
	}) do
		mMovie:__wf_atom_4c1c1986("SideSelection.Frame", v17, 11, v6.FloatingContent)
		mMovie:__wf_atom_4c1c1986("SideSelection.Frame", v17, 12, 35)
	end

	local ternary = module.Ternary(v9, "/Lotus/Language/Menu/ArenaEnduranceEnd", "/Lotus/Language/Menu/End")
	local ternary2 = module.Ternary(v9, "/Lotus/Language/Menu/ArenaEnduranceContinue", "/Lotus/Language/Menu/Continue")
	mMovie:__wf_atom_7d7314f1("SideSelection.TitleLeft.text", ternary)
	mMovie:__wf_atom_7d7314f1("SideSelection.TitleRight.text", ternary2)
	mMovie:SetCallbacks("SideSelection.LeftButton", "LeftButtonRollover", "LeftButtonRollout", "LeftButtonRelease", nil)
	mMovie:SetCallbacks(
		"SideSelection.RightButton",
		"RightButtonRollover",
		"RightButtonRollout",
		"RightButtonRelease",
		nil
	)
	fn9("Left", false, true)
	fn9("Right", false, true)
end

local function fn11()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Player1", 1)
	local v17 = mMovie:__wf_atom_5e6e15c8("Player4", 1) - __wf_atom_5e6e15c8
	v12 = __wf_atom_5e6e15c8 + v17 * 0.5
	v13 = v17 * 0.25
	local color = module4.GetColor(9, false)
	local color2 = module4.GetColor(2, false)

	for i = 1, 4 do
		local v18 = "Player" .. i
		mMovie:__wf_atom_933bbce0(v18 .. ".Icon", defaultProfileTexture, playerAvatarMaterial)
		mMovie:__wf_atom_e57658c2(v18, 1, v12)
		mMovie:__wf_atom_4c1c1986(v18, "IconBg", 100, i)
		mMovie:SetCallbacks(v18 .. ".IconBg", "HostFocused", "HostUnfocused", nil, nil)
		mMovie:__wf_atom_4c1c1986(v18, "IconBg", 11, v6.FloatingContent)
		mMovie:__wf_atom_4c1c1986(v18, "HostIcon", 11, v6.FloatingContent)

		for _, v19 in ipairs({ "Left", "Right" }) do
			local v20 = v18 .. ".NameContainer" .. v19
			mMovie:__wf_atom_e57658c2(v20, 0, module.Ternary(v19 == "Left", 220, -220))
			mMovie:__wf_atom_4c1c1986(v20, "Label", 44, v6.Content)
			mMovie:__wf_atom_48bd5a59(v20, "Label", 46, "center")
			mMovie:__wf_atom_4c1c1986(v20, "RightArrow.Arrow", 11, v6.FloatingContent)
			mMovie:__wf_atom_4c1c1986(v20, "RightArrow.ArrowBg", 11, v6.Background1)
			mMovie:__wf_atom_4c1c1986(v20, "LeftArrow.Arrow", 11, v6.FloatingContent)
			mMovie:__wf_atom_4c1c1986(v20, "LeftArrow.ArrowBg", 11, v6.Background1)
			mMovie:OverrideMaterial(v20 .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_1ca72041(
				v20 .. ".Bg",
				"RectEdgeColor",
				color.red / 255,
				color.green / 255,
				color.blue / 255,
				0.7
			)
			mMovie:__wf_atom_1ca72041(
				v20 .. ".Bg",
				"RectInnerColor",
				color2.red / 255,
				color2.green / 255,
				color2.blue / 255,
				0.9
			)
		end
	end
end

function Initialize()
	local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

	if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
		print("ScopeDebug: Hide from DefenseReward")
		__wf_atom_b56d2aa8:Execute("HideReticle", "")
	end

	local movie = __wf_atom_8e4fda44:FindMovie(_G.UIMovie_DetailedPurchaseDialog)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("TransitionOut", "")
	end

	local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

	while __wf_atom_7e8ad928(__wf_atom_e23b2855) do
		__wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()
		Sleep(1)
	end

	local module8 = require("Lotus.Interface.Libs.TimerMgr")
	v15 = module8.CreateTimerMgr()

	if _T.EnableUIInput ~= nil and not _T.UIInputEnabled then
		v10 = true
		_T.EnableUIInput(true)
	end

	module5.RegisterHideHud(true)
	v9 = gGameRules:IsA(__wf_atom_8fc2e025) and gGameRules:__wf_atom_c31e256f() == 1
	v3 = mMovie:PushChildMovie(countdownMovie)
	v3:Execute("SetPosition", "800,200")
	v3:Execute("SetScale", "130,130")
	fn3()
	fn11()
	fn6()
	fn10()
	gGameRules:__wf_atom_411c9025(true)

	if gGameRules:IsA(__wf_atom_dd9a0bb8) then
		gGameRules:OnTieredRewardRoundOver(-1)
	end

	if v9 then
		local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(Symbol("WagerWins"), 1)
		storeItem = gGameRules:__wf_atom_72fc675e().missionRewardExtra.randomizedItems:GetTieredItem(
			__wf_atom_421b01aa(__wf_atom_e23b2855[1]:__wf_atom_a4299765().mGreedWager, 0, 2),
			0
		):GetStoreItem()
		v8 = {}

		for i = 1, __wf_atom_d163c8e5 do
			table.insert(v8, { storeItem = storeItem, levelOverride = 0, itemCount = 1, wave = i })
		end
	else
		v8 = module6.GenerateDefenseRewards()
	end

	fn7()
	module.PlaySound(rewardOpenSound)
	fn4()

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		if __wf_atom_7e8ad928(v14) then
			_T.SetSquadOverlayTitle(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Objectives/VoidFissureTitle", false),
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/BattleOrExtractTitle", false)
			)
		else
			_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/BattleOrExtractTitle", false))
		end
	end

	fn2(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function Shutdown()
	if not __wf_atom_7e8ad928(gGameRules) then
		local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

		if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
			print("ScopeDebug: Show from DefenseReward")
			__wf_atom_b56d2aa8:Execute("ShowReticle", "")
		end
	end

	if _T.DisableUIInput ~= nil and v10 then
		_T.DisableUIInput()
	end

	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.UI_ContinueResponse = v4
	module5.RegisterHideHud(false)

	if v4 ~= false and not __wf_atom_7e8ad928(gGameRules) then
		print("DefenseReward: user elected to continue")
		local v17 = gGameRules:__wf_atom_a56b661d() + 1
		print("DefenseReward: cumulative rewards " .. tostring(v17))
		gGameRules:__wf_atom_44530e48(v17)
	end
end

local function fn12(p)
	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for i = 1, #__wf_atom_bb46d8b6 do
		if __wf_atom_bb46d8b6[i].name == p then
			return (cjson.decode(__wf_atom_bb46d8b6[i].loadout))
		end
	end

	return nil
end

local function fn13(p, __wf_atom_6be84646)
	local iconTexture = nil
	local v17 = fn12(__wf_atom_6be84646)

	if v17 ~= nil then
		local profileImage = v17.ProfileImage

		if not __wf_atom_7e8ad928(profileImage) and profileImage ~= "" then
			local v18 = Resource(profileImage)

			if not __wf_atom_7e8ad928(v18) then
				iconTexture = v18:GetIconTexture()
			end
		end
	end

	if __wf_atom_7e8ad928(iconTexture) then
		iconTexture = defaultProfileTexture
	end

	mMovie:__wf_atom_c90af43a(p, iconTexture)
end

fn = function(list, p)
	local v17 = 200

	local function fn14(i, vote)
		local v18 = "Player" .. i
		local voteYesFx2 = nil

		if vote == 1 then
			voteYesFx2 = voteYesFx
		elseif vote == 2 then
			voteYesFx2 = voteNoFx
		end

		if v7[i] ~= vote then
			v7[i] = vote
			module.CreateParticles(mMovie, v18, voteYesFx2, 0, 10)
			__wf_atom_ec43d06e(
				mMovie,
				v18 .. ".NameContainerLeft",
				2,
				{ 0 },
				{ module.Ternary(vote == 2, -20, v17 + 20) },
				0.2
			)
			__wf_atom_ec43d06e(
				mMovie,
				v18 .. ".NameContainerRight",
				2,
				{ 0 },
				{ module.Ternary(vote == 1, 20, -v17 - 20) },
				0.2
			)
		end
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, 4 do
		local v18 = "Player" .. i

		if i <= #__wf_atom_3c8e1a7a then
			mMovie:__wf_atom_2dedec1a(v18, 13, true)
			local v19 = __wf_atom_3c8e1a7a[i]
			local __wf_atom_6be84646 = v19:__wf_atom_6be84646()
			local v20 = v19:__wf_atom_3c213d6b() and not v19:__wf_atom_7553fb91()

			if v20 then
				v16 = i
			end

			mMovie:__wf_atom_7f57ab2f(v18, "HostIcon", 13, v20)
			mMovie:__wf_atom_50d60589(v18 .. ".NameContainerLeft.Label", 36, __wf_atom_6be84646)
			mMovie:__wf_atom_50d60589(v18 .. ".NameContainerRight.Label", 36, __wf_atom_6be84646)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v18 .. ".NameContainerLeft.Label", 40)

			if __wf_atom_5e6e15c8 ~= nil then
				local v21 = __wf_atom_5e6e15c8 + 30
				v17 = math.max(v17, v21)
			end

			if p then
				fn13(v18 .. ".Icon", __wf_atom_6be84646)
			end

			local vote = __wf_atom_3c8e1a7a[i]:__wf_atom_5ae4fcae()

			if list ~= nil then
				for j = 1, #list do
					if tonumber(list[j].Id) ~= __wf_atom_3c8e1a7a[i]:__wf_atom_ef151cfd() then
						continue
					end

					vote = list[j].Vote
					break
				end
			end

			fn14(i, vote)
		else
			mMovie:__wf_atom_2dedec1a(v18, 13, false)
		end
	end

	for i = 1, #__wf_atom_3c8e1a7a do
		local v18 = "Player" .. i
		mMovie:__wf_atom_4c1c1986(v18, "NameContainerLeft.Bg", 14, v17)
		mMovie:__wf_atom_4c1c1986(v18, "NameContainerLeft.LeftArrow", 0, -v17)
		mMovie:__wf_atom_4c1c1986(v18, "NameContainerRight.Bg", 14, v17)
		mMovie:__wf_atom_4c1c1986(v18, "NameContainerRight.RightArrow", 0, v17)
	end
end

function Update()
	local v17 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v17)

	if not __wf_atom_7e8ad928(v15) then
		v15:Update(v17)
	end

	v5:RunForAllVisibleElements(function(state)
		if state.IsMod then
			local mClipName = state.mClipName
			state.mClipName ..= ".Mod"
			module3.Update(state, __wf_atom_084b3e93())
			state.mClipName = mClipName
		end
	end)

	if flag then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v18

	if v11 == #__wf_atom_3c8e1a7a then
		v18 = false
	else
		v18 = true
		v11 = #__wf_atom_3c8e1a7a
		local v19 = (v11 - 1) * v13
		local v20 = v12 - v19 * 0.5

		for i = 1, v11 do
			__wf_atom_ec43d06e(mMovie, "Player" .. i, 2, { 1 }, { v20 + (i - 1) * v13 }, 0.2)
		end
	end

	fn(nil, v18)
end

function SetCountdownText(p)
	local v17 = tonumber(p)

	if v17 == 0 and v == nil then
		fn8("Right")
	end

	if v17 ~= nil and v2 ~= v17 then
		if not __wf_atom_7e8ad928(v3) then
			v3:Execute("SetCountdown", v17)

			if v2 == nil then
				v3:Execute("EnableAutoCountdown", "false")
			end
		end

		v2 = v17
	end
end

function HostFocused(p)
	if v16 == p then
		_T.gToolTip = Localize("/Lotus/Language/Menu/Host", {})
	end
end

function HostUnfocused(_)
	_T.gToolTip = nil
end

function LeftButtonRollover()
	if not flag then
		fn9("Left", true)
	end
end

function LeftButtonRollout()
	fn9("Left", false)
end

function LeftButtonRelease()
	if not flag then
		fn8("Left")
	end
end

function RightButtonRollover()
	if not flag then
		fn9("Right", true)
	end
end

function RightButtonRollout()
	fn9("Right", false)
end

function RightButtonRelease()
	if not flag then
		fn8("Right")
	end
end

function onKeyUp_MENU_GENERIC1()
	if not flag then
		fn8("Left")
	end
end

function onKeyUp_MENU_GENERIC2()
	if not flag then
		fn8("Right")
	end
end

function onKeyUp_MENU_SELECT()
	return true
end

function onKeyUp_MENU_CANCEL()
	return true
end

function RewardFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:FocusElementById((tonumber(p)))
	end
end

function RewardUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElementById((tonumber(p)))
	end
end

function IsmInputBlocked()
	return flag
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not flag and v5 ~= nil and v5.mScrollBar ~= nil then
		v5.mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function SupportsThemes()
	return true
end