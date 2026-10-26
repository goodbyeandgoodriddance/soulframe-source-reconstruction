module(..., package.seeall)
local v = { WeakResource("/SF/Souls/Default/BaseSoul"), WeakResource("/SF/Upgrades/Skins/Body/ForgetFireBodyNaked") }
local v2 = {
	faction = Resource("/SF/Syndicates/ChampionSyndicate"),
	virtueBonus = { 4, 0, 0 },
	virtueName = "/SF/Language/Menu/CourageVirtuePath",
	timeOfDay = 7,
	sunDir = Vector(-2, 0.2, -1),
	lightColor = Color(255, 196, 196),
	idleAnim = Resource("/SF/Animations/Player/Movement/MM/UnarmedV3/IdleRightChampion_anim.fbx"),
	gear = {
		WeakResource("/SF/Souls/Default/ChampionSoul"),
		WeakResource("/SF/Upgrades/Skins/Body/StarterCourageBody"),
		WeakResource("/SF/Upgrades/Skins/Helmets/StarterCourageHelmet"),
		WeakResource("/SF/Upgrades/Skins/Legs/StarterCourageLegs"),
		WeakResource("/SF/Weapons/Melee/OneHand/StarterSword/StarterSwordMeleeWeapon")
	},
	totem = WeakResource("/SF/Upgrades/Skins/Totem/ChampionHubTotem")
}
local v3 = {
	faction = Resource("/SF/Syndicates/SilentRoseSyndicate"),
	virtueBonus = { 0, 0, 4 },
	virtueName = "/SF/Language/Menu/GraceVirtuePath",
	timeOfDay = 17,
	sunDir = Vector(0, 1, -1),
	lightColor = Color(196, 225, 255),
	idleAnim = Resource("/SF/Animations/Player/Movement/MM/UnarmedV3/IdleRightSaboteur_anim.fbx"),
	gear = {
		WeakResource("/SF/Souls/Default/SaboteurSoul"),
		WeakResource("/SF/Upgrades/Skins/Body/StarterGraceBody"),
		WeakResource("/SF/Upgrades/Skins/Helmets/StarterGraceHelmet"),
		WeakResource("/SF/Upgrades/Skins/Legs/StarterGraceLegs"),
		WeakResource("/SF/Weapons/Ranged/TwoHand/StarterBow/StarterBowRangedMeleeWeapon")
	},
	totem = WeakResource("/SF/Upgrades/Skins/Totem/SilentRoseHubTotem")
}
local v4 = {
	faction = Resource("/SF/Syndicates/FeySyndicate"),
	virtueBonus = { 0, 4, 0 },
	virtueName = "/SF/Language/Menu/SpiritVirtuePath",
	timeOfDay = 0,
	sunDir = Vector(0, 1, -1),
	lightColor = Color(196, 255, 196),
	idleAnim = Resource("/SF/Animations/Player/Movement/MM/UnarmedV3/IdleRightGalene_anim.fbx"),
	gear = {
		WeakResource("/SF/Souls/Default/WardSoul"),
		WeakResource("/SF/Upgrades/Skins/Body/StarterSpiritBody"),
		WeakResource("/SF/Upgrades/Skins/Helmets/StarterSpiritHelmet"),
		WeakResource("/SF/Upgrades/Skins/Legs/StarterSpiritLegs"),
		WeakResource("/SF/Weapons/Ranged/OneHand/StarterStaffCaster/StarterStaffCasterRangedMeleeWeapon")
	},
	totem = WeakResource("/SF/Upgrades/Skins/Totem/FeyHubTotem")
}
mInitialHeadSkins = {
	WeakResource("/SF/Upgrades/Skins/Head/ForgetFire1Head"),
	WeakResource("/SF/Upgrades/Skins/Head/ForgetFire2Head"),
	WeakResource("/SF/Upgrades/Skins/Head/ForgetFire3Head"),
	WeakResource("/SF/Upgrades/Skins/Head/ForgetFire4Head"),
	WeakResource("/SF/Upgrades/Skins/Head/ForgetFire5Head")
}
mInitialHairSkins = {
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair4AHelmet"),
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair5AHelmet"),
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair1AHelmet"),
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair2AHelmet"),
	WeakResource("/SF/Upgrades/Skins/Helmets/Hair3AHelmet")
}
mMotherSkinColors = {
	Color(255, 255, 255, 255),
	Color(229, 202, 180, 255),
	Color(163, 124, 70, 255),
	Color(85, 66, 41, 128),
	Color(68, 51, 44, 128)
}
local v5 = {
	WeakResource("/SF/Upgrades/Skins/Mother/Hair4Helmet"),
	WeakResource("/SF/Upgrades/Skins/Mother/Hair5Helmet"),
	WeakResource("/SF/Upgrades/Skins/Mother/Hair1Helmet"),
	WeakResource("/SF/Upgrades/Skins/Mother/Hair2Helmet"),
	WeakResource("/SF/Upgrades/Skins/Mother/Hair3Helmet")
}
local module = require("SF.Scripts.Libs.QuestLib")
local v6 = {
	WeakResource("/SF/Upgrades/Skins/Head/BloodHeadSkin1"),
	WeakResource("/SF/Upgrades/Skins/Head/BloodHeadSkin2"),
	WeakResource("/SF/Upgrades/Skins/Head/BloodHeadSkin3"),
	WeakResource("/SF/Upgrades/Skins/Head/BloodHeadSkin4"),
	WeakResource("/SF/Upgrades/Skins/Head/BloodHeadSkin5")
}
local v7 = WeakResource("/SF/Types/Quests/PreAlpha/Q1WakeUp")

function GetEnvoyHairForMotherHair(p)
	local index = table.find(v5, p) or 1
	return mInitialHairSkins[index]
end

function GetEnvoyHeadSkinForMotherTone(object)
	local __wf_atom_dcecedb0 = object:__wf_atom_dcecedb0()
	local v8 = 1

	for i, v9 in ipairs(mMotherSkinColors) do
		if v9:__wf_atom_dcecedb0() ~= __wf_atom_dcecedb0 then
			continue
		end

		v8 = i
		break
	end

	return mInitialHeadSkins[v8], v6[v8]
end

function GetInitialFactionLoadouts()
	return { v2, v3, v4 }
end

local function fn(p)
	if __wf_atom_7e8ad928(p) then
		return nil
	end

	for _, v8 in ipairs(GetInitialFactionLoadouts()) do
		if p == v8.faction:__wf_atom_e0f044e1() then
			return v8
		end
	end

	return nil
end

function GetInitialGear(p)
	local v8 = fn(p)

	if v8 then
		return v8.gear
	end

	return nil
end

function GetAllInitialGear()
	local result = {}

	for _, v8 in ipairs(v) do
		table.insert(result, v8)
	end

	for _, v8 in ipairs(GetInitialFactionLoadouts()) do
		for _, v9 in ipairs(v8.gear) do
			table.insert(result, v9)
		end

		table.insert(result, v8.totem)
	end

	for _, v8 in ipairs(mInitialHeadSkins) do
		table.insert(result, v8)
	end

	for _, v8 in ipairs(mInitialHairSkins) do
		table.insert(result, v8)
	end

	for _, v8 in ipairs(v6) do
		table.insert(result, v8)
	end

	return result
end

function LoadInitialGear()
	local v8 = {}

	for _, v9 in ipairs(GetAllInitialGear()) do
		if v9:IsA(__wf_atom_9df43583) then
			local __wf_atom_3dbd0893 = gGameData:__wf_atom_3dbd0893(v9)
			table.move(__wf_atom_3dbd0893, 1, #__wf_atom_3dbd0893, #v8 + 1, v8)
		else
			table.insert(v8, v9:__wf_atom_5b41f63b())
		end
	end

	return UISys.__wf_atom_c0dbe47c(v8, true)
end

function GetFactionVirtueBonus(p)
	local v8 = fn(p)

	if v8 then
		return v8.virtueBonus
	end

	return { 0, 0, 0 }
end

function GetFactionIdleAnim(p)
	local v8 = fn(p)

	if v8 then
		return v8.idleAnim
	end

	return nil
end

function GiveInitialGear(instance, p, p2, p3)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v8 = p2 == nil or p2
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	__wf_atom_d2b2176d:Clear()
	__wf_atom_d2b2176d:__wf_atom_91ecc559()
	local v9

	if __wf_atom_7e8ad928(gGameData) then
		v9 = false
	else
		v9 = gGameData:__wf_atom_8856b776()
		instance:__wf_atom_72cd7949(v9)
	end

	local __wf_atom_3a61ed37 = gGameData:GetInventory():__wf_atom_3a61ed37()
	local v10 = GetEnvoyHairForMotherHair(__wf_atom_3a61ed37:__wf_atom_035fdfa8(0))
	local v11, v12 = GetEnvoyHeadSkinForMotherTone(__wf_atom_3a61ed37:GetColor(0, 0))
	__wf_atom_3a61ed37:__wf_atom_632ac5b2()
	__wf_atom_3a61ed37:SetSkin(v10, 4)
	__wf_atom_3a61ed37:SetSkin(v11, 6)
	local v13 = fn(p)
	local gear

	if __wf_atom_7e8ad928(v13) then
		for i = 0, 2 do
			instance:__wf_atom_9189c3be(i, (instance:GetAttribute(i, false)))
		end

		gear = v
	else
		gear = v13.gear
	end

	for _, v14 in ipairs(gear) do
		local v15 = Resource(v14)

		if v15:IsA(__wf_atom_abf506db) then
			__wf_atom_3a61ed37:SetSkin(v15, v15:__wf_atom_1e8ecdaa())
		else
			instance:GiveItem(v15, v8)
		end
	end

	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:SetCustomization(__wf_atom_3a61ed37)
	end

	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	__wf_atom_d2b2176d:Update(0)

	if not p3 then
		Resource(v12):__wf_atom_e6329949(v9 and 0 or 1, instance, false)
	end
end

function OnFirstLoginSequenceFinished()
	_T.FirstLoginSequencePlayed = true
	_T.ShowWelcome = true
	gRegion:__wf_atom_0a6a5887(Symbol("StartLoginCins")):FirePort("Execute")
	gRegion:__wf_atom_0a6a5887(Symbol("PostFirstLoginSetup")):FirePort("Execute")
end

local function fn2(p)
	local v8 = false
	local __wf_atom_f89aa44a = __wf_atom_a0f6588f:__wf_atom_f89aa44a()
	print("IsNewPlayer: checking if new player, logged in: " .. tostring(__wf_atom_f89aa44a))

	if p and not __wf_atom_f89aa44a then
		print("IsNewPlayer: player not logged in, fetching last profile")
		__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v8 = true
	else
		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if not (__wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_9be88b01:__wf_atom_df64c481()) then
			v8 = not (module.QuestIsActive(v7) or module.HasCompletedQuest(v7))
		end
	end

	if v8 then
		print("IsNewPlayer: new player detected!")
		return v8
	end

	print("IsNewPlayer: returning player!")
	return v8
end

function ShouldDoFirstLoginSequence(p)
	return (fn2(p))
end

function ShouldSkipPostLoginCin()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return false
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	return not (__wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_9be88b01:__wf_atom_df64c481())
end

function FetchLoadOutId(p)
	local __wf_atom_f89aa44a = __wf_atom_a0f6588f:__wf_atom_f89aa44a()

	if p and not __wf_atom_f89aa44a then
		__wf_atom_a0f6588f:__wf_atom_aca7a6d6(false)
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v8 = not __wf_atom_7e8ad928(__wf_atom_18a5d83b) and __wf_atom_18a5d83b:__wf_atom_9be88b01() or nil
	local inventory = not __wf_atom_7e8ad928(v8) and v8:GetInventory() or nil

	if __wf_atom_7e8ad928(inventory) then
		return nil
	end

	return inventory:__wf_atom_d25917b6(0).mId
end

function StartFirstLoginSequenece()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local loadOut = SF.LoadOut()
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		__wf_atom_d2b2176d:__wf_atom_91ecc559()
		__wf_atom_d2b2176d:Clear()
		__wf_atom_d2b2176d:BuildLoadOut(loadOut, 0)
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StartFirstLoginCins"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("Execute")
	end
end