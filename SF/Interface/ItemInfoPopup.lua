local v = nil
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("EE.Interface.Utilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("SF.Interface.Libs.ItemUtil")
local module7 = require("SF.Interface.Components.StatCompare")
local module8 = require("Lotus.Interface.CodexUtilities")
require("Lotus.Interface.LoadoutUtilities")
local module9 = require("Lotus.Interface.ModularWeaponUtilities")
local module10 = require("Lotus.Interface.CardUtilitiesRedux")
local module11 = require("Lotus.Interface.SyndicateUtilities")
local module12 = require("SF.Interface.SFUtilities")
local module13 = require("SF.Interface.Libs.MoteUtil")
local module14 = require("SF.Interface.Libs.StatsUtil")

function Create(movie, value, options)
	local v2 = nil
	local v3 = options or {}
	local clipName = value or "Popup"
	local env = v3.Env or getfenv(2)
	local useGlobalData = v3.UseGlobalData == true
	local popupMode = v3.PopupMode == true
	local itemInfo = v3.ItemInfo
	local maxScale = v3.MaxScale or 100

	local function fn(p)
		if p == nil or p == "" then
			return clipName
		end

		return clipName .. "." .. p
	end

	local function fn2(p)
		if popupMode then
			movie:SetVisible(p)
		else
			movie:__wf_atom_2dedec1a(clipName, 13, p)
		end
	end

	local function fn3()
		if popupMode then
			return movie:IsVisible()
		end

		return movie:__wf_atom_a91463a8(clipName, 13)
	end

	local v4 = nil

	local function fn4(p)
		if not popupMode or v2 == nil then
			return
		end

		_T.ItemInfoPopupComponents = _T.ItemInfoPopupComponents or {}

		if v4 ~= nil and _T.ItemInfoPopupComponents[v4] == v2 then
			_T.ItemInfoPopupComponents[v4] = nil
		end

		if _T.ItemInfoPopupComponents[p] == nil or _T.ItemInfoPopupComponents[p] == v2 then
			_T.ItemInfoPopupComponents[p] = v2
			v4 = p
		end
	end

	local updateMovieInterpolator = v3.UpdateMovieInterpolator

	if updateMovieInterpolator == nil then
		updateMovieInterpolator = popupMode
	end

	local fn5
	local fn6
	local fn7
	Type("/SF/Types/Game/HealthShieldDisplay")
	local asyncLoader = module2.CreateAsyncLoader()
	local asyncLoader2 = module2.CreateAsyncLoader()
	local v5 = nil
	local v6 = nil
	local v7 = {
		PreviousX = nil,
		PreviousY = nil,
		CurrentX = nil,
		CurrentY = nil,
		TargetX = nil,
		TargetY = nil
	}
	local v8 = 0
	local v9 = 0
	local v10 = 0
	local v11 = 0
	local v12 = 0
	local total = 0
	local v13 = { nil, nil }
	v13[1], v13[2] = 0, 0
	local v14 = ""
	local v15 = ""
	local tags = {}
	local v16 = 0
	local total2 = 10
	local v17 = 1
	local statId = 1
	local v18 = 0
	local v19 = 1
	local mDisplayStats = { Labels = 0, Values = 0, BaseValues = 0, StatChanges = 0 }
	mDisplayStats.Labels = {}
	mDisplayStats.Values = {}
	mDisplayStats.BaseValues = {}
	mDisplayStats.StatChanges = {}
	local v20 = nil
	local v21 = nil
	local v22 = nil
	local v23 = false
	local v24 = nil
	local v25 = nil
	local v26 = false
	local v27 = nil
	local resultItemType = nil
	local v28 = false
	local v29 = nil
	local v30 = nil
	local v31 = {}
	local v32 = true
	local v34 = { x = 0, y = 0 }
	local v35 = nil
	local v36 = false
	local v37 = nil
	local v38 = nil
	local v39 = 0
	local v40 = nil
	local v41 = 8
	local flag = true
	local v42 = ""
	local v43 = ""
	local v44 = false
	local v45 = -1
	local v46 = {}
	local v47 = false
	local state = nil
	local index = nil
	local v48 = {
		BASE = 1,
		INFO = 2,
		ABILITIES = 3,
		STATS = 4,
		CRAFTING = 5,
		ASPECTS = 6
	}
	local fn8
	local fn9
	local fn10
	local fn11

	local function fn12(p)
		local uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialDefault
		local v49

		if p == "Cassid" then
			uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialCassid
			v49 = 6172982
		else
			v49 = 16235792
		end

		if p == "Dendrit" then
			uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialDendrit
			v49 = 6176049
		end

		if p == "Fey" or p == "Feykin" then
			uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialFey
			v49 = 2839868
		end

		if p == "Mendicant" then
			uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialMendicant
			v49 = 8355452
		end

		if p == "Ode" or p == "Ode'n" then
			uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialOde
			v49 = 3038570
		end

		return uiMaterial_BorderMaterialDefault, v49
	end

	local function fn13(p)
		local uiTexture_BackerTextureStock = _G.UITexture_BackerTextureStock

		if p == "MILITARY" then
			uiTexture_BackerTextureStock = _G.UITexture_BackerTextureMilitary
		end

		if p == "OFFICER" then
			uiTexture_BackerTextureStock = _G.UITexture_BackerTextureOfficer
		end

		if p == "NOBLE" then
			uiTexture_BackerTextureStock = _G.UITexture_BackerTextureNoble
		end

		if p == "MASTERWORK" then
			uiTexture_BackerTextureStock = _G.UITexture_BackerTextureMasterwork
		end

		if p == "LEGENDARY" then
			uiTexture_BackerTextureStock = _G.UITexture_BackerTextureLegendary
		end

		return uiTexture_BackerTextureStock
	end

	local function fn14(p)
		local v49 = false
		local v50 = #mDisplayStats.GroupIndices

		if p + 1 <= v50 then
			for i = mDisplayStats.GroupIndices[p] + 1, mDisplayStats.GroupIndices[p + 1] do
				if mDisplayStats.Values[i] ~= "-" then
					v49 = true
				end
			end
		else
			for i = mDisplayStats.GroupIndices[p] + 1, #mDisplayStats.Values do
				if mDisplayStats.Values[i] ~= "-" then
					v49 = true
				end
			end
		end

		return v49
	end

	local function fn15()
		if v5 ~= nil and v5.ManualCloseHandled then
			return
		end

		v39 = 0

		if not __wf_atom_7e8ad928(v) then
			v:Stop(false)
		end

		if not v47 then
			v47 = true

			if popupMode then
				_T["InfoPopup_Data" .. 2] = nil
			end

			if not flag then
				v24:RemoveTimer(v22)
			end

			if v26 then
				fn10(false)
			end

			v27 = nil
			v7.TargetX = nil
			v7.TargetY = nil
			__wf_atom_ec43d06e(movie, clipName, 2, { 12 }, { 0 }, 0.34, 0, function()
				movie:__wf_atom_3f8dd1de(fn("VideoPreview.Image"))
				movie:__wf_atom_c90af43a(fn("VideoPreview.Image"), nil)
				fn2(false)

				if popupMode and not flag then
					movie:Close()
				end
			end)
		end
	end

	local function fn16(value2)
		return string.gsub(value2, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")
	end

	local function fn17()
		local infoPopup_Grid = _T.InfoPopup_Grid
		local canPreviewElements

		if infoPopup_Grid == nil then
			canPreviewElements = false
		else
			canPreviewElements = infoPopup_Grid.CanPreviewElements
		end

		if v5 ~= nil and v5.CanPreviewOverride ~= nil then
			canPreviewElements = canPreviewElements and v5.CanPreviewOverride
		end

		return canPreviewElements
	end

	local function fn18()
		return v5 ~= nil and v5.mUnequipItem ~= nil
	end

	local function fn19()
		return fn17() or fn18()
	end

	local function fn20() end

	local function fn21(p, p2, p3)
		local v49 = 1

		repeat
			local __wf_atom_253d7085 = movie:__wf_atom_253d7085(p .. v49)

			if __wf_atom_253d7085 then
				movie:__wf_atom_2dedec1a(p .. v49, 13, false)

				if p2 and (v49 ~= 1 or p3) then
					__wf_atom_86cbd68d(movie, p .. v49 .. ".removeMovieClip")
				end
			end

			v49 += 1
		until not __wf_atom_253d7085
	end

	local function fn22(p, p2, p3)
		local v49

		if v5 == nil then
			v49 = false
		else
			v49 = not v5.ModdedStats

			if v49 then
				if p3 == 0 then
					v49 = false
				else
					v49 = p2 ~= nil
				end
			end
		end

		if v49 then
			p = movie:__wf_atom_8e9ac384("<MINI_ARROW>", true) .. p
		end

		if v49 then
			p = p2 .. p
		end

		return p
	end

	local function fn23()
		if not __wf_atom_7e8ad928(movie) and v5 then
			local bonusStats = mDisplayStats.BonusStats

			if bonusStats ~= nil then
				local statChanges = bonusStats.StatChanges
				local v49 = ""

				for i = 1, #bonusStats.Labels do
					if #v49 > 0 then
						v49 ..= "\r\n"
					end

					local v50

					if statChanges ~= nil then
						v50 = statChanges[i]
					end

					local v51 = fn22(bonusStats.Values[i], nil, v50)
					local v52 = string.gsub(v51, "%%", "%%%0")
					v49 ..= string.gsub(bonusStats.Labels[i], "%[STAT%]", v52)
				end

				local v50

				if state == v48.STATS or v16 == 0 then
					v50 = v14
				else
					v50 = string.sub(v14, 1, v16) .. "\r\n\r\n" .. v49 .. string.sub(v14, v16 + 1)
				end

				movie:__wf_atom_50d60589(
					fn("Description"),
					36,
					"<p><font color=\"" .. v46.ContentHex .. "\">" .. v50 .. "</font></p>"
				)
			end

			for i = 1, v18 do
				local v49 = fn("ItemStats.Item") .. i
				movie:__wf_atom_4c1c1986(v49, "Backer", 11, v46.Background1)
				local label = mDisplayStats.Labels[i]

				if not (label ~= nil and mDisplayStats.Values[i] ~= "") then
					continue
				end

				local v50 = "<p><font color=\"" .. v46.FloatingContentHex .. "\">" .. label .. "</font></p>"
				movie:__wf_atom_50d60589(v49 .. ".Labels", 36, v50)

				for j = 1, 1 do
					local v51 = j == 1 and "Stats" or "StatsCompare"

					if j == 1 then
						local _statWeapon = v5.StatWeapon
					else
						local _statCompareWeapon = v5.StatCompareWeapon
					end

					local __wf_atom_4934c8e7 = movie:__wf_atom_4934c8e7(v49, v51, 36)
					local floatingContentHighlightHex = v46.FloatingContentHighlightHex

					if v44 and j == 1 then
						if mDisplayStats.Comparison[i] > 0 then
							floatingContentHighlightHex = v46.NegativeHex
						elseif mDisplayStats.Comparison[i] < 0 then
							floatingContentHighlightHex = v46.PositiveHex
						end
					end

					local v52, v53 = string.find(__wf_atom_4934c8e7, "<WEAPON_CATEGORY_ICON")

					if v52 ~= nil or v53 ~= nil or mDisplayStats.IconValues[i] then
						continue
					end

					local v54, v55 = string.find(__wf_atom_4934c8e7, "%([+-]%d+%)")
					local v56 = ""

					if v54 and v55 then
						if v44 then
							__wf_atom_4934c8e7 = string.sub(__wf_atom_4934c8e7, 1, v54 - 1) .. string.sub(__wf_atom_4934c8e7, v55 + 1, #__wf_atom_4934c8e7)
						else
							v56 = "<p><font color=\"" .. v46.YellowColorHex .. "\">" .. string.sub(__wf_atom_4934c8e7, 1, v55) .. "</font></p>"
							__wf_atom_4934c8e7 = string.sub(__wf_atom_4934c8e7, v55 + 1, #__wf_atom_4934c8e7)
						end
					end

					movie:__wf_atom_48bd5a59(
						v49,
						v51,
						36,
						v56 .. "<p><font color=\"" .. floatingContentHighlightHex .. "\">" .. __wf_atom_4934c8e7 .. "</font></p>"
					)
				end
			end
		end
	end

	local function fn24()
		if not popupMode then
			fn23()
			return
		end

		if __wf_atom_7e8ad928(_T.ItemInfoStatComparison) then
			return
		end

		if flag then
			_T.ItemInfoStatComparison()
		else
			_T.ItemInfoStatComparison(mDisplayStats, fn23)
		end
	end

	local v49 = nil

	local function fn25()
		local convertColorNumberToProceduralRGB = module3.ConvertColorNumberToProceduralRGB(module4.GetColor(3, true, v49))
		v46.Background1 = module4.GetColor(2, true, v49)
		v46.Background1RGB = module3.ConvertColorNumberToProceduralRGB(v46.Background1)
		v46.Background4Hex = module3.ConvertColorNumberToHex(module4.GetColor(5, true, v49))
		v46.BackerHighlightRGB = module3.ConvertColorNumberToProceduralRGB(module4.GetColor(1, true, v49))
		v46.Content = module4.GetColor(6, true, v49)
		v46.ContentHex = module3.ConvertColorNumberToHex(v46.Content)
		v46.FloatingContent = module4.GetColor(9, true, v49)
		v46.FloatingContentHex = module3.ConvertColorNumberToHex(v46.FloatingContent)
		v46.FloatingContentRGB = module3.ConvertColorNumberToProceduralRGB(v46.FloatingContent)
		v46.FloatingContentHighlight = _G.UIColor_Beige
		v46.FloatingContentHighlightHex = module3.ConvertColorNumberToHex(v46.FloatingContentHighlight)
		v46.FloatingContentHighlightRGB = module3.ConvertColorNumberToProceduralRGB(v46.FloatingContentHighlight)
		v46.YellowColor = _G.UIColor_Yellow
		v46.YellowColorHex = module3.ConvertColorNumberToHex(v46.YellowColor)
		v46.YellowColorRGB = module3.ConvertColorNumberToProceduralRGB(v46.YellowColor)
		v46.Positive = _G.UIColor_Yellow
		v46.PositiveHex = module3.ConvertColorNumberToHex(v46.Positive)
		v46.PositiveRGB = module3.ConvertColorNumberToProceduralRGB(v46.Positive)
		v46.Negative = _G.UIColor_BrightOrange
		v46.NegativeHex = module3.ConvertColorNumberToHex(v46.Negative)
		v46.NegativeRGB = module3.ConvertColorNumberToProceduralRGB(v46.Negative)
		v46.HoldFillHighlight = _G.UIColor_Tan
		movie:__wf_atom_e57658c2(fn("BgSecondGroup"), 11, v46.Background1)
		movie:__wf_atom_e57658c2(fn("BgThirdGroup"), 11, v46.Background1)
		movie:__wf_atom_1ca72041(
			fn("Bg"),
			"StartColor",
			v46.Background1RGB.r,
			v46.Background1RGB.g,
			v46.Background1RGB.b,
			1
		)
		movie:__wf_atom_1ca72041(
			fn("Bg"),
			"EndColor",
			convertColorNumberToProceduralRGB.r,
			convertColorNumberToProceduralRGB.g,
			convertColorNumberToProceduralRGB.b,
			0.95
		)
		movie:__wf_atom_e57658c2(fn("HeaderItem1.TitleBg"), 11, v46.Background1)
		movie:__wf_atom_e57658c2(fn("HeaderItem1.TitleBgBacker"), 11, v46.Background1)
		movie:__wf_atom_1ca72041(fn("OverallBg"), "RectEdgeColor", 0, 0, 0, 0)
		movie:__wf_atom_1ca72041(
			fn("OverallBg"),
			"RectInnerColor",
			v46.Background1RGB.r,
			v46.Background1RGB.g,
			v46.Background1RGB.b,
			1
		)
		movie:__wf_atom_1ca72041(
			fn("Header.Bg"),
			"RectEdgeColor",
			v46.BackerHighlightRGB.r,
			v46.BackerHighlightRGB.g,
			v46.BackerHighlightRGB.b,
			0.2
		)
		movie:__wf_atom_1ca72041(
			fn("Header.Bg"),
			"RectInnerColor",
			v46.Background1RGB.r,
			v46.Background1RGB.g,
			v46.Background1RGB.b,
			1
		)
		movie:__wf_atom_1ca72041(fn("Header.Fade"), "RectEdgeColor", 0, 0, 0, 0)
		movie:__wf_atom_1ca72041(
			fn("Header.Fade"),
			"RectInnerColor",
			v46.FloatingContentRGB.r,
			v46.FloatingContentRGB.g,
			v46.FloatingContentRGB.b,
			0.4
		)
		movie:__wf_atom_e57658c2(fn("Header.Label"), 11, v46.FloatingContentHighlight)
		movie:__wf_atom_e57658c2(fn("HoldFill"), 11, v46.HoldFillHighlight)

		if state == v48.BASE and v5 ~= nil then
			movie:__wf_atom_50d60589(
				fn("Description"),
				36,
				"<p><font color=\"" .. v46.ContentHex .. "\">" .. v14 .. "</font></p>"
			)
			local infoPopup_Grid = _T.InfoPopup_Grid
			local _, v50 = module2.GetGridItemName(movie, infoPopup_Grid, v5, v5.MetaData)
			tags = module2.GetGridItemTags(movie, infoPopup_Grid, v5, v5.MetaData, v50)
			local v51 = 1

			for _, v52 in ipairs(tags) do
				if v52.ExcludeFromInfoPopup then
					continue
				end

				local clipName2
				clipName2, v51 = module2.GetPriceLabelClip(movie, clipName, v51)
				v52.FitText = true
				v52.MaxWidth = v11 - total2
				module2.DrawPriceLabel(movie, clipName2, v52)
				v52.ClipName = clipName2
			end
		end

		local v50 = { "AbilityInfo.Passive.Description" }
		table.insert(v50, "AbilityInfo.Ability" .. 1 .. ".Desc")
		table.insert(v50, "AbilityInfo.Ability" .. 2 .. ".Desc")
		table.insert(v50, "AbilityInfo.Ability" .. 3 .. ".Desc")

		for i = 1, #v50 do
			movie:__wf_atom_4c1c1986(clipName, v50[i], 44, v46.Content)
		end

		local v51 = {}

		for i = 1, #v51 do
			movie:__wf_atom_4c1c1986(clipName, v51[i], 11, v46.FloatingContent)
		end

		local v52 = {
			"TagSeparator",
			"PreviewTag",
			"PreviewCallout",
			"AbilityInfo.Passive.Name",
			"AbilityInfo.PassiveSeparator",
			"AbilityInfo.Passive.Icon",
			"PrereqSeparator.Separator",
			"IngredientsSeparator.Separator"
		}
		table.insert(v52, "AbilityInfo.Ability" .. 1 .. ".Name")
		table.insert(v52, "AbilityInfo.Ability" .. 2 .. ".Name")
		table.insert(v52, "AbilityInfo.Ability" .. 3 .. ".Name")

		for i = 1, #v52 do
			movie:__wf_atom_4c1c1986(clipName, v52[i], 11, v46.FloatingContentHighlight)
		end

		if not __wf_atom_7e8ad928(v37) then
			v37:RunForAllElements(function(p)
				v37.UpdateColor(p.mClipName)
			end)
		end

		movie:__wf_atom_50d60589(
			fn("HeaderItem1.Title"),
			36,
			"<p><font color=\"" .. v46.YellowColorHex .. "\">" .. v15 .. "</font></p>"
		)
		fn24()
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.Trait.Desc"), 11, v46.Content)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.Trait.Icon"), 11, v46.FloatingContent)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Faction"), 11, v46.Content)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Rank"), 44, v46.Content)
		movie:__wf_atom_e57658c2(
			fn("CrewMemberInfo.BelowSkills.WeaponInfo.Separator"),
			11,
			v46.FloatingContentHighlight
		)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.WeaponInfo.Name"), 44, v46.FloatingContent)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.WeaponInfo.Rank"), 44, v46.FloatingContentHighlight)
	end

	local function fn26()
		local module15 = require("EE.Interface.Components.List")
		v6 = module15.CreateList(movie, fn("InfoToggle.List.Dot"))
		v6.mForcedHorizontalSeparation = 14
		v6.mForcedVerticalSeparation = 0

		function v6.mElementDrawCallback(p)
			if p.mClipName == nil then
				return
			end

			local v50 = v6.mSelectedElement ~= nil and v6.mSelectedElement.Id == p.Id
			__wf_atom_86cbd68d(movie, p.mClipName .. ".gotoAndStop", module3.Ternary(v50, "Selected", "Unfocused"))
		end

		function v6.mOnSelectedCallback(data)
			state = data.State
			index = data.Index
			statId = data.StatId

			if
				state == v48.BASE and not v5.AllInOne and v5.Category ~= 43 and v5.Category ~= 46
				or not __wf_atom_7e8ad928(v27)
			then
				fn8()
			else
				local v50 = {}

				if not __wf_atom_7e8ad928(resultItemType) then
					table.insert(v50, resultItemType:__wf_atom_5b41f63b())
				end

				if not __wf_atom_7e8ad928(v5.mExtraAbility) then
					table.insert(v50, v5.mExtraAbility:__wf_atom_5b41f63b())
				end

				if #v50 > 0 then
					v27 = UISys.__wf_atom_c0dbe47c(v50, true)
					fn10(true)
				end
			end

			v6:RunForAllElements(function(p)
				v6.mElementDrawCallback(p)
			end)
		end
	end

	local function fn27()
		local calloutOverride = module3.Ternary(Engine.IsPlayingWithController(), "<MENU_RTRIGGER1>", "<NEXT_MENU>")
		local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(
			module3.Ternary(Engine.IsPlayingWithController(), "<MENU_RTHUMB>", "<MENU_RIGHT_CLICK>"),
			true
		)
		local previewTagOverride = "/Lotus/Language/OstronCrafting/Crafting_Preview_NoIcon"

		if v5 ~= nil then
			if v5.PreviewTagOverride == nil then
				previewTagOverride = v5.mUnequipItem ~= nil and "/Lotus/Language/Menu/Loadout_Remove"
					or previewTagOverride
			else
				previewTagOverride = v5.PreviewTagOverride
			end

			if v5.PreviewCalloutFunction ~= nil then
				__wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(v5.PreviewCalloutFunction(), true)
			end

			if v5.CalloutOverride ~= nil then
				calloutOverride = v5.CalloutOverride
			end
		end

		movie:__wf_atom_50d60589(fn("PreviewCallout"), 36, __wf_atom_8e9ac384)
		local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("PreviewCallout"), 40)
		movie:__wf_atom_50d60589(fn("PreviewTag"), 36, (movie:__wf_atom_8e9ac384(previewTagOverride, false)))
		local v50 = movie:__wf_atom_5e6e15c8(fn("PreviewTag"), 40) + 5
		movie:__wf_atom_e57658c2(fn("PreviewTag"), 0, v11 - v50)
		movie:__wf_atom_e57658c2(fn("PreviewCallout"), 0, v11 - (v50 + __wf_atom_5e6e15c8 + 5))
		movie:__wf_atom_7d7314f1(fn("InfoToggle.Callout.text"), calloutOverride)
		movie:__wf_atom_2dedec1a(fn("InfoToggle.Callout"), 13, flag)

		if v5 == nil or v5.IsDismantle == nil or not v5.IsDismantle then
			if v5 and v5.BottomLeftCalloutOverride ~= nil and v5.BottomLeftCalloutOverride ~= "" then
				movie:__wf_atom_50d60589(fn("BottomLeftCallout"), 36, v5.BottomLeftCalloutOverride)
				movie:__wf_atom_2dedec1a(fn("BottomLeftCallout"), 52, false)

				if v46 and v46.FloatingContentHighlight then
					movie:__wf_atom_e57658c2(fn("BottomLeftCallout"), 44, v46.FloatingContentHighlight)
				end

				movie:__wf_atom_2dedec1a(fn("BottomLeftCallout"), 13, true)
			else
				movie:__wf_atom_2dedec1a(fn("BottomLeftCallout"), 13, false)
			end
		else
			local v51 = movie:__wf_atom_c7fa5e0c("<USE>", v5.InputFilter) .. " " .. movie:__wf_atom_8e9ac384(
				"/SF/Language/Crafting/HoldToSell",
				true
			)
			local v52, v53 = fn5(v5.StatWeapon)

			if not v52 then
				v51 = v53
			end

			local envoyInventoryControl = module12.GetEnvoyInventoryControl()

			if
				not __wf_atom_7e8ad928(envoyInventoryControl)
				and envoyInventoryControl:__wf_atom_259e7653():__wf_atom_9ed9a33c(0) <= 0
			then
				v51 = "<p><font >" .. ("<font color=\"" .. v46.NegativeHex .. "\">" .. Localize("/SF/Language/Vendor/WeaponStorageFull", false) .. "</font>") .. "<font >\r" .. v51 .. "</font></font></p>"
			end

			movie:__wf_atom_50d60589(fn("BottomLeftCallout"), 36, v51)
			movie:__wf_atom_2dedec1a(fn("BottomLeftCallout"), 52, true)

			if v46 and v46.FloatingContentHighlight then
				movie:__wf_atom_e57658c2(fn("BottomLeftCallout"), 44, v46.FloatingContentHighlight)
			end

			movie:__wf_atom_2dedec1a(fn("BottomLeftCallout"), 13, true)
		end

		if not fn7() then
			movie:__wf_atom_2dedec1a(fn("BottomRightCallout"), 13, false)
			return
		end

		Engine.IsPlayingWithController()
		local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384("<MENU_GENERIC1>", true)
		local v53

		if v44 then
			v53 = __wf_atom_8e9ac384_2 .. movie:__wf_atom_8e9ac384("/SF/Language/Menu/Stat_CompareOff", true)
		else
			v53 = __wf_atom_8e9ac384_2 .. " " .. movie:__wf_atom_8e9ac384("/SF/Language/Menu/Stat_Compare", true)
		end

		movie:__wf_atom_50d60589(fn("BottomRightCallout"), 36, v53)
		movie:__wf_atom_2dedec1a(fn("BottomRightCallout"), 52, false)

		if v46 and v46.FloatingContentHighlight then
			movie:__wf_atom_e57658c2(fn("BottomRightCallout"), 44, v46.FloatingContentHighlight)
		end

		movie:__wf_atom_2dedec1a(fn("BottomRightCallout"), 13, true)
	end

	local function fn28()
		local howManyElements = v6:GetHowManyElements()

		if flag then
			movie:__wf_atom_5e6e15c8(fn("InfoToggle.Callout"), 40)
		end

		movie:__wf_atom_e57658c2(fn("InfoToggle.List"), 0, 0)
		movie:__wf_atom_e57658c2(fn("InfoToggle.Callout"), 0, howManyElements * v6.mForcedHorizontalSeparation + 5)
		local v50 = howManyElements > 1
		local v51

		if v5 == nil then
			v51 = false
		else
			v51 = v5.CalloutOverride ~= nil
		end

		local howManyElements2 = v6:GetHowManyElements()
		local v53 = fn("InfoToggle")

		if v50 or v51 then
			if v5 == nil then
				v51 = false
			else
				v51 = not v5.HideStats or howManyElements2 > 1
			end
		end

		movie:__wf_atom_2dedec1a(v53, 13, v51)
		movie:__wf_atom_2dedec1a(fn("InfoToggle.List"), 13, v50)
		movie:__wf_atom_e57658c2(fn("InfoToggle.List"), 11, v46.YellowColor)
		movie:__wf_atom_e57658c2(fn("InfoToggle"), 0, 20)
	end

	local function fn29()
		local module15 = require("EE.Interface.Components.List")
		v29 = module15.CreateList(movie, fn("Ingredients.Ingredient"))
		v29.mForcedHorizontalSeparation = 0
		v29.mForcedVerticalSeparation = 62

		function v29:mElementDrawCallback()
			movie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)
			movie:OverrideMaterial(self.mClipName .. ".Icon", self.Material)
			local v50 = 50

			if not self.Themed then
				v50 *= 1.6
			end

			movie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, v50)
			movie:__wf_atom_4c1c1986(
				self.mClipName,
				"Icon",
				11,
				module3.Ternary(self.TintIconColor ~= nil, self.TintIconColor, _G.UIColor_White)
			)
			local checkResearch

			if v5.MetaData == nil then
				checkResearch = false
			else
				checkResearch = v5.MetaData.CheckResearch

				if checkResearch then
					if state == v48.CRAFTING then
						checkResearch = false
					else
						checkResearch = not v5.mTechItem
					end
				end
			end

			local mIncomplete = v5.mPrereqElement ~= nil and not (v5.mPrereqElement.TimeRemaining < 0)

			if checkResearch then
				self.mIncomplete = mIncomplete
			end

			local v52 = mIncomplete or self.mIncomplete and not self.mHasResources
			local ternary = module3.Ternary(v52, v46.ContentHex, v46.FloatingContentHex)
			local ternary2 = module3.Ternary(v52, v46.ContentHex, v46.FloatingContentHighlightHex)
			local v53 = "<p><font color=\"" .. ternary .. "\">" .. TitleCase(self.Name) .. "</font>"

			if self.HideCount ~= true then
				local v54 = v53 .. "<font color=\"" .. ternary2 .. "\"><br>"
				local v55

				if self.SubText == nil then
					if checkResearch then
						v55 = v54 .. module3.FormatNumber(self.Req)
					else
						v55 = v54 .. module3.FormatNumber(self.Count) .. "/" .. module3.FormatNumber(self.Req)
					end
				else
					v55 = v54 .. self.SubText
				end

				v53 = v55 .. "</font>"
			end

			local v54 = v53 .. "</p>"
			movie:__wf_atom_48bd5a59(self.mClipName, "Name", 46, "center")
			movie:__wf_atom_48bd5a59(self.mClipName, "Name", 36, v54)
			self.mHeight = movie:__wf_atom_cfc41e35(self.mClipName, "Name", 41)
			movie:__wf_atom_e57658c2(self.mClipName, 12, module3.Ternary(v52, 40, 100))
			movie:__wf_atom_7f57ab2f(
				self.mClipName,
				"Check",
				13,
				(self.mIncomplete == nil or not self.mIncomplete) and not self.HideCheck
			)
			movie:__wf_atom_4c1c1986(self.mClipName, "Check", 11, v46.FloatingContentHighlight)
			local background1RGB = v46.Background1RGB
			local backerHighlightRGB = v46.BackerHighlightRGB
			movie:OverrideMaterial(self.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			movie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectEdgeColor",
				backerHighlightRGB.r,
				backerHighlightRGB.g,
				backerHighlightRGB.b,
				0.05
			)
			movie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectInnerColor",
				background1RGB.r,
				background1RGB.g,
				background1RGB.b,
				0.9
			)
			local mIndex = self.mIndex

			if mIndex == nil then
				mIndex = v29:GetElementIndexById(self.Id)
			end

			local mInitialY = v29.mInitialY

			if not __wf_atom_7e8ad928(mIndex) and mIndex > 1 then
				for i = 1, mIndex - 1 do
					mInitialY += math.max(v29.mForcedVerticalSeparation, v29.mElements[i].mHeight or 0)
				end

				mInitialY = mInitialY + 5 * (mIndex - 1) + math.max(
					(self.mHeight - v29.mForcedVerticalSeparation) / 2,
					0
				)
			end

			movie:__wf_atom_e57658c2(self.mClipName, 1, module3.Round(mInitialY))
		end

		function v29.CalculateY(_, _)
			return 0
		end
	end

	local function fn30()
		local module15 = require("EE.Interface.Components.List")
		v30 = module15.CreateList(movie, fn("IngredientsSecondary.Ingredient"))
		v30.mForcedHorizontalSeparation = 0
		v30.mForcedVerticalSeparation = 62

		function v30:mElementDrawCallback()
			movie:__wf_atom_c90af43a(self.mClipName .. ".Icon", self.Icon)
			movie:OverrideMaterial(self.mClipName .. ".Icon", self.Material)
			local v50 = 50

			if not self.Themed then
				v50 *= 1.6
			end

			movie:__wf_atom_4c1c1986(self.mClipName, "Icon", 14, v50)
			movie:__wf_atom_4c1c1986(
				self.mClipName,
				"Icon",
				11,
				module3.Ternary(self.TintIconColor ~= nil, self.TintIconColor, _G.UIColor_White)
			)
			local floatingContentHex = v46.FloatingContentHex
			local floatingContentHighlightHex = v46.FloatingContentHighlightHex
			local v51 = "<p><font color=\"" .. floatingContentHex .. "\">" .. TitleCase(self.Name) .. "</font>"

			if self.HideCount ~= true then
				local v52 = v51 .. "<font color=\"" .. floatingContentHighlightHex .. "\"><br>"
				local v53

				if self.SubText == nil then
					v53 = v52 .. module3.FormatNumber(self.Req)
				else
					v53 = v52 .. self.SubText
				end

				v51 = v53 .. "</font>"
			end

			local v52 = v51 .. "</p>"
			movie:__wf_atom_48bd5a59(self.mClipName, "Name", 46, "center")
			movie:__wf_atom_48bd5a59(self.mClipName, "Name", 36, v52)
			self.mHeight = movie:__wf_atom_cfc41e35(self.mClipName, "Name", 41)
			movie:__wf_atom_7f57ab2f(self.mClipName, "Check", 13, false)
			local background1RGB = v46.Background1RGB
			local backerHighlightRGB = v46.BackerHighlightRGB
			movie:OverrideMaterial(self.mClipName .. ".Bg", _G.UIMaterial_RectangleNoDepth)
			movie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectEdgeColor",
				backerHighlightRGB.r,
				backerHighlightRGB.g,
				backerHighlightRGB.b,
				0.05
			)
			movie:__wf_atom_1ca72041(
				self.mClipName .. ".Bg",
				"RectInnerColor",
				background1RGB.r,
				background1RGB.g,
				background1RGB.b,
				0.9
			)
			local mIndex = self.mIndex

			if mIndex == nil then
				mIndex = v30:GetElementIndexById(self.Id)
			end

			local mInitialY = v30.mInitialY

			if not __wf_atom_7e8ad928(mIndex) and mIndex > 1 then
				for i = 1, mIndex - 1 do
					mInitialY += math.max(v30.mForcedVerticalSeparation, v30.mElements[i].mHeight or 0)
				end

				mInitialY = mInitialY + 5 * (mIndex - 1) + math.max(
					(self.mHeight - v30.mForcedVerticalSeparation) / 2,
					0
				)
			end

			movie:__wf_atom_e57658c2(self.mClipName, 1, module3.Round(mInitialY))
		end

		function v30.CalculateY(_, _)
			return 0
		end
	end

	local function fn31()
		local module15 = require("EE.Interface.Components.List")
		v35 = module15.CreateList(movie, fn("CrewMemberInfo.Skill1"))
		v35.mForcedHorizontalSeparation = 0
		v35.mForcedVerticalSeparation = 32

		function v35.mClipCreatedCallback(p, _)
			movie:__wf_atom_4c1c1986(p, "Bg", 12, 5)
		end

		function v35.mElementDrawCallback(data)
			movie:__wf_atom_4c1c1986(data.mClipName, "Icon", 11, v46.FloatingContent)
			movie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, v46.FloatingContentHighlight)
			movie:__wf_atom_4c1c1986(data.mClipName, "Bg", 11, v46.Content)
			movie:__wf_atom_c90af43a(data.mClipName .. ".Icon", crewSkillIcons[data.Skill + 1])
			movie:__wf_atom_7f57ab2f(data.mClipName, "Bg", 13, data.mIndex % 2 == 1)
			local skill = TitleCase(movie:__wf_atom_8e9ac384(
				"/Lotus/Language/Railjack/CrewSkill" .. tostring(data.Skill),
				false
			))
			local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/CrewSkillLong", false, {
				LEVEL = data.Level,
				SKILL = skill
			})
			movie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, __wf_atom_8e9ac384)
		end

		gRegion:IsMaster()
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.HealthInfo"), 1, 40)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.HealthLabel"), 1, 15)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Faction"), 12, 70)
		module2.DrawSeparator(movie, fn("CrewMemberInfo.BelowSkills.WeaponInfo.Separator"), 325)
	end

	local function fn32(_, p)
		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo"), 13, not p)

		if p then
			return
		end

		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo.Trait"), 13, false)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo"), 1, v10 + 10 + 0)
		v35:RemoveElements(true, true)

		if not p then
			for i = 0, 5 - 1 do
				v35:AddElement({
					Skill = i,
					Level = v5.CrewMemberInfo:__wf_atom_ba6893d3(i)
				}, true)
			end
		end

		v35:Redraw(nil, nil, true)
		local v50 = v35:GetHowManyElements() * v35.mForcedVerticalSeparation
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills"), 1, v50 + 5)
		v10 = v10 + 0 + v50
		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo.BelowSkills.HealthInfo"), 13, false)
		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo.BelowSkills.HealthLabel"), 13, false)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.WeaponInfo"), 1, 0)
		movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Faction"), 1, 40)
		local mPowersuitInfo = v5.CrewMemberInfo.mPowersuitInfo
		local __wf_atom_b4a75eaa = __wf_atom_c67f9605:__wf_atom_b4a75eaa(mPowersuitInfo.mXP, mPowersuitInfo.mItemType)
		math.min(
			__wf_atom_c67f9605:__wf_atom_7da755e9(mPowersuitInfo.mItemType, mPowersuitInfo.mPolarized),
			__wf_atom_b4a75eaa
		)
		movie:__wf_atom_50d60589(fn("CrewMemberInfo.BelowSkills.Rank"), 36, TitleCase(" "))
		local mId = v5.CrewMemberInfo.mWeaponId.mId
		local v51

		if mId == SF.__wf_atom_b8679e91 or mId == "" then
			v51 = false
		else
			v51 = tonumber(mId) ~= 0
		end

		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo.BelowSkills.WeaponInfo"), 13, v51)

		if v51 then
			local __wf_atom_0ff4b555 = gGameData:GetInventory():__wf_atom_0ff4b555(mId)

			if not __wf_atom_7e8ad928(__wf_atom_0ff4b555) then
				local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

				if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
					local itemType = module5.GetItemTypeWithStoreInfo(
						movie,
						__wf_atom_0ff4b555.mItemType,
						__wf_atom_964056fd,
						{ ItemInfo = __wf_atom_0ff4b555 },
						true
					)

					if not __wf_atom_7e8ad928(itemType) then
						movie:__wf_atom_c90af43a(fn("CrewMemberInfo.BelowSkills.WeaponInfo.Icon"), itemType.Icon)
						movie:__wf_atom_e57658c2(
							fn("CrewMemberInfo.BelowSkills.WeaponInfo.Icon"),
							14,
							64 * module3.Ternary(itemType.Themed, 1, 1.6)
						)
						local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(itemType.Name, false)
						movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.WeaponInfo.Name"), 14, 210)
						module3.SetFitText(movie, fn("CrewMemberInfo.BelowSkills.WeaponInfo.Name"), "...")
						movie:__wf_atom_50d60589(
							fn("CrewMemberInfo.BelowSkills.WeaponInfo.Name"),
							36,
							__wf_atom_8e9ac384
						)
						local __wf_atom_b4a75eaa2 = __wf_atom_c67f9605:__wf_atom_b4a75eaa(
							__wf_atom_0ff4b555.mXP,
							__wf_atom_0ff4b555.mItemType
						)
						local __wf_atom_8e9ac384_2 = movie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/Global_FormattedRankCaps",
							false,
							{
								RANK = module3.FormatNumber(__wf_atom_b4a75eaa2)
							}
						)
						movie:__wf_atom_50d60589(
							fn("CrewMemberInfo.BelowSkills.WeaponInfo.Rank"),
							36,
							TitleCase(__wf_atom_8e9ac384_2)
						)
					end
				end
			end

			v10 += 75
			movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Faction"), 0, 300)
		else
			v10 += 75
			movie:__wf_atom_e57658c2(fn("CrewMemberInfo.BelowSkills.Faction"), 0, 165)
		end
	end

	local function fn33(data)
		movie:__wf_atom_50d60589(fn("MoteInfo.Title"), 36, data.title)

		if data.icon then
			movie:__wf_atom_2dedec1a(fn("MoteInfo.Icon"), 13, true)
			movie:__wf_atom_c90af43a(fn("MoteInfo.Icon"), data.icon)
		else
			movie:__wf_atom_2dedec1a(fn("MoteInfo.Icon"), 13, false)
		end

		if data.iconText then
			movie:__wf_atom_2dedec1a(fn("MoteInfo.IconText"), 13, true)
			movie:__wf_atom_50d60589(fn("MoteInfo.IconText"), 44, v46.Content)
			movie:__wf_atom_50d60589(fn("MoteInfo.IconText"), 11, _G.UIColor_White)
			movie:__wf_atom_50d60589(fn("MoteInfo.IconText"), 36, data.iconText)
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("MoteInfo.IconText"), 14)
			local __wf_atom_5e6e15c8_2 = movie:__wf_atom_5e6e15c8(fn("MoteInfo.Icon"), 0)
			local __wf_atom_5e6e15c8_3 = movie:__wf_atom_5e6e15c8(fn("MoteInfo.Icon"), 14)
			movie:__wf_atom_e57658c2(
				fn("MoteInfo.IconText"),
				0,
				__wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8_3 / 2 - __wf_atom_5e6e15c8 / 2 + 2
			)
			movie:__wf_atom_e57658c2(fn("MoteInfo.Title"), 14, __wf_atom_5e6e15c8_2 - __wf_atom_5e6e15c8_3 - 10)
		else
			movie:__wf_atom_2dedec1a(fn("MoteInfo.IconText"), 13, false)
		end

		movie:__wf_atom_2dedec1a(fn("MoteInfo"), 13, true)
	end

	local function fn34(p)
		movie:__wf_atom_fbca497c(p)
	end

	local function fn35()
		if v4 ~= nil and _T.ItemInfoPopupComponents ~= nil and _T.ItemInfoPopupComponents[v4] == v2 then
			_T.ItemInfoPopupComponents[v4] = nil
		end

		if popupMode then
			_T.ShowItemInfoPopupCursor = nil
		end

		if popupMode and flag then
			_T.ItemInfoStatComparison = nil
		end
	end

	local function fn36(state2, state3)
		local labels = state2.Labels
		local labels2 = state3.Labels
		state2.StatChanges = {}
		state3.StatChanges = {}
		local v50 = {}

		for i = 1, #labels do
			v50[labels[i]] = i
		end

		for i = 1, #labels2 do
			local v51 = v50[labels2[i]]
			local compareValue = state3.CompareValues[i]

			if v51 == nil then
				continue
			end

			v50[labels2[i]] = nil
			local compareValue2 = state2.CompareValues[v51]

			if compareValue2 == compareValue then
				continue
			end

			local v52 = (tonumber(compareValue2) or 0) < (tonumber(compareValue) or 0)
			state2.StatChanges[v51] = v52 and -1 or 1
			state3.StatChanges[i] = v52 and 1 or -1
		end
	end

	local function fn37(p, p2)
		v20 = p or v20
		v21 = p2 or v21

		if v20 ~= nil and v20.CompareValues ~= nil and mDisplayStats.CompareValues ~= nil then
			fn36(mDisplayStats, v20)
			mDisplayStats.BonusStats = mDisplayStats.BonusStats or {}
			v20.BonusStats = v20.BonusStats or {}
			fn36(mDisplayStats.BonusStats, v20.BonusStats)
		end

		fn23()

		if v21 ~= nil then
			v21()
		end
	end

	local function fn38()
		local module15 = require("EE.Interface.Components.List")
		v37 = module15.CreateList(movie, fn("Invasion.Subinvasion"))
		v37.BarWidth = 330
		v37.mForcedHorizontalSeparation = 0
		v37.mForcedVerticalSeparation = 75

		local function fn39(count, goal)
			local v50 = 50 + count / goal * 50

			if v5.AttackerFaction == 2 then
				return 100 + count / goal * 100
			end

			return v50
		end

		function v37.UpdateColor(p)
			movie:__wf_atom_1ca72041(
				p .. ".ProgressBar.LeftFill",
				"RectInnerColor",
				v46.FloatingContentRGB.r,
				v46.FloatingContentRGB.g,
				v46.FloatingContentRGB.b,
				0.4
			)
			movie:__wf_atom_1ca72041(p .. ".ProgressBar.LeftFill", "RectEdgeColor", 0, 0, 0, 0)
			movie:__wf_atom_1ca72041(
				p .. ".ProgressBar.RightFill",
				"RectInnerColor",
				v46.FloatingContentRGB.r,
				v46.FloatingContentRGB.g,
				v46.FloatingContentRGB.b,
				1
			)
			movie:__wf_atom_1ca72041(p .. ".ProgressBar.RightFill", "RectEdgeColor", 0, 0, 0, 0)
			movie:__wf_atom_1ca72041(
				p .. ".ProgressBar.Bg",
				"RectInnerColor",
				v46.Background1RGB.r,
				v46.Background1RGB.g,
				v46.Background1RGB.b,
				1
			)
			movie:__wf_atom_1ca72041(
				p .. ".ProgressBar.Bg",
				"RectEdgeColor",
				v46.FloatingContentRGB.r,
				v46.FloatingContentRGB.g,
				v46.FloatingContentRGB.b,
				1
			)
			movie:__wf_atom_4c1c1986(p, "Progress", 44, v46.Content)
			movie:__wf_atom_4c1c1986(p, "LRewards", 44, v46.Content)
			movie:__wf_atom_4c1c1986(p, "RRewards", 44, v46.Content)
		end

		function v37.mClipCreatedCallback(p, _)
			v37.UpdateColor(p)
			movie:OverrideMaterial(p .. ".ProgressBar.LeftFill", _G.UIMaterial_RectangleNoDepth)
			movie:OverrideMaterial(p .. ".ProgressBar.RightFill", _G.UIMaterial_RectangleNoDepth)
			movie:OverrideMaterial(p .. ".ProgressBar.Bg", _G.UIMaterial_RectangleNoDepth)
		end

		function v37.mElementDrawCallback(data)
			local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(data.Node:c_str(), false)

			if not data.CustomEntry then
				__wf_atom_8e9ac384 = "<p><font size=\"19\"><b>" .. __wf_atom_8e9ac384 .. "</b></font></p>"
			end

			movie:__wf_atom_48bd5a59(data.mClipName, "Title", 36, __wf_atom_8e9ac384)
			movie:__wf_atom_48bd5a59(data.mClipName, "Title", 45, module3.Ternary(data.CustomEntry, "left", "center"))
			movie:__wf_atom_4c1c1986(data.mClipName, "Title", 0, module3.Ternary(data.CustomEntry, 2, 115))
			movie:__wf_atom_4c1c1986(data.mClipName, "Title", 1, module3.Ternary(data.CustomEntry, 45, 0))
			movie:__wf_atom_4c1c1986(
				data.mClipName,
				"Title",
				44,
				module3.Ternary(data.CustomEntry, v46.FloatingContentHighlight, v46.FloatingContent)
			)
			local v50

			if data.Delta == nil or data.Delta == 0 then
				v50 = false
			else
				v50 = not data.HideProgress
			end

			movie:__wf_atom_7f57ab2f(data.mClipName, "Progress", 13, v50)

			if v50 then
				movie:__wf_atom_48bd5a59(data.mClipName, "Progress", 36, tostring(data.Delta) .. "/" .. tostring(3))
				movie:__wf_atom_48bd5a59(
					data.mClipName,
					"Progress",
					45,
					module3.Ternary(data.SupportAttacker, "left", "right")
				)
				local v51

				if data.SupportAttacker then
					v51 = 0
				else
					local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(data.mClipName .. ".Progress", 14)
					v51 = v37.BarWidth - __wf_atom_5e6e15c8
				end

				movie:__wf_atom_4c1c1986(data.mClipName, "Progress", 0, v51)
			end

			if data.CustomEntry then
				movie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.LeftFill", 14, 0.001)
				local v51 = __wf_atom_421b01aa(v37.BarWidth * data.Delta, 0.001, v37.BarWidth)
				movie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 14, v51)
				movie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 0, v51)
			else
				local v51 = fn39(data.Count, data.Goal)
				local v52 = v37.BarWidth * (v51 / 100)
				movie:__wf_atom_4c1c1986(
					data.mClipName,
					"ProgressBar.LeftFill",
					14,
					__wf_atom_421b01aa(v52 + 2, 0.001, v37.BarWidth)
				)
				movie:__wf_atom_4c1c1986(
					data.mClipName,
					"ProgressBar.RightFill",
					14,
					__wf_atom_421b01aa(v37.BarWidth - v52 + 2, 0.001, v37.BarWidth)
				)
				movie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.RightFill", 0, v37.BarWidth)
			end

			movie:__wf_atom_4c1c1986(data.mClipName, "ProgressBar.Bg", 14, v37.BarWidth)

			if __wf_atom_7e8ad928(data.AttackerReward) or __wf_atom_7e8ad928(data.DefenderReward) then
				movie:__wf_atom_48bd5a59(data.mClipName, "LRewards", 36, "")
				movie:__wf_atom_48bd5a59(data.mClipName, "RRewards", 36, "")
			else
				local v51 = TitleCase(module.GetRewardDesc(movie, data.AttackerReward))
				local v52 = TitleCase(module.GetRewardDesc(movie, data.DefenderReward))
				module3.FitTextIntoLines(movie, data.mClipName .. ".LRewards", 2, v51, "...")
				module3.FitTextIntoLines(movie, data.mClipName .. ".RRewards", 2, v52, "...")
			end
		end
	end

	local function fn39()
		if popupMode and _T.ItemInfoStatComparison == nil then
			_T.ItemInfoStatComparison = fn37
		end

		fn20()
		local visible = v3.Visible

		if visible == nil then
			visible = not popupMode
		end

		fn2(visible)
		movie:__wf_atom_e57658c2(clipName, 12, 100)
		movie:__wf_atom_2dedec1a(fn("AspectContainer"), 13, false)

		if popupMode then
			movie:__wf_atom_c884ca43(true)
			movie:__wf_atom_b4ffb30f(false)
			movie:__wf_atom_dac78d3d(true)
			v38 = movie:__wf_atom_4dc54686()
		end

		local module15 = require("Lotus.Interface.Libs.TimerMgr")
		v24 = module15.CreateTimerMgr()

		if popupMode then
			_T.ShowItemInfoPopupCursor = fn34
		end

		movie:__wf_atom_933bbce0(fn("Bg"), _G.UITexture_MidBgTexture, _G.UIMaterial_MidBgMaterial)
		module2.DrawSeparator(movie, fn("TagSeparator"), 330)
		module2.DrawSeparator(movie, fn("PrereqSeparator.Separator"), 330)
		module2.DrawSeparator(movie, fn("IngredientsSeparator.Separator"), 330)
		module2.DrawSeparator(movie, fn("AbilityInfo.PassiveSeparator"), 330)
		movie:__wf_atom_c90af43a(fn("AbilityInfo.Passive.Icon"), passiveIcon)
		movie:__wf_atom_1ca72041(fn("Bg"), "RectEdgeColor", 0, 0, 0, 0)
		movie:__wf_atom_1ca72041(fn("Bg"), "RectInnerColor", 1, 1, 1, 1)
		movie:__wf_atom_1ca72041(fn("Third"), "RectEdgeColor", 0, 0, 0, 0)
		movie:__wf_atom_1ca72041(fn("Third"), "RectInnerColor", 1, 1, 1, 1)
		movie:OverrideMaterial(fn("Header.Fade"), _G.UIMaterial_RectangleNoDepth)
		movie:OverrideMaterial(fn("Header.Bg"), _G.UIMaterial_RectangleNoDepth)
		movie:OverrideMaterial(fn("ItemInfoBorder"), _G.UIMaterial_BorderMaterialErodedEdge)
		movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 11, _G.UIColor_Brown)
		movie:__wf_atom_c90af43a(fn("HeaderItem1.TitleBgOverlay"), _G.UITexture_BackerTextureStock)
		movie:OverrideMaterial(fn("OverallBg"), _G.UIMaterial_RectangleNoDepth)
		v11 = movie:__wf_atom_5e6e15c8(fn("OverallBg"), 14)
		movie:__wf_atom_e57658c2(fn("LineHeader.Line"), 14, v11 - 70)
		movie:__wf_atom_e57658c2(fn("LineFooter.Line"), 14, v11 - 70)
		movie:__wf_atom_e57658c2(fn("TitleDivider"), 14, v11 - 40)
		movie:__wf_atom_e57658c2(fn("GroupDivider1"), 14, v11 - 40)
		movie:__wf_atom_e57658c2(fn("GroupDivider2"), 14, v11 - 40)
		fn26()
		fn29()
		fn30()
		fn38()
		fn31()
		fn27()
		fn25()
		local module16 = require("Lotus.Interface.Components.ThemedSpinner")
		v25 = module16.Create(movie, fn("Spinner"))

		if popupMode and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
		end
	end

	local function fn40(p)
		local v50 = p == nil and 1 or p
		local v51 = fn("TagContainer.Tag1")
		local v52 = 1

		while movie:__wf_atom_253d7085(v51) do
			movie:__wf_atom_2dedec1a(v51, 13, v52 < v50)
			v52 += 1
			v51 = fn("TagContainer.Tag") .. tostring(v52)
		end
	end

	local function fn41(p)
		movie:__wf_atom_e57658c2(fn("Header.Bg"), 15, v10 + v12)
		movie:__wf_atom_e57658c2(fn("OverallBg"), 15, v10)

		for i = 1, 1 do
			local v50

			if i == 1 then
				v50 = fn("HeaderItem1")
			else
				v50 = fn("HeaderItem2")
			end

			movie:__wf_atom_4c1c1986(v50, "TitleBg", 15, v8)
			movie:__wf_atom_4c1c1986(v50, "TitleBg", 14, 344)
			movie:__wf_atom_4c1c1986(v50, "TitleBg", 12, 65)
			movie:__wf_atom_4c1c1986(v50, "TitleBgBacker", 15, v8)
			movie:__wf_atom_4c1c1986(v50, "TitleBgbacker", 14, 344)
			movie:__wf_atom_4c1c1986(v50, "TitleBgOverlayMask", 15, v8)
			movie:__wf_atom_4c1c1986(v50, "TitleBgOverlayMask", 14, v8 * 40)
			movie:__wf_atom_4c1c1986(v50, "TitleBgOverlay", 15, 120)
			movie:__wf_atom_4c1c1986(v50, "TitleBgOverlay", 14, 240)
			movie:__wf_atom_4c1c1986(
				v50,
				"TitleBgOverlay",
				1,
				-movie:__wf_atom_cfc41e35(v50, "TitleBgOverlay", 15) / 2 + v8 / 2
			)
			movie:__wf_atom_4c1c1986(
				v50,
				"TitleBgOverlay",
				0,
				movie:__wf_atom_cfc41e35(v50, "TitleBg", 14) - movie:__wf_atom_cfc41e35(v50, "TitleBgOverlay", 14) / 2 + 3
			)
			movie:__wf_atom_4c1c1986(
				v50,
				"TitleBgOverlayMask",
				0,
				movie:__wf_atom_cfc41e35(v50, "TitleBg", 14) - movie:__wf_atom_cfc41e35(v50, "TitleBgOverlayMask", 14) / 2 + 3
			)
		end

		movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 1, movie:__wf_atom_5e6e15c8(fn("HeaderItem1.TitleBg"), 1) - 6)
		movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 15, v10 + 10)
		movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 14, 358)
		movie:__wf_atom_e57658c2(fn("Bg"), 15, (math.max(1, v10 - v9 - 2)))
		movie:__wf_atom_e57658c2(fn("Bg"), 1, v9)
		movie:__wf_atom_e57658c2(fn("TitleDivider"), 1, v9 + 2)
		movie:__wf_atom_e57658c2(fn("PreviewTag"), 1, v10 - (p - 6))
		movie:__wf_atom_e57658c2(fn("PreviewCallout"), 1, v10 - (p - 6))
		movie:__wf_atom_e57658c2(fn("Blurer"), 15, v10)
		movie:__wf_atom_e57658c2(fn("LineFooter"), 1, v10)

		if
			movie:__wf_atom_a91463a8(fn("DescStatItem"), 13)
			or movie:__wf_atom_a91463a8(fn("DescInfoArea"), 13)
			or v45 > 0
		then
			if v45 > 0 then
				movie:__wf_atom_e57658c2(
					fn("GroupDivider1"),
					1,
					movie:__wf_atom_5e6e15c8(fn("TagContainer"), 1) + movie:__wf_atom_5e6e15c8(fn("TagContainer.Tag") .. v45, 1) + movie:__wf_atom_5e6e15c8(fn("TagContainer.Tag") .. v45, 15) + 5
				)
				movie:__wf_atom_e57658c2(
					fn("BgSecondGroup"),
					1,
					movie:__wf_atom_5e6e15c8(fn("TagContainer"), 1) + movie:__wf_atom_5e6e15c8(fn("TagContainer.Tag") .. v45, 1) + movie:__wf_atom_5e6e15c8(fn("TagContainer.Tag") .. v45, 15) + 5
				)
			elseif movie:__wf_atom_a91463a8(fn("DescInfoArea"), 13) then
				movie:__wf_atom_e57658c2(
					fn("GroupDivider1"),
					1,
					movie:__wf_atom_5e6e15c8(fn("DescInfoArea"), 1) + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Title"), 15) + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Desc"), 41) + 5
				)
				movie:__wf_atom_e57658c2(
					fn("BgSecondGroup"),
					1,
					movie:__wf_atom_5e6e15c8(fn("DescInfoArea"), 1) + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Title"), 15) + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Desc"), 41) + 5
				)
			else
				movie:__wf_atom_e57658c2(
					fn("GroupDivider1"),
					1,
					movie:__wf_atom_5e6e15c8(fn("DescStatItem"), 1) + movie:__wf_atom_5e6e15c8(fn("DescStatItem.Stat"), 41) + 15
				)
				movie:__wf_atom_e57658c2(
					fn("BgSecondGroup"),
					1,
					movie:__wf_atom_5e6e15c8(fn("DescStatItem"), 1) + movie:__wf_atom_5e6e15c8(fn("DescStatItem.Stat"), 41) + 15
				)
			end
		else
			movie:__wf_atom_e57658c2(fn("GroupDivider1"), 1, v12 + v13[1] + v9 - 10)
			movie:__wf_atom_e57658c2(fn("BgSecondGroup"), 1, v12 + v13[1] + v9 - 10)
		end

		movie:__wf_atom_e57658c2(fn("GroupDivider2"), 1, v12 + v13[2] + v9 - 10)

		if movie:__wf_atom_a91463a8(fn("GroupDivider2"), 13) then
			movie:__wf_atom_e57658c2(
				fn("BgSecondGroup"),
				15,
				movie:__wf_atom_5e6e15c8(fn("GroupDivider2"), 1) - movie:__wf_atom_5e6e15c8(fn("GroupDivider1"), 1)
			)
			return
		end

		local v50 = movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 1) - 4

		if not (movie:__wf_atom_a91463a8(fn("BottomRightCallout"), 13) or movie:__wf_atom_a91463a8(fn("BottomLeftCallout"), 13)) then
			v50 = v10 + 2
		end

		local v51 = v50 - movie:__wf_atom_5e6e15c8(fn("GroupDivider1"), 1) - 4
		movie:__wf_atom_e57658c2(fn("BgSecondGroup"), 15, v51)
	end

	fn10 = function(p)
		v26 = p
		v25:SetActive(p)

		if p then
			fn40()

			for _, v50 in pairs({
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
				movie:__wf_atom_7f57ab2f(clipName, v50, 13, false)
			end

			if v10 == 0 then
				v10 = 120
				fn41(0)
			end

			movie:__wf_atom_e57658c2(fn("Spinner"), 1, v9 + (v10 - v9) / 2)
		end
	end

	local function fn42()
		if v32 and not __wf_atom_7e8ad928(gGameData) then
			v32 = false
			v24:AddTimer(5, function()
				v32 = true
			end)
			v31 = {}
			local inventory = gGameData:GetInventory()

			if not __wf_atom_7e8ad928(inventory) then
				module.AddTableToPurchasedItems(v31, inventory:__wf_atom_4f67b86c())
				module.AddTableToPurchasedItems(v31, inventory:__wf_atom_20b04548())
				module.AddTableToPurchasedItems(v31, inventory:__wf_atom_4259c789())
				module.AddTableToPurchasedItems(v31, inventory:__wf_atom_6b29f1ed())
			end
		end
	end

	local function fn43(infoPopup_Grid)
		v6:RemoveElements(true, true)
		v6.mAbilitiesAvailable = false
		v6.mStatsAvailable = false
		local v50 = nil
		local mIsNemesis = v5.mIsNemesis
		local resultStoreItem = v5.ResultStoreItem or v5.StoreItem

		if mIsNemesis or not __wf_atom_7e8ad928(resultStoreItem) then
			local v51

			if not __wf_atom_7e8ad928(resultStoreItem) then
				v51 = resultStoreItem:__wf_atom_efa6f447()
			end

			local item = resultStoreItem:GetItem()
			local v52 = mIsNemesis or v51 == 3 or v51 == 27 or v51 == 48
			local v53 = v51 == 0
				or v51 == 1
				or v51 == 5
				or v51 == 28
				or v51 == 29
				or v51 == 37
				or v51 == 16
				or v51 == 43
			local v54 = v51 == 6
			local v55 = not __wf_atom_7e8ad928(item) and item:IsA(__wf_atom_16cdad3a)
			local mStatsAvailable = not __wf_atom_7e8ad928(item)
				and item:IsA(WeakResource("/SF/Types/Items/AttributeItem"))
			v6.mAbilitiesAvailable = v52 and not v5.HideAbilities
			local v57 = true

			if __wf_atom_7e8ad928(v5.StatWeapon) then
				if mStatsAvailable then
					v50 = module5.GetDisplayStats(item, true)

					if #v50.Labels > 0 then
						v57 = true
					else
						v57 = false
					end
				end
			else
				local mStatsToOnlyShow = v5.mStatsToOnlyShow
				local getDisplayStats = module5.GetDisplayStats
				local statWeapon = v5.StatWeapon
				local statOwner = v5.StatOwner
				local v60

				if not v5.DisableCompare then
					v60 = v5.StatCompareWeapon
				end

				v50 = getDisplayStats(statWeapon, true, statOwner, nil, v60, nil, mStatsToOnlyShow)
				v57 = #v50.Labels > 0
			end

			local v58 = v6

			if v53 or v54 or v55 or mStatsAvailable then
				mStatsAvailable = not v5.HideStats and v57
			end

			v58.mStatsAvailable = mStatsAvailable

			if
				v5.StoreItem:IsA(__wf_atom_bf37f5ca)
				and (v5.StoreItem:__wf_atom_c44f24a5() == 14 or v5.StoreItem:__wf_atom_c44f24a5() == 15)
			then
				v6.mStatsAvailable = false
			end

			if v6.mStatsAvailable then
				for i = module3.Ternary(v5.AllInOne, 2, 1), v17 do
					v6:AddElement({ State = v48.STATS, StatId = i }, true)
				end
			end
		end

		if v50 and (v5.HideAspects == nil or not v5.HideAspects) then
			for i = 1, #v50.Labels do
				if not (v50.Labels[i] == movie:__wf_atom_8e9ac384("/SF/Language/Menu/Stat_Aspects", true) and (v50.Values[i] ~= "-" or v44)) then
					continue
				end

				v6:AddElement({ State = v48.ASPECTS, Index = 1 }, true)
				local v51 = StringSplit(",", v50.Values[i])
				local v52 = not v44 and {} or StringSplit(",", v50.CompareValues[i])
				local v53 = math.max(#v51, #v52)

				if v41 < v53 then
					v6:AddElement({ State = v48.ASPECTS, Index = 2 }, true)
				end
			end
		end

		if v5.HideBasePage == nil or not v5.HideBasePage then
			for _ = 1, v5.Hints ~= nil and math.max(#v5.Hints, 1) or 1 do
				v6:AddElement({ State = v48.BASE }, true)
			end
		end

		if v6.mAbilitiesAvailable and not (v5.AllInOne or v5.HideAbilities) then
			v6:AddElement({ State = v48.ABILITIES }, true)
		end

		if
			infoPopup_Grid ~= nil
			and infoPopup_Grid.AdditionalTabInfo ~= nil
			and #infoPopup_Grid.AdditionalTabInfo(v5) > 0
		then
			v6:AddElement({ State = v48.INFO }, true)
		end

		if v5.TimeRemaining ~= nil and not v5.HideRecipe then
			v6:AddElement({ State = v48.CRAFTING }, true)
		end

		if (v50 or v5.Type and v5.Type:IsA(__wf_atom_d98e64fe)) and v5.HideLevel ~= nil then
			local _hideLevel = v5.HideLevel
		end

		v6:Redraw(nil, nil, true)
		v39 = 0
		movie:__wf_atom_e57658c2(fn("HoldFill"), 14, 0)
		movie:__wf_atom_e57658c2(fn("HoldFill"), 12, 0)
		fn28()
	end

	local function fn44()
		local v50 = v36
		v36 = false
		local v51 = true
		local v52 = v5.mPrereqElement ~= nil
		local storeItem = v5.StoreItem
		local __wf_atom_92a55f32 = storeItem:__wf_atom_92a55f32()
		local v53 = ""
		local v54

		if v5.MetaData == nil or not v5.MetaData.CheckResearch or state == v48.CRAFTING then
			v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_RecipeComponents", false)

			if __wf_atom_92a55f32 then
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/FabricationRequirements", true)
			else
				v53 = module.SecondsToFormattedTime(movie, storeItem:__wf_atom_ed1be18b(), "CompactHours")
			end
		elseif v5.Researched or v5.InProgress or v52 and v5.mPrereqElement.TimeRemaining >= 0 then
			v51 = false

			if v50 and v5.mCompletionDate ~= nil then
				v5.TimeRemaining = Engine.__wf_atom_db2b0cee(v5.mCompletionDate)
			end

			if v5.TimeRemaining > 0 then
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchStatusInProgress", false)
				v53 = module.SecondsToFormattedTime(movie, v5.TimeRemaining, "Compact")
				v36 = true
			elseif v52 and not v5.Researched then
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchPrereqNeededHint", false, {
					PREREQ = v5.mPrereqElement.Name
				})
			elseif _T.ShowDojoColors then
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchColorCompleteHint", false)
			elseif __wf_atom_92a55f32 then
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Railjack/ResearchCompleteHintFabrication", false)
			else
				v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchCompleteHint", false)
			end
		else
			v54 = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/ResearchRequirements", false)

			if not __wf_atom_92a55f32 then
				v53 = module.SecondsToFormattedTime(movie, storeItem:__wf_atom_cc75974f(), "CompactHours")
			end
		end

		if #v53 > 0 then
			v53 = "<br>" .. movie:__wf_atom_8e9ac384("<TIMER> ", true) .. v53
		end

		local v55 = "<p><font color=\"" .. v46.FloatingContentHex .. "\">" .. v54 .. "<font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v53 .. "</font></font></p>"
		movie:__wf_atom_50d60589(fn("PrereqSeparator.Description"), 36, v55)
		return v51, v52
	end

	local function fn45()
		local storeItem = v5.StoreItem
		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
		local inventory = nil

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			return false, false
		end

		local v50, v51 = fn44()
		v29:RemoveElements(true, true)
		fn42()

		if v50 then
			if not __wf_atom_7e8ad928(gGameData) then
				inventory = gGameData:GetInventory()
			end

			local guildTier = 0

			if v5.MetaData == nil or v5.MetaData.GuildTier == nil then
				if gGameRules:IsA(__wf_atom_1316e0c2) then
					guildTier = gGameRules:__wf_atom_7d674792()
				end
			else
				guildTier = v5.MetaData.GuildTier
			end

			local v52

			if v5.MetaData == nil then
				v52 = false
			else
				v52 = v5.MetaData.CheckResearch and state ~= v48.CRAFTING
			end

			local v53 = v52 and storeItem:__wf_atom_c4eef360() or storeItem:__wf_atom_524145ba()

			for i = 1, #v53 do
				local v54 = v53[i]
				local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(v54.mItemType)

				if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
					continue
				end

				local count2 = 0
				v29:RunForAllElements(function(data)
					if data.Type ~= nil and data.Type == v54.mItemType then
						count2 -= math.min(data.Req, data.Count)
					end
				end)
				local count = 0

				if
					v31[v54.mItemType:__wf_atom_5b41f63b()] == nil
					or v31[v54.mItemType:__wf_atom_5b41f63b()].Count == nil
				then
					if not __wf_atom_7e8ad928(inventory) then
						count = inventory:__wf_atom_52fcdd65(v54.mItemType)
					end
				else
					count = v31[v54.mItemType:__wf_atom_5b41f63b()].Count
				end

				count2 += count
				local storeItemInfo = module5.GetStoreItemInfo(movie, __wf_atom_232fd31d, nil, nil, nil, true)
				storeItemInfo.Req = v54.mItemCount
				local count3 = 0

				if v52 then
					storeItemInfo.Req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(nil, storeItemInfo.Req, guildTier, true)
					local mTechItem = v5.mTechItem

					if mTechItem then
						for j = 1, #mTechItem.mReqItems do
							if mTechItem.mReqItems[j].mItemType == v54.mItemType then
								count3 = storeItemInfo.Req - mTechItem.mReqItems[j].mItemCount
							end
						end
					end
				end

				if v54.mItemType:IsA(__wf_atom_9df43583) then
					count2 = __wf_atom_421b01aa(count2, 0, v54.mItemCount)
				else
					count2 = math.max(count2, 0)
				end

				if v52 then
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

				v29:AddElement(storeItemInfo, true)
			end

			local req = v52 and storeItem:__wf_atom_0df579e8() or storeItem:__wf_atom_6276eba2()

			if req > 0 then
				local v55 = {
					Themed = true,
					Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_BuyWithCredits", false),
					Icon = creditsIcon
				}
				local count = 0

				if v52 then
					req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(nil, req, guildTier, true)

					if v5.mTechItem then
						count = req - v5.mTechItem.mReqCredits

						if count < req then
							v55.mIncomplete = true
						end

						local __wf_atom_7050e489 = gGameData:__wf_atom_7050e489()
						v55.mHasResources = req - count <= __wf_atom_7050e489
					end
				elseif not __wf_atom_7e8ad928(gGameData) then
					count = gGameData:__wf_atom_7050e489()
				end

				v55.Count = count
				v55.Req = req
				v29:InsertElement(1, v55, true)
			end
		end

		v29:Redraw(nil, nil, true)
		return v50, v51
	end

	local function fn46(infoPopup_Grid, p, storeItem, mDesc, _, p2, p3, p4, p5)
		local _, v50 = module2.GetGridItemName(movie, infoPopup_Grid, v5, v5.MetaData)
		tags = {}

		if v5.CustomEntry and not __wf_atom_7e8ad928(v5.Tags) then
			tags = v5.Tags
		else
			if v5.ShowInfoPopupOwned and v5.MetaData then
				v5.MetaData.HideOwned = nil
				v5.MetaData.HideCountThreshold = 0
				v5.MetaData.OwnedInfo = {
					TagOverride = "/Lotus/Language/Menu/Crafting_Owned_Icon_Label",
					mShowOne = true
				}
			end

			tags = module2.GetGridItemTags(movie, infoPopup_Grid, v5, v5.MetaData, v50)
		end

		movie:__wf_atom_e57658c2(fn("TagContainer"), 1, v10)
		local count = 0
		local v51 = 300
		local v52 = 0
		local flag2 = false

		for _, tag in ipairs(tags) do
			if not tag.ExcludeFromInfoPopup then
				count += 1
			end
		end

		v45 = count
		local v53 = true

		for _, tag in ipairs(tags) do
			if not (tag.ExcludeFromInfoPopup or tag.UseFullLabel) then
				total2 += 35
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
				rightAlignPopup = not v53

				if not rightAlignPopup then
					if tag.Type == module2.LABEL_TYPE_FAVORITE then
						rightAlignPopup = not (v53 or tag.UseFullLabel)
					else
						rightAlignPopup = true
					end
				end
			else
				rightAlignPopup = not (v53 or tag.UseFullLabel)
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
				tag.Name = movie:__wf_atom_8e9ac384(tag.PopUpLabel, true)
			end

			local clipName2
			clipName2, p = module2.GetPriceLabelClip(movie, clipName, p)

			if not rightAlignPopup then
				tag.FitText = true
				tag.MaxWidth = v11 - total2
			end

			module2.DrawPriceLabel(movie, clipName2, tag)
			tag.ClipName = clipName2
			local v56 = movie:__wf_atom_5e6e15c8(clipName2 .. ".Label", 41) + module3.Ternary(tag.TagBuffer == nil, 13, tag.TagBuffer)

			if rightAlignPopup then
				local v57 = movie:__wf_atom_5e6e15c8(clipName2 .. ".IconText", 40) or 0

				if v57 > 0 then
					v51 = v51 - v57 + 5
				end

				movie:__wf_atom_e57658c2(clipName2, 1, 0)
				movie:__wf_atom_e57658c2(clipName2, 0, v51)
				v51 += -32
				local _ = v57 > 0

				if not v53 then
					v52 = math.max(v52, v56)
				end
			else
				movie:__wf_atom_e57658c2(clipName2, 1, v52)
				v52 += v56
				v53 = false
			end
		end

		local v54 = v52 == 0 and count > 0 and 30 or v52
		v10 += v54

		if v5.NotOwned and not __wf_atom_7e8ad928(storeItem) then
			local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(storeItem:__wf_atom_42794027():c_str(), true)

			if __wf_atom_8e9ac384 ~= "" then
				if v14 ~= "" then
					v14 ..= "\r\n\r\n"
				end

				v14 ..= __wf_atom_8e9ac384 .. "\r\n\r\n"
			end
		end

		if v5.NextSuitLevel ~= nil then
			local v55 = TitleCase(movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", true, {
				RANK = v5.NextSuitLevel
			}))
			local rank = "<font color=\"" .. v46.ContentHex .. "\">" .. v55 .. "</font>"

			if v5.Locked then
				v14 ..= movie:__wf_atom_8e9ac384("/Lotus/Language/Suits/AbilityUnlockedAt", true, {
					RANK = rank
				}) .. "\r\n\r\n"
			else
				v14 ..= movie:__wf_atom_8e9ac384("/Lotus/Language/Suits/AbilityUpgradeAt", true, {
					RANK = rank
				}) .. "\r\n\r\n"
			end

			v14 = "<font color=\"" .. v46.FloatingContentHex .. "\">" .. v14 .. "</font>"
		end

		if #v5.Hints > 0 then
			v14 ..= v5.Hints[v6.mCurrentElementIndex or 1]
		end

		if not __wf_atom_7e8ad928(v5.mMeleeSet) then
			local __wf_atom_27db0e17 = v5.mMeleeSet:__wf_atom_27db0e17()

			if v5.mMeleeCallouts == nil then
				v5.mMeleeCallouts = {}
			end

			local v55 = "<font color=\"" .. v46.FloatingContentHighlightHex .. "\">"

			for i = 1, #__wf_atom_27db0e17 do
				local v56

				if v5.mMeleeCallouts[i] == nil then
					v56 = ""
				else
					local mMeleeCallout = v5.mMeleeCallouts[i]
					local v57

					if
						mMeleeCallout == "<MELEE>"
						or mMeleeCallout == "<AIM_WEAPON>"
						or mMeleeCallout == "<MELEE_CHANNEL>"
					then
						v57 = movie:__wf_atom_8e9ac384("/Lotus/Language/Melee/ComboBtnPress", true, {
							ACTION = mMeleeCallout
						})
					else
						v57 = movie:__wf_atom_8e9ac384(mMeleeCallout, true)
					end

					v56 = v57 .. "<br>"
				end

				v14 ..= v56
				local v57 = math.max(1, __wf_atom_27db0e17[i]:__wf_atom_7ee4ff02())

				for j = 1, v57 do
					local __wf_atom_6b8680b1 = __wf_atom_27db0e17[i]:__wf_atom_6b8680b1(j - 1)
					local v58 = __wf_atom_6b8680b1 == 0.01 and 0 or __wf_atom_6b8680b1
					v14 ..= "    " .. movie:__wf_atom_8e9ac384("/Lotus/Language/Melee/ComboAttack", false, {
						OPEN_COLOR = v55,
						VALUE = module3.FormatNumber(100 * v58),
						CLOSE_COLOR = "</font>"
					})

					for k = 0, 32 - 1 do
						if __wf_atom_27db0e17[i]:__wf_atom_c7927521(j - 1, false, k) then
							v14 ..= " + " .. movie:__wf_atom_8e9ac384("<" .. module.GetProcTypeTag(k) .. ">", true)
						end
					end

					v14 ..= module3.Ternary(j == v57, "", "<br>")
				end

				v14 ..= module3.Ternary(i == #__wf_atom_27db0e17, "", "<br><br>")
			end
		end

		if
			__wf_atom_7e8ad928(storeItem)
			or __wf_atom_7e8ad928(storeItem:GetItem())
			or not storeItem:GetItem():IsA(__wf_atom_6317e6dc)
		then
			if flag2 then
				v14 = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Blueprint_UnlimitedCharges", true) .. "<br>" .. v14 .. movie:__wf_atom_8e9ac384(v5.Description, false)
			elseif __wf_atom_7e8ad928(v5.mMod) then
				if v5.LocalizedDesc == nil then
					v14 ..= movie:__wf_atom_8e9ac384(v5.Description, false)
				else
					v14 ..= v5.LocalizedDesc
				end
			end
		else
			v14 ..= module5.GetRelicInfo(movie, storeItem, true)
		end

		if #v5.LongDesc > 0 then
			if #v14 > 0 then
				v14 = "<br><br>" .. v14
			end

			v14 = "<font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v5.LongDesc .. "</font>" .. v14
		end

		if #v5.MergeDesc > 0 then
			if #v14 > 0 then
				v14 ..= "<br><br>"
			end

			v14 ..= v5.MergeDesc
		end

		if #v5.ListItems > 0 then
			local v55 = ""

			for _, listItem in ipairs(v5.ListItems) do
				if #listItem.Label > 0 then
					if #v55 > 0 then
						v55 ..= "<br>"
					end

					v55 ..= listItem.Label
				end

				if not (#listItem.Desc > 0) then
					continue
				end

				local v56 = v55 .. "<font color=\"" .. v46.ContentHex .. "\">"

				for i = 1, #listItem.Desc do
					v56 ..= "<br>     " .. listItem.Desc[i]
				end

				v55 = v56 .. "</font>"
			end

			if #v55 > 0 then
				if #v14 > 0 then
					v14 ..= "<br><br>"
				end

				v14 ..= "<font color=\"" .. v46.FloatingContentHex .. "\">" .. v55 .. "</font>"
			end
		end

		if v5.SalvageTimeRemaining ~= nil then
			local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v5.SalvageTimeRemaining)

			if __wf_atom_db2b0cee > 0 then
				local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(
					"/Lotus/Language/Railjack/SalvageTimeRemaining",
					true,
					{
						REPAIR_TIME = module.GetTwitterStyleTime(__wf_atom_db2b0cee, true, true)
					}
				)
				v14 = "<font color=\"" .. v46.FloatingContentHex .. "\">" .. __wf_atom_8e9ac384 .. "</font>" .. "<br>" .. v14
			else
				v14 = "<font color=\"" .. v46.FloatingContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
					"/Lotus/Language/Railjack/SalvageReadyToClaim",
					true
				) .. "</font>" .. "<br>" .. v14
			end
		end

		if not v5.ShowDucatTag then
			if not __wf_atom_7e8ad928(storeItem) then
				v5.PrimePrice = storeItem:__wf_atom_69dc9a11()
			end

			if v5.PrimePrice ~= nil and v5.PrimePrice > 0 then
				if v14 ~= "" then
					v14 ..= "<br><br>"
				end

				v14 ..= movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_ValuePrimeBucks", true, {
					COST = v5.PrimePrice
				})
			end
		end

		if v14 ~= "" and mDesc ~= "" then
			v16 = string.len(v14)
		end

		local v55 = false
		local flag3 = false
		local v56 = false

		if v5.IngredientOverride == nil then
			if __wf_atom_7e8ad928(storeItem) or not storeItem:IsA(__wf_atom_bf37f5ca) or v5.HideRecipe then
				if v5.Capacity ~= nil then
					local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

					if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
						v55 = true
						v29:RemoveElements(true, true)
						local v57 = { availableCapacity = 0, capacityParams = nil }

						if __wf_atom_7e8ad928(_T.DojoMgr) then
							v57.capacityParams = module.GetShipDecoRoom()
							v57.availableCapacity = gGameData:__wf_atom_31e514d3(v57.capacityParams)
						else
							v57.capacityParams = _T.DojoMgr:BuildComponentParams(__wf_atom_c4f78a8f:__wf_atom_e800787c():__wf_atom_58b2e21e())
							v57.availableCapacity = _T.DojoMgr.mDojo:GetJsonComponent(v57.capacityParams):__wf_atom_47a3d3d2()
						end

						local v58 = {
							Icon = capacityIcon,
							TintIconColor = v46.FloatingContent,
							Themed = true,
							Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v5.Capacity,
							Req = 1,
							Count = module3.Ternary(v5.Capacity <= v57.availableCapacity, 1, 0),
							SubText = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
								COUNT = v57.availableCapacity
							})
						}
						v29:AddElement(v58, true)
						v29:Redraw(nil, nil, true)
					end
				end
			else
				local v57 = v5

				if v57 and v57.NumPortals ~= nil and not __wf_atom_7e8ad928(_T.DojoMgr) then
					local __wf_atom_ba75ca7b = v57.Recipe:__wf_atom_ba75ca7b()
					local v58 = v57.NumPortals ~= 1
						and movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/NumberOfDoors", false, {
							DOORS = v57.NumPortals
						})
						or movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/OneDoor", false, nil)

					if v57.NumPortals <= 1 then
						v58 ..= " / " .. movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/DeadEndWarning", false, nil)
					end

					if __wf_atom_ba75ca7b > 0 then
						local v59 = "/Lotus/Language/Clan/Tier" .. __wf_atom_ba75ca7b .. "Name"
						local v60 = {
							TierClanSize = __wf_atom_c67f9605:__wf_atom_e0d9634c(__wf_atom_ba75ca7b),
							TierName = movie:__wf_atom_8e9ac384(v59, false)
						}
						v14 = movie:__wf_atom_8e9ac384(v57.Recipe:__wf_atom_3a3d2e39():c_str(), true, v60)
					end

					v14 = "<font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v58 .. "</font>" .. "<br>" .. v14 .. "<br><br><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. movie:__wf_atom_8e9ac384(
						"/Lotus/Language/Dojo/RequireLabel",
						true
					) .. "<br></font>"
					local v59 = Resource("/Lotus/Types/Game/Store/DojoRecipeManifest")
					local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
					local __wf_atom_7e0e1506 = v57.Recipe:__wf_atom_7e0e1506()
					v55 = true
					v29:RemoveElements(true, true)

					if not __wf_atom_7e8ad928(__wf_atom_7e0e1506) and #__wf_atom_7e0e1506 > 0 then
						for i = 1, #__wf_atom_7e0e1506 do
							local v60 = __wf_atom_7e0e1506[i]

							for j = 1, #v60 do
								if __wf_atom_7e8ad928(v60[j]) then
									continue
								end

								local __wf_atom_e564443c = v59:__wf_atom_e564443c(v60[j])

								if __wf_atom_7e8ad928(__wf_atom_e564443c) then
									continue
								end

								local storeItem2 = __wf_atom_964056fd:GetStoreItem(WeakResource(__wf_atom_e564443c:__wf_atom_5b41f63b()))
								local storeItemInfo = module5.GetStoreItemInfo(movie, storeItem2, nil, nil, nil, true)
								storeItemInfo.HideCount = true
								storeItemInfo.Req = 1
								storeItemInfo.Count = module3.Ternary(_T.DojoMgr.mDojo:__wf_atom_4a314099(v60), 1, 0)
								storeItemInfo.Name = movie:__wf_atom_8e9ac384(
									storeItem2:__wf_atom_014a76a2():c_str(),
									false
								)
								storeItemInfo.Material = v57.InfoMaterial
								v29:AddElement(storeItemInfo, true)
							end
						end
					end

					local v60 = -v57.Recipe:__wf_atom_be9cf318()
					local __wf_atom_be9cf318 = _T.DojoMgr.mDojo:__wf_atom_be9cf318()
					local v61 = {
						Icon = capacityIcon,
						TintIconColor = v46.FloatingContent,
						Themed = true,
						Req = 1,
						Count = module3.Ternary(v60 <= __wf_atom_be9cf318, 1, 0),
						SubText = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
							COUNT = __wf_atom_be9cf318
						})
					}
					local v62

					if v60 < 0 then
						v60 = -v60
						v62 = movie:__wf_atom_8e9ac384("<UPARROW>", true)
					else
						v62 = ""
					end

					v61.Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v60 .. v62
					v29:AddElement(v61, true)
					local v63 = -v57.Recipe:__wf_atom_d905c44b()
					local __wf_atom_d905c44b = _T.DojoMgr.mDojo:__wf_atom_d905c44b()
					local v64 = {
						Icon = energyIcon,
						TintIconColor = v46.FloatingContent,
						Themed = true,
						Req = 1,
						Count = module3.Ternary(v63 <= __wf_atom_d905c44b, 1, 0),
						SubText = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
							COUNT = __wf_atom_d905c44b
						})
					}
					local v65

					if v63 < 0 then
						v63 = -v63
						v65 = movie:__wf_atom_8e9ac384("<UPARROW>", true)
					else
						v65 = ""
					end

					v64.Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/EnergyLabel", false) .. " " .. v63 .. v65
					v29:AddElement(v64, true)
					v29:Redraw(nil, nil, true)
				elseif v57 and v57.Capacity ~= nil and not __wf_atom_7e8ad928(_T.DojoMgr) then
					v55 = true
					v29:RemoveElements(true, true)
					local count2 = _T.ComponentParams == nil and 0
						or _T.DojoMgr.mDojo:GetJsonComponent(_T.ComponentParams):__wf_atom_47a3d3d2()
					local v59 = {
						Icon = capacityIcon,
						TintIconColor = v46.FloatingContent,
						Themed = true,
						Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/CapacityLabel", false) .. " " .. v57.Capacity,
						Req = 1,
						Count = module3.Ternary(v57.Capacity <= count2, 1, 0),
						SubText = movie:__wf_atom_8e9ac384("/Lotus/Language/Dojo/AvailableLabel", false, {
							COUNT = count2
						})
					}
					v29:AddElement(v59, true)
					v29:Redraw(nil, nil, true)

					if not (v57.HideRecipe or __wf_atom_7e8ad928(v57.Recipe)) then
						flag3 = true
						v30:RemoveElements(true, true)
						local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
						local v60 = movie:__wf_atom_8e9ac384("<TIMER> ", true) .. " " .. module.SecondsToFormattedTime(
							movie,
							v57.Recipe:__wf_atom_ed1be18b(),
							"CompactHours"
						)
						local v61 = "<p><font color=\"" .. v46.FloatingContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_BpAbout",
							false
						) .. "<br><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v60 .. "</font></font></p>"
						movie:__wf_atom_50d60589(fn("IngredientsSeparator.Description"), 36, v61)
						local __wf_atom_ad81b9a4 = __wf_atom_c67f9605:__wf_atom_ad81b9a4(
							v57.Recipe,
							v57.Recipe:__wf_atom_6276eba2(),
							_T.DojoMgr.mGameRules:__wf_atom_7d674792(),
							false
						)

						if __wf_atom_ad81b9a4 > 0 then
							local v62 = {
								Name = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_BuyWithCredits", false),
								Req = __wf_atom_ad81b9a4,
								Icon = creditsIcon,
								Themed = true
							}
							v30:AddElement(v62, true)
						end

						local __wf_atom_524145ba = v57.Recipe:__wf_atom_524145ba()

						for i = 1, #__wf_atom_524145ba do
							local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(__wf_atom_524145ba[i].mItemType)
							local storeItemInfo = module5.GetStoreItemInfo(
								movie,
								__wf_atom_232fd31d,
								nil,
								nil,
								nil,
								true
							)
							storeItemInfo.Req = __wf_atom_c67f9605:__wf_atom_ad81b9a4(
								v57.Recipe,
								__wf_atom_524145ba[i].mItemCount,
								_T.DojoMgr.mGameRules:__wf_atom_7d674792(),
								false
							)
							v30:AddElement(storeItemInfo, true)
						end

						v30:Redraw(nil, nil, true)
					end
				elseif not (__wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_dd9a0bb8)) then
					v55, v56 = fn45()
				end
			end
		else
			v29:RemoveElements(true, true)
			v55 = true

			for i = 1, #v5.IngredientOverride do
				v29:AddElement(v5.IngredientOverride[i], true)
			end

			v29:Redraw(nil, nil, true)
		end

		if not __wf_atom_7e8ad928(v5.CodexEntry) then
			v14 ..= module8.GetEnemyInfoText(movie, v5.CodexEntry, v46.FloatingContentHighlightHex, v46.ContentHex)
		end

		if not __wf_atom_7e8ad928(infoPopup_Grid) then
			if not __wf_atom_7e8ad928(storeItem) and storeItem:IsPackage() then
				local packageContentsDesc = module5.GetPackageContentsDesc(
					movie,
					storeItem,
					infoPopup_Grid.PurchasedItems,
					"#cbc3ad",
					"#847a61",
					18
				)

				if #v5.ExtraItems > 0 then
					local v57 = packageContentsDesc .. "<br><br>" .. Localize("/SF/Language/Vendor/ExternalIncludes", nil)
					local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384("<BULLET>", true)
					local v58 = v57 .. "<font color=\"#cbc3ad\">"

					for _, extraItem in v5.ExtraItems do
						if #v58 > 0 then
							v58 ..= "<br>"
						end

						v58 ..= __wf_atom_8e9ac384 .. Localize(extraItem, nil)
					end

					packageContentsDesc = v58 .. "</font>"
				end

				if v14 ~= "" and packageContentsDesc ~= "" then
					v14 ..= "<br><br>"
				end

				v14 ..= packageContentsDesc
			end

			local v57

			if not (__wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gGameData)) then
				local v58, v59
				v58, v57, v59 = module5.GetCompatWarning(
					movie,
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

			if v57 ~= nil and v57 ~= "" then
				if v14 ~= "" then
					v14 ..= "<br><br>"
				end

				v14 ..= movie:__wf_atom_8e9ac384("<WARNING>", true) .. " " .. v57
			end
		end

		if
			not __wf_atom_7e8ad928(v5)
			and not __wf_atom_7e8ad928(v5.StoreItem)
			and module12.IsMoteType(v5.Type)
			and not (__wf_atom_7e8ad928(v5.RawItem) or __wf_atom_7e8ad928(v5.MoteRes))
		then
			if v5.RawItem.mItemId == nil then
				print("ItemType: " .. tostring(v5.RawItem.mItemType:__wf_atom_5b41f63b()))
				print("UpgradeFingerprint: " .. tostring(v5.RawItem.mUpgradeFingerprint))
				LogBug("Attempting to get mote description for a malformed item")
				v14 = ""
			else
				local upgradeInfo = SF.UpgradeInfo()
				upgradeInfo.mItemId = v5.RawItem.mItemId
				upgradeInfo.mUpgradeFingerprint = v5.RawItem.mUpgradeFingerprint
				upgradeInfo.mItemType = v5.RawItem.mItemType
				v14 = movie:__wf_atom_8e9ac384(module13.GetMoteDescription({
					Type = v5.RawItem.mItemType,
					Instance = v5.MoteRes,
					Upgrade = upgradeInfo,
					Polarity = v5.MoteRes:__wf_atom_c05c3cf5(v5.RawItem.mUpgradeFingerprint),
					Size = v5.MoteRes:__wf_atom_1c14f269(),
					Weapon = nil
				}), true)
			end
		end

		if __wf_atom_7e8ad928(v5.mMod) then
			if v5.mModDescOverride == nil then
				if v5.ArcaneRank ~= nil then
					if v5.CompatLabel ~= nil then
						v14 ..= v5.CompatLabel .. "<br><br>"
					end

					local arcaneMaxRank = v5.ArcaneRank < 0 and v5.ArcaneMaxRank or v5.ArcaneRank
					local v57 = module3.Ternary(
						arcaneMaxRank == 0,
						movie:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false),
						movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
							RANK = arcaneMaxRank
						})
					) .. "  "
					local v58 = ""
					local mInstance = nil

					if __wf_atom_7e8ad928(v5.Arcane) then
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
						mInstance = v5.Arcane.mInstance
					end

					if not __wf_atom_7e8ad928(mInstance) then
						v58 = movie:__wf_atom_8e9ac384(
							mInstance:__wf_atom_f324d993((mInstance:__wf_atom_254ac1f5(arcaneMaxRank))),
							true
						)
					end

					if v5.ShowAllRanks then
						v14 ..= module5.GetUpgradeInfo(
							movie,
							storeItem,
							v46.FloatingContentHighlightHex,
							v46.FloatingContentHex,
							" ",
							""
						)
					else
						v14 ..= "<font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v57 .. "</font><font color=\"" .. v46.FloatingContentHex .. "\">" .. v58 .. "</font>"
					end
				end
			else
				v14 ..= v5.mModDescOverride
			end
		else
			v14 ..= v5.mMod.Card.mDesc
		end

		if p2 < v10 then
			v10 += 6
		else
			v10 -= 11
		end

		movie:__wf_atom_e57658c2(fn("TagSeparator"), 1, v10)

		if v5.CustomEntry and v5.RankedProgress ~= nil then
			module11.DrawRankIndicator(movie, fn("RankedProgress.Rank"), {
				Level = v5.RankedProgress.Rank
			})
			movie:OverrideMaterial(fn("RankedProgress.Bar.Fill"), _G.UIMaterial_RectangleNoDepth)
			movie:OverrideMaterial(fn("RankedProgress.Bar.Bg"), _G.UIMaterial_RectangleNoDepth)
			movie:__wf_atom_e57658c2(fn("RankedProgress.Title"), 44, v46.FloatingContent)
			movie:__wf_atom_e57658c2(fn("RankedProgress.Progress"), 44, v46.FloatingContentHighlight)
			local background1RGB = v46.Background1RGB
			local floatingContentRGB = v46.FloatingContentRGB
			movie:__wf_atom_1ca72041(
				fn("RankedProgress.Bar.Fill"),
				"RectInnerColor",
				floatingContentRGB.r,
				floatingContentRGB.g,
				floatingContentRGB.b,
				1
			)
			movie:__wf_atom_1ca72041(
				fn("RankedProgress.Bar.Fill"),
				"RectEdgeColor",
				floatingContentRGB.r,
				floatingContentRGB.g,
				floatingContentRGB.b,
				1
			)
			movie:__wf_atom_1ca72041(
				fn("RankedProgress.Bar.Bg"),
				"RectInnerColor",
				background1RGB.r,
				background1RGB.g,
				background1RGB.b,
				0
			)
			movie:__wf_atom_1ca72041(
				fn("RankedProgress.Bar.Bg"),
				"RectEdgeColor",
				floatingContentRGB.r,
				floatingContentRGB.g,
				floatingContentRGB.b,
				1
			)
			movie:__wf_atom_e57658c2(fn("RankedProgress.Bar.Bg"), 14, 256)
			movie:__wf_atom_e57658c2(
				fn("RankedProgress.Bar.Fill"),
				14,
				(math.max(
					252 * (math.min(v5.RankedProgress.Progress, v5.RankedProgress.Required) / v5.RankedProgress.Required),
					0.1
				))
			)
			movie:__wf_atom_e57658c2(fn("RankedProgress.Progress"), 14, 256)
			movie:__wf_atom_50d60589(fn("RankedProgress.Title"), 36, v5.RankedProgress.Name)
			movie:__wf_atom_50d60589(
				fn("RankedProgress.Progress"),
				36,
				v5.RankedProgress.ProgressPrefix .. module3.FormatNumber(v5.RankedProgress.Progress) .. "/" .. module3.FormatNumber(v5.RankedProgress.Required)
			)
			movie:__wf_atom_2dedec1a(fn("RankedProgress"), 13, true)
			movie:__wf_atom_e57658c2(fn("RankedProgress"), 1, v10)
			v10 += 64
		end

		local v57 = v5.PreviewImage ~= nil

		if v57 then
			movie:__wf_atom_e57658c2(fn("VideoPreview"), 1, v10)
			movie:__wf_atom_e57658c2(fn("VideoPreview.Mask"), 14, 330)
			movie:__wf_atom_e57658c2(fn("VideoPreview.Mask"), 15, 185)

			if v5.PreviewImage:IsA(__wf_atom_8a33958d) then
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 1, 0)
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 14, 330)
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 15, 185)
			else
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 1, -30)
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 14, 330)
				movie:__wf_atom_e57658c2(fn("VideoPreview.Image"), 15, 330)
				movie:OverrideMaterial(fn("VideoPreview.Image"), parallaxIconMaterial)
				movie:__wf_atom_1ca72041(fn("VideoPreview.Image"), "DetailMapParams", 0, 0, 1, 1)
				movie:__wf_atom_1ca72041(fn("VideoPreview.Image"), "BlendOffsetParallax", 1, 0.5, 1, 0.025)
				movie:__wf_atom_1ca72041(fn("VideoPreview.Image"), "TintColor", 1, 1, 1, 0)
				local v58 = v5.AutoParallaxX and 1 or 0
				local v59 = v5.AutoParallaxY and 1 or 0
				movie:__wf_atom_1ca72041(fn("VideoPreview.Image"), "AutoOffsetParallax", v58, v59, 1, 0)
			end

			local v58 = not __wf_atom_1ef90898(v5.PreviewImage)
			movie:__wf_atom_2dedec1a(fn("VideoPreview.Image"), 13, v58)

			if v58 then
				if v5.SkipVideoReset then
					movie:__wf_atom_c90af43a(fn("VideoPreview.Image"), v5.PreviewImage)
					v5.SkipVideoReset = nil
				else
					movie:__wf_atom_3f8dd1de(fn("VideoPreview.Image"))
					movie:__wf_atom_c90af43a(fn("VideoPreview.Image"), v5.PreviewImage)
					movie:__wf_atom_e3debc9a(fn("VideoPreview.Image"))
				end
			else
				v25:SetActive(true)
				movie:__wf_atom_e57658c2(fn("Spinner"), 1, v9 + 93)
			end

			v10 = v10 + 185 + 6
		else
			v10 += 10
		end

		movie:__wf_atom_2dedec1a(fn("VideoPreview"), 13, v57)

		if v16 ~= 0 then
			mDesc = "\r\n\r\n" .. mDesc
		end

		if (p5 == nil or p5 == "") and not (v45 > 0) then
			if
				v5.Type
				and (v5.Type:IsA(WeakResource("/SF/Types/Recipes/Pacts/PactBlueprint")) or v5.Type:IsA(__wf_atom_d98e64fe))
			then
				movie:__wf_atom_2dedec1a(fn("DescInfoArea"), 13, true)
				movie:__wf_atom_e57658c2(fn("DescInfoArea"), 1, v10)

				if v5.Type:IsA(WeakResource("/SF/Types/Recipes/Pacts/PactBlueprint")) then
					movie:__wf_atom_50d60589(
						fn("DescInfoArea.Title"),
						36,
						"<p><font color=\"" .. v46.YellowColorHex .. "\">" .. movie:__wf_atom_8e9ac384(
							"/SF/Language/SystemMessages/PactFragment",
							true
						) .. " " .. "</font></p>" .. "<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384("<FRAGMENTS>", true) .. "</font></p>"
					)
					movie:__wf_atom_50d60589(
						fn("DescInfoArea.Desc"),
						36,
						"<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
							"/SF/Language/SystemMessages/PactFragmentDescription",
							true
						) .. "</font></p>"
					)
				elseif v5.Type:IsA(__wf_atom_d98e64fe) then
					movie:__wf_atom_50d60589(
						fn("DescInfoArea.Title"),
						36,
						"<p><font color=\"" .. v46.YellowColorHex .. "\">" .. movie:__wf_atom_8e9ac384(
							"/SF/Language/SystemMessages/PactSlot",
							true
						) .. " " .. "</font></p>" .. "<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384("<PACT_ICON>", true) .. "</font></p>"
					)
					movie:__wf_atom_50d60589(
						fn("DescInfoArea.Desc"),
						36,
						"<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
							"/SF/Language/SystemMessages/PactDescription",
							true
						) .. "</font></p>"
					)
				end

				movie:__wf_atom_2dedec1a(fn("DescInfoArea.Desc"), 52, true)
				v10 = v10 + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Title"), 15) + movie:__wf_atom_5e6e15c8(fn("DescInfoArea.Desc"), 41) + 10
				movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, true)
				movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, true)
				movie:__wf_atom_e57658c2(fn("GroupDivider1"), 1, v10)
			end
		else
			if not (v5.PurchaseContext and flag) then
				movie:__wf_atom_2dedec1a(fn("DescStatItem"), 13, true)
				movie:__wf_atom_e57658c2(fn("DescStatItem"), 1, v10)
				movie:__wf_atom_50d60589(
					fn("DescStatItem.Stat"),
					36,
					"<p><font color=\"" .. v46.ContentHex .. "\">" .. p5 .. "</font></p>"
				)
				movie:__wf_atom_2dedec1a(fn("DescStatItem.Label"), 52, false)
				movie:__wf_atom_50d60589(
					fn("DescStatItem.Label"),
					36,
					"<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
						"/SF/Language/Menu/Stat_ItemCreator",
						true
					) .. "</font></p>"
				)
				v10 = v10 + movie:__wf_atom_5e6e15c8(fn("DescStatItem.Stat"), 41) + 15
			end

			movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, true)
			movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, true)
			movie:__wf_atom_e57658c2(fn("GroupDivider1"), 1, v10)
		end

		movie:__wf_atom_e57658c2(fn("Description"), 1, v10)
		movie:__wf_atom_50d60589(
			fn("Description"),
			36,
			"<p><font color=\"" .. v46.ContentHex .. "\">" .. v14 .. mDesc .. "</font></p>"
		)

		if v14 == "" then
			v10 -= 21
		else
			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("Description"), 41) + 15
		end

		movie:__wf_atom_2dedec1a(fn("TagSeparator"), 13, false)
		movie:__wf_atom_2dedec1a(fn("CrewMemberInfo"), 13, v5.CrewMemberInfo ~= nil)

		if v5.CrewMemberInfo ~= nil then
			fn32(p3, v5.CrewMemberInfo:__wf_atom_894dc31a())
		end

		movie:__wf_atom_2dedec1a(fn("ExtraDesc"), 13, v5.ExtraDesc ~= nil)

		if v5.ExtraDesc ~= nil then
			movie:OverrideMaterial(fn("ExtraDesc.Bg"), _G.UIMaterial_RectangleNoDepth)
			local background1RGB = v46.Background1RGB
			local floatingContentRGB = v46.FloatingContentRGB
			movie:__wf_atom_1ca72041(
				fn("ExtraDesc.Bg"),
				"RectInnerColor",
				background1RGB.r,
				background1RGB.g,
				background1RGB.b,
				0.2
			)
			movie:__wf_atom_1ca72041(
				fn("ExtraDesc.Bg"),
				"RectEdgeColor",
				floatingContentRGB.r,
				floatingContentRGB.g,
				floatingContentRGB.b,
				0.7
			)
			movie:__wf_atom_c90af43a(fn("ExtraDesc.Icon"), v5.ExtraDesc.Icon)
			movie:__wf_atom_e57658c2(fn("ExtraDesc.Icon"), 11, v46.FloatingContentHighlight)
			movie:__wf_atom_50d60589(fn("ExtraDesc.Title"), 36, v5.ExtraDesc.Title)
			movie:__wf_atom_e57658c2(fn("ExtraDesc.Title"), 44, v46.FloatingContentHighlight)
			movie:__wf_atom_50d60589(fn("ExtraDesc.Desc"), 36, v5.ExtraDesc.Desc)
			movie:__wf_atom_e57658c2(fn("ExtraDesc.Desc"), 44, v46.Content)
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("ExtraDesc.Desc"), 41)
			movie:__wf_atom_e57658c2(fn("ExtraDesc.Bg"), 15, __wf_atom_5e6e15c8 + 50)
			movie:__wf_atom_e57658c2(fn("ExtraDesc"), 1, v10 + 5)
			v10 = v10 + __wf_atom_5e6e15c8 + 55
		end

		movie:__wf_atom_2dedec1a(fn("Invasion"), 13, v5.SubInvasions ~= nil)

		if v5.SubInvasions ~= nil then
			local customEntry = v5.SubInvasions[1].CustomEntry
			v37.mForcedVerticalSeparation = module3.Ternary(customEntry, 50, 75)
			movie:__wf_atom_e57658c2(fn("Invasion"), 1, v10 + module3.Ternary(customEntry, -15, 5))
			v37:RemoveElements(true, true)

			for i = 1, #v5.SubInvasions do
				v37:AddElement(v5.SubInvasions[i], true)
			end

			v37:Redraw(nil, true, true)
			v10 += v37:GetHowManyElements() * v37.mForcedVerticalSeparation
		end

		if v5.RarityChances == nil then
			movie:__wf_atom_2dedec1a(fn("RarityBar"), 13, false)
		else
			movie:__wf_atom_2dedec1a(fn("RarityBar"), 13, true)
			module2.DrawRarityBar(movie, fn("RarityBar"), v5.RarityChances, 330, barMaterial, 0, -16, 10, v10 + 30)
			v10 += 40
		end

		movie:__wf_atom_2dedec1a(fn("Prerequisite"), 13, v56)

		if v56 then
			movie:__wf_atom_e57658c2(fn("Prerequisite"), 1, v10 + 20)
			v10 += 123
			local mPrereqElement = v5.mPrereqElement
			movie:__wf_atom_c90af43a(fn("Prerequisite.Icon"), mPrereqElement.Icon)
			movie:OverrideMaterial(fn("Prerequisite.Icon"), mPrereqElement.Material)
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("Prerequisite.Icon"), 15)

			if not mPrereqElement.Themed then
				__wf_atom_5e6e15c8 *= 1.6
			end

			movie:__wf_atom_e57658c2(fn("Prerequisite.Icon"), 14, __wf_atom_5e6e15c8)
			local v59 = "<p><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. Localize("/Lotus/Language/Dojo/Prerequisite", {}) .. "</font></p>"
			movie:__wf_atom_50d60589(fn("Prerequisite.Header"), 36, v59)
			local v60 = "<p><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. "<font color=\"" .. v46.FloatingContentHex .. "\">" .. TitleCase(mPrereqElement.Name) .. "<br></font>"
			local v61

			if
				not __wf_atom_7e8ad928(mPrereqElement.mCompletionDate)
				and Engine.__wf_atom_db2b0cee(mPrereqElement.mCompletionDate) <= 0
			then
				v61 = v60 .. "<font color=\"" .. v46.PositiveHex .. "\">" .. movie:__wf_atom_8e9ac384("<CHECKMARK_NO_BORDER> ", true) .. "</font>" .. movie:__wf_atom_8e9ac384(
					"/Lotus/Language/Categories/RESEARCHED",
					true
				)
			else
				v61 = v60 .. "<font color=\"" .. v46.NegativeHex .. "\">" .. movie:__wf_atom_8e9ac384(
					"<CHECKMARK_FAIL_NO_BORDER> ",
					true
				) .. "</font>" .. movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_ResearchNotStarted", true)
			end

			local v62 = v61 .. "</font></p>"
			movie:__wf_atom_50d60589(fn("Prerequisite.Name"), 46, "center")
			movie:__wf_atom_50d60589(fn("Prerequisite.Name"), 36, v62)
			movie:__wf_atom_2dedec1a(fn("Prerequisite.Bg"), 13, not __wf_atom_7e8ad928(mPrereqElement.Background))
			movie:__wf_atom_c90af43a(fn("Prerequisite.Bg"), mPrereqElement.Background)
			movie:__wf_atom_e57658c2(fn("Prerequisite.Bg"), 11, v46.FloatingContent)
			movie:OverrideMaterial(fn("Prerequisite.Bg"), _G.UIMaterial_RectangleNoDepth)
			movie:__wf_atom_1ca72041(fn("Prerequisite.Bg"), "RectEdgeColor", 1, 1, 1, 0)
			movie:__wf_atom_1ca72041(fn("Prerequisite.Bg"), "RectInnerColor", 1, 1, 1, 1)
			local background1RGB = v46.Background1RGB
			local backerHighlightRGB = v46.BackerHighlightRGB
			movie:OverrideMaterial(fn("Prerequisite.Border"), _G.UIMaterial_RectangleNoDepth)
			movie:__wf_atom_1ca72041(
				fn("Prerequisite.Border"),
				"RectEdgeColor",
				backerHighlightRGB.r,
				backerHighlightRGB.g,
				backerHighlightRGB.b,
				0.2
			)
			movie:__wf_atom_1ca72041(
				fn("Prerequisite.Border"),
				"RectInnerColor",
				background1RGB.r,
				background1RGB.g,
				background1RGB.b,
				0.2
			)
		end

		local researched = not v5.HideRecipe and (v5.Researched or v5.InProgress or v56)
		movie:__wf_atom_2dedec1a(fn("PrereqSeparator"), 13, researched)

		if researched then
			movie:__wf_atom_e57658c2(fn("PrereqSeparator"), 1, v10 + 10)
			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("PrereqSeparator.Description"), 41) + 21
		end

		movie:__wf_atom_2dedec1a(fn("Ingredients"), 13, v55)

		if v55 then
			movie:__wf_atom_e57658c2(fn("Ingredients"), 1, v10 + 10)
			local v59 = 0

			for _, mElement in ipairs(v29.mElements) do
				v59 = v59 + 5 + math.max(v29.mForcedVerticalSeparation, mElement.mHeight or 0)
			end

			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("Ingredients.ingredient"), 1) + v59
		end

		local v59 = v55 and flag3
		movie:__wf_atom_2dedec1a(fn("IngredientsSeparator"), 13, v59)

		if v59 then
			movie:__wf_atom_e57658c2(fn("IngredientsSeparator"), 1, v10 + 10)
			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("IngredientsSeparator.Description"), 41) + 21
		end

		movie:__wf_atom_2dedec1a(fn("IngredientsSecondary"), 13, flag3)

		if flag3 then
			movie:__wf_atom_e57658c2(fn("IngredientsSecondary"), 1, v10 + 10)
			local v60 = 0

			for _, mElement in ipairs(v30.mElements) do
				v60 = v60 + 5 + math.max(v30.mForcedVerticalSeparation, mElement.mHeight or 0)
			end

			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("IngredientsSecondary.ingredient"), 1) + v60
		end

		if v5.CustomEntry and v5.Affiliations ~= nil then
			v10 += 10
			p4 = #v5.Affiliations

			for i = v19 + 1, p4 do
				if not movie:__wf_atom_253d7085(fn("Affiliation") .. i) then
					__wf_atom_86cbd68d(movie, fn("Affiliation1.duplicateMovieClip"), "Affiliation" .. i, i)
				end
			end

			if p4 < v19 then
				for i = math.max(p4 + 1, 2), v19 do
					__wf_atom_86cbd68d(movie, fn("Affiliation") .. i .. ".removeMovieClip")
				end
			end

			v19 = math.max(1, p4)

			for i, affiliation in ipairs(v5.Affiliations) do
				local v60 = fn("Affiliation") .. i
				movie:__wf_atom_2dedec1a(v60, 13, true)
				movie:__wf_atom_e57658c2(v60, 1, v10)
				local v61 = affiliation.Level >= 0
				movie:__wf_atom_7f57ab2f(v60, "Border", 13, false)
				movie:__wf_atom_7f57ab2f(v60, "Bg", 13, false)
				movie:__wf_atom_4c1c1986(v60, "Border", 14, v11)
				movie:__wf_atom_4c1c1986(v60, "Bg", 14, v11)
				movie:__wf_atom_4c1c1986(v60, "Border", 11, v46.Background1)
				movie:__wf_atom_933bbce0(v60 .. ".Bg", _G.UITexture_MidBgTexture, _G.UIMaterial_MidBgMaterial)
				movie:__wf_atom_1ca72041(
					v60 .. ".Bg",
					"StartColor",
					v46.Background1RGB.r,
					v46.Background1RGB.g,
					v46.Background1RGB.b,
					1
				)
				local ternary = module3.Ternary(v61, v46.PositiveRGB, v46.NegativeRGB)
				movie:__wf_atom_1ca72041(v60 .. ".Bg", "EndColor", ternary.r / 1, ternary.g / 1, ternary.b / 1, 1)
				movie:__wf_atom_c90af43a(v60 .. ".Icon", affiliation.Icon)
				movie:__wf_atom_4c1c1986(v60, "Icon", 11, v46.FloatingContentHighlight)
				movie:__wf_atom_4c1c1986(v60, "Name", 44, v46.Content)
				movie:__wf_atom_48bd5a59(v60, "Label", 36, affiliation.Label)
				movie:__wf_atom_4c1c1986(v60, "Label", 1, 36 - movie:__wf_atom_cfc41e35(v60, "Label", 41) / 2)
				v10 += module3.Ternary(i ~= #v5.Affiliations, 70, 60)
			end
		end

		if v5.IsAbility then
			local v60 = mDisplayStats
			local v61 = mDisplayStats
			local v62 = mDisplayStats
			local v63 = mDisplayStats
			local statsTextForAbility, values, baseValues, statChanges = module7.GetStatsTextForAbility(v5)
			v60.Labels = statsTextForAbility
			v61.Values = values
			v62.BaseValues = baseValues
			v63.StatChanges = statChanges
		elseif v5.mDisplayStats ~= nil then
			mDisplayStats = v5.mDisplayStats
		end

		return p, "", p4
	end

	fn8 = function()
		if not fn7() and v44 then
			fn9()
		end

		if v44 and v5.CompareItemInfo and _T["InfoPopup_Data" .. 2] == nil then
			_T.CompareInfoPopup(v5.CompareItemInfo, 2, "")
		end

		v45 = 0
		movie:__wf_atom_2dedec1a(fn("DescStatItem"), 13, false)
		movie:__wf_atom_2dedec1a(fn("DescInfoArea"), 13, false)
		movie:__wf_atom_2dedec1a(fn("Leaves"), 13, not v5.HideLeaves)
		v41 = 8

		if v5.PreviewMode == nil or not v5.PreviewMode then
			if v5.EmbeddedMode == nil or not v5.EmbeddedMode then
				if popupMode then
					movie:__wf_atom_e57658c2("_root", 12, 100)
				end

				movie:__wf_atom_e57658c2(fn("OverallBG"), 12, 100)
				movie:__wf_atom_e57658c2(fn("HeaderItem1"), 12, 100)
				movie:__wf_atom_e57658c2(fn("HeaderItem2"), 12, 100)
				movie:__wf_atom_e57658c2(fn("BG"), 12, 100)
				movie:__wf_atom_e57658c2(fn("BGSecondGroup"), 12, 100)
				movie:__wf_atom_e57658c2(fn("BGThirdGroup"), 12, 100)
				movie:__wf_atom_e57658c2(fn("Blurer"), 12, 100)
				movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 12, 100)
				movie:__wf_atom_e57658c2(fn("Leaves"), 12, 100)
				movie:__wf_atom_e57658c2(clipName, 5, maxScale)
				movie:__wf_atom_e57658c2(clipName, 6, maxScale)
				v41 = popupMode and 8 or 4
			else
				if popupMode then
					movie:__wf_atom_e57658c2("_root", 12, 100)
				end

				movie:__wf_atom_e57658c2(fn("OverallBG"), 12, 0)
				movie:__wf_atom_e57658c2(fn("HeaderItem1"), 12, 100)
				movie:__wf_atom_e57658c2(fn("HeaderItem1.TitleBg"), 12, 45)
				movie:__wf_atom_e57658c2(fn("HeaderItem1.TitleBgBacker"), 12, 45)
				movie:__wf_atom_e57658c2(fn("HeaderItem2"), 12, 100)
				movie:__wf_atom_e57658c2(fn("BG"), 12, 0)
				movie:__wf_atom_e57658c2(fn("BGSecondGroup"), 12, 0)
				movie:__wf_atom_e57658c2(fn("BGThirdGroup"), 12, 0)
				movie:__wf_atom_e57658c2(fn("Blurer"), 12, 25)
				movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 12, 0)
				movie:__wf_atom_e57658c2(fn("Leaves"), 12, 0)
				movie:__wf_atom_e57658c2(clipName, 5, maxScale)
				movie:__wf_atom_e57658c2(clipName, 6, maxScale)
				v41 = 4
			end
		else
			if popupMode then
				movie:__wf_atom_e57658c2("_root", 12, 85)
			end

			movie:__wf_atom_e57658c2(fn("OverallBG"), 12, 80)
			movie:__wf_atom_e57658c2(fn("HeaderItem1"), 12, 80)
			movie:__wf_atom_e57658c2(fn("HeaderItem2"), 12, 80)
			movie:__wf_atom_e57658c2(fn("BG"), 12, 80)
			movie:__wf_atom_e57658c2(fn("BGSecondGroup"), 12, 80)
			movie:__wf_atom_e57658c2(fn("BGThirdGroup"), 12, 80)
			movie:__wf_atom_e57658c2(fn("Blurer"), 12, 25)
			movie:__wf_atom_e57658c2(fn("ItemInfoBorder"), 12, 80)
			movie:__wf_atom_e57658c2(fn("Leaves"), 12, 100)
			movie:__wf_atom_e57658c2(clipName, 5, 80)
			movie:__wf_atom_e57658c2(clipName, 6, 80)
		end

		local v50

		if not (__wf_atom_7e8ad928(resultItemType) or state == v48.BASE and not v5.AllInOne and v5.Category ~= 43 and v5.Category ~= 46) then
			v50 = Resource(resultItemType)
		end

		if v5.IsAbility and not v5.AbilityInitialized then
			fn11(v50)
		end

		local infoPopup_Grid = _T.InfoPopup_Grid
		local storeItem = v5.StoreItem
		local mUpgradeType

		if not __wf_atom_7e8ad928(storeItem) then
			mUpgradeType = storeItem:__wf_atom_efa6f447()
		end

		local v52 = v9 + 10
		v10 = v52
		local v53 = state == v48.BASE or state == v48.INFO
		movie:__wf_atom_2dedec1a(fn("TagSeparator"), 13, false)
		movie:__wf_atom_2dedec1a(fn("Ingredients"), 13, state == v48.CRAFTING)
		movie:__wf_atom_2dedec1a(fn("IngredientsSeparator"), 13, false)
		movie:__wf_atom_2dedec1a(fn("IngredientsSecondary"), 13, false)
		movie:__wf_atom_2dedec1a(fn("PrereqSeparator"), 13, state == v48.CRAFTING)
		movie:__wf_atom_2dedec1a(fn("PrereqSeparator.Separator"), 13, state ~= v48.CRAFTING)
		movie:__wf_atom_2dedec1a(fn("Prerequisite"), 13, false)
		movie:__wf_atom_2dedec1a(fn("RankedProgress"), 13, false)
		movie:__wf_atom_2dedec1a(fn("Affiliation1"), 13, false)
		local v54 = 1
		local v55 = 0
		local mDesc = ""
		v14 = ""
		v16 = 0
		total2 = 10
		mDisplayStats = {}
		mDisplayStats.Labels = {}
		mDisplayStats.Values = {}
		local ternary = module3.Ternary(v5.StatWeapon ~= nil, v5.StatWeapon, v50)
		movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, false)
		movie:__wf_atom_2dedec1a(fn("GroupDivider2"), 13, false)
		movie:__wf_atom_2dedec1a(fn("BgThirdGroup"), 13, false)
		movie:__wf_atom_c90af43a(fn("Leaves"), _G.UITexture_ItemInfoLeaf)

		if
			(__wf_atom_7e8ad928(ternary) or not ternary:__wf_atom_9422b5f5())
			and (__wf_atom_7e8ad928(v5.RawItem) or not v5.RawItem.mShiny)
		then
			if not __wf_atom_7e8ad928(storeItem) then
				local item = storeItem:GetItem()

				if
					not __wf_atom_7e8ad928(item)
					and item:IsA(WeakResource("/SF/Weapons/Melee/TwoHand/MotherCorruptedGreatSword/MotherCorruptedGreatSwordMeleeWeapon"))
				then
					movie:__wf_atom_c90af43a(fn("Leaves"), corruptBGTexture)
				end
			end
		else
			movie:__wf_atom_c90af43a(fn("Leaves"), _G.UITexture_ItemInfoLeafShiny)
		end

		if state == v48.STATS or state == v48.ASPECTS or v5.AllInOne and v6.mStatsAvailable then
			local ternary2 = module3.Ternary(v5.StatOwner ~= nil, v5.StatOwner, nil)
			local flag2 = true

			if __wf_atom_7e8ad928(v5.StatWeapon) then
				local modularType, _ = module9.GetModularType(resultItemType)

				if modularType == nil then
					if v5.IsAmp then
						local rawItem = v5.RawItem
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
					local mStatsToOnlyShow = v5.mStatsToOnlyShow
					local getDisplayStats = module5.GetDisplayStats
					local v58

					if not v5.DisableCompare then
						v58 = v5.StatCompareWeapon
					end

					mDisplayStats = getDisplayStats(ternary, true, ternary2, nil, v58, nil, mStatsToOnlyShow)
				end
			else
				mDisplayStats.Labels = { movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/StatsUnavailable", false) }
				mDisplayStats.Values = { "" }
			end

			if __wf_atom_7e8ad928(v5.StatWeapon) and v5.IsAmp then
				gRegion:__wf_atom_dd1e4d10(ternary)
				ternary = v50
			end

			movie:__wf_atom_e57658c2(fn("ItemStats"), 12, 0)
			__wf_atom_ec43d06e(movie, fn("ItemStats"), 8, { 12 }, { 100 }, 0.2)
		end

		mDisplayStats.BaseValues = {}
		mDisplayStats.StatChanges = {}
		gGameRules:__wf_atom_964056fd()
		local v56

		if not __wf_atom_7e8ad928(v5.StatWeapon) then
			v56 = module14.IsWeaponStatItem(v5.StatWeapon) and not v5.SuppressLevel
		end

		if v5.PurchaseContext then
			module14.SetLevel(movie, fn("HeaderItem1.LevelIndicator"), v56, ternary, v46.FloatingContentHighlight)
		else
			module14.SetLevel(movie, fn("HeaderItem1.LevelIndicator"), v56, ternary, v46.FloatingContentHighlight)

			if v5.Type and v5.Type:IsA(__wf_atom_d98e64fe) then
				local xp = v5.Xp or 0
				local level = v5.Level or 0
				local __wf_atom_a1680b24 = __wf_atom_c67f9605:__wf_atom_a1680b24(v5.Type)
				local v57 = math.min(level + 1, __wf_atom_a1680b24)
				local __wf_atom_89d4ac2a = __wf_atom_c67f9605:__wf_atom_89d4ac2a(v57, v5.Type)
				local __wf_atom_89d4ac2a2 = __wf_atom_c67f9605:__wf_atom_89d4ac2a(level, v5.Type)
				module14.SetLevelExplicit(
					movie,
					fn("HeaderItem1.LevelIndicator"),
					v46.FloatingContentHighlight,
					level,
					__wf_atom_89d4ac2a2,
					__wf_atom_89d4ac2a,
					xp
				)
			end
		end

		if
			__wf_atom_7e8ad928(v5.StatWeapon)
			and not __wf_atom_7e8ad928(ternary)
			and (v5.Category == 43 or v5.Category == 46)
		then
			local item = storeItem:GetItem()

			if __wf_atom_7e8ad928(v5.ResultItemType) then
				if v5.RawItem ~= nil then
					local rawItem = v5.RawItem

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
				item = v5.ResultItemType
			end

			local v57 = Resource(item)
			local mUpgradeFingerprint

			if v5 == nil or v5.RawItem == nil then
				mUpgradeFingerprint = ""
			else
				mUpgradeFingerprint = v5.RawItem.mUpgradeFingerprint

				if #mUpgradeFingerprint == 0 and v5.RawItem.Item ~= nil then
					mUpgradeFingerprint = v5.RawItem.Item.mUpgradeFingerprint
				end
			end

			local v58 = mUpgradeFingerprint == nil and "" or mUpgradeFingerprint

			if not __wf_atom_7e8ad928(v57) and v57:IsA(__wf_atom_f8bb7ca2) then
				local __wf_atom_70b880cb = v57:__wf_atom_70b880cb(v58)
				local v59 = { mUpgradeType = mUpgradeType, mDesc = "" }
				module10.UpdateCrewShipCard(v59, __wf_atom_70b880cb, movie)
				mDesc = v59.mDesc

				if mDesc ~= "" then
					local v60 = StringSplit("\r\n", mDesc)
					local v61 = "%d*%.?%d+"
					local v62 = "%p*" .. v61 .. "[^%s]*"
					local bonusStats = { Values = {}, Labels = {}, CompareValues = {} }

					for i = 1, #v60 do
						local v64 = string.match(v60[i], v62) or 0
						table.insert(bonusStats.Values, v64)
						table.insert(bonusStats.CompareValues, (tonumber(string.match(v64, v61))))
						local v65 = fn16(v64)
						local v66 = string.gsub(v60[i], v65, "[STAT]")
						table.insert(bonusStats.Labels, v66)
					end

					mDisplayStats.BonusStats = bonusStats
				end
			end
		end

		if state == v48.ASPECTS then
			local v57 = fn("AspectContainer")
			movie:__wf_atom_2dedec1a(v57, 13, true)
			movie:__wf_atom_e57658c2(v57, 1, v10 + 45)
			fn21(v57 .. ".Aspect", true)
			fn21(v57 .. ".AspectCompare", true, true)
			local v58 = { 0, 0 }

			for i = 1, #mDisplayStats.IconValues do
				if not (mDisplayStats.IconValues and mDisplayStats.IconValues[i]) then
					continue
				end

				for j = 1, 1 do
					local v59 = j == 1 and "Aspect" or "AspectCompare"
					local values

					if j == 1 then
						values = mDisplayStats.Values
					else
						values = mDisplayStats.CompareValues
					end

					local v60 = StringSplit(",", values[i])
					local v61

					if mDisplayStats.FreeformPayload[i][j] then
						v61 = mDisplayStats.FreeformPayload[i][j]
					else
						v61 = mDisplayStats.FreeformPayload[i]
					end

					for k = 1, math.min(v41, #v60 - v41 * (index - 1)) do
						local v62 = (index - 1) * v41 + k
						local v63 = v57 .. "." .. v59 .. k .. ".gridItem1"
						local v64 = v57 .. "." .. v59 .. k

						if not movie:__wf_atom_253d7085(v57 .. "." .. v59 .. k) then
							__wf_atom_86cbd68d(movie, v57 .. ".Aspect1.duplicateMovieClip", v59 .. k, 1000 + k + 20 * j)
						end

						movie:__wf_atom_7f57ab2f(v57, v59 .. k, 13, true)
						movie:__wf_atom_4c1c1986(v57, v59 .. k, 0, (j - 1) * 165)
						movie:__wf_atom_48bd5a59(v57, v59 .. k .. ".Name", 11, v46.YellowColor)
						movie:__wf_atom_48bd5a59(v57, v59 .. k .. ".Desc", 11, v46.FloatingContentHighlight)
						movie:__wf_atom_48bd5a59(
							v57,
							v59 .. k .. ".Name",
							0,
							movie:__wf_atom_5e6e15c8(v63, 0) + 32.5 + 4
						)
						movie:__wf_atom_48bd5a59(
							v57,
							v59 .. k .. ".Desc",
							0,
							movie:__wf_atom_5e6e15c8(v63, 0) + 32.5 + 4
						)
						movie:__wf_atom_48bd5a59(v57, v59 .. k .. ".Name", 14, 265)
						movie:__wf_atom_48bd5a59(v57, v59 .. k .. ".Desc", 14, 265)
						local unfocusedItem, v66 = fn12("")

						if v61 and v61.Title and v61.Desc and v61.Title[v62] and v61.Desc[v62] then
							local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(v61.Title[v62], true)
							local v67 = (not v61.AmpLevel or v61.AmpLevel[v62] == nil or not (v61.AmpLevel[v62] > 1))
								and ""
								or " " .. movie:__wf_atom_8e9ac384("/SF/Language/Menu/Stat_AspectMultiplier", true)
							movie:__wf_atom_4c1c1986(v57, v59 .. k .. ".Name", 1, -3)
							movie:__wf_atom_48bd5a59(v57, v59 .. k .. ".Name", 36, __wf_atom_8e9ac384 .. v67)
							movie:__wf_atom_48bd5a59(
								v57,
								v59 .. k .. ".Desc",
								36,
								movie:__wf_atom_8e9ac384(v61.Desc[v62], true)
							)
							local __wf_atom_cfc41e35 = movie:__wf_atom_cfc41e35(v57, v59 .. k .. ".Name", 1)
							local __wf_atom_cfc41e35_2 = movie:__wf_atom_cfc41e35(v57, v59 .. k .. ".Name", 41)
							movie:__wf_atom_4c1c1986(
								v57,
								v59 .. k .. ".Desc",
								1,
								__wf_atom_cfc41e35 + __wf_atom_cfc41e35_2 + 2
							)

							if v61.Faction and v61.Faction[v62] ~= "" then
								unfocusedItem, v66 = fn12(v61.Faction[v62])
							end
						end

						movie:__wf_atom_4c1c1986(v57, v59 .. k, 12, 0)
						asyncLoader2:AbortLoad(v63)

						if WeakResource(v60[v62]) then
							local v67 = k
							local v68 = v61
							asyncLoader2:LoadResource(v63, WeakResource(v60[v62]), function(p)
								movie:__wf_atom_4c1c1986(v57, v59 .. v67, 12, 100)
								local v69 = {
									Icon = Resource(p),
									SkipDefaultMaterials = true,
									WidthOverride = 65,
									HeightOverride = 65,
									mVisRangeMaterials = { UnfocusedItem = unfocusedItem }
								}
								module6.Initialize(movie, v63, v69)

								if not (v68 and v68.AmpLevel and v68.AmpLevel[v62] > 1) then
									movie:__wf_atom_1ca72041(
										v64 .. ".gridItem1.IconOutline",
										"RippleSettings",
										0,
										0,
										1,
										1
									)
									return
								end

								local convertColorNumberToProceduralRGB = module3.ConvertColorNumberToProceduralRGB(v66 or _G.UIColor_Yellow)
								movie:__wf_atom_1ca72041(
									v64 .. ".gridItem1.IconOutline",
									"RipplesColor",
									convertColorNumberToProceduralRGB.r,
									convertColorNumberToProceduralRGB.g,
									convertColorNumberToProceduralRGB.b,
									1
								)
								movie:__wf_atom_1ca72041(
									v64 .. ".gridItem1.IconOutline",
									"RippleSettings",
									50,
									2,
									0.1,
									0.5
								)
								movie:__wf_atom_1ca72041(v64 .. ".gridItem1.IconOutline", "RippleCenter", 2, -2, 0, 0)
								movie:__wf_atom_1ca72041(
									v64 .. ".gridItem1.IconOutline",
									"RippleAnimationSettings",
									3,
									3,
									1,
									1
								)
							end)
						end

						if k > 1 then
							local v67 = math.max(
								72,
								movie:__wf_atom_4934c8e7(v57, v59 .. k - 1 .. ".Name", 41) + movie:__wf_atom_4934c8e7(v57, v59 .. k - 1 .. ".Desc", 41)
							)
							movie:__wf_atom_4c1c1986(
								v57,
								v59 .. k,
								1,
								movie:__wf_atom_cfc41e35(v57, v59 .. k - 1, 1) + v67 + 10
							)
						end

						local v67 = math.max(
							72,
							movie:__wf_atom_4934c8e7(v57, v59 .. k .. ".Name", 41) + movie:__wf_atom_4934c8e7(v57, v59 .. k .. ".Desc", 41)
						) + 10
						v58[j] += v67
					end

					if values[i] == "-" then
						movie:__wf_atom_2dedec1a(fn("AspectContainer.AspectsPageMessage"), 13, true)
						movie:__wf_atom_50d60589(
							fn("AspectContainer.AspectsPageMessage"),
							36,
							"<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384(
								"/SF/Language/Menu/Stat_NoAspectsToCompare",
								true
							) .. "</font></p>"
						)
					else
						movie:__wf_atom_2dedec1a(fn("AspectContainer.AspectsPageMessage"), 13, false)
					end
				end
			end

			local v59 = math.max(v58[1], v58[2])
			v10 = v10 + v59 + 25
		else
			movie:__wf_atom_2dedec1a(fn("AspectContainer"), 13, false)
		end

		if state == v48.BASE then
			local statWeapon = v5.StatWeapon
			v54, mDesc, v55 = fn46(
				infoPopup_Grid,
				v54,
				storeItem,
				mDesc,
				mUpgradeType,
				v52,
				v50,
				v55,
				__wf_atom_7e8ad928(statWeapon) and "" or module12.GetCreator(
					statWeapon:__wf_atom_b2875ac0(),
					v5.StatOwner
				)
			)
		elseif state == v48.CRAFTING then
			v10 -= 13
			movie:__wf_atom_e57658c2(fn("PrereqSeparator"), 1, v10)
			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("PrereqSeparator.Description"), 41) + 21
			fn45()
			movie:__wf_atom_e57658c2(fn("Ingredients"), 1, v10)
			local v57 = 0

			for _, mElement in ipairs(v29.mElements) do
				v57 = v57 + 5 + math.max(v29.mForcedVerticalSeparation, mElement.mHeight or 0)
			end

			v10 = v10 + movie:__wf_atom_5e6e15c8(fn("Ingredients.ingredient"), 1) + v57 - 10
		elseif state == v48.INFO then
			if not __wf_atom_7e8ad928(infoPopup_Grid) and infoPopup_Grid.AdditionalTabInfo ~= nil then
				v14 = infoPopup_Grid.AdditionalTabInfo(v5)
			end

			if type(v14) ~= "string" then
				print("AdditionalTabInfo returned " .. type(v14) .. ", should be string")
				v14 = ""
			end

			v10 -= 2
			movie:__wf_atom_e57658c2(fn("Description"), 1, v10)
			movie:__wf_atom_50d60589(
				fn("Description"),
				36,
				"<p><font color=\"" .. v46.ContentHex .. "\">" .. v14 .. "</font></p>"
			)

			if v14 == "" then
				v10 -= 17
			else
				v10 += movie:__wf_atom_5e6e15c8(fn("Description"), 41)
			end
		end

		local v57 = state == v48.ABILITIES or (v5.AllInOne and v6.mAbilitiesAvailable) == true
		movie:__wf_atom_2dedec1a(fn("AbilityInfo"), 13, v57)

		if v57 then
			if v5.AllInOne then
				v10 += 23
			end

			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("AbilityInfo.Ability1"), 1)
			movie:__wf_atom_e57658c2(fn("AbilityInfo"), 1, v10)
			local mStats = module7.GetPowerSuitStats(movie, nil, v50).mStats

			if v5.mIsNemesis then
				local abilityType = Resource(v5.mExtraAbility)

				if not __wf_atom_7e8ad928(abilityType) then
					mStats.Ability4 = movie:__wf_atom_8e9ac384(abilityType:__wf_atom_014a76a2():c_str(), false)
					mStats.AbilityDescription4 = movie:__wf_atom_8e9ac384(
						abilityType:__wf_atom_3a3d2e39():c_str(),
						true
					)
					mStats.AbilityIcon4 = abilityType:GetIconTexture()
					mStats.AbilityType4 = abilityType
				end
			end

			local mStats2 = {}

			for i = 1, 3 do
				local mStat = mStats["Ability" .. i + 1]

				if mStat == nil then
					continue
				end

				local v58 = fn("AbilityInfo.Ability") .. i
				movie:__wf_atom_2dedec1a(v58, 13, false)
				movie:__wf_atom_e57658c2(v58, 1, __wf_atom_5e6e15c8)
				movie:__wf_atom_48bd5a59(
					v58,
					"Name",
					36,
					"<p><font color=\"" .. v46.YellowColorHex .. "\">" .. mStat .. "</font></p>"
				)
				movie:__wf_atom_4c1c1986(v58, "Name", 11, 16777215)
				local mStat2 = mStats["AbilityDescription" .. i + 1]
				module3.SetFitText(movie, v58 .. ".Desc", "...")
				movie:__wf_atom_4c1c1986(v58, "Desc", 92, 6)
				movie:__wf_atom_48bd5a59(v58, "Desc", 36, mStat2)
				local mStat3 = mStats["AbilityIcon" .. i + 1]

				if not __wf_atom_7e8ad928(mStat3) then
					table.insert(mStats2, mStat3)
				end

				local __wf_atom_5e6e15c8_2 = movie:__wf_atom_5e6e15c8(v58 .. ".Name", 41)
				local __wf_atom_5e6e15c8_3 = movie:__wf_atom_5e6e15c8(v58 .. ".Desc", 41)
				__wf_atom_5e6e15c8 = __wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 + 20
			end

			asyncLoader:LoadMultipleResources("InfoPopupAbilityIcons", mStats2, function()
				for i = 1, 3 do
					if mStats["Ability" .. i + 1] == nil then
						continue
					end

					local mStat = mStats["AbilityIcon" .. i + 1]
					local v58 = fn("AbilityInfo.Ability") .. i
					movie:__wf_atom_2dedec1a(v58, 13, true)
					movie:__wf_atom_c90af43a(v58 .. ".Icon", mStat)
					movie:__wf_atom_7f57ab2f(v58, "Icon", 13, not __wf_atom_7e8ad928(mStat))
					movie:__wf_atom_4c1c1986(v58, "Icon", 0, 0)
				end
			end, true)
			local v58 = __wf_atom_5e6e15c8 + 4

			if not __wf_atom_7e8ad928(gRegion) then
				local _mIsNemesis = v5.mIsNemesis
			end

			movie:__wf_atom_2dedec1a(fn("AbilityInfo.Passive"), 13, false)
			movie:__wf_atom_2dedec1a(fn("AbilityInfo.PassiveSeparator"), 13, false)
			v10 = v10 + v58 + module3.Ternary(
				false,
				movie:__wf_atom_5e6e15c8(fn("AbilityInfo.Passive.Description"), 41) + 38,
				10
			)
		end

		if mDesc ~= "" then
			if state == v48.STATS then
				movie:__wf_atom_e57658c2(fn("Description"), 1, v10)
				v10 += 5
			end

			movie:__wf_atom_50d60589(
				fn("Description"),
				36,
				"<p><font color=\"" .. v46.ContentHex .. "\">" .. mDesc .. "</font></p>"
			)
			v10 += movie:__wf_atom_5e6e15c8(fn("Description"), 41)
			v53 = true
		end

		if v19 > 1 then
			for i = math.max(v55 + 1, 2), v19 do
				__wf_atom_86cbd68d(movie, fn("Affiliation") .. i .. ".removeMovieClip")
			end

			v19 = math.max(1, v55)
		end

		local v58 = false
		local total3 = -8

		if #mDisplayStats.Labels > 0 and state ~= v48.ASPECTS then
			if state ~= v48.STATS then
				v10 += 23
			end

			local v59 = v18

			if type(mDisplayStats.Labels) == "table" then
				v18 = #mDisplayStats.Labels
				v13 = { 0, 0 }

				for i = 1, v18 do
					local v60 = fn("ItemStats.Item") .. i
					local iconValue = mDisplayStats.IconValues[i]

					if iconValue and (mDisplayStats.Values[i] == "" or mDisplayStats.Values[i] == "-") and not v44 then
						if movie:__wf_atom_253d7085(v60) then
							__wf_atom_86cbd68d(movie, fn("ItemStats.Item") .. i .. ".removeMovieClip")
						end
					else
						if not movie:__wf_atom_253d7085(v60) then
							__wf_atom_86cbd68d(movie, fn("ItemStats.Item1.duplicateMovieClip"), "Item" .. i, i)
						end

						local label = mDisplayStats.Labels[i]
						movie:__wf_atom_e57658c2(v60, 1, total3)
						movie:__wf_atom_7f57ab2f(v60, "Backer", 13, false)
						movie:__wf_atom_7f57ab2f(v60, "Labels", 52, false)
						movie:__wf_atom_50d60589(v60 .. ".Labels", 36, movie:__wf_atom_8e9ac384(label, true))
						movie:__wf_atom_7f57ab2f(v60, "SpecialText", 13, false)
						movie:__wf_atom_4c1c1986(v60, "StatsCompare", 1, movie:__wf_atom_cfc41e35(v60, "Stats", 1))
						movie:__wf_atom_7f57ab2f(v60, "StatIconComponent1", 13, false)
						movie:__wf_atom_7f57ab2f(v60, "StatCompareIconComponent1", 13, false)
						fn21(v60 .. ".StatIconComponent", true)
						fn21(v60 .. ".StatCompareIconComponent", true, true)
						movie:__wf_atom_4c1c1986(v60, "StatIconComponent1", 1, 0)
						local v61 = { 0, 0 }
						local v62 = 23
						local v63 = -1

						for j = 1, 1 do
							local v64 = j == 1 and "Stats" or "StatsCompare"

							if j == 1 then
								movie:__wf_atom_7f57ab2f(v60, "StatsCompare", 13, false)
							else
								movie:__wf_atom_7f57ab2f(v60, "StatsCompare", 13, true)
							end

							local v65

							if j == 1 then
								v65 = mDisplayStats.Values[i]
							else
								v65 = mDisplayStats.CompareValues[i]
							end

							local v66 = fn22(v65, mDisplayStats.BaseValues[i], mDisplayStats.StatChanges[i])
							movie:__wf_atom_48bd5a59(
								v60,
								v64,
								36,
								movie:__wf_atom_8e9ac384(mDisplayStats.IconValues[i] and "" or v66, true)
							)
							local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(v60 .. ".Labels", 14)
							local __wf_atom_5e6e15c8_2 = movie:__wf_atom_5e6e15c8(v60 .. ".Labels", 40)
							local v68 = movie:__wf_atom_cfc41e35(v60, "Stats", 40) + 10
							local _ = movie:__wf_atom_cfc41e35(v60, "StatsCompare", 40) + 10
							local _ = __wf_atom_5e6e15c8_2 + v68 + 0

							if mDisplayStats.Values[i] == "" then
								label = "<p><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. label .. "</p>"
								movie:__wf_atom_4c1c1986(v60, "Labels", 14, 330)
								movie:__wf_atom_7f57ab2f(v60, "Labels", 52, true)
								movie:__wf_atom_50d60589(v60 .. ".Labels", 36, label)
								v62 = movie:__wf_atom_5e6e15c8(v60 .. ".Labels", 41)
							end

							if v65 == "" then
								continue
							end

							if iconValue then
								local v69 = StringSplit(",", v65)
								v61[j] = #v69

								for k, _ in v69 do
									local v70

									if j == 1 then
										v70 = "StatIconComponent" .. k
									else
										v70 = "StatCompareIconComponent" .. k
									end

									if not movie:__wf_atom_253d7085(v60 .. "." .. v70) then
										__wf_atom_86cbd68d(
											movie,
											v60 .. ".StatIconComponent1.duplicateMovieClip",
											v70,
											2000 * j + k
										)
									end

									movie:__wf_atom_7f57ab2f(v60, v70, 13, true)
									local unfocusedItem, v72 = fn12("")
									local v73

									if mDisplayStats.FreeformPayload[i][j] then
										v73 = mDisplayStats.FreeformPayload[i][j]
									else
										v73 = mDisplayStats.FreeformPayload[i]
									end

									if v73 and v73.Faction and v73.Faction[k] ~= "" then
										unfocusedItem, v72 = fn12(v73.Faction[k])
									end

									movie:__wf_atom_4c1c1986(v60, v70, 12, 0)
									asyncLoader2:AbortLoad(v60 .. v70)

									if WeakResource(v69[k]) then
										local v74 = v70
										local v75 = v73
										local v76 = k
										asyncLoader2:LoadResource(v60 .. v70, WeakResource(v69[k]), function(p)
											movie:__wf_atom_4c1c1986(v60, v74, 12, 100)
											local v77 = {
												Icon = Resource(p),
												SkipDefaultMaterials = true,
												WidthOverride = 55,
												HeightOverride = 55,
												mVisRangeMaterials = {
													UnfocusedItem = unfocusedItem
												}
											}
											module6.Initialize(movie, v60 .. "." .. v74 .. ".gridItem1", v77)

											if not v75 or v75.AmpLevel == nil or not (v75.AmpLevel[v76] > 1) then
												movie:__wf_atom_1ca72041(
													v60 .. "." .. v74 .. ".gridItem1.IconOutline",
													"RippleSettings",
													0,
													0,
													1,
													1
												)
												return
											end

											local convertColorNumberToProceduralRGB = module3.ConvertColorNumberToProceduralRGB(v72 or _G.UIColor_Yellow)
											movie:__wf_atom_1ca72041(
												v60 .. "." .. v74 .. ".gridItem1.IconOutline",
												"RipplesColor",
												convertColorNumberToProceduralRGB.r,
												convertColorNumberToProceduralRGB.g,
												convertColorNumberToProceduralRGB.b,
												1
											)
											movie:__wf_atom_1ca72041(
												v60 .. "." .. v74 .. ".gridItem1.IconOutline",
												"RippleSettings",
												50,
												2,
												0.1,
												0.5
											)
											movie:__wf_atom_1ca72041(
												v60 .. "." .. v74 .. ".gridItem1.IconOutline",
												"RippleCenter",
												2,
												-2,
												0,
												0
											)
											movie:__wf_atom_1ca72041(
												v60 .. "." .. v74 .. ".gridItem1.IconOutline",
												"RippleAnimationSettings",
												3,
												3,
												1,
												1
											)
										end)
									else
										movie:__wf_atom_7f57ab2f(v60, v70, 13, false)
										movie:__wf_atom_48bd5a59(
											v60,
											"SpecialText",
											36,
											"<p><font color=\"" .. v46.FloatingContentHex .. "\">" .. movie:__wf_atom_8e9ac384(v65, true) .. "</font></p>"
										)
										movie:__wf_atom_7f57ab2f(v60, "SpecialText", 13, true)
										v63 = j
									end
								end
							else
								local _ = __wf_atom_5e6e15c8 < __wf_atom_5e6e15c8_2
							end

							v62 = math.max(movie:__wf_atom_cfc41e35(v60, v64, 41), v62)
						end

						local v64 = 0

						for k, _ in v61 do
							local v65 = #v61 - k + 1

							if v63 == -1 and v61[2] == 0 then
								v65 = k
							end

							local v66 = v65 == 1 and "Stats" or "StatsCompare"
							local v67 = v64 + 1

							if v63 == v65 then
								movie:__wf_atom_4c1c1986(v60, "SpecialText", 1, 55 * v67 - 20)
								movie:__wf_atom_4c1c1986(
									v60,
									"SpecialText",
									0,
									0 - movie:__wf_atom_cfc41e35(v60, v66, 14) / 2 - 27.5
								)
								v64 += 1
							elseif v61[v65] > 0 then
								for j = 1, v61[v65] do
									local v68 = math.floor((j - 1) / 6) + v67
									v64 = math.max(v64, v68)
									local v69

									if v65 == 1 then
										v69 = "StatIconComponent" .. j
									else
										v69 = "StatCompareIconComponent" .. j
									end

									if not (movie:__wf_atom_253d7085(v60 .. "." .. v69) and movie:__wf_atom_bd8fa442(v60, v69, 13)) then
										continue
									end

									movie:__wf_atom_4c1c1986(v60, v69, 0, 50 + 55 * ((j - 1) % 6))
									movie:__wf_atom_4c1c1986(v60, v69, 1, 55 * v68)
								end
							end
						end

						local v65 = v62 + 0

						if v64 > 0 then
							v65 = 70 * v64
						end

						movie:__wf_atom_4c1c1986(v60, "Backer", 15, v65)
						total3 += v65

						if mDisplayStats.GroupIndices and #mDisplayStats.GroupIndices >= 1 then
							if fn14(1) or v44 then
								movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, true)
								movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, true)
							else
								movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, false)
								movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, false)
							end

							if #mDisplayStats.GroupIndices >= 2 then
								if fn14(2) or v44 then
									movie:__wf_atom_2dedec1a(fn("GroupDivider2"), 13, true)
								else
									movie:__wf_atom_2dedec1a(fn("GroupDivider2"), 13, false)
								end
							end

							for k, groupIndice in mDisplayStats.GroupIndices do
								if not (i <= groupIndice and i == groupIndice) then
									continue
								end

								local __wf_atom_cfc41e35 = movie:__wf_atom_cfc41e35(v60, "Stats", 15)
								v13[k] = total3 + __wf_atom_cfc41e35
								total3 += 12
							end
						else
							movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, false)
							movie:__wf_atom_2dedec1a(fn("BgThirdGroup"), 13, false)
							movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, false)
							movie:__wf_atom_2dedec1a(fn("GroupDivider2"), 13, false)
						end
					end
				end

				fn24()
			else
				v18 = 1
				movie:__wf_atom_e57658c2(fn("ItemStats.Item1.Backer"), 12, 0)
				movie:__wf_atom_50d60589(fn("ItemStats.Item1.Labels"), 36, mDisplayStats.Labels)
				movie:__wf_atom_50d60589(fn("ItemStats.Item1.Stats"), 36, mDisplayStats.Values)
			end

			v58 = v18 > 0

			for i = math.max(v18 + 1, 2), v59 do
				__wf_atom_86cbd68d(movie, fn("ItemStats.Item") .. i .. ".removeMovieClip")
			end
		elseif mDisplayStats.BonusStats ~= nil and #mDisplayStats.BonusStats.Labels > 0 then
			fn24()
		end

		fn40(v54)
		movie:__wf_atom_2dedec1a(fn("Description"), 13, v53)
		movie:__wf_atom_2dedec1a(fn("ItemStats"), 13, v58)

		if v58 then
			movie:__wf_atom_e57658c2(fn("ItemStats"), 1, v10)
			v10 = v10 + total3 + 35
		elseif
			not (movie:__wf_atom_a91463a8(fn("DescStatItem"), 13) or movie:__wf_atom_a91463a8(fn("DescInfoArea"), 13))
			and v45 <= 0
		then
			movie:__wf_atom_2dedec1a(fn("BgSecondGroup"), 13, false)
			movie:__wf_atom_2dedec1a(fn("GroupDivider1"), 13, false)
		end

		local v59 = movie:__wf_atom_a91463a8(fn("BottomRightCallout"), 13)
			or movie:__wf_atom_a91463a8(fn("BottomLeftCallout"), 13)
		local v60 = 0
		local v61

		if v59 then
			if
				movie:__wf_atom_a91463a8(fn("BottomLeftCallout"), 13)
				and movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 43) > 1
			then
				v61 = movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 41)
				v60 = movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 41) - 20
			else
				v61 = 20
			end
		else
			v61 = 0
		end

		local v62 = 0

		if state == v48.BASE then
			if v59 then
				v10 += v61
			end
		else
			v62 = state ~= v48.STATS and state == v48.ASPECTS and 5 or v62
		end

		local v63 = v10 + 7 + v62 + v60 / 2
		movie:__wf_atom_e57658c2(
			fn("BottomLeftCallout"),
			1,
			v63 - movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 41) / 2 - movie:__wf_atom_5e6e15c8(fn("BottomLeftCallout"), 43) * 2 - 6
		)
		movie:__wf_atom_e57658c2(
			fn("BottomRightCallout"),
			1,
			v63 - movie:__wf_atom_5e6e15c8(fn("BottomRightCallout"), 41) / 2 - movie:__wf_atom_5e6e15c8(fn("BottomRightCallout"), 43) * 2 - 6
		)
		movie:__wf_atom_e57658c2(
			fn("BottomRightCallout"),
			0,
			345 - movie:__wf_atom_5e6e15c8(fn("BottomRightCallout"), 40)
		)
		movie:__wf_atom_e57658c2(fn("HoldFill"), 1, v63 - 7)
		movie:__wf_atom_e57658c2(fn("HoldFill"), 15, 35 + v60)
		movie:__wf_atom_e57658c2(fn("BgThirdGroup"), 15, 35 + v60)
		movie:__wf_atom_e57658c2(fn("BgThirdGroup"), 1, v63 - movie:__wf_atom_5e6e15c8(fn("BgThirdGroup"), 15) / 2 - 7)
		local v64 = v59
			and (not movie:__wf_atom_a91463a8(fn("BgSecondGroup"), 13) or movie:__wf_atom_a91463a8(fn("GroupDivider2"), 13))
		movie:__wf_atom_2dedec1a(fn("BgThirdGroup"), 13, v64)
		v10 = v10 + v61 + v62
		fn41(v61)
		fn6()
	end

	local function fn47()
		local v50 = v43 ~= ""
		movie:__wf_atom_2dedec1a(fn("Header"), 13, v50)
		v12 = v50 and 22 or 0
		movie:__wf_atom_e57658c2(fn("Header.Label"), 14, 330)
		movie:__wf_atom_50d60589(fn("Header.Label"), 36, v43)
		local infoPopup_Grid = _T.InfoPopup_Grid
		v15 = module2.GetGridItemName(movie, infoPopup_Grid, v5, v5.MetaData)

		if v15 ~= "" then
			if v5.IsEliteCrewMember then
				v15 ..= movie:__wf_atom_8e9ac384(" <ELITE_CREW_MEMBER>", true)
			end

			if not __wf_atom_7e8ad928(v5.RawItem) and v5.RawItem.mFavorite then
				v15 ..= movie:__wf_atom_8e9ac384(" <FAVORITE_ICON>", true)
			end
		end

		if not (__wf_atom_7e8ad928(v5.RawItem) or __wf_atom_7e8ad928(v5.RawItem.mTitleType)) then
			local mTitleType = v5.RawItem.mTitleType
			v15 = movie:__wf_atom_8e9ac384(
				gGameRules:__wf_atom_964056fd():__wf_atom_232fd31d(mTitleType):__wf_atom_014a76a2():c_str(),
				true
			) .. " (" .. v15 .. ")"
		end

		v10 = 0
		v8 = 5
		fn43(infoPopup_Grid)
		local v51 = not (v6:GetHowManyElements() > 1) and 0
			or 5 + (movie:__wf_atom_5e6e15c8(fn("InfoToggle.Callout"), 40) or 0) + v6.mForcedHorizontalSeparation * v6:GetHowManyElements()

		if
			__wf_atom_7e8ad928(v5)
			or __wf_atom_7e8ad928(v5.StoreItem)
			or module12.IsMoteType(v5.Type)
			or v5.SuppressRarity
		then
			module14.SetRarity(movie, fn("HeaderItem1.LevelIndicator"), false, -1)
		else
			local __wf_atom_a8dac107 = v5.StoreItem:__wf_atom_a8dac107()
			local v52

			if not __wf_atom_7e8ad928(v5.StatWeapon) then
				v52 = module14.IsWeaponStatItem(v5.StatWeapon) and not v5.SuppressLevel
			end

			local v53 = v5.Type and v5.Type:IsA(__wf_atom_d98e64fe)
			module14.SetRarity(
				movie,
				fn("HeaderItem1.LevelIndicator"),
				v52 or v53 and not v5.PurchaseContext,
				__wf_atom_a8dac107
			)
		end

		movie:__wf_atom_e57658c2(fn("HeaderItem1.Title"), 14, 330 - v51)
		local yellowColorHex = v46.YellowColorHex
		movie:__wf_atom_50d60589(
			fn("HeaderItem1.Title"),
			36,
			"<p><font color=\"" .. yellowColorHex .. "\">" .. v15 .. "</font></p>"
		)
		v9 = 0

		if v15 == "" then
			v9 += 20
			v8 = 20
		else
			v8 = movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Title"), 41) + 20
			v9 += v8
		end

		movie:__wf_atom_e57658c2(fn("TitleRight"), 14, 330)
		movie:__wf_atom_2dedec1a(fn("TitleRight"), 13, v5.TitleRight ~= nil)

		if v5.TitleRight ~= nil then
			movie:__wf_atom_50d60589(
				fn("TitleRight"),
				36,
				"<p><font color=\"" .. v46.ContentHex .. "\">" .. movie:__wf_atom_8e9ac384(v5.TitleRight, true) .. "</font></p>"
			)
		end

		fn27()
		local subtitleOverride = nil

		if v5.SubtitleOverride then
			movie:__wf_atom_e57658c2(fn("HeaderItem1.Subtitle"), 44, v46.Content)
			subtitleOverride = v5.SubtitleOverride
		else
			movie:__wf_atom_e57658c2(fn("HeaderItem1.Subtitle"), 44, v46.Content)

			if v5.BuySlot and not v5.Disabled then
				local emptyCount = v5.EmptyCount

				if v5.MaxCount == nil then
					if emptyCount == 1 then
						subtitleOverride = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlot", true)
					else
						subtitleOverride = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FreeSlots", true, {
							free = emptyCount
						})
					end
				else
					subtitleOverride = movie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_LimitedExtraSlots", true, {
						CUR = emptyCount,
						MAX = v5.MaxCount
					})
				end
			elseif v5.IsAbility then
				subtitleOverride = TitleCase(movie:__wf_atom_8e9ac384(
					"/Lotus/Language/Menu/Global_FormattedRankCaps",
					true,
					{ RANK = v5.Level }
				))

				if v5.Locked then
					subtitleOverride ..= movie:__wf_atom_8e9ac384("<LOCKED>", true)
				end
			elseif v5.IsPAUpgrade then
				subtitleOverride = movie:__wf_atom_8e9ac384(
					"/Lotus/Language/PrimeStore/PrimeAccessUpgradeSubtitle",
					true
				)
			elseif v5.WeeklyLocked then
				subtitleOverride = movie:__wf_atom_8e9ac384("/Lotus/Language/Store/PerWeekPurchase", false)
			end
		end

		local v53 = subtitleOverride ~= nil
		movie:__wf_atom_2dedec1a(fn("HeaderItem1.Subtitle"), 13, v53)

		if v53 then
			movie:__wf_atom_e57658c2(
				fn("HeaderItem1.Subtitle"),
				1,
				v8 - movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Subtitle"), 41) / 2
			)
			movie:__wf_atom_50d60589(fn("HeaderItem1.Subtitle"), 36, subtitleOverride)
			v9 = v9 + movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Subtitle"), 41) + 2
			v8 = v8 + movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Subtitle"), 41) + 2
		end

		if movie:__wf_atom_a91463a8(fn("InfoToggle"), 13) then
			v9 = v9 + movie:__wf_atom_5e6e15c8(fn("InfoToggle"), 15) + 2
			v8 = v8 + movie:__wf_atom_5e6e15c8(fn("InfoToggle"), 15) + 2
		end

		movie:__wf_atom_e57658c2(fn("InfoToggle"), 1, v8 - movie:__wf_atom_5e6e15c8(fn("InfoToggle"), 15) + 7)

		if module12.IsMoteType(v5.Type) then
			movie:__wf_atom_2dedec1a(fn("MoteInfo"), 13, false)
			local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Title"), 15)
			movie:__wf_atom_e57658c2(fn("MoteInfo"), 1, __wf_atom_5e6e15c8 / 2 + 5 - 3)
			asyncLoader2:LoadResource("moteArtifactUpgrade", v5.Type, function(p)
				local moteRes = Resource(p)

				if not __wf_atom_7e8ad928(v5) then
					v5.MoteRes = moteRes
					fn8()
				end

				if not (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v5.RawItem) or __wf_atom_7e8ad928(v5.RawItem.mUpgradeFingerprint)) then
					local __wf_atom_c6a5f697 = moteRes:__wf_atom_c6a5f697(v5.RawItem.mUpgradeFingerprint)
					v15 ..= " " .. movie:__wf_atom_8e9ac384(module12.GetRankFlowerIcons(__wf_atom_c6a5f697), true)
				end

				movie:__wf_atom_50d60589(
					fn("HeaderItem1.Title"),
					36,
					"<p><font color=\"" .. v46.FloatingContentHighlightHex .. "\">" .. v15 .. "</font></p>"
				)
				asyncLoader2:LoadResource("moteSkillTree", moteRes:__wf_atom_7ec2d06a(""), function(p2)
					local v55 = Resource(p2)

					if v55:IsA(__wf_atom_cdd2dd31) then
						local __wf_atom_ab9ebfce = v55:__wf_atom_ab9ebfce()
						local ternary = module3.Ternary(
							__wf_atom_ab9ebfce ~= EMPTY_SYMBOL,
							__wf_atom_ab9ebfce:c_str(),
							""
						)
						local iconText = (not v5 or v5.StoreItem == nil) and 0 or v5.StoreItem:__wf_atom_2941433a()
						fn33({
							title = movie:__wf_atom_8e9ac384(ternary, true),
							icon = _G.UITexture_MoteIcons[1],
							iconText = iconText
						})
					end
				end)
			end)
		else
			movie:__wf_atom_2dedec1a(fn("MoteInfo"), 13, false)
		end

		if v5.DefaultItemInfoTab == nil or v6:GetElementInIndex(v5.DefaultItemInfoTab) == nil then
			v6:FocusElement(1)
		else
			v6:FocusElement(v5.DefaultItemInfoTab)
		end

		v6:SelectCurrentElement()
		local v54 = fn19()
		movie:__wf_atom_2dedec1a(fn("PreviewTag"), 13, v54)
		movie:__wf_atom_2dedec1a(fn("PreviewCallout"), 13, v54)
		total = 0

		if movie:__wf_atom_a91463a8(fn("HeaderItem1.Title"), 13) then
			total += movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Title"), 41)
		end

		if movie:__wf_atom_a91463a8(fn("HeaderItem1.Subtitle"), 13) then
			total += movie:__wf_atom_5e6e15c8(fn("HeaderItem1.Subtitle"), 41)
		end

		if movie:__wf_atom_a91463a8(fn("HeaderItem2.Title"), 13) then
			total += movie:__wf_atom_5e6e15c8(fn("HeaderItem2.Title"), 41)
		end

		if movie:__wf_atom_a91463a8(fn("HeaderItem2.Subtitle"), 13) then
			total += movie:__wf_atom_5e6e15c8(fn("HeaderItem2.Subtitle"), 41)
		end

		movie:__wf_atom_e57658c2(fn("HeaderItem1.TitleBg"), 11, v46.Background1)

		for i = 1, 1 do
			local statWeapon

			if i == 1 then
				statWeapon = v5.StatWeapon
			else
				statWeapon = v5.StatCompareWeapon
			end

			local v55

			if i == 1 then
				v55 = fn("HeaderItem1")
			else
				v55 = fn("HeaderItem2")
			end

			local v56

			if not __wf_atom_7e8ad928(statWeapon) then
				v56 = module14.IsWeaponStatItem(statWeapon)
			end

			if statWeapon then
				local v57

				if v56 then
					v57 = module12.GetQualityTag(statWeapon:__wf_atom_966277ef())
				end

				local materialColor = module14.GetMaterialColorFromCraftwork(v57)
				movie:__wf_atom_7f57ab2f(v55, "TitleBg", 13, true)
				movie:__wf_atom_7f57ab2f(v55, "TitleBgBacker", 13, true)

				if materialColor then
					movie:__wf_atom_4c1c1986(v55, "TitleBg", 11, materialColor)
				else
					movie:__wf_atom_4c1c1986(v55, "TitleBg", 11, v46.Background1)
				end

				movie:__wf_atom_7f57ab2f(v55, "TitleBgOverlay", 13, v57 ~= nil)
				movie:__wf_atom_4c1c1986(v55, "TitleBgOverlay", 12, 65)
				local textColor = module14.GetTextColorFromCraftwork(v57)

				if v57 == "WORN" then
					movie:__wf_atom_4c1c1986(v55, "TitleBgOverlay", 12, 100)
					textColor = 4664607
				end

				if textColor then
					movie:__wf_atom_4c1c1986(v55, "TitleBgOverlay", 11, textColor)
				else
					movie:__wf_atom_4c1c1986(v55, "TitleBgOverlay", 11, v46.Background1)
				end

				local v58 = fn13(v57)
				movie:__wf_atom_c90af43a(v55 .. ".TitleBgOverlay", v58)

				if i == 2 then
					movie:__wf_atom_e57658c2(fn("HeaderItem2"), 1, 0)
					movie:__wf_atom_e57658c2(fn("HeaderItem1"), 1, v8)
				elseif i == 1 then
					movie:__wf_atom_e57658c2(fn("HeaderItem1"), 1, 0)
				end
			else
				if v5.EmbeddedMode then
					movie:__wf_atom_7f57ab2f(v55, "TitleBg", 13, false)
					movie:__wf_atom_7f57ab2f(v55, "TitleBgBacker", 13, false)
				else
					movie:__wf_atom_7f57ab2f(v55, "TitleBg", 13, true)
					movie:__wf_atom_7f57ab2f(v55, "TitleBgBacker", 13, true)
				end

				movie:__wf_atom_7f57ab2f(v55, "TitleBgOverlay", 13, false)
			end
		end
	end

	local function fn48()
		movie:__wf_atom_e57658c2(clipName, 12, 0)
		__wf_atom_ec43d06e(movie, clipName, 1, { 12 }, { 100 }, 0.34)
	end

	fn11 = function(resource, p)
		if v5.AbilityInitialized or __wf_atom_7e8ad928(resource) then
			return
		end

		local suit = nil

		if __wf_atom_7e8ad928(p) then
			if not __wf_atom_7e8ad928(v5.Suit) then
				suit = v5.Suit

				if __wf_atom_1ef90898(suit) then
					suit = Resource(suit)
				end
			end
		else
			suit = p
		end

		local module15 = require("Lotus.Powersuits.PowersuitAbilities.PVPLib")
		local __wf_atom_fbc08c87 = resource:__wf_atom_fbc08c87()
		local __wf_atom_8e9ac384 = movie:__wf_atom_8e9ac384(resource:__wf_atom_014a76a2():c_str(), false)
		local description

		if v5.ForceOverrideDesc and resource:__wf_atom_64741537() ~= EMPTY_SYMBOL then
			description = resource:__wf_atom_64741537():c_str()
		else
			description = resource:__wf_atom_3a3d2e39():c_str()
		end

		if module15.IsPvpEnabled() then
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

		if __wf_atom_7e8ad928(v5.ResLoader) and not __wf_atom_7e8ad928(__wf_atom_fbc08c87) then
			v5.ResLoader = UISys.__wf_atom_c0dbe47c({ __wf_atom_fbc08c87:__wf_atom_5b41f63b() })
			v5.ResLoading = true
		end

		v5.Name = __wf_atom_8e9ac384
		v5.Description = description
		v5.LocalizedDesc = movie:__wf_atom_8e9ac384(description, true)
		v5.Energy = resource:__wf_atom_cb2fe64e(true, false)
		v5.BaseEnergy = resource:__wf_atom_cb2fe64e(false, false)
		v5.Icon = iconTexture
		v5.PreviewImage = __wf_atom_fbc08c87
		v5.MaxLevel = 3
		v5.Script = resource:__wf_atom_d67bb5bf()
		v5.LocTag = resource:__wf_atom_014a76a2()
		v5.Resource = resource
		v5.AutoParallaxX = autoParallaxX
		v5.AutoParallaxY = not autoParallaxX
		local abilityLevelOverride = nil

		if v5.AbilityLevelOverride == nil then
			if not (__wf_atom_7e8ad928(suit) or __wf_atom_7e8ad928(v5.AbilityIndex)) then
				abilityLevelOverride = suit:__wf_atom_cc3c265a(v5.AbilityIndex) - 1
			end
		else
			abilityLevelOverride = v5.AbilityLevelOverride
		end

		local nextSuitLevel = 0
		v5.Locked = false

		if abilityLevelOverride ~= nil then
			v5.Level = math.max(0, abilityLevelOverride)

			if not __wf_atom_7e8ad928(suit) then
				local __wf_atom_22941262 = suit:__wf_atom_22941262()
				nextSuitLevel = suit:__wf_atom_87c63382(v5.AbilityIndex)
				v5.Locked = __wf_atom_22941262 < nextSuitLevel
			end
		end

		v5.IsAbility = true

		if not v5.HideRankUp then
			if v5.Locked then
				v5.NextSuitLevel = nextSuitLevel
				v5.LastSuitLevel = 0
			elseif not __wf_atom_7e8ad928(suit) then
				v5.NextSuitLevel = suit:__wf_atom_d14dd4cc(v5.AbilityIndex, v5.Level + 2)
				v5.LastSuitLevel = suit:__wf_atom_d14dd4cc(v5.AbilityIndex, v5.Level + 1)

				if v5.NextSuitLevel == 255 then
					v5.NextSuitLevel = nil
				end
			end

			if v5.NextSuitLevel ~= nil then
				local __wf_atom_6480316c = __wf_atom_c67f9605:__wf_atom_6480316c(v5.LastSuitLevel, suit)
				local v53 = suit:__wf_atom_9765cbd5() - __wf_atom_6480316c
				local v54 = __wf_atom_c67f9605:__wf_atom_6480316c(v5.NextSuitLevel, suit) - __wf_atom_6480316c
				v5.LevelProgress = v53 / v54
			end
		end

		v5.AbilityInitialized = true
	end

	fn5 = function(statWeapon)
		if __wf_atom_7e8ad928(statWeapon) or not statWeapon:IsA(__wf_atom_9df43583) then
			return false, ""
		end

		if statWeapon.mFavorite then
			return false, Localize("/SF/Language/Vendor/DismantleDisabledClient", true)
		end

		return true, ""
	end

	local function fn49(_)
		if __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f())) then
			return
		end

		if
			v5.ContextAction ~= nil
			and v5.ItemInstance ~= nil
			and v5.StatWeapon ~= nil
			and v5.StatWeapon:__wf_atom_966277ef() ~= nil
		then
			gRegion:CreateEntity(
				dismantleFx,
				v5.ItemInstance:__wf_atom_d0069154(),
				v5.ItemInstance:__wf_atom_dc309f8a()
			)
			module12.DismantleItem(v5.StatWeapon)
			v5.ItemInstance:OnItemTakenRMI(gRegion:__wf_atom_eab484a7())
			_T.InfoPopup_Data = nil
		end
	end

	local function fn50(p, _)
		if p then
			return
		end

		module3.ShowMessage("/SF/Language/Vendor/SellFailed")
	end

	local function fn51()
		if __wf_atom_7e8ad928(v5.ContextAction) or not fn5(v5.StatWeapon) then
			return
		end

		local v50 = __wf_atom_fa1258d0()
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		__wf_atom_c4f78a8f:__wf_atom_92aa9d91()
		local v51 = v39
		v39 = -v5.ContextAction:__wf_atom_85018362() - 0.1
		local v52 = (v5.StatWeapon == nil or not (v5.StatWeapon:__wf_atom_966277ef() <= 3) or v5.StatWeapon:__wf_atom_9422b5f5())
			and 2
			or 1

		if v51 < 0 and v39 >= 0 then
			if not __wf_atom_7e8ad928(dismantleHoldSound) and __wf_atom_7e8ad928(v) then
				v = module3.PlaySound(dismantleHoldSound)
			end

			local dismantleAnim2

			if v52 == 1 then
				dismantleAnim2 = dismantleAnim
			else
				dismantleAnim2 = dismantleLongAnim
			end

			__wf_atom_c4f78a8f:__wf_atom_9b5dcd3b(
				dismantleAnim2,
				false,
				2,
				1,
				false,
				dismantleAnim2:__wf_atom_8bb4ded3() * dismantleAnim2:__wf_atom_091354f5(Symbol("Dismantle")) / v52
			)
			__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_0c00516f(0, false, false)

			if v24 and v24:HasTimer(v40) then
				v24:RemoveTimer(v40)
			end
		elseif
			v51 >= 0
			and v39 < 0
			and (__wf_atom_c4f78a8f:__wf_atom_c138b19b(dismantleAnim) or __wf_atom_c4f78a8f:__wf_atom_c138b19b(dismantleLongAnim))
		then
			__wf_atom_c4f78a8f:__wf_atom_9b5dcd3b(nil, false, 2, 1, false)

			if not __wf_atom_7e8ad928(v) then
				v:Stop(false)
			end

			__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_0c00516f(0, true, false)

			if v24 then
				v24:RemoveTimer(v40)
				v40 = nil
			end
		end

		if v52 < v39 then
			if not __wf_atom_7e8ad928(v) then
				v:Stop(false)
			end

			if v5.WeaponFingerprintForDismantle == nil or v5.WeaponFingerprintForDismantle == "" then
				module3.PlaySound(dismantleCompleteSound)
			else
				module3.PlaySound(dismantleCompleteWithTemperSound)
			end

			if v24 then
				if v24:HasTimer(v40) then
					v24:RemoveTimer(v40)
				end

				v40 = v24:AddTimer(0.5, function()
					__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_0c00516f(0, true, false)
					v40 = nil
				end)
			else
				__wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_0c00516f(0, true, false)
			end

			if v5 ~= nil and v5.PickupItem ~= nil and not v44 then
				fn49(v5.PickupItem)
			end

			v39 = 0
		end

		if v50 < v39 and not v44 then
			local v53 = __wf_atom_104bfe98(0, 346, v39 / v52)
			movie:__wf_atom_e57658c2(fn("HoldFill"), 14, v53)
			movie:__wf_atom_e57658c2(fn("HoldFill"), 12, 25)
		else
			movie:__wf_atom_e57658c2(fn("HoldFill"), 14, 0)
			movie:__wf_atom_e57658c2(fn("HoldFill"), 12, 0)
		end
	end

	local function fn52()
		if __wf_atom_7e8ad928(movie) then
			return
		end

		local v50 = __wf_atom_fa1258d0()

		if not __wf_atom_7e8ad928(v24) then
			v24:Update(v50)
		end

		if updateMovieInterpolator then
			movie:__wf_atom_88d9cd84(v50)
		end

		asyncLoader2:Update()
		asyncLoader:Update()

		if not __wf_atom_7e8ad928(v25) then
			v25:Update()
		end

		if v47 and not flag then
			return
		end

		local v51

		if useGlobalData then
			v51 = _T["InfoPopup_Data" .. v42]
		else
			v51 = itemInfo
		end

		if popupMode then
			_T.ItemInfoPopupMovies = _T.ItemInfoPopupMovies or {}
			_T.ItemInfoPopupMovies[v42] = movie
		end

		if v51 ~= nil then
			if v51.StoreItem == nil then
				v51.StoreItem = v51.mStoreItem
			end

			if v51.StoreItem == nil and v51.CodexEntry == nil and not v51.CustomEntry then
				v51 = nil
			end
		end

		if v5 == nil and v51 == nil then
			return
		end

		if popupMode then
			local v52 = _T.RadialSolarMapOpen == true or not __wf_atom_7e8ad928(_T.ShawzinMovie)

			if v28 ~= v52 then
				v28 = v52
				movie:__wf_atom_f0448d34(v28)
			end
		end

		if v26 and not __wf_atom_7e8ad928(v27) and v27:__wf_atom_86399a47() then
			fn10(false)
			fn8()
		end

		if v23 and not asyncLoader2:IsLoading() then
			if not fn3() then
				fn2(true)
			end

			fn48()
			v23 = false
		end

		if v5 ~= v51 or v51 ~= nil and v51.Refresh then
			local v52 = v51 == nil or v5 ~= nil
			v5 = v51

			if v24 ~= nil then
				v24:RemoveTimer(v22)
			end

			if v25 ~= nil then
				v25:SetActive(false)
			end

			resultItemType = nil
			v17 = 1
			v36 = false
			v39 = 0

			if v5 ~= nil then
				local mApplyThemes = v5.mApplyThemes

				if v49 ~= mApplyThemes then
					v49 = mApplyThemes
					fn25()
				end

				v5.Movie = movie
				v5.CompareHeight = 0
				local v53 = not v5.Refresh

				if v5.Refresh then
					v5.Refresh = nil

					if v5.IsAbility then
						v5.SkipVideoReset = true
					end

					v52 = false
				end

				if v5.IsAbility and not v5.AbilityInitialized then
					if __wf_atom_7e8ad928(v5.Suit) and not __wf_atom_7e8ad928(v5.SourceAvatar) then
						if v5.SourceAvatarAlternateSuit then
							v5.Suit = v5.SourceAvatar:__wf_atom_d2b2176d():__wf_atom_f7583f71()
						else
							v5.Suit = v5.SourceAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
						end
					end

					local resource = v5.Resource
					local suit

					if not __wf_atom_7e8ad928(v5.Suit) then
						suit = v5.Suit

						if __wf_atom_1ef90898(suit) then
							suit = Resource(suit)
						end
					end

					if
						__wf_atom_7e8ad928(resource)
						and not (__wf_atom_7e8ad928(v5.AbilityIndex) or __wf_atom_7e8ad928(suit))
					then
						resource = suit:__wf_atom_c497b0ae(v5.AbilityIndex)
					end

					if not __wf_atom_7e8ad928(resource) then
						if __wf_atom_1ef90898(resource) then
							v5.AllInOne = true
							v5.ResultItemType = resource
						else
							fn11(resource, suit)
						end
					end
				end

				if __wf_atom_7e8ad928(v5.CrewMemberInfo) then
					if __wf_atom_7e8ad928(v5.StoreItem) then
						resultItemType = v5.ResultItemType
					else
						local storeItem = v5.StoreItem
						v17 = math.max(storeItem:__wf_atom_22083c3e(), v17)

						if storeItem:IsA(__wf_atom_39c4c96b) and storeItem:__wf_atom_3d753d93() then
							v17 -= 1
						end

						if storeItem:IsA(__wf_atom_bf37f5ca) then
							resultItemType = storeItem:__wf_atom_c5566ef8()
						else
							resultItemType = storeItem:GetItem()
						end
					end
				else
					resultItemType = v5.CrewMemberInfo.mPowersuitInfo.mItemType
					v5.AllInOne = not v5.CrewMemberInfo:__wf_atom_894dc31a()
				end

				if v5.MetaData == nil then
					v5.MetaData = { HideOwned = true }
				else
					v5.MetaData.HideOwned = true
					v5.MetaData.ShowCheckmark = nil
				end

				local function fn53()
					v22 = nil

					if popupMode then
						module3.PlaySound(_G.UISound_ItemTip)
					end

					if v5.ResetCompare ~= nil and v5.ResetCompare and v44 then
						fn9()
					end

					fn47()
					v47 = false

					if asyncLoader2:IsLoading() then
						v23 = v53 and popupMode
						return
					end

					fn2(true)

					if v53 and popupMode then
						fn48()
					else
						movie:__wf_atom_e57658c2(clipName, 12, 100)
					end
				end

				if popupMode and v24 ~= nil then
					v22 = v24:AddTimer(0.01, fn53)
				else
					fn53()
				end
			end

			if v52 and popupMode then
				fn15()
			end

			local v53 = v5 ~= nil

			if popupMode then
				if v5 == nil or v5.InputFilter == nil then
					if v5 == nil or not v5.IgnoreInput then
						movie:__wf_atom_0c1c47f2(v38)
						movie:__wf_atom_c884ca43(not v53)
						movie:__wf_atom_b4ffb30f(true)
					else
						movie:__wf_atom_0c1c47f2(nil)
						movie:__wf_atom_c884ca43(true)
						movie:__wf_atom_b4ffb30f(false)
						movie:__wf_atom_69a0663a(false)
						movie:__wf_atom_dac78d3d(false)
					end
				else
					movie:__wf_atom_0c1c47f2(v5.InputFilter)
					movie:__wf_atom_c884ca43(true)
					movie:__wf_atom_b4ffb30f(false)
					movie:__wf_atom_69a0663a(false)
					movie:__wf_atom_dac78d3d(true)
				end
			else
				fn2(v53)
			end
		end

		if v5 ~= nil then
			fn51()

			if v36 and not __wf_atom_7e8ad928(v5.StoreItem) then
				fn44()
			end

			if v5.RarityChances ~= nil then
				v34.x = (v50 / 2 + v34.x) % 1
				v34.y = (-v50 / 40 + v34.y) % 1
				module2.UpdateRarityBar(movie, fn("RarityBar"), v34, false)
			end

			if v5.ResLoading and v5.ResLoader:__wf_atom_86399a47() then
				print("loader done")
				v25:SetActive(false)
				v5.ResLoading = false
				v5.PreviewImage = Resource(v5.PreviewImage)
				movie:__wf_atom_2dedec1a(fn("VideoPreview.Image"), 13, true)
				movie:__wf_atom_3f8dd1de(fn("VideoPreview.Image"))
				movie:__wf_atom_c90af43a(fn("VideoPreview.Image"), v5.PreviewImage)
				movie:__wf_atom_e3debc9a(fn("VideoPreview.Image"))
			end

			if popupMode and v24 ~= nil and not v24:HasTimer(v22) then
				local infoPopup_Data = _T.InfoPopup_Data

				if infoPopup_Data == nil or infoPopup_Data.Rect == nil then
					if v5.CustomPopupPosition then
						local x = v5.CustomPopupPosition.x
						local y = v5.CustomPopupPosition.y
						movie:__wf_atom_e57658c2(clipName, 0, x)
						movie:__wf_atom_e57658c2(clipName, 1, y)
					end
				else
					local rect = infoPopup_Data.Rect
					local __wf_atom_97cd8326 = movie:__wf_atom_97cd8326()
					local __wf_atom_54eeda24 = movie:__wf_atom_54eeda24()
					local infoPopup_Grid = _T.InfoPopup_Grid
					local v52 = (infoPopup_Grid == nil or infoPopup_Grid.PopupPadding == nil) and 10
						or infoPopup_Grid.PopupPadding
					local v53

					if rect.UseCursor then
						local __wf_atom_68d996b1 = movie:__wf_atom_68d996b1()
						local v54 = __wf_atom_97cd8326 / __wf_atom_68d996b1 / movie:__wf_atom_d5a50cb5()
						local v55 = __wf_atom_54eeda24 / __wf_atom_68d996b1 / movie:__wf_atom_c4f6543f()

						if v55 < v54 then
							v55 = v54
						end

						v53 = {
							x = movie:__wf_atom_79258be8() * v55,
							y = movie:__wf_atom_7c4b8de8() * v55
						}
					else
						v53 = module3.TransformViewportToPixelCoordinates(movie, {
							x = rect.X,
							y = rect.Y
						})
					end

					local transformViewportToPixelCoordinates = module3.TransformViewportToPixelCoordinates(movie, {
						x = rect.W,
						y = rect.H
					})
					local x = transformViewportToPixelCoordinates.x
					local y = transformViewportToPixelCoordinates.y

					if infoPopup_Data.CenterAlign then
						x = -v11 / 2
						y /= 2
						v52 = 0
					elseif not infoPopup_Data.TopLeftAligned then
						x /= 2
						y /= 2
					end

					local v54 = v10
					local _ = _T.InfoPopup_Data2 == nil
					local v55 = tonumber(v42) or 1
					local x2 = v53.x
					local y2 = v53.y
					local x3

					if v5.CustomPopupPosition then
						x3 = v5.CustomPopupPosition.x
						y2 = v5.CustomPopupPosition.y
					elseif v5.InventoryFixedPosition then
						x3 = x2 - (flag and 0 or 365)
					else
						if infoPopup_Data.CenterAlign then
							y2 += y
						elseif infoPopup_Data.BottomAnchor then
							y2 = y2 - v54 + y
						elseif not infoPopup_Data.TopLeftAligned then
							y2 -= y
						end

						local screenDimensions, v56 = module3.GetScreenDimensions(movie)
						local v57 = __wf_atom_54eeda24 * 0.05
						local v58 = v56 - (v57 + v54)

						if infoPopup_Data.CenterAlign then
							if v58 < y2 then
								y2 = v53.y - y - v54
							end
						else
							y2 = __wf_atom_421b01aa(y2, v57, v58)
						end

						local v59 = __wf_atom_97cd8326 * 0.01
						_T.ItemInfoPopupMovies = _T.ItemInfoPopupMovies or {}
						local v60 = #_T.ItemInfoPopupMovies + 1

						if _T.ItemInfoPopupMovies ~= nil then
							for _, itemInfoPopupMovy in _T.ItemInfoPopupMovies do
								if
									__wf_atom_7e8ad928(itemInfoPopupMovy)
									or itemInfoPopupMovy:__wf_atom_5e6e15c8(clipName, 12) ~= 0
								then
									continue
								end

								v60 -= 1
							end
						end

						local v61 = screenDimensions - v59

						if __wf_atom_97cd8326 < screenDimensions then
							v61 = __wf_atom_97cd8326 + (screenDimensions - __wf_atom_97cd8326) / 2
						end

						local v62 = v61 - v59
						local v63 = v11 + 15
						local v64 = x2 + x + v52 + v63 * (v60 - v55)

						if v62 < v64 + v11 or infoPopup_Data.RightAligned then
							local v65 = infoPopup_Data.TopLeftAligned and 0 or x
							v64 = v53.x - v65 - v52 - (v11 + 15) * v55 + 15
						end

						local v65 = v62 - (v63 + v63 * (v55 - 1))
						x3 = __wf_atom_421b01aa(v64, v59, v65)
					end

					movie:__wf_atom_e57658c2(clipName, 0, x3)
					movie:__wf_atom_e57658c2(clipName, 1, y2)
				end

				if v5.MetaData.UpdateExpiry then
					for _, tag in ipairs(tags) do
						if tag.ExcludeFromInfoPopup or tag.Type ~= module2.LABEL_TYPE_TIMER then
							continue
						end

						local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(v5.MetaData.Expiry)
						tag.Name = module.SecondsToFormattedTime(movie, __wf_atom_db2b0cee, "CompactTwoMax")
						module2.DrawPriceLabel(movie, tag.ClipName, tag)
						return
					end
				end
			end
		end
	end

	local function fn53(_, _)
		return not __wf_atom_7e8ad928(v5) and v5.mPreset ~= nil and v5.mPreset.mFavorite
	end

	local function fn54(p, p2)
		if __wf_atom_7e8ad928(v6) or not (v6:GetHowManyElements() > 1) or v5 == nil or v26 then
			return false
		end

		if p == module3.INCREMENT then
			v6:FocusNextElement()
		else
			v6:FocusPreviousElement()
		end

		v6:SelectCurrentElement()

		if p2 and popupMode then
			local itemInfoPopupComponents = _T.ItemInfoPopupComponents

			if itemInfoPopupComponents ~= nil then
				local itemInfoPopupComponent = itemInfoPopupComponents[flag and 2 or ""]

				if itemInfoPopupComponent ~= nil then
					itemInfoPopupComponent:SwitchPages(p, false)
				end
			end
		end

		module3.PlaySound(_G.UISound_ItemTipSection)
		return true
	end

	local function fn55()
		return v5 ~= nil and v5.ShowDisposition
	end

	local function fn56(p, p2)
		flag = false
		v44 = true
		v42 = p
		v43 = Localize(p2, true)
		fn4(v42)
		fn25()
	end

	fn6 = function()
		local v50 = {
			_G.UIMaterial_BorderMaterialErodedEdge,
			_G.UIMaterial_BorderMaterialDefault,
			_G.UIMaterial_BorderMaterialCassid,
			_G.UIMaterial_BorderMaterialDendrit,
			_G.UIMaterial_BorderMaterialFey,
			_G.UIMaterial_BorderMaterialMendicant,
			_G.UIMaterial_BorderMaterialOde
		}

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			module3.ScaleSlicedMaterials(_T.BackgroundMovie, v50)
		end
	end

	local function onViewportSizeChanged()
		fn6()
	end

	local function fn57(p)
		if not p then
			__wf_atom_86cbd68d(movie, fn("HeaderItem2") .. ".removeMovieClip")
			return
		end

		__wf_atom_86cbd68d(movie, fn("HeaderItem1.duplicateMovieClip"), "HeaderItem2", -1)
		movie:__wf_atom_2dedec1a(fn("HeaderItem2.subtitle"), 13, false)
		movie:__wf_atom_e57658c2(fn("HeaderItem2.TitleBgBacker"), 11, v46.Background1)
		__wf_atom_86cbd68d(movie, fn("Leaves") .. ".swapDepths", 10)
		__wf_atom_86cbd68d(movie, fn("MoteInfo") .. ".swapDepths", 5)
		__wf_atom_86cbd68d(movie, fn("HeaderItem1") .. ".swapDepths", 2)
		__wf_atom_86cbd68d(movie, fn("HeaderItem2") .. ".swapDepths", 1)
	end

	fn9 = function()
		if not flag then
			return
		end

		local v50 = v44
		v44 = not v44

		if v50 ~= v44 then
			fn57(v44 and false)

			if v44 then
				_T.CompareInfoPopup(v5.CompareItemInfo, 2, "")
			else
				_T["InfoPopup_Data" .. 2] = nil
			end
		end

		fn47()
		fn8()
		fn43(_T.InfoPopup_Grid)
		v6:FocusElement(1)
		v6:SelectCurrentElement()
		fn27()
		module3.PlaySound(nextMenuSound)
	end

	fn7 = function()
		local v50 = v5

		if v50 then
			if v5.StatCompareWeapon == nil or v5.StatCompareWeapon == v5.StatWeapon then
				return false
			else
				return flag and not v5.DisableCompare
			end
		end

		return v50
	end

	local fn61
	fn61 = fn20
	v2 = {
		Movie = movie,
		ClipName = clipName,
		OnProfileSaved = function()
			fn61()
		end,
		Shutdown = fn35,
		CanDismantle = fn5,
		OnItemSold = fn50,
		Update = fn52,
		FocusedFavoriteCallback = fn53,
		OnStyleChangedCallback = function()
			fn25()
		end,
		IconCacheFlushed = function()
			fn27()
		end,
		onKeyDown_MENU_RTRIGGER1 = function() end,
		OnGamepadTransition = function(_)
			fn27()
			fn28()
		end,
		SupportsThemes = function()
			return true
		end,
		AlwaysShowLabels = function()
			return true
		end,
		ShouldShowOmegaAttenStat = fn55,
		OverrideItemInfoData = fn56,
		ScaleMaterials = fn6,
		onViewportSizeChanged = onViewportSizeChanged,
		ToggleCompareHeader = fn57,
		ToggleCompare = fn9,
		CanCompare = fn7,
		onKeyDown_MENU_LTRIGGER1 = function() end,
		onKeyDown_MENU_GENERIC1 = function()
			if fn7() and flag then
				fn9()
				return true
			else
				return false
			end
		end,
		mHooks = {}
	}

	function v2.SetItem(_, p, p2)
		itemInfo = p

		if p2 and itemInfo ~= nil then
			itemInfo.Refresh = true
		end

		fn52()
	end

	function v2:GetItem()
		return itemInfo
	end

	function v2.Refresh(_)
		if itemInfo ~= nil then
			itemInfo.Refresh = true
			fn52()
		end
	end

	function v2:SetVisible(p)
		fn2(p)
	end

	function v2:SwitchPages(p, p2)
		return fn54(p, p2 == nil or p2)
	end

	(function(name, callback)
		local previous = env[name]

		local function fn58(...)
			if previous ~= nil then
				previous(...)
			end

			callback(...)
		end

		setfenv(fn58, env)
		env[name] = fn58
		table.insert(v2.mHooks, { Name = name, Previous = previous, Hooked = fn58 })
	end)("OnGamepadTransition", function(_)
		fn27()
		fn28()
	end)

	local function fn58(name, fn59)
		local previous = env[name]

		local function fn60(...)
			if fn59(...) then
				return true
			end

			if previous == nil then
				return false
			end

			return previous(...)
		end

		setfenv(fn60, env)
		env[name] = fn60
		table.insert(v2.mHooks, { Name = name, Previous = previous, Hooked = fn60 })
	end

	fn58("onKeyDown_NEXT_MENU", function()
		return fn54(module3.INCREMENT, true)
	end)
	fn58("onKeyDown_MENU_RTRIGGER1", function()
		return fn54(module3.INCREMENT, true)
	end)
	local update = env.Update

	local function fn59(...)
		if update ~= nil then
			update(...)
		end

		v2:Update()
	end

	env.Update = fn59
	table.insert(v2.mHooks, { Name = "Update", Previous = update, Hooked = fn59 })
	fn39()
	fn4(v42)
	return v2
end

local v2 = nil

function Initialize()
	v2 = Create(mMovie, "Popup", { UseGlobalData = true, PopupMode = true })
end

function OnProfileSaved(...)
	if v2 == nil then
		return
	else
		return v2.OnProfileSaved(...)
	end
end

function Shutdown(...)
	if v2 == nil then
		return
	else
		return v2.Shutdown(...)
	end
end

function CanDismantle(...)
	if v2 == nil then
		return false
	end

	return v2.CanDismantle(...)
end

function OnItemSold(...)
	if v2 == nil then
		return
	else
		return v2.OnItemSold(...)
	end
end

function Update(...)
	if v2 == nil then
		return
	else
		return v2.Update(...)
	end
end

function FocusedFavoriteCallback(...)
	if v2 == nil then
		return false
	end

	return v2.FocusedFavoriteCallback(...)
end

function OnStyleChangedCallback(...)
	if v2 == nil then
		return
	else
		return v2.OnStyleChangedCallback(...)
	end
end

function IconCacheFlushed(...)
	if v2 == nil then
		return
	else
		return v2.IconCacheFlushed(...)
	end
end

function onKeyDown_MENU_RTRIGGER1(...)
	if v2 == nil then
		return
	else
		return v2.onKeyDown_MENU_RTRIGGER1(...)
	end
end

function OnGamepadTransition(...)
	if v2 == nil then
		return
	else
		return v2.OnGamepadTransition(...)
	end
end

function SupportsThemes(...)
	if v2 == nil then
		return true
	end

	return v2.SupportsThemes(...)
end

function AlwaysShowLabels(...)
	if v2 == nil then
		return true
	end

	return v2.AlwaysShowLabels(...)
end

function ShouldShowOmegaAttenStat(...)
	if v2 == nil then
		return false
	end

	return v2.ShouldShowOmegaAttenStat(...)
end

function OverrideItemInfoData(...)
	if v2 == nil then
		return
	else
		return v2.OverrideItemInfoData(...)
	end
end

function ScaleMaterials(...)
	if v2 == nil then
		return
	else
		return v2.ScaleMaterials(...)
	end
end

function onViewportSizeChanged(...)
	if v2 == nil then
		return
	else
		return v2.onViewportSizeChanged(...)
	end
end

function ToggleCompareHeader(...)
	if v2 == nil then
		return
	else
		return v2.ToggleCompareHeader(...)
	end
end

function ToggleCompare(...)
	if v2 == nil then
		return
	else
		return v2.ToggleCompare(...)
	end
end

function CanCompare(...)
	if v2 == nil then
		return false
	end

	return v2.CanCompare(...)
end

function onKeyDown_MENU_LTRIGGER1(...)
	if v2 == nil then
		return
	else
		return v2.onKeyDown_MENU_LTRIGGER1(...)
	end
end

function onKeyDown_MENU_GENERIC1(...)
	if v2 == nil then
		return
	else
		return v2.onKeyDown_MENU_GENERIC1(...)
	end
end