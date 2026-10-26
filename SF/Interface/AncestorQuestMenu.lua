local module = require("SF.Scripts.Libs.AncestorsFunctionLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("EE.Interface.Components.Grid")
local module4 = require("EE.Interface.Components.List")
local module5 = require("SF.Scripts.Libs.QuestLib")
local module6 = require("SF.Interface.SFUtilities")
local module7 = require("Lotus.Interface.StoreItemUtilities")
local module8 = require("Lotus.Interface.Libs.TimerMgr")
local module9 = require("SF.Interface.Libs.UIUtilities")
local module10 = require("EE.Interface.Utilities")
local module11 = require("EE.Interface.AnchorMgr")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local hubNpc = nil
local idSymbol = nil
local asyncLoader = module9.CreateAsyncLoader()
local v5 = nil
local v6 = nil
local v7 = {
	UNAVAILABLE = 1,
	AVAILABLE = 2,
	IN_PROGRESS = 3,
	READY_FOR_TURNIN = 4,
	COMPLETE = 5
}
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = false
local flag = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local flag2 = nil
local rewardElements = nil
local activeVendorCamera = nil
local v20 = nil
local v21 = nil

local function fn(activeVendorCamera2)
	if not (__wf_atom_7e8ad928(activeVendorCamera2) or __wf_atom_7e8ad928(v21) or v21:__wf_atom_c8c5ba0a()) then
		local __wf_atom_1b3db7e0 = v21:__wf_atom_1b3db7e0()
		v21:__wf_atom_fd14c463(0)
		v21:SetCameraSpot(activeVendorCamera2, 0.5)
		v21:__wf_atom_fd14c463(__wf_atom_1b3db7e0)
		_T.ActiveVendorCamera = activeVendorCamera2
	end
end

local function fn2(p)
	if module5.HasCompletedQuest(WeakResource(p)) then
		return v7.COMPLETE
	end

	if module5.QuestIsActive(WeakResource(p)) and module5.TaggedTaskIsActive(WeakResource(p), v4) then
		return v7.READY_FOR_TURNIN
	end

	if module5.QuestIsActive(WeakResource(p)) then
		return v7.IN_PROGRESS
	end

	if module5.CanQuestBeStarted(WeakResource(p)) then
		return v7.AVAILABLE
	end

	return v7.UNAVAILABLE
end

function RankUpPopupClosed() end

function OnRankUp(p)
	if not p then
		__wf_atom_f2daf912("Failed to rank up")
	end

	UpdateCurrencyBar()
	RefreshDisplay()
	flag = false
end

function OnTaskComplete(p)
	v15 = false

	if not p then
		__wf_atom_f2daf912("failed to complete task")
	end

	v5:AddTimer(0.5, function()
		flag2 = true
	end)
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) or fn2(object) ~= v7.READY_FOR_TURNIN or v15 then
		return
	end

	module10.PlaySound(questCompletedSound)

	for _, v22 in pairs(_T.AncestorTaskTurnsQueue) do
		if __wf_atom_7e8ad928(v22.Quest) or v22.Quest:GetName() ~= object:GetName() then
			continue
		end

		if not (__wf_atom_7e8ad928(v22.DialogueTag) or __wf_atom_7e8ad928(v22.TransmissionSet)) then
			module.PlayAncestorTransmission(
				v22.TransmissionSet,
				v22.DialogueTag,
				hubNpc,
				v22.AnimTag,
				nil,
				false,
				false
			)
		end

		v15 = true
		fn(activeVendorCamera)
		module6.DissolveOut(mMovie)
		fn(activeVendorCamera)
		module5.CompleteTaskWithTag(object, v4, "OnTaskComplete")
		return
	end

	LogBug("Failed to turn in " .. object:GetName())
end

local function fn4(p)
	module10.PlaySound(questAcceptedSound)
	_T.TechTreeTaskAcecpted = { idSymbol = idSymbol, HubNpc = hubNpc }
	module5.StartQuest(p, "OnQuestStarted")
end

function OnQuestStarted(_)
	if not v14 or __wf_atom_7e8ad928(v9) then
		return
	end

	local v22 = v17
	v17 = nil
	ShowQuest(v22)
	v9:Redraw(nil, true, true)
end

function ConfirmStartQuest(p)
	if tonumber(p) ~= 4 then
		return
	end

	fn4(v17)
end

local function fn5(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	if not object:__wf_atom_291a5f6a() then
		fn4(object)
		return
	end

	local v22 = (__wf_atom_7e8ad928(gMatchingService) or not (gMatchingService:__wf_atom_8b3e33a6() > 1))
		and "/SF/Language/Menu/SoloVotiveWarning"
		or "/SF/Language/Menu/SoloVotiveInSquadWarning"
	module10.ShowYesOrNoMessage(v22, "ConfirmStartQuest")
end

local function fn6(quest)
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(quest:__wf_atom_014a76a2():c_str(), false)
	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(quest:__wf_atom_3a3d2e39():c_str(), false)
	mMovie:__wf_atom_48bd5a59("Details.Info", "Title", 36, __wf_atom_8e9ac384)
	mMovie:__wf_atom_48bd5a59("Details.Info", "Description", 36, __wf_atom_8e9ac384_2)
	v8:RemoveElements(true, true)
	local acceptedQuest = module5.GetAcceptedQuestFromType(quest)

	if __wf_atom_7e8ad928(acceptedQuest) then
		local __wf_atom_731bdba2 = quest:__wf_atom_731bdba2()

		for _, v22 in ipairs(__wf_atom_731bdba2) do
			local __wf_atom_23accb14 = quest:__wf_atom_23accb14(v22)

			if not (__wf_atom_23accb14:__wf_atom_68085970() and __wf_atom_23accb14:__wf_atom_3a3d2e39() ~= Symbol("") and __wf_atom_23accb14:__wf_atom_db682341() ~= v4) then
				continue
			end

			v8:AddElement({ Node = __wf_atom_23accb14, Quest = quest, Completed = false }, true)
		end
	else
		local questNodesData = module5.GetQuestNodesData(acceptedQuest)

		for _, v22 in ipairs(questNodesData) do
			if not (v22.mNode:__wf_atom_68085970() and v22.mNode:__wf_atom_3a3d2e39() ~= Symbol("")) then
				continue
			end

			if v22.mNode:__wf_atom_db682341() == v4 then
				continue
			end

			local v23 = { Node = v22.mNode, Quest = quest, Completed = v22.mCompleted }
			v8:AddElement(v23, true)
		end
	end

	v8:Redraw(nil, true, true, true)
	local __wf_atom_9b6e11e8 = quest:__wf_atom_9b6e11e8()
	v10:RemoveElements(true, true)
	local v22 = false
	local v23 = false

	for _, v24 in __wf_atom_9b6e11e8 do
		local storeItemInfo = module7.GetStoreItemInfo(mMovie, v24, nil, nil, nil, true)
		v10:AddElement(storeItemInfo, true)
		v22 = true
	end

	local __wf_atom_0942f434 = v:__wf_atom_0942f434(WeakResource(quest))

	for _, v24 in __wf_atom_0942f434 do
		if not module.GetAncestorHasUpgradeTagAndQuestSet(v, v24, quest) then
			continue
		end

		local c_str = module.GetAncestorRankLocalizeTag(v, v24, quest):c_str()
		local c_str2 = module.GetAncestorRankLocalizeDescTag(v, v24, quest):c_str()
		local ancestorRankIcon = module.GetAncestorRankIcon(v, v24, quest)
		local v25 = {
			Name = mMovie:__wf_atom_8e9ac384(c_str, true),
			Description = mMovie:__wf_atom_8e9ac384(c_str2, true),
			CustomEntry = true,
			Icon = ancestorRankIcon
		}
		v10:AddElement(v25, true)
		local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384(c_str, false)
		mMovie:__wf_atom_48bd5a59("Details.Info", "TextSpoils.TextRewards", 36, __wf_atom_8e9ac384_3)
		v23 = true
	end

	mMovie:__wf_atom_7f57ab2f("Details.Info", "Spoils", 13, v22 or v23)
	mMovie:__wf_atom_7f57ab2f("Details.Info", "TextSpoils", 13, false)
	v10:Redraw(nil, true, true)
	local v24 = mMovie:__wf_atom_cfc41e35("Details.Info", "Description", 1) + mMovie:__wf_atom_cfc41e35("Details.Info", "Description", 41) + 30
	mMovie:__wf_atom_4c1c1986("Details.Info", "NodeListContainer", 1, v24)
	local v25 = mMovie:__wf_atom_cfc41e35("Details.Info", "NodeListContainer", 1) + mMovie:__wf_atom_cfc41e35(
		"Details.Info",
		"NodeListContainer",
		15
	) + 10

	if v25 < v13 then
		v25 = v13
	end

	mMovie:__wf_atom_4c1c1986("Details.Info", "Spoils", 1, v25)

	if v22 or v23 then
		v25 += 40
	end

	mMovie:__wf_atom_4c1c1986("Details.Info", "RewardItemsContainer", 1, v25)
	local v26 = v25 + 40
	mMovie:__wf_atom_48bd5a59("Details.Info", "TextSpoils", 1, v26)
end

local function fn7()
	local v22 = nil
	local v23 = 1

	for k, v24 in v3 do
		local v25 = fn2(v24)

		if v25 == v7.READY_FOR_TURNIN then
			return v24
		end

		if v25 == v7.AVAILABLE and __wf_atom_7e8ad928(v22) then
			v22 = k
		elseif v25 ~= v7.UNAVAILABLE then
			v23 = k
		end
	end

	if __wf_atom_7e8ad928(v22) then
		return v3[v23]
	end

	return v3[v22]
end

function ShowQuest(quest)
	if v17 == quest then
		return
	end

	if __wf_atom_7e8ad928(quest) and v19 then
		__wf_atom_ec43d06e(mMovie, "Details", 8, { 0, 12 }, { v12 - 10, 0 }, 0.2)
		v19 = false
	elseif not (__wf_atom_7e8ad928(quest) or v19) then
		__wf_atom_ec43d06e(mMovie, "Details", 8, { 0, 12 }, { v12, 100 }, 0.2)
		v19 = true
	end

	v17 = quest

	if __wf_atom_7e8ad928(quest) then
		return
	end

	__wf_atom_ec43d06e(mMovie, "Details.Info", 8, { 12 }, { 0 }, 0.05, 0, function()
		fn6(quest)
		__wf_atom_ec43d06e(mMovie, "Details.Info", 8, { 12 }, { 100 }, 0.01)
	end)
	mMovie:__wf_atom_933bbce0("Details.Header.QuestDecoSymbol.Icon", quest:GetIconTexture(), iconVisRangeMaterial)
	local v22 = fn2(quest)
	v18 = v22
	mMovie:__wf_atom_2dedec1a("Details.Header.PipGlow", 13, false)

	if v22 == v7.READY_FOR_TURNIN then
		v11:SetActive(true)
		v11:SetVisible(true)
		v11:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/TurnInQuest", false))
		mMovie:__wf_atom_2dedec1a("Details.Header.PipGlow", 13, true)
	elseif v22 == v7.IN_PROGRESS then
		v11:SetActive(false)
		v11:SetVisible(true)
		v11:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/TurnInQuest", false))
	elseif v22 == v7.AVAILABLE then
		v11:SetActive(true)
		v11:SetVisible(true)
		v11:SetText(mMovie:__wf_atom_8e9ac384("/SF/Language/Quests/AcceptTale", false))
	else
		v11:SetActive(false)
		v11:SetVisible(false)
	end
end

local function fn8()
	if flag2 then
		ReturnFromTransmission()
		return
	end

	module6.DissolveOutAndClose(mMovie)
	module10.PlaySound(menuCloseSound)
end

local function fn9(list, quest)
	local __wf_atom_0942f434 = v:__wf_atom_0942f434(WeakResource(quest))

	for _, v22 in __wf_atom_0942f434 do
		if not module.GetAncestorHasUpgradeTagAndQuestSet(v, v22, quest) then
			continue
		end

		local c_str = module.GetAncestorRankLocalizeTag(v, v22, quest):c_str()
		local c_str2 = module.GetAncestorRankLocalizeDescTag(v, v22, quest):c_str()
		local ancestorRankIcon = module.GetAncestorRankIcon(v, v22, quest)
		table.insert(list, {
			Name = mMovie:__wf_atom_8e9ac384(c_str, true),
			Description = mMovie:__wf_atom_8e9ac384(c_str2, true),
			CustomEntry = true,
			Icon = ancestorRankIcon
		})
	end
end

local function fn10()
	v9:RemoveElements(true, true)
	local number = 1
	local v22 = { Header = true, mHeight = 179, Label = v2[1].Name, Number = number }
	v9:AddElement(v22)
	local flag3 = true
	local v23 = {}
	local locked = true

	for k, quest in v3 do
		local v24 = { Quest = quest, mHeight = 80 }

		if fn2(quest) == v7.UNAVAILABLE then
			continue
		end

		local v25

		if k > 1 then
			v25 = v3[k - 1]:__wf_atom_5b41f63b()
		end

		for _, v26 in v2 do
			if v25 ~= v26.PreReqQuest then
				continue
			end

			if flag3 then
				local rewardElements2 = {}

				for _, v27 in v23 do
					fn9(rewardElements2, v27.Quest)
				end

				v9:AddElement({ Rewards = true, mHeight = 70, RewardElements = rewardElements2 })
			else
				for _, v27 in v23 do
					v9:AddElement(v27)
				end
			end

			v9:AddElement({ Footer = true, mHeight = 30 })
			number += 1
			local v27 = { Header = true, mHeight = 179, Label = v2[number].Name, Number = number }
			v9:AddElement(v27)
			v22.Locked = locked
			v22.Complete = flag3
			v22 = v27
			flag3 = true
			v23 = {}
			locked = true
		end

		if locked and fn2(quest) ~= v7.UNAVAILABLE then
			locked = false
		end

		if flag3 and fn2(quest) ~= v7.COMPLETE then
			flag3 = false
		end

		table.insert(v23, v24)
	end

	v22.Locked = locked
	v22.Complete = flag3

	if flag3 then
		local rewardElements2 = {}

		for _, v24 in v23 do
			fn9(rewardElements2, v24.Quest)
		end

		v9:AddElement({ Rewards = true, mHeight = 70, RewardElements = rewardElements2 })
	else
		for _, v24 in v23 do
			v9:AddElement(v24)
		end
	end

	v9:AddElement({ Footer = true, mHeight = 30 })
	local number2 = number + 1

	if not locked and number2 < #v2 + 1 then
		local v24 = {
			Header = true,
			mHeight = 179,
			Label = v2[number2].Name,
			Number = number2,
			Locked = true,
			Complete = false
		}
		v9:AddElement(v24)
	end

	v9:Redraw(nil, true, true)
	local v24 = fn7()

	for _, mElement in v9.mElements do
		if v24 == mElement.Quest and mElement.mIndex > 9 then
			v9:SetScroll(mElement.mIndex)
		end
	end
end

function RewardItemFocused(_, p)
	if __wf_atom_7e8ad928(rewardElements) or __wf_atom_7e8ad928(rewardElements[p]) then
		return
	end

	local infoPopup_Data = rewardElements[p]
	_T.InfoPopup_Data = infoPopup_Data
	module9.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8(p, 2) + 80,
		mMovie:__wf_atom_5e6e15c8(p, 3),
		mMovie:__wf_atom_5e6e15c8(p, 14),
		mMovie:__wf_atom_5e6e15c8(p, 15)
	)
end

function RewardItemUnfocused()
	_T.InfoPopup_Data = nil
end

local function fn11()
	v9 = module4.CreateNewList(getfenv(1), "QuestList.QuestListContainer.Element")
	v9.mForcedVerticalSeparation = 10
	v9.mHeight = 793

	function v9.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "Label", 44, _G.UIColor_MediumBrown)
		mMovie:__wf_atom_4c1c1986(p, "LongGlow", 12, 80)
		mMovie:__wf_atom_4c1c1986(p, "Backer.DefaultBacker", 12, 40)
		mMovie:__wf_atom_4c1c1986(p, "Backer.DefaultBacker", 11, 10066329)
		mMovie:__wf_atom_4c1c1986(p, "PipGlow", 12, 100)
		mMovie:__wf_atom_4c1c1986(p, "Header.ChapterNumber", 44, _G.UIColor_DarkBrown)
		mMovie:__wf_atom_4c1c1986(p, "Header.ChaperName", 44, _G.UIColor_DarkBrown)
		mMovie:__wf_atom_4c1c1986(p, "Backer.Selected", 12, 0)
		mMovie:__wf_atom_4c1c1986(p, "Header.LockIcon", 11, 4664607)
		mMovie:__wf_atom_4c1c1986(p, "Footer.Divider", 11, 4664607)
		mMovie:OverrideMaterial(p .. ".Header.ChapterHeaderLocked", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Header.ChapterHeaderActive", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Header.ChapterListBacker", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Header.LockIcon", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Header.CompletionCheck", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Header.ChapterNumber", _G.UIMaterial_VerticalVisibilityRangeText)
		mMovie:OverrideMaterial(p .. ".Header.LockedChapterNumber", _G.UIMaterial_VerticalVisibilityRangeText)
		mMovie:OverrideMaterial(p .. ".Header.ChaperName", _G.UIMaterial_VerticalVisibilityRangeText)
		mMovie:OverrideMaterial(p .. ".Label", _G.UIMaterial_VerticalVisibilityRangeText)
		mMovie:OverrideMaterial(p .. ".Pip.Fill", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Pip.Empty", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:__wf_atom_c90af43a(p .. ".Pip.Fill", pipFullIcon)
		mMovie:__wf_atom_c90af43a(p .. ".Pip.Empty", pipEmptyIcon)
		mMovie:OverrideMaterial(p .. ".Backer.DefaultBacker", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Backer.Selected", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".LongGlow", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".PipGlow", rankUpRaysMaterialVisRange)
		mMovie:OverrideMaterial(p .. ".QuestStateIcon.TurnInPin", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".QuestStateIcon.CompletionCheck", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Footer.LeftCorner", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Footer.Divider", _G.UIMaterial_VerticalVisibilityRange)
		mMovie:OverrideMaterial(p .. ".Footer.RightCorner", _G.UIMaterial_VerticalVisibilityRange)
	end

	function v9.mElementDrawCallback(data)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "RewardItemsContainer", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "LongGlow", 13, false)
		mMovie:__wf_atom_7f57ab2f(data.mClipName, "PipGlow", 13, false)

		if data.Header then
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header", 13, true)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Backer", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "LongGlow", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Footer", 13, false)
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Header", 12, module10.Ternary(data.Locked, 80, 100))
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.ChapterName", 50, module10.Ternary(data.Locked, 26, 30))
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Header.ChaperName", 36, data.Label)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.ChaperName", 13, not data.Locked)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.ChapterListBacker", 13, not data.Locked)
			mMovie:__wf_atom_7f57ab2f(
				data.mClipName,
				"Header.ChapterHeaderActive",
				13,
				not (data.Locked or data.Complete)
			)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.LockIcon", 13, data.Locked or false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.CompletionCheck", 13, data.Complete or false)
			mMovie:__wf_atom_7f57ab2f(
				data.mClipName,
				"Header.ChapterHeaderLocked",
				13,
				data.Locked or data.Complete or false
			)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.ChapterNumber", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.LockedChapterNumber", 13, false)

			if data.Locked then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.LockedChapterNumber", 13, true)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.LockedChapterNumber", 44, 4664607)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.LockedChapterNumber", 12, 50)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.ChapterHeaderLocked", 12, 50)
			else
				if data.Complete then
					mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.LockedChapterNumber", 13, true)
					mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.LockedChapterNumber", 44, _G.UIColor_DarkerBrown)
					mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.LockedChapterNumber", 12, 100)
				else
					mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header.ChapterNumber", 13, true)
				end

				mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.ChapterNumber", 44, _G.UIColor_DarkBrown)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Header.ChapterHeaderLocked", 12, 100)
			end

			mMovie:__wf_atom_48bd5a59(data.mClipName, "Header.ChapterNumber", 36, data.Number)
			mMovie:__wf_atom_48bd5a59(data.mClipName, "Header.LockedChapterNumber", 36, data.Number)
		elseif data.Footer then
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Backer", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "LongGlow", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Footer", 13, true)
		elseif data.Rewards then
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Backer", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "LongGlow", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Footer", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "RewardItemsContainer", 13, true)
			local v22 = data.mClipName .. ".RewardItemsContainer.RewardElement"

			if __wf_atom_7e8ad928(rewardElements) then
				rewardElements = {}
			end

			local v23 = 2

			while mMovie:__wf_atom_253d7085(data.mClipName .. ".RewardItemsContainer.RewardElement" .. "_" .. v23) do
				__wf_atom_86cbd68d(
					mMovie,
					data.mClipName .. ".RewardItemsContainer.RewardElement" .. "_" .. v23 .. ".removeMovieClip"
				)
				v23 += 1
			end

			local v24 = 0

			for k, rewardElement in data.RewardElements do
				local v25 = data.mClipName .. ".RewardItemsContainer.RewardElement" .. "_" .. k

				if not mMovie:__wf_atom_253d7085(v25) then
					__wf_atom_86cbd68d(mMovie, v22 .. ".duplicateMovieClip", "RewardElement" .. "_" .. k, k + 9000)
				end

				mMovie:__wf_atom_933bbce0(v25 .. ".Icon", rewardElement.Icon, _G.UIMaterial_VerticalVisibilityRange)
				mMovie:__wf_atom_933bbce0(
					v25 .. ".IconBg",
					additionalTextures[1],
					_G.UIMaterial_VerticalVisibilityRange
				)
				mMovie:__wf_atom_e57658c2(v25 .. ".IconBg", 11, 8152122)
				mMovie:__wf_atom_e57658c2(v25 .. ".IconBg", 12, 50)
				mMovie:__wf_atom_e57658c2(v25, 0, 70 * k)
				mMovie:SetCallbacks(v25, "RewardItemFocused", "RewardItemUnfocused", nil, nil)
				rewardElements[v25] = rewardElement
				v24 = k
			end

			local v25 = v24 + 1
			mMovie:__wf_atom_e57658c2(data.mClipName .. ".RewardItemsContainer", 0, 226 - v25 * 70 / 2)
			mMovie:__wf_atom_2dedec1a(v22, 13, false)
		else
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Header", 13, false)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Label", 13, true)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip", 13, true)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Backer", 13, true)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, true)
			mMovie:__wf_atom_7f57ab2f(data.mClipName, "Footer", 13, false)
			local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(data.Quest:__wf_atom_014a76a2():c_str(), false)
			local v22 = fn2(data.Quest)

			if v22 == v7.AVAILABLE then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip.Fill", 13, false)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, 100)
			elseif v22 == v7.IN_PROGRESS then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip.Fill", 13, false)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, 100)
			elseif v22 == v7.READY_FOR_TURNIN then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip.Fill", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "LongGlow", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "PipGlow", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon.TurnInPin", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon.CompletionCheck", 13, false)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, 100)
			elseif v22 == v7.COMPLETE then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip.Fill", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, true)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon.TurnInPin", 13, false)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon.CompletionCheck", 13, true)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, 100)
			elseif v22 == v7.UNAVAILABLE then
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "Pip.Fill", 13, false)
				mMovie:__wf_atom_7f57ab2f(data.mClipName, "QuestStateIcon", 13, false)
				mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 12, 70)
			end

			mMovie:__wf_atom_48bd5a59(data.mClipName, "Label", 36, __wf_atom_8e9ac384)
			local v23 = mMovie:__wf_atom_cfc41e35(data.mClipName, "Label", 43) > 1 and 11 or 24
			mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 1, v23)
		end
	end

	function v9.mOnFocusedCallback(data)
		if data.Header or data.Footer then
			return
		end

		module10.PlaySound(bookElementFocusedSound)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, _G.UIColor_DarkBrown)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Backer.DefaultBacker", 12, 100)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Backer.DefaultBacker", 11, 16777215)
	end

	function v9.mOnUnfocusedCallback(data)
		if data.Header or data.Footer then
			return
		end

		mMovie:__wf_atom_4c1c1986(data.mClipName, "Label", 44, _G.UIColor_MediumBrown)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Backer.DefaultBacker", 12, 40)
		mMovie:__wf_atom_4c1c1986(data.mClipName, "Backer.DefaultBacker", 11, 10066329)
	end

	function v9.mOnSelectedCallback(mPreviouslySelectedElement)
		if mPreviouslySelectedElement.Header or mPreviouslySelectedElement.Footer then
			return
		end

		if not __wf_atom_7e8ad928(v9.mPreviouslySelectedElement) then
			mMovie:__wf_atom_4c1c1986(v9.mPreviouslySelectedElement.mClipName, "Backer.Selected", 12, 0)
		end

		mMovie:__wf_atom_4c1c1986(mPreviouslySelectedElement.mClipName, "Backer.Selected", 12, 100)
		v9.mPreviouslySelectedElement = mPreviouslySelectedElement
		local _mSelectedElement = v9.mSelectedElement
		module10.PlaySound(bookElementSelectedSound)
		ShowQuest(mPreviouslySelectedElement.Quest)
	end

	function v9.CalculateScrollBarHeight(p)
		local _ = p.mBackerVisible == false
		return p.mHeight - 16
	end

	local mVisRangeMaterials = {
		_G.UIMaterial_VerticalVisibilityRange,
		_G.UIMaterial_VerticalVisibilityRangeText,
		rankUpRaysMaterialVisRange
	}
	v9:AttachScrollBar("QuestList.Scrollbar", { mVisRangeMaterials = mVisRangeMaterials })
	v9:EnableSmoothScroll()
	v9:SetCallbacks()
	v9:Redraw(nil, true, true)
end

local function fn12(p)
	local newGrid = module3.CreateNewGrid(getfenv(1), p, {
		mRows = 1,
		mColumns = 10,
		mColumnSeparation = 80,
		mRowSeparation = 80,
		mPadding = 16
	})

	function newGrid.mClipCreatedCallback(p2)
		mMovie:__wf_atom_c90af43a(p2 .. ".IconBg", additionalTextures[1])
	end

	function newGrid.mElementDrawCallback(p2)
		mMovie:__wf_atom_c90af43a(p2.mClipName .. ".Icon", p2.Icon)
		local v22 = p2.mClipName .. ".IconBg"
		mMovie:__wf_atom_e57658c2(v22, 11, 8152122)
		mMovie:__wf_atom_e57658c2(v22, 12, 50)
	end

	function newGrid.mOnFocusedCallback(infoPopup_Data)
		mMovie:__wf_atom_e57658c2(infoPopup_Data.mClipName .. ".IconBg", 12, 90)
		_T.InfoPopup_Data = infoPopup_Data
		module9.SetItemInfoPopupRect(
			mMovie,
			infoPopup_Data,
			mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 2) + 80,
			mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 3),
			mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 14),
			mMovie:__wf_atom_5e6e15c8(infoPopup_Data.mClipName, 15)
		)
	end

	function newGrid.mOnUnfocusedCallback(p2)
		mMovie:__wf_atom_e57658c2(p2.mClipName .. ".IconBg", 12, 50)
		_T.InfoPopup_Data = nil
	end

	return newGrid
end

local function fn13()
	mMovie:__wf_atom_4c1c1986("Details.Info", "Title", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_7f57ab2f("Details.Info", "Title", 54, true)
	mMovie:__wf_atom_4c1c1986("Details.Info", "Description", 11, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_4c1c1986("Details.Info", "Spoils", 44, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_4c1c1986("Details.Info", "TextSpoils.TextRewards", 44, _G.UIColor_MediumBrown)
	mMovie:__wf_atom_4c1c1986("Details.Info", "TextSpoils.BulletPoint", 11, 4664607)
	mMovie:__wf_atom_48bd5a59(
		"Details.Info",
		"Spoils",
		36,
		mMovie:__wf_atom_8e9ac384("/SF/Language/Codex/Spoils", false)
	)
	v13 = mMovie:__wf_atom_cfc41e35("Details.Info", "Spoils", 1)
	v8 = module4.CreateNewList(getfenv(1), "Details.Info.NodeListContainer.Node")

	function v8.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "ObjectiveText", 44, _G.UIColor_MediumBrown)
	end

	function v8:mElementDrawCallback()
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(self.Node:__wf_atom_3a3d2e39():c_str(), false)
		mMovie:__wf_atom_48bd5a59(self.mClipName, "ObjectiveText", 36, __wf_atom_8e9ac384)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".ObjectiveText", 43)
		local mHeight = 10 + 30 * __wf_atom_5e6e15c8

		if __wf_atom_5e6e15c8 > 1 and self.mHeight ~= mHeight then
			self.mHeight = mHeight
			v8:Redraw(nil, true, true)
		end

		if fn2(self.Quest) == v7.COMPLETE then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Pip.Fill", 13, true)
		elseif self.Completed then
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Pip.Fill", 13, true)
		else
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "Pip.Fill", 13, false)
		end

		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Pip.Fill", pipFullIcon)
		mMovie:__wf_atom_e57658c2(self.mClipName .. ".Pip.Fill", 15, 50)
		mMovie:__wf_atom_e57658c2(self.mClipName .. ".Pip.Fill", 14, 50)
		mMovie:__wf_atom_e57658c2(self.mClipName .. ".Pip.Fill", 0, -7)
		mMovie:__wf_atom_e57658c2(self.mClipName .. ".Pip.Fill", 1, -7)
		mMovie:__wf_atom_c90af43a(self.mClipName .. ".Pip.Empty", pipEmptyIcon)
	end

	v10 = fn12("Details.Info.RewardItemsContainer.RewardElement")
	mMovie:__wf_atom_2dedec1a("Details.Scrollbar", 13, false)
end

local function fn14()
	v12 = mMovie:__wf_atom_5e6e15c8("Details", 0)
	mMovie:__wf_atom_e57658c2("Details", 0, v12 - 10)
	mMovie:__wf_atom_e57658c2("Details", 12, 0)
	v19 = false
	mMovie:OverrideMaterial("Details.Header.PipGlow", rankUpRaysMaterial)
	local v22 = mMovie:__wf_atom_5e6e15c8("Details.Header.QuestDecoSymbol.Gold", 14) + 20
	mMovie:__wf_atom_e57658c2("Details.Header.QuestDecoSymbol.Icon", 14, v22)
	mMovie:__wf_atom_e57658c2("Details.Header.QuestDecoSymbol.Icon", 15, v22)
	local module12 = require("SF.Interface.Components.Button")
	v11 = module12.Create(mMovie, "Details.TurnInButton", "/SF/Language/Quests/AcceptTale", "QuestButtonPressed")
	v11:SetVariant(module12.VARIANTS.SPECIAL_BUTTON)
	v11:SetAnchor(module10.CENTER_ALIGNED)
	fn13()
end

local function fn15()
	mMovie:__wf_atom_2dedec1a("_root", 13, true)
	module6.DissolveIn(mMovie)
	module10.PlaySound(menuOpenSound)
	fn11()
	fn10()
	fn14()
	UpateButtons()
	UpdateCurrencyBar()
	v14 = true
end

function Initialize()
	v5 = module8.CreateTimerMgr()
	module9.SetChatVisible(false)
	module6.RegisterHideHudSelective(true)
	v6 = module11.Create(mMovie)
	v6:Register(mMovie, "RankUpCelebration", { v6.ANCHOR_V_CENTRE, v6.ANCHOR_H_CENTRE })
	v21 = gRegion:__wf_atom_c4f78a8f():CameraControl()
	_T.SetupAncestorData = SetupAncestorData
	activeVendorCamera = _T.ActiveVendorCamera
	v20 = module2.FindTaggedChild(_T.VendorCameras, taskCameraSymbol)
	fn(v20)
	mMovie:__wf_atom_2dedec1a("_root", 13, false)
	mMovie:__wf_atom_2dedec1a("RankUpCelebration", 13, false)
	onViewportSizeChanged()
end

function UpateButtons()
	local v22 = {}
	table.insert(v22, {
		Label = "/Lotus/Language/Menu/Exit",
		CallBack = fn8,
		CallOut = "MENU_CANCEL"
	})

	if not (__wf_atom_7e8ad928(_T.SetButtons) or __wf_atom_7e8ad928(_T.BackgroundMovie)) then
		_T.SetButtons(mMovie, v22, getfenv(1))
	end
end

function UpdateCurrencyBar()
	local v22 = {
		mMovie = mMovie,
		mLabel = mMovie:__wf_atom_8e9ac384(v:__wf_atom_014a76a2():c_str(), false),
		mOverwriteCurrencies = true,
		mMinWidth = 525,
		mLevel = module.GetAncestorRank(v) + 1
	}
	local v23 = not (v22.mLevel > 1) and 0 or v:__wf_atom_071f014c(v22.mLevel - 1)
	local v24 = v:__wf_atom_071f014c(v22.mLevel) - v23
	local v25 = module.GetAncestorXP(v) - v23
	v22.mRankProgress = __wf_atom_421b01aa(v25 / v24, 0, 1) * 100

	if _T.ShowCurrencyBar ~= nil then
		_T.ShowCurrencyBar(v22)
	end

	if flag then
		module9.ShowRankUpPopup(
			getfenv(1),
			false,
			RankUpPopupClosed,
			v22.mLabel,
			v22.mLevel,
			rankUpRaysMaterial,
			linesMaterial
		)
	end
end

function ReturnFromTransmission()
	flag2 = false
	UpdateCurrencyBar()
	RefreshDisplay()
	fn(v20)
	module6.DissolveIn(mMovie)
end

function Update()
	local v22 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v22)
	asyncLoader:Update()

	if not __wf_atom_7e8ad928(v5) then
		v5:Update(__wf_atom_084b3e93())
	end

	if not v14 and v16 then
		fn15()
	end

	if not __wf_atom_7e8ad928(v17) and v18 ~= fn2(v17) then
		RefreshDisplay()
	end

	if module.CheckForPendingRankUpFromXP(v) and not flag then
		flag = true
		gGameData:RankUpAncestor(v, "OnRankUp")
	end

	if flag2 and __wf_atom_7e8ad928(_T.curTransmission) then
		ReturnFromTransmission()
	end
end

function RefreshDisplay()
	if not v14 or __wf_atom_7e8ad928(v9) then
		return
	end

	local v22 = v17
	v17 = nil
	ShowQuest(v22)
	fn10()
end

function Shutdown()
	module9.SetChatVisible(true)
	module6.RegisterHideHudSelective(false)

	if _T.HideCurrencyBar ~= nil then
		_T.HideCurrencyBar(mMovie)
	end

	_T.SetupAncestorData = nil
	_T.InfoPopup_Data = nil
	_T.OrlickIMGUI = false
	fn(activeVendorCamera)
end

function QuestButtonPressed()
	if __wf_atom_7e8ad928(v17) then
		return
	end

	local v22 = fn2(v17)

	if v22 == v7.READY_FOR_TURNIN then
		__wf_atom_f2daf912("Turning in quest")
		fn3(v17)
	elseif v22 == v7.AVAILABLE then
		__wf_atom_f2daf912("Startig quest")
		fn5(v17)
	end
end

function onKeyDown_MENU_CANCEL()
	fn8()
end

function SetupAncestorData(p, p2, items, list, list2, p3, p4)
	v = p
	v4 = p2
	hubNpc = p4
	idSymbol = p3
	v2 = {}

	for i = 1, #list do
		v2[i] = {
			Name = mMovie:__wf_atom_8e9ac384(list2[i], false),
			PreReqQuest = list[i]:__wf_atom_5b41f63b()
		}
	end

	v3 = {}
	asyncLoader:LoadMultipleResources("Quests", items, function()
		for _, item in items do
			table.insert(v3, Resource(item))
		end

		v16 = true
	end)
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v6) then
		v6:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end