module(..., package.seeall)
local v = { "AT_COURAGE", "AT_SPIRIT", "AT_GRACE" }
local v2 = { "AT_WRATH", "AT_DEATH", "AT_DOOM" }
local v3 = { "COMMON", "UNCOMMON", "RARE", "LEGENDARY" }
local v4 = { "NONE", "WORN", "MILITARY", "OFFICER", "NOBLE", "MASTERWORK", "LEGENDARY" }
local module = require("EE.Interface.Utilities")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v5 = WeakResource("/SF/Interface/Inventory.swf")
local v6 = WeakResource("/SF/Interface/FullscreenItemPicker.swf")
local v7 = WeakResource("/SF/Interface/ProgressionSmall.swf")
local v8 = WeakResource("/SF/Interface/DiegeticNote.swf")
local v9 = WeakResource("/SF/Interface/Dialog.swf")
local v10 = WeakResource("/SF/Interface/ConsumablesOverlay.swf")
local v11 = WeakResource("/SF/Types/Items/Consumables/WevetSeed")
local v12 = WeakResource("/SF/Upgrades/SFMotesBaseUpgrade")
local v13 = WeakResource("/SF/Types/Game/Ancestors/Tuvalkane/TuvalkaneAncestor")
local v14 = Resource("/SF/Types/Lore/TutorialLore/TempersTutorialFragment")
local v15 = WeakResource("/SF/Types/Gameplay/Tutorial/TutorialTriggerTempers")
MAX_SQUAD_SIZE = 4
HT_PROGRESS_BAR = 1
HT_TIMER = 2
HT_HEALTH_TRACKER = 3
HT_ICON_BAR = 4
HT_OPPONENT_BAR = 5
HT_LABEL = 6
HT_TEMPERATURE_BAR = 7
HT_CORRUPTION_BAR = 8
HT_NODE_CONFLICT_BAR = 9
HT_DRAGON_TRACKER = 10
HT_ALCHEMY_BAR = 11
HT_PROGRESS_TRACKER = 12
REPORT_PLAYER = 1
REPORT_CLAN_AD = 2
local filters = {
	{
		Label = "/SF/Language/Skills/ThrowingKnivesSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_THROWING_KNIVES>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/SecondaryThrowingKnivesSkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/SwordSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_SWORD>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/SwordSkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/BowSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_ARCHERY>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/ArcherySkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/DaggerSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_DAGGER>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/DaggerSkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/ShieldsSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_SHIELD>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/ShieldSkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/PolearmSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_POLEARM>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/PolearmSkillTree"),
		Active = false
	},
	{
		Label = "/SF/Language/Skills/CastSkill",
		LabelIcon = "<WEAPON_CATEGORY_ICON_CASTING>",
		CompatibilityType = WeakResource("/SF/Upgrades/Techniques/CastingSkillTree"),
		Active = false
	}
}
INVENTORY_CATEGORIES = {
	{ Name = "/SF/Language/Categories/All" },
	{
		ItemType = 3,
		AdditionalTypes = { 13 },
		SubTypes = {
			WeakResource("/SF/Types/Recipes/Pacts/PactBlueprint"),
			WeakResource("/SF/Types/Recipes/Pacts/PactFragment"),
			__wf_atom_d98e64fe
		},
		Name = "/SF/Language/Categories/Pacts"
	},
	{
		ItemType = 5,
		AdditionalTypes = { 1 },
		Name = "/SF/Language/Categories/Weapons"
	},
	{ ItemType = 6, Name = "/SF/Language/Categories/Armour" },
	{ ItemType = 6, SubCategory = "accessories", Name = "/SF/Language/Categories/Accessories" },
	{ ItemType = 2, Name = "/SF/Language/Categories/Consumables" },
	{
		ItemType = 4,
		SubType = WeakResource("/SF/Types/Items/Kintsugi/BaseKintsugiUpgrade"),
		Name = "/SF/Language/Categories/Joineries",
		ExcludeList = { WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade") }
	},
	{
		ItemType = 4,
		SubType = WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade"),
		Name = "/SF/Language/Categories/MotesActive",
		Filters = filters,
		FilterFunction = function(p, p2)
			return Resource(p.Type):CanUseWithItem("", p2.CompatibilityType)
		end
	},
	{
		ItemType = 4,
		SubType = WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade"),
		Name = "/SF/Language/Categories/MotesPassive",
		Filters = filters,
		FilterFunction = function(p, p2)
			return Resource(p.Type):CanUseWithItem("", p2.CompatibilityType)
		end
	},
	{ ItemType = 13, Name = "/SF/Language/Categories/Fragments" },
	{ ItemType = 11, Name = "/SF/Language/Categories/Misc" }
}
ZERO_WIDTH_SPACE = table.concat({ string.char(226), string.char(128), (string.char(139)) })
local v16 = Symbol("AvatarPause")

function HideSpawnedSoulModeHiddenEntityScript(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	Sleep(0)
	local v17 = Symbol("SOUL_MODE_HIDDEN")
	local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_7e616794)

	for _, v18 in ipairs(__wf_atom_f582136d) do
		if v18:__wf_atom_db682341() ~= v17 then
			continue
		end

		v18:__wf_atom_a7ee9662(false, true)

		if v18:IsA(__wf_atom_d00f34c2) then
			v18:__wf_atom_edd3fec6(0)
		end

		v18:__wf_atom_a763aa1a(1)
	end
end

function IsInventoryOpen()
	return __wf_atom_8e4fda44:FindMovie(v5) ~= nil
end

function ShouldHideConsumable(instance)
	if __wf_atom_7e8ad928(instance) or instance:IsA(v11) then
		return true
	end

	local __wf_atom_00133eea = instance:__wf_atom_00133eea()

	if __wf_atom_00133eea and (__wf_atom_00133eea == 0 or __wf_atom_00133eea == 1) then
		return true
	end

	return false
end

function OpenInventory(object, inventoryUiOptions)
	local movie = __wf_atom_8e4fda44:FindMovie(v5)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end

	_T.InventoryUiOptions = inventoryUiOptions
	object:__wf_atom_f6811c70(v5, "InventoryOpened")
end

function CloseInventory()
	local movie = __wf_atom_8e4fda44:FindMovie(v5)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("AdvanceAndShutdown", nil)
	end
end

function IsFullscreenItemPickerOpen()
	return __wf_atom_8e4fda44:FindMovie(v6) ~= nil
end

function OpenFullscreenItemPicker(object, fullscreenItemPickerUiOptions)
	local movie = __wf_atom_8e4fda44:FindMovie(v6)

	if not __wf_atom_7e8ad928(movie) then
		movie:Close()
	end

	_T.FullscreenItemPickerUiOptions = fullscreenItemPickerUiOptions
	object:__wf_atom_f6811c70(v6, "ItemPickerOpened")
end

function CloseFullscreenItemPicker()
	local movie = __wf_atom_8e4fda44:FindMovie(v6)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("AdvanceAndShutdown", nil)
	end
end

function MarkFullscreenItemPickerDirty()
	local movie = __wf_atom_8e4fda44:FindMovie(v6)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("MarkDirty", nil)
	end
end

function DissolveIn(object, p, value, value2, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local mFadeTime = value or 0.5
	local mFadeDelay = value2 or 0
	object:__wf_atom_a763aa1a(1)
	__wf_atom_ec43d06e(object, "_root", 2, { function(p3)
			object:__wf_atom_a763aa1a(1 - p3)
		end }, { 1 }, mFadeTime, mFadeDelay, p)

	if p2 ~= nil then
		p2.mFadeTime = mFadeTime
		p2.mFadeDelay = mFadeDelay
		ShowBackground(p2)
	end
end

function DissolveOut(object, p, value, value2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local mFadeTime = value or 0.5
	local mFadeDelay = value2 or 0
	__wf_atom_ec43d06e(object, "_root", 2, { function(p2)
			object:__wf_atom_a763aa1a(p2)
		end }, { 1 }, mFadeTime, mFadeDelay, p)
	HideBackground({ mFadeTime = mFadeTime, mFadeDelay = mFadeDelay })
end

function DissolveOutAndClose(object, p)
	DissolveOut(object, function()
		if not __wf_atom_7e8ad928(object) then
			object:Close()
		end
	end, p)
end

function DissolveClipIn(object, p, value, value2, value3)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v17 = __wf_atom_421b01aa(value3 or 0, 0, 1)
	object:__wf_atom_1ca72041(p, "Dissolve", 1 - v17, 0, 1, 1)
	__wf_atom_ec43d06e(object, p, 2, { function(p2)
			object:__wf_atom_1ca72041(p, "Dissolve", 1 - v17 - p2, 0, 1, 1)
		end }, { 1 - v17 }, value or 0, value2 or 0)
end

function DissolveClipOut(object, p, value, value2, value3, callback)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v17 = __wf_atom_421b01aa(value3 or 1, 0, 1)
	object:__wf_atom_1ca72041(p, "Dissolve", 1 - v17, 0, 1, 1)
	__wf_atom_ec43d06e(object, p, 2, { function(p2)
			object:__wf_atom_1ca72041(p, "Dissolve", 1 - v17 + p2, 0, 1, 1)
		end }, { v17 }, value or 0, value2 or 0, function()
		if callback then
			callback()
		end
	end)
end

function ToggleElementVisibility(object, p, p2)
	local ternary = module.Ternary(p2, 0, 100)

	if p2 then
		object:__wf_atom_2dedec1a(p, 13, p2)
	end

	__wf_atom_ec43d06e(object, "_root." .. p, 2, { function(p3)
			object:__wf_atom_e57658c2(p, 12, (math.abs(ternary - p3)))
		end }, { 100 }, 0.2, 0, function()
		object:__wf_atom_2dedec1a(p, 13, p2)
	end)
end

function GetAttributeTypeTag(p, p2)
	local v17

	if p2 then
		v17 = v2
	else
		v17 = v
	end

	return v17[(#v17 <= p and 0 or p) + 1]
end

function GetRarityTag(p)
	return v3[(#v3 <= p and 0 or p) + 1]
end

function GetQualityTag(p)
	return v4[(#v4 <= p and 0 or p) + 1]
end

function GetQualityTexture(p)
	if p == 1 then
		return _G.UITexture_BackerTextureStock
	elseif p == 2 then
		return _G.UITexture_BackerTextureMilitary
	elseif p == 3 then
		return _G.UITexture_BackerTextureOfficer
	elseif p == 4 then
		return _G.UITexture_BackerTextureNoble
	elseif p == 5 then
		return _G.UITexture_BackerTextureMasterwork
	elseif p == 6 then
		return _G.UITexture_BackerTextureLegendary
	end

	return nil
end

function GetFactionBorderAndRippleColorFromFactionName(p)
	local uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialDefault
	local v17

	if p == "Cassid" then
		uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialCassid
		v17 = 6172982
	else
		v17 = 16235792
	end

	if p == "Dendrit" then
		uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialDendrit
		v17 = 6176049
	end

	if p == "Fey" or p == "Feykin" then
		uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialFey
		v17 = 2839868
	end

	if p == "Mendicant" then
		uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialMendicant
		v17 = 8355452
	end

	if p == "Ode" or p == "Ode'n" then
		uiMaterial_BorderMaterialDefault = _G.UIMaterial_BorderMaterialOde
		v17 = 3038570
	end

	return uiMaterial_BorderMaterialDefault, v17
end

function GetCreator(p, object)
	if p and p ~= "" then
		return p
	end

	if not __wf_atom_7e8ad928(object) then
		return (object:__wf_atom_818ea3a7())
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if not __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		p = __wf_atom_eab484a7:__wf_atom_6be84646(true)
	end

	return p
end

function GetHTMLAmountText(p, p2)
	local convertColorNumberToHex = module.ConvertColorNumberToHex(module.Ternary(p < p2, _G.UIColor_Yellow, _G.UIColor_Tan))
	local convertColorNumberToHex2 = module.ConvertColorNumberToHex(_G.UIColor_Tan)
	return "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. module.FormatNumber(p) .. "</font><font color=\"" .. convertColorNumberToHex2 .. "\">/" .. module.FormatNumber(p2) .. "</font></p>"
end

function ColorHTMLMessage(p, items)
	local v17 = "<font face=\"Spectral SC\" color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\">"

	for k, item in pairs(items) do
		items[k] = v17 .. item .. "</font>"
	end

	return "<font >" .. Localize(p, items) .. "</font>"
end

function GetInventoryControl()
	if __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not __wf_atom_c4f78a8f:IsA(__wf_atom_7e6ed5fa) then
		return nil
	end

	local __wf_atom_48e698f2 = __wf_atom_c4f78a8f:__wf_atom_48e698f2()

	if __wf_atom_7e8ad928(__wf_atom_48e698f2) or not __wf_atom_48e698f2:IsA(__wf_atom_4d316097) then
		return nil
	end

	return __wf_atom_48e698f2
end

function GetEnvoyInventoryControl()
	if __wf_atom_7e8ad928(gRegion) then
		return nil
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) or not playerAvatar:IsA(__wf_atom_7e6ed5fa) then
		return nil
	end

	local __wf_atom_48e698f2 = playerAvatar:__wf_atom_48e698f2()

	if __wf_atom_7e8ad928(__wf_atom_48e698f2) or not __wf_atom_48e698f2:IsA(__wf_atom_4d316097) then
		return nil
	end

	return __wf_atom_48e698f2
end

function CloseProgressionScreen()
	local movie = __wf_atom_8e4fda44:FindMovie(v7)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("AdvanceAndShutdown", "")
	end
end

function CloseConsumablesOverlay()
	local movie = __wf_atom_8e4fda44:FindMovie(v10)

	if not __wf_atom_7e8ad928(movie) then
		movie:Execute("Close", "")
	end
end

function ShowProgressionScreen(p, progressionOverrides)
	if _T.DisableProgressionSummary then
		_T.DisableProgressionSummary = nil
		return
	end

	local movie = __wf_atom_8e4fda44:FindMovie(v7)
	_T.ProgressionOverrides = progressionOverrides

	if p then
		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("AdvanceAndShutdown", "")
		end
	elseif not __wf_atom_7e8ad928(movie) then
		return
	end

	if p then
		gGameRules:__wf_atom_512342ec()
	elseif __wf_atom_7e8ad928(progressionOverrides) or __wf_atom_7e8ad928(progressionOverrides.CacheIndex) then
		gGameRules:__wf_atom_fd87a8ab()
	else
		gGameRules:__wf_atom_fd87a8ab(progressionOverrides.CacheIndex)
	end

	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(v7, "")
end

function IsDaytime()
	if __wf_atom_7e8ad928(gRegion) then
		return false
	end

	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	return not (__wf_atom_cb3427c9 >= 22 or __wf_atom_cb3427c9 < 6)
end

local function fn(p)
	local v17 = math.floor(p / 86400)
	local v18 = p - v17 * 86400
	local v19 = math.floor(v18 / 3600)
	local v20 = v18 - v19 * 3600
	local v21 = math.floor(v20 / 60)
	return v17, v19, v21, v20 - v21 * 60
end

function GetColloquialTime(object, p, p2)
	local number, number2, number3, v17 = fn(p)
	local v18

	if number > 0 then
		v18 = object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_DaysShort", false, {
			NUMBER = number
		})

		if p2 then
			return v18 .. " " .. object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_HoursShort", false, {
				NUMBER = number2
			})
		end
	elseif number2 > 0 then
		v18 = object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_HoursShort", false, {
			NUMBER = number2
		})

		if p2 then
			return v18 .. " " .. object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_MinutesShort", false, {
				NUMBER = number3
			})
		end
	else
		if number3 > 0 then
			return (object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_MinutesShort", false, {
				NUMBER = number3
			}))
		end

		return (object:__wf_atom_8e9ac384("/SF/Language/Menu/TimeFormat_SecondsShort", false, {
			NUMBER = math.ceil(v17)
		}))
	end

	return v18
end

function GetReplicationMode()
	return gRegion:IsMaster() and 3 or 4
end

function ShowDiegeticNote(p)
	_T.NoteContents = Localize(p, nil)
	__wf_atom_8e4fda44:FindMovie(v8)
	__wf_atom_8e4fda44:__wf_atom_3e5e23c0(v8, "")
end

function ShrinkTextToFit(object, p, p2, p3, p4, p5)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 41)

	while p3 < __wf_atom_5e6e15c8 and p5 < p4 do
		p4 = math.max(p5, p4 - 1)
		object:__wf_atom_e57658c2(p, 50, p4)
		object:__wf_atom_50d60589(p, 36, "")
		object:__wf_atom_50d60589(p, 36, p2)
		__wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 41)
	end

	print("end")
end

function IsMoteType(instance)
	return not __wf_atom_7e8ad928(instance) and instance:IsA(v12)
end

function RegisterHideSubtitles(p)
	if tonumber(_T.HideSubtitles) == nil then
		_T.HideSubtitles = 0
	end

	_T.HideSubtitles = math.max(0, _T.HideSubtitles + module.Ternary(p, 1, -1))
	print("DBG: SubVis " .. _T.HideSubtitles)
end

function RegisterHideHud(p)
	if __wf_atom_7e8ad928(_T.HideHud) then
		_T.HideHud = 0
	end

	_T.HideHud = math.max(0, _T.HideHud + module.Ternary(p, 1, -1))
	print("DBG: HudVis " .. _T.HideHud)
end

function RegisterHideHudSelective(p)
	if __wf_atom_7e8ad928(_T.HideHudSelective) then
		_T.HideHudSelective = 0
	end

	_T.HideHudSelective = math.max(0, _T.HideHudSelective + module.Ternary(p, 1, -1))
	print("DBG: HudVisSelective " .. _T.HideHudSelective)
end

function BlockFastTravel(p)
	if __wf_atom_7e8ad928(_T.BlockFastTravel) then
		_T.BlockFastTravel = 0
	end

	_T.BlockFastTravel = math.max(0, _T.BlockFastTravel + module.Ternary(p, 1, -1))
	print("DBG: BlockFastTravel " .. _T.BlockFastTravel)
end

function ShowBackground(p)
	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(p)
	end
end

function HideBackground(p)
	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground(p)
	end
end

function BuildLoadout(object, p)
	local v17 = p
		or __wf_atom_7e8ad928(gGameData) and gRegion:__wf_atom_eab484a7():__wf_atom_a4299765()
		or gGameData:__wf_atom_a4299765()
	local v18 = not __wf_atom_7e8ad928(object) and object:__wf_atom_d2b2176d() or GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(v18) then
		return
	end

	v18:__wf_atom_91ecc559()
	v18:Clear()
	v18:BuildLoadOut(v17, 0)
	v18:__wf_atom_da1b89a8()
	v18:Update(0)
end

function CenterClipAroundText(object, p, p2, p3, p4)
	local __wf_atom_5e6e15c8 = object:__wf_atom_5e6e15c8(p, 0)
	local __wf_atom_5e6e15c8_2 = object:__wf_atom_5e6e15c8(p, 14)
	local __wf_atom_5e6e15c8_3 = object:__wf_atom_5e6e15c8(p, 40)
	object:__wf_atom_e57658c2(
		p2,
		0,
		__wf_atom_5e6e15c8 + __wf_atom_5e6e15c8_2 / 2 + (p3 and -1 or 1) * (p4 + __wf_atom_5e6e15c8_3 / 2)
	)
end

function IsPlayingCinematic()
	if
		(__wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()))
		and (__wf_atom_7e8ad928(__wf_atom_392793db) or __wf_atom_7e8ad928(__wf_atom_392793db:__wf_atom_c3b255b8()))
	then
		return false
	end

	return true
end

function ShowDevOptions()
	return false
end

function GetPlayerEventId(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return nil
	end

	local __wf_atom_af937b39 = __wf_atom_a96eb2aa:__wf_atom_af937b39()

	if __wf_atom_7e8ad928(__wf_atom_af937b39) then
		return nil
	end

	local __wf_atom_e75653c3 = __wf_atom_af937b39:__wf_atom_e75653c3()

	if __wf_atom_7e8ad928(__wf_atom_e75653c3) then
		return nil
	end

	local v17 = __wf_atom_63c7031a(__wf_atom_e75653c3)
	local v18 = __wf_atom_04d7eaaa()
	__wf_atom_2e624c2f(v17, 0)
	local v19 = __wf_atom_c08f5a0e(0, 9)
	__wf_atom_01bfe5c4(v18)
	return v19
end

local function fn2(object, p)
	local ternary = module.Ternary(p ~= nil, p, 2)
	local v17 = getfenv(ternary)

	while not v17.mMovie or not __wf_atom_7e8ad928(object) and v17.mMovie ~= object do
		ternary += 1
		v17 = getfenv(ternary)
	end

	return v17
end

function IsOSKAvailable(p)
	return Engine.IsOSKAvailable()
		and (Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302() or Engine.__wf_atom_2a979d69() or Engine.__wf_atom_fc67ba71() and p)
end

local function fn3(object, titleString, p, p2, p3, list, items, p4)
	local v17 = {
		isMultiline = false,
		cancelDisabled = false,
		forChat = false,
		desc = nil,
		isEmail = false,
		doFilter = true
	}

	if items ~= nil then
		for k, item in pairs(items) do
			v17[k] = item
		end
	end

	local v18 = p2 == nil and 0 or p2
	local v19

	if __wf_atom_7e8ad928(object) then
		v19 = true
	else
		local v20 = fn2(object, 1)

		if #list > 0 then
			v19 = type(v20[list]) == "function"
		else
			v19 = false
		end
	end

	if IsOSKAvailable(p4) and v19 then
		local v20 = Localize(titleString, {})

		if v18 == 0 then
			return gRegion:__wf_atom_858ae72f(p, v20, v20, false, v17.isEmail, v17.forChat, list, v17.doFilter)
		end

		return gRegion:__wf_atom_06b65d2b(p, v20, v20, false, v17.isEmail, v17.forChat, list, v18)
	else
		if __wf_atom_7e8ad928(v9) then
			return
		end

		local dialogSettings = Engine.DialogSettings()
		dialogSettings.titleString = titleString

		if v17.desc then
			dialogSettings.locString = v17.desc
		end

		if v17.extraTag then
			dialogSettings.firstString = v17.extraTag
		end

		if v17.cancelDisabled then
			dialogSettings.dialogType = 0
		else
			dialogSettings.dialogType = 1

			if v17.noTag then
				dialogSettings.secondString = v17.noTag
			end
		end

		local v20 = nil

		function _T.DialogSetupCallback(p5)
			v20 = p5.AddInputFieldComponent()
			v20:SetMaxChars(v18)

			if v17.isMultiline then
				local v21 = v18 == 0 and 4 or math.min(20, (math.ceil(v18 / 22)))
				v20:SetHeightLines(v21)
				v20:SetMultiline(v17.isMultiline, v21)
			end

			v20:SetText(p)
		end

		dialogSettings:SetCallback(function(p5)
			object:__wf_atom_f62a8704(p3, { p5, v20.mLabel })
		end)
		return true, (module.ShowCustomMessage(dialogSettings))
	end
end

function ShowInputDialog(p, p2, p3, p4, p5, p6, p7)
	return fn3(p, p2, p3, p4, p5, p6, p7)
end

local function fn4(p, p2)
	local v17 = ""

	for _ = 1, p do
		v17 ..= p2
	end

	return ZERO_WIDTH_SPACE .. v17
end

function GetRankStarIcons(p)
	return fn4(p + 1, "<RANK_STAR_ICON>")
end

function GetRankFlowerIcons(p)
	return fn4(p, "<RANK_STAR_ICON>")
end

function OpenColorPicker(object, p, colorPickerCallback, colorPickerOnCloseCallback, colorPickerSpecificColorsInfo)
	_T.ColorPickerCurrentColor = p and string.format("0x%08X", p) or nil
	_T.ColorPickerCallback = colorPickerCallback
	_T.ColorPickerOnCloseCallback = colorPickerOnCloseCallback
	_T.ColorPickerSpecificColorsInfo = colorPickerSpecificColorsInfo

	if _T.InSimulacrum then
		_T.ColorPickerUseCustomBg = true
	end

	return object:PushChildMovie(WeakResource("/Lotus/Interface/ColorPicker.swf"))
end

local function fn5(p, reasonId, mLabel, REPORT_PLAYER2, p2, p3)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if REPORT_PLAYER2 == REPORT_PLAYER then
		local __wf_atom_7190444e = gMatchingService:__wf_atom_7190444e()

		if __wf_atom_7190444e ~= nil then
			__wf_atom_7190444e:__wf_atom_414f1cde(p, reasonId, mLabel, p2)
		end
	elseif REPORT_PLAYER2 == REPORT_CLAN_AD then
		gGameData:__wf_atom_03859ec9(p3, reasonId, mLabel, p2)
	end
end

function ShowReportMenu(object, p, callback, list)
	local REPORT_PLAYER = REPORT_PLAYER
	local reasonId = ""
	local mLabel = ""
	local v17 = fn2(object, 1)

	function v17.OnConfirmReport(p2)
		if tonumber(p2) == 4 then
			fn5(p, reasonId, mLabel, REPORT_PLAYER, "OnReported", nil)
		elseif not __wf_atom_7e8ad928(callback) then
			callback(false)
		end
	end

	function v17.OnReported(p2, _)
		local v18 = nil

		if p2 then
			module.ShowMessage("/Lotus/Language/Menu/ReportPlayerSuccess")
			v18 = reasonId
		else
			module.ShowErrorMessage("/Lotus/Language/Menu/ReportPlayerFailed")
		end

		if not __wf_atom_7e8ad928(callback) then
			callback(v18)
		end

		v17.OnConfirmReport = nil
		v17.OnReported = nil
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.titleString = object:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_ReportPlayer", false)
	dialogSettings.locString = object:__wf_atom_8e9ac384("/SF/Language/Menu/ReportPlayerDescription", false, {
		PLAYER = WrapStringWithFont(p, _G.UIColor_Yellow)
	})
	dialogSettings.firstString = "/SF/Language/Menu/ReportPlayerSubmit"
	local v18 = nil
	local v19 = nil

	function _T.DialogSetupCallback(p2)
		v18 = p2.AddDropDownMenuComponent({ mLabel = "/SF/Language/Menu/ReportPlayerReason" })
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_Spam",
			ReasonId = "Spam"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_OffensiveLanguage",
			ReasonId = "OffensiveLangauge"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_OffensiveName",
			ReasonId = "OffensiveName"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_Harassment",
			ReasonId = "Harassment"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_RealLifeThreat",
			ReasonId = "RealLifeThreat"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_Cheating",
			ReasonId = "Cheating"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_RealMoneyTrade",
			ReasonId = "RealMoneyTrade"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_Griefing",
			ReasonId = "Griefing"
		})
		v18:AddElement({
			Name = "/SF/Language/CustomerSupport/ReportPlayer_HateSpeech",
			ReasonId = "HateSpeech"
		})
		v19 = p2.AddInputFieldComponent()
		v19:SetMaxChars(140)
		v19:SetHeightLines(4)
		v19:SetMultiline(true, 4)
		v19:SetHint("/SF/Language/Menu/ReportPlayerAdditionalComments")
	end

	dialogSettings:SetCallback(function(p2)
		if tonumber(p2) == 4 and v18.mSelectedElement then
			reasonId = v18.mSelectedElement.ReasonId
			mLabel = v19.mLabel
			mLabel = string.gsub(mLabel, "\r\n", " ")
			mLabel = string.gsub(mLabel, "\n", " ")
			mLabel = string.gsub(mLabel, "\r", " ")

			if #list > 0 then
				if #mLabel > 0 then
					mLabel = list .. ": " .. mLabel
				else
					mLabel = list
				end
			end

			local v20 = module.ShowYesOrNoMessage("/Lotus/Language/Menu/ReportPlayer_ConfirmText", "OnConfirmReport")

			if not __wf_atom_7e8ad928(v20) then
				v20:Execute("SetSendCallbackOnShutdown", "true")
			end
		elseif not __wf_atom_7e8ad928(callback) then
			callback(false)
		end
	end)
	return (module.ShowCustomMessage(dialogSettings))
end

function WrapStringWithFont(p, p2, p3, p4)
	local v17 = "<font "

	if p2 ~= nil then
		v17 ..= "color=\"" .. module.ConvertColorNumberToHex(p2) .. "\""
	end

	if p3 ~= nil then
		v17 ..= " face=\"" .. p3 .. "\""
	end

	local v18 = v17 .. ">" .. p .. "</font>"

	if p4 then
		return "<p>" .. v18 .. "</p>"
	end

	return v18
end

function ScaleBackerToViewport(object, p, p2)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v17 = object:__wf_atom_d5a50cb5() / object:__wf_atom_c4f6543f()
	local __wf_atom_97cd8326 = object:__wf_atom_97cd8326()
	local __wf_atom_54eeda24 = object:__wf_atom_54eeda24()
	local v18 = __wf_atom_97cd8326 / __wf_atom_54eeda24

	if p2 then
		__wf_atom_97cd8326 = object:__wf_atom_5e6e15c8(p, 14) / (object:__wf_atom_5e6e15c8(p, 5) / 100)
		__wf_atom_54eeda24 = object:__wf_atom_5e6e15c8(p, 15) / (object:__wf_atom_5e6e15c8(p, 6) / 100)
	end

	local v19 = __wf_atom_97cd8326 / __wf_atom_54eeda24
	local v20, v21

	if v18 < v17 then
		v20 = __wf_atom_54eeda24 * v17 * v19 / v18
		v21 = v20 / v19
	else
		v21 = __wf_atom_97cd8326 * (v18 / v19) / v17
		v20 = v21 * v19
	end

	object:__wf_atom_e57658c2(p, 14, v20)
	object:__wf_atom_e57658c2(p, 15, v21)
end

function CalculateRushCost(p, p2, p3)
	local v17 = p * (p3 / p2)
	return (math.ceil((math.min(p, p * 0.5 + v17))))
end

function GetLocalizedProductType(instance)
	local v17 = "/SF/Language/Categories/UnknownItemType"

	if __wf_atom_7e8ad928(instance) then
		return v17
	end

	local __wf_atom_efa6f447 = instance:__wf_atom_efa6f447()
	local v18

	if __wf_atom_efa6f447 == 3 then
		v18 = "/SF/Language/Categories/Pact"
	elseif __wf_atom_efa6f447 == 5 then
		v18 = "/SF/Language/Categories/Weapon"
	elseif __wf_atom_efa6f447 == 1 then
		v18 = "/SF/Language/Categories/SecondaryWeapon"
	elseif __wf_atom_efa6f447 == 6 then
		if instance:__wf_atom_e84d016c(0) then
			v18 = "/SF/Language/Categories/Helm"
		elseif instance:__wf_atom_e84d016c(2) then
			v18 = "/SF/Language/Categories/Cuirass"
		elseif instance:__wf_atom_e84d016c(3) then
			v18 = "/SF/Language/Categories/Leggings"
		elseif instance:__wf_atom_e84d016c(5) then
			v18 = "/SF/Language/Categories/Totem"
		else
			v18 = "/SF/Language/Categories/Armour"
		end
	elseif __wf_atom_efa6f447 == 2 then
		v18 = instance:IsA(WeakResource("/SF/Types/Items/Consumables/PetConsumeables/BasePetFood"))
			and "/SF/Language/Categories/PetTreat"
			or instance:IsA(WeakResource("/SF/Types/Game/Restorative")) and "/SF/Language/Categories/Elixir"
			or "/SF/Language/Categories/Consumable"
	elseif __wf_atom_efa6f447 == 10 then
		v18 = instance:IsA(WeakResource("/SF/Types/Items/ColorPickerItem"))
			and "/SF/Language/Categories/ColourPalette"
			or v17
	elseif __wf_atom_efa6f447 == 4 then
		if instance:IsA(__wf_atom_16cdad3a) and not instance:IsA(WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")) then
			v18 = "/SF/Language/Categories/Joineries"
		elseif instance:IsA(WeakResource("/SF/Upgrades/SFMotesBaseActiveUpgrade")) then
			v18 = "/SF/Language/Categories/MotesActive"
		elseif instance:IsA(WeakResource("/SF/Upgrades/SFTotemsBaseUpgrade")) then
			v18 = "/SF/Language/Categories/MotesPassive"
		else
			v18 = v17
		end
	else
		v18 = instance:IsA(WeakResource("/SF/Types/PickUps/Resources/IngotBaseResourceItem"))
			and "/SF/Language/Categories/UpgradeItem"
			or v17
	end

	return Localize(v18, nil)
end

function ExecuteForAllPlayers(callback)
	if __wf_atom_7e8ad928(callback) or __wf_atom_7e8ad928(gRegion) then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v17 in pairs(__wf_atom_3c8e1a7a) do
		callback(v17)
	end
end

function IsUndamagableEnemy(object, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_7be51ede = object:__wf_atom_7be51ede()

	if __wf_atom_7e8ad928(__wf_atom_7be51ede) then
		return false
	end

	local playerAvatar = __wf_atom_7be51ede:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) or playerAvatar:IsKilled() then
		return false
	end

	local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) or not __wf_atom_d2b2176d:IsA(__wf_atom_4d316097) then
		return false
	end

	local __wf_atom_a8e8c5c4 = __wf_atom_d2b2176d:__wf_atom_a8e8c5c4()

	if __wf_atom_7e8ad928(__wf_atom_a8e8c5c4) then
		return false
	end

	if module2.IsInvulnerable(object2) then
		return true
	end

	local __wf_atom_21059808 = __wf_atom_a8e8c5c4:__wf_atom_21059808()

	if __wf_atom_21059808 > 0 then
		return __wf_atom_21059808 <= object2:__wf_atom_7470861b():__wf_atom_58367d88(true) + 1
	end

	return false
end

function SetBlockPartyInvites(p)
	if p then
		_T.BlockPartyInvites = (_T.BlockPartyInvites or 0) + 1
	elseif _T.BlockPartyInvites ~= nil then
		if _T.BlockPartyInvites > 0 then
			_T.BlockPartyInvites = _T.BlockPartyInvites - 1
		else
			_T.BlockPartyInvites = nil
		end
	end
end

function GetIsBlockingPartyInvites()
	return _T.BlockPartyInvites ~= nil and _T.BlockPartyInvites > 0
end

function DisbandMultiplayer()
	if module2.IsInMultiplayerSession() then
		if gRegion:IsMaster() then
			local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

			for i = 1, #__wf_atom_3c8e1a7a do
				if not __wf_atom_3c8e1a7a[i]:IsLocal() then
					gMatchingService:__wf_atom_369780a2(__wf_atom_3c8e1a7a[i], false)
				end
			end
		else
			gClient:ForceHostMigration()
		end
	end
end

function SetSoloPlayerMode(p)
	if __wf_atom_7e8ad928(gGameRules) then
		if p then
			print("Failed to enable solo player mode.")
		else
			print("Failed to disable solo player mode.")
		end
	elseif p then
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if __wf_atom_7e8ad928(__wf_atom_15811761) or __wf_atom_15811761:GetSettings().regionId ~= 2 then
			gGameRules:HideGameSession(true)
		end

		while gGameRules:__wf_atom_3aa103d3() do
			Sleep(0)
		end

		SetBlockPartyInvites(true)
	else
		gGameRules:UnHideGameSession()
		SetBlockPartyInvites(false)
	end
end

function AreUpgradesAvailableForSkillTree(object, instance)
	local __wf_atom_dfb755f8 = object:__wf_atom_dfb755f8(instance)

	if __wf_atom_dfb755f8 == 0 or (__wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_cdd2dd31)) then
		return false
	end

	local __wf_atom_5047b73c = instance:__wf_atom_5047b73c()
	local __wf_atom_72055871 = object:__wf_atom_72055871(instance)
	local v17 = {}
	local v18 = {}

	for i = 1, #__wf_atom_5047b73c.nodes do
		v17[__wf_atom_5047b73c.nodes[i]] = i
		local nodeType = __wf_atom_5047b73c.nodeTypes[i]
		local level = 0

		if nodeType:IsA(__wf_atom_cdd2dd31) then
			level = 1
		else
			for _, v19 in __wf_atom_72055871 do
				if not v19.mItemType:IsA(nodeType) then
					continue
				end

				level = v19.mLevel + 1
				break
			end
		end

		table.insert(v18, { technique = nodeType, level = level })
	end

	for i = #__wf_atom_5047b73c.edgePairs - 1, 1, -2 do
		local _ = __wf_atom_5047b73c.edgePairs[i]
		local _ = __wf_atom_5047b73c.edgePairs[i + 1]
		local v19 = v17[__wf_atom_5047b73c.edgePairs[i]]
		local v20 = v17[__wf_atom_5047b73c.edgePairs[i + 1]]

		if v19 and v20 then
			v18[v20].parent = v18[v19]
		end
	end

	for _, v19 in ipairs(v18) do
		local v20 = Resource(v19.technique)

		if __wf_atom_7e8ad928(v20) or not v20:IsA(__wf_atom_32fa4011) then
			continue
		end

		local __wf_atom_576f6429 = v20:__wf_atom_576f6429()
		local level = v19.level

		if
			(v19.parent == nil or v19.parent.level > 0)
			and level < __wf_atom_576f6429
			and v20:__wf_atom_c61f7de4(level) <= __wf_atom_dfb755f8
		then
			return true
		end
	end

	return false
end

function DoesWeaponHaveFillableRuneSlot(object, p)
	if __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local inventory = gGameData:GetInventory()
	local __wf_atom_43563387 = inventory:__wf_atom_43563387(p.mId, 0, false)
	local flag = false

	if __wf_atom_43563387 ~= nil then
		for _, v17 in ipairs(__wf_atom_43563387) do
			if
				__wf_atom_7e8ad928(v17)
				or __wf_atom_7e8ad928(v17.mItemType)
				or Resource(v17.mItemType):__wf_atom_1c14f269() ~= 3
			then
				continue
			end

			flag = true
			break
		end
	end

	if flag then
		return false
	end

	local __wf_atom_af539005 = inventory:__wf_atom_af539005(1, object:__wf_atom_efa6f447(), object, true)

	if __wf_atom_af539005 ~= nil then
		for _, v17 in ipairs(__wf_atom_af539005) do
			if v17.mInstance:__wf_atom_1c14f269() == 3 then
				return true
			end
		end
	end

	return false
end

function AddPickupLogMessage(p, items, p2)
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	local v17 = __wf_atom_7e8ad928(p2) and 0 or p2
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_330f77f5 = __wf_atom_eab484a7:__wf_atom_330f77f5(false)

	if __wf_atom_7e8ad928(__wf_atom_330f77f5) then
		return
	end

	local encoded

	if items then
		local v18 = {}
		local v19 = { Icon = true }

		for k, item in pairs(items) do
			if type(item) == "userdata" and v19[k] then
				v18[k] = item:__wf_atom_5b41f63b()
			elseif type(item) ~= "function" and type(item) ~= "userdata" then
				v18[k] = item
			end
		end

		encoded = cjson.encode(v18)
	else
		encoded = ""
	end

	__wf_atom_330f77f5:AddLogMessage(p, encoded, v17)
end

function SetLevelUpNotificationsVisible(p)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local __wf_atom_301e8d97 = __wf_atom_eab484a7:__wf_atom_301e8d97()

	if __wf_atom_7e8ad928(__wf_atom_301e8d97) then
		return
	end

	__wf_atom_301e8d97:__wf_atom_dbd98029(p)
end

function GetCraftingAncestorForItem(instance)
	local v17 = WeakResource("/SF/Types/Recipes/ColorPalettes/ColorPaletteBlueprint")
	local v18 = WeakResource("/SF/Types/Recipes/Elixers/ElixerRecipeItem")

	if instance:IsA(v17) or instance:IsA(v18) then
		return WeakResource("/SF/Types/Game/Ancestors/Verminia/VerminiaAncestor")
	end

	return v13
end

function KillEnemies()
	local v17 = Symbol("TENNO_TEAM")
	local v18 = Symbol("TENNO")
	_T.KillingSimulacrumEnemies = true
	local all = gRegion:FindAll(__wf_atom_67c46eba)

	for _, v19 in ipairs(all) do
		local __wf_atom_30e3d82b = v19:__wf_atom_30e3d82b()

		if not ((__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_8537d7d4() ~= v17) and v19:__wf_atom_a97361bb() ~= v18) then
			continue
		end

		if not __wf_atom_7e8ad928(v19:__wf_atom_0d9c1a58()) then
			continue
		end

		v19:Suicide()
	end
end

function UpdatePausedEnemies()
	if __wf_atom_7e8ad928(_T.spawnedAgents) or not _T.PauseAI then
		return
	end

	local spawnedAgents = _T.spawnedAgents

	for i = #spawnedAgents, 1, -1 do
		local spawnedAgent = spawnedAgents[i]

		if __wf_atom_7e8ad928(spawnedAgent) then
			table.remove(spawnedAgents, i)
		elseif not spawnedAgent:__wf_atom_160c488b() then
			spawnedAgent:SetPaused(true, v16)
		end
	end
end

function DismantleItem(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v17 = false

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_a87d87b5 = gGameData:GetInventory():__wf_atom_a87d87b5()

		for _, v18 in ipairs(__wf_atom_a87d87b5) do
			if v18.mType ~= v13 then
				continue
			end

			v17 = v18.mRank >= 0
			break
		end
	end

	gGameRules:DismantleItem(p, v17)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local __wf_atom_22020464 = v14:__wf_atom_22020464()

	for _, v18 in ipairs(__wf_atom_22020464) do
		if module2.HasSpecificLoreMemoryUnlocked(__wf_atom_c4f78a8f, v14, v18) then
			continue
		end

		module2.GiveLoreFragmentMemory(__wf_atom_c4f78a8f, v14, v18, true)

		if v18 == Symbol("/SF/Language/Codex/TempersTutorialMemory") then
			__wf_atom_c4f78a8f:Attach(
				Type(v15),
				EMPTY_SYMBOL,
				__wf_atom_28d5d4aa,
				__wf_atom_80368bb1,
				__wf_atom_c4f78a8f,
				1
			)
		end
	end
end

function AddAngle(p, p2)
	local v17 = p + p2

	if v17 > 180 then
		return v17 - 360
	end

	if v17 < -180 then
		return v17 + 360
	end

	return v17
end

function SubtractAngle(p, p2)
	if p - p2 > 180 then
		p -= 360
	end

	if p - p2 < -180 then
		p += 360
	end

	return p - p2
end