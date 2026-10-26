local module = require("EE.Interface.AnchorMgr")
local module2 = require("SF.Scripts.NightFoldLib")
local module3 = require("EE.Interface.Utilities")
local module4 = require("SF.Interface.SFUtilities")
local v = { mAlpha = 0, mDepth = -15000, mTime = 0.35, mDelay = 0 }
local v2 = true
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local flag = false
local flag2 = false
local v9 = false
local lastMenuOpen = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = 0
local v14 = nil

function ShowLevelLoader(_) end

function ShowKeyLauncher(_) end

local function fn()
	if __wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v3) or v12 == v3:__wf_atom_799d95f5() then
		return
	end

	if v13 > 0 then
		v13 -= 1
		return
	end

	v11:DoPostAction(v3)
	v11 = nil
	v12 = nil
	Close()
end

function ShowFastTravelLauncher(_) end

function ShowGenericMenuInContext(_) end

local function fn2()
	mMovie:Execute("ShowGenericMenuInContext", "ShowLevelLoader")
end

local function fn3()
	mMovie:Execute("ShowGenericMenuInContext", "ShowKeyLauncher")
end

local function fn4()
	mMovie:Execute("ShowGenericMenuInContext", "ShowFastTravelLauncher")
end

local function fn5(p)
	mMovie:__wf_atom_2dedec1a("Menu.Tabs.Callouts", 13, not p)

	if not p then
		mMovie:__wf_atom_7d7314f1("Menu.Tabs.Callouts.Left.text", "<MENU_LTRIGGER2>")
		mMovie:__wf_atom_7d7314f1("Menu.Tabs.Callouts.Right.text", "<MENU_RTRIGGER2>")
	end
end

function OnGamepadTransition(p)
	fn5(p == "true")
end

local function fn6(p, p2)
	if not __wf_atom_7e8ad928(v5) then
		v5:Update(p, p2)
	end

	local v15 = math.max(p / 16 / (p2 / 9), 1)
	local v16 = math.ceil(mMovie:__wf_atom_97cd8326() * v15) + 1
	mMovie:__wf_atom_e57658c2("MenuBacker", 14, v16)
	mMovie:__wf_atom_e57658c2("SquadMask.Right", 14, v16)
	UpdateMaskArea()
end

function onViewportSizeChanged(p, p2)
	fn6(tonumber(p), tonumber(p2))
end

local function fn7(p)
	local v15 = {}
	local label = "/Lotus/Language/Menu/Exit"

	if module4.ShowDevOptions() then
		table.insert(v15, { Label = "[DEV] Fast Travel", CallBack = fn4 })
		table.insert(v15, { Label = "[DEV] Test Keys", CallBack = fn3 })
		table.insert(v15, { Label = "[DEV] Test Levels", CallBack = fn2 })
	end

	if #_T.TopMenuChildButtons > 0 then
		local v16 = { MENU_GENERIC1 = true, MENU_CANCEL = true }

		for _, topMenuChildButton in ipairs(_T.TopMenuChildButtons) do
			if v16[topMenuChildButton.CallOut] then
				if topMenuChildButton.CallOut == "MENU_CANCEL" then
					label = topMenuChildButton.Label
				end
			else
				table.insert(v15, topMenuChildButton)
			end
		end
	end

	local v16

	if __wf_atom_7e8ad928(v3) then
		v16 = false
	else
		v16 = v3:__wf_atom_799d95f5()
	end

	local v17 = __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) and true
		or v3 == gRegion:__wf_atom_eab484a7():__wf_atom_eff0517e()

	if v16 then
		table.insert(v15, {
			Label = "/SF/Language/Menu/ExitNightFold",
			CallBack = GoToNightFold,
			CallOut = "MENU_GENERIC1"
		})
	elseif v17 and not module2.IsNightfoldBlocked() then
		table.insert(v15, {
			Label = "/SF/Language/Menu/EnterNightFold",
			CallBack = GoToNightFold,
			CallOut = "MENU_GENERIC1"
		})
	end

	table.insert(v15, { Label = label, CallBack = Close, CallOut = "MENU_CANCEL" })

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		if not __wf_atom_7e8ad928(v6) then
			_T.SetButtons(v6, nil)
		end

		_T.SetButtons(mMovie, v15, getfenv(1), p, nil, _T.TopMenuChildButtonOptions)
	end
end

function UpdateButtons(p)
	fn7(p == "true")
end

function IconCacheFlushed()
	fn7(true)
end

local function fn8()
	v2 = true

	if not _T.FocusCodexMovie then
		_T.FocusCodexEntry = nil
		_T.FocusCodexTab = nil
	end

	if not __wf_atom_7e8ad928(_T.DisableUIInput) then
		_T.DisableUIInput(true)
	end

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	if flag2 then
		return
	end

	flag2 = true

	if _T.HideNotification ~= nil then
		_T.HideNotification(nil, nil, nil, "Matchmaking")
	end

	if _T.SetButtons then
		_T.SetButtons(mMovie, nil)
	end

	mMovie:__wf_atom_0c1c47f2(nil)
	mMovie:__wf_atom_c884ca43(true)
	mMovie:__wf_atom_b4ffb30f(false)
end

function Shutdown()
	fn8()

	if flag then
		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		if not __wf_atom_7e8ad928(__wf_atom_8e4fda44) then
			__wf_atom_8e4fda44:__wf_atom_65363409()
		end
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:Close()
	end

	if not __wf_atom_7e8ad928(v7) then
		v7:Close()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Close()
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_21b4d6e8(false)
	end

	_G.LastMenuOpen = lastMenuOpen
	_T.TopMenuMovie = nil
	_T.TopMenuOpen = nil
	module4.RegisterHideHud(false)
end

local function fn9(object)
	if __wf_atom_7e8ad928(object) then
		return nil
	end

	return object:__wf_atom_6d61d595()
end

local function fn10(_, _) end

local function fn11()
	if not __wf_atom_7e8ad928(fn9(v7)) then
		fn10(v7, "ClosedFromPauseMenu")
		v7:Execute("ClosedFromPauseMenu", "")

		if not __wf_atom_7e8ad928(fn9(v7)) then
			fn10(v7, "mClosingChildMovie:Close()")
			v7:__wf_atom_feba44c7(false)
			v7:Close()
		end
	end

	v7 = nil
end

local function fn12()
	if __wf_atom_7e8ad928(fn9(v6)) then
		return
	end

	if v7 ~= nil then
		fn11()
	end

	v7 = v6
	__wf_atom_ec43d06e(v7, "_root", 2, { 12, 4 }, { v.mAlpha, v.mDepth }, v.mTime, v.mDelay, fn11)
end

local function fn13()
	local v15

	if __wf_atom_7e8ad928(v6) then
		return false
	else
		fn10(v6, "PrepareToClose")
		v15 = v6:Execute("PrepareToClose", "")

		if not v15 then
			fn12()
		end
	end

	return v15
end

local function fn14(p)
	fn10(mMovie, "Close")

	if not p and fn13() then
		fn10(v6, "Abort")
		return
	end

	if not __wf_atom_7e8ad928(gGameRules) then
		gGameRules:__wf_atom_21b4d6e8(true)
	end

	fn8()
	__wf_atom_ec43d06e(mMovie, "SquadMask", 2, { 4 }, { -v.mDepth }, v.mTime, v.mDelay)
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12, 4 }, { v.mAlpha, v.mDepth }, v.mTime, v.mDelay, function()
		fn11()
		fn10(mMovie, "mMovie:Close()")
		mMovie:Close()
	end)
end

function Close()
	v9 = true
	fn14()
end

function GoToNightFold()
	if not v3:__wf_atom_799d95f5() and module2.IsNightfoldBlocked() then
		return
	end

	gGameRules:__wf_atom_9141808b()

	if not __wf_atom_7e8ad928(v3) and not v3:__wf_atom_59cb39a4() and v3:__wf_atom_420d11c2() then
		_T.ForceCharacterScreen = true
		v3:GoToNightFold()
	end

	fn14()
end

function LogOutConfirm(p)
	local v15 = tonumber(p)

	if v15 == 4 then
		if __wf_atom_7e8ad928(gGameRules) or __wf_atom_7e8ad928(gRegion) then
			return
		end

		gRegion:__wf_atom_031728c7()
		fn14()

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:__wf_atom_f62a8704("ConfirmLogoff", { v15 })
		end
	elseif v15 == 6 then
		__wf_atom_8e4fda44:__wf_atom_bcb70491(cmdQuit)
	end
end

local function fn15()
	local dialogSettings = Engine.DialogSettings()
	dialogSettings.locString = "/SF/Language/Menu/QuitGameConfirm"
	dialogSettings.titleString = "/Lotus/Language/Menu/Confirm"
	dialogSettings.dialogType = 5
	dialogSettings.firstString = "/SF/Language/Menu/Logout"
	dialogSettings.secondString = "/Lotus/Language/Menu/QuitGame"
	dialogSettings.thirdString = "/Menu/Confirm_Item_Cancel"
	dialogSettings:SetCallback("LogOutConfirm")
	v8 = module3.ShowCustomMessage(dialogSettings)
end

function AsyncMovieLoaded(p)
	mMovie:SetVisible(true)
	flag = false

	if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	if not __wf_atom_7e8ad928(p) then
		v2 = false
		v6 = p
		v6:Execute("OpenedFromPauseMenu", "")
		fn10(v6, "OpenedFromPauseMenu")
		fn7(true)
	end
end

local function fn16(object)
	local movie = __wf_atom_8e4fda44:FindMovie(object)

	if __wf_atom_7e8ad928(movie) then
		flag = true

		if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		end

		print("TopMenu: Loading " .. object:__wf_atom_5b41f63b())
		_T.TopMenuChildButtons = nil
		_T.TopMenuChildButtonOptions = nil
		mMovie:__wf_atom_f6811c70(object, "AsyncMovieLoaded")
	else
		print("TopMenu: Found " .. object:__wf_atom_5b41f63b())
		movie:__wf_atom_f43c289f(mMovie)
		AsyncMovieLoaded(movie)
	end
end

local function fn17()
	if v10 == nil then
		return
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		_T.SetButtons(mMovie, nil)
	end

	if lastMenuOpen ~= nil then
		local v15 = "Menu.Tabs.Tab" .. lastMenuOpen
		mMovie:__wf_atom_4c1c1986(v15, "Label", 44, _G.UIColor_Tan)
		mMovie:__wf_atom_7f57ab2f(v15, "Leaves", 13, false)
		mMovie:__wf_atom_e57658c2(v15, 5, 100)
		mMovie:__wf_atom_e57658c2(v15, 6, 100)
	end

	lastMenuOpen = v10
	v10 = nil
	local v15 = "Menu.Tabs.Tab" .. lastMenuOpen
	mMovie:__wf_atom_4c1c1986(v15, "Label", 44, _G.UIColor_Yellow)
	mMovie:__wf_atom_7f57ab2f(v15, "Leaves", 13, true)
	mMovie:__wf_atom_e57658c2(v15, 5, 110)
	mMovie:__wf_atom_e57658c2(v15, 6, 110)
	fn16(movies[lastMenuOpen])
end

function ChildMovieClosed()
	fn12()

	if v10 == nil then
		fn14(true)
	else
		fn17()
	end
end

local function fn18(p, p2)
	local v15 = (p - 1) % #movies + 1

	if lastMenuOpen == v15 or not __wf_atom_7e8ad928(v7) or __wf_atom_7e8ad928(movies[v15]) then
		return
	end

	v10 = v15

	if not (p2 or _T.FocusCodexMovie) then
		_T.FocusCodexEntry = nil
		_T.FocusCodexTab = nil
	end

	if fn13() then
		return
	end

	fn17()
end

function SelectTabByMovie(p)
	for i, v15 in ipairs(movies) do
		if v15:IsA(WeakResource(p)) then
			fn18(i, true)
		end
	end
end

local function fn19()
	local total = 0
	local v15 = nil
	local v16 = nil

	for i, v17 in ipairs(movies) do
		local v18 = "Menu.Tabs.Tab" .. i

		if not mMovie:__wf_atom_253d7085(v18) then
			__wf_atom_86cbd68d(mMovie, "Menu.Tabs.Tab1.duplicateMovieClip", "Tab" .. i, i)
		end

		mMovie:SetCallbacks(v18, "TabFocused", "TabUnfocused", "TabReleased", "TabPressed")
		mMovie:__wf_atom_e57658c2(v18, 100, i)
		local v19 = string.gsub(v17:GetName(), ".swf", "")
		local v20 = "/SF/Language/Menu/Menu_Open_" .. v19

		if v19 == "Codex" then
			local __wf_atom_10192cfa, v21 = gGameData:__wf_atom_10192cfa(Symbol("CodexTitleChoice"))

			if __wf_atom_10192cfa then
				v20 = v21
			end

			if _T.FocusCodexMovie then
				v16 = i
			end
		end

		mMovie:__wf_atom_48bd5a59(v18, "Label", 36, Localize(v20, nil))
		local v21 = mMovie:__wf_atom_cfc41e35(v18, "Label", 40) / 2 + 3
		mMovie:__wf_atom_4c1c1986(v18, "Leaves.Left", 0, -v21)
		mMovie:__wf_atom_4c1c1986(v18, "Leaves.Right", 0, v21)
		mMovie:__wf_atom_4c1c1986(v18, "Label", 44, _G.UIColor_Tan)
		mMovie:__wf_atom_7f57ab2f(v18, "Leaves", 13, false)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8(v18, 14)
		mMovie:__wf_atom_4c1c1986(v18, "Btn", 14, __wf_atom_5e6e15c8)
		mMovie:__wf_atom_e57658c2(v18, 0, total + __wf_atom_5e6e15c8 / 2)
		total += __wf_atom_5e6e15c8
		local movie = __wf_atom_8e4fda44:FindMovie(v17)

		if __wf_atom_7e8ad928(movie) then
			continue
		end

		if not __wf_atom_7e8ad928(gGameRules) then
			movie:__wf_atom_f43c289f(mMovie)
			movie:Execute("UpdateButtons", "")
		end

		v15 = i
	end

	local v17 = v15 or v16 or _G.LastMenuOpen or 1
	mMovie:__wf_atom_e57658c2(
		"Menu.Tabs.Callouts.Left",
		0,
		-mMovie:__wf_atom_5e6e15c8("Menu.Tabs.Callouts.Left", 14) - 5
	)
	mMovie:__wf_atom_e57658c2("Menu.Tabs.Callouts.Right", 0, total + 15)
	mMovie:__wf_atom_e57658c2("Menu.Tabs", 0, -total / 2)
	mMovie:__wf_atom_e57658c2("Menu.Underline", 12, 60)
	mMovie:__wf_atom_e57658c2("Menu.Underline", 14, total)
	mMovie:OverrideMaterial("Menu.Underline", _G.UIMaterial_TiledDivider)
	mMovie:__wf_atom_1ca72041("Menu.Underline", "TileRepeats", total / 32, 1, 0, 0)
	fn18(v17)
end

local function fn20() end

function UpdateMaskArea()
	if _T.GetSquadOverlayMaskArea then
		local squadOverlayMaskArea, v15, v16 = _T.GetSquadOverlayMaskArea()
		mMovie:__wf_atom_e57658c2("SquadMask.Left", 0, squadOverlayMaskArea)
		mMovie:__wf_atom_e57658c2("SquadMask.Left", 14, squadOverlayMaskArea)
		mMovie:__wf_atom_e57658c2("SquadMask.Right", 0, squadOverlayMaskArea + v15)
		local visibilitySize = module3.GetVisibilitySize(mMovie, v16)
		mMovie:__wf_atom_1ca72041("MenuBacker", "VisibilitySize", visibilitySize, 0, 0, 0)
	end
end

function Initialize()
	if _T.SubvertTopMenu then
		__wf_atom_8e4fda44:__wf_atom_3e5e23c0(_T.SubvertTopMenu, "")
		mMovie:Close()
	else
		v3 = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(v3) and v3:IsA(__wf_atom_7e6ed5fa) then
			v3:__wf_atom_7ab15c94(nil)
		end

		_T.TopMenuMovie = mMovie
		_T.TopMenuOpen = true
		module4.RegisterHideHud(true)
		UpdateMaskArea()

		if _T.EnableUIInput ~= nil then
			_T.EnableUIInput()
		end

		v5 = module.Create(mMovie)
		v5:Register(mMovie, "Menu", { v5.ANCHOR_V_TOP, v5.ANCHOR_H_CENTRE })
		v5:Register(mMovie, "SignOutBtn", { v5.ANCHOR_V_TOP, v5.ANCHOR_H_RIGHT })
		v5:Register(mMovie, "SquadMask", { v5.ANCHOR_V_TOP, v5.ANCHOR_H_LEFT })
		local module5 = require("Lotus.Interface.Libs.TimerMgr")
		v4 = module5.CreateTimerMgr()

		if not __wf_atom_7e8ad928(_T.ShowBackground) then
			_T.ShowBackground()
		end

		mMovie:OverrideMaterial("MenuBacker", backerFadeMaterial)
		mMovie:__wf_atom_e57658c2("MenuBacker", 12, 80)
		mMovie:__wf_atom_e57658c2("MenuBacker", 11, _G.UIColor_DarkBrown)
		mMovie:SetCallbacks("SignOutBtn", "SignOutFocused", "SignOutUnfocused", "SignOutReleased", "SignOutPressed")
		mMovie:__wf_atom_e57658c2("SignOutBtn", 12, 60)
		fn19()
		fn20()
		fn6(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
		fn5(not Engine.IsPlayingWithController())
		fn7()
	end
end

function Update()
	local v15 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v15)

	if not __wf_atom_7e8ad928(v4) then
		v4:Update(v15)
	end

	if __wf_atom_7e8ad928(gRegion) then
		if not (flag2 or v9) then
			Close()
		end
	else
		if not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8()) then
			mMovie:Close()
			return
		end

		if not (flag2 or v9) then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) and __wf_atom_c4f78a8f:IsKilled() then
				Close()
				return
			end

			if _G.matchmakingTimeoutActive and _T.ShowNotification ~= nil then
				local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

				if not __wf_atom_7e8ad928(__wf_atom_15811761) then
					local __wf_atom_a7bb026f = __wf_atom_15811761:__wf_atom_a7bb026f()

					if v14 ~= __wf_atom_a7bb026f then
						v14 = __wf_atom_a7bb026f
						local __wf_atom_2b52c5a6 = __wf_atom_15811761:__wf_atom_2b52c5a6()
						_T.ShowNotification(
							"Locating Players... (" .. __wf_atom_a7bb026f .. "/" .. __wf_atom_2b52c5a6 .. ")",
							"Matchmaking",
							true,
							0,
							nil,
							true
						)
					end
				end
			end
		end

		fn()
	end
end

function TabFocused(p, p2)
	if p == lastMenuOpen then
		return
	end

	module3.PlaySound(_G.UISound_Focus)
	mMovie:__wf_atom_4c1c1986(p2, "Label", 44, _G.UIColor_Yellow)
	__wf_atom_ec43d06e(mMovie, p2, 2, { 5, 6 }, { 110, 110 }, 0.15)
end

function TabUnfocused(p, p2)
	if p == lastMenuOpen then
		return
	end

	mMovie:__wf_atom_4c1c1986(p2, "Label", 44, _G.UIColor_Tan)
	__wf_atom_ec43d06e(mMovie, p2, 2, { 5, 6 }, { 100, 100 }, 0.1)
end

function TabReleased(p, _)
	fn18(p)
end

function TabPressed(_, _) end

function SignOutFocused(_, p)
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6, 12 }, { 110, 110, 100 }, 0.15)
	_T.gToolTip = Localize("/SF/Language/Menu/Logout", nil)
end

function SignOutUnfocused(_, p)
	__wf_atom_ec43d06e(mMovie, p, 2, { 5, 6, 12 }, { 100, 100, 60 }, 0.1)
	_T.gToolTip = nil
end

function SignOutReleased(_, _)
	fn15()
end

function SignOutPressed(_, _) end

function IsInputBlocked()
	return v2 or flag
end

function onKeyDown_MENU_LTRIGGER2()
	fn18(lastMenuOpen - 1)
end

function onKeyDown_MENU_RTRIGGER2()
	fn18(lastMenuOpen + 1)
end