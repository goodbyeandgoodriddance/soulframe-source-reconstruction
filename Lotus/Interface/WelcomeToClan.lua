local module = require("EE.Interface.Utilities")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("Lotus.Interface.UIStyleUtilities")
local v = nil
local v2 = nil
local v3 = false
local flag = false
local v4 = nil
local v5 = {}

local function fn()
	if flag then
		return
	end

	flag = true
	module.PlaySound(_G.UISound_Close)
	__wf_atom_ec43d06e(mMovie, "_root", 2, { 4, 12 }, { -5000, 0 }, 0.25, 0, function()
		v3 = true
	end)
end

local function fn2()
	local v6 = {}
	table.insert(v6, {
		Label = "/Lotus/Language/Menu/Badlands_Continue",
		CallBack = fn,
		CallOut = "MENU_CANCEL"
	})
	_T.SetButtons(mMovie, v6, getfenv(1))
end

function OnEmblemReady(p, p2)
	local uiTexture_DefaultClan = Resource(p2)

	if not p or uiTexture_DefaultClan:__wf_atom_5583ebb9() then
		uiTexture_DefaultClan = _G.UITexture_DefaultClan
	end

	mMovie:__wf_atom_c90af43a("ClanInfo.ClanIcon.Icon", uiTexture_DefaultClan)
end

local function fn3()
	flag = true
	local __wf_atom_5ff594a3 = v4:__wf_atom_5ff594a3()
	local v6

	if __wf_atom_5ff594a3 == "" then
		v6 = false
	else
		v6 = not v4:__wf_atom_100362b3()
	end

	if not v6 then
		v3 = true
		return
	end

	local __wf_atom_84083b39 = v4:__wf_atom_84083b39()
	local __wf_atom_7d674792 = v4:__wf_atom_7d674792()
	local __wf_atom_c7ded697 = v4:__wf_atom_c7ded697()

	if module.IsUGCRestricted() then
		__wf_atom_84083b39 = mMovie:__wf_atom_8e9ac384("/Lotus/Language/Menu/Chat_ClanTitle", false)
	end

	local v7 = string.upper(mMovie:__wf_atom_8e9ac384("/Lotus/Language/Clan/Clan_ClassLower", false, {
		CLASS = __wf_atom_c7ded697
	})) .. " " .. string.upper(mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Clan/Tier" .. __wf_atom_7d674792 .. "Name",
		true
	))
	mMovie:__wf_atom_c90af43a("ClanInfo.ClanIcon.Icon", _G.UITexture_DefaultClan)

	if not module.IsUGCRestricted() and v4:__wf_atom_620befcd() then
		local __wf_atom_0b80c61f = __wf_atom_c67f9605:__wf_atom_0b80c61f(__wf_atom_5ff594a3)
		gGameRules:RequestResource(__wf_atom_0b80c61f, "OnEmblemReady")
	end

	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.BgLines", 11, v5.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.Fill", 11, v5.Background1)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.LinesFill", 11, v5.FloatingContent)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.BgBottom", 11, v5.Background1)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.LinesBottom", 11, v5.FloatingContent)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.Fill", 12, 75)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.BgBottom", 12, 75)
	mMovie:__wf_atom_e57658c2("ClanInfo.Header", 44, v5.FloatingContent)
	mMovie:__wf_atom_e57658c2("ClanInfo.Name", 44, v5.Content)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClassAndTier", 44, v5.FloatingContent)
	mMovie:__wf_atom_e57658c2("ClanInfo.Info", 44, v5.FloatingContent)
	mMovie:__wf_atom_e57658c2("ClanInfo.LinesLeft", 11, v5.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("ClanInfo.LinesRight", 11, v5.FloatingContentHighlight)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Icon", 1, 220)
	mMovie:__wf_atom_e57658c2("ClanInfo.Header", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.Emblem", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.Name", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClassAndTier", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.Info", 12, 0)
	mMovie:__wf_atom_7d7314f1("ClanInfo.Header.text", "/Lotus/Language/Menu/WelcomeToClanHeader")
	mMovie:__wf_atom_2dedec1a("ClanInfo.Name", 54, true)
	mMovie:__wf_atom_50d60589("ClanInfo.Name", 36, __wf_atom_84083b39)
	mMovie:__wf_atom_50d60589("ClanInfo.ClassAndTier", 36, v7)
	local v8 = "<font color=\"" .. v5.FloatingContentHighlightHex .. "\">"
	local v9 = "<p><font color=\"" .. v5.FloatingContentHex .. "\">" .. mMovie:__wf_atom_8e9ac384(
		"/Lotus/Language/Menu/WelcomeToClan",
		false,
		{ OPEN_COLOR = v8, CLOSE_COLOR = "</font>" }
	) .. "</p>"
	mMovie:__wf_atom_50d60589("ClanInfo.Info", 36, v9)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon", 1, -460)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.Fill", 15, 260)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.LinesFill", 15, 260)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.BgBottom", 1, 260)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Banner.LinesBottom", 1, 260)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Icon", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Icon", 4, -10000)
	mMovie:__wf_atom_e57658c2("ClanInfo.ClanIcon.Highlight", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.LinesLeft", 12, 0)
	mMovie:__wf_atom_e57658c2("ClanInfo.LinesRight", 12, 0)
	module.PlaySound(_G.UISound_Open)
	v:AddTimer(0.35, function()
		__wf_atom_ec43d06e(mMovie, "ClanInfo.LinesLeft", 2, { 12 }, { 100 }, 0.2)
		__wf_atom_ec43d06e(mMovie, "ClanInfo.LinesRight", 2, { 12 }, { 100 }, 0.2, 0, function()
			__wf_atom_ec43d06e(mMovie, "ClanInfo.ClanIcon", 2, { 1 }, { 0 }, 0.2)
			__wf_atom_ec43d06e(mMovie, "ClanInfo.ClanIcon.Banner", 2, { 6 }, { 110 }, 0.15, 0.15, function()
				__wf_atom_ec43d06e(mMovie, "ClanInfo.ClanIcon.Banner", 1, { 6 }, { 100 }, 0.15, 0, function()
					local particles = module.CreateParticles(mMovie, "ClanInfo.ClanIcon.Icon", winnerFx, 0, 0)
					module2.ApplyParticleThemeColors(particles)
					__wf_atom_ec43d06e(mMovie, "ClanInfo.ClanIcon.Highlight", 2, { 12 }, { 60 }, 0.2, 0.1)
					__wf_atom_ec43d06e(mMovie, "ClanInfo.ClanIcon.Icon", 2, { 12, 4 }, { 100, 0 }, 0.2, 0, function()
						__wf_atom_ec43d06e(mMovie, "ClanInfo.Header", 2, { 12 }, { 100 }, 0.5, 0.075)
						__wf_atom_ec43d06e(mMovie, "ClanInfo.Name", 2, { 12 }, { 100 }, 0.5, 0.15)
						__wf_atom_ec43d06e(mMovie, "ClanInfo.ClassAndTier", 2, { 12 }, { 100 }, 0.5, 0.225)
						__wf_atom_ec43d06e(mMovie, "ClanInfo.Info", 2, { 12 }, { 100 }, 0.5, 0.3, function()
							flag = false
						end)
					end)
				end)
			end)
		end)
	end)
end

function Initialize()
	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	v4 = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(v4) then
		return
	end

	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:SetVisible(false)
	end

	local module4 = require("Lotus.Interface.Libs.TimerMgr")
	v = module4.CreateTimerMgr()
	v5.FloatingContent = module3.GetColor(9, true)
	v5.FloatingContentHex = module.ConvertColorNumberToHex(v5.FloatingContent)
	v5.FloatingContentHighlight = module3.GetColor(10, true)
	v5.FloatingContentHighlightHex = module.ConvertColorNumberToHex(v5.FloatingContentHighlight)
	v5.Content = module3.GetColor(6, true)
	v5.Background1 = module3.GetColor(2, true)
	local module5 = require("EE.Interface.AnchorMgr")
	v2 = module5.Create(mMovie)
	v2:Register(mMovie, "ClanInfo", { v2.ANCHOR_V_TOP, v2.ANCHOR_H_CENTRE })
	fn3()
	fn2()
end

function Update()
	if not __wf_atom_7e8ad928(v) then
		v:Update(__wf_atom_fa1258d0())
	end

	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())

	if __wf_atom_7e8ad928(v4) or v3 then
		v3 = false
		mMovie:Close()
	end
end

function Shutdown()
	local __wf_atom_2ad5cd23 = mMovie:__wf_atom_2ad5cd23()

	if not __wf_atom_7e8ad928(__wf_atom_2ad5cd23) then
		__wf_atom_2ad5cd23:SetVisible(true)
	end
end

function onKeyUp_MENU_CANCEL()
	if not flag then
		fn()
	end
end

function onKeyUp_MENU_SELECT()
	if not flag then
		fn()
	end
end

function IsInputBlocked()
	return flag
end

function onViewportSizeChanged()
	if not __wf_atom_7e8ad928(v2) then
		v2:Update(mMovie:__wf_atom_d5a50cb5(), mMovie:__wf_atom_c4f6543f())
	end
end

function SupportsThemes()
	return true
end