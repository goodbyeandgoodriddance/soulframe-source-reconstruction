local module = require("EE.Interface.Utilities")
local module2 = require("SF.Interface.Libs.UIUtilities")
local module3 = require("EE.Interface.AnchorMgr")
local module4 = require("SF.Interface.SFUtilities")
local module5 = require("SF.Interface.Libs.MoteUtil")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local runeMaterial2 = nil
local v7 = nil
local v8 = false
local asyncLoader = module2.CreateAsyncLoader()

local function fn()
	mMovie:__wf_atom_c90af43a("CenterIcon.Backer.Fill", moteBackerTexture)
	local v9 = mMovie:__wf_atom_5e6e15c8("Title.Title", 40) + 60
	mMovie:__wf_atom_e57658c2("Title.Backer", 14, v9)
	mMovie:__wf_atom_e57658c2("Title.Subtext", 11, 12363651)
	mMovie:__wf_atom_e57658c2("Title.Backer", 12, 0)
	mMovie:__wf_atom_e57658c2("CenterIcon.Icon", 12, 95)
	mMovie:__wf_atom_e57658c2("CenterIcon.Backer", 12, 85)
	mMovie:__wf_atom_e57658c2("CenterIcon.Border", 12, 85)
	mMovie:__wf_atom_2dedec1a("CenterIcon.Glow.Shadow", 13, false)
	mMovie:__wf_atom_2dedec1a("CenterIcon.Glow.Mist", 13, false)
end

local function fn2()
	mMovie:__wf_atom_50d60589("Title.Title", 36, v3)
	mMovie:__wf_atom_2dedec1a("Title.Subtext", 13, false)
	mMovie:__wf_atom_c90af43a("CenterIcon.Icon", v6)
	mMovie:OverrideMaterial("CenterIcon.Icon", runeMaterial2)
	mMovie:__wf_atom_c90af43a("CenterIcon.Border", v5)
	mMovie:__wf_atom_50d60589("Title.MoteNumber", 36, v4)
end

local function fn3()
	v = module3.Create(mMovie)
	v:Register(mMovie, "Dialog", { v.ANCHOR_V_TOP, v.ANCHOR_H_CENTRE })
	local module6 = require("Lotus.Interface.Libs.TimerMgr")
	v2 = module6.CreateTimerMgr()
	mMovie:__wf_atom_2dedec1a("Title.AcquiredText", 13, false)
end

function Initialize()
	if _T.DisableMotePickup then
		mMovie:Close()
	else
		fn3()
	end
end

local function fn4(p, value, _, p2)
	local v9 = (value or 0.5) / 2
	local ternary = module.Ternary(p, 0.05, 0)
	local v10 = { (module.Ternary(p, 88, 0)) }
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 12 }, v10, v9, ternary, p2)
end

function onViewportSizeChanged(p, p2)
	if v ~= nil then
		v:Update(p, p2)
	end
end

local function fn5() -- 1 equivalent call inferred from this helper
	mMovie:Close()
end

function TransitionOut()
	if not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
		local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			__wf_atom_330f77f5:__wf_atom_99407548(false)
		end
	end

	module.PlaySound(_G.UISound_WindowClose)
	fn4(false, 2, nil, fn5)
end

local function fn6()
	v2:AddTimer(fadeoutTimer, TransitionOut)
end

function TransitionIn()
	if not __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) then
		local __wf_atom_330f77f5 = gRegion:__wf_atom_eab484a7():__wf_atom_330f77f5(false)

		if not __wf_atom_7e8ad928(__wf_atom_330f77f5) then
			__wf_atom_330f77f5:__wf_atom_99407548(true)
		end
	end

	mMovie:__wf_atom_e57658c2("_root", 12, 0)
	fn4(true, 0.5, nil)
	v2:AddTimer(0.5, fn6)
end

local function fn7(__wf_atom_c05c3cf5) -- 1 equivalent call inferred from this helper
	if __wf_atom_c05c3cf5 == 9 then
		return cardBackerTextures[3]
	elseif __wf_atom_c05c3cf5 == 10 then
		return cardBackerTextures[5]
	elseif __wf_atom_c05c3cf5 == 11 then
		return cardBackerTextures[4]
	end

	return cardBackerTextures[2]
end

function SetMoteDisplay(p, _, p2)
	mMovie:__wf_atom_c884ca43(true)
	local v9 = Resource(p)

	if v9 == nil then
		return
	end

	if p2 then
		v9:__wf_atom_eaa00d7a(p2)
	end

	local convertColorNumberToHex = module.ConvertColorNumberToHex(_G.UIColor_Yellow)
	v3 = mMovie:__wf_atom_8e9ac384(v9:__wf_atom_014a76a2():c_str(), false)
	v3 = "<p><font color=\"" .. convertColorNumberToHex .. "\">" .. v3 .. "</font></p>"
	v4 = v9:__wf_atom_2941433a()
	local __wf_atom_f298d802 = v9:__wf_atom_f298d802()
	local __wf_atom_c05c3cf5 = v9:__wf_atom_c05c3cf5(__wf_atom_f298d802)
	local __wf_atom_c6a5f697 = v9:__wf_atom_c6a5f697(__wf_atom_f298d802)
	mMovie:__wf_atom_8e9ac384(module4.GetRankFlowerIcons(__wf_atom_c6a5f697), true)
	v9:__wf_atom_f324d993(__wf_atom_f298d802)
	local __wf_atom_0f53c1b9 = v9:__wf_atom_0f53c1b9()
	v9:__wf_atom_919e7078()
	v9:__wf_atom_68d47410()
	v8 = v9:IsA((Type("/SF/Upgrades/SFMotesBaseActiveUpgrade")))
	local isA = v9:IsA(WeakResource("/SF/Upgrades/Totems/Vadagar/VadagarTotemOne"))

	if v8 then
		runeMaterial2 = runeMaterial
		v7 = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/ActiveMoteAcquired", true)
		mMovie:__wf_atom_c90af43a("Backer", cardBackerTextures[1])
		mMovie:__wf_atom_2dedec1a("Card.Rune", 13, true)
		mMovie:__wf_atom_2dedec1a("Card.Totem", 13, false)
	else
		runeMaterial2 = animalMaterial
		v7 = mMovie:__wf_atom_8e9ac384("/SF/Language/Motes/PassiveMoteAcquired", true)

		if isA then
			mMovie:__wf_atom_c90af43a("Backer", cardBackerTextures[6])
			mMovie:__wf_atom_e57658c2("CenterIcon.Icon", 11, 15327477)
		else
			local mMovie2 = mMovie
			mMovie2:__wf_atom_c90af43a("Backer", fn7(__wf_atom_c05c3cf5)) -- inferred equivalent call
			mMovie:__wf_atom_e57658c2("CenterIcon.Icon", 11, module5.CalcTotemColor(__wf_atom_c05c3cf5))
		end

		mMovie:__wf_atom_2dedec1a("Card.Rune", 13, false)
		mMovie:__wf_atom_2dedec1a("Card.Totem", 13, true)
	end

	if __wf_atom_0f53c1b9 ~= nil then
		v6 = __wf_atom_0f53c1b9[2]

		if isA then
			v5 = _G.UITexture_MoteFrameTexturesPassive[8]
		else
			v5 = _G.UITexture_MoteFrameTexturesPassive[1]
		end
	end

	asyncLoader:LoadResource("moteArtifactUpgrade", v9, function(object)
		asyncLoader:LoadResource("moteSkillTree", object:__wf_atom_7ec2d06a(""), function(p3)
			local v10 = Resource(p3)

			if v10:IsA(__wf_atom_cdd2dd31) then
				local __wf_atom_ab9ebfce = v10:__wf_atom_ab9ebfce()
				local ternary = module.Ternary(
					__wf_atom_ab9ebfce ~= EMPTY_SYMBOL,
					__wf_atom_ab9ebfce:c_str(),
					"<WEAPON_CATEGORY_ICON_UNIVERSAL>"
				)
				mMovie:__wf_atom_50d60589("Title.GripIcon", 36, mMovie:__wf_atom_8e9ac384(ternary, true))
			end
		end)
	end)
	fn2()
	fn()
	TransitionIn()
end

function Update()
	local v9 = __wf_atom_fa1258d0()
	mMovie:__wf_atom_88d9cd84(v9)

	if not __wf_atom_7e8ad928(v2) then
		v2:Update(v9)
	end

	asyncLoader:Update()
end

function ForceClose()
	fn5() -- inferred equivalent call
end

function OpenFileFlashMovie(_, _)
	local v9 = Type("/SF/Upgrades/Motes/Daggers/Hare/HareMotePassive")
	SetMoteDisplay(v9)
end