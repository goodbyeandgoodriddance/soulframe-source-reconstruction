local v = nil
local v2 = nil
local v3 = nil
local v4 = 0
local v5 = nil
local v6 = nil
local v7 = 0
local v8 = nil
local module = require("EE.Interface.AnchorMgr")
local v9 = nil
local module2 = require("EE.Interface.Utilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.CrossPlatformUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
require("Lotus.Scripts.Duviri.Encounters.DuviriRewardsLib")
local v10 = false
local v11 = false
local flag = false
local v12 = false
local avatar = nil
local v13 = nil
local v14 = {
	Heading = __wf_atom_10cd16b2(0, 0.05),
	Pitch = __wf_atom_10cd16b2(0, 0.05),
	Bank = __wf_atom_10cd16b2(0, 0.05),
	FirstUpdate = true
}
local v15 = 0
local v16 = false
local v17 = false
local flag2 = false
local v18 = false
local v19 = { DeadTimeTag = "PlayerDeadTime_", StackTimer = 180, NumStacks = 0 }
local v20 = false
local v21 = true
local total = 0
local v22 = {}
local flag3 = false
local v23 = nil
local v24 = nil
local v25 = nil

function IsInputBlocked()
	return v10
end

function onViewportSizeChanged(p, p2, _, _)
	if not __wf_atom_7e8ad928(v9) then
		v9:Update(p, p2)
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:RepositionElements()
	end

	local screenDimensions, _ = module2.GetScreenDimensions(mMovie)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SelectorMenu", 14)
	mMovie:__wf_atom_e57658c2("SelectorBg", 14, __wf_atom_5e6e15c8)
	local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("SelectorMenu", 1)
	mMovie:__wf_atom_5e6e15c8("SelectorMenu", 15)
	local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("SelectorMenu.PlayerButton", 1)
	local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8("SelectorMenu.PlayerButton.Label", 1)
	local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8("SelectorMenu.PlayerButton.Label", 15)
	mMovie:__wf_atom_e57658c2(
		"SelectorBg",
		1,
		__wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 + __wf_atom_5e6e15c8_4 + __wf_atom_5e6e15c8_5 / 2 - 6
	)
	mMovie:__wf_atom_e57658c2("SelectorShadow", 14, screenDimensions + 20)
end

local function fn()
	local __wf_atom_d2b2176d = gRegion:__wf_atom_c4f78a8f():__wf_atom_d2b2176d()
	local __wf_atom_b8ebbaca = __wf_atom_d2b2176d:__wf_atom_b8ebbaca(0, 0, false)
	local __wf_atom_b8ebbaca2 = __wf_atom_d2b2176d:__wf_atom_b8ebbaca(0, 1, false)
	local __wf_atom_b8ebbaca3 = __wf_atom_d2b2176d:__wf_atom_b8ebbaca(0, 2, false)
	local __wf_atom_b8ebbaca4 = __wf_atom_d2b2176d:__wf_atom_b8ebbaca(0, 3, false)
	local __wf_atom_dd42a319 = __wf_atom_d2b2176d:__wf_atom_dd42a319(false)
	local __wf_atom_293bca72 = __wf_atom_d2b2176d:__wf_atom_293bca72(false)
	return __wf_atom_b8ebbaca + __wf_atom_b8ebbaca2 + __wf_atom_b8ebbaca3 + __wf_atom_b8ebbaca4 + __wf_atom_dd42a319 + __wf_atom_293bca72 + 0 + 0 + 0
end

local function fn2()
	if gRegion:IsMaster() then
		local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()

		if
			not string.match(__wf_atom_ade7f08f.level:GetName(), "Crypt")
			and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
		then
			__wf_atom_ade7f08f.migrateServer = false
			local all = gRegion:FindAll(__wf_atom_bc9e92c8)

			for _, v26 in ipairs(all) do
				local __wf_atom_babe9f00 = v26:__wf_atom_babe9f00()

				if not (string.len(__wf_atom_babe9f00) > 0) then
					continue
				end

				__wf_atom_ade7f08f.contextTags = {}
				__wf_atom_ade7f08f:__wf_atom_98718663(__wf_atom_babe9f00)
				break
			end

			Engine.OpenLevel(__wf_atom_ade7f08f)
		end
	else
		Engine.Disconnect(false)
	end
end

function DbUpdateComplete(_, _)
	print("DbUpdateComplete, disconnecting")

	if gGameRules:__wf_atom_3d21c15e() and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_66a27504()
	end

	fn2()
	mMovie:Close()
end

function MainMenuConfirm(p)
	print("SpectatorHud: MainMenuConfirm(" .. tostring(p) .. ")")
	local gGameRules = gGameRules
	v10 = false
	v16 = false
	v15 = 0
	mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", v15 / 1, 0, 0, 0)

	if tonumber(p) == 4 then
		if
			(__wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) or not (gGameRules:InDojo() or gGameRules:__wf_atom_f4503a61()))
			and not __wf_atom_72884638("LotusGameRules.DemoMode")
		then
			if gGameRules:__wf_atom_8cc6640f() then
				v5 = module2.ShowMessage("/Lotus/Language/Menu/CouldNotAbortAlreadyCompleted")
			elseif gGameRules:MissionFailed() then
				v5 = module2.ShowMessage("/Lotus/Language/Menu/CouldNotAbortAlreadyFailed")
			else
				gGameRules:OnPlayerQuitting("DbUpdateComplete")
			end
		else
			if not gMatchingService:__wf_atom_607c7363() then
				gMatchingService:LeaveSquad()
			end

			fn2()
			print("SpectatorHud: Close one")
			mMovie:Close()
		end
	end
end

local function fn3()
	if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_e23b2855()) then
		return
	end

	local v26 = gRegion:__wf_atom_e23b2855()[1]

	if __wf_atom_7e8ad928(v26) then
		return
	end

	local __wf_atom_eff0517e = v26:__wf_atom_eff0517e()

	if gGameRules:IsA(__wf_atom_fa19955e) then
		__wf_atom_eff0517e = v26:__wf_atom_50a7d83e()
	end

	if __wf_atom_7e8ad928(__wf_atom_eff0517e) then
		return
	end

	local reviveCountOverride = __wf_atom_eff0517e:__wf_atom_523951a1()

	if _T.ReviveCountOverride then
		reviveCountOverride = _T.ReviveCountOverride
	end

	local __wf_atom_7ebb5a37 = __wf_atom_eff0517e:__wf_atom_7ebb5a37()

	if not flag2 then
		v4 = reviveCountOverride - __wf_atom_7ebb5a37
	end

	mMovie:__wf_atom_50d60589("RevivePanel.RevivesLeft", 36, (tonumber(v4)))
	v17 = true
end

function ConfirmPopup() end

local function fn4(_)
	print("SpectatorHud: Close Called")

	if flag then
		return
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput()
	end

	gGameRules:__wf_atom_c61d8ba7()
	mMovie:Close()

	if Engine.__wf_atom_2a979d69() and not __wf_atom_7e8ad928(_T.Touch_OnPlayerAliveStatusChanged) then
		_T.Touch_OnPlayerAliveStatusChanged(false)
	end

	flag = true

	if not __wf_atom_7e8ad928(mixer) then
		mixer:__wf_atom_c1782862(0)
	end
end

local function fn5()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return false
	end

	local motionControl = __wf_atom_c4f78a8f:MotionControl()

	if __wf_atom_7e8ad928(motionControl) then
		print("SpectatorHUD:  preDeathPlayer:MotionControl is nil")
	elseif gGameRules:__wf_atom_e22d6f15() == 39 then
		return false
	else
		return motionControl:__wf_atom_7099dee1()
	end

	return false
end

local function fn6()
	__wf_atom_ec43d06e(mMovie, "RevivePanel", 2, { 12 }, { 0 }, 0.5, 0, function()
		v12 = true
	end)
end

function OnRevivePressed()
	if not v10 then
		if gGameRules:InDojo() then
			return
		end

		v10 = true
		fn6()
		local reviveFX = reviveFX
		local rootBasedPosition, v26 = module2.GetRootBasedPosition(mMovie, "RevivePanel")

		if not __wf_atom_7e8ad928(reviveFX) then
			module3.CreateScreenParticles(mMovie, reviveFX, rootBasedPosition, v26 - 60)
		end

		module2.PlaySound(reviveSound)
	end
end

function OnAbortPressed()
	if not v10 then
		if flag2 then
			v5 = module2.ShowYesOrNoMessage("/SF/Language/Menu/LeavePartyDead", "MainMenuConfirm")
		elseif gGameRules:__wf_atom_43133207() then
			v5 = module2.ShowYesOrNoMessage("/SF/Language/Menu/LeavePartyDead", "MainMenuConfirm")
		else
			v5 = module2.ShowYesOrNoMessage("/SF/Language/Menu/LeavePartyDead", "MainMenuConfirm")
		end
	end
end

local function fn7()
	if v10 or gGameRules:InDojo() then
		return
	end

	v10 = true

	if gGameRules:IsA(__wf_atom_fa19955e) then
		module2.PlaySound(duviriReviveStartSound)
	else
		module2.PlaySound(reviveCompleteSound)
	end

	if not __wf_atom_7e8ad928(v23) then
		v23:Stop(false)
	end

	if not __wf_atom_7e8ad928(v24) then
		v24:Stop(false)
	end

	if not __wf_atom_7e8ad928(v25) then
		v25:Stop(false)
	end

	if v4 > 0 then
		fn6()
		local reviveFX = reviveFX
		local rootBasedPosition, v26 = module2.GetRootBasedPosition(mMovie, "RevivePanel")

		if not __wf_atom_7e8ad928(reviveFX) then
			module3.CreateScreenParticles(mMovie, reviveFX, rootBasedPosition, v26 - 60)
		end

		module2.PlaySound(reviveSound)
	else
		if flag2 then
			v5 = module2.ShowYesOrNoMessage("/SF/Language/Menu/LeavePartyDead", "MainMenuConfirm")
			return
		end

		if gGameRules:__wf_atom_43133207() then
		end

		v5 = module2.ShowYesOrNoMessage("/SF/Language/Menu/LeavePartyDead", "MainMenuConfirm")
	end
end

function OnClosePressed()
	v10 = true
	fn4(true)
end

local function fn8()
	v22.Background1 = module5.GetColor(2, true)
	v22.FloatingContent = module5.GetColor(9, true)
	v22.FloatingContentHighlight = module5.GetColor(10, true)
	v22.Negative = module5.GetColor(12, true)
	v22.FloatingContentHex = module2.ConvertColorNumberToHex(v22.FloatingContent)
	v22.FloatingContentHighlightHex = module2.ConvertColorNumberToHex(v22.FloatingContentHighlight)
	local convertColorNumberToProceduralRGB = module2.ConvertColorNumberToProceduralRGB(v22.Background1)
	local convertColorNumberToProceduralRGB2 = module2.ConvertColorNumberToProceduralRGB(v22.FloatingContent)
	module2.ConvertColorNumberToProceduralRGB(v22.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Backer", 11, v22.FloatingContent)
	mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Backer", 12, 40)
	mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Diamond", 11, v22.Background1)
	mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Diamond", 12, 80)
	mMovie:__wf_atom_e57658c2("RevivePanel.Shadow", 11, v22.Background1)
	mMovie:__wf_atom_e57658c2("RevivePanel.RevivesLeft", 44, v22.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("RevivePanel.Callout", 11, v22.FloatingContent)

	if v4 > 0 then
		mMovie:__wf_atom_2dedec1a("RevivePanel.RevivesLeft", 13, not _T.InfiniteRevives)
		mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Fill", 11, v22.FloatingContentHighlight)
		__wf_atom_86cbd68d(mMovie, "RevivePanel.HoldProgress.IconContainer.gotoAndStop", "Revive")

		if v18 then
			mMovie:OverrideMaterial("RevivePanel.HoldProgress.IconContainer.SpiralIcon", duviriIconMaterial)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Icon", 12, 0)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Blur", 12, 0)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.IconShadow", 12, 0)
		else
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.SpiralIcon", 12, 0)
			mMovie:OverrideMaterial("RevivePanel.HoldProgress.IconContainer.Icon", shineMaterial)
			mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.IconContainer.Icon", "RippleCenter", 0.4, 0.5, 0, 0)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Icon", 11, v22.FloatingContentHighlight)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Fill", 11, v22.FloatingContentHighlight)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Blur", 11, v22.FloatingContentHighlight)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.IconShadow", 11, v22.Background1)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.IconShadow", 12, 80)
		end
	else
		mMovie:__wf_atom_2dedec1a("RevivePanel.RevivesLeft", 13, false)
		mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.Fill", 11, v22.Negative)
		__wf_atom_86cbd68d(mMovie, "RevivePanel.HoldProgress.IconContainer.gotoAndStop", "Abandon")
		mMovie:__wf_atom_c90af43a("RevivePanel.HoldProgress.IconContainer.Icon", abandonIcon)

		if v18 then
			mMovie:OverrideMaterial("RevivePanel.HoldProgress.IconContainer.SpiralIcon", duviriIconMaterial)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Icon", 11, v22.FloatingContentHighlight)
		else
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.SpiralIcon", 12, 0)
			mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress.IconContainer.Icon", 11, v22.FloatingContent)
		end
	end

	mMovie:OverrideMaterial("SelectorBg.Border", _G.UIMaterial_BackerBorderSingle)
	mMovie:__wf_atom_e57658c2("SelectorBg.Border", 11, _G.UIColor_Gold)
	mMovie:OverrideMaterial("SelectorBg.Blurer", _G.UIMaterial_BackerBorderFill)
	mMovie:OverrideMaterial("SelectorBg.Backer", _G.UIMaterial_BackerBorderFill)
	mMovie:__wf_atom_e57658c2("SelectorBg.Backer", 12, _G.UIAlpha_FadedBacker)
	mMovie:__wf_atom_e57658c2("SelectorBg.Backer", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_e57658c2("CalloutRt", 44, v22.FloatingContent)
	mMovie:__wf_atom_e57658c2("CalloutLt", 44, v22.FloatingContent)
	mMovie:__wf_atom_e57658c2("SelectorShadow", 11, v22.Background1)
	mMovie:__wf_atom_e57658c2("SelectorMenu.Selected.Icon", 11, v22.FloatingContent)
	mMovie:__wf_atom_e57658c2("SelectorLineLeft", 11, v22.FloatingContent)
	mMovie:__wf_atom_e57658c2("SelectorLineRight", 11, v22.FloatingContent)
	mMovie:OverrideMaterial("SelectorMenu.Selected.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:__wf_atom_1ca72041(
		"SelectorMenu.Selected.Bg",
		"RectInnerColor",
		convertColorNumberToProceduralRGB.r,
		convertColorNumberToProceduralRGB.g,
		convertColorNumberToProceduralRGB.b,
		1
	)
	mMovie:__wf_atom_1ca72041(
		"SelectorMenu.Selected.Bg",
		"RectEdgeColor",
		convertColorNumberToProceduralRGB2.r,
		convertColorNumberToProceduralRGB2.g,
		convertColorNumberToProceduralRGB2.b,
		1
	)
end

local function fn9()
	local module7 = require("Lotus.Interface.Components.ThemedButton")
	local module8 = require("EE.Interface.Components.List")
	v8 = module8.CreateList(mMovie, "SelectorMenu.PlayerButton")
	v8.mForcedVerticalSeparation = 0
	v8.mInitialDepth = 4000
	v8.mLabelScale = module2.Ternary(Engine.__wf_atom_578fc9dd(), 1.2, 1)

	function v8.Print(p, p2)
		print(p.mPrefix .. p2)
	end

	function v8:mElementDrawCallback()
		if __wf_atom_7e8ad928(self.mBtn) then
			self.mBtn = module7.Create(mMovie, self.mClipName, self.Name, nil, nil)

			function self.mBtn.mOnPressedCallback()
				v8:SelectElementById(self.Id)
			end

			self.mBtn:SetWidth(200)
			self.mBtn:SetId(self.Id)
			self.mBtn.mInnerAlpha = 0
			self.mBtn.mUnfocusedEdgeColor = 10
			self.mBtn.mEdgeAlpha = 0
			self.mBtn.mShowUnderline = false
			self.mBtn.mHeight = 48
			self.mBtn.mApplyThemes = false
			self.mBtn.mInactiveAlpha = 50
			self.mBtn:UpdateColors()
			self.mBtn:SetText(self.Name)
			self.mBtn._Button_Redraw = self.mBtn.Redraw

			function self.mBtn:Redraw()
				self:_Button_Redraw()
				local _mMovie = self.mMovie
				local mMovie = self.mMovie
				local mClipName = self.mClipName
				self:UpdateColors()
				self:OnGamepadTransition()
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 90, 0)
				mMovie:__wf_atom_4c1c1986(mClipName, "Label", 91, 100)
			end

			self.mBtn:Resize()

			function self.mBtn.mOnFocusedCallback()
				v8:FocusElementById(self.Id)
			end

			function self.mBtn.mOnUnfocusedCallback()
				v8:UnfocusElementById(self.Id)
			end

			self.mBtn:SetVisible(true)
			self.mBtn:Redraw()
		end
	end

	function v8.mOnFocusedCallback(_)
		module2.PlaySound(_G.UISound_Focus)
	end

	function v8.mOnUnfocusedCallback(_) end

	function v8:mOnSelectedCallback()
		module2.PlaySound(_G.UISound_Select)
		local name = self.Name

		if not v10 then
			local __wf_atom_b56d2aa8 = gGameRules:__wf_atom_b56d2aa8()

			if not __wf_atom_7e8ad928(__wf_atom_b56d2aa8) then
				__wf_atom_b56d2aa8:Execute("SwitchSpectator", name)
			end
		end

		local v26 = mMovie:__wf_atom_5e6e15c8(self.mClipName, 0) + self.BgWidth / 2

		if __wf_atom_7e8ad928(self.Avatar) and not __wf_atom_7e8ad928(self.Player) then
			self.Avatar = self.Player:__wf_atom_50a7d83e()
		end

		avatar = self.Avatar
		v14.FirstUpdate = true

		for i = 1, 5 do
			mMovie:OverrideMaterial("Divider" .. i, verticalDividerMaterial)
			mMovie:__wf_atom_2dedec1a("Divider" .. i, 13, false)
		end

		local howManyElements = v8:GetHowManyElements()

		for i = 1, howManyElements do
			local elementInIndex = v8:GetElementInIndex(i)
			mMovie:__wf_atom_7f57ab2f(elementInIndex.mBtn.mClipName, "NewHighlight", 13, false)
			mMovie:__wf_atom_e57658c2(elementInIndex.mBtn.mClipName .. ".Label", 11, _G.UIColor_Gold)
			elementInIndex.mBtn.mActiveColor = _G.UIColor_Gold
			elementInIndex.mBtn.mInactiveColor = _G.UIColor_Gold
			mMovie:__wf_atom_2dedec1a("Divider" .. i, 13, i < howManyElements)

			if not (i < howManyElements) then
				continue
			end

			local elementInIndex2 = v8:GetElementInIndex(i + 1)
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("SelectorMenu", 0)
			local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("SelectorMenu", 1)
			local __wf_atom_5e6e15c8_3 = mMovie:__wf_atom_5e6e15c8("SelectorMenu", 15)
			local __wf_atom_5e6e15c8_4 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mClipName, 0)
			local __wf_atom_5e6e15c8_5 = mMovie:__wf_atom_5e6e15c8(elementInIndex2.mClipName, 0)
			mMovie:__wf_atom_5e6e15c8(elementInIndex.mBtn.mClipName, 0)
			mMovie:__wf_atom_5e6e15c8(elementInIndex2.mBtn.mClipName, 0)
			local __wf_atom_5e6e15c8_6 = mMovie:__wf_atom_5e6e15c8(elementInIndex.mBtn.mClipName .. ".Label", 40)
			local __wf_atom_5e6e15c8_7 = mMovie:__wf_atom_5e6e15c8(elementInIndex2.mBtn.mClipName .. ".Label", 40)
			mMovie:__wf_atom_5e6e15c8(elementInIndex.mBtn.mClipName .. ".Label", 0)
			mMovie:__wf_atom_5e6e15c8(elementInIndex2.mBtn.mClipName .. ".Label", 0)
			local midpoint = (__wf_atom_5e6e15c8_4 + elementInIndex.BgWidth / 2 + __wf_atom_5e6e15c8_6 / 2 + (__wf_atom_5e6e15c8_5 + elementInIndex2.BgWidth / 2 - __wf_atom_5e6e15c8_7 / 2)) / 2
			mMovie:__wf_atom_e57658c2("Divider" .. i, 0, __wf_atom_5e6e15c8 + math.floor(midpoint))
			mMovie:__wf_atom_e57658c2("Divider" .. i, 1, __wf_atom_5e6e15c8_2 + __wf_atom_5e6e15c8_3 / 4)
		end

		mMovie:__wf_atom_7f57ab2f(self.mBtn.mClipName, "NewHighlight", 13, true)
		mMovie:__wf_atom_e57658c2(self.mBtn.mClipName .. ".Label", 11, _G.UIColor_Yellow)
		self.mBtn.mActiveColor = _G.UIColor_Yellow
		self.mBtn.mInactiveColor = _G.UIColor_Yellow
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(self.mBtn.mClipName .. ".Label", 40)
		mMovie:__wf_atom_4c1c1986(self.mBtn.mClipName, "NewHighlight", 14, __wf_atom_5e6e15c8)
		mMovie:__wf_atom_4c1c1986(self.mBtn.mClipName, "NewHighlight", 14, __wf_atom_5e6e15c8 + 100)
		mMovie:__wf_atom_4c1c1986(self.mBtn.mClipName, "NewHighlight", 0, (__wf_atom_5e6e15c8 + 40) / 2)
		mMovie:__wf_atom_4c1c1986(self.mBtn.mClipName, "NewHighlight", 12, 35)
		mMovie:__wf_atom_e57658c2("SelectorMenu.Selected", 0, v26)
		mMovie:__wf_atom_2dedec1a("SelectorMenu.Selected", 13, false)
	end

	function v8:RepositionElements()
		local howManyElements = self:GetHowManyElements()
		local newX = 0

		for i = 1, howManyElements do
			local elementInIndex = self:GetElementInIndex(i)
			local mClipName = elementInIndex.mClipName
			elementInIndex.NewX = newX
			local bgWidth = math.max(mMovie:__wf_atom_5e6e15c8(elementInIndex.mBtn.mClipName .. ".Label", 40) + 20, 200)
			elementInIndex.mBtn:SetWidth(bgWidth)
			elementInIndex.BgWidth = bgWidth
			newX = newX + elementInIndex.BgWidth + 0
			mMovie:__wf_atom_4c1c1986(mClipName, "Btn", 14, elementInIndex.BgWidth)
			mMovie:__wf_atom_4c1c1986(mClipName, "Bg", 14, elementInIndex.BgWidth)
		end

		for i = 1, howManyElements do
			local elementInIndex = self:GetElementInIndex(i)
			local mClipName = elementInIndex.mClipName
			mMovie:__wf_atom_e57658c2(mClipName, 0, self.mInitialX + elementInIndex.NewX)
		end

		mMovie:__wf_atom_e57658c2("SelectorMenu", 0, (mMovie:__wf_atom_97cd8326() - newX) * 0.5)
	end

	v8._SpectatorMenu_Redraw = v8.Redraw

	function v8:Redraw(p, p2, p3)
		self:_SpectatorMenu_Redraw(p, p2, p3)
		self:RepositionElements()
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for i = 1, #__wf_atom_3c8e1a7a do
		if __wf_atom_3c8e1a7a[i]:IsLocal() then
			continue
		end

		local v26 = __wf_atom_3c8e1a7a[i]
		local name = __wf_atom_7e8ad928(v26) and ""
			or module4.GetCrossPlatformUniquePlayerName(v26:__wf_atom_6be84646(), __wf_atom_3c8e1a7a, nil, true)

		if name ~= module3.HIDDEN_PLAYER_NAME then
			v8:AddElement(
				{
					Name = name,
					Player = __wf_atom_3c8e1a7a[i],
					Avatar = __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e()
				},
				true
			)
		end
	end

	mMovie:__wf_atom_c90af43a("SelectorMenu.Selected.Icon", viewIcon)
	__wf_atom_86cbd68d(mMovie, "SelectorMenu.Selected.swapDepths", 5000)
	v8:Redraw(nil, true, true)
	v8:RepositionElements()

	if v8:GetHowManyElements() > 0 then
		v8:FocusElement(1)
		v8:SelectCurrentElement()
		mMovie:__wf_atom_7d7314f1("CalloutLt.text", "<MENU_LTRIGGER2>")
		mMovie:__wf_atom_7d7314f1("CalloutRt.text", "<MENU_RTRIGGER2>")
		mMovie:__wf_atom_2dedec1a("CalloutLt", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_2dedec1a("CalloutRt", 13, Engine.IsPlayingWithController())
	end
end

function OnPlayersChanged()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	v7 = #__wf_atom_3c8e1a7a
	v13 = nil

	if v7 == 0 then
		return
	end

	if __wf_atom_7e8ad928(v8) and v7 > 1 then
		fn9()
	elseif not __wf_atom_7e8ad928(v8) then
		local v26 = {}

		for i = 1, #v8.mElements do
			v26[v8.mElements[i].Id] = true
		end

		for i = 1, v7 do
			if __wf_atom_3c8e1a7a[i]:IsLocal() then
				continue
			end

			local v27 = __wf_atom_3c8e1a7a[i]
			local name = __wf_atom_7e8ad928(v27) and ""
				or module4.GetCrossPlatformUniquePlayerName(v27:__wf_atom_6be84646(), __wf_atom_3c8e1a7a, nil, true)
			local v28 = false

			for j = 1, #v8.mElements do
				local mElement = v8.mElements[j]

				if mElement.Name ~= name then
					continue
				end

				v26[mElement.Id] = nil
				v28 = true
				break
			end

			if v28 or name == module3.HIDDEN_PLAYER_NAME then
				continue
			end

			v8:AddElement(
				{
					Name = name,
					Player = __wf_atom_3c8e1a7a[i],
					Avatar = __wf_atom_3c8e1a7a[i]:__wf_atom_50a7d83e()
				},
				true
			)
		end

		local v27 = false

		for k, _ in pairs(v26) do
			v27 = v8.mSelectedElement and v8.mSelectedElement.Id == k and true or v27
			v8:RemoveElementById(k)
		end

		v8:Redraw(nil, true, true)
		v8:RepositionElements()

		if v27 and v8:GetHowManyElements() > 0 then
			v8:GetElementInIndex(1).mBtn:TryPressed(true)
		end
	end

	mMovie:__wf_atom_2dedec1a("SelectorMenu", 13, v7 > 1)
	mMovie:__wf_atom_2dedec1a("SelectorBg", 13, v7 > 1)
	mMovie:__wf_atom_2dedec1a("SelectorLineLeft", 13, v7 > 1)
	mMovie:__wf_atom_2dedec1a("SelectorLineRight", 13, v7 > 1)

	if not __wf_atom_7e8ad928(v8) and v8:GetHowManyElements() > 0 then
		mMovie:__wf_atom_7d7314f1("CalloutLt.text", "<MENU_LTRIGGER2>")
		mMovie:__wf_atom_7d7314f1("CalloutRt.text", "<MENU_RTRIGGER2>")
		mMovie:__wf_atom_2dedec1a("CalloutLt", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_2dedec1a("CalloutRt", 13, Engine.IsPlayingWithController())
	end
end

local function fn10()
	v20 = false
	gGameRules:RespawnPlayer(gRegion:__wf_atom_eab484a7(), v21)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		__wf_atom_c4f78a8f:Attach(reviveFXType, EMPTY_SYMBOL)

		if _T.InfiniteRevives then
			__wf_atom_c4f78a8f:__wf_atom_5b93785b(0)
		end
	end

	gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	fn4(false)
end

local function fn11()
	return v15 / 1
end

local function fn12(p)
	if p then
		if v4 > 0 then
			if gGameRules:IsA(__wf_atom_fa19955e) then
				module2.PlaySound(duviriRevivePressSound)
			else
				module2.PlaySound(reviveStartSound)
				v25 = module2.PlaySound(reviveLoopSound)
			end

			v16 = true
		end
	elseif v4 > 0 then
		v16 = false
		v15 = 0
		mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)

		if not __wf_atom_7e8ad928(v25) then
			v25:Stop(false)
			v25 = nil
		end
	end
end

local function fn13(p)
	if p then
		if v4 <= 0 then
			v16 = true
		end
	elseif v4 <= 0 then
		v16 = false
		v15 = 0
		mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)
	end
end

function Initialize()
	if (__wf_atom_7e8ad928(_T.MissionEnded) or not _T.MissionEnded) and not _G.StalkerMode then
		for _, v26 in ipairs(moviesToClose) do
			local movie = __wf_atom_8e4fda44:FindMovie(v26)

			if not __wf_atom_7e8ad928(movie) then
				movie:Close()
			end
		end

		v10 = false
		flag2 = true
		v18 = not __wf_atom_7e8ad928(gGameRules) and gGameRules:IsA(__wf_atom_fa19955e)

		if _T.InstantRevive then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
			local __wf_atom_04b7536b = __wf_atom_eab484a7:__wf_atom_04b7536b()
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if
				not __wf_atom_7e8ad928(__wf_atom_04b7536b)
				and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
				and __wf_atom_c4f78a8f ~= __wf_atom_04b7536b
			then
				__wf_atom_eab484a7:AssignAvatar(__wf_atom_04b7536b)
				__wf_atom_04b7536b:Suicide()
			end

			print("SpectatorHud: CRespawnPlayerFunc")
			v21 = false
			v20 = true
			print("SpectatorHud: Early out from initialize _T.InstantRevive=" .. tostring(_T.InstantRevive))
			fn10()
		else
			if _T.forceLocalRespawn then
				print("SpectatorHud: Reviving self")
				mMovie:__wf_atom_2dedec1a("_root", 13, false)
			end

			_T.ForceShowHudTrackers = true
			_T.ForceShowHealthShield = true
			_T.ForceShowMiniMap = true

			if Engine.__wf_atom_dd1285f1() then
				_T.SpectatorHD_HoldingRevive = fn12
				_T.SpectatorHD_HoldingExit = fn13
				_T.SpectatorHD_GetReviveProgress = fn11

				function _T.SpectatorHD_GetRevivesLeft()
					return v4
				end
			end

			gRegion:__wf_atom_d5ede414("OnPlayersChanged")
			mMovie:OverrideMaterial("RevivePanel.HoldProgress.Backer", diamondMaterial)
			mMovie:OverrideMaterial("RevivePanel.HoldProgress.Fill", diamondProgressMaterial)
			mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)
			mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Backer", "CircleSettings", 0.485, 0.2, 0.65, 0)
			mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "CircleSettings", 0.485, 0.2, 0.65, 0)
			mMovie:__wf_atom_2dedec1a("CalloutLt", 13, false)
			mMovie:__wf_atom_2dedec1a("CalloutRt", 13, false)
			mMovie:__wf_atom_2dedec1a("AfkWarning", 13, false)
			mMovie:__wf_atom_7d7314f1("AfkWarning.text", "/Lotus/Language/SystemMessages/SpectatorAfkWarning")
			v9 = module.Create(mMovie)
			v9:Register(mMovie, "SelectorBg", { v9.ANCHOR_V_BOTTOM })
			v9:Register(mMovie, "SelectorLineLeft", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_LEFT })
			v9:Register(mMovie, "SelectorLineRight", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_RIGHT })
			v9:Register(mMovie, "SelectorMenu", { v9.ANCHOR_V_BOTTOM })
			v9:Register(mMovie, "RevivePanel", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_CENTRE })
			v9:Register(mMovie, "ConquestPanel", { v9.ANCHOR_V_TOP, v9.ANCHOR_H_CENTRE })
			v9:Register(mMovie, "SelectorShadow", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_CENTRE })
			v9:Register(mMovie, "CalloutLt", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_CENTRE })
			v9:Register(mMovie, "CalloutRt", { v9.ANCHOR_V_BOTTOM, v9.ANCHOR_H_CENTRE })
			local deathLoopSound = deathLoopSound
			local duviriDeathSoundLoop2 = nil

			if gGameRules:IsA(__wf_atom_fa19955e) then
				module2.PlaySound(duviriDeathStartSound)
				deathLoopSound = duviriDeathMusicLoop
				duviriDeathSoundLoop2 = duviriDeathSoundLoop
			else
				module2.PlaySound(deathStartSound)
			end

			if not __wf_atom_7e8ad928(deathLoopSound) then
				v23 = module2.PlaySound(deathLoopSound)
			end

			if not __wf_atom_7e8ad928(duviriDeathSoundLoop2) then
				v24 = module2.PlaySound(duviriDeathSoundLoop2)
			end

			v7 = #gRegion:__wf_atom_3c8e1a7a()
			local v26 = gRegion:__wf_atom_e23b2855()[1]
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if __wf_atom_7e8ad928(v26) or __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
				print("SpectatorHud: Closing from intialize part 2")
				print("humanPlayer=" .. tostring(v26))
				print("playerAvatar=" .. tostring(__wf_atom_c4f78a8f))
				fn4(true)
			else
				if __wf_atom_c4f78a8f:IsA(ghostType) then
					print("SpectatorHud: Closing from intialize part 3, player was a ghost! spooooky")
					fn4(false)
				end

				v6 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
				fn3()
				local __wf_atom_4dc54686 = mMovie:__wf_atom_4dc54686()
				local v27

				if v4 <= 0 then
					if v7 == 1 then
						print("SpectatorHud: Closing from intialize part 4, no revives and I was the only player")
						fn4(true)
						return
					else
						mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress", 5, 80)
						mMovie:__wf_atom_e57658c2("RevivePanel.HoldProgress", 6, 80)
						v27 = "/Lotus/Language/SystemMessages/AbandonPrompt"
					end
				else
					v27 = "/Lotus/Language/SystemMessages/RevivePrompt"
				end

				local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c(v27, __wf_atom_4dc54686)
				mMovie:__wf_atom_50d60589("RevivePanel.Callout", 36, __wf_atom_c7fa5e0c)
				mMovie:__wf_atom_50d60589(
					"Prompt.PromptLabel.Label",
					36,
					mMovie:__wf_atom_c7fa5e0c("/SF/Language/SystemMessages/AbandonPrompt", __wf_atom_4dc54686)
				)
				mMovie:__wf_atom_e57658c2("Prompt.PromptLabel.Label", 44, _G.UIColor_Yellow)
				mMovie:OverrideMaterial("Prompt.PromptLabel.Backer.Blurer", _G.UIMaterial_BackerBorderFill)
				mMovie:OverrideMaterial("Prompt.PromptLabel.Backer.Backer", _G.UIMaterial_DarkPaperBacker)
				mMovie:__wf_atom_e57658c2("Prompt.PromptLabel.Backer.Backer", 12, _G.UIAlpha_FadedBacker)
				mMovie:__wf_atom_e57658c2("Prompt.PromptLabel.Backer.Backer", 11, _G.UIColor_DarkerBrown)
				mMovie:__wf_atom_5e6e15c8("Prompt.PromptLabel.Label", 0)
				mMovie:__wf_atom_5e6e15c8("Prompt.PromptLabel.Label", 1)
				local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Prompt.PromptLabel.Label", 40)
				local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Prompt.PromptLabel.Label", 41)
				mMovie:__wf_atom_e57658c2("Prompt.PromptLabel.Backer", 14, __wf_atom_5e6e15c8 + 25)
				mMovie:__wf_atom_e57658c2("Prompt.PromptLabel.Backer", 15, __wf_atom_5e6e15c8_2 * 2 - 10)
				mMovie:__wf_atom_2dedec1a("RevivePanel", 13, false)

				if v7 > 1 then
					fn9()
				else
					mMovie:__wf_atom_2dedec1a("SelectorMenu", 13, false)
					mMovie:__wf_atom_2dedec1a("SelectorBg", 13, false)
					mMovie:__wf_atom_2dedec1a("SelectorLineLeft", 13, false)
					mMovie:__wf_atom_2dedec1a("SelectorLineRight", 13, false)
				end

				fn8()
				mMovie:__wf_atom_2dedec1a("ConquestPanel", 13, false)

				if v4 > 0 then
					if not (gGameRules:IsA(__wf_atom_fa19955e) or _T.InfiniteRevives) then
						local v28 = fn()
						local __wf_atom_dcad28e0 = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_dcad28e0()
						local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
							"/Lotus/Language/SystemMessages/AffinityCostInfo",
							false,
							{
								OPEN_COLOR = "<font color=\"" .. v22.FloatingContentHighlightHex .. "\">",
								CLOSE_COLOR = "</font>",
								COST = module2.FormatNumber(__wf_atom_dcad28e0, 0),
								TOTAL = module2.FormatNumber(v28, 0)
							}
						)
						local v29 = "<p><font color=\"" .. v22.FloatingContentHex .. "\">" .. __wf_atom_8e9ac384 .. "</font></p>"
						mMovie:__wf_atom_50d60589("RevivePanel.Status", 36, v29)
					end
				elseif flag2 then
					local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
						"/Lotus/Language/SystemMessages/NoReviveHint",
						false
					)
					mMovie:__wf_atom_50d60589(
						"RevivePanel.Status",
						36,
						"<p><font color=\"" .. v22.FloatingContentHighlightHex .. "\">" .. __wf_atom_8e9ac384 .. "</font></p>"
					)
				end

				mMovie:__wf_atom_e57658c2("RevivePanel", 12, 0)
				local particleFX = particleFX
				local rootBasedPosition, v28 = module2.GetRootBasedPosition(mMovie, "RevivePanel")

				if not __wf_atom_7e8ad928(particleFX) then
					module3.CreateScreenParticles(mMovie, particleFX, rootBasedPosition, v28 - 60)
				end

				gRegion:IsMaster()
				__wf_atom_ec43d06e(mMovie, "RevivePanel", 7, { 12 }, { 100 }, 0.5, 0, nil)

				if
					(__wf_atom_7e8ad928(_T.EnableUIInput) or Engine.__wf_atom_dd1285f1())
					and Engine.__wf_atom_dd1285f1()
					and not __wf_atom_7e8ad928(_T.Touch_OnPlayerAliveStatusChanged)
				then
					_T.Touch_OnPlayerAliveStatusChanged(true)
				end

				_T.SpectatorHudOpen = true
				gGameRules:__wf_atom_7f181659()
				local movie = __wf_atom_8e4fda44:FindMovie(module2.GetChatMovie())

				if not __wf_atom_7e8ad928(movie) and movie:Execute("IsMaximized", "") then
					movie:Execute("ToggleFocus", "")
				end

				local __wf_atom_6be84646 = v26:__wf_atom_6be84646()

				if gGameRules:__wf_atom_d163c8e5(Symbol("Alive_" .. __wf_atom_6be84646)) > 0 then
					flag3 = true
				end

				if Engine.__wf_atom_2a979d69() then
					ForceIconUpdate()
				end

				v11 = true
				onViewportSizeChanged(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f(), 1, 1)
				InitializePrompt()
			end
		end
	else
		print("SpectatorHud: Close from initialize")
		print("_T.MissionEnded=" .. tostring(_T.MissionEnded))
		print("_G.StalkerMode=" .. tostring(_G.StalkerMode))
		mMovie:Close()
	end
end

function SelectPressCallback(p, _)
	if p == "Use" and v4 > 0 then
		v16 = true
	end
end

function SelectReleaseCallback(p, _)
	if p == "Use" and v4 > 0 then
		v16 = false
		v15 = 0
		mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)
	end
end

local function fn14(object, p)
	if __wf_atom_7e8ad928(avatar) then
		avatar = object:__wf_atom_d891a752()
	end

	if not __wf_atom_7e8ad928(avatar) then
		local __wf_atom_4e50d390 = avatar:__wf_atom_4e50d390()

		if not gRegion:IsMaster() then
			if v14.FirstUpdate then
				v14.FirstUpdate = false
				v14.Heading:__wf_atom_4453e49c(__wf_atom_4e50d390.heading)
				v14.Pitch:__wf_atom_4453e49c(__wf_atom_4e50d390.pitch)
				v14.Bank:__wf_atom_4453e49c(__wf_atom_4e50d390.bank)
			else
				local __wf_atom_9e368823 = v14.Heading:__wf_atom_9e368823()
				local __wf_atom_9e368823_2 = v14.Pitch:__wf_atom_9e368823()
				local __wf_atom_9e368823_3 = v14.Bank:__wf_atom_9e368823()

				if __wf_atom_4e50d390.heading - __wf_atom_9e368823 > 180 then
					v14.Heading:__wf_atom_4453e49c(360 + __wf_atom_9e368823)
				elseif __wf_atom_9e368823 - __wf_atom_4e50d390.heading > 180 then
					v14.Heading:__wf_atom_4453e49c(__wf_atom_9e368823 - 360)
				end

				if __wf_atom_4e50d390.pitch - __wf_atom_9e368823_2 > 180 then
					v14.Pitch:__wf_atom_4453e49c(360 + __wf_atom_9e368823_2)
				elseif __wf_atom_9e368823_2 - __wf_atom_4e50d390.pitch > 180 then
					v14.Pitch:__wf_atom_4453e49c(__wf_atom_9e368823_2 - 360)
				end

				if __wf_atom_4e50d390.bank - __wf_atom_9e368823_3 > 180 then
					v14.Bank:__wf_atom_4453e49c(360 + __wf_atom_9e368823_3)
				elseif __wf_atom_9e368823_3 - __wf_atom_4e50d390.bank > 180 then
					v14.Bank:__wf_atom_4453e49c(__wf_atom_9e368823_3 - 360)
				end

				v14.Heading:__wf_atom_09294a87(__wf_atom_4e50d390.heading)
				v14.Pitch:__wf_atom_09294a87(__wf_atom_4e50d390.pitch)
				v14.Bank:__wf_atom_09294a87(__wf_atom_4e50d390.bank)
			end

			v14.Heading:Update(p)
			v14.Pitch:Update(p)
			v14.Bank:Update(p)
			__wf_atom_4e50d390.heading = v14.Heading:__wf_atom_9e368823()
			__wf_atom_4e50d390.pitch = v14.Pitch:__wf_atom_9e368823()
			__wf_atom_4e50d390.bank = v14.Bank:__wf_atom_9e368823()
		end

		object:__wf_atom_84645c5b(__wf_atom_4e50d390)
	end
end

function Update()
	if not v11 or __wf_atom_7e8ad928(mMovie) then
		return
	end

	if __wf_atom_7e8ad928(_T.MissionEnded) or not _T.MissionEnded then
		if not v17 then
			fn3()
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local v26 = (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or not __wf_atom_c4f78a8f:IsA(__wf_atom_7e6ed5fa))
			and true
			or __wf_atom_c4f78a8f:__wf_atom_73c496b3()

		if v20 and v26 then
			if fn5() and total < 15 then
				total += __wf_atom_084b3e93()
			else
				fn10()
			end
		end

		if v16 and v26 then
			v15 = math.min(v15 + __wf_atom_084b3e93(), 1)
			mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", v15 / 1, 0, 0, 0)

			if v15 == 1 then
				fn7()
			end
		end

		local v27 = v15 / 1
		mMovie:__wf_atom_1ca72041("Prompt.ProgressFill", "AlphaTestThreshold", v27, 0, 0, 0)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Prompt", 5)
		local v28 = __wf_atom_104bfe98(90, 140, (math.pow(v27, 0.5)))
		local v29 = __wf_atom_084b3e93()
		local v30 = __wf_atom_104bfe98(__wf_atom_5e6e15c8, v28, v29 * 5)
		mMovie:__wf_atom_e57658c2("Prompt", 5, v30)
		mMovie:__wf_atom_e57658c2("Prompt", 6, v30)
		local topMenuOpen

		if _T.TopMenuOpen == nil then
			topMenuOpen = false
		else
			topMenuOpen = _T.TopMenuOpen
		end

		local v31 = _T.NemesisPopup_RankUpVisible ~= nil and _T.NemesisPopup_RankUpVisible
		mMovie:SetVisible(not topMenuOpen and not v31 and v26)
		mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

		if not __wf_atom_7e8ad928(mixer) then
			local v32 = mMovie:__wf_atom_5e6e15c8("RevivePanel.HoldProgress", 12) * 0.01
			mixer:__wf_atom_c1782862(v32)
		end

		if
			not __wf_atom_7e8ad928(__wf_atom_c4f78a8f)
			and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:CameraControl())
			and __wf_atom_c4f78a8f:CameraControl():__wf_atom_e62e24d5()
			and __wf_atom_c4f78a8f:IsKilled()
		then
			local __wf_atom_eab484a7 = gRegion:__wf_atom_eab484a7()
			local __wf_atom_d891a752 = __wf_atom_c4f78a8f:CameraControl():__wf_atom_d891a752()

			if __wf_atom_d891a752 ~= __wf_atom_c4f78a8f then
				fn14(__wf_atom_eab484a7:CameraControl(), __wf_atom_fa1258d0())
			end

			if not (__wf_atom_7e8ad928(__wf_atom_d891a752) or __wf_atom_7e8ad928(v8)) then
				if __wf_atom_7e8ad928(v13) or v13.Avatar ~= __wf_atom_d891a752 then
					for i = 1, #v8.mElements do
						local mElement = v8.mElements[i]

						if __wf_atom_7e8ad928(mElement.Avatar) and not __wf_atom_7e8ad928(mElement.Player) then
							mElement.Avatar = mElement.Player:__wf_atom_50a7d83e()
						end

						if mElement.Avatar ~= __wf_atom_d891a752 then
							continue
						end

						v13 = mElement
						break
					end
				end

				if not __wf_atom_7e8ad928(v13) then
					local v32 = mMovie:__wf_atom_5e6e15c8(v13.mClipName, 0) + v13.BgWidth / 2
					mMovie:__wf_atom_e57658c2("SelectorMenu.Selected", 0, v32)
				end
			end

			if flag3 then
				__wf_atom_eab484a7:__wf_atom_98782515()
			elseif _T.IsLiteSortie and v4 <= 0 then
				local v32 = not __wf_atom_eab484a7:IsActive()
				mMovie:__wf_atom_2dedec1a("AfkWarning", 13, v32)
			end

			if _T.forceLocalRespawn then
				_T.forceLocalRespawn = nil

				if not (v10 or gGameRules:InDojo()) then
					v10 = true
					fn6()
					local reviveFX = reviveFX
					local rootBasedPosition, v32 = module2.GetRootBasedPosition(mMovie, "RevivePanel")

					if not __wf_atom_7e8ad928(reviveFX) then
						module3.CreateScreenParticles(mMovie, reviveFX, rootBasedPosition, v32 - 60)
					end

					module2.PlaySound(reviveSound)
				end
			end
		end

		if not (__wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_c4f78a8f:IsKilled() or __wf_atom_c4f78a8f:__wf_atom_7470861b():__wf_atom_bedb4e3f()) then
			print("SpectatorHud: Closing from update. Im actually alive?")
			fn4(false)
		end

		if v12 and not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsKilled() then
			print("SpectatorHud: CRespawnPlayerFunc")
			v21 = true
			v20 = true
			v12 = false
		end
	else
		print("SpectatorHud: Closing from update _T.MissionEnded=" .. tostring(_T.MissionEnded))
		mMovie:Close()
	end
end

function Shutdown()
	_T.SpectatorHudOpen = false
	_T.ForceShowHudTrackers = nil
	_T.ForceShowHealthShield = nil
	_T.ForceShowMiniMap = nil
	_T.SpectatorHD_HoldingRevive = nil
	_T.SpectatorHD_HoldingExit = nil
	_T.InfoPopup_Data = nil

	if Engine.__wf_atom_dd1285f1() then
		_T.SpectatorHD_GetReviveProgress = nil
		_T.SpectatorHD_GetRevivesLeft = nil
	end

	if not __wf_atom_7e8ad928(gRegion) then
		gRegion:__wf_atom_a5a32a3b("OnPlayersChanged")
	end
end

function Revive_Confirm(p)
	if tonumber(p) == 4 and not v10 then
		if gGameRules:InDojo() then
			return
		end

		v10 = true
		fn6()
		local reviveFX = reviveFX
		local rootBasedPosition, v26 = module2.GetRootBasedPosition(mMovie, "RevivePanel")

		if not __wf_atom_7e8ad928(reviveFX) then
			module3.CreateScreenParticles(mMovie, reviveFX, rootBasedPosition, v26 - 60)
		end

		module2.PlaySound(reviveSound)
	end
end

function Close_Confirm(p)
	if tonumber(p) == 4 then
		v10 = true
		fn4(true)
	end
end

function ConquestPanelFocused()
	local infoPopup_Data = {
		CustomEntry = true,
		Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Conquest/IdlePlayerPanelTitle", false),
		MetaData = { CustomTags = {} }
	}
	local v26 = "<font color=\"" .. v22.FloatingContentHex .. "\">"
	infoPopup_Data.LocalizedDesc = mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Conquest/HexConquest_IdlePlayerPopupDesc",
		false,
		{ OPEN_COLOR = v26, CLOSE_COLOR = "</font>" }
	)
	local ternary = module2.Ternary(
		v19.NumStacks == 1,
		"/Lotus/Language/Conquest/IdlePlayerPanelStackCountSingular",
		"/Lotus/Language/Conquest/IdlePlayerPanelStackCount"
	)
	table.insert(
		infoPopup_Data.MetaData.CustomTags,
		module6.GetInfoForLabel(
			module6.LABEL_TYPE_UNIQUE_TEXT,
			mMovie:__wf_atom_8e9ac384(ternary, false, {
				NUM = module2.FormatNumber(v19.NumStacks)
			})
		)
	)
	module6.SetItemInfoPopupRect(
		mMovie,
		infoPopup_Data,
		mMovie:__wf_atom_5e6e15c8("ConquestPanel", 2),
		mMovie:__wf_atom_5e6e15c8("ConquestPanel", 3),
		mMovie:__wf_atom_5e6e15c8("ConquestPanel.Btn", 14) - 20,
		100
	)
	_T.InfoPopup_Data = infoPopup_Data
end

function ConquestPanelUnfocused()
	_T.InfoPopup_Data = nil
end

function onKeyDown_MENU_LTRIGGER2()
	if not v10 and v8 ~= nil and Engine.IsPlayingWithController() then
		v8:SelectElementInDirection(module2.DECREMENT)
	end
end

function onKeyDown_MENU_RTRIGGER2()
	if not v10 and v8 ~= nil and Engine.IsPlayingWithController() then
		v8:SelectElementInDirection(module2.INCREMENT)
	end
end

function onKeyDown_USE()
	if v4 > 0 then
		if gGameRules:IsA(__wf_atom_fa19955e) then
			module2.PlaySound(duviriRevivePressSound)
		else
			module2.PlaySound(reviveStartSound)
			v25 = module2.PlaySound(reviveLoopSound)
		end

		v16 = true
	end
end

function onKeyUp_USE()
	if v4 > 0 then
		v16 = false
		v15 = 0
		mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)

		if not __wf_atom_7e8ad928(v25) then
			v25:Stop(false)
			v25 = nil
		end
	end
end

function onKeyDown_MENU_GENERIC2()
	if v4 <= 0 then
		v16 = true
	end
end

function onKeyUp_MENU_GENERIC2()
	if v4 <= 0 then
		v16 = false
		v15 = 0
		mMovie:__wf_atom_1ca72041("RevivePanel.HoldProgress.Fill", "AlphaTestThreshold", 0, 0, 0, 0)
	end
end

local function fn15()
	local __wf_atom_4dc54686 = mMovie:__wf_atom_4dc54686()
	local ternary = module2.Ternary(
		v4 > 0,
		"/Lotus/Language/SystemMessages/RevivePrompt",
		"/Lotus/Language/SystemMessages/AbandonPrompt"
	)
	local __wf_atom_c7fa5e0c = mMovie:__wf_atom_c7fa5e0c(ternary, __wf_atom_4dc54686)

	if Engine.__wf_atom_dd1285f1() and Engine.__wf_atom_2a979d69() then
		__wf_atom_c7fa5e0c = mMovie:__wf_atom_8e9ac384(ternary, true)
	end

	mMovie:__wf_atom_50d60589("RevivePanel.Callout", 36, __wf_atom_c7fa5e0c)
	mMovie:__wf_atom_50d60589(
		"Prompt.PromptLabel.Label",
		36,
		mMovie:__wf_atom_c7fa5e0c("/SF/Language/SystemMessages/AbandonPrompt", __wf_atom_4dc54686)
	)

	if not __wf_atom_7e8ad928(v8) and v8:GetHowManyElements() > 0 then
		local __wf_atom_c7fa5e0c2 = mMovie:__wf_atom_c7fa5e0c("<MENU_LTRIGGER2>", __wf_atom_4dc54686)
		local __wf_atom_c7fa5e0c3 = mMovie:__wf_atom_c7fa5e0c("<MENU_RTRIGGER2>", __wf_atom_4dc54686)
		mMovie:__wf_atom_50d60589("CalloutLt", 36, __wf_atom_c7fa5e0c2)
		mMovie:__wf_atom_50d60589("CalloutRt", 36, __wf_atom_c7fa5e0c3)
		mMovie:__wf_atom_2dedec1a("CalloutLt", 13, Engine.IsPlayingWithController())
		mMovie:__wf_atom_2dedec1a("CalloutRt", 13, Engine.IsPlayingWithController())
	end
end

function ForceIconUpdate()
	fn15()
end

function IconCacheFlushed()
	fn15()
end

function OnGamepadTransition(_)
	fn15()
end

function SupportsThemes()
	return true
end

local function fn16()
	local v26 = (__wf_atom_7e8ad928(_T.ScriptedStruggleParams) or __wf_atom_7e8ad928(_T.ScriptedStruggleParams.inputCode))
		and "MENU_GENERIC2"
		or _T.ScriptedStruggleParams.inputCode
	local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(v26, false, promptInputFilter)
	local v27

	if
		Engine.IsPlayingWithController()
		or Engine.__wf_atom_dd1285f1()
		or not (#__wf_atom_c2e9085e > 0)
		or string.find(__wf_atom_c2e9085e[1], "EN_") ~= nil
	then
		local v28 = (__wf_atom_7e8ad928(_T.ScriptedStruggleParams) or __wf_atom_7e8ad928(_T.ScriptedStruggleParams.inputLoc))
			and "<MENU_GENERIC2>"
			or _T.ScriptedStruggleParams.inputLoc
		v27 = mMovie:__wf_atom_8e9ac384(v28, true)
	else
		v27 = __wf_atom_c2e9085e[1]
	end

	mMovie:__wf_atom_50d60589("Prompt.Callout.Label", 36, v27)
end

function InitializePrompt()
	v2 = mMovie:__wf_atom_5e6e15c8("Prompt", 0)
	v3 = mMovie:__wf_atom_5e6e15c8("Prompt", 1)
	print("*B* InitializePrompt", v2)
	mMovie:OverrideMaterial("Prompt.Bg", bgMaterial)
	mMovie:OverrideMaterial("Prompt.Bg.Mist", mistMaterial)
	mMovie:__wf_atom_e57658c2("Prompt.Glow", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Prompt.Glow", 12, 60)
	mMovie:__wf_atom_e57658c2("Prompt.CircleBg", 11, 2825751)
	mMovie:__wf_atom_e57658c2("Prompt.CircleBg", 12, 45)
	mMovie:OverrideMaterial("Prompt.ProgressFill", progressMaterial)
	mMovie:__wf_atom_e57658c2("Prompt.ProgressBg", 12, 10)
	mMovie:__wf_atom_e57658c2("Prompt.Callout.Label", 44, 14524216)
	mMovie:__wf_atom_e57658c2("Prompt.Hint.Label", 44, 12363651)
	fn16()
	mMovie:__wf_atom_50d60589("Prompt.Hint.Label", 46, "bottom")
	mMovie:__wf_atom_7d7314f1(
		"Prompt.Hint.Label.text",
		module2.Ternary(false, "/Lotus/Language/Actions/StruggleHold", "/Lotus/Language/Actions/StruggleTap")
	)
	local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Prompt.Hint.Label", 40)
	local v26 = -13 - (__wf_atom_421b01aa(__wf_atom_5e6e15c8, 50, 100) - 50) / 3 + 0
	mMovie:__wf_atom_e57658c2("Prompt.Hint.Label", 1, v26)
	local openSound = openSound

	if _T.ScriptedStruggleParams and _T.ScriptedStruggleParams.openSound then
		openSound = _T.ScriptedStruggleParams.openSound
	end

	module2.PlaySound(openSound)

	if not __wf_atom_7e8ad928(loopSound) and v == nil then
		local loopSound = loopSound

		if _T.ScriptedStruggleParams and _T.ScriptedStruggleParams.loopSound then
			loopSound = _T.ScriptedStruggleParams.loopSound
		end

		v = module2.PlaySound(loopSound)
	end
end