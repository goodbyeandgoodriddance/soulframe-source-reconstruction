local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.UIUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local gToolTip = nil
local gToolTipCallout = nil
local height = 0
local width = 0
local v = {
	PreviousX = nil,
	PreviousY = nil,
	CurrentX = nil,
	CurrentY = nil,
	TargetX = nil,
	TargetY = nil
}
local viewportWidth = 0
local viewportHeight = 0
local cursorScale = 1
local flag = false
local v2 = true
local v3 = nil
local v4 = 2
local total = 0

local function fn()
	local v5 = not __wf_atom_7e8ad928((__wf_atom_8e4fda44:__wf_atom_1dca1cfb()))
	local color = module3.GetColor(9, true, v5)
	local color2 = module3.GetColor(10, true, v5)
	local color3 = module3.GetColor(3, false, v5)
	local color4 = module3.GetColor(2, false, v5)
	mMovie:__wf_atom_1ca72041("Tip.Bg", "RectEdgeColor", color3.red / 255, color3.green / 255, color3.blue / 255, 0.85)
	mMovie:__wf_atom_1ca72041("Tip.Bg", "RectInnerColor", color4.red / 255, color4.green / 255, color4.blue / 255, 1)
	mMovie:__wf_atom_e57658c2("Tip.Label", 44, color)
	mMovie:__wf_atom_e57658c2("Tip.Callout.Tf", 44, color)
	_T.ToolTipColors = { Title = color2, Content = color }
end

function OnProfileSaved()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()

		if not __wf_atom_7e8ad928(settings) then
			cursorScale = settings:__wf_atom_ce8334fc() / 0.125
		end
	end

	flag = true
end

local function fn2()
	mMovie:__wf_atom_e57658c2("Tip", 12, 0)
	mMovie:__wf_atom_e57658c2("Tip.Label", 12, 0)
	mMovie:__wf_atom_e57658c2("Tip.Bg", 12, 0)
	mMovie:__wf_atom_e57658c2("Tip.Callout", 12, 0)
	mMovie:__wf_atom_e57658c2("Tip.Bg", 1, 0)
	mMovie:__wf_atom_e57658c2("Tip.Bg", 15, 45)
	mMovie:__wf_atom_e57658c2("Tip.BottomRightCorner", 1, 34)

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Tip.Label", 49, "Arial Unicode MS")
	end

	local __wf_atom_79258be8 = mMovie:__wf_atom_79258be8()
	local __wf_atom_7c4b8de8 = mMovie:__wf_atom_7c4b8de8()
	mMovie:__wf_atom_e57658c2("Tip", 0, __wf_atom_79258be8)
	mMovie:__wf_atom_e57658c2("Tip", 1, __wf_atom_7c4b8de8)
end

function Initialize()
	viewportWidth, viewportHeight = module.GetScreenDimensions(mMovie)
	fn2()
	gToolTip = nil
	gToolTipCallout = nil
	width = mMovie:__wf_atom_5e6e15c8("Tip.Bg", 14)
	mMovie:OverrideMaterial("Tip.Bg", _G.UIMaterial_RectangleNoDepth)
	mMovie:SetVisible(false)
	_T.ToolTipUpdateColors = fn
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		local settings = __wf_atom_18a5d83b:Settings()

		if not __wf_atom_7e8ad928(settings) then
			cursorScale = settings:__wf_atom_ce8334fc() / 0.125
		end
	end

	flag = true

	if __wf_atom_a0f6588f:__wf_atom_f89aa44a() then
		__wf_atom_55142dd4(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01(), "OnProfileSaved")
	end
end

function Shutdown()
	_T.ToolTipUpdateColors = nil
end

local function fn3(p) -- 1 equivalent call inferred from this helper
	return p - 11
end

local function fn4()
	local gToolTipDelay = _T.gToolTipDelay or mMovie:__wf_atom_1b848254("RefocusTimer") and 0 or 0.75
	_T.gToolTipDelay = nil
	height = mMovie:__wf_atom_5e6e15c8("Tip.Label", 41) + 12
	width = mMovie:__wf_atom_5e6e15c8("Tip.Label", 40) + 18

	if not __wf_atom_7e8ad928(gToolTipCallout) and Engine.IsPlayingWithController() then
		local v5 = mMovie:__wf_atom_5e6e15c8("Tip.Callout.Tf", 40) or 0
		local v6 = mMovie:__wf_atom_5e6e15c8("Tip.Callout", 15) or 0
		mMovie:__wf_atom_e57658c2("Tip.Callout", 0, width - 12 - v5 / 2)
		mMovie:__wf_atom_e57658c2("Tip.Callout", 1, height + v6 / 2)
		height = height + v6 + 12
		__wf_atom_ec43d06e(mMovie, "Tip.Callout", 0, { 12 }, { 100 }, 0.15, 0.15 + gToolTipDelay)
	end

	mMovie:__wf_atom_e57658c2("Tip.Bg", 14, width)
	mMovie:__wf_atom_e57658c2("Tip.Bg", 15, height)
	__wf_atom_ec43d06e(mMovie, "Tip", 0, { 12 }, { 100 }, 0.1, gToolTipDelay)
	__wf_atom_ec43d06e(mMovie, "Tip.Bg", 2, { 12 }, { 100 }, 0.15, gToolTipDelay)
	__wf_atom_ec43d06e(mMovie, "Tip.BottomRightCorner", 2, { 1 }, { fn3(height) }, 0.15, 0.1 + gToolTipDelay) -- inferred equivalent call
	__wf_atom_ec43d06e(mMovie, "Tip.Label", 0, { 12 }, { 100 }, 0.15, 0.15 + gToolTipDelay)
	__wf_atom_ec43d06e(mMovie, "VisibleTimer", 0, nil, nil, 0, gToolTipDelay)
end

function Update()
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if gToolTip == nil and _T.gToolTip == nil then
		return
	end

	if flag then
		viewportWidth, viewportHeight = module.GetScreenDimensions(mMovie)
		flag = false
	end

	if total < 1 then
		total += __wf_atom_fa1258d0() * v4

		if total >= 1 then
			mMovie:__wf_atom_e57658c2("Tip.Label", 72, -1)
		else
			local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Tip.Label", 80)
			local rounded = module.Round(__wf_atom_5e6e15c8 * total)
			mMovie:__wf_atom_e57658c2("Tip.Label", 72, rounded)
		end
	end

	if gToolTipCallout ~= _T.gToolTipCallout or v2 then
		v2 = false
		gToolTipCallout = _T.gToolTipCallout

		if gToolTipCallout == "" then
			gToolTipCallout = nil
		end

		if __wf_atom_7e8ad928(gToolTipCallout) then
			mMovie:__wf_atom_50d60589("Tip.Callout.Tf", 36, "")
		else
			mMovie:__wf_atom_7d7314f1("Tip.Callout.Tf.text", gToolTipCallout)
		end

		fn4()
	end

	if _T.gToolTip ~= "" then
		local v5 = gToolTip
		gToolTip = _T.gToolTip

		if v5 ~= nil and not mMovie:__wf_atom_1b848254("VisibleTimer") then
			__wf_atom_ec43d06e(mMovie, "RefocusTimer", 0, nil, nil, 0, 0.3)
		end

		if gToolTip == nil then
			_T.gToolTipCoords = nil
			_T.gToolTipClipName = nil
			__wf_atom_ec43d06e(mMovie, "Tip", 0, { 12 }, { 0 }, 0.15, 0, function()
				mMovie:SetVisible(false)
			end)
		else
			_T.gToolTip = ""
			mMovie:SetVisible(true)
			fn()
			v4 = 2

			if v5 == nil or _T.gToolTipRedraw ~= false then
				if mMovie:__wf_atom_1b848254("RefocusTimer") then
					v4 = 5
				else
					fn2()
				end

				mMovie:__wf_atom_50d60589("Tip.Label", 36, gToolTip)
				mMovie:__wf_atom_e57658c2("Tip.Label", 72, 0)
				total = 0
			else
				mMovie:__wf_atom_50d60589("Tip.Label", 36, gToolTip)
				mMovie:__wf_atom_e57658c2("Tip.Label", 72, -1)
				total = 0.99
			end

			fn4()
			v.TargetX = nil
			v.TargetY = nil
		end
	end

	if gToolTip ~= nil then
		local v5 = not __wf_atom_a0f6588f:__wf_atom_f89aa44a()

		if v3 ~= v5 then
			v3 = v5
			mMovie:__wf_atom_62d09591(v5)
		end

		local drawScale, invScale

		if mMovie:__wf_atom_6e4667f6() then
			drawScale = mMovie:__wf_atom_68d996b1()
			invScale = 1 / drawScale
		else
			drawScale = 1
			invScale = 1
		end

		local gTooltipAlignment = _T.gTooltipAlignment
		local gToolTipCoords = _T.gToolTipCoords
		local v6 = gToolTipCoords == nil and {
			x = mMovie:__wf_atom_79258be8() + 10,
			y = mMovie:__wf_atom_7c4b8de8() - 13
		} or gToolTipCoords
		local v7 = {
			ReverseBuffer = 20,
			CursorScale = cursorScale,
			Width = width,
			Height = height,
			DrawScale = drawScale,
			InvScale = invScale,
			ViewportWidth = viewportWidth,
			ViewportHeight = viewportHeight,
			PixelCoords = _T.gToolTipCoords ~= nil
		}

		if gTooltipAlignment ~= nil and gTooltipAlignment == module.LEFT_ALIGNED then
			v7.Width = 0
		end

		local popupCoords = module2.GetPopupCoords(v6, mMovie, v7, v)

		if gTooltipAlignment ~= nil and gTooltipAlignment == module.LEFT_ALIGNED then
			popupCoords.x -= width + 18 + 10
		end

		mMovie:__wf_atom_e57658c2("Tip", 0, popupCoords.x)
		mMovie:__wf_atom_e57658c2("Tip", 1, popupCoords.y)
	end
end

function onViewportSizeChanged(_, _, _, _)
	viewportWidth, viewportHeight = module.GetScreenDimensions(mMovie)
end

function OnGamepadTransition(_)
	fn2()
	v2 = true
end