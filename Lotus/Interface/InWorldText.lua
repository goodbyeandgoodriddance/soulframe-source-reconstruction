local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local v = false
local v2 = ""
local v3 = ""
local v4 = nil
local v5 = false
local v6 = 360
local v7 = false
local v8 = false
local v9 = false
local v10 = false
local v11 = ""
local v12 = nil
local v13 = false
local v14 = 30
local v15 = 12
local v16 = nil
local v17 = nil

function SetTitle(_) end

local function fn(p)
	v9 = p
	mMovie:__wf_atom_e57658c2("Panel", 5, module.Ternary(p, 100, 600))
	mMovie:__wf_atom_e57658c2("Panel", 6, module.Ternary(p, 100, 600))
	mMovie:__wf_atom_7f57ab2f("Panel", module.Ternary(p, "Bg", "LiteBg"), 13, false)
	mMovie:__wf_atom_7f57ab2f("Panel", module.Ternary(p, "LiteBg", "Bg"), 13, true)

	if p then
		module2.SetUpInWorldPanel(mMovie, "Panel.LiteBg")
		mMovie:__wf_atom_e57658c2("Panel.LiteBg.Foreground", 4, 0)
		mMovie:__wf_atom_e57658c2("Panel.LiteBg.Shadow", 4, 0)
		mMovie:__wf_atom_e57658c2("Panel.LiteBg.BackShadow", 4, 0)
		__wf_atom_ec43d06e(mMovie, "Panel.LiteBg.BackShadow", 8, { 4 }, { 400 }, 0.25, 0.25)
		__wf_atom_ec43d06e(mMovie, "Panel.LiteBg.Shadow", 8, { 4 }, { 200 }, 0.25, 0.25)
	else
		mMovie:__wf_atom_e57658c2("ControllerHolder", 5, 600)
		mMovie:__wf_atom_e57658c2("ControllerHolder", 6, 600)
	end

	if p and not __wf_atom_7e8ad928(shapeProcedural) then
		shapeProcedural:__wf_atom_a042ff6c(Symbol("AAEdgeExtend"), 1, 0, 0, 0)
	end
end

function SetVisible(p)
	if p == "true" then
		mMovie:__wf_atom_2dedec1a("Panel.Instruction", 13, true)
		fn(v9)
	else
		mMovie:__wf_atom_2dedec1a("Panel.Instruction", 13, false)
		mMovie:__wf_atom_2dedec1a("Panel.Bg", 13, false)
		mMovie:__wf_atom_2dedec1a("Panel.LiteBg", 13, false)
	end
end

function SetLiteMode(p)
	fn(p == "true")
end

function HideBg(p)
	local v18 = p == "true"
	mMovie:__wf_atom_7f57ab2f("Panel", module.Ternary(v9, "LiteBg", "Bg"), 13, not v18)
end

local function fn2()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)
	local ternary = module.Ternary(
		not __wf_atom_7e8ad928(__wf_atom_18a5d83b),
		__wf_atom_18a5d83b:Settings():__wf_atom_2203c0db(),
		0
	)
	return Engine.__wf_atom_e43a530e() and ternary == 1
end

local function fn3(value)
	if __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		print("Profile == nil in ApplyGamepadBindingSubstitutions")
		return ""
	end

	if
		(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0):Settings():__wf_atom_000a0b8a(
			"POWER_MODIFIER",
			false,
			__wf_atom_c67f9605:__wf_atom_622bc136(),
			tennoInputFilter
		) ~= "" or fn2())
		and string.find(value, "TutorialUsePower")
	then
		local v18 = string.gsub(value, "Excal", "Generic")
		local v19 = string.gsub(v18, "Volt", "Generic")
		value = string.gsub(v19, "Mag", "Generic")
	end

	local __wf_atom_8e9ac384 = mMovie:__wf_atom_8e9ac384(value, false)

	if fn2() and string.find(__wf_atom_8e9ac384, "<ACTIVATE_ABILITY_[0-9]>") then
		if not mMovie:__wf_atom_253d7085("ControllerHolder.SwipePadController") then
			__wf_atom_86cbd68d(mMovie, "ControllerHolder.attachMovie", "PS4Controller_All", "SwipePadController", 10)
		end

		__wf_atom_8e9ac384 = string.gsub(__wf_atom_8e9ac384, "<ACTIVATE_ABILITY_[0-9]>", "")
	end

	return (string.gsub(__wf_atom_8e9ac384, "<MINI_INVENTORY_HOLD>", "<MINI_INVENTORY_TOGGLE>"))
end

function SetMultilineWidth(p)
	v7 = true
	mMovie:__wf_atom_2dedec1a("Panel.Instruction", 52, true)
	local v18 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 5) / 100
	local v19 = -(p / 2) * v18
	mMovie:__wf_atom_e57658c2("Panel.Instruction", 0, v19)
	mMovie:__wf_atom_e57658c2("Panel.Instruction", 14, p)

	if v8 then
		local v20 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 41) * v18
		local v21 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 50) * v18
		mMovie:__wf_atom_e57658c2("Panel", 1, v6 - (v20 - v21))
	end
end

function SetMultilineExpandUp(p)
	v8 = p == "true"

	if not v8 then
		mMovie:__wf_atom_e57658c2("Panel", 1, v6)
		return
	end

	local v18 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 5) / 100
	local v19 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 41) * v18
	local v20 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 50) * v18
	mMovie:__wf_atom_e57658c2("Panel", 1, v6 - (v19 - v20))
end

local function fn4(value)
	if __wf_atom_7e8ad928(mMovie) then
		return
	end

	if __wf_atom_7e8ad928(v16) then
		v16 = mMovie:__wf_atom_5e6e15c8("Panel.Bg", 1)
	end

	if __wf_atom_7e8ad928(v17) then
		v17 = mMovie:__wf_atom_5e6e15c8("Panel.LiteBg", 1)
	end

	local v18 = value == nil and "" or string.gsub(value, "<COMMA>", ",")

	if not _T.InWorldTextDisableAlphaInterp then
		__wf_atom_ec43d06e(mMovie, "Panel", 8, { 12 }, { 100 }, 0.5)
	end

	local v19 = string.gsub(v18, "%[", "")
	local v20 = string.gsub(v19, "%]", "")
	v3 = v20

	if string.find(v20, "Tutorial") and string.find(v20, "_KBM") then
		local isPlayingWithController = Engine.IsPlayingWithController()

		if Engine.__wf_atom_84bb79c2() or Engine.__wf_atom_e43a530e() or Engine.__wf_atom_b290ec01() then
			if isPlayingWithController then
				v20 = string.gsub(v20, "_KBM", "_Windows")
			end
		elseif isPlayingWithController then
			v20 = string.gsub(v20, "_KBM", "_XBone")
		end
	end

	if Engine.IsPlayingWithController() then
		v20 = fn3(v20)
	end

	v2 = mMovie:__wf_atom_8e9ac384(v20, true)
	local v21 = v2

	if v5 then
		v21 = "<p><font color=\"#444444\">" .. v21 .. "</font></p>"
	end

	mMovie:__wf_atom_50d60589("Panel.Instruction", 36, v21)
	local v22 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 5) / 100
	local v23 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 40) * v22 + v14
	local v24 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 41) * v22 + v15
	mMovie:__wf_atom_e57658c2("Panel.Bg", 14, v23)
	mMovie:__wf_atom_e57658c2("Panel.LiteBg", 14, v23)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 15, v24)
	mMovie:__wf_atom_e57658c2("Panel.LiteBg", 15, v24)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 1, v16 - (v15 - 12) * 0.5)
	mMovie:__wf_atom_e57658c2("Panel.LiteBg", 1, v17 - (v15 - 12) * 0.5)

	if v7 and v8 then
		local v25 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 50) * v22
		mMovie:__wf_atom_e57658c2("Panel", 1, v6 - (v24 - 12 - v25))
	end

	if not v then
		mMovie:__wf_atom_e57658c2(
			"ControllerHolder",
			1,
			mMovie:__wf_atom_5e6e15c8("ControllerHolder", 1) - mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 41) * 2
		)
		v = true
	end

	return true
end

function SetMessage(p)
	return fn4(p)
end

function SetFont(p)
	mMovie:__wf_atom_50d60589("Panel.Instruction", 49, p)
end

function SetTextColor(p)
	mMovie:__wf_atom_e57658c2("Panel.Instruction", 44, (tonumber(p)))
end

function SetTextAlpha(p)
	mMovie:__wf_atom_e57658c2("Panel.Instruction", 12, (tonumber(p)))
end

function SetTextAlign(p)
	mMovie:__wf_atom_50d60589("Panel.Instruction", 45, p)
end

function SetVertexColors(p, p2)
	__wf_atom_86cbd68d(
		mMovie,
		"Panel.Instruction.setVertexColors",
		tonumber(p),
		tonumber(p),
		tonumber(p2),
		(tonumber(p2))
	)
end

function SetUserText()
	mMovie:__wf_atom_50d60589("Panel.Instruction", 49, "Arial Unicode MS")
	mMovie:__wf_atom_3eb83f41(scalingTextMaterial)
end

function SetFancyText()
	mMovie:__wf_atom_3eb83f41(fancyTextMaterial)
end

function SetOutOfService(p)
	v5 = p == "true"
	__wf_atom_ec43d06e(mMovie, "Panel", 8, { 12 }, { module.Ternary(v5, 90, 100) }, 0.5)
	local v18 = v2

	if v5 then
		v18 = "<p><font color=\"#444444\">" .. v18 .. "</font></p>"
	end

	mMovie:__wf_atom_50d60589("Panel.Instruction", 36, v18)
end

function SetHorizontalPadding(p)
	v14 = tonumber(p)
end

function SetVerticalalPadding(p)
	v15 = tonumber(p)
end

function Initialize()
	mMovie:__wf_atom_e57658c2("Panel", 12, 0)
	mMovie:__wf_atom_50d60589("NotoLoader", 36, "")
	mMovie:__wf_atom_2dedec1a("Panel.Instruction", 52, false)

	if Engine.__wf_atom_578fc9dd() then
		mMovie:__wf_atom_50d60589("Panel.Instruction", 49, "Arial Unicode MS")
		mMovie:__wf_atom_e57658c2("Panel.Instruction", 50, 18)
		local __wf_atom_5e6e15c8 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 14)
		local v18 = __wf_atom_5e6e15c8 * 1.5
		local __wf_atom_5e6e15c8_2 = mMovie:__wf_atom_5e6e15c8("Panel.Instruction", 0)
		mMovie:__wf_atom_e57658c2("Panel.Instruction", 5, 150)
		mMovie:__wf_atom_e57658c2("Panel.Instruction", 6, 150)
		mMovie:__wf_atom_e57658c2("Panel.Instruction", 0, __wf_atom_5e6e15c8_2 - (v18 - __wf_atom_5e6e15c8) * 0.8)
		mMovie:__wf_atom_e57658c2("Panel.Instruction", 1, -20)
	end

	v6 = mMovie:__wf_atom_5e6e15c8("Panel", 1)
	fn(false)
end

function SetHiddenInBackgroundRegion(p)
	v10 = p or p == "true"
end

function SetComponentId(p)
	v11 = p
end

local function fn5()
	if
		v11 == ""
		or __wf_atom_7e8ad928(_T.DojoMgr)
		or __wf_atom_7e8ad928(gRegion)
		or __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f())
	then
		return true
	end

	local __wf_atom_e800787c = gRegion:__wf_atom_c4f78a8f():__wf_atom_e800787c()

	if __wf_atom_e800787c == v12 then
		return v13
	end

	v12 = __wf_atom_e800787c
	v13 = false
	local v18 = _T.DojoMgr.mIdToZoneMap[v11]

	for i = 1, #v18 do
		if __wf_atom_e800787c ~= v18[i] then
			continue
		end

		v13 = true
		return true
	end

	return true
end

function Update()
	if v10 then
		local v18 = __wf_atom_7e8ad928(__wf_atom_392793db) and fn5()

		if v4 ~= v18 then
			v4 = v18
			mMovie:SetVisible(v18)
		end
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Close()
	__wf_atom_ec43d06e(mMovie, "Panel", 8, { 12 }, { 0 }, 0.5, 0, function()
		mMovie:Close()
	end)
end

function IconCacheFlushed()
	fn4(v3)
end

function OnGamepadTransition(_)
	fn4(v3)
end

function DisplayInWorldText(p)
	if p == "true" then
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 100 }, 0.5)
	else
		__wf_atom_ec43d06e(mMovie, "_root", 8, { 12 }, { 0 }, 0.5)
	end
end

function SetBGAlpha(p)
	mMovie:__wf_atom_e57658c2("Panel.Bg", 12, (tonumber(p)))
end