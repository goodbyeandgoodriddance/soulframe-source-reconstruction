local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.UIUtilities")
local module4 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = true
local v3 = nil
local v4 = nil
local v5 = -1
local v6 = false
local v7 = nil
local v8 = nil
local __wf_atom_b4a422eds = nil
local v9 = nil
local goalTag = nil
local v10 = nil
local v11 = {}
local v12 = nil
local v13 = nil
local v14 = {}
local v15 = nil
local v16 = {
	{ Tag = Symbol("IndexQuestMissionA"), PayoutCredits = 120000, BuyInCredits = 100000 },
	{
		Tag = Symbol("IndexQuestMissionB"),
		PayoutCredits = 140000,
		PayoutCaptives = 2,
		BuyInCredits = 120000
	},
	{
		Tag = Symbol("IndexQuestMissionC"),
		PayoutCredits = 160000,
		PayoutCaptives = 4,
		BuyInCredits = 140000
	},
	{
		Tag = Symbol("IndexQuestMissionD"),
		PayoutCredits = 180000,
		PayoutCaptives = 6,
		BuyInCredits = 160000
	},
	{
		Tag = Symbol("IndexQuestMissionE"),
		PayoutLocOverride = "/Lotus/Language/Menu/Gambling_QuestMatchEPayout",
		BuyInLocOverride = "/Lotus/Language/Menu/Gambling_QuestMatchEBuyIn"
	},
	{
		Tag = Symbol("IndexQuestMissionF"),
		PayoutLocOverride = "/Lotus/Language/Menu/Gambling_QuestMatchFPayout",
		BuyInLocOverride = "/Lotus/Language/Menu/Gambling_QuestMatchFBuyIn"
	}
}
local v17 = nil

function IsInputBlocked()
	return v2
end

local function fn()
	mMovie:__wf_atom_e57658c2("BetList", 12, 100)
	v:RunForAllElements(function(state)
		state.Active = true

		if state.mBuyInBtn then
			state.mBuyInBtn:SetActive(state.Active)
		end
	end)
end

local function fn2()
	local v18 = 1
	__wf_atom_b4a422eds = {}
	v9 = {}
	local c_str = goalTag:c_str()
	local __wf_atom_b4a422ed = questTransmissionSet:__wf_atom_b4a422ed(Symbol(c_str .. "_" .. v18))

	while not __wf_atom_7e8ad928(__wf_atom_b4a422ed) do
		table.insert(__wf_atom_b4a422eds, __wf_atom_b4a422ed)
		table.insert(v9, __wf_atom_b4a422ed:__wf_atom_5b41f63b())
		v18 += 1
		__wf_atom_b4a422ed = questTransmissionSet:__wf_atom_b4a422ed(Symbol(c_str .. "_" .. v18))
	end

	if next(__wf_atom_b4a422eds) == nil then
		v11.done = true
		fn()
	else
		v10 = UISys.__wf_atom_c0dbe47c(v9)
		v11.pending = true
		v11.playingIndex = 0
	end
end

local function fn3()
	if v7 == nil then
		return
	end

	if goalTag == nil then
		goalTag = v7.goalTag
	end

	if goalTag == EMPTY_SYMBOL then
		v11.done = true
		fn()
	elseif not (v11.pending or v11.playing) then
		fn2()
	elseif v11.pending and v10:__wf_atom_86399a47() then
		v11.pending = false
		v11.playing = true

		for i = 1, #__wf_atom_b4a422eds do
			module.CreateHudlessTransmission(__wf_atom_b4a422eds[i])
		end
	elseif v11.playing and not module.IsTransmissionPlaying() then
		v11.playing = false
		v11.done = true
		fn()
	end
end

local function fn4()
	_T.SetButtons(mMovie, nil)

	if not __wf_atom_7e8ad928(v13) then
		v13:Close()
	end

	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) and v4 then
		local v18 = v15 and "true"
			or not (v5 >= 0) and "false"
			or v17 and v12
			or wagerTierNodes[v5 + 1]:c_str()
			or "false"
		__wf_atom_2ad5cd23:__wf_atom_f62a8704(v4, { v18, v5 })
	end

	if v6 then
		_T.DisableUIInput()
	end

	if not __wf_atom_7e8ad928(_T.AcceptInvitePanel) then
		_T.AcceptInvitePanel:SetVisible(true)
		_T.AcceptInvitePanel:__wf_atom_b4ffb30f(true)
	end

	if v11.playing and module.IsTransmissionPlaying() then
		for _, v18 in ipairs(__wf_atom_b4a422eds) do
			module.InterruptTransmission(v18)
		end
	end

	mMovie:Close()
end

local function fn5(p)
	if p >= 0 then
		v3:__wf_atom_1ece6a5e(p)
		_T.MadeWagerChoice = true
	end

	v5 = p
	fn4()
end

function ForceClose()
	fn5(-1)
end

local function fn6()
	local v18 = {}
	local tips = module3.GetTips(mMovie, "/Lotus/Language/Tokens/ArenaGambling_Tip")
	table.insert(v18, {
		Label = mMovie:__wf_atom_8e9ac384("<WARNING>", true),
		Tips = tips,
		Padding = -10
	})
	table.insert(v18, {
		Label = "/Lotus/Language/Menu/Exit",
		CallBack = function()
			fn5(-1)
		end,
		CallOut = "MENU_CANCEL"
	})

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, v18, getfenv(1))
	end
end

function OnInvestConfirm(p)
	if tonumber(p) == 4 then
		fn5(v5)
	else
		v5 = -1
	end
end

local function fn7()
	local module5 = require("EE.Interface.Components.List")
	v = module5.CreateList(mMovie, "BetList.Element")
	v:SetCallbacks("BetSelected", "BetFocused", "BetUnfocused")
	v.mForcedVerticalSeparation = 0
	v.mForcedHorizontalSeparation = 485
	v.mInitXPos = mMovie:__wf_atom_5e6e15c8("BetList", 0)

	function v.mClipCreatedCallback(p)
		mMovie:__wf_atom_4c1c1986(p, "Title", 44, v14.FloatingContent)
		mMovie:__wf_atom_4c1c1986(p, "ReturnDesc", 44, v14.FloatingContentHighlight)
		mMovie:__wf_atom_4c1c1986(p, "Desc", 44, v14.FloatingContent)
		mMovie:__wf_atom_c0d7a318(p, "Bg", "noMenuSelection", true)
		mMovie:OverrideMaterial(p .. ".Bg", _G.UIMaterial_RectangleNoDepth)
		mMovie:__wf_atom_1ca72041(
			p .. ".Bg",
			"RectInnerColor",
			v14.Background1Object.r,
			v14.Background1Object.g,
			v14.Background1Object.b,
			0.7
		)
		module3.DrawSeparator(mMovie, p .. ".Underline", 413)
		mMovie:__wf_atom_4c1c1986(p, "Underline", 11, v14.FloatingContent)
		mMovie:__wf_atom_c90af43a(p .. ".Watermark", watermark)
		mMovie:__wf_atom_4c1c1986(p, "Watermark", 12, 10)
		mMovie:__wf_atom_4c1c1986(p, "Watermark", 11, v14.FloatingContent)
	end

	function v.GetInterpolationProperties(object, p)
		return { 12, 1 }, { module2.Ternary(p.Active or p.QuestStageIndex ~= nil, 100, 50), object:CalculateY(p) }
	end

	function v.mOnFocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		module2.PlaySound(_G.UISound_Focus)
		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			v14.BackerHighlightObject.r,
			v14.BackerHighlightObject.g,
			v14.BackerHighlightObject.b,
			0.9
		)
	end

	function v.mOnUnfocusedCallback(p)
		if p.mClipName == nil then
			return
		end

		mMovie:__wf_atom_1ca72041(
			p.mClipName .. ".Bg",
			"RectEdgeColor",
			v14.BackerHighlightObject.r,
			v14.BackerHighlightObject.g,
			v14.BackerHighlightObject.b,
			0.05
		)
	end

	function v.mOnSelectedCallback(data)
		if not data.Active then
			return
		end

		v5 = (data.tier or data.mIndex) - 1
		local v18

		if data.QuestStageIndex == nil then
			v18 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaInvestConfirm", true, {
				BUYIN = module2.FormatNumber(data.BuyIn)
			})
		else
			v18 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaInvestQuestConfirm", false)
		end

		v13 = module2.ShowYesOrNoMessage(v18, "OnInvestConfirm")
	end

	function v:mElementDrawCallback()
		if self.mClipName == nil then
			return
		end

		local focusedElement = v:GetFocusedElement()
		local v18 = focusedElement ~= nil and focusedElement.Id == self.Id
		mMovie:__wf_atom_1ca72041(
			self.mClipName .. ".Bg",
			"RectEdgeColor",
			v14.BackerHighlightObject.r,
			v14.BackerHighlightObject.g,
			v14.BackerHighlightObject.b,
			module2.Ternary(v18, 0.9, 0.05)
		)
		mMovie:__wf_atom_7d7314f1(self.mClipName .. ".Title.text", self.Title)
		local image = self.Image
		local v19 = 375
		local v20 = 375
		local v21 = ""
		local v22 = ""

		if self.QuestStageIndex == nil then
			local reward = self.Reward
			local v23 = reward - self.BuyIn
			v21 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaGamblingPayout", true, {
				PAYOUT = module2.FormatNumber(v23)
			})
			v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaGamblingBuyIn", true, {
				BUYIN = module2.FormatNumber(self.BuyIn)
			})
			mMovie:__wf_atom_7d7314f1(
				self.mClipName .. ".ReturnDesc.text",
				"/Lotus/Language/Menu/ArenaGamblingReturn",
				{ RETURN = module2.FormatNumber(reward) }
			)
		else
			local v23 = v16[self.QuestStageIndex]

			if self.QuestStageIndex == 1 then
				image = questRewardTextures[1]
				v19 = 512
				v20 = 256
			else
				if self.QuestStageIndex <= 4 then
					image = questRewardTextures[2]
					v19 = 512
				else
					image = questRewardTextures[3]
					v19 = 256
				end

				v20 = 512
			end

			if v23.PayoutCredits == nil then
				if v23.PayoutLocOverride ~= nil then
					v21 = mMovie:__wf_atom_8e9ac384(v23.PayoutLocOverride, true)
				end
			elseif v23.PayoutCaptives == nil then
				v21 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/CreditsFormatted", true, {
					CREDITS = module2.FormatNumber(v23.PayoutCredits)
				})
			else
				v21 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Gambling_QuestPayoutCaptives", true, {
					NUM = v23.PayoutCaptives,
					CREDITS = module2.FormatNumber(v23.PayoutCredits)
				})
			end

			if v23.BuyInCredits == nil then
				if v23.BuyInLocOverride ~= nil then
					v22 = mMovie:__wf_atom_8e9ac384(v23.BuyInLocOverride, true)
				end
			else
				v22 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Gambling_QuestGenericBuyIn", true, {
					CREDITS = module2.FormatNumber(v23.BuyInCredits)
				})
			end

			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Payout", 1)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Payout", 1, __wf_atom_5e6e15c8 + 20)
			mMovie:__wf_atom_7f57ab2f(self.mClipName, "ReturnDesc", 13, false)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".Desc", 1)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Desc", 1, __wf_atom_5e6e15c8_2 + 10)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8(self.mClipName .. ".BuyInBtn", 1)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "BuyInBtn", 1, __wf_atom_5e6e15c8_3 - 20)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "BuyInBtn.Btn", 15, 70)
			mMovie:__wf_atom_48bd5a59(self.mClipName, "BuyInBtn.Label", 46, "center")
		end

		if not __wf_atom_7e8ad928(image) then
			mMovie:__wf_atom_c90af43a(self.mClipName .. ".Image", image)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Image", 14, v19)
			mMovie:__wf_atom_4c1c1986(self.mClipName, "Image", 15, v20)
		end

		local module6 = require("Lotus.Interface.Components.ThemedButton")
		local v23 = module6.Create(mMovie, self.mClipName .. ".PayoutBtn", v21)
		v23.mInactiveAlpha = 100
		v23:SetActive(false)
		v23:SetAnchor(module2.CENTER_ALIGNED)
		local v24 = "<p><font size=\"17\"><font size=\"20\"><b>" .. mMovie:__wf_atom_8e9ac384(
			"/Lotus/Language/Menu/ArenaGamblingDescHeader",
			false
		) .. "</b><br></font>"
		local v25

		if self.Score > 0 then
			v25 = v24 .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Tokens/ArenaGamblingGenericConditions", false, {
				NUM = self.Score,
				OPEN_COLOR = "<font color=\"" .. v14.FloatingContentHighlightHex .. "\">",
				CLOSE_COLOR = "</font>"
			})
		else
			v25 = v24 .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaGamblingVictoryOnlyCondition", false)
		end

		if self.Debuffs > 0 then
			v25 ..= "<br>" .. mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaGamblingNegModifiers", false, {
				NUM = self.Debuffs
			})
		end

		local v26 = v25 .. "</font></p>"
		mMovie:__wf_atom_48bd5a59(self.mClipName, "Desc", 36, v26)
		self.mBuyInBtn = module6.Create(mMovie, self.mClipName .. ".BuyInBtn", v22, "BuyInBtnPressed")
		self.mBuyInBtn:SetSpecialMode()
		self.mBuyInBtn:SetWidth(333)

		function self.mBuyInBtn.mOnFocusedCallback()
			v:FocusElementById(self.Id)
		end

		self.mBuyInBtn:SetActive(not v17 or self.Active)
		self.mBuyInBtn:Redraw()
	end
end

local v18 = {
	"/Lotus/Language/Menu/Gambling_WagerOne",
	"/Lotus/Language/Menu/Gambling_WagerTwo",
	"/Lotus/Language/Menu/Gambling_WagerThree"
}

local function fn8(tieredItem, p, __wf_atom_7050e489, tier)
	local storeItem = tieredItem:GetStoreItem()
	local mCreditsFee = p.mCreditsFee
	local reward = -storeItem:__wf_atom_ee4fa4fd()
	local odds = reward / mCreditsFee
	v:AddElement({
		Title = v18[tier],
		Debuffs = tier - 1,
		Image = creditTextures[tier],
		BuyIn = mCreditsFee,
		Odds = odds,
		Score = p.mScoreGoal,
		Reward = reward,
		Active = mCreditsFee < __wf_atom_7050e489,
		tier = tier
	}, true)
end

local function fn9()
	if __wf_atom_7e8ad928(v3) or __wf_atom_7e8ad928(v7) then
		return
	end

	local missionRewardExtra = v7.missionRewardExtra
	local randomizedItems

	if v17 == nil then
		if __wf_atom_7e8ad928(missionRewardExtra) then
			return
		end

		randomizedItems = missionRewardExtra.randomizedItems

		if __wf_atom_7e8ad928(randomizedItems) then
			return
		end
	end

	local __wf_atom_b984b7fc = v7:__wf_atom_b984b7fc()

	if #__wf_atom_b984b7fc == 0 then
		return
	end

	if v17 == nil then
		local __wf_atom_7050e489 = v3:__wf_atom_7050e489()
		local v19 = math.min(#__wf_atom_b984b7fc, 3)

		if v8 then
			fn8(randomizedItems:GetTieredItem(v8 - 1, 0), __wf_atom_b984b7fc[1], __wf_atom_7050e489, v8)
		else
			for i = 1, v19 do
				fn8(randomizedItems:GetTieredItem(i - 1, 0), __wf_atom_b984b7fc[i], __wf_atom_7050e489, i)
			end
		end
	else
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Gambling_MatchGeneric", false, {
			NUM = v17
		})
		v:AddElement({
			QuestStageIndex = v17,
			Title = __wf_atom_8e9ac384,
			Debuffs = 0,
			Score = __wf_atom_b984b7fc[1].mScoreGoal,
			Active = false
		}, true)
		mMovie:__wf_atom_e57658c2("BetList", 12, 50)
	end

	v:Redraw()
	local v19 = v.mInitXPos - (v.mForcedHorizontalSeparation * v:GetHowManyElements() - 17) / 2
	mMovie:__wf_atom_e57658c2("BetList", 0, v19)
end

function SetSectorNameAndCloseCallback(value, p, p2)
	local v19 = string.find(value, module.KEY_TAG)
	local v20

	if v19 ~= nil then
		local v21 = string.sub(value, 1, v19 - 1)
		v20 = Resource(v21)
	end

	if __wf_atom_7e8ad928(v20) then
		v7 = module.GetStarChart():BuildMissionForLocation(Symbol(value))

		for i = 1, #wagerTierNodes do
			if wagerTierNodes[i]:c_str() ~= value then
				continue
			end

			v8 = i
			break
		end
	else
		v7 = v20:__wf_atom_72fc675e()
		v12 = value
	end

	for i = 1, #v16 do
		if v7.goalTag ~= v16[i].Tag then
			continue
		end

		v17 = i
		break
	end

	if v17 ~= nil then
		mMovie:__wf_atom_7d7314f1("Subtitle.text", "/Lotus/Language/Menu/ArenaSelectWager")
		mMovie:__wf_atom_7d7314f1("Hint.text", "/Lotus/Language/Menu/ArenaGamblingHintQuest")
	end

	v4 = p

	if not __wf_atom_7e8ad928(_T.AcceptInvitePanel) then
		_T.AcceptInvitePanel:SetVisible(false)
		_T.AcceptInvitePanel:__wf_atom_b4ffb30f(false)
	end

	fn9()

	if p2 and p2 == "true" then
		v15 = true

		if v12 then
			fn5(0)
		elseif v8 then
			fn5(v8 - 1)
		end
	end
end

function Shutdown()
	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle()
	end
end

function Initialize()
	v14 = {
		Content = module4.GetColor(6, true),
		Background1 = module4.GetColor(2, true),
		FloatingContent = module4.GetColor(9, true),
		FloatingContentHighlight = module4.GetColor(10, true),
		BackerHighlight = module4.GetColor(1, true)
	}
	v14.Background1Object = module2.ConvertColorNumberToProceduralRGB(v14.Background1)
	v14.FloatingContentObject = module2.ConvertColorNumberToProceduralRGB(v14.FloatingContent)
	v14.FloatingContentHighlightObject = module2.ConvertColorNumberToProceduralRGB(v14.FloatingContentHighlight)
	v14.BackerHighlightObject = module2.ConvertColorNumberToProceduralRGB(v14.BackerHighlight)
	v14.FloatingContentHex = module2.ConvertColorNumberToHex(v14.FloatingContent)
	v14.FloatingContentHighlightHex = module2.ConvertColorNumberToHex(v14.FloatingContentHighlight)
	mMovie:__wf_atom_7d7314f1("Subtitle.text", "/Lotus/Language/Menu/ArenaGamblingSubtitle")
	mMovie:__wf_atom_e57658c2("Subtitle", 44, v14.FloatingContentHighlight)
	mMovie:__wf_atom_50d60589(
		"Hint",
		36,
		TitleCase(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Tokens/ArenaGamblingHint", true))
	)
	mMovie:__wf_atom_e57658c2("Hint", 44, v14.FloatingContent)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true)
	v6 = not _T.UIInputEnabled

	if v6 then
		_T.EnableUIInput()
	end

	if not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(0.25)
	end

	if not __wf_atom_7e8ad928(_T.SetSquadOverlayTitle) then
		_T.SetSquadOverlayTitle(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/ArenaGamblingTitle", false))
	end

	_T.MadeWagerChoice = false

	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		v3 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	end

	fn7()
	fn9()
	fn6()
	v2 = false
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if v17 and not v11.done then
		fn3()
	end
end

function onViewportSizeChanged(_, _) end

function BuyInBtnPressed()
	if v2 or __wf_atom_7e8ad928(v) then
		return
	end

	v:SelectCurrentElement()
end

function BetFocused(p)
	if not __wf_atom_7e8ad928(v) then
		if Engine.__wf_atom_dd1285f1() then
			v:SelectElementById((tonumber(p)))
		else
			v:FocusElementById((tonumber(p)))
		end
	end
end

function BetUnfocused(p)
	if not __wf_atom_7e8ad928(v) then
		v:UnfocusElementById((tonumber(p)))
	end
end

function BetSelected(p)
	if not (__wf_atom_7e8ad928(v) or v2) then
		v:SelectElementById((tonumber(p)))
	end
end

function onKeyDown_MENU_SELECT()
	if not v2 and Engine.IsPlayingWithController() and not __wf_atom_7e8ad928(v) then
		local focusedElement = v:GetFocusedElement()

		if not __wf_atom_7e8ad928(focusedElement) and focusedElement.Active then
			v:SelectCurrentElement()
		end
	end
end

function SupportsThemes()
	return true
end