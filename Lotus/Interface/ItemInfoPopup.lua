local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.Components.StatCompare")
local module7 = require("Lotus.Interface.CodexUtilities")
local module8 = require("Lotus.Interface.LoadoutUtilities")
local module9 = require("Lotus.Interface.ModularWeaponUtilities")
local module10 = require("Lotus.Interface.CardUtilitiesRedux")
local module11 = require("Lotus.Interface.SyndicateUtilities")
local module12 = require("Lotus.Scripts.Libs.CrewMemberUtilities")
Type("/SF/Types/Game/HealthShieldDisplay")
local v = false
local v2 = nil
local v3 = nil
local v4 = {
	PreviousX = nil,
	PreviousY = nil,
	CurrentX = nil,
	CurrentY = nil,
	TargetX = nil,
	TargetY = nil
}
local v5 = 0
local v6 = 0
local v7 = 0
local v8 = 0
local v9 = ""
local v10 = ""
local tags = {}
local v11 = 0
local total = 10
local v12 = 1
local statId = 1
local v13 = 0
local v14 = 1
local mDisplayStats = { Labels = 0, Values = 0, BaseValues = 0, StatChanges = 0 }
mDisplayStats.Labels = {}
mDisplayStats.Values = {}
mDisplayStats.BaseValues = {}
mDisplayStats.StatChanges = {}
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = false
local v21 = nil
local resultItemType = nil
local v22 = false
local v23 = nil
local v24 = nil
local v25 = {}
local v26 = true
local v27 = { x = 0, y = 0 }
local v28 = nil
local v29 = false
local v30 = nil
local flag = true
local v31 = ""
local v32 = ""
local v33 = {}
local v34 = false
local state = nil
local v35 = {
	BASE = 1,
	INFO = 2,
	ABILITIES = 3,
	STATS = 4,
	CRAFTING = 5
}
local fn
local fn2
local fn3

local function fn4()
	if not v34 then
		v34 = true

		if not flag then
			v18:RemoveTimer(v17)
			_T.ItemInfoPopupCount = (_T.ItemInfoPopupCount or 1) - 1
		end

		if v20 then
			fn2(false)
		end

		v21 = nil
		v4.TargetX = nil
		v4.TargetY = nil
		__wf_atom_ec43d06e(mMovie, "Popup", 2, { 12 }, { 0 }, 0.34, 0, function()
			mMovie:__wf_atom_3f8dd1de("Popup.VideoPreview.Image")
			mMovie:__wf_atom_c90af43a("Popup.VideoPreview.Image", nil)
			mMovie:SetVisible(false)

			if not flag then
				mMovie:Close()
			end
		end)
	end
end

function OnProfileSaved() end

local function fn5(p, p2, p3, p4)
	local v36

	if v2 == nil then
		v36 = false
	else
		v36 = not v2.ModdedStats

		if v36 then
			if p3 == 0 then
				v36 = false
			else
				v36 = p2 ~= nil
			end
		end
	end

	local v37 = p4 == true or p3 == nil

	if v36 then
		p = mMovie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. p
	end

	if not v37 then
		if p3 < 0 then
			p = "<font color=\"" .. v33.NegativeHex .. "\">" .. p .. "</font>"
		elseif p3 > 0 then
			p = "<font color=\"" .. v33.PositiveHex .. "\">" .. p .. "</font>"
		end
	end

	if v36 then
		p = p2 .. p
	end

	return p
end

local function fn6()
	if not __wf_atom_7e8ad928(mMovie) then
		local bonusStats = mDisplayStats.BonusStats

		if bonusStats ~= nil then
			local statChanges = bonusStats.StatChanges
			local v36 = ""

			for i = 1, #bonusStats.Labels do
				if #v36 > 0 then
					v36 ..= "\r\n"
				end

				local v37

				if statChanges ~= nil then
					v37 = statChanges[i]
				end

				local v38 = fn5(bonusStats.Values[i], nil, v37)
				local v39 = string.gsub(v38, "%%", "%%%0")
				v36 ..= string.gsub(bonusStats.Labels[i], "%[STAT%]", v39)
			end

			local v37

			if state == v35.STATS or v11 == 0 then
				v37 = v9
			else
				v37 = string.sub(v9, 1, v11) .. "\r\n\r\n" .. v36 .. string.sub(v9, v11 + 1)
			end

			mMovie:__wf_atom_50d60589(
				"Popup.Description",
				36,
				"<p><font color=\"" .. v33.ContentHex .. "\">" .. v37 .. "</font></p>"
			)
		end

		for i = 1, v13 do
			local v36 = "Popup.ItemStats.Item" .. i
			mMovie:__wf_atom_4c1c1986(v36, "Backer", 11, v33.Background1)
			local label = mDisplayStats.Labels[i]

			if label == nil then
				continue
			end

			if mDisplayStats.Values[i] == "" then
				local v37 = "<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. label .. "</font></p>"
				mMovie:__wf_atom_50d60589(v36 .. ".Labels", 36, v37)
			else
				local v37 = "<p><font color=\"" .. v33.FloatingContentHex .. "\">" .. label .. "</font></p>"
				mMovie:__wf_atom_50d60589(v36 .. ".Labels", 36, v37)
				local v38 = "<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. fn5(
					mDisplayStats.Values[i],
					mDisplayStats.BaseValues[i],
					mDisplayStats.StatChanges[i]
				) .. "</font></p>"
				mMovie:__wf_atom_50d60589(v36 .. ".Stats", 36, v38)
			end
		end
	end
end

local v36 = nil

local function fn7()
	local convertColorNumberToProceduralRGB = module3.ConvertColorNumberToProceduralRGB(module4.GetColor(3, true, v36))
	v33.Background1 = module4.GetColor(2, true, v36)
	v33.Background1RGB = module3.ConvertColorNumberToProceduralRGB(v33.Background1)
	v33.Background4Hex = module3.ConvertColorNumberToHex(module4.GetColor(5, true, v36))
	v33.BackerHighlightRGB = module3.ConvertColorNumberToProceduralRGB(module4.GetColor(1, true, v36))
	v33.Content = module4.GetColor(6, true, v36)
	v33.ContentHex = module3.ConvertColorNumberToHex(v33.Content)
	v33.FloatingContent = module4.GetColor(9, true, v36)
	v33.FloatingContentHex = module3.ConvertColorNumberToHex(v33.FloatingContent)
	v33.FloatingContentRGB = module3.ConvertColorNumberToProceduralRGB(v33.FloatingContent)
	v33.FloatingContentHighlight = module4.GetColor(10, true, v36)
	v33.FloatingContentHighlightHex = module3.ConvertColorNumberToHex(v33.FloatingContentHighlight)
	v33.FloatingContentHighlightRGB = module3.ConvertColorNumberToProceduralRGB(v33.FloatingContentHighlight)
	v33.Positive = module4.GetColor(11, true, v36)
	v33.PositiveHex = module3.ConvertColorNumberToHex(v33.Positive)
	v33.PositiveRGB = module3.ConvertColorNumberToProceduralRGB(v33.Positive)
	v33.Negative = module4.GetColor(12, true, v36)
	v33.NegativeHex = module3.ConvertColorNumberToHex(v33.Negative)
	v33.NegativeRGB = module3.ConvertColorNumberToProceduralRGB(v33.Negative)
	mMovie:__wf_atom_1ca72041(
		"Popup.Bg",
		"StartColor",
		v33.Background1RGB.r,
		v33.Background1RGB.g,
		v33.Background1RGB.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Popup.Bg",
		"EndColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		0.95
	)

	if v32 == "" then
		mMovie:__wf_atom_1ca72041(
			"Popup.TitleBg",
			"RectEdgeColor",
			v33.BackerHighlightRGB.r,
			v33.BackerHighlightRGB.g,
			v33.BackerHighlightRGB.b,
			0.2
		)
	else
		mMovie:__wf_atom_1ca72041("Popup.TitleBg", "RectEdgeColor", 0, 0, 0, 0)
	end

	mMovie:__wf_atom_1ca72041(
		"Popup.TitleBg",
		"RectInnerColor",
		v33.Background1RGB.r,
		v33.Background1RGB.g,
		v33.Background1RGB.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Popup.Header.Bg",
		"RectEdgeColor",
		v33.BackerHighlightRGB.r,
		v33.BackerHighlightRGB.g,
		v33.BackerHighlightRGB.b,
		0.2
	)
	mMovie:__wf_atom_1ca72041(
		"Popup.Header.Bg",
		"RectInnerColor",
		v33.Background1RGB.r,
		v33.Background1RGB.g,
		v33.Background1RGB.b,
		1
	)
	mMovie:__wf_atom_1ca72041("Popup.Header.Fade", "RectEdgeColor", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041(
		"Popup.Header.Fade",
		"RectInnerColor",
		v33.FloatingContentRGB.r,
		v33.FloatingContentRGB.g,
		v33.FloatingContentRGB.b,
		0.4
	)
	mMovie:__wf_atom_e57658c2("Popup.Header.Label", 11, v33.FloatingContentHighlight)

	if state == v35.BASE and v2 ~= nil then
		mMovie:__wf_atom_50d60589(
			"Popup.Description",
			36,
			"<p><font color=\"" .. v33.ContentHex .. "\">" .. v9 .. "</font></p>"
		)
		local infoPopup_Grid = _T.InfoPopup_Grid
		local _, v37 = module2.GetGridItemName(mMovie, infoPopup_Grid, v2, v2.MetaData)
		tags = module2.GetGridItemTags(mMovie, infoPopup_Grid, v2, v2.MetaData, v37)
		local v38 = 1

		for _, v39 in ipairs(tags) do
			if v39.ExcludeFromInfoPopup then
				continue
			end

			local clipName
			clipName, v38 = module2.GetPriceLabelClip(mMovie, "Popup", v38)
			v39.FitText = true
			v39.MaxWidth = v7 - total
			module2.DrawPriceLabel(mMovie, clipName, v39)
			v39.ClipName = clipName
		end
	end

	local v37 = { "AbilityInfo.Passive.Description", "Subtitle" }
	table.insert(v37, "AbilityInfo.Ability" .. tostring(1) .. ".Description")
	table.insert(v37, "AbilityInfo.Ability" .. tostring(2) .. ".Description")
	table.insert(v37, "AbilityInfo.Ability" .. tostring(3) .. ".Description")
	table.insert(v37, "AbilityInfo.Ability" .. tostring(4) .. ".Description")

	for i = 1, #v37 do
		mMovie:__wf_atom_4c1c1986("Popup", v37[i], 11, v33.Content)
	end

	local v38 = {}

	for i = 1, #v38 do
		mMovie:__wf_atom_4c1c1986("Popup", v38[i], 11, v33.FloatingContent)
	end

	local v39 = {
		"InfoToggle",
		"TagSeparator",
		"PreviewTag",
		"PreviewCallout",
		"AbilityInfo.Passive.Name",
		"AbilityInfo.PassiveSeparator",
		"AbilityInfo.Passive.Icon",
		"PrereqSeparator.Separator",
		"IngredientsSeparator.Separator"
	}

	for i = 1, 4 do
		table.insert(v39, "AbilityInfo.Ability" .. tostring(i) .. ".Name")
		table.insert(v39, "AbilityInfo.Ability" .. tostring(i) .. ".Icon")
	end

	for i = 1, #v39 do
		mMovie:__wf_atom_4c1c1986("Popup", v39[i], 11, v33.FloatingContentHighlight)
	end

	if not __wf_atom_7e8ad928(v30) then
		v30:RunForAllElements(function(p)
			v30.UpdateColor(p.mClipName)
		end)
	end

	mMovie:__wf_atom_50d60589(
		"Popup.Title",
		36,
		"<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v10 .. "</font></p>"
	)

	if not __wf_atom_7e8ad928(_T.ItemInfoStatComparison) then
		if flag then
			_T.ItemInfoStatComparison()
		else
			_T.ItemInfoStatComparison(mDisplayStats, fn6)
		end
	end

	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.Trait.Desc", 11, v33.Content)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.Trait.Icon", 11, v33.FloatingContent)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Faction", 11, v33.Content)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Rank", 44, v33.Content)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Separator", 11, v33.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Name", 44, v33.FloatingContent)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Rank", 44, v33.FloatingContentHighlight)
end

local function fn8()
	local module13 = require("EE.Interface.Components.List")
	v3 = module13.CreateList(mMovie, "Popup.InfoToggle.List.Dot")
	v3.mForcedHorizontalSeparation = 14
	v3.mForcedVerticalSeparation = 0

	function v3.mElementDrawCallback(p)
		if p.mClipName == nil then
			return
		end

		local v37 = v3.mSelectedElement ~= nil and v3.mSelectedElement.Id == p.Id
		__wf_atom_86cbd68d(mMovie, p.mClipName .. ".gotoAndStop", module3.Ternary(v37, "Selected", "Unfocused"))
	end

	function v3.mOnSelectedCallback(p)
		state = p.State
		statId = p.StatId

		if
			state == v35.BASE and not v2.AllInOne and v2.Category ~= 43 and v2.Category ~= 46
			or not __wf_atom_7e8ad928(v21)
		then
			fn()
		else
			local v37 = {}

			if not __wf_atom_7e8ad928(resultItemType) then
				table.insert(v37, resultItemType:__wf_atom_5b41f63b())
			end

			if not __wf_atom_7e8ad928(v2.mExtraAbility) then
				table.insert(v37, v2.mExtraAbility:__wf_atom_5b41f63b())
			end

			if #v37 > 0 then
				v21 = UISys.__wf_atom_c0dbe47c(v37, true)
				fn2(true)
			end
		end

		v3:RunForAllElements(function(p2)
			v3.mElementDrawCallback(p2)
		end)
	end
end

local function fn9()
	local calloutOverride = module3.Ternary(Engine.__wf_atom_5df63302(), "<MENU_RTRIGGER1>", "<NEXT_MENU>")
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
		module3.Ternary(Engine.IsPlayingWithController(), "<MENU_RTHUMB>", "<MENU_RIGHT_CLICK>"),
		true
	)
	local previewTagOverride = "/Lotus/Language/OstronCrafting/Crafting_Preview_NoIcon"

	if v2 ~= nil then
		if v2.PreviewTagOverride == nil then
			previewTagOverride = v2.mUnequipItem ~= nil and "/Lotus/Language/Menu/Loadout_Remove" or previewTagOverride
		else
			previewTagOverride = v2.PreviewTagOverride
		end

		if v2.PreviewCalloutFunction ~= nil then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v2.PreviewCalloutFunction(), true)
		end

		if v2.CalloutOverride ~= nil then
			calloutOverride = v2.CalloutOverride
		end
	end

	mMovie:__wf_atom_50d60589("Popup.PreviewCallout", 36, __wf_atom_8e9ac384)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.PreviewCallout", 40)
	mMovie:__wf_atom_50d60589("Popup.PreviewTag", 36, (mMovie:__wf_atom_8e9ac384(previewTagOverride, false)))
	local v37 = mMovie:__wf_atom_5e6e15c8("Popup.PreviewTag", 40) + 5
	mMovie:__wf_atom_e57658c2("Popup.PreviewTag", 0, v7 - v37)
	mMovie:__wf_atom_e57658c2("Popup.PreviewCallout", 0, v7 - (v37 + __wf_atom_5e6e15c8 + 5))
	mMovie:__wf_atom_7d7314f1("Popup.InfoToggle.Callout.text", calloutOverride)
end

local function fn10()
	local howManyElements = v3:GetHowManyElements()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.InfoToggle.Callout", 40)
	mMovie:__wf_atom_e57658c2(
		"Popup.InfoToggle.List",
		0,
		-(howManyElements * v3.mForcedHorizontalSeparation + __wf_atom_5e6e15c8 + 5)
	)
	local v37 = howManyElements > 1
	local v38 = v2 ~= nil and v2.CalloutOverride ~= nil
	mMovie:__wf_atom_2dedec1a("Popup.InfoToggle", 13, v37 or v38)
	mMovie:__wf_atom_2dedec1a("Popup.InfoToggle.List", 13, v37)
end

local function fn11()
	local module13 = require("EE.Interface.Components.List")
	v23 = module13.CreateList(mMovie, "Popup.Ingredients.Ingredient")
	v23.mForcedHorizontalSeparation = 0
	v23.mForcedVerticalSeparation = 62

	function v23:mElementDrawCallback()
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)
		mMovie:OverrideMaterial(self.mClipName .. ".Icon", self.Material)
		local v37 = 50

		if not self.Themed then
			v37 *= 1.6
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, v37)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"Icon",
			11,
			module3.Ternary(self.TintIconColor ~= nil, self.TintIconColor, _G.UIColor_White)
		)
		local checkResearch

		if v2.MetaData == nil then
			checkResearch = false
		else
			checkResearch = v2.MetaData.CheckResearch

			if checkResearch then
				if state == v35.CRAFTING then
					checkResearch = false
				else
					checkResearch = not v2.mTechItem
				end
			end
		end

		local mIncomplete = v2.mPrereqElement ~= nil and not (v2.mPrereqElement.TimeRemaining < 0)

		if checkResearch then
			self.mIncomplete = mIncomplete
		end

		local v39 = mIncomplete or self.mIncomplete and not self.mHasResources
		local ternary = module3.Ternary(v39, v33.ContentHex, v33.FloatingContentHex)
		local ternary2 = module3.Ternary(v39, v33.ContentHex, v33.FloatingContentHighlightHex)
		local v40 = "<p><font color=\"" .. ternary .. "\">" .. TitleCase(self.Name) .. "</font>"

		if self.HideCount ~= true then
			local v41 = v40 .. "<font color=\"" .. ternary2 .. "\"><br>"
			local v42

			if self.SubText == nil then
				if checkResearch then
					v42 = v41 .. module3.FormatNumber(self.Req)
				else
					v42 = v41 .. module3.FormatNumber(self.Count) .. "/" .. module3.FormatNumber(self.Req)
				end
			else
				v42 = v41 .. self.SubText
			end

			v40 = v42 .. "</font>"
		end

		local v41 = v40 .. "</p>"
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Name", 46, "center")
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Name", 36, v41)
		self.mHeight = mMovie:__wf_atom_cfc41e35(self.mClipName, "Name", 41)
		mMovie:__wf_atom_e57658c2(self.mClipName, 12, module3.Ternary(v39, 40, 100))
		mMovie:__wf_atom_7f57ab2f(
			self.mClipName,
			"Check",
			13,
			(self.mIncomplete == nil or not self.mIncomplete) and not self.HideCheck
		)
		mMovie:__wf_atom_4c1c1986(self.mClipName, "Check", 11, v33.FloatingContentHighlight)
		local background1RGB = v33.Background1RGB
		local backerHighlightRGB = v33.BackerHighlightRGB
		mMovie:OverrideMaterial(self.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Bg",
			"RectEdgeColor",
			backerHighlightRGB.r,
			backerHighlightRGB.g,
			backerHighlightRGB.b,
			0.05
		)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Bg",
			"RectInnerColor",
			background1RGB.r,
			background1RGB.g,
			background1RGB.b,
			0.9
		)
		local mIndex = self.mIndex

		if mIndex == nil then
			mIndex = v23:GetElementIndexById(self.Id)
		end

		local mInitialY = v23.mInitialY

		if not __wf_atom_7e8ad928(mIndex) and mIndex > 1 then
			for i = 1, mIndex - 1 do
				mInitialY += math.max(v23.mForcedVerticalSeparation, v23.mElements[i].mHeight or 0)
			end

			mInitialY = mInitialY + 5 * (mIndex - 1) + math.max((self.mHeight - v23.mForcedVerticalSeparation) / 2, 0)
		end

		mMovie:__wf_atom_e57658c2(self.mClipName, 1, module3.Round(mInitialY))
	end

	function v23.CalculateY(_, _)
		return 0
	end
end

local function fn12()
	local module13 = require("EE.Interface.Components.List")
	v24 = module13.CreateList(mMovie, "Popup.IngredientsSecondary.Ingredient")
	v24.mForcedHorizontalSeparation = 0
	v24.mForcedVerticalSeparation = 62

	function v24:mElementDrawCallback()
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)
		mMovie:OverrideMaterial(self.mClipName .. ".Icon", self.Material)
		local v37 = 50

		if not self.Themed then
			v37 *= 1.6
		end

		mMovie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, v37)
		mMovie:__wf_atom_4c1c1986(
			self.mClipName,
			"Icon",
			11,
			module3.Ternary(self.TintIconColor ~= nil, self.TintIconColor, _G.UIColor_White)
		)
		local floatingContentHex = v33.FloatingContentHex
		local floatingContentHighlightHex = v33.FloatingContentHighlightHex
		local v38 = "<p><font color=\"" .. floatingContentHex .. "\">" .. TitleCase(self.Name) .. "</font>"

		if self.HideCount ~= true then
			local v39 = v38 .. "<font color=\"" .. floatingContentHighlightHex .. "\"><br>"
			local v40

			if self.SubText == nil then
				v40 = v39 .. module3.FormatNumber(self.Req)
			else
				v40 = v39 .. self.SubText
			end

			v38 = v40 .. "</font>"
		end

		local v39 = v38 .. "</p>"
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Name", 46, "center")
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Name", 36, v39)
		self.mHeight = mMovie:__wf_atom_cfc41e35(self.mClipName, "Name", 41)
		mMovie:__wf_atom_7f57ab2f(self.mClipName, "Check", 13, false)
		local background1RGB = v33.Background1RGB
		local backerHighlightRGB = v33.BackerHighlightRGB
		mMovie:OverrideMaterial(self.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Bg",
			"RectEdgeColor",
			backerHighlightRGB.r,
			backerHighlightRGB.g,
			backerHighlightRGB.b,
			0.05
		)
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Bg",
			"RectInnerColor",
			background1RGB.r,
			background1RGB.g,
			background1RGB.b,
			0.9
		)
		local mIndex = self.mIndex

		if mIndex == nil then
			mIndex = v24:GetElementIndexById(self.Id)
		end

		local mInitialY = v24.mInitialY

		if not __wf_atom_7e8ad928(mIndex) and mIndex > 1 then
			for i = 1, mIndex - 1 do
				mInitialY += math.max(v24.mForcedVerticalSeparation, v24.mElements[i].mHeight or 0)
			end

			mInitialY = mInitialY + 5 * (mIndex - 1) + math.max((self.mHeight - v24.mForcedVerticalSeparation) / 2, 0)
		end

		mMovie:__wf_atom_e57658c2(self.mClipName, 1, module3.Round(mInitialY))
	end

	function v24.CalculateY(_, _)
		return 0
	end
end

local function fn13()
	local module13 = require("EE.Interface.Components.List")
	v28 = module13.CreateList(mMovie, "Popup.CrewMemberInfo.Skill1")
	v28.mForcedHorizontalSeparation = 0
	v28.mForcedVerticalSeparation = 32

	function v28.mClipCreatedCallback(p, _)
		mMovie:__wf_atom_4c1c1986(p, "Bg", 12, 5)
	end

	function v28.mElementDrawCallback(data)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, v33.FloatingContent)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, v33.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, v33.Content)
		mMovie:__wf_atom_c90af43a(data.mClipName .. ".Icon", crewSkillIcons[data.Skill + 1])
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Bg", 13, data.mIndex % 2 == 1)
		local skill = TitleCase(mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Railjack/CrewSkill" .. tostring(data.Skill),
			false
		))
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/CrewSkillLong", false, {
			LEVEL = data.Level,
			SKILL = skill
		})
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, __wf_atom_8e9ac384)
	end

	gRegion:IsMaster()
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.HealthInfo", 1, 40)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.HealthLabel", 1, 15)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Faction", 12, 70)
	module2.DrawSeparator(mMovie, "Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Separator", 325)
end

local function fn14(_, p)
	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo", 13, not p)

	if p then
		return
	end

	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo.Trait", 13, v2.IsEliteCrewMember == true)
	local v37

	if v2.IsEliteCrewMember then
		mMovie:__wf_atom_50d60589("Popup.CrewMemberInfo.Trait.Desc", 46, "center")
		local crewMemberTrait = module12.GetCrewMemberTrait(v2.CrewMemberInfo.mCrewMemberGeneratedDetails.mSkillUpgrade)
		mMovie:__wf_atom_50d60589("Popup.CrewMemberInfo.Trait.Desc", 36, crewMemberTrait)
		v37 = 72
	else
		v37 = 0
	end

	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo", 1, v6 + 10 + v37)
	v28:RemoveElements(true, true)

	if not p then
		for i = 0, 5 - 1 do
			v28:AddElement({
				Skill = i,
				Level = v2.CrewMemberInfo:__wf_atom_ba6893d3(i)
			}, true)
		end
	end

	v28:Redraw(nil, nil, true)
	local v38 = v28:GetHowManyElements() * v28.mForcedVerticalSeparation
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills", 1, v38 + 5)
	v6 = v6 + v37 + v38
	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo.BelowSkills.HealthInfo", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo.BelowSkills.HealthLabel", 13, false)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.WeaponInfo", 1, 0)
	mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Faction", 1, 40)
	local __wf_atom_3a3b6501 = crewIconMap:__wf_atom_3a3b6501(string.lower(v2.CrewMemberInfo.mFaction:c_str()), 0)
	mMovie:__wf_atom_c90af43a("Popup.CrewMemberInfo.BelowSkills.Faction", __wf_atom_3a3b6501 or v2.Icon)
	local mPowersuitInfo = v2.CrewMemberInfo.mPowersuitInfo
	local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mPowersuitInfo.mXP, mPowersuitInfo.mItemType)
	math.min(
		__wf_atom_c67f9605:__wf_atom_7da755e9(mPowersuitInfo.mItemType, mPowersuitInfo.mPolarized),
		__wf_atom_b4a75eaa
	)
	mMovie:__wf_atom_50d60589("Popup.CrewMemberInfo.BelowSkills.Rank", 36, TitleCase(" "))
	local mId = v2.CrewMemberInfo.mWeaponId.mId
	local v39

	if mId == SF.__wf_atom_b8679e91 or mId == "" then
		v39 = false
	else
		v39 = tonumber(mId) ~= 0
	end

	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo.BelowSkills.WeaponInfo", 13, v39)

	if v39 then
		local __wf_atom_0ff4b555 = gGameData:GetInventory():__wf_atom_0ff4b555(mId)

		if not __wf_atom_7e8ad928(__wf_atom_0ff4b555) then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

			if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
				local itemType = module5.GetItemTypeWithStoreInfo(
					mMovie,
					__wf_atom_0ff4b555.mItemType,
					__wf_atom_964056fd,
					{ ItemInfo = __wf_atom_0ff4b555 },
					true
				)

				if not __wf_atom_7e8ad928(itemType) then
					mMovie:__wf_atom_c90af43a("Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Icon", itemType.Icon)
					mMovie:__wf_atom_e57658c2(
						"Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Icon",
						14,
						64 * module3.Ternary(itemType.Themed, 1, 1.6)
					)
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(itemType.Name, false)
					mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Name", 14, 210)
					module3.SetFitText(mMovie, "Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Name", "...")
					mMovie:__wf_atom_50d60589(
						"Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Name",
						36,
						__wf_atom_8e9ac384
					)
					local __wf_atom_b4a75eaa2 = __wf_atom_c67f9605:__wf_atom_b4a75eaa(
						__wf_atom_0ff4b555.mXP,
						__wf_atom_0ff4b555.mItemType
					)
					local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/Global_FormattedRankCaps",
						false,
						{
							RANK = module3.FormatNumber(__wf_atom_b4a75eaa2)
						}
					)
					mMovie:__wf_atom_50d60589(
						"Popup.CrewMemberInfo.BelowSkills.WeaponInfo.Rank",
						36,
						TitleCase(__wf_atom_8e9ac384_2)
					)
				end
			end
		end

		v6 += 75
		mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Faction", 0, 300)
	else
		v6 += 75
		mMovie:__wf_atom_e57658c2("Popup.CrewMemberInfo.BelowSkills.Faction", 0, 165)
	end
end

local function fn15(p)
	mMovie:__wf_atom_fbca497c(p)
end

function Shutdown()
	_T.ShowItemInfoPopupCursor = nil

	if flag then
		_T.ItemInfoPopupCount = 0
		_T.ItemInfoStatComparison = nil
	end
end

local function fn16(state2, state3)
	local labels = state2.Labels
	local labels2 = state3.Labels
	state2.StatChanges = {}
	state3.StatChanges = {}
	local v37 = {}

	for i = 1, #labels do
		v37[labels[i]] = i
	end

	for i = 1, #labels2 do
		local v38 = v37[labels2[i]]
		local compareValue = state3.CompareValues[i]

		if v38 == nil then
			continue
		end

		v37[labels2[i]] = nil
		local compareValue2 = state2.CompareValues[v38]

		if compareValue2 == compareValue then
			continue
		end

		local v39 = (tonumber(compareValue2) or 0) < (tonumber(compareValue) or 0)
		state2.StatChanges[v38] = v39 and -1 or 1
		state3.StatChanges[i] = v39 and 1 or -1
	end
end

local function fn17(p, p2)
	v15 = p or v15
	v16 = p2 or v16

	if v15 ~= nil and v15.CompareValues ~= nil and mDisplayStats.CompareValues ~= nil then
		fn16(mDisplayStats, v15)
		mDisplayStats.BonusStats = mDisplayStats.BonusStats or {}
		v15.BonusStats = v15.BonusStats or {}
		fn16(mDisplayStats.BonusStats, v15.BonusStats)
	end

	fn6()

	if v16 ~= nil then
		v16()
	end
end

local function fn18()
	local module13 = require("EE.Interface.Components.List")
	v30 = module13.CreateList(mMovie, "Popup.Invasion.Subinvasion")
	v30.BarWidth = 330
	v30.mForcedHorizontalSeparation = 0
	v30.mForcedVerticalSeparation = 75

	function v30.UpdateColor(p)
		mMovie:__wf_atom_1ca72041(
			p .. ".ProgressBar.LeftFill",
			"RectInnerColor",
			v33.FloatingContentRGB.r,
			v33.FloatingContentRGB.g,
			v33.FloatingContentRGB.b,
			0.4
		)
		mMovie:__wf_atom_1ca72041(p .. ".ProgressBar.LeftFill", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041(
			p .. ".ProgressBar.RightFill",
			"RectInnerColor",
			v33.FloatingContentRGB.r,
			v33.FloatingContentRGB.g,
			v33.FloatingContentRGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(p .. ".ProgressBar.RightFill", "RectEdgeColor", 0, 0, 0, 0)
		mMovie:__wf_atom_1ca72041(
			p .. ".ProgressBar.Bg",
			"RectInnerColor",
			v33.Background1RGB.r,
			v33.Background1RGB.g,
			v33.Background1RGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			p .. ".ProgressBar.Bg",
			"RectEdgeColor",
			v33.FloatingContentRGB.r,
			v33.FloatingContentRGB.g,
			v33.FloatingContentRGB.b,
			1
		)
		mMovie:__wf_atom_4c1c1986(p, "Progress", 44, v33.Content)
		mMovie:__wf_atom_4c1c1986(p, "LRewards", 44, v33.Content)
		mMovie:__wf_atom_4c1c1986(p, "RRewards", 44, v33.Content)
	end

	function v30.mClipCreatedCallback(p, _)
		v30.UpdateColor(p)
		mMovie:OverrideMaterial(p .. ".ProgressBar.LeftFill", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(p .. ".ProgressBar.RightFill", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial(p .. ".ProgressBar.Bg", _G.UIMaterial_RectangleNoDepth)
	end

	function v30.mElementDrawCallback(data)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(data.Node:c_str(), false)

		if not data.CustomEntry then
			__wf_atom_8e9ac384 = "<p><font size=\"19\"><b>" .. __wf_atom_8e9ac384 .. "</b></font></p>"
		end

		mMovie:__wf_atom_48bd5a59(data.mClipName, "Title", 36, __wf_atom_8e9ac384)
		mMovie:__wf_atom_48bd5a59(data.mClipName, "Title", 45, module3.Ternary(data.CustomEntry, "left", "center"))
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Title", 0, module3.Ternary(data.CustomEntry, 2, 115))
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Title", 1, module3.Ternary(data.CustomEntry, 45, 0))
		mMovie:__wf_atom_4c1c1986(
			data.mClipName,
			"Title",
			44,
			module3.Ternary(data.CustomEntry, v33.FloatingContentHighlight, v33.FloatingContent)
		)
		local v37

		if data.Delta == nil or data.Delta == 0 then
			v37 = false
		else
			v37 = not data.HideProgress
		end

		mMovie:__wf_atom_7f57ab2f(data.mClipName, "Progress", 13, v37)

		if v37 then
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Progress", 36, tostring(data.Delta) .. "/" .. tostring(3))
			mMovie:__wf_atom_48bd5a59(
				data.mClipName,
				"Progress",
				45,
				module3.Ternary(data.SupportAttacker, "left", "right")
			)
			local v38

			if data.SupportAttacker then
				v38 = 0
			else
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Progress", 14)
				v38 = v30.BarWidth - __wf_atom_5e6e15c8
			end

			mMovie:__wf_atom_4c1c1986(data.mClipName, "Progress", 0, v38)
		end

		if data.CustomEntry then
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.LeftFill", 14, 0.001)
			local v38 = __wf_atom_421b01aa(v30.BarWidth * data.Delta, 0.001, v30.BarWidth)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 14, v38)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 0, v38)
		else
			local count = data.Count
			local goal = data.Goal
			local v38 = 50 + count / goal * 50

			if v2.AttackerFaction == 2 then
				v38 = 100 + count / goal * 100
			end

			local v39 = v30.BarWidth * (v38 / 100)
			mMovie:__wf_atom_4c1c1986(
				data.mClipName,
				"ProgressBar.LeftFill",
				14,
				__wf_atom_421b01aa(v39 + 2, 0.001, v30.BarWidth)
			)
			mMovie:__wf_atom_4c1c1986(
				data.mClipName,
				"ProgressBar.RightFill",
				14,
				__wf_atom_421b01aa(v30.BarWidth - v39 + 2, 0.001, v30.BarWidth)
			)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 0, v30.BarWidth)
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.Bg", 14, v30.BarWidth)

		if __wf_atom_7e8ad928(data.AttackerReward) or __wf_atom_7e8ad928(data.DefenderReward) then
			mMovie:__wf_atom_48bd5a59(data.mClipName, "LRewards", 36, "")
			mMovie:__wf_atom_48bd5a59(data.mClipName, "RRewards", 36, "")
		else
			local v38 = TitleCase(module.GetRewardDesc(mMovie, data.AttackerReward))
			local v39 = TitleCase(module.GetRewardDesc(mMovie, data.DefenderReward))
			module3.FitTextIntoLines(mMovie, data.mClipName .. ".LRewards", 2, v38, "...")
			module3.FitTextIntoLines(mMovie, data.mClipName .. ".RRewards", 2, v39, "...")
		end
	end
end

function Initialize()
	_T.ItemInfoPopupCount = (_T.ItemInfoPopupCount or 0) + 1

	if _T.ItemInfoStatComparison == nil then
		_T.ItemInfoStatComparison = fn17
	end

	mMovie:SetVisible(false)
	mMovie:__wf_atom_c884ca43(true)
	mMovie:__wf_atom_b4ffb30f(false)
	mMovie:__wf_atom_dac78d3d(true)
	local module13 = require("Lotus.Interface.Libs.TimerMgr")
	v18 = module13.CreateTimerMgr()
	_T.ShowItemInfoPopupCursor = fn15
	mMovie:__wf_atom_933bbce0("Popup.Bg", midBgTexture, midBgMaterial)
	module2.DrawSeparator(mMovie, "Popup.TagSeparator", 330)
	module2.DrawSeparator(mMovie, "Popup.PrereqSeparator.Separator", 330)
	module2.DrawSeparator(mMovie, "Popup.IngredientsSeparator.Separator", 330)
	module2.DrawSeparator(mMovie, "Popup.AbilityInfo.PassiveSeparator", 330)
	mMovie:__wf_atom_c90af43a("Popup.AbilityInfo.Passive.Icon", passiveIcon)
	mMovie:__wf_atom_1ca72041("Popup.Bg", "RectEdgeColor", 0, 0, 0, 0)
	mMovie:__wf_atom_1ca72041("Popup.Bg", "RectInnerColor", 1, 1, 1, 1)
	mMovie:OverrideMaterial("Popup.Header.Fade", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial("Popup.Header.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial("Popup.TitleBg", _G.UIMaterial_RectangleNoDepth)
	v7 = mMovie:__wf_atom_5e6e15c8("Popup.TitleBg", 14)
	mMovie:__wf_atom_e57658c2("Popup.LineHeader.Line", 14, v7 - 70)
	mMovie:__wf_atom_e57658c2("Popup.LineFooter.Line", 14, v7 - 70)
	mMovie:__wf_atom_e57658c2("Popup.TitleDivider", 14, v7 - 40)
	fn8()
	fn11()
	fn12()
	fn18()
	fn13()
	fn9()
	fn7()
	local module14 = require("Lotus.Interface.Components.ThemedSpinner")
	v19 = module14.Create(mMovie, "Popup.Spinner")

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
	end
end

local function fn19(p)
	local v37 = p == nil and 1 or p
	local v38 = "Popup.TagContainer.Tag1"
	local v39 = 1

	while mMovie:__wf_atom_253d7085(v38) do
		mMovie:__wf_atom_2dedec1a(v38, 13, v39 < v37)
		v39 += 1
		v38 = "Popup.TagContainer.Tag" .. tostring(v39)
	end
end

local function fn20(p)
	mMovie:__wf_atom_e57658c2("Popup.Header.Bg", 15, v6 + v8)
	mMovie:__wf_atom_e57658c2("Popup.TitleBg", 15, v6)
	mMovie:__wf_atom_e57658c2("Popup.Bg", 15, (math.max(1, v6 - v5 - p)))
	mMovie:__wf_atom_e57658c2("Popup.Bg", 1, v5)
	mMovie:__wf_atom_e57658c2("Popup.TitleDivider", 1, v5)
	mMovie:__wf_atom_e57658c2("Popup.PreviewTag", 1, v6 - (p - 6))
	mMovie:__wf_atom_e57658c2("Popup.PreviewCallout", 1, v6 - (p - 6))
	mMovie:__wf_atom_e57658c2("Popup.Blurer", 15, v6)
	mMovie:__wf_atom_e57658c2("Popup.LineFooter", 1, v6)
end

fn2 = function(p)
	v20 = p
	v19:SetActive(p)

	if p then
		fn19()

		for _, v37 in pairs({
			"Description",
			"AbilityInfo",
			"ItemStats",
			"TagSeparator",
			"Ingredients",
			"IngredientsSeparator",
			"IngredientsSecondary",
			"PrereqSeparator",
			"Prerequisite",
			"RankedProgress",
			"RarityBar",
			"Affiliation1",
			"VideoPreview",
			"ExtraDesc",
			"CrewMemberInfo",
			"Invasion"
		}) do
			mMovie:__wf_atom_7f57ab2f("Popup", v37, 13, false)
		end

		if v6 == 0 then
			v6 = 120
			fn20(0)
		end

		mMovie:__wf_atom_e57658c2("Popup.Spinner", 1, v5 + (v6 - v5) / 2)
	end
end

local function fn21()
	if v26 and not __wf_atom_7e8ad928(gGameData) then
		v26 = false
		v18:AddTimer(5, function()
			v26 = true
		end)
		v25 = {}
		local inventory = gGameData:GetInventory()

		if not __wf_atom_7e8ad928(inventory) then
			module.AddTableToPurchasedItems(v25, inventory:__wf_atom_4f67b86c())
			module.AddTableToPurchasedItems(v25, inventory:__wf_atom_20b04548())
			module.AddTableToPurchasedItems(v25, inventory:__wf_atom_4259c789())
			module.AddTableToPurchasedItems(v25, inventory:__wf_atom_6b29f1ed())
		end
	end
end

local function fn22(infoPopup_Grid)
	v3:RemoveElements(true, true)
	v3.mAbilitiesAvailable = false
	v3.mStatsAvailable = false

	for _ = 1, v2.Hints == nil and 1 or math.max(#v2.Hints, 1) or 1 do
		v3:AddElement({ State = v35.BASE }, true)
	end

	if
		infoPopup_Grid ~= nil
		and infoPopup_Grid.AdditionalTabInfo ~= nil
		and #infoPopup_Grid.AdditionalTabInfo(v2) > 0
	then
		v3:AddElement({ State = v35.INFO }, true)
	end

	if v2.TimeRemaining ~= nil and not v2.HideRecipe then
		v3:AddElement({ State = v35.CRAFTING }, true)
	end

	local mIsNemesis = v2.mIsNemesis
	local resultStoreItem = v2.ResultStoreItem or v2.StoreItem

	if mIsNemesis or not __wf_atom_7e8ad928(resultStoreItem) then
		local v37

		if not __wf_atom_7e8ad928(resultStoreItem) then
			v37 = resultStoreItem:__wf_atom_efa6f447()
		end

		local v38 = mIsNemesis or v37 == 3 or v37 == 27 or v37 == 48
		local v39 = v37 == 0 or v37 == 1 or v37 == 5 or v37 == 28 or v37 == 29 or v37 == 37 or v37 == 16 or v37 == 43
		local mStatsAvailable = v37 == 15 or v37 == 39
		v3.mAbilitiesAvailable = v38 and not v2.HideAbilities
		local v41 = v3

		if v38 or v39 or mStatsAvailable then
			mStatsAvailable = not v2.HideStats
		end

		v41.mStatsAvailable = mStatsAvailable

		if v3.mAbilitiesAvailable and not v2.AllInOne then
			v3:AddElement({ State = v35.ABILITIES }, true)
		end

		if v3.mStatsAvailable then
			for i = module3.Ternary(v2.AllInOne, 2, 1), v12 do
				v3:AddElement({ State = v35.STATS, StatId = i }, true)
			end
		end
	end

	v3:Redraw(nil, nil, true)
	fn10()
end

local function fn23()
	local v37 = v29
	v29 = false
	local v38 = true
	local v39 = v2.mPrereqElement ~= nil
	local storeItem = v2.StoreItem
	local __wf_atom_92a55f32 = storeItem:__wf_atom_92a55f32()
	local v40 = ""
	local v41

	if v2.MetaData == nil or not v2.MetaData.CheckResearch or state == v35.CRAFTING then
		v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_RecipeComponents", false)

		if __wf_atom_92a55f32 then
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/FabricationRequirements", true)
		else
			v40 = module.SecondsToFormattedTime(mMovie, storeItem:__wf_atom_ed1be18b(), "CompactHours")
		end
	elseif v2.Researched or v2.InProgress or v39 and v2.mPrereqElement.TimeRemaining >= 0 then
		v38 = false

		if v37 and v2.mCompletionDate ~= nil then
			v2.TimeRemaining = Engine.__wf_atom_db2b0cee(v2.mCompletionDate)
		end

		if v2.TimeRemaining > 0 then
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchStatusInProgress", false)
			v40 = module.SecondsToFormattedTime(mMovie, v2.TimeRemaining, "Compact")
			v29 = true
		elseif v39 and not v2.Researched then
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchPrereqNeededHint", false, {
				PREREQ = v2.mPrereqElement.Name
			})
		elseif _T.ShowDojoColors then
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchColorCompleteHint", false)
		elseif __wf_atom_92a55f32 then
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/ResearchCompleteHintFabrication", false)
		else
			v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchCompleteHint", false)
		end
	else
		v41 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchRequirements", false)

		if not __wf_atom_92a55f32 then
			v40 = module.SecondsToFormattedTime(mMovie, storeItem:__wf_atom_cc75974f(), "CompactHours")
		end
	end

	if #v40 > 0 then
		v40 = "<br>" .. mMovie:__wf_atom_8e9ac384("<TIMER> ", true) .. v40
	end

	local v42 = "<p><font color=\"" .. v33.FloatingContentHex .. "\">" .. v41 .. "<font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v40 .. "</font></font></p>"
	mMovie:__wf_atom_50d60589("Popup.PrereqSeparator.Description", 36, v42)
	return v38, v39
end

local function fn24()
	local storeItem = v2.StoreItem
	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	local inventory = nil

	if __wf_atom_7e8ad928(__wf_atom_964056fd) then
		return false, false
	end

	local v37, v38 = fn23()
	v23:RemoveElements(true, true)
	fn21()

	if v37 then
		if not __wf_atom_7e8ad928(gGameData) then
			inventory = gGameData:GetInventory()
		end

		local guildTier = 0

		if v2.MetaData == nil or v2.MetaData.GuildTier == nil then
			if gGameRules:IsA(__wf_atom_1316e0c2) then
				guildTier = gGameRules:__wf_atom_7d674792()
			end
		else
			guildTier = v2.MetaData.GuildTier
		end

		local v39

		if v2.MetaData == nil then
			v39 = false
		else
			v39 = v2.MetaData.CheckResearch and state ~= v35.CRAFTING
		end

		local v40 = v39 and storeItem:__wf_atom_c4eef360() or storeItem:__wf_atom_524145ba()

		for i = 1, #v40 do
			local v41 = v40[i]
			local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(v41.mItemType)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				continue
			end

			local count2 = 0
			v23:RunForAllElements(function(data)
				if data.Type ~= nil and data.Type == v41.mItemType then
					count2 -= math.min(data.Req, data.Count)
				end
			end)
			local count = 0

			if
				v25[v41.mItemType:__wf_atom_5b41f63b()] == nil
				or v25[v41.mItemType:__wf_atom_5b41f63b()].Count == nil
			then
				if not __wf_atom_7e8ad928(inventory) then
					count = inventory:__wf_atom_52fcdd65(v41.mItemType)
				end
			else
				count = v25[v41.mItemType:__wf_atom_5b41f63b()].Count
			end

			count2 += count
			local storeItemInfo = module5.GetStoreItemInfo(mMovie, __wf_atom_232fd31d, nil, nil, nil, true)
			storeItemInfo.Req = v41.mItemCount
			local count3 = 0

			if v39 then
				storeItemInfo.Req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(nil, storeItemInfo.Req, guildTier, true)
				local mTechItem = v2.mTechItem

				if mTechItem then
					for j = 1, #mTechItem.mReqItems do
						if mTechItem.mReqItems[j].mItemType == v41.mItemType then
							count3 = storeItemInfo.Req - mTechItem.mReqItems[j].mItemCount
						end
					end
				end
			end

			if v41.mItemType:IsA(__wf_atom_9df43583) then
				count2 = __wf_atom_421b01aa(count2, 0, v41.mItemCount)
			else
				count2 = math.max(count2, 0)
			end

			if v39 then
				if count3 < storeItemInfo.Req then
					storeItemInfo.mIncomplete = true
				end

				storeItemInfo.mHasResources = storeItemInfo.Req - count3 <= count2
				storeItemInfo.Count = count3
			else
				storeItemInfo.mIncomplete = count2 < storeItemInfo.Req
				storeItemInfo.mHasResources = not storeItemInfo.mIncomplete
				storeItemInfo.Count = count2
			end

			v23:AddElement(storeItemInfo, true)
		end

		local req = v39 and storeItem:__wf_atom_0df579e8() or storeItem:__wf_atom_6276eba2()

		if req > 0 then
			local v42 = {
				Themed = true,
				Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_BuyWithCredits", false),
				Icon = creditsIcon
			}
			local count = 0

			if v39 then
				req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(nil, req, guildTier, true)

				if v2.mTechItem then
					count = req - v2.mTechItem.mReqCredits

					if count < req then
						v42.mIncomplete = true
					end

					local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()
					v42.mHasResources = req - count <= __wf_atom_7050e489
				end
			elseif not __wf_atom_7e8ad928(gGameData) then
				count = gGameData:__wf_atom_7050e489()
			end

			v42.Count = count
			v42.Req = req
			v23:InsertElement(1, v42, true)
		end
	end

	v23:Redraw(nil, nil, true)
	return v37, v38
end

local function fn25(infoPopup_Grid, p, storeItem, mDesc, _, p2, p3, p4)
	local _, v37 = module2.GetGridItemName(mMovie, infoPopup_Grid, v2, v2.MetaData)
	tags = {}

	if v2.CustomEntry and not __wf_atom_7e8ad928(v2.Tags) then
		tags = v2.Tags
	else
		if v2.ShowInfoPopupOwned and v2.MetaData then
			v2.MetaData.HideOwned = nil
			v2.MetaData.HideCountThreshold = 0
			v2.MetaData.OwnedInfo = {
				TagOverride = "/Lotus/Language/Menu/Crafting_Owned_Icon_Label",
				mShowOne = true
			}
		end

		tags = module2.GetGridItemTags(mMovie, infoPopup_Grid, v2, v2.MetaData, v37)
	end

	mMovie:__wf_atom_e57658c2("Popup.TagContainer", 1, v6)
	local count = 0
	local v38 = 300
	local v39 = 0
	local flag2 = false

	for _, tag in ipairs(tags) do
		if not tag.ExcludeFromInfoPopup then
			count += 1
		end
	end

	local v40 = true

	for _, tag in ipairs(tags) do
		if not (tag.ExcludeFromInfoPopup or tag.UseFullLabel) then
			total += 35
		end
	end

	for _, tag in ipairs(tags) do
		if tag.ExcludeFromInfoPopup then
			continue
		end

		local rightAlignPopup

		if tag.Type == module2.LABEL_TYPE_UGC then
			rightAlignPopup = false
		elseif tag.RightAlign then
			rightAlignPopup = not v40

			if not rightAlignPopup then
				if tag.Type == module2.LABEL_TYPE_FAVORITE then
					rightAlignPopup = not (v40 or tag.UseFullLabel)
				else
					rightAlignPopup = true
				end
			end
		else
			rightAlignPopup = not (v40 or tag.UseFullLabel)
		end

		tag.RightAlignPopup = rightAlignPopup

		if rightAlignPopup then
			if tag.Type == module2.LABEL_TYPE_REUSABLE_BLUEPRINT then
				flag2 = true

				if count ~= 1 then
					tag.Name = ""
				end
			elseif tag.Type ~= module2.LABEL_TYPE_RIGHT_TEXT and count ~= 1 then
				tag.Name = ""
			end
		elseif tag.PopUpLabel ~= nil then
			tag.Name = mMovie:__wf_atom_8e9ac384(tag.PopUpLabel, true)
		end

		local clipName
		clipName, p = module2.GetPriceLabelClip(mMovie, "Popup", p)

		if not rightAlignPopup then
			tag.FitText = true
			tag.MaxWidth = v7 - total
		end

		module2.DrawPriceLabel(mMovie, clipName, tag)
		tag.ClipName = clipName
		local v43 = mMovie:__wf_atom_5e6e15c8(clipName .. ".Label", 41) + module3.Ternary(tag.TagBuffer == nil, 13, tag.TagBuffer)

		if rightAlignPopup then
			local v44 = mMovie:__wf_atom_5e6e15c8(clipName .. ".IconText", 40) or 0

			if v44 > 0 then
				v38 = v38 - v44 + 5
			end

			mMovie:__wf_atom_e57658c2(clipName, 1, 0)
			mMovie:__wf_atom_e57658c2(clipName, 0, v38)
			v38 += -32
			local _ = v44 > 0

			if not v40 then
				v39 = math.max(v39, v43)
			end
		else
			mMovie:__wf_atom_e57658c2(clipName, 1, v39)
			v39 += v43
			v40 = false
		end
	end

	local v41 = v39 == 0 and count > 0 and 30 or v39
	v6 += v41

	if v2.NotOwned and not __wf_atom_7e8ad928(storeItem) then
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(storeItem:__wf_atom_42794027():c_str(), true)

		if __wf_atom_8e9ac384 ~= "" then
			if v9 ~= "" then
				v9 ..= "\r\n\r\n"
			end

			v9 ..= __wf_atom_8e9ac384 .. "\r\n\r\n"
		end
	end

	if v2.NextSuitLevel ~= nil then
		local v42 = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", true, {
			RANK = v2.NextSuitLevel
		}))
		local rank = "<font color=\"" .. v33.ContentHex .. "\">" .. v42 .. "</font>"

		if v2.Locked then
			v9 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Suits/AbilityUnlockedAt", true, {
				RANK = rank
			}) .. "\r\n\r\n"
		else
			v9 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Suits/AbilityUpgradeAt", true, {
				RANK = rank
			}) .. "\r\n\r\n"
		end

		v9 = "<font color=\"" .. v33.FloatingContentHex .. "\">" .. v9 .. "</font>"
	end

	if #v2.Hints > 0 then
		v9 ..= v2.Hints[v3.mCurrentElementIndex or 1]
	end

	if not __wf_atom_7e8ad928(v2.mMeleeSet) then
		local __wf_atom_27db0e17 = v2.mMeleeSet:__wf_atom_27db0e17()

		if v2.mMeleeCallouts == nil then
			v2.mMeleeCallouts = {}
		end

		local v42 = "<font color=\"" .. v33.FloatingContentHighlightHex .. "\">"

		for i = 1, #__wf_atom_27db0e17 do
			local v43

			if v2.mMeleeCallouts[i] == nil then
				v43 = ""
			else
				local mMeleeCallout = v2.mMeleeCallouts[i]
				local v44

				if
					mMeleeCallout == "<MELEE>"
					or mMeleeCallout == "<AIM_WEAPON>"
					or mMeleeCallout == "<MELEE_CHANNEL>"
				then
					v44 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Melee/ComboBtnPress", true, {
						ACTION = mMeleeCallout
					})
				else
					v44 = mMovie:__wf_atom_8e9ac384(mMeleeCallout, true)
				end

				v43 = v44 .. "<br>"
			end

			v9 ..= v43
			local v44 = math.max(1, __wf_atom_27db0e17[i]:__wf_atom_7ee4ff02())

			for j = 1, v44 do
				local __wf_atom_6b8680b1 = __wf_atom_27db0e17[i]:__wf_atom_6b8680b1(j - 1)
				local v45 = __wf_atom_6b8680b1 == 0.01 and 0 or __wf_atom_6b8680b1
				v9 ..= "    " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Melee/ComboAttack", false, {
					OPEN_COLOR = v42,
					VALUE = module3.FormatNumber(100 * v45),
					CLOSE_COLOR = "</font>"
				})

				for k = 0, 32 - 1 do
					if __wf_atom_27db0e17[i]:__wf_atom_c7927521(j - 1, false, k) then
						v9 ..= " + " .. mMovie:__wf_atom_8e9ac384("<" .. module.GetProcTypeTag(k) .. ">", true)
					end
				end

				v9 ..= module3.Ternary(j == v44, "", "<br>")
			end

			v9 ..= module3.Ternary(i == #__wf_atom_27db0e17, "", "<br><br>")
		end
	end

	if
		__wf_atom_7e8ad928(storeItem)
		or __wf_atom_7e8ad928(storeItem:GetItem())
		or not storeItem:GetItem():IsA(__wf_atom_6317e6dc)
	then
		if flag2 then
			v9 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Blueprint_UnlimitedCharges", true) .. "<br>" .. v9 .. mMovie:__wf_atom_8e9ac384(v2.Description, false)
		elseif __wf_atom_7e8ad928(v2.mMod) then
			if v2.LocalizedDesc == nil then
				v9 ..= mMovie:__wf_atom_8e9ac384(v2.Description, false)
			else
				v9 ..= v2.LocalizedDesc
			end
		end
	else
		v9 ..= module5.GetRelicInfo(mMovie, storeItem, true)
	end

	if #v2.MergeDesc > 0 then
		if #v9 > 0 then
			v9 ..= "<br><br>"
		end

		v9 ..= v2.MergeDesc
	end

	if #v2.ListItems > 0 then
		local v42 = ""

		for _, listItem in ipairs(v2.ListItems) do
			if #listItem.Label > 0 then
				if #v42 > 0 then
					v42 ..= "<br>"
				end

				v42 ..= listItem.Label
			end

			if not (#listItem.Desc > 0) then
				continue
			end

			local v43 = v42 .. "<font color=\"" .. v33.ContentHex .. "\">"

			for i = 1, #listItem.Desc do
				v43 ..= "<br>     " .. listItem.Desc[i]
			end

			v42 = v43 .. "</font>"
		end

		if #v42 > 0 then
			if #v9 > 0 then
				v9 ..= "<br><br>"
			end

			v9 ..= "<font color=\"" .. v33.FloatingContentHex .. "\">" .. v42 .. "</font>"
		end
	end

	if v2.SalvageTimeRemaining ~= nil then
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v2.SalvageTimeRemaining)

		if __wf_atom_db2b0cee > 0 then
			local twitterStyleTime = module.GetTwitterStyleTime(__wf_atom_db2b0cee, true, true)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Railjack/SalvageTimeRemaining",
				true,
				{ REPAIR_TIME = twitterStyleTime }
			)
			v9 = "<font color=\"" .. v33.FloatingContentHex .. "\">" .. __wf_atom_8e9ac384 .. "</font>" .. "<br>" .. v9
		else
			v9 = "<font color=\"" .. v33.FloatingContentHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Railjack/SalvageReadyToClaim",
				true
			) .. "</font>" .. "<br>" .. v9
		end
	end

	if not v2.ShowDucatTag then
		if not __wf_atom_7e8ad928(storeItem) then
			v2.PrimePrice = storeItem:__wf_atom_69dc9a11()
		end

		if v2.PrimePrice ~= nil and v2.PrimePrice > 0 then
			if v9 ~= "" then
				v9 ..= "<br><br>"
			end

			v9 ..= mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_ValuePrimeBucks", true, {
				COST = v2.PrimePrice
			})
		end
	end

	if v9 ~= "" and mDesc ~= "" then
		v11 = string.len(v9)
	end

	local v42 = false
	local flag3 = false
	local v43 = false

	if v2.IngredientOverride == nil then
		if __wf_atom_7e8ad928(storeItem) or not storeItem:IsA(__wf_atom_bf37f5ca) or v2.HideRecipe then
			if v2.Capacity ~= nil then
				local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

				if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
					v42 = true
					v23:RemoveElements(true, true)
					local v44 = { availableCapacity = 0, capacityParams = nil }

					if __wf_atom_7e8ad928(_T.DojoMgr) then
						v44.capacityParams = module.GetShipDecoRoom()
						v44.availableCapacity = gGameData:__wf_atom_31e514d3(v44.capacityParams)
					else
						v44.capacityParams = _T.DojoMgr:BuildComponentParams(__wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_58b2e21e())
						v44.availableCapacity = _T.DojoMgr.mDojo:GetJsonComponent(v44.capacityParams):__wf_atom_47a3d3d2()
					end

					local v45 = {
						Icon = capacityIcon,
						TintIconColor = v33.FloatingContent,
						Themed = true,
						Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v2.Capacity,
						Req = 1,
						Count = module3.Ternary(v2.Capacity <= v44.availableCapacity, 1, 0),
						SubText = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
							COUNT = v44.availableCapacity
						})
					}
					v23:AddElement(v45, true)
					v23:Redraw(nil, nil, true)
				end
			end
		else
			local v44 = _T["InfoPopup_Data" .. v31]

			if v44 and v44.NumPortals ~= nil and not __wf_atom_7e8ad928(_T.DojoMgr) then
				local __wf_atom_ba75ca7b = v44.Recipe:__wf_atom_ba75ca7b()
				local v45 = v44.NumPortals ~= 1
					and mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/NumberOfDoors", false, {
						DOORS = v44.NumPortals
					})
					or mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/OneDoor", false, nil)

				if v44.NumPortals <= 1 then
					v45 ..= " / " .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DeadEndWarning", false, nil)
				end

				if __wf_atom_ba75ca7b > 0 then
					local v46 = "/Lotus/Language/Clan/Tier" .. __wf_atom_ba75ca7b .. "Name"
					local v47 = {
						TierClanSize = __wf_atom_c67f9605:__wf_atom_e0d9634c(__wf_atom_ba75ca7b),
						TierName = mMovie:__wf_atom_8e9ac384(v46, false)
					}
					v9 = mMovie:__wf_atom_8e9ac384(v44.Recipe:__wf_atom_3a3d2e39():c_str(), true, v47)
				end

				v9 = "<font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v45 .. "</font>" .. "<br>" .. v9 .. "<br><br><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Dojo/RequireLabel",
					true
				) .. "<br></font>"
				local v46 = Resource("/Lotus/Types/Game/Store/DojoRecipeManifest")
				local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
				local __wf_atom_7e0e1506 = v44.Recipe:__wf_atom_7e0e1506()
				v42 = true
				v23:RemoveElements(true, true)

				if not __wf_atom_7e8ad928(__wf_atom_7e0e1506) and #__wf_atom_7e0e1506 > 0 then
					for i = 1, #__wf_atom_7e0e1506 do
						local v47 = __wf_atom_7e0e1506[i]

						for j = 1, #v47 do
							if __wf_atom_7e8ad928(v47[j]) then
								continue
							end

							local __wf_atom_e564443c = v46:__wf_atom_e564443c(v47[j])

							if __wf_atom_7e8ad928(__wf_atom_e564443c) then
								continue
							end

							local storeItem2 = __wf_atom_964056fd:GetStoreItem(WeakResource(__wf_atom_e564443c:__wf_atom_5b41f63b()))
							local storeItemInfo = module5.GetStoreItemInfo(mMovie, storeItem2, nil, nil, nil, true)
							storeItemInfo.HideCount = true
							storeItemInfo.Req = 1
							storeItemInfo.Count = module3.Ternary(_T.DojoMgr.mDojo:__wf_atom_4a314099(v47), 1, 0)
							storeItemInfo.Name = mMovie:__wf_atom_8e9ac384(
								storeItem2:__wf_atom_014a76a2():c_str(),
								false
							)
							storeItemInfo.Material = v44.InfoMaterial
							v23:AddElement(storeItemInfo, true)
						end
					end
				end

				local v47 = -v44.Recipe:__wf_atom_be9cf318()
				local __wf_atom_be9cf318 = _T.DojoMgr.mDojo:__wf_atom_be9cf318()
				local v48 = {
					Icon = capacityIcon,
					TintIconColor = v33.FloatingContent,
					Themed = true,
					Req = 1,
					Count = module3.Ternary(v47 <= __wf_atom_be9cf318, 1, 0),
					SubText = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
						COUNT = __wf_atom_be9cf318
					})
				}
				local v49

				if v47 < 0 then
					v47 = -v47
					v49 = mMovie:__wf_atom_8e9ac384("<UPARROW>", true)
				else
					v49 = ""
				end

				v48.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v47 .. v49
				v23:AddElement(v48, true)
				local v50 = -v44.Recipe:__wf_atom_d905c44b()
				local __wf_atom_d905c44b = _T.DojoMgr.mDojo:__wf_atom_d905c44b()
				local v51 = {
					Icon = energyIcon,
					TintIconColor = v33.FloatingContent,
					Themed = true,
					Req = 1,
					Count = module3.Ternary(v50 <= __wf_atom_d905c44b, 1, 0),
					SubText = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
						COUNT = __wf_atom_d905c44b
					})
				}
				local v52

				if v50 < 0 then
					v50 = -v50
					v52 = mMovie:__wf_atom_8e9ac384("<UPARROW>", true)
				else
					v52 = ""
				end

				v51.Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/EnergyLabel", false) .. " " .. v50 .. v52
				v23:AddElement(v51, true)
				v23:Redraw(nil, nil, true)
			elseif v44 and v44.Capacity ~= nil and not __wf_atom_7e8ad928(_T.DojoMgr) then
				v42 = true
				v23:RemoveElements(true, true)
				local count2 = _T.ComponentParams == nil and 0
					or _T.DojoMgr.mDojo:GetJsonComponent(_T.ComponentParams):__wf_atom_47a3d3d2()
				local v46 = {
					Icon = capacityIcon,
					TintIconColor = v33.FloatingContent,
					Themed = true,
					Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v44.Capacity,
					Req = 1,
					Count = module3.Ternary(v44.Capacity <= count2, 1, 0),
					SubText = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
						COUNT = count2
					})
				}
				v23:AddElement(v46, true)
				v23:Redraw(nil, nil, true)

				if not (v44.HideRecipe or __wf_atom_7e8ad928(v44.Recipe)) then
					flag3 = true
					v24:RemoveElements(true, true)
					local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
					local v47 = mMovie:__wf_atom_8e9ac384("<TIMER> ", true) .. " " .. module.SecondsToFormattedTime(
						mMovie,
						v44.Recipe:__wf_atom_ed1be18b(),
						"CompactHours"
					)
					local v48 = "<p><font color=\"" .. v33.FloatingContentHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Menu/DetailedPurchase_BpAbout",
						false
					) .. "<br><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v47 .. "</font></font></p>"
					mMovie:__wf_atom_50d60589("Popup.IngredientsSeparator.Description", 36, v48)
					local __wf_atom_ad81b9a4 = __wf_atom_c67f9605:__wf_atom_ad81b9a4(
						v44.Recipe,
						v44.Recipe:__wf_atom_6276eba2(),
						_T.DojoMgr.mGameRules:__wf_atom_7d674792(),
						false
					)

					if __wf_atom_ad81b9a4 > 0 then
						local v49 = {
							Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_BuyWithCredits", false),
							Req = __wf_atom_ad81b9a4,
							Icon = creditsIcon,
							Themed = true
						}
						v24:AddElement(v49, true)
					end

					local __wf_atom_524145ba = v44.Recipe:__wf_atom_524145ba()

					for i = 1, #__wf_atom_524145ba do
						local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(__wf_atom_524145ba[i].mItemType)
						local storeItemInfo = module5.GetStoreItemInfo(mMovie, __wf_atom_232fd31d, nil, nil, nil, true)
						storeItemInfo.Req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(
							v44.Recipe,
							__wf_atom_524145ba[i].mItemCount,
							_T.DojoMgr.mGameRules:__wf_atom_7d674792(),
							false
						)
						v24:AddElement(storeItemInfo, true)
					end

					v24:Redraw(nil, nil, true)
				end
			elseif not (__wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_dd9a0bb8)) then
				v42, v43 = fn24()
			end
		end
	else
		v23:RemoveElements(true, true)
		v42 = true

		for i = 1, #v2.IngredientOverride do
			v23:AddElement(v2.IngredientOverride[i], true)
		end

		v23:Redraw(nil, nil, true)
	end

	if not __wf_atom_7e8ad928(v2.CodexEntry) then
		v9 ..= module7.GetEnemyInfoText(mMovie, v2.CodexEntry, v33.FloatingContentHighlightHex, v33.ContentHex)
	end

	if not __wf_atom_7e8ad928(infoPopup_Grid) then
		if not __wf_atom_7e8ad928(storeItem) and storeItem:IsPackage() then
			local packageContentsDesc = module5.GetPackageContentsDesc(
				mMovie,
				storeItem,
				infoPopup_Grid.PurchasedItems,
				v33.FloatingContentHighlightHex,
				v33.Background4Hex,
				18
			)

			if v9 ~= "" and packageContentsDesc ~= "" then
				v9 ..= "<br><br>"
			end

			v9 ..= packageContentsDesc
		end

		local v44

		if not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData)) then
			local v45, v46
			v45, v44, v46 = module5.GetCompatWarning(
				mMovie,
				storeItem,
				gGameRules:__wf_atom_964056fd(),
				gGameData:GetInventory(),
				{
					Items = infoPopup_Grid.PurchasedItems,
					Dictionary = infoPopup_Grid.PurchasedIsDictionary
				},
				true
			)
		end

		if v44 ~= nil and v44 ~= "" then
			if v9 ~= "" then
				v9 ..= "<br><br>"
			end

			v9 ..= mMovie:__wf_atom_8e9ac384("<WARNING>", true) .. " " .. v44
		end
	end

	if __wf_atom_7e8ad928(v2.mMod) then
		if v2.mModDescOverride == nil then
			if v2.ArcaneRank ~= nil then
				if v2.CompatLabel ~= nil then
					v9 ..= v2.CompatLabel .. "<br><br>"
				end

				local arcaneMaxRank = v2.ArcaneRank < 0 and v2.ArcaneMaxRank or v2.ArcaneRank
				local v44 = module3.Ternary(
					arcaneMaxRank == 0,
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false),
					mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
						RANK = arcaneMaxRank
					})
				) .. "  "
				local v45 = ""
				local mInstance = nil

				if __wf_atom_7e8ad928(v2.Arcane) then
					if
						not __wf_atom_7e8ad928(storeItem)
						and not __wf_atom_7e8ad928(storeItem:GetItem())
						and storeItem:GetItem():IsA(__wf_atom_58a409f1)
					then
						local upgradeInfo = SF.UpgradeInfo()
						upgradeInfo.mItemType = storeItem:GetItem()
						mInstance = upgradeInfo.mInstance
					end
				else
					mInstance = v2.Arcane.mInstance
				end

				if not __wf_atom_7e8ad928(mInstance) then
					local __wf_atom_254ac1f5 = mInstance:__wf_atom_254ac1f5(arcaneMaxRank)
					v45 = mMovie:__wf_atom_8e9ac384(mInstance:__wf_atom_f324d993(__wf_atom_254ac1f5), true)
				end

				if v2.ShowAllRanks then
					v9 ..= module5.GetUpgradeInfo(
						mMovie,
						storeItem,
						v33.FloatingContentHighlightHex,
						v33.FloatingContentHex,
						" ",
						""
					)
				else
					v9 ..= "<font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v44 .. "</font><font color=\"" .. v33.FloatingContentHex .. "\">" .. v45 .. "</font>"
				end
			end
		else
			v9 ..= v2.mModDescOverride
		end
	else
		v9 ..= v2.mMod.Card.mDesc
	end

	local v44 = p2 < v6

	if v44 then
		v6 += 6
	else
		v6 -= 11
	end

	mMovie:__wf_atom_e57658c2("Popup.TagSeparator", 1, v6)

	if v2.CustomEntry and v2.RankedProgress ~= nil then
		module11.DrawRankIndicator(mMovie, "Popup.RankedProgress.Rank", {
			Level = v2.RankedProgress.Rank
		})
		mMovie:OverrideMaterial("Popup.RankedProgress.Bar.Fill", _G.UIMaterial_RectangleNoDepth)
		mMovie:OverrideMaterial("Popup.RankedProgress.Bar.Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_e57658c2("Popup.RankedProgress.Title", 44, v33.FloatingContent)
		mMovie:__wf_atom_e57658c2("Popup.RankedProgress.Progress", 44, v33.FloatingContentHighlight)
		local background1RGB = v33.Background1RGB
		local floatingContentRGB = v33.FloatingContentRGB
		mMovie:__wf_atom_1ca72041(
			"Popup.RankedProgress.Bar.Fill",
			"RectInnerColor",
			floatingContentRGB.r,
			floatingContentRGB.g,
			floatingContentRGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			"Popup.RankedProgress.Bar.Fill",
			"RectEdgeColor",
			floatingContentRGB.r,
			floatingContentRGB.g,
			floatingContentRGB.b,
			1
		)
		mMovie:__wf_atom_1ca72041(
			"Popup.RankedProgress.Bar.Bg",
			"RectInnerColor",
			background1RGB.r,
			background1RGB.g,
			background1RGB.b,
			0
		)
		mMovie:__wf_atom_1ca72041(
			"Popup.RankedProgress.Bar.Bg",
			"RectEdgeColor",
			floatingContentRGB.r,
			floatingContentRGB.g,
			floatingContentRGB.b,
			1
		)
		mMovie:__wf_atom_e57658c2("Popup.RankedProgress.Bar.Bg", 14, 256)
		mMovie:__wf_atom_e57658c2(
			"Popup.RankedProgress.Bar.Fill",
			14,
			(math.max(
				252 * (math.min(v2.RankedProgress.Progress, v2.RankedProgress.Required) / v2.RankedProgress.Required),
				0.1
			))
		)
		mMovie:__wf_atom_e57658c2("Popup.RankedProgress.Progress", 14, 256)
		mMovie:__wf_atom_50d60589("Popup.RankedProgress.Title", 36, v2.RankedProgress.Name)
		mMovie:__wf_atom_50d60589(
			"Popup.RankedProgress.Progress",
			36,
			v2.RankedProgress.ProgressPrefix .. module3.FormatNumber(v2.RankedProgress.Progress) .. "/" .. module3.FormatNumber(v2.RankedProgress.Required)
		)
		mMovie:__wf_atom_2dedec1a("Popup.RankedProgress", 13, true)
		mMovie:__wf_atom_e57658c2("Popup.RankedProgress", 1, v6)
		v6 += 64
	end

	local v45 = v2.PreviewImage ~= nil

	if v45 then
		mMovie:__wf_atom_e57658c2("Popup.VideoPreview", 1, v6)
		mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Mask", 14, 330)
		mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Mask", 15, 185)

		if v2.PreviewImage:IsA(__wf_atom_8a33958d) then
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 1, 0)
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 14, 330)
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 15, 185)
		else
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 1, -30)
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 14, 330)
			mMovie:__wf_atom_e57658c2("Popup.VideoPreview.Image", 15, 330)
			mMovie:OverrideMaterial("Popup.VideoPreview.Image", parallaxIconMaterial)
			mMovie:__wf_atom_1ca72041("Popup.VideoPreview.Image", "DetailMapParams", 0, 0, 1, 1)
			mMovie:__wf_atom_1ca72041("Popup.VideoPreview.Image", "BlendOffsetParallax", 1, 0.5, 1, 0.025)
			mMovie:__wf_atom_1ca72041("Popup.VideoPreview.Image", "TintColor", 1, 1, 1, 0)
			local v46 = v2.AutoParallaxX and 1 or 0
			local v47 = v2.AutoParallaxY and 1 or 0
			mMovie:__wf_atom_1ca72041("Popup.VideoPreview.Image", "AutoOffsetParallax", v46, v47, 1, 0)
		end

		local v46 = not __wf_atom_1ef90898(v2.PreviewImage)
		mMovie:__wf_atom_2dedec1a("Popup.VideoPreview.Image", 13, v46)

		if v46 then
			if v2.SkipVideoReset then
				mMovie:__wf_atom_c90af43a("Popup.VideoPreview.Image", v2.PreviewImage)
				v2.SkipVideoReset = nil
			else
				mMovie:__wf_atom_3f8dd1de("Popup.VideoPreview.Image")
				mMovie:__wf_atom_c90af43a("Popup.VideoPreview.Image", v2.PreviewImage)
				mMovie:__wf_atom_e3debc9a("Popup.VideoPreview.Image")
			end
		else
			v19:SetActive(true)
			mMovie:__wf_atom_e57658c2("Popup.Spinner", 1, v5 + 93)
		end

		v6 = v6 + 185 + 6
	else
		v6 += 10
	end

	mMovie:__wf_atom_2dedec1a("Popup.VideoPreview", 13, v45)
	mMovie:__wf_atom_e57658c2("Popup.Description", 1, v6)

	if v11 ~= 0 then
		mDesc = "\r\n\r\n" .. mDesc
	end

	mMovie:__wf_atom_50d60589(
		"Popup.Description",
		36,
		"<p><font color=\"" .. v33.ContentHex .. "\">" .. v9 .. mDesc .. "</font></p>"
	)

	if v9 == "" then
		v44 = false
		v6 -= 21
	else
		v6 += mMovie:__wf_atom_5e6e15c8("Popup.Description", 41)
	end

	mMovie:__wf_atom_2dedec1a("Popup.TagSeparator", 13, v44)
	mMovie:__wf_atom_2dedec1a("Popup.CrewMemberInfo", 13, v2.CrewMemberInfo ~= nil)

	if v2.CrewMemberInfo ~= nil then
		fn14(p3, v2.CrewMemberInfo:__wf_atom_894dc31a())
	end

	mMovie:__wf_atom_2dedec1a("Popup.ExtraDesc", 13, v2.ExtraDesc ~= nil)

	if v2.ExtraDesc ~= nil then
		mMovie:OverrideMaterial("Popup.ExtraDesc.Bg", _G.UIMaterial_RectangleNoDepth)
		local background1RGB = v33.Background1RGB
		local floatingContentRGB = v33.FloatingContentRGB
		mMovie:__wf_atom_1ca72041(
			"Popup.ExtraDesc.Bg",
			"RectInnerColor",
			background1RGB.r,
			background1RGB.g,
			background1RGB.b,
			0.2
		)
		mMovie:__wf_atom_1ca72041(
			"Popup.ExtraDesc.Bg",
			"RectEdgeColor",
			floatingContentRGB.r,
			floatingContentRGB.g,
			floatingContentRGB.b,
			0.7
		)
		mMovie:__wf_atom_c90af43a("Popup.ExtraDesc.Icon", v2.ExtraDesc.Icon)
		mMovie:__wf_atom_e57658c2("Popup.ExtraDesc.Icon", 11, v33.FloatingContentHighlight)
		mMovie:__wf_atom_50d60589("Popup.ExtraDesc.Title", 36, v2.ExtraDesc.Title)
		mMovie:__wf_atom_e57658c2("Popup.ExtraDesc.Title", 44, v33.FloatingContentHighlight)
		mMovie:__wf_atom_50d60589("Popup.ExtraDesc.Desc", 36, v2.ExtraDesc.Desc)
		mMovie:__wf_atom_e57658c2("Popup.ExtraDesc.Desc", 44, v33.Content)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.ExtraDesc.Desc", 41)
		mMovie:__wf_atom_e57658c2("Popup.ExtraDesc.Bg", 15, __wf_atom_5e6e15c8 + 50)
		mMovie:__wf_atom_e57658c2("Popup.ExtraDesc", 1, v6 + 5)
		v6 = v6 + __wf_atom_5e6e15c8 + 55
	end

	mMovie:__wf_atom_2dedec1a("Popup.Invasion", 13, v2.SubInvasions ~= nil)

	if v2.SubInvasions ~= nil then
		local customEntry = v2.SubInvasions[1].CustomEntry
		v30.mForcedVerticalSeparation = module3.Ternary(customEntry, 50, 75)
		mMovie:__wf_atom_e57658c2("Popup.Invasion", 1, v6 + module3.Ternary(customEntry, -15, 5))
		v30:RemoveElements(true, true)

		for i = 1, #v2.SubInvasions do
			v30:AddElement(v2.SubInvasions[i], true)
		end

		v30:Redraw(nil, true, true)
		v6 += v30:GetHowManyElements() * v30.mForcedVerticalSeparation
	end

	if v2.RarityChances == nil then
		mMovie:__wf_atom_2dedec1a("Popup.RarityBar", 13, false)
	else
		mMovie:__wf_atom_2dedec1a("Popup.RarityBar", 13, true)
		module2.DrawRarityBar(mMovie, "Popup.RarityBar", v2.RarityChances, 330, barMaterial, 0, -16, 10, v6 + 30)
		v6 += 40
	end

	mMovie:__wf_atom_2dedec1a("Popup.Prerequisite", 13, v43)

	if v43 then
		mMovie:__wf_atom_e57658c2("Popup.Prerequisite", 1, v6 + 20)
		v6 += 123
		local mPrereqElement = v2.mPrereqElement
		mMovie:__wf_atom_c90af43a("Popup.Prerequisite.Icon", mPrereqElement.Icon)
		mMovie:OverrideMaterial("Popup.Prerequisite.Icon", mPrereqElement.Material)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.Prerequisite.Icon", 15)

		if not mPrereqElement.Themed then
			__wf_atom_5e6e15c8 *= 1.6
		end

		mMovie:__wf_atom_e57658c2("Popup.Prerequisite.Icon", 14, __wf_atom_5e6e15c8)
		local v47 = "<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. Localize("/Lotus/Language/Dojo/Prerequisite", {}) .. "</font></p>"
		mMovie:__wf_atom_50d60589("Popup.Prerequisite.Header", 36, v47)
		local v48 = "<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. "<font color=\"" .. v33.FloatingContentHex .. "\">" .. TitleCase(mPrereqElement.Name) .. "<br></font>"
		local v49

		if
			not __wf_atom_7e8ad928(mPrereqElement.mCompletionDate)
			and Engine.__wf_atom_db2b0cee(mPrereqElement.mCompletionDate) <= 0
		then
			v49 = v48 .. "<font color=\"" .. v33.PositiveHex .. "\">" .. mMovie:__wf_atom_8e9ac384("<CHECKMARK_NO_BORDER> ", true) .. "</font>" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Categories/RESEARCHED",
				true
			)
		else
			v49 = v48 .. "<font color=\"" .. v33.NegativeHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
				"<CHECKMARK_FAIL_NO_BORDER> ",
				true
			) .. "</font>" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_ResearchNotStarted", true)
		end

		local v50 = v49 .. "</font></p>"
		mMovie:__wf_atom_50d60589("Popup.Prerequisite.Name", 46, "center")
		mMovie:__wf_atom_50d60589("Popup.Prerequisite.Name", 36, v50)
		mMovie:__wf_atom_2dedec1a("Popup.Prerequisite.Bg", 13, not __wf_atom_7e8ad928(mPrereqElement.Background))
		mMovie:__wf_atom_c90af43a("Popup.Prerequisite.Bg", mPrereqElement.Background)
		mMovie:__wf_atom_e57658c2("Popup.Prerequisite.Bg", 11, v33.FloatingContent)
		mMovie:OverrideMaterial("Popup.Prerequisite.Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041("Popup.Prerequisite.Bg", "RectEdgeColor", 1, 1, 1, 0)
		mMovie:__wf_atom_1ca72041("Popup.Prerequisite.Bg", "RectInnerColor", 1, 1, 1, 1)
		local background1RGB = v33.Background1RGB
		local backerHighlightRGB = v33.BackerHighlightRGB
		mMovie:OverrideMaterial("Popup.Prerequisite.Border", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			"Popup.Prerequisite.Border",
			"RectEdgeColor",
			backerHighlightRGB.r,
			backerHighlightRGB.g,
			backerHighlightRGB.b,
			0.2
		)
		mMovie:__wf_atom_1ca72041(
			"Popup.Prerequisite.Border",
			"RectInnerColor",
			background1RGB.r,
			background1RGB.g,
			background1RGB.b,
			0.2
		)
	end

	local researched = not v2.HideRecipe and (v2.Researched or v2.InProgress or v43)
	mMovie:__wf_atom_2dedec1a("Popup.PrereqSeparator", 13, researched)

	if researched then
		mMovie:__wf_atom_e57658c2("Popup.PrereqSeparator", 1, v6 + 10)
		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.PrereqSeparator.Description", 41) + 21
	end

	mMovie:__wf_atom_2dedec1a("Popup.Ingredients", 13, v42)

	if v42 then
		mMovie:__wf_atom_e57658c2("Popup.Ingredients", 1, v6 + 10)
		local v47 = 0

		for _, mElement in ipairs(v23.mElements) do
			v47 = v47 + 5 + math.max(v23.mForcedVerticalSeparation, mElement.mHeight or 0)
		end

		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.Ingredients.ingredient", 1) + v47
	end

	local v47 = v42 and flag3
	mMovie:__wf_atom_2dedec1a("Popup.IngredientsSeparator", 13, v47)

	if v47 then
		mMovie:__wf_atom_e57658c2("Popup.IngredientsSeparator", 1, v6 + 10)
		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.IngredientsSeparator.Description", 41) + 21
	end

	mMovie:__wf_atom_2dedec1a("Popup.IngredientsSecondary", 13, flag3)

	if flag3 then
		mMovie:__wf_atom_e57658c2("Popup.IngredientsSecondary", 1, v6 + 10)
		local v48 = 0

		for _, mElement in ipairs(v24.mElements) do
			v48 = v48 + 5 + math.max(v24.mForcedVerticalSeparation, mElement.mHeight or 0)
		end

		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.IngredientsSecondary.ingredient", 1) + v48
	end

	if v2.CustomEntry and v2.Affiliations ~= nil then
		v6 += 10
		p4 = #v2.Affiliations

		for i = v14 + 1, p4 do
			local v48 = "Popup.Affiliation" .. i

			if not mMovie:__wf_atom_253d7085(v48) then
				__wf_atom_86cbd68d(mMovie, "Popup.Affiliation1.duplicateMovieClip", "Affiliation" .. i, i)
			end
		end

		if p4 < v14 then
			for i = math.max(p4 + 1, 2), v14 do
				__wf_atom_86cbd68d(mMovie, "Popup.Affiliation" .. i .. ".removeMovieClip")
			end
		end

		v14 = math.max(1, p4)

		for i, affiliation in ipairs(v2.Affiliations) do
			local v48 = "Popup.Affiliation" .. i
			mMovie:__wf_atom_2dedec1a(v48, 13, true)
			mMovie:__wf_atom_e57658c2(v48, 1, v6)
			local v49 = affiliation.Level >= 0
			mMovie:__wf_atom_7f57ab2f(v48, "Border", 13, false)
			mMovie:__wf_atom_7f57ab2f(v48, "Bg", 13, false)
			mMovie:__wf_atom_4c1c1986(v48, "Border", 14, v7)
			mMovie:__wf_atom_4c1c1986(v48, "Bg", 14, v7)
			mMovie:__wf_atom_4c1c1986(v48, "Border", 11, v33.Background1)
			mMovie:__wf_atom_933bbce0(v48 .. ".Bg", midBgTexture, midBgMaterial)
			mMovie:__wf_atom_1ca72041(
				v48 .. ".Bg",
				"StartColor",
				v33.Background1RGB.r,
				v33.Background1RGB.g,
				v33.Background1RGB.b,
				1
			)
			local ternary = module3.Ternary(v49, v33.PositiveRGB, v33.NegativeRGB)
			mMovie:__wf_atom_1ca72041(v48 .. ".Bg", "EndColor", ternary.r / 1, ternary.g / 1, ternary.b / 1, 1)
			mMovie:__wf_atom_c90af43a(v48 .. ".Icon", affiliation.Icon)
			mMovie:__wf_atom_4c1c1986(v48, "Icon", 11, v33.FloatingContentHighlight)
			mMovie:__wf_atom_4c1c1986(v48, "Name", 44, v33.Content)
			mMovie:__wf_atom_48bd5a59(v48, "Label", 36, affiliation.Label)
			local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(v48, "Label", 41)
			mMovie:__wf_atom_4c1c1986(v48, "Label", 1, 36 - __wf_atom_cfc41e35 / 2)
			v6 += module3.Ternary(i ~= #v2.Affiliations, 70, 60)
		end
	end

	if v2.IsAbility then
		local v48 = mDisplayStats
		local v49 = mDisplayStats
		local v50 = mDisplayStats
		local v51 = mDisplayStats
		local statsTextForAbility, values, baseValues, statChanges = module6.GetStatsTextForAbility(v2)
		v48.Labels = statsTextForAbility
		v49.Values = values
		v50.BaseValues = baseValues
		v51.StatChanges = statChanges
	elseif v2.mDisplayStats ~= nil then
		mDisplayStats = v2.mDisplayStats
	end

	return p, "", p4
end

local function fn26(value) -- 1 equivalent call inferred from this helper
	return string.gsub(value, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
end

fn = function()
	local v37

	if not (__wf_atom_7e8ad928(resultItemType) or state == v35.BASE and not v2.AllInOne and v2.Category ~= 43 and v2.Category ~= 46) then
		v37 = Resource(resultItemType)
	end

	if v2.IsAbility and not v2.AbilityInitialized then
		fn3(v37)
	end

	local infoPopup_Grid = _T.InfoPopup_Grid
	local storeItem = v2.StoreItem
	local mUpgradeType

	if not __wf_atom_7e8ad928(storeItem) then
		mUpgradeType = storeItem:__wf_atom_efa6f447()
	end

	local v39 = v5 + 10
	v6 = v39
	local v40 = state == v35.BASE or state == v35.INFO
	mMovie:__wf_atom_2dedec1a("Popup.TagSeparator", 13, state == v35.BASE)
	mMovie:__wf_atom_2dedec1a("Popup.Ingredients", 13, state == v35.CRAFTING)
	mMovie:__wf_atom_2dedec1a("Popup.IngredientsSeparator", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.IngredientsSecondary", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.PrereqSeparator", 13, state == v35.CRAFTING)
	mMovie:__wf_atom_2dedec1a("Popup.PrereqSeparator.Separator", 13, state ~= v35.CRAFTING)
	mMovie:__wf_atom_2dedec1a("Popup.Prerequisite", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.RankedProgress", 13, false)
	mMovie:__wf_atom_2dedec1a("Popup.Affiliation1", 13, false)
	local v41 = 1
	local v42 = 0
	local mDesc = ""
	v9 = ""
	v11 = 0
	total = 10
	mDisplayStats = {}
	mDisplayStats.Labels = {}
	mDisplayStats.Values = {}
	local ternary = module3.Ternary(v2.StatWeapon ~= nil, v2.StatWeapon, v37)

	if state == v35.STATS or v2.AllInOne and v3.mStatsAvailable then
		local ternary2 = module3.Ternary(v2.StatOwner ~= nil, v2.StatOwner, nil)
		local flag2 = true

		if __wf_atom_7e8ad928(v2.StatWeapon) then
			local modularType, _ = module9.GetModularType(resultItemType)

			if modularType == nil then
				if v2.IsAmp then
					local rawItem = v2.RawItem
					ternary = gRegion:CreateObject(Type(ternary), ternary2, 0)
					ternary:SetOwner(ternary2)
					ternary:__wf_atom_7514bb3f(rawItem.mModularParts, rawItem:__wf_atom_717d3c58(4))
				end
			else
				flag2 = false
			end
		end

		if flag2 then
			if not __wf_atom_7e8ad928(ternary) then
				mDisplayStats = module5.GetDisplayStats(
					ternary,
					true,
					ternary2,
					module3.Ternary(statId == nil, 1, statId)
				)
			end
		else
			mDisplayStats.Labels = { mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/StatsUnavailable", false) }
			mDisplayStats.Values = { "" }
		end

		if __wf_atom_7e8ad928(v2.StatWeapon) and v2.IsAmp then
			gRegion:__wf_atom_dd1e4d10(ternary)
			ternary = v37
		end

		mMovie:__wf_atom_e57658c2("Popup.ItemStats", 12, 0)
		__wf_atom_ec43d06e(mMovie, "Popup.ItemStats", 8, { 12 }, { 100 }, 0.2)
	end

	mDisplayStats.BaseValues = {}
	mDisplayStats.StatChanges = {}

	if
		__wf_atom_7e8ad928(v2.StatWeapon)
		and not __wf_atom_7e8ad928(ternary)
		and (v2.Category == 43 or v2.Category == 46)
	then
		local item = storeItem:GetItem()

		if __wf_atom_7e8ad928(v2.ResultItemType) then
			if v2.RawItem ~= nil then
				local rawItem = v2.RawItem

				if __wf_atom_7e8ad928(rawItem.mUpgradeType) and not __wf_atom_7e8ad928(rawItem.Item) then
					rawItem = rawItem.Item
				end

				if not __wf_atom_7e8ad928(rawItem.mUpgradeType) then
					local upgradeInfo = SF.UpgradeInfo()
					upgradeInfo.mItemType = rawItem.mUpgradeType
					item = upgradeInfo.mInstance
				end
			end
		else
			item = v2.ResultItemType
		end

		local v43 = Resource(item)
		local mUpgradeFingerprint

		if v2 == nil or v2.RawItem == nil then
			mUpgradeFingerprint = ""
		else
			mUpgradeFingerprint = v2.RawItem.mUpgradeFingerprint

			if #mUpgradeFingerprint == 0 and v2.RawItem.Item ~= nil then
				mUpgradeFingerprint = v2.RawItem.Item.mUpgradeFingerprint
			end
		end

		local v44 = mUpgradeFingerprint == nil and "" or mUpgradeFingerprint

		if not __wf_atom_7e8ad928(v43) and v43:IsA(__wf_atom_f8bb7ca2) then
			local __wf_atom_70b880cb = v43:__wf_atom_70b880cb(v44)
			local v45 = { mUpgradeType = mUpgradeType, mDesc = "" }
			module10.UpdateCrewShipCard(v45, __wf_atom_70b880cb, mMovie)
			mDesc = v45.mDesc

			if mDesc ~= "" then
				local v46 = StringSplit("\r\n", mDesc)
				local v47 = "%d*%.?%d+"
				local v48 = "%p*" .. v47 .. "[^%s]*"
				local bonusStats = { Values = {}, Labels = {}, CompareValues = {} }

				for i = 1, #v46 do
					local v50 = string.match(v46[i], v48) or 0
					table.insert(bonusStats.Values, v50)
					table.insert(bonusStats.CompareValues, (tonumber(string.match(v50, v47))))
					local v51 = fn26(v50) -- inferred equivalent call
					local v52 = string.gsub(v46[i], v51, "[STAT]")
					table.insert(bonusStats.Labels, v52)
				end

				mDisplayStats.BonusStats = bonusStats
			end
		end
	end

	if state == v35.BASE then
		v41, mDesc, v42 = fn25(infoPopup_Grid, v41, storeItem, mDesc, mUpgradeType, v39, v37, v42)
	elseif state == v35.CRAFTING then
		v6 -= 13
		mMovie:__wf_atom_e57658c2("Popup.PrereqSeparator", 1, v6)
		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.PrereqSeparator.Description", 41) + 21
		fn24()
		mMovie:__wf_atom_e57658c2("Popup.Ingredients", 1, v6)
		local v43 = 0

		for _, mElement in ipairs(v23.mElements) do
			v43 = v43 + 5 + math.max(v23.mForcedVerticalSeparation, mElement.mHeight or 0)
		end

		v6 = v6 + mMovie:__wf_atom_5e6e15c8("Popup.Ingredients.ingredient", 1) + v43 - 10
	elseif state == v35.INFO then
		if not __wf_atom_7e8ad928(infoPopup_Grid) and infoPopup_Grid.AdditionalTabInfo ~= nil then
			v9 = infoPopup_Grid.AdditionalTabInfo(v2)
		end

		if type(v9) ~= "string" then
			print("AdditionalTabInfo returned " .. type(v9) .. ", should be string")
			v9 = ""
		end

		v6 -= 2
		mMovie:__wf_atom_e57658c2("Popup.Description", 1, v6)
		mMovie:__wf_atom_50d60589(
			"Popup.Description",
			36,
			"<p><font color=\"" .. v33.ContentHex .. "\">" .. v9 .. "</font></p>"
		)

		if v9 == "" then
			v6 -= 17
		else
			v6 += mMovie:__wf_atom_5e6e15c8("Popup.Description", 41)
		end
	end

	local v43 = state == v35.ABILITIES or (v2.AllInOne and v3.mAbilitiesAvailable) == true
	mMovie:__wf_atom_2dedec1a("Popup.AbilityInfo", 13, v43)

	if v43 then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Popup.AbilityInfo.Ability1", 1)
		mMovie:__wf_atom_e57658c2("Popup.AbilityInfo", 1, v6)
		local mStats = module6.GetPowerSuitStats(mMovie, nil, v37).mStats

		if v2.mIsNemesis then
			local abilityType = Resource(v2.mExtraAbility)

			if not __wf_atom_7e8ad928(abilityType) then
				mStats.Ability4 = mMovie:__wf_atom_8e9ac384(abilityType:__wf_atom_014a76a2():c_str(), false)
				mStats.AbilityDescription4 = mMovie:__wf_atom_8e9ac384(abilityType:__wf_atom_3a3d2e39():c_str(), true)
				mStats.AbilityIcon4 = abilityType:GetIconTexture()
				mStats.AbilityType4 = abilityType
			end
		end

		for i = 1, 4 do
			local v44 = "Popup.AbilityInfo.Ability" .. tostring(i)

			if mStats["Ability" .. i] == nil then
				continue
			end

			mMovie:__wf_atom_e57658c2(v44, 1, __wf_atom_5e6e15c8)
			mMovie:__wf_atom_50d60589(v44 .. ".Name", 36, mStats["Ability" .. i])
			module3.SetFitText(mMovie, v44 .. ".Description", "...")
			mMovie:__wf_atom_4c1c1986(v44, "Description", 92, 6)
			mMovie:__wf_atom_50d60589(v44 .. ".Description", 36, mStats["AbilityDescription" .. i])
			local mStat = mStats["AbilityIcon" .. i]
			mMovie:__wf_atom_c90af43a(v44 .. ".Icon", mStat)
			mMovie:__wf_atom_7f57ab2f(v44, "Icon", 13, not __wf_atom_7e8ad928(mStat))
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v44 .. ".Name", 41)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v44 .. ".Description", 41)
			__wf_atom_5e6e15c8 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 + 20
		end

		local v44 = __wf_atom_5e6e15c8 + 4
		local v45 = (__wf_atom_7e8ad928(gRegion) or v2.mIsNemesis) and ""
			or module8.GetPassiveDescription(mMovie, gRegion:__wf_atom_c4f78a8f(), v37)
		local v46 = v45 ~= ""
		mMovie:__wf_atom_2dedec1a("Popup.AbilityInfo.Passive", 13, v46)
		mMovie:__wf_atom_2dedec1a("Popup.AbilityInfo.PassiveSeparator", 13, v46)

		if v46 then
			mMovie:__wf_atom_7d7314f1("Popup.AbilityInfo.Passive.Name.text", "/Lotus/Language/Menu/Ability_Passive")
			module3.SetFitText(mMovie, "Popup.AbilityInfo.Passive.Description", "...")
			mMovie:__wf_atom_e57658c2("Popup.AbilityInfo.Passive.Description", 92, 6)
			mMovie:__wf_atom_50d60589("Popup.AbilityInfo.Passive.Description", 36, v45)
			mMovie:__wf_atom_e57658c2("Popup.AbilityInfo.PassiveSeparator", 1, v44)
			mMovie:__wf_atom_e57658c2("Popup.AbilityInfo.Passive", 1, v44 + 12)
		end

		v6 = v6 + v44 + module3.Ternary(
			v46,
			mMovie:__wf_atom_5e6e15c8("Popup.AbilityInfo.Passive.Description", 41) + 38,
			-20
		)
	end

	if mDesc ~= "" then
		if state == v35.STATS then
			mMovie:__wf_atom_e57658c2("Popup.Description", 1, v6)
			v6 += 5
		end

		mMovie:__wf_atom_50d60589(
			"Popup.Description",
			36,
			"<p><font color=\"" .. v33.ContentHex .. "\">" .. mDesc .. "</font></p>"
		)
		v6 += mMovie:__wf_atom_5e6e15c8("Popup.Description", 41)
		v40 = true
	end

	if v14 > 1 then
		for i = math.max(v42 + 1, 2), v14 do
			__wf_atom_86cbd68d(mMovie, "Popup.Affiliation" .. i .. ".removeMovieClip")
		end

		v14 = math.max(1, v42)
	end

	local v44 = false

	if #mDisplayStats.Labels > 0 then
		if state ~= v35.STATS then
			v6 += 23
		end

		local v45 = v13

		if type(mDisplayStats.Labels) == "table" then
			v13 = #mDisplayStats.Labels
			local total2 = 0

			for i = 1, v13 do
				local v46 = "Popup.ItemStats.Item" .. i

				if not mMovie:__wf_atom_253d7085(v46) then
					__wf_atom_86cbd68d(mMovie, "Popup.ItemStats.Item1.duplicateMovieClip", "Item" .. i, i)
				end

				local label = mDisplayStats.Labels[i]
				local v47 = fn5(
					mDisplayStats.Values[i],
					mDisplayStats.BaseValues[i],
					mDisplayStats.StatChanges[i],
					true
				)
				mMovie:__wf_atom_e57658c2(v46, 1, total2)
				mMovie:__wf_atom_4c1c1986(v46, "Backer", 12, 35 - i % 2 * 35)
				mMovie:__wf_atom_4c1c1986(v46, "Backer", 1, 1)
				mMovie:__wf_atom_7f57ab2f(v46, "Labels", 52, false)
				mMovie:__wf_atom_50d60589(v46 .. ".Labels", 36, label)
				mMovie:__wf_atom_50d60589(v46 .. ".Stats", 36, v47)
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v46 .. ".Labels", 40)
				local v48 = 330 - (mMovie:__wf_atom_5e6e15c8(v46 .. ".Stats", 40) + 20)
				local v49

				if mDisplayStats.Values[i] == "" or not (v48 < __wf_atom_5e6e15c8) then
					v49 = 1
				else
					mMovie:__wf_atom_7f57ab2f(v46, "Stats", 52, true)
					mMovie:__wf_atom_4c1c1986(v46, "Stats", 0, 0)
					mMovie:__wf_atom_4c1c1986(v46, "Stats", 14, 330)
					mMovie:__wf_atom_50d60589(v46 .. ".Stats", 36, "\r\n" .. v47)
					v49 = mMovie:__wf_atom_5e6e15c8(v46 .. ".Stats", 43)
				end

				local v50 = v49 * 23

				if #label == 0 then
					v50 = 16
				else
					mMovie:__wf_atom_4c1c1986(v46, "Stats", 1, (v49 - 1) * 23 + 2)
				end

				mMovie:__wf_atom_4c1c1986(v46, "Backer", 15, v50)
				total2 += v50
			end

			if not __wf_atom_7e8ad928(_T.ItemInfoStatComparison) then
				if flag then
					_T.ItemInfoStatComparison()
				else
					_T.ItemInfoStatComparison(mDisplayStats, fn6)
				end
			end
		else
			v13 = 1
			mMovie:__wf_atom_e57658c2("Popup.ItemStats.Item1.Backer", 12, 0)
			mMovie:__wf_atom_50d60589("Popup.ItemStats.Item1.Labels", 36, mDisplayStats.Labels)
			mMovie:__wf_atom_50d60589("Popup.ItemStats.Item1.Stats", 36, mDisplayStats.Values)
		end

		v44 = v13 > 0

		for i = math.max(v13 + 1, 2), v45 do
			__wf_atom_86cbd68d(mMovie, "Popup.ItemStats.Item" .. i .. ".removeMovieClip")
		end
	elseif
		mDisplayStats.BonusStats ~= nil
		and #mDisplayStats.BonusStats.Labels > 0
		and not __wf_atom_7e8ad928(_T.ItemInfoStatComparison)
	then
		if flag then
			_T.ItemInfoStatComparison()
		else
			_T.ItemInfoStatComparison(mDisplayStats, fn6)
		end
	end

	mMovie:__wf_atom_2dedec1a("Popup.Description", 13, v40)
	mMovie:__wf_atom_2dedec1a("Popup.ItemStats", 13, v44)

	if v44 then
		mMovie:__wf_atom_e57658c2("Popup.ItemStats", 1, v6)
		v6 += mMovie:__wf_atom_5e6e15c8("Popup.ItemStats", 15)
	end

	fn19(v41)
	local ternary2 = module3.Ternary
	local infoPopup_Grid2 = _T.InfoPopup_Grid
	local canPreviewElements

	if infoPopup_Grid2 == nil then
		canPreviewElements = false
	else
		canPreviewElements = infoPopup_Grid2.CanPreviewElements
	end

	if v2 ~= nil and v2.CanPreviewOverride ~= nil then
		canPreviewElements = canPreviewElements and v2.CanPreviewOverride
	end

	if not canPreviewElements then
		if v2 == nil then
			canPreviewElements = false
		else
			canPreviewElements = v2.mUnequipItem ~= nil
		end
	end

	local v46 = 7 + ternary2(canPreviewElements, 25, 0)
	v6 = v6 + 21 + v46
	fn20(v46)
end

local function fn27()
	local v37 = v32 ~= ""
	mMovie:__wf_atom_2dedec1a("Popup.Header", 13, v37)
	v8 = v37 and 22 or 0
	mMovie:__wf_atom_e57658c2("Popup.Header.Label", 14, 330)
	mMovie:__wf_atom_50d60589("Popup.Header.Label", 36, v32)
	local infoPopup_Grid = _T.InfoPopup_Grid
	v10 = module2.GetGridItemName(mMovie, infoPopup_Grid, v2, v2.MetaData)

	if v10 ~= "" and v2.IsEliteCrewMember then
		v10 ..= mMovie:__wf_atom_8e9ac384(" <ELITE_CREW_MEMBER>", true)
	end

	v6 = 0
	v5 = 0
	fn22(infoPopup_Grid)
	local v38 = not (v3:GetHowManyElements() > 1) and 0
		or 5 + (mMovie:__wf_atom_5e6e15c8("Popup.InfoToggle.Callout", 40) or 0) + v3.mForcedHorizontalSeparation * v3:GetHowManyElements()
	mMovie:__wf_atom_e57658c2("Popup.Title", 14, 330)
	mMovie:__wf_atom_50d60589(
		"Popup.Title",
		36,
		"<p><font color=\"" .. v33.FloatingContentHighlightHex .. "\">" .. v10 .. "</font></p>"
	)

	if v10 == "" then
		v5 += 21
	else
		v5 = v5 + mMovie:__wf_atom_5e6e15c8("Popup.Title", 41) + 3

		if mMovie:__wf_atom_5e6e15c8("Popup.Title", 94) + v38 > 330 then
			v5 += 20
		end

		mMovie:__wf_atom_e57658c2("Popup.InfoToggle", 1, v5)
		v5 += 25
	end

	fn9()
	local subtitleOverride = nil

	if v2.BuySlot and not v2.Disabled then
		local emptyCount = v2.EmptyCount

		if v2.MaxCount == nil then
			if emptyCount == 1 then
				subtitleOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlot", true)
			else
				subtitleOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlots", true, {
					free = emptyCount
				})
			end
		else
			subtitleOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_LimitedExtraSlots", true, {
				CUR = emptyCount,
				MAX = v2.MaxCount
			})
		end
	elseif v2.IsAbility then
		subtitleOverride = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", true, {
			RANK = v2.Level
		}))

		if v2.Locked then
			subtitleOverride ..= mMovie:__wf_atom_8e9ac384("<LOCKED>", true)
		end
	elseif v2.IsPAUpgrade then
		subtitleOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/PrimeStore/PrimeAccessUpgradeSubtitle", true)
	elseif v2.WeeklyLocked then
		subtitleOverride = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Store/PerWeekPurchase", false)
	elseif v2.SubtitleOverride then
		subtitleOverride = v2.SubtitleOverride
	end

	local v40 = subtitleOverride ~= nil
	mMovie:__wf_atom_2dedec1a("Popup.Subtitle", 13, v40)

	if v40 then
		mMovie:__wf_atom_e57658c2("Popup.Subtitle", 1, v5 - 8)
		mMovie:__wf_atom_50d60589("Popup.Subtitle", 36, subtitleOverride)
		v5 += mMovie:__wf_atom_5e6e15c8("Popup.Subtitle", 41)
	end

	if v2.DefaultItemInfoTab == nil or v3:GetElementInIndex(v2.DefaultItemInfoTab) == nil then
		v3:FocusElement(1)
	else
		v3:FocusElement(v2.DefaultItemInfoTab)
	end

	v3:SelectCurrentElement()
	local infoPopup_Grid2 = _T.InfoPopup_Grid
	local canPreviewElements

	if infoPopup_Grid2 == nil then
		canPreviewElements = false
	else
		canPreviewElements = infoPopup_Grid2.CanPreviewElements
	end

	if v2 ~= nil and v2.CanPreviewOverride ~= nil then
		canPreviewElements = canPreviewElements and v2.CanPreviewOverride
	end

	if not canPreviewElements then
		if v2 == nil then
			canPreviewElements = false
		else
			canPreviewElements = v2.mUnequipItem ~= nil
		end
	end

	mMovie:__wf_atom_2dedec1a("Popup.PreviewTag", 13, canPreviewElements)
	mMovie:__wf_atom_2dedec1a("Popup.PreviewCallout", 13, canPreviewElements)
end

local function fn28()
	mMovie:__wf_atom_e57658c2("Popup", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Popup", 1, { 12 }, { 100 }, 0.34)
end

fn3 = function(resource, p)
	if v2.AbilityInitialized or __wf_atom_7e8ad928(resource) then
		return
	end

	local suit = nil

	if __wf_atom_7e8ad928(p) then
		if not __wf_atom_7e8ad928(v2.Suit) then
			suit = v2.Suit

			if __wf_atom_1ef90898(suit) then
				suit = Resource(suit)
			end
		end
	else
		suit = p
	end

	local module13 = require("Lotus.Powersuits.PowersuitAbilities.PVPLib")
	local __wf_atom_fbc08c87 = resource:__wf_atom_fbc08c87()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(resource:__wf_atom_014a76a2():c_str(), false)
	local description

	if v2.ForceOverrideDesc and resource:__wf_atom_64741537() ~= EMPTY_SYMBOL then
		description = resource:__wf_atom_64741537():c_str()
	else
		description = resource:__wf_atom_3a3d2e39():c_str()
	end

	if module13.IsPvpEnabled() then
		local __wf_atom_b805f0a2 = resource:__wf_atom_b805f0a2()

		if string.len(__wf_atom_b805f0a2) ~= 0 then
			description = __wf_atom_b805f0a2
		end
	end

	local iconTexture = resource:GetIconTexture()
	local autoParallaxX = true

	if not __wf_atom_7e8ad928(suit) then
		for _, className in ipairs(verticalParallaxFrameTypes) do
			if not suit:IsA(className) then
				continue
			end

			autoParallaxX = false
			break
		end
	end

	if __wf_atom_7e8ad928(v2.ResLoader) and not __wf_atom_7e8ad928(__wf_atom_fbc08c87) then
		v2.ResLoader = UISys.__wf_atom_c0dbe47c({ __wf_atom_fbc08c87:__wf_atom_5b41f63b() })
		v2.ResLoading = true
	end

	v2.Name = __wf_atom_8e9ac384
	v2.Description = description
	v2.LocalizedDesc = mMovie:__wf_atom_8e9ac384(description, true)
	v2.Energy = resource:__wf_atom_cb2fe64e(true, false)
	v2.BaseEnergy = resource:__wf_atom_cb2fe64e(false, false)
	v2.Icon = iconTexture
	v2.PreviewImage = __wf_atom_fbc08c87
	v2.MaxLevel = 3
	v2.Script = resource:__wf_atom_d67bb5bf()
	v2.LocTag = resource:__wf_atom_014a76a2()
	v2.Resource = resource
	v2.AutoParallaxX = autoParallaxX
	v2.AutoParallaxY = not autoParallaxX
	local abilityLevelOverride = nil

	if v2.AbilityLevelOverride == nil then
		if not (__wf_atom_7e8ad928(suit) or __wf_atom_7e8ad928(v2.AbilityIndex)) then
			abilityLevelOverride = suit:__wf_atom_cc3c265a(v2.AbilityIndex) - 1
		end
	else
		abilityLevelOverride = v2.AbilityLevelOverride
	end

	local nextSuitLevel = 0
	v2.Locked = false

	if abilityLevelOverride ~= nil then
		v2.Level = math.max(0, abilityLevelOverride)

		if not __wf_atom_7e8ad928(suit) then
			local __wf_atom_22941262 = suit:__wf_atom_22941262()
			nextSuitLevel = suit:__wf_atom_87c63382(v2.AbilityIndex)
			v2.Locked = __wf_atom_22941262 < nextSuitLevel
		end
	end

	v2.IsAbility = true

	if not v2.HideRankUp then
		if v2.Locked then
			v2.NextSuitLevel = nextSuitLevel
			v2.LastSuitLevel = 0
		elseif not __wf_atom_7e8ad928(suit) then
			v2.NextSuitLevel = suit:__wf_atom_d14dd4cc(v2.AbilityIndex, v2.Level + 2)
			v2.LastSuitLevel = suit:__wf_atom_d14dd4cc(v2.AbilityIndex, v2.Level + 1)

			if v2.NextSuitLevel == 255 then
				v2.NextSuitLevel = nil
			end
		end

		if v2.NextSuitLevel ~= nil then
			local __wf_atom_6480316c = __wf_atom_c67f9605:__wf_atom_6480316c(v2.LastSuitLevel, suit)
			local v40 = suit:__wf_atom_9765cbd5() - __wf_atom_6480316c
			local v41 = __wf_atom_c67f9605:__wf_atom_6480316c(v2.NextSuitLevel, suit) - __wf_atom_6480316c
			v2.LevelProgress = v40 / v41
		end
	end

	v2.AbilityInitialized = true
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v37 = __wf_atom_fa1258d0()

	if not __wf_atom_7e8ad928(v18) then
		v18:Update(v37)
	end

	mMovie:__wf_atom_88d9cd84(v37)

	if not __wf_atom_7e8ad928(v19) then
		v19:Update()
	end

	if v34 and not flag then
		return
	end

	local v38 = _T["InfoPopup_Data" .. v31]

	if v38 ~= nil then
		if v38.StoreItem == nil then
			v38.StoreItem = v38.mStoreItem
		end

		if v38.StoreItem == nil and v38.CodexEntry == nil and not v38.CustomEntry then
			v38 = nil
		end
	end

	if v2 == nil and v38 == nil then
		return
	end

	local v39 = _T.RadialSolarMapOpen == true or not __wf_atom_7e8ad928(_T.ShawzinMovie)

	if v22 ~= v39 then
		v22 = v39
		mMovie:__wf_atom_f0448d34(v22)
	end

	if v20 and not __wf_atom_7e8ad928(v21) and v21:__wf_atom_86399a47() then
		fn2(false)
		fn()
	end

	if v2 ~= v38 or v38 ~= nil and v38.Refresh then
		local v40 = v38 == nil or v2 ~= nil
		v2 = v38
		v18:RemoveTimer(v17)
		v19:SetActive(false)
		resultItemType = nil
		v12 = 1
		v29 = false

		if v2 ~= nil then
			local mApplyThemes = v2.mApplyThemes

			if v36 ~= mApplyThemes then
				v36 = mApplyThemes
				fn7()
			end

			v2.Movie = mMovie
			v2.CompareHeight = 0
			local v41 = not v2.Refresh

			if v2.Refresh then
				v2.Refresh = nil

				if v2.IsAbility then
					v2.SkipVideoReset = true
				end

				v40 = false
			end

			if v2.IsAbility and not v2.AbilityInitialized then
				if __wf_atom_7e8ad928(v2.Suit) and not __wf_atom_7e8ad928(v2.SourceAvatar) then
					if v2.SourceAvatarAlternateSuit then
						v2.Suit = v2.SourceAvatar:__wf_atom_d2b2176d():__wf_atom_f7583f71()
					else
						v2.Suit = v2.SourceAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
					end
				end

				local resource = v2.Resource
				local suit

				if not __wf_atom_7e8ad928(v2.Suit) then
					suit = v2.Suit

					if __wf_atom_1ef90898(suit) then
						suit = Resource(suit)
					end
				end

				if
					__wf_atom_7e8ad928(resource)
					and not (__wf_atom_7e8ad928(v2.AbilityIndex) or __wf_atom_7e8ad928(suit))
				then
					resource = suit:__wf_atom_c497b0ae(v2.AbilityIndex)
				end

				if not __wf_atom_7e8ad928(resource) then
					if __wf_atom_1ef90898(resource) then
						v2.AllInOne = true
						v2.ResultItemType = resource
					else
						fn3(resource, suit)
					end
				end
			end

			if __wf_atom_7e8ad928(v2.CrewMemberInfo) then
				if __wf_atom_7e8ad928(v2.StoreItem) then
					resultItemType = v2.ResultItemType
				else
					local storeItem = v2.StoreItem
					v12 = math.max(storeItem:__wf_atom_22083c3e(), v12)

					if storeItem:IsA(__wf_atom_39c4c96b) and storeItem:__wf_atom_3d753d93() then
						v12 -= 1
					end

					if storeItem:IsA(__wf_atom_bf37f5ca) then
						resultItemType = storeItem:__wf_atom_c5566ef8()
					else
						resultItemType = storeItem:GetItem()
					end
				end
			else
				resultItemType = v2.CrewMemberInfo.mPowersuitInfo.mItemType
				v2.AllInOne = not v2.CrewMemberInfo:__wf_atom_894dc31a()
			end

			v17 = v18:AddTimer(0.01, function()
				v17 = nil
				module3.PlaySound(_G.UISound_ItemTip)
				fn27()
				v34 = false
				mMovie:SetVisible(true)

				if v41 then
					fn28()
				end
			end)

			if v2.MetaData == nil then
				v2.MetaData = { HideOwned = true }
			else
				v2.MetaData.HideOwned = true
				v2.MetaData.ShowCheckmark = nil
			end
		end

		if v40 then
			fn4()
		end

		local v41 = v2 ~= nil
		mMovie:__wf_atom_c884ca43(not v41)
		mMovie:__wf_atom_b4ffb30f(v41)
	end

	if v2 ~= nil then
		if v29 and not __wf_atom_7e8ad928(v2.StoreItem) then
			fn23()
		end

		if v2.RarityChances ~= nil then
			v27.x = (v37 / 2 + v27.x) % 1
			v27.y = (-v37 / 40 + v27.y) % 1
			module2.UpdateRarityBar(mMovie, "Popup.RarityBar", v27, false)
		end

		if v2.ResLoading and v2.ResLoader:__wf_atom_86399a47() then
			print("loader done")
			v19:SetActive(false)
			v2.ResLoading = false
			v2.PreviewImage = Resource(v2.PreviewImage)
			mMovie:__wf_atom_2dedec1a("Popup.VideoPreview.Image", 13, true)
			mMovie:__wf_atom_3f8dd1de("Popup.VideoPreview.Image")
			mMovie:__wf_atom_c90af43a("Popup.VideoPreview.Image", v2.PreviewImage)
			mMovie:__wf_atom_e3debc9a("Popup.VideoPreview.Image")
		end

		if not v18:HasTimer(v17) then
			local infoPopup_Data = _T.InfoPopup_Data

			if infoPopup_Data ~= nil then
				local rect = infoPopup_Data.Rect
				local __wf_atom_97cd8326 = mMovie:__wf_atom_97cd8326()
				local __wf_atom_54eeda24 = mMovie:__wf_atom_54eeda24()
				local infoPopup_Grid = _T.InfoPopup_Grid
				local v40 = (infoPopup_Grid == nil or infoPopup_Grid.PopupPadding == nil) and 10
					or infoPopup_Grid.PopupPadding
				local v41

				if rect.UseCursor then
					local __wf_atom_68d996b1 = mMovie:__wf_atom_68d996b1()
					local v42 = __wf_atom_97cd8326 / __wf_atom_68d996b1 / mMovie:__wf_atom_d5a50cb5()
					local v43 = __wf_atom_54eeda24 / __wf_atom_68d996b1 / mMovie:__wf_atom_c4f6543f()

					if v43 < v42 then
						v43 = v42
					end

					v41 = {
						x = mMovie:__wf_atom_79258be8() * v43,
						y = mMovie:__wf_atom_7c4b8de8() * v43
					}
				else
					v41 = module3.TransformViewportToPixelCoordinates(mMovie, {
						x = rect.X,
						y = rect.Y
					})
				end

				local w = rect.W
				local h = rect.H

				if infoPopup_Data.CenterAlign then
					w = -v7 / 2
					h /= 2
					v40 = 0
				elseif not infoPopup_Data.TopLeftAligned then
					w /= 2
					h /= 2
				end

				local compareHeight = v6

				if _T.InfoPopup_Data2 ~= nil then
					compareHeight = math.max(infoPopup_Data.CompareHeight or 0, compareHeight)
					infoPopup_Data.CompareHeight = compareHeight
				end

				local v43 = tonumber(v31) or 1
				local v44 = v41.x + w + v40 + (v7 + 2) * (v43 - 1)
				local y = v41.y

				if infoPopup_Data.CenterAlign then
					y += h
				elseif infoPopup_Data.BottomAnchor then
					y = y - compareHeight + h
				elseif not infoPopup_Data.TopLeftAligned then
					y -= h
				end

				local screenDimensions, v45 = module3.GetScreenDimensions(mMovie)
				local v46 = __wf_atom_54eeda24 * 0.05
				local v47 = v45 - (v46 + compareHeight)

				if infoPopup_Data.CenterAlign then
					if v47 < y then
						y = v41.y - h - compareHeight
					end
				else
					y = __wf_atom_421b01aa(y, v46, v47)
				end

				local v48 = __wf_atom_97cd8326 * 0.05
				local v49 = screenDimensions - v48

				if
					v49 - (((_T.ItemInfoPopupCount or 1) - (v43 - 1)) * (v7 + 2) - 2) < v44
					or infoPopup_Data.RightAligned
				then
					local v50 = infoPopup_Data.TopLeftAligned and 0 or w
					v44 = v41.x - v50 - v40 - (v7 + 2) * v43 + 2
				end

				local itemInfoPopupCount = _T.ItemInfoPopupCount or 1
				local v50 = v7 + 2
				local v51 = v49 - (v50 + v50 * (itemInfoPopupCount - v43))
				local v52 = __wf_atom_421b01aa(v44, v48, v51)
				mMovie:__wf_atom_e57658c2("Popup", 0, (math.ceil(v52)))
				mMovie:__wf_atom_e57658c2("Popup", 1, (math.ceil(y)))
			end

			if v2.MetaData.UpdateExpiry then
				for _, tag in ipairs(tags) do
					if tag.ExcludeFromInfoPopup or tag.Type ~= module2.LABEL_TYPE_TIMER then
						continue
					end

					local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v2.MetaData.Expiry)
					tag.Name = module.SecondsToFormattedTime(mMovie, __wf_atom_db2b0cee, "CompactTwoMax")
					module2.DrawPriceLabel(mMovie, tag.ClipName, tag)
					return
				end
			end
		end
	end
end

function FocusedFavoriteCallback(_, _)
	return not __wf_atom_7e8ad928(v2) and v2.mPreset ~= nil and v2.mPreset.mFavorite
end

function OnStyleChangedCallback()
	fn7()
end

function IconCacheFlushed()
	fn9()
end

local function fn29(p)
	if __wf_atom_7e8ad928(v3) or not (v3:GetHowManyElements() > 1) or v2 == nil or v20 then
		return false
	end

	if p == module3.INCREMENT then
		v3:FocusNextElement()
	else
		v3:FocusPreviousElement()
	end

	v3:SelectCurrentElement()
	module3.PlaySound(_G.UISound_ItemTipSection)
	return true
end

function onKeyDown_MENU_RTHUMB()
	local infoPopup_Grid = _T.InfoPopup_Grid
	local infoPopup_Grid2 = _T.InfoPopup_Grid
	local canPreviewElements

	if infoPopup_Grid2 == nil then
		canPreviewElements = false
	else
		canPreviewElements = infoPopup_Grid2.CanPreviewElements
	end

	if v2 ~= nil and v2.CanPreviewOverride ~= nil then
		canPreviewElements = canPreviewElements and v2.CanPreviewOverride
	end

	if canPreviewElements and infoPopup_Grid.PreviewCallback ~= nil then
		infoPopup_Grid:PreviewCallback()
		return true
	end

	local v37

	if v2 == nil then
		v37 = false
	else
		v37 = v2.mUnequipItem ~= nil
	end

	if not v37 or infoPopup_Grid.UnequipCallback == nil then
		return false
	end

	infoPopup_Grid:UnequipCallback()
	return true
end

function onKeyDown_MENU_RIGHT_CLICK()
	local infoPopup_Grid = _T.InfoPopup_Grid
	local infoPopup_Grid2 = _T.InfoPopup_Grid
	local canPreviewElements

	if infoPopup_Grid2 == nil then
		canPreviewElements = false
	else
		canPreviewElements = infoPopup_Grid2.CanPreviewElements
	end

	if v2 ~= nil and v2.CanPreviewOverride ~= nil then
		canPreviewElements = canPreviewElements and v2.CanPreviewOverride
	end

	if canPreviewElements and infoPopup_Grid.PreviewCallback ~= nil then
		infoPopup_Grid:PreviewCallback()
		return true
	end

	local v37

	if v2 == nil then
		v37 = false
	else
		v37 = v2.mUnequipItem ~= nil
	end

	if not v37 or infoPopup_Grid.UnequipCallback == nil then
		return false
	end

	infoPopup_Grid:UnequipCallback()
	return true
end

function onKeyDown_MENU_RTRIGGER1()
	return (fn29(module3.INCREMENT))
end

function onKeyDown_NEXT_MENU()
	return true
end

function onRawInputEvent(_, p, p2)
	local v37 = p2 == "1"

	if p == "EN_LSHIFT" or p == "EN_RSHIFT" then
		v = v37
	elseif v37 and p == "EN_TAB" then
		fn29(module3.Ternary(v, module3.DECREMENT, module3.INCREMENT))
	end
end

function OnGamepadTransition(_)
	fn9()
	fn10()
end

function SupportsThemes()
	return true
end

function AlwaysShowLabels()
	return true
end

function ShouldShowOmegaAttenStat()
	return v2 ~= nil and v2.ShowDisposition
end

function OverrideItemInfoData(p, p2)
	flag = false
	v31 = p
	v32 = Localize(p2, true)
	fn7()
end