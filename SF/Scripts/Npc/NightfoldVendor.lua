local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.ConversationLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("SF.Scripts.Libs.TransmissionSet")
local module6 = require("SF.Scripts.Libs.SparrowLib")
local module7 = require("Lotus.Scripts.Libs.StoryLib")
local v = {}
local v2 = nil
local v3 = nil
local v4 = true
local v5 = nil
local v6 = Resource("/SF/Types/Input/BlockMovementInputFilter")
local v7 = 0
local v8 = nil
local questController = nil
local v9 = nil
local v10 = nil
local v11 = nil

local function fn(characterLore, object, mRank)
	if not __wf_atom_7e8ad928(characterLore) then
		if not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
			return
		end

		if not __wf_atom_7e8ad928(object) then
			local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

			if
				not __wf_atom_7e8ad928(__wf_atom_d2b2176d)
				and __wf_atom_d2b2176d:__wf_atom_96a19f31(characterLore) < mRank
			then
				module2.GiveLoreFragment(object, characterLore)
			end
		end
	end
end

local function fn2(p, p2, p3, p4)
	if rankDebuggerEnabled and not __wf_atom_7e8ad928(p4) then
		v8 = p4
	else
		v8 = module.GetAncestorRank(vendorAncestorRes, false) + 1
	end

	local rankUpDiorama = rankUpDioramas[v8]

	if not __wf_atom_7e8ad928(rankUpDiorama) then
		module5.CloseTransmissions()

		if not __wf_atom_7e8ad928(v2) then
			v2:Execute("FadeOutFoundryOnRankUp", "")
			Sleep(2.9)
		end

		module7.PlayCinematic(rankUpDiorama, nil, false, false)

		if not __wf_atom_7e8ad928(v2) then
			v2:Execute("FadeInMovieOnRankUpFinished", "")
		end
	end

	if not __wf_atom_7e8ad928(p) then
		module4.CompleteTaskWithTag(p, p2)
	end

	local v12 = v8 - 1

	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	gGameData:RankUpAncestor(v3.mType, "OnAncestorCallback")
	_T.Ancestor_PendingRankUp = false
	fn(characterLore, p3, v3.mRank)

	if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
		local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)
		local v13 = ancestorRank - v12 == 1

		if ancestorRank < #v then
			if v13 then
				local v14 = ancestorRank + 1
				module4.StartQuest(v[v14])
			else
				print("Can't start Rank " .. v12 + 1 .. " quest. RankUpAncestor must have failed.")
			end
		end
	end
end

function RankingDebugger()
	__wf_atom_489de21b("TestAncesotrRankUp")

	if __wf_atom_80afb308("TestRankUpDiorama") then
		fn2(nil, nil, v5, v7)
	end

	__wf_atom_78aeed31()

	if __wf_atom_80afb308("-") then
		v7 -= 1
	end

	__wf_atom_78aeed31()
	__wf_atom_05a856ad("Set Rank: " .. v7)
	__wf_atom_78aeed31()

	if __wf_atom_80afb308("+") then
		v7 += 1
	end

	__wf_atom_48bcafdc()
end

function PlayerMenuIdleStart()
	if __wf_atom_7e8ad928(v5) then
		return
	end

	_T.playerVendorIdleWait = true
	local __wf_atom_9b5dcd3b = v5:__wf_atom_9b5dcd3b(playerIdleAnims[1], false, 4, 1, true)
	Sleep(__wf_atom_9b5dcd3b)
	v5:__wf_atom_9b5dcd3b(playerIdleAnims[2], false, 4, 2, true)
	_T.playerVendorIdleWait = false
end

function PlayerIdleAnimEnd()
	if __wf_atom_7e8ad928(v5) then
		return
	end

	v5:__wf_atom_9b5dcd3b(playerIdleAnims[3], true, 4, 1, true)
end

function SlidePlayer()
	local v12 = 3
	local v13 = nil

	for _, v14 in pairs(playerDialougePosition) do
		local __wf_atom_8a6b8fc3 = v5:__wf_atom_8a6b8fc3(v14)

		if not (__wf_atom_8a6b8fc3 < v12) then
			continue
		end

		v13 = v14
		v12 = __wf_atom_8a6b8fc3
	end

	module3.SlidePlayer(v5, v13, 0.5)
end

function InitalizeAncestorVendor(object, object2)
	if __wf_atom_7e8ad928(gGameData) then
		print("Game Data not found, are you logged in?")
		return
	end

	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_3aa103d3() then
		return
	end

	v5 = object2
	object:Disable()
	_T.VendorTransmissionSet = vendorTransmissionSet
	_T.VendorDialougCamera = dialogCamerSpotInstance
	local cameraControl = object2:CameraControl()

	if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
		cameraControl:__wf_atom_fd14c463(0)
		cameraControl:SetCameraSpot(dialogCamerSpotInstance, cameraTransitionIn)
		cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end

	if useSlide and #playerDialougePosition > 0 then
		object2:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
	end

	if #playerIdleAnims > 0 then
		object2:__wf_atom_8a035cd5(Symbol("PlayerMenuIdleStart"), false)
	end

	v3 = module.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)
	v = module.GetAllAncestorRankTasks(vendorAncestorRes)
	local v12, v13, v14 = module.CheckForPendingRankUp(vendorAncestorRes, true)

	if __wf_atom_7e8ad928(v3) or v3.mRank ~= -1 then
		if v12 then
			local v15 = "Rank" .. module.GetAncestorRank(vendorAncestorRes, true) .. "Greetings"
			module.PlayAncestorTransmission(
				vendorTransmissionSet,
				Symbol(v15),
				ancestorHubNPC,
				ancestorGreetingAnimTag,
				nil,
				false,
				false
			)
			fn2(v13, v14, object2)
		else
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)
			object2:__wf_atom_aeb02c14(v6)
			local v15 = "Rank" .. ancestorRank .. "Greetings"
			module.PlayAncestorTransmission(
				vendorTransmissionSet,
				Symbol(v15),
				ancestorHubNPC,
				ancestorGreetingAnimTag,
				nil,
				false,
				false
			)

			if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
				local v16 = ancestorRank + 1

				if v16 <= #v then
					local v17 = v[v16]

					if not (module4.QuestIsActive(v17) or module4.HasCompletedQuest(v17)) then
						module4.StartQuest(v17)
					end
				end
			end

			if not __wf_atom_7e8ad928(object2) then
				object2:__wf_atom_cf966a74(v6)
			end
		end
	else
		object2:__wf_atom_aeb02c14(v6)
		module.PlayAncestorTransmission(
			vendorTransmissionSet,
			vendorQuestTransmissionTag,
			ancestorHubNPC,
			Symbol("FIRST_ENCOUNTER_GREETING"),
			nil,
			false,
			true
		)
		local mRank = v3.mRank

		while __wf_atom_7e8ad928(gGameData) do
			Sleep(0.1)
		end

		gGameData:RankUpAncestor(v3.mType, "OnAncestorCallback")

		if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)

			if ancestorRank < #v then
				if ancestorRank - mRank == 1 then
					local v15 = ancestorRank + 1
					module4.StartQuest(v[v15])
				else
					print("Can't start Rank " .. mRank + 1 .. " quest. RankUpAncestor must have failed.")
				end
			end
		end

		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SparrowPerchPoint"), object:GetPosition(), 0, 10)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			module6.RemoveSparrowDestination(__wf_atom_f738b4af)
		end

		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_cf966a74(v6)
		end
	end

	if __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(vendorFunctionMenuMovie) then
		v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(vendorFunctionMenuMovie)

		while not __wf_atom_7e8ad928(v2) do
			if _T.Ancestor_PendingRankUp == true then
				local v15, v16, v17 = module.CheckForPendingRankUp(vendorAncestorRes, true)

				if v15 then
					fn2(v16, v17, object2)
				end
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(playerIdleAnims) then
			while _T.playerVendorIdleWait do
				Sleep(0)
			end

			if not __wf_atom_7e8ad928(object2) then
				object2:__wf_atom_8a035cd5(Symbol("PlayerIdleAnimEnd"), false)
			end
		end

		if not (__wf_atom_7e8ad928(dialogCamerSpotInstance) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) then
			if not __wf_atom_7e8ad928(object2) then
				object2:__wf_atom_51075230((dialogCamerSpotInstance:__wf_atom_2f2bada0()))
			end

			if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
				local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
				cameraControl:__wf_atom_fd14c463(0)
				cameraControl:SetCameraSpot(nil, cameraTransitionOut)
				cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
			end

			object:Enable()
		end
	else
		dialogCamerSpotInstance:Deactivate()
		Sleep(20)

		if not __wf_atom_7e8ad928(object) then
			object:Enable()
		end
	end
end

function OnAncestorCallback()
	v4 = true
end

function SimpleTalk(object, _)
	object:Disable()
	v3 = module.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)
	v = module.GetAllAncestorRankTasks(vendorAncestorRes)
	local _, _, _ = module.CheckForPendingRankUp(vendorAncestorRes, true)

	if __wf_atom_7e8ad928(v3) or v3.mRank ~= -1 then
		module.PlayLocalTransmission(
			vendorTransmissionSet,
			Symbol("NightfoldDialouge"),
			ancestorHubNPC,
			nil,
			nil,
			false
		)
		Sleep(20)
		object:Enable()
	else
		module5.PlayLocalTransmission(
			vendorTransmissionSet,
			vendorQuestTransmissionTag,
			ancestorHubNPC,
			nil,
			nil,
			false
		)
		local mRank = v3.mRank

		while __wf_atom_7e8ad928(gGameData) do
			Sleep(0.1)
		end

		gGameData:RankUpAncestor(v3.mType, "OnAncestorCallback")

		if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)

			if ancestorRank < #v then
				if ancestorRank - mRank == 1 then
					local v12 = ancestorRank + 1
					module4.StartQuest(v[v12])
				else
					print("Can't start Rank " .. mRank + 1 .. " quest. RankUpAncestor must have failed.")
				end
			end
		end
	end
end

function SimpleVendorScreen(object, object2)
	object:Disable()
	_T.VendorTransmissionSet = vendorTransmissionSet
	_T.VendorDialougCamera = dialogCamerSpotInstance
	local cameraControl = object2:CameraControl()

	if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
		cameraControl:__wf_atom_fd14c463(0)
		cameraControl:SetCameraSpot(dialogCamerSpotInstance, cameraTransitionIn)
		cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end

	if __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(vendorFunctionMenuMovie) then
		v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(vendorFunctionMenuMovie)

		while not __wf_atom_7e8ad928(v2) do
			Sleep(0)
		end

		if not (__wf_atom_7e8ad928(dialogCamerSpotInstance) or __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2)) then
			if not __wf_atom_7e8ad928(object2) then
				object2:__wf_atom_51075230((dialogCamerSpotInstance:__wf_atom_2f2bada0()))
			end

			if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
				local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
				cameraControl:__wf_atom_fd14c463(0)
				cameraControl:SetCameraSpot(nil, cameraTransitionOut)
				cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
			end

			object:Enable()
		end
	else
		dialogCamerSpotInstance:Deactivate()
		Sleep(20)

		if not __wf_atom_7e8ad928(object) then
			object:Enable()
		end
	end
end

function FilterAvialableTechQuests()
	local result = {}
	local result2 = {}

	for _, v12 in pairs(techTreeQuest) do
		if module4.CanQuestBeStarted(v12) then
			table.insert(result, v12)
		elseif module4.QuestIsActive(v12) and module4.TaggedTaskIsActive(WeakResource(v12), ANCESTOR_TURNIN_SYM) then
			table.insert(result2, v12)
		end
	end

	return result, result2
end

local function fn3(list)
	local mRank = v3.mRank

	if next(list) ~= nil then
		local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)

		if ancestorRank < #list then
			if ancestorRank - mRank == 1 then
				local v12 = ancestorRank + 1
				module4.StartQuest(list[v12])
			else
				print("Can't start Rank " .. mRank + 1 .. " quest. RankUpAncestor must have failed.")
			end
		end
	end
end

function DitherOutAvatar(object)
	local v12 = 0

	while v12 < 1 do
		v12 = __wf_atom_421b01aa(v12 + __wf_atom_084b3e93(), 0, 1)
		object:__wf_atom_68f2c268(v12)
		Sleep(0)
	end
end

function DitherInAvatar(object)
	object:__wf_atom_68f2c268(1)
	local v12 = 1

	while not __wf_atom_7e8ad928(object) and v12 > 0 do
		v12 = __wf_atom_421b01aa(v12 - __wf_atom_084b3e93() / 1.5, 0, 1)
		object:__wf_atom_68f2c268(__wf_atom_24a82b69(v12))
		Sleep(0)
	end
end

local function fn4()
	if __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(vendorFunctionMenuMovie) then
		v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(vendorFunctionMenuMovie)

		if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(_T.SetupAncestorData) then
			LogBug("Failed to create ancestor quest movie")
		else
			_T.SetupAncestorData(
				vendorAncestorRes,
				ANCESTOR_TURNIN_SYM,
				techTreeQuest,
				techChapterBreakQuests,
				techChapterTitles,
				ANCESTOR_SYM,
				ancestorHubNPC
			)
		end
	end
end

local function fn5(mConvoMovie, vendorAncestorRes)
	local v12 = {
		mMovie = mConvoMovie,
		mLabel = Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), {}),
		mOverwriteCurrencies = true,
		mMinWidth = 525,
		mLevel = module.GetAncestorRank(vendorAncestorRes) + 1
	}
	local v13 = not (v12.mLevel > 1) and 0 or vendorAncestorRes:__wf_atom_071f014c(v12.mLevel - 1)
	local v14 = vendorAncestorRes:__wf_atom_071f014c(v12.mLevel) - v13
	local v15 = module.GetAncestorXP(vendorAncestorRes) - v13
	v12.mRankProgress = __wf_atom_421b01aa(v15 / v14, 0, 1) * 100

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v12)
	end
end

function techTreeAncestor(object, object2)
	if not __wf_atom_7e8ad928(gGameRules) and gGameRules:__wf_atom_3aa103d3() then
		return
	end

	v5 = object2
	object:Disable()
	_T.VendorTransmissionSet = vendorTransmissionSet
	_T.ActiveVendorCamera = vendorCamSpotInstances[1]
	_T.VendorCameras = vendorCamSpotInstances
	local cameraControl = object2:CameraControl()

	if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
		cameraControl:__wf_atom_fd14c463(0)
		cameraControl:SetCameraSpot(_T.ActiveVendorCamera, cameraTransitionIn)
		cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
	end

	if hideAvatar then
		object2:__wf_atom_8a035cd5(Symbol("DitherOutAvatar"), false)
	end

	if #playerIdleAnims > 0 then
		object2:__wf_atom_8a035cd5(Symbol("PlayerMenuIdleStart"), false)
	end

	v3 = module.GetLocalPlayerAncestorOfType(vendorAncestorRes, true)
	v = module.GetAllAncestorRankTasks(vendorAncestorRes)
	local v12 = module.CheckForPendingRankUpFromXP(vendorAncestorRes)
	v9 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
	v9:Start()
	fn5(v9.mConvoMovie, vendorAncestorRes)

	if __wf_atom_7e8ad928(v3) or v3.mRank ~= -1 then
		if v12 then
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)
			gGameData:RankUpAncestor(v3.mType, "OnAncestorCallback")
			local v13 = "Rank" .. ancestorRank .. "Greetings"
			module.PlayAncestorTransmission(
				vendorTransmissionSet,
				Symbol(v13),
				ancestorHubNPC,
				ancestorGreetingAnimTag,
				nil,
				false,
				false
			)
			fn3(v)
		else
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)
			object2:__wf_atom_aeb02c14(v6)
			local v13 = "Rank" .. ancestorRank .. "Greetings"
			module.PlayAncestorTransmission(
				vendorTransmissionSet,
				Symbol(v13),
				ancestorHubNPC,
				ancestorGreetingAnimTag,
				nil,
				false,
				false
			)

			if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
				local v14 = ancestorRank + 1

				if v14 <= #v then
					local v15 = v[v14]

					if not (module4.QuestIsActive(v15) or module4.HasCompletedQuest(v15)) then
						module4.StartQuest(v15)
					end
				end
			end
		end
	else
		object2:__wf_atom_aeb02c14(v6)
		module5.PlayLocalTransmission(
			vendorTransmissionSet,
			vendorQuestTransmissionTag,
			gRegion:__wf_atom_c4f78a8f(),
			true
		)
		local mRank = v3.mRank

		while __wf_atom_7e8ad928(gGameData) do
			Sleep(0.1)
		end

		gGameData:RankUpAncestor(v3.mType, "OnAncestorCallback")

		if v3.mRank ~= vendorAncestorRes:__wf_atom_d5b255f8() and next(v) ~= nil then
			local ancestorRank = module.GetAncestorRank(vendorAncestorRes, true)

			if ancestorRank < #v then
				if ancestorRank - mRank == 1 then
					local v13 = ancestorRank + 1
					module4.StartQuest(v[v13])
				else
					print("Can't start Rank " .. mRank + 1 .. " quest. RankUpAncestor must have failed.")
				end
			end
		end

		local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SparrowPerchPoint"), object:GetPosition(), 0, 10)

		if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
			module6.RemoveSparrowDestination(__wf_atom_f738b4af)
		end

		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_cf966a74(v6)
		end
	end

	local journal = Localize("/SF/Language/Menu/Menu_Open_Codex", nil)
	local __wf_atom_10192cfa, v13 = gGameData:__wf_atom_10192cfa(Symbol("CodexTitleChoice"))

	if __wf_atom_10192cfa then
		journal = Localize(v13, nil)
	end

	local text = Localize("/SF/Language/Characters/OrlickConvo_InfoMenu", { JOURNAL = journal })
	local v14 = { Text = "/SF/Language/Characters/OrlickConvo_QuestMenu" }
	v14.Text = Localize(v14.Text, false)
	v14.Tag = "QuestMenu"
	local v15 = "QuestMenu"
	local v16 = nil

	function v14.Callback()
		v10 = v15
		v11 = v16
	end

	local v17 = { Text = text }
	v17.Text = Localize(v17.Text, false)
	v17.Tag = "InfoMenu"
	local v18 = "InfoMenu"
	local v19 = nil

	function v17.Callback()
		v10 = v18
		v11 = v19
	end

	local v20 = { Text = "/SF/Language/Characters/OrlickConvo_Exit" }
	v20.Text = Localize(v20.Text, false)
	v20.Tag = "Exit"
	local v21 = "Exit"
	local v22 = nil

	function v20.Callback()
		v10 = v21
		v11 = v22
	end

	v9:SetChoices({ v14, v17, v20 })
	v9:SetBackChoice("Exit")

	while v9:Update() do
		if not __wf_atom_7e8ad928(v10) then
			if v10 == "QuestMenu" then
				fn4()
				v9:Close(true)

				while not __wf_atom_7e8ad928(v2) do
					if _T.OrlickIMGUI then
						AncestorTechTreeIMGUI()
					end

					Sleep(0)
				end

				v9 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
				v9:UseCursorSnapping(false)
				v9:Start()
				v9:SetChoices({ v14, v17, v20 })
				v9:SetBackChoice("Exit")
				fn5(v9.mConvoMovie, vendorAncestorRes)
			elseif v10 == "InfoMenu" then
				if __wf_atom_7e8ad928(v2) and not __wf_atom_7e8ad928(infoFunctionMenuMovie) then
					_T.BlockPauseMenu = true
					v2 = __wf_atom_8e4fda44:__wf_atom_8b74c30b(infoFunctionMenuMovie)

					if __wf_atom_7e8ad928(v2) then
						LogBug("Failed to create codex movie")
					end
				end

				v9:Close(true)

				while not __wf_atom_7e8ad928(v2) or _T.TopMenuOpen do
					Sleep(0)
				end

				_T.BlockPauseMenu = nil

				if _T.ExitConversation == nil or not _T.ExitConversation then
					v9 = module3.CreateConversation(Localize(vendorAncestorRes:__wf_atom_014a76a2():c_str(), false))
					v9:UseCursorSnapping(false)
					v9:Start()
					v9:SetChoices({ v14, v17, v20 })
					v9:SetBackChoice("Exit")
					fn5(v9.mConvoMovie, vendorAncestorRes)
					_T.ExitConversation = nil
				end
			elseif v10 == "Exit" then
				v9:Close(true)
				break
			end

			v10 = nil
		end

		Sleep(0)
	end

	_T.OrlickIMGUI = nil

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(v9.mConvoMovie)
	end

	if not (__wf_atom_7e8ad928(_T.ActiveVendorCamera) or __wf_atom_7e8ad928(object2)) then
		if not __wf_atom_7e8ad928(object2) then
			object2:__wf_atom_51075230((_T.ActiveVendorCamera:__wf_atom_2f2bada0()))
		end

		if not (__wf_atom_7e8ad928(cameraControl) or cameraControl:__wf_atom_c8c5ba0a()) then
			local __wf_atom_1b3db7e0 = cameraControl:__wf_atom_1b3db7e0()
			cameraControl:__wf_atom_fd14c463(0)
			cameraControl:SetCameraSpot(nil, cameraTransitionOut)
			cameraControl:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
		end
	end

	if hideAvatar then
		object2:__wf_atom_8a035cd5(Symbol("DitherInAvatar"), false)
	end

	object:Enable()

	if not __wf_atom_7e8ad928(object2) then
		object2:__wf_atom_cf966a74(v6)
	end
end

function AncestorTechTreeIMGUI(_)
	if __wf_atom_7e8ad928(gGameRules) then
		return
	end

	if __wf_atom_7e8ad928(questController) then
		questController = gGameRules:GetQuestController()
	end

	if __wf_atom_7e8ad928(questController) then
		return
	end

	if __wf_atom_7e8ad928(nil) or __wf_atom_7e8ad928(nil) then
		local _, _ = FilterAvialableTechQuests()
	end

	__wf_atom_48bcafdc()
end