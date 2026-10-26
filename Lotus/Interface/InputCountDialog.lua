local module = require("Lotus.Interface.UIUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local module4 = require("Lotus.Interface.CardUtilitiesRedux")
local module5 = require("Lotus.Interface.StoreItemUtilities")
local module6 = require("Lotus.Interface.Components.ThemedButton")
local module7 = require("Lotus.Interface.Components.ThemedInputField")
local v = nil
local v2 = nil
local callback = nil
local v3 = true
local v4 = nil
local v5 = false
local countOverride = 0
local v6 = 0
local maxSelectionCount = 1
local v7 = nil
local total = 0
local v8 = 0
local v9 = nil
local infoPopup_Data = nil
local v10 = ""
local v11 = nil
local v12 = 0
local v13 = 0
local v14 = false
local v15 = {
	{
		Name = "MinButton",
		Row = 1,
		Width = 32,
		Label = "<MIN_BUTTON>",
		CalloutAlt = "<MENU_LTRIGGER1>",
		Callback = "onKeyDown_TOGGLE_CHAT_WINDOW_ALT"
	},
	{
		Name = "DecrButton",
		Row = 1,
		Width = 32,
		Label = "<DECR_BUTTON>",
		CalloutAlt = "<MENU_LTRIGGER2>",
		Callback = "DecreaseCount",
		SendReleaseCallback = true
	},
	{
		Name = "CountField",
		Row = 1,
		Width = 206,
		Label = "1",
		CalloutAlt = "<MENU_GENERIC1> " .. Localize("/Lotus/Language/Menu/Select", ""),
		InputField = true
	},
	{
		Name = "IncrButton",
		Row = 1,
		Width = 32,
		Label = "<INCR_BUTTON>",
		CalloutAlt = "<MENU_RTRIGGER2>",
		Callback = "IncreaseCount",
		SendReleaseCallback = true
	},
	{
		Name = "MaxButton",
		Row = 1,
		Width = 32,
		Label = "<MAX_BUTTON>",
		CalloutAlt = "<MENU_RTRIGGER1>",
		Callback = "onKeyDown_MENU_RTRIGGER1"
	},
	{
		Name = "AcceptButton",
		Row = 2,
		Width = 173,
		Label = "/Lotus/Language/Menu/Global_Confirm",
		Callout = "<MENU_SELECT>",
		Callback = "onKeyDown_MENU_SELECT"
	},
	{
		Name = "CancelButton",
		Row = 2,
		Width = 173,
		Label = "/Lotus/Language/Menu/ItemSelection_Cancel",
		Callout = "<MENU_CANCEL>",
		Callback = "onKeyDown_MENU_CANCEL"
	}
}
local button = nil

function IsInputBlocked()
	return v3
end

local function fn(countOverride2)
	return (string.len((tostring(countOverride2))))
end

function MouseCatcherPressed(_) end

local function fn2()
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 14, v2)
	mMovie:__wf_atom_e57658c2("MouseCatcherBtn", 15, v)
end

function onViewportSizeChanged(_, _)
	v2, v = module2.GetScreenDimensions(mMovie)
	fn2()
end

function Shutdown()
	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(-1)
	end
end

local function fn3()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if _T[callback] == nil then
		if __wf_atom_2ad5cd23 ~= nil and callback ~= nil then
			__wf_atom_2ad5cd23:__wf_atom_f62a8704(callback, { v6, v4 })
		end
	else
		_T[callback](v6, v4)
	end

	mMovie:Close()
end

local function fn4()
	if not v3 then
		v3 = true
		module2.FadeBackground(mMovie, 0, 0.2)
		__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { 0 }, 0.25, 0, function()
			fn3()
		end)
	end
end

function onKeyDown_MENU_GENERIC1()
	if not v3 then
		for i = 1, #v15 do
			local v16 = v15[i]

			if v16.InputField then
				v16.Button:TryPressed(true)
			end
		end
	end
end

function onKeyDown_MENU_SELECT()
	if not v3 then
		v4 = 1
		v6 = maxSelectionCount
		fn4()
		module2.PlaySound(_G.UISound_Select)
		module2.PlaySound(_G.UISound_ButtonSelect)
	end
end

function onKeyDown_MENU_CANCEL()
	if not v3 then
		fn4()
		module2.PlaySound(_G.UISound_Select)
		module2.PlaySound(_G.UISound_WindowClose)
	end
end

local function fn5() end

function SelectAll()
	if infoPopup_Data.MaxSelectionCount == nil then
		maxSelectionCount = countOverride
	else
		maxSelectionCount = infoPopup_Data.MaxSelectionCount
	end

	button:SetText(maxSelectionCount)
	fn5()
	module2.PlaySound(_G.UISound_Select)
end

local function fn6()
	local __wf_atom_387f260e = mMovie:__wf_atom_387f260e(button.mClipName .. ".Label", 36)

	if tonumber(__wf_atom_387f260e) ~= maxSelectionCount then
		local v16 = tonumber((string.gsub(__wf_atom_387f260e, "|", "")))

		if v16 == nil then
			button:SetText("")
		else
			local v17

			if infoPopup_Data.MaxSelectionCount == nil then
				v17 = __wf_atom_421b01aa(v16, 0, countOverride)
			else
				v17 = __wf_atom_421b01aa(v16, 0, infoPopup_Data.MaxSelectionCount)
			end

			local v18 = math.floor(v17)
			button:SetText(v18)
			maxSelectionCount = v18
			fn5()
		end
	end
end

local function fn7(p)
	local v16 = maxSelectionCount + p

	if v16 < 0 or countOverride < v16 then
		return
	end

	if Engine.IsPlayingWithController() then
		module2.CreateParticles(
			mMovie,
			"Dialog.Callouts." .. module2.Ternary(p > 0, "Right", "Left"),
			module2.Ternary(p > 0, _G.UIFx_RightBumperPress, _G.UIFx_LeftBumperPress),
			0,
			0
		)
	end

	maxSelectionCount = v16
	fn5()
	button:SetText(maxSelectionCount)
end

local function fn8()
	v5 = true
	v2, v = module2.GetScreenDimensions(mMovie)

	if button ~= nil then
		mMovie:__wf_atom_50d60589(
			button.mLabelClipName,
			57,
			module2.Ternary(Engine.IsPlayingWithController(), "dynamic", "input")
		)

		if Engine.IsPlayingWithController() then
			button.mSelected = false
			mMovie:__wf_atom_2004c47f()
		else
			button.mSelected = true
			mMovie:__wf_atom_46a6af3b(button.mLabelClipName)
		end
	end

	fn2()
	v3 = false
end

function DisableOkAllButton() end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v9) then
		v9:Update()
	end

	if not v5 then
		fn8()
	end

	if not __wf_atom_7e8ad928(v7) then
		v8 -= __wf_atom_084b3e93()

		if v8 <= 0 then
			if total < fn(countOverride) - 1 then
				total += 0.2
			end

			v8 = 0.25
			fn7(v7 * math.pow(10, (math.floor(total))))

			if tonumber(maxSelectionCount) ~= countOverride then
				module2.PlaySound(module2.Ternary(v7 > 0, contributionUpSound, contributionDownSound))
			end
		end
	end

	if button ~= nil then
		fn6()
	end
end

function onKeyDown_MENU_UP()
	return true
end

function onKeyDown_MENU_DOWN()
	return true
end

function onKeyDown_MENU_UP_FROM_ANALOG()
	return true
end

function onKeyDown_MENU_DOWN_FROM_ANALOG()
	return true
end

function Global_onPress() end

function Global_onRollOver()
	__wf_atom_7e8ad928(beepSound)
end

local function fn9()
	if not v3 then
		if infoPopup_Data.MaxSelectionCount ~= nil and infoPopup_Data.MaxSelectionCount <= maxSelectionCount then
			return
		end

		module2.PlaySound(contributionUpSound)
		fn7(1)
		v7 = 1
		total = 0
		v8 = 0.6
	end
end

local function fn10()
	if not v3 then
		module2.PlaySound(contributionDownSound)
		fn7(-1)
		v7 = -1
		total = 0
		v8 = 0.6
	end
end

local function fn11()
	v7 = nil
end

function IncreaseCount(_, p)
	if p then
		fn9()
	else
		fn11()
	end
end

function DecreaseCount(_, p)
	if p then
		fn10()
	else
		fn11()
	end
end

function ConcludeCount()
	fn11()
end

function onKeyDown_MENU_LTRIGGER2()
	fn10()
	return true
end

function onKeyDown_MENU_RTRIGGER2()
	fn9()
	return true
end

function onKeyUp_MENU_LTRIGGER2()
	fn11()
	return true
end

function onKeyUp_MENU_RTRIGGER2()
	fn11()
	return true
end

function onKeyDown_TOGGLE_CHAT_WINDOW_ALT()
	maxSelectionCount = 0
	fn7(0)
	return true
end

function onKeyDown_MENU_RTRIGGER1()
	if infoPopup_Data.MaxSelectionCount == nil then
		maxSelectionCount = countOverride
	else
		maxSelectionCount = infoPopup_Data.MaxSelectionCount
	end

	fn7(0)
	return true
end

local function fn12(p)
	local v16 = 0
	local v17 = 32
	local total2 = 0
	local v18 = 1
	local v19 = false
	local infoPopup_Grid = _T.InfoPopup_Grid
	local v20 = infoPopup_Data.mMod ~= nil
	local _, v21 = module.GetGridItemName(mMovie, infoPopup_Grid, infoPopup_Data, infoPopup_Data.MetaData)
	v11 = v20 and {} or module.GetGridItemTags(mMovie, infoPopup_Grid, infoPopup_Data, infoPopup_Data.MetaData, v21)

	for _, v22 in ipairs(v11) do
		if not v22.UseFullLabel then
			continue
		end

		v17 = -32
		v16 = 300
		break
	end

	for _, v22 in ipairs(v11) do
		if not v22.UseFullLabel then
			v19 = v22.Type == module.LABEL_TYPE_REUSABLE_BLUEPRINT or v19
			v22.Name = ""
		end

		local v23
		v23, v18 = module.GetPriceLabelClip(mMovie, p, v18)
		module.DrawPriceLabel(mMovie, v23, v22)

		if v22.UseFullLabel then
			mMovie:__wf_atom_e57658c2(v23, 1, total2)
			total2 += mMovie:__wf_atom_5e6e15c8(v23 .. ".Label", 41) + 13
		else
			local v24 = mMovie:__wf_atom_5e6e15c8(v23 .. ".IconText", 40) or 0

			if v24 > 0 and v17 < 0 then
				v16 = v16 - v24 + 5
			end

			mMovie:__wf_atom_e57658c2(v23, 1, 0)
			mMovie:__wf_atom_e57658c2(v23, 0, v16)
			v16 += v17

			if v24 > 0 and v17 > 0 then
				v16 = v16 + v24 - 5
			end
		end
	end

	local v22 = v18 == nil and 1 or v18
	local v23 = p .. ".TagContainer.Tag1"
	local v24 = 1

	while mMovie:__wf_atom_253d7085(v23) do
		mMovie:__wf_atom_2dedec1a(v23, 13, v24 < v22)
		v24 += 1
		v23 = p .. ".TagContainer.Tag" .. tostring(v24)
	end

	return total2, v19
end

local function fn13()
	local color = module3.GetColor(2, true)
	local color2 = module3.GetColor(3, true)
	local convertColorNumberToProceduralRGB = module2.ConvertColorNumberToProceduralRGB(color)
	local convertColorNumberToProceduralRGB2 = module2.ConvertColorNumberToProceduralRGB(color2)
	local color3 = module3.GetColor(6, true)
	local color4 = module3.GetColor(9, true)
	local color5 = module3.GetColor(10, true)
	mMovie:__wf_atom_1ca72041(
		"Popup.Content.Bg",
		"StartColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"Popup.Content.Bg",
		"EndColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		0.95
	)
	mMovie:__wf_atom_e57658c2("Popup.Content.TitleBg", 11, color)
	mMovie:__wf_atom_e57658c2("Popup.Content.Footer", 11, color)
	mMovie:__wf_atom_e57658c2("Popup.Content.MaxCount", 44, color4)

	if infoPopup_Data ~= nil then
		mMovie:__wf_atom_50d60589(
			"Popup.Content.Description",
			36,
			"<p><font color=\"" .. module2.ConvertColorNumberToHex(color3) .. "\">" .. v10 .. "</font></p>"
		)
		fn12("Popup.Content")

		if v14 then
			local tagType = infoPopup_Data.TagType
			local formatNumber = module2.FormatNumber(countOverride)
			local iconTintLabelColor = tagType == module.LABEL_TYPE_CHECKMARK

			if countOverride == 9999999 then
				formatNumber ..= "+"
			end

			if iconTintLabelColor then
				formatNumber = Localize("/Lotus/Language/Menu/Crafting_Owned", {
					HOW_MANY = formatNumber
				})
			end

			local v16 = {
				Name = formatNumber,
				Type = tagType,
				Icon = _G.UITexture_LabelIcons[tagType],
				IconPos = { X = 0, Y = 0 },
				IconDims = { W = 25, H = 25 },
				ClipOffset = -165,
				IconTintLabelColor = iconTintLabelColor,
				BgAlpha = 0,
				BgColor = 2,
				LabelColor = 9
			}
			module.DrawPriceLabel(mMovie, "Popup.Content.ItemCount", v16)
		end
	end

	local v16 = { "Title", "TagSeparator" }

	for i = 1, #v16 do
		mMovie:__wf_atom_4c1c1986("Popup.Content", v16[i], 11, color5)
	end

	for i = 1, #v15 do
		local v17 = v15[i]

		if not v17.Button then
			continue
		end

		mMovie:__wf_atom_4c1c1986("Popup.Content", v17.Name .. "Callout", 11, color4)
		v17.Button:UpdateColors()
	end

	mMovie:__wf_atom_7df746cd(color)
end

local function fn14()
	local v16 = mMovie:__wf_atom_5e6e15c8("Popup.Content.Title", 41) + 16
	local v17 = v16 + 10
	mMovie:__wf_atom_e57658c2("Popup.Content.TagContainer", 1, v17)

	if v12 == 0 and #v11 > 0 then
		v12 = 30
	end

	local v18 = v17 + v12
	local v19 = v10 ~= ""

	if v18 <= v17 then
		v18 -= 13
		v19 = false
	end

	mMovie:__wf_atom_e57658c2("Popup.Content.TagSeparator", 1, v18 + 6)
	mMovie:__wf_atom_e57658c2("Popup.Content.Description", 1, v18 + 16)
	local v20

	if v10 == "" then
		v20 = v18 - 5
	else
		v20 = v18 + mMovie:__wf_atom_5e6e15c8("Popup.Content.Description", 41) + 18
	end

	mMovie:__wf_atom_2dedec1a("Popup.Content.TagSeparator", 13, v19)
	local v21 = v20 + 10 + 9
	mMovie:__wf_atom_e57658c2("Popup.Content.ItemCount", 1, v21 + 15)
	mMovie:__wf_atom_e57658c2("Popup.Content.MaxCount", 1, v21 + 18)
	mMovie:__wf_atom_e57658c2("Popup.Content.TitleBg", 15, v16)
	mMovie:__wf_atom_e57658c2("Popup.Content.Bg", 15, v21 - v16 - 9)
	mMovie:__wf_atom_e57658c2("Popup.Content.Bg", 1, v16)
	mMovie:__wf_atom_e57658c2("Popup.Content.Footer", 15, 9)
	mMovie:__wf_atom_e57658c2("Popup.Content.Footer", 1, v21 - 9)
	mMovie:__wf_atom_e57658c2("Popup.Content.Blurer", 15, v21)

	if v14 then
		v21 += 37
		mMovie:__wf_atom_2dedec1a("Popup.Content.ItemCount", 13, infoPopup_Data.mMod == nil)
	else
		mMovie:__wf_atom_2dedec1a("Popup.Content.ItemCount", 13, false)
	end

	local v22 = infoPopup_Data.MaxSelectionCount ~= nil

	if v22 then
		local v23 = Localize("/Lotus/Language/Labels/MaxCount", {
			COUNT = infoPopup_Data.MaxSelectionCount
		})
		mMovie:__wf_atom_50d60589("Popup.Content.MaxCount", 36, v23)
	end

	mMovie:__wf_atom_2dedec1a("Popup.Content.MaxCount", 13, v22)
	local v23 = "Popup.Content" .. "." .. v15[1].Name
	local v24 = v21 + 15
	local isPlayingWithController = Engine.IsPlayingWithController()
	local v25 = 1
	local v26 = 42
	local v27 = -175

	for i = 1, #v15 do
		local v28 = v15[i]

		while v25 < v28.Row do
			v25 += 1
			v24 += v26
			v26 = 42
			v27 = -175
		end

		local v29 = isPlayingWithController and v28.CalloutAlt ~= nil
		v26 = v29 and 72 or v26
		local v30 = "Popup.Content" .. "." .. v28.Name

		if not mMovie:__wf_atom_253d7085(v30) then
			__wf_atom_86cbd68d(mMovie, v23 .. ".duplicateMovieClip", v28.Name, 500 + i)
		end

		if not mMovie:__wf_atom_253d7085(v30 .. "Callout") then
			__wf_atom_86cbd68d(mMovie, v23 .. "Callout.duplicateMovieClip", v28.Name .. "Callout", 1000 + i)
		end

		mMovie:__wf_atom_e57658c2(v30, 0, v27)
		mMovie:__wf_atom_e57658c2(v30, 1, v24)
		mMovie:__wf_atom_e57658c2(v30 .. "Callout", 0, v27)
		mMovie:__wf_atom_e57658c2(v30 .. "Callout", 1, v24 + 36)
		mMovie:__wf_atom_2dedec1a(v30 .. "Callout", 13, v29)
		mMovie:__wf_atom_50d60589(v30 .. "Callout.Label", 36, mMovie:__wf_atom_8e9ac384(v28.CalloutAlt, true))
		v27 = v27 + v28.Width + 4

		if v28.Button ~= nil then
			continue
		end

		local button2 = (v28.InputField and module7 or module6).Create(
			mMovie,
			v30,
			v28.Label,
			v28.Callback,
			v28.Callout or v28.CalloutAlt,
			v28.CalloutAlt == nil
		)
		button2.mMinSize = v28.Width
		button2.mMaxSize = v28.Width
		button2.mInnerAlpha = 100
		button2.BaseSetFocus = button2.SetFocus

		function button2.SetFocus(_, p)
			button2:BaseSetFocus(p)

			if not p then
				fn11()
			end
		end

		if v28.SendReleaseCallback then
			button2.mOnReleasedCallback = button2.mOnPressedCallback
		end

		if v28.InputField then
			button2.BaseInputFieldFocused = button2.InputFieldFocused

			function button2.InputFieldFocused(object, p)
				object:BaseInputFieldFocused(p)

				if p then
					local mLabel = tonumber(button2.mLabel)
					maxSelectionCount = module2.Ternary(mLabel == nil, 1, maxSelectionCount)
				else
					fn6()
					local mLabel = tonumber(button2.mLabel)

					if mLabel == nil then
						button2:SetText("1")
						mLabel = 1
					end

					maxSelectionCount = mLabel
					fn5()
				end
			end

			button2:SetTextAlignment("center")
			mMovie:__wf_atom_e57658c2(v30 .. "Callout.Label", 14, v28.Width)
		end

		button2:Resize()
		v28.Button = button2
	end

	local v28 = v24 + 32

	if button == nil then
		button = v15[3].Button

		if infoPopup_Data.DefaultValue ~= nil then
			maxSelectionCount = infoPopup_Data.DefaultValue
			button:SetText(infoPopup_Data.DefaultValue)
		end
	end

	fn13()
	mMovie:__wf_atom_e57658c2("Popup.Content", 1, -v28 / 2 + v13)
end

function Initialize()
	if not __wf_atom_7e8ad928(_T.ChangeHubVisCounter) then
		_T.ChangeHubVisCounter(1)
	end

	module2.FadeBackground(mMovie, 0.95, 0.2)
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	__wf_atom_ec43d06e(mMovie, "_root", 1, { 12 }, { 100 }, 0.25)
	mMovie:__wf_atom_dac78d3d(true)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)

	if _T.SetButtons then
		_T.SetButtons(mMovie, {}, getfenv(1))
	end

	module2.PlaySound(_G.UISound_WindowOpen)
	mMovie:SetCallbacks("MouseCatcherBtn", nil, nil, "MouseCatcherPressed", nil)
	infoPopup_Data = _T.InfoPopup_Data

	if infoPopup_Data == nil then
		return
	end

	local isFocused = infoPopup_Data.mMod ~= nil
	mMovie:__wf_atom_933bbce0("Popup.Content.Bg", midBgTexture, midBgMaterial)
	local gridItemName, _ = module.GetGridItemName(mMovie, nil, infoPopup_Data, infoPopup_Data.MetaData)
	mMovie:__wf_atom_50d60589("Popup.Content.Title", 36, string.upper(mMovie:__wf_atom_8e9ac384(gridItemName, true)))
	local v16, v17 = fn12("Popup.Content")
	v12 = v16

	if infoPopup_Data.ArcaneRank == nil then
		v10 = module.GetItemInfoDesc(mMovie, infoPopup_Data, v17)
	else
		if infoPopup_Data.CompatLabel ~= nil then
			v10 ..= infoPopup_Data.CompatLabel .. "<br><br>"
		end

		local arcaneMaxRank = infoPopup_Data.ArcaneRank < 0 and infoPopup_Data.ArcaneMaxRank
			or infoPopup_Data.ArcaneRank
		local v18 = module2.Ternary(
			arcaneMaxRank == 0,
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false),
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
				RANK = arcaneMaxRank
			})
		) .. "  "
		local v19 = ""
		local mInstance = nil

		if __wf_atom_7e8ad928(infoPopup_Data.Arcane) then
			if not __wf_atom_7e8ad928(infoPopup_Data.StoreItem) then
				local upgradeInfo = SF.UpgradeInfo()
				upgradeInfo.mItemType = infoPopup_Data.StoreItem:GetItem()
				mInstance = upgradeInfo.mInstance
			end
		else
			mInstance = infoPopup_Data.Arcane.mInstance
		end

		if not __wf_atom_7e8ad928(mInstance) then
			local __wf_atom_254ac1f5 = mInstance:__wf_atom_254ac1f5(arcaneMaxRank)
			v19 = mMovie:__wf_atom_8e9ac384(mInstance:__wf_atom_f324d993(__wf_atom_254ac1f5), true)
		end

		local color = module3.GetColor(9, true)
		local color2 = module3.GetColor(10, true)
		v10 ..= "<font color=\"" .. module2.ConvertColorNumberToHex(color2) .. "\">" .. v18 .. "</font><font color=\"" .. module2.ConvertColorNumberToHex(color) .. "\">" .. v19 .. "</font>"
	end

	mMovie:__wf_atom_50d60589("Popup.Content.Description", 36, "<p><font color=\"#000000\">" .. v10 .. "</font></p>")
	module.DrawSeparator(mMovie, "Popup.Content.TagSeparator", 330)
	countOverride = infoPopup_Data.CountOverride or infoPopup_Data.Count

	if countOverride == nil and isFocused then
		countOverride = infoPopup_Data.mMod.Card.mUpgrade.mItemCount
	end

	countOverride = tonumber(countOverride)

	if countOverride == nil then
		countOverride = 0
	end

	if countOverride > 9999999 then
		countOverride = 9999999
	end

	v14 = infoPopup_Data.TagType ~= nil
	callback = infoPopup_Data.Callback
	local module8 = require("Lotus.Interface.Components.ThemedSpinner")
	v9 = module8.Create(mMovie, "Popup.Spinner")
	local module9 = require("EE.Interface.Components.Grid")
	local grid = module9.CreateGrid(mMovie, "Popup.Content.Grid.Item", nil, 1, 1)
	grid.mElementTransitionTime = 0
	grid.ElementWidth = 142
	grid.ElementHeight = 142
	grid.mEdgeAlpha = 30
	grid.mInnerAlpha = 60
	grid.SkipReinitializePos = true
	module.InitializeGridItem(mMovie, grid)
	local v18 = nil

	if isFocused then
		local v19 = {
			Card = module4.CardFromArtifact(infoPopup_Data.mMod.Card.mUpgrade, -1)
		}
		v18 = module4.AddToCollectionGrid(grid, -1, v19, 0)
		v18.mMod = { Card = v18.Card }
		grid:Redraw(nil, nil, true)
		mMovie:__wf_atom_e57658c2("Popup.Content.Grid", 1, -220)
		mMovie:__wf_atom_e57658c2("Popup.Content.Grid", 0, 0)
		mMovie:__wf_atom_2dedec1a("Popup.Content.Title", 13, false)
		mMovie:__wf_atom_2dedec1a("Popup.Content.Description", 13, false)
		mMovie:__wf_atom_2dedec1a("Popup.Content.TitleBg", 13, false)
		mMovie:__wf_atom_2dedec1a("Popup.Content.Bg", 13, false)
		mMovie:__wf_atom_2dedec1a("Popup.Content.Footer", 13, false)
		mMovie:__wf_atom_2dedec1a("Popup.Content.Grid.Item.RectangleBg", 13, false)
	elseif infoPopup_Data.StoreItem ~= nil then
		local storeItemInfo = module5.GetStoreItemInfo(
			mMovie,
			infoPopup_Data.StoreItem,
			{ GetVisibilityMaterial = true },
			nil,
			nil,
			true
		)

		if storeItemInfo ~= nil then
			v18 = grid:AddElement(storeItemInfo)
		end
	end

	if v18 ~= nil then
		module.OnGridItemCreated(mMovie, grid, "Popup.Content.Grid.Item")
		module.DrawGridItem(mMovie, grid, v18, { DisableSaturation = true, IsFocused = isFocused })
	end

	v13 = isFocused and 100 or 0
	fn14()
end

function OnGamepadTransition(p)
	local v16 = p == "true"
	mMovie:__wf_atom_fbca497c(v16)
	mMovie:__wf_atom_2004c47f()
	mMovie:__wf_atom_50d60589(button.mLabelClipName, 57, module2.Ternary(v16, "input", "dynamic"))

	if v16 then
		button.mSelected = true
		mMovie:__wf_atom_46a6af3b(button.mLabelClipName)
	else
		button.mSelected = false
	end

	fn14()
end

function SupportsThemes()
	return true
end

function OnStyleChangedCallback()
	fn13()
end