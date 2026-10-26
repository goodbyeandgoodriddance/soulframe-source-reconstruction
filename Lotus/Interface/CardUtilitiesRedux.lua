module(..., package.seeall)
CategoryId_ALL = 0
CategoryId_INSTALLED = 1
CategoryId_WARFRAME = 2
CategoryId_AURA = 3
CategoryId_AUGMENT = 4
CategoryId_RIFLE = 5
CategoryId_HAND_GUN = 6
CategoryId_MELEE = 7
CategoryId_STANCE = 8
CategoryId_ARCHWING = 9
CategoryId_ARCHWINGPRIMARY = 10
CategoryId_ARCHWINGSECONDARY = 11
CategoryId_ROBOTIC = 12
CategoryId_COMPANIONS = 13
CategoryId_UNFUSED = 14
CategoryId_UTILITY = 15
CategoryId_OMEGA = 16
CategoryId_IMMORTAL = 17
CategoryId_RAILJACK = 18
CategoryId_TOME = 19
CategoryId_DUPLICATE = 101
CategoryId_INCOMPLETE = 102
MAX_BACKGROUND_HEIGHT = 340
MAX_BACKGROUND_WIDTH = 260
warframeForFiltering = WeakResource("/Lotus/Types/Game/PowerSuits/PlayerPowerSuit")
rifleForFiltering = WeakResource("/Lotus/Weapons/Tenno/LotusLongGun")
pistolForFiltering = WeakResource("/SF/Weapons/Tenno/Pistol/SFPistol")
roboticForFiltering = WeakResource("/Lotus/Types/Game/Pets/RoboticPetPowerSuit")
companionForFiltering = WeakResource("/SF/Types/Game/Pets/PetPowerSuit")
genericPetForFiltering = WeakResource("/SF/Types/Game/SentinelPowerSuit")
archwingMeleeForFiltering = WeakResource("/Lotus/Weapons/Tenno/Archwing/Melee/ArchMeleeWeapon")
archwingGunForFiltering = WeakResource("/Lotus/Weapons/Tenno/Archwing/Primary/ArchGun")
archwingSuitForFiltering = WeakResource("/Lotus/Types/Game/FlightJetPackItems/PlayerFlightJetPackItem")
kdriveSuitForFiltering = WeakResource("/Lotus/Types/Vehicles/Hoverboard/HoverboardSuit")
dataKnifeForFiltering = WeakResource("/Lotus/Weapons/Tenno/HackingDevices/TnHackingDevice/TnHackingDeviceWeapon")
tomeForFiltering = WeakResource("/Lotus/Weapons/Tenno/Pistol/LotusGrimoire")
mechSuitForFiltering = WeakResource("/Lotus/Powersuits/EntratiMech/BaseMechSuit")
crewHarnessForFiltering = WeakResource("/SF/Types/Game/CrewShip/CrewShipHarness")
cosmeticEnhancer = WeakResource("/SF/Types/Game/BaseCosmeticEnhancer")
focusUpgrade = WeakResource("/SF/Types/Game/SFFocusUpgradeBase")
omegaModType = WeakResource("/SF/Types/Game/RandomizedArtifactUpgrade")
omegaRawModType = WeakResource("/Lotus/Types/Game/RawRandomizedArtifactUpgrade")
omegaModEffect = Resource("/Lotus/Fx/Interface/OmegaModParticles")
omegaModBorderEffect = Resource("/Lotus/Fx/Interface/OmegaModBorder")
peculiarModType = WeakResource("/Lotus/Upgrades/CosmeticEnhancers/Peculiars/PeculiarBaseMod")
statOverrideModType = WeakResource("/Lotus/Upgrades/Mods/WeaponStatOverride/WeaponStatOverrideBaseMod")
immortalModType = WeakResource("/Lotus/Upgrades/Mods/Immortal/ImmortalBaseMod")
immortalBrokenIcon = Resource("/Lotus/Interface/Graphics/Mods/ImmortalDamageOverlay.png")
railjackModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseMod")
railjackAuraType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseAuraMod")
railjackBaseTacModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseTacticalMod")
railjackDefenseModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseDefenseAbilityMod")
railjackTacDefModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseTacticalDefenseMod")
railjackOffenseModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseOffenseAbilityMod")
railjackTacOffModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseTacticalOffenseMod")
railjackSuperModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseUltAbilityMod")
railjackTacSuperModType = WeakResource("/Lotus/Upgrades/Mods/Railjack/RailjackBaseTacticalUtilityMod")
garudaClaws = WeakResource("/Lotus/Powersuits/Garuda/GarudaClaws")
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Scripts.Effects.EffectsColorUtilities")
local v = {
	"COMMONUpper",
	"UNCOMMONUpper",
	"RAREUpper",
	"LEGENDARYUpper",
	"OMEGAUpper",
	"PECULIARUpper",
	"AMALGAMUpper",
	"GALVANIZEDUpper",
	"IMMORTALUpper",
	"KAHLUpper",
	"GRIMOIREUpper"
}
local v2 = {
	{ 0.8, 0.5, 0.2, 1 },
	{ 0.4, 0.7, 1.5, 1 },
	{ 1.5, 1.2, 0.4, 1 },
	{ 0.6, 1.3, 1.5, 1 },
	{ 0.67, 0.514, 0.835, 1 },
	{ 1.5, 1.5, 1.5, 1 },
	{ 0.6, 0.3, 0.3, 1 },
	{ 1, 1, 1, 1 },
	{ 1, 1, 1, 1 },
	{ 1, 1, 1, 1 },
	{ 1, 1, 1, 1 }
}
local v3 = {
	{ 0.3, 0.1, 0.01, 1 },
	{ 0.7, 0.7, 0.7, 1 },
	{ 0.8, 0.725, 0.144, 1 },
	{ 1, 1, 1, 0 },
	{ 0.37, 0.254, 0.415, 0 },
	{ 1, 1, 1, 0 },
	{ 1, 1, 1, 0 },
	{ 1, 1, 1, 0 },
	{ 1, 1, 1, 0 },
	{ 0.026, 0.012, 0.00057, 0 },
	{ 1, 0.76, 0.42, 1 }
}
local v4 = {
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowVoid.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowTruth.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowForm.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowOrder.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowLight.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowChaos.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowDecay.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowTime.png"),
	Resource("/Lotus/Interface/Icons/ImmortalRunes/ImmortalRuneGlowWildcard.png")
}
local v5 = {
	ImmortalOneMod = 1,
	ImmortalTwoMod = 2,
	ImmortalThreeMod = 3,
	ImmortalFourMod = 4,
	ImmortalFiveMod = 5,
	ImmortalSixMod = 6,
	ImmortalSevenMod = 7,
	ImmortalEightMod = 8,
	ImmortalWildcardMod = 9
}
local v6 = {
	LohkAuraMod = 1,
	XataStrikeMod = 2,
	JahuAuraMod = 3,
	VomeStrikeMod = 4,
	RisStrikeMod = 5,
	FassAuraMod = 6,
	NetraStrikeMod = 7,
	KhraAuraMod = 8
}
local v7 = {
	".HeaderIcon",
	".HeaderIcon.Utility",
	".TopInfo.Polarity",
	".TopCenterIcon.TopIcon",
	".TopCenterIcon.TopIconBacker",
	".TopInfo.CountBacker",
	".TopInfo.CountBacker.Backer",
	".TopInfo.PolarityBacker",
	".TopInfo.PolarityBacker.Backer",
	".Details.TypeBacker",
	".UsageCounter.UseCounterBacker",
	".ImmortalRank",
	".ImmortalFx",
	".GrimoireFx"
}
local v8 = {
	".Name",
	".Description",
	".TopInfo.CostAndPolarity",
	".TopInfo.Count",
	".Details.Type",
	".Details.Rerolls",
	".UsageCounter.Count",
	".Locked.Label"
}
local v9 = {
	"._parent.Shadow",
	".Background",
	".BottomFrame.ConnectorLine",
	".BottomFrame.Equipped",
	".BottomFrame.Image",
	".BottomFrame.Shards",
	".Icon",
	".Lights",
	".Socket",
	".Socket.Highlight",
	".SocketPolarityBacker",
	".SocketPolarityBacker.Backer",
	".TopFrame",
	".TopFrame.Shards"
}
local v10 = {
	WeakResource("/Lotus/Upgrades/Mods/Warframe/Kahl/KahlAvatarAbilityDurationMod"),
	WeakResource("/Lotus/Upgrades/Mods/Warframe/Kahl/KahlAvatarPowerMaxMod"),
	WeakResource("/Lotus/Upgrades/Mods/Warframe/Kahl/KahlAvatarHealthMaxMod"),
	WeakResource("/Lotus/Upgrades/Mods/Warframe/Kahl/KahlAvatarAbilityStrengthMod"),
	WeakResource("/Lotus/Upgrades/Mods/Warframe/Kahl/KahlAvatarAbilityRangeMod")
}
local v11 = {
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeHPBoostFromImpact"),
		IsPercent = false
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeHPBoostFromImpactMythic"),
		IsPercent = false
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWeaponCritBoostFromHeat"),
		IsPercent = true
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWeaponCritBoostFromHeatMythic"),
		IsPercent = true
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeElectricDamage"),
		IsPercent = true
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeElectricDamageMythic"),
		IsPercent = true
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeCritDamageBoost"),
		IsPercent = true
	},
	{
		UpgradeType = WeakResource("/Lotus/Upgrades/Invigorations/ArchonCrystalUpgrades/ArchonCrystalUpgradeWarframeCritDamageBoostMythic"),
		IsPercent = true
	}
}
local fn

local function fn2()
	local v12 = 2
	local v13 = getfenv(v12)

	while not v13.mMovie do
		v12 += 1
		v13 = getfenv(v12)
	end

	return v13
end

local function fn3(mUpgradeItemType)
	return not __wf_atom_7e8ad928(mUpgradeItemType) and v5[mUpgradeItemType:GetName()] == 9
end

local function fn4(object, p)
	if not __wf_atom_7e8ad928(object) then
		local v12 = p[object:GetName()]

		if v12 ~= nil then
			return v4[v12]
		end
	end

	return nil
end

function GetImmortalGlowIcon(p)
	return fn4(p, v5)
end

function GetImmortalGlowIconByIndex(p)
	return v4[p]
end

local function fn5(p, p2)
	if p2 ~= nil then
		return p2
	end

	if p.Card ~= nil then
		return p.Card
	end

	local cards = fn2().GetCards()

	if cards == nil then
		return nil
	end

	return cards[p.mCardIndex]
end

local function fn6(_, p, value, p2, p3, p4)
	if p.affixes == nil or p3 == 1 and not p2 and value ~= "" then
		return (string.gsub(value, "x%+", "+x"))
	end

	if #p.affixes > 0 and value ~= "" then
		value ..= "\r\n"
	end

	for i = 1, #p.affixes do
		if p.affixes[i] == "" then
			continue
		end

		if value ~= "" then
			value ..= "\r\n"
		end

		local affix = p.affixes[i]

		if p4 ~= nil then
			local v12 = string.match(affix, "(%d*%.?%d+)")
			local v13 = tonumber(v12)

			if v13 ~= nil then
				local formatNumber = module.FormatNumber(v13 + v13 * p4, 1, false)
				affix = string.gsub(affix, v12, formatNumber)
			end
		end

		value ..= affix
	end

	return (string.gsub(value, "x%+", "+x"))
end

function GetBackgroundHeightMultiplier()
	return 512 / 337
end

local function fn7(data, p)
	if
		data.mUpgradeType ~= 1
		or __wf_atom_7e8ad928((data.mArtifactUpgrade:__wf_atom_7ec2d06a(data.mUpgrade.mUpgradeFingerprint)))
	then
		return nil
	end

	local mUpgradeObject = data.mUpgradeObject

	if not p then
		mUpgradeObject = Resource(mUpgradeObject)
	end

	return mUpgradeObject
end

function GetAbilityFromCard(p, p2)
	return fn7(p, p2)
end

function AbilityNameFromCard(data, object)
	if __wf_atom_7e8ad928(object) then
		return ""
	end

	if
		data.mUpgradeType == 1
		and not __wf_atom_7e8ad928((data.mArtifactUpgrade:__wf_atom_7ec2d06a(data.mUpgrade.mUpgradeFingerprint)))
	then
		return (tostring(object:GetStoreItem(data.mUpgradeItemType):__wf_atom_014a76a2()))
	end
end

local function fn8(p, p2)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	if not __wf_atom_7e8ad928(p.mUpgradeItemType) then
		return p.mUpgradeItemType:IsA(omegaModType) or p2 and p.mUpgradeItemType:IsA(omegaRawModType)
	end

	if not __wf_atom_7e8ad928(p.mArtifactUpgrade) then
		return p.mArtifactUpgrade:IsA(omegaModType) or p2 and p.mArtifactUpgrade:IsA(omegaRawModType)
	end

	return false
end

function IsCardOmega(p, p2)
	return fn8(p, p2)
end

local function fn9(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:IsA(peculiarModType)
end

function IsCardPeculiar(p)
	return fn9(p)
end

local function fn10(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:__wf_atom_38ed2a4b()
end

function IsCardAmalgam(p)
	return fn10(p)
end

local function fn11(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:IsA(railjackModType)
end

function IsCardRailjack(p)
	return fn11(p)
end

local function fn12(p)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	local uiCategoryIcon_RailjackSuperOn = nil
	local mArtifactUpgrade = p.mArtifactUpgrade

	if mArtifactUpgrade:IsA(railjackDefenseModType) or mArtifactUpgrade:IsA(railjackTacDefModType) then
		return _G.UICategoryIcon_RailjackDefensiveOn
	end

	if mArtifactUpgrade:IsA(railjackOffenseModType) or mArtifactUpgrade:IsA(railjackTacOffModType) then
		return _G.UICategoryIcon_RailjackOffensiveOn
	end

	if mArtifactUpgrade:IsA(railjackSuperModType) or mArtifactUpgrade:IsA(railjackTacSuperModType) then
		uiCategoryIcon_RailjackSuperOn = _G.UICategoryIcon_RailjackSuperOn
	end

	return uiCategoryIcon_RailjackSuperOn
end

local function fn13(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:__wf_atom_10375371()
end

function IsCardGalvanized(p)
	return fn13(p)
end

local function fn14(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:__wf_atom_84da2c4a()
end

function IsCardImmortal(p)
	return fn14(p)
end

function IsCardGrimoire(p)
	if __wf_atom_7e8ad928(p) then
	end

	return false
end

local function fn15(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	return p.mArtifactUpgrade:__wf_atom_a81b8586()
end

function IsCardStarter(p)
	return fn15(p)
end

local function fn16(p)
	if __wf_atom_7e8ad928(p) then
		return false
	end

	local mArtifactUpgrade = p.mArtifactUpgrade

	for i = 1, #v10 do
		if mArtifactUpgrade:IsA(v10[i]) then
			return true
		end
	end

	return false
end

function EnableCardVisibleRange(p, p2, p3)
	local v12 = p3 ~= false
	local mMovie = fn2().mMovie
	local v13 = fn5(p)

	if v12 then
		for _, v14 in ipairs(v7) do
			mMovie:__wf_atom_83a44191(p2 .. v14, "VisibilitySize")
		end

		for _, v14 in ipairs(v8) do
			mMovie:__wf_atom_83a44191(p2 .. v14, "VisibilitySize")
		end

		for _, v14 in ipairs(v9) do
			mMovie:__wf_atom_83a44191(p2 .. v14, "VisibilitySize")
		end

		for i = 1, v13.mLevelLimit do
			mMovie:__wf_atom_83a44191(p2 .. ".BottomFrame.Level" .. i, "VisibilitySize")
			mMovie:__wf_atom_83a44191(p2 .. ".BottomFrame.GrimoireLevel" .. i, "VisibilitySize")
		end
	else
		for _, v14 in ipairs(v7) do
			mMovie:__wf_atom_1ca72041(p2 .. v14, "VisibilitySize", 3, 0, 0, 0)
		end

		for _, v14 in ipairs(v8) do
			mMovie:__wf_atom_1ca72041(p2 .. v14, "VisibilitySize", 3, 0, 0, 0)
		end

		for _, v14 in ipairs(v9) do
			mMovie:__wf_atom_1ca72041(p2 .. v14, "VisibilitySize", 3, 0, 0, 0)
		end

		for i = 1, v13.mLevelLimit do
			mMovie:__wf_atom_1ca72041(p2 .. ".BottomFrame.Level" .. i, "VisibilitySize", 3, 0, 0, 0)
			mMovie:__wf_atom_1ca72041(p2 .. ".BottomFrame.GrimoireLevel" .. i, "VisibilitySize", 3, 0, 0, 0)
		end
	end
end

local function fn17(object, p)
	if not object:Execute("ShowModToolTips", "") then
		return false
	end

	local v12 = #p.mArtifactUpgrade:__wf_atom_a649b1ed() > 0

	if not v12 and fn11(p) and not p.mArtifactUpgrade:IsA(railjackBaseTacModType) then
		return not __wf_atom_7e8ad928(fn7(p, true))
	end

	return v12
end

local function fn18(mMovie, data, clipName)
	local infoPopup_Data = {}
	local __wf_atom_a649b1ed = data.mArtifactUpgrade:__wf_atom_a649b1ed()

	if #__wf_atom_a649b1ed > 0 then
		local count = 0
		local v12 = "<p><font >"

		for i = 1, #__wf_atom_a649b1ed do
			local __wf_atom_011a196c = _G.UITypes_ModTips:__wf_atom_011a196c(__wf_atom_a649b1ed[i])

			if __wf_atom_011a196c.tag == EMPTY_SYMBOL then
				continue
			end

			if count > 0 then
				v12 ..= "<br><br>"
			end

			v12 = (v12 .. "<b>" .. mMovie:__wf_atom_8e9ac384(__wf_atom_011a196c.name:c_str(), true) .. "</b>") .. "<br>" .. mMovie:__wf_atom_8e9ac384(
				__wf_atom_011a196c.desc:c_str(),
				true
			)
			count += 1
		end

		infoPopup_Data = {
			CustomEntry = true,
			LocalizedDesc = v12 .. "</font></p>"
		}
	elseif fn11(data) and not data.mArtifactUpgrade:IsA(railjackBaseTacModType) then
		local resource = fn7(data, true)

		if not __wf_atom_7e8ad928(resource) then
			infoPopup_Data = {
				CustomEntry = true,
				IsAbility = true,
				IsRailjackAbility = true,
				Resource = resource,
				Name = data.mName,
				Level = data.mLevel,
				AbilityLevelOverride = data.mLevel
			}
		end
	end

	infoPopup_Data.Rect = { W = 200, H = 100 }

	if __wf_atom_7e8ad928(mMovie:__wf_atom_8cdb5ac9()) then
		local transformPixelToViewportCoordinates = module.TransformPixelToViewportCoordinates(mMovie, {
			x = mMovie:__wf_atom_5e6e15c8(clipName, 2),
			y = mMovie:__wf_atom_5e6e15c8(clipName, 3)
		})
		infoPopup_Data.Rect.X = transformPixelToViewportCoordinates.x
		infoPopup_Data.Rect.Y = transformPixelToViewportCoordinates.y
	else
		infoPopup_Data.Rect.IsDiegetic = true
		infoPopup_Data.Rect.Movie = mMovie
		infoPopup_Data.Rect.ClipName = clipName
	end

	_T.InfoPopup_Data = infoPopup_Data
end

function ZoomCard(state, clipName, zoomed, p, p2, p3, p4, p5, p6)
	local mMovie = fn2().mMovie
	local v12 = false
	local v13 = fn5(state, p4)

	if state.DrawingEmpty or v13 == nil then
		return
	end

	local v14 = fn14(v13)
	local v15 = IsCardGrimoire(v13)
	local _, v16 = fn(v13)

	if v16 == "Omega" then
		if zoomed then
			__wf_atom_86cbd68d(mMovie, clipName .. ".TopFrame.Shards.play")
			__wf_atom_86cbd68d(mMovie, clipName .. ".BottomFrame.Shards.play")
		else
			__wf_atom_86cbd68d(mMovie, clipName .. ".TopFrame.Shards.gotoAndStop", 1)
			__wf_atom_86cbd68d(mMovie, clipName .. ".BottomFrame.Shards.gotoAndStop", 1)
		end
	end

	local v17 = p6 == nil and 1 or p6
	local mItemCount = v13.mUpgrade.mItemCount

	for _, _ in pairs(v13.mInstalled) do
		v12 = true
		break
	end

	if p5 == nil then
		p5 = module.Ternary(zoomed, 2, 1)
	end

	local uiMaterial_Mod = _G.UIMaterial_Mods[p5]

	if fn9(v13) then
		mMovie:OverrideMaterial(clipName .. ".Lights", uiMaterial_Mod.PeculiarEnergy)
	else
		mMovie:OverrideMaterial(clipName .. ".Lights", uiMaterial_Mod.Energy)
	end

	mMovie:OverrideMaterial(clipName .. ".BottomFrame.Equipped", uiMaterial_Mod.Energy)

	if fn8(v13, true) then
		mMovie:OverrideMaterial(clipName .. ".TopFrame.Shards", uiMaterial_Mod.BottomFrame)
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Shards", uiMaterial_Mod.BottomFrame)
	end

	local c_str = v13.mSyndicate:c_str()

	if c_str == "" then
		if fn8(v13) and v13.mIdentified and #v13.mIcons > 1 then
			mMovie:OverrideMaterial(clipName .. ".Icon", uiMaterial_Mod.OmegaIcon)
		elseif v14 then
			if fn3(v13.mUpgradeItemType) and v13.mLevel ~= v13.mLevelLimit then
				mMovie:OverrideMaterial(clipName .. ".Icon", _G.UIMaterial_Mods[2].ImmortalWildcardIcon)
			else
				mMovie:OverrideMaterial(clipName .. ".Icon", uiMaterial_Mod.ImmortalIcon)
			end
		elseif v15 then
			mMovie:OverrideMaterial(clipName .. ".Icon", uiMaterial_Mod.ImmortalIcon)
		else
			mMovie:OverrideMaterial(clipName .. ".Icon", uiMaterial_Mod.Icon)
		end
	else
		mMovie:OverrideMaterial(clipName .. ".Icon", _G.UIMaterial_ModsSyndicateIcons[p5][c_str])
	end

	mMovie:OverrideMaterial(clipName .. "._parent.Shadow", uiMaterial_Mod.Content)

	if fn9(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.PeculiarBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.Background)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.PeculiarTopFrame)
	elseif fn13(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.GalvanizedBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.Background)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.GalvanizedTopFrame)
	elseif fn14(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.ImmortalBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.ImmortalBackground)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.ImmortalTopFrame)
	elseif IsCardGrimoire(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.GrimoireBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.GrimoireBackground)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.GrimoireTopFrame)
	elseif fn11(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.AvionicBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.Background)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.AvionicTopFrame)
	elseif fn16(v13) then
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.KahlBottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.Background)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.KahlTopFrame)
	else
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Image", uiMaterial_Mod.BottomFrame)
		mMovie:OverrideMaterial(clipName .. ".Background", uiMaterial_Mod.Background)
		mMovie:OverrideMaterial(clipName .. ".TopFrame", uiMaterial_Mod.TopFrame)
	end

	local content = uiMaterial_Mod.Content

	for _, v18 in ipairs(v7) do
		mMovie:OverrideMaterial(clipName .. v18, content)
	end

	local text = uiMaterial_Mod.Text

	for _, v18 in ipairs(v8) do
		mMovie:OverrideMaterial(clipName .. v18, text)
	end

	for i = 1, v13.mLevelLimit do
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.Level" .. i, content)
		mMovie:OverrideMaterial(clipName .. ".BottomFrame.GrimoireLevel" .. i, content)
	end

	mMovie:OverrideMaterial(clipName .. ".Locked.LabelBg", uiMaterial_Mod.SmoothEdge)
	mMovie:OverrideMaterial(clipName .. ".BottomFrame.ConnectorLine", content)
	mMovie:OverrideMaterial(clipName .. ".BottomFrame.New.Bg", uiMaterial_Mod.SmoothEdge)
	mMovie:OverrideMaterial(clipName .. ".BottomFrame.New.Label", text)
	local v18 = tonumber(mMovie:__wf_atom_76657dba(clipName .. ".Icon.transition"))
	local v19 = v18 == nil and 1 or v18
	local v20 = module.Ternary(zoomed, 1, 0) - v19

	if v13.NameHeight == nil then
		v13.NameHeight = mMovie:__wf_atom_5e6e15c8(clipName .. ".Name", 41)

		if v13.NameHeight == nil then
			v13.NameHeight = 26
		end
	end

	if v13.IconHeight == nil then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(clipName .. ".Description", 41)
		local v21 = __wf_atom_5e6e15c8 == nil and 26 or __wf_atom_5e6e15c8
		v13.IconHeight = math.min(MAX_BACKGROUND_HEIGHT - v13.NameHeight - v21 - 74, 256)
	end

	if v13.IconMid == nil then
		v13.IconMid = __wf_atom_104bfe98(0.25, 0.5, v13.IconHeight / 256)
	end

	local v21 = v13.IconHeight / 256

	local function fn19(p7)
		local v22 = v19 + v20 * p7
		mMovie:__wf_atom_1ca72041(
			clipName .. ".Icon",
			"BlendOffsetParallax",
			v22 * v17,
			__wf_atom_104bfe98(0.25, v13.IconMid, v22),
			__wf_atom_104bfe98(0.35, v21, v22),
			0.025
		)
		mMovie:__wf_atom_c0d7a318(clipName, "Icon", "transition", v22)
	end

	local v22 = __wf_atom_7e8ad928(p) and 0.35 or p
	state.Zoomed = zoomed
	local iconY = 0
	local zoomedNameY = 0
	local v23 = not v14 and (v15 and 42 or 100) or v13.mLevel < v13.mLevelLimit and 42 or 66
	local MAX_BACKGROUND_HEIGHT2

	if zoomed then
		MAX_BACKGROUND_HEIGHT2 = MAX_BACKGROUND_HEIGHT

		if v13.IconY == nil or v13.ZoomedNameY == nil then
			print("CardUtilitiesRedux::ZoomCard - Card has nil IconY, ZoomCard called before DrawCard?")
		else
			iconY = v13.IconY
			zoomedNameY = v13.ZoomedNameY
		end

		if v14 and v13.mLevel == v13.mLevelLimit then
			zoomedNameY += 50
		end

		if mItemCount > 1 and not v12 then
			__wf_atom_ec43d06e(mMovie, clipName .. ".StackFrame", 8, { 16, 1 }, { -6, 5 }, 0.1, 0.2)
		end

		if fn17(mMovie, v13) then
			fn18(mMovie, v13, clipName)
		end
	else
		MAX_BACKGROUND_HEIGHT2 = 100
		iconY = v14 and 0 or v15 and 10 or 62
		zoomedNameY = 9 - v13.NameHeight * 0.5

		if fn8(v13, true) then
			zoomedNameY -= 5
		end

		__wf_atom_ec43d06e(mMovie, clipName .. ".StackFrame", 6, { 16, 1 }, { 0, 0 }, v22)

		if fn17(mMovie, v13) then
			_T.InfoPopup_Data = nil
		end
	end

	if state.mClipName ~= nil then
		mMovie:__wf_atom_4c1c1986(state.mClipName, "Btn", 15, (math.min(MAX_BACKGROUND_HEIGHT2, 180)))
	end

	if p2 ~= nil and p3 ~= nil then
		if v22 > 0 then
			__wf_atom_ec43d06e(mMovie, clipName, 6, { 0, 1 }, { p2, p3 }, v22)
		else
			mMovie:__wf_atom_e57658c2(clipName, 0, p2)
			mMovie:__wf_atom_e57658c2(clipName, 1, p3)
		end
	end

	local ternary = module.Ternary(zoomed, 100, 0)

	if mItemCount == 0 then
		__wf_atom_ec43d06e(
			mMovie,
			clipName .. ".Locked",
			6,
			{ 1, 12 },
			{ -(MAX_BACKGROUND_HEIGHT2 * 0.5) + 21, ternary },
			v22
		)
	end

	__wf_atom_ec43d06e(mMovie, clipName .. ".Background", 6, { 15 }, { MAX_BACKGROUND_HEIGHT2 * (512 / 337) }, v22)
	__wf_atom_ec43d06e(mMovie, clipName .. ".TopFrame", 6, { 1 }, { -(MAX_BACKGROUND_HEIGHT2 * 0.5) - 16 }, v22)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".IconMask",
		6,
		{ 1, 15 },
		{ -(MAX_BACKGROUND_HEIGHT2 * 0.5) - 2, MAX_BACKGROUND_HEIGHT2 },
		v22
	)
	__wf_atom_ec43d06e(mMovie, clipName .. ".BottomFrame", 6, { 1 }, { MAX_BACKGROUND_HEIGHT2 * 0.5 - 86 }, v22)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".Lights",
		6,
		{ 1, 6, 12 },
		{ MAX_BACKGROUND_HEIGHT2 * 0.5 - 44, module.Ternary(zoomed, 100, 35), ternary },
		v22
	)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".Details",
		6,
		{ 1, 12 },
		{ MAX_BACKGROUND_HEIGHT2 * 0.5 - 17, ternary },
		v22
	)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".ImmortalRank",
		6,
		{ 1, 12 },
		{ MAX_BACKGROUND_HEIGHT2 * 0.5 - 49, ternary },
		v22
	)
	__wf_atom_ec43d06e(mMovie, clipName .. ".Icon", 6, { 1, fn19, 12, 5, 6 }, {
		iconY,
		1,
		module.Ternary(v15 and not zoomed, 65, 100),
		v23,
		v23
	}, v22)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".Name",
		6,
		{ 1, 12 },
		{ zoomedNameY, module.Ternary(v14 and not zoomed, 0, 100) },
		v22
	)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".Description",
		6,
		{ 1, 12 },
		{ zoomedNameY + v13.NameHeight + module.Ternary(v14, 14, 2), ternary },
		v22
	)
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".TopInfo",
		6,
		{ 1 },
		{ -(MAX_BACKGROUND_HEIGHT2 * 0.5) + module.Ternary(v15, 44, 34) },
		v22
	)
	local v24 = v13.mTopIconYOffset == nil and 0 or v13.mTopIconYOffset
	__wf_atom_ec43d06e(
		mMovie,
		clipName .. ".TopCenterIcon",
		6,
		{ 1 },
		{ -(MAX_BACKGROUND_HEIGHT2 * 0.5) + 34 + v24 },
		v22
	)
	__wf_atom_ec43d06e(mMovie, clipName .. ".HeaderIcon", 6, { 1 }, { -(MAX_BACKGROUND_HEIGHT2 * 0.5) + 7 }, v22)
	__wf_atom_ec43d06e(mMovie, clipName .. ".UsageCounter", 6, { 1 }, { module.Ternary(zoomed, -60, -4) }, v22)
	local v25 = module.Ternary(zoomed, 0, -(MAX_BACKGROUND_HEIGHT2 * 0.5) - 70) + module.Ternary(p3 ~= nil, p3, 0)
	local v26 = { ternary, 0 + module.Ternary(p2 ~= nil, p2, 0), v25 }
	__wf_atom_ec43d06e(mMovie, clipName .. "._parent.Shadow", 6, { 12, 0, 1 }, v26, v22)
end

local function fn19(p)
	return (__wf_atom_7e8ad928(p.mUpgrade) or __wf_atom_7e8ad928(p.mArtifactUpgrade) or not p.mArtifactUpgrade:IsA(__wf_atom_58a409f1))
		and 0
		or p.mArtifactUpgrade:__wf_atom_e8638878(p.mUpgrade.mUpgradeFingerprint)
end

function CalcCardRating(p)
	return fn19(p)
end

local function fn20(object, p, p2, p3, p4)
	if p4 == nil then
		p4 = false
	end

	local __wf_atom_43563387 = object:__wf_atom_43563387(p, p3, p4)

	if __wf_atom_7e8ad928(__wf_atom_43563387) then
		return
	end

	local mItemId = p2.mUpgrade.mItemId
	local mItemType = p2.mUpgrade.mItemType

	for i = 1, #__wf_atom_43563387 do
		if mItemId:__wf_atom_b70c3343() then
			if __wf_atom_43563387[i].mItemId:__wf_atom_b70c3343() and __wf_atom_43563387[i].mItemType == mItemType then
				p2.mInstalled[p.mItemId.mId] = i
			end
		elseif __wf_atom_43563387[i].mItemId == mItemId then
			p2.mInstalled[p.mItemId.mId] = i
		end
	end
end

function CheckInstalled(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(p2) then
		return
	end

	if p4 ~= nil then
		fn20(p, p2, p3, p4, p5)
		return
	end

	fn20(p, p2, p3, 0, p5)
	fn20(p, p2, p3, 1, p5)
	fn20(p, p2, p3, 2, p5)
end

function BuildInstalled(p, object, p2)
	local v12 = p2 == nil and 3 or p2
	local v13 = {}

	if v12 == 1 or v12 == 3 then
		table.insert(v13, {
			upgrades = object:__wf_atom_df500044(false),
			isPvp = 0
		})
	end

	if v12 == 2 or v12 == 3 then
		table.insert(v13, {
			upgrades = object:__wf_atom_df500044(true),
			isPvp = 1
		})
	end

	for i = 1, #v13 do
		local upgrades = v13[i].upgrades

		for j = 1, #upgrades do
			__wf_atom_83c14687(0)
			local upgrade = upgrades[j]
			local __wf_atom_15a67666 = upgrade:__wf_atom_15a67666()
			local upgradeInfo = upgrade:GetUpgradeInfo()
			local mItemId = upgradeInfo.mItemId
			local mItemType = upgradeInfo.mItemType

			if mItemId:__wf_atom_b70c3343() then
				if not __wf_atom_7e8ad928(mItemType) then
					local v14 = tostring(mItemType:__wf_atom_5b41f63b())

					if not p[v14] then
						p[v14] = {}
					end

					if v12 == 3 then
						if not p[v14][__wf_atom_15a67666] then
							p[v14][__wf_atom_15a67666] = {}
						end

						p[v14][__wf_atom_15a67666][v13[i].isPvp] = upgradeInfo
					else
						p[v14][__wf_atom_15a67666] = upgradeInfo
					end
				end
			else
				local v14 = tostring(mItemId)

				if not p[v14] then
					p[v14] = {}
				end

				if v12 == 3 then
					if not p[v14][__wf_atom_15a67666] then
						p[v14][__wf_atom_15a67666] = {}
					end

					p[v14][__wf_atom_15a67666][v13[i].isPvp] = upgradeInfo
				else
					p[v14][__wf_atom_15a67666] = upgradeInfo
				end
			end
		end
	end
end

local function fn21(p)
	return p ~= nil and p.mPolarity == 6 and p.mRarity == 3
end

function IsLegendaryFusion(p)
	return fn21(p)
end

function UpdateOmegaCard(state, instance, object)
	local v12 = fn2()
	local v13 = nil
	local decoded = cjson.decode(state.mUpgrade.mUpgradeFingerprint)

	if __wf_atom_7e8ad928(decoded) or __wf_atom_7e8ad928(decoded.compat) then
		return
	end

	if __wf_atom_1ef90898(instance) then
		instance = Resource(instance)
	end

	if __wf_atom_7e8ad928(object) then
		if instance:IsA(__wf_atom_9df43583) and instance:__wf_atom_f3505c97() then
			local __wf_atom_5a5d4027 = instance:__wf_atom_5a5d4027()

			for _, v14 in ipairs(__wf_atom_5a5d4027) do
				local v15 = Resource(v14)

				if not (v15:__wf_atom_2d576057() == 8 or v15:__wf_atom_2d576057() == 1) then
					continue
				end

				v13 = instance
				instance = v15
				break
			end
		end
	else
		decoded.compat = object:__wf_atom_5b41f63b()
	end

	if __wf_atom_7e8ad928(object) then
		decoded.compat = instance:__wf_atom_1bb5b1ff():__wf_atom_5b41f63b()
	end

	local encoded = cjson.encode(decoded)
	local mUpgradeFingerprint = string.gsub(encoded, "\\/", "/")
	state.mUpgrade.mUpgradeFingerprint = mUpgradeFingerprint
	local __wf_atom_d212c718 = state.mArtifactUpgrade:__wf_atom_d212c718(state.mUpgrade.mUpgradeFingerprint, v13)
	state.mDesc = ""
	state.mDesc = fn6(mMovie, __wf_atom_d212c718, state.mDesc, false, state.mUpgradeType, nil)
	state.mDesc = v12.mMovie:__wf_atom_b4b867f2(state.mDesc)
end

local function fn22(p, state)
	if not __wf_atom_7e8ad928(state.mModSet) then
		if
			not _T.InModPreview
			and _T.SelectedLoadOutPart == 5
			and (_T.mSpecialSuitMode or not state.mModSet:__wf_atom_ea0b3b4c())
		then
			return
		end

		local mMovie = p.mMovie
		local v12 = {}
		local count = 0
		local inventory = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():GetInventory()
		local v13

		if __wf_atom_7e8ad928(_T.MenuSuitAvatar) then
			v13 = false
		else
			v13 = not __wf_atom_7e8ad928(_T.MenuSuitAvatar:__wf_atom_d2b2176d():__wf_atom_28224c27(5))
		end

		if _T.InModPreview then
			if #_T.ModPreviewEquippedUpgrades > 0 then
				for _, modPreviewEquippedUpgrade in ipairs(_T.ModPreviewEquippedUpgrades) do
					local __wf_atom_a56ddec5 = modPreviewEquippedUpgrade:__wf_atom_a56ddec5()

					if __wf_atom_7e8ad928(__wf_atom_a56ddec5) or not state.mModSet:IsA(__wf_atom_a56ddec5) then
						continue
					end

					count += 1
				end
			end
		else
			for i = 0, 3 - 1 do
				local __wf_atom_c132f79b = inventory:__wf_atom_c132f79b(i, inventory:__wf_atom_d25917b6(i))

				for j = 0, 6 - 1 do
					local __wf_atom_b369d77f = __wf_atom_c132f79b:__wf_atom_b369d77f(j)

					if not __wf_atom_b369d77f.mItemId:__wf_atom_8598f3a9() then
						continue
					end

					local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(i, j, __wf_atom_b369d77f.mItemId.mId)
					local __wf_atom_43563387 = inventory:__wf_atom_43563387(
						__wf_atom_0ff4b555,
						i,
						j,
						__wf_atom_b369d77f.mModSlot
					)

					if __wf_atom_7e8ad928(__wf_atom_43563387) then
						continue
					end

					for _, v14 in ipairs(__wf_atom_43563387) do
						local mInstance = v14.mInstance

						if __wf_atom_7e8ad928(mInstance) then
							continue
						end

						local __wf_atom_f6844bcd = mInstance:__wf_atom_f6844bcd()

						if __wf_atom_7e8ad928(__wf_atom_f6844bcd) then
							continue
						end

						local v15 = false

						for k = 1, #v12 do
							if v12[k] ~= mInstance:__wf_atom_1bb5b1ff() then
								continue
							end

							v15 = true
							break
						end

						local __wf_atom_ea0b3b4c = __wf_atom_f6844bcd:__wf_atom_ea0b3b4c()

						if __wf_atom_ea0b3b4c then
							if _T.SelectedLoadOutPart == nil then
								__wf_atom_ea0b3b4c = false
							else
								__wf_atom_ea0b3b4c = _T.SelectedLoadOutPart - 1 == j
							end
						end

						local v16 = __wf_atom_0ff4b555.mItemType:IsA(garudaClaws) and not v13
						local v17 = not __wf_atom_f6844bcd:__wf_atom_ea0b3b4c() and (j ~= 4 or v16)

						if
							v15
							or __wf_atom_f6844bcd:__wf_atom_1bb5b1ff() ~= state.mModSet:__wf_atom_1bb5b1ff()
							or not (count < state.mMaxSetUpgrades)
							or not (v17 or __wf_atom_ea0b3b4c)
						then
							continue
						end

						table.insert(v12, mInstance:__wf_atom_1bb5b1ff())
						count += 1
					end
				end
			end
		end

		state.mNumModSetEquipped = count
		state.mSetDesc = ""

		for i = 1, state.mMaxSetUpgrades do
			if i <= state.mNumModSetEquipped then
				state.mSetDesc ..= "<MOD_SET_FILLED_NOTCH>"
			else
				state.mSetDesc ..= "<MOD_SET_EMPTY_NOTCH>"
			end
		end

		state.mSetDesc ..= "\r\n"
		local v14 = not (state.mNumModSetEquipped > 1) and ""
			or "{\"lvl\":" .. math.min(state.mNumModSetEquipped, state.mMaxSetUpgrades) - 1 .. "}"
		state.ModSetDescription = {
			Equipped = state.mNumModSetEquipped,
			Max = state.mMaxSetUpgrades
		}
		local __wf_atom_70b880cb = state.mModSet:__wf_atom_70b880cb(v14)

		if __wf_atom_70b880cb.affixes ~= nil then
			for i = 1, #__wf_atom_70b880cb.affixes do
				if i ~= 1 and __wf_atom_70b880cb.affixes[i] ~= "" then
					state.mSetDesc ..= "\r\n"
				end

				state.mSetDesc ..= __wf_atom_70b880cb.affixes[i]
			end
		end

		local mArtifactUpgrade = state.mArtifactUpgrade
		local __wf_atom_70b880cb2 = mArtifactUpgrade:__wf_atom_70b880cb(state.mUpgrade.mUpgradeFingerprint)

		if state.mNumModSetEquipped ~= nil then
			local __wf_atom_c5801833 = mArtifactUpgrade:__wf_atom_c5801833()
			local v15 = not (#__wf_atom_c5801833 > 0 and state.mNumModSetEquipped > 1) and 0
				or __wf_atom_c5801833[math.min(state.mNumModSetEquipped - 1, #__wf_atom_c5801833)]
			state.mDesc = ""
			state.mDesc = fn6(mMovie, __wf_atom_70b880cb2, state.mDesc, false, state.mUpgradeType, v15)
			state.mDesc = mMovie:__wf_atom_b4b867f2(state.mDesc)
		end

		state.mSetDesc = mMovie:__wf_atom_b4b867f2(state.mSetDesc)
	end
end

function UpdateCrewShipCard(state, p, mMovie)
	if __wf_atom_7e8ad928(mMovie) then
		mMovie = fn2().mMovie
	end

	state.mDesc = fn6(mMovie, p, state.mDesc, true, state.mUpgradeType, nil)
end

function UpdateSetCard(p)
	return fn22(fn2(), p)
end

local function fn23(p, p2)
	if fn8(p, true) then
		return 4
	end

	if fn9(p) then
		return 5
	end

	if fn10(p) then
		return 6
	end

	if fn13(p) then
		return 7
	end

	if fn14(p) then
		return 8
	end

	if fn16(p) then
		return 9
	end

	return IsCardGrimoire(p) and 10 or p2
end

local function fn24(p, mUpgrade, mId, object)
	__wf_atom_83c14687(0)
	local mMovie = p.mMovie
	local result = {
		mSeed = math.random(),
		mBasePitch = 0,
		mPitch = __wf_atom_10cd16b2(0, 0.05),
		mHeading = __wf_atom_10cd16b2(0, 0.15)
	}
	local mInstance = mUpgrade.mInstance

	if __wf_atom_7e8ad928(mInstance) then
		if __wf_atom_7e8ad928(mUpgrade.mItemType) then
			print("Could not make upgrade instance for artifact without type")
		else
			print("Could not make upgrade instance for " .. mUpgrade.mItemType:__wf_atom_5b41f63b())
		end

		if getmetatable(mUpgrade) ~= getmetatable(SF.UpgradeInfo()) then
			LogBug("CardFromArtifact expects UpgradeInfo but was passed " .. __wf_atom_37b37cce(mUpgrade))
		end

		return result
	else
		local mUpgradeFingerprint = mUpgrade.mUpgradeFingerprint
		local v12

		if __wf_atom_7e8ad928(object) then
			v12 = mInstance:__wf_atom_6ac4d478(mUpgradeFingerprint)
		else
			v12 = mInstance:__wf_atom_6ac4d478(mUpgradeFingerprint, object:__wf_atom_1bb5b1ff())
		end

		local mUpgradeType, mUpgradeValue, mUpgradeObject

		if #v12 > 0 then
			mUpgradeType = v12[1]:__wf_atom_b810064e()
			mUpgradeValue = v12[1]:__wf_atom_505b3c0e()
			mUpgradeObject = v12[1]:__wf_atom_7da6362c()
		else
			mUpgradeType = 0
			mUpgradeValue = 0
		end

		local v13

		if __wf_atom_7e8ad928(object) then
			v13 = mInstance:__wf_atom_70b880cb(mUpgradeFingerprint)
		else
			v13 = mInstance:__wf_atom_d212c718(mUpgradeFingerprint, object)
		end

		result.mName = mMovie:__wf_atom_8e9ac384(v13.localizedTitle, true)
		result.mLevelReq = mInstance:__wf_atom_57b8ef0f(mUpgradeFingerprint)
		result.mUpgrade = mUpgrade
		result.mArtifactUpgrade = mInstance
		result.mIconOverlay = mInstance:__wf_atom_604f3d52()

		if mInstance:IsA(cosmeticEnhancer) then
			result.mDesc = mInstance:__wf_atom_f324d993(mUpgradeFingerprint)
		elseif mInstance:IsA(omegaModType) then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
			local v14 = 1

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

				if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
					v14 = __wf_atom_9be88b01:__wf_atom_a04e4a53()
				end
			end

			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
				module.Ternary(
					result.mLevelReq <= v14,
					"/Lotus/Language/Omega/OmegaMasteryRequirementShort",
					"/Lotus/Language/Omega/OmegaMasteryRequirementLockedShort"
				),
				true,
				{ LEVEL = result.mLevelReq }
			)

			if
				mUpgradeFingerprint == ""
				or mUpgradeFingerprint == "{}"
				or mUpgradeFingerprint == "{\"lvl\":0}"
				or mUpgradeFingerprint == "{\"lvl\":8}"
				or mUpgradeFingerprint == "{\"IsSentinel\":true}"
			then
				result.mIdentified = false
				result.mType = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Omega/OmegaUnidentified", false)
				result.mDesc = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/OmegaModGenericDesc", false)
			elseif mInstance:__wf_atom_ffb2b866(mUpgradeFingerprint) then
				result.mType = __wf_atom_8e9ac384
				result.mDesc = v13.localizedDescription
				result.mIdentified = true
				result.mIcons = mInstance:__wf_atom_6f91ea2f(mUpgradeFingerprint)
				result.mBlend = __wf_atom_10cd16b2(0.5, 0.7)
				result.mNextChange = 0
				result.mRecordChangeTime = 0
				result.mBlendMaskOffset = 0

				if result.mIcons ~= nil and #result.mIcons > 0 then
					result.mIconIndexA = math.random(1, #result.mIcons)

					if #result.mIcons > 1 then
						result.mIconIndexB = math.random(1, #result.mIcons)

						while result.mIconIndexB == result.mIconIndexA do
							result.mIconIndexB = math.random(1, #result.mIcons)
						end
					end

					result.mIcon = result.mIcons[result.mIconIndexA]
				end
			else
				result.mIdentified = false
				result.mType = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Omega/OmegaUnidentified", false)
				result.mDesc = __wf_atom_0a63ecce(mMovie:__wf_atom_b4b867f2(mInstance:__wf_atom_d3115755(mUpgradeFingerprint))) .. "\r\n" .. mInstance:__wf_atom_1dce7a3d(mUpgradeFingerprint) .. "/" .. mInstance:__wf_atom_ab325d85(mUpgradeFingerprint)
			end
		elseif mInstance:IsA(omegaRawModType) then
			result.mIdentified = false
			result.mType = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Omega/OmegaRaw", false)
			result.mDesc = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Omega/OmegaRawDesc", false)
		else
			result.mDesc = v13.localizedDescription
			local __wf_atom_f6844bcd = mInstance:__wf_atom_f6844bcd()

			if not __wf_atom_7e8ad928(__wf_atom_f6844bcd) then
				result.mModSet = __wf_atom_f6844bcd
				result.mMaxSetUpgrades = __wf_atom_f6844bcd:__wf_atom_c9814239()
				fn22(p, result)
			end
		end

		if result.mType == nil then
			result.mType = "???"
		end

		local __wf_atom_7ec2d06a = mInstance:__wf_atom_7ec2d06a(mUpgradeFingerprint)
		result.mItemCompatibilityValue = CategoryId_UNFUSED

		if not __wf_atom_7e8ad928(__wf_atom_7ec2d06a) then
			if result.mType == "???" and not (mInstance:IsA(omegaModType) or mInstance:IsA(omegaRawModType)) then
				result.mType = mMovie:__wf_atom_8e9ac384(mInstance:__wf_atom_e36eb44b(mUpgradeFingerprint), true)

				if not __wf_atom_7e8ad928(result.mModSet) then
					result.mType = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/Upgrades/SetBonusDesc",
						true,
						result.ModSetDescription
					) .. ": " .. result.mType
				end
			end

			result.mItemCompatibility = __wf_atom_7ec2d06a

			if result.mItemCompatibility:IsA(warframeForFiltering) then
				result.mItemCompatibilityValue = CategoryId_WARFRAME
			elseif result.mItemCompatibility:IsA(rifleForFiltering) then
				result.mItemCompatibilityValue = CategoryId_RIFLE
			elseif result.mItemCompatibility:IsA(__wf_atom_2c8a4b8d) then
				result.mItemCompatibilityValue = CategoryId_HAND_GUN
			elseif result.mItemCompatibility:IsA(__wf_atom_77e05d3b) then
				if result.mIsStance then
					result.mItemCompatibilityValue = CategoryId_STANCE
				else
					result.mItemCompatibilityValue = CategoryId_MELEE
				end
			elseif result.mItemCompatibility:IsA(companionForFiltering) then
				result.mItemCompatibilityValue = CategoryId_COMPANIONS
			elseif result.mItemCompatibility:IsA(roboticForFiltering) then
				result.mItemCompatibilityValue = CategoryId_ROBOTIC
			end
		end

		result.mType = string.upper(result.mType)
		result.mUpgradeType = mUpgradeType
		result.mUpgradeValue = mUpgradeValue
		result.mUpgradeObject = mUpgradeObject
		result.mRarity = fn23(result, mInstance:__wf_atom_a8dac107())
		local v14 = fn14(result)
		local v15 = IsCardGrimoire(result)

		if v14 or v15 then
			result.mGlowStrength = 0.5
			result.mGlowDir = 1
		end

		result.mSyndicate = mInstance:__wf_atom_09f877c1()

		if string.len(result.mName) == 0 then
			result.mName = mMovie:__wf_atom_8e9ac384(tostring(mInstance:__wf_atom_014a76a2()), false)
		end

		result.mPvpIcon = ""

		if mInstance:__wf_atom_50182074() and mInstance:__wf_atom_c05c3cf5(mUpgradeFingerprint) ~= 6 then
			if mInstance:__wf_atom_1447fa74() then
				result.mPvpIcon = mMovie:__wf_atom_8e9ac384("<UNIVERSAL>", true)
			else
				result.mPvpIcon = mMovie:__wf_atom_8e9ac384("<CONCLAVE>", true)
			end
		end

		if string.len(result.mDesc) == 0 and not mInstance:IsA(cosmeticEnhancer) then
			local v16 = mInstance:IsA(focusUpgrade) and v13.affixes ~= nil

			if mUpgradeType ~= 2 and not v16 then
				result.mDesc = mMovie:__wf_atom_8e9ac384(tostring(mInstance:__wf_atom_3a3d2e39()), false)
			end

			if result.mNumModSetEquipped == nil then
				result.mDesc = fn6(mMovie, v13, result.mDesc, v16, mUpgradeType, nil)
			else
				local __wf_atom_c5801833 = mInstance:__wf_atom_c5801833()
				local v17 = not (#__wf_atom_c5801833 > 0 and result.mNumModSetEquipped > 1) and 0
					or __wf_atom_c5801833[math.min(result.mNumModSetEquipped - 1, #__wf_atom_c5801833)]
				result.mDesc = fn6(mMovie, v13, result.mDesc, v16, mUpgradeType, v17)
			end

			result.mDesc = mMovie:__wf_atom_b4b867f2(result.mDesc)

			if v16 then
				result.mNextLvlDesc = fn6(
					mMovie,
					mInstance:__wf_atom_95bdb725(mUpgradeFingerprint),
					"",
					true,
					mUpgradeType,
					nil
				)
				result.mNextLvlDesc = mMovie:__wf_atom_b4b867f2(result.mNextLvlDesc)
			end
		end

		result.mId = mId
		result.mLevel = mInstance:__wf_atom_c6a5f697(mUpgradeFingerprint)
		result.mLevelLimit = mInstance:__wf_atom_49f7d220(mUpgradeFingerprint)
		result.mLevelForSort = result.mLevel

		if result.mLevel == result.mLevelLimit then
			result.mLevelForSort += 0.01
		end

		if __wf_atom_7e8ad928(result.mIcon) then
			result.mIcon = v13.icon
		end

		if __wf_atom_7e8ad928(result.mIcon) then
			result.mIcon = mInstance:__wf_atom_17642f7d()
		end

		if v14 or v15 then
			if result.mLevel == result.mLevelLimit and not v15 then
				result.mIcon = immortalBrokenIcon
				result.mGlowIcon = immortalBrokenIcon
				result.mName = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Mods/ImmortalBrokenModName", true, {
					IMMORTAL_NAME = result.mName
				})
				result.mDesc = ""
			else
				result.mGlowIcon = fn4(mUpgrade.mItemType, v15 and v6 or v5)
			end
		end

		local __wf_atom_49f7d220 = mInstance:__wf_atom_49f7d220("")

		if __wf_atom_49f7d220 < result.mLevelLimit then
			result.mLevel = math.floor(result.mLevel / result.mLevelLimit * __wf_atom_49f7d220)
			result.mLevelLimit = __wf_atom_49f7d220
		end

		result.mDrain = mInstance:__wf_atom_c85c35bf(mUpgradeFingerprint)
		result.mPolarity = mInstance:__wf_atom_c05c3cf5(mUpgradeFingerprint)
		result.mInstalled = {}
		result.mIsHidden = false

		if mInstance:__wf_atom_23583b7f() then
			result.mIsHidden = true
		end

		if mInstance:__wf_atom_a81b8586() then
			result.mDesc = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Labels/DAMAGEDUpper", false) .. "\r" .. result.mDesc
			result.mDamaged = true
		end

		if result.mPolarity == 6 or mInstance:__wf_atom_4290ab7f() then
			result.mType = "MOD"
		elseif mInstance:IsA(__wf_atom_6dcad331) or mInstance:IsA(railjackAuraType) then
			result.mType = "AURA"
		elseif mInstance:IsA(__wf_atom_39cfd03e) then
			result.mIsStance = true
			result.mDesc = TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/Stance", false)) .. ": " .. result.mDesc
		elseif mInstance:IsA(WeakResource("/Lotus/Upgrades/Mods/Melee/Channel/BaseChannelMod")) then
			result.mType = "CHANNELING"
		end

		result.mIsUtility = mInstance:__wf_atom_bad844cd()
		result.mRating = fn19(result)
		result.mUpgradeItemType = mUpgrade.mItemType
		result.mIsNew = false

		if not __wf_atom_7e8ad928(gGameData) then
			local __wf_atom_1f1e74ba = gGameData:__wf_atom_1f1e74ba()

			for i = 1, #__wf_atom_1f1e74ba do
				if mUpgrade.mItemType ~= __wf_atom_1f1e74ba[i].mItemType then
					continue
				end

				result.mIsNew = true
				break
			end
		end

		result.mNameSearchable = __wf_atom_d99ae0ec(result.mName)
		return result
	end
end

function CardFromArtifact(mUpgrade, mId, p)
	return fn24(fn2(), mUpgrade, mId, p)
end

function GetStatsFromUpgrade(p)
	local result = {}
	local __wf_atom_70b880cb = p.mArtifactUpgrade:__wf_atom_70b880cb(p.mUpgrade.mUpgradeFingerprint)

	if __wf_atom_70b880cb.affixes ~= nil then
		for i = 1, #__wf_atom_70b880cb.affixes do
			table.insert(result, __wf_atom_70b880cb.affixes[i])
		end
	end

	return result
end

function GetStatPairsFromUpgrade(object, data)
	local result = {}
	local mArtifactUpgrade = data.mArtifactUpgrade
	local mUpgradeFingerprint = data.mUpgrade.mUpgradeFingerprint
	local __wf_atom_70b880cb = mArtifactUpgrade:__wf_atom_70b880cb(mUpgradeFingerprint)

	if __wf_atom_70b880cb.affixPairs == nil then
		for _, v12 in ipairs(v11) do
			if not mArtifactUpgrade:IsA(v12.UpgradeType) then
				continue
			end

			local mUpgradeValue = data.mUpgradeValue

			if v12.IsPercent then
				mUpgradeValue = math.floor(mUpgradeValue * 1000 + 0.5) / 10
			end

			table.insert(result, {
				localizedName = data.mDesc,
				statValue = mUpgradeValue,
				displayAsPercent = v12.IsPercent,
				reverseValueSymbol = nil,
				displayAbsValue = true
			})
			break
		end
	else
		for i = 1, #__wf_atom_70b880cb.affixPairs do
			print(__wf_atom_70b880cb.affixPairs[i].localizedName)
			table.insert(result, __wf_atom_70b880cb.affixPairs[i])
		end
	end

	if object ~= nil then
		table.insert(result, {
			localizedName = object:__wf_atom_8e9ac384("/Lotus/Language/Labels/Drain_Capacity", false),
			statValue = -mArtifactUpgrade:__wf_atom_c85c35bf(mUpgradeFingerprint),
			displayAsPercent = false,
			reverseValueSymbol = nil,
			displayAbsValue = true
		})
	end

	return result
end

local function fn25(p)
	local v12 = fn2()
	local v13 = p.mClipName .. ".SocketPolarity"
	local v14

	if p.mPolarity == nil then
		v14 = false
	else
		v14 = p.mPolarity ~= 0
	end

	v12.mMovie:__wf_atom_2dedec1a(v13, 13, v14)
	v12.mMovie:__wf_atom_7f57ab2f(p.mClipName, "SocketPolarityBacker", 13, v14)

	if v14 then
		v12.mMovie:__wf_atom_50d60589(v13, 36, module2.GetTagForPolarity(p.mPolarity))
		v12.mMovie:__wf_atom_2dedec1a(v13, 89, true)
		v12.mMovie:__wf_atom_e57658c2(v13, 12, 45)
	end
end

local function fn26(data, p)
	local v12 = fn2()
	local selected = data.Selected
	v12.mMovie:__wf_atom_7f57ab2f(p, "UsageCounter", 13, selected == true)

	if selected then
		local mSelectionText = module.Ternary(data.NumSelected ~= nil, data.NumSelected, 1)

		if data.mSelectionText ~= nil and (data.NumSelected == nil or data.NumSelected > 1) then
			mSelectionText = data.mSelectionText
		end

		v12.mMovie:__wf_atom_48bd5a59(p, "UsageCounter.Count", 46, "center")
		v12.mMovie:__wf_atom_50d60589(p .. ".UsageCounter.Count", 36, mSelectionText)
		v12.mMovie:__wf_atom_7f57ab2f(p, "UsageCounter.Count", 89, true)
		v12.mMovie:__wf_atom_4c1c1986(p, "UsageCounter", 4, -350)
	end
end

local function fn27(state, p)
	local v12 = fn2()
	state.DrawingEmpty = true
	v12.mMovie:OverrideMaterial(
		state.mClipName .. ".Socket.Highlight",
		_G.UIMaterial_Mods[module.Ternary(p ~= nil, p, 2)].Content
	)
	v12.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Card", 13, false)
	v12.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Socket", 13, true)

	if state.mSlotType == nil then
		__wf_atom_86cbd68d(v12.mMovie, state.mClipName .. ".Socket.gotoAndStop", 1)
	else
		__wf_atom_86cbd68d(v12.mMovie, state.mClipName .. ".Socket.gotoAndStop", state.mSlotType)
	end

	v12.mMovie:__wf_atom_7f57ab2f(state.mClipName, "SocketType", 13, false)
	v12.mMovie:__wf_atom_7f57ab2f(state.mClipName, "SocketTypeBacker", 13, false)
	v12.mMovie:__wf_atom_4c1c1986(state.mClipName, "SocketType", 12, 45)
	v12.mMovie:OverrideMaterial(
		state.mClipName .. ".Socket",
		_G.UIMaterial_Mods[module.Ternary(p ~= nil, p, 1)].EmptySlot
	)
	v12.mMovie:OverrideMaterial(
		state.mClipName .. ".SocketPolarityBacker",
		_G.UIMaterial_Mods[module.Ternary(p ~= nil, p, 1)].Content
	)
	v12.mMovie:OverrideMaterial(
		state.mClipName .. ".SocketPolarityBacker.Backer",
		_G.UIMaterial_Mods[module.Ternary(p ~= nil, p, 1)].Content
	)
	v12.mMovie:__wf_atom_4c1c1986(state.mClipName, "Btn", 15, 120)
	fn26(state, state.mClipName .. ".Socket")
	v12.mMovie:__wf_atom_7f57ab2f(state.mClipName, "Shadow", 13, false)
	fn25(state)
end

function DrawEmptyCard(p, p2)
	fn27(p, p2)
end

local function fn28(p, data, p2)
	local mDrain = data.mDrain

	if p2 ~= nil then
		mDrain = p2
	end

	local mPolarity = p.mPolarity

	if mPolarity == nil then
		return mDrain
	end

	return data.mArtifactUpgrade:__wf_atom_d41d9dcf(mDrain, mPolarity, data.mUpgrade.mUpgradeFingerprint)
end

function ComputeDrain(p, p2, p3)
	return fn28(p, p2, p3)
end

local function fn29(p, p2, p3, _, p4, value, p5)
	local mMovie = fn2().mMovie

	if p2 == 0 then
		mMovie:__wf_atom_7f57ab2f(p, "BottomFrame.Level1", 13, false)
		mMovie:__wf_atom_7f57ab2f(p, "BottomFrame.ConnectorLine", 13, true)
		p2 = 1
	else
		if p4 then
			p3 = p2 - p3
		end

		for i = 1, p2 do
			local v12 = p .. ".BottomFrame.Level" .. i

			if not mMovie:__wf_atom_253d7085(v12) then
				__wf_atom_86cbd68d(mMovie, p .. ".BottomFrame.Level1.duplicateMovieClip", "Level" .. i, i + 100)
			end

			mMovie:__wf_atom_2dedec1a(v12, 13, not (p4 or p5))

			if p4 then
				mMovie:__wf_atom_2dedec1a(p .. ".ImmortalRank.Level" .. i, 13, i <= p3)
			elseif p5 then
				mMovie:__wf_atom_2dedec1a(p .. ".BottomFrame.GrimoireLevel" .. i, 13, i <= p3)
			else
				if i <= p3 then
					__wf_atom_86cbd68d(mMovie, v12 .. ".gotoAndStop", value or "On")
				else
					__wf_atom_86cbd68d(mMovie, v12 .. ".gotoAndStop", "Off")
				end

				mMovie:__wf_atom_e57658c2(v12, 0, (-p2 * 0.5 + i - 0.5) * 13)
			end
		end

		if p3 == p2 and p3 > 1 then
			mMovie:__wf_atom_7f57ab2f(p, "BottomFrame.ConnectorLine", 13, true)
		else
			mMovie:__wf_atom_7f57ab2f(p, "BottomFrame.ConnectorLine", 13, false)
		end
	end

	for i = p2 + 1, 10 do
		local v12 = p .. ".BottomFrame.Level" .. i
		__wf_atom_86cbd68d(mMovie, v12 .. ".removeMovieClip")
	end
end

function DrawLevelDrain(p, p2, p3, p4, p5, p6, p7)
	fn29(p, p2, p3, p4, p5, p6, p7)
end

local function fn30(p)
	if p.mType == "MOD" then
		return Localize("/Lotus/Language/Labels/Module", nil)
	end

	if p.mType == "AURA" then
		if fn11(p) then
			return Localize("/Lotus/Language/Railjack/CategoryRJAura", nil)
		end

		return Localize("/Lotus/Language/Menu/CategoryAura", nil)
	elseif p.mType == "CHANNELING" then
		return Localize("/Lotus/Language/Focus/Channeling_EnergyEfficiencyName", nil)
	else
		return p.mType
	end
end

fn = function(p)
	local v12 = "Common"
	local v13 = 14524549
	local v14 = 14524549
	local mRarity = p.mRarity

	if mRarity == 1 then
		v12 = "Uncommon"
		v13 = 15000804
		v14 = 16777215
	elseif mRarity == 2 then
		v12 = "Rare"
		v13 = 16640957
		v14 = 16766857
	elseif mRarity == 3 then
		v12 = "Legendary"
		v13 = 16777215
		v14 = 16777215
	elseif mRarity == 4 then
		v12 = "Omega"
		v13 = 11305941
		v14 = 11305941
	elseif mRarity == 5 then
		v12 = "Peculiar"
		v13 = 16777215
		v14 = 16777215
	elseif mRarity == 6 then
		v12 = "Amalgam"
		v13 = 16777215
		v14 = 16777215
	elseif mRarity == 7 then
		v12 = "Galvanized"
		v13 = 16777215
		v14 = 16777215
	elseif mRarity == 8 then
		v12 = "Immortal"
		v13 = 15523508
		v14 = 16777215
	elseif mRarity == 9 then
		v12 = "Kahl"
		v13 = 12495206
		v14 = 12495206
	elseif mRarity == 10 then
		v12 = "Grimoire"
		v13 = 15323019
		v14 = 16766857
	end

	if fn11(p) then
		v12 = "Avionics" .. v12
	end

	return v13, v12, v14
end

function GetRarityColor(p)
	return fn(p)
end

local function fn31(p, p2)
	local HEX2RGB = module.HEX2RGB(p)
	HEX2RGB.red = HEX2RGB.r
	HEX2RGB.green = HEX2RGB.g
	HEX2RGB.blue = HEX2RGB.b
	local rgbToHSV, v12, _ = module3.RGBToHSV(HEX2RGB)
	local hsvToRGB = module3.HSVToRGB(rgbToHSV, v12, p2)
	return (tonumber("0x" .. module.ConvertRGB2HEX(hsvToRGB.red, hsvToRGB.green, hsvToRGB.blue)))
end

local function fn32(object, p, value)
	local __wf_atom_a649b1ed = p.mArtifactUpgrade:__wf_atom_a649b1ed()

	for i = 1, #__wf_atom_a649b1ed do
		local __wf_atom_011a196c = _G.UITypes_ModTips:__wf_atom_011a196c(__wf_atom_a649b1ed[i])

		if __wf_atom_011a196c.tag == EMPTY_SYMBOL then
			continue
		end

		local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(__wf_atom_011a196c.name:c_str(), true)
		value = value:gsub(__wf_atom_8e9ac384, "<b>" .. __wf_atom_8e9ac384 .. "</b>")
	end

	if string.find(value, "<font>") == nil then
		value = "<p><font >" .. value .. "</font></p>"
	end

	return value
end

local function fn33(mMovie, p, p2, p3)
	if fn17(mMovie, p) then
		p3 = fn32(mMovie, p, p3)
	end

	mMovie:__wf_atom_50d60589(p2, 36, p3)
end

function DrawCard(mElement, _, p, p2, p3, p4)
	if mElement.mClipName == nil then
		return
	end

	local v12 = fn2()
	local mMovie = v12.mMovie
	local v13 = fn5(mElement, nil)
	local v14 = p or v13

	if (not mElement.mCardIndex or mElement.mCardIndex <= -1) and not mElement.Card then
		fn27(mElement, p3)
		return
	end

	mElement.DrawingEmpty = false
	v14.mElement = mElement
	local v15 = false

	for _, _ in pairs(v14.mInstalled) do
		v15 = true
		break
	end

	local v16 = mElement.mClipName .. ".Card"

	if not mMovie:__wf_atom_253d7085(v16) then
		print("CardUtil: Tried drawing nonexistent clip for \"" .. v14.mName .. "\"")
		return
	end

	local v17 = fn8(v14)
	local v18 = fn14(v14)
	local v19 = fn11(v14)
	local v20 = fn16(v14)
	local v21 = IsCardGrimoire(v14)
	mMovie:__wf_atom_2dedec1a(v16, 13, true)
	mMovie:__wf_atom_e57658c2(v16, 18, 0)
	mMovie:__wf_atom_e57658c2(v16, 17, 0)
	mMovie:__wf_atom_7f57ab2f(v16, "ImmortalDepth", 13, false)
	local v22, v23, v24 = fn(v14)
	__wf_atom_86cbd68d(mMovie, v16 .. ".Background.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".Lights.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".BottomFrame.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".TopFrame.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".BottomFrame.Equipped.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".Details.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".TopInfo.gotoAndStop", 1)
	__wf_atom_86cbd68d(mMovie, v16 .. ".Background.gotoAndStop", module.Ternary(fn11(v14), "Avionics", v23))
	__wf_atom_86cbd68d(mMovie, v16 .. ".Lights.gotoAndStop", v23)
	__wf_atom_86cbd68d(mMovie, v16 .. ".BottomFrame.gotoAndStop", v23)
	__wf_atom_86cbd68d(mMovie, v16 .. ".TopFrame.gotoAndStop", v23)
	__wf_atom_86cbd68d(mMovie, v16 .. ".BottomFrame.Equipped.gotoAndStop", v23)
	__wf_atom_86cbd68d(mMovie, v16 .. ".Details.gotoAndStop", v23)
	__wf_atom_86cbd68d(mMovie, v16 .. ".TopInfo.gotoAndStop", module.Ternary(v18, "Immortal", "Normal"))
	__wf_atom_86cbd68d(mMovie, v16 .. ".TopCenterIcon.gotoAndStop", module.Ternary(v18, "Immortal", "Normal"))
	mMovie:__wf_atom_7f57ab2f(v16, "ImmortalFx", 13, v18)
	mMovie:__wf_atom_7f57ab2f(v16, "GrimoireFx", 13, v21)

	if v23 == "Omega" then
		__wf_atom_86cbd68d(mMovie, v16 .. ".TopFrame.Shards.gotoAndStop", 1)
		__wf_atom_86cbd68d(mMovie, v16 .. ".BottomFrame.Shards.gotoAndStop", 1)
	end

	local mItemCount = v14.mUpgrade.mItemCount

	if v14.ForceCount == nil then
		if p4 == nil or mElement.Count == nil then
			if v12.GetSelectedElement ~= nil and v12.IsFusionMode ~= nil then
				local selectedElement = v12.GetSelectedElement()

				if v12.IsFusionMode() then
					if mElement.mClipName == "FusionTarget.DetailCard" then
						mItemCount = 1
					elseif
						selectedElement.Card ~= nil
						and v14.mName == selectedElement.Card.mName
						and v14.mLevel == selectedElement.Card.mLevel
						and v14.mUpgradeType == selectedElement.Card.mUpgradeType
						and (v14.mId == selectedElement.Card.mId or mItemCount > 1)
					then
						local v25 = false

						for _, _ in pairs(selectedElement.Card.mInstalled) do
							v25 = true
							break
						end

						if v15 == v25 then
							mItemCount = math.max(0, mItemCount - 1)

							if mItemCount == 0 then
								fn27(mElement, p3)
								return
							end
						end
					end
				end
			end
		else
			mItemCount = mElement.Count
		end
	else
		mItemCount = v14.ForceCount
	end

	local canPreview = mItemCount == 0
	mElement.CanPreview = canPreview

	if
		canPreview
		or mItemCount > 1 and v14.mUpgrade.mItemId:__wf_atom_b70c3343() and (p2 == true or p2 == nil and not v15)
	then
		if canPreview then
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.Count", 1, module.Ternary(v18, 15.5, -21.5))
			mMovie:__wf_atom_7d7314f1(v16 .. ".TopInfo.Count.text", "<p><font size=\"27\"><PREVIEW></font></p>")
		else
			if v18 then
				mMovie:__wf_atom_4c1c1986(v16, "TopInfo.Count", 1, 12.5)
			else
				mMovie:__wf_atom_4c1c1986(v16, "TopInfo.Count", 1, -23.5)
			end

			mMovie:__wf_atom_7d7314f1(v16 .. ".TopInfo.Count.text", "<MOD_DUPLICATES>" .. tostring(mItemCount))
		end

		mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.Count", 13, true)
		mMovie:__wf_atom_4c1c1986(v16, "TopInfo.Count", 4, -50)
		mMovie:__wf_atom_4c1c1986(v16, "TopInfo.Count", 44, v22)
		mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.CountBacker", 13, true)
		mMovie:__wf_atom_4c1c1986(v16, "TopInfo.CountBacker", 11, module.Ternary(v18, 16777215, v22))
		local v25 = mMovie:__wf_atom_5e6e15c8(v16 .. ".TopInfo.Count", 40) + module.Ternary(v18 and canPreview, -5, 4)
		mMovie:__wf_atom_4c1c1986(v16, "TopInfo.CountBacker", 0, -121 + v25)
		mMovie:__wf_atom_4c1c1986(v16, "TopInfo.CountBacker.Backer", 14, v25 + module.Ternary(v18, 6, 0))
	else
		mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.Count", 13, false)
		mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.CountBacker", 13, false)
	end

	fn26(mElement, v16)
	mMovie:__wf_atom_50d60589(v16 .. ".Name", 36, v14.mPvpIcon .. v14.mName)
	mMovie:__wf_atom_4c1c1986(v16, "Name", 44, v22)
	mMovie:__wf_atom_7f57ab2f(v16, "Name", 89, true)
	mMovie:__wf_atom_4c1c1986(v16, "Name", 4, -200)
	mMovie:__wf_atom_4c1c1986(v16, "Description", 4, -150)
	mMovie:__wf_atom_4c1c1986(v16, "Icon", 4, module.Ternary(v21, -350, 0))
	v14.NameHeight = mMovie:__wf_atom_5e6e15c8(v16 .. ".Name", 41)

	if v14.NameHeight == nil then
		v14.NameHeight = 26
	end

	local rerolls = not (v17 and v14.mIdentified) and 0
		or v14.mArtifactUpgrade:__wf_atom_039b779b(v14.mUpgrade.mUpgradeFingerprint)
	mMovie:__wf_atom_7f57ab2f(v16, "Details.Rerolls", 13, rerolls > 0)
	mMovie:__wf_atom_7d7314f1(v16 .. ".Details.Rerolls.text", "/Lotus/Language/Omega/OmegaNumRerolls", {
		REROLLS = rerolls
	})
	mMovie:__wf_atom_7f57ab2f(v16, "Details.Rerolls", 89, true)
	local v25 = fn30(v14)
	mMovie:__wf_atom_4c1c1986(v16, "Details", 11, module.Ternary(v18, 8816262, v22))
	mMovie:__wf_atom_4c1c1986(v16, "Details", 4, -50)
	mMovie:__wf_atom_7f57ab2f(v16, "Details.Type", 54, true)
	mMovie:__wf_atom_48bd5a59(v16, "Details.Type", 46, "center")
	mMovie:__wf_atom_50d60589(v16 .. ".Details.Type", 36, string.upper(v25))
	mMovie:__wf_atom_48bd5a59(v16, "Details.Type", 45, module.Ternary(rerolls == 0, "center", "left"))
	mMovie:__wf_atom_7f57ab2f(v16, "Details.Type", 89, true)

	if v14.mSetDesc then
		fn33(mMovie, v14, v16 .. ".Description", v14.mDesc .. "\r\n" .. v14.mSetDesc)
	elseif v18 then
		local v26 = "<p><font face=\"Roboto Condensed\" size=\"19\">" .. string.gsub(
			v14.mDesc,
			"\r\n\r\n",
			"<br><br></font><font face=\"Roboto Condensed\" size=\"19\">"
		) .. "</font></p>"
		fn33(mMovie, v14, v16 .. ".Description", v26)
	else
		fn33(mMovie, v14, v16 .. ".Description", v14.mDesc)
	end

	mMovie:__wf_atom_4c1c1986(v16, "Description", 44, v22)
	mMovie:__wf_atom_7f57ab2f(v16, "Description", 89, true)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v16 .. ".Description", 41)
	v14.IconHeight = math.min(MAX_BACKGROUND_HEIGHT - v14.NameHeight - __wf_atom_5e6e15c8 - 65, 256)
	v14.IconMid = __wf_atom_104bfe98(0.25, 0.5, v14.IconHeight / 256)

	if v18 then
		v14.IconY = (-MAX_BACKGROUND_HEIGHT + v14.IconHeight + 10) / 2 - 20
		v14.ZoomedNameY = math.min(-32, v14.IconY + v14.IconHeight / 2 + 8)
	else
		v14.IconY = (-MAX_BACKGROUND_HEIGHT + v14.IconHeight + 10) / 2
		v14.ZoomedNameY = v14.IconY + v14.IconHeight / 2 + 8
	end

	v14.IconY += (0.5 - v14.IconMid) * 256
	mMovie:__wf_atom_4c1c1986(v16, "Lights", 4, -50)
	mMovie:__wf_atom_4c1c1986(v16, "Details.TypeBacker", 4, 0)
	local v26 = fn28(mElement, v14)
	local uiColor_Green

	if v14.DrainColorForceToRarity then
		uiColor_Green = v22
	elseif v26 < v14.mDrain then
		uiColor_Green = _G.UIColor_Green
	elseif v14.mDrain < v26 then
		uiColor_Green = _G.UIColor_Red
	else
		uiColor_Green = v22
	end

	if not v18 then
		local v27 = ""

		if v26 < 0 then
			v27 = mMovie:__wf_atom_8e9ac384("<UPARROW>" .. math.abs(v26), true)
		elseif v26 > 0 then
			v27 = v26
		end

		local mPolarity = v14.mPolarity

		if mPolarity then
			if v14.mPolarity > 0 then
				mPolarity = v14.mPolarity <= #_G.UITexture_Polarity
			else
				mPolarity = false
			end
		end

		if v14.mIsSecret or fn8(v14, true) and not v14.mIdentified then
			v27 = "??? "
		elseif mPolarity then
			v27 ..= module2.GetTagForPolarity(v14.mPolarity)
		end

		if v27 == "" then
			mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.CostAndPolarity", 13, false)
			mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.PolarityBacker", 13, false)
		else
			mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.CostAndPolarity", 13, true)
			mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.PolarityBacker", 13, true)
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.CostAndPolarity", 11, uiColor_Green)
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.PolarityBacker", 11, v22)
			mMovie:__wf_atom_50d60589(v16 .. ".TopInfo.CostAndPolarity", 36, v27)
			local v28 = mMovie:__wf_atom_5e6e15c8(v16 .. ".TopInfo.CostAndPolarity", 40) + 4
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.PolarityBacker", 0, 121 - v28)
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.PolarityBacker.Backer", 14, v28)
			mMovie:__wf_atom_7f57ab2f(v16, "TopInfo.CostAndPolarity", 89, true)
			mMovie:__wf_atom_4c1c1986(v16, "TopInfo.CostAndPolarity", 4, -50)
		end
	end

	fn29(v16, v14.mLevelLimit, v14.mLevel, v26, v18, v20 and "Kahl" or v17 and "Riven" or "On", v21)

	if fn8(v14) and v14.mIdentified and #v14.mIcons > 1 then
		mMovie:OverrideMaterial(v16 .. ".Icon", _G.UIMaterial_Mods[2].OmegaIcon)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 5, 100)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 6, 100)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 16777215)
		local __wf_atom_611e7c82 = _G.UIMaterial_Mods[2].OmegaIcon:__wf_atom_611e7c82(Symbol("DetailMap"))
		mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("DetailMap"), __wf_atom_611e7c82)
		mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapTint", 1, 1, 1, 0)
	elseif v18 then
		if fn3(v14.mUpgradeItemType) and v14.mLevel ~= v14.mLevelLimit then
			mMovie:OverrideMaterial(v16 .. ".Icon", _G.UIMaterial_Mods[2].ImmortalWildcardIcon)
		else
			mMovie:OverrideMaterial(v16 .. ".Icon", _G.UIMaterial_Mods[2].ImmortalIcon)
		end

		mMovie:__wf_atom_4c1c1986(v16, "Icon", 5, 50)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 6, 50)

		if v14.mLevel == v14.mLevelLimit then
			mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 14540253)
			local __wf_atom_611e7c82 = _G.UIMaterial_Mods[2].Icon:__wf_atom_611e7c82(Symbol("DetailMap"))
			mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("DetailMap"), __wf_atom_611e7c82)
			mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapTint", 1, 1, 1, 0)
		else
			mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 16709593)
			mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("DetailMap"), v14.mGlowIcon)
			mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapTint", 0.6353, 0, 0.1804, 1)
		end
	elseif v21 then
		mMovie:OverrideMaterial(v16 .. ".Icon", _G.UIMaterial_Mods[2].ImmortalIcon)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 5, 50)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 6, 50)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 12840184)
		mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("DetailMap"), v14.mGlowIcon)
		mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapTint", 0, 0.45, 0.65, 1)
	else
		mMovie:OverrideMaterial(v16 .. ".Icon", _G.UIMaterial_Mods[2].Icon)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 5, 100)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 6, 100)
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 16777215)
		local c_str = v14.mSyndicate:c_str()
		local mIconOverlay = _G.UIMaterial_Mods[2].Icon:__wf_atom_611e7c82(Symbol("DetailMap"))

		if __wf_atom_7e8ad928(v14.mIconOverlay) then
			if c_str ~= "" then
				mIconOverlay = _G.UIMaterial_ModsSyndicateIcons[2][c_str]:__wf_atom_611e7c82(Symbol("DetailMap"))
			end
		else
			mIconOverlay = v14.mIconOverlay
		end

		mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("DetailMap"), mIconOverlay)
		mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapTint", 1, 1, 1, 0)
	end

	mMovie:__wf_atom_7f57ab2f(v16, "ImmortalRank", 13, v18)
	mMovie:__wf_atom_c90af43a(v16 .. ".Icon", v14.mIcon)

	if v14.mIconIndexB ~= nil then
		mMovie:__wf_atom_f321ac85(v16 .. ".Icon", Symbol("BlendImageMap"), v14.mIcons[v14.mIconIndexB])
	end

	mMovie:__wf_atom_7f57ab2f(v16, "Locked", 13, canPreview)

	if canPreview then
		mMovie:__wf_atom_7d7314f1(v16 .. ".Locked.Label.text", "/Lotus/Language/OstronCrafting/Crafting_Preview_NoIcon")
		mMovie:__wf_atom_4c1c1986(v16, "Icon", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "Background", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "Lights", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "TopFrame", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "BottomFrame", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "Name", 11, 6710886)
		mMovie:__wf_atom_4c1c1986(v16, "Description", 11, 6710886)
		v24 = fn31(v24, 0.4)
	else
		mMovie:__wf_atom_4c1c1986(v16, "Background", 11, 16777215)
		mMovie:__wf_atom_4c1c1986(v16, "Lights", 11, 16777215)
		mMovie:__wf_atom_4c1c1986(v16, "TopFrame", 11, 16777215)
		mMovie:__wf_atom_4c1c1986(v16, "BottomFrame", 11, 16777215)
		mMovie:__wf_atom_4c1c1986(v16, "Name", 11, 16777215)
		mMovie:__wf_atom_4c1c1986(v16, "Description", 11, 16777215)
	end

	if _T.CardIconDepth == nil then
		_T.CardIconDepth = tonumber(__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.getDepth"))
		_T.CardImmortalDepth = tonumber(__wf_atom_86cbd68d(mMovie, v16 .. ".ImmortalDepth.getDepth"))
	end

	if v18 then
		if v12.SwappedIconClips == nil then
			v12.SwappedIconClips = {}
		end

		if tonumber(__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.getDepth")) == _T.CardIconDepth then
			__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.swapDepths", _T.CardImmortalDepth)
			__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.setMask", v16 .. ".IconMask")
			__wf_atom_86cbd68d(mMovie, v16 .. ".ImmortalFx.setMask", v16 .. ".IconMask")
			__wf_atom_86cbd68d(mMovie, v16 .. ".GrimoireFx.setMask", v16 .. ".IconMask")
			v12.SwappedIconClips[v16] = true
		end
	elseif v12.SwappedIconClips ~= nil and v12.SwappedIconClips[v16] then
		__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.swapDepths", _T.CardIconDepth)
		__wf_atom_86cbd68d(mMovie, v16 .. ".Icon.setMask", v16 .. ".IconMask")
		v12.SwappedIconClips[v16] = nil
	end

	if v14.mSyndicate:c_str() == "" and __wf_atom_7e8ad928(v14.mIconOverlay) then
		if v14.mDamaged then
			mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapParams", 1, 0, 1, 1)
		elseif v21 or v18 and v14.mLevel < v14.mLevelLimit then
			mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapParams", 1, 1, 1, 1)
		else
			mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapParams", 0, 0, 1, 1)
		end
	else
		mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "DetailMapParams", 0, 1, 1, 1)
	end

	local v27 = false

	if __wf_atom_7e8ad928(v14.mModSet) then
		mMovie:__wf_atom_7f57ab2f(v16, "HeaderIcon", 13, false)
	else
		local __wf_atom_84f7e137 = v14.mModSet:__wf_atom_84f7e137()

		if not __wf_atom_7e8ad928(__wf_atom_84f7e137) then
			mMovie:__wf_atom_c90af43a(v16 .. ".HeaderIcon", __wf_atom_84f7e137)
			mMovie:__wf_atom_4c1c1986(v16, "HeaderIcon", 11, v24)
			mMovie:__wf_atom_7f57ab2f(v16, "HeaderIcon.Utility", 13, v14.mIsUtility)
		end

		v27 = not __wf_atom_7e8ad928(__wf_atom_84f7e137)
		mMovie:__wf_atom_7f57ab2f(v16, "HeaderIcon", 13, v27)
	end

	v14.mTopIconYOffset = 0
	local v28

	if v19 then
		v28 = fn12(v14)
		v14.mTopIconYOffset = 7
	end

	if v23 ~= "Immortal" then
		if v14.mIsStance or v14.mType == "AURA" or v28 ~= nil then
			if v28 == nil then
				v28 = module.Ternary(v14.mType == "AURA", _G.UICategoryIcon_AuraOn, _G.UICategoryIcon_StanceOn)
			end

			mMovie:__wf_atom_c90af43a(v16 .. ".TopCenterIcon.TopIcon", v28)
			mMovie:__wf_atom_4c1c1986(v16, "TopCenterIcon.TopIcon", 4, -50)
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIcon", 13, true)
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIconBacker", 13, true)
			mMovie:__wf_atom_4c1c1986(v16, "TopCenterIcon.TopIcon", 11, v22)
			mMovie:__wf_atom_4c1c1986(v16, "TopCenterIcon.TopIconBacker", 11, v22)
		elseif v14.mIsUtility and not v27 then
			mMovie:__wf_atom_c90af43a(v16 .. ".TopCenterIcon.TopIcon", _G.UICategoryIcon_UtilityOn)
			mMovie:__wf_atom_4c1c1986(v16, "TopCenterIcon.TopIcon", 4, -50)
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIcon", 13, true)
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIconBacker", 13, false)
			mMovie:__wf_atom_4c1c1986(v16, "TopCenterIcon.TopIcon", 11, v22)
		else
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(v16, "TopCenterIcon.TopIconBacker", 13, false)
		end
	end

	local v29 = v3[v14.mRarity + 1]
	mMovie:__wf_atom_1ca72041(v16 .. ".BottomFrame.Image", "CubeMapColor", v29[1] * 2, v29[2] * 2, v29[3] * 2, 0)
	local v30 = v2[v14.mRarity + 1]
	mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "TintColor", v30[1], v30[2], v30[3], 1)

	if fn9(v14) then
		mMovie:__wf_atom_4c1c1986(v16, "Background", 11, v22)
		mMovie:__wf_atom_4c1c1986(v16, "Lights", 11, v22)
		mMovie:__wf_atom_4c1c1986(v16, "BottomFrame.Image", 11, v22)
		mMovie:__wf_atom_4c1c1986(v16, "TopFrame", 11, v22)
	end

	mMovie:__wf_atom_7f57ab2f(mElement.mClipName, "SocketType", 13, false)
	mMovie:__wf_atom_7f57ab2f(mElement.mClipName, "SocketTypeBacker", 13, false)
	local mHasSlot = mElement.mHasSlot == true
	mMovie:__wf_atom_7f57ab2f(mElement.mClipName, "Socket", 13, mHasSlot)
	mMovie:__wf_atom_7f57ab2f(mElement.mClipName, "SocketPolarity", 13, mHasSlot)
	mMovie:__wf_atom_7f57ab2f(mElement.mClipName, "SocketPolarityBacker", 13, mHasSlot)

	if mElement.mHasSlot then
		if mElement.mSlotType == nil then
			__wf_atom_86cbd68d(mMovie, mElement.mClipName .. ".Socket.gotoAndStop", 1)
		else
			__wf_atom_86cbd68d(mMovie, mElement.mClipName .. ".Socket.gotoAndStop", mElement.mSlotType)
		end

		fn25(mElement)
	end

	local v31, v32

	if v14.mSeed < 0.5 then
		v31 = 1
		v32 = 0
	else
		v31 = 0
		v32 = 1
	end

	mMovie:__wf_atom_1ca72041(v16 .. ".Icon", "AutoOffsetParallax", v31, v32, v14.mSeed * 10, 0)
	mMovie:__wf_atom_7f57ab2f(v16, "BottomFrame.Equipped", 13, v15)
	mMovie:__wf_atom_7f57ab2f(v16, "BottomFrame.New", 13, v14.mIsNew and not v14.HideNew)

	if v14.mIsNew then
		mMovie:__wf_atom_7d7314f1(v16 .. ".BottomFrame.New.Label.text", "/Lotus/Language/Menu/Store_New")
		mMovie:__wf_atom_4c1c1986(
			v16,
			"BottomFrame.New.Bg",
			14,
			mMovie:__wf_atom_5e6e15c8(v16 .. ".BottomFrame.New.Label", 40) + 20
		)
		mMovie:__wf_atom_4c1c1986(v16, "BottomFrame.New.Bg", 11, 490863)
		mMovie:__wf_atom_4c1c1986(v16, "BottomFrame.New", 4, -100)
	end
end

function GetCollectionCategories(p, p2, p3, p4)
	local mMovie = fn2().mMovie
	local v12 = {}
	table.insert(v12, {
		Category = CategoryId_ALL,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAll", false),
		Icon = _G.UICategoryIcon_AllOn
	})

	if _T.upgradeItem then
		table.insert(v12, {
			Category = CategoryId_INSTALLED,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryEquipped", false),
			Icon = _G.UICategoryIcon_InstalledOn
		})
	end

	table.insert(v12, {
		Category = CategoryId_WARFRAME,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryWarframe", false),
		Icon = _G.UICategoryIcon_WarframeOn
	})
	table.insert(v12, {
		Category = CategoryId_AURA,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAura", false),
		Icon = _G.UICategoryIcon_AuraOn
	})
	table.insert(v12, {
		Category = CategoryId_AUGMENT,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryAugment", false),
		Icon = _G.UICategoryIcon_AugmentOn
	})
	table.insert(v12, {
		Category = CategoryId_RIFLE,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryTwoHandWeapon", false),
		Icon = _G.UICategoryIcon_RifleOn
	})
	table.insert(v12, {
		Category = CategoryId_HAND_GUN,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryOneHandWeapon", false),
		Icon = _G.UICategoryIcon_HandGunOn
	})
	table.insert(v12, {
		Category = CategoryId_MELEE,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryMeleeWeapon", false),
		Icon = _G.UICategoryIcon_MeleeOn
	})
	table.insert(v12, {
		Category = CategoryId_STANCE,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryMeleeStance", false),
		Icon = _G.UICategoryIcon_StanceOn
	})
	table.insert(v12, {
		Category = CategoryId_UTILITY,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategoryUtility", false),
		Icon = _G.UICategoryIcon_UtilityOn
	})
	table.insert(v12, {
		Category = CategoryId_ARCHWING,
		Name = string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Vehicles", false)),
		Icon = _G.UICategoryIcon_VehiclesOn
	})
	table.insert(v12, {
		Category = CategoryId_ARCHWINGPRIMARY,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/ArchwingGun", false),
		Icon = _G.UICategoryIcon_ArchwingPrimaryOn
	})
	table.insert(v12, {
		Category = CategoryId_ARCHWINGSECONDARY,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/ArchwingMelee", false),
		Icon = _G.UICategoryIcon_ArchwingSecondaryOn
	})
	table.insert(v12, {
		Category = CategoryId_ROBOTIC,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CategorySentinel", false),
		Icon = _G.UICategoryIcon_SentinelOn
	})
	table.insert(v12, {
		Category = CategoryId_COMPANIONS,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Loadout_Beast", false),
		Icon = _G.UICategoryIcon_CompanionsOn
	})
	table.insert(v12, {
		Category = CategoryId_RAILJACK,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/RailjackTitle", false),
		Icon = _G.UICategoryIcon_RailjackOn
	})

	if p then
		table.insert(v12, {
			Category = CategoryId_DUPLICATE,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/AutoFuseDuplicatesTitle", false),
			Icon = _G.UICategoryIcon_DuplicatesOn
		})
	end

	table.insert(v12, {
		Category = CategoryId_INCOMPLETE,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Quests_Incomplete", false),
		Icon = _G.UICategoryIcon_IncompleteOn
	})

	if p2 then
		table.insert(v12, {
			Category = CategoryId_OMEGA,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArtifactCards_CategoryOmega", false),
			Icon = _G.UICategoryIcon_OmegaOn
		})
	end

	if p3 then
		table.insert(v12, {
			Category = CategoryId_IMMORTAL,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Weapons/DataKnife", false),
			Icon = _G.UICategoryIcon_DataKnifeOn
		})
	end

	if p4 then
		table.insert(v12, {
			Category = CategoryId_TOME,
			Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Items/GrimoireCategoryName", false),
			Icon = _G.UICategoryIcon_TomeOn
		})
	end

	return v12
end

function GetCollectionSortBy(p)
	local v12 = fn2()
	local mMovie = v12.mMovie
	local v13 = {}
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortRecent", false),
		SortId = "RECENT",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if data.mLastAdded == nil and data2.mLastAdded == nil then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.mLastAdded > data2.mLastAdded
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortRarity", false),
		SortId = "RARITY",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.mRarity ~= data2.mRarity then
				return data.mRarity > data2.mRarity
			end

			if data.mName ~= data2.mName then
				return data.mName < data2.mName
			end

			if data.Categories[1] == data2.Categories[1] then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.Categories[1] < data2.Categories[1]
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortPrice", false),
		SortId = "PRICE",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.mPrice ~= data2.mPrice then
				return data.mPrice < data2.mPrice
			end

			if data.mName ~= data2.mName then
				return data.mName < data2.mName
			end

			if data.Categories[1] == data2.Categories[1] then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.Categories[1] < data2.Categories[1]
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortName", false),
		SortId = "NAME",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if
				data.mNameSearchable ~= nil
				and data2.mNameSearchable ~= nil
				and string.sub(data.mNameSearchable, 1, 1) ~= string.sub(data2.mNameSearchable, 1, 1)
			then
				return data.mNameSearchable < data2.mNameSearchable
			end

			if data.mName ~= data2.mName then
				return data.mName < data2.mName
			end

			if data.Categories[1] == data2.Categories[1] then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.Categories[1] < data2.Categories[1]
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Polarity", false),
		SortId = "POLARITY",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.Card.mPolarity ~= data2.Card.mPolarity then
				return data.Card.mPolarity < data2.Card.mPolarity
			end

			if data.mName ~= data2.mName then
				return data.mName < data2.mName
			end

			if data.Categories[1] == data2.Categories[1] then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.Categories[1] < data2.Categories[1]
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortType", false),
		SortId = "TYPE",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.Card.mItemCompatibilityValue ~= data2.Card.mItemCompatibilityValue then
				return data.Card.mItemCompatibilityValue < data2.Card.mItemCompatibilityValue
			end

			if data.Card.mUpgradeType ~= data2.Card.mUpgradeType then
				return data.Card.mUpgradeType < data2.Card.mUpgradeType
			end

			if data.mName == data2.mName then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.mName < data2.mName
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/SortingLabels/Level", false),
		SortId = "RANK",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.Card.mLevelForSort ~= data2.Card.mLevelForSort then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			if data.Card.mItemCompatibilityValue ~= data2.Card.mItemCompatibilityValue then
				return data.Card.mItemCompatibilityValue < data2.Card.mItemCompatibilityValue
			end

			if data.Card.mUpgradeType ~= data2.Card.mUpgradeType then
				return data.Card.mUpgradeType < data2.Card.mUpgradeType
			end

			if data.mName == data2.mName then
				return data.Id > data2.Id
			end

			return data.mName < data2.mName
		end
	})
	table.insert(v13, {
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SortDuplicates", false),
		SortId = "DUPLICATES",
		Attribute = function(data, data2)
			__wf_atom_83c14687()

			if data.LockCategories ~= data2.LockCategories then
				return data2.LockCategories
			end

			if
				p
				and not __wf_atom_7e8ad928(v12.HasCollectionBeenSorted)
				and not v12.HasCollectionBeenSorted()
				and data.Card.mIsNew ~= data2.Card.mIsNew
			then
				return data.Card.mIsNew
			end

			if data.Card.mUpgrade.mItemCount ~= data2.Card.mUpgrade.mItemCount then
				return data.Card.mUpgrade.mItemCount > data2.Card.mUpgrade.mItemCount
			end

			if data.mName ~= data2.mName then
				return data.mName < data2.mName
			end

			if data.Categories[1] == data2.Categories[1] then
				return data.Card.mLevelForSort > data2.Card.mLevelForSort
			end

			return data.Categories[1] < data2.Categories[1]
		end
	})
	return v13
end

local function fn34(data, p)
	if data == nil then
		return
	end

	local v12 = {}

	if fn8(data, true) then
		table.insert(v12, CategoryId_OMEGA)
	end

	if not __wf_atom_7e8ad928(data.mItemCompatibility) and data.mPolarity ~= 6 then
		if data.mItemCompatibility:IsA(crewHarnessForFiltering) then
			if data.mType == "AURA" then
				table.insert(v12, CategoryId_AURA)
			end

			table.insert(v12, CategoryId_RAILJACK)
		elseif data.mItemCompatibility:IsA(warframeForFiltering) then
			if data.mType == "AURA" then
				table.insert(v12, CategoryId_AURA)
			elseif data.mItemCompatibility ~= warframeForFiltering then
				table.insert(v12, CategoryId_AUGMENT)
			end

			table.insert(v12, CategoryId_WARFRAME)
		elseif data.mItemCompatibility:IsA(archwingMeleeForFiltering) then
			table.insert(v12, CategoryId_ARCHWINGSECONDARY)
		elseif data.mItemCompatibility:IsA(archwingGunForFiltering) then
			table.insert(v12, CategoryId_ARCHWINGPRIMARY)
		elseif data.mItemCompatibility:IsA(dataKnifeForFiltering) then
			table.insert(v12, CategoryId_IMMORTAL)
		elseif data.mItemCompatibility:IsA(tomeForFiltering) then
			table.insert(v12, CategoryId_TOME)
		elseif data.mItemCompatibility:IsA(rifleForFiltering) then
			table.insert(v12, CategoryId_RIFLE)
		elseif data.mItemCompatibility:IsA(__wf_atom_2c8a4b8d) then
			table.insert(v12, CategoryId_HAND_GUN)
		elseif data.mItemCompatibility:IsA(__wf_atom_77e05d3b) then
			if data.mIsStance then
				table.insert(v12, CategoryId_STANCE)
			else
				table.insert(v12, CategoryId_MELEE)
			end
		elseif data.mItemCompatibility:IsA(companionForFiltering) then
			table.insert(v12, CategoryId_COMPANIONS)
		elseif data.mItemCompatibility:IsA(roboticForFiltering) then
			table.insert(v12, CategoryId_ROBOTIC)
		elseif data.mItemCompatibility:IsA(genericPetForFiltering) then
			table.insert(v12, CategoryId_COMPANIONS)
			table.insert(v12, CategoryId_ROBOTIC)
		elseif
			data.mItemCompatibility:IsA(archwingSuitForFiltering)
			or data.mItemCompatibility:IsA(kdriveSuitForFiltering)
			or data.mItemCompatibility:IsA(mechSuitForFiltering)
		then
			table.insert(v12, CategoryId_ARCHWING)
		end

		if data.mLevel == 0 then
			table.insert(v12, CategoryId_UNFUSED)
		end

		if data.mIsUtility then
			table.insert(v12, CategoryId_UTILITY)
		end
	end

	if
		_T.upgradeItem ~= nil
		and data.mInstalled[_T.upgradeItem.info.mItemId.mId] ~= nil
		and (p == nil or data.mInstalled[_T.upgradeItem.info.mItemId.mId][p] ~= nil)
	then
		table.insert(v12, CategoryId_INSTALLED)
	end

	if #v12 == 0 then
		table.insert(v12, CategoryId_ALL)
	end

	return v12
end

function GetCardCategories(p)
	return fn34(p)
end

function AddToCollectionGrid(object, id, state, p)
	__wf_atom_83c14687(0)

	if state.Card == nil then
		return nil
	end

	local __wf_atom_a8dac107 = state.Card.mArtifactUpgrade:__wf_atom_a8dac107()
	local __wf_atom_964b656f = state.Card.mArtifactUpgrade:__wf_atom_964b656f(state.Card.mUpgrade.mUpgradeFingerprint)
	state.Id = id
	state.Selected = false

	if not state.LockCategories then
		local v12 = fn34(state.Card, p)

		if state.Categories == nil then
			state.Categories = fn34(state.Card, p)
		else
			for _, v13 in ipairs(v12) do
				table.insert(state.Categories, v13)
			end
		end
	end

	state.mRarity = fn23(state.Card, __wf_atom_a8dac107)
	state.mRating = state.Card.mRating
	state.mPrice = __wf_atom_964b656f
	state.mName = state.Card.mName
	state.mNameSearchable = state.Card.mNameSearchable
	state.Name = state.mName
	state.mType = state.Card.mType
	state.mLastAdded = state.Card.mUpgrade.mItemId.mId

	if state.Card.mIdentified and not state.Card.mUpgrade.mLastAdded:__wf_atom_b70c3343() then
		state.mLastAdded = state.Card.mUpgrade.mLastAdded.mId
	end

	if state.mLastAdded == "" then
		state.mLastAdded = state.Card.mUpgrade.mLastAdded.mId
	end

	if state.Card.mIsHidden then
		return nil
	end

	return object:AddElement(state, true)
end

function Update(p, p2, p3)
	local mMovie = fn2().mMovie
	local v12 = fn5(p, p3)

	if v12 ~= nil and p.mClipName ~= nil then
		if v12.mIdentified and fn8(v12) then
			v12.mNextChange -= __wf_atom_084b3e93()

			if v12.mNextChange <= 0 then
				v12.mNextChange = Random(0.2, 1.35)
				local v13 = __wf_atom_5784a397(0, 2)
				local v14 = v13 == 0 and 0 or v13 == 1 and 1 or 0.5
				v12.mBlend:__wf_atom_09294a87(v14)
			end

			local __wf_atom_9e368823 = v12.mBlend:__wf_atom_9e368823()
			v12.mBlend:Update(__wf_atom_084b3e93())
			local __wf_atom_9e368823_2 = v12.mBlend:__wf_atom_9e368823()

			if __wf_atom_9e368823_2 <= 0.1 and __wf_atom_9e368823 > 0.1 and v12.mIcons ~= nil and #v12.mIcons > 1 then
				local _mIconIndexB = v12.mIconIndexB
				local mIconIndexB = math.random(1, #v12.mIcons)

				while mIconIndexB == v12.mIconIndexA do
					mIconIndexB = math.random(1, #v12.mIcons)
				end

				v12.mIconIndexB = mIconIndexB
				v12.mIcon = v12.mIcons[mIconIndexB]
				mMovie:__wf_atom_f321ac85(p.mClipName .. ".Card.Icon", Symbol("BlendImageMap"), v12.mIcon)
			elseif
				__wf_atom_9e368823_2 >= 0.9
				and __wf_atom_9e368823 < 0.9
				and v12.mIcons ~= nil
				and #v12.mIcons > 1
			then
				local _mIconIndexA = v12.mIconIndexA
				local mIconIndexA = math.random(1, #v12.mIcons)

				while mIconIndexA == v12.mIconIndexB do
					mIconIndexA = math.random(1, #v12.mIcons)
				end

				v12.mIconIndexA = mIconIndexA
				v12.mIcon = v12.mIcons[mIconIndexA]
				mMovie:__wf_atom_c90af43a(p.mClipName .. ".Card.Icon", v12.mIcon)
			end

			v12.mBlendMaskOffset += __wf_atom_084b3e93() * 0.15

			if v12.mBlendMaskOffset > 1 then
				v12.mBlendMaskOffset -= 1
			end

			mMovie:__wf_atom_1ca72041(p.mClipName .. ".Card.Icon", "BlendMaskOffset", 0, v12.mBlendMaskOffset, 0, 0)
			mMovie:__wf_atom_1ca72041(p.mClipName .. ".Card.Icon", "BlendPoint", __wf_atom_9e368823_2, 0, 0, 0)
			v12.mRecordChangeTime = v12.mNextChange
		elseif v12.mGlowDir ~= nil and (fn14(v12) or IsCardGrimoire(v12)) then
			v12.mGlowStrength = __wf_atom_421b01aa(v12.mGlowStrength + 0.002 * v12.mGlowDir, 0.65, 0.95)

			if v12.mGlowStrength <= 0.65 or v12.mGlowStrength >= 0.95 then
				v12.mGlowDir = -v12.mGlowDir
			end

			if IsCardGrimoire(v12) then
				mMovie:__wf_atom_1ca72041(
					p.mClipName .. ".Card.Icon",
					"DetailMapTint",
					0,
					0.45,
					0.65,
					v12.mGlowStrength
				)
			else
				mMovie:__wf_atom_1ca72041(
					p.mClipName .. ".Card.Icon",
					"DetailMapTint",
					0.6353,
					0,
					0.1804,
					v12.mGlowStrength
				)
			end
		end

		if p.Zoomed then
			local rootBasedPosition, v13 = module.GetRootBasedPosition(mMovie, p.mClipName .. ".Btn")
			local v14 = v13 - mMovie:__wf_atom_5e6e15c8("_root", 31)
			local v15 = __wf_atom_421b01aa(v14 * -0.1, -20, 20)

			if v12.ForcePitchUpdate then
				v12.ForcePitchUpdate = nil
				v12.mPitch:__wf_atom_4453e49c(v15)
			else
				v12.mPitch:__wf_atom_09294a87(v15)
			end

			local v16 = rootBasedPosition - mMovie:__wf_atom_5e6e15c8("_root", 30)
			local v17 = __wf_atom_421b01aa(v16 * 0.2, -25, 25)
			v12.mHeading:__wf_atom_09294a87(v17)
		else
			v12.mPitch:__wf_atom_09294a87(v12.mBasePitch)
			v12.mHeading:__wf_atom_09294a87(0)
		end

		local __wf_atom_9e368823 = v12.mPitch:__wf_atom_9e368823()
		local __wf_atom_9e368823_2 = v12.mHeading:__wf_atom_9e368823()
		v12.mPitch:Update(p2)
		local __wf_atom_9e368823_3 = v12.mPitch:__wf_atom_9e368823()

		if __wf_atom_9e368823_3 ~= __wf_atom_9e368823 then
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Card", 18, __wf_atom_9e368823_3)
			mMovie:__wf_atom_1ca72041(
				p.mClipName .. ".Card.Icon",
				"AutoOffsetParallax",
				0,
				0,
				__wf_atom_9e368823_2,
				__wf_atom_9e368823
			)
		end

		v12.mHeading:Update(p2)
		local __wf_atom_9e368823_4 = v12.mHeading:__wf_atom_9e368823()

		if __wf_atom_9e368823_4 ~= __wf_atom_9e368823_2 then
			mMovie:__wf_atom_4c1c1986(p.mClipName, "Card", 17, __wf_atom_9e368823_4)
			mMovie:__wf_atom_1ca72041(
				p.mClipName .. ".Card.Icon",
				"AutoOffsetParallax",
				0,
				0,
				__wf_atom_9e368823_2,
				__wf_atom_9e368823
			)
		end
	end
end

function GetOmegaUpgrades()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return nil
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		return nil
	end

	local inventory = __wf_atom_9be88b01:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return nil
	end

	local upgrades = inventory:GetUpgrades()
	local result = {}

	for i = 1, #upgrades do
		if __wf_atom_7e8ad928(upgrades[i].mItemType) or not upgrades[i].mItemType:IsA(omegaModType) then
			continue
		end

		table.insert(result, upgrades[i])
	end

	return result
end

local function fn35(state, p)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return false
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_7e8ad928((__wf_atom_9be88b01:GetInventory())) then
		return false
	end

	local v12 = p == nil and 0 or p
	local omegaCards = module2.GetOmegaCards()
	local maxOmegaCapacity = module2.GetMaxOmegaCapacity()
	local v13 = #omegaCards + v12
	local sellOperation = SF.SellOperation()
	sellOperation.mSellCurrency = 2
	local total = 0
	local v14 = v13 - maxOmegaCapacity
	local screen = _T.OpenScreen("ItemBrowsing")

	if __wf_atom_7e8ad928(screen) then
		return false
	end

	local v15 = #omegaCards <= maxOmegaCapacity
	screen:Execute(
		"SetTitle",
		state.mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/OmegaLimit_TitleWithCount", false, {
			COUNT = module.FormatNumber(v14)
		})
	)
	screen:__wf_atom_f62a8704("SetVariableSelection", { tostring(v14), "false" })
	screen:Execute(
		"SetCancelCallout",
		module.Ternary(v15, "/Lotus/Language/Menu/NavBar_Cancel", "/Lotus/Language/Menu/OmegaLimit_Cancel")
	)

	if not v15 then
		screen:Execute("SetCancelConfirmText", "/Lotus/Language/Menu/OmegaLimit_CancelConfirm")
	end

	screen:Execute("SetHideCountThreshold", "1")
	local result = {}

	for i = 1, #omegaCards do
		local card = fn24(state, omegaCards[i], i)
		local v16 = { Card = card, mCardIndex = i, Count = 1, SellingPrice = card.mRating }
		v16.SellInfo = { LabelType = 12, HideInGrid = false }
		table.insert(result, v16)
	end

	local v16 = nil

	function state.OnOmegaSellCompleted(p2, p3)
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

		if p2 then
			module.PlaySound(_G.UISound_Purchase)
		else
			print("Upgrade Sale Fail: " .. p3)
			module.ShowMessage("/Lotus/Language/Menu/Upgrade_SaleFailed")
		end

		if not __wf_atom_7e8ad928(state._OnOmegaSellCompleted) then
			state._OnOmegaSellCompleted(p2)
		end

		_T.ShowingOmegaDiscardScreen = false
		v16 = nil
	end

	function state.SellExcessOmegas()
		module2.AddMatchmakingLabelToSellOperation(sellOperation)
		v16 = SF.SellCommand(sellOperation, "OnOmegaSellCompleted")
		v16:Execute()
	end

	function _T.OmegaSelectionDone(list)
		_T.GetAllOmegaMods = nil
		_T.OmegaSelectionDone = nil
		_T.GetMeltConfirmText = nil

		if list == nil then
			_T.ShowingOmegaDiscardScreen = false
			return
		end

		for i = 1, #list do
			if not __wf_atom_7e8ad928(list[i]) then
				sellOperation:SellItem(4, tostring(list[i].Card.mUpgrade.mItemId), 0)
			end
		end

		sellOperation.mSellPrice = total
		state.mMovie:Execute("SellExcessOmegas", "")
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
	end

	screen:Execute("SetCallBack", "OmegaSelectionDone")

	function _T.GetMeltConfirmText(list)
		total = 0

		if list ~= nil then
			for i = 1, #list do
				local mRating = list[i].Card.mRating
				total += mRating
			end
		end

		return (screen:__wf_atom_8e9ac384("/Lotus/Language/Menu/OmegaLimit_SellConfirm", true, {
			PRICE = module.FormatNumber(total)
		}))
	end

	screen:Execute("SetConfirmTextFunction", "GetMeltConfirmText")

	function _T.GetAllOmegaMods()
		return result
	end

	screen:Execute("SetElementsFunction", "GetAllOmegaMods")
end

function OmegaLimitCheck(p)
	local v12 = p == nil and 0 or p
	local omegaCards = module2.GetOmegaCards()
	local maxOmegaCapacity = module2.GetMaxOmegaCapacity()
	local v13 = #omegaCards + v12

	if v13 <= maxOmegaCapacity then
		return false
	end

	local num = v13 - maxOmegaCapacity
	local v14 = fn2()

	function v14.OnRivenLimitSelection(p2)
		if p2 == 4 then
			fn35(v14, v12)
			return
		end

		if p2 ~= 6 then
			_T.ShowingOmegaDiscardScreen = false
			return
		end

		local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()

		if __wf_atom_7e8ad928(__wf_atom_964056fd) then
			_T.ShowingOmegaDiscardScreen = false
			return
		end

		local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(WeakResource("/Lotus/Types/StoreItems/SlotItems/RandomModSlotItem"))

		if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
			_T.ShowingOmegaDiscardScreen = false
			return
		end

		local saleInfo = module2.GetSaleInfo(__wf_atom_232fd31d)
		local v15 = nil

		local function fn36(p3, _, p4)
			if not (__wf_atom_7e8ad928(v15) or p4) then
				v15:Execute("TransitionOut", "")
			end

			if p3 == false then
				module.ShowMessage("/Lotus/Language/Menu/Global_PurchaseFailed")
			elseif not __wf_atom_7e8ad928(v14.OnBuySlot) then
				v14.OnBuySlot()
			end
		end

		_T.marketDetailedViewParms = nil
		_T.marketDetailedViewParms = {
			ITEM = { StoreItem = __wf_atom_232fd31d, Sale = saleInfo },
			CALLBACK = fn36
		}
		v15 = _T.OpenScreen("DetailedPurchaseDialog")

		if __wf_atom_7e8ad928(v15) then
			_T.ShowingOmegaDiscardScreen = false
		else
			function _T.OnDetailedViewComplete()
				_T.OnDetailedViewComplete = nil
				_T.ShowingOmegaDiscardScreen = false
			end

			v15:Execute("SetIgnoreTopMenu", "true")
			v15:Execute("SetExitCallback", "OnDetailedViewComplete")
			v15:Execute("SetExitCallbackIsTemp", "true")
		end
	end

	local ternary = module.Ternary(
		v12 > 0,
		"/Lotus/Language/SystemMessages/OmegaLimit_ActivationWarning",
		"/Lotus/Language/Menu/OmegaLimit_Warning"
	)
	local v15 = not __wf_atom_7e8ad928(gGameRules:__wf_atom_964056fd())
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = module.Ternary(v15, 5, 1)
	dialogSettings.locString = v14.mMovie:__wf_atom_8e9ac384(ternary, false, { NUM = num })
	dialogSettings.firstString = "/Lotus/Language/Menu/OmegaLimit_Title"

	if v15 then
		dialogSettings.secondString = "/Lotus/Language/Menu/OmegaLimit_PurchaseSlots"
		dialogSettings.thirdString = "/Lotus/Language/Menu/OmegaLimit_Cancel"
	else
		dialogSettings.secondString = "/Lotus/Language/Menu/OmegaLimit_Cancel"
	end

	dialogSettings:SetCallback("OnRivenLimitSelection")
	module.ShowCustomMessage(dialogSettings)
	_T.ShowingOmegaDiscardScreen = true
	return true
end

function OnOmegaSellCompleted(p, p2)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p then
		module.PlaySound(_G.UISound_Purchase)
	else
		print("Upgrade Sale Fail: " .. p2)
		module.ShowMessage("/Lotus/Language/Menu/Upgrade_SaleFailed")
	end

	_T.ShowingOmegaDiscardScreen = false
end

function GetOmegaRerollCost(p)
	local v12 = 900

	if not fn8(p) then
		return (math.min(v12, 3500))
	end

	local v13 = math.floor(v12 + math.pow(p.mArtifactUpgrade:__wf_atom_039b779b(p.mUpgrade.mUpgradeFingerprint), 1.5) * 100)
	local v14 = v13 % 50
	local v15

	if v14 >= 25 then
		v15 = 50 - v14
	else
		v15 = -v14
	end

	v12 = v13 + v15
	return (math.min(v12, 3500))
end

local function fn36(p, p2)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p.mInstance) then
		return 0
	end

	local ternary = module.Ternary(p2 ~= nil, p2, p.mUpgradeFingerprint)
	return p.mInstance:__wf_atom_c6a5f697(ternary), (p.mInstance:__wf_atom_49f7d220(ternary))
end

function GetArcaneRank(p, p2)
	return fn36(p, p2)
end

function GetArcaneRankLabel(object, p, p2, p3)
	local v12 = ""
	local v13, v14 = fn36(p, p3)

	if p2 then
		if v13 > 0 then
			for i = 1, v14 do
				v12 ..= object:__wf_atom_8e9ac384(
					module.Ternary(i <= v13, "<ARCANE_RANK>", "<ARCANE_RANK_OUTLINE>"),
					true
				)
			end
		end
	else
		if v13 == 0 then
			return (object:__wf_atom_8e9ac384("/Lotus/Language/Ranks/Rank0", false))
		end

		return (object:__wf_atom_8e9ac384("/Lotus/Language/Menu/Global_FormattedRankCaps", false, {
			RANK = tostring(v13)
		}))
	end

	return v12
end

function ValidateWeaponUpgrades(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	local inventory = object:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return
	end

	local v12 = false
	local __wf_atom_0ff4b555 = inventory:__wf_atom_0ff4b555(p)
	local __wf_atom_6ec6b781 = __wf_atom_0ff4b555:__wf_atom_6ec6b781()
	local v13 = math.min(
		math.max(
			__wf_atom_c67f9605:__wf_atom_b4a75eaa(__wf_atom_0ff4b555.mXP, __wf_atom_0ff4b555.mItemType),
			object:__wf_atom_a04e4a53()
		),
		__wf_atom_c67f9605:__wf_atom_a1680b24(__wf_atom_0ff4b555.mItemType)
	)

	if __wf_atom_0ff4b555:__wf_atom_717d3c58(1) then
		v13 *= 2
	end

	for i = 0, 1 do
		for j = 0, 2 do
			local __wf_atom_43563387 = inventory:__wf_atom_43563387(__wf_atom_0ff4b555, p3, p2, j, i == 1)
			local upgradeIds = {}
			local v14 = 0

			for k = #__wf_atom_43563387, 1, -1 do
				local upgradeId = SF.UpgradeId()
				local v15 = __wf_atom_43563387[k]

				if not (v15.mItemId:__wf_atom_b70c3343() and __wf_atom_7e8ad928(v15.mItemType)) then
					local __wf_atom_c85c35bf = v15.mInstance:__wf_atom_c85c35bf(v15.mUpgradeFingerprint)

					if __wf_atom_6ec6b781[k] ~= nil then
						__wf_atom_c85c35bf = v15.mInstance:__wf_atom_d41d9dcf(
							__wf_atom_c85c35bf,
							__wf_atom_6ec6b781[k],
							v15.mUpgradeFingerprint
						)
					end

					local v16 = v14 + __wf_atom_c85c35bf

					if v16 <= v13 then
						upgradeId.mId = v15.mItemId
						upgradeId.mType = v15.mItemType
						v14 = v16
					else
						v12 = true
					end
				end

				upgradeIds[k] = upgradeId
			end

			inventory:__wf_atom_494e9b0e(p, j, i == 1, upgradeIds)
		end
	end

	return v12
end

function GetSearchString(data)
	local v12 = data.mName .. " " .. data.mDesc .. " " .. data.mType

	if data.mSetDesc then
		v12 ..= " " .. data.mSetDesc
	end

	if not (__wf_atom_7e8ad928(data.mUpgrade) or __wf_atom_7e8ad928(data.mArtifactUpgrade)) then
		local __wf_atom_fee7bbed = data.mArtifactUpgrade:__wf_atom_fee7bbed()

		for i = 1, #__wf_atom_fee7bbed do
			v12 ..= " " .. Localize(__wf_atom_fee7bbed[i]:c_str(), false)
		end
	end

	return __wf_atom_d99ae0ec(v12)
end

function GetRarityLoc(p)
	return "/Lotus/Language/Labels/" .. v[p + 1]
end