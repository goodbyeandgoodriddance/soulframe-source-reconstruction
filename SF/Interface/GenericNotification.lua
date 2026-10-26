local module = require("EE.Interface.Utilities")
local v = {}
local v2 = nil
local v3 = nil
local v4 = nil
local total = 0
local v5 = nil
local holdDuration2 = nil
local v6 = {
	BuildComplete = { Icon = 1, Sound = 1 },
	BuildCompleteTuvalkane = { Icon = 2 },
	BuildCompleteVerminia = { Icon = 3 },
	HotfixInbound = {
		Icon = 4,
		RemoveBackground = true,
		CustomIconSize = 116,
		CustomIconOffsetX = -11,
		CustomIconOffsetY = -7
	},
	UpdateInbound = {
		Icon = 6,
		RemoveBackground = true,
		CustomIconSize = 116,
		CustomIconOffsetX = -16,
		CustomIconOffsetY = -1
	},
	Matchmaking = { Icon = 5, Material = 1, InputFilter = 1 }
}

local function fn()
	local icon = v2.Icon

	if icon ~= nil and v6[icon] ~= nil then
		return v6[icon]
	end

	if __wf_atom_7e8ad928(icon) or type(icon) ~= "userdata" then
		return { Icon = defaultIcon }
	end

	return { Icon = icon }
end

local function fn2(p)
	local v7 = getfenv(1)

	if v2 ~= nil then
		for k, _ in v2.ActionCallbacks do
			v7["onKeyDown_" .. k] = nil
			v7["onKeyUp_" .. k] = nil
		end
	end

	if p == nil then
		v2 = table.remove(v, 1)
	else
		v2 = p
	end

	if v2 ~= nil then
		for k, actionCallback in v2.ActionCallbacks do
			local v8 = actionCallback

			v7["onKeyDown_" .. k] = function()
				v5 = v8[1]
				holdDuration2 = holdDuration

				if v5 ~= nil then
					v5(true)
				end

				mMovie:__wf_atom_2dedec1a("Notification.Profile.ProgressCap", 13, true)
				return true
			end

			local v9 = actionCallback

			v7["onKeyUp_" .. k] = function()
				if v5 ~= v9[1] then
					return true
				end

				v5(false)
				v5 = nil
				mMovie:__wf_atom_1ca72041("Notification.Profile.Border", "AlphaTestThreshold", 1, 0, 0, 0)
				mMovie:__wf_atom_2dedec1a("Notification.Profile.ProgressCap", 13, false)
				return true
			end
		end
	end
end

local function fn3(p, callback, p2, p3)
	if not v2 or p3 ~= nil and p3 ~= v2.Icon then
		return
	end

	__wf_atom_ec43d06e(mMovie, "Notification", 2, { 0 }, { mMovie:__wf_atom_97cd8326() }, fadeOutTime, p, function()
		mMovie:__wf_atom_2dedec1a("Notification", 13, false)
		mMovie:SetVisible(false)

		if not __wf_atom_7e8ad928(callback) then
			callback(false, p2)
		end

		fn2()
	end)
end

local function fn4()
	if not v2 then
		return
	end

	local input = v2.Input or ""

	if type(input) == "table" then
		input = input.Text or ""
	end

	local v7 = fn()

	if __wf_atom_7e8ad928(v7.InputFilter) then
		mMovie:__wf_atom_50d60589("Notification.Label.Text", 36, mMovie:__wf_atom_8e9ac384(input, true))
	else
		mMovie:__wf_atom_50d60589("Notification.Label.Text", 36, mMovie:__wf_atom_c7fa5e0c(input, v7.InputFilter))
	end

	local v8 = math.max(mMovie:__wf_atom_5e6e15c8("Notification.Label.Text", 41) + 20, v4)
	mMovie:__wf_atom_e57658c2("Notification.Backer", 15, v8)
	mMovie:__wf_atom_e57658c2("Notification.Btn", 15, v8)
	mMovie:__wf_atom_e57658c2("Notification.SeparatorTop", 1, -v8 / 2)
	mMovie:__wf_atom_e57658c2("Notification.SeparatorBot", 1, v8 / 2)
	mMovie:__wf_atom_e57658c2("Notification.Icon", 1, -v8 / 2)
	__wf_atom_ec43d06e(mMovie, "Notification", 4, { 0 }, { v3 }, fadeInTime, 0, function()
		if v2 ~= nil and v2.VisibleDuration > 0 then
			fn3(v2.VisibleDuration, v2.Callback, v2.CallbackParams)
		end
	end)
end

local function fn5(label, icon, p, fadeOutDelay2, colorOverride, p2, callback, callbackParams, actionCallbacks)
	if fadeOutDelay2 == nil then
		fadeOutDelay2 = fadeOutDelay
	end

	local v7 = {
		Input = label,
		Icon = icon,
		VisibleDuration = fadeOutDelay2,
		ColorOverride = colorOverride,
		Callback = callback,
		CallbackParams = callbackParams,
		ActionCallbacks = actionCallbacks
	}

	for _, item in actionCallbacks do
		if type(item) ~= "table" then
			DebugBreak("function must be contained in a table due to engine hashing limitations preventing indexing functions by string")
		end
	end

	if v2 ~= nil and p2 then
		if p and icon == v2.Icon then
			fn2(v7)
			fn4()
			return
		elseif not (__wf_atom_7e8ad928(gClient) or gClient:__wf_atom_449cc668()) then
			fn3(0)
		end
	end

	local v8 = (p or p2) and 1 or #v + 1
	table.insert(v, v8, v7)
end

local function fn6()
	fn2()

	if not v2 then
		return
	end

	local v7 = fn()
	fn4()
	mMovie:__wf_atom_2dedec1a("Notification", 13, true)
	module.PlaySound(v7.Sound)
	mMovie:__wf_atom_933bbce0("Notification.Profile.Icon", v7.Icon, v7.Material)
	mMovie:__wf_atom_0c1c47f2(v7.InputFilter)
	mMovie:__wf_atom_b4ffb30f(not __wf_atom_7e8ad928(v7.InputFilter))
	local customIconSize = v7.CustomIconSize or 60
	local customIconOffsetX = v7.CustomIconOffsetX or 0
	local customIconOffsetY = v7.CustomIconOffsetY or 0
	local removeBackground = v7.RemoveBackground or false
	mMovie:__wf_atom_2dedec1a("Notification.Profile.Mask", 13, not removeBackground)
	mMovie:__wf_atom_e57658c2("Notification.Profile.Icon", 0, customIconOffsetX)
	mMovie:__wf_atom_e57658c2("Notification.Profile.Icon", 1, customIconOffsetY)
	mMovie:__wf_atom_e57658c2("Notification.Profile.Icon", 14, customIconSize)
	mMovie:__wf_atom_e57658c2("Notification.Profile.Icon", 15, customIconSize)
	mMovie:SetVisible(true)
	local callback = v2.Callback

	if not __wf_atom_7e8ad928(callback) then
		callback(true, v2.CallbackParams)
	end

	mMovie:__wf_atom_2dedec1a("Notification.Profile.Leaves", 13, not removeBackground)
	mMovie:__wf_atom_2dedec1a("Notification.Profile.Border", 13, not removeBackground)
	mMovie:__wf_atom_2dedec1a("Notification.Profile.Backer", 13, not removeBackground)
	mMovie:__wf_atom_2dedec1a("Notification.Profile.Trough", 13, not removeBackground)
	total = 0
	mMovie:__wf_atom_e57658c2("Notification.Profile.Leaves", 16, total)
end

function Shutdown()
	_T.HideNotification = nil
	_T.ShowNotification = nil
end

local function fn7()
	for k, v7 in pairs(v6) do
		v6[k].Icon = iconTexture[v7.Icon]
		v6[k].Material = iconMaterial[v7.Material]
		v6[k].Sound = noteSounds[v7.Sound]
		v6[k].InputFilter = inputFilters[v7.InputFilter]
	end
end

function Initialize()
	fn7()
	_T.HideNotification = fn3
	_T.ShowNotification = fn5
	mMovie:OverrideMaterial("Notification.Profile.Border", radialProgressMaterial)
	mMovie:__wf_atom_1ca72041("Notification.Profile.Border", "AlphaTestThreshold", 1, 0, 0, 0)
	mMovie:__wf_atom_2dedec1a("Notification.Profile.ProgressCap", 13, false)
	mMovie:__wf_atom_2dedec1a("Notification", 13, false)
	v3 = mMovie:__wf_atom_5e6e15c8("Notification", 0)
	v4 = mMovie:__wf_atom_5e6e15c8("Notification.Bg.TextBacker", 15)
	mMovie:__wf_atom_e57658c2("Notification", 0, mMovie:__wf_atom_97cd8326())
	local v7 = mMovie:__wf_atom_97cd8326() - v3
	mMovie:__wf_atom_e57658c2("Notification.Label.Text", 14, v7 - mMovie:__wf_atom_97cd8326() * 0.05)
	mMovie:__wf_atom_e57658c2("Notification.Backer", 14, v7 + 600)
	mMovie:__wf_atom_e57658c2("Notification.Btn", 14, v7)
	mMovie:__wf_atom_e57658c2("Notification.SeparatorTop", 14, v7)
	mMovie:__wf_atom_e57658c2("Notification.SeparatorBot", 14, v7)
	local v8 = mMovie:__wf_atom_5e6e15c8("Notification.Highlight", 14) / 2
	mMovie:__wf_atom_e57658c2("Notification.Highlight", 0, v8)
	mMovie:OverrideMaterial("Notification.SeparatorTop", _G.UIMaterial_TiledDivider)
	mMovie:OverrideMaterial("Notification.SeparatorBot", _G.UIMaterial_TiledDivider)
	mMovie:__wf_atom_1ca72041("Notification.SeparatorTop", "TileRepeats", v7 / 32, 1, 0, 0)
	mMovie:__wf_atom_1ca72041("Notification.SeparatorBot", "TileRepeats", v7 / 32, 1, 0, 0)
	mMovie:SetCallbacks("Notification.Btn", "NotificationFocused", "NotificationUnfocused", "NotificationSelected", nil)
	mMovie:__wf_atom_e57658c2("Notification.Highlight", 12, 0)
	mMovie:__wf_atom_e57658c2("Notification.Highlight", 11, _G.UIColor_Yellow)
	mMovie:__wf_atom_e57658c2("Notification.Backer", 11, _G.UIColor_DarkBrown)
	mMovie:__wf_atom_e57658c2("Notification.Profile.Backer", 11, _G.UIColor_DarkerBrown)
	mMovie:__wf_atom_e57658c2("Notification.Label.Text", 44, _G.UIColor_Tan)
	mMovie:__wf_atom_50d60589("Notification.Label.Text", 46, "center")

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Notification.Label.Text", 49, "Arial Unicode MS")
	end

	if _T.QueuedNotifications ~= nil then
		for i = 1, #_T.QueuedNotifications do
			local queuedNotification = _T.QueuedNotifications[i]
			fn5(
				queuedNotification.Label,
				queuedNotification.Icon,
				false,
				queuedNotification.TimeOverride,
				queuedNotification.ColorOverride,
				nil,
				queuedNotification.Callback,
				queuedNotification.CallbackParams,
				queuedNotification.ActionCallbacks
			)
		end

		_T.QueuedNotifications = nil
	end
end

function Update()
	local v7 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v7)

	if
		#v > 0
		and not v2
		and not _T.PauseNotifications
		and not __wf_atom_7e8ad928(gClient)
		and not gClient:__wf_atom_449cc668()
		and not __wf_atom_7e8ad928(gRegion)
		and __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	then
		fn6()
	end

	total += v7 * 30
	mMovie:__wf_atom_e57658c2("Notification.Profile.Leaves", 16, total)

	if v5 == nil then
		if holdDuration2 ~= nil then
			holdDuration2 = nil
		end
	else
		holdDuration2 -= v7
		local v8 = math.min(1, 1 - holdDuration2 / holdDuration)
		mMovie:__wf_atom_1ca72041("Notification.Profile.Border", "AlphaTestThreshold", v8, 0, 0, 0)
		mMovie:__wf_atom_e57658c2("Notification.Profile.ProgressCap", 16, v8 * 360)

		if holdDuration2 <= 0 then
			v5(true, true)
			v5 = nil
			holdDuration2 = nil
			mMovie:__wf_atom_2dedec1a("Notification.Profile.ProgressCap", 13, false)
		end
	end
end

function IconCacheFlushed()
	fn4()
end

function OnGamepadTransition()
	fn4()
end