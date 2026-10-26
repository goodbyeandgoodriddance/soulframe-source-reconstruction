local v = Symbol("CameraSpot")
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.TransmissionSet")
local module3 = require("SF.Scripts.Libs.ConversationLib")
local module4 = require("SF.Interface.SFUtilities")
local module5 = require("Lotus.Interface.SyndicateUtilities")
local module6 = require("SF.Interface.Libs.UIUtilities")
local module7 = require("SF.Scripts.Libs.QuestLib")
local module8 = require("SF.Scripts.Libs.JobsLib")
local module9 = require("EE.Interface.Utilities")
local module10 = require("Lotus.Interface.LotusUtilities")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = {}
local v9 = false
local v10 = nil
local v11 = false
local v12 = nil
local v13 = nil
local asyncLoader = module6.CreateAsyncLoader()
local flag = false
local v14 = nil

function SlidePlayer()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(playerDialogueWpTag)
	module3.SlidePlayer(v6, __wf_atom_0a6a5887, 0.5)
end

function HidePlayer()
	Sleep(0.5)
	local v15 = 0

	while v15 < 1 and not __wf_atom_7e8ad928(v6) and v9 do
		v15 = __wf_atom_421b01aa(v15 + __wf_atom_084b3e93() * 2, 0, 1)
		local v16 = __wf_atom_24a82b69(v15)
		v6:__wf_atom_68f2c268(v16)
		Sleep(0)
	end
end

function RotateDeoraHead()
	local v15 = Rotation()
	v15.pitch = -15
	v15.heading = 15
	v15.bank = 10
	module3.RotateHead(v7, v15, 0.5)
end

function RotateDeoraHeadJobs()
	local v15 = Rotation()
	module3.RotateHead(v7, v15, 0.5)
end

function ResetDeoraHead()
	local v15 = Rotation()
	module3.RotateHead(v7, v15, 1)
end

function TavernIntro(object)
	if not object:__wf_atom_4417a5d4() then
		return
	end

	introLookAtTrigger:Enable()
end

local function fn()
	if __wf_atom_7e8ad928(syndicate) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	return syndicate:__wf_atom_e0f044e1() == gGameData:__wf_atom_0cbd9965()
end

local function fn2()
	if __wf_atom_7e8ad928(syndicate) or __wf_atom_7e8ad928(gGameData) then
		return false
	end

	local __wf_atom_e0f044e1 = syndicate:__wf_atom_e0f044e1()
	return gGameData:__wf_atom_51dd1b95(__wf_atom_e0f044e1).mInitiated
end

local function fn3()
	local __wf_atom_195979ca = gGameData:__wf_atom_195979ca()

	if __wf_atom_7e8ad928(__wf_atom_195979ca) then
		return nil
	end

	local v15 = MongoDateTime()
	v15.sec = gGameRules:__wf_atom_93691ff2()
	return __wf_atom_195979ca:__wf_atom_8f70d89f(v15)
end

local function fn4()
	return not __wf_atom_7e8ad928(gGameData)
end

local function fn5(p)
	local cooldown = ""

	if not __wf_atom_7e8ad928(gGameData) then
		local v15 = fn3()

		if v15 ~= nil then
			cooldown = module10.SecondsToFormattedTime(mMovie, 604800 - v15, "CompactTwoMax")
		end
	end

	return v2.mConvoMovie:__wf_atom_8e9ac384(dialogLocPrefix .. p, true, { COOLDOWN = cooldown })
end

local function fn6(value)
	if string.sub(value, 1, 1) == "/" then
		local v15 = StringSplit("/", value)
		local _ = v15[#v15]
	else
		value = dialogLocPrefix .. value
	end

	return v2.mConvoMovie:__wf_atom_8e9ac384(value, true)
end

local function fn7(fn8, tag)
	local text = fn8 == nil and "" or fn8(tag)
	local defaultMenuChoice = v5[tag]

	if defaultMenuChoice == nil then
		local v15 = StringSplit("_", tag)
		local v16 = v15[#v15]
		defaultMenuChoice = v5[v16]

		if defaultMenuChoice == nil then
			defaultMenuChoice = v5.DefaultMenuChoice
		else
			tag = v16
		end
	end

	local function fn9()
		module2.CloseTransmissions()
		defaultMenuChoice(tag)
	end

	return {
		Text = text,
		Tag = tag,
		Callback = function()
			v3 = fn9
		end
	}
end

local function fn8()
	if __wf_atom_7e8ad928(v2) or __wf_atom_7e8ad928(v2.mConvoMovie) then
		return
	end

	local v15 = {}

	if dialogIncludesSyndicateStanding then
		if fn() then
			table.insert(v15, fn7(fn6, "SyndicateStanding"))
		elseif fn4() then
			table.insert(v15, fn7(fn6, "SyndicateSwap"))
		else
			table.insert(v15, fn7(fn5, "SyndicateSwapImpossible"))
		end
	end

	for _, v16 in dialogChoices do
		table.insert(v15, fn7(fn6, v16))
	end

	if dialogIncludesJobSelection then
		table.insert(v15, fn7(fn6, "JobSelection"))
	end

	table.insert(v15, fn7(fn6, "Goodbye"))
	v2:SetChoices(v15)
end

local function fn9()
	module4.RegisterHideSubtitles(true)
	module4.DissolveIn(v2.mConvoMovie)

	if v13 ~= nil then
		v13()
		v13 = nil
	end

	v10 = nil
end

function ChildMovieLoaded(p)
	v10 = p
	v11 = false
	v2:SetSubConversation(p, true, nil, fn9)

	if v12 ~= nil then
		v12()
		v12 = nil
	end
end

local function fn10(p, p2, p3)
	v11 = true
	module4.DissolveOut(v2.mConvoMovie, function()
		module4.RegisterHideSubtitles(false)
	end)
	v2.mConvoMovie:__wf_atom_f6811c70(p, "ChildMovieLoaded")
	v12 = p2
	v13 = p3 or fn8
end

local function fn11()
	v10:__wf_atom_8fcdea81(v6)
	module4.DissolveIn(v10)
end

local function fn12()
	module3.SetCamSpot(v4, nil, v6:CameraControl())
	v6:__wf_atom_8a035cd5(Symbol("RotateDeoraHead"), false)
	fn8()
end

function OnDoSyndicateSacrificeResult(_)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	flag = false
end

function Initiate()
	if not __wf_atom_7e8ad928(gGameData) then
		flag = true
		gGameData:__wf_atom_1e0d81b6(syndicate:__wf_atom_e0f044e1(), 0, "OnDoSyndicateSacrificeResult")
		_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
			"2",
			"/SF/Language/Syndicates/InitiationWaitingMessage"
		})
	end
end

local function fn13(p)
	module2.PlayDialogMenuTransmission(transmissionSet, Symbol(p), v6, false, transmissionRange)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(jobCamSpotTag)
	module3.SetCamSpot(__wf_atom_0a6a5887, nil, v6:CameraControl())
	v6:__wf_atom_8a035cd5(Symbol("RotateDeoraHeadJobs"), false)
	_T.AvailableJobs = {}

	if gMatchingService:__wf_atom_1b24a1bb() then
		local v15 = __wf_atom_04d7eaaa()
		local __wf_atom_774cdec4 = Engine.__wf_atom_774cdec4(10800)
		__wf_atom_01bfe5c4(__wf_atom_774cdec4)
		local __wf_atom_1603253f = jobManifest:__wf_atom_1603253f()
		local v16 = {}

		for _, v17 in ipairs(__wf_atom_1603253f) do
			table.insert(v16, v17)
		end

		local seededShuffleTable = module9.SeededShuffleTable(v16)
		local mJobs = {}

		for _, v17 in ipairs(seededShuffleTable) do
			local c_str = v17.mLocationTag:c_str()
			local c_str2 = v17.mLocationLocTag:c_str()
			local v18 = __wf_atom_c08f5a0e(1, #v17.mJobs)
			local mJob = v17.mJobs[v18]
			local v19 = false

			for _, v20 in mJobs do
				if v20 ~= mJob then
					continue
				end

				v19 = true
				break
			end

			if v19 then
				continue
			end

			local c_str3 = mJob:__wf_atom_4f3855f9():c_str()
			local c_str4 = mJob:__wf_atom_9d4f2308():c_str()
			local __wf_atom_d4fa771b = mJob:__wf_atom_d4fa771b()

			if #__wf_atom_d4fa771b == 0 then
				continue
			end

			local v20 = __wf_atom_d4fa771b[1]

			if #v20.encounterChoices == 0 then
				continue
			end

			local c_str5 = Resource(v20.encounterChoices[1]):__wf_atom_55116686():c_str()
			table.insert(_T.AvailableJobs, {
				LocationTag = Symbol(c_str),
				LocationLocTag = Symbol(c_str2),
				MissionTag = Symbol(c_str5),
				Name = c_str3,
				Description = c_str4,
				JobInfo = mJob
			})
			table.insert(mJobs, mJob)

			if #_T.AvailableJobs == 3 then
				break
			end
		end

		__wf_atom_01bfe5c4(v15)
	end

	if __wf_atom_7e8ad928(_T.ActiveJobs) then
		_T.ActiveJobs = {}
	end

	for i = #_T.ActiveJobs, 1, -1 do
		local activeJob = _T.ActiveJobs[i]
		local v15 = false

		for _, availableJob in ipairs(_T.AvailableJobs) do
			if not (activeJob.LocationTag == availableJob.LocationTag and activeJob.JobInfo == availableJob.JobInfo) then
				continue
			end

			v15 = true
			break
		end

		if not v15 then
			table.remove(_T.ActiveJobs, i)
		end
	end

	fn10(jobsMovie, fn11, fn12)
end

local function fn14()
	module5.InitializeSyndicateData(syndicate, {})
	local __wf_atom_1603253f = jobManifest:__wf_atom_1603253f()
	local v15 = {}

	for _, v16 in ipairs(__wf_atom_1603253f) do
		for _, mJob in ipairs(v16.mJobs) do
			local __wf_atom_d4fa771b = mJob:__wf_atom_d4fa771b()

			if #__wf_atom_d4fa771b == 0 then
				continue
			end

			local v17 = __wf_atom_d4fa771b[1]

			if #v17.encounterChoices ~= 0 then
				table.insert(v15, v17.encounterChoices[1])
			end
		end
	end

	asyncLoader:LoadMultipleResources("DeoraJobs", v15, function(list)
		v8 = {}

		for _, v16 in ipairs(list) do
			table.insert(v8, Resource(v16))
		end
	end)
end

function ConfirmSyndicateSwap(p)
	if tonumber(p) == 4 then
		if __wf_atom_7e8ad928(v6) then
			return
		end

		module2.PlayDialogMenuTransmission(transmissionSet, Symbol("SyndicateSwap"), v6, false, 60)
		SwapToSyndicate()
	else
		module4.DissolveIn(v2.mConvoMovie)
		module4.RegisterHideSubtitles(true)
		fn8()
	end
end

local function fn15()
	if __wf_atom_7e8ad928(v10) then
		return
	end

	v10:Execute("SetTitleText", "/Lotus/Language/OstronCrafting/Syndicate_SyndicatesCategory")
	v10:Execute("SetBenefitsTitleText", "/Lotus/Language/OstronCrafting/Syndicate_BenefitsConsequences")
	v10:Execute("SetNPCName", Localize(npcName, false))

	function _T.DeoraShowOfferings()
		module2.PlayDialogMenuTransmission(transmissionSet, Symbol("Browsing"), v6, false, transmissionRange)
	end

	v10:Execute("SetOnShowOfferingsVendor", "DeoraShowOfferings")

	function _T.DeoraOnRankUp(p)
		local v15 = Symbol("RankUp" .. p)
		module2.PlayDialogMenuTransmission(transmissionSet, v15, v6, false, transmissionRange)
	end

	v10:Execute("SetOnRankUp", "DeoraOnRankUp")

	function _T.OnClaimDeoraItem(p)
		if p ~= nil and p then
			module2.PlayDialogMenuTransmission(transmissionSet, Symbol("ClaimItem"), v6, false, transmissionRange)
		end
	end

	v10:Execute("SetOnClaimOffering", "OnClaimDeoraItem")
end

local function fn16()
	if __wf_atom_7e8ad928(_T.SyndicateInvInfo) or __wf_atom_7e8ad928(_T.SyndicateInvInfo.Syndicate) then
		_T.ShowSyndicate = syndicate
	else
		_T.ShowSyndicate = _T.SyndicateInvInfo.Syndicate
	end

	fn10(syndicateFlashMovie, fn15)
end

function SwapToSyndicate()
	_T.BackgroundMovie:Execute("ShowBlockingMessage", 2)
	v14 = SF.SetSupportedSyndicateCommand(syndicate:__wf_atom_e0f044e1(), true, "OnRepSyndicateSet")
	v14:Execute()
end

function OnRepSyndicateSet(p, _)
	v14 = nil
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

	if p and not fn2() then
		Initiate()
	end

	module4.RegisterHideSubtitles(true)
	module4.DissolveIn(v2.mConvoMovie)

	if p then
		module2.PlayDialogMenuTransmission(transmissionSet, Symbol("FirstVisit"), v6, false, 60)
	end

	fn8()
end

local function fn17(_)
	if __wf_atom_7e8ad928(gGameData) or not IsLeader then
		return true
	end

	if __wf_atom_7e8ad928(syndicateTotem) then
		return false
	end

	local __wf_atom_71d5cc00 = gGameData:GetInventory():__wf_atom_71d5cc00()

	for _, v15 in ipairs(__wf_atom_71d5cc00) do
		if not __wf_atom_7e8ad928(v15.mItemType) and v15.mItemType:IsA(syndicateTotem) then
			return true
		end
	end

	return false
end

local function fn18(_)
	local __wf_atom_71d5cc00 = gGameData:GetInventory():__wf_atom_71d5cc00()
	local v15 = WeakResource("/SF/Upgrades/Skins/Body/StarterGraceBody")
	local v16 = Symbol("SilentRoseSyndicate")
	local v17 = WeakResource("/SF/Upgrades/Skins/Body/StarterSpiritBody")
	local v18 = Symbol("FeySyndicate")
	local v19 = WeakResource("/SF/Upgrades/Skins/Body/StarterCourageBody")
	local v20 = Symbol("ChampionSyndicate")

	for _, v21 in ipairs(__wf_atom_71d5cc00) do
		local mItemType = v21.mItemType

		if mItemType == v15 then
			return v16
		end

		if mItemType == v17 then
			return v18
		end

		if mItemType == v19 then
			return v20
		end
	end

	return nil
end

local function fn19()
	local __wf_atom_71d5cc00 = gGameData:GetInventory():__wf_atom_71d5cc00()

	for _, v15 in ipairs(__wf_atom_71d5cc00) do
		if not __wf_atom_7e8ad928(v15.mItemType) and v15.mItemType:IsA(syndicateTotem) then
			return true
		end
	end

	return false
end

function DeoraInteract(object, object2)
	if not object2:__wf_atom_4417a5d4() then
		return
	end

	v5 = getfenv(1)
	v6 = object2
	v7 = object:__wf_atom_3d96ddcd()

	if fn17(object2) then
		if #dialogLocPrefix == 0 then
			dialogLocPrefix = "/SF/Language/Hub/"
		end

		if not __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(v7) and useExplicitActivate then
			v7:__wf_atom_45194434(v6)
			v6:__wf_atom_aeb02c14(noMovementInputFilter)
		end

		local flag2 = false

		if not __wf_atom_7e8ad928(syndicate) then
			if not fn2() and fn() then
				Initiate()

				while flag do
					Sleep(0)
				end

				flag2 = true
			end

			fn14()
		end

		if not __wf_atom_7e8ad928(v7) then
			v4 = v7:__wf_atom_bb3e7833(__wf_atom_7369b1a2)

			if __wf_atom_7e8ad928(v4) then
				local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

				for i = 1, #__wf_atom_be0bea4a do
					local v15 = __wf_atom_be0bea4a[i]

					if v15:__wf_atom_db682341() == v then
						v4 = v15
					end
				end
			end

			v7:PlayTriggeredAnim(Symbol("TalkLoop"))
			v7:__wf_atom_c1b602d8(Symbol("TalkLoop"))
		end

		v6:__wf_atom_d2b2176d():Unequip(0, 0)
		v6:__wf_atom_8a035cd5(Symbol("SlidePlayer"), false)
		v6:__wf_atom_8a035cd5(Symbol("RotateDeoraHead"), false)
		module2.CloseTransmissions()
		v2 = module3.CreateConversation(Localize(npcName, false), v4, newConversationMovie)
		v2.mConvoInfo.QuitCallback = Goodbye

		function v2.OnClose(_, p)
			module2.CloseTransmissions()

			if not (p or __wf_atom_7e8ad928(v6)) then
				module2.PlayDialogMenuTransmission(transmissionSet, Symbol("Goodbye"), v6, false, transmissionRange)
				v6:__wf_atom_8a035cd5(Symbol("ResetDeoraHead"), false)
			end

			v9 = false

			if not __wf_atom_7e8ad928(v6) then
				v6:__wf_atom_68f2c268(0)
			end
		end

		local v15 = {
			Enter = conversationEnterSound,
			Exit = conversationExitSound,
			Loop = conversationLoopSound
		}
		v2:Start(v15)
		fn8()

		if not greetingTransmissionTag:__wf_atom_8598f3a9() then
			local reputationInfoForSyndicate, _, _, _, _ = module10.GetReputationInfoForSyndicate(syndicate)
			local v16 = Symbol("GreetRank" .. reputationInfoForSyndicate)
			local v17 = not __wf_atom_7e8ad928(transmissionSet:__wf_atom_b4a422ed(v16))
			greetingTransmissionTag = Symbol("Greet")

			if flag2 then
				greetingTransmissionTag = Symbol("FirstVisit")
			elseif reputationInfoForSyndicate > 0 and v17 then
				greetingTransmissionTag = v16
			end
		end

		module2.PlayDialogMenuTransmission(transmissionSet, greetingTransmissionTag, v6, false, transmissionRange)
		v9 = true
		v6:__wf_atom_8a035cd5(Symbol("HidePlayer"), false)

		while v2:Update() and not __wf_atom_7e8ad928(v6) do
			asyncLoader:Update()

			if v3 ~= nil then
				v3()
				v3 = nil
			end

			Sleep(0)
		end

		if not __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(v7) and useExplicitActivate then
			v7:__wf_atom_f0f55ac8(v6)
		end

		if not __wf_atom_7e8ad928(v7) then
			v7:PlayTriggeredAnim(Symbol("StandingUpIdle"))
			v7:__wf_atom_c1b602d8(Symbol("StandingUpIdle"))
		end

		v2:Close()
		module8.RefreshJobTrackers()
	else
		local v15 = {}
		object:Disable()
		local __wf_atom_e919fb8e = v7:__wf_atom_e919fb8e()

		if v7:HasTag(Symbol("AvakotInUnderCity")) and __wf_atom_e919fb8e.avakotIsInShell then
			v7:PlayTriggeredAnim(Symbol("PopUp"))
			v7:__wf_atom_c1b602d8(Symbol("StandingUpIdle"))
			__wf_atom_e919fb8e.avakotIsInShell = false
		end

		for i, v16 in ipairs(syndicateNoTalismanTransmissionsFactionTags) do
			if gGameData:__wf_atom_51dd1b95(v16).mInitiated then
				table.insert(v15, i)
			end
		end

		gGameData:__wf_atom_0cbd9965()

		if #v15 > 0 then
			local v16 = math.random(1, #v15)
			local syndicateNoTalismanTransmissionTag = syndicateNoTalismanTransmissionTags[v15[v16]]
			module2.PlayLocalTransmission(
				transmissionSet,
				syndicateNoTalismanTransmissionTag,
				gRegion:__wf_atom_c4f78a8f()
			)
		else
			local v16 = fn18(object2)
			local v17 = nil

			if v16 ~= nil then
				local v18 = nil

				for i, v19 in ipairs(syndicateNoTalismanTransmissionsFactionTags) do
					if v19 ~= v16 then
						continue
					end

					v18 = i
					break
				end

				if v18 ~= nil then
					v17 = syndicateNoTalismanTransmissionTags[v18]
				end
			end

			if v17 == nil then
				if not __wf_atom_7e8ad928(syndicateNoTalismanTransmissionFallbackTag) then
					module2.PlayLocalTransmission(
						transmissionSet,
						syndicateNoTalismanTransmissionFallbackTag,
						gRegion:__wf_atom_c4f78a8f()
					)
				end
			else
				module2.PlayLocalTransmission(transmissionSet, v17, gRegion:__wf_atom_c4f78a8f())
			end
		end

		if _T.ShowImpactMessage ~= nil then
			_T.ShowImpactMessage("/SF/Language/Syndicates/FactionNotOwned", 4)
		end

		Sleep(2)
		object:Enable()
	end
end

local function fn20()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("SproutFolkNpc"))

	for i = 1, #__wf_atom_2226b35c do
		__wf_atom_2226b35c[i]:__wf_atom_400189c4(1000)
	end
end

function Init(instance)
	module.WaitForLevel()
	module.WaitForLoginSequence()
	local v15

	if hasContextAction then
		v15 = instance:__wf_atom_bb3e7833(__wf_atom_0f45538d)

		while __wf_atom_7e8ad928(v15) do
			Sleep(1)
			v15 = instance:__wf_atom_bb3e7833(__wf_atom_0f45538d)
		end
	end

	instance:SetVisibility(false, true)

	if instance:HasTag(Symbol("AvakotInUnderCity")) and not fn2() then
		fn20()

		if not fn19() then
			instance:PlayTriggeredAnim(Symbol("IntoShell"))
			instance:__wf_atom_c1b602d8(Symbol("InGroundIdle"))
			local __wf_atom_e919fb8e = instance:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.avakotIsInShell = true
		end
	end

	if not __wf_atom_7e8ad928(v15) then
		v15:Disable()
	end

	if not (__wf_atom_7e8ad928(fragmentNeededToShow) or module.HasFragment(fragmentNeededToShow)) then
		return
	end

	if not __wf_atom_7e8ad928(requiredQuestToComplete) then
		instance:HasTag(Symbol("FencerHubNPC"))
		module7.HasCompletedQuest(requiredQuestToComplete)

		if instance:HasTag(Symbol("FencerHubNPC")) and not module7.HasCompletedQuest(requiredQuestToComplete) then
			return
		end
	end

	if not (fn2() or __wf_atom_7e8ad928(requiredQuestToComplete) or module7.HasCompletedQuest(requiredQuestToComplete)) then
		if #excludedQuestInProgressTasks == 0 then
			return
		end

		if module7.QuestIsActive(requiredQuestToComplete) then
			for _, v16 in ipairs(excludedQuestInProgressTasks) do
				if module7.TaggedTaskIsActive(requiredQuestToComplete, v16) then
					return
				end
			end
		end
	end

	instance:SetVisibility(true, true)

	if not __wf_atom_7e8ad928(v15) then
		v15:Enable()
	end
end

local function fn21(object)
	if __wf_atom_7e8ad928(object) then
		return ""
	end

	return Localize("/SF/Language/Syndicates/" .. string.gsub(object:c_str(), "Syndicate", "Name"), nil)
end

function Goodbye()
	if not __wf_atom_7e8ad928(v6) and not __wf_atom_7e8ad928(v7) and useExplicitActivate then
		v6:__wf_atom_cf966a74(noMovementInputFilter)
	end

	v2:Close()
end

function JobSelection(p)
	fn13(p)
end

function SyndicateStanding()
	fn16()
end

function SyndicateSwap()
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(syndicate) then
		return
	end

	module4.DissolveOut(v2.mConvoMovie, function()
		module4.RegisterHideSubtitles(false)
	end)
	local v15 = Localize("/SF/Language/Syndicates/SwitchFactionConfirmation", {
		FROM = fn21(gGameData:__wf_atom_0cbd9965()),
		TO = fn21(syndicate:__wf_atom_e0f044e1())
	})
	module9.ShowConfirmMessage(v15, "ConfirmSyndicateSwap")
end

function PlayUrMinigame()
	fn10(urMinigameFlashMovie)
	module3.ClearCamSpot()
end

function Trade()
	fn10(vendorFlashMovie)
end

function DefaultMenuChoice(p)
	if not __wf_atom_7e8ad928(talkIdleAnim) then
		v7:__wf_atom_d927a2a4(talkIdleAnim)
	end

	if module2.PlayDialogMenuTransmission(transmissionSet, Symbol(p), v6, true, transmissionRange) then
		fn8()

		if not __wf_atom_7e8ad928(idleAnim) then
			v7:__wf_atom_d927a2a4(idleAnim)
		end
	end
end