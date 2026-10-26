_T.hasCheckedTutorial = nil
mAllowedAdvanceFromLogin = false
mShowingBackground = false
mFirstLoginMenuSet = false
local fn
local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusNetworkUtilities")
local module3 = require("Lotus.Interface.LotusUtilities")
local module4 = require("Lotus.Interface.LotusUtilities")
local module5 = require("Lotus.Interface.UIStyleUtilities")
local module6 = require("Lotus.Interface.UIUtilities")
local module7 = require("EE.Interface.AnchorMgr")
local module8 = require("Lotus.Interface.MissionRequirementUtilities")
local module9 = require("SF.Scripts.FirstLoginUtils")
local module10 = require("SF.Scripts.NightFoldLib")
local v = nil
mInputBlocked = true
mInitialized = false
mOfferedSteamPack = false
mRemovedSteamPackNotified = false
mOfferedSteamEconomy = true
mShownEmailPopup = false
mShowEpicNotifications = false
OPEN_BROWSER_DELAY = 1
local v2 = nil
local v3 = nil
local flag = nil
local v4 = false
local v5 = nil
local flag2 = false
local v6 = nil
local v7 = {}
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local locString = nil
local v15 = nil
local v16 = nil
local v17 = 0
local v18 = false
local v19 = nil
local flag3 = false
local flag4 = false
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = nil
local v27 = false
local v28 = nil
local v29 = nil
local v30 = false
local v31 = nil
local v32 = false
local v34 = nil
local v35 = false
local v36 = false
local v37 = nil
local v38 = false
local v39 = false
local v40 = nil
local v41 = true
local v42 = true
local v43 = false
local v44 = false
local v45 = false
local v46 = false
local v47 = false
local v48 = {}
local flag5 = false
local v49 = false
local v50 = false
local v51 = nil
local v52 = nil
local v53 = "Logo"
local v54 = false
local v55 = false
local v56 = false
local v57 = nil
local v58 = {
	Harrasment = "https://digitalextremes.zendesk.com/hc/articles/360010646551",
	PrivacyBreach = "https://www.soulframe.com/privacy",
	Profanity = "https://digitalextremes.zendesk.com/hc/articles/360010646551",
	Terms = "https://www.soulframe.com/terms",
	Threat = "https://www.soulframe.com/terms",
	InvasionLiteban = "https://digitalextremes.zendesk.com/hc/articles/360010427612",
	CompromisedAccount = "https://digitalextremes.zendesk.com/hc/articles/360010427612"
}
local v59 = {
	Harrasment = "https://kf.qq.com/bills/200901selfsam4979ae6.html",
	PrivacyBreach = "https://kf.qq.com/bills/200901selfsam4979ae6.html",
	Profanity = "https://kf.qq.com/bills/200901selfsam4979ae6.html",
	Terms = "https://game.qq.com/contract.shtml",
	Threat = "https://game.qq.com/contract.shtml",
	InvasionLiteban = "https://kf.qq.com/bills/200901selfsam4979ae6.html",
	CompromisedAccount = "https://kf.qq.com/bills/200901selfsam4979ae6.html"
}
local v60 = {
	"/Lotus/Language/Menu/Warframe_ConsoleDisclaimerLink1",
	"/Lotus/Language/Menu/Warframe_ConsoleDisclaimerLink2"
}
local level = WeakResource("/SF/Levels/Prisoner.level")
local v62 = false
local v63 = nil
local v64 = false
local v65 = false
local flag6 = false
local fn2
local fn3
local fn4
local fn5
local fn6
local fn7
local fn8
local fn9
local fn10
local fn11
local fn12
addResourceDeps = { Resource() }
local v66 = false
local flag7 = false

local function fn13()
	mMovie:__wf_atom_933bbce0("Logo", smokeyLogo, smokeyLogoMaterial)
	mMovie:__wf_atom_e57658c2("Logo", 14, 660)
	mMovie:__wf_atom_e57658c2("Logo", 15, 291)
	mMovie:__wf_atom_e57658c2("Logo", 16, 180)
	mMovie:__wf_atom_e57658c2("LoginPanel.LoginBtn", 16, 180)
	mMovie:__wf_atom_e57658c2("Logo", 0, 1350)
	mMovie:__wf_atom_e57658c2("Logo", 1, 800)
	mMovie:__wf_atom_e57658c2("LoginPanel", 1, 600)
	mMovie:__wf_atom_2dedec1a("LoginPanel.Email", 13, false)
	mMovie:__wf_atom_2dedec1a("LoginPanel.Password", 13, false)
	mMovie:__wf_atom_2dedec1a("Spinner", 13, false)
	flag7 = true
end

function EmptyCallback() end

function IsInputBlocked()
	return mInputBlocked
end

local function fn14()
	mMovie:__wf_atom_2dedec1a("ScreenBlocker", 13, false)
end

local function fn15(p)
	mMovie:__wf_atom_46a6af3b(p)
end

local function fn16(p)
	v20:SetActive(p)
	v21:SetActive(p)
	v22:SetActive(p)
	v20.mSilent = false
	v21.mSilent = false
	fn9(p)
end

local function fn17(p)
	mMovie:__wf_atom_2dedec1a("LoginPanel", 13, true)
	mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, false)

	if not p then
		v21:TryPressed(true)
	end

	v21:SetText("")
	__wf_atom_ec43d06e(mMovie, "LoginPanel", 0, { 12 }, { 100 }, 0.1)
	fn16(true)
end

local function fn18(p)
	print("ResetLogin")

	if Engine.__wf_atom_fc67ba71() and not v49 then
		mMovie:__wf_atom_2dedec1a("LoginPanel", 13, false)
		mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, true)
		__wf_atom_ec43d06e(mMovie, "LoginPanel_PS4", 0, { 12 }, { 100 }, 0.1)

		if Engine.__wf_atom_b290ec01() then
			mMovie:__wf_atom_2dedec1a("Logos", 13, true)
		end
	elseif not v47 then
		fn17(p)
	end

	_T.NextLitePresenceResync = nil
	_T.NextRichPresenceResync = nil
end

local function fn19()
	local mLabel = v21.mLabel
	local v67

	if v26 == nil then
		v67 = __wf_atom_0a63ecce(v20.mLabel)
	else
		v67 = __wf_atom_0a63ecce(v26)
	end

	if v20.mSelected then
		v21:TryPressed(true)
		return
	end

	if mLabel == "" or v67 == "" then
		return
	end

	if v21.mSelected or Engine.__wf_atom_5f0554d9() then
		fn15("")
		fn4()
	end
end

local function fn20()
	if v2 == 0 then
		local v67 = not v47
		local v68 = not v47

		if mMovie:__wf_atom_387f260e("LoginPanel.Email.EmailText", 36) ~= "" then
			v67 = false
		end

		if mMovie:__wf_atom_387f260e("LoginPanel.Password.PasswordText", 36) ~= "" then
			v68 = false
		end

		mMovie:__wf_atom_2dedec1a("LoginPanel.Email.BackerText", 13, v67)
		mMovie:__wf_atom_2dedec1a("LoginPanel.Password.BackerText", 13, v68)
	end
end

local function fn21(p)
	local v67 = __wf_atom_c4e218a2()

	if v67 - v17 < OPEN_BROWSER_DELAY then
		return
	end

	v17 = v67
	module.DoOpenWebBrowser(p)
end

local function fn22()
	if __wf_atom_7e8ad928(_T.gNewBuildPopup) and v2 == 1 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
		return true
	end

	return false
end

function OnSync(_, _) end

function OnAggregateComplete(p)
	print("OnAggregateComplete")
	v62 = false

	if not p then
		return
	end

	if _T.RadialSolarMap_OnAggregateResults then
		_T.RadialSolarMap_OnAggregateResults()
	end
end

local function fn23()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local sessionSearch = Engine.SessionSearch()
	local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 1
	else
		sessionSearch.matchType = 2
	end

	sessionSearch.wantPlayers = false
	sessionSearch.wantMap = false
	sessionSearch.wantScoreLimit = false
	sessionSearch.wantTimeLimit = false
	sessionSearch.wantReconnect = false
	sessionSearch.regionId = __wf_atom_7611b6b4.regionId
	v62 = true
	gMatchingService:__wf_atom_d270445b(__wf_atom_18a5d83b, sessionSearch, "OnAggregateComplete")
end

local function fn24()
	print("SignoutConfirmed!!!")
	v31 = nil
	_T.BackgroundMovie:Execute("DoLogoff", "")
end

local function fn25()
	print("Local user changed...")
	_G.forcedUserChange = true
	__wf_atom_a0f6588f:__wf_atom_01bce336()
end

function SwitchProfile()
	if __wf_atom_7e8ad928(gRegion) then
		return
	end

	gRegion:__wf_atom_031728c7()
	fn25()
end

function onKeyDown_MENU_GENERIC2()
	if
		not fn5()
		and Engine.__wf_atom_84bb79c2()
		and not Engine.__wf_atom_54205c5a()
		and not v35
		and v24 ~= nil
		and v2 == 0
	then
		v24.mOnPressedCallback()
	end
end

local function fn26(p)
	v25:SetActive(p)

	if p then
		__wf_atom_ec43d06e(mMovie, "LoginPanel.LoginBtn", 8, { 12 }, { 0 }, 0.25, 0)
	else
		__wf_atom_ec43d06e(mMovie, "LoginPanel.LoginBtn", 8, { 12 }, { 100 }, 0.25, 0.2)
	end
end

local email = nil
local v68 = nil

local function fn27(p, p2, p3)
	print("DispatchLogin()")
	fn16(false)
	fn26(true)
	email = p
	v68 = p2
	__wf_atom_a0f6588f:LogIn(p, p2, "LoginDone", p3)
	flag4 = false
	mOfferedSteamEconomy = false
end

function OnWeGameAccountNamed()
	mMovie:__wf_atom_b4ffb30f(true)
	local mLabel

	if v26 == nil then
		mLabel = v20.mLabel
	else
		mLabel = v26
	end

	fn27(mLabel, __wf_atom_a1d009e6("Password"), true)
end

function OnWeGameAccountNameCancelled()
	v45 = false
	v46 = false
	mMovie:__wf_atom_b4ffb30f(true)
	v20:TryPressed(true)
	v21:SetText("")
end

local function fn28()
	_T.MainMenuStateReady = true
end

local function fn29()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return false
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
		local activeQuest, v69 = module3.GetActiveQuest(__wf_atom_9be88b01)

		if activeQuest == WeakResource("/Lotus/Types/Keys/NewWarQuest/NewWarQuestKeyChain") then
			return true, v69
		end
	end

	return false
end

local function fn30()
	math.random()

	if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() and module9.ShouldDoFirstLoginSequence(true) then
		local introMusic = introMusic

		if not __wf_atom_7e8ad928(introMusicTNW) then
			local v69, v70 = fn29()

			if v69 and v70 ~= nil and v70 > 4 then
				introMusic = introMusicTNW
			end
		end

		_T.introMusicInstance = module.PlaySound(introMusic)
	end

	_T.introMusicPlayed = true
end

local function fn31()
	if not __wf_atom_7e8ad928(_T.IsScreenOpen) and _T.IsScreenOpen("MissionStats") then
		local screenRes = _T.GetScreenRes("MissionStats")
		local movie = __wf_atom_8e4fda44:FindMovie(screenRes)

		if not __wf_atom_7e8ad928(movie) then
			movie:Execute("ReturnedToShip", "")
			return true
		end
	end

	return false
end

local function fn32()
	if not (fn31() or __wf_atom_7e8ad928(_T.GoToScreen)) then
		_T.GoToScreen("MissionStats")
	end

	_T.missionStatsPending = false

	if v37 ~= nil then
		v:RemoveTimer(v37)
	end
end

local function fn33()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		_T.missionStatsPending = false
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	local __wf_atom_a4359d36 = __wf_atom_9be88b01:__wf_atom_a4359d36()

	if
		not __wf_atom_7e8ad928(__wf_atom_a4359d36)
		and not __wf_atom_7e8ad928(__wf_atom_a4359d36.gameRules)
		and __wf_atom_a4359d36.gameRules:IsA(__wf_atom_3066d015)
	then
		_T.missionStatsPending = false
		return
	end

	if __wf_atom_9be88b01:__wf_atom_62656485() then
		__wf_atom_9be88b01:__wf_atom_66a27504()
		return
	end

	local v69 = #__wf_atom_9be88b01:__wf_atom_8ba10f50() > 0
	local v70

	if __wf_atom_7e8ad928(__wf_atom_a4359d36) then
		v70 = false
	else
		v70 = __wf_atom_a4359d36.missionType == 10
	end

	if v69 and not v70 then
		_T.missionStatsPending = true
		v37 = v:AddTimer(0.25, fn32)
	else
		fn31()
	end
end

function OnQuit()
	if not _T.ShowingQuitGameDialog then
		_T.ShowingQuitGameDialog = true
		module.ShowYesOrNoMessage("/Lotus/Language/Menu/QuitGameConfirm", "ConfirmQuit")
	end
end

function MovieLoaded() end

fn9 = function(p)
	if Engine.__wf_atom_fc67ba71() then
		return
	end

	print("UpdateButtons(" .. tostring(p) .. ")")
	local v69

	if p then
		v69 = {}

		if not (Engine.__wf_atom_fc67ba71() or __wf_atom_a29d89c2() or v47) then
			table.insert(v69, {
				Label = "/Lotus/Language/Menu/MainMenu_ForgotPassword",
				CallBack = function()
					mMovie:Execute("ForgotPassword", "")
				end,
				CallOut = "MENU_LTHUMB"
			})
		end

		if not __wf_atom_d9227398() then
			table.insert(v69, {
				Label = "/Lotus/Language/Menu/NewAccount",
				CallBack = function()
					mMovie:Execute("NewAccountPC", "")
				end,
				CallOut = "MENU_RTHUMB"
			})
		end

		if not Engine.__wf_atom_2a979d69() then
			table.insert(v69, {
				Label = "/Lotus/Language/Menu/QuitGame",
				CallBack = function()
					mMovie:Execute("OnQuit", "")
				end,
				CallOut = "MENU_CANCEL"
			})
		end
	end

	if not __wf_atom_7e8ad928(_T.SetButtons) then
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Logo", 0)
		_T.SetButtons(mMovie, v69, getfenv(1), false, false, { DesiredCenterX = __wf_atom_5e6e15c8 })
	end

	if flag7 then
		_T.SetButtons(mMovie, {}, getfenv(1), false, false)
	end
end

local function fn34()
	__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_d373e581()
	__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
	v48 = {}
end

local function fn35(p)
	if v2 == p then
		return
	end

	print("MainMenu::" .. "SetCurrentState(" .. p .. ")")
	mInputBlocked = true
	local v69 = v2
	v2 = p

	local function fn36()
		if v2 == 0 then
			if not __wf_atom_7e8ad928(chatMovie) then
				local movie = __wf_atom_8e4fda44:FindMovie(chatMovie)

				if not __wf_atom_7e8ad928(movie) then
					movie:Close()
				end
			end

			_T.gShowingLoginScreen = true

			if not __wf_atom_7e8ad928(_T.BackgroundMovie) then
				if not (__wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928((gRegion:__wf_atom_c4f78a8f()))) then
					local _t = _T
					local _t2 = _T
					local playerLight, priorLightMapTint = module6.SetupLoginLighting(true, nil, nil, loginLight)
					_t.PlayerLight = playerLight
					_t2.PriorLightMapTint = priorLightMapTint
				end

				if not __wf_atom_7e8ad928(gGameRules) then
					gGameRules:__wf_atom_411c9025(true)
				end
			end

			fn30()
			mMovie:__wf_atom_dac78d3d(true)
			mMovie:__wf_atom_e57658c2("LoginPanel", 12, 0)
			fn16(true)
			_T.PreLoginLoadOutId = module9.FetchLoadOutId(true)

			if v47 or Engine.IsPlayingWithController() and (v18 or Engine.__wf_atom_84bb79c2()) then
				if v47 then
					v22:SetActive(false)
					mInputBlocked = false
				end
			else
				__wf_atom_ec43d06e(mMovie, "LoginPanel", 7, { 12 }, { 100 }, 1, 0.2, function()
					mInputBlocked = false
				end)
			end

			__wf_atom_ec43d06e(mMovie, "Logo", 7, { 12 }, { 100 }, 1, 0.2)
			__wf_atom_ec43d06e(mMovie, "BG", 7, { 12 }, { 100 }, 1)

			if v63 then
				__wf_atom_ec43d06e(mMovie, "BackerImage", 1, { 12 }, { 12 }, 2, 0.2)
			end

			if
				__wf_atom_52a115fb == "PS4"
				or __wf_atom_52a115fb == "XBONE"
				or __wf_atom_52a115fb == "SWITCH"
				or __wf_atom_52a115fb == "PS5"
			then
				print("Pre login")

				if
					(__wf_atom_52a115fb == "PS4" or __wf_atom_52a115fb == "PS5" or __wf_atom_52a115fb == "SWITCH")
					and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
				then
					fn()
				elseif
					(__wf_atom_52a115fb == "PS4" or __wf_atom_52a115fb == "PS5" or __wf_atom_52a115fb == "SWITCH")
					and __wf_atom_a0f6588f:__wf_atom_7bd0381c()
				then
					__wf_atom_a0f6588f:__wf_atom_a73769fe("OnAutoLogin")
					fn26(true)
				elseif v18 then
					local v70 = __wf_atom_9a2b0be4("Client.Email")
					print("Auto login")
					local v71 = __wf_atom_9a2b0be4("Client.PlayerHash")

					if
						__wf_atom_72884638("Client.AutoLoginAsPC")
						and not __wf_atom_7e8ad928(v70)
						and string.len(v70) > 0
					then
						fn27(v70, v71, true)
					else
						fn27("", "", true)
					end

					v18 = false
				end
			else
				local v70 = __wf_atom_9a2b0be4("Client.Email")

				if v19 and v18 then
					local v71 = __wf_atom_9a2b0be4("Client.PlayerHash")

					if not __wf_atom_7e8ad928(v70) and string.len(v70) > 0 then
						fn27(v70, v71, true)
						v18 = false
					end
				elseif not v19 then
					v20:TryPressed(true)
				end
			end

			fn20()

			if v47 and not v54 then
				fn11()
			end
		elseif v2 == 2 then
			fn2()
		elseif v2 == 4 then
			fn3()
		elseif v2 == 5 then
			local v70 = false
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
			local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

			if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(__wf_atom_3cb140dc)) then
				local settings = __wf_atom_18a5d83b:Settings()
				local __wf_atom_72feee20 = settings:__wf_atom_72feee20()
				local __wf_atom_3959fbd8 = settings:__wf_atom_3959fbd8()
				local __wf_atom_e9a058a9 = settings:__wf_atom_e9a058a9()
				local __wf_atom_a4bdf2b8 = __wf_atom_3cb140dc:__wf_atom_a4bdf2b8()
				local __wf_atom_cb0fd61c = __wf_atom_3cb140dc:__wf_atom_cb0fd61c()
				local __wf_atom_f57f9624 = __wf_atom_3cb140dc:__wf_atom_f57f9624()

				if
					__wf_atom_72feee20 ~= __wf_atom_a4bdf2b8
					or __wf_atom_3959fbd8 ~= __wf_atom_cb0fd61c
					or __wf_atom_e9a058a9 ~= __wf_atom_f57f9624
				then
					v70 = true
					local v71 = {
						__wf_atom_72feee20:__wf_atom_5b41f63b(),
						__wf_atom_3959fbd8:__wf_atom_5b41f63b(),
						__wf_atom_e9a058a9:__wf_atom_5b41f63b()
					}
					v29 = UISys.__wf_atom_c0dbe47c(v71)
				end
			end

			if not v70 then
				local v71 = v3
				v3 = 1
				fn35(v71)
			end
		else
			if __wf_atom_52a115fb == "SWITCH" then
				__wf_atom_ec43d06e(mMovie, "LoginPanel", 2, { 12 }, { 0 }, 0.2)
				__wf_atom_ec43d06e(mMovie, "Logo", 2, { 12 }, { 0 }, 0.2)
				__wf_atom_ec43d06e(mMovie, "FirstLoginBacker", 2, { 12 }, { 0 }, 0.2)
				__wf_atom_ec43d06e(mMovie, "BackerImage", 2, { 12 }, { 0 }, 0.2)
			end

			_T.gShowingLoginScreen = false

			if mShowingBackground and not __wf_atom_7e8ad928(__wf_atom_392793db) then
				__wf_atom_8e4fda44:__wf_atom_62a19abc()
				mMovie:__wf_atom_0cf0fdbe(0)
			end

			if not __wf_atom_7e8ad928(gGameRules) then
				gGameRules:__wf_atom_411c9025(false)
			end

			if not _T.HasDailyTribute then
				if not __wf_atom_7e8ad928(_T.HideBackground) then
					_T.HideBackground(nil, 0.5)
				end

				mShowingBackground = false
				module6.SetupLoginLighting(false, _T.PlayerLight, _T.PriorLightMapTint)
			end

			local v70 = __wf_atom_72884638("LotusGameRules.DemoMode")
			mMovie:__wf_atom_dac78d3d(v70)

			if gGameRules:IsA(__wf_atom_311a7128) then
				gGameRules:__wf_atom_38e61d94()
				local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()
				__wf_atom_ade7f08f.loadFromLobby = false
				__wf_atom_ade7f08f.migrateServer = true
				__wf_atom_ade7f08f.hostingMultiplayer = not __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761())
				__wf_atom_ade7f08f.gameRules = WeakResource("/Lotus/Types/GameRules/LotusGameRules")
				gGameRules:__wf_atom_d3b879d4(__wf_atom_ade7f08f)
				Engine.OpenLevel(__wf_atom_ade7f08f)
			end

			_T.BackgroundMovie:Execute("OnLoginDone", "")

			if Engine.__wf_atom_84bb79c2() then
				mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, false)
			end

			local MATCHMAKING_QUICKMATCH_GAMEMODE = _T.MATCHMAKING_QUICKMATCH_GAMEMODE
			_T.gQueueMailbox = false
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

				if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
					if _G.StalkerMode then
						__wf_atom_9be88b01:__wf_atom_1cb25f9e(_T.MATCHMAKING_QUICKMATCH_GAMEMODE)
					elseif __wf_atom_9be88b01:__wf_atom_cb02838c() then
						_T.gQueueMailbox = true
					end

					MATCHMAKING_QUICKMATCH_GAMEMODE = __wf_atom_9be88b01:__wf_atom_bdcb3fb9()
				end
			end

			_T.gActiveMatchMakingMode = MATCHMAKING_QUICKMATCH_GAMEMODE

			if __wf_atom_c67f9605:__wf_atom_6d03a710() then
				if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
					_T.ForegroundMovie:Execute(
						"ShowRequireExitMessage",
						"/Lotus/Language/Menu/MainMenu_NewBuildAvailable"
					)
				end
			elseif __wf_atom_c67f9605:__wf_atom_dd8bc9ed() and not __wf_atom_7e8ad928(_T.ForegroundMovie) then
				_T.ForegroundMovie:Execute("ShowRequireExitMessage", "/Lotus/Language/Menu/MainMenu_BugReportPending")
			end

			__wf_atom_ec43d06e(mMovie, "BG", 2, { 12 }, { 0 }, 1)
			mMovie:__wf_atom_2dedec1a("LoginPanel", 13, false)
			mMovie:__wf_atom_2dedec1a("FirstLoginBacker", 13, false)
			mMovie:__wf_atom_2dedec1a("Logos", 13, false)
			mMovie:__wf_atom_2dedec1a("BuildLabel", 13, false)

			if v47 then
				v6:SetVisible(false)
			end

			if _T.UpdateProfileIconList ~= nil then
				_T.UpdateProfileIconList()
			end

			if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
				_T.ForegroundMovie:Execute("RefreshActivePlayType", "")
			end

			if v66 then
				gMatchingService:__wf_atom_27e16961()
			end

			fn33()
			fn28()
			local postProcess = gRegion:__wf_atom_8ad59546().postProcess
			postProcess.focalNearPlane = 0
			postProcess.focalNearDepth = 0
			postProcess.focalFarPlane = 0
			postProcess.focalFarDepth = 0
			postProcess.horizonDOF = 0
			postProcess.horizonRadius = 0.5

			if Engine.__wf_atom_fc67ba71() and v15 then
				fn6()
			end
		end

		mMovie:__wf_atom_c884ca43(module.Ternary(v2 == 0, false, true))

		if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
			_T.ForegroundMovie:Execute("SetInputBlocked", "0")
		end

		_T.BackgroundMovie:Execute("ForceClearChildMovie", "")
	end

	print("SetCurrentState checking states: " .. tostring(v69) .. " currentState: " .. tostring(v2))

	if __wf_atom_7e8ad928(v69) then
		local function fn37()
			if __wf_atom_7e8ad928(gRegion) or __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
				v:AddTimer(0.2, fn37)
			else
				fn36()
			end
		end

		fn37()
	elseif v69 == 0 then
		__wf_atom_ec43d06e(mMovie, "LoginPanel", 2, { 12 }, { 0 }, 0.2, 0, fn36)
		__wf_atom_ec43d06e(mMovie, "Logo", 2, { 12 }, { 0 }, 0.2)
		__wf_atom_ec43d06e(mMovie, "FirstLoginBacker", 2, { 12 }, { 0 }, 0.2)
		__wf_atom_ec43d06e(mMovie, "BackerImage", 2, { 12 }, { 0 }, 0.2)

		if Engine.__wf_atom_e43a530e() then
			__wf_atom_ec43d06e(mMovie, "LoginPanel_PS4", 2, { 12 }, { 0 }, 0.2)
		elseif Engine.__wf_atom_84bb79c2() then
			__wf_atom_ec43d06e(mMovie, "LoginPanel_PS4", 2, { 12 }, { 0 }, 0.2)
			mMovie:__wf_atom_2dedec1a("XBoneComponents", 13, false)
		end
	else
		fn36()
	end

	if p == 1 then
		local entity = module.GetEntityFromTag("MenuSuit", module.Ternary(module3.IsInHub(), __wf_atom_392793db, nil))

		if not __wf_atom_7e8ad928(entity) then
			entity:SetVisibility(false, true)
		end

		if __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(module.GetChatMovie()))) then
			mMovie:PushChildMovie(module.GetChatMovie())
		end
	end
end

function Close_Dialog(_) end

function ConfirmHostFailed() end

function OnScenarioLobbyReady(p)
	if p then
		local __wf_atom_6819071c = gGameData:__wf_atom_6819071c()

		if __wf_atom_6819071c.hubInstance >= 0 then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local c_str = __wf_atom_6819071c.location:c_str()
				local v69 = {
					difficulty = 0.5,
					baseNodeName = c_str,
					name = c_str .. "_HUB"
				}

				if _T.SquadOverlay then
					gMatchingService:__wf_atom_e9772176(__wf_atom_6819071c.hubInstance)
					_T.SquadOverlay:__wf_atom_f62a8704("OnSquadMissionSelected", {
						__wf_atom_18a5d83b:__wf_atom_e75653c3(),
						cjson.encode(v69),
						"true"
					})
					return
				end
			end
		end
	end

	local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
	local v69 = __wf_atom_91952c92 == "" and "/Lotus/Language/Menu/Multiplayer_FailedToHost" or __wf_atom_91952c92
	module.ShowMessage(mMovie:__wf_atom_8e9ac384(v69, false), "ConfirmHostFailed")
end

local function fn36()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(__wf_atom_18a5d83b:__wf_atom_9be88b01()) then
		return
	end

	__wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_f4d37998()
	__wf_atom_a0f6588f:__wf_atom_beda43f0(0)
end

function ConfirmScenarioReconnect(p)
	if tonumber(p) == 4 or p == "true" then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(__wf_atom_18a5d83b:__wf_atom_9be88b01()) then
			return
		end

		local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

		if __wf_atom_9be88b01:__wf_atom_6819071c().hubInstance >= 0 then
			if __wf_atom_9be88b01:__wf_atom_bdcb3fb9() == _T.MATCHMAKING_OFFLINE_GAMEMODE then
				mMovie:Execute("OnScenarioLobbyReady", "true")
			else
				module2.HostSquadSession("OnScenarioLobbyReady")
			end
		end
	else
		fn36()
	end
end

local function fn37()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(__wf_atom_18a5d83b:__wf_atom_9be88b01()) then
		return
	end

	local __wf_atom_6819071c = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_6819071c()

	if __wf_atom_6819071c.hubInstance >= 0 and _T.SquadOverlay then
		if _G.CachedGoalInfo then
			local c_str = __wf_atom_6819071c.location:c_str()

			for _, v69 in pairs(_G.CachedGoalInfo) do
				if not (v69 and v69.mNode == c_str and Engine.__wf_atom_db2b0cee(v69.mActivation) <= 0 and Engine.__wf_atom_db2b0cee(v69.mExpiry) > 0) then
					continue
				end

				module.ShowYesOrNoMessage(
					"/Lotus/Language/SquadLink/ScenarioReconnectPrompt",
					"ConfirmScenarioReconnect"
				)
				return
			end
		end

		fn36()
	end
end

function ConfirmSessionReconnect(p)
	if tonumber(p) == 4 or p == "true" and gMatchingService:IsFindSessionsProcessDone() then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if p ~= "true" then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
		end

		local v69 = not __wf_atom_7e8ad928(v48.session)
			and v48.session:GetSettings().gameModeId == module3.BuildGameModeIdForClanDojo()
		print("HandleSessionReconnectResult. DojoDuel=" .. tostring(v69))
		local team = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_bf0172cf().team
		local v70 = module2.CheckSingleSessionResults(
			true,
			false,
			team,
			true,
			mMovie,
			"ConfirmSessionReconnect",
			false,
			false,
			true
		)

		if type(v70) == "string" then
			print("Result: " .. v70)
			fn34()
			fn36()
		else
			local gameModeId = v70:GetSettings().gameModeId
			local nodeName = module3.GetNodeNameFromGameModeId(gameModeId)

			if nodeName ~= nil then
				local nodeModifierTag = module3.GetNodeModifierTagFromGameModeId(gameModeId)
				local v71 = module8.CheckConclaveRequirements(Symbol(nodeName .. nodeModifierTag), true)
				local v72 = v71 == nil
					and module3.GetStarChart():BuildMissionForLocation(Symbol(nodeName)).missionType == 23
					and {
						text = Localize("/Lotus/Language/Menu/MissionLocationUnavailable", nil)
					}
					or v71

				if v72 ~= nil then
					module8.ShowMissionRequirementsError(v72)
					return
				end
			end

			if v69 then
				gMatchingService:JoinSession(__wf_atom_18a5d83b, v48.session, false, 255, "OnJoinLobbyComplete")
			else
				gMatchingService:JoinSquadSession(
					__wf_atom_18a5d83b,
					v48.session,
					false,
					v48.teamId,
					"OnJoinLobbyComplete"
				)
			end
		end
	else
		fn34()
		fn37()
	end
end

local function fn38(p)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local team = __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_bf0172cf().team
	local session = module2.CheckSingleSessionResults(p, false, team, true, mMovie, "OnFindSessionComplete", true, true)

	if type(session) == "string" then
		fn34()
		fn37()
	else
		v48.session = session
		v48.teamId = team

		if Engine.__wf_atom_fc67ba71() and not (fn22() or _G.StalkerMode) then
			flag5 = true
		else
			module.ShowYesOrNoMessage("/Lotus/Language/Menu/ClientSessionReconnectPrompt", "ConfirmSessionReconnect")
		end
	end
end

function OnFindOriginalSessionComplete(p)
	print("OnFindOriginalSessionComplete")

	if p and gMatchingService:__wf_atom_1368e60b() ~= 0 then
		fn38(p)
		return
	end

	local __wf_atom_bf0172cf = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01():__wf_atom_bf0172cf()

	if not module2.FindSessionById(__wf_atom_bf0172cf.id, "OnFindSessionComplete") then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end
end

function OnFindSessionComplete(p)
	fn38(p)
end

function OnJoinLobbyComplete(p)
	print("OnJoinLobbyComplete | result: " .. tostring(p))
	fn34()
	fn36()

	if p then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")

		if not __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
			_T.BackgroundMovie:Execute("GoToLobby", "")
		end
	else
		_T.BackgroundMovie:Execute("ShowBlockingMessage", 0)
		local __wf_atom_91952c92 = gMatchingService:__wf_atom_91952c92()
		local v69 = __wf_atom_91952c92 == "" and "/Lotus/Language/Menu/SocialOverlay_SessionJoinFail"
			or __wf_atom_91952c92
		module.ShowMessage(v69)
	end
end

function OnLobbyReady(p)
	if p and v5 ~= nil then
		flag2 = true
		return
	end

	print("No lobby!  Oh dear")
	v5 = nil
end

local function fn39()
	v54 = true
	_G.LoginSequencePlayed = nil
	fn18(Engine.__wf_atom_2a979d69())
	print("Main menu - _LogOut()")

	if not __wf_atom_7e8ad928(chatMovie) then
		local movie = __wf_atom_8e4fda44:FindMovie(chatMovie)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):Close()
	end

	if Engine.__wf_atom_fc67ba71() then
		v18 = false
	end

	fn35(0)

	if not __wf_atom_7e8ad928(v9) then
		v9:Close()
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:Close()
	end

	if not Engine.__wf_atom_2a979d69() then
		local mLabel

		if v26 == nil then
			mLabel = v20.mLabel
		else
			mLabel = v26
		end

		if mLabel ~= nil and string.len(mLabel) > 0 then
			v21:TryPressed(true)
		end
	end

	v54 = false
end

function LogOut()
	print("Main menu - LogOut()")
	fn39()
end

fn2 = function()
	flag = true
end

fn3 = function()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		print("ShowConsent has no playerprofile")
		return
	end

	local __wf_atom_4a32e35e = __wf_atom_18a5d83b:__wf_atom_4a32e35e()

	for i = 1, #__wf_atom_4a32e35e do
		if __wf_atom_7e8ad928(string.match(__wf_atom_4a32e35e[i].name, "PrivacyUpdated")) then
		end
	end

	fn35(2)
end

function ConfirmQuit(p)
	_T.ShowingQuitGameDialog = nil

	if tonumber(p) == 4 then
		__wf_atom_8e4fda44:__wf_atom_bcb70491(cmdQuit)
	end
end

local v69 = false

local function fn40()
	v69 = true
end

local function fn41()
	v69 = false
end

fn5 = function()
	return mInputBlocked or Engine.__wf_atom_fc67ba71() and not __wf_atom_7e8ad928(v9)
end

local function fn42()
	if not (Engine.__wf_atom_fc67ba71() or fn5() or v20.mSelected) then
		v20:TryPressed(true)
	end
end

local function fn43()
	if not (Engine.__wf_atom_fc67ba71() or fn5() or v21.mSelected) then
		v21:TryPressed(true)
	end
end

function onKeyUp_MENU_LEFT()
	fn42()
	return true
end

function onKeyUp_MENU_LEFT_FROM_ANALOG()
	fn42()
	return true
end

function onKeyUp_MENU_RIGHT()
	fn43()
	return true
end

function onKeyUp_MENU_RIGHT_FROM_ANALOG()
	fn43()
	return true
end

local function fn44()
	if v2 ~= 0 or v30 or v32 then
		return
	end

	local v70 = string.lower(__wf_atom_c67f9605:__wf_atom_2863bfee())

	if Engine.__wf_atom_e43a530e() then
		v70 ..= "signupPSN.php"
	elseif Engine.__wf_atom_84bb79c2() then
		v70 ..= "signupXBLive.php"
	elseif Engine.__wf_atom_b290ec01() then
		v70 ..= "signupNSAccount.php"
	end

	fn26(true)
	v30 = true

	if v23 ~= nil then
		v23:SetVisible(false)
	end

	if v24 ~= nil then
		v24:SetVisible(false)
	end

	__wf_atom_a0f6588f:__wf_atom_70639fea(v70, "OnGetModifiedSignupUrl")
end

local function fn45()
	__wf_atom_a0f6588f:__wf_atom_70639fea("https://www.soulframe.com/signup", "OnGetModifiedSignupUrlPC")
end

function OnSignUpComplete(p, value)
	fn26(false)
	print("OnSignUpComplete")

	if p then
		fn27("", "", true)
	else
		print("Msg " .. tostring(value))
		local v70 = string.find(value, "notAdult") ~= nil and "/Lotus/Language/Menu/SignupFailedAge"
			or "/Lotus/Language/Launcher/LoginFailedNoConnection"

		if Engine.__wf_atom_b290ec01() then
			if string.find(value, "dupename") ~= nil then
				v32 = false
				module.ShowMessage("/Lotus/Language/Menu/Profile_AccountNameFail_DUPLICATE", "NewAccount")
				return
			elseif string.find(value, "restrictedname") ~= nil then
				v32 = false
				module.ShowMessage("/Lotus/Language/Menu/Generic_Name_CENSORED", "NewAccount")
				return
			end
		end

		module.ShowMessage(v70)

		if Engine.__wf_atom_84bb79c2() then
			fn18()

			if v23 ~= nil then
				v23:SetVisible(true)
			end

			flag4 = true
			mAllowedAdvanceFromLogin = false
			v32 = false
			return
		else
			if v23 ~= nil then
				v23:SetVisible(true)
				mInputBlocked = false
			end

			if v24 ~= nil then
				v24:SetVisible(Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a())
			end
		end
	end

	v32 = false
end

local function fn46(value)
	local v70 = string.find(value, "User is not signed up to PSN") ~= nil
	local v71 = string.find(value, "Specified user was not found") ~= nil
	local v72 = string.find(value, "User is signed out of PSN") ~= nil
	local v73 = string.find(value, "User is signed out of Xbox Live") ~= nil
	module.ShowMessage(v70 and "/Lotus/Language/Menu/LoginFailedPSN" or v71 and "/Lotus/Language/Launcher/LoginFailed" or v72 and "/Lotus/Language/Menu/LoginFailedPSN" or v73 and "/Lotus/Language/Menu/LoginFailedXBoxLive" or "/Lotus/Language/Launcher/LoginFailed")
end

function SwitchOnBadNameAcknowledged()
	module4.ShowInputDialog(
		mMovie,
		"/Lotus/Language/Menu/Profile_AccountSignupName",
		"",
		24,
		"SwitchGotAccountName",
		"SwitchGotAccountName",
		{ isMultiline = false, cancelDisabled = true }
	)
end

function SwitchGotAccountName(_, value)
	local invalidNameCharacters = module.GetInvalidNameCharacters(value)

	if invalidNameCharacters > 0 then
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/SocialOverlay_InvalidCharacter", false) .. __wf_atom_f50c9d2d(
				value,
				invalidNameCharacters,
				invalidNameCharacters
			),
			"SwitchOnBadNameAcknowledged"
		)
		return
	end

	if string.len(value) > 24 then
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_AccountNameFail_TOO_LONG", false),
			"SwitchOnBadNameAcknowledged"
		)
		return
	end

	if string.len(value) < 4 then
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Profile_AccountNameFail_TOO_SHORT", false),
			"SwitchOnBadNameAcknowledged"
		)
		return
	end

	local v70 = __wf_atom_bb4529ac(value)

	if __wf_atom_f8f86fc5(v70, 1) ~= v70 then
		module.ShowMessage("/Lotus/Language/Menu/Generic_Name_CENSORED", "SwitchOnBadNameAcknowledged")
		return
	end

	local v71 = v34 .. "&NSAccountName=" .. v70
	Engine.WebGet(v71, "OnSignUpComplete")
end

function OnGetModifiedSignupUrl(p, p2)
	v30 = false
	v34 = p2

	if p then
		v32 = true

		if Engine.__wf_atom_b290ec01() then
			module4.ShowInputDialog(
				mMovie,
				"/Lotus/Language/Menu/Profile_AccountSignupName",
				"",
				24,
				"SwitchGotAccountName",
				"SwitchGotAccountName",
				{ isMultiline = false, cancelDisabled = true }
			)
		else
			__wf_atom_a0f6588f:__wf_atom_9a39bf1b(p2, "OnSignUpComplete")
		end
	else
		fn26(false)
		print("Unable to get modified url for signup process")
		fn46(p2)

		if v23 ~= nil then
			v23:SetVisible(true)
			mInputBlocked = false
		end

		if v24 ~= nil then
			v24:SetVisible(Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a())
		end
	end
end

function NewAccountPC()
	fn45()
end

function OnGetModifiedSignupUrlPC(p, p2)
	if p then
		fn21(p2)
	end
end

function OSKUserNameCallback(p, p2)
	if p then
		print("cancelled by user")
	else
		v20:SetText(p2)
	end

	v36 = false
end

function OSKPwdCallback(p, p2)
	if p then
		print("cancelled by user")
	else
		v21:SetText(p2)
	end

	v36 = false
end

local function fn47()
	if v2 ~= 0 or Engine.__wf_atom_578fc9dd() then
		return
	end

	fn21(module3.IsDevServer() and "https://dev.soulframe.com/resetpassword" or module3.IsTestServer() and "https://test.soulframe.com/resetpassword" or module3.IsLocalServer() and "http://localhost/resetpassword" or "https://www.soulframe.com/resetpassword")
end

local v70 = false
local v71 = false
local v72 = false

function onRawInputEvent(p, p2, p3)
	if Engine.__wf_atom_140b2555() then
		if p2 == "EN_GAMEPAD_R2" then
			v70 = p3 == "1"
		elseif p2 == "EN_GAMEPAD_L2" then
			v71 = p3 == "1"
		elseif p2 == "EN_GAMEPAD_BUTTON_TOP" then
			v72 = p3 == "1"
		end

		if v70 and v71 and v72 then
			v35 = true
			fn17()
		end
	end

	local v73 = not __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie)

	if p2 == "EN_LSHIFT" or p2 == "EN_RSHIFT" then
		v27 = p3 == "1"
	elseif p2 == "EN_TAB" and p3 == "1" then
		if v27 or not v20.mSelected then
			if v27 and v21.mSelected then
				v20:TryPressed(true)
			end
		else
			v21:TryPressed(true)
		end
	elseif p2 == "EN_GAMEPAD_BUTTON_RIGHT" and p3 == "1" and Engine.__wf_atom_5f0554d9() and not fn5() and v73 then
		_T.ShowingQuitGameDialog = true
		module.ShowYesOrNoMessage("/Lotus/Language/Menu/QuitGameConfirm", "ConfirmQuit")
		return true
	else
		if p2 == "EN_GAMEPAD_RIGHT" and p3 == "1" then
			fn43()
			return true
		end

		if p2 == "EN_GAMEPAD_LEFT" and p3 == "1" then
			fn42()
			return true
		end

		if p2 == "EN_GAMEPAD_START" and __wf_atom_72884638("LotusGameRules.DemoMode") and p3 == "1" then
			if __wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) then
				fn12()
			else
				print("non null session!!")
				return
			end
		elseif
			not fn5()
			and (p2 == "EN_ENTER" or p2 == "EN_KP_ENTER")
			and not (Engine.IsPlayingWithController() or __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie))
		then
			fn19()
		end
	end

	if p2 == "EN_MOUSE_B0" then
		if p3 == "1" then
			fn40()
		else
			fn41()
		end
	end

	fn20()

	if
		not v35
		and Engine.__wf_atom_84bb79c2()
		and p2 == "EN_GAMEPAD_BUTTON_BOTTOM"
		and p3 == "1"
		and v23 ~= nil
		and v2 == 0
		and flag4
		and not __wf_atom_7e8ad928(gRegion)
		and __wf_atom_8e4fda44:__wf_atom_6ce80e77() == 0
	then
		if gRegion:__wf_atom_9f7eb1c3() then
			gRegion:__wf_atom_f35eb741(p, true)
			fn8(true)
		else
			gRegion:__wf_atom_d3cccaa6(p)
		end
	end

	if not (Engine.__wf_atom_fc67ba71() or v47) then
		if p2 == "EN_GAMEPAD_LTHUMB" then
			fn47()
		end

		if p2 == "EN_GAMEPAD_RTHUMB" then
			fn45()
		end
	end
end

local function fn48(p, p2)
	if not __wf_atom_7e8ad928(v16) then
		v16:Update(p, p2)
	end

	local screenDimensions, v73 = module.GetScreenDimensions(mMovie)
	mMovie:__wf_atom_e57658c2("ScreenBlocker", 14, screenDimensions)
	mMovie:__wf_atom_e57658c2("ScreenBlocker", 15, v73)

	if not __wf_atom_7e8ad928(v25) then
		v25:OnViewportSizeChanged()
	end
end

function onViewportSizeChanged(p, p2, _, _)
	fn48(p, p2)
end

function ForgotPassword()
	fn47()
end

function RollOverGearItem(p)
	_T.gToolTip = v7[p]
end

function RollOutGearItem()
	_T.gToolTip = nil
end

local function fn49()
	if v2 == 3 then
		local levelArgs = Engine.OpenLevelArgs()
		levelArgs:SetLevel(__wf_atom_c67f9605:__wf_atom_7411f278())
		levelArgs.gameRules = tutorialGameRules
		local __wf_atom_db2d8292 = module3.GetStarChart():__wf_atom_db2d8292(Symbol("/Lotus/Language/Locations/Earth"))

		if __wf_atom_7e8ad928(__wf_atom_db2d8292) then
			print("Error: Unable to find void region")
		else
			if __wf_atom_db2d8292.resources ~= nil then
				for _, resource in ipairs(__wf_atom_db2d8292.resources) do
					if not __wf_atom_7e8ad928(resource.mStoreItem) then
						levelArgs:__wf_atom_fce3b660(resource.mStoreItem)
					end

					if not __wf_atom_7e8ad928(resource.mItemType) then
						levelArgs:__wf_atom_fce3b660(resource.mItemType)
					end

					if not __wf_atom_7e8ad928(resource.mDecoType) then
						levelArgs:__wf_atom_fce3b660(resource.mDecoType)
					end
				end
			end

			if __wf_atom_db2d8292.drops ~= nil then
				for _, drop in ipairs(__wf_atom_db2d8292.drops) do
					if not __wf_atom_7e8ad928(drop.mStoreItem) then
						levelArgs:__wf_atom_fce3b660(drop.mStoreItem)
					end

					if not __wf_atom_7e8ad928(drop.mItemType) then
						levelArgs:__wf_atom_fce3b660(drop.mItemType)
					end

					if not __wf_atom_7e8ad928(drop.mDecoType) then
						levelArgs:__wf_atom_fce3b660(drop.mDecoType)
					end
				end
			end
		end

		Engine.OpenLevel(levelArgs)
		_G.LoadingTutorial = true
	else
		v3 = 3
		fn35(4)
	end
end

function StartNewPlayerIntro()
	gMatchingService:LeaveSquad(fn49)
end

function BackerImageReady(p, p2)
	v63 = p

	if v63 then
		mMovie:__wf_atom_c90af43a("BackerImage", Resource(p2))
		mMovie:__wf_atom_e57658c2("BackerImage", 14, 1000)
		mMovie:__wf_atom_e57658c2("BackerImage", 15, 1000)
	end
end

local function fn50()
	mMovie:__wf_atom_e57658c2("BackerImage", 12, 0)

	if not (__wf_atom_7e8ad928(backerImage) or __wf_atom_7e8ad928(gGameRules)) then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false)

		if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if not __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				local __wf_atom_4f33ef14 = __wf_atom_9be88b01:__wf_atom_4f33ef14()

				if
					not __wf_atom_7e8ad928(__wf_atom_4f33ef14)
					and __wf_atom_4f33ef14:IsA(WeakResource("/Lotus/Types/GameRules/CampFirstLoadFrontEndGameRules"))
				then
					gGameRules:RequestResource(backerImage:__wf_atom_5b41f63b(), "BackerImageReady")
					mMovie:__wf_atom_2dedec1a("Logo", 13, false)
					_T.NewWarConsoleLogin = __wf_atom_a0f6588f:__wf_atom_f89aa44a() and Engine.__wf_atom_fc67ba71()
					return
				end
			end
		end
	end

	v63 = false
end

local function fn51()
	gMatchingService:__wf_atom_5e652839("AnalyzeCallback")

	if Engine.__wf_atom_fc67ba71() or __wf_atom_21342f4a == nil then
		return
	end

	local stats = Engine.GetStats()

	for _, stat in ipairs(stats) do
		__wf_atom_21342f4a:__wf_atom_3c9aa248(stat.key, stat.target, "", stat.count)
	end
end

function Shutdown()
	print("*** Main menu -- shutdown ***")
end

function Initialize()
	print("*** Main menu -- initialize ***")
	v47 = Engine.__wf_atom_578fc9dd()
	_T.UnlinkSteamAccountByUser = false
	v49 = Engine.__wf_atom_e43a530e() and not __wf_atom_72884638("PS4.RequirePSN", true)
	v35 = false
	_T.PriorLightMapTint = Color(255, 255, 255)
	mMovie:__wf_atom_2dedec1a("CaptchaImage", 13, false)

	if v47 then
		mMovie:__wf_atom_976dcedd("ArialAnchor", "text", "")
	end

	fn50()

	if not __wf_atom_7e8ad928(_T.ForegroundMovie) then
		_T.ForegroundMovie:Execute("SetInputBlocked", "1")
	end

	if Engine.__wf_atom_fc67ba71() and not v49 then
		mMovie:__wf_atom_e57658c2("Spinner", 1, 590)

		if Engine.__wf_atom_e43a530e() and _T.BackgroundMovie:Execute("IsMenuSuitAvatarShowing", "") then
			fn14()
		else
			mMovie:__wf_atom_2dedec1a("ScreenBlocker", 13, true)
		end
	else
		fn14()
	end

	local v73

	if
		__wf_atom_7e8ad928(gGameRules)
		or not gGameRules:IsA(WeakResource("/Lotus/Types/GameRules/CampFirstLoadFrontEndGameRules"))
	then
		v73 = 0
	else
		mMovie:__wf_atom_2e64957a(false)
		v73 = 375
		local buttonBarMovie = _T.ButtonBarMovie

		if not __wf_atom_7e8ad928(buttonBarMovie) then
			buttonBarMovie:__wf_atom_2e64957a(false)
		end
	end

	mMovie:__wf_atom_2dedec1a("LoginPanel", 13, not Engine.__wf_atom_fc67ba71())
	mMovie:__wf_atom_e57658c2("LoginPanel_PS4", 0, 875 - v73)
	mMovie:__wf_atom_e57658c2("XBoneComponents", 0, 1175 - v73)
	mMovie:__wf_atom_e57658c2("ContinueAnchor", 0, 1175 - v73)
	mMovie:__wf_atom_2dedec1a("Logo.Logo.LogoDeco", 13, not __wf_atom_7e8ad928(logoDecoTexture))
	mMovie:__wf_atom_933bbce0("Logo.Logo.LogoDeco", logoDecoTexture, logoDecoMaterial)
	mMovie:__wf_atom_7d7314f1("Logo.UpdateName.Text", "/SF/Language/Updates/TitleText")
	mMovie:__wf_atom_e57658c2("Logo.UpdateName", 0, 8)
	mMovie:__wf_atom_e57658c2("Logo.UpdateName", 11, 10066329)
	v16 = module7.Create(mMovie)
	v16:Register(mMovie, "BuildLabel", { v16.ANCHOR_V_BOTTOM, v16.ANCHOR_H_LEFT })
	local module11 = require("Lotus.Interface.Libs.TimerMgr")
	v = module11.CreateTimerMgr()
	local module12 = require("Lotus.Interface.Components.ThemedSpinner")
	v25 = module12.Create(mMovie, "Spinner")
	mMovie:__wf_atom_384aa4e8("LoginPanel_PS4.Disclaimer", "OnHyperlinkPressed")

	if Engine.__wf_atom_fc67ba71() then
		local v74 = ""

		if Engine.__wf_atom_703b1471() then
			v74 = "/Lotus/Language/Menu/WarframeSEN_LinkAccounts"
		elseif Engine.__wf_atom_6d151271() then
			v74 = "/Lotus/Language/Menu/WarframeSEN_LinkAccounts_PS5"
		elseif Engine.__wf_atom_84bb79c2() then
			if not __wf_atom_7e8ad928(gRegion) then
				gRegion:__wf_atom_ea091a05("OnProfilePickerCompleted")
			end

			mMovie:__wf_atom_2dedec1a("XBoneComponents.ProfileName", 13, false)
			v74 = "/Lotus/Language/Menu/WarframeXBONE_LinkAccounts"
		end

		local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Hyperlink)
		local convertColorNumberToHex2 = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
		local v75 = ""

		for i = 1, #v60 do
			v75 ..= "<a color=\"" .. convertColorNumberToHex .. "\" hovercolor=\"" .. convertColorNumberToHex2 .. "\" href=\"#onHyperLinkPressed:" .. Localize(v60[i], false) .. "\">" .. mMovie:__wf_atom_8e9ac384(
				"/Lotus/Language/Menu/Warframe_ConsoleDisclaimerName" .. i,
				true
			) .. "</a>"

			if i ~= #v60 then
				v75 ..= "<br>"
			end
		end

		local v76 = "<p><font color=\"#FFFFFF\">" .. mMovie:__wf_atom_8e9ac384(v74, true) .. "<br>" .. v75 .. "</font></p>"
		mMovie:__wf_atom_50d60589("LoginPanel_PS4.Disclaimer", 36, v76)
		mMovie:__wf_atom_50d60589("LoginPanel_PS4.Disclaimer", 45, "center")
	end

	mMovie:__wf_atom_2dedec1a("XBoneComponents", 13, Engine.__wf_atom_84bb79c2())
	mMovie:__wf_atom_e57658c2("BG", 12, 0)
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v74

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		v74 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	end

	local __wf_atom_f89aa44a = __wf_atom_a0f6588f:__wf_atom_f89aa44a()

	if __wf_atom_f89aa44a and not __wf_atom_7e8ad928(v74) then
		local hasMissionStats = #v74:__wf_atom_8ba10f50() > 0
		_T.hasMissionStats = hasMissionStats
	end

	local v75 = __wf_atom_d9227398()
	local logoTexture = logoTexture

	if v75 then
		logoTexture = logoChinaTexture
		logoVideoTex = nil
		logoVideoMat = nil
	end

	mMovie:__wf_atom_976dcedd("_root", "name", "MainMenu")
	mMovie:__wf_atom_c90af43a("Logo.Logo", logoTexture)
	mMovie:__wf_atom_e57658c2("Logo.LogoAlt", 12, 0)
	mMovie:__wf_atom_933bbce0("Logo.LogoVideo", logoVideoTex, logoVideoMat)
	mMovie:__wf_atom_e57658c2("Logo.LogoVideo", 12, 0)
	mMovie:__wf_atom_7d7314f1("LoginPanel.CapsLock.text", "/Lotus/Language/Menu/MainMenu_CapsLock")
	mMovie:__wf_atom_2dedec1a("Logos", 13, v47)

	if v75 or Engine.__wf_atom_b290ec01() then
		mMovie:__wf_atom_2dedec1a("Logos.OtherLogo", 13, Engine.__wf_atom_b290ec01())

		if v75 then
			mMovie:__wf_atom_976dcedd("Logos.DELogo", "_x", -30)
		end

		if Engine.__wf_atom_b290ec01() then
			mMovie:__wf_atom_c90af43a("Logos.OtherLogo", logoOtherTexture)
			mMovie:__wf_atom_e57658c2("Logos.DELogo", 0, 167.5)
		end
	end

	if v75 then
		mMovie:__wf_atom_2dedec1a("Logos.OtherLogo", 13, false)
		mMovie:__wf_atom_2dedec1a("Logos.DELogo", 13, true)
	end

	flag2 = false
	v2 = nil
	v4 = false
	v8 = nil
	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	mMovie:__wf_atom_e57658c2("LoginPanel", 12, 0)
	mMovie:__wf_atom_e57658c2("Logo", 12, 0)
	local module13 = require("SF.Interface.Components.InputField")
	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InputPromptEmail", false)
	v20 = module13.Create(getfenv(1), "LoginPanel.Email")
	v20:SetType(v20.TYPE.EMAIL, __wf_atom_8e9ac384, __wf_atom_8e9ac384, "OSKUserNameCallback")
	v20.BaseInputFieldTextChanged = v20.InputFieldTextChanged

	function v20.InputFieldTextChanged(_, mLabel)
		if mInitialized and mInputBlocked then
			mLabel = v20.mLabel
		end

		v20:BaseInputFieldTextChanged(mLabel)
	end

	v20._AltPressed = v20.AltPressed

	function v20.AltPressed(object, p)
		if p and object.mLocked then
			v26 = nil
		end

		object:_AltPressed(p)
	end

	local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Menu/InputPromptPassword", false)
	v21 = module13.Create(getfenv(1), "LoginPanel.Password")
	v21:SetType(v21.TYPE.PASSWORD, __wf_atom_8e9ac384_2, __wf_atom_8e9ac384_2, "OSKPwdCallback")
	v21.BaseInputFieldTextChanged = v21.InputFieldTextChanged

	function v21.InputFieldTextChanged(_, mLabel)
		if mInitialized and mInputBlocked then
			mLabel = v21.mLabel
		end

		v21:BaseInputFieldTextChanged(mLabel)
	end

	local module14 = require("SF.Interface.Components.Button")
	v22 = module14.Create(
		mMovie,
		"LoginPanel.LoginBtn",
		"/Lotus/Language/Menu/MainMenu_Login",
		"Login",
		"<MENU_SELECT>"
	)
	v22:SetVariant(module14.VARIANTS.SPECIAL_BUTTON)
	v23 = module14.Create(
		mMovie,
		"LoginPanel_PS4.NewAccountAndLoginBtn",
		"/Lotus/Language/Menu/Global_Accept",
		"TiePSNAccountToWarframe",
		"<MENU_SELECT>"
	)
	v24 = module14.Create(
		mMovie,
		"XBoneComponents.SwitchProfileBtn",
		"/Lotus/Language/Menu/SwitchProfile",
		"SwitchProfile",
		"<MENU_GENERIC2>"
	)
	v24:SetVisible(false)
	v6 = module14.Create(
		mMovie,
		"ContinueAnchor.PressContinue",
		"/Lotus/Language/Menu/MainMenu_Continue",
		"PressContinue",
		"<MENU_SELECT>"
	)
	v6:SetVisible(v49)
	mMovie:__wf_atom_e57658c2("LoginPanel_PS4", 12, 0)
	mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, false)
	v23:Redraw()
	v24:Redraw()
	v6:Redraw()
	v23:SetPosition(nil, mMovie:__wf_atom_5e6e15c8("LoginPanel_PS4.Disclaimer", 41) + 15, module.CENTER_ALIGNED)
	v24:SetAnchor(module.CENTER_ALIGNED)
	v6:SetAnchor(module.CENTER_ALIGNED)
	v22:SetAnchor(module.CENTER_ALIGNED)
	local __wf_atom_8e9ac384_3 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/UPDATE_TITLE", true)
	mMovie:__wf_atom_7d7314f1("Logo.BetaLabel.text", __wf_atom_8e9ac384_3)
	mMovie:__wf_atom_50d60589("BuildLabel", 36, module6.GetBuildLabel())
	fn10()
	local previousLoggedInStreamerMode = _G.PreviousLoggedInStreamerMode

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		previousLoggedInStreamerMode = __wf_atom_18a5d83b:Settings():__wf_atom_a35494b3()
	end

	if not (Engine.__wf_atom_fc67ba71() or v47) then
		local v76 = __wf_atom_9a2b0be4("Client.Email")
		v19 = not __wf_atom_7e8ad928(v76) and string.len(v76) > 0

		if v19 then
			if previousLoggedInStreamerMode then
				v20:SetText(v76)
			else
				v26 = v76
				local v77, v78 = string.match(v76, "(.+)(@.+)")

				if v77 ~= nil and v78 ~= nil then
					local v79 = string.len(v77)
					local v80

					if v79 <= 2 then
						v80 = string.sub(v77, 1) .. "***"
					elseif v79 <= 6 then
						v80 = string.gsub(v77, "^(.).+(.)$", "%1***%2")
					else
						v80 = string.gsub(v77, "^(..).+(..)$", "%1***%2")
					end

					v76 = v80 .. v78
				end

				v20:SetText(v76)
				v20:SetLocked()
			end

			if not __wf_atom_f89aa44a then
				v21.mQueuePressed = true
			end
		end

		if __wf_atom_72884638("App.PressDemoMode") and __wf_atom_9a2b0be4("Client.PlayerHash") ~= "" then
			fn13()
		end
	end

	if previousLoggedInStreamerMode then
		mMovie:__wf_atom_2dedec1a(v20.mLabelClipName, 68, true)

		if v19 then
			v20:SetLocked()
		end
	end

	_G.PreviousLoggedInStreamerMode = nil

	local function fn52(object, p)
		object.mSilent = true
		object:SetWidth(320)
		object:SetPosition(0, nil, module.CENTER_ALIGNED)
		object:SetActive(false)
		object:SetHint(p)
		object:Redraw()
	end

	fn52(v20, "/SF/Language/Menu/InputPromptEmail")
	fn52(v21, "/SF/Language/Menu/InputPromptPassword")
	v66 = __wf_atom_a0f6588f:__wf_atom_f89aa44a()
	__wf_atom_fa1033ac("UI.ForceKeyboardIcons", true)
	mMovie:__wf_atom_62d09591(true)
	mInitialized = true
	v18 = __wf_atom_72884638("Client.AutoLogin") or __wf_atom_72884638("Client.HostMissionInfo")

	if Engine.__wf_atom_b290ec01() then
		v18 = true
		Engine.__wf_atom_e6cfd6f4(false)
	elseif Engine.__wf_atom_e43a530e() or Engine.__wf_atom_54205c5a() then
		v18 = not v49
	elseif Engine.__wf_atom_84bb79c2() then
		v18 = __wf_atom_72884638("Client.HostMissionInfo") or __wf_atom_72884638("Client.AutoLoginAsPC")
		__wf_atom_ec43d06e(mMovie, "ScreenBlocker", 1, { 12 }, { 0 }, 1, 0.1, fn14)
		fn26(false)

		if v23 ~= nil then
			v23:SetVisible(true)
		end

		if v24 ~= nil then
			v24:SetVisible(false)
		end

		gMatchingService:SetSquadHostHubLevelName("")
		print("Calling resetlogin from initialize mainmenu")
		fn18()
	end

	if __wf_atom_f89aa44a and not __wf_atom_7e8ad928(v74) then
		if v74:__wf_atom_24908c96() then
			if v74:__wf_atom_df64c481() or __wf_atom_a0f6588f:__wf_atom_48285177() then
				v55 = true
			else
				print("Login completed, have no starting gear")

				if v74:__wf_atom_5e78cad5() then
					fn51()
				end
			end
		end
	else
		local entity = module.GetEntityFromTag(
			"StarChartRoot",
			module.Ternary(module3.IsInHub(), __wf_atom_392793db, nil)
		)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetVisibility(false, true)
		end

		flag4 = true
	end

	if not __wf_atom_7e8ad928(v74) and v74:__wf_atom_d6083286() then
		module.ShowMessage("/Lotus/Language/Menu/DbUpdateFailed")

		if not __wf_atom_7e8ad928(v74) then
			v74:__wf_atom_4050d76b(false)
		end
	end

	_T.missionCamera = false

	if __wf_atom_72884638("LotusGameRules.DemoMode") then
		mMovie:__wf_atom_2dedec1a("LoginPanel.Logo", 13, false)
	end

	fn48(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
end

function OnChangYouMotp(_, _)
	_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
end

function OnCancelledMotpVerify()
	module4.ShowInputDialog(mMovie, "/Lotus/Language/Changyou/VerifyMotp", "", 128, "ChangYouMOTP", "OSKChangYouMOTP")
end

local function fn52(value)
	if value == nil or value == "" or type(value) ~= "string" then
		return nil, "Expected string"
	end

	local v73 = value:find("[^%@]+$")

	if v73 == nil then
		return nil, "Missing @ symbol"
	end

	local v74 = value:sub(1, v73 - 2)
	local v75 = value:sub(v73, #value)

	if v74 == nil then
		return nil, "Local name is invalid"
	end

	if v75 == nil then
		return nil, "Domain is invalid"
	end

	if #v74 > 64 then
		return nil, "Local name must be less than 64 characters"
	end

	if #v75 > 253 then
		return nil, "Domain must be less than 253 characters"
	end

	if v73 >= 65 then
		return nil, "Invalid @ symbol usage"
	end

	local v76 = v74:find("[\"]")

	if type(v76) == "number" and v76 > 1 then
		return nil, "Invalid usage of quotes"
	end

	if v74:find("%@+") and v76 == nil then
		return nil, "Invalid @ symbol usage in local part"
	end

	if v75:find("%.%.") then
		return nil, "Too many periods in domain"
	end

	if value:match("[%w]*[%p]*%@+[%w]*[%.]?[%w]*") then
		return true
	end

	return nil, "Email pattern test failed"
end

fn4 = function()
	if fn5() then
		return
	end

	print("StartLogin()")
	mInputBlocked = true
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or not __wf_atom_18a5d83b:__wf_atom_6c7eca06() then
		local v73

		if v26 == nil then
			v73 = __wf_atom_0a63ecce(v20.mLabel)
		else
			v73 = __wf_atom_0a63ecce(v26)
		end

		v51 = nil

		if Engine.__wf_atom_140b2555() and string.find(v73, "@") == nil then
			v73 ..= "@digitalextremes.com"
		end

		local accountsupportpage = "<a color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Hyperlink) .. "\" hovercolor=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\" href=\"#OnHyperlinkPressed:" .. mMovie:__wf_atom_8e9ac384(
			"/SF/Language/Launcher/AccountSupportPage",
			false
		) .. "\">" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/AccountSupport", false) .. "</a>"
		local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/LoginFailed", true, {
			ACCOUNTSUPPORTPAGE = accountsupportpage
		})
		local dialogSettings = Engine.DialogSettings()
		dialogSettings.dialogType = 0
		dialogSettings.locString = __wf_atom_8e9ac384
		dialogSettings.titleString = "/SF/Language/Launcher/LoginFailedHeading"

		if v73 == "" then
			mInputBlocked = false
			dialogSettings.locString = "/SF/Language/Launcher/LoginFailedEmptyField"
			module.ShowCustomMessage(dialogSettings)
		elseif string.find(v73, "@") == nil then
			mInputBlocked = false
			dialogSettings.locString = "/SF/Language/Launcher/LoginFailedNoAtSign"
			module.ShowCustomMessage(dialogSettings)
		else
			local v75, v76 = fn52(v73)

			if v75 then
				local mLabel = v21.mLabel
				local v77

				if mLabel == "" then
					v77 = __wf_atom_9a2b0be4("Client.PlayerHash")

					if __wf_atom_7e8ad928(v77) or v77 == "" then
						mInputBlocked = false
						dialogSettings.locString = "/SF/Language/Launcher/LoginFailedEmptyField"
						module.ShowCustomMessage(dialogSettings)
						return
					end
				end

				if _T.LoginTarPit == nil or not (Time() - _T.LoginTarPit < 900) then
					__wf_atom_fa72567b("Client.Email", v73)

					if __wf_atom_7e8ad928(v77) then
						v77 = __wf_atom_a1d009e6(mLabel)
					end

					if __wf_atom_72884638("Client.AutoLogin") then
						__wf_atom_fa72567b("Client.PlayerHash", v77)
					end

					fn27(v73, v77, false)
				else
					fn16(false)
					fn26(true)
					mInputBlocked = true
					v:AddTimer(1.5, function()
						module.ShowMessage("/Lotus/Language/Launcher/LoginFailedTarpit", "ConfirmLoginFailed")
						fn16(true)
						fn26(false)
						mInputBlocked = false
					end)
				end
			else
				mInputBlocked = false
				print("Invalid Email:" .. tostring(v76))
				module.ShowCustomMessage(dialogSettings)
			end
		end
	end
end

local function fn53()
	if not __wf_atom_7e8ad928(_T.introMusicInstance) then
		_T.introMusicInstance:Stop(false)
	end

	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local v73 = __wf_atom_9a2b0be4("LotusPvpGameRules.ForceStartUpMode")

	if not __wf_atom_7e8ad928(v73) and string.len(v73) > 0 then
		local __wf_atom_8d81f5f8 = SF.__wf_atom_8d81f5f8(v73)

		if __wf_atom_8d81f5f8 ~= 0 then
			fn35(1)
			local module11 = require("Lotus.Scripts.PVP.PVPHelper")
			local pvpMode2NodeID = module11.PVPMode2NodeID(__wf_atom_8d81f5f8)
			local encoded = cjson.encode({ name = pvpMode2NodeID, quest = "", difficulty = "" })
			gMatchingService:SendSquadMission(encoded)

			if gGameRules:IsA(__wf_atom_e714d8ac) then
				__wf_atom_9be88b01:__wf_atom_3f7ee611(2)
			end

			local missionForLocation = module3.GetStarChart():BuildMissionForLocation(Symbol(pvpMode2NodeID))
			module2.Host_LoadMission(
				Symbol(pvpMode2NodeID),
				missionForLocation,
				module.Ternary(
					not __wf_atom_7e8ad928(missionForLocation.levelKeyName),
					missionForLocation.levelKeyName,
					nil
				),
				true
			)
			return
		end
	end

	if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		local v74, _ = fn29()

		if not v74 then
			module.PlaySound(_G.UISound_LoginSuccess)
		end
	end

	if Engine.__wf_atom_fc67ba71() and not Engine.__wf_atom_6d151271() or v47 then
		mInputBlocked = false
		v6:SetVisible(not v49)

		if Engine.__wf_atom_b290ec01() and mAllowedAdvanceFromLogin == true then
			print("_AdvanceFromLogin() isSwitch")
			v6:SetVisible(false)
			fn35(4)
			mAllowedAdvanceFromLogin = false
		end

		mAllowedAdvanceFromLogin = true

		if Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a() then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				mMovie:__wf_atom_2dedec1a("XBoneComponents.ProfileName", 13, false)
			else
				local __wf_atom_6be84646 = __wf_atom_18a5d83b:__wf_atom_6be84646()
				mMovie:__wf_atom_2dedec1a("XBoneComponents.ProfileName", 13, true)
				mMovie:__wf_atom_50d60589("XBoneComponents.ProfileName", 36, __wf_atom_6be84646)
			end
		end

		_T.BackgroundMovie:Execute("SetupMenuSuit", "")

		if v49 then
			fn35(1)
		end

		if __wf_atom_6a6ca13e() ~= "" then
			v6:SetVisible(false)
			v3 = 4
			fn35(5)
		end
	else
		v3 = 4
		fn35(5)
	end

	if not __wf_atom_7e8ad928(gRegion) then
		local v74 = gRegion:__wf_atom_e23b2855()[1]

		if not __wf_atom_7e8ad928(v74) then
			v74:__wf_atom_87bb4276()
		end
	end

	_T.BackgroundMovie:Execute("CheckNewOmega", "")
end

function AdvanceFromLogin()
	fn53()
end

function StatsReceived(p)
	print("Main menu.lua - received stats")
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:__wf_atom_9be88b01():SyncChallengeStats(p.mReviveCount, p.mCiphersSolved)
	end
end

local function fn54()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:GetStatsFromServer(__wf_atom_18a5d83b:__wf_atom_e75653c3(), false, "StatsReceived")
	end
end

function OnInitActiveDrones() end

function OnUpdateSessionSettings() end

local function fn55()
	if
		v56
		and __wf_atom_7e8ad928((__wf_atom_8e4fda44:FindMovie(dailyTributeMovie)))
		and not __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false))
	then
		v56 = false

		if __wf_atom_7e8ad928(_T.SetClanEnum) then
			local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0, false):__wf_atom_9be88b01()
			local activeQuest, v73, v74, _ = module3.GetActiveQuest(__wf_atom_9be88b01)

			if not __wf_atom_7e8ad928(activeQuest) then
				for i = 1, #questKeyChainsToCheckForLoad do
					if not activeQuest:IsA(questKeyChainsToCheckForLoad[i]) then
						continue
					end

					local __wf_atom_8ffd7933 = activeQuest:__wf_atom_8ffd7933()

					if not (v73 <= #__wf_atom_8ffd7933) then
						return
					end

					local mKey = __wf_atom_8ffd7933[v73].mMainMission.mKey

					if __wf_atom_7e8ad928(mKey) then
						return
					end

					for j = 1, #questMissionKeysToCheckForLoad do
						if not mKey:IsA(questMissionKeysToCheckForLoad[j]) then
							continue
						end

						local __wf_atom_72fc675e = mKey:__wf_atom_72fc675e()
						__wf_atom_72fc675e.levelKeyName = mKey
						__wf_atom_72fc675e.keyChainName = activeQuest
						__wf_atom_72fc675e.difficulty = activeQuest:__wf_atom_916d8009(v73 - 1, v74)
						local __wf_atom_211412ff = mKey:__wf_atom_211412ff()

						if __wf_atom_211412ff ~= EMPTY_SYMBOL then
							__wf_atom_72fc675e.location = __wf_atom_211412ff
						end

						module2.Host_LoadMission(
							mKey:__wf_atom_211412ff(),
							__wf_atom_72fc675e,
							__wf_atom_72fc675e.levelKeyName
						)
						return
					end

					return
				end
			end
		end
	end
end

function OnQuestsChanged()
	v56 = true
	fn55()
end

function OnProfileSaved() end

fn = function()
	if v65 or flag6 then
		return
	end

	_G.gHasLoggedIn = true
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
	local settings = __wf_atom_18a5d83b:Settings()
	local __wf_atom_622bc136 = __wf_atom_c67f9605:__wf_atom_622bc136()

	if not __wf_atom_8e4fda44:__wf_atom_c2e9085e("TOGGLE_CHAT_WINDOW_ALT", false, menuInputFilter, false, false) then
		mMovie:__wf_atom_042a8818("TOGGLE_CHAT_WINDOW_ALT", 0, false, shawzinInputFilter, true)
		settings:__wf_atom_042a8818(
			"TOGGLE_CHAT_WINDOW_ALT",
			"GAMEPAD_L1",
			false,
			shawzinInputFilter,
			__wf_atom_622bc136
		)
		mMovie:AddInputBinding("TOGGLE_CHAT_WINDOW_ALT", "GAMEPAD_L1", 0, false, menuInputFilter, nil, nil)
		settings:__wf_atom_6b99bafa(false)
		__wf_atom_8e4fda44:__wf_atom_8ef89e30()
	end

	local __wf_atom_000a0b8a = settings:__wf_atom_000a0b8a(
		"EQUIP_RAILJACK_REPAIR_TOOL",
		false,
		__wf_atom_622bc136,
		powerMenuInputFilter
	)

	if __wf_atom_000a0b8a ~= "" then
		mMovie:__wf_atom_042a8818("EQUIP_RAILJACK_REPAIR_TOOL", 0, false, nil, true)
		mMovie:__wf_atom_042a8818("EQUIP_RAILJACK_REPAIR_TOOL", 0, false, powerMenuInputFilter, true)
		settings:AddInputBinding(
			"EQUIP_RAILJACK_REPAIR_TOOL_MENU",
			__wf_atom_000a0b8a,
			false,
			powerMenuInputFilter,
			__wf_atom_622bc136
		)
		settings:__wf_atom_042a8818(
			"EQUIP_RAILJACK_REPAIR_TOOL",
			__wf_atom_000a0b8a,
			false,
			powerMenuInputFilter,
			__wf_atom_622bc136
		)
		settings:__wf_atom_6b99bafa(false)
	end

	if Engine.IsPlayingWithController() then
		local __wf_atom_000a0b8a2 = settings:__wf_atom_000a0b8a(
			"POWER_MENU",
			false,
			__wf_atom_622bc136,
			tennoInputFilter
		)
		local __wf_atom_000a0b8a3 = settings:__wf_atom_000a0b8a(
			"ACTIVATE_ABILITY_MENU_4",
			false,
			__wf_atom_622bc136,
			powerMenuInputFilter
		)

		if __wf_atom_000a0b8a2 ~= "" and __wf_atom_000a0b8a3 == "" then
			settings:AddInputBinding(
				"ACTIVATE_ABILITY_MENU_4",
				module.Ternary(__wf_atom_000a0b8a2 ~= "GAMEPAD_R2", "GAMEPAD_R2", "GAMEPAD_L2"),
				false,
				powerMenuInputFilter,
				__wf_atom_622bc136
			)
			settings:__wf_atom_6b99bafa(false)
		end

		if settings:__wf_atom_000a0b8a("DOJO_SELECTION_EXIT", false, __wf_atom_622bc136, decoPlacementFilter) == "" then
			local v73 = {
				"DOJO_SELECTION_ADD",
				"DOJO_SELECTION_EDIT",
				"DOJO_SELECTION_PLACE",
				"DOJO_SELECTION_ROTATE",
				"DOJO_SELECTION_CHANGE_ROTATION",
				"DOJO_SELECTION_SCALE",
				"DOJO_SELECTION_SCALE_UP",
				"DOJO_SELECTION_SCALE_DOWN",
				"DOJO_SELECTION_SNAP",
				"DOJO_SELECTION_SURFACE_SNAP",
				"DOJO_SELECTION_PUSH_PULL",
				"DOJO_SELECTION_EXIT"
			}
			local __wf_atom_000a0b8a4 = settings:__wf_atom_000a0b8a(
				"MOVE_Y",
				false,
				__wf_atom_622bc136,
				archwingInputFilter
			)

			if __wf_atom_000a0b8a4 ~= "" then
				for i = 1, #v73 do
					local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(
						v73[i],
						false,
						decoPlacementFilter,
						true,
						false,
						true
					)

					if not (#__wf_atom_c2e9085e > 0 and __wf_atom_c2e9085e[1] == __wf_atom_000a0b8a4) then
						continue
					end

					settings:AddInputBinding(
						"MOVE_Y",
						__wf_atom_000a0b8a4,
						false,
						decoPlacementFilter,
						__wf_atom_622bc136
					)
					settings:AddInputBinding(v73[i], "GAMEPAD_X", false, decoPlacementFilter, __wf_atom_622bc136)
					settings:__wf_atom_6b99bafa(false)
					break
				end
			end

			local __wf_atom_000a0b8a5 = settings:__wf_atom_000a0b8a(
				"MOVE_Y",
				true,
				__wf_atom_622bc136,
				archwingInputFilter
			)

			if __wf_atom_000a0b8a5 ~= "" then
				for i = 1, #v73 do
					local __wf_atom_c2e9085e = __wf_atom_8e4fda44:__wf_atom_c2e9085e(
						v73[i],
						false,
						decoPlacementFilter,
						true,
						false,
						true
					)

					if not (#__wf_atom_c2e9085e > 0 and __wf_atom_c2e9085e[1] == __wf_atom_000a0b8a5) then
						continue
					end

					settings:AddInputBinding(
						"MOVE_Y",
						__wf_atom_000a0b8a5,
						true,
						decoPlacementFilter,
						__wf_atom_622bc136
					)
					settings:AddInputBinding(v73[i], "GAMEPAD_L2", false, decoPlacementFilter, __wf_atom_622bc136)
					settings:__wf_atom_6b99bafa(false)
					break
				end
			end
		end
	end

	local module11 = require("Lotus.Interface.BindingsUtil")
	module11.ResetCustomBindings()
	local __wf_atom_5bb4e2aa = gClient:__wf_atom_5bb4e2aa()
	local __wf_atom_a744f814 = GraphicsRes.__wf_atom_a744f814(gRegion:__wf_atom_22941262())
	local v73 = WeakResource("/Lotus/Levels/Proc/PlayerShip")

	if __wf_atom_5bb4e2aa == nil then
		__wf_atom_5bb4e2aa = v73
	end

	if __wf_atom_a744f814 == nil then
		__wf_atom_a744f814 = gRegion:__wf_atom_22941262() or v73
	end

	if __wf_atom_5bb4e2aa ~= __wf_atom_a744f814 then
		Engine.Disconnect(true)
	end

	if Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a() then
		v24:SetVisible(true)
	end

	if __wf_atom_9be88b01:__wf_atom_5e78cad5() then
		fn51()
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("LOGINS"), "", 1)
	end

	fn54()
	local v74

	if welcomeScreenTag == EMPTY_SYMBOL then
		v74 = false
	else
		v74 = not __wf_atom_9be88b01:__wf_atom_7f86fc42(welcomeScreenTag) or false
	end

	if
		welcomeScreenRequiresNightwave and not __wf_atom_9be88b01:__wf_atom_92662866():IsSeasonActive()
		or not __wf_atom_9be88b01:IsNewPlayer() and Engine.__wf_atom_84bb79c2()
	then
		v74 = false
	end

	if v74 and __wf_atom_9be88b01:__wf_atom_a04e4a53() < 2 then
		if welcomeScreenTag ~= EMPTY_SYMBOL then
			__wf_atom_9be88b01:__wf_atom_c9bb8504(welcomeScreenTag)
		end

		v74 = false
	end

	if __wf_atom_72884638("LotusGameRules.DemoMode") then
		__wf_atom_ec43d06e(mMovie, "Logo", 0, { 12 }, { 0 }, 0.15)
		__wf_atom_ec43d06e(mMovie, "LoginPanel", 0, { 12 }, { 0 }, 0.15, 0, function()
			if __wf_atom_7e8ad928(demoOverlay) then
				fn53()
			else
				mMovie:PushChildMovie(demoOverlay)
			end
		end)
	elseif v74 then
		v40 = mMovie:PushChildMovie(parkourTutorialMovie)

		if welcomeScreenTag ~= EMPTY_SYMBOL then
			__wf_atom_9be88b01:__wf_atom_c9bb8504(welcomeScreenTag)
		end

		v39 = true
		mInputBlocked = true
	else
		fn53()
	end

	_T.LastCheckedResourceDrones = __wf_atom_c4e218a2()
	__wf_atom_9be88b01:__wf_atom_90a6119f("OnInitActiveDrones")
end

function ConfirmUnlockAccountCode(p, p2)
	if __wf_atom_7e8ad928(p) or tonumber(p) ~= 4 then
		if v57 ~= nil then
			fn21(v57)
			v57 = nil
		end
	elseif not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		__wf_atom_a0f6588f:__wf_atom_aa83e764(p2, "OnUnlockAccount")
	end
end

function BannedDialogCallback(p)
	if tonumber(p) == 4 and v57 ~= nil then
		fn21(v57)
		v57 = nil
	end
end

function AnalyzeDialogCallback(p)
	v13:Close()
	v13 = nil

	if tonumber(p) == 4 and v14 ~= "error" then
		local networkAnalysisURL = module3.GetNetworkAnalysisURL(v14)

		if networkAnalysisURL ~= "" then
			fn21(networkAnalysisURL)
		end
	end
end

fn6 = function()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local v73 = __wf_atom_18a5d83b and __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if v73 then
		local __wf_atom_bf0172cf = v73:__wf_atom_bf0172cf()

		if __wf_atom_bf0172cf.id == "" then
			if
				gMatchingService:__wf_atom_06fa71e3()
				or not (__wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) and __wf_atom_18a5d83b:__wf_atom_b2644498())
			then
				fn36()
			else
				fn37()
			end
		elseif
			gMatchingService:__wf_atom_06fa71e3()
			or not (__wf_atom_7e8ad928(gMatchingService:__wf_atom_15811761()) and __wf_atom_18a5d83b:__wf_atom_b2644498())
		then
			fn34()
			fn36()
		elseif module2.FindSessionById(__wf_atom_bf0172cf.id, "OnFindOriginalSessionComplete", true) then
			_T.BackgroundMovie:__wf_atom_f62a8704("ShowBlockingMessage", {
				"2",
				"/Lotus/Language/Menu/ClientSessionReconnectPleaseWait"
			})
		end
	end
end

function AnalyzeCallback(p, p2)
	local v73 = StringSplit(",", p)
	local v74

	if #v73 >= 1 then
		p = v73[1]
		v74 = v73[2]
	end

	if not __wf_atom_7e8ad928(__wf_atom_21342f4a) then
		__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NETWORK_ANALYSIS"), p)

		if v74 then
			__wf_atom_21342f4a:__wf_atom_3c9aa248(Symbol("NETWORK_FORWARDING"), v74)
		end
	end

	print("Network analysis done: " .. p)
	v15 = true

	if not Engine.__wf_atom_fc67ba71() or _T.MainMenuStateReady then
		fn6()
	end

	if p == "nominal" or p == "nominal_rewrite" then
		return
	end

	v14 = p
	locString = p2
end

function LocalUserChanged()
	fn25()
end

function KickLogin(p)
	print("KickLogin(" .. tostring(p) .. ")")

	if tonumber(p) == 4 then
		fn27(email, v68, true)
	end
end

local function fn56(p, value)
	print("MainMenu::LoginDone result=" .. tostring(p))

	if email and email ~= "" then
		local __wf_atom_98893f8d = SF.__wf_atom_98893f8d()

		if not __wf_atom_7e8ad928(__wf_atom_98893f8d) then
			__wf_atom_98893f8d.email = email
			__wf_atom_98893f8d:Save()
		end
	end

	mInputBlocked = false
	flag4 = false
	gMatchingService:__wf_atom_9dea018d("LocalUserChanged")

	if Engine.__wf_atom_e43a530e() then
		mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, true)
	end

	if Engine.__wf_atom_fc67ba71() then
		__wf_atom_ec43d06e(mMovie, "ScreenBlocker", 1, { 12 }, { 0 }, 1, 0.1, fn14)
	end

	v41 = true

	if p then
		v64 = p and module9.ShouldDoFirstLoginSequence(false)

		if v64 then
			v65 = true
			StreamPrisonerLevel()
		else
			flag6 = true
			module10.StreamNightFold("NightFoldStreamCallback")
		end

		fn()
	else
		fn26(false)
		print("Login failed." .. value)
		fn18(Engine.IsOSKAvailable())
		local v73 = string.find(value, "noPWAccount") ~= nil
		local v74 = string.find(value, "noPSNAccount") ~= nil
		local v75 = string.find(value, "noXBLiveAccount") ~= nil or string.find(value, "invalidAuthToken") ~= nil
		local v76 = string.find(value, "noNSAccount") ~= nil

		if
			(string.find(value, "noValidGamepad") ~= nil or string.find(value, "No Valid Gamepads") ~= nil)
			and not Engine.__wf_atom_84bb79c2()
		then
			if not __wf_atom_7e8ad928(gRegion) then
				v42 = gRegion:__wf_atom_9f7eb1c3()
			end

			print("Returning because no valid gamepad detected")

			if v23 ~= nil then
				v23:SetVisible(true)
			end
		elseif v73 then
			print("Don't have a PW account tied yet, need to show the bind screen")
			fn7(value)
		else
			if v75 or v76 then
				fn44()
				return
			end

			if v74 then
				return
			end

			local v77, v78

			if Engine.__wf_atom_578fc9dd() then
				v77, v78 = string.match(value, "Suspended: (%d+-%d+-%d+)%s+;%s*([%a%d%s]*)")
			else
				v77, v78 = string.match(value, "Suspended: (%w+ %d+, %d+)%s+-%s*([%a%d]*)")
			end

			local v79 = v78 ~= nil and #v78 == 0 and "None" or v78
			local v80 = string.find(value, "unknown user") ~= nil
			local v81 = string.find(value, "wrongPSNAccount") ~= nil
			local v82 = string.find(value, "wrongXBLiveAccount") ~= nil
			local v83 = string.find(value, "inactive account") ~= nil
			local isConnectionErrorMsg = module.IsConnectionErrorMsg(value)
			local v84 = string.find(value, "old build") ~= nil
			local v85 = string.find(value, "SSL chain") ~= nil
				or string.find(value, "Peer certificate cannot be authenticated") ~= nil
			local v86 = string.find(value, "Clock desync") ~= nil
			local v87 = string.find(value, "PSN login failed") ~= nil
			local v88 = string.find(value, "Xbox Live login failed") ~= nil
			local v89 = string.find(value, "PSN NP unavailable") ~= nil
			local v90 = string.find(value, "Wrong Build") ~= nil
			local v91 = string.find(value, "Timeout") ~= nil
			local v92 = string.find(value, "Japan failsafe") ~= nil
			local v93 = string.find(value, "nonSteamAccount") ~= nil
			local v94 = string.find(value, "notAdult") ~= nil
			local v95 = string.find(value, "PlayTimeExceeded") ~= nil
			local v96 = string.find(value, "wegame account created") ~= nil
			local v97 = string.find(value, "CCB IP ban") ~= nil
				or string.find(value, "temporarily restricting account from logging in") ~= nil
			local v98 = string.find(value, "new hardware detected") ~= nil
			local v99 = string.find(value, "new country detected") ~= nil
			local v100 = string.find(value, "tar-pit", 1, true) ~= nil
			local v101 = string.find(value, "nonce still set") ~= nil
			local v102 = string.find(value, "Login failed; Could not connect to PSN: E") ~= nil
			local v103 = string.find(value, "Chargeback") ~= nil
			local v104 = v103 and string.find(value, "negativePlat") ~= nil
			local v105 = v103 and string.find(value, "negativePrimeTokens") ~= nil
			local v106 = string.find(value, "not in preludes") ~= nil

			if v94 then
				v41 = false
			end

			local locString2

			if isConnectionErrorMsg then
				print("Connection failed!")
				locString2 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/LoginFailedNoConnection", true)
				local v108

				if Engine.__wf_atom_e43a530e() then
					v108 = string.gsub(value, "sceHttpSendRequest failed %(0x%x+%)", "")
				else
					v108 = Engine.__wf_atom_84bb79c2() and "" or value
				end

				local v109 = string.gsub(v108, "HttpSendRequest failed", "")

				if not __wf_atom_d9227398() then
					locString2 ..= " " .. v109
				end
			elseif v90 then
				locString2 = "/Lotus/Language/Launcher/LoginFailedWrongBuild"
			elseif v103 then
				local v108

				if v104 then
					v108 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/LoginFailedNegativePlat", true)
				elseif v105 then
					v108 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/LoginFailedNegativePrimeTokens", true)
				else
					v108 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Launcher/LoginFailedNegativePlat", true)
				end

				locString2 = string.format(v108, "http://support.soulframe.com")
			elseif v77 == nil then
				if v91 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedTimedOut"
				elseif v81 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedAccountAlreadyUsed"
				elseif v82 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedAccountAlreadyUsedXB1"
				elseif v85 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedSSL"
				elseif v86 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedDesync"
				elseif v83 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedInactiveAccount"
				elseif v80 then
					locString2 = "/Lotus/Language/Launcher/LoginFailedUnknownUser"
				elseif v84 then
					locString2 = "/Lotus/Language/Menu/MainMenu_NewBuildAvailable"
				elseif v87 then
					locString2 = "/Lotus/Language/Menu/LoginFailedPSN"
				elseif v88 then
					locString2 = "/Lotus/Language/Menu/LoginFailedXBoxLive"
				elseif v89 then
					locString2 = "/Lotus/Language/Menu/LoginFailedPSNUnavailable"
				elseif v92 then
					fn26(false)
					locString2 = "/Lotus/Language/News/NewsItem_Maintenance"
				elseif v94 then
					locString2 = "/Lotus/Language/Menu/SignupFailedAge"
				elseif v106 then
					locString2 = "/Lotus/Language/Launcher/NotPreludeEnabled"
				elseif v95 then
					locString2 = "/Lotus/Language/Menu/LoginFailedPlayTime"

					if string.find(value, "remainRestTime") ~= nil then
						local v108 = string.find(value, "{")

						if v108 ~= nil then
							local v109 = string.sub(value, v108)
							local decoded = cjson.decode(v109)

							if decoded.result and decoded.result.remainRestTime then
								local v110 = decoded.result.remainRestTime / 1000
								print(module3.SecondsToFormattedTime(mMovie, v110, false))
								local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(locString2, true)
								module.ShowMessage(__wf_atom_8e9ac384, "ConfirmLoginFailed")
								return
							end
						end
					end
				elseif v93 then
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.locString = "/Menu/SteamRunningNoSteamAccount"
					dialogSettings:SetCallback("ConfirmLoginFailedDownload")
					dialogSettings.dialogType = 1
					dialogSettings.firstString = "/Lotus/Language/Webpage/WP_Download"
					dialogSettings.secondString = "/Menu/Confirm_Item_Cancel"
					module.ShowCustomMessage(dialogSettings)
					return
				elseif v96 then
					local v108, v109 = string.find(value, "RailID=")

					if v108 == nil then
						local accountsupportpage = "<a color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Hyperlink) .. "\" hovercolor=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\" href=\"#OnHyperlinkPressed:" .. mMovie:__wf_atom_8e9ac384(
							"/SF/Language/Launcher/AccountSupportPage",
							false
						) .. "\">" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/AccountSupport", false) .. "</a>"
						locString2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/LoginFailed", true, {
							ACCOUNTSUPPORTPAGE = accountsupportpage
						})
					else
						_T.gWeGameAccount = string.sub(value, v109 + 1)
						mMovie:__wf_atom_b4ffb30f(false)
						fn15("")
						_T.BackgroundMovie:Execute("InitiateAccountRename", "true")
						return
					end
				elseif v97 then
					locString2 = "/Lotus/Language/Changyou/CcbIpBan"
				elseif v100 then
					_T.LoginTarPit = Time()
					locString2 = "/Lotus/Language/Launcher/LoginFailedTarpit"
				elseif v102 then
					locString2 = "/Lotus/Language/Menu/LoginFailedPSNDown"
				else
					local accountsupportpage = "<a color=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Hyperlink) .. "\" hovercolor=\"" .. module.ConvertColorNumberToHex(_G.UIColor_Yellow) .. "\" href=\"#onHyperLinkPressed:" .. mMovie:__wf_atom_8e9ac384(
						"/SF/Language/Launcher/AccountSupportPage",
						false
					) .. "\">" .. mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/AccountSupport", false) .. "</a>"
					locString2 = mMovie:__wf_atom_8e9ac384("/SF/Language/Launcher/LoginFailed", true, {
						ACCOUNTSUPPORTPAGE = accountsupportpage
					})
				end
			else
				local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(
					"/Lotus/Language/Launcher/LoginFailedSuspended",
					true
				)
				local v108 = "/Lotus/Language/Launcher/SuspendReason_" .. v79
				local __wf_atom_8e9ac384_2 = mMovie:__wf_atom_8e9ac384(v108, true)

				if __wf_atom_8e9ac384_2 == v108 then
					__wf_atom_8e9ac384_2 = v79
				end

				locString2 = string.format(__wf_atom_8e9ac384, v77, __wf_atom_8e9ac384_2)
			end

			if v98 or v99 then
				fn15("")
				module4.ShowInputDialog(
					mMovie,
					"/Lotus/Language/Launcher/LoginFailedNewHardwareDetectedTitle",
					"",
					25,
					"ConfirmLoginEnterCode",
					"OSKConfirmLoginEnterCode",
					{
						isMultiline = false,
						cancelDisabled = true,
						desc = "/Lotus/Language/Launcher/LoginFailedNewHardwareDetected"
					}
				)
			else
				if v101 then
					module.ShowMessage("/Lotus/Language/Launcher/LoginFailedConflict", "KickLogin", 1)
				elseif v79 == "CompromisedAccount" then
					fn15("")
					local _, v108 = module4.ShowInputDialog(
						mMovie,
						"/Lotus/Language/Launcher/SuspendReason_CompromisedAccount",
						"",
						25,
						"ConfirmUnlockAccountCode",
						"ConfirmUnlockAccountCode",
						{ isMultiline = false, cancelDisabled = false, forChat = false }
					)
					v108:Execute("SetNoTag", "/NetTest/Help")
					v57 = module.Ternary(
						Engine.__wf_atom_578fc9dd(),
						"https://kf.qq.com/bills/200901selfsam4979ae6.html",
						"https://digitalextremes.zendesk.com/hc/articles/360010427612"
					)
				elseif v79 == "ContactSupport" then
					fn15("")
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.locString = "/Lotus/Language/Launcher/SuspendReason_ContactSupport"
					dialogSettings:SetCallback("BannedDialogCallback")
					dialogSettings.dialogType = 1
					dialogSettings.firstString = "/Lotus/Language/Menu/ContactSupport"
					dialogSettings.secondString = "/Lotus/Language/Menu/ItemSelection_OK"
					v57 = module.Ternary(
						Engine.__wf_atom_578fc9dd(),
						"https://kf.qq.com/bills/200901selfsam4979ae6.html",
						"http://support.soulframe.com"
					)
					module.ShowCustomMessage(dialogSettings)
				elseif v103 or v77 ~= nil and v58[v79] ~= nil then
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.locString = locString2
					dialogSettings:SetCallback("BannedDialogCallback")
					dialogSettings.dialogType = 1
					dialogSettings.firstString = "/NetTest/Help"
					dialogSettings.secondString = "/Lotus/Language/Menu/ItemSelection_OK"

					if v103 then
						v57 = module.Ternary(
							Engine.__wf_atom_578fc9dd(),
							"https://wf.qq.com/newsDetail.shtml?&tid=13357758",
							"https://digitalextremes.zendesk.com/hc/articles/360010426932"
						)
					else
						v57 = module.Ternary(Engine.__wf_atom_578fc9dd(), v59[v79], v58[v79])
					end

					module.ShowCustomMessage(dialogSettings)
				else
					local dialogSettings = Engine.DialogSettings()
					dialogSettings.dialogType = 0
					dialogSettings.locString = locString2
					dialogSettings.titleString = "/SF/Language/Launcher/LoginFailedHeading"
					dialogSettings:SetCallback("ConfirmLoginFailed")
					module.ShowCustomMessage(dialogSettings)
				end

				fn15("")
			end

			if not __wf_atom_7e8ad928(__wf_atom_a0f6588f) and Engine.__wf_atom_b290ec01() then
				__wf_atom_a0f6588f:LogOut()
			end
		end
	end
end

function LoginDone(p, p2)
	fn56(p, p2)
end

function OnInitChallenges(_) end

function ConfirmLoginFailed()
	print("Login failed, confirmed")

	if Engine.__wf_atom_e43a530e() or Engine.__wf_atom_54205c5a() then
		if v23 ~= nil then
			v23:SetVisible(true)
		end
	elseif Engine.__wf_atom_84bb79c2() then
		fn18()

		if v23 ~= nil then
			v23:SetVisible(true)
		end

		flag4 = true
		mAllowedAdvanceFromLogin = false
	elseif Engine.__wf_atom_b290ec01() then
		if v23 ~= nil then
			v23:SetVisible(true)
		end
	elseif v47 then
		v6:SetVisible(true)
	else
		v21:TryPressed(true)
	end

	if v24 ~= nil then
		v24:SetVisible(false)
	end
end

function OnAuthorizeNewHardware(p, p2)
	if p then
		v21:TryPressed(true)
		fn27(email, v68, true)
	else
		module.ShowMessage("/Lotus/Language/Launcher/NewHardwareCodeFailed", "ConfirmLoginFailed")
		print(p2)
	end
end

local function fn57(p)
	if not __wf_atom_7e8ad928(__wf_atom_a0f6588f) then
		__wf_atom_a0f6588f:__wf_atom_60ff7ca4(p, email, "OnAuthorizeNewHardware")
	end
end

function ConfirmLoginEnterCode(p, _)
	fn57(p)
end

function OSKConfirmLoginEnterCode(_, p)
	fn57(p)
end

function UnlockedConfirmed()
	v21:TryPressed(true)
	fn27(email, v68, true)
end

function OnUnlockAccount(p, p2)
	if p then
		module.ShowMessage("/Lotus/Language/Launcher/AccountUnlockedMessage", "UnlockedConfirmed")
		return
	end

	module.ShowMessage("/Lotus/Language/Launcher/NewHardwareCodeFailed", "ConfirmLoginFailed")
	print(p2)
end

function ConfirmLoginFailedDownload(p)
	if tonumber(p) == 4 then
		module.__wf_atom_37151f8f("https://soulframe.com/Download-Non-Steam-9lk85n234kjd")
	end
end

local function fn58()
	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		if Engine.__wf_atom_fc67ba71() and __wf_atom_a0f6588f:__wf_atom_48285177() then
			print("Fade in complete, not signed in, logging out")
			_T.BackgroundMovie:Execute("DoLogoff", "")
		elseif _G.localUserChanged then
			_G.localUserChanged = false
			_G.forcedUserChange = true
			__wf_atom_a0f6588f:__wf_atom_01bce336()
		else
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				return
			end

			local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if __wf_atom_7e8ad928(__wf_atom_9be88b01) then
				fn35(0)
			elseif not __wf_atom_7e8ad928((gMatchingService:__wf_atom_15811761())) then
				fn35(1)
			elseif __wf_atom_72884638("LotusGameRules.DemoMode") then
				if __wf_atom_7e8ad928(demoOverlay) then
					fn53()
					return
				end

				mMovie:PushChildMovie(demoOverlay)
				__wf_atom_9be88b01:__wf_atom_66a27504()
				__wf_atom_9be88b01:__wf_atom_41be2b1e()
			else
				if Engine.__wf_atom_e43a530e() and (__wf_atom_7e8ad928(_G.gHasLoggedIn) or not _G.gHasLoggedIn) then
					fn35(0)
				else
					fn35(1)
				end

				if not __wf_atom_9be88b01:__wf_atom_24908c96() then
					flag3 = true
					_T.BackgroundMovie:Execute("ShowBlockingMessage", 1)
				end

				if #__wf_atom_9be88b01:__wf_atom_8ba10f50() > 0 then
					return
				end
			end
		end
	else
		fn35(0)
	end
end

function SignOutConfirmed()
	fn24()
end

local function fn59()
	mInputBlocked = false
	flag4 = false
	fn26(false)
	local v73 = __wf_atom_6bafbd34()
	print("Browser was closed on page " .. v73)

	if string.find(v73, "err=") == nil then
		if string.find(v73, "https://cpass.wanmei.com/console/bindsuss") == nil then
			module.ShowMessage(
				mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_AccountBindNotCompleted", false),
				"ConfirmLoginFailed"
			)
		else
			__wf_atom_a0f6588f:__wf_atom_8dca513d(true)
			print("Skipped account bind")
		end
	else
		module.ShowMessage(
			mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/MainMenu_ErrorPWServers", false),
			"ConfirmLoginFailed"
		)
	end

	v23:SetVisible(true)
end

local function fn60()
	if v2 == 1 and not v31 then
		if Engine.__wf_atom_e43a530e() then
			if __wf_atom_a0f6588f:__wf_atom_f89aa44a() and __wf_atom_a0f6588f:__wf_atom_48285177() then
				print("Main menu update - not signed in, logging out")
				v31 = module.ShowMessage("/Multiplayer/NPSignOutWarning_Windows", "SignOutConfirmed")
				mAllowedAdvanceFromLogin = false

				if v23 ~= nil then
					v23:SetVisible(true)
				end
			end
		elseif Engine.__wf_atom_84bb79c2() then
			if __wf_atom_a0f6588f:__wf_atom_f89aa44a() and __wf_atom_a0f6588f:__wf_atom_48285177() then
				print("Main menu update - not signed in, logging out")
				v31 = module.ShowMessage("/Multiplayer/NPSignOutWarning_Windows", "SignOutConfirmed")
				mAllowedAdvanceFromLogin = false

				if v23 ~= nil then
					v23:SetVisible(true)
				end
			else
				local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

				if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_18a5d83b:__wf_atom_9be88b01():__wf_atom_df64c481()) then
					fn49()
				end
			end
		elseif
			Engine.__wf_atom_b290ec01()
			and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
			and __wf_atom_a0f6588f:__wf_atom_48285177()
		then
			v31 = module.ShowMessage("/Multiplayer/NPSignOutWarning_Windows", "SignOutConfirmed")
			mAllowedAdvanceFromLogin = false

			if v23 ~= nil then
				v23:SetVisible(true)
			end
		end

		if v24 ~= nil then
			v24:SetVisible(false)
		end
	end
end

local function fn61()
	if __wf_atom_7e8ad928(logoVideoTex) or v53 ~= "Logo" then
		v:AddTimer(5, function()
			local v73 = (v53 == "LogoAlt" or __wf_atom_7e8ad928(v52)) and "Logo" or "LogoAlt"
			__wf_atom_ec43d06e(mMovie, "Logo." .. v53, 2, { 12 }, { 0 }, 0.25)
			__wf_atom_ec43d06e(mMovie, "Logo." .. v73, 2, { 12 }, { 100 }, 0.55, 0.1)
			module.PlaySound(_G.UISound_LogoTransition)
			v53 = v73
			fn61()
		end)
	else
		v:AddTimer(3, function()
			mMovie:__wf_atom_e57658c2("Logo.LogoVideo", 12, 1)
			mMovie:__wf_atom_3f8dd1de("Logo.LogoVideo")
			v:AddTimer(0.01, function()
				mMovie:__wf_atom_e3debc9a("Logo.LogoVideo")
				v:AddTimer(0.1, function()
					mMovie:__wf_atom_e57658c2("Logo.Logo", 12, 0)
					mMovie:__wf_atom_e57658c2("Logo.LogoVideo", 12, 100)
					v53 = "LogoVideo"
					v:AddTimer(5, fn61)
				end)
			end)
		end)
	end
end

function NightFoldStreamCallback()
	if flag6 then
		flag6 = false
		fn26(false)
		fn()
	end
end

function PrisonerStreamCallback(_, prisonerStreamLayer)
	v65 = false
	_T.PrisonerStreamLayer = prisonerStreamLayer
	_T.BackgroundMovie:Execute("OnFirstLogin", "")
	fn26(false)
	fn()
	module10.StreamNightFold("NightFoldStreamCallback")
end

function StreamPrisonerLevel()
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("ArenaOrigin"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	local __wf_atom_ade7f08f = gRegion:__wf_atom_ade7f08f()
	__wf_atom_ade7f08f.level = level
	__wf_atom_ade7f08f.streamingLayer = 256
	__wf_atom_ade7f08f.streamingMode = 1
	__wf_atom_ade7f08f:__wf_atom_60471db9(__wf_atom_0a6a5887:GetPosition(), __wf_atom_80368bb1)
	__wf_atom_ade7f08f:__wf_atom_c4be912d("PrisonerStreamCallback")
	__wf_atom_ade7f08f.isAutonomous = false
	__wf_atom_ade7f08f.streamingPriority = 2
	Engine.StreamRegion(__wf_atom_ade7f08f)
end

local function fn62()
	if __wf_atom_7e8ad928(_T.BackgroundMovie) or __wf_atom_7e8ad928((gRegion:__wf_atom_8ad59546())) then
		return false
	end

	if not module9.ShouldDoFirstLoginSequence(true) or gRegion:__wf_atom_c519a397() then
		return true
	end

	mMovie:__wf_atom_2e64957a(false)
	local buttonBarMovie = _T.ButtonBarMovie

	if not __wf_atom_7e8ad928(buttonBarMovie) then
		buttonBarMovie:__wf_atom_2e64957a(false)
	end

	local v73 = mMovie:__wf_atom_97cd8326() / 2
	mMovie:__wf_atom_e57658c2("FirstLoginBacker", 12, 100)
	mMovie:__wf_atom_e57658c2("LoginPanel", 0, v73)
	mMovie:__wf_atom_e57658c2("Spinner", 0, v73)
	mMovie:__wf_atom_e57658c2("Logo", 0, v73)
	return true
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not mInitialized then
		return
	end

	if not __wf_atom_7e8ad928(gRegion) and gRegion:__wf_atom_c519a397() then
		mMovie:Close()
		return
	end

	fn55()

	if flag then
		flag = nil
		fn35(v3)
	end

	if v29 ~= nil and v29:__wf_atom_86399a47() then
		local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
		local __wf_atom_3cb140dc = gClient:__wf_atom_3cb140dc()

		if not (__wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(__wf_atom_3cb140dc)) then
			local settings = __wf_atom_18a5d83b:Settings()
			local __wf_atom_72feee20 = settings:__wf_atom_72feee20()
			local __wf_atom_3959fbd8 = settings:__wf_atom_3959fbd8()
			local __wf_atom_e9a058a9 = settings:__wf_atom_e9a058a9()
			__wf_atom_3cb140dc:__wf_atom_6355f113(Resource(__wf_atom_72feee20))
			__wf_atom_3cb140dc:__wf_atom_ccd7dcbc(Resource(__wf_atom_3959fbd8))
			__wf_atom_3cb140dc:__wf_atom_c9368b31(Resource(__wf_atom_e9a058a9))
			v29 = nil
			local v73 = v3
			v3 = 1
			fn35(v73)
		end
	end

	if Engine.__wf_atom_fc67ba71() and v44 and not __wf_atom_45afeb34() then
		fn59()
		v44 = false
	end

	if v39 and __wf_atom_7e8ad928(v40) and not _T.StoryLib_PlayingCin then
		mInputBlocked = false
		fn53()
		v39 = false
	end

	if not (v38 or __wf_atom_7e8ad928(gRegion)) then
		local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

		if __wf_atom_3c8e1a7a ~= nil and #__wf_atom_3c8e1a7a > 0 then
			mMovie:__wf_atom_8fcdea81(__wf_atom_3c8e1a7a[1])
			v38 = true
		end
	end

	if v28 == nil or not v28:IsLoading() then
		if not __wf_atom_7e8ad928(v) then
			v:Update(__wf_atom_fa1258d0())
		end

		mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

		if not __wf_atom_7e8ad928(v25) then
			v25:Update()
		end

		if Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a() then
			if not v43 then
				gMatchingService:__wf_atom_9dea018d("LocalUserChanged")
				v43 = true
			end

			if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
				fn14()
			else
				v6:SetVisible(false)
			end
		elseif flag4 and __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local __wf_atom_9be88b01 = __wf_atom_18a5d83b:__wf_atom_9be88b01()
				flag4 = false

				if not (__wf_atom_7e8ad928(__wf_atom_9be88b01) or __wf_atom_9be88b01:__wf_atom_df64c481() or __wf_atom_a0f6588f:__wf_atom_48285177()) then
					print("Main Menu update - loading Dojo")
					fn49()
					return
				end
			end
		elseif not flag4 and __wf_atom_a0f6588f:__wf_atom_f89aa44a() and Engine.__wf_atom_fc67ba71() then
			fn14()
		end

		if flag2 then
			local __wf_atom_15811761 = gMatchingService:__wf_atom_15811761()

			if not __wf_atom_7e8ad928(__wf_atom_15811761) and __wf_atom_15811761:__wf_atom_e6770097() then
				flag2 = false
				local levelArgs = Engine.OpenLevelArgs()
				levelArgs:SetLevel(v5)
				levelArgs.hostingMultiplayer = true
				levelArgs.migrateServer = false
				Engine.OpenLevel(levelArgs)
				mMovie:Close()
			end
		end

		if
			not v4
			and v63 ~= nil
			and not __wf_atom_7e8ad928(gClient)
			and (not gClient:__wf_atom_449cc668() or _T.LoadingScreenTransOut)
		then
			if not mFirstLoginMenuSet then
				fn62()
				mFirstLoginMenuSet = true
			end

			local v73 = WeakResource("/Lotus/Interface/Bumper.swf")

			if not __wf_atom_8e4fda44:__wf_atom_6b69b901(v73) or __wf_atom_7e8ad928(v73) then
				v4 = true
				fn58()

				if v2 == 0 and not __wf_atom_7e8ad928(_T.ShowBackground) then
					_T.ShowBackground()
					v52 = module5.GetBackgroundLogo()

					if not __wf_atom_7e8ad928(v52) then
						mMovie:__wf_atom_933bbce0("Logo.LogoAlt", v52, logoTransitionMaterial)
						local __wf_atom_80cf57aa = v52:__wf_atom_80cf57aa()
						local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Logo.LogoAlt", 14)
						local v74 = __wf_atom_80cf57aa.y * __wf_atom_5e6e15c8 / __wf_atom_80cf57aa.x
						mMovie:__wf_atom_e57658c2("Logo.LogoAlt", 15, v74)
						local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Logo.LogoAlt", 1)

						if not v47 then
							mMovie:__wf_atom_e57658c2(
								"Logo.LogoAlt",
								1,
								__wf_atom_5e6e15c8_2 - 82 + (__wf_atom_5e6e15c8 - v74)
							)
						end
					end

					mMovie:OverrideMaterial("Logo.Logo", logoTransitionMaterial)
					fn61()
				end

				mMovie:__wf_atom_e57658c2("_root", 12, 100)
			end
		end

		if not __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
			local entity = module.GetEntityFromTag(
				"SpaceZoneAttrib",
				module.Ternary(module3.IsInHub(), __wf_atom_392793db, nil)
			)

			if not __wf_atom_7e8ad928(entity) then
				local __wf_atom_dc309f8a = entity:__wf_atom_dc309f8a()
				__wf_atom_dc309f8a.heading = -90
				__wf_atom_dc309f8a.bank -= __wf_atom_084b3e93() * 0.3
				entity:__wf_atom_9b788a35(__wf_atom_dc309f8a)
			end

			if __wf_atom_8e4fda44:__wf_atom_ef7108f9() then
				mMovie:__wf_atom_2dedec1a("LoginPanel.CapsLock", 13, true)
			else
				mMovie:__wf_atom_2dedec1a("LoginPanel.CapsLock", 13, false)
			end
		end

		if
			_T.RadialSolarMap_OnAggregateResults ~= nil
			and gMatchingService:__wf_atom_93688ee1()
			and v2 == 1
			and not __wf_atom_7e8ad928(gGameRules)
			and _T.gActiveMatchMakingMode == _T.MATCHMAKING_QUICKMATCH_GAMEMODE
			and not (_T.tutorialActive or v62)
		then
			fn23()
		end

		if flag3 then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
			local v73

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				v73 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

				if not __wf_atom_7e8ad928(v73) and v73:__wf_atom_24908c96() then
					_T.BackgroundMovie:Execute("ShowBlockingMessage", 0)
					flag3 = false
				end
			end

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) or __wf_atom_7e8ad928(v73) then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", 0)
				flag3 = false
				fn35(0)
			end
		end

		if
			v10 == nil
			and v11 == nil
			and v12 == nil
			and locString ~= nil
			and __wf_atom_7e8ad928(_T.gNewBuildPopup)
			and __wf_atom_7e8ad928(v9)
			and not __wf_atom_72884638("Server.FastLoad")
			and mShownEmailPopup
		then
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.locString = locString
			dialogSettings:SetCallback("AnalyzeDialogCallback")

			if v14 == "error" then
				dialogSettings.firstString = "/Menu/Confirm_Item_Ok"
				dialogSettings.dialogType = 0
			else
				dialogSettings.dialogType = 1
				dialogSettings.firstString = "/NetTest/Help"
				dialogSettings.secondString = "/Menu/Continue"
			end

			v13 = module.ShowCustomMessage(dialogSettings)
			locString = nil
		end

		if
			v2 == 1
			and locString == nil
			and __wf_atom_7e8ad928(_T.gNewBuildPopup)
			and __wf_atom_7e8ad928(v9)
			and mShownEmailPopup == false
		then
			if __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_a88a4a13() then
				module.ShowMessage("/Lotus/Language/Settings/ConsoleEmailConfirmedSyandana")
				__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_2403ebb5(false)
			end

			mShownEmailPopup = true
		end

		if
			v2 == 1
			and locString == nil
			and __wf_atom_7e8ad928(_T.gNewBuildPopup)
			and __wf_atom_7e8ad928(v9)
			and mShownEmailPopup
			and mShowEpicNotifications == false
		then
			local __wf_atom_e73f9072 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_e73f9072()

			if #__wf_atom_e73f9072 > 0 then
				for i = 1, #__wf_atom_e73f9072 do
					module.ShowMessage("/Lotus/Language/Settings/" .. __wf_atom_e73f9072[i])
				end

				__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_4b939c59()
			end

			mShowEpicNotifications = true
		end

		if
			v2 == 1
			and v10 == nil
			and locString == nil
			and __wf_atom_7e8ad928(_T.gNewBuildPopup)
			and __wf_atom_7e8ad928(v9)
			and __wf_atom_a0f6588f:SteamTokenRedeemed()
			and mShowEpicNotifications
		then
			__wf_atom_a0f6588f:__wf_atom_621f44e4()
			local dialogSettings = Engine.DialogSettings()
			dialogSettings.dialogType = 0
			dialogSettings.locString = "/Lotus/Language/Menu/Popup_SteamTokenRedeemed"
			dialogSettings:SetCallback("SteamTokenRedeemed")
			v11 = module.ShowCustomMessage(dialogSettings)
		end

		if fn22() and not __wf_atom_7e8ad928(_T.ShowNotification) then
			module3.UpdateMailbox(v)
		end

		if
			v55
			and v2 == 1
			and not (_T.missionStatsPending or __wf_atom_7e8ad928(_T.IsInScreenStack) or _T.IsInScreenStack("MissionStats"))
		then
			v55 = false
			fn6()
		end

		if fn22() and not (v50 or __wf_atom_7e8ad928(gRegion)) then
			local __wf_atom_e23b2855 = gRegion:__wf_atom_e23b2855()

			if
				__wf_atom_a0f6588f:__wf_atom_f89aa44a()
				and #__wf_atom_e23b2855 > 0
				and not __wf_atom_7e8ad928(__wf_atom_e23b2855[1])
			then
				if __wf_atom_6a6ca13e() == "" then
					if flag5 then
						v:AddTimer(1.5, function()
							module.ShowYesOrNoMessage(
								"/Lotus/Language/Menu/ClientSessionReconnectPrompt",
								"ConfirmSessionReconnect"
							)
						end)
						flag5 = false
					end
				elseif _T.TopMenuOpen then
					local movie = __wf_atom_8e4fda44:FindMovie(topMenuMovie)

					if not __wf_atom_7e8ad928(movie) then
						movie:Execute("TriggerConsole", "SolarMapOrigin")
					end
				else
					_T.triggeredConsoleTag = "SolarMapOrigin"
					module.GetEntityFromTag("ConsoleTeleportAndActivate"):__wf_atom_f0368285()
				end

				v50 = true
			end
		end

		fn60()

		if
			Engine.__wf_atom_84bb79c2()
			and not __wf_atom_7e8ad928(v31)
			and __wf_atom_a0f6588f:__wf_atom_f89aa44a()
			and not __wf_atom_a0f6588f:__wf_atom_48285177()
		then
			print("Logged back in")
			v31:Close()
			v31 = nil
		end
	elseif v28:LoadingComplete() then
		v28:FinishLoad()
		local __wf_atom_2226b35c = __wf_atom_392793db:__wf_atom_2226b35c(Symbol("BackgroundMusic"))

		if not (__wf_atom_7e8ad928(__wf_atom_2226b35c) or __wf_atom_7e8ad928(__wf_atom_2226b35c[1])) then
			__wf_atom_2226b35c[1]:Disable()
		end

		mMovie:__wf_atom_0cf0fdbe(0)

		if not _T.introMusicPlayed then
			_T.introMusicInstance = module.PlaySound(introMusic)
		end

		_T.introMusicPlayed = true
	end
end

function AcceptSteamPack(p)
	v10:Close()
	v10 = nil

	if tonumber(p) == 4 then
		__wf_atom_a0f6588f:__wf_atom_ca396b40()
	end
end

function RemoveSteamPack(_)
	v12:Close()
	v12 = nil
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:__wf_atom_9be88b01():SyncInventoryFromDB("EmptyCallback")
	end
end

function SteamTokenRedeemed(_)
	v11:Close()
	v11 = nil
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		__wf_atom_18a5d83b:__wf_atom_9be88b01():SyncInventoryFromDB("EmptyCallback")
	end
end

function TransitionOut()
	if not __wf_atom_7e8ad928(v9) then
		v9:Close()
	end

	if not __wf_atom_7e8ad928(v13) then
		v13:Close()
	end

	if not __wf_atom_7e8ad928(v10) then
		v10:Close()
	end

	if not __wf_atom_7e8ad928(nil) then
		(nil):Close()
	end

	__wf_atom_ec43d06e(mMovie, "LoginPanel", 2, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "Logo", 2, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "FirstLoginBacker", 2, { 12 }, { 0 }, 0.2)
	__wf_atom_ec43d06e(mMovie, "BackerImage", 2, { 12 }, { 0 }, 0.2)
end

local function fn63(p, p2, p3)
	local v73 = p .. "." .. p2

	if __wf_atom_7e8ad928((mMovie:__wf_atom_387f260e(v73, 36))) then
		mMovie:__wf_atom_50d60589(v73, 36, "")
	end

	__wf_atom_ec43d06e(
		mMovie,
		p .. ".Highlight",
		2,
		{ 12, 15 },
		{ module.Ternary(p3, 50, 0), module.Ternary(p3, 36, 1) },
		0.35
	)
	mMovie:__wf_atom_7f57ab2f(p, "Callout", 13, Engine.IsPlayingWithController() and p3)

	if p3 then
		local color = module5.GetColor(10, true)
		mMovie:__wf_atom_4c1c1986(p, "Underline", 11, color)
		mMovie:__wf_atom_4c1c1986(p, "Underline", 12, 100)
	else
		local color = module5.GetColor(4, true)
		mMovie:__wf_atom_4c1c1986(p, "Underline", 11, color)
		mMovie:__wf_atom_4c1c1986(p, "Underline", 12, 40)
	end
end

function UserNameFieldFocused()
	fn63("LoginPanel.Email", "EmailText", true)
end

function UserNameFieldUnfocused()
	fn63("LoginPanel.Email", "EmailText", false)
end

function PasswordFieldFocused()
	fn63("LoginPanel.Password", "PasswordText", true)
end

function PasswordFieldUnfocused()
	fn63("LoginPanel.Password", "PasswordText", false)
end

function Login()
	if not (fn5() or __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie)) then
		fn4()
	end
end

fn7 = function(value)
	if not fn5() then
		local v73 = string.sub(value, string.find(value, "noPWAccount") + 11)
		print(v73)
		v23:SetVisible(false)
		module.__wf_atom_226b7a27(v73)
		v44 = true
	end
end

local function fn64()
	if not (fn5() or __wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie)) then
		fn44()
	end
end

function OnAutoLogin(p, value)
	local v73 = string.find(value, "noPSNAccount") ~= nil
	local v74 = string.find(value, "noPWAccount") ~= nil
	local v75 = string.find(value, "noXBLiveAccount") ~= nil or string.find(value, "invalidAuthToken") ~= nil
	local v76 = string.find(value, "noNSAccount") ~= nil

	if string.find(value, "PSN NP unavailable") ~= nil then
		module.ShowMessage("/Lotus/Language/Menu/LoginFailedPSNUnavailable", "ConfirmLoginFailed")
		fn26(false)
	elseif p then
		fn()
	elseif v74 then
		fn7(value)
	elseif v75 or v76 then
		fn44()
	elseif v73 then
		fn64()
	else
		fn56(p, value)
	end
end

local function fn65()
	if v23 ~= nil then
		v23:SetVisible(false)
	end

	if v24 ~= nil then
		v24:SetVisible(false)
	end

	print("AttemptAutoLogin")
	fn16(false)

	if Engine.__wf_atom_fc67ba71() then
		mMovie:__wf_atom_2dedec1a("LoginPanel_PS4", 13, false)

		if Engine.__wf_atom_b290ec01() then
			mMovie:__wf_atom_2dedec1a("Logos", 13, false)
		end
	end

	fn26(true)
	__wf_atom_a0f6588f:LogIn("", "", "OnAutoLogin", true)
	flag4 = false
end

fn8 = function(p)
	if not p then
		return
	end

	if flag4 then
		fn15("")
		v23.mOnPressedCallback()
		v23:SetVisible(false)
		fn65()
	end
end

function OnProfilePickerCompleted(p)
	fn8(p)
end

function TiePSNAccountToWarframe()
	if Engine.__wf_atom_84bb79c2() and not Engine.__wf_atom_54205c5a() then
		return
	end

	fn65()
end

function EntryFocused(p)
	if not (fn5() or __wf_atom_7e8ad928(nil)) then
		(nil):FocusElementById((tonumber(p)))
	end
end

function EntryUnfocused(p)
	if not (fn5() or __wf_atom_7e8ad928(nil)) then
		(nil):UnfocusElementById((tonumber(p)))
	end
end

function EntryPressed(p)
	if not (fn5() or __wf_atom_7e8ad928(nil)) then
		(nil):SelectElementById((tonumber(p)))
	end
end

function DeselectAndLogin()
	if not fn5() then
		fn15("")
		fn4()
	end
end

fn11 = function()
	if not fn5() then
		local v73 = Engine.__wf_atom_84bb79c2()
			and not Engine.__wf_atom_54205c5a()
			and __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

		if v73 then
			local __wf_atom_9be88b01 = v73:__wf_atom_9be88b01()

			if
				not __wf_atom_9be88b01:__wf_atom_df64c481()
				and __wf_atom_9be88b01:__wf_atom_24908c96()
				and not __wf_atom_a0f6588f:__wf_atom_48285177()
			then
				if v24:IsActive() then
					fn49()
				end

				return
			end
		end

		if v49 then
			if not v47 then
				fn19()
				return
			end

			v6:SetVisible(false)
			fn27("", "", false)
		elseif Engine.__wf_atom_fc67ba71() and mAllowedAdvanceFromLogin then
			v6:SetVisible(false)
			v3 = 4
			fn35(5)
		elseif Engine.__wf_atom_b290ec01() then
			mMovie:__wf_atom_46a6af3b("")

			if v23 ~= nil and v2 == 0 then
				v23.mOnPressedCallback()
			end
		elseif Engine.__wf_atom_e43a530e() and not v35 then
			fn15("")

			if v23 ~= nil and v2 == 0 then
				v23.mOnPressedCallback()
			end
		elseif not (__wf_atom_8e4fda44:__wf_atom_6b69b901(_G.UIMovie_ConfirmMovie) or Engine.__wf_atom_84bb79c2()) then
			fn19()
		end
	end
end

function PressContinue()
	fn11()
end

function onKeyDown_MENU_SELECT()
	if mMovie:__wf_atom_94bf489f() == nil or Engine.IsPlayingWithController() then
		fn11()
	end
end

function onKeyUp_MENU_GENERIC1() end

function OnChildScreenClosed(p)
	if
		p ~= nil
		and Engine.__wf_atom_fc67ba71()
		and p == "HudMargin"
		and (not Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_54205c5a())
	then
		print("HudMargin Set, Loading Dojo")
		fn49()
	end
end

function onKeyDown_MENU_X(...) end

function onKeyDown_MENU_MOUSE_Z(_, _) end

local function fn66()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local __wf_atom_7611b6b4 = __wf_atom_18a5d83b:Settings():__wf_atom_7611b6b4()
	__wf_atom_7611b6b4.matchType = 2
	__wf_atom_7611b6b4.minPlayers = 1
	__wf_atom_7611b6b4.maxPlayers = 4
	__wf_atom_7611b6b4.gameModeId = module3.BuildGameModeIdForNode("SolNode101")
	gMatchingService:__wf_atom_7b244579(__wf_atom_18a5d83b, __wf_atom_7611b6b4, "OnPS4LobbyReady")
end

function OnPS4LobbyReady(p)
	if not p then
		return
	end

	local starChart = module3.GetStarChart()
	local missionForLocation = starChart:BuildMissionForLocation(Symbol("SolNode101"))
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs:SetLevel("/Lotus/Levels/Proc/Corpus/CorpusOutpostDefenseOneGC")
	levelArgs.hostingMultiplayer = true
	levelArgs.migrateServer = true
	levelArgs:__wf_atom_98718663(missionForLocation:__wf_atom_cf762a4f())
	local __wf_atom_0958db03 = missionForLocation:__wf_atom_0958db03()

	for i = 1, #__wf_atom_0958db03 do
		levelArgs:__wf_atom_fce3b660(__wf_atom_0958db03[i].agent)
	end

	if not __wf_atom_7e8ad928(missionForLocation.vipAgent) then
		levelArgs:__wf_atom_fce3b660(missionForLocation.vipAgent)
	end

	local __wf_atom_d5d42e7f = starChart:__wf_atom_d5d42e7f(missionForLocation.location, missionForLocation.vipAgent)

	for i = 1, #__wf_atom_d5d42e7f do
		levelArgs:__wf_atom_fce3b660(__wf_atom_d5d42e7f[i])
	end

	local __wf_atom_65a78aaf = missionForLocation:__wf_atom_65a78aaf()

	for i = 1, #__wf_atom_65a78aaf do
		local v73 = __wf_atom_65a78aaf[i]
		levelArgs:__wf_atom_fce3b660((Type(v73.resource)))
	end

	local __wf_atom_4ccf4f85 = missionForLocation:__wf_atom_4ccf4f85()

	for i = 1, #__wf_atom_4ccf4f85 do
		local v73 = __wf_atom_4ccf4f85[i]
		levelArgs:__wf_atom_fce3b660((Type(v73.resource)))
	end

	local __wf_atom_bd54da48 = missionForLocation:__wf_atom_bd54da48()

	for i = 1, #__wf_atom_bd54da48 do
		levelArgs:__wf_atom_fce3b660(__wf_atom_bd54da48[i])
	end

	local __wf_atom_5623185e = missionForLocation:__wf_atom_5623185e()

	for i = 1, #__wf_atom_5623185e do
		levelArgs:__wf_atom_fce3b660(__wf_atom_5623185e[i])
	end

	levelArgs:__wf_atom_11c734e9(missionForLocation:__wf_atom_fda0d558())
	print("MainMenu::OnPS4LobbyReady: launching level for SolNode101 (/Lotus/Levels/Proc/Corpus/CorpusOutpostDefenseOneGC)")
	Engine.OpenLevel(levelArgs)
end

fn12 = function()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local sessionSearch = Engine.SessionSearch()

	if gMatchingService:__wf_atom_c5171bd3() then
		sessionSearch.matchType = 0
	else
		sessionSearch.matchType = 2
	end

	sessionSearch.gameModeId = module3.BuildGameModeIdForNode("SolNode101")
	print("Searching for gameModeId (gameModeId)=" .. tostring(sessionSearch.gameModeId))
	gMatchingService:FindSessions(__wf_atom_18a5d83b, sessionSearch, "OnFindPS4Lobby")
end

function OnFindPS4Lobby(p)
	print("MainMenu::OnFindPS4Lobby - success=" .. tostring(p))
	local __wf_atom_754c4d7d = gMatchingService:__wf_atom_754c4d7d()

	if p and not __wf_atom_7e8ad928(__wf_atom_754c4d7d) and #__wf_atom_754c4d7d ~= 0 then
		print("Available PS4 hosts:")

		for i = 1, #__wf_atom_754c4d7d do
			print("searchResults[" .. i .. "]=" .. __wf_atom_754c4d7d[i]:__wf_atom_6c164199())
		end

		local v73 = "No hosts"

		for i = 1, #__wf_atom_754c4d7d do
			local v74 = __wf_atom_754c4d7d[i]

			if v74:__wf_atom_366d49f7() == 0 then
				v73 = "/Lotus/Language/Menu/SocialOverlay_SessionFull"
			elseif gMatchingService:__wf_atom_b05c9a8f(v74:StrictNAT()) then
				print("joining " .. v74:__wf_atom_6c164199())
				module2.JoinLobby("OnJoinPS4LobbyComplete", v74)
				return
			else
				v73 = "/Lotus/Language/Menu/SocialOverlay_SessionStrictNAT"
			end
		end

		print("Unable to find joinable session: " .. v73)
		fn66()
	else
		print("No PS4 hosts found -- preparing to host locally")
		fn66()
	end
end

function OnJoinPS4LobbyComplete(p)
	print("MainMenu::OnJoinPS4LobbyComplete - success=" .. tostring(p))

	if not p then
		fn66()
	end
end

function AddResourceDeps()
	local _ = addResourceDeps == nil
end

function NewAccount()
	fn44()
end

local function fn67()
	if not __wf_atom_7e8ad928(v20) then
		v20:Redraw()
	end

	if not __wf_atom_7e8ad928(v21) then
		v21:Redraw()
	end

	if v22 ~= nil then
		v22:Redraw()
	end

	if v23 ~= nil then
		v23:Redraw()
	end

	if v24 ~= nil then
		v24:Redraw()
	end

	if v6 ~= nil then
		v6:Redraw()
	end
end

function IconCacheFlushed()
	fn67()

	if Engine.__wf_atom_703b1471() then
		mMovie:__wf_atom_7d7314f1("LoginPanel_PS4.Disclaimer.text", "")
		mMovie:__wf_atom_7d7314f1("LoginPanel_PS4.Disclaimer.text", "/Lotus/Language/Menu/WarframeSEN_LinkAccounts")
	elseif Engine.__wf_atom_6d151271() then
		mMovie:__wf_atom_7d7314f1("LoginPanel_PS4.Disclaimer.text", "")
		mMovie:__wf_atom_7d7314f1("LoginPanel_PS4.Disclaimer.text", "/Lotus/Language/Menu/WarframeSEN_LinkAccounts_PS5")
	end
end

function SupportsThemes()
	return true
end

function OnHyperlinkPressed(p)
	module.DoOpenWebBrowser(p)
	module6.OnHyperlinkPressed(mMovie)
end

fn10 = function()
	local color = module5.GetColor(9, true)
	local color2 = module5.GetColor(6, true)
	mMovie:__wf_atom_e57658c2("BuildLabel", 11, color)
	mMovie:__wf_atom_e57658c2("Logo.BetaLabel", 11, color2)
end

function OnStyleChangedCallback()
	fn10()

	if not __wf_atom_7e8ad928(v20) then
		v20:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v21) then
		v21:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v22) then
		v22:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v23) then
		v23:UpdateColors()
	end

	if v24 ~= nil then
		v24:UpdateColors()
	end

	if not __wf_atom_7e8ad928(v6) then
		v6:UpdateColors()
	end

	if v2 == 0 and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground()
	end

	if v25 ~= nil then
		v25:UpdateColors()
	end
end