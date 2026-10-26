local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("EE.Interface.AnchorMgr")
local module4 = require("Lotus.Interface.Components.ThemedButton")
local v = nil
local v2 = nil
local v3 = false
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local flag = false
local v10 = {}
local v11 = {}
local mName = nil
local v12 = {}
local v13 = nil
local v14 = nil
local v15 = 0
local v16 = {
	23,
	54,
	42,
	1,
	28,
	29,
	38,
	52,
	60,
	50,
	19,
	15,
	16,
	21,
	37,
	4,
	12,
	53,
	10,
	55,
	56,
	25,
	22,
	41,
	40,
	13,
	27,
	30,
	20,
	32,
	45,
	39,
	2,
	17,
	31,
	14,
	3,
	51,
	47,
	6,
	18,
	48,
	26,
	61,
	58,
	46,
	33,
	34,
	35,
	36,
	43
}
local fn

function OnProfileSaved(_)
	if flag then
		mMovie:Close()
	else
		v3 = false
	end
end

local function fn2()
	if next(v10) == nil then
		if flag then
			mMovie:Close()
		end
	else
		v3 = true

		if not __wf_atom_7e8ad928(mName) then
			local mElement = v.CustomizationList.mElements[1]
			mElement.NameTag = TitleCase(Localize(mName, {}))
			v.CustomizationList.mElementDrawCallback(mElement)
		end

		for k, v17 in pairs(v10) do
			v6:__wf_atom_eaa56609(k, v17)
		end

		v10 = {}
		fn()

		if not __wf_atom_7e8ad928(gRegion) then
			local allObjects = gRegion:FindAllObjects(__wf_atom_f6f0ace7)

			for _, allObject in ipairs(allObjects) do
				allObject:UpdateColors()
			end

			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				local __wf_atom_cca6e0bc = __wf_atom_eab484a7:__wf_atom_cca6e0bc()

				if not __wf_atom_7e8ad928(__wf_atom_cca6e0bc) then
					__wf_atom_cca6e0bc:__wf_atom_733ea5ef()
					__wf_atom_cca6e0bc:__wf_atom_36169d98()
				end
			end
		end

		__wf_atom_dd7f4712(gGameData, "OnProfileSaved")
		__wf_atom_a0f6588f:__wf_atom_507ce99c(0, "OnProfileSaved")
	end
end

local function fn3()
	v10 = {}

	for k, v17 in pairs(v11) do
		v10[k] = v17
	end

	fn2()
end

function SaveChanges()
	flag = true
	v11 = {}
	fn2()

	if not __wf_atom_7e8ad928(mName) then
		v6:__wf_atom_e3755c51(mName)
	end

	module2.PlaySound(_G.UISound_SelectConfirm)
	module2.PlaySound(_G.UISound_SweetenerTwo)
end

function SaveChangesWithLocalContext()
	fn2()
end

function Close()
	mMovie:Close()
end

local function fn4(p, __wf_atom_fd5d793e, p2, p3)
	v10[p] = __wf_atom_fd5d793e

	if v11[p] == nil then
		v11[p] = v6:__wf_atom_fd5d793e(p)
	end

	v.CustomizationList.mActiveColorList[p] = __wf_atom_fd5d793e

	if p2 and not p3 then
		mName = "/Lotus/Language/Menu/Options_DisplayCustomize_Custom"
		mMovie:Execute("SaveChangesWithLocalContext", "")
	end

	v7:SetActive(true)
end

local function fn5(object)
	for _, v17 in ipairs(v16) do
		fn4(v17, object:__wf_atom_fd5d793e(v17), true, true)
	end

	mMovie:Execute("SaveChangesWithLocalContext", "")
	v.CustomizationList:Redraw()
end

local function fn6()
	local v17 = {}

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v17, getfenv(1))
	end
end

local function fn7()
	v9 = mMovie:PushChildMovie(genericMenuMovie)
	v9:Execute("SetTitle", "/Lotus/Language/Settings/Options_DisplayCustomize_SelectPreset")

	function _T.MenuSelectionDone(list)
		_T.GetComponents = nil
		_T.ResetSelectionDone = nil
		fn6()

		if list[1] ~= nil and list[1].PressedCallback ~= nil then
			mName = list[1].mName
			list[1].PressedCallback()
		end
	end

	v9:Execute("SetCallBack", "MenuSelectionDone")

	function _T.GetMenuEntries()
		local result = {}

		for i = 1, #presets do
			local v17 = i
			table.insert(result, {
				mName = presets[i]:__wf_atom_62b4f231(),
				PressedCallback = function()
					fn5(presets[v17])
				end
			})
		end

		return result
	end

	v9:Execute("SetElementsFunction", "GetMenuEntries")
end

local function fn8()
	local color = module.GetColor(6, true)
	local color2 = module.GetColor(9, true)
	local color3 = module.GetColor(10, true)
	local color4 = module.GetColor(2, false)
	local color5 = module.GetColor(9, false)
	mMovie:OverrideMaterial("ColorMenu.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:OverrideMaterial("Preview.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"ColorMenu.Bg",
		"RectInnerColor",
		color4.red / 255,
		color4.green / 255,
		color4.blue / 255,
		0.8
	)
	mMovie:__wf_atom_1ca72041(
		"ColorMenu.Bg",
		"RectEdgeColor",
		color5.red / 255,
		color5.green / 255,
		color5.blue / 255,
		0.1
	)
	mMovie:__wf_atom_1ca72041(
		"Preview.Bg",
		"RectInnerColor",
		color4.red / 255,
		color4.green / 255,
		color4.blue / 255,
		0.8
	)
	mMovie:__wf_atom_1ca72041(
		"Preview.Bg",
		"RectEdgeColor",
		color5.red / 255,
		color5.green / 255,
		color5.blue / 255,
		0.2
	)
	mMovie:__wf_atom_e57658c2("ColorMenu.HintHeader", 44, color3)
	mMovie:__wf_atom_e57658c2("ColorMenu.Hint", 44, color)
	mMovie:__wf_atom_e57658c2("Preview.Divider", 11, color2)
	mMovie:__wf_atom_e57658c2("Preview.Divider", 12, 20)
	local v17 = "<p><font color=\"#" .. string.format("%X", color2) .. "\">" .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/SettingsHud",
		false
	) .. "/</font>" .. "<font color=\"#" .. string.format("%X", color3) .. "\">" .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Settings/Loadout_ColorsTip",
		false
	) .. "</font></p>"
	mMovie:__wf_atom_50d60589("ColorMenu.Title", 36, v17)

	for k, _ in pairs(v12) do
		mMovie:__wf_atom_4c1c1986("Preview", k .. ".Label", 44, color)
	end

	mMovie:__wf_atom_e57658c2("Preview.Invulnerable.Label", 44, color)
	mMovie:__wf_atom_e57658c2("Preview.Overshield.Label", 44, color)
	mMovie:__wf_atom_e57658c2("Preview.Buff.Label", 44, color)
	mMovie:__wf_atom_e57658c2("Preview.Debuff.Label", 44, color)
end

local function fn9()
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("ColorMenu.CustomizationPanel", 1)
	local _, v17 = module2.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("ColorMenu.MouseCatcherTop", 1, __wf_atom_5e6e15c8)
	mMovie:__wf_atom_e57658c2(
		"ColorMenu.MouseCatcherBottom",
		1,
		__wf_atom_5e6e15c8 + v.CustomizationList.mMaxVisibleHeight
	)
	mMovie:__wf_atom_e57658c2("ColorMenu.MouseCatcherTop", 15, v17)
	mMovie:__wf_atom_e57658c2("ColorMenu.MouseCatcherBottom", 15, v17)
end

local function fn10()
	local module5 = require("Lotus.Interface.Components.ThemedCustomizationButton")
	local module6 = require("Lotus.Interface.Components.ThemedCustomizationList")
	v = module6.Create(mMovie, "ColorMenu.CustomizationPanel")
	v.CustomizationList.mElementHeight = 42
	v.CustomizationList.mElementWidth = 364
	v.CustomizationList.mForcedVerticalSeparation = 45
	v.CustomizationList.mMaxVisibleHeight = 486
	v.CustomizationList.mShowAccessibilityColors = true
	v.CustomizationList.VisibleRangeMaterial = panelVisRangeMaterial
	v.CustomizationList.TextVisibleRangeMaterial = panelTextVisRangeMaterial
	v.CustomizationList.RectangleVisibleRangeMaterial = panelBgVisRangeMaterial
	v.CustomizationList.mApplyColorCallback = fn4

	function v.CustomizationList.mOnSelectedCallback(p)
		if p.CallBack ~= nil then
			p.CallBack()
		end
	end

	v.CustomizationList:UpdateVisRanges()
	v.CustomizationList.mActiveColorList = {}

	for _, v17 in ipairs(v16) do
		v.CustomizationList.mActiveColorList[v17] = v6:__wf_atom_fd5d793e(v17)
	end

	local function fn11(p)
		local nameTag = string.upper(mMovie:__wf_atom_8e9ac384(p, true))
		v.CustomizationList:AddElement({ Type = module5.Types.TITLE, NameTag = nameTag }, true)
	end

	local function fn12(p, nameTag)
		v.CustomizationList:AddElement({
			Type = module5.Types.COLOR,
			NameTag = nameTag,
			mColorRegions = { p },
			mDefaultColor = v6:__wf_atom_fd5d793e(p, true)
		}, true)
	end

	if #presets > 0 then
		local __wf_atom_528defae = v6:__wf_atom_528defae()
		local v17 = __wf_atom_528defae == "" and "/Lotus/Language/Menu/Composition_Default" or __wf_atom_528defae
		local nameTag = TitleCase(Localize(v17, {}))
		v.CustomizationList:AddElement(
			{
				Type = module5.Types.BUTTON,
				NameTag = nameTag,
				CallBack = fn7,
				DefaultIcon = presetArrowIcon
			},
			true
		)
	end

	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_STATUS")
	fn12(23, "/Lotus/Language/Labels/HUD_COLOR_HEALTH")
	fn12(54, "/Lotus/Language/Labels/HUD_COLOR_SHIELD")
	fn12(42, "/Lotus/Language/Labels/HUD_COLOR_OVERSHIELD")
	fn12(1, "/Lotus/Language/Labels/HUD_COLOR_ARMOR")
	fn12(28, "/Lotus/Language/Labels/HUD_COLOR_INVULNERABLE_HEALTH")
	fn12(29, "/Lotus/Language/Labels/HUD_COLOR_INVULNERABLE_SHIELD")
	fn12(38, "/Lotus/Language/Labels/HUD_COLOR_OBJECT")
	fn12(4, "/Lotus/Language/Labels/HUD_COLOR_BUFF")
	fn12(12, "/Lotus/Language/Labels/HUD_COLOR_DEBUFF")
	fn12(43, "/Lotus/Language/Labels/HUD_COLOR_PARAZON_RANGE")
	fn12(16, "/Lotus/Language/Labels/HUD_COLOR_ENERGY")
	fn12(46, "/Lotus/Language/Labels/HUD_COLOR_PROTECTED_HEALTH")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_ABILITY_COMPONENT")
	fn12(52, "/Lotus/Language/Labels/HUD_COLOR_SELECTED_ABILITY")
	fn12(60, "/Lotus/Language/Labels/HUD_COLOR_UNSELECTED_ABILITY")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_COMBAT")
	fn12(50, "/Lotus/Language/Labels/HUD_COLOR_RETICLE")
	fn12(25, "/Lotus/Language/Labels/HUD_COLOR_HIT_INDICATOR")
	fn12(22, "/Lotus/Language/Labels/HUD_COLOR_HEADSHOT_INDICATOR")
	fn12(10, "/Lotus/Language/Labels/HUD_COLOR_CRITICAL")
	fn12(55, "/Lotus/Language/Labels/HUD_COLOR_STRONG_CRITICAL")
	fn12(56, "/Lotus/Language/Labels/HUD_COLOR_STRONGEST_CRITICAL")
	fn11("/Lotus/Language/Menu/MiniMap")
	fn12(33, "/Lotus/Language/Labels/HUD_COLOR_MINIMAP_PATHABLE")
	fn12(34, "/Lotus/Language/Labels/HUD_COLOR_MINIMAP_OUTLINE")
	fn12(35, "/Lotus/Language/Labels/HUD_COLOR_MINIMAP_OUTLINE_ABOVE")
	fn12(36, "/Lotus/Language/Labels/HUD_COLOR_MINIMAP_OUTLINE_BELOW")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_MARKERS")
	fn12(20, "/Lotus/Language/Labels/HUD_COLOR_GENERAL_MARKER")
	fn12(19, "/Lotus/Language/Labels/HUD_COLOR_FRIENDLY")
	fn12(15, "/Lotus/Language/Labels/HUD_COLOR_ENEMY")
	fn12(32, "/Lotus/Language/Labels/HUD_COLOR_LOOT")
	fn12(45, "/Lotus/Language/Labels/HUD_COLOR_PREDEATH")
	fn12(39, "/Lotus/Language/Labels/HUD_COLOR_OBJECTIVE")
	fn12(2, "/Lotus/Language/Labels/HUD_COLOR_ATTACK")
	fn12(17, "/Lotus/Language/Labels/HUD_COLOR_EXTRACTION")
	fn12(24, "/Lotus/Language/Labels/HUD_COLOR_HIGHLIGHT")
	fn12(18, "/Lotus/Language/Labels/HUD_COLOR_FOCUS")
	fn12(31, "/Lotus/Language/Labels/HUD_COLOR_LIFE_MODULE")
	fn12(14, "/Lotus/Language/Labels/HUD_COLOR_DOJO_ROOM")
	fn12(26, "/Lotus/Language/Labels/HUD_COLOR_HUB")
	fn12(58, "/Lotus/Language/Labels/HUD_COLOR_TOWN")
	fn12(3, "/Lotus/Language/Labels/HUD_COLOR_AVIONIC")
	fn12(51, "/Lotus/Language/Labels/HUD_COLOR_SALVAGE")
	fn12(47, "/Lotus/Language/Labels/HUD_COLOR_PVP_ENERGY")
	fn12(6, "/Lotus/Language/Labels/HUD_COLOR_COLLECTOR_TARGET")
	fn12(48, "/Lotus/Language/Labels/HUD_COLOR_RACE")
	fn12(61, "/Lotus/Language/Labels/HUD_COLOR_VIP")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_MISSION")
	fn12(27, "/Lotus/Language/Labels/HUD_COLOR_INCOMING_LIFE_SUPPORT")
	fn12(30, "/Lotus/Language/Labels/HUD_COLOR_KUVA_HARVESTER")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_TEXT")
	fn12(21, "/Lotus/Language/Labels/HUD_COLOR_GENERIC_TEXT")
	fn12(13, "/Lotus/Language/Labels/HUD_COLOR_DISABLED_TEXT")
	fn12(37, "/Lotus/Language/Labels/HUD_COLOR_NEGATIVE_TEXT")
	fn12(53, "/Lotus/Language/Labels/HUD_COLOR_SHADOW")
	fn11("/Lotus/Language/Labels/HUD_COLOR_SECTION_OBJECTIVE")
	fn12(41, "/Lotus/Language/Labels/HUD_COLOR_OBJECTIVE_PROGRESS")
	fn12(40, "/Lotus/Language/Labels/HUD_COLOR_OBJECTIVE_FLARE")
	v.CustomizationList:Redraw()
	fn9()
end

local function fn11()
	v12.MarkerDefault = 20
	v12.MarkerFriendly = 19
	v12.MarkerEnemy = 15
	v12.MarkerVip = 61
	v12.MarkerSynthesis = 6
	v12.MarkerLifeSupport = 41
	v12.MarkerFocus = 18
	v12.MarkerExtraction = 17
	v12.MarkerAttack = 2
	v12.MarkerObjective = 39
	v12.MarkerPredeath = 45
	v12.MarkerRace = 48
	v12.MarkerLoot = 32
	v12.MarkerDojo = 14
	v12.MarkerTown = 58
	v12.MarkerRelay = 26
	v12.MarkerAvionic = 3
	v12.MarkerSalvage = 51
	local v17 = {
		"MarkerDefault",
		"MarkerFriendly",
		"MarkerEnemy",
		"MarkerVip",
		"MarkerSynthesis",
		"MarkerLifeSupport",
		"MarkerFocus",
		"MarkerExtraction",
		"MarkerAttack",
		"MarkerObjective",
		"MarkerPredeath",
		"MarkerRace",
		"MarkerLoot",
		"MarkerDojo",
		"MarkerTown",
		"MarkerRelay",
		"MarkerAvionic",
		"MarkerSalvage"
	}
	local v18 = {
		"/Lotus/Language/Labels/HUD_COLOR_GENERAL_MARKER",
		"/Lotus/Language/Labels/HUD_COLOR_FRIENDLY",
		"/Lotus/Language/Labels/HUD_COLOR_ENEMY",
		"/Lotus/Language/Labels/HUD_COLOR_VIP",
		"/Lotus/Language/Labels/HUD_COLOR_COLLECTOR_TARGET",
		"/Lotus/Language/CrewShip/CommandConsole_LifeSupportBar",
		"/Lotus/Language/Labels/HUD_COLOR_FOCUS",
		"/Lotus/Language/Labels/HUD_COLOR_EXTRACTION",
		"/Lotus/Language/Labels/HUD_COLOR_ATTACK",
		"/Lotus/Language/Labels/HUD_COLOR_OBJECTIVE",
		"/Lotus/Language/Labels/HUD_COLOR_PREDEATH",
		"/Lotus/Language/Labels/HUD_COLOR_RACE",
		"/Lotus/Language/Labels/HUD_COLOR_LOOT",
		"/Lotus/Language/Labels/HUD_COLOR_DOJO_ROOM",
		"/Lotus/Language/Labels/HUD_COLOR_TOWN",
		"/Lotus/Language/Labels/HUD_COLOR_HUB",
		"/Lotus/Language/Labels/HUD_COLOR_AVIONIC",
		"/Lotus/Language/Labels/HUD_COLOR_SALVAGE"
	}

	for i = 1, #previewMarkerIcons do
		if not (i <= #v17) then
			continue
		end

		local v19 = v17[i]
		mMovie:__wf_atom_c90af43a("Preview." .. v19 .. ".Icon", previewMarkerIcons[i])
		local v20 = TitleCase(mMovie:__wf_atom_8e9ac384(v18[i], true))
		mMovie:__wf_atom_7f57ab2f("Preview", v19 .. ".Label", 54, true)
		mMovie:__wf_atom_48bd5a59("Preview", v19 .. ".Label", 36, v20)

		if not (v19 == "MarkerAvionic" or v19 == "MarkerSalvage") then
			continue
		end

		mMovie:__wf_atom_4c1c1986("Preview", v19 .. ".Icon", 5, 200)
		mMovie:__wf_atom_4c1c1986("Preview", v19 .. ".Icon", 6, 200)
	end

	mMovie:__wf_atom_2dedec1a("Preview.Overshield.InvulnerableBadge", 13, false)
	mMovie:__wf_atom_2dedec1a("Preview.Invulnerable.GloryKillThreshold", 13, false)
	mMovie:OverrideMaterial("Preview.Overshield.Shield", shieldGateMaterial)
	mMovie:OverrideMaterial("Preview.Overshield.Health", plainMaterial)
	mMovie:OverrideMaterial("Preview.Invulnerable.Shield", shieldGateMaterial)
	mMovie:OverrideMaterial("Preview.Invulnerable.Health", plainMaterial)
	mMovie:__wf_atom_7d7314f1("Preview.Overshield.Label.text", "/Lotus/Language/Labels/HUD_COLOR_OVERSHIELD")
	mMovie:__wf_atom_7d7314f1("Preview.Invulnerable.Label.text", "/Lotus/Language/Labels/Invulnerable")
	mMovie:__wf_atom_7d7314f1("Preview.Buff.Label.text", "/Lotus/Language/Labels/HUD_COLOR_BUFF")
	mMovie:__wf_atom_7d7314f1("Preview.Debuff.Label.text", "/Lotus/Language/Labels/HUD_COLOR_DEBUFF")
	mMovie:__wf_atom_50d60589("Preview.Buff.Data2.Desc", 36, "10")
	mMovie:__wf_atom_50d60589("Preview.Debuff.Data2.Desc", 36, "10")
	mMovie:OverrideMaterial("Preview.Buff.Data2.Bg", _G.UIMaterial_SmoothEdgeNoDepthTest)
	mMovie:OverrideMaterial("Preview.Debuff.Data2.Bg", _G.UIMaterial_SmoothEdgeNoDepthTest)
	mMovie:__wf_atom_c90af43a("Preview.Debuff.Icon", debuffPreviewIcon)
	mMovie:__wf_atom_c90af43a("Preview.Buff.Icon", buffPreviewIcon)
end

fn = function()
	mMovie:__wf_atom_e57658c2("Preview.Overshield.Health", 11, v6:__wf_atom_fd5d793e(23))
	mMovie:__wf_atom_e57658c2("Preview.Overshield.Shield", 11, v6:__wf_atom_fd5d793e(42))
	mMovie:__wf_atom_e57658c2("Preview.Overshield.GloryKillThreshold", 11, v6:__wf_atom_fd5d793e(43))
	mMovie:__wf_atom_e57658c2("Preview.Invulnerable.Health", 11, v6:__wf_atom_fd5d793e(28))
	mMovie:__wf_atom_e57658c2("Preview.Invulnerable.Shield", 11, v6:__wf_atom_fd5d793e(29))
	mMovie:__wf_atom_e57658c2("Preview.Buff.Icon", 11, v6:__wf_atom_fd5d793e(4))
	mMovie:__wf_atom_e57658c2("Preview.Debuff.Icon", 11, v6:__wf_atom_fd5d793e(12))
	mMovie:__wf_atom_e57658c2("Preview.Buff.Data2.Bg", 11, v6:__wf_atom_fd5d793e(53))
	mMovie:__wf_atom_e57658c2("Preview.Debuff.Data2.Bg", 11, v6:__wf_atom_fd5d793e(53))
	mMovie:__wf_atom_e57658c2("Preview.Buff.Data2.Desc", 44, v6:__wf_atom_fd5d793e(21))
	mMovie:__wf_atom_e57658c2("Preview.Debuff.Data2.Desc", 44, v6:__wf_atom_fd5d793e(21))
	local v17 = "<p><font color=\"#" .. string.format("%X", v6:__wf_atom_fd5d793e(42)) .. "\">300</font><font color=\"#" .. string.format("%X", v6:__wf_atom_fd5d793e(23)) .. "\">300</font></p>"
	mMovie:__wf_atom_50d60589("Preview.Overshield.PlayerHealth", 36, v17)
	local v18 = "<p><font color=\"#" .. string.format("%X", v6:__wf_atom_fd5d793e(29)) .. "\">300</font><font color=\"#" .. string.format("%X", v6:__wf_atom_fd5d793e(28)) .. "\">300</font></p>"
	mMovie:__wf_atom_50d60589("Preview.Invulnerable.PlayerHealth", 36, v18)

	for k, v19 in pairs(v12) do
		mMovie:__wf_atom_4c1c1986("Preview", k .. ".Icon", 11, v6:__wf_atom_fd5d793e(v19))
		mMovie:__wf_atom_4c1c1986("Preview", k .. ".Backer", 11, v6:__wf_atom_fd5d793e(v19))
	end
end

function MouseCatcherFocused() end

function Initialize()
	v6 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings()
	local topMenuMovie = _T.TopMenuMovie

	if _T.TopMenuOpen and not __wf_atom_7e8ad928(topMenuMovie) then
		topMenuMovie:Execute("SkipDisableInputOnClose", "true")
	end

	_T.ClosingTopMenu = true
	v5 = _T.GetSquadOverlayTitle()

	if v5 ~= nil then
		_T.SetSquadOverlayTitle()
	end

	v4 = module.GetCurrentBackgroundInfo()

	if v4.Visible and not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	mMovie:__wf_atom_e57658c2("ColorMenu.MouseCatcherTop", 12, 0)
	mMovie:__wf_atom_e57658c2("ColorMenu.MouseCatcherBottom", 12, 0)
	mMovie:__wf_atom_2dedec1a("ColorMenu.Title", 54, true)
	mMovie:__wf_atom_7d7314f1("ColorMenu.HintHeader.text", "/Lotus/Language/SystemMessages/SuggestionTipTitle")
	mMovie:__wf_atom_7d7314f1("ColorMenu.Hint.text", "/Lotus/Language/SystemMessages/HudColorTip")
	mMovie:SetCallbacks("ColorMenu.MouseCatcherBottom", "MouseCatcherFocused", nil, nil, nil)
	mMovie:SetCallbacks("ColorMenu.MouseCatcherTop", "MouseCatcherFocused", nil, nil, nil)
	v2 = module3.Create(mMovie)
	v2:Register(mMovie, "ColorMenu", { v2.ANCHOR_V_CENTRE, v2.ANCHOR_H_LEFT })
	v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	v7 = module4.Create(mMovie, "ColorMenu.ApplyBtn", "/Lotus/Language/Menu/Loadout_ApplyToolTip", "SaveChanges")
	v7:SetSpecialMode()
	v7:SetWidth(280)
	v7:SetActive(false)
	v7:Redraw()
	v8 = module4.Create(mMovie, "ColorMenu.BackBtn", "/Lotus/Language/Menu/NavBar_Cancel", "Close", "<MENU_CANCEL>")
	v8:SetWidth(115)
	v8:SetActive(true)
	v8:Redraw()
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		v14 = __wf_atom_eab484a7:__wf_atom_301e8d97()

		if not __wf_atom_7e8ad928(v14) then
			v13 = Engine.DamageData()
			v13.hitType = 1
		end
	end

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
	end

	fn10()
	fn11()
	fn8()
	fn()
	fn6()
	_T.HUDColorScreenOpen = true
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(p, p2)
	end

	if not __wf_atom_7e8ad928(v) then
		v.CustomizationList:UpdateVisRanges()
		v.CustomizationList:Redraw()
		fn9()
	end
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not (__wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(v14)) then
		v15 += __wf_atom_084b3e93()

		if v15 >= 2 then
			v15 -= 2
			v14:__wf_atom_ab4b3a1e(v13)
		end
	end
end

function Shutdown()
	fn3()

	if not __wf_atom_7e8ad928(v9) then
		v9:Close()
	end

	if v4.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0.25)
	end

	if v5 ~= nil then
		_T.SetSquadOverlayTitle(v5[1], v5[2])
	end

	_T.HUDColorScreenOpen = false
end

function onKeyDown_MENU_MOUSE_Z(_, p)
	if not v3 and not __wf_atom_7e8ad928(v) and v.CustListScrollBar.mInitialized then
		v.CustListScrollBar:ScrollByStep(tonumber(p), _G.UISound_Scroll)
	end
end

function onKeyDown_MENU_CANCEL()
	if not v3 then
		mMovie:Close()
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