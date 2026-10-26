module(..., package.seeall)
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusNetworkUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local v = nil
local v2 = nil
local v3 = nil
local gameRules = WeakResource("/SF/Types/GameRules/SFPhotoBoothGameRules")

local function fn()
	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_2564b701) then
		local __wf_atom_5b41f63b = gRegion:__wf_atom_22941262():__wf_atom_5b41f63b()
		local v4 = string.find(__wf_atom_5b41f63b, ".level")

		if v4 == nil then
			v4 = string.find(__wf_atom_5b41f63b, ".lp")
		end

		if v4 ~= nil then
			__wf_atom_5b41f63b = string.sub(__wf_atom_5b41f63b, 1, v4 - 1)
		end

		__wf_atom_21342f4a:__wf_atom_0d1ea252(Symbol("SANDBOX_TIME"), __wf_atom_5b41f63b)
		__wf_atom_21342f4a:Upload(Symbol("Photobooth"))
	end

	if _T.gActiveMatchMakingMode ~= _T.MATCHMAKING_OFFLINE_GAMEMODE then
		local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

		if __wf_atom_7e8ad928(__wf_atom_15811761) then
			module2.HostSquadSession("OnLobbyReady", module3.BuildGameModeIdForPhotobooth(), 8)
		else
			print("Updating Captura session with game mode id")
			local settings = __wf_atom_15811761:GetSettings()
			settings.gameModeId = module3.BuildGameModeIdForPhotobooth()
			settings.maxPlayers = 8
			gMatchingService:__wf_atom_c8d901d4(settings, "OnUpdateSessionSettings")
		end
	end

	local levelArgs = Engine.OpenLevelArgs()
	levelArgs:SetLevel(_T.photoboothTile)
	levelArgs.hostingMultiplayer = true
	levelArgs.migrateServer = true
	levelArgs.loadFromLobby = true
	levelArgs.gameRules = gameRules
	levelArgs.contextTags = { "info={archwingRequired=1\n}\n" }
	module2.SetContextObjectsFromSquadLoadOuts(levelArgs, false, false)
	Engine.OpenLevel(levelArgs)
end

function LoadPhotoboothTile()
	fn()
end

local function fn2()
	if __wf_atom_7e8ad928(v) or not v:__wf_atom_86399a47() or __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v3) then
		v2:AddTimer(0.25, fn2)
		return
	end

	if _T.LoadoutSaveRequired and not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			__wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_993aebc4("OnSaveLoadOutComplete")
		end
	end

	_T.photoboothTile = v3.TileString

	if gMatchingService:__wf_atom_8b3e33a6() > 1 and not gGameRules:IsA(__wf_atom_469b1d97) then
		gMatchingService:SendSquadMission(cjson.encode({ name = "Photobooth" }))
	else
		fn()
	end
end

function OnSaveLoadOutComplete(_, _)
	module3.OnSaveLoadOutCompleteCommon("OnUpdateSessionSettings")
	local menuSuitAvatar = _T.MenuSuitAvatar

	if not __wf_atom_7e8ad928(menuSuitAvatar) then
		menuSuitAvatar:__wf_atom_d2b2176d():__wf_atom_cac3dd53(false)

		if module3.IsInHub() then
			local v4 = "{\"loadout\":" .. gGameRules:__wf_atom_67d15da1() .. "}"
			gGameRules:SendControlMessage(v4)
			gGameRules:__wf_atom_59e54957(menuSuitAvatar)
		end
	end
end

function OpenPhotoboothTileSelect(object, object2, object3)
	if __wf_atom_7e8ad928(object3) then
		object3 = gGameRules:__wf_atom_964056fd()
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) or __wf_atom_7e8ad928(object3) then
		return
	end

	local menuSuitAvatar = _T.MenuSuitAvatar
	local v4

	if __wf_atom_7e8ad928(menuSuitAvatar) then
		v4 = false
	else
		v4 = menuSuitAvatar:__wf_atom_f63d17c0()
		menuSuitAvatar:__wf_atom_e424c72a(false)
	end

	local v5 = WeakResource("/Lotus/Types/Items/MiscItems/PhotoboothTile")
	local v6 = object:PushChildMovie(_G.UIMovie_ItemBrowsingMovie)
	v6:Execute("SetTitle", object:__wf_atom_8e9ac384("/Lotus/Language/Menu/PhotoboothTileSelectTitle", false))
	v6:Execute("SetRequiredSelections", 1)
	v6:Execute("SetRequiresConfirmation", "false")
	v6:Execute("SetExitCallout", "/Lotus/Language/Menu/PhotoBoothSelection")
	v6:Execute("SetUseCornerForSelected", "false")

	function _T.ValidateTile(list)
		if list == nil or list[1] == nil then
			return false, ""
		end

		if list[1].Locked and list[1].RegularPrice == nil then
			return false, list[1].LockedMsg
		end

		return true
	end

	v6:Execute("SetValidationFunction", "ValidateTile")

	function _T.BrowseDone(list)
		_T.ValidateTile = nil
		_T.BrowseDone = nil
		_T.GetAllTiles = nil
		_T.GetTileSorting = nil

		if not __wf_atom_7e8ad928(menuSuitAvatar) and v4 then
			menuSuitAvatar:__wf_atom_e424c72a(true)
		end

		if list ~= nil and list[1] ~= nil then
			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_9141808b()
			end

			if not __wf_atom_7e8ad928(list[1].Type) then
				if not (gMatchingService:__wf_atom_607c7363() or __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())) then
					module.ShowMessage("/Lotus/Language/Menu/Photobooth_Client_Host_Error")
					return
				end

				v = UISys.__wf_atom_c0dbe47c({ list[1].Type:__wf_atom_5b41f63b() })
				v2 = object2
				v3 = list[1]

				if
					not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_469b1d97)
					or gMatchingService:__wf_atom_8b3e33a6() == 1
				then
					_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
				end

				object2:AddTimer(0.25, fn2)
			end
		end
	end

	v6:Execute("SetCallBack", "BrowseDone")

	function _T.GetTileSorting()
		local v7 = {}
		table.insert(v7, {
			Name = "LOCKED",
			SortId = "LOCKED",
			Attribute = function(p, p2)
				return not (p.Locked or not p2.Locked) or not (p.Locked and not p2.Locked) and p.Name < p2.Name
			end
		})
		return v7, "LOCKED"
	end

	v6:Execute("SetSortByFunction", "GetTileSorting")

	function _T.GetAllTiles()
		local result = {}
		local mItemTypes = {}
		local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()

		if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
			local __wf_atom_c84817dd = __wf_atom_9be88b01:GetInventory():__wf_atom_c84817dd()

			for i = 1, #__wf_atom_c84817dd do
				if __wf_atom_c84817dd[i].mItemType:IsA(v5) then
					table.insert(mItemTypes, __wf_atom_c84817dd[i].mItemType)
				end
			end
		end

		local v7 = tostring(gRegion:__wf_atom_22941262():__wf_atom_5b41f63b())
		local __wf_atom_caa82b8d = object3:__wf_atom_caa82b8d(v5, true)

		for i = 1, #__wf_atom_caa82b8d do
			local storeItem = __wf_atom_caa82b8d[i]

			if __wf_atom_7e8ad928(storeItem) then
				continue
			end

			local item = storeItem:GetItem()
			local alwaysAvailable = storeItem:AlwaysAvailable()

			if not alwaysAvailable then
				for j = 1, #mItemTypes do
					if mItemTypes[j] ~= item then
						continue
					end

					alwaysAvailable = true
					break
				end
			end

			local __wf_atom_ecd05e96 = storeItem:__wf_atom_ecd05e96()
			local v8 = string.find(v7, __wf_atom_ecd05e96:__wf_atom_5b41f63b())
			local v9 = true

			if item:IsA(_G.UITypes_QuestRequiredCapturaTile) then
				item = Resource(item)
				local __wf_atom_7e97ff70 = item:__wf_atom_7e97ff70()

				for _, v10 in ipairs(__wf_atom_7e97ff70) do
					if module3.HasCompletedQuest(v10) then
						continue
					end

					v9 = false
					break
				end
			end

			if
				__wf_atom_7e8ad928(__wf_atom_ecd05e96)
				or v8 ~= nil
				or not (not item:IsA(_G.UITypes_OwnershipRequiredCapturaTile) or alwaysAvailable)
				or not v9
			then
				continue
			end

			local v10 = {
				Type = item,
				StoreItem = storeItem,
				HideOwnedTag = true,
				TileString = __wf_atom_ecd05e96:__wf_atom_5b41f63b(),
				Locked = not alwaysAvailable,
				LockedTag = "/Lotus/Language/Menu/FocusLocked",
				LockedMsg = storeItem:__wf_atom_42794027():c_str()
			}

			if storeItem:__wf_atom_ee4fa4fd() > 0 then
				if alwaysAvailable then
					v10.HidePrice = true
				else
					v10.RegularPrice = storeItem:__wf_atom_ee4fa4fd()
				end
			end

			if v10.Locked then
				v10.Description = v10.LockedMsg
			else
				v10.Description = "/Lotus/Language/CapturaScenes/PhotoboothTileOwnedDesc"
			end

			table.insert(result, v10)
		end

		return result
	end

	v6:Execute("SetElementsFunction", "GetAllTiles")
	return v6
end