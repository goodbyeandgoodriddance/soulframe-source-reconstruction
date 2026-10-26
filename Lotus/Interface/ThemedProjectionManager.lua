local currencyBar_ExtraCurrency = Resource("/Lotus/Types/Items/MiscItems/VoidTearDrop")
local v = Resource("/Lotus/Types/Game/Projections/T5VoidProjectionImmortal")
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CodexUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.StoreItemUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("EE.Interface.AnchorMgr")
local module8 = require("Lotus.Interface.Components.ThemedButton")
local v2 = Resource("/Lotus/Types/Game/Store/RelicStoreManifest")
local v3 = WeakResource("/Lotus/Types/Lore/PrimaryCodexManifest")
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local flag = true
local v12 = nil
local v13 = {}
local quality = 0
local quality2 = 0
local v14 = 0
local v15 = nil
local v16 = {}
local v17 = nil
local uiInputEnabled = false
local v18 = false
local v19 = ""
local v20 = {}
local v21 = true
local v22 = nil
local v23 = nil
local v24 = {}
local v25 = {}
local v26 = false
local count = 0
local count2 = 0
local count3 = 0
local v27 = nil
local v28 = nil
local v29 = false
local v30 = false
local v31 = false
local flag2 = false
local v32 = false
local v34 = false
local v35 = 0
local v36 = 0
local v37 = nil
local flag3 = false
local v38 = nil
local v39 = false
local v40 = nil
local v41 = {}
local v42 = {}
local v43 = { x = 0, y = 0 }
local v44 = nil
local v45 = {}
local v46 = false
local flag4 = false
local v47 = 2
local v48 = { "/Lotus/Language/Labels/COMMON", "/Lotus/Language/Labels/UNCOMMON", "/Lotus/Language/Labels/RARE" }
local v49 = {
	MaxMovement = 2,
	TransitionTime = 2,
	LastX = -275,
	LastY = -15,
	TargetX = -275,
	TargetY = -15,
	Timer = 0
}
local v50 = {
	"/Lotus/Language/Menu/VoidProjectionQuality_Bronze",
	"/Lotus/Language/Menu/VoidProjectionQuality_Silver",
	"/Lotus/Language/Menu/VoidProjectionQuality_Gold",
	"/Lotus/Language/Menu/VoidProjectionQuality_Platinum"
}
local v51 = { 25, 25, 50 }
local v52 = { ALL = 0 }
local v53 = {
	{ 19, -82.5 },
	{ 39, -27 },
	{ 46, 43 }
}
local v54 = {
	{ 9, -82.5 },
	{ 25, -17 },
	{ 30, 110 }
}

local function fn(value, value2, value3, p)
	mMovie:__wf_atom_e57658c2("Upgradeer.RarityBars", 0, mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Grid", 0))
	local v55 = {
		{
			Left = "Upgrader.Main.Grid.Item",
			Right = "Upgrader.Main.Grid.Item3",
			Percent = value or 0
		},
		{
			Left = "Upgrader.Main.Grid.Item4",
			Right = "Upgrader.Main.Grid.Item5",
			Percent = value2 or 0
		},
		{
			Left = "Upgrader.Main.Grid.Item6",
			Right = "Upgrader.Main.Grid.Item6",
			Percent = value3 or 0
		}
	}
	local v56 = p and 0 or 0.2

	for i = 1, #v55 do
		local v57 = v55[i]
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v57.Left, 0)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v57.Left, 1)
		local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v57.Right, 0)

		if not (__wf_atom_5e6e15c8 ~= nil and __wf_atom_5e6e15c8_3 ~= nil) then
			continue
		end

		local v58 = __wf_atom_5e6e15c8 - v7.ElementWidth / 2
		local v59 = __wf_atom_5e6e15c8_2 + v7.ElementHeight / 2 + 10
		local v60 = __wf_atom_5e6e15c8_3 + v7.ElementWidth / 2 - v58
		module6.DrawRarityBar(
			mMovie,
			"Upgrader.Main.RarityBars.RarityBar" .. i,
			{ [i] = v57.Percent },
			v60,
			barMaterial,
			v56,
			0,
			v58,
			v59
		)
	end
end

local function fn2(p, p2)
	local v55 = 0.4 * (3 - p) / 3 + 0.6
	local v56 = 0.6 * p / 3 + 0.4
	local v57 = 0.49999999999999994 * p / 3 + 0.2
	fn(v55, v56, v57, p2)
	return { v55 * 3, v56 * 2, v57 }
end

local function fn3(p, p2, value)
	if not __wf_atom_7e8ad928(v17) then
		v17:Update(p, p2)
	end

	if __wf_atom_7e8ad928(v5) then
		return
	end

	module3.AdjustBluerSize(mMovie, "Bluer")
	local screenDimensions, _ = module.GetScreenDimensions(mMovie)
	local v55 = (screenDimensions - 1440) / 2
	mMovie:__wf_atom_e57658c2("CategoriesBg.LeftStub", 14, v55)
	mMovie:__wf_atom_e57658c2("CategoriesBg.RightStub", 14, v55)
	local v56 = { visibleRangeMat, rectangleVisibleRangeMat, textVisibleRangeMat }
	local v57 = value or 0

	for _, v58 in pairs(_G.UIMaterial_CosmeticEnhancersStore) do
		table.insert(v56, v58)
	end

	local v58 = mMovie:__wf_atom_5e6e15c8("GridBounds", 0) - mMovie:__wf_atom_5e6e15c8("InventorySelector", 0)
	local v59 = mMovie:__wf_atom_5e6e15c8("GridBounds", 1) - mMovie:__wf_atom_5e6e15c8("InventorySelector", 1)

	if v30 or _T.TestProjectionSquad then
		v58 -= 212
		mMovie:__wf_atom_e57658c2("Upgrader.Blurer", 14, 750)
		mMovie:__wf_atom_e57658c2("Upgrader.Main", 0, -234)
		mMovie:__wf_atom_e57658c2("Upgrader.Anim", 0, -234)
	else
		mMovie:__wf_atom_e57658c2("Upgrader.Blurer", 14, 550)
		mMovie:__wf_atom_e57658c2("Upgrader.Main", 0, 0)
		mMovie:__wf_atom_e57658c2("Upgrader.Anim", 0, 0)
	end

	module6.ResizeGrid(v5, v58, v59, mMovie, "InventorySelector")
	module6.ResizeGrid(v7, 440, 315, mMovie)
	fn2(quality2)
	v5.mScrollBar:SetHeight(v59 + 2)
	v10:SetPosition(nil, v59 - 176)
	v9:SetPosition(nil, v59 - 58)
	v8:SetPosition(nil, v59 - 58)
	local v60 = v59 - 84

	if flag2 and v10.mIsVisible then
		v60 -= 130
	else
		mMovie:__wf_atom_e57658c2("Upgrader.Main.RankList", 12, 0)
		mMovie:__wf_atom_e57658c2("Upgrader.Main.UpgradeBtn", 12, 0)
	end

	__wf_atom_ec43d06e(mMovie, "Upgrader.Main.Backer", 2, { 15 }, { v60 }, v57)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Main.RankList", 1, { 12 }, { 100 }, v57)

	if not (flag2 and v10.mIsVisible) then
		__wf_atom_ec43d06e(mMovie, "Upgrader.Main.UpgradeBtn", 1, { 12 }, { v9.mInactiveAlpha }, v57)
	end

	mMovie:__wf_atom_e57658c2("Upgrader.Blurer", 15, v59)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.RankList", 1, 492)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.VoidTrace", 1, v59 - 90)
	mMovie:__wf_atom_e57658c2("InventorySelector.Stats", 0, v58 - 76)
	mMovie:__wf_atom_e57658c2("InventorySelector.GridBounds", 14, v58)
	mMovie:__wf_atom_e57658c2("InventorySelector.GridBounds", 15, v59)
	mMovie:__wf_atom_2dedec1a("InventorySelector.GridBounds", 13, false)
	local v61 = mMovie:__wf_atom_5e6e15c8("InventorySelector.Grid", 3) + v59 / 2
	local visibilityCenter = module.GetVisibilityCenter(mMovie, v61)
	local visibilitySize = module.GetVisibilitySize(mMovie, v59)
	local visibilityFadeSize = module.GetVisibilityFadeSize(mMovie, 5)

	for _, v62 in pairs(v56) do
		if __wf_atom_7e8ad928(v62) then
			continue
		end

		v62:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
		v62:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
		v62:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
	end
end

function onViewportSizeChanged(p, p2)
	fn3(p, p2)
end

local function fn4()
	if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(backgroundMovie))) then
		__wf_atom_8e4fda44:__wf_atom_5d67a2c5(backgroundMovie)
	end
end

function IsInputBlocked()
	return flag
end

local function fn5()
	local color = module5.GetColor(6, true)
	local color2 = module5.GetColor(9, true)
	local color3 = module5.GetColor(10, true)
	local color4 = module5.GetColor(2, true)
	local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(color2)
	local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(color3)
	local convertColorNumberToProceduralRGB3 = module.ConvertColorNumberToProceduralRGB(color4)
	local convertColorNumberToHex = module.ConvertColorNumberToHex(color2)
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(color3)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.Hint", 11, color2)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.HintIcon", 11, color)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.VoidTrace", 11, color2)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.Loom", 11, color2)
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic.Loom", 11, color2)
	mMovie:__wf_atom_e57658c2("Upgrader.SquadList.Title", 11, color2)
	mMovie:__wf_atom_e57658c2("Upgrader.SquadList.Timer", 11, color2)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<MASTERED>", true)
	local v55 = count2

	if count > 0 and count2 == count then
		v55 = __wf_atom_8e9ac384 .. v55
	end

	local count4 = "<font color=\"" .. convertColorNumberToHex2 .. "\">" .. v55 .. "/" .. count .. "</font>"
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CollectedCount", true, {
		COUNT = count4
	})
	local v57 = count3

	if count > 0 and count3 == count then
		v57 = __wf_atom_8e9ac384 .. v57
	end

	local count5 = "<font color=\"" .. convertColorNumberToHex2 .. "\">" .. v57 .. "/" .. count .. "</font>"
	local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/RelicRefined", true, {
		COUNT = count5
	})
	mMovie:__wf_atom_50d60589(
		"InventorySelector.Stats",
		36,
		"<p><font color=\"" .. convertColorNumberToHex .. "\">" .. __wf_atom_8e9ac384_2 .. "    " .. __wf_atom_8e9ac384_3 .. "</font></p>"
	)
	mMovie:__wf_atom_50d60589(
		"Upgrader.Main.Title",
		36,
		"<p><font color=\"" .. convertColorNumberToHex .. "\">" .. v19 .. "</font></p>"
	)

	for i = 1, #v13 do
		local v59 = "Upgrader.Main.RankList.Rank" .. i
		local v60

		if quality >= 0 then
			v60 = i <= quality2 + 1
		else
			v60 = false
		end

		local v61 = "<p><font color=\"" .. convertColorNumberToHex2 .. "\"><b>" .. v13[i][1] .. "</b></font><font color=\"" .. convertColorNumberToHex .. "\" letterSpacing=\"0.2\">" .. v13[i][2] .. "</font></p>"
		mMovie:__wf_atom_48bd5a59(v59, "Desc", 36, v61)
		mMovie:__wf_atom_4c1c1986(v59, "Check", 11, color3)
		mMovie:__wf_atom_4c1c1986(v59, "Glow", 11, color3)
		mMovie:__wf_atom_4c1c1986(v59, "Arrow", 11, color3)
		mMovie:__wf_atom_7f57ab2f(v59, "Arrow", 13, quality2 + 1 == i)
		local v62 = (i <= quality + 1 or not v60) and convertColorNumberToProceduralRGB
			or convertColorNumberToProceduralRGB2
		mMovie:__wf_atom_1ca72041(v59 .. ".IconBacker", "RectEdgeColor", v62.r, v62.g, v62.b, 1)
		mMovie:__wf_atom_1ca72041(
			v59 .. ".IconBacker",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			1
		)
		mMovie:__wf_atom_1ca72041(v59 .. ".Backer", "RectEdgeColor", v62.r, v62.g, v62.b, 0.5)
		mMovie:__wf_atom_1ca72041(
			v59 .. ".Backer",
			"RectInnerColor",
			convertColorNumberToProceduralRGB3.r,
			convertColorNumberToProceduralRGB3.g,
			convertColorNumberToProceduralRGB3.b,
			0
		)
		mMovie:__wf_atom_1ca72041(v59 .. ".Gradient", "RectEdgeColor", v62.r, v62.g, v62.b, 0.25)
		mMovie:__wf_atom_1ca72041(v59 .. ".Gradient", "RectInnerColor", v62.r, v62.g, v62.b, 0.25)
	end

	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.IconBacker",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.IconBacker",
		"RectInnerColor",
		convertColorNumberToProceduralRGB3.r,
		convertColorNumberToProceduralRGB3.g,
		convertColorNumberToProceduralRGB3.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.Backer",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.5
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.Backer",
		"RectInnerColor",
		convertColorNumberToProceduralRGB3.r,
		convertColorNumberToProceduralRGB3.g,
		convertColorNumberToProceduralRGB3.b,
		0
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.Gradient",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.25
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Anim.CopiedRank.Gradient",
		"RectInnerColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.25
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Main.Backer",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.25
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Main.Backer",
		"RectInnerColor",
		convertColorNumberToProceduralRGB3.r,
		convertColorNumberToProceduralRGB3.g,
		convertColorNumberToProceduralRGB3.b,
		0.25
	)
	local v59 = 0
	local v60 = 2
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Left.SingleLoom01", "RippleCenter", v59, v60, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Left.SingleLoom02", "RippleCenter", v59, v60, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Left.SingleLoom03", "RippleCenter", v59, v60, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Left.SingleLoom04", "RippleCenter", v59, v60, 0, 0)
	local v61 = 2
	local v62 = 0
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Right.SingleLoom01", "RippleCenter", v61, v62, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Right.SingleLoom02", "RippleCenter", v61, v62, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Right.SingleLoom03", "RippleCenter", v61, v62, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Main.Loom.Right.SingleLoom04", "RippleCenter", v61, v62, 0, 0)
	local v63 = 2
	local v64 = 2
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain01", "RippleCenter", v63, v64, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain02", "RippleCenter", v63, v64, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain03", "RippleCenter", v63, v64, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain04", "RippleCenter", v63, v64, 0, 0)
	local v65 = 2
	local v66 = -2
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain05", "RippleCenter", v65, v66, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain06", "RippleCenter", v65, v66, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain07", "RippleCenter", v65, v66, 0, 0)
	mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Loom.StraightLoomMain08", "RippleCenter", v65, v66, 0, 0)
end

local function fn6()
	v16 = {}
	table.insert(v16, {
		Label = mMovie:__wf_atom_8e9ac384("<WARNING>", true),
		Tips = module6.GetTips(mMovie, "/Lotus/Language/WarframeHints/Relics_"),
		Padding = -10
	})
	local v55 = flag2 and not v8.mIsVisible

	if v55 then
		table.insert(v16, {
			Label = "/Lotus/Language/Menu/ItemSelection_Cancel",
			CallBack = function()
				mMovie:Execute("GoBack", "")
			end,
			CallOut = "MENU_CANCEL"
		})
	end

	if not (v30 or v55 and Engine.IsPlayingWithController()) then
		table.insert(v16, {
			Label = "/Lotus/Language/Menu/Exit",
			CallBack = function()
				mMovie:Execute("Close", "")
			end,
			CallOut = "MENU_CANCEL"
		})
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v16, getfenv(1))
	end
end

local function fn7()
	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	_T.ProjectionMoviePickerOpen = false

	if not v30 then
		if flag2 then
			if not v29 then
				_T.MadeProjectionChoice = true
				gMatchingService:__wf_atom_27e16961()
			end

			if not __wf_atom_7e8ad928(_T.AcceptInvitePanel) then
				_T.AcceptInvitePanel:SetVisible(true)
				_T.AcceptInvitePanel:__wf_atom_b4ffb30f(true)
			end
		end

		local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

		if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
			__wf_atom_2ad5cd23:Execute(v28, module.Ternary(v29, "", "true"))
		end

		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle()
		end

		module.PlaySound(_G.UISound_WindowClose)
	end

	if __wf_atom_7e8ad928(v4) then
		mMovie:Close()
		return
	end

	v4:FirePort("Close")
	v4 = nil
end

local function fn8(p)
	if v30 then
		return
	end

	if flag2 then
		v29 = true
	end

	if p or mMovie == __wf_atom_8e4fda44:__wf_atom_1dca1cfb() then
		fn7()
	else
		v46 = true
	end
end

function Close(p)
	fn8(p == "true")
end

local function fn9()
	if not flag2 or v8.mIsVisible then
		fn8()
		return
	end

	v10:SetVisible(true)
	v9:SetVisible(false)
	v8:SetVisible(true)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.RankList", 13, false)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.VoidTrace", 13, false)
	fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), 0.2)
	fn6()
end

function GoBack()
	fn9()
end

function SetTrigger(p)
	v4 = p
	return true
end

local function fn10(p, equippedProjection)
	if
		not __wf_atom_7e8ad928(gRegion)
		and not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7())
		and gRegion:__wf_atom_eab484a7():__wf_atom_e3587084() == p
	then
		v34 = true
	end

	local mSelectedElement = nil

	if v6 ~= nil then
		if v30 or v6.mSelectedElement == nil then
			for i = 1, #v6.mElements do
				if v6.mElements[i].PlayerAccountId ~= p then
					continue
				end

				mSelectedElement = v6.mElements[i]
				break
			end
		else
			mSelectedElement = v6.mSelectedElement
		end
	end

	if mSelectedElement ~= nil then
		local relic = Resource(equippedProjection)

		if __wf_atom_7e8ad928(relic) then
			mSelectedElement.Relic = nil
			mSelectedElement.EquippedProjection = nil
			mSelectedElement.StoreItem = nil
			mSelectedElement.IsNone = true
			mSelectedElement.Quality = 0
			mSelectedElement.Name = Localize("/Lotus/Language/Menu/ProjectionManager_NoRelic", {})
			mSelectedElement.LocalizedDesc = ""
			mSelectedElement.Icon = emptySlotIcon
			mSelectedElement.Themed = true
			mSelectedElement.Count = 0
		else
			local __wf_atom_232fd31d = v2:__wf_atom_232fd31d(relic)

			if not __wf_atom_7e8ad928(__wf_atom_232fd31d) and __wf_atom_232fd31d ~= mSelectedElement.StoreItem then
				mSelectedElement = module4.GetStoreItemInfo(
					mMovie,
					__wf_atom_232fd31d,
					{ AppendInfo = mSelectedElement },
					nil,
					nil,
					true
				)
			end

			mSelectedElement.Relic = relic
			mSelectedElement.EquippedProjection = equippedProjection
			mSelectedElement.IsNone = false
			mSelectedElement.Quality = relic:__wf_atom_966277ef()
			mSelectedElement.Name = __wf_atom_232fd31d:__wf_atom_014a76a2():c_str()

			if mSelectedElement.Quality > 0 then
				mSelectedElement.Name ..= " [" .. TitleCase(mMovie:__wf_atom_8e9ac384(
					v50[mSelectedElement.Quality + 1],
					true
				)) .. "]"
			end

			mSelectedElement.LocalizedDesc = Localize(relic:__wf_atom_3a3d2e39():c_str(), {})
			local iconTexture, themed = module4.GetIconTexture(relic, true)
			mSelectedElement.Icon = iconTexture
			mSelectedElement.Themed = themed
			mSelectedElement.Count = 1
		end

		if equippedProjection ~= "" then
			mSelectedElement.ProjectionLoader = UISys.__wf_atom_c0dbe47c({ equippedProjection })
		end

		v6.mElementDrawCallback(mSelectedElement)
	end

	if not v32 and v30 and not __wf_atom_7e8ad928(gGameRules) then
		v36 = gRegion:__wf_atom_577a4d19()
		mMovie:__wf_atom_50d60589("EquippedProjections.Count", 36, gGameRules:__wf_atom_556a8e54() .. "/" .. v36)

		if not __wf_atom_7e8ad928(gRegion) and gRegion:IsMaster() then
			local __wf_atom_556a8e54 = gGameRules:__wf_atom_556a8e54()

			if v36 <= __wf_atom_556a8e54 then
				print("We got all the votes so we can close now!")
				gGameRules:__wf_atom_10079e4d()
				v32 = true
			end
		end
	end
end

function OnProjectionChosen(p, equippedProjection)
	fn10(p, equippedProjection)
end

function OnConfirmEquipProjection(p)
	if tonumber(p) == 4 and not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(v37)) then
		if v30 or v31 then
			gGameRules:__wf_atom_ab52ec74(v37.Type)

			if v30 then
				if not __wf_atom_7e8ad928(gRegion) then
					local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

					if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
						fn10(__wf_atom_eab484a7:__wf_atom_e3587084(), v37.Type:__wf_atom_5b41f63b())
					end
				end

				return
			end
		end

		gGameData:__wf_atom_2d4e8342(v37.Type)

		if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CONFIRM_DIALOG"), "relic_yes")
		end

		fn7()
	elseif not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("CONFIRM_DIALOG"), "relic_no")
	end
end

local function fn11(p)
	if tonumber(p) == 4 and not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_2d4e8342(nil)

		if v30 or v31 then
			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_ab52ec74(nil)
			end

			if v30 then
				if not __wf_atom_7e8ad928(gRegion) then
					local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

					if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
						fn10(__wf_atom_eab484a7:__wf_atom_e3587084(), "")
					end
				end

				return
			end
		end

		fn7()
	end
end

function ConfirmProjectionNotOwned(_) end

function ConfirmPlayWithoutProjection(p)
	fn11(p)
end

local function fn12()
	if flag or __wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v37) then
		return
	end

	if v37.NotOwned then
		module.ShowMessage("/Lotus/Language/Menu/ProjectionNotOwned", "ConfirmProjectionNotOwned")
		return
	end

	if v37.IsNone then
		v44 = module.ShowConfirmMessage(
			"/Lotus/Language/Menu/NoLoadOutProjectionConfirm",
			"ConfirmPlayWithoutProjection"
		)
		return
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/ProjectionManager_EquipProjectionConfirm",
		false,
		{ NAME = v37.Name }
	)
	v44 = module.ShowYesOrNoMessage(__wf_atom_8e9ac384, "OnConfirmEquipProjection")
end

local function fn13()
	print("LoadingComplete")
	v5.mPrevSelectedId = nil
	v5:RemoveElements(true, true)
	v21 = false
	v40:SetActive(v21)
	mMovie:__wf_atom_2dedec1a("TierList", 13, true)
	mMovie:__wf_atom_2dedec1a("ProjectionList", 13, true)

	for _, appendInfo in pairs(v20) do
		__wf_atom_83c14687(0)

		if appendInfo.Relic ~= nil then
			continue
		end

		local relic = Resource(appendInfo.Type)

		if __wf_atom_7e8ad928(relic) then
			local categories = {}

			for _, v58 in pairs(v52) do
				table.insert(categories, v58)
			end

			appendInfo.Categories = categories
			appendInfo.Icon = fillerSlotIcon
			appendInfo.IconHeight = 118
			appendInfo.Themed = true
		else
			local categories = { v52.ALL }
			local mUnfilteredCategories = v5.mUnfilteredCategories

			for i = 1, #mUnfilteredCategories do
				if not relic:IsA(mUnfilteredCategories[i].BaseTierType) then
					continue
				end

				table.insert(categories, mUnfilteredCategories[i].Category)
				break
			end

			local c_str = relic:__wf_atom_014a76a2():c_str()
			local v57 = string.match(c_str, "(%d+)")
			appendInfo.Categories = categories
			appendInfo.RelicName = c_str

			if v57 ~= nil then
				c_str = string.gsub(c_str, v57, "") or c_str
			end

			appendInfo.SearchName = c_str
			appendInfo.SearchNumber = tonumber(v57) or 0
			appendInfo.Quality = relic:__wf_atom_966277ef()
			appendInfo.Relic = relic

			if not __wf_atom_1ef90898(v3) and appendInfo.Quality > 0 then
				local __wf_atom_2ad5cd23 = appendInfo.Type:__wf_atom_2ad5cd23()
				appendInfo.Entry = v3:__wf_atom_37a8a86f(__wf_atom_2ad5cd23)
			end

			local storeItem = appendInfo.StoreItem or v2:__wf_atom_232fd31d(appendInfo.Type)

			if __wf_atom_7e8ad928(storeItem) then
				appendInfo.Name = appendInfo.RelicName
				appendInfo.SearchTerm = __wf_atom_d99ae0ec(appendInfo.Name)
				appendInfo.LocalizedDesc = mMovie:__wf_atom_8e9ac384(relic:__wf_atom_3a3d2e39():c_str(), false)
				local iconTexture, themed = module4.GetIconTexture(relic, true)
				appendInfo.Icon = iconTexture
				appendInfo.Themed = themed
			else
				appendInfo = module4.GetStoreItemInfo(mMovie, storeItem, { AppendInfo = appendInfo }, nil, nil, true)
				appendInfo.SearchTerm = module4.GetSearchString(mMovie, storeItem)
			end

			appendInfo.CanPreview = appendInfo.NotOwned
		end
	end

	for _, v55 in pairs(v20) do
		if v55.Quality == 0 or v55.Count > 0 then
			v5:AddElement(v55, true)
		end
	end

	v5:Redraw(nil, true, true)

	if v5.mPrevSelection ~= 0 then
		v5:SelectElement(v5.mPrevSelection)
	end

	local v55 = "/Lotus/Language/Menu/" .. module.Ternary(
		count == 0,
		"ProjectionManager_NoProjectionsHint",
		"ProjectionManager_Hint"
	)
	mMovie:__wf_atom_7d7314f1("Upgrader.Main.Hint.text", v55)
	fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	print("LoadingCompleteEnd")
end

local function fn14()
	print("PopulateInventoryGrid")

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		print("ERROR: No inventory!")
		assert(false)
	end

	if flag2 then
		if v20.NONE == nil then
			v20.NONE = {
				Found = true,
				IsNone = true,
				Count = 0,
				SearchTerm = "",
				Quality = 0,
				Name = Localize("/Lotus/Language/Menu/ProjectionManager_NoRelic", {})
			}
		else
			v20.NONE.Found = true
		end
	end

	local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()
	local mItemCount = 0

	for k, v55 in pairs(__wf_atom_c84817dd) do
		__wf_atom_83c14687(0)

		if not (__wf_atom_7e8ad928(v55.mItemType) or not v55.mItemType:IsA(__wf_atom_6317e6dc)) then
			continue
		end

		if v55.mItemType == currencyBar_ExtraCurrency then
			mItemCount = v55.mItemCount
		end

		__wf_atom_c84817dd[k] = nil
	end

	mMovie:__wf_atom_50d60589(
		"Upgrader.Main.VoidTrace",
		36,
		Localize("/Lotus/Language/Items/VoidTearDrop", {}) .. mMovie:__wf_atom_8e9ac384(
			"<LUMINOUS>" .. mItemCount .. " / " .. tostring(_T.CurrencyBar_ExtraCurrencyMax),
			true
		)
	)
	local __wf_atom_5b41f63bs = {}
	local v55 = not __wf_atom_7e8ad928(v23)

	local function fn15(instance, mItemCount2, storeItem, entry)
		local __wf_atom_5b41f63b = instance:__wf_atom_5b41f63b()
		table.insert(__wf_atom_5b41f63bs, __wf_atom_5b41f63b)
		local v56 = v20[__wf_atom_5b41f63b]

		if v56 == nil then
			v56 = {
				Type = instance,
				Count = mItemCount2,
				NotOwned = mItemCount2 == 0,
				StoreItem = storeItem,
				Entry = entry,
				Found = true
			}
			v20[__wf_atom_5b41f63b] = v56
		else
			v56.Found = true
			v56.Count = mItemCount2
			v56.NotOwned = mItemCount2 == 0
			v56.CanPreview = mItemCount2 == 0
		end

		if v55 and instance:IsA(v23) then
			v55 = false
			v56.FocusElement = true
		end
	end

	if not v30 then
		if #v24 == 0 then
			if __wf_atom_1ef90898(v3) then
				v3 = Resource(v3)
			end

			v24 = v3:__wf_atom_93efa65d()
		end

		for _, v56 in pairs(v24) do
			__wf_atom_83c14687(0)
			local __wf_atom_232fd31d = v2:__wf_atom_232fd31d(v56.type)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				continue
			end

			local alwaysAvailable = __wf_atom_232fd31d:AlwaysAvailable()
			local item = __wf_atom_232fd31d:GetItem()
			local mItemCount2 = 0

			if not alwaysAvailable then
				for k, v57 in pairs(__wf_atom_c84817dd) do
					if v57.mItemType ~= item then
						continue
					end

					mItemCount2 = v57.mItemCount
					__wf_atom_c84817dd[k] = nil
					alwaysAvailable = true
				end
			end

			if not (alwaysAvailable or __wf_atom_232fd31d:__wf_atom_e063e3c3() or v56.secret) or alwaysAvailable then
				fn15(item, mItemCount2, __wf_atom_232fd31d, v56)
			end
		end
	end

	for _, v56 in pairs(__wf_atom_c84817dd) do
		__wf_atom_83c14687(0)
		fn15(v56.mItemType, v56.mItemCount)
	end

	v21 = #__wf_atom_5b41f63bs > 0
	v40:SetActive(v21)

	if v21 then
		v22 = UISys.__wf_atom_c0dbe47c(__wf_atom_5b41f63bs)
	end

	for k, v56 in pairs(v20) do
		if not v56.Found then
			v20[k] = nil
		end
	end

	print("PopulateInventoryGridEnd")
end

local function fn15()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Loom.Left.SingleLoom01", 10)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Main.Loom", 0, { function(p)
			local v55 = __wf_atom_5e6e15c8 - p

			for i = 1, 4 do
				__wf_atom_86cbd68d(mMovie, "Upgrader.Main.Loom.Left.SingleLoom0" .. i .. ".gotoAndStop", v55)
				__wf_atom_86cbd68d(mMovie, "Upgrader.Main.Loom.Right.SingleLoom0" .. i .. ".gotoAndStop", v55)
			end
		end }, { __wf_atom_5e6e15c8 - 1 }, 0.5)
end

local function fn16(p)
	local v55 = (p <= quality2 or v15 ~= nil and p == v15 - 1) and 100 or 25
	local v56 = "Upgrader.Main.RankList.Rank" .. p + 1
	mMovie:__wf_atom_4c1c1986(v56, "IconBacker", 12, v55)
end

local function fn17(p)
	local tieredItems = {}
	local v55

	if __wf_atom_7e8ad928(p.Relic) then
		v55 = Resource(p.Type)
	else
		v55 = Resource(p.Relic)
	end

	if __wf_atom_7e8ad928(v55) then
		return tieredItems
	end

	local __wf_atom_ff7834ae = v55:__wf_atom_ff7834ae()

	if __wf_atom_7e8ad928(__wf_atom_ff7834ae) then
		return tieredItems
	end

	for i = 0, __wf_atom_ff7834ae:__wf_atom_8cfee589() do
		for j = 0, __wf_atom_ff7834ae:__wf_atom_d1247c6c(i) - 1 do
			local tieredItem = __wf_atom_ff7834ae:GetTieredItem(i, j)

			if not __wf_atom_7e8ad928(tieredItem) then
				table.insert(tieredItems, tieredItem)
			end
		end
	end

	return tieredItems
end

local function fn18(data)
	v7:RemoveElements(true, true)
	local v55 = fn17(data)
	table.sort(v55, function(a, b)
		return a:__wf_atom_a8dac107() < b:__wf_atom_a8dac107()
	end)
	local inventory

	if not __wf_atom_7e8ad928(gGameData) then
		inventory = gGameData:GetInventory()
	end

	for i = 1, #v55 do
		local v56 = v55[i]
		local storeItemInfo = module4.GetStoreItemInfo(mMovie, v56.mStoreItem, nil, nil, nil, true)

		if __wf_atom_7e8ad928(storeItemInfo) then
			continue
		end

		storeItemInfo.Rarity = v56:__wf_atom_a8dac107()
		storeItemInfo.ShowInfoPopupOwned = true
		storeItemInfo.QuantityMultiplier = v56.mItemCount
		storeItemInfo.Count = 0

		if v25[storeItemInfo.FullName] == nil or not (v25[storeItemInfo.FullName].Count > 0) then
			if not __wf_atom_7e8ad928(inventory) then
				storeItemInfo.Count = inventory:__wf_atom_52fcdd65(storeItemInfo.Type)
			end
		else
			storeItemInfo.Count = v25[storeItemInfo.FullName].Count
		end

		v7:AddElement(storeItemInfo, true)
	end

	v7:Redraw(nil, true, true)
end

local function fn19(item)
	local baseUpgradeIcon = baseUpgradeIcon
	local rankIcons = rankIcons
	local ringIcons = ringIcons
	local v55 = v53

	if not __wf_atom_7e8ad928(item) and item:IsA(v) then
		baseUpgradeIcon = immortalUpgradeIcon
		rankIcons = immortalIcons
		ringIcons = immortalRingIcons
		v55 = v54
	end

	return baseUpgradeIcon, rankIcons, ringIcons, v55
end

local function fn20(data, p, p2)
	if __wf_atom_7e8ad928(data) then
		return
	end

	v37 = data

	if v30 and not __wf_atom_7e8ad928(v23) then
		v23 = nil
		fn12()
	end

	local v55 = (data.Filler or data.IsNone) == true
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Hint", 13, v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.HintIcon", 13, v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Backer", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Grid", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Icon", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.RankList", 13, not (v55 or v10.mIsVisible))
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.VoidTrace", 13, not (v55 or v10.mIsVisible))
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.ScrollBar", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Loom", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Title", 13, not v55)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.RarityBars", 13, not v55)
	v9:SetVisible(not (v55 or v10.mIsVisible))
	v10:SetVisible(not v55 and v10.mIsVisible)
	v8:SetVisible((v55 or v10.mIsVisible) and flag2)

	if v55 or __wf_atom_7e8ad928(v37.StoreItem) then
		if not v21 then
			local v56 = "/Lotus/Language/Menu/" .. module.Ternary(
				count == 0,
				"ProjectionManager_NoProjectionsHint",
				"ProjectionManager_Hint"
			)
			mMovie:__wf_atom_7d7314f1("Upgrader.Main.Hint.text", v56)
		end

		if not p2 and _T.TestProjectionSquad then
			fn10(gRegion:__wf_atom_eab484a7():__wf_atom_e3587084(), "")
		end
	else
		if not p2 and _T.TestProjectionSquad then
			fn10(gRegion:__wf_atom_eab484a7():__wf_atom_e3587084(), data.Type:__wf_atom_5b41f63b())
		end

		quality = data.Quality
		v19 = "<b>" .. TitleCase(data.Name) .. " <\8>- " .. TitleCase(mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ProjectionManager_Rewards",
			true
		))

		if p then
			fn15()
		end

		mMovie:__wf_atom_933bbce0("Upgrader.Main.Icon.Main", data.Icon, data.Material)
		mMovie:__wf_atom_1ca72041("Upgrader.Main.Icon.Main", "VisibilitySize", 100, 0, 0, 0)
		local v56 = not data.NotOwned

		if v56 then
			mMovie:__wf_atom_1ca72041("Upgrader.Main.Icon.Main", "DetailMapParams", 1, 0, 1, 1)
		else
			mMovie:__wf_atom_1ca72041("Upgrader.Main.Icon.Main", "DetailMapParams", 0.4, 0, 1, 1)
		end

		mMovie:__wf_atom_933bbce0("Upgrader.Anim.Relic.Icon.Main", data.Icon, data.Material)
		mMovie:__wf_atom_1ca72041("Upgrader.Anim.Relic.Icon.Main", "VisibilitySize", 100, 0, 0, 0)
		local v57 = v56 and "/Lotus/Language/Menu/ProjectionManager_EnhancementsTitle"
			or "/Lotus/Language/Menu/ProjectionNotOwned"
		local v58 = v56 and "/Lotus/Language/Menu/ProjectionManager_UpgradeRelic"
			or "/Lotus/Language/Menu/ProjectionNotOwned"

		if quality == 3 then
			v9:SetActive(false)
			v10:SetActive(false)
			v57 = "/Lotus/Language/Ranks/MaxRank"
			v58 = "/Lotus/Language/Ranks/MaxRank"
		else
			local inventory = gGameData:GetInventory()

			if __wf_atom_7e8ad928(inventory) then
				print("ERROR: No inventory!")
				assert(false)
			end

			local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()
			local v59 = 0
			local total = 0
			local mItemCount = 0

			for _, v61 in pairs(__wf_atom_c84817dd) do
				if not v61.mItemType:IsA(currencyBar_ExtraCurrency) then
					continue
				end

				mItemCount = v61.mItemCount
				break
			end

			for i = 0, quality do
				v59 = v59 + i + 1
			end

			for i = quality + 1, quality2 do
				total += v51[i]
			end

			if mItemCount < total and quality2 ~= 0 then
				quality2 = v14
				total = 0

				for i = quality + 1, quality2 do
					total += v51[i]
				end
			end

			v14 = quality2

			if v56 and quality < quality2 then
				local quality3 = "\"" .. TitleCase(mMovie:__wf_atom_8e9ac384(v50[quality2 + 1], true)) .. "\""
				v57 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_UpgradeWithNum", false, {
					QUALITY = quality3,
					NUM = total
				})
				mMovie:__wf_atom_290807ee("Upgrader.Main.UpgradeBtn")
			end

			v9:SetActive(v56 and quality < quality2)
			v10:SetActive(true)
		end

		fn18(data)
		fn2(quality2, true)
		local v59, v60, v61, v62 = fn19(v37.StoreItem:GetItem())
		local total = 0

		for i = 0, 3 do
			local ternary = module.Ternary(v56 and i <= quality2, 100, 50)
			local v63 = i + 1
			local v64 = "Upgrader.Main.RankList.Rank" .. v63
			local v65 = module.Ternary(
				i == 0,
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false),
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
					RANK = i
				})
			) .. "  "

			if not mMovie:__wf_atom_253d7085(v64) then
				__wf_atom_86cbd68d(mMovie, "Upgrader.Main.RankList.Rank1.duplicateMovieClip", "Rank" .. v63, v63)
			end

			mMovie:SetCallbacks(
				"Upgrader.Main.RankList.Rank" .. v63 .. ".Btn",
				"RankElementFocused",
				"RankElementUnfocused",
				"",
				"RankElementPressed"
			)
			mMovie:__wf_atom_e57658c2("Upgrader.Main.RankList.Rank" .. v63, 0, total + 50)
			mMovie:__wf_atom_e57658c2("Upgrader.Main.RankList.Rank" .. v63 .. ".Btn", 100, i)
			v13[v63] = { v65, "" }
			local v66 = "<p><font ><b>" .. v65 .. "</b></font><font letterSpacing=\"0.2\"></font></p>"
			mMovie:__wf_atom_48bd5a59(v64, "Desc", 46, "center")
			mMovie:__wf_atom_48bd5a59(v64, "Desc", 36, v66)
			mMovie:__wf_atom_4c1c1986(v64, "Desc", 12, ternary)
			mMovie:__wf_atom_4c1c1986(v64, "Icon", 12, ternary)
			local mMovie2 = mMovie
			local v69

			if v56 then
				if quality < quality2 then
					v69 = quality2 == i
				else
					v69 = false
				end
			else
				v69 = v56
			end

			mMovie2:__wf_atom_7f57ab2f(v64, "Glow", 13, v69)
			mMovie:__wf_atom_7f57ab2f(v64, "Line", 13, i ~= 3)
			mMovie:__wf_atom_4c1c1986(v64, "Line", 12, i < quality2 and 50 or 0)
			fn16(i)
			local v70 = i <= quality
			local v71 = v60[v63 - 1]
			mMovie:__wf_atom_4c1c1986(v64, "Icon", 1, v70 and -4 or 0)
			mMovie:__wf_atom_4c1c1986(v64, "RankIcon", 1, v70 and -4 or 0)
			mMovie:__wf_atom_7f57ab2f(v64, "Check", 13, v70)
			mMovie:__wf_atom_7f57ab2f(v64, "RankIcon", 13, not __wf_atom_7e8ad928(v71))
			mMovie:__wf_atom_c90af43a(v64 .. ".Icon", v59)
			mMovie:__wf_atom_c90af43a(v64 .. ".RankIcon", v71)
			mMovie:__wf_atom_c90af43a(v64 .. ".Check", checkIcon)
			mMovie:OverrideMaterial(v64 .. ".IconBacker", _G.UIMaterial_RectangleNoDepth)
			mMovie:OverrideMaterial(v64 .. ".Backer", _G.UIMaterial_RectangleNoDepth)
			mMovie:__wf_atom_933bbce0(v64 .. ".Glow", glowIcon, glowMaterial)
			mMovie:__wf_atom_933bbce0(v64 .. ".Gradient", backerIcon, _G.UIMaterial_RectangleNoDepth)
			total += 100
			mMovie:__wf_atom_c90af43a("Upgrader.Main.Icon.GlowRings.Ring" .. i, v61[i])
			mMovie:__wf_atom_c90af43a("Upgrader.Anim.Relic.Icon.GlowRings.Ring" .. i, v61[i])
			mMovie:__wf_atom_2dedec1a("Upgrader.Main.Icon.GlowRings.Ring" .. i, 13, i <= quality2)
			mMovie:__wf_atom_2dedec1a("Upgrader.Anim.Relic.Icon.GlowRings.Ring" .. i, 13, i <= quality2)

			if v62[i] == nil then
				continue
			end

			mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon.GlowRings.Ring" .. i, 0, v62[i][1])
			mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon.GlowRings.Ring" .. i, 1, v62[i][2])
			mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic.Icon.GlowRings.Ring" .. i, 0, v62[i][1])
			mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic.Icon.GlowRings.Ring" .. i, 1, v62[i][2])
		end

		v9:SetText(v57)
		v10:SetText(v58)
		fn5()
		fn6()
	end
end

local function fn21(data, isFocused)
	local filler = data.Filler or data.EmptySlot
	return {
		IsFiller = filler,
		IsFocused = isFocused,
		IsSelected = not filler and v6.mPrevSelectedId == data.Id,
		Locked = data.Equipped,
		LockedMsg = "/Lotus/Language/Menu/ItemSelection_Equipped",
		ShowInfoPopup = isFocused and not (data.Locked or data.Hidden)
	}
end

local function fn22(p, p2)
	module6.OnGridItemCreated(mMovie, v6, p)
	local player = p2 ~= nil and p2.Player or gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(player) then
		local v55 = p .. ".PlayerIcon"
		table.insert(v45, v55)
		module3.RegisterProfileIcon(mMovie, v55, player)
	end
end

local function fn23(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v6, p, fn21(p, true))
end

local function fn24(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v6, p, fn21(p, false))
end

local function fn25(data)
	if data.mClipName == nil then
		return
	end

	module6.DrawGridItem(mMovie, v6, data, fn21(data, data == v6:GetFocusedElement()))
	mMovie:__wf_atom_4c1c1986(data.mClipName, "RelicName", 14, 178)
	mMovie:__wf_atom_48bd5a59(data.mClipName, "RelicName", 36, TitleCase(data.Name))
	mMovie:__wf_atom_48bd5a59(data.mClipName, "RelicName", 46, "center")
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow", 14, 30)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow", 15, 60)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow", 0, -v6.BackerWidth / 2)
	mMovie:__wf_atom_4c1c1986(data.mClipName, "Arrow", 1, -11)
	local player = data ~= nil and data.Player or gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(player) then
		mMovie:__wf_atom_48bd5a59(data.mClipName, "PlayerName", 36, player:__wf_atom_6be84646())
	end
end

local function fn26()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not (v30 or _T.TestProjectionSquad) or __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		mMovie:__wf_atom_2dedec1a("Upgrader.SquadList", 13, false)
		return
	end

	mMovie:__wf_atom_50d60589("Upgrader.SquadList.Title", 46, "bottom")
	mMovie:__wf_atom_50d60589(
		"Upgrader.SquadList.Title",
		36,
		TitleCase(Localize("/Lotus/Language/Menu/ProjectionManager_EquippedProjectionsTitle", {}))
	)
	local module9 = require("EE.Interface.Components.Grid")
	v6 = module9.CreateGrid(mMovie, "Upgrader.SquadList.Item", nil, 1, 4)
	v6:SetCallbacks("SquadSelected", "SquadFocused", "SquadUnfocused")
	v6.BackerWidth = 268
	v6.mRowSeparation = 92
	v6.ElementWidth = 90
	v6.ElementHeight = 90
	v6.mSelectedScale = 100
	v6.mUseCornerForSelected = true
	v6.mSelectElementsOnFocus = false
	v6.mWrapAroundNavigation = false
	v6.mPrevSelectedId = nil
	v6.mClipCreatedCallback = fn22
	v6.mOnFocusedCallback = fn23
	v6.mOnUnfocusedCallback = fn24
	v6.mElementDrawCallback = fn25

	function v6.mOnSelectedCallback(data)
		if data.mClipName == nil then
			return
		end

		local mPrevSelectedId = v6.mPrevSelectedId

		if mPrevSelectedId ~= nil and mPrevSelectedId == data.Id then
			return
		end

		v6.mPrevSelectedId = data.Id
		quality2 = data.Quality
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_ItemTipSection)

		if mPrevSelectedId ~= nil then
			local elementById = v6:GetElementById(mPrevSelectedId)

			if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
				fn25(elementById)
			end
		end

		fn25(data)
		fn20(data, true, true)
	end

	v6.BaseUpdateColors = v6.UpdateColors

	function v6.UpdateColors(object, p, p2, p3, p4)
		object:BaseUpdateColors(p, p2, p3, p4)
		local color = module5.GetColor(2, true)
		local color2 = module5.GetColor(9, true)
		local color3 = module5.GetColor(10, true)
		local v55 = p2 and color3 or color2
		mMovie:__wf_atom_4c1c1986(p.mClipName, "RelicName", 11, v55)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "PlayerName", 11, v55)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Divider", 11, color2)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Arrow.Icon", 11, color3)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Arrow.Backer", 11, color)
		mMovie:__wf_atom_4c1c1986(p.mClipName, "Divider", 12, (p2 or p3) and 80 or 25)
		mMovie:__wf_atom_7f57ab2f(p.mClipName, "Arrow", 13, p3)
	end

	v6:RemoveElements(true, true)
	local v55 = v30 and gGameRules:__wf_atom_ccaf9d5c()
		or { __wf_atom_eab484a7, __wf_atom_eab484a7, __wf_atom_eab484a7 }
	local __wf_atom_e3587084 = __wf_atom_eab484a7:__wf_atom_e3587084()
	local v56 = {}

	for i = 1, #v55 do
		local __wf_atom_e3587084_2 = v55[i]:__wf_atom_e3587084()
		table.insert(v56, {
			Name = Localize("/Lotus/Language/Menu/ProjectionManager_SelectionPending", {}),
			Icon = emptySlotIcon,
			Themed = true,
			IsNone = true,
			NotOwned = true,
			Count = 0,
			Quality = 0,
			ProjectionLoader = nil,
			PlayerAccountId = __wf_atom_e3587084_2,
			PlayerName = v55[i]:__wf_atom_6be84646(),
			Player = v55[i],
			IsLocal = __wf_atom_e3587084_2 == __wf_atom_e3587084,
			EquippedProjection = nil,
			IconHeight = 54
		})
	end

	table.sort(v56, function(a, b)
		local isLocal = a.IsLocal

		if isLocal == b.IsLocal then
			return a.PlayerName < b.PlayerName
		end

		return isLocal
	end)

	for i = 1, #v56 do
		v6:AddElement(v56[i], true)
	end

	v6:Redraw(nil, true, true)
	v6:SelectElementById(1, true)
	_T.SquadRelics = v6.mElements
end

local function fn27(data, isFocused)
	local filler = data.Filler or data.EmptySlot
	return {
		HideCountThreshold = 0,
		HideOwned = true,
		IsFiller = filler,
		IsFocused = isFocused,
		IsSelected = not filler and v7.mPrevSelectedId == data.Id,
		Locked = data.Equipped,
		LockedMsg = "/Lotus/Language/Menu/ItemSelection_Equipped",
		ShowInfoPopup = isFocused and not (data.Locked or data.Hidden)
	}
end

local function fn28(p, _)
	module6.OnGridItemCreated(mMovie, v7, p)
end

local function fn29(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v7, p, fn27(p, true))
end

local function fn30(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v7, p, fn27(p, false))
end

local function fn31(p)
	if p.mClipName == nil then
		return
	end

	module6.DrawGridItem(mMovie, v7, p, fn27(p, p == v7:GetFocusedElement()))
end

local function fn32()
	local module9 = require("EE.Interface.Components.Grid")
	v7 = module9.CreateGrid(mMovie, "Upgrader.Main.Grid.Item", nil, 3, 2)
	v7:SetCallbacks("RewardSelected", "RewardFocused", "RewardUnfocused")
	v7.mShowLabels = true
	v7.ElementDimBuffer = 0
	v7.ElementWidth = 142
	v7.ElementHeight = 142
	v7.Width = 400
	v7.Height = 300
	v7.mSelectedScale = 100
	v7.mUseCornerForSelected = true
	v7.mSelectElementsOnFocus = false
	v7.mWrapAroundNavigation = false
	v7.mPrevSelectedId = nil
	v7.mClipCreatedCallback = fn28
	v7.mOnFocusedCallback = fn29
	v7.mOnUnfocusedCallback = fn30
	v7.mElementDrawCallback = fn31

	function v7.mOnSelectedCallback(p)
		if p.mClipName == nil then
			return
		end

		local mPrevSelectedId = v7.mPrevSelectedId

		if mPrevSelectedId ~= nil and mPrevSelectedId == p.Id then
			return
		end

		v7.mPrevSelectedId = p.Id
		module.PlaySound(_G.UISound_Select)
		module.PlaySound(_G.UISound_ItemTipSection)

		if mPrevSelectedId ~= nil then
			local elementById = v7:GetElementById(mPrevSelectedId)

			if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
				fn31(elementById)
			end
		end

		fn31(p)
	end
end

local function fn33(data, isFocused)
	local filler = data.Filler or data.EmptySlot
	return {
		HideCountThreshold = 1,
		IsFiller = filler,
		IsFocused = isFocused,
		IsSelected = not filler and v5.mPrevSelectedId == data.Id,
		Locked = data.Equipped,
		LockedMsg = "/Lotus/Language/Menu/ItemSelection_Equipped",
		OwnedInfo = { TagOverride = "/Lotus/Language/Menu/HowManyRequired" },
		ShowInfoPopup = isFocused and not (data.Locked or data.Hidden)
	}
end

local function fn34(p, _)
	module6.OnGridItemCreated(mMovie, v5, p)
end

local function fn35(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v5, p, fn33(p, true))
end

local function fn36(p)
	if p.mClipName == nil then
		return
	end

	module6.OnGridItemFocusChanged(mMovie, v5, p, fn33(p, false))
end

local function fn37(p)
	if p.mClipName == nil then
		return
	end

	module6.DrawGridItem(mMovie, v5, p, fn33(p, p == v5:GetFocusedElement()))
end

local function fn38()
	local module9 = require("Lotus.Interface.Components.CategorizedGrid")
	v5 = module9.CreateCategorizedGrid(
		mMovie,
		"InventorySelector.Grid.Item",
		6,
		4,
		"InventorySelector.CategoryMenu",
		"InventorySelector.SortMenu"
	)
	v5:SetCallbacks("InventoryItemSelected", "InventoryItemFocused", "InventoryItemUnfocused")
	v5.mShowLabels = true
	v5.ElementDimBuffer = 24
	v5.ElementWidth = 142
	v5.ElementHeight = 142
	v5.Width = 900
	v5.Height = 640
	v5.mSelectedScale = 100
	v5:AttachScrollBar("InventorySelector.ScrollBar", 1)
	v5:EnableSmoothScroll()
	v5.mUseCornerForSelected = true
	v5.mSmoothScrollExtraSpace = 0
	v5.mSelectElementsOnFocus = false
	v5.mScroll = 1
	v5.mSkipRefocusOnScrollRedraw = true
	v5.mSortMenu:SetWidth(200)
	v5.mScrollBar:SetActive(true)
	v5.mScrollAlwaysVisible = true
	v5.mScrollBarHorizontalOffset = nil
	v5.mWrapAroundNavigation = false
	v5.mPrevSelectedId = nil
	v5.RectangleVisibleRangeMaterial = rectangleVisibleRangeMat
	v5.VisibleRangeMaterial = visibleRangeMat
	v5.TextVisibleRangeMaterial = textVisibleRangeMat
	v5.mCategoryMenu.mAlign = module.LEFT_ALIGNED
	v5.mCategoryMenu.mHideEmptyCategories = true
	v5.mClipCreatedCallback = fn34
	v5.mOnFocusedCallback = fn35
	v5.mOnUnfocusedCallback = fn36
	v5.mElementDrawCallback = fn37
	v5.BaseOnFilteredElementsReady = v5.OnFilteredElementsReady

	function v5:OnFilteredElementsReady()
		self:BaseOnFilteredElementsReady()
		self.mPrevSelection = self.mPrevSelection or 0

		for i = 1, #self.mElements do
			local mElement = self.mElements[i]

			if not mElement.FocusElement then
				continue
			end

			self.mPrevSelection = i
			mElement.FocusElement = nil
			break
		end

		self.mPrevSelection = math.min(self.mPrevSelection, self:GetHowManyElements())

		if self.mPrevSelection ~= 0 then
			self:SetScroll(self.mPrevSelection - (self.mPrevSelection - 1) % self.mColumns, true)
		end

		count = 0
		count2 = 0
		count3 = 0
		local v55 = {}

		for _, mElement in ipairs(self.mElements) do
			if mElement.RelicName == nil then
				continue
			end

			local v56 = v55[mElement.RelicName]

			if v56 == nil then
				v56 = {}
				v55[mElement.RelicName] = v56
				count += 1
			end

			if not (v56.Owned or mElement.NotOwned) then
				v56.Owned = true
				count2 += 1
			end

			if v56.Maxed or mElement.Quality ~= 3 then
				continue
			end

			v56.Maxed = true
			count3 += 1
		end

		fn5()

		if self.mPrevSelectedId ~= nil then
			self.mSelectedElement = self:GetElementById(self.mPrevSelectedId)
			fn20(self.mSelectedElement or { Filler = true, IsNone = true })
		end
	end

	function v5.mOnSelectedCallback(data)
		if data.mClipName == nil then
			return
		end

		local mPrevSelectedId = v5.mPrevSelectedId

		if mPrevSelectedId == nil or mPrevSelectedId ~= data.Id then
			v5.mPrevSelectedId = data.Id
			v11 = Time()
			module.PlaySound(_G.UISound_Select)
			module.PlaySound(_G.UISound_ItemTipSection)
			quality2 = data.Quality

			if mPrevSelectedId ~= nil then
				local elementById = v5:GetElementById(mPrevSelectedId)

				if not __wf_atom_7e8ad928(elementById) and elementById.mClipName ~= nil then
					fn37(elementById)
				end
			end

			v10:SetVisible(flag2)
			fn20(data, true)

			if data.Filler then
				return
			end

			fn37(data)
			fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
		else
			if (Engine.IsPlayingWithController() or Time() - v11 < 0.5) and flag2 then
				fn12()
			end

			v11 = Time()
		end
	end

	function v5.AdditionalTabInfo(p)
		if __wf_atom_1ef90898(v3) then
			return ""
		end

		local convertColorNumberToHex = module.ConvertColorNumberToHex(module5.GetColor(9, true))
		local convertColorNumberToHex2 = module.ConvertColorNumberToHex(module5.GetColor(10, true))
		return (module2.GetDropSourcesString(
			mMovie,
			v3,
			p.Entry,
			1,
			v41,
			v42,
			convertColorNumberToHex,
			convertColorNumberToHex2
		))
	end

	function v5.AdditionalFilterFunction(p)
		if v12.mLabel == nil or v12.mLabel == "" or p.SearchTerm == nil then
			return false
		end

		return string.find(p.SearchTerm, __wf_atom_d99ae0ec(v12.mLabel), 1, true) == nil
	end

	function v5.GenericSort(data, data2, p, p2)
		if data.IsNone ~= data2.IsNone then
			return data.IsNone
		end

		if data.NotOwned ~= data2.NotOwned then
			return data2.NotOwned
		end

		if p then
			return p2
		end

		if data.SearchName == data2.SearchName then
			return data.SearchNumber < data2.SearchNumber
		end

		return data.SearchName < data2.SearchName
	end

	v5:AddSortBy({
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Name", false),
		SortId = "NAME",
		Attribute = function(p, p2)
			return v5.GenericSort(p, p2)
		end
	})
	v5:AddSortBy({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_EnhancementsTitle", false),
		SortId = "RANK",
		Attribute = function(p, p2)
			return v5.GenericSort(p, p2, p.Quality ~= p2.Quality, p.Quality > p2.Quality)
		end
	})
	v5:AddSortBy({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Owned", false),
		SortId = "COUNT",
		Attribute = function(p, p2)
			return v5.GenericSort(p, p2, p.Count ~= p2.Count, p.Count > p2.Count)
		end
	})
	local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
	local __wf_atom_6340bbd5 = gGameData:__wf_atom_6340bbd5(__wf_atom_6d61d595)
	v5:SetSortBy(__wf_atom_6340bbd5 == "" and "NAME" or __wf_atom_6340bbd5)
	v5:AddCategory({
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Categories/ALL", false),
		Icon = categoryIcons[1],
		Category = v52.ALL
	})
	local v55 = {}

	for k, tier in pairs(module3.VOID_PROJECTION_ITEMS) do
		table.insert(v55, { name = k, tier = tier })
	end

	table.sort(v55, function(a, b)
		return a.name < b.name
	end)

	for i = 1, #v55 do
		local tier = v55[i].tier
		v52[tier] = i
		v5:AddCategory({
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_TierDesc" .. i, false),
			Icon = categoryIcons[i + 1],
			Category = i,
			BaseTierType = tier
		}, true)
	end

	v5:SetCategory(0)
	module.PlaySound(_G.UISound_WindowOpen)
end

local function fn39()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SearchPrompt", false)
	local module9 = require("Lotus.Interface.Components.ThemedInputField")
	v12 = module9.Create(mMovie, "InventorySelector.Search", nil, nil, "<MENU_LTHUMB>")
	v12:SetType(v12.TYPE.PLAIN, __wf_atom_8e9ac384, __wf_atom_8e9ac384)
	v12.mMinSize = 200
	v12.mMaxSize = 200
	v12.mTextBuffer = 4
	v12.mAltButtonIcon = _G.UITexture_Search
	v12.mAltButtonVisible = true
	v12.mUnfocusedUnderlineColorOverride = nil
	v12.BaseInputFieldTextChanged = v12.InputFieldTextChanged

	function v12:InputFieldTextChanged(p)
		local mLabel = self.mLabel
		self:BaseInputFieldTextChanged(p)
		local uiTexture_Search = self.mLabel == "" and _G.UITexture_Search or _G.UITexture_ClearSearch

		if self.mAltButtonicon ~= uiTexture_Search then
			self.mAltButtonicon = uiTexture_Search
			self.mMovie:__wf_atom_c90af43a(self.mClipName .. ".BtnAlt", uiTexture_Search)
		end

		if mLabel ~= self.mLabel and v5 ~= nil then
			v5.mMuteGridOpenSound = true
			v5:Redraw(nil, true, true)
			v5.mMuteGridOpenSound = false
		end
	end

	v12.BaseOnGamepadTransition = v12.OnGamepadTransition

	function v12:OnGamepadTransition()
		self:BaseOnGamepadTransition()
		local mAltButtonVisible = not Engine.IsPlayingWithController()
		self.mAltButtonVisible = mAltButtonVisible
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "BtnAlt", 13, mAltButtonVisible)
	end

	v12.BaseSetClearHintVisible = v12.SetClearHintVisible

	function v12.SetClearHintVisible(object, p)
		object:BaseSetClearHintVisible(p)
		mMovie:__wf_atom_2dedec1a("InventorySelector.Stats", 13, not p)
	end

	v12:SetHint("/Lotus/Language/Menu/SearchPrompt")
	v12:Redraw()
end

local function fn40()
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.CopiedRank", 13, false)
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.Relic", 13, false)
	mMovie:OverrideMaterial("Upgrader.Main.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Main.Bg",
		"RectInnerColor",
		_G.UIColorObject_DarkBlue.r,
		_G.UIColorObject_DarkBlue.g,
		_G.UIColorObject_DarkBlue.b,
		0.1
	)
	mMovie:__wf_atom_1ca72041(
		"Upgrader.Main.Bg",
		"RectEdgeColor",
		_G.UIColorObject_White.r,
		_G.UIColorObject_White.g,
		_G.UIColorObject_White.b,
		0.2
	)
	v10 = module8.Create(mMovie, "Upgrader.Main.RankUpBtn", "Next Rank", "RankUpRelic", "<MENU_RTHUMB>")
	v10:SetPosition(-275, 550, module.CENTER_ALIGNED)
	v10:SetTextAlignment("center")
	v10:SetMinWidth(100)
	v10:Redraw()
	v9 = module8.Create(mMovie, "Upgrader.Main.UpgradeBtn", "Upgrade", "onKeyDown_MENU_GENERIC1", "<MENU_GENERIC1>")
	v9:SetPosition(-275, 594, module.CENTER_ALIGNED)
	v9:SetTextAlignment("center")
	v9:SetSpecialMode()
	v9:SetWidth(350)
	v9:Redraw()
	v8 = module8.Create(
		mMovie,
		"Upgrader.Main.EquipBtn",
		"/Lotus/Language/Menu/EquipProjection",
		"onKeyDown_MENU_GENERIC1",
		"<MENU_GENERIC1>"
	)
	v8:SetPosition(-275, 594, module.CENTER_ALIGNED)
	v8:SetTextAlignment("center")
	v8:SetSpecialMode()
	v8:SetWidth(350)
	v8:Redraw()
	mMovie:__wf_atom_7d7314f1("Upgrader.Main.Hint.text", "/Lotus/Language/Menu/LoadoutSelection_Loading")
	mMovie:__wf_atom_e57658c2("Upgrader.Main.HintIcon", 12, 10)
	mMovie:__wf_atom_50d60589("Upgrader.Main.Hint", 46, "center")
	mMovie:__wf_atom_c90af43a("Upgrader.Main.HintIcon", relicWatermarkIcon)
	fn32()
end

function Shutdown()
	_T.gToolTip = nil
	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
	_T.CurrencyBar_ExtraCurrency = nil
	_T.CurrencyBar_ExtraCurrencyMax = nil

	for i = 1, #v45 do
		module3.UnregisterProfileIcon(mMovie, v45[i])
	end

	if not __wf_atom_7e8ad928(v44) then
		v44:Execute("ForceClose", "")
	end

	if flag3 then
		_T.HideMoneyOverlay = true
	end

	if v30 then
		module3.RegisterHideHud(false)
	else
		if not __wf_atom_7e8ad928(_T.HideBackground) then
			_T.HideBackground()
		end

		if not __wf_atom_7e8ad928(_T.ProjectionManagerAvatar) then
			_T.ProjectionManagerAvatar:SetVisibility(true)
		end
	end

	if _T.DebugThemedProjectionManagerToggleInput and not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(gGameData)) then
		local sortById = v5:GetSortById()

		if not __wf_atom_7e8ad928(sortById) then
			local __wf_atom_6d61d595 = mMovie:__wf_atom_6d61d595()
			gGameData:__wf_atom_00283c1e(__wf_atom_6d61d595, sortById)
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("IN_SHIP_VIEW_TIME"), "EQUIPMENT_REFINEMENT")
	end
end

local function fn41()
	local __wf_atom_af5caba7 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_af5caba7()
	v42 = module2.OnStats(__wf_atom_af5caba7, v41)
end

function Initialize()
	if _T.GloriousHackToAllowSlomoInLotusGameRules then
		mMovie:Close()
		return
	end

	__wf_atom_86cbd68d(mMovie, "Upgrader.Anim.Relic.Loom.gotoAndStop", 1)

	if not __wf_atom_7e8ad928(gGameRules) then
		v30 = gGameRules:IsA(__wf_atom_dd9a0bb8)

		if v30 and gGameRules:__wf_atom_72fc675e().missionType == 32 then
			v31 = true

			if gGameRules:__wf_atom_d163c8e5(Symbol("RJMODE_STATE")) >= 3 then
				v30 = false
			end
		end
	end

	local module9 = require("Lotus.Interface.Components.ThemedSpinner")
	v40 = module9.Create(mMovie, "Spinner")
	v40:SetActive(v21)
	_T.MadeProjectionChoice = false
	_T.CurrencyBar_ExtraCurrency = currencyBar_ExtraCurrency
	_T.CurrencyBar_ExtraCurrencyMax = module4.GetMaxVoidTrace()
	uiInputEnabled = not _T.UIInputEnabled
	local topMenuMovie = _T.TopMenuMovie

	if _T.TopMenuOpen and not __wf_atom_7e8ad928(topMenuMovie) then
		topMenuMovie:Execute("SkipDisableInputOnClose", "true")
		topMenuMovie:Execute("Close", "")
		uiInputEnabled = _T.UIInputEnabled
	end

	_T.DebugThemedProjectionManagerToggleInput = uiInputEnabled

	if uiInputEnabled then
		if _T.EnableUIInput == nil then
			v18 = true
		else
			_T.EnableUIInput()
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:StartTimer(Symbol("IN_SHIP_VIEW_TIME"), "EQUIPMENT_REFINEMENT")
	end

	v17 = module7.Create(mMovie)
	v17:Register(mMovie, "InventorySelector", { v17.ANCHOR_V_TOP, v17.ANCHOR_H_LEFT })
	v17:Register(mMovie, "Upgrader", { v17.ANCHOR_V_TOP, v17.ANCHOR_H_RIGHT })
	v17:Register(mMovie, "GridBounds", { v17.ANCHOR_V_BOTTOM, v17.ANCHOR_H_RIGHT })
	mMovie:__wf_atom_e57658c2("Upgrader", 12, 0)
	mMovie:__wf_atom_e57658c2("InventorySelector", 12, 0)
	mMovie:__wf_atom_2dedec1a("GridBounds", 13, false)
	mMovie:OverrideMaterial("Upgrader.Main.Backer", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Left.SingleLoom01", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Left.SingleLoom02", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Left.SingleLoom03", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Left.SingleLoom04", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Right.SingleLoom01", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Right.SingleLoom02", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Right.SingleLoom03", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Main.Loom.Right.SingleLoom04", linesMaterial)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain01", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain02", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain03", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain04", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain05", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain06", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain07", _G.UIMaterial_VitruvianLines)
	mMovie:OverrideMaterial("Upgrader.Anim.Relic.Loom.StraightLoomMain08", _G.UIMaterial_VitruvianLines)

	for i = 1, 3 do
		local v55 = "Upgrader.Main.RarityBars.RarityBar" .. i .. ".Backer"
		mMovie:__wf_atom_e57658c2(v55, 100, i)
		mMovie:SetCallbacks(v55, "RarityBarFocused", "RarityBarUnfocused", "RarityBarReleased", "RarityBarPressed")
	end

	mMovie:SetFrameCallback("Upgrader.Anim.Relic.Loom", "OnFrameEnter")
	module3.InitializeProfileIconList()
	v25 = {}

	if not __wf_atom_7e8ad928(gGameData) then
		local inventory = gGameData:GetInventory()
		module3.AddTableToPurchasedItems(v25, inventory:GetUpgrades())
		module3.AddTableToPurchasedItems(v25, inventory:__wf_atom_063f1444())
		module3.AddTableToPurchasedItems(v25, inventory:__wf_atom_49479502())
	end

	v41 = module3.GetStarChartNodes()
	fn41()
	fn39()
	fn40()
	fn26()
	fn38()
	fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	fn14()
	fn20({ Filler = true, IsNone = true })
	fn5()

	if v30 then
		fn4()
		linesMaterial:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0.1)
		module3.RegisterHideHud(true)
	else
		if not __wf_atom_7e8ad928(_T.ShowBackground) then
			_T.ShowBackground(0.25, nil, false)
		end

		local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
		local menuSuitAvatar

		if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
			menuSuitAvatar = _T.MenuSuitAvatar or __wf_atom_eab484a7:__wf_atom_50a7d83e()

			if not (__wf_atom_7e8ad928(menuSuitAvatar) or menuSuitAvatar:IsVisible()) then
				menuSuitAvatar = __wf_atom_eab484a7:__wf_atom_04b7536b()
			end
		end

		if not __wf_atom_7e8ad928(menuSuitAvatar) and menuSuitAvatar:IsVisible() then
			menuSuitAvatar:SetVisibility(false)
			_T.ProjectionManagerAvatar = menuSuitAvatar
		end
	end

	flag = false
end

function CountdownDone()
	flag4 = true
	flag = true

	if not v34 then
		fn11(4)
	end
end

function StartCloseTimer()
	flag = true

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	if not __wf_atom_7e8ad928(v38) then
		v38:Execute("SetCountdown", "0")
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	__wf_atom_8e4fda44:__wf_atom_8b74c30b(rewardChoiceMovie)
	__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5, 0, fn7)
end

local function fn42(p)
	v49.Timer += p

	if v49.Timer > v49.TransitionTime then
		v49.LastX = v49.TargetX
		v49.LastY = v49.TargetY
		v49.Timer = 0
		v49.TargetX = Random(v49.MaxMovement, -v49.MaxMovement) - 275
		v49.TargetY = Random(v49.MaxMovement, -v49.MaxMovement) - 15
	end

	local v55 = v49.Timer / v49.TransitionTime
	local v56 = v49.TargetX - v49.LastX
	mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 0, -v56 / 2 * (math.cos(3.1415927410125732 * v55) - 1) + v49.LastX)
	local v57 = v49.TargetY - v49.LastY
	mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 1, -v57 / 2 * (math.cos(3.1415927410125732 * v55) - 1) + v49.LastY)
end

local function fn43()
	v39 = true
	_T.ProjectionMoviePickerOpen = true

	if _T.HideMoneyOverlay then
		flag3 = true
		_T.HideMoneyOverlay = false
	end

	__wf_atom_ec43d06e(mMovie, "Upgrader", 8, { 12 }, { 100 }, 0.5)
	__wf_atom_ec43d06e(mMovie, "InventorySelector", 8, { 12 }, { 100 }, 0.5)

	if v30 then
		if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
			_T.SetSquadOverlayTitle()
			_T.SetSquadOverlayTitle(
				mMovie:__wf_atom_8e9ac384(
					v30 and "/Lotus/Language/Objectives/VoidFissureTitle" or "/Lotus/Language/Menu/Menu_Projections",
					false
				),
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_SelectProjection", false)
			)
		end

		v38 = mMovie:PushChildMovie(countdownMovie)

		if not __wf_atom_7e8ad928(v38) then
			v38:Execute("SetCountdown", "20,CountdownDone")
		end

		v38:Execute("SetPosition", 1385 .. "," .. 225 .. "," .. v17.ANCHOR_V_TOP .. "," .. v17.ANCHOR_H_RIGHT)
	elseif not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Menu_Projections", false),
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ProjectionManager_EnhancementsTitle", false)
		)
	end

	fn6()
end

function Update()
	if v46 and mMovie == __wf_atom_8e4fda44:__wf_atom_1dca1cfb() then
		fn7()
		v46 = false
	end

	local v55 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v55)
	fn42(v55)
	local v56 = not v26 and __wf_atom_8e4fda44:FindMovie(defenseRewardMovie) == nil
	mMovie:SetVisible(v56)

	if v56 and not (v39 or v21) then
		fn43()
	end

	if not __wf_atom_7e8ad928(v40) then
		v40:Update()
	end

	if v18 and _T.EnableUIInput ~= nil then
		v18 = false
		_T.EnableUIInput()
	end

	if v21 and not __wf_atom_7e8ad928(v22) and v22:__wf_atom_86399a47() then
		fn13()
	end

	if flag4 then
		v47 -= v55
	end

	if v30 and not (__wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gGameRules)) then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		if #__wf_atom_3c8e1a7a ~= v35 then
			v35 = #__wf_atom_3c8e1a7a
			v36 = #gGameRules:__wf_atom_ccaf9d5c()
		end

		if not v32 and gRegion:IsMaster() then
			local __wf_atom_556a8e54 = gGameRules:__wf_atom_556a8e54()

			if v36 <= __wf_atom_556a8e54 then
				print("We got all the votes so we can close now!")
				gGameRules:__wf_atom_10079e4d()
				v32 = true
			elseif v47 < 0 then
				print("Some players failed to respond! Got " .. gGameRules:__wf_atom_556a8e54() .. "/" .. gRegion:__wf_atom_577a4d19())

				for i = 1, #v6.mElements do
					if v6.mElements[i].Relic == nil then
						v6.mElements[i].Name = Localize("/Lotus/Language/Menu/ProjectionManager_NoRelic", {})
					end
				end

				gGameRules:__wf_atom_10079e4d()
				v32 = true
			end
		end
	end

	v43.x = (v55 / 2 + v43.x) % 1
	v43.y = (-v55 / 40 + v43.y) % 1
	module6.UpdateRarityBar(mMovie, "Upgrader.Main.RarityBars.RarityBar" .. 1, v43)
	module6.UpdateRarityBar(mMovie, "Upgrader.Main.RarityBars.RarityBar" .. 2, v43)
	module6.UpdateRarityBar(mMovie, "Upgrader.Main.RarityBars.RarityBar" .. 3, v43)
end

local function fn44(p, p2)
	mMovie:__wf_atom_e57658c2(
		"Upgrader.Anim.CopiedRank",
		0,
		mMovie:__wf_atom_5e6e15c8(p, 0) + mMovie:__wf_atom_5e6e15c8("Upgrader.Main.RankList", 0)
	)
	mMovie:__wf_atom_e57658c2(
		"Upgrader.Anim.CopiedRank",
		1,
		mMovie:__wf_atom_5e6e15c8(p, 1) + mMovie:__wf_atom_5e6e15c8("Upgrader.Main.RankList", 1)
	)
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.CopiedRank.Glow", 11, mMovie:__wf_atom_5e6e15c8(p .. ".Glow", 11))
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.CopiedRank.Arrow", 11, mMovie:__wf_atom_5e6e15c8(p .. ".Arrow", 11))
	mMovie:__wf_atom_50d60589("Upgrader.Anim.CopiedRank.Desc", 46, mMovie:__wf_atom_387f260e(p .. ".Desc", 46))
	mMovie:__wf_atom_50d60589("Upgrader.Anim.CopiedRank.Desc", 36, mMovie:__wf_atom_387f260e(p .. ".Desc", 36))
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.CopiedRank.Backer", 15, mMovie:__wf_atom_5e6e15c8(p .. ".Backer", 15))
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.CopiedRank.Gradient", 15, mMovie:__wf_atom_5e6e15c8(p .. ".Gradient", 15))
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.CopiedRank.Line", 13, false)
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.CopiedRank.Check", 13, false)
	mMovie:__wf_atom_c90af43a("Upgrader.Anim.CopiedRank.Glow", glowIcon)
	mMovie:__wf_atom_c90af43a("Upgrader.Anim.CopiedRank.Icon", baseUpgradeIcon)
	mMovie:__wf_atom_c90af43a("Upgrader.Anim.CopiedRank.RankIcon", rankIcons[p2 - 1])
	mMovie:OverrideMaterial("Upgrader.Anim.CopiedRank.IconBacker", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial("Upgrader.Anim.CopiedRank.Backer", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_933bbce0("Upgrader.Anim.CopiedRank.Gradient", backerIcon, _G.UIMaterial_RectangleNoDepth)
end

local function fn45()
	module.PlaySound(installSuccessSound)

	if v30 then
		upgradeFx = upgradeFxInGame
	end

	if not __wf_atom_7e8ad928(upgradeFx) then
		local rootBasedPosition, v55 = module3.GetRootBasedPosition(mMovie, "Upgrader.Main.Icon")
		local screenParticles = module3.CreateScreenParticles(
			mMovie,
			upgradeFx,
			rootBasedPosition,
			v55,
			__wf_atom_392793db
		)
		module3.ApplyParticleThemeColors(screenParticles)
	end

	if v23 ~= nil then
		fn14()
	end
end

local function fn46(p)
	v23 = p

	if v30 or _T.TestProjectionSquad then
		fn45()
		return
	end

	module.PlaySound(installStartSound)
	local v55 = quality2 + 1
	local v56 = "Upgrader.Main.RankList.Rank" .. v55
	local v57 = mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Icon", 14) / mMovie:__wf_atom_5e6e15c8("Upgrader.Anim.Relic.Icon", 14) * 100
	fn44(v56, v55)
	mMovie:__wf_atom_2dedec1a(v56, 13, false)
	mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 12, 0)
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.CopiedRank", 13, true)
	mMovie:__wf_atom_2dedec1a("Upgrader.Anim.Relic", 13, true)
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic", 5, v57)
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic", 6, v57)
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic", 1, mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Icon", 1))
	mMovie:__wf_atom_e57658c2("Upgrader.Anim.Relic", 0, mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Icon", 0))
	__wf_atom_ec43d06e(mMovie, "Upgrader.Anim.CopiedRank", 2, { 0, 1 }, { -275, 500 }, 0.5)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Main", 2, { 12 }, { 0 }, 0.5, 0, function()
		mMovie:__wf_atom_2dedec1a(v56, 13, true)
	end)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Anim.Relic", 6, { 0, 1, 5, 6 }, { -275, 200, 100, 100 }, 0.5, 0, function()
		__wf_atom_86cbd68d(mMovie, "Upgrader.Anim.Relic.Loom.gotoAndPlay", 1)
	end)
end

local function fn47()
	module.PlaySound(installSuccessSound)
	local v55 = mMovie:__wf_atom_5e6e15c8("Upgrader.Main.Icon", 14) / mMovie:__wf_atom_5e6e15c8("Upgrader.Anim.Relic.Icon", 14) * 100

	if v30 then
		upgradeFx = upgradeFxInGame
	end

	if not __wf_atom_7e8ad928(upgradeFx) then
		local rootBasedPosition, v56 = module3.GetRootBasedPosition(mMovie, "Upgrader.Anim.Relic")
		local screenParticles = module3.CreateScreenParticles(
			mMovie,
			upgradeFx,
			rootBasedPosition,
			v56,
			__wf_atom_392793db
		)
		module3.ApplyParticleThemeColors(screenParticles)
	end

	if v23 ~= nil then
		fn14()
	end

	__wf_atom_ec43d06e(mMovie, "Upgrader.Main", 2, { 12 }, { 100 }, 0.3, 0.5)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Anim.Relic", 6, { 0, 1, 5, 6 }, { -275, -15, v55, v55 }, 0.3, 0.5, function()
		mMovie:__wf_atom_2dedec1a("Upgrader.Anim.Relic", 13, false)
		mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 12, 100)
		mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 0, -275)
		mMovie:__wf_atom_e57658c2("Upgrader.Main.Icon", 1, -15)
		v49.LastX = -275
		v49.LastY = -15
		v49.Timer = 0
	end)
	__wf_atom_ec43d06e(mMovie, "Upgrader.Anim.CopiedRank", 2, { 12 }, { 0 }, 0.3, 0.5, function()
		mMovie:__wf_atom_2dedec1a("Upgrader.Anim.CopiedRank", 13, false)
		mMovie:__wf_atom_e57658c2("Upgrader.Anim.CopiedRank", 12, 100)
	end)
end

function RankUpRelic()
	if not v10:IsActive() then
		return
	end

	v10:SetVisible(false)
	v9:SetVisible(true)
	v8:SetVisible(false)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.RankList", 13, true)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.VoidTrace", 13, true)
	fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), 0.2)
	fn6()
end

local function fn48()
	if _T.TestUpgradeAnim then
		fn46()
		return
	end

	if flag or __wf_atom_7e8ad928(gGameData) or v5 == nil or v37 == nil then
		return
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		print("ERROR: No inventory!")
		assert(false)
	end

	local total = 0

	for i = quality + 1, quality2 do
		total += v51[i]
	end

	local __wf_atom_c84817dd = inventory:__wf_atom_c84817dd()
	local mItemCount = 0

	for _, v56 in pairs(__wf_atom_c84817dd) do
		if not v56.mItemType:IsA(currencyBar_ExtraCurrency) then
			continue
		end

		mItemCount = v56.mItemCount
		break
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v50[quality2 + 1], true)

	if mItemCount < total then
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ProjectionManager_InsufficientLuminous",
			true,
			{
				RARITY = __wf_atom_8e9ac384,
				NEEDED = tostring(total - mItemCount)
			}
		)
		module.ShowMessage(__wf_atom_8e9ac384_2)
	else
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ProjectionManager_UpgradeProjectionConfirm",
			true,
			{ NAME = v37.Name, QUALITY = __wf_atom_8e9ac384, COST = total }
		)
		module.ShowYesOrNoMessage(__wf_atom_8e9ac384_2, "OnConfirmUpgradeProjection")
	end
end

function OnConfirmUpgradeProjection(p)
	if tonumber(p) == 4 then
		flag = true

		if not __wf_atom_7e8ad928(gGameData) then
			gGameData:__wf_atom_9ca71f38(v37.Type:__wf_atom_5b41f63b(), quality2, "OnUpgradeProjection")
		end

		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	end
end

function OnUpgradeProjection(p, p2)
	flag = false
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		fn46(WeakResource(p2))
	else
		module.ShowMessage("/Lotus/Language/Menu/ProjectionManager_UpgradeProjectionFailed")
	end
end

function SquadFocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:FocusElementById((tonumber(p)))
	end
end

function SquadUnfocused(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:UnfocusElementById((tonumber(p)))
	end
end

function SquadSelected(p)
	if not __wf_atom_7e8ad928(v6) then
		v6:SelectElementById(tonumber(p), true)
	end
end

function RewardFocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:FocusElementById((tonumber(p)))
	end
end

function RewardUnfocused(p)
	if not __wf_atom_7e8ad928(v7) then
		v7:UnfocusElementById((tonumber(p)))
	end

	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
end

function RewardSelected(_) end

function InventoryItemFocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:FocusElementById((tonumber(p)))
	end
end

function InventoryItemUnfocused(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:UnfocusElementById((tonumber(p)))
	end

	_T.InfoPopup_Data = nil
	_T.InfoPopup_Grid = nil
end

function InventoryItemSelected(p)
	if not __wf_atom_7e8ad928(v5) then
		v5:SelectElementById(tonumber(p), true)
	end
end

local function fn49(rarityChances)
	local clipName = "Upgrader.Main.RankList.Rank" .. v15
	local v56 = {
		CustomEntry = true,
		ClipName = clipName,
		Name = mMovie:__wf_atom_8e9ac384(v50[v15], true),
		Description = v50[v15] .. "_Desc",
		RarityChances = rarityChances
	}
	local total = 0

	for i = quality + 1, v15 - 1 do
		total += v51[i]
	end

	if total > 0 then
		v56.CalloutOverride = total .. "<LUMINOUS>"
	end

	module6.SetItemInfoPopupRect(
		mMovie,
		v56,
		mMovie:__wf_atom_5e6e15c8(clipName .. ".IconBacker", 2),
		mMovie:__wf_atom_5e6e15c8(clipName .. ".IconBacker", 3),
		88,
		88
	)
	return v56
end

local function fn50(p)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Icon.GlowRings.Ring" .. 1, 13, p >= 1 or quality >= 1)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Icon.GlowRings.Ring" .. 2, 13, p >= 2 or quality >= 2)
	mMovie:__wf_atom_2dedec1a("Upgrader.Main.Icon.GlowRings.Ring" .. 3, 13, p >= 3 or quality >= 3)
end

function OnFrameEnter(_, p)
	if p == "UpgradeLoomAnimComplete" then
		fn47()
	end
end

function RankElementFocused(p)
	local v55 = tonumber(p)

	if v55 ~= nil then
		module.PlaySound(_G.UISound_Focus)
		v15 = v55 + 1
		fn16(v55)
		fn50(v55)
		local rarityChances = fn2(v55)
		_T.InfoPopup_Data = fn49(rarityChances)
	end
end

function RankElementUnfocused(p)
	local v55 = tonumber(p)

	if v55 ~= nil and v15 ~= nil then
		if v15 == v55 + 1 then
			v15 = nil
		end

		fn16(v55)
		fn50(quality2)
		fn2(quality2)
		_T.InfoPopup_Data = nil
		_T.InfoPopup_Grid = nil
	end
end

function RankElementPressed(p)
	local v55 = tonumber(p)
	local v56 = quality2

	if v55 == nil then
		v55 = v56
	elseif v55 < quality then
		v55 = quality
	end

	if quality2 ~= v55 then
		quality2 = v55
		fn20(v37)

		if quality2 == v55 then
			module.PlaySound(_G.UISound_ButtonSelect)
		end
	end
end

function CategoryFocused(p)
	if v5 == nil or v5.mCategoryMenu == nil then
		return
	end

	v5.mCategoryMenu:FocusElementById((tonumber(p)))
end

function CategoryUnfocused(p)
	if v5 == nil or v5.mCategoryMenu == nil then
		return
	end

	v5.mCategoryMenu:UnfocusElementById((tonumber(p)))
end

function CategoryPressed(p)
	if flag or v5 == nil or v5.mCategoryMenu == nil then
		return
	end

	v5.mCategoryMenu:SelectElementById(tonumber(p), true)
end

function SortByFocused(p)
	if not __wf_atom_7e8ad928(v5.mSortMenu) then
		v5.mSortMenu:FocusElementById((tonumber(p)))
	end
end

function SortByUnfocused(p)
	if not __wf_atom_7e8ad928(v5.mSortMenu) then
		v5.mSortMenu:UnfocusElementById((tonumber(p)))
	end
end

function SortByPressed(p)
	if not (flag or __wf_atom_7e8ad928(v5.mSortMenu)) then
		v5.mSortMenu:SelectElementById(tonumber(p), true)
	end
end

function RarityBarFocused(p)
	_T.gToolTip = TitleCase(mMovie:__wf_atom_8e9ac384(v48[tonumber(p)], false))
end

function RarityBarUnfocused(_)
	_T.gToolTip = nil
end

function onKeyDown_MENU_LTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v5)) then
		v5:PreviousCategory()
	end

	return true
end

function onKeyDown_MENU_RTRIGGER2()
	if not (flag or __wf_atom_7e8ad928(v5)) then
		v5:NextCategory()
	end

	return true
end

function onKeyUp_MENU_SELECT()
	if v5.mSortMenu.mVisible then
		v5.mSortMenu:SelectCurrentElement()
	end
end

function onKeyUp_MENU_CANCEL()
	if not (flag or __wf_atom_7e8ad928(v5) or v5:onKeyUp_MENU_CANCEL()) then
		fn9()
	end
end

function onKeyDown_MENU_GENERIC1()
	if v8.mIsVisible then
		if v8:IsActive() then
			fn12()
		end
	elseif v9:IsActive() then
		fn48()
	end
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if flag then
		return
	end

	local mScrollBar

	if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5.mScrollBar)) then
		mScrollBar = v5.mScrollBar
	end

	if not __wf_atom_7e8ad928(mScrollBar) then
		mScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end

	return false
end

function SetExclusiveTier(p, p2)
	if v39 and not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end

	v27 = WeakResource(p)
	flag2 = true
	v39 = false
	v28 = p2

	if not __wf_atom_7e8ad928(_T.AcceptInvitePanel) then
		_T.AcceptInvitePanel:SetVisible(false)
		_T.AcceptInvitePanel:__wf_atom_b4ffb30f(false)
	end

	for i = #v5.mUnfilteredCategories, 1, -1 do
		if v5.mUnfilteredCategories[i].BaseTierType ~= v27 then
			table.remove(v5.mUnfilteredCategories, i)
		end
	end

	fn14()
	fn20(v37)
end

function OnGamepadTransition(_)
	if not __wf_atom_7e8ad928(v10) then
		v10:Redraw()
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Redraw()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Redraw()
	end

	fn6()
end

function SupportsThemes()
	return true
end

function OnStyleChangedCallback()
	fn5()

	if not (v30 or __wf_atom_7e8ad928(_T.ShowBackground)) then
		_T.ShowBackground()
	end
end

function DisableInput()
	v18 = true
	uiInputEnabled = true
	_T.DebugThemedProjectionManagerToggleInput = uiInputEnabled
end

function HideScreenForPlatPurchase(p)
	v26 = p == "true"

	if not v26 then
		fn3(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end