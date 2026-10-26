module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.CardUtilitiesRedux")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local module5 = require("Lotus.Interface.CodexUtilities")
local module6 = require("Lotus.Interface.StoreItemUtilities")
local v = {
	Symbol("MaskingPlane0"),
	Symbol("MaskingPlane1"),
	Symbol("MaskingPlane2"),
	Symbol("MaskingPlane3")
}
local v2 = { Vector(), Vector(), Vector(), Vector() }
local _ = { 1, 0, 5, 16, 28, 29 }
local _ = { 3, 15, 27 }
local v3 = WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")
local v4 = WeakResource("/Lotus/Upgrades/Mods/Fusers/LegendaryModFuser")
local v5 = WeakResource("/Lotus/Interface/ItemInfoPopup.swf")
local v6 = WeakResource("/Lotus/Weapons/CrewShip/RailjackWeapon")
local v7 = WeakResource("/SF/Types/Game/CrewShipCustomization")
local v8 = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseMod")
local v9 = {
	WeakResource("/Lotus/Interface/Friends.swf"),
	WeakResource("/Lotus/Interface/Clan.swf"),
	WeakResource("/Lotus/Interface/Settings.swf"),
	WeakResource("/Lotus/Interface/Profile.swf"),
	WeakResource("/Lotus/Interface/ControllerLayoutPS4.swf"),
	WeakResource("/Lotus/Interface/ControllerLayoutPS5.swf"),
	WeakResource("/Lotus/Interface/ControllerLayoutRemotePlay.swf"),
	WeakResource("/Lotus/Interface/ControllerLayoutSwitch.swf"),
	WeakResource("/Lotus/Interface/ControllerLayoutXbone.swf"),
	WeakResource("/Lotus/Interface/StyleManager.swf"),
	WeakResource("/Lotus/Interface/InputBinding.swf")
}
local v10 = {
	false,
	false,
	false,
	false,
	false,
	true,
	true,
	true,
	true,
	true,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	true,
	true,
	false
}
local v11 = {
	InitLabelWidth = 25,
	ItemDimensions = { Width = 232, Height = 162 }
}
LABEL_TYPE_CREDITS = 1
LABEL_TYPE_PLATINUM = 2
LABEL_TYPE_CHECKMARK = 3
LABEL_TYPE_STEAM = 4
LABEL_TYPE_PREVIEW = 5
LABEL_TYPE_REPUTATION = 6
LABEL_TYPE_DUCATS = 7
LABEL_TYPE_PRIMETOKENS = 8
LABEL_TYPE_TIMER = 9
LABEL_TYPE_OSTRON_ITEM = 10
LABEL_TYPE_MISC_ITEM = 11
LABEL_TYPE_FOCUS = 12
LABEL_TYPE_ENDO = 13
LABEL_TYPE_RESEARCHED = 14
LABEL_TYPE_CLAN_XP = 15
LABEL_TYPE_CRAFTED = 16
LABEL_TYPE_RECIPES = 17
LABEL_TYPE_UNIQUE_TEXT = 18
LABEL_TYPE_NEW = 19
LABEL_TYPE_RECOMMENDED = 20
LABEL_TYPE_LIMITED = 21
LABEL_TYPE_SALE = 22
LABEL_TYPE_UPGRADE = 23
LABEL_TYPE_PAUSED = 24
LABEL_TYPE_MASTERY = 25
LABEL_TYPE_POLARIZED = 26
LABEL_TYPE_TRADEABLE = 27
LABEL_TYPE_CATALYST = 28
LABEL_TYPE_REACTOR = 29
LABEL_TYPE_WEAPON_EXILUS = 30
LABEL_TYPE_POWERSUIT_EXILUS = 31
LABEL_TYPE_PRIMARY_ADAPTER = 32
LABEL_TYPE_SECONDARY_ADAPTER = 33
LABEL_TYPE_FOCUS_LENS = 34
LABEL_TYPE_GILD = 35
LABEL_TYPE_REQUIRED_MASTERY = 36
LABEL_TYPE_REUSABLE_BLUEPRINT = 37
LABEL_TYPE_RIGHT_TEXT = 38
LABEL_TYPE_LOCK = 39
LABEL_TYPE_DISCORD = 40
LABEL_TYPE_FAVORITE = 41
LABEL_TYPE_CAMERA = 42
LABEL_TYPE_CREW_SHIP_FUSION_POINTS = 43
LABEL_TYPE_ARCANE_REPROC = 44
LABEL_TYPE_EPIC = 45
LABEL_TYPE_CONTRIBUTE = 46
LABEL_TYPE_PREMIUM = 47
LABEL_TYPE_GIFTABLE = 48
LABEL_TYPE_IN_PROGRESS = 49
LABEL_TYPE_UGC = 50
LABEL_TYPE_BUNDLE = 51
LABEL_TYPE_ARCHON_SHARDS = 52
LABEL_TYPE_MASTERY_UNLOCKED = 53
LABEL_TYPE_COUPON = 54
LABEL_TYPE_IOS = 55
PQ_FIRST_LAYER = 300
PQ_LAST_LAYER = 315
TOUCH_TOOLTIP_DELAY = 0.125
local v12 = {
	{
		IconPos = { X = 3, Y = 2 },
		IconDims = { W = 22, H = 22 },
		ShowInGrid = true,
		UseFullLabel = true,
		ExcludeFromInfoPopup = true
	},
	{
		IconPos = { X = 0, Y = 1 },
		GridIconPos = { X = 7, Y = 3 },
		IconDims = { W = 25, H = 25 },
		GridIconDims = { W = 21, H = 21 },
		GridBgColor = 2,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		SkipTitleCase = true,
		IconTintLabelColor = true,
		IconPos = { X = 5, Y = 1 },
		IconDims = { W = 24, H = 24 },
		BgColor = 2,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		SkipTitleCase = true,
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 25, H = 25 },
		ShowInGrid = false,
		UseFullLabel = true
	},
	{ LabelPrefix = "<PREVIEW>", LabelOffset = 2, ShowInGrid = true, UseFullLabel = true },
	{ LabelPrefix = "<REPUTATION>", LabelOffset = 2, UseFullLabel = true },
	{ LabelPrefix = "<PRIME_BUCKS>", LabelOffset = 2, ShowInGrid = true, UseFullLabel = true },
	{ LabelPrefix = "<PRIME_TOKEN>", LabelOffset = 2, ShowInGrid = true, UseFullLabel = true },
	{
		IconPos = { X = 3, Y = 2 },
		IconDims = { W = 24, H = 24 },
		IconTintLabelColor = true,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{ LabelPrefix = "<OSTRON_PRICE>", LabelOffset = 2, UseFullLabel = true },
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 40, H = 25 },
		LabelOffset = 38,
		UseFullLabel = true
	},
	{ LabelPrefix = "<FOCUS>", LabelOffset = 2, UseFullLabel = true },
	{ LabelPrefix = "<FUSION_POINTS>", LabelOffset = 2, ShowInGrid = true, UseFullLabel = true },
	{
		IconPos = { X = 0, Y = -3 },
		IconDims = { W = 32, H = 32 },
		IconTintLabelColor = true,
		LabelColor = 10,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconPos = { X = 0, Y = -3 },
		IconDims = { W = 32, H = 32 },
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 32, H = 32 },
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 32, H = 32 },
		UseFullLabel = true
	},
	{ LabelOffset = 0, UseFullLabel = true },
	{
		SkipTitleCase = true,
		IconTintLabelColor = true,
		IconPos = { X = 1, Y = -2 },
		IconDims = { W = 32, H = 32 },
		GridBgColor = 2,
		GridBgHeightOffset = 2,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 32, H = 32 },
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		SkipTitleCase = true,
		IconTintLabelColor = true,
		IconPos = { X = 7, Y = 4 },
		IconDims = { W = 20, H = 20 },
		GridBgColor = 2,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 5, Y = 1 },
		IconDims = { W = 24, H = 24 },
		GridBgColor = 2,
		ShowInGrid = false,
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 7, Y = 4 },
		IconDims = { W = 30, H = 30 },
		ExcludeFromInfoPopup = true,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconPos = { X = 3, Y = 1 },
		IconDims = { W = 24, H = 24 },
		IconTintLabelColor = true,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconPos = { X = -10, Y = -11 },
		IconDims = { W = 50, H = 50 }
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 28, H = 28 },
		IconTextPos = { X = 24, Y = 3 },
		IconTextColor = 9
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 6, Y = 5 },
		IconDims = { W = 20, H = 20 }
	},
	{
		IconPos = { X = 0, Y = -2 },
		IconDims = { W = 32, H = 32 }
	},
	{
		IconPos = { X = 0, Y = -2 },
		IconDims = { W = 32, H = 32 }
	},
	{
		IconPos = { X = 0, Y = -2 },
		IconDims = { W = 32, H = 32 }
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 40, H = 25 }
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 32, H = 32 }
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 32, H = 32 }
	},
	{ LabelOffset = 0 },
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 28, H = 28 }
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 28, H = 28 },
		IconTextPos = { X = 21, Y = 3 },
		IconTextColor = 9
	},
	{
		RightAlign = true,
		IconTintLabelColor = true,
		IconDims = { W = 24, H = 24 },
		IconPos = { X = -4, Y = 1 },
		BgWidth = 30,
		BgColor = 2,
		ExcludeFromInfoPopup = true,
		PopUpLabel = "/Lotus/Language/Menu/Blueprint_UnlimitedCharges",
		ShowInGrid = true
	},
	{ LabelOffset = -200, LabelAlignment = "right", MaxWidth = 220, MultiLine = true },
	{
		IconTintLabelColor = true,
		IconPos = { X = 4, Y = 3 },
		IconDims = { W = 22, H = 22 },
		ShowInGrid = true
	},
	{
		IconTintLabelColor = true,
		SkipTitleCase = true,
		IconPos = { X = 4, Y = 3 },
		IconDims = { W = 22, H = 22 }
	},
	{
		RightAlign = true,
		IconTintLabelColor = true,
		IconDims = { W = 24, H = 24 },
		IconPos = { X = 3, Y = 0 },
		GridIconPos = { X = -4, Y = 1 },
		BgWidth = 30,
		CallbackPrefix = "FavoriteTag",
		PopUpLabel = "/Lotus/Language/SystemMessages/Favorite",
		ShowInGrid = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 9, Y = 9 },
		IconDims = { W = 36, H = 36 },
		ShowInGrid = true
	},
	{ LabelPrefix = "<CREW_SHIP_FUSION_POINTS>", LabelOffset = 2 },
	{ LabelPrefix = "<ARCANE_CAN_REPROC>", LabelOffset = 2 },
	{
		IconTintLabelColor = true,
		SkipTitleCase = true,
		IconPos = { X = 4, Y = 3 },
		IconDims = { W = 22, H = 22 }
	},
	{
		IconPos = { X = 3, Y = 1 },
		IconDims = { W = 24, H = 24 },
		IconTintLabelColor = true,
		ShowInGrid = true
	},
	{
		RightAlign = true,
		IconDims = { W = 24, H = 24 },
		IconPos = { X = 1, Y = 1 },
		GridIconPos = { X = -4, Y = 2 },
		BgWidth = 31,
		GridBgHeightOffset = 2,
		IconTintLabelColor = true,
		mShowItemPrice = true
	},
	{
		RightAlign = true,
		IconDims = { W = 36, H = 36 },
		IconTintLabelColor = true,
		IconPos = { X = -2, Y = -4 }
	},
	{ LabelPrefix = "<IN_PROGRESS>", LabelOffset = 2, ShowInGrid = true },
	{
		SkipTitleCase = true,
		RightAlign = true,
		IconDims = { W = 24, H = 24 },
		IconPos = { X = 1, Y = 1 },
		GridIconPos = { X = -4, Y = 2 },
		BgWidth = 31,
		GridBgHeightOffset = 2,
		PopUpLabel = "/Lotus/Language/Menu/Store_Tennogen",
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconDims = { X = 0, Y = 0 },
		GridIconPos = { X = 4, Y = 0 },
		GridIconDims = { W = 28, H = 28 },
		GridBgColor = 2,
		IconTintLabelColor = true,
		ExcludeFromInfoPopup = true,
		ShowInGrid = true
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 28, H = 28 },
		IconTextPos = { X = 24, Y = 3 },
		IconTintLabelColor = true,
		IconTextColor = 9
	},
	{
		IconPos = { X = 0, Y = 0 },
		IconDims = { W = 28, H = 28 },
		IconTextPos = { X = 21, Y = 3 },
		IconTextColor = 9,
		ExcludeFromInfoPopup = true,
		ExcludeFromSmallGrid = true,
		ShowInGrid = true,
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		IconPos = { X = 2, Y = 0 },
		GridIconPos = { X = 4, Y = 0 },
		IconDims = { W = 24, H = 24 },
		GridBgColor = 2,
		ShowInGrid = false,
		UseFullLabel = true
	},
	{
		IconTintLabelColor = true,
		SkipTitleCase = true,
		IconPos = { X = 4, Y = 3 },
		IconDims = { W = 22, H = 22 }
	}
}

function HandleHudScale(object, p, object2, list)
	if __wf_atom_7e8ad928(object) then
		return { 0, 0 }
	end

	local __wf_atom_d5a50cb5 = object:__wf_atom_d5a50cb5()
	local __wf_atom_c4f6543f = object:__wf_atom_c4f6543f()

	if
		__wf_atom_d5a50cb5 < object:__wf_atom_97cd8326()
		or __wf_atom_c4f6543f < object:__wf_atom_54eeda24()
		or Engine.__wf_atom_fc67ba71()
	then
		__wf_atom_d5a50cb5 = object:__wf_atom_97cd8326()
		__wf_atom_c4f6543f = object:__wf_atom_54eeda24()
	end

	object:__wf_atom_e57658c2("_root", 5, p * 100)
	object:__wf_atom_e57658c2("_root", 6, p * 100)
	local v13 = (p - 1) * __wf_atom_d5a50cb5 / 2
	local v14 = (p - 1) * __wf_atom_c4f6543f / 2
	object:__wf_atom_e57658c2("_root", 0, -v13)
	object:__wf_atom_e57658c2("_root", 1, -v14)
	local mHudScalePadding = { v13 / p, v14 / p }

	if not __wf_atom_7e8ad928(list) then
		local v15 = 1 / p * 100

		for _, v16 in ipairs(list) do
			object:__wf_atom_e57658c2(v16, 5, v15)
			object:__wf_atom_e57658c2(v16, 6, v15)
		end
	end

	if not __wf_atom_7e8ad928(object2) then
		object2.mHudScalePadding = mHudScalePadding
		object2:Update(__wf_atom_d5a50cb5, __wf_atom_c4f6543f, true, mHudScalePadding)
	end

	return mHudScalePadding
end

function GetCraftingPostErrorMessage(p)
	local v13 = Localize("/Lotus/Language/Menu/CraftingErrorText_UnknownError", false)
	local v14 = tonumber(p)

	if v14 == nil then
		if module.IsConnectionErrorMsg(p) then
			return (Localize("/Lotus/Language/Menu/Profile_FailedToConnect", false))
		end

		return v13
	else
		if v14 == 5 then
			return (Localize("/Lotus/Language/Menu/CraftingErrorText_InsufficientSpace", false))
		elseif v14 == 4 then
			return (Localize("/Lotus/Language/Menu/CraftingErrorText_InvalidAccount", false))
		elseif v14 == 3 then
			return (Localize("/Lotus/Language/Menu/CraftingErrorText_AuthenticationFailed", false))
		elseif v14 == 2 then
			return (Localize("/Lotus/Language/Menu/CraftingErrorText_InsufficientXP", false))
		elseif v14 == 1 then
			return (Localize("/Lotus/Language/Menu/CraftingErrorText_InsufficientCredits", false))
		end

		return (Localize("/Lotus/Language/Menu/CraftingErrorText_UnknownError", false))
	end
end

function PlayTransmission(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_b4a422ed = object:__wf_atom_b4a422ed(Symbol(p))

	if __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		return
	end

	local v13 = not __wf_atom_7e8ad928(_T.curTransmission) or #_T.QueuedTransmissions ~= 0

	if p2 then
		module3.ClearTransmissionQueue()
		module3.InterruptTransmission()
	elseif not p3 and v13 then
		return
	end

	if _T.CurrentConversation then
		_T.CurrentConversation:__wf_atom_9265891c(__wf_atom_b4a422ed, nil, false)
	else
		module3.CreateHudlessTransmission(__wf_atom_b4a422ed)
	end
end

local function fn(p, p2, p3)
	local v13 = p2.x - p.x
	p3.x = -(p2.y - p.y)
	p3.y = v13
	p3.z = 0
	Normalize(p3)
	p3.z = Dot(p3, p)
end

local function fn2(list, list2)
	fn(list[1], list[2], list2[1])
	fn(list[2], list[3], list2[2])
	fn(list[3], list[4], list2[3])
	fn(list[4], list[1], list2[4])
end

function UpdateMaskingMaterial(object, p, _)
	fn2(p, v2)

	for i = 1, #v2 do
		object:__wf_atom_a042ff6c(v[i], v2[i].x, v2[i].y, v2[i].z, 0)
	end
end

function StreamVignette(p, level, p2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(_T.QuartersVignette) then
		_T.QuartersVignette = {
			Level = nil,
			Layer = PQ_FIRST_LAYER - 1,
			IsStreaming = false,
			RemovingOld = false
		}
	end

	local layer = _T.QuartersVignette.Layer
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("DioramaStreamOffset"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		print("Error: Could not find DioramaStreamOffset waypoint, aborting vignette stream.")
		return
	end

	local levelArgs = Engine.OpenLevelArgs()

	if not __wf_atom_7e8ad928(level) then
		levelArgs.level = level
		levelArgs.streamingLayer = layer + 1

		if levelArgs.streamingLayer > PQ_LAST_LAYER then
			levelArgs.streamingLayer = PQ_FIRST_LAYER
		end

		levelArgs.streamingMode = 1
		levelArgs:__wf_atom_c4be912d("OnVignetteStreamed")
		levelArgs:__wf_atom_60471db9(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
		Engine.StreamRegion(levelArgs)
	end

	local removingOld = _T.QuartersVignette.Level ~= nil
	_T.QuartersVignette.RemovingOld = removingOld

	if removingOld then
		local levelArgs2 = Engine.OpenLevelArgs()
		levelArgs2.level = _T.QuartersVignette.Level
		levelArgs2.streamingLayer = layer
		levelArgs2.streamingMode = 1
		levelArgs2:__wf_atom_c4be912d("OnVignetteRemoved")
		Engine.__wf_atom_94cafc05(levelArgs2)
	end

	_T.QuartersVignette.Level = level
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("VignetteBasePlate"))
	local v13

	if __wf_atom_7e8ad928(level) then
		v13 = true
	else
		_T.QuartersVignette.Layer = levelArgs.streamingLayer
		v13 = false
	end

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = 1, #__wf_atom_2226b35c do
			__wf_atom_2226b35c[i]:SetVisibility(v13)
		end
	end

	if _T.ShipDecosInVignette ~= nil and p2 ~= nil then
		for _, v14 in pairs(_T.ShipDecosInVignette) do
			if __wf_atom_7e8ad928(v14) then
				continue
			end

			v14:SetVisibility(p2)
			local __wf_atom_f582136d = v14:__wf_atom_f582136d(__wf_atom_7e616794)

			for i = 1, #__wf_atom_f582136d do
				__wf_atom_f582136d[i]:SetVisibility(p2)
			end
		end
	end
end

function GetFishDeco(p, object)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_6b56e6c2 = object:__wf_atom_6b56e6c2()
	local mDecoration = nil

	for i = 1, #__wf_atom_6b56e6c2 do
		local v13 = __wf_atom_6b56e6c2[i]
		local __wf_atom_c5b10d35 = v13:__wf_atom_c5b10d35()

		for j = 1, #__wf_atom_c5b10d35 do
			if __wf_atom_c5b10d35[j] ~= p then
				continue
			end

			mDecoration = v13.mDecoration
			break
		end

		if not __wf_atom_7e8ad928(mDecoration) then
			break
		end
	end

	return mDecoration
end

function SetFishScale(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or object2:__wf_atom_33bb197f() ~= 0 then
		return
	end

	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()
	local __wf_atom_fd49129d = object2:__wf_atom_fd49129d()

	if __wf_atom_fd49129d ~= 1 then
		__wf_atom_c082fc3d *= module.Ternary(__wf_atom_fd49129d == 0, 0.5, 1.6)
	end

	object:SetMeshScale(__wf_atom_c082fc3d)
end

function SetQuartersWallpaper(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WallpaperMesh"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:__wf_atom_a887a262(0, p)
end

local function fn3(p, p2, p3)
	local v13 = {}

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v14 in pairs(uiMaterial_Mod) do
			table.insert(v13, v14)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v14 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v13, v14)
		end
	end

	for _, v14 in pairs(v13) do
		if __wf_atom_7e8ad928(v14) then
			continue
		end

		v14:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, p)
		v14:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, p2)
		v14:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, p3)
	end
end

function RestoreGridModMaterials()
	if _T.CachedGridModParams == nil then
		return
	end

	fn3(_T.CachedGridModParams.Center, _T.CachedGridModParams.Size, _T.CachedGridModParams.FadeSize)
end

function ClearGridModMaterials(p)
	_T.CachedGridModParams = nil

	if p then
		for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
			for _, v13 in pairs(uiMaterial_Mod) do
				_T.CachedGridModParams = {}
				_T.CachedGridModParams.Center = v13:__wf_atom_b90af225(SF.__wf_atom_5ddc828f, 1)
				_T.CachedGridModParams.Size = v13:__wf_atom_b90af225(SF.__wf_atom_cf0d1cc6, 1)
				_T.CachedGridModParams.FadeSize = v13:__wf_atom_b90af225(SF.__wf_atom_7a5b8f59, 1)
				break
			end
		end
	end

	fn3(0.5, 1.5, 0)
end

function GetPopupCoords(p, object, data, state, p2)
	local v13 = 0
	local v14 = 0
	local v15 = 0
	local v16 = 0
	local v17 = p2 == nil and 0 or p2
	local v18, v19

	if data.PixelCoords then
		local transformViewportToPixelCoordinates = module.TransformViewportToPixelCoordinates(object, p)
		v18 = transformViewportToPixelCoordinates.x * data.DrawScale
		v19 = transformViewportToPixelCoordinates.y * data.DrawScale
	else
		v18, v19 = object:__wf_atom_6efc7cd1(p.x, p.y)
		v13, v14 = object:__wf_atom_6efc7cd1(15 * data.CursorScale, 30 * data.CursorScale)
	end

	local v20 = data.Width * data.DrawScale
	local v21 = data.Height * data.DrawScale

	if not data.PixelCoords then
		v16 = v14 - v21 / 2
		v15 = v13
	end

	if (v18 + v15 + v20) * data.InvScale > data.ViewportWidth then
		v15 = -(v20 - 5)

		if data.ReverseBuffer ~= nil then
			v15 -= data.ReverseBuffer
		end
	end

	local v22 = (v19 + v16) * data.InvScale
	local v23 = (v19 + v16 + v21) * data.InvScale

	if data.ViewportHeight - v17 < v23 then
		v16 += data.ViewportHeight - v17 - v23
	elseif v22 < v17 then
		v16 += v17 - v22
	end

	if state.TargetX ~= v15 or state.TargetY ~= v16 then
		state.PreviousX = state.TargetX
		state.PreviousY = state.TargetY
		state.TargetX = v15
		state.TargetY = v16

		if __wf_atom_7e8ad928(state.PreviousX) or __wf_atom_7e8ad928(state.PreviousY) then
			state.CurrentX = v15
			state.CurrentY = v16
			object:__wf_atom_290807ee("_root")
		else
			__wf_atom_ec43d06e(object, "_root", 0, { function(p3)
					if not __wf_atom_7e8ad928(state.TargetX) then
						state.CurrentX = module.Round(state.PreviousX + (state.TargetX - state.PreviousX) * p3)
						state.CurrentY = module.Round(state.PreviousY + (state.TargetY - state.PreviousY) * p3)
					end
				end }, { 1 }, module.Ternary(data.Instant, 0, 0.15))
		end
	end

	return {
		x = (v18 + state.CurrentX) * data.InvScale,
		y = (v19 + state.CurrentY) * data.InvScale
	}
end

local function fn4(p, name, options, labelPrefix)
	local result = options or {}

	for k, v13 in pairs(v12[p]) do
		result[k] = v13
	end

	if not next(result) then
		print("UIUtilities::_GetInfoForLabel - Could not find label info for type: " .. tostring(p))
		return result
	end

	result.Name = name
	result.Type = p
	result.LabelColor = result.LabelColor or 9

	if labelPrefix then
		result.LabelPrefix = labelPrefix
	end

	if result.IconDims ~= nil then
		result.Icon = _G.UITexture_LabelIcons[p]
	end

	return result
end

function GetInfoForLabel(p, p2, p3)
	return fn4(p, p2, p3)
end

local function fn5(value)
	return (string.sub(value, 1, -4))
end

local function fn6(object, p, p2, p3, value)
	local v13 = object:__wf_atom_f62a8704("FocusedFavoriteCallback", { p2, (tostring(p3)) }) and 1 or 0

	if p3 == nil then
		object:__wf_atom_c90af43a(p .. ".Icon", _G.UITexture_FavoriteIcons[v13 + 1])
		object:__wf_atom_4c1c1986(p, "Icon", 12, 100)
		object:__wf_atom_4c1c1986(p, "IconTextBg", 12, 0)
	else
		if p3 then
			object:__wf_atom_c90af43a(p .. ".IconTextBg", _G.UITexture_FavoriteIcons[v13 + 3])
		else
			object:__wf_atom_c90af43a(p .. ".Icon", _G.UITexture_FavoriteIcons[v13 + 1])
		end

		local v14 = value or 0
		__wf_atom_ec43d06e(object, p .. ".Icon", 0, { 12 }, { p3 and 0 or 100 }, v14)
		__wf_atom_ec43d06e(object, p .. ".IconTextBg", 0, { 12 }, { p3 and 100 or 0 }, v14)
		__wf_atom_ec43d06e(object, p, 0, { 5, 6 }, { p3 and 125 or 100, p3 and 125 or 100 }, v14)
	end
end

local function fn7(object)
	return {
		FavoriteTag = {
			Initialize = { fn6 },
			Focused = { function(p, p2)
					fn6(object, fn5(p2), p, true, 0.15)
				end },
			Unfocused = { function(p, p2)
					fn6(object, fn5(p2), p, false, 0.15)
				end },
			Selected = { function(p, p2)
					local v13 = object:Execute("SelectedFavoriteCallback", p) and 1 or 0
					object:__wf_atom_c90af43a(fn5(p2) .. ".IconTextBg", _G.UITexture_FavoriteIcons[v13 + 3])
				end }
		}
	}
end

local function fn8(object)
	local count = 0
	local v13

	repeat
		v13 = getfenv(count)
		count += 1
	until v13.mMovie and (not object or object == v13.mMovie)

	return v13
end

local function fn9(callbackPrefix, object, p)
	if not (#callbackPrefix > 0) then
		return nil, nil, nil, nil
	end

	local v13 = "UiUtil" .. callbackPrefix
	local v14 = fn8(object)

	if __wf_atom_7e8ad928(v14) then
		return v13 .. "Focused", v13 .. "Unfocused", v13 .. "Selected", v13 .. "Released"
	end

	local v15 = fn7(object)

	for k, v16 in pairs(v15[callbackPrefix]) do
		if v14[v13 .. k] == nil then
			v14[v13 .. k] = v16[1]
		end
	end

	if v14[v13 .. "Initialize"] ~= nil then
		v14[v13 .. "Initialize"](object, p, object:__wf_atom_cfc41e35(p, "Bg", 100))
	end

	return v13 .. "Focused", v13 .. "Unfocused", v13 .. "Selected", v13 .. "Released"
end

local function fn10(object, p, data, p2)
	local v13 = __wf_atom_7e8ad928(data.Icon)
	local rightAlign = data.RightAlign

	if not p2 and data.RightAlignPopup ~= nil then
		rightAlign = data.RightAlignPopup
	end

	object:__wf_atom_7f57ab2f(p, "Icon", 13, not v13)
	object:__wf_atom_7f57ab2f(p, "IconText", 13, not v13 and data.IconText ~= nil)
	object:__wf_atom_7f57ab2f(
		p,
		"IconTextBg",
		13,
		not v13 and data.IconText ~= nil and not __wf_atom_7e8ad928(data.IconTextBg) or data.BackerCapTexture ~= nil or data.CallbackPrefix ~= nil
	)
	object:__wf_atom_50d60589(p .. ".IconText", 36, data.IconText or "")

	if not v13 then
		if data.CallbackPrefix == nil then
			object:__wf_atom_c90af43a(p .. ".Icon", data.Icon)
		end

		local ternary = module.Ternary(
			p2 and not __wf_atom_7e8ad928(data.GridIconDims),
			data.GridIconDims,
			data.IconDims
		)
		local ternary2 = module.Ternary(p2 and not __wf_atom_7e8ad928(data.GridIconPos), data.GridIconPos, data.IconPos)
		object:__wf_atom_4c1c1986(p, "Icon", 14, ternary.W)
		object:__wf_atom_4c1c1986(p, "Icon", 15, ternary.H)
		local x = ternary2.X
		local v14 = ternary2.Y + 2

		if rightAlign and p2 then
			x -= ternary.W
		end

		object:__wf_atom_4c1c1986(p, "Icon", 0, x)
		object:__wf_atom_4c1c1986(p, "Icon", 1, v14)

		if data.IconTintLabelColor == true and data.LabelColor then
			object:__wf_atom_4c1c1986(p, "Icon", 11, module4.GetColor(data.LabelColor, true))
		else
			object:__wf_atom_4c1c1986(p, "Icon", 11, 16777215)
		end

		if data.IconText == nil then
			if not __wf_atom_7e8ad928(data.CallbackPrefix) then
				object:__wf_atom_4c1c1986(p, "IconTextBg", 11, module4.GetColor(10, true))
				object:__wf_atom_4c1c1986(p, "IconTextBg", 14, ternary.W)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 15, ternary.H)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 0, x)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 1, v14)
			end
		else
			if data.CenterIconText then
				object:__wf_atom_4c1c1986(p, "IconText", 0, ternary2.X + data.IconTextPos.X)
				object:__wf_atom_4c1c1986(p, "IconText", 77, -2)
				object:__wf_atom_48bd5a59(p, "IconText", 45, "center")
			else
				object:__wf_atom_4c1c1986(p, "IconText", 0, data.IconTextPos.X)
				object:__wf_atom_4c1c1986(p, "IconText", 77, 0)
				object:__wf_atom_48bd5a59(p, "IconText", 45, "left")
			end

			object:__wf_atom_4c1c1986(p, "IconText", 1, data.IconTextPos.Y + 2)
			object:__wf_atom_4c1c1986(p, "IconText", 44, module4.GetColor(data.IconTextColor, true))

			if not __wf_atom_7e8ad928(data.IconTextBg) then
				object:__wf_atom_c90af43a(p .. ".IconTextBg", data.IconTextBg)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 12, data.IconTextBgAlpha)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 11, data.IconTextBgColor)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 14, data.IconTextBgDims.W)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 15, data.IconTextBgDims.H)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 0, data.IconTextBgPos.X)
				object:__wf_atom_4c1c1986(p, "IconTextBg", 1, data.IconTextBgPos.Y + 2)
			end
		end
	end

	local v14 = math.max(object:__wf_atom_5e6e15c8(p .. ".IconText", 40) or 0, 5)
	local clipOffset = data.ClipOffset or 0
	object:__wf_atom_e57658c2(p, 0, clipOffset)
	local v15 = v14 + (data.LabelOffset or 27)
	object:__wf_atom_4c1c1986(p, "Label", 0, v15)
	object:__wf_atom_4c1c1986(p, "Label", 1, data.LabelOffsetY or 5)
	local multiLine = data.MultiLine
	local name = data.Name

	if p2 and data.mGridLabelTag ~= nil then
		name = data.mGridLabelTag
	end

	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(name, true)

	if not data.SkipTitleCase then
		__wf_atom_8e9ac384 = TitleCase(__wf_atom_8e9ac384)
	end

	if data.LabelPrefix ~= nil then
		__wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(data.LabelPrefix, true) .. " " .. __wf_atom_8e9ac384
	end

	object:__wf_atom_7f57ab2f(p, "Strikethrough", 13, data.ShowDiscount == true)

	if data.ShowDiscount and data.RegularPrice ~= nil then
		local __wf_atom_8e9ac384_2 = object:__wf_atom_8e9ac384("<MINI_ARROW>", true)
		local __wf_atom_8e9ac384_3 = object:__wf_atom_8e9ac384(
			module.Ternary(data.Type == LABEL_TYPE_PLATINUM, "<PLATINUM_CREDITS>", "<REGULAR_CREDITS>"),
			true
		)
		__wf_atom_8e9ac384 = module.FormatNumber(data.RegularPrice) .. __wf_atom_8e9ac384_2 .. __wf_atom_8e9ac384_3 .. __wf_atom_8e9ac384
		object:__wf_atom_48bd5a59(p, "Label", 36, module.FormatNumber(data.RegularPrice))
		object:__wf_atom_4c1c1986(p, "Strikethrough", 14, object:__wf_atom_cfc41e35(p, "Label", 40) + 30)
		object:__wf_atom_4c1c1986(p, "Strikethrough", 0, 3)
		object:__wf_atom_4c1c1986(p, "Strikethrough", 11, module4.GetColor(6, true))
	end

	if not p2 and data.PricePostfix ~= nil then
		__wf_atom_8e9ac384 ..= data.PricePostfix
		multiLine = true
	end

	if data.Bold then
		__wf_atom_8e9ac384 = "<b>" .. __wf_atom_8e9ac384 .. "</b>"
	end

	local v16 = "<p><font color=\"" .. module.ConvertColorNumberToHex(data.LabelColor == nil and 16777215 or module4.GetColor(data.LabelColor, true) or 16777215) .. "\">" .. __wf_atom_8e9ac384 .. "</font></p>"

	if data.FitText and data.MaxWidth ~= nil then
		object:__wf_atom_4c1c1986(p, "Label", 14, data.MaxWidth - (v15 + clipOffset))
		module.SetFitText(object, p .. ".Label", "...")
	elseif data.MaxWidth == nil then
		object:__wf_atom_4c1c1986(p, "Label", 14, 75)
	else
		object:__wf_atom_4c1c1986(p, "Label", 14, data.MaxWidth)
	end

	local v17 = v13 and 1 or 0
	local v18 = p2 == true
	object:__wf_atom_7f57ab2f(p, "Bg", 13, v18)
	local fn11

	if v18 then
		fn11 = function(p3)
			local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(p, "Label", 72)

			if p3 == nil then
				local ternary = module.Ternary
				local v19

				if __wf_atom_cfc41e35 >= 0 then
					v19 = __wf_atom_cfc41e35 <= v17
				else
					v19 = false
				end

				p3 = ternary(v19, 0, 1)
			end

			if v13 then
				local __wf_atom_cfc41e35_2 = object:__wf_atom_cfc41e35(p, "Label", 80)
				local v19 = 1 / __wf_atom_cfc41e35_2

				if p3 < v19 then
					p3 = v19
				end

				if __wf_atom_cfc41e35_2 < 2 then
					object:__wf_atom_4c1c1986(p, "Label", 72, -1)
				elseif __wf_atom_cfc41e35 >= 0 and __wf_atom_cfc41e35 < v17 then
					object:__wf_atom_4c1c1986(p, "Label", 72, v17)
				end
			end

			local bgWidth = data.BgWidth

			if bgWidth == nil then
				local __wf_atom_cfc41e35_2 = object:__wf_atom_cfc41e35(p, "Label", 40)

				if __wf_atom_cfc41e35_2 ~= 0 then
					__wf_atom_cfc41e35_2 = (__wf_atom_cfc41e35_2 + 4) * p3
				end

				bgWidth = __wf_atom_cfc41e35_2 + 30 + v15 - 27
			end

			if data.BackerCapTexture ~= nil then
				object:__wf_atom_4c1c1986(p, "IconTextBg", 0, bgWidth - 6)
			end

			object:__wf_atom_4c1c1986(p, "Bg", 14, bgWidth)
			object:__wf_atom_4c1c1986(p, "Strikethrough", 12, p3 * 100)
		end

		local bgColor = data.BgColor

		if data.GridBgColor ~= nil and p2 then
			bgColor = data.GridBgColor
		end

		local convertColorNumberToProceduralRGB = module.ConvertColorNumberToProceduralRGB(module4.GetColor(bgColor or 2, true))
		local convertColorNumberToProceduralRGB2 = module.ConvertColorNumberToProceduralRGB(module4.GetColor(9, true))
		local bgOffset = data.BgOffset or 0

		if rightAlign and p2 then
			bgOffset = bgOffset - (data.BgWidth or 0) - 1
		end

		object:__wf_atom_4c1c1986(p, "Bg", 0, bgOffset)
		object:__wf_atom_4c1c1986(p, "Bg", 1, data.BgOffsetY or 0)
		local v19 = (data.GridBgHeightOffset == nil or not p2) and 0 or data.GridBgHeightOffset
		object:__wf_atom_4c1c1986(p, "Bg", 15, v19 + 30)
		object:__wf_atom_c90af43a(p .. ".Bg", data.BackerTexture)

		if data.BackerCapTexture ~= nil then
			object:__wf_atom_c90af43a(p .. ".IconTextBg", data.BackerCapTexture)
			object:__wf_atom_4c1c1986(p, "IconTextBg", 12, 100)
			object:__wf_atom_4c1c1986(p, "IconTextBg", 11, 16777215)
			object:__wf_atom_4c1c1986(p, "IconTextBg", 14, v19 + 30)
			object:__wf_atom_4c1c1986(p, "IconTextBg", 15, v19 + 30)
			object:__wf_atom_4c1c1986(p, "IconTextBg", 1, object:__wf_atom_cfc41e35(p, "Bg", 1))
			object:__wf_atom_1ca72041(
				p .. ".IconTextBg",
				"StartColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			object:__wf_atom_1ca72041(
				p .. ".IconTextBg",
				"EndColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				1
			)
		end

		if data.BackerMaterial == nil then
			object:__wf_atom_1ca72041(
				p .. ".Bg",
				"RectInnerColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				data.RectInnerAlpha or 1
			)
			object:__wf_atom_1ca72041(
				p .. ".Bg",
				"RectEdgeColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				data.RectEdgeAlpha or 0
			)
		else
			object:__wf_atom_1ca72041(p .. ".Bg", "RectInnerColor", 1, 1, 1, 1)
			object:__wf_atom_1ca72041(p .. ".Bg", "RectEdgeColor", 1, 1, 1, data.RectEdgeAlpha or 0)
			object:__wf_atom_1ca72041(
				p .. ".Bg",
				"StartColor",
				convertColorNumberToProceduralRGB.r,
				convertColorNumberToProceduralRGB.g,
				convertColorNumberToProceduralRGB.b,
				1
			)
			object:__wf_atom_1ca72041(
				p .. ".Bg",
				"EndColor",
				convertColorNumberToProceduralRGB2.r,
				convertColorNumberToProceduralRGB2.g,
				convertColorNumberToProceduralRGB2.b,
				1
			)
		end
	else
		fn11 = nil
	end

	if data.HideTagLabel == nil or data.DisableHide then
		object:__wf_atom_48bd5a59(p, "Label", 36, v16)
		object:__wf_atom_4c1c1986(p, "Label", 72, -1)

		if v18 then
			fn11(1)
		end
	else
		local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(p, "Label", 72)
		local v19 = nil

		if data.HideTagLabel then
			local fn12 = v18 and function()
				fn11(0)
			end or v19

			if v17 < __wf_atom_cfc41e35 or __wf_atom_cfc41e35 < 0 then
				module.AnimateTyping(object, nil, p .. ".Label", v16, fn12, -1, nil, fn11)
			elseif v18 then
				object:__wf_atom_48bd5a59(p, "Label", 36, v16)
				fn12()
			end
		else
			local __wf_atom_cfc41e35_2 = object:__wf_atom_cfc41e35(p, "Label", 80)
			local fn12 = v18 and function()
				fn11(1)
			end or v19

			if __wf_atom_cfc41e35 >= 0 and __wf_atom_cfc41e35 < __wf_atom_cfc41e35_2 then
				module.AnimateTyping(object, nil, p .. ".Label", v16, fn12, nil, nil, fn11)
			elseif v18 then
				object:__wf_atom_48bd5a59(p, "Label", 36, v16)
				fn12()
			end
		end
	end

	object:__wf_atom_48bd5a59(p, "Label", 45, (module.Ternary(data.LabelAlignment ~= nil, data.LabelAlignment, "left")))
	object:__wf_atom_7f57ab2f(p, "Label", 52, multiLine == true)
	object:SetCallbacks(p .. ".Bg", fn9(data.CallbackPrefix, object, p))
end

function DrawPriceLabel(p, p2, p3, p4)
	fn10(p, p2, p3, p4)
end

local function fn11(object, p, p2)
	local v13 = p .. ".TagContainer.Tag"
	local v14 = v13 .. tostring(p2)

	if not object:__wf_atom_253d7085(v14) then
		local v15 = tonumber(__wf_atom_86cbd68d(object, v13 .. "1.getDepth")) or 10000
		__wf_atom_86cbd68d(object, v13 .. "1.duplicateMovieClip", "Tag" .. tostring(p2), v15 + p2)
	end

	return v14, p2 + 1
end

function GetPriceLabelClip(p, p2, p3)
	return fn11(p, p2, p3)
end

local function fn12(p, p2, p3, p4, p5, p6, topLeftAligned, bottomAnchor)
	local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(p, {
		x = p3,
		y = p4
	})
	p2.Rect = {
		X = transformPixelToViewportCoordinates.x,
		Y = transformPixelToViewportCoordinates.y,
		W = p5,
		H = p6
	}
	p2.TopLeftAligned = topLeftAligned
	p2.BottomAnchor = bottomAnchor
end

function SetItemInfoPopupRect(p, p2, p3, p4, p5, p6, topLeftAligned, bottomAnchor)
	fn12(p, p2, p3, p4, p5, p6, topLeftAligned, bottomAnchor)
end

local function fn13(object, p, p2, value)
	local infoPopup_Data = {
		CustomEntry = true,
		LocalizedDesc = object:__wf_atom_8e9ac384(p2, true)
	}
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 14)
	fn12(
		object,
		infoPopup_Data,
		object:__wf_atom_5e6e15c8(p, 2) + __wf_atom_5e6e15c8 * (value or 0) / 2,
		object:__wf_atom_5e6e15c8(p, 3),
		__wf_atom_5e6e15c8,
		object:__wf_atom_5e6e15c8(p, 15)
	)
	_T.InfoPopup_Data = infoPopup_Data
end

function ShowInfoPopupTip(p, p2, p3, p4)
	fn13(p, p2, p3, p4)
end

local function fn14(object, infoPopup_Data, p, p2)
	if
		infoPopup_Data.BundleTextureIndex == nil
		or #infoPopup_Data.BundleTextures <= 2
		or infoPopup_Data.mClipName == nil
		or not object:__wf_atom_253d7085(infoPopup_Data.mClipName)
	then
		return
	end

	__wf_atom_ec43d06e(object, infoPopup_Data.mClipName .. ".ImageContainer.Image", 0, { 12 }, { 0 }, p, p2, function()
		infoPopup_Data.BundleTextureIndex = infoPopup_Data.BundleTextureIndex % #infoPopup_Data.BundleTextures + 1
		object:__wf_atom_c90af43a(
			infoPopup_Data.mClipName .. ".ImageContainer.Image",
			infoPopup_Data.BundleTextures[infoPopup_Data.BundleTextureIndex].Texture
		)
		object:__wf_atom_c90af43a(
			infoPopup_Data.mClipName .. ".Background",
			infoPopup_Data.BundleTextures[infoPopup_Data.BundleTextureIndex].Background
		)
		object:__wf_atom_e57658c2(
			infoPopup_Data.mClipName .. ".Background",
			12,
			module.Ternary(
				not __wf_atom_7e8ad928(infoPopup_Data.BundleTextures[infoPopup_Data.BundleTextureIndex].Background),
				100,
				0
			)
		)

		if
			infoPopup_Data.IconWidth == nil
			and infoPopup_Data.Themed ~= infoPopup_Data.BundleTextures[infoPopup_Data.BundleTextureIndex].Themed
		then
			if infoPopup_Data.Themed then
				object:__wf_atom_4c1c1986(
					infoPopup_Data.mClipName,
					"ImageContainer.Image",
					14,
					infoPopup_Data.OriginalImageWidth * 1.6
				)
			else
				object:__wf_atom_4c1c1986(
					infoPopup_Data.mClipName,
					"ImageContainer.Image",
					14,
					infoPopup_Data.OriginalImageWidth / 1.6
				)
			end
		else
			object:__wf_atom_4c1c1986(
				infoPopup_Data.mClipName,
				"ImageContainer.Image",
				14,
				infoPopup_Data.OriginalImageWidth
			)
		end

		__wf_atom_ec43d06e(
			object,
			infoPopup_Data.mClipName .. ".ImageContainer.Image",
			0,
			{ 12 },
			{ 100 },
			p,
			0,
			function()
				fn14(object, infoPopup_Data, p, p2)
			end
		)
	end)
end

local function fn15(object, infoPopup_Grid, infoPopup_Data, data)
	local mClipName = infoPopup_Data.mClipName

	if mClipName == nil or not object:__wf_atom_253d7085(mClipName) then
		return
	end

	if infoPopup_Grid.UpdateColors ~= nil then
		infoPopup_Grid:UpdateColors(infoPopup_Data, data.IsFocused, data.IsSelected, data.IgnoreCount)
	end

	local ternary = module.Ternary(data.FromRedraw, 0, 0.2)
	local ternary2 = module.Ternary(data.FromRedraw, 0, 0.01)
	local v13 = 2
	local isFocused = data.IsFocused
	local v14 = data.OffAlphaMultiplier == nil and 1 or data.OffAlphaMultiplier
	local ternary3 = module.Ternary(isFocused, 100, module.Ternary(infoPopup_Data.NotOwned, 25, 85) * v14)
	local ternary4 = module.Ternary(
		isFocused or data.DisableSaturation,
		0,
		module.Ternary(infoPopup_Data.NotOwned, -50, 0)
	)
	object:__wf_atom_290807ee(mClipName .. ".ImageContainer.Image")
	__wf_atom_ec43d06e(
		object,
		mClipName .. ".ImageContainer.Image",
		v13,
		{ "adjustcolor_saturation", "_alpha" },
		{ ternary4, ternary3 },
		ternary,
		ternary2
	)
	local ternary5 = module.Ternary(isFocused, 115, 100)
	__wf_atom_ec43d06e(
		object,
		mClipName .. ".NameBg",
		0,
		{ 12 },
		{ module.Ternary(data.IsFocused, 100, 65) },
		ternary,
		ternary2
	)
	__wf_atom_ec43d06e(
		object,
		mClipName .. ".ImageContainer",
		v13,
		{ "_xscale", "_yscale" },
		{ ternary5, ternary5 },
		ternary,
		ternary2
	)

	if data.HideLockedOnFocus then
		__wf_atom_ec43d06e(
			object,
			mClipName .. ".Locked",
			v13,
			{ 12 },
			{ module.Ternary(data.IsFocused, 0, 100) },
			ternary,
			ternary2
		)
	end

	local zoomXShift = 0
	local zoomYShift = 0

	if __wf_atom_7e8ad928(infoPopup_Data.mMod) then
		if
			not data.DisableBundleCycle
			and not __wf_atom_7e8ad928(infoPopup_Data.Category)
			and infoPopup_Data.Category == 9
			and not __wf_atom_7e8ad928(infoPopup_Data.StoreItem)
		then
			if data.IsFocused then
				local __wf_atom_72915748 = infoPopup_Data.StoreItem:__wf_atom_72915748()
				local v15

				if infoPopup_Data.StoreItem:__wf_atom_bdbcec0a() == "" then
					v15 = false
				else
					v15 = module3.CheckSteamPurchaseAvailability(infoPopup_Data.StoreItem) ~= "MARKET"
				end

				if not v15 and #__wf_atom_72915748 > 0 then
					if __wf_atom_7e8ad928(infoPopup_Data.BundleTextures) then
						infoPopup_Data.BundleTextures = {
							{ Texture = infoPopup_Data.Icon, Themed = infoPopup_Data.Themed }
						}

						for i = 1, #__wf_atom_72915748 do
							local mTypeName = __wf_atom_72915748[i].mTypeName

							if __wf_atom_7e8ad928(mTypeName) then
								continue
							end

							local storeItemInfo = module6.GetStoreItemInfo(object, mTypeName)
							local iconTexture, themed = module6.GetIconTexture(mTypeName, true)

							if __wf_atom_7e8ad928(iconTexture) then
								continue
							end

							if __wf_atom_7e8ad928(storeItemInfo) then
								table.insert(infoPopup_Data.BundleTextures, {
									Texture = iconTexture,
									Themed = themed
								})
							else
								table.insert(infoPopup_Data.BundleTextures, {
									Texture = iconTexture,
									Themed = themed,
									Background = storeItemInfo.Background
								})
							end
						end
					end

					infoPopup_Data.BundleTextureIndex = 1
					infoPopup_Data.OriginalImageWidth = object:__wf_atom_cfc41e35(mClipName, "ImageContainer.Image", 14)
					fn14(object, infoPopup_Data, 0.5, 3)
				end
			else
				object:__wf_atom_c90af43a(mClipName .. ".ImageContainer.Image", infoPopup_Data.Icon)

				if infoPopup_Data.OriginalImageWidth ~= nil then
					object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 14, infoPopup_Data.OriginalImageWidth)
					infoPopup_Data.OriginalImageWidth = nil
				end
			end
		end
	else
		local ternary6 = module.Ternary(data.IsFocused, 80, infoPopup_Grid.ModScale)
		local ternary7 = module.Ternary(infoPopup_Data.mBaseClipName ~= nil, infoPopup_Data.mBaseClipName, mClipName)

		if data.IsFocused then
			if data.ZoomYShift == nil then
				if not infoPopup_Grid.Horizontal then
					local v15 = infoPopup_Grid.mInitialY - infoPopup_Grid.ElementHeight / 2
					local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(mClipName, 1)
					local v16 = infoPopup_Grid.mRows * infoPopup_Grid.mRowSeparation - module.Ternary(
						infoPopup_Grid.ElementDimBuffer ~= nil,
						infoPopup_Grid.ElementDimBuffer,
						0
					)
					local v17 = module2.MAX_BACKGROUND_HEIGHT / 2 + 10

					if __wf_atom_5e6e15c8 < v15 + v17 then
						zoomYShift = v17 - (__wf_atom_5e6e15c8 - v15)
					elseif v15 + v16 - v17 < __wf_atom_5e6e15c8 then
						zoomYShift = v15 + v16 - __wf_atom_5e6e15c8 - v17
					end
				end
			else
				zoomYShift = data.ZoomYShift
			end

			if data.ZoomXShift == nil then
				if infoPopup_Grid.Horizontal then
					local v15 = infoPopup_Grid.mInitialX - infoPopup_Grid.ElementWidth
					local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(mClipName, 0)
					local height = infoPopup_Grid.Height
					local v16 = module2.MAX_BACKGROUND_WIDTH / 2 + 10

					if __wf_atom_5e6e15c8 < v15 + v16 then
						zoomXShift = v16 - (__wf_atom_5e6e15c8 - v15)
					elseif v15 + height - v16 < __wf_atom_5e6e15c8 then
						zoomXShift = v15 + height - __wf_atom_5e6e15c8 - v16
					end
				end
			else
				zoomXShift = data.ZoomXShift
			end

			infoPopup_Data.InitDepth = tonumber(__wf_atom_86cbd68d(object, ternary7 .. ".getDepth"))
			__wf_atom_86cbd68d(object, ternary7 .. ".swapDepths", 3000)
		elseif infoPopup_Data.InitDepth ~= nil then
			__wf_atom_86cbd68d(object, ternary7 .. ".swapDepths", infoPopup_Data.InitDepth)
			infoPopup_Data.InitDepth = nil
		end

		if not infoPopup_Grid.SkipModScaling then
			__wf_atom_ec43d06e(object, mClipName .. ".Mod", v13, { 5, 6 }, { ternary6, ternary6 }, ternary, ternary2)
		end

		local v15

		if data.DepthTest then
			v15 = module.Ternary(infoPopup_Grid.Horizontal, 3, 1)
		else
			v15 = module.Ternary(infoPopup_Grid.Horizontal, 4, 2)
		end

		if data.NoZoomedVisRange then
			module2.EnableCardVisibleRange(
				infoPopup_Data.mMod,
				infoPopup_Data.mMod.mClipName .. ".Card",
				not data.IsFocused
			)
		end

		local isFocused2 = data.IsFocused or infoPopup_Grid.ForceZoomMods
		module2.ZoomCard(
			infoPopup_Data.mMod,
			infoPopup_Data.mMod.mClipName .. ".Card",
			isFocused2,
			module.Ternary(data.FromRedraw, 0, nil),
			zoomXShift,
			zoomYShift,
			nil,
			v15
		)
	end

	if not data.FromRedraw then
		if data.IsFocused then
			module.PlaySound(_G.UISound_Focus)

			if data.ShowToolTip and not __wf_atom_7e8ad928(infoPopup_Data.ToolTip) and infoPopup_Data.ToolTip ~= "" then
				_T.gToolTip = object:__wf_atom_8e9ac384(infoPopup_Data.ToolTip, true)
			elseif data.ShowInfoPopup then
				local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 14)

				if not __wf_atom_7e8ad928(infoPopup_Data.mMod) then
					__wf_atom_5e6e15c8 = module2.MAX_BACKGROUND_WIDTH * 0.8
				end

				fn12(
					object,
					infoPopup_Data,
					object:__wf_atom_5e6e15c8(mClipName, 2) + zoomXShift,
					object:__wf_atom_5e6e15c8(mClipName, 3),
					__wf_atom_5e6e15c8,
					object:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 15)
				)
				infoPopup_Data.TagType = LABEL_TYPE_CHECKMARK
				_T.InfoPopup_Data = infoPopup_Data
				_T.InfoPopup_Grid = infoPopup_Grid
			end
		else
			_T.gToolTip = nil
			_T.InfoPopup_Data = nil
			_T.InfoPopup_Grid = nil
		end
	end

	object:__wf_atom_4c1c1986(
		mClipName,
		"CornerPiece",
		12,
		module.Ternary(infoPopup_Grid.mUseCornerForSelected and data.IsSelected, 100, 0)
	)

	if not (data.FromRedraw and data.IsFocused) then
		for k, label in pairs(infoPopup_Data.Labels) do
			if label.mShowItemPrice then
				continue
			end

			local v15 = mClipName .. ".TagContainer.Tag" .. tostring(k)

			if not label.Visible then
				__wf_atom_ec43d06e(
					object,
					v15,
					v13,
					{ 12 },
					{ module.Ternary(data.IsFocused, 0, 0) },
					ternary,
					ternary2
				)
			end
		end
	end
end

function OnGridItemFocusChanged(p, infoPopup_Grid, infoPopup_Data, p2)
	fn15(p, infoPopup_Grid, infoPopup_Data, p2)
end

local function fn16(state)
	if state.ElementWidth == nil then
		return
	end

	if not state.SkipReinitializePos then
		state.mInitialX = state.ElementWidth / 2
	end

	local v13 = state.Width + state.ElementDimBuffer
	local v14 = state.ElementWidth + state.ElementDimBuffer
	local v15 = v13 / v14
	local v16 = v13 % v14
	local mColumns = math.floor(v15)
	local rounded = module.Round(v16 / (mColumns - 1))
	state.mColumnSeparation = state.ElementWidth + rounded + state.ElementDimBuffer
	state.mColumns = mColumns
	state.mVisibleElements = state.mColumns * state.mRows
end

function FitGridToWidth(p)
	fn16(p)
end

local function fn17(object)
	if object.ElementHeight == nil then
		return
	end

	if not object.SkipReinitializePos then
		object.mInitialY = object.ElementHeight / 2
	end

	local v13 = object.Height + object.ElementDimBuffer
	local v14 = object.ElementHeight + object.ElementDimBuffer
	local v15 = v13 / v14
	local mRows

	if object.FixedDimBufferHeight then
		mRows = math.ceil(v15)
		object.mRowSeparation = object.ElementHeight + object.ElementDimBuffer
	else
		local v16 = v13 % v14
		mRows = math.floor(v15)
		local rounded = module.Round(v16 / (mRows - 1))
		object.mRowSeparation = object.ElementHeight + rounded + object.ElementDimBuffer
	end

	object.mRows = mRows
	object.mVisibleElements = object.mColumns * object.mRows
end

function ResizeGrid(object, width, height, object2, p, p2)
	local v13

	if width == object.Width then
		v13 = false
	else
		v13 = true

		if p ~= nil and not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_4c1c1986(p, "Search", 0, width - 178)
			object2:__wf_atom_4c1c1986(p, "SortMenu", 0, width - 388)
			object2:__wf_atom_4c1c1986(p, "ScrollBar", 0, width + 18)
		end

		object.Width = width
		fn16(object)
	end

	if height ~= object.Height then
		object.Height = height
		fn17(object)
		v13 = true
	end

	if v13 and not p2 then
		object:Redraw(nil, nil, true)
	end
end

function InitializeGridItem(_, state)
	local ternary = module.Ternary(state.ElementDimBuffer ~= nil, state.ElementDimBuffer, 0)

	if state.ElementWidth ~= nil then
		state.mColumnSeparation = state.ElementWidth + ternary

		if not state.SkipReinitializePos then
			state.mInitialX = state.ElementWidth / 2
		end

		state.mColumns = math.floor(((state.Width or 1200) + ternary) / state.mColumnSeparation)
	end

	if state.ElementHeight ~= nil then
		local ternary2 = module.Ternary(state.ElementHeightBuffer ~= nil, state.ElementHeightBuffer, ternary)
		state.mRowSeparation = state.ElementHeight + ternary2

		if not state.SkipReinitializePos then
			state.mInitialY = state.ElementHeight / 2
		end

		state.mRows = math.floor(((state.Height or 700) + ternary2) / state.mRowSeparation)
	end

	state.mVisibleElements = state.mColumns * state.mRows
end

function OnGridItemCreated(object, state, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(p) then
		return
	end

	local width = v11.ItemDimensions.Width
	local height = v11.ItemDimensions.Height
	local ternary = module.Ternary(state.ElementDimBuffer ~= nil, state.ElementDimBuffer, 0)

	if state.ElementWidth == nil then
		if state.mForcedHorizontalSeparation ~= nil or state.mColumnSeparation ~= nil then
			width = module.Ternary(
				state.mForcedHorizontalSeparation ~= nil,
				state.mForcedHorizontalSeparation,
				state.mColumnSeparation
			) - ternary
		end
	else
		width = state.ElementWidth
	end

	if state.ElementHeight == nil then
		if state.mForcedVerticalSeparation ~= nil or state.mRowSeparation ~= nil then
			height = module.Ternary(
				state.mForcedVerticalSeparation ~= nil,
				state.mForcedVerticalSeparation,
				state.mRowSeparation
			) - ternary
		end
	else
		height = state.ElementHeight
	end

	for _, v13 in pairs({ ".Btn", ".RectangleBg", ".Blurer" }) do
		if state.BackerWidth == nil then
			object:__wf_atom_e57658c2(p .. v13, 14, width)
		else
			object:__wf_atom_e57658c2(p .. v13, 14, state.BackerWidth)
		end

		object:__wf_atom_e57658c2(p .. v13, 15, height)
	end

	state.ImageHeight = height - 4

	for k, v13 in pairs({
		".ImageMask",
		".ImageContainer.Image",
		".ShadowContainer.ImageShadow",
		".Background",
		".Locked.Gradient",
		".Highlight",
		".NameBg"
	}) do
		if state.BackerWidth == nil or k == 1 or k == 2 or k == 3 then
			object:__wf_atom_e57658c2(p .. v13, 14, width - 4)
		else
			object:__wf_atom_e57658c2(p .. v13, 14, state.BackerWidth - 4)
		end

		object:__wf_atom_e57658c2(p .. v13, 15, state.ImageHeight)
	end

	local v13 = width / 2

	if state.BackerWidth ~= nil then
		v13 = state.BackerWidth / 2
		object:__wf_atom_4c1c1986(p, "ImageMask", 0, -v13 + 43)
		object:__wf_atom_4c1c1986(p, "ImageMask", 1, -13)
		object:__wf_atom_4c1c1986(p, "ImageContainer", 0, -v13 + 43)
		object:__wf_atom_4c1c1986(p, "ImageContainer", 1, -13)
	end

	if state.ModScale == nil then
		state.ModScale = 54
	end

	object:__wf_atom_4c1c1986(p, "Mod", 5, state.ModScale)
	object:__wf_atom_4c1c1986(p, "Mod", 6, state.ModScale)
	object:__wf_atom_4c1c1986(p, "CornerPiece", 16, 180)
	object:__wf_atom_4c1c1986(p, "CornerPiece", 14, 45)
	object:__wf_atom_4c1c1986(p, "CornerPiece", 15, 45)
	object:__wf_atom_4c1c1986(p, "CornerPiece", 0, v13 - 22.5 + 9)
	object:__wf_atom_4c1c1986(p, "CornerPiece", 1, -height / 2 + 22.5 - 9)
	object:__wf_atom_4c1c1986(p, "Highlight", 1, height / 2 - 1)
	state.mNameX = -width / 2 + 4 + 2
	state.mNameWidth = width - 8
	object:__wf_atom_4c1c1986(p, "ItemName", 0, state.mNameX)
	object:__wf_atom_4c1c1986(p, "ItemName", 14, state.mNameWidth)
	object:__wf_atom_4c1c1986(p, "ItemName", 1, height / 2 - 24)
	object:__wf_atom_4c1c1986(p, "NameBg", 1, height / 2 - 1)
	state.mOriginalButtonHeight = height
	object:__wf_atom_4c1c1986(p, "Check", 0, width / 2 - 20)
	object:__wf_atom_4c1c1986(p, "Check", 1, height / 2 - 20)
	object:__wf_atom_4c1c1986(p, "Locked.LabelBg", 14, width - 4)
	object:__wf_atom_4c1c1986(p, "Locked.Label", 14, width - 4)
	object:__wf_atom_4c1c1986(p, "Locked.Label", 0, -((width - 4) / 2) + 2)
end

local function fn18(value, p, p2, object, p3)
	if p == nil or not (p >= 0) or p2 == nil then
		return value
	end

	if value ~= "" then
		if __wf_atom_7e8ad928(p3) then
			value ..= " "
		elseif p3.mShowLabels == false and not object:Execute("AlwaysShowLabels", "") then
			value = ""
		elseif string.len(value) > 0 then
			value ..= "\r\n"
		end
	end

	for i = 1, p2 do
		if i <= p then
			value ..= object:__wf_atom_8e9ac384("<ARCANE_RANK>", true)
		else
			value ..= object:__wf_atom_8e9ac384("<ARCANE_RANK_OUTLINE>", true)
		end
	end

	return value
end

function GetArcaneRankString(p, p2, p3, p4, p5)
	return fn18(p, p2, p3, p4, p5)
end

local function fn19(object, p, state, p2)
	local platinumBundlePair = module6.GetPlatinumBundlePair(state.StoreItem)

	if not __wf_atom_7e8ad928(platinumBundlePair) and module6.__wf_atom_7f3468fc() then
		state.Name = module6.GetStoreItemInfo(object, platinumBundlePair).Name
	end

	local name = state.Name
	local v13 = "Owned"
	local v14 = object:__wf_atom_6d61d595() == v5

	if not __wf_atom_7e8ad928(state.Type) and state.Type:IsA(__wf_atom_3aaccc49) and state.RawName == nil then
		name = object:__wf_atom_8e9ac384(module3.GetTreasureName(object, state.StoreItem, state.RawItem, name), true)
	end

	if state.WillExpire then
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(state.RawItem.mExpiry.sec)
		local v15

		if __wf_atom_db2b0cee <= 0 then
			v15 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Expired", false)
		else
			v15 = module3.GetFullTime(__wf_atom_db2b0cee)
		end

		name ..= "\r\n" .. object:__wf_atom_8e9ac384("<TIMER>", true) .. v15
	elseif state.Rank == nil then
		if state.ArcaneRank == nil then
			if state.StoreItem then
				local bundleQuantity

				if __wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2.ShowPurchaseQuantity) then
					bundleQuantity = 1
				else
					bundleQuantity = state.StoreItem:__wf_atom_17d97bf6()

					if not (__wf_atom_7e8ad928(state.BundleQuantity) or v14) then
						bundleQuantity = state.BundleQuantity
					end
				end

				if state.QuantityMultiplier ~= nil and state.QuantityMultiplier > 1 then
					bundleQuantity *= state.QuantityMultiplier
				end

				if state.StoreItem:__wf_atom_efa6f447() == 35 then
					if state.HideEndoCount then
						name = object:__wf_atom_8e9ac384(state.StoreItem:__wf_atom_014a76a2():c_str(), false)
					else
						local v15 = -state.StoreItem:__wf_atom_ee4fa4fd()
						name = module.FormatNumber(v15 * bundleQuantity) .. " " .. object:__wf_atom_8e9ac384(
							state.StoreItem:__wf_atom_014a76a2():c_str(),
							false
						)
					end
				elseif bundleQuantity > 1 or not __wf_atom_7e8ad928(state.BundleQuantity) then
					name = module.FormatNumber(bundleQuantity) .. " x " .. name
				end
			end
		else
			name = fn18(name, state.ArcaneRank, state.ArcaneMaxRank, object, p)
		end
	else
		local v15 = state.Rank >= __wf_atom_c67f9605:__wf_atom_a1680b24(state.Type)
		v13 = state.Polarized ~= nil and state.Polarized > 0 and "Forma" or v15 and "Max" or v13
		local v16 = not __wf_atom_7e8ad928(state.Type) and (state.Type:IsA(v6) or state.Type:IsA(v7))

		if
			name ~= nil
			and not v16
			and state.ResultStoreItem == nil
			and (state.Category == nil or state.Category ~= 13)
		then
			name ..= " " .. "[" .. state.Rank .. "]"
		end
	end

	if not (__wf_atom_7e8ad928(p2) or __wf_atom_7e8ad928(p2.NameOverride)) then
		name = p2.NameOverride
	end

	return name == nil and "" or name, v13
end

function GetGridItemName(p, p2, p3, p4)
	return fn19(p, p2, p3, p4)
end

local function fn20(object, p, p2, storeItem)
	local v13 = (p2 - p) / p2 * 100
	local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
		"/Lotus/Language/Railjack/" .. module.Ternary(v13 > 0, "CrewMemberDiscountLabel", "CrewMemberTaxLabel"),
		false
	)
	local syndicate = __wf_atom_7e8ad928(storeItem) and ""
		or object:__wf_atom_8e9ac384(storeItem:__wf_atom_014a76a2():c_str(), false)
	return "\r\n" .. object:__wf_atom_8e9ac384("/Lotus/Language/Railjack/CrewMemberPriceChangeLabel", false, {
		CHANGE = module.FormatNumber((math.abs(v13))),
		SYNDICATE = syndicate,
		TYPE = __wf_atom_8e9ac384
	})
end

local function fn21(_)
	return nil
end

function GetArcaneTagInfo(p)
	return fn21(p)
end

local function fn22(object, state, state2, data, _)
	if __wf_atom_7e8ad928(data) or __wf_atom_7e8ad928(gGameData) then
		return {}
	end

	local result = {}
	local v13 = object:__wf_atom_6d61d595() == v5
	local v14 = not (__wf_atom_7e8ad928(state) or __wf_atom_7e8ad928(state.Mode))
		and not __wf_atom_7e8ad928(state.mFilterBy)
		and state.mFilterBy == state.Mode.PACKAGE

	if not __wf_atom_7e8ad928(data.CustomTags) then
		for _, customTag in pairs(data.CustomTags) do
			if not (v13 and customTag.HideInPopup) then
				table.insert(result, customTag)
			end
		end
	end

	local purchasedItems

	if not __wf_atom_7e8ad928(state) then
		purchasedItems = state.PurchasedItems

		if
			__wf_atom_7e8ad928(purchasedItems)
			and not (__wf_atom_7e8ad928(state2.ResultStoreItem) or __wf_atom_7e8ad928(gGameRules))
		then
			local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

			if not __wf_atom_7e8ad928(__wf_atom_964056fd) then
				purchasedItems = module6.GetPurchasedItems(__wf_atom_964056fd, gGameData:GetInventory())
				state.PurchasedItems = purchasedItems
			end
		end
	end

	if data.SellInfo == nil then
		if data.HidePrice or __wf_atom_7e8ad928(state2.StoreItem) then
			if state2.CustomEntry then
				local v15 = state2.RegularPrice == nil and 0 or state2.RegularPrice
				local v16 = state2.PremiumPrice == nil and 0 or state2.PremiumPrice

				if v15 > 0 or v16 > 0 then
					local v17 = v16 > 0
					local formatNumber = module.FormatNumber(module.Ternary(v17, v16, v15))
					table.insert(
						result,
						fn4(module.Ternary(v17, LABEL_TYPE_PLATINUM, LABEL_TYPE_CREDITS), formatNumber)
					)
				end
			end

			if not (v13 or state2.IsExternalProduct) then
				local __wf_atom_a94b426a, v15 = module3.__wf_atom_a94b426a(
					state2.StoreItem,
					nil,
					false,
					purchasedItems,
					false
				)
				local regularPrice, premiumPrice = module3.__wf_atom_a94b426a(
					state2.StoreItem,
					nil,
					true,
					purchasedItems,
					false
				)
				local v16 = premiumPrice > 0

				if state2.RegularPrice ~= nil then
					regularPrice = state2.RegularPrice
					local ternary = module.Ternary
					local v17

					if state2.RegularPriceBeforeDiscount == nil then
						v17 = false
					else
						v17 = state2.RegularPriceBeforeDiscount > 0
					end

					__wf_atom_a94b426a = ternary(v17, state2.RegularPriceBeforeDiscount, regularPrice)
				end

				if state2.PremiumPrice ~= nil then
					premiumPrice = state2.PremiumPrice
					v15 = premiumPrice
				end

				if
					(v16 or regularPrice > 0)
					and not data.IgnoreDiscount
					and module.Ternary(v16, premiumPrice < v15, regularPrice < __wf_atom_a94b426a)
				then
					table.insert(result, (fn4(LABEL_TYPE_SALE, "/Lotus/Language/Menu/Store_Sale")))
				end
			end
		else
			if data.SpecialPriceInfo and data.SpecialPriceInfo.Price > 0 and data.SpecialPriceInfo.LabelType ~= nil then
				local ternary = module.Ternary(
					data.SpecialPriceInfo.TagOverride ~= nil,
					data.SpecialPriceInfo.TagOverride,
					module.FormatNumber(data.SpecialPriceInfo.Price)
				)
				local v15 = fn4(data.SpecialPriceInfo.LabelType, ternary)

				if data.SpecialPriceInfo.LabelPrefix ~= nil then
					v15.LabelPrefix = data.SpecialPriceInfo.LabelPrefix
				end

				v15.HideInGrid = state2.Count ~= nil and state2.Count > 0 and not data.PriceIgnoreCount
				table.insert(result, v15)
			end

			if state2.ItemPrices ~= nil then
				local v15

				if not __wf_atom_7e8ad928(gGameRules) then
					v15 = gGameRules:__wf_atom_964056fd()
				end

				local count = #state2.ItemPrices

				for i = 1, count do
					local itemPrice = state2.ItemPrices[i]
					local v16

					if not __wf_atom_7e8ad928(v15) then
						v16 = v15:__wf_atom_232fd31d(itemPrice.mItemType)
					end

					if __wf_atom_7e8ad928(v16) then
						v16 = Resource(itemPrice.mItemType)
					end

					if __wf_atom_7e8ad928(v16) then
						continue
					end

					local formatNumber = module.FormatNumber(itemPrice.mItemCount)
					local v17 = (itemPrice.mItemType:IsA(__wf_atom_58a409f1) or itemPrice.NumOwned == nil) and ""
						or module.FormatNumber(itemPrice.NumOwned) .. "/"
					local v18 = tostring(v16:__wf_atom_014a76a2())
					local v19 = v17 .. formatNumber .. " " .. TitleCase(object:__wf_atom_8e9ac384(v18, false))
					local multiLine

					if
						itemPrice.mItemCountBeforeDiscount == nil
						or itemPrice.mItemCountBeforeDiscount == itemPrice.mItemCount
					then
						multiLine = false
					else
						v19 ..= fn20(object, itemPrice.mItemCount, itemPrice.mItemCountBeforeDiscount, state2.StoreItem)
						multiLine = true
					end

					local v20 = fn4(LABEL_TYPE_MISC_ITEM, v19)
					v20.MultiLine = multiLine

					if itemPrice.mItemType:IsA(WeakResource("/Lotus/Types/Items/Deimos/EntratiFragmentBase")) then
						local v21 = StringSplit("/", v18)
						v20.LabelPrefix = ({
							EntratiFragmentCommonA = "<OTAK_TOKEN>",
							EntratiFragmentCommonB = "<SON_TOKEN>",
							EntratiFragmentCommonC = "<DAUGHTER_TOKEN>",
							EntratiFragmentUncommonA = "<FATHER_TOKEN>",
							EntratiFragmentUncommonB = "<MOTHER_TOKEN>",
							EntratiFragmentRareA = "<GRANDMOTHER_TOKEN>"
						})[v21[#v21]]
						v20.LabelOffset = 2
					else
						local iconTexture, v21 = module6.GetIconTexture(v16, true)
						v20.Icon = iconTexture

						if v21 then
							v20.IconDims.W = 26
							v20.LabelOffset = 26
						end
					end

					if
						count == 1
						or itemPrice.mItemType:IsA(WeakResource("/Lotus/Types/Items/MiscItems/LastWishItems/CrystalBase"))
					then
						v20.mGridLabelTag = " " .. formatNumber
						v20.IconPos = { X = 3, Y = 0 }
						v20.IconDims = { W = 26, H = 26 }
					end

					table.insert(result, v20)
				end
			end

			local v15 = module3.CheckSteamPurchaseAvailability(state2.StoreItem)
			local __wf_atom_a8366d8a = module3.__wf_atom_a8366d8a(state2.StoreItem)
			local __wf_atom_3963da3f = module3.__wf_atom_3963da3f(state2.StoreItem)
			local v16 = state2.StoreItem:__wf_atom_836b9069() and Engine.__wf_atom_6f25c160()
			local v17

			if state2.StoreItem:__wf_atom_56c51289() > 0 then
				v17 = Engine.__wf_atom_eecb6143()
			else
				v17 = false
			end

			local v18 = Engine.__wf_atom_2a979d69()
				and gGameData:__wf_atom_23adb874(state2.StoreItem:__wf_atom_bdbcec0a())
			local v19 = state2.IsExternalProduct and not state2.StoreItem:__wf_atom_955f7fe0()

			if
				(not v16 or v15 ~= "UNAVAILABLE")
				and (not v17 or __wf_atom_a8366d8a ~= "UNAVAILABLE")
				and (not v18 or __wf_atom_3963da3f ~= "UNAVAILABLE")
			then
				if
					v16 and v15 == "EXTERNAL"
					or v17 and __wf_atom_a8366d8a == "EXTERNAL"
					or v18 and __wf_atom_3963da3f == "EXTERNAL"
					or v19
				then
					local saleInfo = module3.GetSaleInfo(state2.StoreItem)
					local v20

					if __wf_atom_7e8ad928(gGameData) then
						v20 = "0.00"
					else
						local __wf_atom_43750928 = gGameData:__wf_atom_43750928(module3.GetProductId(state2.StoreItem))

						if
							state2.StoreItem:__wf_atom_56c51289() == 4
							and state2.StoreItem:__wf_atom_efa6f447() == 9
							and __wf_atom_43750928 > 0
						then
							local __wf_atom_ff62ea3d = gGameData:__wf_atom_ff62ea3d()

							if
								__wf_atom_ff62ea3d == nil
								or not (Engine.__wf_atom_db2b0cee(__wf_atom_ff62ea3d.mExpiry) > 0)
							then
								v20 = gGameData:__wf_atom_347d3c3b(module3.GetProductId(state2.StoreItem))
							else
								local v21 = __wf_atom_43750928 - __wf_atom_43750928 * __wf_atom_ff62ea3d.mDiscount / 100
								local __wf_atom_9e2402a0 = gGameData:__wf_atom_9e2402a0(
									module3.GetProductId(state2.StoreItem),
									module.FormatNumber(v21, 2, true, true)
								)
								v20 = object:__wf_atom_8e9ac384(
									"/Lotus/Language/Bundles/DetailedPurchase_DiscountAndDiscountPrice",
									false,
									{
										DISCOUNT = __wf_atom_ff62ea3d.mDiscount,
										PRICE = string.upper(__wf_atom_9e2402a0)
									}
								)
							end
						elseif
							Engine.__wf_atom_6f25c160()
							and state2.StoreItem:__wf_atom_955f7fe0()
							and not __wf_atom_7e8ad928(saleInfo)
							and saleInfo.mDiscount > 0
							and __wf_atom_43750928 > 0
						then
							local v21 = saleInfo.mDiscount / 100
							local __wf_atom_9e2402a0 = gGameData:__wf_atom_9e2402a0(
								module3.GetProductId(state2.StoreItem),
								module.FormatNumber(__wf_atom_43750928 - __wf_atom_43750928 * v21, 2, true, true)
							)
							v20 = object:__wf_atom_8e9ac384(
								"/Lotus/Language/Bundles/DetailedPurchase_DiscountAndDiscountPrice",
								false,
								{
									DISCOUNT = saleInfo.mDiscount,
									PRICE = string.upper(__wf_atom_9e2402a0)
								}
							)
						else
							v20 = gGameData:__wf_atom_347d3c3b(module3.GetProductId(state2.StoreItem))
						end
					end

					if v20 ~= "0.00" and __wf_atom_0a63ecce(v20) ~= "" then
						if v17 then
							table.insert(result, fn4(LABEL_TYPE_EPIC, v20))
						elseif v18 then
							table.insert(result, fn4(LABEL_TYPE_IOS, v20))
						elseif v16 then
							table.insert(result, fn4(LABEL_TYPE_STEAM, v20))
						else
							local v21 = fn4(LABEL_TYPE_UNIQUE_TEXT, v20)
							v21.SkipTitleCase = true
							table.insert(result, v21)
						end
					end

					if
						not v13
						and Engine.__wf_atom_6f25c160()
						and state2.StoreItem:__wf_atom_955f7fe0()
						and not __wf_atom_7e8ad928(saleInfo)
						and saleInfo.mDiscount > 0
					then
						local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
							"/Lotus/Language/Menu/DetailedPurchase_Discount",
							false,
							{
								DISCOUNT = module.FormatNumber(saleInfo.mDiscount)
							}
						)
						table.insert(result, (fn4(LABEL_TYPE_SALE, __wf_atom_8e9ac384)))
					end
				elseif not state2.IsExternalProduct then
					local rounded, rounded2 = module3.__wf_atom_a94b426a(
						state2.StoreItem,
						nil,
						false,
						purchasedItems,
						false
					)
					local regularPrice, premiumPrice = module3.__wf_atom_a94b426a(
						state2.StoreItem,
						nil,
						true,
						purchasedItems,
						true
					)
					local specialPrice = 0

					if state2.RegularPrice ~= nil then
						regularPrice = state2.RegularPrice
						local ternary = module.Ternary
						local v20

						if state2.RegularPriceBeforeDiscount == nil then
							v20 = false
						else
							v20 = state2.RegularPriceBeforeDiscount > 0
						end

						rounded = ternary(v20, state2.RegularPriceBeforeDiscount, regularPrice)
					end

					if state2.PremiumPrice ~= nil then
						premiumPrice = state2.PremiumPrice
						rounded2 = premiumPrice
					end

					if state2.SpecialPrice ~= nil then
						specialPrice = state2.SpecialPrice
					end

					if v14 then
						state2.PurchaseQuantity = state2.StoreItem:__wf_atom_17d97bf6()

						if
							not v13
							and state2.BundleQuantity ~= nil
							and state2.PurchaseQuantity ~= nil
							and state2.BundleQuantity ~= state2.PurchaseQuantity
							and state2.PurchaseQuantity > 0
						then
							local v20 = state2.BundleQuantity / state2.PurchaseQuantity
							premiumPrice = module.Round(premiumPrice * v20, 0)
							regularPrice = module.Round(regularPrice * v20, 0)
							rounded2 = module.Round(rounded2 * v20, 0)
							rounded = module.Round(rounded * v20, 0)
						end
					end

					local v20 = premiumPrice > 0

					if v20 or regularPrice > 0 then
						local ternary = module.Ternary(v20, premiumPrice < rounded2, regularPrice < rounded)
						local formatNumber = module.FormatNumber(module.Ternary(v20, premiumPrice, regularPrice))
						local v21 = fn4(module.Ternary(v20, LABEL_TYPE_PLATINUM, LABEL_TYPE_CREDITS), formatNumber)

						if state2.RegularPriceBeforeDiscount ~= nil and regularPrice ~= rounded then
							v21.PricePostfix = fn20(object, regularPrice, rounded, state2.StoreItem)
							ternary = false
						end

						v21.ShowDiscount = not data.IgnoreDiscount and ternary
						v21.RegularPrice = module.Ternary(v20, rounded2, rounded)
						v21.HideInGrid = state2.Count ~= nil and state2.Count > 0 and not data.PriceIgnoreCount
							or not v20 and specialPrice > 0
						table.insert(result, v21)

						if ternary then
							module3.PopulateCouponInfo(state2)
							local saleInfo = module3.GetSaleInfo(state2.StoreItem)
							local v22 = not (__wf_atom_7e8ad928(saleInfo) or __wf_atom_7e8ad928(saleInfo.mDiscount))
							local v23 = not __wf_atom_7e8ad928(state2.Coupon)
								and not __wf_atom_7e8ad928(state2.Coupon.mExpiry)
								and Engine.__wf_atom_db2b0cee(state2.Coupon.mExpiry) > 0
							local v24 = v22 and (not v23 or state2.Coupon.mAmount < saleInfo.mDiscount / 100)

							if v22 and v24 then
								local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/DetailedPurchase_Discount",
									false,
									{
										DISCOUNT = module.FormatNumber(saleInfo.mDiscount)
									}
								)
								table.insert(result, (fn4(LABEL_TYPE_SALE, __wf_atom_8e9ac384)))
							elseif v23 then
								local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
									"/Lotus/Language/Menu/DetailedPurchase_Discount",
									false,
									{
										DISCOUNT = module.FormatNumber(state2.Coupon.mAmount * 100)
									}
								)
								table.insert(result, (fn4(LABEL_TYPE_COUPON, __wf_atom_8e9ac384)))
							end
						end
					elseif state2.BundleOnly then
						table.insert(result, (fn4(LABEL_TYPE_BUNDLE, "/Lotus/Language/Store/BundleOnly")))
					end
				end
			end
		end
	else
		local sellInfo = data.SellInfo
		local LABEL_TYPE_CREDITS = LABEL_TYPE_CREDITS

		if sellInfo.LabelType ~= nil then
			LABEL_TYPE_CREDITS = sellInfo.LabelType
		end

		local v15 = not __wf_atom_7e8ad928(state2.SellingPrice)

		if v15 then
			if state2.SellingPrice == 0 then
				v15 = false
			else
				v15 = not (state2.WillExpire or state2.PreventSelling)
			end
		end

		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/CantSell", false)

		if v15 then
			if
				state2.Category == 4
				and not (__wf_atom_7e8ad928(state2.RawItem) or __wf_atom_7e8ad928(state2.RawItem.mItemType) or state2.RawItem.mItemType:IsA(v8))
			then
				local __wf_atom_964b656f = state2.RawItem.mInstance:__wf_atom_964b656f(state2.RawItem.mUpgradeFingerprint)
				__wf_atom_8e9ac384 = module.FormatNumber(__wf_atom_964b656f)
			else
				__wf_atom_8e9ac384 = module.FormatNumber(state2.SellingPrice)
			end
		end

		state2.ShowDucatTag = LABEL_TYPE_CREDITS == LABEL_TYPE_DUCATS
		local v16 = fn4(LABEL_TYPE_CREDITS, __wf_atom_8e9ac384)
		v16.HideInGrid = module.Ternary(sellInfo.HideInGrid ~= nil, sellInfo.HideInGrid, true)
		table.insert(result, v16)
	end

	local productExpiryTime = module6.GetProductExpiryTime(state2)

	if productExpiryTime ~= 0 and data.CanShowExpiry then
		local v15

		if v13 then
			local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(productExpiryTime)
			v15 = not (__wf_atom_db2b0cee > 0) and "/Lotus/Language/Menu/Store_Expired"
				or object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Expires_Short", false, {
					TIME = module3.GetStoreTime(__wf_atom_db2b0cee)
				})
		else
			v15 = "/Lotus/Language/Menu/Store_Expires"
		end

		table.insert(result, (fn4(LABEL_TYPE_LIMITED, v15)))
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return {}
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return {}
	end

	local __wf_atom_92662866 = __wf_atom_9be88b01:__wf_atom_92662866()
	local v15 = false

	for _, v16 in ipairs(__wf_atom_92662866.mExperimentRecommended) do
		if not state2.StoreItem then
			continue
		end

		local v17

		if state2.StoreItem:IsPackage() then
			v17 = state2.StoreItem:__wf_atom_5b41f63b()
		else
			v17 = state2.StoreItem:__wf_atom_eca5585c()
		end

		if v16 ~= v17 then
			continue
		end

		v15 = true
		break
	end

	if __wf_atom_7e8ad928(state2.Count) or state2.Count == 0 then
		local __wf_atom_a04e4a53 = gGameData:__wf_atom_a04e4a53()
		local v16 = gGameData:__wf_atom_d5bed0b3() >= gGameData:__wf_atom_05cd7ba0(__wf_atom_a04e4a53 + 1)
		local __wf_atom_e0c949ff = gGameData:__wf_atom_e0c949ff()
		local v17

		if __wf_atom_e0c949ff > -604800 then
			v17 = __wf_atom_e0c949ff < 0
		else
			v17 = false
		end

		if not v16 and v17 then
			local _, v18 = module3.IsXPLocked(state2.StoreItem)

			if
				not __wf_atom_7e8ad928(v18)
				and not __wf_atom_7e8ad928(__wf_atom_a04e4a53)
				and v18 > 0
				and v18 == __wf_atom_a04e4a53
			then
				local v19 = fn4(LABEL_TYPE_MASTERY_UNLOCKED, "/Lotus/Language/Menu/Unlocked")
				v19.IconText = module.FormatNumber(v18)
				table.insert(result, v19)
			end
		end
	end

	if not __wf_atom_7e8ad928(state2.Tag) and state2.Tag ~= "" then
		if state2.Tag == "Popular" then
			table.insert(result, (fn4(LABEL_TYPE_RECOMMENDED, "/Lotus/Language/Menu/StorePopular")))
		elseif state2.Tag == "Premium" then
			table.insert(result, (fn4(LABEL_TYPE_RECOMMENDED, "/Lotus/Language/Menu/CategoryPremium")))
		elseif state2.Tag == "Recommended" then
			table.insert(result, (fn4(LABEL_TYPE_RECOMMENDED, "/Lotus/Language/Store/RecommendedTag")))
		end
	end

	if state2.IsPAUpgrade then
		table.insert(result, fn4(LABEL_TYPE_UPGRADE, ""))
	end

	if
		__wf_atom_7e8ad928(state2.Count)
		or data.HideOwned
		or not (state2.Count > module.Ternary(data.HideCountThreshold ~= nil, data.HideCountThreshold, 1))
	then
		if data.ShowCheckmark then
			table.insert(
				result,
				fn4(
					LABEL_TYPE_CHECKMARK,
					object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_Owned_Brief", true, {
						HOW_MANY = ""
					})
				)
			)
		else
			if (state2.IsNew or data.ForceNew) and data.CanShowNew and not v13 then
				table.insert(result, (fn4(LABEL_TYPE_NEW, "/Lotus/Language/Menu/Store_New")))
			elseif
				v15
				and (__wf_atom_7e8ad928(state2.Count) or state2.Count == 0)
				and not v13
				and __wf_atom_18a5d83b:__wf_atom_01fbbcf8("tag_recommended")
			then
				local flag = true

				if state2.StoreItem:IsPackage() then
					local __wf_atom_72915748 = state2.StoreItem:__wf_atom_72915748()

					for i = 1, #__wf_atom_72915748 do
						if not (module3.GetNumOwned(
							gGameData,
							gGameData:GetInventory(),
							__wf_atom_72915748[i].mTypeName,
							state.PurchasedItems
						) > 0) then
							continue
						end

						flag = false
						break
					end
				end

				if flag then
					table.insert(result, (fn4(LABEL_TYPE_RECOMMENDED, "/Lotus/Language/Store/RecommendedTag")))
				end
			end

			if state2.CanPreview then
				local ternary = module.Ternary(v13, "/Lotus/Language/OstronCrafting/Crafting_Preview_NoIcon", "")
				table.insert(result, fn4(LABEL_TYPE_PREVIEW, object:__wf_atom_8e9ac384(ternary, false)))
			end
		end
	else
		local ternary = module.Ternary(data.OwnedInfo ~= nil, data.OwnedInfo, {})
		local ternary2 = module.Ternary(
			ternary.TagOverride ~= nil,
			ternary.TagOverride,
			"/Lotus/Language/Menu/Crafting_Owned_Brief"
		)
		local ternary3 = module.Ternary
		local v16

		if state2.Count == 1 then
			v16 = not ternary.mShowOne
		else
			v16 = false
		end

		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(ternary2, true, {
			HOW_MANY = ternary3(v16, "", module.FormatNumber(state2.Count, 0))
		})
		local v17 = fn4(LABEL_TYPE_CHECKMARK, __wf_atom_8e9ac384)

		if ternary.TagOverride ~= nil and ternary.TagOverride ~= "/Lotus/Language/Menu/Crafting_Owned_Brief" then
			v17.Icon = nil
			v17.LabelOffset = 3
			v17.BgAlpha = 0
		end

		table.insert(result, v17)
	end

	if state2.Researched then
		local v16 = fn4(LABEL_TYPE_RESEARCHED, "")
		v16.PopUpLabel = "/Lotus/Language/Dojo/ResearchStatusComplete"
		table.insert(result, v16)
	elseif state2.Paused then
		local v16 = fn4(LABEL_TYPE_PAUSED, "")
		v16.PopUpLabel = "/Lotus/Language/Dojo/ResearchStatusPause"
		table.insert(result, v16)
	elseif state2.InProgress then
		local v16 = fn4(LABEL_TYPE_IN_PROGRESS, "")
		v16.PopUpLabel = "/Lotus/Language/Categories/IN_PROGRESS"
		table.insert(result, v16)
	elseif state2.AwaitingFunds then
		local v16 = fn4(LABEL_TYPE_CONTRIBUTE, "")
		v16.PopUpLabel = "/Lotus/Language/Dojo/ResearchStatusAwaitingFunds"
		table.insert(result, v16)
	end

	if state2.ShowLockIcon then
		local v16 = fn4(LABEL_TYPE_LOCK, "")
		v16.PopUpLabel = "/Lotus/Language/Menu/MissionLocked"
		table.insert(result, v16)
	end

	if state2.ShowCameraIcon then
		table.insert(result, (fn4(LABEL_TYPE_CAMERA, "")))
	end

	if state2.NumPortals == nil then
		if
			state2.Capacity ~= nil
			and not __wf_atom_7e8ad928(state2.Recipe)
			and state2.Recipe:IsA(__wf_atom_9125f355)
		then
			local __wf_atom_dcaa99d5 = state2.Recipe:__wf_atom_dcaa99d5()
			local count = #gRegion:FindAll(__wf_atom_dcaa99d5)

			if count > 0 then
				local v16 = fn4(
					LABEL_TYPE_CHECKMARK,
					object:__wf_atom_8e9ac384("/Lotus/Language/Dojo/NumBuilt", true, {
						AMOUNT = count
					})
				)
				v16.HideInGrid = true
				table.insert(result, v16)

				if state2.ShowCollecting and not __wf_atom_7e8ad928(_T.DojoMgr) then
					local mDecoTypeToDeco = _T.DojoMgr.mDecoTypeToDecos[__wf_atom_dcaa99d5:__wf_atom_5b41f63b()]
					local count2 = 0

					for k, v17 in pairs(mDecoTypeToDeco) do
						local _ = _T.DojoMgr.mIdToPlacedDecos[v17][k]

						if _T.DojoMgr.mDojo:__wf_atom_0d0c9d51(k):__wf_atom_644d0f1d() then
							count2 += 1
						end
					end

					if count2 > 0 then
						local v17 = fn4(
							LABEL_TYPE_UNIQUE_TEXT,
							object:__wf_atom_8e9ac384("/Lotus/Language/Dojo/NumUnfunded", true, {
								AMOUNT = count2
							})
						)
						v17.HideInGrid = true
						v17.LabelOffset = 2
						table.insert(result, v17)
					end
				end
			end

			if count == 0 and state2.Recipe:__wf_atom_55fcd0f2() > 0 then
				table.insert(
					result,
					(fn4(
						LABEL_TYPE_CLAN_XP,
						object:__wf_atom_8e9ac384("/Lotus/Language/Menu/OneTimeClanXp", true, {
							AMOUNT = module.FormatNumber(state2.Recipe:__wf_atom_55fcd0f2(), 0)
						})
					))
				)
			end
		end
	else
		local amount

		if __wf_atom_7e8ad928(_T.DojoMgr) or __wf_atom_7e8ad928(state2.Prefab) then
			amount = 0
		else
			amount = _T.DojoMgr.mDojo:__wf_atom_1fb6dc22(state2.Prefab)

			if amount > 0 then
				local v16 = fn4(
					LABEL_TYPE_CHECKMARK,
					object:__wf_atom_8e9ac384("/Lotus/Language/Dojo/NumBuilt", true, {
						AMOUNT = amount
					})
				)
				v16.HideInGrid = true
				table.insert(result, v16)
			end
		end

		if
			amount == 0
			and not __wf_atom_7e8ad928(state2.Recipe)
			and state2.Recipe:IsA(__wf_atom_3cecff09)
			and state2.Recipe:__wf_atom_55fcd0f2() > 0
		then
			table.insert(
				result,
				(fn4(
					LABEL_TYPE_CLAN_XP,
					object:__wf_atom_8e9ac384("/Lotus/Language/Menu/OneTimeClanXp", true, {
						AMOUNT = module.FormatNumber(state2.Recipe:__wf_atom_55fcd0f2(), 0)
					})
				))
			)
		end
	end

	if state2.EvoSkills ~= nil and state2.EvoSkills > 0 then
		local v16 = fn4(LABEL_TYPE_POLARIZED, "/Lotus/Language/Zariman/EvolutionPopupTag")
		v16.Icon = _G.UITexture_EvolutionLabelIcon
		v16.IconText = module.FormatNumber(state2.EvoSkills)
		table.insert(result, v16)
	end

	if state2.ArchonShards ~= nil then
		local v16 = fn4(
			LABEL_TYPE_ARCHON_SHARDS,
			object:__wf_atom_8e9ac384("/Lotus/Language/Alchemy/ArchonShardCount", false)
		)
		v16.IconText = module.FormatNumber(state2.ArchonShards)
		table.insert(result, v16)
	end

	if not (__wf_atom_7e8ad928(state2.RawItem) or __wf_atom_7e8ad928(state2.RawItem.mDominantTraits)) then
		local kubrowTypesTable = module3.GetKubrowTypesTable()
		local name = ""
		local icon = nil

		for i = 1, #kubrowTypesTable do
			if kubrowTypesTable[i].Type ~= state2.RawItem.mDominantTraits.mPersonality then
				continue
			end

			name = kubrowTypesTable[i].Name
			icon = kubrowTypesTable[i].Icon
			break
		end

		local v16 = fn4(LABEL_TYPE_MISC_ITEM, object:__wf_atom_8e9ac384(name, false))
		v16.Icon = icon
		v16.IconTintLabelColor = true
		v16.IconDims.H = 40
		v16.IconPos.Y = -8
		v16.LabelOffset = 40
		table.insert(result, v16)
		local v17, icon2

		if state2.RawItem.mIsMale == nil then
			v17 = ""
		else
			v17 = module.Ternary(
				state2.RawItem.mIsMale,
				"/Lotus/Language/Menu/KubrowMale",
				"/Lotus/Language/Menu/KubrowFemale"
			)
			icon2 = module.Ternary(state2.RawItem.mIsMale, _G.UITexture_GenderIcons[2], _G.UITexture_GenderIcons[1])
		end

		local v18 = fn4(LABEL_TYPE_MISC_ITEM, object:__wf_atom_8e9ac384(v17, false))
		v18.Icon = icon2
		v18.IconTintLabelColor = true
		v18.IconDims.W = 35
		v18.IconDims.H = 35
		v18.IconPos.Y = -5
		v18.LabelOffset = 40
		table.insert(result, v18)
	end

	if state2.WillExpire == true and not __wf_atom_7e8ad928(state2.RawItem) then
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(state2.RawItem.mExpiry.sec)
		local v16

		if __wf_atom_db2b0cee <= 0 then
			v16 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Expired", false)
		else
			v16 = module3.GetFullTime(__wf_atom_db2b0cee)
		end

		table.insert(result, (fn4(LABEL_TYPE_TIMER, v16)))
	elseif
		not __wf_atom_7e8ad928(state2.Type)
		and state2.Type:IsA(__wf_atom_d5a2d4b7)
		and SF.CountedItem(state2.Type, 1):__wf_atom_fb43e353() > 0
	then
		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(gGameData:__wf_atom_11351897())
		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(
			"/Lotus/Language/CraftingComponents/DecayRate_Timer",
			false,
			{
				TIME = module3.GetStoreTime(__wf_atom_db2b0cee)
			}
		)
		local v16 = fn4(LABEL_TYPE_TIMER, __wf_atom_8e9ac384)
		v16.HideInGrid = true
		table.insert(result, v16)
	end

	if not (__wf_atom_7e8ad928(state2.ResultStoreItem) or __wf_atom_7e8ad928(purchasedItems) or __wf_atom_7e8ad928(gGameData)) then
		local count = 0

		if state.PurchasedIsDictionary then
			local purchasedItem = purchasedItems[state2.ResultStoreItem:__wf_atom_eca5585c()]

			if not __wf_atom_7e8ad928(purchasedItem) then
				count = purchasedItem.Count
			end
		else
			count = module3.GetNumOwned(gGameData, gGameData:GetInventory(), state2.ResultStoreItem, purchasedItems)
		end

		if count > 0 and (state2.Category == nil or state2.Category ~= 43 and state2.Category ~= 46) then
			local v16

			if count == 1 then
				v16 = object:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/CraftedSingular", false)
			else
				v16 = object:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/CraftedPlural", false, {
					COUNT = module.FormatNumber(count)
				})
			end

			if
				state2.Category == 6
				and not (data.ShowCheckmark or data.HideOwned)
				and (__wf_atom_7e8ad928(state2.Count) or state2.Count <= module.Ternary(
					data.HideCountThreshold ~= nil,
					data.HideCountThreshold,
					1
				))
			then
				table.insert(
					result,
					fn4(
						LABEL_TYPE_CHECKMARK,
						object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Crafting_Owned_Brief", true, {
							HOW_MANY = ""
						})
					)
				)
			end

			table.insert(result, (fn4(LABEL_TYPE_CRAFTED, v16)))
		end
	end

	if not __wf_atom_7e8ad928(state2.Arcane) then
		if state2.CanReproc == nil then
			state2.CanReproc = not __wf_atom_7e8ad928(state2.Arcane.mInstance)
				and state2.Arcane.mInstance:CanReproc()
				and not state2.Arcane.mInstance:__wf_atom_7ff8366d()
		end

		if state2.CanReproc then
			table.insert(
				result,
				(fn4(
					LABEL_TYPE_ARCANE_REPROC,
					object:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArcaneManager_CanReproc", false)
				))
			)
		end
	end

	if not __wf_atom_7e8ad928(state2.Type) and state2.Type:IsA(v3) then
		local v16 = fn21(state2.Type)

		if v16 ~= nil then
			table.insert(result, v16)
		end
	end

	if not __wf_atom_7e8ad928(state2.StoreItem) then
		if not data.HideMastery then
			local isXPLocked, v16 = module3.IsXPLocked(state2.StoreItem)

			if isXPLocked or v16 ~= nil and v16 > 0 then
				local v17 = fn4(LABEL_TYPE_REQUIRED_MASTERY, "")
				v17.PopUpLabel = "/SortingLabels/MasteryRank"
				v17.IconText = module.FormatNumber(v16)
				table.insert(result, v17)
			end
		end

		if state2.StoreItem:__wf_atom_955f7fe0() then
			local v16 = fn4(LABEL_TYPE_UGC, "")

			if not v13 and not __wf_atom_7e8ad928(state) and state.ElementWidth ~= nil then
				v16.ClipOffset = state.ElementWidth
			end

			table.insert(result, v16)
		end

		if
			(state2.Category == 13 or state2.Category == 2 and state2.StoreItem:__wf_atom_efa6f447() == 13)
			and not state2.StoreItem:__wf_atom_7a2dbfd5()
		then
			local v16 = fn4(LABEL_TYPE_REUSABLE_BLUEPRINT, "")

			if not v13 and not __wf_atom_7e8ad928(state) and state.ElementWidth ~= nil then
				v16.ClipOffset = state.ElementWidth
			end

			table.insert(result, v16)
		end

		if not __wf_atom_7e8ad928(purchasedItems) then
			local __wf_atom_ecd05e96 = state2.StoreItem:__wf_atom_ecd05e96()

			if not __wf_atom_7e8ad928(__wf_atom_ecd05e96) then
				local count = 0

				if state.PurchasedIsDictionary then
					local purchasedItem = purchasedItems[__wf_atom_ecd05e96:__wf_atom_5b41f63b()]

					if not __wf_atom_7e8ad928(purchasedItem) then
						count = purchasedItem.Count
					end
				else
					count = module3.GetRecipesOwned(__wf_atom_ecd05e96, purchasedItems)
				end

				if count > 0 then
					local v16

					if count == 1 then
						v16 = object:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/RecipeOwnedSingular", false)
					else
						v16 = object:__wf_atom_8e9ac384("/Lotus/Language/CraftingComponents/RecipeOwnedPlural", false, {
							COUNT = module.FormatNumber(count)
						})
					end

					table.insert(result, (fn4(LABEL_TYPE_RECIPES, v16)))
				end
			end
		end
	end

	if
		state == nil
		or not state.mShowFav
		or state2 == nil
		or state2.BuySlot
		or __wf_atom_7e8ad928(state2.StoreItem)
	then
		return result
	end

	local v16 = fn4(LABEL_TYPE_FAVORITE, "")

	if not v13 and not __wf_atom_7e8ad928(state) and state.ElementWidth ~= nil then
		v16.ClipOffset = state.ElementWidth
	end

	table.insert(result, v16)
	return result
end

function GetGridItemTags(p, p2, p3, p4, p5)
	return fn22(p, p2, p3, p4, p5)
end

function DrawGridItem(object, infoPopup_Grid, state, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local metaData = __wf_atom_7e8ad928(p) and {} or p
	metaData.FromRedraw = true
	state.Labels = {}
	local mClipName = state.mClipName
	local filler = state.Filler or metaData.IsFiller
	local emptySlot = state.EmptySlot
	local isNone = state.IsNone
	local v13 = not __wf_atom_7e8ad928(infoPopup_Grid)
		and not __wf_atom_7e8ad928(infoPopup_Grid.ElementWidth)
		and infoPopup_Grid.ElementWidth <= 150
	local v14, v15 = fn19(object, infoPopup_Grid, state, metaData)
	object:__wf_atom_7f57ab2f(mClipName, "Btn", 67, not filler)
	local v16 = fn22(object, infoPopup_Grid, state, metaData, v15)
	local count = 0
	local v17 = 1
	local total = 0
	local total2 = 0

	for _, v18 in ipairs(v16) do
		local showInGrid = not __wf_atom_7e8ad928(v18.ShowInGrid) and v18.ShowInGrid

		if v18.Type == LABEL_TYPE_SALE or v18.Type == LABEL_TYPE_COUPON then
			showInGrid = metaData.ShowDiscountOnGrid
				and (__wf_atom_7e8ad928(state.Count) or state.Count == 0)
				and true
				or showInGrid
		end

		local excludeFromSmallGrid = not __wf_atom_7e8ad928(v18.ExcludeFromSmallGrid) and v18.ExcludeFromSmallGrid
		v18.Visible = not v13 and showInGrid or v13 and showInGrid and not excludeFromSmallGrid

		if v18.Visible and not v18.HideInGrid then
			count += 1
		end

		v18.HideTagLabel = metaData.HideTagLabel

		if not (v18.Type == LABEL_TYPE_PLATINUM or v18.Type == LABEL_TYPE_PRIMETOKENS) then
			continue
		end

		v18.BackerTexture = infoPopup_Grid.TagBackerTexture
		v18.BackerCapTexture = infoPopup_Grid.TagBackerCapTexture
		v18.BackerMaterial = infoPopup_Grid.ColorRemapMaterial
	end

	for _, v18 in ipairs(v16) do
		local v19
		v19, v17 = fn11(object, mClipName, v17)

		if #v18.CallbackPrefix > 0 then
			object:__wf_atom_4c1c1986(v19, "Bg", 100, state.Id)
			object:__wf_atom_7f57ab2f(v19, "Bg", 67, true)
		else
			object:__wf_atom_7f57ab2f(v19, "Bg", 67, false)
		end

		fn10(object, v19, v18, true)
		table.insert(state.Labels, v18)

		if v18.mGridLabelTag ~= nil and count == 0 then
			v18.mShowItemPrice = true
		end

		local mShowItemPrice = not __wf_atom_7e8ad928(v18.mShowItemPrice) and v18.mShowItemPrice

		if v18.Visible or mShowItemPrice then
			mShowItemPrice = not v18.HideInGrid
		end

		v18.Visible = mShowItemPrice

		if not v18.Visible then
			continue
		end

		object:__wf_atom_290807ee(v19)
		object:__wf_atom_e57658c2(v19, 12, 100)

		if v18.RightAlign then
			if v18.BackerTexture ~= nil then
				total += 1
			end

			object:__wf_atom_e57658c2(v19, 1, total)
			total += 26

			if v18.BackerTexture ~= nil then
				total += 4
			end
		else
			if v18.BackerTexture ~= nil then
				total2 += 1
			end

			object:__wf_atom_e57658c2(v19, 1, total2)
			total2 += 26

			if v18.BackerTexture ~= nil then
				total2 += 4
			end
		end
	end

	local ternary = module.Ternary(
		__wf_atom_7e8ad928(infoPopup_Grid.RectangleVisibleRangeMaterial),
		_G.UIMaterial_RectangleNoDepth,
		infoPopup_Grid.RectangleVisibleRangeMaterial
	)

	if not __wf_atom_7e8ad928(ternary) then
		for i = 1, #v16 do
			local v18 = ".TagContainer.Tag" .. tostring(i)

			if v16[i].Type == LABEL_TYPE_NEW and infoPopup_Grid.RippleRectMaterial ~= nil then
				object:OverrideMaterial(mClipName .. v18 .. ".Bg", infoPopup_Grid.RippleRectMaterial)
				object:OverrideMaterial(mClipName .. v18 .. ".IconTextBg", nil)
			elseif
				(v16[i].Type == LABEL_TYPE_PLATINUM or v16[i].Type == LABEL_TYPE_PRIMETOKENS or v16[i].RemapColors)
				and infoPopup_Grid.ColorRemapMaterial ~= nil
			then
				object:OverrideMaterial(mClipName .. v18 .. ".Bg", infoPopup_Grid.ColorRemapMaterial)
				object:OverrideMaterial(mClipName .. v18 .. ".IconTextBg", infoPopup_Grid.ColorRemapMaterial)
			else
				object:OverrideMaterial(mClipName .. v18 .. ".Bg", ternary)
				object:OverrideMaterial(mClipName .. v18 .. ".IconTextBg", nil)
			end
		end
	end

	local v18 = mClipName .. ".TagContainer.Tag1"
	local v19 = 1

	while object:__wf_atom_253d7085(v18) do
		object:__wf_atom_2dedec1a(v18, 13, not filler and v19 < v17)
		v19 += 1
		v18 = mClipName .. ".TagContainer.Tag" .. tostring(v19)
	end

	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 14)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(mClipName .. ".RectangleBg", 15)
	local v20 = __wf_atom_5e6e15c8 == nil and 0 or __wf_atom_5e6e15c8
	local v21 = __wf_atom_5e6e15c8_2 == nil and 0 or __wf_atom_5e6e15c8_2
	object:__wf_atom_4c1c1986(mClipName, "TagContainer", 0, -(v20 / 2) + 0.5)
	object:__wf_atom_4c1c1986(mClipName, "TagContainer", 1, -(v21 / 2) + 0.5)

	if metaData.UpdateLabelsOnly then
		return
	end

	object:__wf_atom_7f57ab2f(mClipName, "Check", 13, metaData.ShowComplete == true)
	local v22 = not (__wf_atom_7e8ad928(state.Card) or module2.IsLegendaryFusion(state.Card))
	local v23, v24

	if __wf_atom_7e8ad928(state.Type) then
		v23 = false
		v24 = false
	else
		v23 = state.Type:IsA(v3)
		v24 = state.Type:IsA(__wf_atom_50a5232d)
		local v25 = state.Type:IsA(__wf_atom_58a409f1) or not __wf_atom_7e8ad928(state.UpgradeInfo)
		v22 = v22 or v25 and not (v23 or state.Type:IsA(v4))
	end

	local v25

	if v14 == "" then
		v25 = false
	else
		v25 = emptySlot
			or isNone
			or (not infoPopup_Grid.mHideArcaneRank and v23 and true or false) and not state.NotOwned

		if not v25 then
			if v22 or not (infoPopup_Grid.mShowLabels or state.mShowLabel) then
				v25 = v22 and infoPopup_Grid.mShowModLabels and not filler
			else
				v25 = not filler
			end
		end
	end

	local v26 = v25 == true
	object:__wf_atom_7f57ab2f(mClipName, "ItemName", 13, v26)
	object:__wf_atom_7f57ab2f(mClipName, "NameBg", 13, v26 and infoPopup_Grid.BackerWidth == nil)
	object:__wf_atom_7f57ab2f(mClipName, "Mod", 13, v22)

	if v22 then
		local card

		if __wf_atom_7e8ad928(state.Card) then
			if __wf_atom_7e8ad928(state.UpgradeInfo) then
				local upgradeInfo = SF.UpgradeInfo()
				upgradeInfo.mItemType = state.Type

				if state.UpgradeFingerprint == nil then
					if not upgradeInfo.mItemType:IsA(module2.immortalModType) then
						upgradeInfo.mUpgradeFingerprint = upgradeInfo.mInstance:__wf_atom_254ac1f5(upgradeInfo.mInstance:__wf_atom_49f7d220(""))
					end
				else
					upgradeInfo.mUpgradeFingerprint = state.UpgradeFingerprint
				end

				card = module2.CardFromArtifact(upgradeInfo, 1)
			else
				card = module2.CardFromArtifact(state.UpgradeInfo, 1)

				if state.UpgradeNameOverride ~= nil then
					card.mName = state.UpgradeNameOverride
				end
			end
		else
			card = state.Card
		end

		local mMod = {
			mClipName = mClipName .. ".Mod",
			Card = card,
			mPolarity = 0,
			Count = state.Count
		}
		state.mMod = mMod
		module2.DrawCard(mMod, nil, nil, nil, nil, state.OverrideCardCount)
		object:__wf_atom_7f57ab2f(mClipName, "Mod.Btn", 67, false)
	elseif v14 == nil then
		if emptySlot then
			v14 = Localize("/Lotus/Language/Menu/Loadout_EmptySlotToolTip", false)
		else
			v14 = not isNone and "" or Localize("/Lotus/Language/Menu/Cosmetics_None", false)
		end
	end

	if v14 ~= nil then
		if not state.SkipTitleCase then
			v14 = TitleCase(v14)

			if string.find(v14, "Tennogen") ~= nil then
				v14 = string.gsub(v14, "Tennogen", "TennoGen")
			end
		end

		object:__wf_atom_48bd5a59(mClipName, "ItemName", 46, "bottom")
		object:__wf_atom_48bd5a59(mClipName, "ItemName", 36, v14)
		local __wf_atom_5e6e15c8_3 = object:__wf_atom_5e6e15c8(mClipName .. ".ItemName", 41)

		if __wf_atom_5e6e15c8_3 ~= nil then
			object:__wf_atom_4c1c1986(mClipName, "NameBg", 15, __wf_atom_5e6e15c8_3 + 15)
		end
	end

	if
		__wf_atom_7e8ad928(state.Icon)
		and not (state.IconMissing or state.HideIcon or filler or isNone or emptySlot)
	then
		print("Missing icon data!")
	end

	object:__wf_atom_7f57ab2f(
		mClipName,
		"ImageContainer",
		13,
		emptySlot or __wf_atom_7e8ad928(state.mMod) and not (__wf_atom_7e8ad928(state.Icon) or state.HideIcon) and not filler or not __wf_atom_7e8ad928(state.IsColorGrid) and state.IsColorGrid
	)
	object:__wf_atom_4c1c1986(mClipName, "ImageContainer", 12, emptySlot and 30 or state.ShadowIcon and 50 or 100)
	local iconHeight = state.IconHeight or v21 - 4
	local iconWidth = state.IconWidth or iconHeight

	if __wf_atom_7e8ad928(state.Icon) then
		if emptySlot or isNone then
			object:__wf_atom_c90af43a(mClipName .. ".ImageContainer.Image", _G.UITexture_EmptySlot)
			object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 14, v21 - 32)
			object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 15, v21 - 32)

			if not __wf_atom_7e8ad928(infoPopup_Grid.VisibleRangeMaterial) then
				object:OverrideMaterial(mClipName .. ".ImageContainer.Image", infoPopup_Grid.VisibleRangeMaterial)
			end
		end
	else
		object:__wf_atom_c90af43a(mClipName .. ".ImageContainer.Image", state.Icon)
		object:__wf_atom_4c1c1986(
			mClipName,
			"ImageContainer",
			16,
			(module.Ternary(state.IconRotation ~= nil, state.IconRotation, 0))
		)
		object:__wf_atom_4c1c1986(
			mClipName,
			"ImageContainer.Image",
			14,
			(state.Themed or state.IconWidth ~= nil) and iconWidth or iconWidth * 1.6
		)
		object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 15, iconHeight)
		local ternary2 = module.Ternary(
			__wf_atom_7e8ad928(state.Material),
			infoPopup_Grid.VisibleRangeMaterial,
			state.Material
		)
		object:OverrideMaterial(mClipName .. ".ImageContainer.Image", ternary2)

		if
			not __wf_atom_7e8ad928(state.Type) and state.Type:IsA(__wf_atom_f6dea198)
			or not __wf_atom_7e8ad928(state.ResultItemType) and state.ResultItemType:IsA(__wf_atom_f6dea198)
		then
			local material = state.Material

			if __wf_atom_7e8ad928(material) then
				object:__wf_atom_1ca72041(mClipName .. ".ImageContainer.Image", "DetailMapParams", 0, 6, 1, 1)
			else
				local v27 = Symbol("DetailMapParams")
				local __wf_atom_b90af225 = material:__wf_atom_b90af225(v27, 1)
				local __wf_atom_b90af225_2 = material:__wf_atom_b90af225(v27, 2)
				local __wf_atom_b90af225_3 = material:__wf_atom_b90af225(v27, 3)
				local __wf_atom_b90af225_4 = material:__wf_atom_b90af225(v27, 4)
				object:__wf_atom_1ca72041(
					mClipName .. ".ImageContainer.Image",
					"DetailMapParams",
					__wf_atom_b90af225,
					__wf_atom_b90af225_2,
					__wf_atom_b90af225_3,
					__wf_atom_b90af225_4
				)
			end
		elseif not v24 then
			object:__wf_atom_1ca72041(mClipName .. ".ImageContainer.Image", "DetailMapParams", 1, 0, 1, 1)
		end

		if __wf_atom_7e8ad928(state.ShadowMaterial) then
			module.Ternary(
				__wf_atom_7e8ad928(infoPopup_Grid.ShadowVisibleRangeMaterial),
				infoPopup_Grid.VisibleRangeMaterial,
				infoPopup_Grid.ShadowVisibleRangeMaterial
			)
		end

		if state.Color ~= nil then
			local v27 = state.Color.red / 255
			local v28 = state.Color.green / 255
			local v29 = state.Color.blue / 255
			object:__wf_atom_1ca72041(mClipName .. ".ImageContainer.Image", "DetailMapTint", v27, v28, v29, 1)
		end
	end

	object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 1, module.Ternary(emptySlot or isNone, -3, 0))

	if state.IsColorGrid then
		object:__wf_atom_4c1c1986(mClipName, "ImageContainer", 11, state.Color)
		object:__wf_atom_4c1c1986(
			mClipName,
			"ImageContainer.Image",
			14,
			(state.Themed or state.IconWidth ~= nil) and iconWidth or iconWidth * 1.6
		)
		object:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 15, iconHeight)
		local ternary2 = module.Ternary(
			__wf_atom_7e8ad928(state.Material),
			infoPopup_Grid.VisibleRangeMaterial,
			state.Material
		)
		object:OverrideMaterial(mClipName .. ".ImageContainer.Image", ternary2)
	end

	object:__wf_atom_4c1c1986(
		mClipName,
		"Background",
		12,
		module.Ternary(not (__wf_atom_7e8ad928(state.Background) or filler), 100, 0)
	)
	object:__wf_atom_c90af43a(mClipName .. ".Background", state.Background)
	object:__wf_atom_4c1c1986(mClipName, "Background", 14, iconWidth)
	object:__wf_atom_4c1c1986(mClipName, "Background", 15, iconHeight)
	object:OverrideMaterial(mClipName .. ".RectangleBg", ternary)
	object:__wf_atom_4c1c1986(
		mClipName,
		"CornerPiece",
		12,
		module.Ternary(infoPopup_Grid.mUseCornerForSelected and metaData.IsSelected, 100, 0)
	)
	object:__wf_atom_7f57ab2f(mClipName, "Locked", 13, metaData.Locked == true)

	if metaData.Locked then
		local v27 = { Width = 24, Height = 24 }
		local v28 = not metaData.HideLockLabel
		object:__wf_atom_7f57ab2f(mClipName, "Locked.Label", 13, v28)
		object:__wf_atom_7f57ab2f(mClipName, "Locked.LabelBg", 13, v28)
		object:__wf_atom_48bd5a59(mClipName, "Locked.Label", 46, "center")
		object:__wf_atom_48bd5a59(
			mClipName,
			"Locked.Label",
			36,
			(string.upper(object:__wf_atom_8e9ac384(
				module.Ternary(metaData.LockedMsg ~= nil, metaData.LockedMsg, ""),
				true
			)))
		)
		local __wf_atom_cfc41e35 = object:__wf_atom_cfc41e35(mClipName, "Locked.Label", 41)
		object:__wf_atom_4c1c1986(mClipName, "Locked.LabelBg", 15, __wf_atom_cfc41e35 + 6)
		object:__wf_atom_4c1c1986(
			mClipName,
			"Locked.LockIcon",
			1,
			-(__wf_atom_cfc41e35 / 2) - (metaData.LockedIconY or 16)
		)
		local lockIconWidth = metaData.LockIconWidth or module.Ternary(v28, v27.Width, v27.Width * 2)
		local lockIconHeight = metaData.LockIconHeight or module.Ternary(v28, v27.Height, v27.Height * 2)
		object:__wf_atom_4c1c1986(mClipName, "Locked.LockIcon", 14, lockIconWidth)
		object:__wf_atom_4c1c1986(mClipName, "Locked.LockIcon", 15, lockIconHeight)
		object:__wf_atom_c90af43a(mClipName .. ".Locked.LockIcon", metaData.LockedIcon or _G.UITexture_Locked)
		object:__wf_atom_7f57ab2f(
			mClipName,
			"Locked.LockIcon",
			13,
			metaData.HideLockIcon == nil or not metaData.HideLockIcon
		)
	end

	object:__wf_atom_7f57ab2f(mClipName, "Flare", 13, false)

	if __wf_atom_7e8ad928(infoPopup_Grid.VisibleRangeMaterial) then
		if infoPopup_Grid.RippleMaterial ~= nil then
			for i = 1, #v16 do
				local v27 = ".TagContainer.Tag" .. tostring(i)

				if v16[i].Type == LABEL_TYPE_NEW then
					object:OverrideMaterial(mClipName .. v27 .. ".Icon", infoPopup_Grid.RippleMaterial)
				else
					object:OverrideMaterial(mClipName .. v27 .. ".Icon", nil)
				end
			end
		end
	else
		local v27 = {
			".Background",
			".Blurer",
			".Locked.LabelBg",
			".Locked.Gradient",
			".Locked.LockIcon",
			".Highlight",
			".NameBg",
			".CornerPiece"
		}

		for i = 1, #v16 do
			local v28 = ".TagContainer.Tag" .. tostring(i)

			if v16[i].Type == LABEL_TYPE_NEW and infoPopup_Grid.RippleMaterial ~= nil then
				object:OverrideMaterial(mClipName .. v28 .. ".Icon", infoPopup_Grid.RippleMaterial)
			else
				table.insert(v27, v28 .. ".Icon")
				table.insert(v27, v28 .. ".Strikethrough")
			end
		end

		for _, v28 in ipairs(v27) do
			object:OverrideMaterial(mClipName .. v28, infoPopup_Grid.VisibleRangeMaterial)
		end
	end

	if not __wf_atom_7e8ad928(infoPopup_Grid.TextVisibleRangeMaterial) then
		local v27 = { ".ItemName", ".Locked.Label" }

		for i = 1, #v16 do
			local v28 = ".TagContainer.Tag" .. tostring(i)
			table.insert(v27, v28 .. ".Label")
			table.insert(v27, v28 .. ".IconText")
		end

		for _, v28 in ipairs(v27) do
			object:OverrideMaterial(mClipName .. v28, infoPopup_Grid.TextVisibleRangeMaterial)
		end
	end

	state.MetaData = metaData
	fn15(object, infoPopup_Grid, state, metaData)
end

local function fn23(data, data2, p, p2, p3)
	local mMovie = data.mMovie
	local mClipName = data2.mClipName
	local emptySlot = data2.EmptySlot or data2.IsNone
	local color = module4.GetColor(2, true, data.ApplyThemes)
	local backgroundColor = data2.BackgroundColor

	if backgroundColor == nil then
		if p3 or data2.Count ~= nil and data2.Count ~= 0 or emptySlot then
			backgroundColor = data.UTIL.ConvertColorNumberToProceduralRGB(color)
		else
			backgroundColor = data.UTIL.ConvertColorNumberToProceduralRGB(module4.GetColor(3, true, data.ApplyThemes))
		end
	end

	local v13 = data.mEdgeColor == nil and 1 or data.mEdgeColor
	local convertColorNumberToProceduralRGB = data.UTIL.ConvertColorNumberToProceduralRGB(module4.GetColor(v13, true, data.ApplyThemes))
	local mEdgeAlpha = not (p or p2) and 5 or data.UTIL.Ternary(p2, 50, 20)

	if data.mEdgeAlpha ~= nil then
		mEdgeAlpha = data.mEdgeAlpha
	end

	if data.mEdgeAlphaOffset ~= nil then
		mEdgeAlpha += data.mEdgeAlphaOffset
	end

	if data.mFillerEdgeAlpha ~= nil and data2.Filler then
		mEdgeAlpha = data.mFillerEdgeAlpha
	end

	mMovie:__wf_atom_1ca72041(
		mClipName .. ".RectangleBg",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		mEdgeAlpha / 100
	)
	local mInnerAlpha = p and 50 or data2.Filler and 5 or 25

	if data.mInnerAlpha ~= nil then
		mInnerAlpha = data.mInnerAlpha
	end

	if data.mInnerAlphaOffset ~= nil and not (data.mIgnoreInnerOffsetForFiller and data2.Filler) then
		mInnerAlpha += data.mInnerAlphaOffset
	end

	mMovie:__wf_atom_1ca72041(
		mClipName .. ".RectangleBg",
		"RectInnerColor",
		backgroundColor.r,
		backgroundColor.g,
		backgroundColor.b,
		mInnerAlpha / 100
	)

	if data2.Labels ~= nil then
		for i, label in ipairs(data2.Labels) do
			if label.Visible then
				fn10(mMovie, fn11(mMovie, mClipName, i), label, true)
			end
		end
	end

	local v14 = 0

	if p2 then
		v14 = __wf_atom_7e8ad928(data.mHighlightAlphaSelectedOverride) and 25 or data.mHighlightAlphaSelectedOverride
	elseif p then
		v14 = __wf_atom_7e8ad928(data.mHighlightAlphaFocusedOverride) and 15 or data.mHighlightAlphaFocusedOverride
	end

	local color2 = module4.GetColor(6, true, data.ApplyThemes)
	local color3 = module4.GetColor(9, true, data.ApplyThemes)
	mMovie:__wf_atom_4c1c1986(mClipName, "Background", 11, color3)
	local color4 = module4.GetColor(10, true, data.ApplyThemes)
	mMovie:__wf_atom_4c1c1986(mClipName, "CornerPiece", 11, color4)
	local v15

	if data2.LockedIconColor then
		v15 = module4.GetColor(data2.LockedIconColor, true, data.ApplyThemes)
	else
		v15 = color3
	end

	mMovie:__wf_atom_4c1c1986(mClipName, "ItemName", 44, data.UTIL.Ternary(p, color4, color3))
	mMovie:__wf_atom_4c1c1986(mClipName, "ItemName", 90, color)
	mMovie:__wf_atom_4c1c1986(mClipName, "NameBg", 12, 65)
	mMovie:__wf_atom_4c1c1986(mClipName, "NameBg", 11, color)
	mMovie:__wf_atom_4c1c1986(mClipName, "Locked.Label", 11, color2)
	mMovie:__wf_atom_4c1c1986(mClipName, "Locked.LabelBg", 12, 80)
	mMovie:__wf_atom_4c1c1986(mClipName, "Locked.LabelBg", 11, color)
	mMovie:__wf_atom_4c1c1986(mClipName, "Locked.LockIcon", 12, data2.LockIconAlpha or 60)
	mMovie:__wf_atom_4c1c1986(mClipName, "Locked.LockIcon", 11, v15)
	mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 12, v14)

	if p2 or p then
		mMovie:__wf_atom_4c1c1986(mClipName, "Highlight", 11, color4)
	end

	mMovie:__wf_atom_4c1c1986(mClipName, "Check", 11, color4)
	local uiColor_White = _G.UIColor_White

	if data2.IconColor == nil then
		if emptySlot then
			uiColor_White = color3
		end
	elseif type(data2.IconColor) == "string" then
		uiColor_White = tonumber(data2.IconColor)
	else
		uiColor_White = module4.GetColor(data2.IconColor, true, data.ApplyThemes)
	end

	mMovie:__wf_atom_4c1c1986(mClipName, "ImageContainer.Image", 11, uiColor_White)

	for i = 1, #data2.ExtraShaderVars do
		local color5 = module4.GetColor(data2.ExtraShaderVars[i].v, false, data.ApplyThemes)
		mMovie:__wf_atom_1ca72041(
			mClipName .. ".ImageContainer.Image",
			data2.ExtraShaderVars[i].k,
			color5.red / 255,
			color5.green / 255,
			color5.blue / 255,
			1
		)
	end
end

function UpdateGridItemColors(p, p2, p3, p4, p5)
	fn23(p, p2, p3, p4, p5)
end

function SetupLoginLighting(p, object, lightMapTint, p2)
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_8ad59546()) then
		return
	end

	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Sunlight"))
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local v13 = Vector(0, 1.5, -0.25)
	local v14 = #all ~= 0

	if v14 then
		v13 = Vector(1, 1, -0.25)
	else
		for _, v15 in pairs(__wf_atom_2226b35c) do
			if __wf_atom_7e8ad928(v15) then
				continue
			end

			if p then
				v15:TurnOff()
			else
				v15:TurnOn()
			end
		end
	end

	if p then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v15 = Color(255, 255, 255)
		local v16

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			v16 = __wf_atom_c4f78a8f:Attach(p2, EMPTY_SYMBOL, v13, Rotation(0, 90, 0))

			if not __wf_atom_7e8ad928(v16) then
				local color = module4.GetColor(13)
				v16:SetColor(color)
				local __wf_atom_7b3a5764 = v16:__wf_atom_7b3a5764()

				if v14 then
					__wf_atom_7b3a5764 *= 0.5
				end

				if color:__wf_atom_72a05e4d() > 0.5 then
					__wf_atom_7b3a5764 *= 0.3
				end

				v16:__wf_atom_edd3fec6(__wf_atom_7b3a5764)

				if not v14 then
					v15 = Color(postProcess.lightMapTint)
					postProcess.lightMapTint = Color(255, 255, 255)
				end

				local __wf_atom_e800787c = __wf_atom_c4f78a8f:__wf_atom_e800787c()

				if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
					__wf_atom_e800787c:__wf_atom_515109d7(Color(), Color(), Color())
				end
			end
		end

		return v16, v15
	else
		if not v14 then
			if __wf_atom_7e8ad928(lightMapTint) then
				lightMapTint = Color(255, 255, 255)
			end

			postProcess.lightMapTint = lightMapTint
		end

		if not __wf_atom_7e8ad928(object) then
			object:__wf_atom_d9b3db95(true)
			object:TurnOff()
		end
	end
end

local function fn24(object, p, p2, p3)
	local module7 = require("Lotus.Interface.Components.TitleBar")
	object:__wf_atom_c90af43a(p .. ".Fill", module7.UnderlineFillTexture)
	object:__wf_atom_c90af43a(p .. ".CapRight", module7.UnderlineCapTexture)
	object:__wf_atom_c90af43a(p .. ".CapLeft", module7.UnderlineStartTexture)
	local v13 = p3 == nil or p3.Left
	local v14 = p3 == nil or p3.Right
	object:__wf_atom_7f57ab2f(p, "CapLeft", 13, v13)
	object:__wf_atom_7f57ab2f(p, "CapRight", 13, v14)

	if p2 ~= nil then
		object:__wf_atom_4c1c1986(p, "Fill", 14, p2 - 64)
		object:__wf_atom_4c1c1986(p, "CapRight", 0, p2 - 32)
	end
end

function DrawSeparator(p, p2, p3, p4)
	fn24(p, p2, p3, p4)
end

local function fn25(object, p, value, value2, p2, p3)
	local v13 = (value or 1) - 1
	local flag = false
	local v14 = p2 or Color(255, 255, 255)
	local v15 = p3 or Color(232, 93, 93)

	local function fn26(p4)
		local v16

		if flag then
			v16 = v15:__wf_atom_104bfe98(v14, p4)
		else
			v16 = v14:__wf_atom_104bfe98(v15, p4)
		end

		object:__wf_atom_e57658c2(p, 11, v16:__wf_atom_dcecedb0())
	end

	__wf_atom_ec43d06e(object, p, 8, { fn26 }, { 1 }, 0.25, value2 or 0, function()
		flag = true
		__wf_atom_ec43d06e(object, p, 8, { fn26 }, { 1 }, 0.25, 0, function()
			if v13 > 0 then
				fn25(object, p, v13, 0, v14, v15)
			end
		end)
	end)
end

function PulseColor(p, p2, p3, p4, p5, p6)
	fn25(p, p2, p3, p4, p5, p6)
end

function GetItemInfoDesc(object, data, p)
	local v13 = ""
	local storeItem = data.StoreItem

	if not __wf_atom_7e8ad928(storeItem) then
		storeItem:__wf_atom_efa6f447()
	end

	local convertColorNumberToHex = module.ConvertColorNumberToHex(module4.GetColor(6, true))
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(module4.GetColor(5, true))

	if
		__wf_atom_7e8ad928(storeItem)
		or __wf_atom_7e8ad928(storeItem:GetItem())
		or not storeItem:GetItem():IsA(__wf_atom_6317e6dc)
	then
		if p then
			v13 = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Blueprint_UnlimitedCharges", true) .. "<br>" .. v13 .. object:__wf_atom_8e9ac384(data.Description, false)
		elseif __wf_atom_7e8ad928(data.mMod) then
			if data.LocalizedDesc == nil then
				v13 ..= object:__wf_atom_8e9ac384(data.Description, true)
			else
				v13 ..= data.LocalizedDesc
			end
		end
	else
		v13 ..= module6.GetRelicInfo(object, storeItem, true)
	end

	if not __wf_atom_7e8ad928(data.CodexEntry) then
		local convertColorNumberToHex3 = module.ConvertColorNumberToHex(module4.GetColor(10, true))
		v13 ..= module5.GetEnemyInfoText(object, data.CodexEntry, convertColorNumberToHex3, convertColorNumberToHex)
	end

	local infoPopup_Grid = _T.InfoPopup_Grid

	if not __wf_atom_7e8ad928(infoPopup_Grid) then
		if not __wf_atom_7e8ad928(storeItem) and storeItem:IsPackage() then
			local convertColorNumberToHex3 = module.ConvertColorNumberToHex(module4.GetColor(10, true))
			v13 ..= "<br><br>" .. module6.GetPackageContentsDesc(
				object,
				storeItem,
				infoPopup_Grid.PurchasedItems,
				convertColorNumberToHex3,
				convertColorNumberToHex2
			)
		end

		if not __wf_atom_7e8ad928(gGameData) then
			local _, v14, _ = module6.GetCompatWarning(
				object,
				storeItem,
				gGameRules:__wf_atom_964056fd(),
				gGameData:GetInventory(),
				{
					Items = infoPopup_Grid.PurchasedItems,
					Dictionary = infoPopup_Grid.PurchasedIsDictionary
				},
				true
			)

			if v14 ~= nil and v14 ~= "" then
				v13 ..= "<br><br>" .. object:__wf_atom_8e9ac384("<WARNING>", true) .. " " .. v14
			end
		end
	end

	if not __wf_atom_7e8ad928(data.mMod) then
		return v13 .. data.mMod.Card.mDesc
	end

	if data.mModDescOverride ~= nil then
		return v13 .. data.mModDescOverride
	end

	local color = module4.GetColor(10, true)
	return v13 .. module6.GetUpgradeInfo(
		object,
		storeItem,
		module.ConvertColorNumberToHex(color),
		convertColorNumberToHex
	)
end

local v13 = {
	{ 2047, 192 },
	{ 65535, 224 },
	{ 2097151, 240 }
}

local function fn26(p)
	if p < 128 then
		return (string.char(p))
	end

	local v14 = {}

	for i, v15 in ipairs(v13) do
		if not (p <= v15[1]) then
			continue
		end

		for j = i + 1, 2, -1 do
			local v16 = p % 64
			p = (p - v16) / 64
			v14[j] = string.char(128 + v16)
		end

		v14[1] = string.char(v15[2] + p)
		break
	end

	return table.concat(v14)
end

function UTF8(p)
	return fn26(p)
end

function OnHyperlinkPressed(object)
	if not __wf_atom_7e8ad928(object) and Engine.IsPlayingWithController() then
		object:__wf_atom_2004c47f()
	end
end

function ScaleTextToFit(object, p, p2, p3, p4)
	if __wf_atom_7e8ad928(object) or p == nil or p2 == nil or p3 == nil then
		return
	end

	local v14 = p4 == nil and 0 or p4
	object:__wf_atom_50d60589(p, 36, p2)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 40)
	local v15 = not (p3 <= __wf_atom_5e6e15c8) and 100 or math.ceil(p3 / __wf_atom_5e6e15c8 * 100)
	object:__wf_atom_e57658c2(p, 5, v15)
	object:__wf_atom_e57658c2(p, 6, v15)

	if v15 ~= 100 then
		v14 += math.floor((100 - v15) / 10)
	end

	object:__wf_atom_e57658c2(p, 1, v14)
	return v15
end

local function fn27(object, p, p2, data, icon, p3, p4, p5, uiMaterial_RectangleNoDepth, p6)
	object:__wf_atom_e57658c2(p, 1, p3)
	object:__wf_atom_e57658c2(p, 15, p4)
	object:OverrideMaterial(p .. ".Left", uiMaterial_RectangleNoDepth)
	object:__wf_atom_1ca72041(p .. ".Left", "RectEdgeColor", data.r, data.g, data.b, 1)
	object:__wf_atom_1ca72041(p .. ".Left", "RectInnerColor", data.r, data.g, data.b, 1)

	if p6 ~= false then
		object:__wf_atom_1ca72041(p .. ".Left", "WipeSpeed", 0.15, -1, 0, 0)
	end

	object:OverrideMaterial(p .. ".Right", uiMaterial_RectangleNoDepth)
	object:__wf_atom_1ca72041(p .. ".Right", "RectEdgeColor", data.r, data.g, data.b, 1)
	object:__wf_atom_1ca72041(p .. ".Right", "RectInnerColor", data.r, data.g, data.b, 1)

	if p6 == true then
		object:__wf_atom_1ca72041(p .. ".Right", "WipeSpeed", 0.15, -1, 0, 0)
	end

	object:__wf_atom_e57658c2(p2, 1, p5)
	object:__wf_atom_48bd5a59(p2, "Text", 36, object:__wf_atom_8e9ac384(icon, true))
end

function UpdateRarityBar(object, p, p2, p3)
	if p3 == false then
		object:__wf_atom_1ca72041(p .. ".LeftFill.Left", "TileOffset", -p2.x, -p2.y, 1, 1)
		object:__wf_atom_1ca72041(p .. ".LeftFill.Right", "TileOffset", -p2.x, -p2.y, 1, 1)
	else
		object:__wf_atom_1ca72041(p .. ".LeftFill.Left", "TileOffset", p2.x, -p2.y, 1, 1)
		object:__wf_atom_1ca72041(p .. ".LeftFill.Right", "TileOffset", p2.x, -p2.y, 1, 1)
	end

	if p3 == false then
		object:__wf_atom_1ca72041(p .. ".CenterFill.Left", "TileOffset", -p2.x, -p2.y, 1, 1)
	else
		object:__wf_atom_1ca72041(p .. ".CenterFill.Left", "TileOffset", p2.x, -p2.y, 1, 1)
	end

	object:__wf_atom_1ca72041(p .. ".CenterFill.Right", "TileOffset", -p2.x, -p2.y, 1, 1)
	object:__wf_atom_1ca72041(p .. ".RightFill.Left", "TileOffset", -p2.x, -p2.y, 1, 1)
	object:__wf_atom_1ca72041(p .. ".RightFill.Right", "TileOffset", -p2.x, -p2.y, 1, 1)
end

function DrawRarityBar(object, p, list, p2, uiMaterial_RectangleNoDepth, value, value2, p3, p4)
	local v14 = {
		{
			Color1 = {
				r = 187 / 255,
				g = 104 / 255,
				b = 72 / 255
			},
			Color2 = {
				r = 31 / 255,
				g = 31 / 255,
				b = 33 / 255
			},
			Icon = "<COMMON>"
		},
		{
			Color1 = {
				r = 120 / 255,
				g = 118 / 255,
				b = 118 / 255
			},
			Color2 = {
				r = 31 / 255,
				g = 31 / 255,
				b = 33 / 255
			},
			Icon = "<UNCOMMON>"
		},
		{
			Color1 = {
				r = 165 / 255,
				g = 144 / 255,
				b = 70 / 255
			},
			Color2 = {
				r = 31 / 255,
				g = 31 / 255,
				b = 33 / 255
			},
			Icon = "<RARE>"
		}
	}

	if __wf_atom_7e8ad928(uiMaterial_RectangleNoDepth) then
		uiMaterial_RectangleNoDepth = _G.UIMaterial_RectangleNoDepth
	end

	local v15 = p .. ".Backer"
	local v16 = p .. ".LeftFill"
	local v17 = p .. ".CenterFill"
	local v18 = p .. ".RightFill"
	local v19 = p .. ".LeftIcon"
	local v20 = p .. ".CenterIcon"
	local v21 = p .. ".RightIcon"
	local uiMaterial_RectangleNoDepth2 = uiMaterial_RectangleNoDepth
	local count = 0
	local total = 0
	local v22 = 7
	local v23 = 1

	for k, v24 in pairs(list) do
		if not (v24 > 0) then
			continue
		end

		count += 1
		total += v24
		v23 = k
	end

	local color2, color1, color2_2, icon, v24, v25, v26, icon2, icon3

	if count == 1 then
		uiMaterial_RectangleNoDepth2 = _G.UIMaterial_RectangleNoDepth
		color2 = v14[v23].Color2
		color1 = v14[v23].Color1
		color2_2 = v14[v23].Color2
		icon = v14[v23].Icon
		local v27 = list[v23]
		v24 = math.max(0.01, (p2 - 4) * (1 - v27) / 2)
		v25 = math.max(0.01, (p2 - 4) * v27)
		object:__wf_atom_4c1c1986(v17, "Left", 14, 16)
		object:__wf_atom_7f57ab2f(v17, "Right", 13, true)
		v26 = v24
		icon2 = ""
		icon3 = ""
	else
		color2 = v14[1].Color1
		color1 = v14[2].Color1
		color2_2 = v14[3].Color1
		icon2 = v14[1].Icon
		icon = v14[2].Icon
		icon3 = v14[3].Icon
		local v27 = list[1] / total
		v24 = math.max(0.01, (p2 - 4) * v27)
		local v28 = list[2] / total
		v25 = math.max(0.01, (p2 - 4) * v28)
		local v29 = list[3] / total
		v26 = math.max(0.01, (p2 - 4) * v29)
		object:__wf_atom_4c1c1986(v17, "Left", 14, 32)
		object:__wf_atom_7f57ab2f(v17, "Right", 13, false)
	end

	object:__wf_atom_7f57ab2f(v16, "Right", 13, false)
	object:__wf_atom_7f57ab2f(v18, "Right", 13, false)
	local v27 = 2 + v24
	local v28 = v27 + 1 + v25
	local v29 = v24 + 1
	local v30 = v28 - 1
	local v31 = v26 + 1

	if p3 ~= nil then
		object:__wf_atom_e57658c2(p, 0, p3)
	end

	if p4 ~= nil then
		object:__wf_atom_e57658c2(p, 1, p4)
	end

	object:__wf_atom_e57658c2(v15, 14, p2)
	object:__wf_atom_e57658c2(v15, 15, v22)
	object:__wf_atom_e57658c2(v15, 11, 0)
	object:__wf_atom_e57658c2(v15, 12, 50)
	local v32 = value2 or 0
	local v33 = v22 - 2
	fn27(object, v16, v19, color2, icon2, 1, v33, v32, uiMaterial_RectangleNoDepth2, true)
	fn27(object, v17, v20, color1, icon, 1, v33, v32, uiMaterial_RectangleNoDepth, nil)
	fn27(object, v18, v21, color2_2, icon3, 1, v33, v32, uiMaterial_RectangleNoDepth2, false)
	local v34 = value or 0.2
	__wf_atom_ec43d06e(object, v16, 2, { 14, 0 }, { v29, 1 }, v34)
	__wf_atom_ec43d06e(object, v17, 2, { 14, 0 }, { v25, v27 }, v34)
	__wf_atom_ec43d06e(object, v18, 2, { 14, 0 }, { v31, v30 }, v34)
	local v35 = count == 1 and 0 or v34
	__wf_atom_ec43d06e(object, v19, 2, { 0 }, { 1 + v29 / 2 }, v35)
	__wf_atom_ec43d06e(object, v20, 2, { 0 }, { v27 + v25 / 2 }, v35)
	__wf_atom_ec43d06e(object, v21, 2, { 0 }, { v30 + v31 / 2 }, v35)
end

function ToggleScreensToHide(p, list)
	if __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
		return
	end

	for i = 1, #v9 do
		local movie = __wf_atom_8e4fda44:FindMovie(v9[i])
		local v14

		if __wf_atom_7e8ad928(movie) then
			v14 = false
		else
			v14 = movie:IsVisible()

			if not p or list[i] then
				movie:SetVisible(p)
			end
		end

		if not p then
			table.insert(list, v14)
		end
	end
end

function SliceLichIcon(object, p)
	object:__wf_atom_7f57ab2f(p, "Slice", 13, true)
	object:__wf_atom_4c1c1986(p, "Slice", 5, 1)
	object:__wf_atom_4c1c1986(p, "Slice", 6, 1)
	__wf_atom_ec43d06e(object, p .. ".Slice", 0, { 5, 6 }, { 100, 100 }, 0.05)
	__wf_atom_ec43d06e(object, p .. ".Icon", 2, {
		function(p2)
			object:__wf_atom_4c1c1986(p, "Icon", 0, __wf_atom_104bfe98(0, -3, p2))
			object:__wf_atom_4c1c1986(p, "Icon", 1, __wf_atom_104bfe98(0, 6, p2))
		end,
		"_alpha"
	}, { 1, 75 }, 0.5, 0.05)
	__wf_atom_ec43d06e(object, p .. ".Icon2", 2, {
		function(p2)
			object:__wf_atom_4c1c1986(p, "Icon2", 0, __wf_atom_104bfe98(0, 3, p2))
			object:__wf_atom_4c1c1986(p, "Icon2", 1, __wf_atom_104bfe98(0, -6, p2))
		end,
		"_alpha"
	}, { 1, 75 }, 0.5, 0.05)
end

function InitializeNemesisAttemptInfo(mMovie, clipName, p, p2, p3, p4, data, p5, p6)
	local v14 = {
		mMovie = mMovie,
		Hints = {},
		ClipName = clipName,
		HintInfo = { Timer = nil, Positions = {}, IconFocused = false }
	}
	local v15 = { 35, 60, 100 }

	for i = 1, 3 do
		local v16 = clipName .. ".Hint.Hint" .. tostring(i)
		mMovie:__wf_atom_2dedec1a(v16, 13, false)
		mMovie:__wf_atom_e57658c2(v16 .. ".Progress", 11, data.Content)
		mMovie:OverrideMaterial(v16 .. ".Icon", p)
		local v17 = { mMovie:__wf_atom_5e6e15c8(v16, 0), (mMovie:__wf_atom_5e6e15c8(v16, 1)) }
		table.insert(v14.HintInfo.Positions, v17)
	end

	local v16 = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Kingpins/NemesisView_HintLabel", false))
	mMovie:__wf_atom_50d60589(clipName .. ".Hint.Label", 36, v16)
	mMovie:__wf_atom_e57658c2(clipName .. ".Hint.Label", 44, data.FloatingContent)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(clipName .. ".Hint.Label", 40)
	fn24(mMovie, clipName .. ".Hint.Underline", __wf_atom_5e6e15c8 + 20)
	mMovie:__wf_atom_e57658c2(clipName .. ".Hint.Underline", 11, data.FloatingContent)
	mMovie:__wf_atom_e57658c2(clipName .. ".Hint.Underline", 0, -(__wf_atom_5e6e15c8 / 2))
	mMovie:__wf_atom_2dedec1a(clipName .. ".Hint.Hint", 13, false)
	v14.CombGrid = p5.CreateGrid(
		mMovie,
		clipName .. ".CombinationHistory.Grid.Element",
		nil,
		1,
		module.Ternary(p6 ~= nil, p6, 6)
	)
	v14.CombGrid.mRowSeparation = 60
	v14.CombGrid.mColumnSeparation = 200
	v14.CombGrid:AttachScrollBar(clipName .. ".CombinationHistory.ScrollBar", -5)
	v14.CombGrid:EnableSmoothScroll()

	function v14.CombGrid.mElementDrawCallback(data2)
		if data2.mClipName == nil then
			return
		end

		local v17 = v14.CombGrid:GetHowManyElements() - data2.Id + 1
		mMovie:OverrideMaterial(data2.mClipName .. ".OrderNumber", p3)
		mMovie:__wf_atom_48bd5a59(data2.mClipName, "OrderNumber", 36, v17)
		mMovie:__wf_atom_4c1c1986(data2.mClipName, "OrderNumber", 12, 30)
		mMovie:__wf_atom_4c1c1986(data2.mClipName, "OrderNumber", 44, data.FloatingContent)

		for i = 1, 3 do
			local icon = data2.Icons[i]
			local state = data2.States[i]
			local v18 = 100
			local content = data.Content
			local background1Color = data.Background1Color
			local v19 = 0.75
			local v20 = false

			if state == 0 then
				background1Color = _G.UIColor_RGB_White
				v18 = 60
				v19 = 0
			elseif state == 1 then
				background1Color = data.NegativeColor
				v20 = true
			elseif state == 2 then
				background1Color = data.FloatingContentColor
			end

			local v21 = data2.mClipName .. ".Symbol" .. tostring(i)
			mMovie:__wf_atom_e57658c2(v21, 14, 75)
			mMovie:__wf_atom_e57658c2(v21, 15, 75)
			mMovie:__wf_atom_e57658c2(v21, 12, v18)

			if __wf_atom_7e8ad928(icon[4]) then
				mMovie:__wf_atom_933bbce0(v21, icon[1], p2)
			else
				mMovie:__wf_atom_933bbce0(v21, icon[1], icon[4])
			end

			mMovie:__wf_atom_f321ac85(v21, Symbol("DetailMap"), icon[2])
			mMovie:__wf_atom_e57658c2(v21, 11, content)
			mMovie:__wf_atom_1ca72041(
				v21,
				"DetailMapTint",
				background1Color.red / 255,
				background1Color.green / 255,
				background1Color.blue / 255,
				v19
			)
			mMovie:__wf_atom_2dedec1a(v21 .. "Strikethrough", 13, v20)
			mMovie:__wf_atom_933bbce0(v21 .. "Strikethrough", v14.StrikeThroughIcons[1], p2)
			mMovie:__wf_atom_f321ac85(v21 .. "Strikethrough", Symbol("DetailMap"), v14.StrikeThroughIcons[2])
			mMovie:__wf_atom_e57658c2(v21 .. "Strikethrough", 11, content)
			mMovie:__wf_atom_1ca72041(
				v21 .. "Strikethrough",
				"DetailMapTint",
				data.NegativeColor.red / 255,
				data.NegativeColor.green / 255,
				data.NegativeColor.blue / 255,
				1
			)
			mMovie:__wf_atom_e57658c2(v21, 14, icon[3])
			mMovie:__wf_atom_e57658c2(v21, 15, icon[3])
		end
	end

	mMovie:__wf_atom_e57658c2(clipName .. ".CombinationHistory.Hint", 44, data.FloatingContent)
	mMovie:__wf_atom_50d60589(clipName .. ".CombinationHistory.Hint", 46, "center")
	mMovie:__wf_atom_7d7314f1(
		clipName .. ".CombinationHistory.Hint.text",
		"/Lotus/Language/Kingpins/NemesisView_NoHistoryHint"
	)

	function v14:AdjustToViewport()
		if __wf_atom_7e8ad928(self.CombGrid) then
			return
		end

		local v17 = self.CombGrid.mRows * self.CombGrid.mRowSeparation
		local v18 = self.mMovie:__wf_atom_5e6e15c8(self.ClipName .. ".CombinationHistory", 3) - 30 + v17 / 2
		local v19 = v17 - 10
		local visibilityCenter = module.GetVisibilityCenter(self.mMovie, v18)
		local visibilitySize = module.GetVisibilitySize(self.mMovie, v19)
		local visibilityFadeSize = module.GetVisibilityFadeSize(self.mMovie, 10)

		for _, v20 in pairs({ p2, p3, p4 }) do
			v20:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, visibilityCenter)
			v20:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, visibilitySize)
			v20:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, visibilityFadeSize)
		end
	end

	function v14.PopulateCombinationHistory(data2, p7)
		if __wf_atom_7e8ad928(data2.CombGrid) then
			return
		end

		data2.CombGrid:RemoveElements()
		local mGuessHistory

		if not __wf_atom_7e8ad928(p7) then
			mGuessHistory = p7.mGuessHistory
		end

		for i = #mGuessHistory, 1, -1 do
			local __wf_atom_cb476fa5, v17, v18, v19, v20, v21 = SF.__wf_atom_cb476fa5(mGuessHistory[i])
			local v22 = { __wf_atom_cb476fa5, v18, v20 }
			local icons = {}

			for j = 1, #v22 do
				local v23 = v22[j]
				local iconTexture = data2.EmptyIcons[1]
				local emptyIcon = data2.EmptyIcons[2]
				local v24 = nil
				local v25 = 45

				if v23 <= 7 then
					iconTexture = data2.ImmortalMods[v23 + 1]:GetIconTexture()
					emptyIcon = module2.GetImmortalGlowIconByIndex(v23 + 1)
					v25 = 75
				elseif v23 == 9 then
					iconTexture = data2.ImmortalMods[9]:GetIconTexture()
					v24 = p4
					v25 = 75
				end

				table.insert(icons, { iconTexture, emptyIcon, v25, v24 })
			end

			data2.CombGrid:AddElement({
				States = { v17, v19, v21 },
				Icons = icons
			}, true)
		end

		data2.CombGrid:Redraw()
		local howManyElements = data2.CombGrid:GetHowManyElements()
		data2.mMovie:__wf_atom_2dedec1a(data2.ClipName .. ".CombinationHistory.Hint", 13, howManyElements == 0)
	end

	function v14:RotateHints(object)
		if __wf_atom_7e8ad928(object) then
			return
		end

		if self.HintInfo.IconFocused then
			self.HintInfo.Timer = object:AddTimer(3, function()
				self:RotateHints(object)
			end)
			return
		end

		local v17 = {}

		for i = 1, 3 do
			table.insert(v17, { self.HintInfo.Positions[i][1], self.HintInfo.Positions[i][2] })
		end

		for i = 1, 3 do
			local v18 = __wf_atom_5784a397(1, #v17)
			local v19 = v17[v18]
			__wf_atom_ec43d06e(
				self.mMovie,
				self.ClipName .. ".Hint.Hint" .. tostring(i),
				7,
				{ 0, 1 },
				{ v19[1], v19[2] },
				1
			)
			table.remove(v17, v18)
		end

		self.HintInfo.Timer = object:AddTimer(3, function()
			self:RotateHints(object)
		end)
	end

	function v14:PopulateHints(p7, p8)
		self.Hints = {}
		local v17 = 0

		if not __wf_atom_7e8ad928(p7) then
			self.Hints = p7.mHints

			if #self.Hints < 3 then
				v17 = p7.mHintProgress / v15[#self.Hints + 1]
			end

			if self.Hints == nil then
				self.Hints = {}
			end
		end

		for i = 1, 3 do
			local iconTexture = self.EmptyIcons[1]
			local emptyIcon = self.EmptyIcons[2]
			local background1Color = data.Background1Color
			local v18 = 0
			local v19 = 25
			local v20 = false
			local v21 = self.ClipName .. ".Hint.Hint" .. tostring(i)
			self.mMovie:__wf_atom_2dedec1a(v21, 13, true)

			if self.Hints[i] == nil then
				if v17 > 0 then
					__wf_atom_86cbd68d(self.mMovie, v21 .. ".Progress.gotoAndStop", module.Round(v17 * 100) + 1)
					v20 = true
					v18 = 5
					v19 = 25
					v17 = 0
				end
			else
				local v22 = self.Hints[i] + 1

				if self.ImmortalMods[v22] == nil then
					print("Error: Nemesis hint is out of range of ImmortalMods: " .. tostring(v22))
				else
					iconTexture = self.ImmortalMods[v22]:GetIconTexture()
					emptyIcon = module2.GetImmortalGlowIconByIndex(v22)
				end

				v18 = 0.75
				v19 = 100
			end

			local v22 = v21 .. ".Icon"
			self.mMovie:__wf_atom_7f57ab2f(v21, "Progress", 13, v20)
			self.mMovie:__wf_atom_c90af43a(v22, iconTexture)
			self.mMovie:__wf_atom_f321ac85(v22, Symbol("DetailMap"), emptyIcon)
			self.mMovie:__wf_atom_1ca72041(
				v22,
				"DetailMapTint",
				background1Color.red / 255,
				background1Color.green / 255,
				background1Color.blue / 255,
				v18
			)
			self.mMovie:__wf_atom_e57658c2(v22, 12, v19)
		end

		self:RotateHints(p8)
	end

	function v14.HintFocused(data2, p7)
		local v17 = tonumber(p7)
		local hint = data2.Hints[v17]

		if hint ~= nil and data2.ImmortalMods[hint + 1] ~= nil then
			data2.HintInfo.IconFocused = true
			local immortalMod = data2.ImmortalMods[hint + 1]
			local v18 = data2.ClipName .. ".Hint.Hint" .. tostring(v17)
			local infoPopup_Data = {
				CustomEntry = true,
				Name = data2.mMovie:__wf_atom_8e9ac384(immortalMod:__wf_atom_014a76a2():c_str(), false)
			}
			fn12(
				data2.mMovie,
				infoPopup_Data,
				data2.mMovie:__wf_atom_5e6e15c8(v18, 2),
				data2.mMovie:__wf_atom_5e6e15c8(v18, 3),
				data2.mMovie:__wf_atom_5e6e15c8(v18, 14),
				data2.mMovie:__wf_atom_5e6e15c8(v18, 15)
			)
			_T.InfoPopup_Data = infoPopup_Data
		end
	end

	function v14.HintUnfocused(p7, _)
		p7.HintInfo.IconFocused = false
		_T.InfoPopup_Data = nil
	end

	v14:AdjustToViewport()
	return v14
end

function GetInnateDamageName(object, p, p2, p3, p4, p5)
	local v14 = Resource(p.mUpgradeType)
	local v15 = ""
	local v16 = 0
	local v17 = 0

	if __wf_atom_7e8ad928(v14) then
		return v15, v16, v17
	end

	v14:__wf_atom_eaa00d7a(module.Ternary(not __wf_atom_7e8ad928(p4), p4, p.mUpgradeFingerprint))

	if not (v14:__wf_atom_06f3cb74() > 0) then
		return v15, v16, v17
	end

	local __wf_atom_b9a1f18c = v14:__wf_atom_b9a1f18c(0)
	v16 = module.Ternary(not __wf_atom_7e8ad928(p5), p5, __wf_atom_b9a1f18c:__wf_atom_7f9e6a1c())
	v17 = __wf_atom_b9a1f18c:__wf_atom_505b3c0e()
	local damageTypeTag = module3.GetDamageTypeTag(v16)
	local v18

	if p3 then
		v18 = "<" .. damageTypeTag .. ">"
	else
		if p2 then
			damageTypeTag ..= "_NoIcon"
		end

		v18 = "/Lotus/Language/Game/" .. damageTypeTag
	end

	v15 = object:__wf_atom_8e9ac384(v18, true) .. " " .. module.FormatNumber(v17 * 100, 1) .. "%"
	return v15, v16, v17
end

function OnMuseumStreamed()
	local playerAvatar = gRegion:GetPlayerAvatar()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("MuseumWaypoint"))
	_T.PreMuseumState = {
		playerAvatar:GetPosition(),
		playerAvatar:__wf_atom_dc309f8a(),
		playerAvatar:__wf_atom_4e50d390()
	}
	playerAvatar:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	playerAvatar:__wf_atom_f0f9fb38(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
	playerAvatar:Teleport(__wf_atom_0a6a5887:GetPosition(), __wf_atom_0a6a5887:__wf_atom_dc309f8a())
	playerAvatar:__wf_atom_f0f9fb38(__wf_atom_0a6a5887:__wf_atom_dc309f8a())
	gRegion:__wf_atom_0a6a5887(Symbol("MuseumScript")):__wf_atom_f0368285()
end

function StreamMuseum(level)
	local v14 = Vector(0, 1000, 0)
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = level
	levelArgs.streamingLayer = 511
	levelArgs.streamingMode = 1
	levelArgs:__wf_atom_c4be912d("OnMuseumStreamed")
	levelArgs:__wf_atom_60471db9(v14, Rotation())
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	_T.PreMuseumState = {
		__wf_atom_c4f78a8f:GetPosition(),
		__wf_atom_c4f78a8f:__wf_atom_dc309f8a(),
		__wf_atom_c4f78a8f:__wf_atom_4e50d390(),
		level
	}
	Engine.StreamRegion(levelArgs)
end

local function fn28(value)
	if #value > 0 and string.sub(value, 1, 1) ~= "/" then
		return value
	end

	return nil
end

local function fn29(object, list, ...)
	if __wf_atom_7e8ad928(object) then
		return list
	end

	local count = 0

	while true do
		local v14 = nil

		for _, v15 in ipairs({ ... }) do
			if #v15 == 0 then
				continue
			end

			if Engine.IsPlayingWithController() then
				v14 = fn28(object:__wf_atom_8e9ac384(v15 .. "Controller_" .. count, true))
			end

			if v14 == nil then
				v14 = fn28(object:__wf_atom_8e9ac384(v15 .. count, true))
			end

			if v14 == nil then
				continue
			end

			table.insert(list, v14)
			count += 1
			break
		end

		if v14 == nil then
			return list
		end
	end
end

function GetTips(p, ...)
	return fn29(p, {}, ...)
end

function AppendTips(p, p2, ...)
	return fn29(p, p2, ...)
end

function ResetModVisibleRangeMaterials()
	local v14 = {}

	for _, uiMaterial_Mod in pairs(_G.UIMaterial_Mods) do
		for _, v15 in pairs(uiMaterial_Mod) do
			table.insert(v14, v15)
		end
	end

	for _, uiMaterial_ModsSyndicateIcon in pairs(_G.UIMaterial_ModsSyndicateIcons) do
		for _, v15 in pairs(uiMaterial_ModsSyndicateIcon) do
			table.insert(v14, v15)
		end
	end

	for _, v15 in ipairs(v14) do
		v15:__wf_atom_a042ff6c(SF.__wf_atom_5ddc828f, 0.5)
		v15:__wf_atom_a042ff6c(SF.__wf_atom_cf0d1cc6, 1.5)
		v15:__wf_atom_a042ff6c(SF.__wf_atom_7a5b8f59, 0)
	end
end

function IsGreyscale(p)
	return v10[Resource(p):__wf_atom_908599dc() + 1]
end

function SetChatVisible(p)
	if not p then
		_T.HideChat = (_T.HideChat or 0) + 1
	elseif _T.HideChat ~= nil then
		if _T.HideChat > 0 then
			_T.HideChat = _T.HideChat - 1
		else
			_T.HideChat = nil
		end
	end
end

function AdjustDualWieldComponent(object, p, p2, p3, object2, object3, p4)
	if __wf_atom_7e8ad928(object3) then
		object3 = gRegion:__wf_atom_c4f78a8f()
	end

	if __wf_atom_7e8ad928(object3) then
		return
	end

	if __wf_atom_7e8ad928(object2) then
		local __wf_atom_a96eb2aa = object3:__wf_atom_a96eb2aa()

		if not __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
			object2 = __wf_atom_a96eb2aa:__wf_atom_301e8d97()
		end

		if __wf_atom_7e8ad928(object2) then
			return
		end
	end

	local __wf_atom_55cc929b = object2:__wf_atom_55cc929b()

	if p3 == __wf_atom_55cc929b and p4 == nil or __wf_atom_7e8ad928(_T.HUD_GetAnchorMgr) then
		return __wf_atom_55cc929b
	end

	local HUD_GetAnchorMgr = _T.HUD_GetAnchorMgr()

	if HUD_GetAnchorMgr == nil then
		return __wf_atom_55cc929b
	end

	if __wf_atom_55cc929b or p4 then
		HUD_GetAnchorMgr:ChangeOriginalCoords(p, nil, p2 - 54)
	else
		HUD_GetAnchorMgr:ChangeOriginalCoords(p, nil, p2)
	end

	HUD_GetAnchorMgr:Update(
		object:__wf_atom_d5a50cb5(),
		object:__wf_atom_c4f6543f(),
		true,
		HUD_GetAnchorMgr.mHudScalePadding
	)
	_T.HUD_UpdateMotionClip(object, p)
	return __wf_atom_55cc929b
end

function ProfileIconSelect(object, icon, p, p2)
	_T.ItemBrowsingElementWidth = 130
	_T.ItemBrowsingElementHeight = 130
	_T.ProfileIconSelectScreenOpen = true
	local isInNewWarAltCharacterMission = module3.IsInNewWarAltCharacterMission()
	local selectionMovie = object:PushChildMovie(_G.UIMovie_ItemBrowsingMovie)
	selectionMovie:Execute(
		"SetTitle",
		object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_ChangeAvatarImage", false)
	)
	selectionMovie:Execute("SetVariableSelection", 1)
	selectionMovie:Execute("SetExitCallout", "/Lotus/Language/Menu/Select")
	selectionMovie:Execute("SetHideCountThreshold", 0)
	selectionMovie:Execute("SetHidePriceIfOwned", "false")
	selectionMovie:Execute("SetShowGridLabels", "false")
	selectionMovie:Execute("SetGridCanPreview", (tostring(not isInNewWarAltCharacterMission)))
	local v14 = nil
	local result = { SelectionMovie = selectionMovie }
	local v15 = not __wf_atom_7e8ad928(p2)
	local v16 = { ALL = 0, PREMIUM = 1 }
	module3.InitializeProfileIconList()

	local function fn30(p3)
		for _, mGlyphImage in ipairs(_T.mGlyphImages) do
			if mGlyphImage.mItemType == p3 then
				return mGlyphImage
			end
		end

		return nil
	end

	local function fn31(p3)
		_T:SetProfileIcon(p3)

		if not __wf_atom_7e8ad928(gGameData) then
			gGameData:__wf_atom_a4299765():__wf_atom_1860f6b3(p3)
		end

		gMatchingService:__wf_atom_27e16961()

		if not __wf_atom_7e8ad928(gRegion) and module3.GetUIMode() == module3.UI_MODE_IN_GAME then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

			if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
				local __wf_atom_a4299765 = __wf_atom_eab484a7:__wf_atom_a4299765()

				if not __wf_atom_7e8ad928(__wf_atom_a4299765) then
					__wf_atom_a4299765:__wf_atom_1860f6b3(p3)
				end
			end
		end

		if not __wf_atom_7e8ad928(_T.GetScreenRes) then
			local screenRes = _T.GetScreenRes("SquadOverlay")

			if not __wf_atom_7e8ad928(screenRes) then
				local movie = __wf_atom_8e4fda44:FindMovie(screenRes)

				if not __wf_atom_7e8ad928(movie) then
					local __wf_atom_5e6e15c8 = movie:__wf_atom_5e6e15c8("SquadInfo.Player1.Icon", 14)
					module.CreateParticles(
						movie,
						"SquadInfo.Player1.Icon",
						p,
						__wf_atom_5e6e15c8 / 2 + 2,
						__wf_atom_5e6e15c8 / 2
					)
					module.PlaySound(_G.UISound_SweetenerTwo)
				end
			end
		end
	end

	local function fn32(p3, _, p4)
		if p3 ~= nil and not p4 then
			if p3 then
				_T.PurchasingGlyph.NotOwned = false
				_T.PurchasingGlyph.Count = 1
				_T.didPurchaseImage = true
				_T.mGlyphImages = gGameData:GetInventory():__wf_atom_da43e3f3()

				if result.SelectionMovie ~= nil then
					result.SelectionMovie:Execute("GridItemPressed", _T.PurchasingGlyph.Id)
				end
			else
				module.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
			end
		end

		_T.PurchasingGlyph = nil

		if result.PurchaseMovie ~= nil then
			result.PurchaseMovie:Execute("TransitionOut", "")
		end
	end

	local function fn33(purchasingGlyph)
		if isInNewWarAltCharacterMission then
			return
		end

		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = purchasingGlyph.StoreItem, Sale = purchasingGlyph.Sale },
			CALLBACK = fn32
		}

		function _T.OnDetailedViewComplete(_)
			if not _T.didPurchaseImage then
				local v17 = fn30(_T.currentAvatarImage)

				if v17 == nil then
					v17 = SF.FlavourItem()
				end

				fn31(v17)
				_T.tempAvatarImage = nil
				_T.currentAvatarImage = nil
			end

			result.PurchaseMovie = nil
		end

		_T.PurchasingGlyph = purchasingGlyph
		local purchaseMovie = selectionMovie:PushChildMovie(_G.UIMovie_DetailedPurchaseDialog)
		result.PurchaseMovie = purchaseMovie
		local localLoadout = _T.GetLocalLoadout()
		_T.currentAvatarImage = localLoadout:__wf_atom_a6382ae5().mItemType
		_T.didPurchaseImage = false
		_T.tempAvatarImage = SF.FlavourItem()
		_T.tempAvatarImage.mItemType = purchasingGlyph.ItemType
		fn31(_T.tempAvatarImage)
		purchaseMovie:Execute("SetIgnoreTopMenu", "true")
		purchaseMovie:Execute("SetExitCallbackIsTemp", "true")
		purchaseMovie:Execute("SetExitCallback", "OnDetailedViewComplete")
		purchaseMovie:__wf_atom_0cf0fdbe(0.9)
	end

	function _T.GetAllItems()
		local mFlashSales = gGameData:__wf_atom_92662866().mFlashSales
		_T.mGlyphImages = gGameData:GetInventory():__wf_atom_da43e3f3()

		if _T.mGlyphImages == nil then
			_T.mGlyphImages = {}
		end

		local mItemTypes = {}

		for i = 1, #_T.mGlyphImages do
			if
				__wf_atom_7e8ad928(_T.mGlyphImages[i].mItemType)
				or not _T.mGlyphImages[i].mItemType:IsA(__wf_atom_746ce1f6)
			then
				continue
			end

			table.insert(mItemTypes, _T.mGlyphImages[i].mItemType)
		end

		local storeItems = gGameRules:__wf_atom_964056fd():GetStoreItems()

		for i = 1, #storeItems do
			local storeItem = storeItems[i]

			if __wf_atom_7e8ad928(storeItem) or not storeItem:AlwaysAvailable() then
				continue
			end

			local item = storeItem:GetItem()

			if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_746ce1f6) then
				continue
			end

			local flavourItem = SF.FlavourItem()
			flavourItem.mItemType = storeItem:GetItem()
			table.insert(_T.mGlyphImages, flavourItem)
		end

		local profileImage = p2

		if profileImage == nil and not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_3f866e1a = gGameData:__wf_atom_3f866e1a()
			profileImage = cjson.decode(__wf_atom_3f866e1a).ProfileImage
		end

		local result2 = {}

		for i = 1, #storeItems do
			__wf_atom_83c14687(0)
			local storeItem = storeItems[i]

			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local item = storeItem:GetItem()

			if __wf_atom_7e8ad928(item) or not item:IsA(__wf_atom_746ce1f6) then
				continue
			end

			local v17 = module.IsValueInTable(mItemTypes, item) or storeItem:AlwaysAvailable()
			local v18 = storeItem:ShowInMarket()
			local v19 = false

			if not __wf_atom_7e8ad928(mFlashSales) then
				for j = 1, #mFlashSales do
					if mFlashSales[j].mTypeName ~= item then
						continue
					end

					v19 = true
					break
				end
			end

			if not (v17 or v18 or v19) then
				continue
			end

			local _, price, _, sale = module3.__wf_atom_a94b426a(storeItem)
			local mSelectedGlyph = {
				Sale = sale,
				Texture = storeItem:GetIconTexture(),
				Name = object:__wf_atom_8e9ac384(storeItem:__wf_atom_014a76a2():c_str(), true),
				Description = object:__wf_atom_8e9ac384(storeItem:__wf_atom_3a3d2e39():c_str(), true),
				Price = price,
				Premium = price >= 15 or price == 0,
				ItemType = item,
				StoreItem = storeItem,
				TennoGen = storeItem:__wf_atom_955f7fe0(),
				SearchCache = module6.GetSearchString(object, storeItem),
				Count = module.Ternary(v17, 1, 0),
				NotOwned = not v17,
				Purchaseable = v18 or v19,
				CustomTags = {}
			}

			if mSelectedGlyph.Purchaseable and not v15 then
				local v20 = fn4(LABEL_TYPE_GIFTABLE, "")
				v20.ClipOffset = _T.ItemBrowsingElementWidth - 32
				table.insert(mSelectedGlyph.CustomTags, v20)
			end

			if mSelectedGlyph.Premium then
				mSelectedGlyph.Categories = { v16.PREMIUM }
				local v20 = fn4(LABEL_TYPE_PREMIUM, "")
				v20.ClipOffset = _T.ItemBrowsingElementWidth
				table.insert(mSelectedGlyph.CustomTags, v20)
			end

			if
				profileImage == item:__wf_atom_5b41f63b()
				or not __wf_atom_7e8ad928(mSelectedGlyph.Texture)
				and profileImage == mSelectedGlyph.Texture:__wf_atom_5b41f63b()
			then
				v14 = { mSelectedGlyph }
				mSelectedGlyph.Selected = true
				_T.mSelectedGlyph = mSelectedGlyph
			end

			table.insert(result2, mSelectedGlyph)
		end

		return result2
	end

	selectionMovie:Execute("SetElementsFunction", "GetAllItems")

	function _T.GlyphCategories()
		local v17 = {}
		table.insert(v17, {
			Category = v16.ALL,
			Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAll", false),
			Icon = _G.UICategoryIcon_AllOn
		})
		table.insert(v17, {
			Category = v16.PREMIUM,
			Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryPremium", false),
			Icon = icon
		})
		return v17
	end

	selectionMovie:Execute("SetCategoriesFunction", "GlyphCategories")

	function _T.GlyphSort()
		local v17 = {}
		table.insert(v17, {
			Name = object:__wf_atom_8e9ac384("/SortingLabels/Name", false),
			SortId = "NAME",
			Attribute = function(p3, p4)
				return string.lower(p3.Name) < string.lower(p4.Name)
			end
		})
		table.insert(v17, {
			Name = object:__wf_atom_8e9ac384("/SortingLabels/Price", false),
			SortId = "PRICE",
			Attribute = function(data, data2)
				if data.NotOwned ~= data2.NotOwned then
					return data.NotOwned
				end

				if data.Price == data2.Price then
					return string.lower(data.Name) < string.lower(data2.Name)
				end

				return data.Price > data2.Price
			end
		})
		table.insert(v17, {
			Name = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Store_Owned", false),
			SortId = "OWNED",
			Attribute = function(data, p3)
				if data.NotOwned == p3.NotOwned then
					return string.lower(data.Name) < string.lower(p3.Name)
				end

				return data.Count > 0
			end
		})
		return v17, "NAME"
	end

	selectionMovie:Execute("SetSortByFunction", "GlyphSort")

	function _T.GlyphSelectedCallback(list)
		local mSelectedGlyph = list[1]

		if
			not __wf_atom_7e8ad928(_T.mSelectedGlyph)
			and mSelectedGlyph.Id == _T.mSelectedGlyph.Id
			and not __wf_atom_7e8ad928(_T.mLastPressTime)
			and Time() - _T.mLastPressTime < 0.5
		then
			selectionMovie:Execute("OnConfirmSelection", 4)
			return false
		end

		_T.mLastPressTime = Time()
		module.PlaySound(_G.UISound_Select)
		local v17

		if not mSelectedGlyph.InfoFocused then
			v17 = fn30(mSelectedGlyph.ItemType)
		end

		if v15 or __wf_atom_7e8ad928(v17) then
			if not __wf_atom_7e8ad928(_G.UIMovie_DetailedPurchaseDialog) and mSelectedGlyph.Purchaseable then
				fn33(mSelectedGlyph)
				return false
			end
		elseif __wf_atom_7e8ad928(_T.mSelectedGlyph) or _T.mSelectedGlyph.Id ~= mSelectedGlyph.Id then
			fn31(v17)
			_T.mSelectedGlyph = mSelectedGlyph
		end

		return true
	end

	selectionMovie:Execute("SetValidationFunction", "GlyphSelectedCallback")

	function _T.GlyphScreenDone(p3, _)
		if __wf_atom_7e8ad928(p3) and not __wf_atom_7e8ad928(v14) then
			_T.GlyphSelectedCallback(v14)
		end

		if not __wf_atom_7e8ad928(gGameData) then
			gGameData:__wf_atom_993aebc4("OnSaveLoadOutComplete")
		end

		_T.ItemBrowsingElementWidth = nil
		_T.ItemBrowsingElementHeight = nil
		_T.GetAllItems = nil
		_T.GlyphCategories = nil
		_T.GlyphSort = nil
		_T.GlyphSelectedCallback = nil
		_T.GlyphScreenDone = nil
		_T.GlyphGiftCallback = nil
		_T.OnNameEnteredCallback = nil
		_T.mGlyphImages = nil
		_T.mSelectedGlyph = nil
		_T.GiftParams = nil
		_T.currentAvatarImage = nil
		_T.didPurchaseImage = nil
		_T.tempAvatarImage = nil
		_T.ProfileIconSelectScreenOpen = false
		_T.TopMenuOpen = not v15

		for k, _ in pairs(result) do
			result[k] = nil
		end
	end

	selectionMovie:Execute("SetCallBack", "GlyphScreenDone")
	_T.GlyphGiftCallback = fn33
	selectionMovie:Execute("SetRightClickFunction", "GlyphGiftCallback")
	return result
end

function GetBuildLabel()
	local buildLabel = __wf_atom_8e4fda44:GetBuildLabel()
	local v14 = string.find(buildLabel, " ")
	local v15

	if v14 == nil then
		v15 = string.len(buildLabel)
	else
		v15 = v14 - 1
	end

	return string.upper((string.sub(buildLabel, 1, v15)))
end

function GetActualEarnedIntrinsics(_, _)
	return 0
end

function CreateAsyncLoader()
	return {
		mLoaders = {},
		LoadResource = function(p, object, callback)
			table.insert(p.mLoaders, {
				Resources = { object },
				Loaded = false,
				Loader = UISys.__wf_atom_c0dbe47c({ object:__wf_atom_5b41f63b() }),
				Callback = callback,
				IsSingleResource = true
			})
		end,
		LoadMultipleResources = function(p, resources, callback)
			local v14 = {}

			for i = 1, #resources do
				table.insert(v14, resources[i]:__wf_atom_5b41f63b())
			end

			table.insert(p.mLoaders, {
				Resources = resources,
				Loaded = false,
				Loader = UISys.__wf_atom_c0dbe47c(v14),
				Callback = callback,
				IsSingleResource = false
			})
		end,
		Update = function(self)
			for i = 1, #self.mLoaders do
				local mLoader = self.mLoaders[i]

				if mLoader.Loaded or not mLoader.Loader:__wf_atom_86399a47() then
					continue
				end

				mLoader.Loaded = true

				if mLoader.IsSingleResource then
					mLoader.Callback(mLoader.Resources[1])
				else
					mLoader.Callback(mLoader.Resources)
				end
			end
		end,
		ClearResources = function(p)
			for i = 1, #p.mLoaders do
				local mLoader = p.mLoaders[i]

				if not (mLoader.Loaded or mLoader.Loader:__wf_atom_86399a47()) then
					mLoader.Loader:Abort()
				end
			end

			p.mLoaders = {}
		end,
		IsLoading = function(p)
			for i = 1, #p.mLoaders do
				if not p.mLoaders[i].Loaded then
					return true
				end
			end

			return false
		end
	}
end