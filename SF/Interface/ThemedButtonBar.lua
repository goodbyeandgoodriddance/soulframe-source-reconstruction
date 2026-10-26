local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("SF.Interface.Components.Button")
local v = nil
local v2 = false
local v3 = nil
local v4 = {}
local v5 = {}
local v6 = true
local mMovie2 = nil
local v7 = false
local v8 = nil
local v9 = {}

function MovieLoaded() end

local function fn()
	local count = #v5

	if not (count > 0) then
		return nil
	end

	local __wf_atom_1dca1cfb = __wf_atom_8e4fda44:__wf_atom_1dca1cfb()

	for i = 1, count do
		if v5[i].mMovie == __wf_atom_1dca1cfb then
			return v5[i]
		end
	end

	return v5[count]
end

local function fn2(screen)
	if screen == nil then
		screen = fn()
	end

	if screen == nil then
		return false
	end

	if __wf_atom_7e8ad928(screen.mMovie) then
		return true
	end

	return (screen.mMovie:Execute("IsInputBlocked", ""))
end

local function fn3()
	local v10 = fn()
	return v10 ~= nil and v10.mApplyThemes
end

function SupportsThemes()
	return fn3()
end

local function fn4()
	local count = 0

	for _, v10 in ipairs(v5) do
		if #v10.mButtons > 0 then
			count += 1
		end
	end

	return count > 0
end

local function fn5(p, list)
	if #list == 0 then
		return
	end

	local v10 = list[1]

	if #list > 1 then
		table.remove(list, 1)
	end

	v8 = v:AddTimer(v10, function()
		mMovie:__wf_atom_e57658c2("Fx", 0, p)
		module.CreateParticles(
			mMovie,
			"Fx",
			pulseFx,
			nil,
			nil,
			module.Ternary(not __wf_atom_7e8ad928(__wf_atom_392793db), __wf_atom_392793db, gRegion),
			nil,
			nil,
			true
		)
		fn5(p, list)
	end)
end

local function fn6()
	if v8 ~= nil then
		v:RemoveTimer(v8)
	end

	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	local mButtons = {}
	local mOptions = {}
	local screen = fn()

	if screen == nil then
		mMovie2 = nil
	else
		mButtons = screen.mButtons
		mMovie2 = screen.mMovie
		mOptions = screen.mOptions or {}
	end

	mMovie:__wf_atom_3d3e910b(mOptions.DesiredViewportAnchor or 8)
	mMovie:__wf_atom_f0448d34(_T.RadialSolarMapOpen == true or not __wf_atom_7e8ad928(mMovie2) and mMovie2:__wf_atom_65909d99())
	local count = #mButtons
	local v10 = count > 0

	if v10 then
		mMovie:SetVisible(true)
	end

	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, { module.Ternary(v10, 100, 0) }, 0.15, 0, function()
		mMovie:SetVisible(v10)
	end)

	local function fn7()
		if v10 then
			local total = 0

			for i = 1, count do
				mButtons[i].TargetX = total
				mButtons[i].Screen = screen
				local v11 = v3:AddElement(mButtons[i])

				if __wf_atom_7e8ad928(v11) or __wf_atom_7e8ad928(v11.mClipName) then
					continue
				end

				local callOut = v11.CallOut

				if callOut ~= nil and callOut ~= "" then
					callOut = "<" .. callOut .. ">"
				end

				v11.mButton = module3.Create(
					mMovie,
					v11.mClipName,
					v11.Label,
					nil,
					callOut,
					nil,
					v11.SkipCallback or false
				)
				v11.mButton.mShowCallout = true

				if not __wf_atom_7e8ad928(v11.Active) then
					v11.mButton:SetActive(v11.Active)
				end

				if not __wf_atom_7e8ad928(v11.Icon) then
					v11.mButton:SetIcon(v11.Icon, 66, v11.IconShiftX or -26, v11.IconShiftY)
				end

				v11.ElementWidth = v11.mButton.mWidth

				if v11.Padding ~= nil then
					v11.ElementWidth += v11.Padding
				end

				total += v11.ElementWidth + v3.mForcedHorizontalSeparation
			end

			local deltaX = total - v3.mForcedHorizontalSeparation
			local desiredRightX = mOptions.DesiredRightX or math.ceil(mMovie:__wf_atom_97cd8326() * 0.95)
			local desiredCenterX = mOptions.DesiredCenterX
			local v11 = desiredRightX + (desiredCenterX == nil and 0 or math.min(desiredCenterX - (desiredRightX - deltaX / 2), 0))
			v3.DeltaX = deltaX
			local startingX = v11 - deltaX
			v3.StartingX = startingX

			for i = 1, count do
				local mButton = mButtons[i]
				mButton.TargetX += startingX
				mButton.mButton:SetPosition(mButton.TargetX + mButton.ElementWidth, nil, module.RIGHT_ALIGNED)

				if mButton.Pulse then
					fn5(mButton.TargetX + mButton.ElementWidth / 2, { 2, 0.75, 0.75, 7 })
				end

				local mEnvironment = screen.mEnvironment

				if not (mEnvironment ~= nil and mButton.CallOut ~= nil and mButton.CallBack ~= nil) then
					continue
				end

				local v12 = "onKeyUp_" .. mButton.CallOut
				local v13 = "onKeyDown_" .. mButton.CallOut
				mButton.mCallbackHandled = not mButton.ForceHandled
					and (mEnvironment[v12] ~= nil or mEnvironment[v13] ~= nil)
				mButton.mCallbackHandled = mButton.mCallbackHandled
					or not Engine.IsPlayingWithController() and mButton.CallOut ~= "MENU_CANCEL"
				v4[mButton.CallOut] = false
				local v14 = getfenv(1)

				v14[v13] = function()
					if not v6 then
						return false
					end

					v4[mButton.CallOut] = true

					if mButton.mCallbackHandled then
						return
					else
						return true
					end
				end

				v14[v12] = function()
					if not v6 then
						return false
					end

					local v15 = false
					local v16 = false

					if mButton.CallOut == "MENU_CANCEL" then
						if not Engine.IsPlayingWithController() then
							local movie = __wf_atom_8e4fda44:FindMovie(module.GetChatMovie())
							v15 = not __wf_atom_7e8ad928(movie)
								and not __wf_atom_7e8ad928(mMovie2)
								and movie:Execute("IsFull", "")
								and not movie:Execute("IsInputBlocked", "")
								and movie:__wf_atom_7fc4c74c() > mMovie2:__wf_atom_7fc4c74c()
								and true
								or false
						end

						if mEnvironment.BUTTONBAR_MENU_CANCEL and mEnvironment.BUTTONBAR_MENU_CANCEL() then
							v15 = true
							v16 = true
						end
					end

					if not v15 and v4[mButton.CallOut] and not mButton.mCallbackHandled then
						v3:SelectElementById(mButton.Id)
						v16 = true
					end

					v4[mButton.CallOut] = false
					return v16
				end
			end
		end

		v3:Redraw(function()
			v3:RunForAllElements(function(p)
				p.mButton:UpdateEnabledState()
			end)
		end, true)
		v3.CalloutDisplayed = Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()
	end

	if v3:GetHowManyElements() > 0 then
		local v11 = getfenv(1)
		v3:RunForAllElements(function(p)
			mMovie:__wf_atom_7f57ab2f(p.mClipName, "Btn", 67, false)

			if p.CallOut ~= nil then
				local v12 = "onKeyUp_" .. p.CallOut
				local v13 = "onKeyDown_" .. p.CallOut
				v11[v13] = nil
				v11[v12] = nil
			end
		end)
		v3:RemoveElements(true, true)
		fn7()
	else
		fn7()
	end

	local mMovie3 = mMovie
	local mIgnoreInput = not v10

	if not mIgnoreInput then
		if screen == nil then
			mIgnoreInput = false
		else
			mIgnoreInput = screen.mIgnoreInput
		end
	end

	mMovie3:__wf_atom_c884ca43(mIgnoreInput)

	if v7 then
		mMovie:__wf_atom_fbca497c(false)
	end
end

local function fn7(p)
	for i = #v5, 1, -1 do
		local v10 = v5[i]

		if not (__wf_atom_7e8ad928(v10.mMovie) or v10.mMovie == p) then
			continue
		end

		table.remove(v5, i)
		break
	end
end

local function fn8(mMovie, mButtons, mEnvironment, p, p2, options)
	if mButtons == nil then
		fn7(mMovie)
		return
	end

	local v10 = {
		mMovie = mMovie,
		mApplyThemes = true,
		mEnvironment = mEnvironment,
		mButtons = mButtons,
		mIgnoreInput = p2 == true,
		mOptions = options or {}
	}
	local count = #v5
	local v11 = count + 1
	local v12 = Engine.IsPlayingWithController() or Engine.__wf_atom_5df63302()
	local v13 = false

	for i = 1, count do
		local mMovie3 = v5[i].mMovie

		if mMovie3 == mMovie then
			v13 = true

			if p then
				v11 = i
			else
				local v14 = #mButtons == #v5[i].mButtons

				if v14 then
					v11 = i

					for j, v15 in ipairs(mButtons) do
						if not (v15.Label ~= v5[i].mButtons[j].Label or v15.CallOut ~= v5[i].mButtons[j].CallOut) then
							continue
						end

						v14 = false
						break
					end
				else
					v11 = i
				end

				if v14 and v12 == v3.CalloutDisplayed then
					return
				end
			end
		elseif v13 and not __wf_atom_7e8ad928(mMovie3) and mMovie3:IsVisible() then
			v13 = false
			break
		end
	end

	v5[v11] = v10

	if p or v13 then
		fn6()
	end
end

local function fn9(p)
	mMovie:__wf_atom_fbca497c(p)
	v7 = not p
end

local function fn10()
	local module4 = require("EE.Interface.Components.List")
	v3 = module4.CreateList(mMovie, "MenuItem")
	v3.mForcedVerticalSeparation = 0
	v3.mForcedHorizontalSeparation = 24
	v3.mElementTransitionTime = 0
	v3.mTransitionInDeltaY = 0
	v3.mTransitionOutDeltaY = 0
	v3.mWrapAroundNavigation = false
	v3.mApplyThemes = fn3()
	v3:SetCallbacks("MenuItemSelected", "MenuItemFocused", "MenuItemUnfocused", "MenuItemPressed")

	function v3.mOnFocusedCallback(data)
		if data.Screen and not (fn2(data.Screen) or __wf_atom_7e8ad928(data.mButton)) then
			data.mButton:SetFocus(true)

			if data.Tips == nil then
				if data.FocusCallback ~= nil then
					data.FocusCallback(data.mButton)
				end
			else
				local infoPopup_Data = {
					CustomEntry = true,
					Name = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Ability_Tips", false),
					Hints = data.Tips
				}
				module2.SetItemInfoPopupRect(
					mMovie,
					infoPopup_Data,
					mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Btn", 2),
					mMovie:__wf_atom_5e6e15c8(data.mClipName .. ".Btn", 3),
					data.mButton.mWidth,
					data.mButton.mHeight,
					true,
					true
				)
				_T.InfoPopup_Grid = nil
				_T.InfoPopup_Data = infoPopup_Data
			end
		end
	end

	function v3.mOnUnfocusedCallback(data)
		if not __wf_atom_7e8ad928(data.mButton) then
			data.mButton:SetFocus(false)

			if data.Tips == nil then
				if data.UnfocusCallback ~= nil then
					data.UnfocusCallback(data.mButton)
				end
			else
				_T.InfoPopup_Data = nil
				_T.InfoPopup_Grid = nil
			end
		end
	end

	function v3.mOnSelectedCallback(data)
		if data.Screen and not fn2(data.Screen) and v6 then
			if not __wf_atom_7e8ad928(data.mButton) then
				data.mButton:Pressed(true)
			end

			if data.CallBack ~= nil then
				data.CallBack()
			end
		end
	end

	function v3.mElementDrawCallback(_) end

	function v3.SetupPreInterpolationValues(p, p2)
		if v3.DeltaX == nil then
			return
		end

		p.mMovie:__wf_atom_e57658c2(p2.mClipName, 12, 0)
		p.mMovie:__wf_atom_e57658c2(p2.mClipName, 0, p2.TargetX + v3.DeltaX)
	end

	function v3.GetInterpolationProperties(_, data)
		if not __wf_atom_7e8ad928(data.Alpha) then
			return { 12, 0 }, { data.Alpha, data.TargetX }
		end

		if __wf_atom_7e8ad928(data.mButton) or __wf_atom_7e8ad928(data.mButton.Alpha) then
			return { 12, 0 }, { 100, data.TargetX }
		end

		return { 12, 0 }, { data.mButton.Alpha, data.TargetX }
	end
end

function Shutdown()
	for k in pairs(v9) do
		_T[k] = nil
	end
end

local function fn11()
	mMovie:Close()
end

function TransitionOut()
	__wf_atom_ec43d06e(mMovie, "_root", 0, { 12 }, { 0 }, 0.15, 0, fn11)
end

local function fn12(p)
	v6 = p
end

local function fn13(p)
	mMovie:__wf_atom_2dedec1a("_root", 13, p)
end

local function fn14()
	return mMovie:__wf_atom_54eeda24() - mMovie:__wf_atom_5e6e15c8("MenuItem", 1) + 10
end

local function fn15()
	return mMovie:__wf_atom_5e6e15c8("MenuItem", 0)
end

local function fn16(p, p2)
	_T[p] = p2
	v9[p] = p2
end

function Initialize()
	fn16("ButtonBarMovie", mMovie)
	fn16("SetButtons", fn8)
	fn16("SetButtonBarEnabled", fn12)
	fn16("SetButtonBarVisible", fn13)
	fn16("IsButtonBarInputBlocked", fn2)
	fn16("AnyMenuOpen", fn4)
	fn16("ShowButtonBarCursor", fn9)
	fn16("GetButtonBarOffset", fn14)
	fn16("GetButtonBarStart", fn15)
	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	fn10()
	fn6()
	v2 = true
end

function Update()
	if __wf_atom_7e8ad928(mMovie) or not v2 then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end

	local v10 = 1

	while v10 <= #v5 do
		if __wf_atom_7e8ad928(v5[v10].mMovie) then
			table.remove(v5, v10)
		else
			v10 += 1
		end
	end

	local v11 = fn()

	if v11 == nil and mMovie2 ~= nil or v11 ~= nil and v11.mMovie ~= mMovie2 then
		fn6()
	end
end

function MenuItemFocused(p)
	if not __wf_atom_7e8ad928(v3) then
		v3:FocusElementById((tonumber(p)))
	end
end

function MenuItemUnfocused(p)
	if not __wf_atom_7e8ad928(v3) then
		v3:UnfocusElementById((tonumber(p)))
	end
end

function MenuItemPressed(p)
	if not __wf_atom_7e8ad928(v3) then
		v3:SelectElementById((tonumber(p)))
	end
end

function IconCacheFlushed()
	fn6()
end

function OnStyleChangedCallback()
	if not __wf_atom_7e8ad928(v3) then
		fn6()
	end
end

function OnGamepadTransition(_)
	fn6()
end