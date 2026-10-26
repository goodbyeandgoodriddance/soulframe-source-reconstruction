local _ = {
	{
		label = "Misc",
		tags = { Symbol("SproutCaveLocation"), Symbol("WishingWellLocation"), Symbol("AboveWorldViewTest") }
	},
	{
		label = "Hub",
		tags = { Symbol("SilentRoseEntrance"), Symbol("AlcasChildrenEntrance"), Symbol("KithOfKingsEntrance") }
	},
	{
		label = "Overworld Ancestors Locations",
		tags = { Symbol("AwakenTuvalkane"), Symbol("AwakenVerminia") }
	}
}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.SparrowLib")
require("SF.Scripts.Prototypes.FastTravel")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Util.AncestorImgui")
local module5 = require("SF.Scripts.Util.PetsImgui")
local module6 = require("Lotus.Interface.LotusUtilities")
require("SF.Scripts.Libs.EncounterLib")
require("Lotus.Interface.CodexUtilities")
local module7 = require("EE.Interface.Utilities")
require("SF.Scripts.Libs.TaleLib")
require("SF.Scripts.Libs.ObjectiveHudLib")
local module8 = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module9 = require("SF.Scripts.Libs.FishingLib")
WeakResource("/SF/Types/Game/Encounters/Locations/DungeonEntranceHintUndercity")
Symbol("CollectorTimer")
local v = WeakResource("/Lotus/Types/Game/LotusWarframeCustomization")
local _ = {
	GENERATED = 0,
	ACTIVEHIDDEN = 1,
	ACCEPTED = 2,
	INPROGRESS = 3,
	COMPLETED = 4,
	ABANDONED = 5
}
local _ = { "GENERATED", "ACTIVEHIDDEN", "ACCEPTED", "INPROGRESS", "COMPLETED", "ABANDONED" }
local questController = nil

local function fn(_)
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	if __wf_atom_7e8ad928(questController) then
		questController = gGameRules:GetQuestController()
	end

	if __wf_atom_7e8ad928(questController) then
		return
	end

	local v2 = not gRegion:IsMaster()
	local allAcceptedQuests = module3.GetAllAcceptedQuests()
	local v3

	if v2 then
		local _ = { "Accepted Quests", "Client Personal Accepted Quests" }
		v3 = { allAcceptedQuests, (module3.GetAllPersonalAcceptedQuests()) }
	else
		local _ = { "Accepted Quests" }
		v3 = { allAcceptedQuests }
	end

	module.RemoveDuplicatesFromTable(v3)
	__wf_atom_48bcafdc()
	return false
end

local function fn2(_)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	__wf_atom_48bcafdc()
	return false
end

local function fn3(_)
	__wf_atom_48bcafdc()
	return false
end

local function fn4(_)
	__wf_atom_48bcafdc()
	return false
end

local function fn5(_)
	if __wf_atom_7e8ad928(_T.CinematicMenuSelection) then
		_T.CinematicMenuSelection = 1
	end

	if __wf_atom_7e8ad928(_T.CinematicMenuItems) then
		_T.CinematicMenuItems = gRegion:FindAll(__wf_atom_dfba676e)
	end

	__wf_atom_48bcafdc()
	return false
end

local function fn6(_)
	__wf_atom_48bcafdc()
	return false
end

WeakResource("/SF/Types/PickUps/LootContainers/Actions/LootChestBaseAction")
WeakResource("/SF/Types/PickUps/LootContainers/Actions/WeaponRackActionBase")
local v2 = nil
local v3 = nil
String("               ")

local function fn7(_)
	module.WaitForLevel()

	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	if __wf_atom_7e8ad928(_G.resetChestDebug) then
		_G.resetChestDebug = false
	end

	if __wf_atom_7e8ad928(v2) and not module.IsInOverworld() then
		v2 = gRegion:__wf_atom_0a6a5887(Symbol("LootChestManager"))

		if not __wf_atom_7e8ad928(v2) then
			v3 = v2:__wf_atom_e919fb8e()
		end
	end

	__wf_atom_48bcafdc()
	return false
end

local kind = nil
local v4 = false

local function fn8()
	v4 = false
end

local function fn9()
	v4 = true
	gGameData:SyncInventoryFromDB(fn8)
end

local function fn10(_)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) then
		return
	end

	local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()

	if __wf_atom_7e8ad928(__wf_atom_eab484a7) then
		return
	end

	local playerAvatar = __wf_atom_eab484a7:GetPlayerAvatar(0)

	if __wf_atom_7e8ad928(playerAvatar) then
		return
	end

	local __wf_atom_d2b2176d = playerAvatar:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928((__wf_atom_d2b2176d:__wf_atom_e55d02aa())) then
		return
	end

	local inventory = gGameData:GetInventory()
	gGameData:__wf_atom_a4299765()
	local _ = inventory:__wf_atom_c132f79b(0, (inventory:__wf_atom_d25917b6(0)))
	local __wf_atom_964056fd = gGameRules:__wf_atom_964056fd()
	local function fn11(data)
		local v5 = 4288
		local v6

		if data.Type == kind then
			v5 = bit32.bor(v5, 1)
			v6 = data
		end

		if #data.Children == 0 then
			v5 = bit32.bor(v5, 256)
		end

		local name = data.Name

		if data.LocName and data.LocName ~= name then
			name = data.LocName .. " - " .. name
		end

		if __wf_atom_c4e4efbb(name, v5) then
			if __wf_atom_cc1619d2(0) then
				kind = data.Type
				v6 = data

				for i = 1, #data.Children do
					fn11(data.Children[i])
				end
			else
				for i = 1, #data.Children do
					v6 = fn11(data.Children[i]) or v6
				end
			end

			__wf_atom_c7d85e6b()
		elseif __wf_atom_cc1619d2(0) then
			return data
		end

		return v6
	end

	local function fn12(data)
		local v5 = ""
		local __wf_atom_232fd31d = __wf_atom_964056fd:__wf_atom_232fd31d(data.mItemType)

		if __wf_atom_7e8ad928(__wf_atom_232fd31d) then
			if __wf_atom_7e8ad928(data.mItemType) then
				return v5
			end

			return (data.mItemType:GetName())
		else
			v5 = Localize(__wf_atom_232fd31d:__wf_atom_014a76a2():c_str(), nil) .. " - " .. data.mItemType:GetName()

			if data.mFavorite then
				v5 ..= " (favorite)"
			end

			if data.mIsNew then
				v5 ..= " (new)"
			end

			if data.mItemId then
				return v5 .. " (" .. data.mItemId.mId .. ")"
			end

			return v5
		end
	end

	local _ = { "None", "Worn", "Military", "Officer", "Noble", "Masterwork", "Legendary" }
	__wf_atom_48bcafdc()
	return false
end

function OnSaveLoadOutComplete(_, _)
	module6.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	module6.RequestLoadOutBuild(gRegion:__wf_atom_eab484a7())
end

function OnUpdateSessionSettings() end

function OnQuestCleared(_, _) end

Resource("/Lotus/Types/Lore/PrimaryCodexManifest")
local _ = { Color(13684944), Color(14671871), Color(16764784), Color(7340031) }

local function fn11(_)
	__wf_atom_48bcafdc()
	return false
end

local v5 = Symbol("WSP11.5_FishingAction")
local v6 = nil
local v7 = WeakResource("/SF/Types/Gameplay/Fishing/FishControlHelper")
local v8 = WeakResource("/SF/Types/Gameplay/Fishing/Manifests/MidrathFishManifest")

local function fn12()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local nearestTagged = gRegion:FindNearestTagged(v5, __wf_atom_c4f78a8f:GetPosition())

		if not __wf_atom_7e8ad928(nearestTagged) then
			__wf_atom_c4f78a8f:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
		end
	end
end

function TCFishingPlayCinAfter()
	while not _T.WarsongFishingCompleted do
		Sleep(0)
	end

	Sleep(2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("WarsongQuest-P11.5-Scene14"))

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		__wf_atom_0a6a5887:FirePort("StartPlaying")
	end

	_T.WarsongFishing = false
	_T.WarsongFishingCompleted = false
end

function FishingMenu(_) end

function ToggleQuestMenu(p)
	return fn(p)
end

function ToggleSparrowMenu(_)
	return module2.SparrowImGui()
end

function ToggleEncountersMenu(p)
	return (fn4(p))
end

function ToggleTeleportMenu(p)
	return (fn3(p))
end

function ToggleFastTravelMenu(p)
	return fn2(p)
end

function ToggleAncestorsMenu(p)
	return module4.AncestorManager(p)
end

function TogglePetsMenu(p)
	return module5.PetsManager(p)
end

function ToggleCinematicsMenu(p)
	return (fn5(p))
end

function TogglePlayerMenu(p)
	return fn10(p)
end

function ToggleTimeMenu(p)
	return (fn6(p))
end

function ToggleCodexMenu(p)
	return (fn11(p))
end

function ToggleFishingMenu(p)
	return FishingMenu(p)
end

function ToggleResourcesAndLootMenu(p)
	return fn7(p)
end

function OpenFlashMovie(_)
	local movie2 = __wf_atom_8e4fda44:FindMovie(movie)

	if __wf_atom_7e8ad928(movie2) then
		__wf_atom_8e4fda44:__wf_atom_8b74c30b(movie)
	else
		movie2:Close()
	end
end

function RunImGui(_) end

function RunScriptTrigger(_) end

local function fn13(object)
	if not module8.GetLocalPlayerAncestorOfType(object) then
		return EMPTY_SYMBOL
	end

	local v9 = Resource(object)
	local ancestorRank = module8.GetAncestorRank(object)
	local __wf_atom_d5b255f8 = v9:__wf_atom_d5b255f8()

	if
		ancestorRank < __wf_atom_d5b255f8 - 1
		or ancestorRank == __wf_atom_d5b255f8 - 1 and not module8.CheckForPendingRankUp(v9)
	then
		return Symbol(object:__wf_atom_5b41f63b())
	end

	return EMPTY_SYMBOL
end

function OnClaimRecipesResult(p, p2)
	print("OnClaimRecipesResult", p, p2)
end

function SendClaimRequest(list, p)
	if #list > 0 then
		gGameData:__wf_atom_2a79b81d(
			list,
			OnClaimRecipesResult,
			p,
			fn13(Resource("/SF/Types/Game/Ancestors/Tuvalkane/TuvalkaneAncestor"))
		)
	end
end

function OnStartRecipeResults(p, p2)
	if p then
		local decoded = cjson.decode(p2)
		local v9 = { MongoId(decoded.RecipeId["$oid"]) }
		SendClaimRequest(v9, false)
	end
end