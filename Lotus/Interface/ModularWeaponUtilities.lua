module(..., package.seeall)
local module = require("Lotus.Interface.UIStyleUtilities")
local module2 = require("EE.Interface.Utilities")
local v = {
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponBlade"),
		Tag = "/Lotus/Language/OstronCrafting/Crafting_PartBlade"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponHilt"),
		Tag = "/Lotus/Language/OstronCrafting/Crafting_PartHilt"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponWeight"),
		Tag = "/Lotus/Language/OstronCrafting/Crafting_PartBalance"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponAmpOculus"),
		Tag = "/Lotus/Language/OstronCrafting/AmpMod_PartBarrel"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponAmpCore"),
		Tag = "/Lotus/Language/OstronCrafting/AmpMod_PartChassis"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFWeaponAmpBrace"),
		Tag = "/Lotus/Language/OstronCrafting/AmpMod_PartGrip"
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/KubrowPetMutagenBase"),
		Tag = "/Lotus/Language/InfestedMicroplanet/Pet_Mutagen"
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/KubrowPetAntigenBase"),
		Tag = "/Lotus/Language/InfestedMicroplanet/Pet_Antigen"
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/CatbrowPetMutagenBase"),
		Tag = "/Lotus/Language/InfestedMicroplanet/Pet_Mutagen"
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/CatbrowPetAntigenBase"),
		Tag = "/Lotus/Language/InfestedMicroplanet/Pet_Antigen"
	},
	{
		Type = WeakResource("/SF/Types/Game/MoaPetParts/SFMoaPetHead"),
		Tag = "/Lotus/Language/SolarisVenus/MoaPet_PartHead"
	},
	{
		Type = WeakResource("/SF/Types/Game/MoaPetParts/SFMoaPetEngine"),
		Tag = "/Lotus/Language/SolarisVenus/MoaPet_PartEngine"
	},
	{
		Type = WeakResource("/SF/Types/Game/MoaPetParts/SFMoaPetPayload"),
		Tag = "/Lotus/Language/SolarisVenus/MoaPet_PartPayload"
	},
	{
		Type = WeakResource("/SF/Types/Game/ZanukaPetParts/SFZanukaHeadPart"),
		Tag = "/Lotus/Language/SolarisVenus/ZanukaPet_PartHead"
	},
	{
		Type = WeakResource("/SF/Types/Game/ZanukaPetParts/SFZanukaBodyPart"),
		Tag = "/Lotus/Language/SolarisVenus/ZanukaPet_PartBody"
	},
	{
		Type = WeakResource("/SF/Types/Game/ZanukaPetParts/SFZanukaLegPart"),
		Tag = "/Lotus/Language/SolarisVenus/ZanukaPet_PartLeg"
	},
	{
		Type = WeakResource("/SF/Types/Game/ZanukaPetParts/SFZanukaTailPart"),
		Tag = "/Lotus/Language/SolarisVenus/ZanukaPet_PartTail"
	},
	{
		Type = WeakResource("/SF/Types/Game/MoaPetParts/SFMoaPetLeg"),
		Tag = "/Lotus/Language/SolarisVenus/MoaPet_PartLeg"
	},
	{
		Type = WeakResource("/SF/Types/Game/HoverboardParts/SFHoverboardDeck"),
		Tag = "/Lotus/Language/Hoverboards/HoverboardPartDeck"
	},
	{
		Type = WeakResource("/SF/Types/Game/HoverboardParts/SFHoverboardEngine"),
		Tag = "/Lotus/Language/Hoverboards/HoverboardPartEngine"
	},
	{
		Type = WeakResource("/SF/Types/Game/HoverboardParts/SFHoverboardFront"),
		Tag = "/Lotus/Language/Hoverboards/HoverboardPartFront"
	},
	{
		Type = WeakResource("/SF/Types/Game/HoverboardParts/SFHoverboardJet"),
		Tag = "/Lotus/Language/Hoverboards/HoverboardPartJet"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFGunBarrel"),
		Tag = "/Lotus/Language/SolarisVenus/Gun_Barrels"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFGunSecondaryHandle"),
		Tag = "/Lotus/Language/SolarisVenus/Gun_Handles"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFGunPrimaryHandle"),
		Tag = "/Lotus/Language/SolarisVenus/Gun_Handles"
	},
	{
		Type = WeakResource("/SF/Types/Weapon/SFGunClip"),
		Tag = "/Lotus/Language/SolarisVenus/Gun_Clips"
	},
	{
		Type = WeakResource("/SF/Types/Game/ArchwingParts/SFArchwingEngine"),
		Tag = "/Lotus/Language/ModularArchwing/ModularAWCrafting_PartEngine"
	},
	{
		Type = WeakResource("/SF/Types/Game/ArchwingParts/SFArchwingGenerator"),
		Tag = "/Lotus/Language/ModularArchwing/ModularAWCrafting_PartGenerator"
	},
	{
		Type = WeakResource("/SF/Types/Game/ArchwingParts/SFArchwingWing"),
		Tag = "/Lotus/Language/ModularArchwing/ModularAWCrafting_PartWing"
	}
}
local v2 = {
	{
		Type = WeakResource("/Lotus/Weapons/Ostron/Melee/LotusModularWeapon"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Primary/LotusModularPrimary"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Primary/LotusModularPrimaryBeam"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Primary/LotusModularPrimaryShotgun"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Secondary/LotusModularSecondary"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Secondary/LotusModularSecondaryBeam"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Weapons/SolarisUnited/Secondary/LotusModularSecondaryShotgun"),
		Parts = 3
	},
	{
		Type = WeakResource("/Lotus/Types/Vehicles/Hoverboard/HoverboardSuit"),
		Parts = 4
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/BasePredatorKubrowPetPowerSuit"),
		Parts = 2
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/BaseInfestedCatbrowPetPowerSuit"),
		Parts = 2
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/MoaPets/MoaPetPowerSuit"),
		Parts = 4
	},
	{
		Type = WeakResource("/Lotus/Types/Friendly/Pets/ZanukaPets/ZanukaPetPowerSuit"),
		Parts = 4
	},
	{
		Type = WeakResource("/Lotus/Powersuits/Archwing/ModularJetPack/ModularJetPack"),
		Parts = 3
	}
}
local v3 = WeakResource("/SF/Types/Game/CreaturePetParts/SFCreaturePetPart")
local v4 = WeakResource("/SF/Types/Game/CreaturePetParts/SFCreaturePetAntigen")
local v5 = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/KubrowPetAntigenBase")
local v6 = WeakResource("/Lotus/Types/Friendly/Pets/CreaturePets/CreaturePetParts/KubrowPetMutagenBase")

local function fn(object, instance)
	for i = 1, #v do
		if instance:IsA(v[i].Type) then
			return (object:__wf_atom_8e9ac384(v[i].Tag, false))
		end
	end

	return ""
end

function GetPartsText(object, list, object2, p, p2, p3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(list) or __wf_atom_7e8ad928(object2) then
		return ""
	end

	local result = {}
	local v7 = ""
	local convertColorNumberToHex = module2.ConvertColorNumberToHex(module.GetColor(9, true))
	local convertColorNumberToHex2 = module2.ConvertColorNumberToHex(module.GetColor(6, true))

	if p then
		v7 ..= "<font color=\"" .. convertColorNumberToHex2 .. "\"><br><b>" .. object:__wf_atom_8e9ac384(
			"/Lotus/Language/OstronCrafting/Crafting_PartsHeader",
			false
		) .. "<br></font>"
	end

	if __wf_atom_7e8ad928(list[1]) or not list[1]:IsA(v3) then
		for i = 1, #list do
			local v8 = list[i]
			local __wf_atom_232fd31d = object2:__wf_atom_232fd31d(v8)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				continue
			end

			local v9 = fn(object, v8)
			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), false)
			table.insert(result, __wf_atom_8e9ac384)
			local v10 = v7 .. "<font color=\"" .. convertColorNumberToHex .. "\"><b>" .. v9 .. ": </b></font><font color=\"" .. convertColorNumberToHex2 .. "\">" .. __wf_atom_8e9ac384

			if not p2 or i ~= #list then
				v10 ..= "<br>"
			end

			v7 = v10 .. "</font>"
		end
	else
		local v8 = {
			Antigen = { Type = v5, Count = 0, Desc = "" },
			Mutagen = { Type = v6, Count = 0, Desc = "" }
		}

		for i = 1, #list do
			local v9 = list[i]
			local __wf_atom_232fd31d = object2:__wf_atom_232fd31d(v9)

			if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
				continue
			end

			local __wf_atom_8e9ac384 = object:__wf_atom_8e9ac384(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), false)
			table.insert(result, __wf_atom_8e9ac384)
			local ternary = module2.Ternary(v8.Antigen.Count == 0, "", ", ")

			if v9:IsA(v4) then
				v8.Antigen.Desc = v8.Antigen.Desc .. ternary .. __wf_atom_8e9ac384
				v8.Antigen.Count = v8.Antigen.Count + 1
			else
				local ternary2 = module2.Ternary(v8.Mutagen.Count == 0, "", ", ")
				v8.Mutagen.Desc = v8.Mutagen.Desc .. ternary2 .. __wf_atom_8e9ac384
				v8.Mutagen.Count = v8.Mutagen.Count + 1
			end
		end

		v8.Antigen.Desc = "<font color=\"" .. convertColorNumberToHex .. "\"><b>" .. fn(object, v8.Antigen.Type) .. ": </b></font><font color=\"" .. convertColorNumberToHex2 .. "\">" .. v8.Antigen.Desc .. "</font>"
		v8.Mutagen.Desc = "<font color=\"" .. convertColorNumberToHex .. "\"><b>" .. fn(object, v8.Mutagen.Type) .. ": </b></font><font color=\"" .. convertColorNumberToHex2 .. "\">" .. v8.Mutagen.Desc .. "</font>"
		v7 ..= v8.Mutagen.Desc .. "<br>" .. v8.Antigen.Desc
	end

	if p3 then
		return v7, result
	end

	return v7
end

function GetModularType(instance)
	if not __wf_atom_7e8ad928(instance) then
		for i = 1, #v2 do
			if instance:IsA(v2[i].Type) then
				return v2[i].Type, v2[i].Parts
			end
		end
	end

	return nil, nil
end