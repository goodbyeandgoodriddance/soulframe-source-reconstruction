local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("EE.Interface.AnchorMgr")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("SF.Interface.SFUtilities")
local module6 = require("Lotus.Interface.StoreItemUtilities")
local module7 = require("SF.Interface.Libs.UIUtilities")
local module8 = require("EE.Interface.Utilities")
local v = {}
local v2 = nil
local v3 = nil
local uiAvatar = nil
local inventory = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local mCustSlot = 0
local v8 = nil
local v9 = {}
local v10 = nil
local v11 = nil
local v12 = nil
local colors = {}
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = { Edge = nil, Inner = nil }
local mVisRangeMaterials = {}
local v21 = {}
local v22 = nil
local v23 = nil
local v24 = nil
local asyncLoader = module7.CreateAsyncLoader()
local v25 = {
	nil,
	"/SF/Language/ColourCustomisations/EyelashColour",
	"/SF/Language/ColourCustomisations/InnerEyeColour",
	"/SF/Language/ColourCustomisations/OuterEyeColour"
}
local v26 = {
	{
		"Helmet",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		5,
		"/SF/Language/ColourCustomisations/CustomizeColors",
		WeakResource("/SF/Upgrades/Skins/Helmets/BaseHelmet"),
		0
	},
	{
		"Body",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		7,
		"/SF/Language/ColourCustomisations/CustomizeColors",
		WeakResource("/SF/Upgrades/Skins/Body/BaseBody"),
		2
	},
	{
		"Legs",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		8,
		"/SF/Language/ColourCustomisations/CustomizeColors",
		WeakResource("/SF/Upgrades/Skins/Legs/BaseLegs"),
		3
	},
	{
		"Arm",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		6,
		"/SF/Language/ColourCustomisations/CustomizeColors",
		nil,
		nil
	},
	{
		"Hair",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		1,
		"/SF/Language/ColourCustomisations/HairColour",
		nil,
		4
	},
	{
		"SkinColor",
		Symbol("GAME_C1_HEAD1"),
		Vector(0, 0, 0),
		0,
		0,
		"/SF/Language/ColourCustomisations/SkinColour",
		nil,
		4
	},
	{ "EyeColor", Symbol("GAME_C1_HEAD1"), Vector(0, 0, 0), 0, 0, v25, nil, 4 }
}
local v27 = { MODE_SELECTION = 1, COLOR_PICKER = 2, CRAFTING = 4, CHARACTER_CUSTOMIZATION = 5 }
local v28 = {
	WeakResource("/SF/Upgrades/Skins/Helmets/NoHelmet"),
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair1AHelmet"),
	WeakResource("/SF/Upgrades/Skins/Legs/UnderwearLegs"),
	WeakResource("/SF/Upgrades/Skins/Body/UnderwearBody")
}
Symbol("FaceLights")
local v29 = nil
local flag = false
local flag2 = false
local v30 = nil
local v31 = nil
local v32 = nil
local flag3 = nil
local v35 = true
local v36 = false
local v37 = nil
local v38 = nil
local v39 = nil
local v40 = 30
local v41 = nil
local v42 = nil
local v43 = nil
local v44 = nil
local v45 = nil
local v46 = __wf_atom_10cd16b2(0, 0.15)
local heading = 0
local v47 = 0
local flag4 = false

function ShowParticleEffect()
	if __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(swapFXSpawner) or __wf_atom_7e8ad928(v39) then
		return
	end

	v3:Attach(swapFXSpawner, EMPTY_SYMBOL)
	Sleep(0)
	local __wf_atom_f582136d = v3:__wf_atom_f582136d(smokeFXType)
	local v48 = #__wf_atom_f582136d > 0 and __wf_atom_f582136d[#__wf_atom_f582136d] or nil

	if not __wf_atom_7e8ad928(v48) then
		v48:__wf_atom_8cd234d5(v39, v39)
	end
end

function OnColorChange(p)
	if __wf_atom_7e8ad928(v3) then
		return
	end

	v39 = p
	v3:__wf_atom_8a035cd5(Symbol("ShowParticleEffect"), false)
end

function RatsCelebrateAsync(object)
	local colourPalette = _T.ColourPalette

	if #v >= 1 and #celebrationAnims >= 1 then
		local v48 = nil

		for i = 1, #v do
			local v49 = math.random(1, #celebrationAnims)
			v48 = celebrationAnims[v49]
			v[i]:__wf_atom_921c1a5f(v48, false, false)
		end

		local v49 = v48:__wf_atom_8bb4ded3() * v48:__wf_atom_091354f5(Symbol("FireColourVFX"))
		Sleep(v49)
	end

	object:Attach(swapFXSpawner, EMPTY_SYMBOL)
	Sleep(0)
	local __wf_atom_f582136d = object:__wf_atom_f582136d(smokeFXType)
	local v48 = #__wf_atom_f582136d > 0 and __wf_atom_f582136d[#__wf_atom_f582136d] or nil

	if not (__wf_atom_7e8ad928(colourPalette) or __wf_atom_7e8ad928(v48)) then
		v48:__wf_atom_8cd234d5(colourPalette.mTintColor1, colourPalette.mTintColor2)
	end
end

local function fn()
	if __wf_atom_7e8ad928(uiAvatar) then
		return
	end

	uiAvatar:__wf_atom_8a035cd5(Symbol("RatsCelebrateAsync"), false)
end

local function fn2(p)
	if v24 then
		v24:PlayTriggeredAnim(p)
	end

	module3.PlayLocalTransmission(verminiaTransmissionSet, p, v3, false)
end

local function fn3(p, data)
	local v48 = Color(p)
	return math.abs(v48.red - data.red) + math.abs(v48.green - data.green) + math.abs(v48.blue - data.blue)
end

local function fn4(p)
	return colors[p == 7 and 6 or p]
end

local function fn5()
	if math.random() > 0.1 or v40 > 0 or (__wf_atom_7e8ad928(colors) or __wf_atom_7e8ad928(v13)) then
		return
	end

	v40 = math.random(60, 300)
	local v48 = { Symbol("FashionReactGood1"), Symbol("FashionReactGood2"), Symbol("FashionReactGood3") }
	local v49 = { Symbol("FashionReactBad1"), Symbol("FashionReactBad2") }
	local v50 = {
		{
			primaryColour = 4607823,
			secondaryColour = 11804707,
			tertiaryColour = 4013373,
			MetalicsColour = 4607823,
			npcResponse = 1
		},
		{
			primaryColour = 16777198,
			secondaryColour = 7032194,
			tertiaryColour = 13617379,
			MetalicsColour = 7032194,
			npcResponse = 1
		},
		{
			primaryColour = 15903935,
			secondaryColour = 5947153,
			tertiaryColour = 1619417,
			MetalicsColour = 1619417,
			npcResponse = -1
		},
		{
			primaryColour = 6581794,
			secondaryColour = 15125898,
			tertiaryColour = 11765568,
			MetalicsColour = 6581794,
			npcResponse = 1
		},
		{
			primaryColour = 3426119,
			secondaryColour = 4605565,
			tertiaryColour = 7961487,
			MetalicsColour = 4605565,
			npcResponse = 1
		},
		{
			primaryColour = 11243872,
			secondaryColour = 5591401,
			tertiaryColour = 11559261,
			MetalicsColour = 11243872,
			npcResponse = 1
		},
		{
			primaryColour = 6503459,
			secondaryColour = 4082255,
			tertiaryColour = 12091987,
			MetalicsColour = 4082255,
			npcResponse = 1
		},
		{
			primaryColour = 8858940,
			secondaryColour = 13219231,
			tertiaryColour = 7303032,
			MetalicsColour = 8858940,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 16094385,
			secondaryColour = 6084594,
			tertiaryColour = 15921906,
			MetalicsColour = 16094385,
			npcResponse = 1
		},
		{
			primaryColour = 3159353,
			secondaryColour = 4367525,
			tertiaryColour = 15754916,
			MetalicsColour = 3159353,
			npcResponse = 1
		}
	}
	local v51 = fn4(v13)
	local _ = { v51.mTintColor0, v51.mTintColor1, v51.mTintColor2, v51.mTintColor3 }
	local v52 = 99999
	local v53 = 1

	for i = 1, #v50 do
		local v54 = fn3(v50[i].primaryColour, v51.mTintColor0) + fn3(v50[i].secondaryColour, v51.mTintColor1) + fn3(v50[i].tertiaryColour, v51.mTintColor2) + fn3(v50[i].MetalicsColour, v51.mTintColor3)

		if not (v54 < v52) then
			continue
		end

		v53 = i
		v52 = v54
	end

	if v50[v53].npcResponse == 1 then
		fn2(v48[__wf_atom_5784a397(1, #v48)])
	else
		fn2(v49[__wf_atom_5784a397(1, #v49)])
	end
end

local function fn6(_) end

local function fn7()
	v9[0] = v5:__wf_atom_d78fd481(0)
	v9[2] = v5:__wf_atom_d78fd481(2)
	v9[3] = v5:__wf_atom_d78fd481(3)
	v9[4] = v5:__wf_atom_d78fd481(4)
	v9[6] = v5:__wf_atom_d78fd481(6)
end

local function fn8(_, p, p2, data)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(uiAvatar) then
		return
	end

	local v48 = fn4(p)
	local v49 = GetTintFromNumber(p2)
	v48:SetColor(v49, data)
	v48:__wf_atom_59cc106e(v49, true)
	local v50 = v26[p][5]
	local v51 = v26[p][8]
	v5:__wf_atom_2754430f(v50, v48)
	v5:ApplyCustomization(uiAvatar, true)
	v8.mItem:SetCustomization(v5, mCustSlot)
	inventory:__wf_atom_fe6304ae(v8.mItem.mItemId.mId, mCustSlot, v5)
	local v52 = tonumber("0x" .. module8.ConvertRGB2HEX(data.red, data.green, data.blue))
	local v53 = GetColorNodeClipById(p * 10 + p2)
	UpdateNodeColor(v53, v52, true)

	if not __wf_atom_7e8ad928(_T.ColorCustomization_OnColorChange) then
		_T.ColorCustomization_OnColorChange(data)
	end

	if not __wf_atom_7e8ad928(v51) then
		v9[v51] = v5:__wf_atom_d78fd481(v51)
	end
end

local function fn9()
	local v48 = {}

	if v18.PickerType == 4 and v10 then
		table.insert(v48, { Label = "/SF/Language/Vendor/BuyItem", CallBack = PurchaseHair })
	elseif v31 and v18.PickerType == 7 then
		local active = (__wf_atom_7e8ad928(v5) or __wf_atom_7e8ad928(v12)) and true
			or not __wf_atom_7e8ad928(v5:__wf_atom_730958a3(v12).mItemType)
		table.insert(v48, {
			Label = "/SF/Language/ColourCustomisations/ResetBestitching",
			CallBack = ButtonBarRemoveBestitching,
			Active = active
		})
	elseif v31 and v14 then
		table.insert(v48, {
			Label = "/SF/Language/ColourCustomisations/ResetColour",
			CallBack = ResetColorsOnSlot,
			CallOut = "MENU_LTRIGGER2"
		})
	end

	if v31 or v30 == v27.CHARACTER_CUSTOMIZATION then
		if v31 and v18.PickerType == 7 then
			table.insert(v48, {
				Label = "/SF/Language/ColourCustomisations/ResetAll",
				CallBack = ResetCustomisations,
				CallOut = "MENU_RTRIGGER2"
			})
		end
	else
		table.insert(v48, {
			Label = "/SF/Language/ColourCustomisations/ResetAll",
			CallBack = ResetCustomisations,
			CallOut = "MENU_RTRIGGER2"
		})
	end

	table.insert(v48, {
		Label = "/SF/Language/Menu/Menu_Back",
		CallBack = Back,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(mMovie, v48, getfenv(1), true)
	end
end

local function fn10(items, p, mEnabled)
	local ternary = module8.Ternary(mEnabled, 95, 0)

	for _, item in items do
		if item == "CustomizationGrids.GridContainer" then
			if not __wf_atom_7e8ad928(v18) then
				v18.mEnabled = mEnabled
				v18:RedrawScrollBar()
			end
		elseif item == "CustomizationGrids.ColorSwatchList" and not __wf_atom_7e8ad928(v19) then
			v19.mEnabled = mEnabled
			v19:RedrawScrollBar()
		end

		if mEnabled then
			mMovie:__wf_atom_2dedec1a(item, 13, true)
		end

		local v48 = item
		__wf_atom_ec43d06e(mMovie, item, 2, { 12 }, { ternary }, p, 0, function()
			mMovie:__wf_atom_2dedec1a(v48, 13, mEnabled)
		end)
	end
end

local function fn11(p, p2)
	fn10(p, p2, false)
end

local function fn12(p, p2)
	fn10(p, p2, true)
end

local function fn13()
	local cameraControl = v3:CameraControl()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("FashionCamera"), v3:GetPosition(), 0, 5)

	if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(__wf_atom_f738b4af)) then
		cameraControl:SetCameraSpot(__wf_atom_f738b4af, 1.5)
		cameraControl:__wf_atom_fd14c463(1)
		__wf_atom_f738b4af:__wf_atom_802e6d6a(99999)
		__wf_atom_f738b4af:Activate()
	end
end

local function fn14()
	local cameraControl = v3:CameraControl()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("HelmArmorPreviewCamVerminia"), v3:GetPosition(), 0, 5)

	if not (__wf_atom_7e8ad928(cameraControl) or __wf_atom_7e8ad928(__wf_atom_f738b4af)) then
		cameraControl:SetCameraSpot(__wf_atom_f738b4af, 1.5)
		cameraControl:__wf_atom_fd14c463(1)
		__wf_atom_f738b4af:__wf_atom_802e6d6a(99999)
		__wf_atom_f738b4af:Activate()
	end
end

local function fn15(p, p2)
	if __wf_atom_7e8ad928(mMovie) or v30 == p then
		return
	end

	if v30 == v27.CHARACTER_CUSTOMIZATION then
		RestorePreviousArmor()
	end

	v30 = p
	local v48 = __wf_atom_7e8ad928(p2) and 0.3 or p2

	if p == v27.MODE_SELECTION then
		fn11(
			{
				"ColorCustomization.ArmourPickers",
				"ColorCustomization.CharacterCustomization",
				"CustomizationGrids.ColorSwatchList",
				"CustomizationGrids.GridContainer"
			},
			v48
		)
		fn12({ "CharacterNode", "ColorNode" }, v48)
		fn13()
	elseif p == v27.COLOR_PICKER then
		UpdateTitleBar()
		fn9()
		fn11({ "CharacterNode", "ColorNode", "ColorCustomization.CharacterCustomization" }, v48)
		fn12({ "ColorCustomization.ArmourPickers" }, v48)
	elseif p == v27.CRAFTING then
		fn11(
			{
				"CharacterNode",
				"ColorNode",
				"ColorCustomization.ArmourPickers",
				"ColorCustomization.CharacterCustomization"
			},
			v48
		)
	elseif p == v27.CHARACTER_CUSTOMIZATION then
		v12 = 0
		v6 = v5:__wf_atom_730958a3(v12)
		local weaponSkinInfo = SF.WeaponSkinInfo()
		weaponSkinInfo.mItemType = WeakResource("/SF/Upgrades/Skins/Helmets/NoHelmet")
		TransmogAsync(weaponSkinInfo, v12, true)
		EquipItem(0, weaponSkinInfo, false)
		UpdateTitleBar()
		fn9()
		fn14()
		fn11({ "CharacterNode", "ColorNode", "ColorCustomization.ArmourPickers" }, v48)
		fn12({ "ColorCustomization.CharacterCustomization" }, v48)
	end
end

local function fn16(instance)
	if __wf_atom_7e8ad928(instance) then
		return true
	end

	for i = 1, #v28 do
		if instance:IsA(v28[i]) then
			return true
		end
	end

	return false
end

function GetColorNodeClipById(p)
	local v49 = v26[math.floor(p / 10)][1]
	local v50 = p % 10
	local v51 = p >= 50 and "ColorCustomization.CharacterCustomization" or "ColorCustomization.ArmourPickers"
	return v51 .. "." .. v49 .. ".Color" .. v50, v51 .. "." .. v49
end

local function fn17(p)
	if p == 99 then
		return "CraftingNode"
	elseif p == 100 then
		return "ColorNode"
	elseif p == 102 then
		return "CharacterNode"
	end

	if p < 5 then
		return "ColorCustomization.ArmourPickers" .. "." .. v26[p][1]
	end

	return "ColorCustomization.CharacterCustomization" .. "." .. v26[p][1]
end

local function fn18(p, p2, p3, p4)
	local v48 = math.floor(0.5 + __wf_atom_104bfe98(p3, p4, p2))
	v21[p] = v48
	__wf_atom_86cbd68d(mMovie, p .. ".gotoAndStop", v48)
end

local function fn19(p)
	local v48 = fn17(p)
	mMovie:__wf_atom_7f57ab2f(v48, "Details", 67, false)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Details", 0, { 12 }, { 0 }, 0.5, 0)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Label", 0, { 12 }, { 0 }, 0.5, 0)
	__wf_atom_ec43d06e(mMovie, v48 .. ".SideLabel", 8, { 5, 6 }, { 100, 100 }, 0.3)
	mMovie:__wf_atom_4c1c1986(v48, "LockIndicator.Lock", 11, _G.UIColor_Gold)
	mMovie:__wf_atom_4c1c1986(v48, "LockIndicator.Circle", 11, _G.UIColor_Gold)
	local ternary = module8.Ternary(p < 99, 30, 80)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Shadow", 0, { 12 }, { ternary }, 0.34)

	if v21[v48 .. ".Hover"] == 9 then
		__wf_atom_ec43d06e(mMovie, v48 .. ".Hover", 0, { function(_) end }, { 1 }, 0.001)
	else
		__wf_atom_ec43d06e(mMovie, v48 .. ".Hover", 0, { function(p2)
				fn18(v48 .. ".Hover", p2, 20, 9)
				mMovie:__wf_atom_e57658c2(
					v48 .. ".Hover",
					5,
					0.35 * __wf_atom_104bfe98(100, 90, __wf_atom_24a82b69(p2))
				)
				mMovie:__wf_atom_e57658c2(
					v48 .. ".Hover",
					6,
					0.35 * __wf_atom_104bfe98(100, 90, __wf_atom_24a82b69(p2))
				)
				mMovie:__wf_atom_e57658c2(v48 .. ".Hover", 12, __wf_atom_104bfe98(100, ternary, p2))
			end }, { 1 }, 0.34)
	end
end

local function fn20(p)
	mMovie:__wf_atom_4c1c1986(p, "Details", 12, 0)
	mMovie:__wf_atom_4c1c1986(p, "HoverArea", 12, 0)
	mMovie:__wf_atom_4c1c1986(p, "Button", 12, 0)
	mMovie:__wf_atom_7f57ab2f(p, "Details", 67, false)
	__wf_atom_86cbd68d(mMovie, p .. ".Hover.gotoAndStop", 1)
	mMovie:__wf_atom_4c1c1986(p, "Hover", 5, 31.499999999999996)
	mMovie:__wf_atom_4c1c1986(p, "Hover", 6, 31.499999999999996)
	mMovie:__wf_atom_4c1c1986(p, "Hover", 12, 30)
	mMovie:__wf_atom_4c1c1986(p, "PanelHover", 12, 0)
	mMovie:__wf_atom_4c1c1986(p, "Shadow", 11, 1774867)
	mMovie:__wf_atom_4c1c1986(p, "Shadow", 12, 30)
	mMovie:__wf_atom_7f57ab2f(p, "Details", 13, false)
	mMovie:__wf_atom_7f57ab2f(p, "LockIndicator", 13, false)
end

local function fn21(p, p2)
	local v48 = p .. ".SideLabel"
	mMovie:__wf_atom_48bd5a59(v48, "Label", 36, Localize(p2, false))
	mMovie:OverrideMaterial(v48 .. ".Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(v48 .. ".Bg", "RectInnerColor", v20.Inner.r, v20.Inner.g, v20.Inner.b, 1)
	mMovie:__wf_atom_1ca72041(v48 .. ".Bg", "RectEdgeColor", v20.Edge.r, v20.Edge.g, v20.Edge.b, 1)
	mMovie:__wf_atom_c90af43a(v48 .. ".LeftCap", catLabelEdgeTexture)
	mMovie:__wf_atom_c90af43a(v48 .. ".RightCap", catLabelEdgeTexture)
	local v49 = mMovie:__wf_atom_cfc41e35(v48, "Label", 40) + 10
	mMovie:__wf_atom_4c1c1986(v48, "Bg", 14, v49)
	mMovie:__wf_atom_4c1c1986(v48, "LeftCap", 0, -(v49 / 2) - 15)
	mMovie:__wf_atom_4c1c1986(v48, "RightCap", 0, v49 / 2 + 15)
	local v50 = mMovie:__wf_atom_cfc41e35(v48, "Bg", 14) / 2 + 10
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(p .. ".Hover", 1)
	mMovie:__wf_atom_e57658c2(v48, 0, v50)
	mMovie:__wf_atom_e57658c2(v48, 1, __wf_atom_5e6e15c8)
	mMovie:__wf_atom_e57658c2(p, 12, 100)
end

local function fn22(p, p2)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local v48 = fn17(p)
	fn20(v48)
	__wf_atom_86cbd68d(mMovie, v48 .. ".Hover.gotoAndStop", 1)
	local ternary = module8.Ternary(p < 99, 30, 80)
	mMovie:__wf_atom_4c1c1986(v48, "Hover", 12, ternary)
	mMovie:__wf_atom_4c1c1986(v48, "Hover", 100, p)
	mMovie:__wf_atom_4c1c1986(v48, "Label", 100, p)
	mMovie:__wf_atom_4c1c1986(v48, "SideLabel", 100, p)
	mMovie:__wf_atom_4c1c1986(v48, "HoverArea", 100, p)
	mMovie:__wf_atom_e57658c2(v48, 100, p)

	if p2 then
		local v49 = ""
		mMovie:__wf_atom_7f57ab2f(v48, "Shadow", 13, false)
		mMovie:__wf_atom_7f57ab2f(v48, "Color1", 13, false)
		mMovie:__wf_atom_7f57ab2f(v48, "Color2", 13, false)
		mMovie:__wf_atom_7f57ab2f(v48, "Color3", 13, false)
		mMovie:__wf_atom_7f57ab2f(v48, "Color4", 13, false)

		if p == 99 then
			mMovie:SetCallbacks(v48 .. ".Hover", "NodeRollOver", "NodeRollOut", "OpenCraftingMovie", nil)
			mMovie:SetCallbacks(v48 .. ".SideLabel", "NodeRollOver", "NodeRollOut", "OpenCraftingMovie", nil)
			v49 = "/SF/Language/Crafting/Verminia_OpenCrafting"
		elseif p == 100 then
			mMovie:SetCallbacks(v48 .. ".Hover", "NodeRollOver", "NodeRollOut", "CustomizeColors", nil)
			mMovie:SetCallbacks(v48 .. ".SideLabel", "NodeRollOver", "NodeRollOut", "CustomizeColors", nil)
			v49 = "/SF/Language/ColourCustomisations/BestitchArmor"
		elseif p == 102 then
			mMovie:SetCallbacks(v48 .. ".Hover", "NodeRollOver", "NodeRollOut", "CustomizeCharacter", nil)
			mMovie:SetCallbacks(v48 .. ".SideLabel", "NodeRollOver", "NodeRollOut", "CustomizeCharacter", nil)
			v49 = "/SF/Language/ColourCustomisations/CustomizeCharacter"
		end

		fn21(v48, v49)
		mMovie:__wf_atom_2dedec1a(v48 .. ".Button", 13, false)
	else
		local v49 = v26[p]
		mMovie:SetCallbacks(v48 .. ".Hover", "NodeRollOver", nil, nil, nil)
		mMovie:SetCallbacks(v48 .. ".HoverArea", nil, "NodeRollOut", nil, nil)
		local v50 = not __wf_atom_7e8ad928(v49[8])
		mMovie:__wf_atom_2dedec1a(v48 .. ".Bestitch", 13, v50)

		for i = 1, 5 do
			local v51 = v48 .. ".Color" .. i
			mMovie:__wf_atom_4c1c1986(v51, "Circle", 11, 8152122)
			mMovie:__wf_atom_4c1c1986(v51, "Highlight", 11, _G.UIColor_Yellow)
			mMovie:__wf_atom_e57658c2(v51 .. ".Fill", 100, p * 10 + i)
			mMovie:SetCallbacks(v51 .. ".Fill", "ColorNodeRollOver", "ColorNodeRollOut", "ColorNodeClicked", nil)
			local v52 = GetTintFromNumber(i)
			local v53, v54

			if colors[p] then
				local v55 = fn4(p)
				local color = v55:GetColor(v52)
				v53 = tonumber("0x" .. module8.ConvertRGB2HEX(color.red, color.green, color.blue))
				v54 = v55:Initialized(v52)
			else
				v53 = 10984574
				v54 = false
			end

			UpdateNodeColor(v51, v53, v54)
			mMovie:__wf_atom_4c1c1986(v51, "Backer", 11, 1774867)
			mMovie:__wf_atom_4c1c1986(v51, "Backer", 12, 90)
			mMovie:__wf_atom_4c1c1986(v51, "PipGlow", 12, 0)
		end

		mMovie:__wf_atom_2dedec1a(v48 .. ".Color5", 13, false)
		mMovie:__wf_atom_e57658c2(v48 .. ".Bestitch", 100, p)
		mMovie:SetCallbacks(v48 .. ".Bestitch", "BestichRollOver", "BestichRollOut", "StartBestitch", nil)
		mMovie:__wf_atom_2dedec1a(v48 .. ".Label", 13, false)
		mMovie:__wf_atom_2dedec1a(v48 .. ".Button", 13, false)
	end
end

local function fn23()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_c90af43a("ColorCustomization.CharacterCustomization.Hair.Bestitch.Icon", hairPickerTexture)
	mMovie:__wf_atom_c90af43a(
		"ColorCustomization.CharacterCustomization.SkinColor.Bestitch.Icon",
		bodyTypeToggleTexture
	)
	mMovie:__wf_atom_c90af43a("ColorCustomization.CharacterCustomization.EyeColor.Bestitch.Icon", facePickerTexture)
	mMovie:SetCallbacks(
		"ColorCustomization.CharacterCustomization.Hair.Bestitch",
		"BestichRollOver",
		"BestichRollOut",
		"SelectHair",
		nil
	)
	local module9 = require("SF.Interface.Components.Button")
	local v48 = "ColorCustomization.CharacterCustomization.SkinColor"
	mMovie:__wf_atom_e57658c2(v48 .. ".Color1", 0, 5)
	mMovie:__wf_atom_e57658c2(v48 .. ".Color1", 1, -58)

	for i = 2, 5 do
		local v49 = v48 .. ".Color" .. i
		mMovie:__wf_atom_2dedec1a(v49, 13, false)
	end

	mMovie:SetCallbacks(v48 .. ".Bestitch", "BestichRollOver", "BestichRollOut", "SwapBodyType", nil)
	local v49 = module9.Create(mMovie, v48 .. ".Button", "/SF/Language/ColourCustomisations/SwapBodyType", "")
	v49:SetVariant(module9.VARIANTS.SPECIAL_BUTTON)
	v49:SetAnchor(module8.CENTER_ALIGNED)
	local v50 = "ColorCustomization.CharacterCustomization.EyeColor"
	mMovie:__wf_atom_e57658c2(v50 .. ".Color2", 0, -30)
	mMovie:__wf_atom_e57658c2(v50 .. ".Color2", 1, -120)
	mMovie:__wf_atom_e57658c2(v50 .. ".Color3", 0, 6)
	mMovie:__wf_atom_e57658c2(v50 .. ".Color3", 1, -63)
	mMovie:__wf_atom_e57658c2(v50 .. ".Color4", 0, -25)
	mMovie:__wf_atom_e57658c2(v50 .. ".Color4", 1, -5)
	mMovie:__wf_atom_2dedec1a(v50 .. ".Color1", 13, false)
	mMovie:SetCallbacks(v50 .. ".Bestitch", "BestichRollOver", "BestichRollOut", "SelectHead", nil)
	mMovie:__wf_atom_2dedec1a("ColorCustomization.CharacterCustomization.Hair.Color5", 13, true)

	for i = 1, 5 do
		local v51 = __wf_atom_104bfe98(1.3, -1.3, (i - 1) / 4)
		mMovie:__wf_atom_e57658c2(
			"ColorCustomization.CharacterCustomization" .. ".Hair.Color" .. i,
			0,
			math.cos(v51) * 90 + -80
		)
		mMovie:__wf_atom_e57658c2(
			"ColorCustomization.CharacterCustomization" .. ".Hair.Color" .. i,
			1,
			math.sin(v51) * 90 + -60
		)
	end
end

local function fn24()
	for i = 1, #v26 do
		colors[i] = v5:GetColors(v26[i][5])
		fn22(i)
	end

	fn23()
end

local function fn25(paletteItem, i)
	local __wf_atom_8f6061c7 = paletteItem:__wf_atom_8f6061c7()

	if #__wf_atom_8f6061c7 == 4 then
		return __wf_atom_8f6061c7[i]
	end

	return 16777215
end

local function fn26(x)
	local v48 = math.abs(x * 6 - 3) - 1
	local v49 = 2 - math.abs(x * 6 - 2)
	local v50 = 2 - math.abs(x * 6 - 4)
	return {
		x = __wf_atom_421b01aa(v48, 0, 1),
		y = __wf_atom_421b01aa(v49, 0, 1),
		z = __wf_atom_421b01aa(v50, 0, 1)
	}
end

local function fn27(data)
	local v48 = fn26(data.x)
	local v49 = (1 - math.abs(2 * data.z - 1)) * data.y
	v48.x = (v48.x - 0.5) * v49 + data.z
	v48.y = (v48.y - 0.5) * v49 + data.z
	v48.z = (v48.z - 0.5) * v49 + data.z
	return v48
end

local function fn28(data)
	local v48

	if data.y < data.z then
		v48 = {
			x = data.z,
			y = data.y,
			z = -1,
			w = 2 / 3
		}
	else
		v48 = {
			x = data.y,
			y = data.z,
			z = 0,
			w = -1 / 3
		}
	end

	local v49

	if data.x < v48.x then
		v49 = { x = v48.x, y = v48.y, z = v48.w, w = data.x }
	else
		v49 = { x = data.x, y = v48.y, z = v48.z, w = v48.x }
	end

	local v50 = v49.x - math.min(v49.w, v49.y)
	return {
		x = math.abs((v49.w - v49.y) / (6 * v50 + 1e-6) + v49.z),
		y = v50,
		z = v49.x
	}
end

local function fn29(p)
	local v48 = fn28(p)
	local v49 = v48.z - v48.y * 0.5
	local v50 = v48.y / (1 - math.abs(v49 * 2 - 1) + 1e-6)
	return { x = v48.x, y = v50, z = v49 }
end

local function fn30(p)
	if p <= 0.03928 then
		return p / 12.92
	end

	return (math.pow((p + 0.055) / 1.055, 2.4))
end

local function fn31(p)
	if p <= 0.0031308 then
		return 12.92 * p
	end

	return math.pow(p, 5 / 12) * 1.055 - 0.055
end

local function fn32()
	if not v29 then
		return
	end

	local v48 = v29[1]
	local v49 = v29[2]
	local v50 = math.floor(v48 / 10)
	local v51 = v48 - v50 * 10
	local mElement = v19.mElements[v50]

	if __wf_atom_7e8ad928(mElement) or __wf_atom_7e8ad928(mElement.PaletteItem) then
		return
	end

	local __wf_atom_8f6061c7 = mElement.PaletteItem:__wf_atom_8f6061c7()

	if #__wf_atom_8f6061c7 ~= 4 then
		print("Colors wrong")
		return
	end

	local convertColorNumberToProceduralRGB = module8.ConvertColorNumberToProceduralRGB(__wf_atom_8f6061c7[v51])
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v49, 14)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(v49, 15)
	local v52 = __wf_atom_5e6e15c8 * -0.5
	local v53 = __wf_atom_5e6e15c8_2 * -0.5
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(v49, 30)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(v49, 31)
	local v54 = (__wf_atom_5e6e15c8_3 - v52) / __wf_atom_5e6e15c8
	local v55 = (__wf_atom_5e6e15c8_4 - v53) / __wf_atom_5e6e15c8_2

	if not (v54 < -0.1 or v54 > 1.1 or v55 < -0.1) then
		local _ = v55 > 1.1
	end

	local v56 = __wf_atom_421b01aa(v54, 0, 1)
	local v57 = __wf_atom_421b01aa(v55, 0, 1)
	Color(
		255 * convertColorNumberToProceduralRGB.r,
		255 * convertColorNumberToProceduralRGB.g,
		255 * convertColorNumberToProceduralRGB.b
	)
	convertColorNumberToProceduralRGB.r = fn30(convertColorNumberToProceduralRGB.r)
	convertColorNumberToProceduralRGB.g = fn30(convertColorNumberToProceduralRGB.g)
	convertColorNumberToProceduralRGB.b = fn30(convertColorNumberToProceduralRGB.b)
	local v58 = fn29({
		x = convertColorNumberToProceduralRGB.r,
		y = convertColorNumberToProceduralRGB.g,
		z = convertColorNumberToProceduralRGB.b
	})
	local v59 = { x = 0, y = 0.75, z = 0.75 }
	v58.y = __wf_atom_104bfe98(v58.y * v59.y, v58.y, 1 - v56 * v56)
	v58.z = __wf_atom_104bfe98(v58.z * v59.z, v58.z, 1 - v57 * v57)
	local v60 = fn27(v58)
	v60.x = __wf_atom_421b01aa(fn31(v60.x), 0, 1)
	v60.y = __wf_atom_421b01aa(fn31(v60.y), 0, 1)
	v60.z = __wf_atom_421b01aa(fn31(v60.z), 0, 1)
	local v61 = Color(255 * v60.x, 255 * v60.y, 255 * v60.z)
	fn8(nil, v13, v14, v61)
end

function OnColorPressed(p, p2)
	v29 = { p, p2 }
	fn32()
	mMovie:__wf_atom_ff7b514d(eyedropperCursor)
	mMovie:__wf_atom_2dedec1a(p2 .. ".Border", 13, true)
	module8.PlaySound(_G.UISound_Focus)
end

function OnColorReleased(_, p)
	v29 = nil
	mMovie:__wf_atom_ff7b514d(nil)
	mMovie:__wf_atom_2dedec1a(p .. ".Border", 13, false)
	module8.PlaySound(colourNodeClickedSound)
	fn5()
end

function OnColorRollout(_, p)
	if v29 then
		module8.PlaySound(colourNodeClickedSound)
		fn5()
	end

	v29 = nil
	mMovie:__wf_atom_ff7b514d(nil)
	mMovie:__wf_atom_2dedec1a(p .. ".Border", 13, false)
end

local function fn33()
	for i = 1, #v26 do
		for j = 1, 5 do
			local v48 = GetColorNodeClipById(i * 10 + j)
			local mMovie = mMovie
			mMovie:__wf_atom_7f57ab2f(v48, "Highlight", 13, i == v13 and j == v14)
		end
	end
end

local function fn34()
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Crafting/ChooseColor", false)

	if not (__wf_atom_7e8ad928(v13) or __wf_atom_7e8ad928(v26[v13][6])) then
		local v48 = v26[v13][6]

		if type(v48) == "table" and not (__wf_atom_7e8ad928(v14) or __wf_atom_7e8ad928(v48[v14])) then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v48[v14], false)
		elseif type(v48) == "string" then
			__wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(v48, false)
		end
	end

	mMovie:__wf_atom_48bd5a59("CustomizationGrids.ColorSwatchList", "TitleBar.Title.Text", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_4c1c1986("CustomizationGrids.ColorSwatchList", "TitleBar.Title.Text", 44, _G.UIColor_Yellow)
	mMovie:OverrideMaterial("CustomizationGrids.ColorSwatchList.TitleBar.Backer", _G.UIMaterial_FocusedTabBorder)
end

local function fn35(p, items)
	if __wf_atom_7e8ad928(v19) or p == v16 and items == v17 then
		return
	end

	v16 = p
	v17 = items
	v19:RemoveElements(true, true)

	for _, item in items do
		v19:AddElement({ PaletteItem = item })
	end

	if p then
		local __wf_atom_da43e3f3 = inventory:__wf_atom_da43e3f3()

		if not __wf_atom_7e8ad928(__wf_atom_da43e3f3) then
			for _, v48 in __wf_atom_da43e3f3 do
				if
					__wf_atom_7e8ad928(v48)
					or not v48.mItemType:IsA(WeakResource("/SF/Types/Items/ColorPickerItem"))
				then
					continue
				end

				local v49 = { PaletteItem = Resource(v48.mItemType) }
				v19:AddElement(v49)
			end
		end
	end

	v19:Redraw(nil, true, true)
end

local function fn36()
	mMovie:OverrideMaterial("CustomizationGrids.ColorSwatchList.Background", colorPickerBackgroundMaterial)
	mMovie:__wf_atom_4c1c1986("CustomizationGrids.ColorSwatchList", "BackgroundFill", 11, 2039583)
	mMovie:OverrideMaterial("CustomizationGrids.ColorSwatchList.Title.Backer", _G.UIMaterial_FocusedTabBorder)
	mMovie:__wf_atom_4c1c1986("CustomizationGrids.ColorSwatchList", "Title.Text", 44, _G.UIColor_Yellow)
	local module9 = require("EE.Interface.Components.List")
	v19 = module9.CreateNewList(getfenv(1), "CustomizationGrids.ColorSwatchList.Element")
	v19.mForcedVerticalSeparation = 175
	v19.mEnabled = true
	v19.mHeight = 730
	table.insert(mVisRangeMaterials, _G.UIMaterial_VerticalVisibilityRangeText)
	table.insert(mVisRangeMaterials, _G.UIMaterial_VerticalVisibilityRange)
	table.insert(mVisRangeMaterials, colorSwatchMaterial)
	table.insert(mVisRangeMaterials, dividerMaterial)
	v19:AttachScrollBar("CustomizationGrids.ColorSwatchList.ScrollBar", {
		mVisRangeMaterials = mVisRangeMaterials,
		mHeight = 730,
		mVisRangeFadeSize = 10
	})

	function v19.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "Btn", 12, 0)
		mMovie:OverrideMaterial(p .. ".DecoLineLeft", dividerMaterial)
		mMovie:OverrideMaterial(p .. ".DecoLineRight", dividerMaterial)
		mMovie:__wf_atom_4c1c1986(p, "Title", 44, _G.UIColor_Yellow)
		mMovie:__wf_atom_7f57ab2f(p, "Title", 54, true)

		for i = 1, 5 do
			mMovie:OverrideMaterial(p .. ".Color" .. i .. ".Swatch", colorSwatchMaterial)
			mMovie:__wf_atom_c90af43a(p .. ".Color" .. i .. ".Swatch", colorSwatchTexture)
			mMovie:OverrideMaterial(p .. ".Color" .. i .. ".Border", _G.UIMaterial_VerticalVisibilityRange)
			mMovie:__wf_atom_2dedec1a(p .. ".Color" .. i .. ".Border", 13, false)
		end

		mMovie:OverrideMaterial(p .. ".Title", _G.UIMaterial_VerticalVisibilityRangeText)
	end

	function v19.mElementDrawCallback(data)
		local paletteItem = data.PaletteItem

		if __wf_atom_7e8ad928(paletteItem) then
			return
		end

		mMovie:__wf_atom_48bd5a59(data.mClipName, "Title", 36, Localize(paletteItem:__wf_atom_014a76a2():c_str(), nil))
		local __wf_atom_cfc41e35 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Title", 40)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "DecoLineLeft", 14, 270 - __wf_atom_cfc41e35 / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "DecoLineRight", 14, 270 - __wf_atom_cfc41e35 / 2)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "DecoLineLeft", 12, 70)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "DecoLineRight", 12, 70)

		for i = 1, 4 do
			local v48 = fn25(paletteItem, i)
			local convertColorNumberToProceduralRGB = module8.ConvertColorNumberToProceduralRGB(v48)
			mMovie:__wf_atom_1ca72041(
				data.mClipName .. ".Color" .. i .. ".Swatch",
				"TintColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			mMovie:SetCallbacks(
				data.mClipName .. ".Color" .. i,
				nil,
				"OnColorRollout",
				"OnColorReleased",
				"OnColorPressed"
			)
			mMovie:__wf_atom_e57658c2(data.mClipName .. ".Color" .. i, 100, data.mIndex * 10 + i)
		end
	end

	function v19.mOnFocusedCallback(_) end

	function v19.mOnUnfocusedCallback(_) end

	function v19.mOnSelectedCallback(_) end

	function v19.CanUseScrollBar(p)
		return p.mEnabled
	end

	if flag3 then
		mMovie:__wf_atom_7f57ab2f("CustomizationGrids.ColorSwatchList", "EmptyPaletteNotification", 13, false)
	else
		mMovie:__wf_atom_7f57ab2f("CustomizationGrids.ColorSwatchList", "EmptyPaletteNotification", 13, true)
		mMovie:__wf_atom_4c1c1986(
			"CustomizationGrids.ColorSwatchList",
			"EmptyPaletteNotification.Text",
			44,
			_G.UIColor_Gold
		)
		mMovie:__wf_atom_48bd5a59(
			"CustomizationGrids.ColorSwatchList",
			"EmptyPaletteNotification.Text",
			36,
			mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/NoPalettesNotice", false)
		)
	end

	v19:SetCallbacks()
	v19:Redraw(nil, true, true)
	fn34()
	fn33()
end

local function fn37()
	local __wf_atom_da43e3f3 = inventory:__wf_atom_da43e3f3()
	local mItemTypes = {}
	flag3 = false

	if not __wf_atom_7e8ad928(__wf_atom_da43e3f3) then
		for _, v48 in __wf_atom_da43e3f3 do
			if __wf_atom_7e8ad928(v48) or not v48.mItemType:IsA(WeakResource("/SF/Types/Items/ColorPickerItem")) then
				continue
			end

			flag3 = true
			table.insert(mItemTypes, v48.mItemType)
		end
	end

	fn36()
	asyncLoader:LoadMultipleResources("Palettes", mItemTypes, function()
		fn35(true)
	end)
end

local function fn38()
	return gRegion:IsMaster() and 3 or 4
end

local function fn39()
	if flag2 then
		return
	end

	if not __wf_atom_7e8ad928(_T.UIAvatar) then
		gRegion:__wf_atom_dd1e4d10(_T.UIAvatar)
	end

	v2 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_d9cb4b97 = v3:MotionControl():__wf_atom_d9cb4b97()
	uiAvatar = gRegion:CreateEntity(dummyAvatarType, v3:GetPosition(), __wf_atom_d9cb4b97, v2, v2, fn38())
	uiAvatar:SetFaction(v3:__wf_atom_e93896ba())
	uiAvatar:__wf_atom_4339a64c(false)
	uiAvatar:__wf_atom_3b7f7d6b(false)
	uiAvatar:__wf_atom_70f78a63(v3)
	uiAvatar:__wf_atom_51075230(__wf_atom_d9cb4b97)
	uiAvatar:Teleport(v3:GetPosition(), __wf_atom_d9cb4b97)
	uiAvatar:EnableFootIK(false)
	uiAvatar:__wf_atom_921c1a5f(idleAnim, false, 2, 2, true)
	module5.BuildLoadout(uiAvatar)
	uiAvatar:SetVisibility(true, true)
	heading = __wf_atom_d9cb4b97.heading
	v3:__wf_atom_a7ee9662(false)
	_T.UIAvatar = uiAvatar
	v = gRegion:__wf_atom_439c0d29(Symbol("WitchStationDeco_Rat"), v3:GetPosition(), 0, 1.1)
	v24 = gRegion:__wf_atom_f738b4af(Symbol("VerminiaNightfoldNpc"), v3:GetPosition(), 0, 10)
	v36 = true
end

local function fn40()
	v4 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	v3 = gRegion:__wf_atom_c4f78a8f()
	v4 = Resource("/Lotus/Types/Game/Store/ProductsManifest")
	inventory = gGameData:GetInventory()
	mCustSlot = inventory:__wf_atom_c132f79b(0, inventory:__wf_atom_d25917b6(0)):__wf_atom_b369d77f(0).mCustSlot
	v8 = gGameData:__wf_atom_a4299765():__wf_atom_d21f18f2(0, 0)
	v5 = v8.mItem:__wf_atom_eb82ab1f()
end

local function fn41(mItemType)
	if __wf_atom_7e8ad928(mItemType) or __wf_atom_7e8ad928(v4) then
		return nil
	end

	return v4:__wf_atom_232fd31d(mItemType)
end

local function fn42(data, data2)
	if fn16(data.Type) ~= fn16(data2.Type) then
		return fn16(data.Type)
	end

	if not (__wf_atom_7e8ad928(data.Owned) and __wf_atom_7e8ad928(data2.Owned)) and data.Owned ~= data2.Owned then
		return data.Owned
	end

	if
		not (__wf_atom_7e8ad928(data.AlwaysAvailable) and __wf_atom_7e8ad928(data2.AlwaysAvailable))
		and data.AlwaysAvailable ~= data2.AlwaysAvailable
	then
		return data.AlwaysAvailable
	end

	if not (__wf_atom_7e8ad928(data.SecondaryStatusIcon) or __wf_atom_7e8ad928(data2.SecondaryStatusIcon)) then
		return data.FullName > data2.FullName
	end

	if not __wf_atom_7e8ad928(data.SecondaryStatusIcon) then
		return true
	end

	if __wf_atom_7e8ad928(data2.SecondaryStatusIcon) then
		return data.FullName < data2.FullName
	end

	return false
end

local function fn43(object, p)
	return object:__wf_atom_717d3c58(p) or inventory:__wf_atom_a7f75274(object.mItemType, p)
end

local function fn44(className, p, p2)
	if __wf_atom_7e8ad928(v18) or __wf_atom_7e8ad928(p) then
		return
	end

	v12 = p2
	v18.PickerType = 7

	if not __wf_atom_7e8ad928(v12) then
		v7 = v5:__wf_atom_730958a3(v12)
	end

	v18:RemoveElements(true, true)
	local __wf_atom_71d5cc00 = inventory:__wf_atom_71d5cc00()
	local storeItemInfos = {}
	local v48 = {}

	for _, v49 in ipairs(__wf_atom_71d5cc00) do
		if not v49.mItemType:IsA(className) then
			continue
		end

		local v50 = fn41(v49.mItemType)

		if not v50:__wf_atom_e84d016c(p2) then
			continue
		end

		local storeItemInfo = module6.GetStoreItemInfo(mMovie, v50, { ItemInfo = v49 }, nil, nil, true)
		storeItemInfo.mItem = v49
		storeItemInfos[v49.mItemType:__wf_atom_5b41f63b()] = storeItemInfo
	end

	local __wf_atom_92ba339b = v4:__wf_atom_92ba339b(className)

	for _, v49 in ipairs(__wf_atom_92ba339b) do
		if __wf_atom_7e8ad928(v49) then
			continue
		end

		local weaponSkinInfo = SF.WeaponSkinInfo()
		weaponSkinInfo.mItemType = v49:GetItem()
		local storeItemInfo = module6.GetStoreItemInfo(mMovie, v49, { ItemInfo = weaponSkinInfo }, nil, nil, true)
		storeItemInfo.AlwaysAvailable = true
		storeItemInfo.mItem = weaponSkinInfo

		if not ((__wf_atom_7e8ad928(p.mItemType) or not p.mItemType:IsA(weaponSkinInfo.mItemType)) and v49:__wf_atom_e84d016c(p2)) then
			continue
		end

		storeItemInfos[weaponSkinInfo.mItemType:__wf_atom_5b41f63b()] = storeItemInfo
	end

	for _, v49 in pairs(storeItemInfos) do
		local mItem = v49.mItem

		if p.mItemType:IsA(v49.Type) then
			continue
		end

		if fn16(mItem.mItemType) then
			v49.Tint = 2827291
		end

		if fn43(mItem, 0) then
			v49.SecondaryStatusIcon = moonsteelIconTexture
			v49.CustomSecondaryStatus = true
		end

		table.insert(v48, v49)
	end

	table.sort(v48, fn42)

	for i = 1, #v48 do
		v18:AddElement(v48[i], true)
	end

	v18:Redraw(nil, true, true)
end

local function fn45()
	module5.ShowBackground({ mFade = module8.RIGHT_ALIGNED, mFadeSize = 0.5 })
	__wf_atom_ec43d06e(mMovie, "CustomizationGrids.GridContainer", 0, { 12 }, { 0 }, 0.3)
	_T.LiteModeBlocking = true
	_T.Dialog_PositionOverride = 1500
	_T.Dialog_BackerAlphaOverride = 90
end

local function fn46()
	module5.HideBackground()
	__wf_atom_ec43d06e(mMovie, "CustomizationGrids.GridContainer", 0, { 12 }, { 100 }, 0.3)
	_T.LiteModeBlocking = nil
	_T.Dialog_PositionOverride = nil
	_T.Dialog_BackerAlphaOverride = nil
end

function AwknowledgeInsufficientMoonsteel()
	fn46()
	RestorePreviousArmor()
end

local function fn47(__wf_atom_4177a1ad, p)
	local v48 = Resource(v11.Type)
	local __wf_atom_f80ff90a = v48:__wf_atom_f80ff90a(0)
	local __wf_atom_52fcdd65 = inventory:__wf_atom_52fcdd65(__wf_atom_f80ff90a)
	EquipItem(p, __wf_atom_4177a1ad, true)
	v6 = v5:__wf_atom_730958a3(p)
	local weaponSkinInfo = SF.WeaponSkinInfo()
	TransmogAsync(weaponSkinInfo, p)

	if __wf_atom_52fcdd65 <= 0 then
		fn45()
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.locString = "/SF/Language/ColourCustomisations/NotEnoughMoonsteelDialog"
		dialogSettings.titleString = "/Lotus/Language/Menu/PurchaseFailure_InsufficientFunds"
		dialogSettings:SetCallback(AwknowledgeInsufficientMoonsteel)
		module8.ShowCustomMessage(dialogSettings)
	else
		local __wf_atom_f80ff90a2 = v48:__wf_atom_f80ff90a(0)
		v38 = SF.UpgradeOperation()
		v38.mItemCategory = 6

		if v11.AlwaysAvailable then
			v38.mItemType = v11.Type
		else
			v38.mItemId:Parse(v11.UID)
		end

		local upgradeOperationItem = SF.UpgradeOperationItem()
		upgradeOperationItem.mOperationType = 0
		upgradeOperationItem.mUpgradeRequirement = __wf_atom_f80ff90a2
		v38:__wf_atom_a0a9fa7a(upgradeOperationItem)
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("<MOONSTEEL>" .. 1, true)
		local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v48:__wf_atom_014a76a2():c_str(), false)
		local colorHTMLMessage = module5.ColorHTMLMessage("/SF/Language/ColourCustomisations/UnlockTransmogDialog", {
			COST = __wf_atom_8e9ac384,
			ITEM = __wf_atom_8e9ac384_2
		})
		fn45()
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 1
		dialogSettings.locString = colorHTMLMessage
		dialogSettings.titleString = "/SF/Language/ColourCustomisations/UnlockTransmogTitle"
		dialogSettings:SetCallback(OnUnlockSkinConfirm)
		gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
	end
end

local function fn48()
	if __wf_atom_7e8ad928(v5) then
		return
	end

	if v5:GetColors(0):Initialized(0) then
		__wf_atom_f2daf912("complexion already set")
		return
	end

	fn8(nil, 6, 1, inventory:__wf_atom_3a61ed37():GetColor(0, 0))
end

local function fn49(state)
	fn48()
	local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(state.UID)
	__wf_atom_4177a1ad.mItemType = state.Type
	EquipItem(6, __wf_atom_4177a1ad, false)
	v9[6] = __wf_atom_4177a1ad
	v18.mRedrawFromScrollBar = true
	v18:Redraw(nil, true, true)
	fn9()
end

function HairSelected(data)
	if data.Owned or data.AlwaysAvailable then
		local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(data.UID)
		__wf_atom_4177a1ad.mItemType = data.Type
		EquipItem(4, __wf_atom_4177a1ad, false)
		v9[4] = __wf_atom_4177a1ad
		v10 = nil
	else
		if __wf_atom_7e8ad928(v10) then
			v10 = v5:__wf_atom_d78fd481(4)
		end

		local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(data.UID)
		__wf_atom_4177a1ad.mItemType = data.Type
		EquipItem(4, __wf_atom_4177a1ad, false)
	end

	v18.mRedrawFromScrollBar = true
	v18:Redraw(nil, true, true)
	fn9()
end

local function fn50()
	local module9 = require("EE.Interface.Components.ItemGrid")
	v18 = module9.Create(getfenv(1), "CustomizationGrids.GridContainer", {
		mColumns = 4,
		mCanSelectItem = true
	})
	v18.mEnabled = true
	v18.mVisRangeMaterials.SaleInfoBacker = Resource("/SF/Interface/Materials/VisibleRangeSaleInfoBacker")
	mMovie:__wf_atom_e57658c2("CustomizationGrids.GridContainer", 12, 0)
	v18:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/ChooseArmorShell", true))

	function v18:mOnSelectedCallback()
		if self.Unselectable or v37 or flag2 then
			return
		end

		if v18.PickerType == 4 then
			HairSelected(self)
			return
		end

		if v18.PickerType == 6 then
			fn49(self)
			return
		end

		v11 = self

		if module7.MarkItemIsNew(self, false) then
			v18.ITEM_UTIL.Update(mMovie, self.mClipName, self, v18)
			self.Refresh = true
		end

		local __wf_atom_4177a1ad = inventory:__wf_atom_4177a1ad(self.UID)
		__wf_atom_4177a1ad.mItemType = self.Type
		local v48 = fn43(__wf_atom_4177a1ad, 0)
		local __wf_atom_730958a3 = v5:__wf_atom_730958a3(v12)
		module8.PlaySound(OnBestitchConfirmSound)

		if
			__wf_atom_7e8ad928(__wf_atom_730958a3)
			or __wf_atom_7e8ad928(__wf_atom_730958a3.mItemType)
			or not __wf_atom_730958a3.mItemType:IsA(__wf_atom_4177a1ad.mItemType)
		then
			if v48 then
				TransmogAsync(__wf_atom_4177a1ad, v12)
			else
				v37 = true
				asyncLoader:LoadResource("AddFeature", v11.Type, function(_)
					v37 = false
					fn47(__wf_atom_4177a1ad, v12)
				end)
			end
		else
			RemoveBestitching()
		end

		fn9()
	end

	function v18.mOnDoubleClickCallback(p)
		if v18.PickerType ~= 4 or p.Owned or p.AlwaysAvailable then
			return
		end

		PurchaseHair(p)
	end

	function v18:mElementDrawCallback()
		if v18.PickerType == 4 or v18.PickerType == 6 then
			mMovie:__wf_atom_7f57ab2f(self.pClipName, "SecondaryStatusIconMini", 13, true)

			if not __wf_atom_7e8ad928(self.Type) then
				self.Equipped = self.Type:IsA(v9[v18.PickerType].mItemType)
			end
		elseif not (__wf_atom_7e8ad928(self.Type) or __wf_atom_7e8ad928(v7)) then
			if self.Type:IsA(v7.mItemType) then
				self.Equipped = true
			else
				self.Equipped = false
			end
		end
	end

	function v18.CanUseScrollBar(p)
		return p.mEnabled
	end
end

function Initialize()
	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(true)
	end

	mMovie:__wf_atom_a763aa1a(1)
	fn11(
		{
			"ColorCustomization.ArmourPickers",
			"ColorCustomization.CharacterCustomization",
			"CustomizationGrids.ColorSwatchList",
			"CustomizationGrids.GridContainer"
		},
		0
	)
	module5.RegisterHideHudSelective(true)
	module7.SetChatVisible(false)
	module7.SetConsumablesEnabled(false)

	if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
		__wf_atom_8e4fda44:__wf_atom_6a42bc9c(true)
	end

	fn40()
	fn50()
	v20.Inner = module8.ConvertColorNumberToProceduralRGB(2825751)
	v20.Edge = module8.ConvertColorNumberToProceduralRGB(1710626)
	fn7()
	fn37()
	fn24()
	fn22(99, true)
	mMovie:__wf_atom_2dedec1a("CraftingNode", 13, false)
	fn22(100, true)
	fn22(102, true)
	UpdateTitleBar()
	v3:__wf_atom_921c1a5f(idleAnim, false, 2, 1, false)
	fn6(true)
	__wf_atom_ec43d06e(mMovie, "avatar", 0, {}, {}, 0.5, 0, fn39)
	local module9 = require("Lotus.Interface.Libs.TimerMgr")
	v22 = module9.CreateTimerMgr()
	v23 = module2.Create(mMovie, true)
	v23:Register(mMovie, "CustomizationGrids", { v23.ANCHOR_V_TOP, v23.ANCHOR_H_RIGHT })
	v23:Register(mMovie, "ColorCustomization", { v23.ANCHOR_V_CENTRE, v23.ANCHOR_H_CENTRE })
	v23:Register(mMovie, "CraftingNode", { v23.ANCHOR_V_CENTRE, v23.ANCHOR_H_CENTRE })
	v23:Register(mMovie, "ColorNode", { v23.ANCHOR_V_CENTRE, v23.ANCHOR_H_CENTRE })
	v23:Register(mMovie, "CharacterNode", { v23.ANCHOR_V_CENTRE, v23.ANCHOR_H_CENTRE })
	v23:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	local v48 = Symbol("BestichingExplained")

	if not gGameData:__wf_atom_7f86fc42(v48) then
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.locString = "/SF/Language/ColourCustomisations/BestichingDesc"
		dialogSettings.titleString = "/SF/Language/ColourCustomisations/BestichingTitle"
		gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
		gGameData:__wf_atom_c9bb8504(v48)
	end

	mMovie:__wf_atom_40912f8e(true)
	fn9()
end

function UpdateTitleBar()
	local ancestorRank = module.GetAncestorRank(ancestorType)
	local v48 = (__wf_atom_7e8ad928(ancestorType) or __wf_atom_7e8ad928(_T.Foundry_GetRankXP) or not _T.Foundry_GetRankXP[ancestorType:__wf_atom_5b41f63b()])
		and 0
		or _T.Foundry_GetRankXP[ancestorType:__wf_atom_5b41f63b()]()
	local v49 = {
		mMovie = mMovie,
		mLevel = ancestorRank + 1,
		mRankProgress = __wf_atom_421b01aa(v48, 0, 1) * 100,
		mMinWidth = 600,
		mLabel = mMovie:__wf_atom_8e9ac384("/SF/Language/Characters/Verminia", false)
	}

	if v30 == v27.CHARACTER_CUSTOMIZATION then
		v49.mOverwriteCurrencies = false
	else
		v49.mOverwriteCurrencies = true
		local mCustomCurrencies = {}
		table.insert(mCustomCurrencies, {
			StoreItem = v4:__wf_atom_232fd31d(WeakResource("/SF/Types/Items/TransmogTokens/TransmogTokenTierA"))
		})
		v49.mCustomCurrencies = mCustomCurrencies
	end

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v49)
	end
end

function UpdateNodeColor(p, p2, p3)
	mMovie:__wf_atom_4c1c1986(p, "Fill", 11, not p3 and 10984574 or p2)
	mMovie:__wf_atom_4c1c1986(p, "Fill", 12, module8.Ternary(p3, 95, 80))
	mMovie:__wf_atom_4c1c1986(p, "Circle", 12, module8.Ternary(p3, 95, 80))
end

function onKeyDown_MENU_RIGHT_X(_, p)
	local v48 = tonumber(p)
	v46:__wf_atom_09294a87(math.abs(v48) < 0.2 and 0 or v48)
	return true
end

function onKeyUp_MENU_RIGHT_X(_, p)
	local v48 = tonumber(p)
	v46:__wf_atom_09294a87(math.abs(v48) < 0.2 and 0 or v48)
	return true
end

function onKeyDown_MENU_CLICK()
	local focus = mMovie:GetFocus()

	if not mMovie:__wf_atom_94bf489f() and focus == "" then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

		if __wf_atom_5e6e15c8 ~= -1000 and __wf_atom_5e6e15c8_2 ~= -1000 then
			v47 = __wf_atom_5e6e15c8
			flag4 = true
		end
	end
end

function onKeyUp_MENU_CLICK()
	flag4 = false
end

local function fn51(p)
	if not Engine.IsPlayingWithController() then
		if flag4 then
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("_root", 30)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("_root", 31)

			if __wf_atom_5e6e15c8 ~= -1000 and __wf_atom_5e6e15c8_2 ~= -1000 then
				v46:__wf_atom_09294a87((__wf_atom_5e6e15c8 - v47) * 0.2)
				v47 = __wf_atom_5e6e15c8
			end
		else
			v46:__wf_atom_09294a87(0)
		end
	end

	v46:Update(p)
	local __wf_atom_9e368823 = v46:__wf_atom_9e368823()

	if math.abs(__wf_atom_9e368823) > 0.0001 then
		heading -= __wf_atom_9e368823 * 1
		local v48 = Rotation(heading, 0, 0)
		heading = v48.heading

		if not __wf_atom_7e8ad928(uiAvatar) then
			uiAvatar:__wf_atom_51075230(v48)
		end
	end
end

function Update()
	local v48 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v48)

	if not __wf_atom_7e8ad928(v22) then
		v22:Update(v48)
	end

	fn32()

	if v40 > 0 then
		v40 -= v48
	end

	asyncLoader:Update()
	fn51(v48)

	if v35 and v36 then
		v35 = false

		if _T.Customization_InitialState == "Bestitch" then
			fn15(v27.COLOR_PICKER, 0)
		elseif _T.Customization_InitialState == "Character" then
			fn15(v27.CHARACTER_CUSTOMIZATION, 0)
		else
			fn15(v27.MODE_SELECTION, 0)
		end

		module5.DissolveIn(mMovie)
	end

	if v43 and not (v45 or v44) then
		v43 = false
		gGameData:__wf_atom_993aebc4(OnSaveLoadOutComplete)
	end
end

local function fn52()
	_T.ColorCustomization_OnColorChange = nil
	_T.ColorCustomization_OnClose = nil
	_T.ColorCustomization_OnBestitch = nil
	_T.LiteModeBlocking = nil
	_T.Dialog_PositionOverride = nil
	_T.Dialog_BackerAlphaOverride = nil
	_T.Customization_InitialState = nil
end

local function fn53()
	if not __wf_atom_7e8ad928(uiAvatar) then
		if not __wf_atom_7e8ad928(v3) then
			v3:__wf_atom_a7ee9662(true)
		end

		if uiAvatar == v3 then
			uiAvatar:__wf_atom_2f0092a2(Symbol("GAME_C1_HEAD1"), Rotation(0, 0, 0))
		else
			gRegion:__wf_atom_dd1e4d10(uiAvatar)
		end
	end
end

function Shutdown()
	flag2 = true

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_921c1a5f(nil, false, 2, 1, false)
	end

	if not __wf_atom_7e8ad928(_T.ColorCustomization_OnClose) then
		_T.ColorCustomization_OnClose()
	end

	if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
		__wf_atom_8e4fda44:__wf_atom_6a42bc9c(false)
	end

	module8.PlaySound(menuCloseSound)
	module7.SetChatVisible(true)
	module7.SetConsumablesEnabled(true)
	fn52()
	fn53()
	_T.gToolTip = nil
	module5.RegisterHideHudSelective(false)

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_411c9025(false)
	end
end

function OnUpgradeApplied(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	UpdateTitleBar()

	if p then
		if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v12)) then
			local mItem = v11.mItem
			local v48 = v26[v15][8]
			v6 = mItem
			RestorePreviousArmor(true)
			SelectArmor(v26[v15][7], v9[v48], v48)
		end
	else
		print("Failed to add feature:" .. p2)
		fn15(v27.COLOR_PICKER)
		RestorePreviousArmor()
	end
end

function OnUnlockSkinConfirm(p)
	fn46()

	if tonumber(p) == 4 then
		gGameData:__wf_atom_89191e2b(v38, OnUpgradeApplied)
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
	else
		fn()
		RestorePreviousArmor(true)
	end
end

local function fn54(p)
	v31 = p
	mMovie:__wf_atom_40912f8e(not p)
	fn33()
end

function Back()
	if v37 or flag2 then
		return
	end

	if not __wf_atom_7e8ad928(v10) then
		EquipItem(4, v10, false)
		v10 = nil
	end

	if v31 then
		v14 = nil
		fn11({ "CustomizationGrids.ColorSwatchList", "CustomizationGrids.GridContainer" }, 0.3)
		fn54(false)
		fn9()

		if not __wf_atom_7e8ad928(v41) then
			local v48 = v41
			v41 = nil
			BestichRollOut(v48, v42)
		end
	elseif v30 == v27.MODE_SELECTION then
		SaveAndClose()
	elseif __wf_atom_7e8ad928(_T.Customization_InitialState) then
		fn15(v27.MODE_SELECTION)
	else
		SaveAndClose()
	end
end

function SaveAndClose()
	flag2 = true

	if v30 == v27.CHARACTER_CUSTOMIZATION then
		RestorePreviousArmor(true)
	end

	v37 = true
	flag = true
	v43 = true
end

function FoundryClosed()
	fn37()
	fn24()
	fn15(v27.MODE_SELECTION)
end

function ForceClose()
	flag2 = true
	module5.DissolveOutAndClose(mMovie)
	fn6(false)
end

function OpenCraftingMovie()
	_T.Foundry_Ancestor = Resource("/SF/Types/Game/Ancestors/Verminia/VerminiaAncestor")
	_T.Foundry_AllowReforge = false
	_T.Foundry_IgnoreReforgeBlueprintRank = true
	_T.Foundry_NPC = "Verminia"
	mMovie:PushChildMovie(Resource("/SF/Interface/Foundry.swf"))
	fn15(v27.CRAFTING)
end

function CustomizeCharacter()
	fn15(v27.CHARACTER_CUSTOMIZATION)
	module8.PlaySound(customizationClickedSound)
	module8.PlaySound(customizationOpenSound)
end

function CustomizeColors()
	fn15(v27.COLOR_PICKER)
	module8.PlaySound(customizationClickedSound)
end

function ButtonBarRemoveBestitching()
	mMovie:Execute("RemoveBestitching", "")
end

function RemoveBestitching()
	if __wf_atom_7e8ad928(v12) then
		return
	end

	local weaponSkinInfo = SF.WeaponSkinInfo()
	TransmogAsync(weaponSkinInfo, v12)
end

function PurchaseHair(mSelectedElement)
	if __wf_atom_7e8ad928(mSelectedElement) then
		mSelectedElement = v18.mSelectedElement
	end

	if __wf_atom_7e8ad928(mSelectedElement) then
		return
	end

	local purchaseParams = SF.PurchaseParams()
	purchaseParams.mSource = 0
	purchaseParams.mSourceId = v4:__wf_atom_5b41f63b()
	purchaseParams.mStoreItem = mSelectedElement.StoreItem
	purchaseParams.mQuantity = 1
	purchaseParams.mSkipConfirm = false
	fn45()
	_T.DoPurchase(purchaseParams, function(p)
		fn46()

		if p ~= nil and not __wf_atom_7e8ad928(mMovie) and p then
			v10 = nil
			mSelectedElement.Owned = true
			mSelectedElement.Prices = nil
			HairSelected(mSelectedElement)
			UpdateTitleBar()
		end

		v18.mRedrawFromScrollBar = true
		v18:Redraw(nil, true, true)
	end)
end

function ResetColorsOnSlot()
	if not v36 or __wf_atom_7e8ad928(uiAvatar) or v37 or __wf_atom_7e8ad928(v13) then
		return
	end

	gGameData:__wf_atom_a4299765()

	if __wf_atom_7e8ad928(inventory) or __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v5) then
		inventory = gGameData:GetInventory()
		v8 = gGameData:__wf_atom_a4299765():__wf_atom_d21f18f2(0, 0)
		v5 = v8.mItem:__wf_atom_eb82ab1f()
	end

	v5:__wf_atom_e7be5998(v26[v13][5], uiAvatar)

	if v26[v13][1] == "SkinColor" then
		fn48()
	end

	v5:ApplyCustomization(uiAvatar, true)
	v8.mItem:SetCustomization(v5, mCustSlot)
	inventory:__wf_atom_fe6304ae(v8.mItem.mItemId.mId, mCustSlot, v5)
	fn24()
	module8.PlaySound(resetCustomizationSound)
end

function ResetCustomisationsConfirmed(p)
	if tonumber(p) ~= 4 or (not v36 or __wf_atom_7e8ad928(uiAvatar) or v37) then
		return
	end

	gGameData:__wf_atom_a4299765()

	if __wf_atom_7e8ad928(inventory) or __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v5) then
		inventory = gGameData:GetInventory()
		v8 = gGameData:__wf_atom_a4299765():__wf_atom_d21f18f2(0, 0)
		v5 = v8.mItem:__wf_atom_eb82ab1f()
	end

	if v30 == v27.COLOR_PICKER then
		v5:__wf_atom_e7be5998(v26[1][5], uiAvatar)
		v5:__wf_atom_e7be5998(v26[2][5], uiAvatar)
		v5:__wf_atom_e7be5998(v26[3][5], uiAvatar)
		v5:__wf_atom_e7be5998(v26[4][5], uiAvatar)
		local weaponSkinInfo = SF.WeaponSkinInfo()
		TransmogAsync(weaponSkinInfo, 0)
		local weaponSkinInfo2 = SF.WeaponSkinInfo()
		TransmogAsync(weaponSkinInfo2, 2)
		local weaponSkinInfo3 = SF.WeaponSkinInfo()
		TransmogAsync(weaponSkinInfo3, 3)
	else
		v5:__wf_atom_e7be5998(v26[5][5], uiAvatar)
		v5:__wf_atom_e7be5998(v26[6][5], uiAvatar)
		v5:__wf_atom_e7be5998(v26[7][5], uiAvatar)
	end

	v5:ApplyCustomization(uiAvatar, true)
	v8.mItem:SetCustomization(v5, mCustSlot)
	inventory:__wf_atom_fe6304ae(v8.mItem.mItemId.mId, mCustSlot, v5)
	fn24()

	if v30 == v27.CHARACTER_CUSTOMIZATION then
		fn48()
	end

	module8.PlaySound(resetCustomizationSound)
end

function ResetCustomisations()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/SF/Language/ColourCustomisations/ResetAllConfirmation"
	dialogSettings.titleString = "/SF/Language/ColourCustomisations/ResetAll"
	dialogSettings:SetCallback(ResetCustomisationsConfirmed)
	gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings)
end

function OnSaveLoadOutComplete(p, _)
	if p then
		fn24()
	end

	v37 = false
	module4.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	module4.RequestLoadOutBuild(v2)

	if flag then
		ForceClose()
	end
end

local function fn55(p, p2, p3, callback)
	if not p3 then
		fn()
	end

	v22:AddTimer(0.5, function()
		if __wf_atom_7e8ad928(uiAvatar) then
			return
		end

		v5:__wf_atom_da712d9e(p, p2)
		v5:ApplyCustomization(uiAvatar, true)
		v8.mItem:SetCustomization(v5, mCustSlot)
		inventory:__wf_atom_fe6304ae(v8.mItem.mItemId.mId, mCustSlot, v5)
		local __wf_atom_d2b2176d = uiAvatar:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_e55d02aa():SetCustomization(v5)
		__wf_atom_d2b2176d:__wf_atom_da1b89a8()
		__wf_atom_d2b2176d:Update(0)

		if not __wf_atom_7e8ad928(p.mItemType) and fn16(p.mItemType) and not p3 then
			fn2(Symbol("FashionReactUndies"))
		end

		if not __wf_atom_7e8ad928(v12) then
			v7 = v5:__wf_atom_730958a3(v12)
		end

		v18:Redraw(nil, true, true)
		fn9()
		v45 = false

		if not __wf_atom_7e8ad928(callback) then
			callback()
		end
	end)
end

function TransmogAsync(p, p2, p3, callback)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	v45 = true
	local __wf_atom_730958a3 = v5:__wf_atom_730958a3(p2)

	if
		__wf_atom_7e8ad928(__wf_atom_730958a3)
		or __wf_atom_730958a3.mItemId ~= p.mItemId
		or __wf_atom_730958a3.mItemType ~= p.mItemType
	then
		if __wf_atom_7e8ad928(p.mItemType) then
			fn55(p, p2, p3, callback)
			return
		end

		v37 = true
		asyncLoader:LoadResource("TransmogAsync" .. p2, p.mItemType, function(_)
			v37 = false
			fn55(p, p2, p3, callback)

			if not __wf_atom_7e8ad928(v18) then
				v18.mRedrawFromScrollBar = true
				v18:Redraw(nil, true, true)
			end
		end)
	else
		if not __wf_atom_7e8ad928(callback) then
			callback()
		end

		v45 = false
	end
end

function EquipItem(p, p2, p3)
	if
		__wf_atom_7e8ad928(p)
		or __wf_atom_7e8ad928(p2)
		or __wf_atom_7e8ad928(p2.mItemType)
		or __wf_atom_7e8ad928(uiAvatar)
	then
		return
	end

	v44 = true
	asyncLoader:LoadResource("EquipItem" .. p, p2.mItemType, function(_)
		local function fn56()
			v5:__wf_atom_b6072b05(p2, p)
			v5:ApplyCustomization(uiAvatar, true)
			v8.mItem:SetCustomization(v5, mCustSlot)
			inventory:__wf_atom_fe6304ae(v8.mItem.mItemId.mId, mCustSlot, v5)
			local __wf_atom_d2b2176d = uiAvatar:__wf_atom_d2b2176d()
			__wf_atom_d2b2176d:__wf_atom_e55d02aa():SetCustomization(v5)
			__wf_atom_d2b2176d:__wf_atom_da1b89a8()
			__wf_atom_d2b2176d:Update(0)
			v44 = false
		end

		if p3 then
			v22:AddTimer(0.5, fn56)
		else
			fn56()
		end
	end)

	if p3 then
		fn()
	end
end

function SelectArmor(p, p2, p3)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(inventory) then
		return
	end

	fn54(true)
	v11 = nil
	v14 = nil
	v18:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/ChooseArmorShell", true))
	fn44(p, p2, p3)
	fn9()
end

function EquipPreviousArmor()
	EquipItem(0, v9[0], false)
	EquipItem(2, v9[2], false)
	EquipItem(3, v9[3], false)
end

function RestorePreviousArmor(p)
	TransmogAsync(v6, v12, p, EquipPreviousArmor)
end

function ColorNodeRollOver(p)
	local v48, v49 = GetColorNodeClipById(p)
	mMovie:__wf_atom_4c1c1986(v48, "Circle", 11, 14524216)
	module8.PlaySound(_G.UISound_Focus)
	__wf_atom_ec43d06e(mMovie, v48 .. ".PipGlow", 0, { 12 }, { 30 }, 0.3)
	__wf_atom_ec43d06e(mMovie, v48, 2, { 5, 6 }, { 110, 110 }, 0.3)
	__wf_atom_ec43d06e(mMovie, v49 .. ".Shadow", 0, { 12 }, { 90 }, 0.34)
end

function ColorNodeRollOut(p)
	local v48, v49 = GetColorNodeClipById(p)
	mMovie:__wf_atom_4c1c1986(v48, "Circle", 11, 8152122)
	__wf_atom_ec43d06e(mMovie, v48 .. ".PipGlow", 0, { 12 }, { 0 }, 0.1)
	__wf_atom_ec43d06e(mMovie, v48, 1, { 5, 6 }, { 100, 100 }, 0.1)
	__wf_atom_ec43d06e(mMovie, v49 .. ".Shadow", 0, { 12 }, { 30 }, 0.34)
end

function ColorNodeClicked(p)
	if not v36 or flag2 then
		return
	end

	if not __wf_atom_7e8ad928(v41) then
		local v48 = v41
		v41 = nil
		BestichRollOut(v48, v42)
	end

	v18.PickerType = nil
	fn54(true)
	fn11({ "CustomizationGrids.GridContainer" })
	fn12({ "CustomizationGrids.ColorSwatchList" }, 0.3)

	if p >= 50 then
		fn15(v27.CHARACTER_CUSTOMIZATION)
	else
		fn15(v27.COLOR_PICKER)
	end

	v13 = math.floor(p / 10)
	v14 = p % 10

	if v26[v13][1] == "SkinColor" then
		fn35(false, complexionsPalettes)
	elseif v26[v13][1] == "EyeColor" then
		if v25[v14] == "/SF/Language/ColourCustomisations/EyelashColour" then
			fn35(false, defaultHairPalettes)
		else
			fn35(false, eyeColorPalettes)
		end
	elseif v26[v13][1] == "Hair" then
		fn35(false, defaultHairPalettes)
	else
		fn35(true)
	end

	fn34()
	fn33()
	fn9()
	module8.PlaySound(colourNodeClickedSound)
end

function NodeRollOver(p)
	local v48 = fn17(p)

	if not __wf_atom_7e8ad928(v32) then
		fn19(v32)
	end

	v32 = p
	local v49

	if p == 100 and not flag3 then
		_T.gToolTip = mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/NoPalettesNotice", false)
		v49 = 70
	else
		v49 = 100
	end

	mMovie:__wf_atom_7f57ab2f(v48, "Details", 67, true)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Details", 0, { 12 }, { 100 }, 0.3)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Label", 0, { 12 }, { v49 }, 0.3)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Button", 0, { 12 }, { v49 }, 0.3)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Shadow", 0, { 12 }, { 90 }, 0.34)
	mMovie:__wf_atom_4c1c1986(v48, "LockIndicator.Lock", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_4c1c1986(v48, "LockIndicator.Circle", 11, _G.UIColor_Yellow)
	__wf_atom_ec43d06e(mMovie, v48 .. ".SideLabel", 8, { 5, 6 }, { 105, 105 }, 0.3)

	if v21[v48 .. ".Hover"] == 20 then
		__wf_atom_ec43d06e(mMovie, v48 .. ".Hover", 0, { function(_) end }, { 1 }, 0.001)
	else
		__wf_atom_ec43d06e(mMovie, v48 .. ".Virtues.Hover", 0, { function(p2)
				fn18(v48 .. ".Hover", p2, 9, 20)
				mMovie:__wf_atom_e57658c2(
					v48 .. ".Hover",
					5,
					0.35 * __wf_atom_104bfe98(90, 100, __wf_atom_24a82b69(p2))
				)
				mMovie:__wf_atom_e57658c2(
					v48 .. ".Hover",
					6,
					0.35 * __wf_atom_104bfe98(90, 100, __wf_atom_24a82b69(p2))
				)
				mMovie:__wf_atom_e57658c2(v48 .. ".Hover", 12, __wf_atom_104bfe98(85, 100, p2))
			end }, { 1 }, 0.34)
	end

	module8.PlaySound(_G.UISound_Focus)
end

function NodeRollOut(_)
	_T.gToolTip = nil

	if not __wf_atom_7e8ad928(v32) then
		fn19(v32)
		v32 = nil
	end

	module8.PlaySound(_G.UISound_Unfocus)
end

function SelectHead(p, p2)
	module8.PlaySound(customizationClickedSound)

	if __wf_atom_7e8ad928(v18) or __wf_atom_7e8ad928(uiAvatar) or v37 or flag2 then
		return
	end

	if not __wf_atom_7e8ad928(v41) then
		local v48 = v41
		v41 = nil
		BestichRollOut(v48, v42)
	end

	v41 = p
	v42 = p2
	v14 = nil

	if v31 and v18.PickerType == 6 then
		fn11({ "CustomizationGrids.ColorSwatchList", "CustomizationGrids.GridContainer" }, 0.3)
		fn54(false)
	else
		fn54(true)
		fn11({ "CustomizationGrids.ColorSwatchList" })
		fn12({ "CustomizationGrids.GridContainer" }, 0.3)
		v18:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/ChangeHead", true))
		v18.PickerType = 6
		local ternary = module8.Ternary(
			uiAvatar:__wf_atom_f115b657(),
			WeakResource("/SF/Upgrades/Skins/Head/BaseFemaleHead"),
			WeakResource("/SF/Upgrades/Skins/Head/BaseMaleHead")
		)
		v18:RemoveElements(true, true)
		local __wf_atom_71d5cc00 = inventory:__wf_atom_71d5cc00()
		local storeItemInfos = {}

		for _, v48 in ipairs(__wf_atom_71d5cc00) do
			if not v48.mItemType:IsA(ternary) then
				continue
			end

			local v49 = fn41(v48.mItemType)

			if __wf_atom_7e8ad928(v49) then
				continue
			end

			local storeItemInfo = module6.GetStoreItemInfo(mMovie, v49, { ItemInfo = v48 }, nil, nil, true)
			storeItemInfo.mItem = v48
			table.insert(storeItemInfos, storeItemInfo)
		end

		local __wf_atom_92ba339b = v4:__wf_atom_92ba339b(ternary)

		for _, v48 in ipairs(__wf_atom_92ba339b) do
			if __wf_atom_7e8ad928(v48) then
				continue
			end

			local weaponSkinInfo = SF.WeaponSkinInfo()
			weaponSkinInfo.mItemType = v48:GetItem()
			local storeItemInfo = module6.GetStoreItemInfo(mMovie, v48, {
				ItemInfo = weaponSkinInfo
			}, nil, nil, true)
			storeItemInfo.AlwaysAvailable = true
			table.insert(storeItemInfos, storeItemInfo)
		end

		table.sort(storeItemInfos, fn42)

		for i = 1, #storeItemInfos do
			v18:AddElement(storeItemInfos[i], true)
		end

		v18:Redraw(nil, true, true)
		fn9()
	end
end

function SwapBodyType()
	if v37 or flag2 or __wf_atom_7e8ad928(uiAvatar) then
		return
	end

	module8.PlaySound(customizationClickedSound)
	fn54(false)
	fn11({ "CustomizationGrids.GridContainer", "CustomizationGrids.ColorSwatchList" })
	local v48 = not uiAvatar:__wf_atom_f115b657()

	if not __wf_atom_7e8ad928(uiAvatar) then
		uiAvatar:__wf_atom_72cd7949(v48)
	end

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_72cd7949(v48)
	end

	gGameData:__wf_atom_575ed439(v48)
	local ternary = module8.Ternary(
		v48,
		WeakResource("/SF/Upgrades/Skins/Head/BaseFemaleHead"),
		WeakResource("/SF/Upgrades/Skins/Head/BaseMaleHead")
	)
	local __wf_atom_92ba339b = v4:__wf_atom_92ba339b(ternary)

	for _, v49 in ipairs(__wf_atom_92ba339b) do
		if __wf_atom_7e8ad928(v49) then
			continue
		end

		local weaponSkinInfo = SF.WeaponSkinInfo()
		weaponSkinInfo.mItemType = v49:GetItem()
		EquipItem(6, weaponSkinInfo, false)
		break
	end
end

function StartBestitch(p, p2)
	if not __wf_atom_7e8ad928(v41) then
		local v48 = v41
		v41 = nil
		BestichRollOut(v48, v42)
	end

	v41 = p
	v42 = p2
	NodeClicked(p)
end

function BestichRollOver(p, p2)
	module8.PlaySound(_G.UISound_Focus)
	__wf_atom_ec43d06e(mMovie, p2, 8, { 12, 5, 6 }, { 100, 34, 34 }, 0.3)
	local v48 = fn17(p)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Button", 8, { 12 }, { 80 }, 0.3)
end

function BestichRollOut(p, p2)
	if p == v41 then
		return
	end

	__wf_atom_ec43d06e(mMovie, p2, 8, { 12, 5, 6 }, { 50, 30, 30 }, 0.3)
	local v48 = fn17(p)
	__wf_atom_ec43d06e(mMovie, v48 .. ".Button", 8, { 12 }, { 0 }, 0.3)
end

function SelectHair(p, p2)
	module8.PlaySound(customizationClickedSound)

	if __wf_atom_7e8ad928(v18) then
		return
	end

	if not __wf_atom_7e8ad928(v41) then
		local v48 = v41
		v41 = nil
		BestichRollOut(v48, v42)
	end

	v41 = p
	v42 = p2
	v14 = nil

	if v31 and v18.PickerType == 4 then
		fn11({ "CustomizationGrids.ColorSwatchList", "CustomizationGrids.GridContainer" }, 0.3)
		fn54(false)
	else
		fn54(true)
		fn11({ "CustomizationGrids.ColorSwatchList" })
		fn12({ "CustomizationGrids.GridContainer" }, 0.3)
		v18:SetTitle(mMovie:__wf_atom_8e9ac384("/SF/Language/ColourCustomisations/ChangeHair", true))
		v18.PickerType = 4
		local v48 = WeakResource("/SF/Upgrades/Skins/Hair/BaseEquipHair")
		v18:RemoveElements(true, true)
		local purchasedItems = module6.GetPurchasedItems(v4, inventory)
		local __wf_atom_71d5cc00 = inventory:__wf_atom_71d5cc00()
		local storeItemInfos = {}
		local v49 = {}

		for _, v50 in ipairs(__wf_atom_71d5cc00) do
			if not v50.mItemType:IsA(v48) then
				continue
			end

			local storeItem = v4:GetStoreItem(v50.mItemType)

			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local weaponSkinInfo = SF.WeaponSkinInfo()
			weaponSkinInfo.mItemType = storeItem:GetItem()
			local storeItemInfo = module6.GetStoreItemInfo(
				mMovie,
				storeItem,
				{ ItemInfo = weaponSkinInfo },
				nil,
				nil,
				true
			)
			storeItemInfo.Owned = true
			storeItemInfo.AlwaysAvailable = false
			table.insert(storeItemInfos, storeItemInfo)
			v49[storeItemInfo.FullName] = true
		end

		local __wf_atom_92ba339b = v4:__wf_atom_92ba339b(v48)

		for _, v50 in ipairs(__wf_atom_92ba339b) do
			if __wf_atom_7e8ad928(v50) then
				continue
			end

			local weaponSkinInfo = SF.WeaponSkinInfo()
			weaponSkinInfo.mItemType = v50:GetItem()
			local storeItemInfo = module6.GetStoreItemInfo(mMovie, v50, {
				ItemInfo = weaponSkinInfo
			}, nil, nil, true)
			storeItemInfo.Owned = false
			storeItemInfo.AlwaysAvailable = true

			if v49[storeItemInfo.FullName] then
				continue
			end

			table.insert(storeItemInfos, storeItemInfo)
			v49[storeItemInfo.FullName] = true
		end

		local v50 = v4:__wf_atom_caa82b8d(v48) or {}

		for _, v51 in ipairs(v50) do
			if __wf_atom_7e8ad928(v51) then
				continue
			end

			local weaponSkinInfo = SF.WeaponSkinInfo()
			weaponSkinInfo.mItemType = v51:GetItem()
			local storeItemInfo = module6.GetStoreItemInfo(mMovie, v51, {
				ItemInfo = weaponSkinInfo
			}, nil, nil, true)
			storeItemInfo.Owned = false
			storeItemInfo.AlwaysAvailable = false
			local storeItemPriceObject = module4.GetStoreItemPriceObject(v51, nil, purchasedItems)
			storeItemInfo.MetaData = { SmallPriceMode = true }

			if __wf_atom_7e8ad928(storeItemPriceObject) or not storeItemPriceObject.ShowInMarket then
				continue
			end

			storeItemInfo.Prices = storeItemPriceObject

			if v49[storeItemInfo.FullName] then
				continue
			end

			table.insert(storeItemInfos, storeItemInfo)
			v49[storeItemInfo.FullName] = true
		end

		table.sort(storeItemInfos, fn42)

		for i = 1, #storeItemInfos do
			v18:AddElement(storeItemInfos[i], true)
		end

		v18:Redraw(nil, true, true)
		fn9()
	end
end

function NodeClicked(p)
	local v48 = v26[p][8]

	if __wf_atom_7e8ad928(v48) then
		return
	end

	if v31 and v15 == p and v18.PickerType == 7 then
		fn11({ "CustomizationGrids.ColorSwatchList", "CustomizationGrids.GridContainer" }, 0.3)
		fn54(false)
	else
		module8.PlaySound(_G.UISound_Select)
		v15 = p
		fn54(true)
		fn12({ "CustomizationGrids.GridContainer" }, 0.3)
		fn11({ "CustomizationGrids.ColorSwatchList" })
		v14 = nil
		fn33()
		SelectArmor(v26[p][7], v9[v48], v48)
	end
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v23) then
		v23:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), true)
	end

	if v18 ~= nil then
		v18:UpdateHeight(nil, true)
		v18:RefreshCategory()
	end
end

function onKeyUp_MENU_CANCEL()
	Back()
end

function GetTintFromNumber(p)
	if p == 1 then
		return 0
	elseif p == 2 then
		return 1
	elseif p == 3 then
		return 2
	elseif p == 4 then
		return 3
	elseif p == 5 then
		return 6
	end

	return 0
end