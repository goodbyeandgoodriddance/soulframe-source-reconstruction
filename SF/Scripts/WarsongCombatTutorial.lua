local module = require("Lotus.Scripts.Libs.AudioLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.NightFoldLib")
local module4 = require("SF.Interface.SFUtilities")

function setMotherAvatar()
	_T.CombatTutorialEnded = false
	module2.RegisterDisableEnemyLootDrops(true)
	module3.RegisterPreventNighfoldUsage(true)
	module4.RegisterHideHudSelective(true)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StartCombatTutorialTrigger"))
	_T.CombatTutorialStartedFromNightFold = __wf_atom_eab484a7:__wf_atom_50a7d83e():__wf_atom_799d95f5()
	local position = __wf_atom_0a6a5887:GetPosition()
	local __wf_atom_dc309f8a = __wf_atom_0a6a5887:__wf_atom_dc309f8a()
	local entity = gRegion:CreateEntity(
		Type("/SF/Types/Player/MotherAvatar"),
		position,
		__wf_atom_dc309f8a,
		__wf_atom_eab484a7
	)
	local __wf_atom_d2b2176d = entity:__wf_atom_d2b2176d()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	local __wf_atom_3a61ed37 = gGameData:GetInventory():__wf_atom_3a61ed37()
	__wf_atom_eab484a7:__wf_atom_6c552f4c(4, entity)
	__wf_atom_eab484a7:AssignAvatar(entity)
	entity:__wf_atom_51075230(__wf_atom_dc309f8a)
	__wf_atom_e55d02aa:SetCustomization(__wf_atom_3a61ed37)
	__wf_atom_d2b2176d:__wf_atom_da1b89a8()
	__wf_atom_d2b2176d:Update(0)
	entity:GiveItem(Resource("/SF/Weapons/Melee/TwoHand/DendritAraGreatSword/DendritAraGreatSwordMeleeWeapon"), false)
	entity:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("InvulSymbol"), 26, 6, 0)
	gGameRules:__wf_atom_5a12097f(false)
	entity:CameraControl():SpawnWeatherEffect(rainFxType)
end

function EndCombatTutorial()
	Sleep(3)
	_T.CombatTutorialEnded = true
	Sleep(1)
	gGameRules:__wf_atom_5a12097f(true)
	module2.RegisterDisableEnemyLootDrops(false)
	module3.RegisterPreventNighfoldUsage(false)
	module4.RegisterHideHudSelective(false)
	cleanupForwarder:FirePort("TriggerPort")
	module.PlaySound(transitionSound)
	module.PlaySound(endCombatMusicStinger)
	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
	__wf_atom_eab484a7:__wf_atom_50a7d83e():Destroy()

	if _T.CombatTutorialStartedFromNightFold then
		module3.DisableAllSkiesButTagged("NightFoldDynSky")
	else
		module3.DisableAllSkiesButTagged("DefaultMainSky")
	end

	_T.CombatTutorialStartedFromNightFold = nil
	__wf_atom_eab484a7:__wf_atom_50a7d83e():CameraControl():SpawnWeatherEffect(nil)
end